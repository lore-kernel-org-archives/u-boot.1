Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6CE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F4B8951F;
	Fri,  6 Dec 2024 03:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G74DK4et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521D18951F; Fri,  6 Dec 2024 03:36:42 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D21895DE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84198252db1so56440339f.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452598; x=1734057398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSi9T0jwsyOTf7U8m2OZryThc774EjL0fNn9zqgfeG4=;
 b=G74DK4etDCTRHOeCLbx2XNELT4P00jE6jkbCChBuEps0bykWIB8SIzEfGrMMj8e1f+
 2SLGTd4y0bTsBXAMYadrGTEzFa2y78LMKHU5/8NlaamXVpDwEK0bVOzrW6MYETg7FUj1
 qG8wZyOXdXXfm/m11SVU+IbusY4dL3Uz2NeTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452598; x=1734057398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSi9T0jwsyOTf7U8m2OZryThc774EjL0fNn9zqgfeG4=;
 b=NdnhApIr6lKrYmjqxrIwCBsmo2Wj7sLXjjRhKdEUBw0RTY9hYowQJrMT3cO9IZtZXj
 wsoxZpfWDBm5oI/NZN5r62QcAvkQEwyZHJLMPnSRSfDAzH0Jjyf/Vkde6BqMU3UXR/aC
 1zlYdyEAo4BhhXUUJaap3PbjGtZU+nFdzV4dtDrsF1hL/4sv2FB2axgNFarUxQKdPN/S
 XPLHh8vCs8BFin4t8FJVe05W911diRnxMFZqnbbBG5BJyttkHOpAe35+lHbxM/VpXXk6
 OGMnQChJ1hRLkZRzrYtryGGqzA5hyw0/Z1NVuk44YNDC1/2u7htTmpH44c7Oxqg2zBtF
 hc5g==
X-Gm-Message-State: AOJu0Yy3fsaTxW1ZqP5MgT2lUFdegUPoOrhEDQdUM34h35w/Rm9uZies
 ZQcDZFVE9Ij+eDE5guoBdQuQotd37fZZIem6r1II5iZh0yFvjNIB0GcLCJ34iek3q8zSmUnW+5Y
 =
X-Gm-Gg: ASbGncud0PLRFezPaUuBnP7kIcQLTyNOBAdb3ilnfCZJXHX+4kjgx2SZpMbnGLNATLU
 XiQwPVKjnLE2CifjOSAYCe04qBYoaMAHRa2SG40sHVLDA3sWF2nPVz3gcZqQ4kRbM6qrpooDH0L
 Lwh6A7CIfllK1F0Nhusjj8WCFgMrXRxAOrFvNZCbkHu9Vb01pdQ17BK1xH83p8R7KMJqZbh9WNJ
 u8A3s30t9lup95gNfgfvQ8a3bhoCPelB6PK/tZTWjI1DwGm0xXEHt2vNvdFMaAmSgKSGYOpRqqs
 fB/T/7iPxgw=
X-Google-Smtp-Source: AGHT+IHU+BBBOYQVwqo7Fjx+arNg7r5PgAyRP/6UcrtrJkzG+KeOvz+p7pq2cileNDRiUxU8sytR3A==
X-Received: by 2002:a6b:6210:0:b0:844:2ef3:a95a with SMTP id
 ca18e2360f4ac-84471100818mr569072039f.7.1733452598353; 
 Thu, 05 Dec 2024 18:36:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 02/46] x86: Rename zboot_run() to zboot_run_args()
Date: Thu,  5 Dec 2024 19:35:41 -0700
Message-Id: <20241206023626.2456858-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Rename this function so we can (later) create a zboot_run() function
which looks the same as bootm_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 73a21bc8f03..53fc81f57a2 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -436,8 +436,8 @@ int zboot_go(void)
 	return ret;
 }
 
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline)
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
 {
 	int ret;
 
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a..ea4c9ed830f 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -446,9 +446,9 @@ static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (IS_ENABLED(CONFIG_X86)) {
-		ret = zboot_run(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
-				map_to_sysmem(bflow->x86_setup),
-				bflow->cmdline);
+		ret = zboot_run_args(map_to_sysmem(bflow->buf), bflow->size, 0,
+				     0, map_to_sysmem(bflow->x86_setup),
+				     bflow->cmdline);
 	} else {
 		ret = bootm_boot_start(map_to_sysmem(bflow->buf),
 				       bflow->cmdline);
diff --git a/include/bootm.h b/include/bootm.h
index 61160705215..154fb98cfcd 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -273,7 +273,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
 int bootm_process_cmdline_env(int flags);
 
 /**
- * zboot_run() - Run through the various steps to boot a zimage
+ * zboot_run_args() - Run through the various steps to boot a zimage
  *
  * Boot a zimage, given the component parts
  *
@@ -289,8 +289,8 @@ int bootm_process_cmdline_env(int flags);
  *	to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline);
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline);
 
 /*
  * zimage_get_kernel_version() - Get the version string from a kernel
-- 
2.34.1

