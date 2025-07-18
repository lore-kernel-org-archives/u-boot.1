Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F30CC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227938368E;
	Fri, 18 Jul 2025 16:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLX5fj0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B5183692; Fri, 18 Jul 2025 16:16:40 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98584835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73e64e87d49so1272945a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848195; x=1753452995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IC1W6nahJ+JFbZN6XmVSp/n+nKuL7YvvO5Oi+In2FVs=;
 b=iLX5fj0rg77QLLVjAykOQtFdqneezRmgs58KNFSCPMvd+akHRCwf6uUOrhZSZHjvuF
 20fT5q+9OgooLYTOffsde7iVc96jYbJUbc3WGDjiCpsL0kpWPyvq9yI6BYpnbzJ7M0ki
 xNwekG1mJ9n/yLRnkUQyTqoJ+IjO3OsNGCpKZe4xbDJIRakQn70IRB3fa5kHnI95MT3+
 0qCAFbVcK9IVdfqWULk4rrTdO1rqo6bQbKgM5BQN3MGIsdu69HtwdSOncOSO+6rlW0s6
 rO8JMeDkmIaaGPV42mPRTaMGtl/PkHx0p53fwCtfvB3wtxGpHYok1obklfG16VIwI8UX
 HRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848195; x=1753452995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC1W6nahJ+JFbZN6XmVSp/n+nKuL7YvvO5Oi+In2FVs=;
 b=MjneK1pbJ93cTeKxVQKeWUSmZnPzQw+ZfQp/KuRmLlVKxtvv1bsI+zpoBaZ6Qduhc8
 amWuVg9LJRLXnogCK+8yhUbgd9N1oOOGagHVcZGwK6VEjWmXLNvBbwvRdmohgJFw73Mj
 vMlCpKIT0qIrBHHLZsqltF0w24MG5QleGeshMO1tzftafYwyooSB5VVpABI3/13sNaA0
 HCIbExZScMMv29+L59QJSeWgI5BXLestmKO3iNvH/hoIwXc+RrfGrZ/yBbZ40u/Ng7HJ
 9y2WB+lfmCvWHfJeek4c7DTxznMqXNr5MUEmLBGGtIv+gBydaHAaV/8OtPth9ibzYjYr
 ep3A==
X-Gm-Message-State: AOJu0YxswXyzVvu2901bFpgh5Vl7LIn7u/0M1OByQNi3KuMPyb6xq4wv
 eb8sLEqPaReIyexZBsjnjG+3JaE3f9CHKJVKv7eJe8fjvyxr3IezsH7IZh2/fQAVc9J/wRFr5PR
 ndVn7
X-Gm-Gg: ASbGnctW5kELSXevYGBWlwljVQ9eeFoTQxgAD4I4v1JsIwe2pLb7Uv/mVFBNN15JpZy
 3pDmuZsynkXY7ybvgZpgugwCd68Mgz5cnXsv3/SWut/XZ4bNOrcB5sfDs7+L/IX2lWoHvtBtXZO
 Z6jtrIMuKd0b4VLc3/YzaGy6+ValOqlPN86ap22Wt5Y2RO1VRTdQdEvlQ5Ee7MDR8YJ+wAovRaR
 UdrClI25jwSeDJ8SSTsWYfA779WwI37xKXLOYrxFxJCNu7u/6Up8VM5fMsr00wTaNQRbXvE2Pnv
 a/WIhNsO728zZBiXVRqMOnlLqVXMQ5UjdSpUi7ZXS46Tqo2sOgSVLsJGUrCH/3qXiDqb9X2RePR
 4Ma9GDjbSYxL4ZzlsWAyYM28n655PoGFrLqUer+8s4py0tH0lwwh/v26MLyQLXu4BF0F19FyRBD
 dGpA5TMo4=
X-Google-Smtp-Source: AGHT+IFzX3IeMIi67VzpB//GqaLzTLpaS627XkAi3YxEqKV2Ctm+ZPL6oh2oEiF4Fn3fWuhNF2WNRg==
X-Received: by 2002:a05:6830:4d87:b0:735:27:2703 with SMTP id
 46e09a7af769-73e66625210mr9000417a34.26.1752848195541; 
 Fri, 18 Jul 2025 07:16:35 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:35 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/6] bloblist: add blob type for DT overlay
Date: Fri, 18 Jul 2025 07:16:14 -0700
Message-Id: <20250718141621.3147633-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
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
Changes in v3:
- None.

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

