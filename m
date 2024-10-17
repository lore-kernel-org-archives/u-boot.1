Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2923D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D46D890CE;
	Fri, 18 Oct 2024 01:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IUoxReV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4805389122; Fri, 18 Oct 2024 01:24:43 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C14890D0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ab3413493so38043939f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207480; x=1729812280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHj/DVtRNBiKqw+MVxyyLczjD9tECG/UqaxPuwFMBeg=;
 b=IUoxReV98m8P745irrzA+tCpCP0WKb2oFPP/X4g4CZohCzm3qCkcxfVXYXNTiRdgAc
 lZPMy6ZmrHWAv3P5HyToeJQ2On4q07OfWHmMxw3EdpBJD636OQlMbsyK4CFfAWGe2PN4
 94UVyws58r40N9yJsZ6I2hPXXcOt57rQYWuRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207480; x=1729812280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHj/DVtRNBiKqw+MVxyyLczjD9tECG/UqaxPuwFMBeg=;
 b=b7RpLID8DH6xhSeAZDet70YyBNlE4KjK1U1froSfZ//dm91AId13ouA06Bicyg4UtI
 /QYXh0X1RkldNtjtuEip8JMAJkqOFWPvm7xXR65so23aexyNXFKSo2ugKuZ2Z7c09EyF
 WPXrf72yhN2APsYw57hZwaDn6NvCbvJhvOJtugZyKcC2fXv8FHdVYCTQgZqSZbV92HPp
 wgmiOw9XG2nlEa+LGfwKAV/xpQYIHl2uEbOq/tK2iR2NuJD5ujsZ3OxLPpxzh2+hhelc
 du4BoRlLAZzTs5ODQDhUsc/xHRogpH5lQpfUHMGn1fY2XbBlzBTPlro6f16PIdY7MRwM
 QihQ==
X-Gm-Message-State: AOJu0YzJZMWqQaGZzWUcRUsmtdUzwYv9jfiFzuFizNjfqKqgNgIO8QCX
 7gYKk+ShMXPxEt6uzadn454HLm5wy8n+3PLNfQjrxfkbH9xekx5Ihy/OIpmm36oBzCKYdNLNUvs
 =
X-Google-Smtp-Source: AGHT+IFB31O7W6fH5vXBrIAeLNy/g/JyXHixa/S9lrlKVfbLus3B++SjW4P1WQZ3YANqSi17bLcvqw==
X-Received: by 2002:a05:6e02:1a83:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a3f40b728fmr3083225ab.24.1729207479750; 
 Thu, 17 Oct 2024 16:24:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 03/34] alist: Expand the comment for alist_get()
Date: Thu, 17 Oct 2024 17:23:42 -0600
Message-Id: <20241017232413.724808-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Add a better description for this macro.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/alist.h b/include/alist.h
index a727f1c7dfa..2c78ede201e 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -116,7 +116,12 @@ static inline const void *alist_getd(struct alist *lst, uint index)
 	return lst->data + index * lst->obj_size;
 }
 
-/** get an entry as a constant */
+/**
+ * alist_get() - get an entry as a constant
+ *
+ * Use as (to obtain element 2 of the list):
+ *	const struct my_struct *ptr = alist_get(lst, 2, struct my_struct)
+ */
 #define alist_get(_lst, _index, _struct)	\
 	((const _struct *)alist_get_ptr(_lst, _index))
 
-- 
2.34.1

