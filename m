Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E4F46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF72084118;
	Mon,  6 Apr 2026 21:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U57V95Cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DE283F98; Mon,  6 Apr 2026 21:21:33 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C6F8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso338451585a.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503290; x=1776108090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=U57V95ClbvGqPfA/TM1VNwjbzF8sl2p3fUkOc+W32//2tg8k34n1s4NitLPcPxByu/
 3o9EX9dbDVxZ5oROzWGUAUy3ckumZsMBF9lJ89UXWNfYKQJlGKNDSyWW0AYxVUyt4veS
 XATwJxLHj90LsHlk+D1ru7rNm0dKX+vQ382skWpOS1cOcbSdN79wG+dHL4jmveP6aHMN
 gzIXvMN1WNIcdXxskEPG7Asbd1+gJawUP7AxXH05OpuEbX5918/QX540Q7+C74Xi3mYe
 8z+9wXlaNbIxkZw3GCI3XETAXzkcarAGr1L0czwjA8NxooeoSQpC6Td+RUFNKTA6QCOc
 j6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503290; x=1776108090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=e+MuhcZltafKFYMvoRBbh8cuT5adKu86Kt1O90keFJ9DkOpmAEYnOmdFsw+vX97VHK
 85j44659h8dLAIwUvn/Jk0p7+y1JiHYS4uOZGD4dUEGKVSS+Xjq3zp/nrsglEE8WB8yi
 orECvEvJqODtADL7VIIjVLLzC+Kw8FIMACBaAIvihjb9IdH9nFVpLWXy92EYnYrx9TYI
 d13u7kJpzpG53TtOM547KKghoQk+/K9FuUGtdjEL7UOvbTyTAbQEhSwnDVS/52zZB9oF
 /EoHxXHaU+KYIMCZdF0p2BSTAB7QBT7OTb7+Kwx4/FeVC0dL5O0w4+GhBi6rywzi5+PN
 gSDg==
X-Gm-Message-State: AOJu0YyyBXDXML0zjaAswWmE2crxklTs/mG9dLnqVae4XwrY1NtDLFCZ
 N+eNDEtjTidN/+qQjwjW9emRAWVX9Q+2U7O40nZkiq38Sq/YnPrc3GqOJtTb9yvj
X-Gm-Gg: AeBDiesg7q0HHy8ISZD1Fd3/eKB29iYYa32YiEnJDLhmLlUmi1CMuO8VyCdbWsqo6Gg
 jO9sdyw7JeJiSqosjF1wUF+v/vWJUSMcu+b4MeHQQP9p/elSTvoHEio5/RxXmbIXBL+OIqL04I8
 t9UVWO6701a4CiGk1seSY0+nhG5psJjgwTcHJrKP9uDhZcY1Y9cq1HTD5zp/JtIpFMXaTzwm3E+
 XXxMCuLW5NK4KRXj+u6M1DKSWvRq0Sn5saYatBT6qMDFY12+kOaPkYhfp195kg6E63unmIpCcyL
 kv94PAEdbywFUcZXFDXJzeuVJUd6eeSPlstQ2GHkmRFMu6CDS15Vu491noQnO3E198WOWK2+MCN
 DSroVg4Hy3e54tuAjCSXoA1VUTPceD0mQe4CUpTxHToj4RKewFDAtpBjuatwu4tcGr+xlQUlz2D
 4ZGaga0trKkJZqYY5Ac2tvzcU0vG16iqYxtXTUYJiqm4xz
X-Received: by 2002:a0c:e007:0:b0:89f:97cc:b8d2 with SMTP id
 6a1803df08f44-8a702e84850mr218149946d6.17.1775503289661; 
 Mon, 06 Apr 2026 12:21:29 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:29 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 04/13] mach-sc5xx: Switch from tftp to wget
Date: Mon,  6 Apr 2026 15:06:06 -0400
Message-Id: <16ea1c8e60ab04d93f37f1ca48ac07b24fd22d34.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

