Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC424D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CFA8910A;
	Mon, 14 Oct 2024 15:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="aZxne3+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E122A890C4; Mon, 14 Oct 2024 15:12:24 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F006B8903C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so1940035f8f.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911542; x=1729516342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=aZxne3+/a0DEpfK2vSjOhYWuVd2fwQbmwNQ6oc1DW16qAKlf60BCu0HBzt3RHNgt9A
 BZC8Q5k2GfqaDdib866aTl00EVGha51BoAsOES+1Fw9gTWPonL1YwBR/4+XXA38drbIP
 6781efZsyvd7yhRFzzUmkGabTN8kTSfhRPtgYD7jY3tmomd8nFZYBP3ABp36b4YawuFc
 sCl9lxTjUYQRfiSAp6SRlLizVaatTErVpZ+3E8ObqfSXoLojtu5WsyxuGNGo5AjXe8r9
 clo0OQs2wWTVS0yH0azHyMFdXAwVc/iiDOHRZqOMHLTUfObr3MpLSGRAnsn7X7PZbepb
 Wt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911542; x=1729516342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=WXBnARNOetgs2C5jv3xRI3ZDsktKwKFUH0tbuKMtC0dDwscu8Hvv0YGQTka2mAZmtu
 Z1TwlsX0pTV1vPKKNCBKH+y8QiCp3ZyJCG3xU5RCEmJI7LiR41v95h9DLExX2+AgfWgp
 OOB5CSz1RV7gsx4ozbNBl8LlJDp4anowkt4aRlPX18ijP4qKZbYSYGC33lFz9LESJaRg
 K7csRwFgeITMh5wyMeTAsXkFEX1epWZ33mg0icUTpYKmtg0WjWg4qDGASA6d5XedY3r/
 h789Ala+huhn6fH9e2/fi9JhbkWJSD4OMuNr4lezA9QgD6gV3p7zoFZ6zT+FFBvKLNvv
 r+WA==
X-Gm-Message-State: AOJu0Yy2DzxQWdI57WR6cuMXKpC1kaAW3o7CE+1ap0R0RyiFJ1m+Secf
 VDKzW9NTPe4Mg8jKr5KNGYbBsJiS1uQ2fEFHso371J964aKdd6n7LLe+KxfGAdrm08xE5MoEdiV
 U
X-Google-Smtp-Source: AGHT+IEPVZf0ALyCvxkeyGwQr9jH21cgca+K4WhfgVBIEpuZKGnyKWqQVZIt4k+B7omLCd9161fsbw==
X-Received: by 2002:adf:ea51:0:b0:37d:4afe:8c9b with SMTP id
 ffacd0b85a97d-37d5531b500mr8059497f8f.54.1728911542140; 
 Mon, 14 Oct 2024 06:12:22 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:21 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 10/37] acpi: Add ACPITAB for PPTT and GTDT
Date: Mon, 14 Oct 2024 15:10:26 +0200
Message-ID: <20241014131152.267405-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
2.46.2

