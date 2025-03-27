Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36487C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94602805C8;
	Thu, 27 Mar 2025 15:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pyq5h73B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27485806FC; Thu, 27 Mar 2025 15:43:52 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DDD8003E
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912622c9c0so134806f8f.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743086629; x=1743691429; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uMrtt9MGHB+GgSpasp7+Hd5A2YkIj0NYBxBWc3kXz68=;
 b=pyq5h73BwrIlyt4GPrxzZ8JUrr8dDZ5SbPv64idivmmn005lc/FCWB/mdd3tSdOEN9
 8FibnxM390ZlsZ2Wet4l666f+Umo2xJuj+Yh44/AKo3zU1RFzSLR4btLKqCPXwM3R6Wv
 BRYRo+X4gfNgvYvMGE6QuBiylckmOmSj7YmmmBWMNjxrrta39VrMm8phUL29ZAXgwW+K
 8pMko1wuxeCN8ARjgAUwAVUDM2IPNgSe9+c7+7PEdYz/QCH0xx9wR44C+wR4l9V6d9+w
 IHdyzY1ADAlw/43zdSdw2rOMoSrFlMqsp2F3slQZvEZDS/OJJT5up5Rv5bPTOwneIsb4
 dvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743086629; x=1743691429;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMrtt9MGHB+GgSpasp7+Hd5A2YkIj0NYBxBWc3kXz68=;
 b=lWOyBI5kyKt8S1+EK+I8jmzQuTEpa8ek4PkocjTxQKD8Z9iaxxl7/c85QtioJDD2AV
 bkYvnmfzLjC5NEmhM/CbqnV2FMoYZ0mH5Eo4jrhxw9p3wgd/F/nNeFb+Ik6ozaVUYMdu
 ZVUuGeo7EVsDYXOsgOSGKk4m251R4/NMaW43nfk+W9/ujzjFRZhs96lVPgFaZiPI4Yew
 8EehG9CqwLOkFtyNgyKIR6/SK2lU3/Qm08LvTM8O7kkQbvkDB2D5l9F+lLQrb7+ecEuK
 iqJV9XascDVciXGososgtMWxYk90RcVS00CKPB6e3MSSS31LGvM3KRMrkR7GubbFUBEm
 Ar7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeYNFvpqj84H4xyG2Pv0rIzsmRTCLefGql+nYMvcN/YGN8S1VM5h9T0pbA21UhY5To21vT+3s=@lists.denx.de
X-Gm-Message-State: AOJu0YyYlQLgtVCgX/w7B0FOdlsnFw3xTYO1MuF0JrdiRvUkJGVfLsd0
 hm09rmCkfjARiR3eUfPvlDwWS6VN0yMWFyoxzB3BXJX3wR0+5JSC9M9xVFWOCso=
X-Gm-Gg: ASbGncts6eYE62lzAH11FxAg/TNFj3c8eG9WJnA+mWoLtPxtBHjH9sWtU5LOMJrz7d5
 CGJ5KrmFHI+uaRtWHAN/8PhnvRYNqTurDWeQen65bj0eYW3J3MyUfdzqkZVQc2gPsDvgeb+o+7e
 q4mLl2dx5hcLbt3SHcmI030c+pvXfVZgAXZETAbnx7ekVQf4WLBE7lDhh/OP87Q8yScqZGl9FRi
 2NniZiYQ64l1nMj7IOC69EkEccgYDXG8ZRO/Gf8pLRjlg9T+SCFQVGRy7LmY0Krxd50h14QcuMo
 wVPJrwZszC/F/D94ZkAquonCeYDe4ORBNCmm0a9R/sV5oH71XxGXrATq/wtgzHs=
X-Google-Smtp-Source: AGHT+IH5gEEqVNOKddBaHRSCNfmG0dcGSJq8SYToe+/iJhXdKw7b5RnD3aef1/1t31q+234LqUqy8g==
X-Received: by 2002:a5d:5f82:0:b0:391:320d:95de with SMTP id
 ffacd0b85a97d-39ad2ae251amr1065489f8f.4.1743086629253; 
 Thu, 27 Mar 2025 07:43:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5193sm20468952f8f.55.2025.03.27.07.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:43:48 -0700 (PDT)
Message-ID: <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
Date: Thu, 27 Mar 2025 15:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
To: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250314185941.27834-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 14/03/2025 19:59, Christian Marangi wrote:
> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
> should not be placed here. Value is derived internally in the user
> driver.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Please drop my Ack. I have never acked such patch for uboot. If I did,
it was by mistake - probably you CC-ed me for some reason.

Best regards,
Krzysztof
