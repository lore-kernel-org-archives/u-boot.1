Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE5BCD8C90
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2112D846B1;
	Mon,  8 Jun 2026 01:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mY3ivy4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5381184154; Mon,  8 Jun 2026 01:05:39 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33FD83314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43cce34c881so2846062fac.2
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873534; x=1781478334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IsghZ/PurGu5uw4ymryZHOXuAcHPavi7dsbtu1lzXI=;
 b=mY3ivy4xDMMi55z3mgUj9jURE+zA/fVOY9fDiUjBC6Q5qsEJ5SKeyiampwI3J2umeZ
 imLt0rADomlDHfWMcQb2kvw0U0l2zhc1ulPJTiFa7lQEhm+KyOy60KhoxBDfA3y/Dozk
 ZPmXBekjke4eZa7i5tePAvkdSVBgtiovGPnSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873534; x=1781478334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8IsghZ/PurGu5uw4ymryZHOXuAcHPavi7dsbtu1lzXI=;
 b=Dshrnj3OY9z9Nfppyl00uvspKg4YASZP0547ELn0jVefwwx3ivdIuw4IwLVpItD+YD
 cZ8r41mVflw8YBpUUjKo7HrRcmHPJv3VapzLGXFAPbWC5v9llcUmJnuiC9alh8OyEmDs
 cTOwnuv0JDffsBgwZzzQDy9xPKwUkKf8SvT6bPRXwUSUK/yIA4N3QrAKoJDAaJRI/Is2
 WwD40a0rWiLBdW5uhMAAY5ednz7OM7QwKGUT8EyjdY9dMKZWvrbIXbRAJ4OmGw/af7sY
 nVStlBS7uHcbgSJC0KD1RiiZe0binNNzRglphZ60hMq0yPwa2jYkdiuT6HaKb2HlvuGM
 +svw==
X-Gm-Message-State: AOJu0Yx9/vLYuVkPQvsHUQxc5/uix2cjc6b4ncr0HrBOy6WV5ViLOOOY
 +0+qHgC/5Bw0jW65W12m3IB0F4JoQ1FTrsK9Rx8p9rNpkyFe82PNaUZPdqYSdBlmAKLcd9rPJW/
 ys5uxVA==
X-Gm-Gg: Acq92OHXJWTz/F4tUWhaXM6OhNyU+LKZP98L2OZZRHoha/KTlzoWEr0GbaeWEqS3Efj
 sInn/BIGrRLz0O3Ijw7JoQBwDaakhGYoC075P+6waCL7dLB5vKcXGcpgBs+z3YIsQmLqMpPEdmc
 cP2Q+mV4mL1RHdjWOiO8LBpYRcPLHu6i+C3dxP/LFWW7mx2qgJwKSozi4crkqy8CbQQU4kjaids
 eygwu6airAUo4w4GegTmb+R3NCtLssf8vfo5nUC+pTIndukyj0p+WtWwkDiUqTX3bAy76QEVty4
 OM8L/d02QdZzGIkTkT4FdAIvBKEKF2wxcXmJLUa3asKrvJ3Gg/2PK/Z7HiaeY+yTvgksVS16BA3
 SPgjUXrDk+/LEtxASuf5z5tXQCHugXY6u+kRHHoSre+FibX4lb1vcgKD4y2jsd8oT28IUa71sZ6
 /SKhZvufL+TWh+v8KXU6X57QLnRZUH
X-Received: by 2002:a05:6871:521e:b0:43d:d0c:ac30 with SMTP id
 586e51a60fabf-4413ceed1c6mr7554720fac.0.1780873534568; 
 Sun, 07 Jun 2026 16:05:34 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] edison: Widen the DFU auto-probe window for flashing
 U-Boot
Date: Sun,  7 Jun 2026 17:05:11 -0600
Message-ID: <20260607230519.3022520-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
References: <20260607230519.3022520-1-sjg@chromium.org>
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
---

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

