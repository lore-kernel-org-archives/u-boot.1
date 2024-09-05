Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48F9CD5BAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 11:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678CF88C87;
	Thu,  5 Sep 2024 13:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yyO5fLM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CC688C88; Thu,  5 Sep 2024 13:55:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B55588C7E
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 13:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso1096638e87.2
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537352; x=1726142152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N29sEg639+jv39r1vH/C6f/9RZfgYNlZjxjVCFnvSsg=;
 b=yyO5fLM82+0U8tr91Ixj8t+i9syzysVWcE8m2EQcMiJHjtxfefMAs8ekojq5PVSOqg
 Hn9FOGeP7iRlgSXPsYspDFLGWjDFn4gW1vl3fNUATNW0HnCwPeLfTkXHPvMb2OPcj7oN
 wVy2Yz8jdyxtSX+/yslJyDWFphTPAuS7cDpWTP2NxsRo48/zpf2BogJKautUFSJ21EqI
 rt6VzF7/aY2lp6LOo/ajTnx2cU+wbXTliQgj0plNQoqpOhqLRqSXJzuqdDuPoXxS5j9W
 /GjiMYmOhmWCiNbKHC6u+nS4MVlZjQsAKFOG5999ypJggrx3/v7gu/rgWuLS0UY4W3Qb
 fqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537352; x=1726142152;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N29sEg639+jv39r1vH/C6f/9RZfgYNlZjxjVCFnvSsg=;
 b=Piu0BSBANgOWDskn/eh2b3jKqdXXBJQ9sMhW6LWETJS3YVyha2mcfMeJpj6NU26vQO
 ws5auV2C3kBCVJ8P9GJc2XKaPYcsgW24t4fmfDmXqKCa9uXfifk4BGVJEh0uSXOrLj2g
 D5SggOCp5enp8N1J4tTbULVZk2C3+WLb1dt2Y5WTqVSrhWQcLkdETuwZGYmc43FtPA6L
 B4q+nO94gC7309DzE0+QRekaX5QpFvnp8Y1me/AcmgYWkruFuUBOoIVLGRQ3zU819jRL
 yb5jeLVJddVXIz/C5i+A/WJzwsBfdwuHw9PB/ejYtETTyfXR3wTrzXjpwI1k6OlGGDsZ
 wr3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWvH+uaQplhNdyPSxUv4D2tVOdIQaontxkGTNyDMBMdS8l2j+z0Cff2aBW9y3e0E6WGfm9q8g=@lists.denx.de
X-Gm-Message-State: AOJu0YxloIzNo6dvFlIF8AF8V2bxy736OEQCyE79uEboUZotbGTOFUCh
 jJcxPcY6JgCeNG3JWDuCLglpi4kHCGvboZYWhtO+AA5RBq1lBFfV/yDmdQh6yYI=
X-Google-Smtp-Source: AGHT+IFcpZZtRq5RKqRaghM7jyRDFWJPjm3mzvwKHATD7UZi+8Vy+EnSB9SHFHA+FIHeYXcb748CxQ==
X-Received: by 2002:a05:6512:3b0d:b0:52e:751a:a172 with SMTP id
 2adb3069b0e04-53546bfbdedmr19332443e87.49.1725537352303; 
 Thu, 05 Sep 2024 04:55:52 -0700 (PDT)
Received: from lion.localdomain ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623e34acsm126825466b.215.2024.09.05.04.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 04:55:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
References: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
Subject: Re: [PATCH 0/2] regulators: qcom-rpmh: support SM8550 and SM8650
 platforms
Message-Id: <172553735137.2587873.11481227196868661175.b4-ty@linaro.org>
Date: Thu, 05 Sep 2024 13:55:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Tue, 03 Sep 2024 18:13:29 +0200, Neil Armstrong wrote:
> Fix the RSC and add the tables for the PM8550 and related regulators.
> 
> 

Applied, thanks!

[1/2] soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
      commit: 0fa4617861299b42effb5faf4afafd6fe1a79192
[2/2] regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators
      commit: cb8cc050f827654e70c8e1ac5020a2cc4d42aefc

Best regards,
-- 
// Caleb (they/them)


