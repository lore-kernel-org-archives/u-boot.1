Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68BE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 08:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E9D80137;
	Fri, 13 Dec 2024 09:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YEoXlImu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4792280141; Fri, 13 Dec 2024 09:58:52 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFEC8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E9CCA3F7FE
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 08:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734080328;
 bh=gL6pjWY58vjrFbQ88gCOfU1tPXPBonBegWmeNUbi0lY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YEoXlImuWoMyd9GyR0aNdRFIucofmlLo1q7V17H6kHfLztDhlyNGZQXtkBiQaoLC2
 BgWz2u86a2AC6Pzoaur2se0Ry5egDjmb9FUpaSFregWlFqPL5qF4d10rKJfMrya7Ka
 BU/CXyJ4RbIcZT6OBZBeTOBS3gwJbidp3fVigoRoLBLFbZZanyH0p35Sf7DZSzazjY
 D3BbufjatfoExth+MLWtUUgbn1OnakBaDoB2Ie3lr4HHk5T8kPSlTXXaJpm2JN+Hvj
 Ez5BFMa3BYlRvXjIl+He1yC3SsOayTTspTDuPmogBExpJbwTDRL8ZwGHPB3cf1NUif
 KidiavsV05gDg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6a831f93cso162444066b.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734080327; x=1734685127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gL6pjWY58vjrFbQ88gCOfU1tPXPBonBegWmeNUbi0lY=;
 b=IzKSAKvbKKJ0uvmn44n6RQ+artTtKmLckz6riYAiTv0PK2XSfDur46RAX2SmABQKjq
 tYgvf8fN1/ug+gJHLCfHEKQUGAANVPbS3o2MKdGHE1Y0KICUCud8omHrDRARQulPi0Be
 f7Saev5ebraXXQ15mtiYkpYg7n8ZoiC00D74pIX7xB8F10Ys8VMnG8TlJmTWWdwLBSrN
 m6DGInqYZlda3L4Ft3wHv0s1QcMx6s+XVr375PW1AHZpG7aohzH+/lWJfZ5Voyn+QCHr
 DXY83N3TbxtXhrU3WXVK9d+sUqsvRNOVoXS5PY5hHXEvZdvAs1EYYx1ddX83FA0Nx7mB
 H0hQ==
X-Gm-Message-State: AOJu0Yy2wVAWUbJh6Itep+8HpmFqyjwrd6CHXzu0ehZ84p7NQx2Lcp34
 0FtKVkzUyHfQnB7u51/8rRvOxBqB5IDkUs4MJVkwkFRlZlUR7k4/N7BEPl+y+adWr3ffdJK9WjG
 DG+/zo/t0BROTe462E3lV9DHhHED1zhdu8pZLf8wd+XOwz3PveluPbLlsnqCet/FgfHE=
X-Gm-Gg: ASbGncvTJnqmxpLqyS3kRpV/lACoQxgkwrkoPFCDGeOu3oaxu7P7uKLIvsIlt4jeWl0
 RnWiWXLC+uPTiaEe/pntsZvGU2saWnhDMbmHFWtRHLemDCCYB/LBMsRPkGuU/md8oM6HcBDnyoA
 e/Cv8nFTOinEkBZkYARqfXazKtT6g9dpWOmHuGK+HOpm7qJBYUFGAok4FXXuetB4HVzwy8WAyqe
 1/GMoIAFD0KTHgFnen+lxd1qs7W3oaormRDwrYBdK5cRVL8cFjEfLCXzhsYwBOPAUYpg2QjLaHO
 iykgAH/EkpQQ/E17C1cHAltjITxJ0wBzbo0xjaPYqlad9a/duBQy15hIXiY=
X-Received: by 2002:a17:907:1c1d:b0:aa6:a501:9b3b with SMTP id
 a640c23a62f3a-aab7792d03emr203692466b.19.1734080326739; 
 Fri, 13 Dec 2024 00:58:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyUt+iScAOhykKIgaQ9f/ocb3CH1av1A5gp+1xpMAHp4qi4/GTC2ebKZgl9XeT5ASekxF+ng==
X-Received: by 2002:a17:907:1c1d:b0:aa6:a501:9b3b with SMTP id
 a640c23a62f3a-aab7792d03emr203690366b.19.1734080326416; 
 Fri, 13 Dec 2024 00:58:46 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3d9e30b7asm8783147a12.57.2024.12.13.00.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 00:58:45 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: update EFI specification version
Date: Fri, 13 Dec 2024 09:58:40 +0100
Message-ID: <20241213085840.21872-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

UEFI specification 2.11 has been published.
There are no changes relevant for the U-Boot scope.
So let us update the supported specification version.

Change the comment for the constant to Sphinx style.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_api.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index 61c4eda8f8a..b10f467f67f 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -20,8 +20,10 @@
 #include <charset.h>
 #include <pe.h>
 
-/* UEFI spec version 2.9 */
-#define EFI_SPECIFICATION_VERSION (2 << 16 | 100)
+/**
+ * define EFI_SPECIFICATION_VERSION - UEFI specification version
+ */
+#define EFI_SPECIFICATION_VERSION (2 << 16 | 110)
 
 /* Types and defines for EFI CreateEvent */
 enum efi_timer_delay {
-- 
2.45.2

