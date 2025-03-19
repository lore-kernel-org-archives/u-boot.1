Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDD1C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7911C81EC9;
	Wed, 19 Mar 2025 15:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mFN5yL2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A50803CC; Wed, 19 Mar 2025 15:38:53 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F63581E47
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so34137725e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395130; x=1742999930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENkUHjgkoGJEeFe9zQ84oNORY+YyL/+vvMCk6oJDCWw=;
 b=mFN5yL2GNeZBFgjwhFQTAW7Znjr+iq1wlfn5rvHyPC4K/SDjFzGfEqG6l9QIGoRAgB
 B4OcngHeVF94hKp3m57J4B6+c+pT4f4lKiD+3Wc1bRQTXjzgTILKUff/I4XWzusyOQQm
 y5PdsGSFzVJS/y0Qrlswb2ftnQpxU+SQFEwlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395130; x=1742999930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENkUHjgkoGJEeFe9zQ84oNORY+YyL/+vvMCk6oJDCWw=;
 b=NUO4AKhTf4OEPZZMdEpEOMLZjf0QyZblbSByQWdkvXmhij2Gec/0lyxWIf3f7TsTDH
 5pt9VRP2sEn1I2FhwBhFT542iaMv0vqRsIsmz2gispwrCaa5SpVe8bjOIya4GGM4zX27
 HGB09EV8Nejt+Uher55lJZ4bdSFmUVSVKWLRv8k/e8wV4Ul2mwFRpPQ7iZXK2B5XWtnJ
 HJh6SK28KETWRM3crRcu5bkzGz7EQYFztxfvIEweYy7o4KZNNdNjbQCKPK0gLyEIDnl/
 MCCUOR9ZLJ8erCTWNHMsfbkbBjVr+eLuTFpFuhyHSMEBNVP+BHCUoSyMX5i3U92f6jAr
 Vj6A==
X-Gm-Message-State: AOJu0Yz7LbXry6NaMRXDEF4YhMR5p2vjCM5fDdPJylthwFpHgsIIO81V
 wW59BfhGrfJwq+K7IgT4NQ4Ul57KAYKcCYFpI3zb8qmVcuWwer3BwjtYIop/lK7IZ0DEPxwKGV0
 =
X-Gm-Gg: ASbGnctxCpPcOQHlJQ+Ehz9IFvB3lIPBQsc2WOHT0OddgY4riT9DSgNM7zzthMce6tV
 BUdhi1KVmM7fXHjNABpHVwJwjovpRHTFgf4ShGPvvcYoRs51YsmEUN5eHNClrLvLLt7MQYww862
 hDP/dmiB+HiCdlbu8V+XDiU/s7+xZ4SqGM16Z7XpU+xA2ndoBOhW6N9nq7NM4xjQ8UMSrgN/wqz
 ULpR609gaShNTtNgv/pWo0Sxjqv7ZTS/do1q9Ez05qPJLeD6C7PRPJWCI/jB3lzrJlwvkPu7EkN
 G+bf31APj7L7kAXSGF+UZeqy450JNpN1fAjb7sSIF9VaLd1GZ5ep
X-Google-Smtp-Source: AGHT+IFaNcpXCM6mfrXCZOhuRG34Qj5t0V/RbKt3+QwmsDLwSBOCDrg8KpgcpGjWTOHz8xxO3C3GPQ==
X-Received: by 2002:a5d:5f90:0:b0:391:1652:f0bf with SMTP id
 ffacd0b85a97d-399739e63c7mr3771663f8f.33.1742395130073; 
 Wed, 19 Mar 2025 07:38:50 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/17] bootstd: Add more debugging to bootmeth_efi
Date: Wed, 19 Mar 2025 15:37:58 +0100
Message-ID: <20250319143820.2385092-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Add a little more debugging to help figure out why bootflows are not
found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 0c9b4c3d59d..01cc7ec3bec 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -103,6 +103,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	char fname[256];
 	int ret, seq;
 
+	log_debug("starting part %d\n", bflow->part);
 	/* We require a partition table */
 	if (!bflow->part) {
 		log_debug("no partitions\n");
@@ -116,7 +117,8 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		 desc = dev_get_uclass_plat(bflow->blk);
 	ret = bootmeth_try_file(bflow, desc, NULL, fname);
 	if (ret) {
-		log_debug("File '%s' not found\n", fname);
+		log_debug("File '%s' not found (desc devnum %d)\n", fname,
+			  desc->devnum);
 		return log_msg_ret("try", ret);
 	}
 
@@ -165,6 +167,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		log_debug("No device tree available\n");
 		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
+	log_debug("found\n");
 
 	return 0;
 }
-- 
2.43.0

