Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60445D5CCAA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A21389207;
	Wed, 30 Oct 2024 14:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="agqyEfO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F2B89216; Wed, 30 Oct 2024 12:02:27 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8741788F28
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 12:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso62189011fa.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730286144; x=1730890944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Y0cQjiWhCk8Wo5244r3KjuFQcxI/spvogrmr0fH5U8=;
 b=agqyEfO3qDnSa1NwR699Ns/dpXjyK9wxwaUmgk3CCZAm4iKoLwNnmHZxwZxZqHxC1Q
 7WUay27KnpD/xnHSFYOj8E1MA6yrAj9jP345J4/nMOqY14h5Zfk8ndQG5xegGrn6NWdb
 /DC6DJhMHw2tC2W7eQGvCIqDSyTMfatDyYwWhDG53iexR2RW1/NZAYFtork8tkYwt2XW
 ipWyTzJsrmiX/r5dzTSNqyIVeZGTDySsQ6DTXtaKJUnBN1cq2U/cxXGonBS0hR0OJWZO
 BTFQHHktPNtGZXTFYDutYDwKcCclPu4aWyfJKgq7VsU3130FRANbJmGPveiGv+FxZgQD
 aZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730286144; x=1730890944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Y0cQjiWhCk8Wo5244r3KjuFQcxI/spvogrmr0fH5U8=;
 b=Fw5Oq4QFagDOc0RmjZwuaswxzuE6OLNLwV/AIq/dHrTBFXE/1qyLBFzt+epfO2tXls
 oX6BUVbc6Oz+fVcjSiaINd7vDFX8f1vccMqiEi+o8yCw1fCSZUcqngn/ld9DdJ/lUKRg
 wjUhTsAGVCF6PipYtu0llqonSXjOn+nZhyyKBgdm80ti7JIhs9+siTGvnUxQzdtwvq6d
 Hz1Lo9kLzv/JgJkM/oy/DrQpfEhR3qza6JB8Mvvol4vrqyR+zxpfTwQxRVLY9VxmD/A+
 tANrPVGCkA6FcP0JP2SuQ48SBcR9eBAPSiwAYO4xyTJioLSpKu8BsbM/Tw2onCwzqPPb
 pieA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlSAbNj7cT6nf3TZhSqZ/HDA7Cyl5SxX6pYGzGYk5vmg9lauvhjn2t4jMvKT9x7HUhX7PGBvg=@lists.denx.de
X-Gm-Message-State: AOJu0YwVqyGI0gxwH/eUnHBtNs9272lrLc8euyYzb6iXUMzhwcyrC5QZ
 R/ZvedW8KAMz7r1xY6K3+gjwWDj6EjrkwZRjQgS9SsI/IX+r7eeCzcUZnrG2i78=
X-Google-Smtp-Source: AGHT+IHda0yXtqXFyW/jdb9Kjch3pzbGwR02iijdopRrxX4zcNVONZWZy+PGucvP4t0i6omDZ3Ww0A==
X-Received: by 2002:a05:651c:221e:b0:2fb:65c8:b4ca with SMTP id
 38308e7fff4ca-2fcbe09865amr61951441fa.40.1730286143718; 
 Wed, 30 Oct 2024 04:02:23 -0700 (PDT)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com.
 [34.38.134.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b1c3absm15141544f8f.21.2024.10.30.04.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 04:02:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: jagan@amarulasolutions.com,
	vigneshr@ti.com
Cc: marex@denx.de, trini@konsulko.com, u-boot@lists.denx.de,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] MAINTAINERS: add tambarus as reviewer for SPI NOR
Date: Wed, 30 Oct 2024 11:02:21 +0000
Message-ID: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Oct 2024 14:17:52 +0100
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

I'd like to get Cc'ed to u-boot's SPI NOR patches to help review them.
The ultimate goal is to have an aligned approach in u-boot and linux.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38c714cf46..df046192ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1604,6 +1604,7 @@ F:	drivers/mtd/nand/spi/
 SPI-NOR
 M:	Jagan Teki <jagan@amarulasolutions.com>
 M:	Vignesh R <vigneshr@ti.com>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 S:	Maintained
 F:	drivers/mtd/spi/
 F:	include/spi_flash.h
-- 
2.47.0.199.ga7371fff76-goog

