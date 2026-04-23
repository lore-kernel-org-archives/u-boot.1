Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035FFFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5C5844FD;
	Sat, 25 Apr 2026 22:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLYTZPTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC7C842E7; Sat, 25 Apr 2026 22:31:45 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A527283FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso7539366c88.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777149102; x=1777753902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNMsZFP1DORyw9Kkzscp45gO0mOD1crtj5fObpmEXpw=;
 b=JLYTZPTqL87MdEh5R7zblqE333xshsr7R91DCmW7wZV3YczRO2e76ia+MRQI9J6Fhr
 bRybIZfhv7BmCWVjwAHL05BDKCYrRoTSxRJ+Y2heeSc+3uJnhYO/kF4yjtYcaaBLxacU
 WDu6ZI/ncpTGqiOGKPSNnFktslvHaLW1wc9c+I2gjhlbXIBz/7GdlK5QwFOzOtVa7CTc
 jeDfYzAmf5dkUu3Pg0u5BGBkfz2rS1n/7wylbbKUIJTEKiP3kymK4ToJIBR/jmUOxZOH
 rpXNR5VuEWpqJYPabHl9Xpe7NCDYftIJD3liUXFsj+EJIgnmXvufTH38QLMxSnGgfNTW
 I8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777149102; x=1777753902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNMsZFP1DORyw9Kkzscp45gO0mOD1crtj5fObpmEXpw=;
 b=gpPOTO5xPoq0sOVsQUS7u9ZPlcWUbdmLecXVWkER9+x2YBLJts5U36YjE9R0Q8GbLP
 qLJEH9Y0JStBFWNcUSchaf3Ux3lryRoVmFiM3xhiAz69hjguk+hzzDSzyRiHgCxOlgYW
 LSv+keoXcctym9u8zAnphxqA9PPqmFMvX4kPtyimlqN8Mn2lHH/9l3cDT93Eia64Dieu
 8PJVqcmErSnJiS7TKWBoPgArxtB5QXCZSY7Wn9zAE3bj5LW4Dq9I+QyQSPreEpcBoKWp
 GbcxY11s0X2pBCEUdnX+u3p+aNe2NxAKS6TabcRwioZU4YFIV5Xs0RGqrGdPPmw4J8F1
 ZINg==
X-Gm-Message-State: AOJu0YyNtqMC7cqHok58O0tgz/qy9tKHrGN67Zsw1RrlNH1ZUxTbxJ5X
 bELC5gyb17INSxnvKbVlw7kcc2Xfn4NvnIKcLgAUDupBMZehSzViBby7kQmGvoq0
X-Gm-Gg: AeBDievJ6nmRjW83oPvo53AyIFIPuZ29bWL2pR+6oIdkbz9ZWzMfHIRPGefcHfp1qxv
 0K90W+um5SslBzUX6DsdXsZ7FnxIsUO8isz1yjGC/5j1IJqYzCKs0i+a+vJVGhyUniv5JrVILla
 XNl7d11YDxRSvuhx4Dwn/8gJltDQaocagMCo4rxt1kTx0miZGe9iUKSit552Vr7lLkhRkg0gyZx
 eD3UFtPzEcz+XEpcGdk6mintjc8CLl15HtfRnk2P24jwqNk+bUIISuDzE/juoZOM47tMqHJJY/Z
 N11GX1f3gUkeZnD/KUEFvtuHeDyZXXff80GK6N3N+rdbozcEVCitFGDOGoSJYfVFYbZehtfuFVD
 c39n77B4BtlzFxOFvy7XOiHfHuVIULmw3D68LPPFemnjQTqesK8Ect9o1SvWF9AncH4AhfNmL1c
 mrYzcmwjgMKOYjo/rpKTRSkb6UMI+MrRxm3bVBxVinCM/s
X-Received: by 2002:a05:6214:4d06:b0:8ac:b5c2:2dfb with SMTP id
 6a1803df08f44-8b027fd9e98mr401987746d6.1.1776954344481; 
 Thu, 23 Apr 2026 07:25:44 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:44 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 04/15] mach-sc5xx: Switch from tftp to wget
Date: Thu, 23 Apr 2026 10:24:39 -0400
Message-Id: <39d4e7e75c543754563f36b265ae584889211d57.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

The default port is set to 8000 instead of the usual 80
to allow for use with an unprivileged web server.

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

