Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4AFC982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A16839E4;
	Fri, 16 Jan 2026 19:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BVaD61ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2361783A8D; Fri, 16 Jan 2026 19:03:22 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82FE836AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so4190831a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586599; x=1769191399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwPhugy2M94yoPzTSPXeOtRKacVr/MN+zcqMge3/ZU4=;
 b=BVaD61ctfFEpZCMrBncKZS8avkRhg/258iIYdp/I0GDEhaglqTJJKZtqrS6/XPTcUX
 PZ4ghVwy5Nr5i3JWQ/+lVgFT/kdf9YCDt0vZraZsK+BlFJyUwZMkINxBXBbTpdkcCT9M
 uUjuzej7zKXmlZE348nkN6NW4sc4HntFBnbscDA0WNuViEWi6rklnftub0lgNeGClSId
 7HRO6Agza1J8dpFuGbvNUa3D4vIdzgffGngCj0Wt7qLVjOhhu4cghamJVKKHYnv56Nmv
 RbLfuuDBmivzmqbcul7kmhp8FYFwi7fH0e+TfvbWHPaAdPqfFc0pijf4oFHO8o8VTmHF
 Gxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586599; x=1769191399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwPhugy2M94yoPzTSPXeOtRKacVr/MN+zcqMge3/ZU4=;
 b=fuCRf8cBZ7sDaE4ECQ4jbYmYehxzJ3xikcFbAaUIcwcwire1vU2i8ZuxuezZoSbUHa
 xZZ8COUjpDgWo2eRqygbyKrRxWB3vATW/m3T4piRnOYDNa+YN3PsiLzsbwBhNCsOPedX
 lM9D7vZrv3lLrWPZhaKieQMPfwO1lqqGa0R/NXpxgN2jcOdYtofK+1UkWdj9udSiFQRG
 aNmP3GKxa2wYhQClfl6ApQNvUmE2uoNYuMIZ1PBlZXjlHjshbuG6cUUwNLkPRFXhh0ad
 qDhal6XGAdiUTm5A1ReS8jhIhTKcP+nytrlgtFKLq2351ctEpz5/aq+xVvIo0RIYXKx4
 qJ8g==
X-Gm-Message-State: AOJu0YzzSTGcI0Su49lniQ8zwMqXy8ashjEsQJ3dtT7LZ6jJVSHKvhxl
 Xc3Zok76/ZRJhBRgwS4gw2xqyi/ONZANmqjjF5iGrA4ELdOoehO/tXOx+fbulKCXFYtfloBUCDd
 p+XkeFd5Icg==
X-Gm-Gg: AY/fxX4y21i/KvbMSZia0e3PhOPeMDDA49iQnIzNnnz1XbqhPN+ZDDxYySTvPDm/fUB
 +fI62nwQKU5TxoXcvTZDSD4f/70OjZFhHYhMuQbZdSJvTC55HlTTD0m8s4vastGaUdwDNl3tKIf
 TqZdXSrYGmEOwgvpG0dCx+wSigQVowdUM1QSjL7RyQZEYG7WNqLSt8iOjb8F9dBEhoqONdiJiOB
 9X3HGcaGUZLtYlTRby7E+/GbePPTS3x8fUjRMm8g3WQKrbw4KetsSIs9/BdH1fu59IJsqsQ3Gu6
 KpYCQnucjpvoespoS5MiHL1BY57nJ9TAk6IyTzObw7FxDT4JBsimQaWPBUu5JZAlqvY5Vng3CTX
 zkLZElt/g8K89FZTGMpb9P4Hpkfs2CvV5TgZJzCF0B667+20+tbM6q1ELM44mhcANZQHKKOakKk
 tvHzQlw2i6OJuLE8bTRNMzTBcGIQwRUMh9yP1CwNiyFs8jx/3uE8fO5A==
X-Received: by 2002:a05:6402:5193:b0:641:78b7:d326 with SMTP id
 4fb4d7f45d1cf-654bb61b16fmr2594742a12.28.1768586599278; 
 Fri, 16 Jan 2026 10:03:19 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:17 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251114144722.173021-2-casey.connolly@linaro.org>
References: <20251114144722.173021-2-casey.connolly@linaro.org>
Subject: Re: [PATCH] phy: qcom: snps-femto-v2: assert reset in probe
Message-Id: <176858659759.3399278.10153338374373746761.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Fri, 14 Nov 2025 15:47:21 +0100, Casey Connolly wrote:
> The power on function for the phy only deasserts the reset, so the phy
> might be in a weird state that we don't clean up properly.
> 
> Assert the reset in probe() so that when we power on we will have the
> phy in a clean state.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: snps-femto-v2: assert reset in probe
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c9c61c1f4e74

Best regards,
-- 
// Casey (she/they)


