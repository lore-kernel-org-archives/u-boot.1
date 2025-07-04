Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5794C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7D58277D;
	Fri,  4 Jul 2025 15:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AT9l5RuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D67806D8; Fri,  4 Jul 2025 15:42:38 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5688782F49
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a58ebece05so11652931cf.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636555; x=1752241355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njXbcVpc7FEX0Rt1gI9cb5rJsbse8LKB2g5GdKKlhZQ=;
 b=AT9l5RuY1ZeOY6yB6IDTl6TcOsJC8IUqoUwTp5ayy6SDH0LJcq+VjD5x9J/AaG9G0B
 +qyNBexOVA/HpjRMzyGDWdLuTV6acS695tRo+3vkff1rRxpVwe1uvMO9QXZkVvoGlJAz
 czHjZ8AIqrNfDTPxPxXqReJRgT956/j8frXTyE2eDlJdpTpGJvWP+sLgVuVIhkhzGmi7
 VRbE2SeNND/HOE6L8+hj6eTTJCJgxkmrzA3+CHFFLzx8ff6AW8PHvTLNRMOGwbG6bnFX
 7PTHA4M4KoHd53tz7ga71CD/Ih4I6+cJupHvervxS7LDA0oV5aOw6xcvjPBNNpzk0rD9
 DM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636555; x=1752241355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njXbcVpc7FEX0Rt1gI9cb5rJsbse8LKB2g5GdKKlhZQ=;
 b=nbbUI5432LrO5skWHX89RuWpxOOJDDy7FUwSKFpETbUhfxqnXj/JBjmlO3EZP9+3uq
 u9Jdw8/dgn9greEgDTxMcNkOJBGWfGenQmWo9HKJ5SdD4VlHQNhD86WqYyZ0OlLrJKbK
 8tyrnoP4WCfJ4F2fsmL+T3ZQWTO8dNcKPEoGgQsCH6vALhYW6FgSzUH+kWZ9cQKSQG0z
 oJpRJlSO7YXX6Xn3+Gw82tLGmJY7Uxr+QlevpEBGQ8xBY8vdSd+3cYx1z2PzeAc4S8Bu
 nolTPgfNYCNu4SqzLFxuKKD4B3wHezWPj04PYpEb2XkgkxPg4v/dQFvnrsjcqtOOdwi5
 CvMg==
X-Gm-Message-State: AOJu0YxUnByA5+hn+bQnbqqcZvaTygNQvoeON0sb9fUGdF5IY7b+YsRw
 iTmM57bhKslNLs3BjNJFyVmHEaqtIurpwGd5pA7z1pKq1XCa8QoHPXtB5JK13VhNErZu6V1p9ow
 NmEK8
X-Gm-Gg: ASbGncuTBeRJh4kthjoqPwhzepKez5vYKoEk3wDw/pP73+YWHy8HM6d5wdZQ/hbeZ6t
 vySKBxXbyeD5ARC7jpgieocvAJFUFbsSA5rBdnWSwsgVXhZ8epzeCmX0l9nGI1nPOUNeZS7tkYR
 KBI6yShVyUUyFS7sl/CcYRVy3iM2RszNTWaEhsppCwjzBSgP87gAW+QtG8wcarcO9U8I/zgRGCU
 rzzv8gHcA757W0IwK94RdRTPhzyE1fS87882zhClUdOn8WA/noFL1nxKIkg23N/cNKo5ETx1CYG
 PUQCOkywvvf4DNVSi4GJTRJHDzKkCIgjr8xO01/S7D820lVWEWRawUy6f9X2uj0ibIJ0W9qP8h3
 KyDGDPJnravHc+ay2UKMHdTUB1ak60T6l8D/FdHGQBzgx4lM=
X-Google-Smtp-Source: AGHT+IFi/ni5DISaOvrJq7AQ4KZCVPQNJwE0MDR7LtVDG5/Ue25CgntPAS+HsEN8jxv2FN984TnLMQ==
X-Received: by 2002:a05:622a:548c:b0:476:9847:7c6e with SMTP id
 d75a77b69052e-4a9964816ebmr39998971cf.19.1751636554794; 
 Fri, 04 Jul 2025 06:42:34 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:34 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 1/6] bloblist: add blob type for DT overlay
Date: Fri,  4 Jul 2025 06:42:00 -0700
Message-Id: <20250704134208.2895595-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704134208.2895595-1-raymond.mao@linaro.org>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
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

Add blob type for DT overlay according to the update of Firmware
Handoff spec[1].
Add an inline header to represent the 'subtype' in a DT overlay
blob payload.

[1] Add Transfer Entry for Devicetree Overlay
https://github.com/FirmwareHandoff/firmware_handoff/pull/74

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Add inline header for 'subtype'.

 common/bloblist.c  |  1 +
 include/bloblist.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..1c690f58b56 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -43,6 +43,7 @@ static struct tag_name {
 	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
 	{ BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
 	{ BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address" },
+	{ BLOBLISTT_FDT_OVERLAY, "DT overlay" },
 
 	/* BLOBLISTT_AREA_FIRMWARE */
 	{ BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..c2d3065a43c 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -110,7 +110,8 @@ enum bloblist_tag_t {
 	BLOBLISTT_ACPI_TABLES = 4,
 	BLOBLISTT_TPM_EVLOG = 5,
 	BLOBLISTT_TPM_CRB_BASE = 6,
-	BLOBLISTT_ACPI_PP = 7,
+	BLOBLISTT_FDT_OVERLAY = 7,
+	BLOBLISTT_ACPI_PP = 8,
 
 	/* Standard area to allocate blobs used across firmware components */
 	BLOBLISTT_AREA_FIRMWARE = 0x10,
@@ -231,6 +232,16 @@ enum {
 	BLOBLIST_REC_HDR_SIZE		= sizeof(struct bloblist_rec),
 };
 
+/*
+ * struct dto_blob_hdr - Blob inline header for BLOBLISTT_FDT_OVERLAY
+ *
+ * @subtype: IMP-DEF per the agreement between the DT overlay producer and
+ *	consumer. Default value is 0.
+ */
+struct dto_blob_hdr {
+	u64 subtype;
+};
+
 /**
  * bloblist_check_magic() - return a bloblist if the magic matches
  *
-- 
2.25.1

