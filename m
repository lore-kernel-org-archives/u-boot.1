Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93447D0EE12
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D18A88FCF;
	Fri, 11 Oct 2024 19:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dygRK37y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C1188DFD; Fri, 11 Oct 2024 19:09:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F6589371
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431137d12a5so19934365e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728666556; x=1729271356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zZSP+x0tcojmSJspzvX0VUooBy80Xk9zGvdj5J0cW1w=;
 b=dygRK37yLreMUFaEXv6/6qkKgxwEF25gnALiFZYEfSIrrNHAFssB0SCFSw7rDLEyv8
 Sn1eCWgz4XB2AH2+d1+653isOSSLpDX9wP6dEtZCkeyiEtL8ykAVaOxaBvzexoIhG/Up
 PYvQelaGfwItCb4qZfmHjlCKyXmw0N2VkhFZaBpsZERXjBCWH9GpB9J4jKmmBq9DumHD
 5v3k9mt3wBVsK20xHm5KklUD7cyPqKv2lw7wjn+nPxrVFNq6gNR3I88ZqYROtyHQpDSd
 t4zrrxJjvToeJoQ4zNy2D8F14yLrFEaGEBl0rotn6A6W7Idr/1y8dRhCPSIQTH5RSDC0
 fNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728666556; x=1729271356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZSP+x0tcojmSJspzvX0VUooBy80Xk9zGvdj5J0cW1w=;
 b=EekO3cfGtV09ReN8k2EDQR2teGkgvkQAUhxn6pccDWuVnNqBKsFOy1FBINechn7m8Z
 vZSi2ua/2fd3BXn5WFZie1a0SngZXKqC2Myh3vbgtBSaCV5AMcAhhoV4d2BpzClVQM99
 V2YiR8bP7UEJalaNL8E/5O8TlpVRrrckeRLVA4yFwmS4orDeAoyBlO59nWcC9yQR5+eA
 5naJdZZiHgO5tBuZWELN7idiQIWQqCCNjNM9Nau4MwmWW38bixQsmwDIcgKe+AqpSBeZ
 3EwbZhLzWZECrWTJsbuif5zfv6TiUMSK5Wwg4GotLX/nh3X5Zpxsnlf604Nuw3aoFzSX
 VKYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzqvssva3Flddw2L6Tf0vleogF4h7aazsNWS4CJL7wuaGPXsSshVVWDvr/cVRWZHwgncDT2wY=@lists.denx.de
X-Gm-Message-State: AOJu0YztL8DNmlx2rUYMEsqv4U0TwPrmmL6S76mIbfToQEgk0xJghb+n
 sB/zxV20ukXGUYBEbHrhaFiIGSjU066cnTekStEd4ogFRNKg4LyZ
X-Google-Smtp-Source: AGHT+IFho/jmIISqIRJRHjp/zM6TNSnL6K3ve0QERIVyGhn4nE/4e26Zebuiw2Ih+aaK0xSkJOUftA==
X-Received: by 2002:a05:600c:3581:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-4311decab1fmr29608505e9.11.1728666556424; 
 Fri, 11 Oct 2024 10:09:16 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd127sm4341395f8f.36.2024.10.11.10.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:09:16 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] board: rpi: Pass CMA through from firmware DT
Date: Fri, 11 Oct 2024 18:09:11 +0100
Message-ID: <20241011170914.1980541-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.47.0
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

For a lot of usecases, such as display, camera, media
the Raspberry Pi needs a lot more CMA than distros
configure as default so we should pass this parameter
through so things work as expected. Fix a spelling
mistake while we're at it.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2: Update the cma string

 board/raspberrypi/rpi/rpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9f..dd5a318d239 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -540,12 +540,15 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 	if (fdt == fw_fdt)
 		return;
 
-	/* The firmware provides a more precie model; so copy that */
+	/* The firmware provides a more precise model; so copy that */
 	copy_property(fdt, fw_fdt, "/", "model");
 
 	/* memory reserve as suggested by the firmware */
 	copy_property(fdt, fw_fdt, "/", "memreserve");
 
+	/* copy the CMA memory setting from the firmware DT to linux */
+	copy_property(fdt, fw_fdt, "/reserved-memory/linux,cma", "size");
+
 	/* Adjust dma-ranges for the SD card and PCI bus as they can depend on
 	 * the SoC revision
 	 */
-- 
2.47.0

