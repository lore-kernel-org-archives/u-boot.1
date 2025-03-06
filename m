Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975EEC28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8324681E1F;
	Thu,  6 Mar 2025 17:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EPMeHk3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CFE81E18; Thu,  6 Mar 2025 17:06:24 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4196B805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-855fc51bdfcso65229839f.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277180; x=1741881980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpCseeffol6lsasERzt05JBB2EGhLIKJkSpiJ+MSXyM=;
 b=EPMeHk3TtBkRhp9lBhyKZC9AIUnzV6OW4M9nQK7FCAEOQbh3iFTCv2KISfWvzyVoc8
 13UBhCDgPtKvZYHkNHBFwsC/8lYcfBFIi11jOBaNfgxqOXhgIRvOTAmdSsZi7G+fQ9sS
 HbddNvS5IaKJo6DIMD4YJU4mmYez2k4O4L3r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277180; x=1741881980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpCseeffol6lsasERzt05JBB2EGhLIKJkSpiJ+MSXyM=;
 b=elv0Cm9VPHWs5+GHDSJKuFsgAgKEPnjcm3jXglxwlczL/hleIr0uEzY1UgMWIMGUXO
 aE00gCMDIlagwl6osviFq3XMclnFsLbJfAXDWef44LvYYm0xZ5nlr1qCiYgIsNpCPXNx
 mnCFmdaBoiHl27JeoSCCqgNTZ4XL5ugTGdpbH/L0qaU0T6vlxtMhiK8CdlwVdli1S6N8
 cX1yp9fCJqAa7/kNRdPZmgzMkeq52h3m0WVuKAeGUoa4+wM033pZ715yhjWpFReVi3vq
 smlcTCwiEQMHvjHTHrBj1UkL1jE8q5H+NJicyGAQyereNp+xxhHB53bPIuJYCm1Ou+Eb
 a5/w==
X-Gm-Message-State: AOJu0Yw0YuL6srC+dM2Slnxq+IlIdgj2Fqv/neCmZHQ1odx5CVxVqWbE
 5/pAYsS5PK3+5tWHPD37wXakEHf8J8+8Y6wH4N1Oi5HJpjh41zBSt1fB5Q2eGZTbBhQZKiydz3c
 =
X-Gm-Gg: ASbGncspr7rjBdxvLnokl2XPVrI2eDqisGNdE43fBXkRfWXK38mcU9sUsIdbRxCAnCc
 YYAkIMhsWHZ4X5s9AtjqK6AaQk/kBam3VKkgIwyQb8L+vhYHMYmuCKD1issuLYFEz4uNMLiw7QH
 pJmYI0BiWDxHCLtJaaXrRAgaG3MPkimPg+kpFygFsRLRf6dvtQ8cUJqHWA0+girA5HoJel8l2MC
 dBJ50S5dmBMC/WmH2+Q39K9X7E0FMruIR42Yk6V569w4bQhSbEH2LeRyn8Fn+GgZRSlxL1ax7ZY
 BW541Ddvccl5XVg5zLHQQGdCaHl+AXiAQ+hq0bfjCRKeiFpT7K8LSNJkpV13rgFn30Her4sgNhZ
 ABt0cnA==
X-Google-Smtp-Source: AGHT+IG4ouWq+jneQA1lVbGbNdQTPugMV2R++CtBEbaZ+DMLo9vzfg258Ns8oKwonQ0PKHa+RWVldg==
X-Received: by 2002:a05:6e02:16ca:b0:3d4:2acc:81fa with SMTP id
 e9e14a558f8ab-3d44189e3e8mr622315ab.2.1741277180225; 
 Thu, 06 Mar 2025 08:06:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 43/47] acpi: Add a checksum to the DMAR table
Date: Thu,  6 Mar 2025 09:04:10 -0700
Message-ID: <20250306160428.3041057-44-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

This table lacks a correct checksum at present, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to add a checksum to the DMAR table

 lib/acpi/acpi_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 3805b61159e..4044a64d688 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -66,6 +66,7 @@ int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags)
 
 	dmar->host_address_width = info.address_width - 1;
 	dmar->flags = flags;
+	header->checksum = table_compute_checksum(dmar, header->length);
 
 	return 0;
 }
-- 
2.43.0

