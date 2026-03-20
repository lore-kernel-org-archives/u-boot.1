Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761EC1098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B3384006;
	Fri, 20 Mar 2026 14:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LoPXD9jT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F80883D71; Fri, 20 Mar 2026 13:52:43 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FEF83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-89c52ef3c2fso19839996d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011160; x=1774615960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvcRbLmmrEx0P9y75/j9jQM1yG49umTKclsFYZLeKW0=;
 b=LoPXD9jT+GXBacFUmHn7fX/Delg3JM16lcbMEfMd+akK32Yb5PxiPH8GrMu0UroGcV
 u6N1Q/ldx0re4pFwRnuYD9fVahUObCFnOOc7tuEKIi1oSjS4VcFSt6GXufXhMcq+Jltb
 7j8xmV3AxP7IUEXcpYiwkSOc7OQPeRoGDhh120LZ1hkPjKD77KunTFFpIyryh0nYsIA6
 VLk5Uh7hchr4e5/2y5aoHRlhylfP4au87hpTNdKHUeBbLKisfFS/WuCa2279EAgC33bl
 gbc25lPatAu17Ftid0YOblVYRG3lzaf/LVS/ejIFckO371sky/cxuF9K2ieRaWcmVNxN
 EzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011160; x=1774615960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvcRbLmmrEx0P9y75/j9jQM1yG49umTKclsFYZLeKW0=;
 b=KbP8t/z7ABWzIbQjv2vCGzpsz1M70vW1AkanoEtQPWtCC7Da3L0OyDwj91nI2LIyMd
 5km54qh87DKAQ5J3/Pk4OuzDudxjWDUaFBQFDbSsc++Rgk2zc+yNS+n+GclLCrmx1PX0
 k1WFr5Ec+iZr9PvBjhORJvxPSednc5gdXsmz0RNAPZgTig4WcS0z0BqMGirsqAoKcelO
 WxuXfXSPVjX+kE4S4JtcXKFBNCA18cj0uTrSlYPqA5Ri3eGMi/W2Up/g04vBpkQWjVYG
 wpCwh0zdLvr9oq5xVr5vCVZrzyunRYeXUGHLXvXEJJLkg9dB2CRdASdrq1Z1KL+j4uPD
 358Q==
X-Gm-Message-State: AOJu0YyVhgQBdUNCRREOJjb+SfzZ4QeRnOs2inhwRmhwAa4vjOwlpNkf
 tA6g+2EB5tyhLn4JVMLInF9O4+7vh7zvOogwoQ9Yhc/aA87636c2+GiNUwRbebMkCD3YBw==
X-Gm-Gg: ATEYQzxKcz6lVotYp7cWRBQYk5EbqKSMjft2YLnorR8/4psiSI1D6N7fiFz0BzjED5h
 uJVJe+95CZruTDJ4nUj5mKOcKHFRP85LBhl16bIUiYSo4iDqzd0CdDjKiPTs2YiBVfnUhMv170a
 QQ6pCVUqBNlIMg8Oc8UmLptgS8dghE9HPXzeo85Qf6S/jognoKewMmOkGW+GvA8jfmXDYcgsiqz
 0v0py3VglpM7xcNusX6fMdaJpoUZi9C1WhqTE9Ny55rhISVNkd/m5vdHpVjGqwgc9jP9DLQLNCG
 N4Kw+hWm6bN+SuSRmsO95zZnkI35ka1Rba05hSpe78QwF6BQgcKa1s7WFfeou/W6IBDH5ma9RZ3
 sJykV7/C2vkYCwwjHBJ5IOm8Cwceziqb4Q5+4j52tvlEE/WlVYz4kEDbXGkD/efZ5DKnD7b+h1N
 uufw7+4VKqLrhRGMw/oCT38J9OqCBp7lCtIQ==
X-Received: by 2002:a05:6214:6016:b0:89a:f10:996e with SMTP id
 6a1803df08f44-89c859aa866mr35391916d6.6.1774011159976; 
 Fri, 20 Mar 2026 05:52:39 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:39 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 04/11] mach-sc5xx: Switch from tftp to wget
Date: Fri, 20 Mar 2026 08:50:19 -0400
Message-Id: <1e5fefaa837efb9bbb55182ea7c8e4c602742d72.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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
 board/adi/sc573-ezkit/sc573-ezkit.env           |  1 +
 board/adi/sc584-ezkit/sc584-ezkit.env           |  1 +
 board/adi/sc589-ezkit/sc589-ezkit.env           |  1 +
 board/adi/sc589-mini/sc589-mini.env             |  1 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  1 +
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  1 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  1 +
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  1 +
 include/env/adi/adi_boot.env                    | 10 ++++------
 9 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 9562b9a68a8..88766870c1a 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 adi_image_offset=0xe0000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index da64ebe093c..e2365a343f0 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 adi_image_offset=0xe0000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 43f5d7a5565..f49d30e88e2 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 adi_image_offset=0xe0000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 7726939946d..c741896601a 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 adi_image_offset=0xe0000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index e3f25043856..d314e1117b5 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 adi_image_offset=0x110000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 2fd2295e1e0..d9109149ec9 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 adi_image_offset=0x110000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 1da4a585b1c..525e0f3547b 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -6,6 +6,7 @@
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 adi_image_offset=0x110000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index f8c5b8472d1..8b23dc6e7d8 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -5,6 +5,7 @@
  */
 
 adi_image_offset=0x100000
+httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 3c196e40603..4d4a76729dc 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -27,15 +27,14 @@ adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
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
 
@@ -64,8 +63,7 @@ ospiboot=run ospiargs;
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

