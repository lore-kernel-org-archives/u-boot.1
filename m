Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8FAC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE0582F49;
	Fri,  4 Jul 2025 14:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QkDgLjfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20397803DF; Fri,  4 Jul 2025 14:32:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D6282A76
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45310223677so5944655e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751632365; x=1752237165; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7v1zow+DBIRaJY4HLjJuhGtMOpHjHwnXCnoFdAahGFI=;
 b=QkDgLjfl7Uas1hbgfic45ZhP7ef70wq3IYrcxNynPVlZFM7XD5HWoDzQ0SAYzcz9uO
 wLBwCby9IHfC669Ax/yBJ8aDfsvGLcK6S4nQVAif+lgwPYAbKOgXUmwfzZFzipA2ayCb
 0+Yhy/vbBBhxdfSulqIIezGfgOLUrM/cp5omE2vq/mKwEnsId+a32VxiLuQLFtPpbU2T
 tvUOLZf7ew2dyFKun2FwVwmls6G07XE5KWEOYGqJ0jNw8I8yh3ZxE2SdV1h6oxsaoHaa
 HPfKjfRXuncURYfeYTcqE6MWo7K2TEK3f82MG2USUQxC3ReVW6uvYrX2sR9R3eaViCXO
 Cr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751632365; x=1752237165;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v1zow+DBIRaJY4HLjJuhGtMOpHjHwnXCnoFdAahGFI=;
 b=Sb5zf7mgqN+ocX692W18dfRKCw/mnzugn9SEgu+Za0Ewad5V/VEHLVUMZG5+YmhgKU
 l48cpmz8fl+PCigUZ1HOFcRU68yGDAtDGLU5GZtpMv9ItXIpbUAstHt70BXjXpok5tfJ
 Yz2pM1orJ18rslfaoKegDgPEcILjHVQdEkjhEryrWeZ6pRkymT7Qyp3+hQezd2F5Nc9C
 tmfgs1JMdIxxP4gzcafskeMehsuZImZ+7TFjIfNlDe3fuxG1xp0htQeNGhyV4UWK8yGe
 ErejYBlIVvdkqAFvdTsed25AMZBiiIOm6VG7x+KIcPoEVQ5AUCCU06a7AgRPcqkuK+9l
 4icA==
X-Gm-Message-State: AOJu0YzH5XeXQo1q21lg4FgQv/SyIpfAsvVwueWb7ELpap8+9z6qtQ+F
 3B0pYyqpWR7FVm4Ubi5Ox+O+H7dBIq+OKFkMI/gq/dEU8s10wUykNq2P3IHxPh2Lz9Y=
X-Gm-Gg: ASbGncvPW9uT4vFfP0IMokY46ESJ4+rhuuumaxF8DXDs15zYsxzT+YXISq8Oa2Py9jh
 JB57tBkmzfPpVtudY5NaZkf8KSeNaWbg7cvaDS5QPCeGbKiQTSRIK4U72NBBJY7lvuIGtLLnJA3
 XcJHJbITyX1J+sVXM54YVULJj6JkZCNuNwnZtEJC9JuNWee1VzUYkKmAr1heKwA1JyT4lCshJOT
 tY+pMmoqQD/fPtS6jQR7G51dhN6woJl8i6YkoyDPwJiHRpvEWc+FKd+XrT1OpidZ7X6j39rYBss
 mTw0Ub48wOGsmDXBjT9uqyaW2wK4gU/QhiY/mT81xoigkZm08JXAq6NS78eeeX1t0ZSftfySx70
 HkRCtJKnFrECNcA==
X-Google-Smtp-Source: AGHT+IHF1Cy8G0t49rNKIWPtAEWbULKmE4VvPDOEPaRg5R2mT27T7lBIXlhozvVqHFmD5PMZhRmP4A==
X-Received: by 2002:a05:6000:2384:b0:3a4:ee3f:e9a6 with SMTP id
 ffacd0b85a97d-3b49703d9acmr1578945f8f.54.1751632364858; 
 Fri, 04 Jul 2025 05:32:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc5asm2367760f8f.20.2025.07.04.05.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 05:32:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 04 Jul 2025 13:32:43 +0100
Subject: [PATCH 2/3] fs: ext4fs: Use unwind goto to free memory on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-ext4fs_fix-v1-2-5c6acf4bf839@linaro.org>
References: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
In-Reply-To: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Ensure that allocated memory is freed on error exit replace the direct
return calls with 'goto fail'.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ext4/ext4_write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d109ed6e90d..dd8ed40f888 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -877,19 +877,19 @@ int ext4fs_write(const char *fname, const char *buffer,
 
 	if (ext4fs_init() != 0) {
 		printf("error in File System init\n");
-		return -1;
+		goto fail;
 	}
 
 	missing_feat = le32_to_cpu(fs->sb->feature_incompat) & ~EXT4_FEATURE_INCOMPAT_SUPP;
 	if (missing_feat) {
 		log_err("Unsupported features found %08x, not writing.\n", missing_feat);
-		return -1;
+		goto fail;
 	}
 
 	missing_feat = le32_to_cpu(fs->sb->feature_ro_compat) & ~EXT4_FEATURE_RO_COMPAT_SUPP;
 	if (missing_feat) {
 		log_err("Unsupported RO compat features found %08x, not writing.\n", missing_feat);
-		return -1;
+		goto fail;
 	}
 
 	inodes_per_block = fs->blksz / fs->inodesz;

-- 
2.39.5

