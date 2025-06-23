Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0432C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194B682E20;
	Tue, 24 Jun 2025 01:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mg4GwLLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B186582E20; Tue, 24 Jun 2025 01:49:40 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BB982E66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so42281545e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722577; x=1751327377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V1zxjz9SAF4OGq5Aoeu/zZgwB4uCX6972RsE5yis7R8=;
 b=mg4GwLLMrFTOmaM3hKHlXScvBcHThKTMvLkpxSrRYscscCjK1fLN3aqI67riIpRxQw
 PeuunNV1KSnfeEjBamHa+Q+4GLbNIMzhBZ/B4IZIrna71Xhi4XCdtnYr4lQMfHju5ex2
 /rb9EYVYNYQ9sDYdsi4wmbsRA1+xLo9HXffcoEaWVjvJ1+m+qBV/rEFiqczfBkq116XS
 h/khthp4SsARrl9R3thoJXG/1w7eub4Cm3SSGcljphc3fvIPr1XCt0jYGdPrmuRXbi6X
 2JWmL9t4WisYqmTI4oRs8vBYZ697QEGC5iiZCOm2iUfzDeL5ni+YykyxMMw1js52clPT
 f63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722577; x=1751327377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1zxjz9SAF4OGq5Aoeu/zZgwB4uCX6972RsE5yis7R8=;
 b=ewyXZHpivoXqjGZZL4QAQwJXkPea3XLNujwn++mTCUhnBCgOWFVX1pMbPB/4fi9T76
 Cle/+HOO86SSyQLB/aKM4YZScmLHyplDwQxiiKIhTo/wMiChBIBJAmLDdEnHCZJfURK6
 qL6juBfPm0m9Z3hRIQXFF66LDmofta5TuoMvxrL+qtYimDsUpEEtRFI+DXVDbw81w/rR
 coYLbVzk1NDFqdCEc7EUYuYlR8zBKmYlW3EG6PO3vdJiNM8LPX3AWJ3wS7w6hrgGCdyc
 U3m1gaCWpkZFWcuPhx/Xzrle4+iqBUtEW1oTOYrW8hzlkEM1CdvnGDiJkkq+K1gffnKD
 izjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvqLpVfEoZrhaEK54+JKIgwvyJTl8Icy/9qUTEDM7yR1w8Tqwfok7rc8GQW3AZRF4/6WDUlCY=@lists.denx.de
X-Gm-Message-State: AOJu0YwxQKdIot1uioR8gOkbFVFGoWi5CyAuGIX1dkYXb3GQKAjOyaIL
 PD5J6T+Si3M8IXs/bM/lZj4flBVF9DdcdPDdzTTQ9jlhSPwprZWRAfnJoteer7chRPEs/6YTybh
 4DgQ2
X-Gm-Gg: ASbGnctltd21Bo2FiR3VplB3uyIIORZYZnMW98ZLk11bHwCTvi3L9H4gRqUchcUURzA
 K0q8IAIu5Gzxe+5dnEHNodYrz8ch2VhnNkDNclK82oNYz9Qgtwi0Ch1TzSlbn79/sT9n+fa1rVC
 w3Nn2V4nnfcTEArqSS6nnmEPglsOh0RYFQvEcQ+z4OMi3jahpLYWvsjWhPuqwCNTYHyuzWMR35Z
 oYZQ6hbCQVdD9G8inGslvvH5unnZHxv2GHrpvkTIgcaz4QnhPJYnQmCUZzA9hi/YPWmWY5442h1
 R4BkppBGRCAVlAdm88Gvg7sqmEoTiSVJpIcm3Id08DmTtND0+iYUk3Pvgqx2TIUiIJB3XMvhbnB
 MwVECxoumTpA=
X-Google-Smtp-Source: AGHT+IH/DyIGSxKBNk0pkBhJYCnMV9I/WIW5lj0aHXYVKlely6JRpf1DBGbDU0Pq7na9tBLaA5HWbw==
X-Received: by 2002:a05:600c:3545:b0:442:f12f:bd9f with SMTP id
 5b1f17b1804b1-453659d44f9mr122003815e9.27.1750722577031; 
 Mon, 23 Jun 2025 16:49:37 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
References: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1 1/1] gpio: msm_gpio: return correct value for gpio read
Message-Id: <175072257376.128390.1973436138640550429.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Thu, 08 May 2025 17:06:46 +0530, Aswin Murugan wrote:
> In the current implementation, the GPIO read operation considers
> both the input and outbut bits (bits 0 and 1). It should only consider
> the state of input bit, i.e bit 0. To address this, mask input bit
> alone and read it.
> 
> Reviewed-by:
> 
> [...]

Applied, thanks!

[1/1] gpio: msm_gpio: return correct value for gpio read
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d202c92862f0

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

