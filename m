Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0285CC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160B58488D;
	Sun,  5 Jul 2026 12:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YIXU35JL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F7B84867; Sun,  5 Jul 2026 12:42:52 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006B384881
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f69eeb6cso1269032a34.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783248169; x=1783852969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/31ZV0LKCTQtvwNAINlIjcEEQ9m0AF7yIX/0fiy/ftM=;
 b=YIXU35JLnKXU3lmopZQKiR6RiUziS8G4zKIDQnj0tkYCsDKnTQ5LZQLSdl6ctI98+l
 zDyr6lQedFZrY6mTO9xmZNheHE1rtKfHxzM7N1mIlcRBjXQOf5ZOk1zGOreC1JqlwW9R
 kcTglVZ172PPWHdClVZYyJVS+oBtmFBUD0qR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783248169; x=1783852969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/31ZV0LKCTQtvwNAINlIjcEEQ9m0AF7yIX/0fiy/ftM=;
 b=lqAYfwXvnP6yjUriKWCZUkTETZmUAfIzTHLQMVq3NUPw3Gie6CZT0xu8UMxnNl2yp9
 Xz1OxgkOWdmZxQIJHq2hPIPJE1mOrdMMJUN34wOyFJbhv4plOhe1qqJ+q3JnX2Vxq0VP
 8crpMTq7yZpuvRV52p6CTkrCjGLlF7VDq4idsdTpH5rMHoQexOL/rc9B7TAX/XvwaQN5
 mM4sAAd4reajg+UaTLyK7lWuNQ8EZCxdD63Xzbhep6l6oBHZMWJjuOxipOgq0icAlZ2v
 /5YekXWxyso3XLDFhsEplg08OWCc+ko2CarApW63V6+Y+hfqg2kicdpYhpFbv7U9Dh5h
 1kDg==
X-Gm-Message-State: AOJu0YwURdxzuJSGzpfuUxA3WYIFUM9OJROJ0CaWI1IAxa00oEye50GN
 ydrIMvWAleaOejT/m0jK2Y42h254Yx7mvLbXDY1kSy/Viqrcnk4vQXWGmDDXTr51kKwq+Ul4UzT
 lNoKWbg==
X-Gm-Gg: AfdE7cna5hs52iydhAkiNXrh2t+88pq/3K5ntfh22CkbIbF76GYjLHznmNa1lx9IJYj
 Oe6ca0iZTkED0MwXzwrQuk34FGxHIBNU3olu1Pe9g45kjErDwh815vxsfR/YcQKXPeVKofsUfPp
 uLK8M7xcvj3gViHGWn+Pw9lPryvSBsVsnKcaelZzPclDJgqVIONPUJviBx2vX3T6YILhoLsMuPA
 75SdvD4z3EqwIIZlAf6DT47QwEjUBwiMy1SLrw/Dm9udIEcxdNKysZArGtLX9qpgiDN1XoKFehy
 kh5EGq4HHYgALgwtqwyDIxkJgjvvDwptkfXZyaqd9R7ZOaOQVGYXCPnZzSTddVpq04YgUqoTASS
 BtBn4bff105GDrgAqg4p7pQwh1rT16iEAwXIBYqmw/VSCgObHPPAKDoJFnVKBHWqdkxaXrrKYU+
 X5p5uvYv8=
X-Received: by 2002:a05:6830:6d4c:b0:7e6:d0ad:5254 with SMTP id
 46e09a7af769-7eb7fdce4aamr4447300a34.8.1783248168726; 
 Sun, 05 Jul 2026 03:42:48 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm9136961a34.3.2026.07.05.03.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 03:42:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/5] edison: Widen the DFU auto-probe window for flashing
 U-Boot
Date: Sun,  5 Jul 2026 04:42:13 -0600
Message-ID: <20260705104231.3846672-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705104231.3846672-1-sjg@chromium.org>
References: <20260705104231.3846672-1-sjg@chromium.org>
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

