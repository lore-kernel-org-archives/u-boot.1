Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A22CC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F3D8388B;
	Tue,  5 Aug 2025 16:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rl2q+qCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C146A83885; Tue,  5 Aug 2025 16:53:43 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692728388B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e0a249d6so7113155e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754405618; x=1755010418; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5mYztxh811xNl/67QJZPtCTOYjz35oBVCkJ6IQr++E0=;
 b=Rl2q+qCO8wZWkH+QJcIb0/3Z/LvuI8BjYx7OSPqQIWNJvx0kjT2LvlAnPQZ4RD+SDz
 V3uMGn065BrEV7WNs/Xv/8fX5UOY/Fstx9uYL9izdDdWTRyv9/7kgmk+Q/nGPhoscUB+
 zxtgHfSaHhLVcDMulqlyqlERXiv98/089Ec/LzatC1GM8om84ehSLIlgvKU6xTlPGUM7
 7ww9LcQyUjcM0/qcnr0qFRRLUIVkdBfTE5G6a8maQQFJYCdUuBV9x038vMjXID183MnR
 JKTem4QbiQ8U4cFwGfKzQ75YvS7z0YjhIYsaxMyubHwHAkhbmcQDQnt7zlpRPh7fPOMM
 dUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405618; x=1755010418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mYztxh811xNl/67QJZPtCTOYjz35oBVCkJ6IQr++E0=;
 b=VdLuY8c3+5deU3Pzyv9iX++TVMbvc3kP0PgO+LepGvkF4FUaYq404Y29hddOacneV2
 wm3o/5qOU/iNB6JkEanL+Asb2+iQ81pwGeZSd58QMtkoHpepbumzQsgy/pkpiwnvgpjm
 +MCvzDhSNSHT3B5LXYs69chLoOcWYFnFr/8kV59KwTTGHpZsOqvA45tMPIU0xvWuNjxC
 eyIm6GfkTWH31kpkYA6pDY9l3ikwCk4MSProk+jJQQGQ45K39AZRL3fa+J827BnoaMB8
 6kKG2oX35qSY1DfJvH67rb4HsLfSrn+Jrc8TyrvyFykN8Qjht2rbKVVodVmWC+WOXxAz
 LzHg==
X-Gm-Message-State: AOJu0YybiZrxS3wLCgXeikadXn01T6qBMAgHTDIbl9dW3Pnecl0WwpVV
 35x5ehzY9qjxZxewvz4pcUxSygxt51NOTG0fXkGM5oUlZ1DQ/gk2A5o9y7/avR1+cG8=
X-Gm-Gg: ASbGncvvUKdolhHQtcW3g9LHpDM92y1L+pP19oylH+uHs4TLYgwxzBZ8rDb1KxloBaF
 xREHQfRzlQL2KW2wZ+4vsrjb02205SWth05SZpA6HOR+HP2eQdbdZQj+QoPsGfRN6+eBIpPOEKc
 J5acpbEQEueHVk563JMcDo4J5mJ29Ktyma9r0JIej4zLz4xDYj7IbMWYaVjYgd9i2jDGxUK7AVI
 aLll20tm8Zu0xNrgdquPiUg9lvflmRwnDXMk/wWmPeTlYoDB+FtRH2SwvVZto9twMsmDdYDuwuM
 ofST+LxUduorkFx5WTg9+Tmcq9edJXBGl6km/2Wr4mNmrrEp1x/LmUcq0k9ftom+ZnM6Qh0mvHj
 +xXHUITIXobKG8Ul5n2j/6PURFJIb/zS49FQfsKR2iXbaRyOa8qo=
X-Google-Smtp-Source: AGHT+IGg7XH15f7VFPwku8vbQxqrpaT4bQh8ybgIsCOESg/1EsR23bYgkuT5OVAekIsLuKLiD0IBIg==
X-Received: by 2002:a05:600c:1f0e:b0:459:d645:bff7 with SMTP id
 5b1f17b1804b1-459d645c4b5mr87687395e9.12.1754405617834; 
 Tue, 05 Aug 2025 07:53:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm66075875e9.13.2025.08.05.07.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:53:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:53:35 +0100
Subject: [PATCH 2/2] net: octeontx2: NULL check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-octeontx2-v1-2-8b804a3760fb@linaro.org>
References: <20250805-octeontx2-v1-0-8b804a3760fb@linaro.org>
In-Reply-To: <20250805-octeontx2-v1-0-8b804a3760fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In rvu_af_init if the code fails to allocate memory for nix_af it will
take the error path with nix_af == NULL which will dereference nix_af.
Add the appropriate NULL check.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/octeontx2/rvu_af.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/octeontx2/rvu_af.c b/drivers/net/octeontx2/rvu_af.c
index 0d3a9ffe9ee..7bdfbc52e3b 100644
--- a/drivers/net/octeontx2/rvu_af.c
+++ b/drivers/net/octeontx2/rvu_af.c
@@ -114,7 +114,7 @@ struct nix_af *rvu_af_init(struct rvu_af *rvu_af)
 	return nix_af;
 
 error:
-	if (nix_af->npa_af) {
+	if (nix_af && nix_af->npa_af) {
 		free(nix_af->npa_af);
 		memset(nix_af, 0, sizeof(*nix_af));
 	}

-- 
2.39.5

