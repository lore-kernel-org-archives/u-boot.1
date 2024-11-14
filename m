Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C49D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09A189653;
	Thu, 14 Nov 2024 19:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="afWu4ZQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3A789639; Thu, 14 Nov 2024 19:13:24 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8198964B
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so178827566b.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607997; x=1732212797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMbR3P++0JSi/If5NZ9INTKMyPYQuQ11n1dDhCwQ/w4=;
 b=afWu4ZQQIJcvSgfXvqkV6pOAwXBI3dDc5Tet2DWP1lizjs/dW3Xc0twOiGILK02Hyp
 KMP99Hn5A1E6EQxl4zC0YR4Ytff5zff3SwUUMu8nXJE2O8ygYMW1heY/THG7uN5TuMQb
 8YV5H6dZJC4qHTnAKXNdTuv+PFFtZRnnxIMNyELZ7PZVluDArRnLCOoYqfcsppApHg2J
 3KycyjVs/8bEpliFwBRzjoiIW1A06o4k9DQzbJCs3fKAF7VxmHdry/v9zT/3G8a/G+rl
 UgqxveP+E6jVahjPB4etmB9yUrW9HUuXUfcj+RKdl59Z/dvh+uCKSp7itEuZlikTCNZI
 E4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607997; x=1732212797;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMbR3P++0JSi/If5NZ9INTKMyPYQuQ11n1dDhCwQ/w4=;
 b=mkm5jF8wOJGvtNW1xklufw+rqPolwe5MfMT7/76XWZ8hHoT8mVjUdyUubQLk2OB2jm
 NQbZQexUsWDD/4HNiKXtvx2z2VvHPam6u5pm9lCy67yUe3pegzafFfJmw84s+1V8ZAB6
 9ktKyF4FDVPGYO/yImRIX7LWm8TUcA1KzGF2Z4y02wHWXDEr4CauhzARRx926DBVlnJC
 4l+DKt7OElEFsUfzd7e2ivZTbO21HPYKHU0bk2dltLIJ6U/eLkRxXdm92EW6vCAjGglJ
 EXPFAcZ8w/UjHI7UrtlI/qYFcBxyQGOYtBc69SvUBONRw2SitVdSlHYgRaSttJRdXxl2
 RPrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmG4GbKAhWbWy4jYMe6l/N+7DvtwlH3vRfF38D0zaW2rTnvnGDEHjAHhDO6FyR4nRbUbhOmW8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+og+EBev7Sx558uHFuCraVHCuGQTiYQeVHMR4/lWfVAo1bLCy
 V6m0Q3eaomAnEj8RltmqgRkhtZFRHJD++N/j6lhVPS1aRopDYlYeWFhOvBXtRrM4vV+XAwtxCny
 Y
X-Google-Smtp-Source: AGHT+IFesTSyJDi14U8x/luGnsXjJFtGOl1pkRuprA9nirJ3g6uUMoZlxb4v0YMMEUKjhN7QP7pBJg==
X-Received: by 2002:a17:907:7b9a:b0:a99:8a0e:8710 with SMTP id
 a640c23a62f3a-aa20ccfe85emr309844166b.14.1731607996425; 
 Thu, 14 Nov 2024 10:13:16 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241017-topic-sm8x50-enable-pinconf-v1-1-a70ddf492e87@linaro.org>
References: <20241017-topic-sm8x50-enable-pinconf-v1-1-a70ddf492e87@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: enable PINCONF
Message-Id: <173160799558.3344230.7521012119425222449.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:15 +0100
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


On Thu, 17 Oct 2024 10:04:54 +0200, Neil Armstrong wrote:
> The SM8550 and SM8650 SoCs requires PINCONF to properly
> setup SDC pins in order to function correctly.
> 
> 

Applied, thanks!

[1/1] qcom_defconfig: enable PINCONF
      commit: 748ee6344fd4896ec9370ac9c5f59578aab11a2a

Best regards,
-- 
// Caleb (they/them)


