Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3873310F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4F584035;
	Fri, 27 Mar 2026 17:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MmiXzza+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDD083FA7; Fri, 27 Mar 2026 14:51:48 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE9A8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50babbce85fso4100121cf.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619505; x=1775224305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=MmiXzza+hCcB09cJ7gRTzz2+yjNfky7cHmXe9KSheqYda7mCxju+VlY79pYZoYYgay
 1Z0soS8HyCBpVEKbKyzF7hoOvULS4551Wr+nWYiGJKciksW/SAWiQ+KU8B/EP8jrnKyw
 9F65TMbMLZ2q7TvfE18NKSjQcqbZGBhJyxZoHPrWwazevWpahLjDhtT0LywsdrDx7pH7
 +7X11bxP+wELZaSLSUWtvL+fBGFws8m3m6H8i3/qyeNdZ5r71Q98OH6p1J9kBlm7FKSX
 0fyg/0naM+DZaPTzt0R6s7n2JBk26mSTvKsQuulVQn8Kbb4Tr4133/FFvx8UuN7YNCan
 kPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619505; x=1775224305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stfTQjdWTDuRBLLaEV+c52nM+KhI813YA5gg692jHH4=;
 b=cyPsaN07xbf1WcLawtN70hnVrkT3QDdujcBFlOuwIUe2U5pul8fpkIkyB323aekIev
 74vcXPhnU+jUIy/TJoBC3drDCQvddYK+AF3dZCCJRgo9fB1ki1T+vBa9UumGBg1e/jfI
 Jb9e5nhW90wWoVv1+U5b1Km4qOCUfQs5495SfTD0er7eHtqPTy9cCmiqTUAVsU1+7+Q+
 z3r9Dq2ndhSPHtUQ8969/JRfzEUzSfHYYNFFpEoi77i+kikeQ6rSkIfFYy39U7fKeeDJ
 QhOxB1xbTVMlsl6koZnWB1LjGcYjaiaqSGQm5EIgPwqCZfFtLOELOqZgCTmT37CINI+X
 pUWw==
X-Gm-Message-State: AOJu0Yw5xUi1UyrDAzwc1GN1SuGnjrcrF80GzW5yAhes24K2npokYjrw
 eNuicMkRrPMvorx32aFSlEPtHk0jkt8pFzkdb7hWp8/HMxSsL2HAL8wYnAR2E+7Q
X-Gm-Gg: ATEYQzzBM4JB6BB7gH/N9nJC6XvnSmlyDh3DHuxqFpgRkNyU8DCKJfMxViA0drYbE4n
 VbslI+iS9JJVJgHV+rkQJi9kC36Gfpywk4TDf+E2L/b0HcqSy+WaQpFSrC35kDMQXAofSDCOyET
 eex/jWTmfAJk32d74xymd0sDFtbpsxjAF56B782bjMjAksGcifu2tz/f/i6gIPlno30hRuzTisY
 ZA4TtVLs7hEpVQnYKruhoLxpUl0GiH5cUOrB31SjrVKi18Tjv7bt2hSN9xR/tLRxOwmFzj5ABqE
 aywwMN4cptOEUZ6+4W2/z2XCKbtpEBB7YEcCbCGh0/IwSdZinTzF/4y19uNFXT/kHQyuoTJBdwz
 NR+uGaCvmvsSlH5wrxTb4l9LeW6VsjHKMHmutpI6h732WbAgzF0E4YNxhRwjbOsVcT4g1bmXQHu
 ED41anaPPzeEBGwn84a8zepNz7dusp2bW8DQ==
X-Received: by 2002:a05:622a:40c6:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-50ba37f5b1bmr34109401cf.19.1774619504853; 
 Fri, 27 Mar 2026 06:51:44 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:44 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 04/13] mach-sc5xx: Switch from tftp to wget
Date: Fri, 27 Mar 2026 09:49:19 -0400
Message-Id: <0c12c7ed4687af9fe2df2b5aa9327f1c2541eb4d.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

