Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DF6C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 08:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CB48091A;
	Sun, 16 Mar 2025 09:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="SBqNyQM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF858082A; Sun, 16 Mar 2025 09:33:20 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086AB803DF
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 09:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso4922486a12.1
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742113997; x=1742718797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJc/DVWU6/3/EPLschV7xKinZ5CWYydw8aI37pRXd2U=;
 b=SBqNyQM3vy8BrMLFz6vqB0ujVqwchUjLe7dGyb1EIqF9DZlcm2NF5MH8kULfQZFq8X
 qYv4EjSx25kFzM2M2oNZUCsLQ9IYHyhQjXvAIB7rs0JRU3qccvcrbuuuTgm2rzaK8+Oi
 P6cC8sKo9nhNRWC7c9V2vDiEENhEbtlg5dpAo8+PxwtKRvE2jGTHmyii18lC57gEZMmy
 9FrZU/HJyjjxM24Y5W57qkqmB6bmySeOLdl8Sg5MGD0o5uHcQtzCAlFv//YBSrv395wc
 XQxODrvnMfuJx3CAnxlXvZSn3dNjgX3olpCEChHHHmtR7mG1Ioc9nx/onpOBEoR6OQqJ
 Z9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742113997; x=1742718797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJc/DVWU6/3/EPLschV7xKinZ5CWYydw8aI37pRXd2U=;
 b=Lrh5bKsRB2xtYq+imQD5NSFgO1cfc0UrvfetKnpzXWCzrNfhRDxQOJjQ5oMyNJ6YM4
 /A4kIAXQLJ4I1eFvcd3ZTcibNJU0UUAyOrI4A+BnuTEM9S0Wk9+BCNXHw3nWYmjJ1BjC
 CQcTnK7c7MQw6SnW7/6AAtJ6noqvJfDzlgiqpKzPM4fpGpt17+i1JidTdoPZkjNHMTXP
 CJ4jOe3pXv9Pw3AzRzzBpwIdroG9XyAc5TjjChZC/9iYMDHE9AmePNs6HOrfN1RDMh4F
 Te9PdGpDDadc+wmlp8KxlS6uyn1gkmUgDETjMyyfllfoFtOylMcOJKfCAFRTjBcgBtNe
 7isw==
X-Gm-Message-State: AOJu0YxkOa07yBCiWqMcv1qcsTZ2eZFH7nIAfUSSyEAMQV7ZaXxbiV7A
 qeuwGXSrki7A3E2o+9j13l/e7c3ydLt1MWYW5juIehk/amCyy3Jft4GooSU24ok=
X-Gm-Gg: ASbGnctSFBQtyy4ElT7PADJRfexz7KwH3IGET7tKPaTYur4ERhu9Dw59qSfktM81fSK
 n60349yLPSJbY8BYSuWtC8LfuF505ugZynQaf6as+B6zQQlLEGJl+Y93h3GLAIBVJscCdLY7mzn
 URuBGkEUCCMrsiXKGEJM7FvdvOZrRBiJ+942GaVxwxlAwOuCsg0fv/yZQLcXbFrbtcPJ4Q4jQ5o
 ckUqkYmKYkqKue3DFs4zBc0JID///4YlYy7VJf2zOJ29PH66c1IrY4EGhJ46yICtbz4HSjAhr4e
 jY11K1I6fhFmIkgXM44NEHgoZ6N9lKMEhzvUKEHi9XUWG4q/ZMN9wBZ8OhbA/X3CradoPyMpRMQ
 K+4SRuAMY2WywXbmUHhTxZwCqermBKEcNdNUVNXPalWs=
X-Google-Smtp-Source: AGHT+IEh344n0NVAjUcv786QkLQ0V04BoJShkuwM0NSOIiuc+awiTH4YpveV5f11RVrweyjucTP0Jw==
X-Received: by 2002:a05:6402:27d2:b0:5e7:5b30:3c4f with SMTP id
 4fb4d7f45d1cf-5e89fa2ee3dmr7282167a12.14.1742113997143; 
 Sun, 16 Mar 2025 01:33:17 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad38f3sm4335232a12.63.2025.03.16.01.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 01:33:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/5] acpi_table: Fix IORT RC node
Date: Sun, 16 Mar 2025 09:32:52 +0100
Message-ID: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
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

Even though the RC node has the correct size and the ID mappings
are written to the end of the node, the ID 'mapping offset' and
'mapping count' are not written in the IORT RC node header, thus it
looks like that the RC node has no ID mappings.
The Linux kernel doesn't complain about the invalid IORT RC node,
even though the spec says that each RC node must have an ID mapping.
The kernel will fail to use MSI IRQs and fall back to a legacy IRQ
mechanism that's not working either.
Finally it will show strange behaviour around PCI interrupts, making it
hard to trace back to an invalid IORT RC nodes.

Add the missing ID mapping count and mapping offset.

TEST: Fixes IRQ usage of PCI devices on qemu/sbsa-ref.
Fixes: bf5d37662da5 "acpi: acpi_table: Add IORT support"

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index c0ed24984af..0e0a7cc498f 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -646,6 +646,8 @@ int acpi_iort_add_rc(struct acpi_ctx *ctx,
 
 	node->type = ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
 	node->revision = 2;
+	node->mapping_count = num_mappings;
+	node->mapping_offset = sizeof(struct acpi_iort_node) + sizeof(struct acpi_iort_rc);
 
 	node->length = sizeof(struct acpi_iort_node);
 	node->length += sizeof(struct acpi_iort_rc);
-- 
2.48.1

