Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8CAC282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 08:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6A9810F4;
	Sun, 16 Mar 2025 09:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Ie691HXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B82810EB; Sun, 16 Mar 2025 09:33:22 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2630803DF
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 09:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so6599277a12.2
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742114000; x=1742718800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSSFptNOq4C9xC2Q+r7WqPng2PAPTfZ2Am41OVOgCmI=;
 b=Ie691HXTady9wzAv/7Te+9jgsUh22gYzVup/UOBWsUDtBSfpRJA+pqjQ+MvYCti54p
 mnr750QDH7T7ksF7WZqD6OkksQP2boenEh5nzNZwyYqBBaS1ZxhGatqgdtDT6T0SPWSS
 GMHLL4dXDamSXoLxlxca4olbesTkEvgccg5d/D/vTOa4yuRq78XGuFTw25eCXY7jq7Ql
 ArL+hqcw1T9x7QN+cEGplkUfLbb4F/b57hmgfcl4ZmifOyLnPrYioo3cYAgo1eYI4oPL
 mb4Rm9TWpXWN8MxOporKg+xkxirr9Rfl04aK+5CaFH7P3d3u9/OgUa76mGcyGUW7xydN
 EHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742114000; x=1742718800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSSFptNOq4C9xC2Q+r7WqPng2PAPTfZ2Am41OVOgCmI=;
 b=xITqm1O2jXURKyOPN9WT+3jYxVZcyHWSMTRmKWAWH5/8w6wcbKVrvED0oaATCDjWdp
 Y7Dw05oqdKLiKVI49bsnF1ka5PXJaHFVMYQGvF6uBFGWushMy1pdhRdUkPkWFURwKH4V
 GgzJejkQoDftPXB0YgY+UYPM1St8SrtIO4cXP8knJcETeWElelBkrIT82UHqmfrUgQZH
 nXOFYLf7hWWy6oWqa30M1+Pmm1yU5xg9s3L0XDke33rXhbRlIE+D6Pkh0/GFJnce/BSo
 Zb6boB5lvFZdToh4Too1LzOppavkhVLYV+JZ3L1ca1klRIc8GyBpcz3IFgl/k97hy33y
 jm7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAXQt8bCQqMFHwmeYzFhLdBpr4UtZogrORIUNbDi3r1oEvj9HGJvntOC247X6czA0WZuRvrMw=@lists.denx.de
X-Gm-Message-State: AOJu0YxmfB3KbGk3VQdf7CPHhNs7uI+B0RWx7P7P+7podsJlByymrBRZ
 q3+ol3VLf7KKfCUYfmu/WOoez+H4tdtqhbMQcbwaZvWt/830Gn7EDBUhHaHc1oE=
X-Gm-Gg: ASbGncvNvAsvsBWSZ9xZKnYz08Au19gEhZov4DIX3CYPs1l7k/FBkpIobUpkdYJJgEa
 /kz7f8ZH8/KLRc5dJPK8qhlr2cv+rMZ4PWx4+H/Ow07pjoelFuzr6b2Nr6S4CRZVfRhoOJcrFEX
 P75uuvJYWBFbk5cVGMsz60GDxaS9+iovYsCafYrjkAw1V3r/0AcCBbL5M/sUSLhd+fQH2KYq+Y8
 10XC5wBZwVJiq2lwgX1444lQBxQ4h66ooJPtVjIPWlbFpZiS5bgIpgNDUt8+iRq2nZSY+TF1PFV
 adNZUqQcIadwGMjaILldNql4/6OcnBw/JPpEKCT99ULRKU+L6M8OXJkfu5WmU2h4FRggqq2bu19
 O36+tLcrTnnVFvaMEae0j1ohDgmXmnob1TfuC05wsCUs=
X-Google-Smtp-Source: AGHT+IEfieGc+Eb3S52jfhLouEj7liBed+E/jMdC+CTn72mdE5V5cG2fR4cWU2BrWtBmdd7hB2pVlg==
X-Received: by 2002:a05:6402:270d:b0:5dc:1289:7f1c with SMTP id
 4fb4d7f45d1cf-5e8a13d68b7mr8301223a12.29.1742114000254; 
 Sun, 16 Mar 2025 01:33:20 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad38f3sm4335232a12.63.2025.03.16.01.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 01:33:19 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/5] acpi_table: Add asserts in IORT
Date: Sun, 16 Mar 2025 09:32:53 +0100
Message-ID: <20250316083300.2692377-2-patrick.rudolph@9elements.com>
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

Check that the provided offsets are really pointing to a node
that have been previously written and are of the correct type.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 0e0a7cc498f..97cd8e8ddb0 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -635,6 +635,7 @@ int acpi_iort_add_rc(struct acpi_ctx *ctx,
 		     const struct acpi_iort_id_mapping *map)
 {
 	struct acpi_iort_id_mapping *mapping;
+	struct acpi_iort_node *output_node;
 	struct acpi_iort_node *node;
 	struct acpi_iort_rc *rc;
 	int offset;
@@ -661,6 +662,13 @@ int acpi_iort_add_rc(struct acpi_ctx *ctx,
 
 	mapping = (struct acpi_iort_id_mapping *)(rc + 1);
 	for (int i = 0; i < num_mappings; i++) {
+		/* Validate input */
+		output_node = (struct acpi_iort_node *)ctx->tab_start + map[i].output_reference;
+		/* ID mappings can use SMMUs or ITS groups as output references */
+		assert(output_node && ((output_node->type == ACPI_IORT_NODE_ITS_GROUP) ||
+				       (output_node->type == ACPI_IORT_NODE_SMMU) ||
+				       (output_node->type == ACPI_IORT_NODE_SMMU_V3)));
+
 		memcpy(mapping, &map[i], sizeof(struct acpi_iort_id_mapping));
 		mapping++;
 	}
@@ -685,6 +693,7 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
 			  const struct acpi_iort_id_mapping *map)
 {
 	struct acpi_iort_node *node;
+	struct acpi_iort_node *output_node;
 	struct acpi_iort_smmu_v3 *smmu;
 	struct acpi_iort_id_mapping *mapping;
 	int offset;
@@ -718,6 +727,14 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
 
 	mapping = (struct acpi_iort_id_mapping *)(smmu + 1);
 	for (int i = 0; i < num_mappings; i++) {
+		/* Validate input */
+		output_node = (struct acpi_iort_node *)ctx->tab_start + map[i].output_reference;
+		/*
+		 * ID mappings of an SMMUv3 node can only have ITS group nodes
+		 * as output references.
+		 */
+		assert(output_node && output_node->type == ACPI_IORT_NODE_ITS_GROUP);
+
 		memcpy(mapping, &map[i], sizeof(struct acpi_iort_id_mapping));
 		mapping++;
 	}
-- 
2.48.1

