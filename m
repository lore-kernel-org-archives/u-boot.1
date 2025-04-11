Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36A7C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00AFF84056;
	Fri, 11 Apr 2025 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yCOBF4BL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AEA84057; Fri, 11 Apr 2025 15:36:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED47284051
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so21219385e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378569; x=1744983369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rckyFnMCiPCWThR43E5Hotzn2mn90OZurqWqlzTflk=;
 b=yCOBF4BLxx+32rbJhOmTODXrnHwvcsggYknbCpUkLtgpajebNceIGgXVDCJAmRYSFW
 lWe1eVyrpHt/06TyHpXUwMM3SaKiRwbD8dx6lX4LCpCuZxHmLCQ34ILr1J7rrGbil/NX
 zG7uiG9eCqqHoQzmfSWEltLh9wgu75ZK7P6qE7zr0jEItPNX43/hQftfvRihGh4qReGm
 81EBmurzKVzyHEC82zoLWY9YWxRHTmD2IJLIsTvVwd0GpyEBBVZvVVD4fHCjafeo9Jed
 tkeieoipxrMejh9dHpQX8q7BkzEisPIFXfyyraqzjlCJaZlGrEiGCuL6dzalrZNUVxqX
 uVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378569; x=1744983369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rckyFnMCiPCWThR43E5Hotzn2mn90OZurqWqlzTflk=;
 b=ae3jbVOHwAI17uXrXWufFN4ftuDM+S4cmTUvT6ieEG2XAUG9G3VoQrI8pUFlz2XhRB
 qJUCBpaYzY0i6wGy/JEDkvSThJS7NayrPi4K737ntqD7bWYoKmuPbHf/fks1oUOut3xu
 Jq+fo6y3na2YuUNi8bocaLAegX0wxOB+JU3UI0fs3mVjn+wR7AyD/xVoBrdgmkp80dgx
 lMtLS/BGVlTAoyodv9KyPq3XvjU8kosHZFGAu2OdtykL6ydwudbKWaN/YQhhNsyqhpdd
 ln7zccuxjT3pgmoNYpIY0JvnotyBLmgY26EGEZe+oz3CE7Gvw5DV6q9btVuLmymGgLi/
 F9Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKYQVG/1LnlhpDcfkXLvfNF7pfY1SnWZ3gaJY1ontZV++PW7qErwNdOj8MP2NpeC7TEWHr2xg=@lists.denx.de
X-Gm-Message-State: AOJu0YypSucB3ZmGBP1DV0xKjIpeZgEudz9KLnlFbsfpyCdK/l5u/r03
 SfW62R2m19NGbya1c7uHd0y8/d5ZAs8KAbXYBPNT9dDlQwhX37tCYM3jk+wszBM=
X-Gm-Gg: ASbGncsjiJ5gyBr29Kve2jzBmf3O9w3IVNkBAvRI8JrT876UkK+CpDEsY7DvvIc0xs5
 DDGXjyCU5Rsd2egOQE9K4DH1lcrwWcdPiJm+pzLJdTxJZMkJe1MuM4xRM0LwqXpzHK/1+BBkPAU
 CYGU+tnAJIOmoeKkmJjmzUJUBp++cOleYXSMIkCIEQm/265E9R29q1kS3QqmYAZW6qYVqUc41AX
 xo7/l+manYEnBkXDri4hgtBTUqpXgoB0oqXDkavg+EfqVQ5QJDQVGiT+HNvRfjRm2/pLT0mtijx
 hkOPLUzO5u7T4lpUABaStpWDQyHf8u432BwrUzclz6F6CSZ3Gw3GOn18bY5FfTlmIJlFQTcqK2I
 VWrEf+ALX9vvlqmwaHg==
X-Google-Smtp-Source: AGHT+IHRt+8pMDWsY5ev5p7w7pEZw2KVdL5kzmAI+PZHZCOwvrPBi76ZKhCYLFIpAypaW308C/UqBw==
X-Received: by 2002:a05:600c:3baa:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-43f3a9afc12mr22116225e9.22.1744378569268; 
 Fri, 11 Apr 2025 06:36:09 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8219sm83195365e9.21.2025.04.11.06.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:36:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
References: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
Subject: Re: [PATCH 0/2] gpio: msm: fix special pins handling
Message-Id: <174437856706.2613234.13660793500363172218.b4-ty@linaro.org>
Date: Fri, 11 Apr 2025 15:36:07 +0200
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


On Tue, 01 Apr 2025 09:45:18 +0200, Neil Armstrong wrote:
> Fix special pins handling of get_value and get_function
> to show correct state in gpio cmd.
> 
> 

Applied, thanks!

[1/2] gpio: msm: fix get_function return for special pins
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0708bdd34d4f
[2/2] gpio: msm: return correct value return for special output pins
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8803cd6dd782

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

