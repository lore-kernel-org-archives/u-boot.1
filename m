Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3307BC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A618A83FB2;
	Mon,  4 Aug 2025 18:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k05d/hoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 935F483FD4; Mon,  4 Aug 2025 18:57:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D0D83FBC
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-459e0a249d6so1136865e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326621; x=1754931421; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jg2DHbK2j/qq/NXbnOo97sXVAqfha6gL+iaxQpBNdJs=;
 b=k05d/hoi2Q+Vi0f/jySB+RHRaDBldwo881luXxHWyorRkBlx3soAayhFkmjNRwgDCk
 tOc23mwdntBFnrPrZZQ9SFuaoPirb2BSTTQEa89EPRd9T+1Pzcci1ZGx2kCKicJt0OjD
 YnhhCeFSg5Z2JcDcvDYVDds8WXvpymkYbNSnELc8qCHUc34MKub0G7jg2l1nNu9grKeY
 BzeeLXwGSiot+sfffk+wkHxuxKaGBZI38Ldj1a/9ZIEZxTwXxaK9s+CnUnZ/YmgMjIck
 9q85VdkaHQKutIsl0Rf+MjnsiK1UdHWXgW71ezNk+GEQSW5mkTX8ycNKPSWI0Nf1CvS0
 yntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326621; x=1754931421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jg2DHbK2j/qq/NXbnOo97sXVAqfha6gL+iaxQpBNdJs=;
 b=nNgE0hst5dS5xDW1Z6SVjT54kJ0G67zuGJl13sBQVpjKXoMG90Pnt9uWybhZHLVsW6
 1uL9S+B+eXFAt1dLAo5BkagrFAqlz7QDyTS3c24xuRpYY7BT//P72TWNBNPAe5+otq7s
 EIt1KJbl4N+ceyrEcppFHNiXl1g/9xeCrWKGZ9ElV1G1cT8KdWU7pjRC6MoyBfwUmghC
 abREUqfVbKodUO6Siev1uUJ0nr1j1LljvAv1lLgGVJxaoNhdYe4n+oKJya3RgluNaag9
 C+KoIxCk6PYashzje62QcGpOS0kflb+rvg8TRZf6UPlviHnUK3DKTUZom8qFLc4XPpoh
 kkMw==
X-Gm-Message-State: AOJu0YxVvzpjbGPbgDM47rHQnwTmoZaD6FUsbSogRIF10URxg9C8OPXu
 TfV0vtg94VKPpKi+nJfnUUQClGwCgg4lMVuEcBUZXs3pmUTvJEryA3Hkeau26m1DXUvC3SMayiE
 iNRS0
X-Gm-Gg: ASbGnctpd/T/MQJKFTNKg7dCCe/CpAk1Ktcu4omoaEyp3ZnPnq7H2WgXMYk9ZtUAori
 uuvzqVXtgKDCTE6v2lm4XwYpDK3GGj11nPfjEQAIYgCqWkTbHTKV9vk8lU4kaEMqaZwfQv6kJzG
 MIFfCbcDvDSiFuNusw7n2QKdkYehxoi85IKTxTtLFlqOcjKjbfzXclzAMG4KY95H4iVJlNbjv+7
 6y0h5qXa4KmK5Eo/EedUw2qTUpmPugXJW/2C8hG7pI/HGxS+6BQSUaBGYg3/+Ps8fYWTj5pe60T
 xmXcQ5YxszHZX/3viMN5nw2hznHzyhLMqfj0ioQaEN5xKAKLAFbX24JuHnxKTYFYH/THTzPm3oE
 Ohk9KVCxwjP2aQiQ2IBmUTuHFTCg+ZiK/pX+D1ucB/nTSMDZa8vY=
X-Google-Smtp-Source: AGHT+IGM6tx3ZMd8fw9SWcR8oBCmHqFG+8gh2kjvuoZ+FU00PykQQOz2rsZ3pxwM6gWdgzrL7Z8A0A==
X-Received: by 2002:a05:600c:8b41:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-458b69dd6bbmr72415575e9.11.1754326621016; 
 Mon, 04 Aug 2025 09:57:01 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:57:00 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:56:57 +0100
Subject: [PATCH 3/5] net: fsl-mc: NULL check dflt_dpbp before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fsl_enetc-v1-3-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
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

In dpbp_exit there is a NULL check for dflt_dpbp after it is
dereferenced a number of times. Instead move the NULL check to early in
the function. Also assign NULL to dflt_dpbp after free in both dpbp_init
and dpbp_exit.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fsl-mc/mc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 999a9912e2f..8c882c7fcf5 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -1438,6 +1438,7 @@ err_close:
 err_open:
 err_create:
 	free(dflt_dpbp);
+	dflt_dpbp = NULL;
 err_calloc:
 	return err;
 }
@@ -1446,6 +1447,9 @@ static int dpbp_exit(void)
 {
 	int err;
 
+	if (!dflt_dpbp)
+		return -ENODEV;
+
 	err = dpbp_destroy(dflt_mc_io, dflt_dprc_handle, MC_CMD_NO_FLAGS,
 			   dflt_dpbp->dpbp_id);
 	if (err < 0) {
@@ -1457,8 +1461,8 @@ static int dpbp_exit(void)
 	printf("Exit: DPBP.%d\n", dflt_dpbp->dpbp_attr.id);
 #endif
 
-	if (dflt_dpbp)
-		free(dflt_dpbp);
+	free(dflt_dpbp);
+	dflt_dpbp = NULL;
 	return 0;
 
 err:

-- 
2.39.5

