Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82364CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192E0848BA;
	Tue, 16 Jun 2026 16:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O/Uc9/OE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C8B848E2; Tue, 16 Jun 2026 16:25:05 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB520848BF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso2929689fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781619901; x=1782224701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/31ZV0LKCTQtvwNAINlIjcEEQ9m0AF7yIX/0fiy/ftM=;
 b=O/Uc9/OEABGHAskpXZkiXg7/UwrCo3e2fiMHx9w9aRZUtu3eqlvPalYSzxn2tz2Hrl
 1YWqVruvMV4B3Vflf6CVDV5kydvGanjUnPOt4bCHp/uWWI6gU7kTGLeAVyULu5zpe1zg
 +ghJDQnnuDliNVdYJG6sKTpNi62Rq40ljI3F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619901; x=1782224701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/31ZV0LKCTQtvwNAINlIjcEEQ9m0AF7yIX/0fiy/ftM=;
 b=NQuzACsaxNo37KBT9YcQAimVtPqD/IsGJASNRRk3K1pNxATUzRq3CgTQchO4z3Z4oK
 B2xkCYWWwTR1Ged2h7GjfUeLZbqhgByM79LoEXFzcE0FfT4HZ0jrQ4GPZwVtGjI5gWpQ
 kKUyCw4XeDLCuTiTZJ+Sp1AsMaIBGVhyRzO84wvr+0riMXKPWQlnTd51oeguxDUA4BtL
 2lgZ/P24cKC49jbu1TEQeNs2SVCq7+NqppZ0s4pdL/mIvqRnHq4/ZawXEa85sQfKkTG9
 A3wvrkxdaxBeYOm+DoWtqyS46vWiBixBVDzNpDoQYQ+MFUHZapPnx+gfmH4Hy67t9V7l
 Fzsw==
X-Gm-Message-State: AOJu0YyGf3nQCl1xA5ABRduzqw0/Z44BCE/gsl1Wz1ghPNMCy1Tv+J2s
 WgwK8KKMXHUN+oU5EAP0CuUbzL3AANJPSIHKW6j+yFZ6SKrsQX+70fhF9Wc36+g9CmcsBqAWaTn
 OeYs=
X-Gm-Gg: Acq92OEbuRKmaU0ON3/dj9YfPsYEIeZ9BhIej54ilHICcqGOO0ZfRLKVt1t46yiWFF2
 +r9tClYa+wBvu9JOM4ULVf25+5pWkYxXMUFlf9nkWtyJR3Y4RQERtoa+o7uxnkt6YVC5h+C3vI3
 ACzKEqUIIYSdqoV6TiGARi9MMEFWIlOeh3xw4iTV/Yx/meSqlpJa58BN2mXRzWeDodYuyQRdYKT
 MVkKZydOdIGAtF3h7F4Ls6YtcU7bQlvnyhIzjqRld/MRgYe3I2dwcRHWygAB775xYgGlx8PmDjf
 ee1ME0Dz9xE7uVsPcabojfVKL8cyPN9X9zkz+Jgh/lcJ77jp8DiEhnzjfZq/BDiYMPwZgMj9F6b
 MOh8JyfAknUruqJ2Ufi2yAmS4p/Rr5tzvp5FUQDoAPXcX/nnTq6m2bhMgqy+xxPgbpeQ+iWmBLn
 hcZyYycUEu5On5VxjTsA==
X-Received: by 2002:a05:6870:7087:b0:43d:7b24:96 with SMTP id
 586e51a60fabf-4430ae544afmr3014665fac.0.1781619900826; 
 Tue, 16 Jun 2026 07:25:00 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm2215230fac.16.2026.06.16.07.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:25:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] edison: Widen the DFU auto-probe window for flashing
 U-Boot
Date: Tue, 16 Jun 2026 08:24:17 -0600
Message-ID: <20260616142444.48193-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142444.48193-1-sjg@chromium.org>
References: <20260616142444.48193-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On boot the Edison environment opens a brief DFU window (do_probe_dfu) so
a host can reflash U-Boot over USB before the board continues booting.
The length of that window is governed by dfu_to_sec, which is 3 seconds.

Three seconds is not enough, but not because the transfer is slow. The
window is a hard deadline measured from when do_probe_dfu starts: the dfu
command records its start time once and never resets it on activity,
despite the 'inactivity timeout' wording in the command's help. Sending
U-Boot through the lab uses most of the window before the transfer even
begins -- the gadget must enumerate, labgrid must detect the resource,
sync the image and launch dfu-util over SSH, about 3 seconds of setup.
The 700KB transfer itself takes only about 1.3 seconds (including the
eMMC write), so the real window usage is roughly 4.4 seconds; a 3-second
window expires during the setup, before the write can finish.

Raise dfu_to_sec to 8 to cover the setup and transfer with margin. The
board waits out this timeout on every boot where no host connects, so
there is no benefit in making it longer than necessary.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

(no changes since v1)

 board/intel/edison/edison-environment.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/intel/edison/edison-environment.txt b/board/intel/edison/edison-environment.txt
index afe00920461..caa5d773740 100644
--- a/board/intel/edison/edison-environment.txt
+++ b/board/intel/edison/edison-environment.txt
@@ -43,6 +43,6 @@ bootdelay=1
 do_flash_os_done=1
 bootargs_target=multi-user
 bootargs_ethconfig=cdc
-dfu_to_sec=3
+dfu_to_sec=8
 do_probe_dfu=run do_dfu_alt_info_mmc ; dfu 0 mmc 0 $dfu_to_sec
 boot_target_cmd=run do_flash_os;run do_probe_dfu;run do_compute_target;run mmc-bootargs;run load_kernel;zboot ${loadaddr}
-- 
2.43.0

