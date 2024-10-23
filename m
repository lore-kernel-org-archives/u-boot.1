Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB22CF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E7389328;
	Wed, 23 Oct 2024 15:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dmGCSXJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23419892CF; Wed, 23 Oct 2024 15:28:54 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5A189268
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so5091694f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690128; x=1730294928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=dmGCSXJ2GEqlhOeLj8fBz9CwHSz8ay8F5sq5wLtC0SJCIS3niAF3HEC1KWCDCwR0zB
 Rf1oyFT6KapLLDP4D9+ltOI9EFWvbHuEcb+BRdKF2VUyrrEBHjA7dkQ5QBULTTTMW07i
 vS1M9Gf3xiqREP3cAC3mcs33U8FPh9yvYNVrDSyyIOzz4h96A2CUEYt+bfFnCcpXeY0E
 w9vqUufTw6IP/GI6xXKfMrehNwa3IxGcGtQRMf8jfR8Z3mXnIHmhqzQhkdhsEzMUetyn
 7lczUB1W68CwnHyd4CnVSroaLxPfpka998akJWZo8d4a4kp38zBZv9Fu0utDLANIKAcc
 3VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690128; x=1730294928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=b8z8z13E0Yl9ytkevry/nkI1ICOflMMZ/CoMt/J6E7EcV2V3Sl+5nnjsQF6gL3TiK7
 yFCd2dTCKbVg+Z8td80NDGl5VtuwP7us69VV0qiratip98Sb+mdlS9o5JuUmah9Lli7E
 IoquC5pB1PHjqRBghCvidF5KCDkvbPsiN53/qtURqFiwy32w+ksZfMIfPuitxrhwbPA5
 MlJ6ES7owZH6cA30Of6WrGmbRoTuT+pjIEEnLMk+k0SUAu0Bm+4rClOneydumsAHu6T6
 YEC7AuihupJl636pF+jyfQHSWnBTyzORsBEWRg+zEp3BfEXYco7GlaHuCaAmj/93sAcN
 2giw==
X-Gm-Message-State: AOJu0Yx+SEMz1XykgiSIA0OGpDWURpFHN5MWAapwxXUCWy2/iV3eGWwd
 VrIX9U8rtJODaNzNrpwtYEVVk90rTTEtEK3VXYwBE5witfKHnn+3xzPLzgmfTdU5N1o9zsJT04R
 8
X-Google-Smtp-Source: AGHT+IFuLr34PE6WSrF8L/dnP9soiohDUrKgqx8TYQU7VqaJj9fZ7qol/EwlqHV/xvXUq9rHjJqR7A==
X-Received: by 2002:a5d:4e8e:0:b0:371:8eb3:603a with SMTP id
 ffacd0b85a97d-37efcf2dcd7mr1668761f8f.27.1729690127786; 
 Wed, 23 Oct 2024 06:28:47 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:47 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 10/37] acpi: Add ACPITAB for PPTT and GTDT
Date: Wed, 23 Oct 2024 15:19:53 +0200
Message-ID: <20241023132116.970117-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

