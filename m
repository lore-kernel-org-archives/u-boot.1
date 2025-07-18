Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C8C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3846883675;
	Fri, 18 Jul 2025 16:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VD5HZSNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD35835B0; Fri, 18 Jul 2025 16:16:44 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70FF836A3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ab554fd8fbso26496081cf.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848201; x=1753453001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1895sRN35sPGDUxMQhF/B9D5O7fk0U8Zvg5wbRqgq4=;
 b=VD5HZSNioK0343vw6YqMyX4021Pevft4KMAGvd9li/Nhr4ji/DDKLpkHwLQs2o1rNB
 0Jc//oXKBFBOncvcoAuFFJKAqG4dh1H/tiI3mtk104TJLl7MqqUOwMyg66RnXCs2rgsa
 Iw8HNWE3XNrFP5zyHZWLIBium6YFFkhFrCEN5wd1mjqOuu4NxEeLfsjRn7aj8bhnEfNN
 alKqq4kySXEaMPnRSfB5zGvoaDdbMJjtjhMR5yISQPwt6nvscGgPVdbA9cBnVyDxG6+U
 aEbf5oT/BSIl3xycERHmJNaGw7olFRbOKyXF/jWXXXLNOl2bTCO0qVwF2tIMxu0kNmL7
 acPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848201; x=1753453001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1895sRN35sPGDUxMQhF/B9D5O7fk0U8Zvg5wbRqgq4=;
 b=HDBYPSvnOxCpKKiXUJY5nGqlesK4Df3Kc4rSYE4kdLQt1f2Axm8Yepvr+Uyaq8e929
 JY64bMN1jXIVb4MHnrtN1iurucLGKyTZ41gAIQPqfGtkQ35Ot+ZhHityRb9GSgcvwoPF
 3cVJA9QKe3PETAhX3bNMWqSt10M/MdkLs8uQPX+L2PMa0SGKJMC8azqizN2HdLyXSn7o
 fXvxgK5CvFRjyjPGGoHdBscSIdI0rFZpXWfqXFMqgCi/ZVd6ujk+ZDG2fzWVKlzkZ3CY
 OY2IsbqIGIGM2XxXBN7KexfWT6mAsx6eNu4QqU9NSABYky2sl336+f7zdyevD48FS2ld
 QVng==
X-Gm-Message-State: AOJu0YzZpubQoQgxwhZq0oTErfSIOkimYWMNgNZ1DLvdEEXYD7MtYNMq
 9+c4zwfRVJHdlX8wjKB9PYJYOnGT9C0iKq01/uIEBktl2dGdgk5aeR3C6Zaf2WWzMv+iqfckKMM
 nMD3R
X-Gm-Gg: ASbGncsPZYrSdXFjKf5xXUVAYInTns8f/ozeTpWSwXtKq5MJp4sIbgfUxBOXv4pDAz0
 db892J7vwVrvauJwjEhgzpm9GaRXo2S+V/B2ExKd3US3KILWSvnMXnx8HstLJ3eCgI5YVBNzOAd
 XC5EFo9un6tpCa2ug52OGOpi8vNz0mrH59W1lgQz/b/RCxzROdLCukX6Od11g3PjCzXSdNTezO2
 Fah8LHAYtUbfANltSCg5Ksz4GQ+UhUSvDwkLIa5ZqMkr+O37aJ4OvBMf5dXxObpwOEZPbEfPIFG
 0gwMwQTQrR9iL4Z3nu9JRSnWv8t+EWwP9SflrgwL/nSdtfk8eE1qHypQdJZ4zzHC+ICUYgnAB8K
 sJL0SFtbFDPYDiWThc7eLeNlzgIGuotkRopn2Ga4sVsEskefIhIZMM9tPsnpJqP8Cp5a0gynFHC
 PMako2Y6D00BSxs4u4lg==
X-Google-Smtp-Source: AGHT+IF5YQ80Pn0gTt9rNO8uUe+yvVE9cUz1eXNleQ48bom2eHrWqMGu5/h5YATqYDif7i7j84NgQw==
X-Received: by 2002:a05:622a:4acb:b0:4ab:41a7:18da with SMTP id
 d75a77b69052e-4abb0901f50mr73258321cf.26.1752848201031; 
 Fri, 18 Jul 2025 07:16:41 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:40 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/6] bloblist: add helper functions
Date: Fri, 18 Jul 2025 07:16:15 -0700
Message-Id: <20250718141621.3147633-3-raymond.mao@linaro.org>
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

Add two helper functions for:
1. marking a blob void
2. getting blob record from a given blob data pointer.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- None.
Changes in v3:
- None.

 common/bloblist.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 1c690f58b56..488908f605e 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -97,6 +97,19 @@ static inline uint rec_tag(struct bloblist_rec *rec)
 		BLOBLISTR_TAG_SHIFT;
 }
 
+static inline void void_blob(struct bloblist_rec *rec)
+{
+	if (rec_tag(rec) == BLOBLISTT_VOID)
+		return;
+	rec->tag_and_hdr_size = BLOBLISTT_VOID |
+				sizeof(*rec) << BLOBLISTR_HDR_SIZE_SHIFT;
+}
+
+static inline struct bloblist_rec *rec_from_blob(void *blob)
+{
+	return (blob - sizeof(struct bloblist_rec));
+}
+
 static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
 				   struct bloblist_rec *rec)
 {
-- 
2.25.1

