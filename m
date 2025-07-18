Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A8CC83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274B6836BE;
	Fri, 18 Jul 2025 16:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i9fjN2MR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7991836B4; Fri, 18 Jul 2025 16:16:56 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75974835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ab644b8dc1so22542151cf.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848213; x=1753453013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8u4BlrqMLJf/f5/wEcAL9DYvdP6nERV08kGu7lVRSu0=;
 b=i9fjN2MRCewHGDIASKODsk5SIKBkEZX5EWd69dljNyYvzIeB7llR+IPZFGNZVc8pHq
 Jjr7K+99IaFQ232cbQdht9b7xIWqVCjxQOBLBXo1OTXCZ1+SqTOsZ+wzWv57JTatFlAA
 f+5fp5xyVav6tsR4JhWxamGsdpfmnE6MiIDhps4yVHKU3fbSKKUTJo+1n+CINg+uLyxm
 q5LziU0R7HahiXEozUtWotxxe5mt86szsCq4NcbV3bw3PFx/vQQFWAeTuE1RhOHcHubK
 giF6MIxVBbTo+vkdVxifgtdI/EtVuYi8zNUENk6Do9/KxAPPqrg+qZ6VP6vY8NDG1ZM1
 PijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848213; x=1753453013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8u4BlrqMLJf/f5/wEcAL9DYvdP6nERV08kGu7lVRSu0=;
 b=Q88U+I+NPinBu3mj25A5ZeIBD5jRY7ufQNhok55gN+Sy5p16VKCOlrJXFzDGNPid3C
 qxuHvzddPwIVDXDr9IYarLJmG+A9gKuOUN+SZ9G32fdA48uZiCpOhsLkm9M60rDQp/Rf
 ZAmlLy0VjRDdCNtbpnQ1xZvZRmA8FWVX2PZR+4wsw12QSTwyL45c8xrddycsqPw9pQ3o
 l9PH6JaQiYc4K8xL+SxQNOssAQmqYESSAokpplWRpaSq4LbOylDQP2qP5XBDihTidyPN
 AdRXHhnXCjKjuSPG4mdmTNbSL+RuMvwLqqZ7C3OnS4y+Znh1Gwyievkkk2TokNZzdAkC
 kXSA==
X-Gm-Message-State: AOJu0YxMzUBgZ4DufNiAnRhRt+uGMxi/Y2Btj//TQIoKz36ss1OkUJmJ
 Qq+NZwmfveNr7DAAIqEy2YSRqVsqOVgRVIo7Y9AzLerZYzthklS8cTj6S5TZoSDIsfMmUshV8QE
 DPnR+
X-Gm-Gg: ASbGncvZfHkhnfg8kdXxdTgXmmSdu2TwMijRBAuU8h9Czk0qv48Ua06Jh2gs1CTpPP6
 TU0i62uC8imkwS5lhT2eM5ikKb4WmVt/VinPihxH0foqT8y+ZcoZ9DlE6Y2oDcGpjT29owICdhu
 fzUm0H4vow34P2tQr3LhC7rRPgfXrKSGMH/GaOVpGXQ5UNj6oecGApWo4p++2FuNX8b0+Fm56Pb
 4AtV7IzKuQ2iBGl1ctLJcDIqgpXo2aEoEv1GfVtIMFmq9GBCmxTi3+FAS6Zc9h0wr3LCjukPAgs
 cXFrzW4UeSZz/DZV7fRDOn8aXEKtAzkx96taOdVdvfPFl7qMlJs9pTAEE4BoU8wMn2TDyJYxFyv
 a88HaL41d/5b/jTB+iT0DUkenIC59thBPJnCOUwuGxepNiZlxlHeQEOUsnHwEmjk5uLsvm9JGrQ
 2mBUmjiqE=
