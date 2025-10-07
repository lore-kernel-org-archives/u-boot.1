Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA7CCA472
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 12:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4428D83F56;
	Tue,  7 Oct 2025 14:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q4+Ptr/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECEA8400F; Tue,  7 Oct 2025 14:04:20 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F2E83F6D
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 14:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so5359203f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838658; x=1760443458; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qqkGITX7DiMZWMC+9wJfyyIF6ZTvvwtSpyhVsXYHWkw=;
 b=q4+Ptr/9JuXg3yj8tlbg6YDpanFgwJE5dnSSDCzHUsAW/bqUtz4+Ku70Fja3+u7q5K
 iHi1sCh2iaSYMJwwcTmkj03zglULlaBIj80LPUsLUXGPVsRA7epvHEi57t42YCsAt2cR
 Ibw3sS+MIc4kB27a/tuGAyEWlzMCTJhLk+mwr3UH/bNo3pijNx/HkUQEeiWYP8eK72wM
 4Xw5tpLNS5UT447jaU6TFG0kIaR5a9djjifLM8rXDPL/BAchQuVY+VqX66A6dilAZWPy
 y8nYughBiM7UwaD+aHJI2WBAubFSRdk2iCyGz7oWxA0vAyjz2OdcZpGhxhkTpbnWNILA
 41ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838658; x=1760443458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqkGITX7DiMZWMC+9wJfyyIF6ZTvvwtSpyhVsXYHWkw=;
 b=NuKheOhjgeWK4EpAZARS3ocF6lf/cApJ16DbkCftXURiKAr8acNTP+MIL39KaG0Ycf
 uAYHhTidaZ9cN3d8wFhk4Qp91cVknlAD0FzUq7LiLnnEFMwUpzWDe/TPyoApzwcbiM7W
 ycksVgmoyEctx0vQ6Sdw5NOPDeXlsWuuB4/X78K3lGOtS9bq7F+aw1BXLIaHSPG9dWHp
 WhQAiPqD+g1RWxvramH34Erk5MU/hiFm/3ZYFh7UCnf6QiGyX4fBqu5AbDume/VoNDCd
 JNKAZ7mKKgqCSAutjyAtk1LE1hlz//dfHuBqbNKSVyytLy8OX2bsUq3FYPOFixqlKIfS
 WszQ==
X-Gm-Message-State: AOJu0YxHA0xPQdpXaW1QJh+Sypkh1PxaVPjAMimDWvxQhqzuXVN1s/i/
 FszqHugN6wNP33gUnDVTUHT/c0/+/fcGNsN58ovHd0TUgiGlb5rK3OJUL/1zAQZRaTA=
X-Gm-Gg: ASbGncsRcp79zacj1S1QWHBPM6vC84mmwdFN4cT0c5P/ULTu0Y6TLYJEcLJolHu44g7
 vybV4ss7UOkrsAhHUrtV31b2j+1n2lZw0r8OvFodSaqa07EO6LFR7dbnPalNmoGhAJbRssMqhgb
 06XqPYzPYe786bKNubJPsLRVPLqt5AiaWEng/zIjI6+IJQul6jSGCWW+HxCtI3oe9Vohk7HITpE
 sXZYNJP5E+6VuWtyuQiTzCeAzhtlYDU9wkUW2DEw5/lSeEmtag1M24bryX0AHaelBYYKdngiX/p
 rXfFkx46fO+iuJaRpsW9R2gSiFJpHSmg4UMfI9+mHmFQTRQFY1lL+hCLeIKlhR6ECNKp+ROLNes
 XlOonXIlbRDxtoufrJl9YB3a/GRIrO8NxSMugbWpsI+uXxLdbpWtnHDmbSLfWvWbd557Fznx8B+
 mD
X-Google-Smtp-Source: AGHT+IFT4i8PZi/eNo2T/2UTsWJFdlGrVJ3WVT+xhtGwYMYj1J3+/0Vg0ASc603F7oD7qlEFmySOZg==
X-Received: by 2002:a05:6000:659:10b0:425:73c9:7159 with SMTP id
 ffacd0b85a97d-42573c9773emr7005475f8f.33.1759838657788; 
 Tue, 07 Oct 2025 05:04:17 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:c90:3de5:5f6:3a69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm25109402f8f.17.2025.10.07.05.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:04:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 07 Oct 2025 13:04:16 +0100
Subject: [PATCH v2 1/3] ti_sci: Prevent memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ti_sci-v2-1-7561d7ea07b2@linaro.org>
References: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
In-Reply-To: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

temp is assigned the pointer returned by malloc which is used without a
NULL check and then never freed. Add a NULL check and ensure temp is
freed on all return paths.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8013afef304dfb70ab14150ddc49d43ebebb5902..2042d88583766213e9d74dd17289cfd3562f0acb 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3083,7 +3083,10 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		dev_err(dev, "%s resource type ids not available\n", of_prop);
 		return ERR_PTR(sets);
 	}
-	temp = malloc(sets);
+	temp = devm_kmalloc(dev, sets, GFP_KERNEL);
+	if (!temp)
+		return ERR_PTR(-ENOMEM);
+
 	sets /= sizeof(u32);
 	res->sets = sets;
 
@@ -3123,6 +3126,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 			return ERR_PTR(-ENOMEM);
 	}
 
+	devm_kfree(dev, temp);
 	if (valid_set)
 		return res;
 

-- 
2.47.3

