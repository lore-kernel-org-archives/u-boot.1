Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6676C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94A482F6D;
	Fri,  4 Jul 2025 15:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rCnZD+iQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF84806D8; Fri,  4 Jul 2025 15:42:43 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ED482F6D
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so13685071cf.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636559; x=1752241359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FhlCqUh0HQlrft5D9yuoPUJjhObT9rHz369rT0PUO4=;
 b=rCnZD+iQYCa+cs7YdFKYTNXeKYVhnuz0YQy+3eVoErEutVLnI3PyP9wbk0epo0OKBK
 CZKE00btOyF0tZMeSRB4Zv7TGXoq2+Gf5X3FA8KJb57azsRErvWYpzZE10ueR8y37d41
 B7YUz9ZsU86cZa1weC5f+mo6+0eDRMbuyyV5jYMGt/lQx76VWYAaV3uEzSTPzy8OD07Y
 sXy7vDEASbYxJPcP4AdT+ltxK3XgEfqAnjdZnHcguYwFcNffCpQuAoZduh1yYZoezRD9
 VIFnbyl2gUh57KQarDWgnb/B169cX4iYrgCApXAGsMZHKJdw9NXX3XgZkFMxmUcWuIrt
 GjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636559; x=1752241359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FhlCqUh0HQlrft5D9yuoPUJjhObT9rHz369rT0PUO4=;
 b=u28AEZ0Dn2ZbXb+ygGyLmcyJ0IyPwOHKPmbx+DQ3g0/OA14Tn+5Cqkl6ZsIJcBbz+9
 hD9r8jK6tp+KfWkTVGrhDFYJK3sSsIwCtN+qTgAjYk0t/+hoPK4MeWhq1SB1ZfYtdTLU
 +IknOniLiamHXYprIsEI/lTNQcqR6FRHQtMGJZFnVa6UspYWJ/kzlX0LnO/9FTZCNIvB
 9OX4FV8gHBP15OEoSI2nfWDvCYCc6ZZEJUqeiQBJM2uUR7vzsVEcAkqOElSXijgigqhu
 thGtFScP616JJgAByrkqvHpkiZJ5ZzRYLYojZGXHu2FOMGSOcWxhwxUq7fpEfvIy3YRT
 vsjw==
X-Gm-Message-State: AOJu0YzzvdYPx1P7wvVUz6Gid02qa0H1QlykgagFBEzCpdPYj5FSuZVm
 O7RVtJdI7EnagzYfg2WiqndhyFkYTxgAsti+IW8Ut3umOydkPRpREILj6cuskRYMD1ixr3TlyOa
 iSK7H
X-Gm-Gg: ASbGncug3/W7+U0vTg6yqhsykAZJGHqv9nkJW+6RPLyLVceJT7y7b9gUwcAixuwDcw8
 n0VkWO3m5JDUosTzpBPWgupsEYvHd42u6H3lo5v0TN+aZTBaTg8Kz266/YNZa/49B2rPIfSI5P5
 Uwau/+41eXOfwgv5hx2S/QjxU5C8vHeaqfDTqlSxqZrYATSsEoDHTKCJvyKJNUyIBH3aS8WlR5d
 4w12gz3Lma3Rw/kFRfAC9aUwDMpYARHydk08a+MXV8yXzCTf3Vy414yd3CIpyJ7zVhw/Vw0mlQA
 hkDoagthCneIJ+ST33zk/fnihmMRnRd/kapkAL4I+OTrsFJt4rtLShgRffNYhI+SXHj55z2cOXl
 u2cg8hGkoml0PhmTZtPtNvl++cXLH079kRcRFjVH1x2eDLxw=
X-Google-Smtp-Source: AGHT+IH1rOd/j2rLXnJh5y7omXbqiFIsGea6BmyX1LBXk1+IYoQePrw255c6XB2OFtHxxySNuGXlGA==
X-Received: by 2002:ac8:59d0:0:b0:4a7:8840:f946 with SMTP id
 d75a77b69052e-4a996890822mr43631581cf.40.1751636559560; 
 Fri, 04 Jul 2025 06:42:39 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 2/6] bloblist: add helper functions
Date: Fri,  4 Jul 2025 06:42:01 -0700
Message-Id: <20250704134208.2895595-3-raymond.mao@linaro.org>
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

Add two helper functions for:
1. marking a blob void
2. getting blob record from a given blob data pointer.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
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