X-Google-Smtp-Source: AGHT+IFJNaa50kz8NwePhqe7XVd6xzyXHynWj/t81V1yL8F/oQUQqsTegGxwvoJ/gCtRcW7MtNR5Tg==
X-Received: by 2002:a05:622a:93:b0:4a9:ace0:b24e with SMTP id
 d75a77b69052e-4ab93dbe35emr154867781cf.37.1752848212760; 
 Fri, 18 Jul 2025 07:16:52 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/6] bloblist: add API for applying blobs with specified tag
Date: Fri, 18 Jul 2025 07:16:17 -0700
Message-Id: <20250718141621.3147633-5-raymond.mao@linaro.org>
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

Add an API to search for the blobs with specified tag and use the
hook function to apply the blob data.
Add a helper function to return the inline header size as according
to recent spec[1] updates, the actual data can be following an inline
header instead of following the TE header immediately.

[1] Firmware Handoff spec:
https://github.com/FirmwareHandoff/firmware_handoff

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Add inline header into the blob payload.
- Add arg 'size' to 'bloblist_apply_blobs()' for more general purpose.
Changes in v3:
- Add including errno.h.

 common/bloblist.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 include/bloblist.h | 21 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 550c0c78ffc..2b5026e00da 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -235,6 +235,19 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
 	return 0;
 }
 
+static int bloblist_get_blob_data_offset(uint tag)
+{
+	switch (tag) {
+	case BLOBLISTT_FDT_OVERLAY:
+		return sizeof(struct dto_blob_hdr);
+	/*
+	 * return the data offset if it is not following the blob
+	 * header immediately.
+	 */
+	}
+	return 0;
+}
+
 void *bloblist_find(uint tag, int size)
 {
 	void *blob = NULL;
@@ -261,6 +274,44 @@ void *bloblist_get_blob(uint tag, int *sizep)
 	return (void *)rec + rec_hdr_size(rec);
 }
 
+int bloblist_apply_blobs(uint tag, int (*func)(void **data, int size))
+{
+	struct bloblist_hdr *hdr = gd->bloblist;
+	struct bloblist_rec *rec;
+
+	if (!func || !hdr)
+		return -ENOENT;
+
+	foreach_rec(rec, hdr) {
+		/* Apply all blobs with the specified tag */
+		if (rec_tag(rec) == tag) {
+			int ret;
+			int tag = rec_tag(rec);
+			void *blob = (void *)rec + rec_hdr_size(rec);
+			int dat_off = bloblist_get_blob_data_offset(tag);
+
+			blob += dat_off;
+			ret = func(&blob, rec->size - dat_off);
+			if (ret) {
+				log_err("Failed to apply blob with tag %d\n",
+					tag);
+				return ret;
+			}
+
+			rec = rec_from_blob(blob - dat_off);
+			if (rec <= 0) {
+				log_err("Blob corrupted\n");
+				return -ENOENT;
+			}
+
+			/* Mark applied blob record as void */
+			void_blob(rec);
+		}
+	}
+
+	return 0;
+}
+
 void *bloblist_add(uint tag, int size, int align_log2)
 {
 	struct bloblist_rec *rec;
diff --git a/include/bloblist.h b/include/bloblist.h
index c2d3065a43c..e67b2a76358 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -73,6 +73,7 @@
 #define __BLOBLIST_H
 
 #include <mapmem.h>
+#include <linux/errno.h>
 
 enum {
 	BLOBLIST_VERSION	= 1,
@@ -279,6 +280,26 @@ static inline void *bloblist_get_blob(uint tag, int *sizep)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+/**
+ * bloblist_apply_blobs() - Apply the data of blobs by tag
+ *
+ * Scan the bloblist, find the blobs with the matching tag and apply the data
+ * of blobs
+ *
+ * @tag:	Tag to search for (enum bloblist_tag_t)
+ * @func:	Function to apply the data of blobs
+ * Return: 0 if OK, otherwise error.
+ */
+int bloblist_apply_blobs(uint tag, int (*func)(void **data, int size));
+#else
+static inline int bloblist_apply_blobs(uint tag,
+				       int (*func)(void **data, int size))
+{
+	return -EPERM;
+}
+#endif
+
 /**
  * bloblist_find() - Find a blob
  *
-- 
2.25.1

