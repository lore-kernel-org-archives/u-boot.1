Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA1FC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBED82B00;
	Tue,  3 Jun 2025 17:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g8GOUKNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443C682145; Tue,  3 Jun 2025 17:00:46 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2EC82145
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso58209435e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962843; x=1749567643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgLctCmVSY7krKs/gofSqxRxBAdlljPovFKFF8W11Bk=;
 b=g8GOUKNHeRyQCHaj6Iaudg/B+rs4b9vPODh2cJVwlRkcI/tpM2dANo99MUvAU2X7N9
 okQt7ixNfLeAI4hKVJmEHvWaEHelIxuzmEHefTtgyL6RUVMIdeboXZmfA8nXvfvAQ7Dk
 SYOh0v1NJnq28iI9n0+XkPbBFOag710+LsC4Cgbm/li7RbfqXXeFOFca8Sa3+CjONBOP
 KH3BcuPqWdxOlR4IG0gvBxMgUcbZ93XzFYkdR+l2ratC7FhOsVQF3qgV4VPK9jLjaWSG
 QiKcDfFjM3/IJgpXHAix9KiC6zGXQp7JNhhxITmWQR0YZ2sxD24tPgoun8JnbnP30JAW
 fyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962843; x=1749567643;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgLctCmVSY7krKs/gofSqxRxBAdlljPovFKFF8W11Bk=;
 b=nDKrZx3pVCZU/NsMAxtUE4gnMqTROknbJt513EVt6nL25qoO2hvXuLs1TO3o+J5xj4
 /tEODIqtLJXx5ve2QzTEFQDidYKC/YXmtI7Ubc/z5+KTRY9BQIHOxt9xN/fHh/tHGUwp
 HfRXXLdKWP52DyIS5qsb9b+CTyT5k8mD6v4xrjB14Fn+V7D88uSUMy1YIxkIqa20N5NJ
 vIK+nDJ6E0jbiXyykCaY9RRDQO70CjDZIZVtvf367BXjv607jjfwEMhrftJaIv3Q3rMi
 fjuDtQuHwfhC5ndCuJfQ7Em6fx7pUPaIqjQytHNOvwrD/7uWrPzWYor1O3uXk7HvxqgG
 0wZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbNIlEEIdT75251bk9c6jLmWGR8/NePPui/nk2EvkQzArq0G//IcmF30aw9MORVQ7ONiGUQSo=@lists.denx.de
X-Gm-Message-State: AOJu0YztVABJ+cBhO2q3pL92XW3Mo3RCAxKM6jVT3K5TbTVoH+7ql5Gh
 osuYuCXh02mua46Xd1OfNjAVpNDY9DMMWk8MUZdjM1EpQUoTZkCFBJJdBO4qN1U9xCE=
X-Gm-Gg: ASbGnctPacS8LIQ6nO9xLT3JyKoCowWXErqwjP82t67Gs/O98fqGHwpHqjhk1W2QX7y
 paPg6fIdZeYZ9O2H0EIsEwT/rqWa/ICQGc1NP07vjaf3xTXzHGGHZj7f7jl7Q5nx6EHv77MwuWR
 tj4MRxO463fFG75MCeusvBJiOSAWhsUX2lLpnNJCnyevhKrwp7pAMZSxxTQ8aIWXtgQljRpY/6a
 5Rk0pJ5frNUwEBCt9RwodgliacE3kI6AzYzyA940OlpeDsoB/AZSmLat8vyf9Tu//qm5r+P29El
 E/SZNCXLOhcQJ9hBCjlW953HAGoqpb888CiXKhpz5UIbKIfRS086fnU7pubdnRqtT3ZujnulIre
 aT7X6DZmB7W0=
X-Google-Smtp-Source: AGHT+IF2ycQj6fmOUpyIP0s9RiK1+Ql59PH3p1JFq8qzTFd/LGzCaosj1agXsnrFBx+HOOTayXHUKg==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4511ecb9cd9mr126415495e9.3.1748962842941; 
 Tue, 03 Jun 2025 08:00:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e5496282sm19845165e9.1.2025.06.03.08.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:00:42 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250412174157.104419-1-rui.silva@linaro.org>
References: <20250412174157.104419-1-rui.silva@linaro.org>
Subject: Re: [PATCH] power: qcom_vbus_regulator: add and fix support for
 pmic variants
Message-Id: <174896284166.1020546.6689653611138467925.b4-ty@linaro.org>
Date: Tue, 03 Jun 2025 17:00:41 +0200
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


On Sat, 12 Apr 2025 18:41:31 +0100, Rui Miguel Silva wrote:
> Fix and add support for different pmic variants pm8x50b to handle
> the vbus regulator.
> 
> 

Applied, thanks!

[1/1] power: qcom_vbus_regulator: add and fix support for pmic variants
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/eb2c63ddccb9

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

