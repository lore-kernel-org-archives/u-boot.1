Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B83CCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FAC838AE;
	Thu, 30 Oct 2025 13:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/lTOC3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9566083893; Thu, 30 Oct 2025 13:16:34 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70114836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso200192166b.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826591; x=1762431391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svg8Rx0+x46FgxozM+MHXGN8WyNlROANvfVTfuzsJSc=;
 b=B/lTOC3hUEBWEx5295smcuVX6LVPH2ZXxpKNTeiQRnREyo/mOhpUfSS1Z0+Xco5lHT
 MWTM9VfUIzAkjXhSxRu5Wu7m/7KCiqyHXn8QxWAiVgNnLTJ6GhOtT72ETtnxXf8iDK+0
 tykS+j/RrvuKOe5t9gvk4STXuOcahteJA8y1tjjz7MW0ffaOyf3nl7//iZc9AnSJqnKP
 OddAAVwFinQ9MTq7pt5msuzvcYonaFRSHPPPJATeWtONmE/ILXIfk/RgPCyCRhyN0rnb
 fwE4Mo7CMIW+2fyWhNYp1LXfqPvuH86eWwDXFGjou0bvemGvb1/emLD8c/GCUmLPQb5q
 jbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826591; x=1762431391;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svg8Rx0+x46FgxozM+MHXGN8WyNlROANvfVTfuzsJSc=;
 b=w7xs+cHTeZ4v4+qbplYVwsYKLZshL8ae+bDI1CCxk4RLBz6Fsxr0oqW2iDnFqpQIif
 lBaIftHA/3lgrVdGnJNdJeiG/ZUDPhvCnTed2XIvSHuO0NzyJMnR66wpY9CsD2BySQ8h
 yBi99iT/4yZe5LtpkD4XrWF1vTumepPTH9sg0UZajWY+1LugnG660Nsh8SevIAdKaFIZ
 hgUG7LlWuzzBzVxLWeDpLUHfKywAJYRaLxIPSx3Ne/YDxDAMxrFGwoDoP4j71E0AowWv
 52DEicXS16H0lHFF7WnJyguAm2sToBzkVT0LQ98J52bHxOhkUYBGchdjFTrp4BfU9uFT
 x+6w==
X-Gm-Message-State: AOJu0YxzXULWyV6G6OLYlnm6YvX/Z0/8C8jFRxPi1H/zsrfz1hPheYnm
 LQeDxJmpcN9b0wCjtbixgle8yKhXnUvYyMh+Ca3I0f+oBqkHfISTxDFKBrayytVdFEOBDSbqMRf
 uOw+eL9g=
X-Gm-Gg: ASbGnct53UPzSxY5A7cAVw4beYk/lIkJCplccya+1CdU06SYLpKjIQ3reW7bBLjhsot
 BdMYJuN2zfemd1NHT3xFhd7Og+g0i6saFynYUwkPCCV2I4M+GTLIMsrUKlmaUQaONdYCuZEdKzh
 mDsyk6pda8WAIrd9TfGtzn6h+nvb7zUDcY/CtxF1m6d7f9apJcvQUivYHHa1DjcasD74xhGq6lU
 CkhnLGc4ZMhH0KB2xL8MoF5feBJi001TJTKGAQPeai2PL96ilpJxooaK5hYpI8D4gkLjxaEhZ16
 iLz1arYilkrYOap0KgCKcukJYrgpsoRBDGozwjBg4C8IXdLGxOHsPjcovLmQZXWfrQjxPXXIKOP
 disiIPSO1xi16ceGoRgpl3619h4973VXwmqL62xqnjyqjQvOuiqk9NunNG8gCj7xwieb+5CMvUX
 DmFe1weMm5CyPR08adkcKWjS24/+2kdd3Wsgf1Fw9T5hptFqjxh4rzSeicpEKzbVs/Hg==
X-Google-Smtp-Source: AGHT+IFejkEgLokw+B7uN89wCPGxhJntdIw3U7sjT9CyPTKryq98TPTbl3LFNJ7OOWsZYVhCQh23IA==
X-Received: by 2002:a17:906:7946:b0:b4e:a47f:715d with SMTP id
 a640c23a62f3a-b7053b6a8e3mr290890566b.17.1761826591428; 
 Thu, 30 Oct 2025 05:16:31 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:30 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
In-Reply-To: <20251003203927.1030052-1-trini@konsulko.com>
References: <20251003203927.1030052-1-trini@konsulko.com>
Subject: Re: [PATCH] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
Message-Id: <176182659016.4111945.2175527841417533160.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Fri, 03 Oct 2025 14:39:27 -0600, Tom Rini wrote:
> This PHY driver is required by USB_EHCI_MSM and not useful on its own.
> Rather than have it be a prompted option, it should (and currently is)
> select'd by USB_EHCI_MSM. Remove the prompt for this option and then
> correct the dependency chain (it must select PHY).
> 
> 

Applied, thanks!

[1/1] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/603b45b0f118

Best regards,
-- 
// Caleb (they/them)


