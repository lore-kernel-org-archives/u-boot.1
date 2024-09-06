Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DB3CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB11088D16;
	Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="hF4AEhxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A6C88D66; Fri,  6 Sep 2024 09:22:48 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969CE88D3E
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso158257966b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607365; x=1726212165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGKngXc1fjM6PFizA+1uj6wsn2+EagGjX2fpaiKk5Gw=;
 b=hF4AEhxfDlPWnWo1VX3AQ0ExzY8BYOkR6ihSr/eaA5pDtY3yefN6B5F4dcd4jGD7kX
 r9zgvoKhO9adebL7Twc0dsdBXDPaLM86xLlDmp3nPDiwAccWvkR1tudjJ5yXQSCBcFOA
 8+2ZY1dAtR/FwXL0MwjMpagqNhU96o+Qj4zwOrCBadJ8Kgb9nbdn3ODeQq2GsDss8o1c
 34hVDMueH7Y5qhJhbraAGtfgpQFyJOVK8wL+uPSstPcxNTQz0NMH6jatb41jEbr/u+fI
 dXJSN9eJ0bc3ay7YEhZI5TJwU2KU4Q+XnatAi/H/F1f0ZxGhkf5WMaOlObJEMflWac+4
 p+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607365; x=1726212165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGKngXc1fjM6PFizA+1uj6wsn2+EagGjX2fpaiKk5Gw=;
 b=b6z1fUhtNONfq7x5bRE3elurxwuzf3Uai853zvvZmz1jF7g/SGV5MG8/gmiAZYtqrY
 AvbhDjWeHi97TfGzho1WvCXO0xfUzemOfxA0Be6g+8wPX8/Qk6on0WJC79i16opmEGHt
 +jtc+YwkwmgjZgKrIORGFF72nBO9tcnyDnbYYdPnjvtcJuEhPvYepD9PJtzaFsm6McLH
 NrGWKtkLOKC+81GzgCrJZsMpEIy6eaQyHYV0RnzyfuaHBPE1VknUPjbqrVtpkPW38xLU
 ZZLX2oZ5EcEhc012ZkncEc7Q6eivCrQumiKIhKBycgf2I88K+Wsrt8mHPtpKKBUoLG+b
 /Fww==
X-Gm-Message-State: AOJu0YzffW9XIbj6bSS7EEpEtvRrTALzRWFgHQlhXKdYMBBzZamxpTCn
 hh1q4TqNEHrnXBOHEdGYzgPiN6NrgHNN6lhChkfXMUw9lci1BqfH86oKMyTAwOSC+D1sH3D8IYD
 G
X-Google-Smtp-Source: AGHT+IHxfBc6aCMIQSZPdAQWfS1vFjfiUuIcBT+iO1e1rnvxLvO55S30LojUA9oTdUs7wosNR09cQw==
X-Received: by 2002:a17:907:3e9e:b0:a8a:7501:de39 with SMTP id
 a640c23a62f3a-a8a885be40emr135803866b.9.1725607365013; 
 Fri, 06 Sep 2024 00:22:45 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:44 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 10/28] acpi: Add ACPITAB for PPTT and GTDT
Date: Fri,  6 Sep 2024 09:22:12 +0200
Message-ID: <20240906072231.2531491-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
index bbe3c99a56..a270fcba1b 100644
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
index fbbf56a5af..657214a532 100644
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
2.45.2

