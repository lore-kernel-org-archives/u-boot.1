Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AE6C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 08:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F382D81877;
	Sun, 16 Mar 2025 09:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="etRPbd5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691638186D; Sun, 16 Mar 2025 09:33:28 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6955781100
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 09:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so6599334a12.2
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742114006; x=1742718806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCNCvJQci4hlDMwBJiOKVLYJxK2nUHHlqpYHh2jegpw=;
 b=etRPbd5ZneR3v+2L8KyhUjIy3uM4P43AqqAIqB0Sq2WqLvyulrpML/F8u70I6k45G9
 sUb98Et80auYRCNseShGBbj6lTd0+vLhxNdJinPPTwW1DzZEZN9TnZNnUUQCgWXC9IiN
 dC+J//p+C2IebXsEtgL9hsBFVFjbVRck1/w9AygoF17pkhzqsSEH2s50BDxwKs5ySepK
 i657FAtDKXn3A9bfsnX4VlWE+WCttaWLRUv34nftzX8+8VyRSwPL7tA0anJBrnxXbYxk
 sYTypmI7H3k5PjMYnKu9ocPu0tc8bkqr7lJXx4CdZgZ9CLE8c6nmIjURGgTSsii9V7of
 cFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742114006; x=1742718806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCNCvJQci4hlDMwBJiOKVLYJxK2nUHHlqpYHh2jegpw=;
 b=X/WfFq7oAEvNFRcXNlTAOWac6zY6rJ28vAURVy2d75+Bihq6HpccAXNSY+8I9VL+n3
 AMRpvly86EEyofabmOeMRhSq4Zy2qBvB7zD4N23bSfJL7S3oLfJ3CiaWbaKIfuOpg6uY
 4ypo/3WP/LvnMoFd0rLjRBmj6IAW+SdUju+cBpnkC6ZC/OglvLpzxZAydPtEQ3qSOCkM
 0cIvo6jNykzl1Y5keVgLNSkhDadDHyeKgBoLjjTn9xSfB0NZ9jPjkYmXSkOWugk6F2VT
 r7WZS8pXjetH9NAeY3EcqcTY3cNcgRyofme0Nx2Xeij6cD2oT2E84IBGO4QjYDfP0ej1
 ZZ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMN+eKkGIu13gpB5ZiChnGYpEHMij5btsCDY4Z69GGdL1K5GpWaWjP03nPRGETxZUGO2ilaOk=@lists.denx.de
X-Gm-Message-State: AOJu0YziXJbYmPrpkIaD/9MEAa4wTKpWOJP0JArK0gVsyfpumtb8tAUV
 aC5jn8zJYUmzITdwn6Bq4P9lsddSA5nWX49WRVnNDQqKGg6ZBDeqqMj7SgpW2Zc=
X-Gm-Gg: ASbGncvUX5wiRjwkoaCLdWhJkiUFO0Cgg5CGzbSb7DmuI/Dlg9jKtcOYCQlpt6kHCul
 yP5pRvmfXeS977imxUtSCixFXTC8RWaYQLFtn+Y1jQJoepr3WNmf+K3jrynuXkbrIfbXbxqJJWj
 SOCAlVvty7aZpQTVfaOqxsmd2CtUVk7C/nA+hVwV15UzdTbC8rTZvtwnPwq8PQXdECxNGH1qIVM
 3TuOoOCPIGV2JUn5tIwjEaW4iOoUfRVEFOEJJtUeOtpqcDr8QRBouLbSvK1QEQC2Ut6kKs+7SIp
 17COz3rgUJxomLPSKY8ADUIVujj9oUz0/TAXtBOprEMKDxloSlzd8TNqsnG1tHuuae5eJLjs0xc
 vtafVbKimmgRGEK5sWZMHm//18l+wT6C6fYWYwwEpKlwzqfXAlou1Bg==
X-Google-Smtp-Source: AGHT+IGXdBvMYFvtzeMZPPGRxJo0RyIwX4Ufak9stZTCgW/+WILKQdVavqIQGX1DhAppUbJhOgxBuw==
X-Received: by 2002:a50:9b1c:0:b0:5e4:97bc:6577 with SMTP id
 4fb4d7f45d1cf-5e8a0c14598mr6442575a12.20.1742114005864; 
 Sun, 16 Mar 2025 01:33:25 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad38f3sm4335232a12.63.2025.03.16.01.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 01:33:24 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/5] acpi: Conditionally set mapping_offset in IORT
Date: Sun, 16 Mar 2025 09:32:55 +0100
Message-ID: <20250316083300.2692377-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
References: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
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

The spec recommends to set the mapping_offset only when there are
ID mappings as indicated by the mapping_count field.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index fc43862ec37..4ad1f56e961 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -649,7 +649,9 @@ int acpi_iort_add_rc(struct acpi_ctx *ctx,
 	node->type = ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
 	node->revision = 2;
 	node->mapping_count = num_mappings;
-	node->mapping_offset = sizeof(struct acpi_iort_node) + sizeof(struct acpi_iort_rc);
+	if (num_mappings)
+		node->mapping_offset = sizeof(struct acpi_iort_node) +
+				       sizeof(struct acpi_iort_rc);
 
 	node->length = sizeof(struct acpi_iort_node);
 	node->length += sizeof(struct acpi_iort_rc);
@@ -709,7 +711,9 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
 	node->type = ACPI_IORT_NODE_SMMU_V3;
 	node->revision = 5;
 	node->mapping_count = num_mappings;
-	node->mapping_offset = sizeof(struct acpi_iort_node) + sizeof(struct acpi_iort_smmu_v3);
+	if (num_mappings)
+		node->mapping_offset = sizeof(struct acpi_iort_node) +
+				       sizeof(struct acpi_iort_smmu_v3);
 
 	node->length = sizeof(struct acpi_iort_node);
 	node->length += sizeof(struct acpi_iort_smmu_v3);
-- 
2.48.1

