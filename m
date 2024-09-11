Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FD6EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C64C89167;
	Wed, 11 Sep 2024 08:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="V21VmkjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC3E89196; Wed, 11 Sep 2024 08:25:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F006F8919C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso1924184a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035935; x=1726640735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbJG1DoLhNXNV4NWNxXb6wO/wf96cLrEIRFD4xykswQ=;
 b=V21VmkjHnV6tsm1WEJwG72FN9NX7y804oaFFhjD3JYY25Oaq90zw3VXvFJD1J+JhLi
 2ItxXxO3kSYq1MmeeovHQ1KIScDsODiOjg9kMWbyHcNyGo2J93I+yIlwUEFiAAW5q6m5
 FB/eu7csaNlYOqgAHzr9J9EkqkV7GA6eWj6fVxFfrKdjtYvtzzmUyF7X/Lfxoq/lmreS
 Cr1rJsjjnPwXleGQcE+kbK8h/WId3o0NT8Bb11585RLcRq8I96XFJNQlGlRKuOle46QI
 a3I+XsDYQeISL2QK8GsIJL2J/gtQ5vd2kkEmNMaXREvGvyyLQbrB6mZUL2/4WNuoXFzf
 xJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035935; x=1726640735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbJG1DoLhNXNV4NWNxXb6wO/wf96cLrEIRFD4xykswQ=;
 b=O8jNuvZKG72hJgiYDDxKMqejt8KGGpIw5RmWjMOSnUD7vJekAqHbZW7Y71PzSmO1rJ
 dxgeOrmUHTwYapFUlOS+HDiPRxhcXUGTQ/YU3uaITa2duu0r/lxouiGQAfDgYHuV9m0c
 nUH4JNg1ZkYNc1U7C9ONR+otMJQTRdMj8VrwYa3hUIt3iXdjW9icm6uJwWdYyMSTtAF2
 yWycK61lsJh42EPLQOCEChuLVCuPc3hJxgULsk34UsLnvZCT8TYcWC7/nmsSDuV+5vMf
 lT/+WSgBjqQpDAZCirwS2WuJSrryDoZF8n++D2BI1u2QLdswcUxmGVmb+NmibgqU+XzY
 Ek+A==
X-Gm-Message-State: AOJu0YzL36e2uGymcqxBUU1JYch2QS3uBdy2cpyPCXHzB6NH09tXKRE3
 dRQJA8yFRQl/P0onHMRceqMefaxhNcBNMCSS2Pg0iHNq+o30GZJiPmfmmoRxoCDZVtocXZE5Duf
 P
X-Google-Smtp-Source: AGHT+IEoPTnZDxJt8JLGneM/77baByMJfU5NfgC9vpYFnFB9YAMup8eFbo84yXfjYkKZ0DqKVjD/hw==
X-Received: by 2002:a17:906:d542:b0:a86:a73e:7ec9 with SMTP id
 a640c23a62f3a-a9004a66525mr189440466b.46.1726035935425; 
 Tue, 10 Sep 2024 23:25:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/30] acpi: Add ACPITAB for PPTT and GTDT
Date: Wed, 11 Sep 2024 08:24:00 +0200
Message-ID: <20240911062511.494855-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
index 6d8bb7eb96..19ca6276d0 100644
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
index 6fabe87cb4..bc236e4ca2 100644
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

