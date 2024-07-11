Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3103C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E496D8841D;
	Thu, 11 Jul 2024 18:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m8r0MNPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8ECC883CE; Thu, 11 Jul 2024 18:46:46 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50AD28831F
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ea79e6979so1248252e87.2
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716403; x=1721321203; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bcZVa+VDuJji/8aNFxPP1iBM+h15a7B0d/YaMGub7Uw=;
 b=m8r0MNPtIph3D3yBN13USIjAEc3lmkAKg562+Hqohd2L1tBQICoUzwdgfDX8liRqO3
 r0TOHhGz7mx1fHvAFwvffgyvko0VrmKh8L7rn0+jWqSc53o2vYqgJOsJ6Nu6UGFfc4hy
 EiTVjS6uHj3A84S3lTkb0Hcn1kTofzIwhOPlevy7Wuwt4gM+WR9B7QJYNRjKchUvyCmd
 FBP6fU9QMZAlwIbJyWJkTQ04sMK1WXGka4vguDKZ71ZyqdELeuupsaL5iTQUyniGvY98
 OGnoYbYWaJTHYb7DTtaGagJfKJY/BYnh7px96gFhglcg373/D55jWJNFiJlZHcJbDYr4
 +xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716403; x=1721321203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcZVa+VDuJji/8aNFxPP1iBM+h15a7B0d/YaMGub7Uw=;
 b=Fsh1v31VGICyC3ZmXpODXzlWFwZbMa+UhJwWbXvEkJdm6NvpTtT0QJO85+sIgWRxlY
 Sxres9A7cNAuoT9XWfVTcCs6apIY8GEOTPyOYFbBTz83xbP0eiOxJVtzDz1rbB/8EzZ7
 0wmzhFFG7oftWc8qd3KFgL5yL0q//ZzM4KhNFLCHdUAyhyTlPu3cd4mFkIYpcIMNtXsD
 20U5ekDJ0m+BxmLct3+LYBCc9uutbkmhIqbkg1/rLJCa/UVEMnS3hgHyH7UDxRS0TdKD
 /kiSX7ToQFxQs/tdHWPKHkaN5fPJxrQNI2F+CxZfiO0EdzDzjWzvIBowrx/Ml2VnClHp
 OdBA==
X-Gm-Message-State: AOJu0YzEFUO5QPBtak0PZ7Dp6XKGLo7FXyI6xwFUdjsp2can2PSYEev8
 3uiu1lA7nvPB2vY9l1sUyTFpldYzZOZpantxQi4aKbdaT7Rjv45KKOquC1SD7ow=
X-Google-Smtp-Source: AGHT+IENgqt1yTTfvb7jZ0xBZiD8NpjdDJYVRGWu8UjBX2nHsP4DE3imzTzhirV2FAghAZVv+MBt8Q==
X-Received: by 2002:ac2:5bc2:0:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-52eb9997806mr5016040e87.23.1720716403573; 
 Thu, 11 Jul 2024 09:46:43 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:33 +0200
Subject: [PATCH v5 01/23] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-1-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PxfbD3T2xPQP1uXV5S6na22BOVQpSqa42vcVud4EfCI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxtEz2teg9BqndbKVeinrsVxcywY3h7+414l
 jc8fbVHaKKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbQAKCRAFgzErGV9k
 ttz7D/0WnAz6PfflMzH8AtIBxK2N6tuM1W3iajEcHDR2q6ZbmS0hp1u02dXI/GTfQaKDRH7/sme
 zsfIDhn7jg1edLAstJ15MVCQJ9eCl93GDd/qclyFv0Nro0Hr53myGrsSYhppBracfoWq9wcnzun
 zCqt7H0RGOiyOD6UBrH+N5UxreebIxOyhzOV5t6dyx6+7cUtQduO/bMy+pGZOTQlPSzDJAWAZ+X
 88C8hXTyC0HjMn4CVsL/ZDwjVxxWyusYvYbNmXY1U2Zg4mePGJAz22C4IAT4lEzWp+iCCoUW2Yt
 ZfXDrUcnmFXUnZGI2OECijM0XsI9N7BntGSiX7XTTTwOYiw6U2qE/geiyYpBm706gStGSju7gUb
 1WlWNa0P+q1vVRsKhDJ1EmpfPLGFCFs8y6iwd3RGFVwC0O5Pi+XbcMwYI0DW0uP28/Bnflp/mqL
 pIV2U9d+uXi8HCRLJFCj5/OCuX11ZHrpFbBePNddY0jZw+oTJEJSogb1/+yfEMOlDSMLVlnPnS2
 bJpA+WQTPyzs1PIXlvulLGlzn9aRPCUyok3PwEkoDQBXcJbAtrziVfh92+u/Gla77xeuyZaBv6A
 1mlri9qwdSbqfVNCvSyru9HzHANyAhQLiGja718AnRZNlfhseTu3/Sv86vdni9eXwZSjZdBRxez
 KNmS16Czxkyj5yQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Import this function from Linux as of 6.10-rc6

Reviewed-by: Tom Rini <trini@konsulko.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.2

