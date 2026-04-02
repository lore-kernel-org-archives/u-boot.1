Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E673DD6AAE6
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBEB84118;
	Thu,  2 Apr 2026 17:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTnv2Fky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF01F840ED; Thu,  2 Apr 2026 17:29:03 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F3C80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d0288d24f6so148253485a.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143736; x=1775748536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=kTnv2Fkyxfkb7sEIgD2FwkYMExKoWurJEL3Mt847iRMn3awJEQV5Qfm1Y/V+O2bP0W
 9C1U5Da15NBc/HD7oVeX4zdaldEq5f8tjcwTJoUosOpIXhfW2mqCETxhDHyGwcjj211j
 FV21h0vgoTe69o4OX5jkJ2fIMrwOb69yOsLbDl+B/nKH5d4iMq2RNdf46IWM8RHrFgLS
 8+Lr84+HjSbmSDqJkshesqIYf+OeuZqC1waKj3MGo3DYa0oD8+8sPjAI6dtzzFfLjtos
 l9rSMmAgX0K/evX0Kh/iSkyfITK0+kYluEeBiGIAqr6/PzjczM4bEnab+tdRXDbm3r3y
 UJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143736; x=1775748536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=LrmMtntHaeB5vnN2aLm8ibuQQzzhEnuQbLK5z4nMQu3bXgbLHuq6CnCeHh9OO95hG8
 y1EaJuOr+nA5iDaLLY1vYDOFcAVG47lQkQ+56m2HTk2r+fF/k33/Mo3nuBRTWeNr/HFp
 9xSQJdKgBr9KFgWGX+0z4eHtZYQmcFzGvUubW+xskR/r9QyCbbbLSgEL+RZs2fgNyQ62
 9GCHM7KYX+MQXOYojR18usFmUNBP2wjJNDRNctfk9HkSddU0lknHlvDJCevngs3he3ml
 fkDZWex4VcqiMEqJFytqeT75B4iIdQhSPRf5c8CxfLhdL/Gk8ATpoYEJrzYUzqM9+het
 BsRA==
X-Gm-Message-State: AOJu0YyRzOJYzOHrENyUsmztL5SwA8N3qTVUmRr9KUGaHD9eDxeH6RvE
 GsUGGZEphci7JCkZgCY/IxTCvOnjkguW8iWLgr8N6cUeH6d/e85tfOZ0MJKeUtxe
X-Gm-Gg: ATEYQzxj25s5hmt8fPLKHWLQC6SbnTgKvr3hEV4CAtlryXrI7o+7oowL+pLnw4yzo4A
 J+tPCQ8e3FfchKPKjbsaJn0wgivAdZU8aRljzOGiwE1AEqTe34B2LapJ2XVorodyuqo5KeaoyNG
 XgdZR1eQEqdKQwTvffWRucniZIamso3kEV9i2a+zZuBpHN9B5uBV/wcGKFG+7YbGMh7llr6ypcK
 iAkof71oHRPSx1FhAFWlDst+ZcASF5FeTAYdh5NiTHafwYURcuLnGup3pSTJ7FTY4PjbNbPJI9H
 SSyIhpxIz973sL1jYjJb/bBcF36ay5J88SroaE0izI1VVHgKJXMydavDsfsXQfvlnbe+sECDvf9
 blfiIhkE12zi+l5Z8DOfWcZ3++L8KUOhFQP4667QUgcFR2qciEm5nSwNd1iO/pz6tFZyf/9RNEF
 GItmtP2mHytW7FDXpgTGY/jKgIppiqmMOkwQ==
X-Received: by 2002:a05:620a:19a5:b0:8cf:d81c:126a with SMTP id
 af79cd13be357-8d303ce51e5mr329983585a.36.1775143736119; 
 Thu, 02 Apr 2026 08:28:56 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:55 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 04/13] mach-sc5xx: Switch from tftp to wget
Date: Thu,  2 Apr 2026 11:28:27 -0400
Message-Id: <23ce1bd4cf2e8c2a1f8f5dbd7a31da1be2a894eb.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Switch the nfsboot and other relevant commands to use
wget instead of tftp. This also includes the addition of
the httpdstp variable for selecting the wget port.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 include/env/adi/adi_boot.env | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 3c196e40603..eb098dd2256 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -15,6 +15,7 @@
 /* Config options */
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
+httpdstp=8000
 uart_console=CONFIG_UART_CONSOLE
 #ifdef CONFIG_SC59X_64
 initrd_high=0xffffffffffffffff
@@ -27,15 +28,14 @@ adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
 ramargs=setenv bootargs ${adi_bootargs}
 
 addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off
+rootpath=/romfs
 
 /* Boot modes are selectable and should be defined in the board env before including */
 #if defined(USE_NFS)
-// rootpath is set by CONFIG_ROOTPATH
 nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfsvers=3 ${adi_bootargs}
-nfsboot=run init_ethernet;
-	tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
-	run nfsargs;
+nfsboot= run nfsargs;
 	run addip;
+	wget ${loadaddr} ${serverip}:/fitImage;
 	bootm ${loadaddr}
 #endif
 
@@ -64,8 +64,7 @@ ospiboot=run ospiargs;
 #endif
 
 #if defined(USE_RAM)
-ramboot=run init_ethernet;
-	tftp ${loadaddr} ${tfpt_dir_prefix}${imagefile};
+ramboot= wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
-- 
2.34.1

