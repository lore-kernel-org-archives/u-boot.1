Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7EFC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41889879E0;
	Wed, 27 Dec 2023 22:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZI/yattQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085B7879E2; Wed, 27 Dec 2023 22:08:08 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F19876D7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78104f6f692so422705885a.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711284; x=1704316084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WZKJiUZpT3hVKZ6Ft6JJtw1JDFeG+xXrcJjolkRR/s=;
 b=ZI/yattQUk1vcK3REIf9M0lH2tJ4SbbS2N9og2eCzAPXcFvGeBEyl2YDyGVgm9m6G2
 chP6K1ZJ1w30GmjQNn/9Kgf0Daj+PET+jJJsoGIDOgxPhtVK7+MMUanJJNM+LVcM53EH
 8IcxqV07YecyzM/q+l183qsonBp8ZC6NpiatalQjcPr5nNldNbYH8gL2bQx5IjsGJZc4
 MajG6TiHWsbh8ggFpZqC4BcFYJA+I9lsC0nqiz7+xDUJsACq67Q4c51GHNOKGcGmN6qP
 nZDEw+heUNlrSjj9BgGTRqK8ZgNW6Zs7twPo0Fj98TyUaup8nsgvWsjrZ06jfNScK7H9
 OgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711284; x=1704316084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WZKJiUZpT3hVKZ6Ft6JJtw1JDFeG+xXrcJjolkRR/s=;
 b=dkwlJu+uOa4oVEXTZKaHNxjMc/Blq/iwd4mpf2sM2Ww39LtYsoX9mGoZUvwowZUFV7
 CNmQ9sGgmuJ/GxnyLRqjwpy6Ja9LpwzWgdBJdn8EsnH0Uf1fz3MaJqFxJkXjEj6G9YO1
 tO25MKovTaGNBQjC82T3IW1fMGKutOpCZfc2FU5mTXiTCvKmv2Mayh8TrST4I+V0Lxfm
 om/D0RVvYCIYPxGtXBiE4F6fGjL39JMPSwbDt6Kkw36GzQSL6DYi3o4yELZnk70P2Evb
 5ZNpOf/TBoYaQtQi+iWbLAkx0EvllWAZIez1WQR0Xr7dLmIonT7sP209OecazrgsYWZN
 hySg==
X-Gm-Message-State: AOJu0YxZNxeqZS59KTM3+JceAg7eJqr0C6vD1gU4fPBghwkw3U5B6Nkm
 VJo6LGvM/44d2n6WStrLK5EsJsPJfBSKwQo/Fr/f9piwSzo=
X-Google-Smtp-Source: AGHT+IGYdxPneI/keNkgeiR+lnq3JvQpeAfRjXJYfs39UNEXKuEFQE41aD7r7BlEjpHcFZ62u0Dx0g==
X-Received: by 2002:a05:620a:1587:b0:781:7332:4bd2 with SMTP id
 d7-20020a05620a158700b0078173324bd2mr156211qkk.66.1703711284360; 
 Wed, 27 Dec 2023 13:08:04 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:08:03 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 06/12] bloblist: Drop spare value from bloblist record
Date: Wed, 27 Dec 2023 13:07:04 -0800
Message-Id: <20231227210712.712937-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Drop spare value from bloblist record header.

For now it is still present in the header, with an underscore, so that
tests continue to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Keep the spare value in the bloblist header to align to FW handoff spec up to commit 3592349.

 common/bloblist.c  | 1 -
 include/bloblist.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 168993e0a7..88e2a0f5c0 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -165,7 +165,6 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec->tag = tag;
 	rec->hdr_size = data_start - hdr->alloced;
 	rec->size = size;
-	rec->spare = 0;
 
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
diff --git a/include/bloblist.h b/include/bloblist.h
index 7eff709ec8..68f97395b7 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -205,13 +205,12 @@ struct bloblist_hdr {
  *	record's data starts at this offset from the start of the record
  * @size: Size of record in bytes, excluding the header size. This does not
  *	need to be aligned (e.g. 3 is OK).
- * @spare: Spare space for other things
  */
 struct bloblist_rec {
 	u32 tag;
 	u32 hdr_size;
 	u32 size;
-	u32 spare;
+	u32 _spare;
 };
 
 /**
-- 
2.25.1

