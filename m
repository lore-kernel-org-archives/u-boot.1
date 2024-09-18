Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A4ACDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DEB88F4A;
	Wed, 18 Sep 2024 17:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DOWwYBov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C10788F30; Wed, 18 Sep 2024 17:22:19 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881EE88F0A
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so832084266b.2
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672937; x=1727277737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuAtYiV37lHVXKik/5kHZmwyI+vxZzd5Fd5yKBNPjE4=;
 b=DOWwYBovmwo8mOktWKyRrwg72e0IpH0PfHy5kznvu5N3p/RqlCxntGIaPoB0bn0cFW
 85a5sz2IGvRAg0cau6jJco+Hd0jHtR2of/21xReBwW7o8PYY2HwyCBkZgMkUV3+lS6K+
 6VSJWVGzSLZ+SuO2GOoXAXsLRFCMkv3uBKVYQdR1zLOpDqqqmVXubhR8YuDefhbG+EYB
 z1hqLt6hP+AqL28ibCMzsnwCPYb+/t/FTDXSS7mUVoKlMme2HbIhF/0jqr4D3NkvDLPK
 UN/jOotNp2YFWS2egh51tp4UltqBwSSSVymOyCBYyd0OAnCLBtqee321utPraY39o/wW
 J8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672937; x=1727277737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuAtYiV37lHVXKik/5kHZmwyI+vxZzd5Fd5yKBNPjE4=;
 b=pEjjWPiCfZWUFRdu8NmKE7hkrtNKZQgBPavURlZT3m5Xqz/NGwA+rZX8g/9g5Tjbd6
 BqKWBurDj4nLBzu/V4WDXtiPxOhhptTc1XEv0AMBtWI+1AuRGdYrKVPUgo7GF4TkYGRM
 imT24JIQRlj/cuUuupFHWGL6plBChxpajWBmGCgbbjC/36q0HhtePZSFDuaDjgzG076I
 +/pOr3XZc1+TaTnrSo+URGkgd77tqkpRWDOulWQjmu5zx+2Mdkj01Fvgqss3z2l8b2Jz
 Do9BUVk7w5/peSpMQ88kP4Yn01YXa4uCXH2Z2q9GKGzVffqGOinfEZabuHUuspSodUAD
 rpxA==
X-Gm-Message-State: AOJu0YwpFbcGZEkvDatTAWdB3xvt3OLKB0jxPmljPHiWyh4Ui52vyCLz
 YJjJmeCf27cVe7IG02GNc/i/bkP1jGLRsPT/5PpRnNZ4jbd2RtbTD3pGoPR7iWP6c4f/26w/lb2
 b
X-Google-Smtp-Source: AGHT+IH7IsNrXmsO8RKnuW2FeCty8znv/vph1dz3djomuy0+vu1OUUWKo/QI8B5MWDcDlJqEV2V3Aw==
X-Received: by 2002:a17:907:d2e4:b0:a8d:3705:4115 with SMTP id
 a640c23a62f3a-a90294ae850mr2030094266b.32.1726672936918; 
 Wed, 18 Sep 2024 08:22:16 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/35] acpi: Add ACPITAB for PPTT and GTDT
Date: Wed, 18 Sep 2024 17:20:14 +0200
Message-ID: <20240918152136.3395170-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

Return the ACPI table revision in acpi_get_table_revision() for
PPTT and GTDT. Match both to ACPI 6.2.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 lib/acpi/acpi_table.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 48f8ce248f..7ee3248ff6 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -841,12 +841,14 @@ enum acpi_tables {
 	ACPITAB_ECDT,
 	ACPITAB_FACS,
 	ACPITAB_FADT,
+	ACPITAB_GTDT,
 	ACPITAB_HEST,
 	ACPITAB_HPET,
 	ACPITAB_IVRS,
 	ACPITAB_MADT,
 	ACPITAB_MCFG,
 	ACPITAB_NHLT,
+	ACPITAB_PPTT,
 	ACPITAB_RSDP,
 	ACPITAB_RSDT,
 	ACPITAB_SLIT,
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 959cac9e2e..2dc7b998e2 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -107,6 +107,10 @@ int acpi_get_table_revision(enum acpi_tables table)
 		return 1;
 	case ACPITAB_SPCR:
 		return 2;
+	case ACPITAB_PPTT: /* ACPI 6.2: 1 */
+		return 1;
+	case ACPITAB_GTDT: /* ACPI 6.2: 2, ACPI 6.3: 3 */
+		return 2;
 	default:
 		return -EINVAL;
 	}
-- 
2.46.0

