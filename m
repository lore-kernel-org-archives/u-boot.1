Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83EBE99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECF0841D6;
	Sat, 11 Apr 2026 09:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BipmekNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC5584120; Fri, 10 Apr 2026 15:58:39 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2A784198
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50baf2df711so17478051cf.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829516; x=1776434316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=BipmekNWvGi+ZI8FA5St+P/HVDb43Dpe3tMEN4liOAR97jvEeyfK6UD4ENStwVhlpC
 Yqo6MWfaIXesBr6jDLtJjvAqiUnDngtXyFYTwdx031yqBLzDQ+ydxPYEZMUPryk7EyQH
 8ezweB1OjR3qTIMu+48/24EN6kGPTJYl6o/+WW1rwoUnR4id0K/DTos+A8VOc/SIaco3
 qksvPZc9FyaJ99BBb2urd3E0RpRT1dCxa14JYPkzbx4Xj+bOnxyb6Fs6S00lf8HPnnL8
 FOSS2Y8tKEd59yAPFk789YudyrbhA1w8uXuOHMAb6Iv+euk30xFp07Qjv8A43DPxXduC
 uekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829516; x=1776434316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=eKqQC2nA0BhLA1LIDzWHh88vlae54/mV9xa+8ABvxna5xB+0S87RN/xCLs0b/pg0BF
 X3d+p8Mx5PLWACu+GYzjU8pPWOSAK1TrOWk/YjAz1v36M+AD7feOKm/6WNjtojNkoxnb
 OGGGliyfTMBeWXMMo0BKtKhda+GxiP2vem7CYHCg2HmrvWyN/GStQLIG+wpRlW2ahPv2
 4vh4dfQyTavV+5qJFaIRDiZ9a72tg018Nn+B93vRmLfrHsTXOFwos/rxEC5zW13jVdSi
 FKnYm35ZRch4PWdsq92wGce3Ld5c/jvGdvR3C/rqP9RPahd6vr9bF48dsn3KW5POv9Rl
 2vjA==
X-Gm-Message-State: AOJu0YxQfO2tpYHL8lyxKudGsdUiZg1z1VjKDlvE8ygO2rMrLU65NCBv
 +2hoA/SdgkTBKbcwdy/o5RdkV+KAsPjZIheSofNgw/n9Fa/FYI+ikYfm9BbwL4/L
X-Gm-Gg: AeBDietLBPg62Tdpp1vFGCZlXn2/m7aZO9y6mUUlzYAS/71gKkUqxH+EfkcbuxoYtYq
 pCLwxjvWkcI5NzZb836wUNmglIoevhgbeOuElroOMCtCYL/xF6KLxJmtYYi01ThS6SXBnF4wkcW
 +cs+jlvr1i9ztyebMCRjuntXrzl44618IEt2S84Zl0lcKWG+ADy+p2gwYM05bLWP+ocYqxoafHg
 qQ5XoJu8erd4JTsK6HjSKzsdJkm0yD8L6YKnkTuWaFbRRIsOrRRouNs3qG00xM+VnGkkR8nJthl
 NAIBaSol9Qatbz8/ihfi9N5bBavC+l/YLe0C5neY90oR1Jw+Y4KAXxF+N7V2Jf9YP1C0azjco1Z
 JujY4JB6IKqxWuVKFfJMDwV346OYRkGDt14rpn51Y7wIpew0lqP/mzMQLQ6WCAFQRU2wJaXmkoQ
 oF8KNbYs8suSM6jvkxHEk8UdBAAuoI0hGdcdFtsDs3EtgT
X-Received: by 2002:a05:622a:58cd:b0:50d:7f60:6231 with SMTP id
 d75a77b69052e-50dd5ada0f0mr55743491cf.21.1775829515871; 
 Fri, 10 Apr 2026 06:58:35 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:35 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 04/14] mach-sc5xx: Switch from tftp to wget
Date: Fri, 10 Apr 2026 09:57:59 -0400
Message-Id: <93d026875d2e477156a401b2ed9bed96250610c7.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

