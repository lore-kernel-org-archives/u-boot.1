Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF41EF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E910F84445;
	Fri, 17 Apr 2026 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTcfBAv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B92FF8420C; Thu, 16 Apr 2026 17:20:19 +0200 (CEST)
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com
 [IPv6:2607:f8b0:4864:20::a41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EBD8420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-vk1-xa41.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso8145339e0c.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352816; x=1776957616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=HTcfBAv+aMuqpb6I0xbUEf2V/OVUldytwyv3R3uoqQGrEFGyTAO4ygT6RMBk2VVMwG
 leDsChufWVdZqfhc61DDodqP5v1ZhFeg4b2fMt4PUmOyxDrf9SLyCC4e2c7fJ03KPD00
 9dt0ODZC9qZoBRcbXA8YZM6GjFsLWg7o1BTDD8j46zhPVmhPki44Hw40dace9ASuLvyJ
 xAM3jpia4KJnKTVqQAYZ22AU8+xARnD+Zmyc/2pfI1paeU+IN78gRXS3biDwun5Md+Jb
 L+UsNLqX/hvaTd8aXTZe+D1/M/dtTq4deljNIvnkE/6Q47KsDpjrD5Zsj3mJVqae3NYy
 DG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352816; x=1776957616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=daJhOBPo2ClFTlFit1NSP5HnWsMCDkJhHQCFOfJ6crM6LRVVnVfdMcjyk9Fb+FiEjK
 zvPFDjaFcNT/DvrP7uVbR4dDrV4G/hnZGIuWOiVxsfdReS9pn3qkSwBZ4X5Q5cxUi9dx
 lklIO2wsIASDoqP1AY0sEXQYv34rNuKb7XiCNRFPpHdkc2x0rDw88FHAkb47V8fMNYXQ
 lPhCckiMo3aRXn7s41Xftm/gpOEOSPRsgYwtVbXQD7z7PKF2yD44XNWd5+p7ptJzcDxd
 dZ16yGfnrSZyR9HYVXZvWC9dFKUe9apAsYlurJGbV8BiAM64LPHTNTVBLIiufi8gHpS7
 PvYg==
X-Gm-Message-State: AOJu0YzSH/ykLkIl68xkknYgMlpf39OXZfV97AQoox3mduJyC4crTAOr
 NMafXMke/CGp8z4rbvOA+UzfxsLn6q5yRh9f/sJZPjdt8a29OdwTMNG1kQ2XPNLJ
X-Gm-Gg: AeBDieuys6WRxQus080YypyAIpJoZOBNQCMGYWxpqsOdKolZ2KYDFm/MTr3ZnaS+vrL
 rxi5iWLJ72kOHJZNIyjk/nTGFWlBn916gtPlaOy7x1lnc/FyAJixYaqVgqNA8pg/o6yly3FRLn8
 psmowBB/HMOxrK7cIDc4sGBVTYIEB8gr7X8lF+AamcDJT7vfPQPtMRlv+57E/gNWXE9mvgFdcYu
 mW2984I1nNgpSWI/63DT8BOgaGljZn92XcyXp6EPzhWIc97DjgBET6vZ7pwKCFSWVGMJljAT1I2
 g5++fCur3yePCmoK49BmaFhrrsbw79u/FiF78EwHrTcnyKlJoXaPLQkVNJsMHU2VclwmQQ51Wd7
 CKr0ANbMY4JgrhoOrGPUljObkzMcvHswx0nDZ1wBVvYO7xFd1mCQrNET2Zj4gpxnk2liA1fXLGe
 UISLQUQ21NWwft28lM1gxNLyet+BWSOCXrYQ==
X-Received: by 2002:a05:6122:e24f:b0:56e:f262:9109 with SMTP id
 71dfb90a1353d-56f3baee745mr14323854e0c.2.1776352816361; 
 Thu, 16 Apr 2026 08:20:16 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:15 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 04/14] mach-sc5xx: Switch from tftp to wget
Date: Thu, 16 Apr 2026 11:19:39 -0400
Message-Id: <63a35f9608c046f37f610fb0679c7217c93016f3.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

