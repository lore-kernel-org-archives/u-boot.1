Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DABCC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1C82F6F;
	Fri,  4 Jul 2025 15:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOhKxCkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6484C8206E; Fri,  4 Jul 2025 15:42:58 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E0882FD4
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7d219896edeso112475485a.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636574; x=1752241374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMfBwwPX0rT+oEQ6LnVE6xl0gmwCyxFiKot38JuBUVk=;
 b=vOhKxCkVXg5uQr/knwaFQFb5yM/Crfii29BIkESreqVItf0nBGckABc1ATNyYWLuDt
 Wl/D9VSsqWqjklW6j/N8/VARUYIzACVUR81w3WL1rfT8n9fKLdwlQ+ao9sQb9hPN/6uc
 TaSj9Og7TL9g4uvvYqQAAzM5fKTZF62NwS+yPjDVN5NxpLhL74Rj09/DO9/dAWK9nAHw
 DXQFnQeuuZeEhxjlWNz5RY53BhezEGsO9zuTCu2Rcl27TQkJlDVGqbDqlKUC0sOt1RLE
 uXIRE7NjMb2znMNWnbjnCV8vTC5TBtHO9YqgQw/M0qFphBZwSSiNkDypuC5f2WoY0/rU
 SSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636574; x=1752241374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMfBwwPX0rT+oEQ6LnVE6xl0gmwCyxFiKot38JuBUVk=;
 b=CJzDaNsbrJGxNru8YfHqIOba/yXGjYGf5sNwJEASrNSR3tY4pGmwV5iL8CmCGo4T0E
 9JICVnkhgMkPifTs4tgkSFtaS5BJeHYeKxsmHlyksxcznC2hIfMttdjIujJh2nhcsMQn
 IgFXJ6g883yZTKWdwE9QI/OErnN+QPWN8D40HnBUyyP1pZyggRTlFiSLVILmGbrwfLMd
 xjKFVjGxI1hSu775xzzULU8EhC3iuk3vKEc0ApCVIgAHO8MJkoCHSzOhnaBEc4cMkruG
 pVSkXKKi8oTWuJQrGdGlDdqSCqdE2s3LR5+GqRlkK87HhpkrOJP7qcDjjGlPysVKKEuf
 /OTg==
X-Gm-Message-State: AOJu0Yy0rwDWCC/VNVFCuCUK4HliOrsHJRwCeA9VHXpBOPWgRSJ3JkTy
 G+/3Vn367bQo1QxLHIaZ4G9RA8odq3KdEzapGUq2JGHjXZF6vdEVg9EIJkEVjO9WBWJ8Lss1hqq
 yjq54
X-Gm-Gg: ASbGncvwIdwH/L7Ar4vlj3wDJlV2I6O+7DMjmlnMA/pZFWt2tX+5idk9TvzzR/sFljZ
 n+cMxtUZH7RpJCbcrPqoslSX3ix6fNIFoXoDQVLDa03li0gRC8QtX/0Gr9vU5PCeEhakZuVv7eq
 orZMNX9kHDIRGwABs4LQLx0remaf4ibCVnhv2zINPvcH4es6ACbrc6CVFJSSlxTrG5XImq2sJS8
 2XwlaH1MUaJh03UEK/QhcO8TLgjys08Q3mS3HhTc09KHQ96wjq+OTAOLIusvbYkPEqE4CSZ48LS
 0zQx4M+5aRPQt3HYK//wwA0eWPIxa3E/AVMTeawvhi4nHCyfrv9ucy8ryaQxK7ctOrJARP5kfXa
 GK+U1bBGBcNQ+38Ge6XwFHmMj4o/fbwjWdwrMJXgMeJ9zeyQ=
X-Google-Smtp-Source: AGHT+IEEGzDmZQWe1gAJyomTtGSiPG02t23OTulloiWsuKZSn9VbPuVAOPPQAZG8Upat7ZyyN63tGw==
X-Received: by 2002:a05:620a:45a4:b0:7d4:2922:14a4 with SMTP id
 af79cd13be357-7d5ddb5943dmr386949785a.23.1751636574386; 
 Fri, 04 Jul 2025 06:42:54 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:53 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/6] bloblist: add API for applying blobs with specified tag
Date: Fri,  4 Jul 2025 06:42:04 -0700
Message-Id: <20250704134208.2895595-6-raymond.mao@linaro.org>
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

 common/bloblist.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 include/bloblist.h | 20 ++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index ae5273785eb..b944821d9f5 100644
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
index 213285bbec6..f88b2513ee8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -280,6 +280,26 @@ static inline void *bloblist_get_blob(uint tag, int *sizep)
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

