Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB415C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C39F82E35;
	Wed, 18 Jun 2025 17:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gx8lLUsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA96A82D7C; Wed, 18 Jun 2025 17:00:06 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED14482CBB
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 17:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6facc3b9559so101821966d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258800; x=1750863600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=briuixwVudTtQ9NI/PMJlBfI4rPpAfj/3S34H3Q193A=;
 b=Gx8lLUsq/KgPnF/i+TUO5Be2dVpWQxQQc6x/8u2WXPqoTCfSUGGdh6Z1arzTqJN5R1
 /SWUfo6m7gcP6umI6d2IphpMM1OgTcwVcix3gErzqrDYcxrKHX97aPn/9XfcOumYBONk
 xPRjbLlpx17FNEQnsekB3kRgbYFNl9b56mswNqCJNShXiCKqECSYKGKVRUZhpx6a2020
 Q+wwaeLNmWwFaEjjjcg84ouLWw5pwlDeCBoBi+PVhE5qJw0IeegVYhBnTBBnuNM1M96z
 kX8/tvD9XgndoMuPU5FdSrpOqFl/legiQdR10F5Zz/qWKHfjoYc+WKjl3UkWxM9MkbZT
 X7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258800; x=1750863600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=briuixwVudTtQ9NI/PMJlBfI4rPpAfj/3S34H3Q193A=;
 b=aPx0Y+2CngYB/ixDYxc9ZMIp5cFKAn3lEA/nrjM9D8XBTEaehoSYurqKTAAGIwakNQ
 tM5qo3NUbrVq0XSJE70wWRLs0sNe28WI+97XTZ76ep0LU7905/uErXRzSC2WO3gU8SW8
 5qBjWwhuLogPoYZyTNz14N6iHVM8iyenctJLtYQSeBH19AQrwkTKXcGdHLf+3Lq5P4zt
 MEMStYP1SZ/mpJ7ieLJT2zwB16DCMAoJ0Eb9gQw6i+jIwbedi/annu/9SY0VrRf+W35Y
 NgZjaCe3Y9aDG8ZLxTtrcQwe0uM/XSFWA0BbemO+QT6d8DPx7CghflvmV3wMX+qtLyqf
 uRsw==
X-Gm-Message-State: AOJu0YxSKkEloSip/hxBcCDkbUt7D+aOgYqU6H4bmrVlb2GmFN2jhesa
 h4RkwDAPY6CTl7cwiA0SpbmIsMCNwzY8dBcj2a8nCyxYi0hyErC7MXjEx0VNzTk8vyE1WyZGcn5
 nTgEg
X-Gm-Gg: ASbGncsNyPAB+P7V4ZRO0d38QoP4WxCgGCKPadmrnTDC8jRxNScs7/TVytGsAFLer40
 +lVoxdjO0nl18FaWY83H7jQXHNW0cdki980IHO96gX/9GF+SJFSXZxfjaXZeg9hPde5QuzR3Hlk
 spZFSZ1KJUUDiYGqW+BywTRkqVeHppBuRD8WyhWduv8OUD2oFjzgG3fTdMCRIuvpzAZzMpUL0SQ
 nvaA+48gQnDB/C+8sWLCR/jfwArOUi4O8R9vKeLdo7c4pKhwxc56OcRlHhSADXhcCwWBvkGo3Qs
 crBLwu10LTr73aL00/NsKWRO9occOJXGBTZjnXvQKgtRK3AQSOWVE6cy+W2SHrtDXmI+NQKN99y
 cySU8AvWsnomKGQWnxaDDQp4dbBqUZhCaHzVdYpjubZNWPNA=
X-Google-Smtp-Source: AGHT+IHSwXLmmy/6TE8+QWQm5u78ilq7cjtxPNQ1q3FISwOymqaGKJivTWDaeYaAFdPGB81OcoMEyA==
X-Received: by 2002:a05:6214:19c2:b0:6e8:98a1:3694 with SMTP id
 6a1803df08f44-6fb47772defmr293753666d6.8.1750258800415; 
 Wed, 18 Jun 2025 08:00:00 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:59 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/6] bloblist: add API for applying blobs with specified tag
Date: Wed, 18 Jun 2025 07:59:27 -0700
Message-Id: <20250618145930.2652304-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/bloblist.h | 19 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index ae5273785eb..47ba6913cfd 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -261,6 +261,42 @@ void *bloblist_get_blob(uint tag, int *sizep)
 	return (void *)rec + rec_hdr_size(rec);
 }
 
+int bloblist_apply_blobs(uint tag, int (*func)(void **data))
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
+
+			ret = func(&blob);
+			if (ret) {
+				log_err("Failed to apply blob with tag %d\n",
+					tag);
+				return ret;
+			}
+
+			rec = rec_from_blob(blob);
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
index 0aaeb9ef7f1..62e4c5b220f 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -270,6 +270,25 @@ static inline void *bloblist_get_blob(uint tag, int *sizep)
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
+int bloblist_apply_blobs(uint tag, int (*func)(void **data));
+#else
+static inline int bloblist_apply_blobs(uint tag, int (*func)(void **data))
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

