Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D77BC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93586806FC;
	Thu, 27 Mar 2025 15:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRAybISi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45B181951; Thu, 27 Mar 2025 15:58:57 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A73B8003E
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39123ad8a9fso40203f8f.2
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743087535; x=1743692335; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FDGeI5aIUCs2XHXajQ4y45LF5ApIBeBrSs737sSOrYI=;
 b=ZRAybISiS3n8tk8muIDsD7HYvyvpyjDo5aaijfconJZVhrxrzATtIuccg0bdHBATTB
 JbiyzA+4U/oviPhwDdJsSu+Uk6fBrXAXpwiXbQLonfKueyLSgy7mkrna/3P2TSZ0wJrV
 Jqq/oXKykXEoLpFrXsHzHZjCJPRox9OhtbjHyG1+jnMula0L5uGsumbtEP319kYXNG0a
 0Hd30bgY8B/zMk92egFlBawXDZyVXF1SoFPTriLiEerhGcXJy06dE91tVtuQHb0ple42
 PJW7c1Zrxy7WcKJ6zSffSYXMIWXHY3Gay8GR9sHhdks34sB8p5DVK0BgKW/PZF38QTDJ
 w6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743087535; x=1743692335;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDGeI5aIUCs2XHXajQ4y45LF5ApIBeBrSs737sSOrYI=;
 b=cK9U6D1cm/R+Bbfc2n4dZh3TFdqZnRWEJpaQw2EiNlUHHz61SECYR82YO1W1dDrH8l
 BurfrOREXc6vTw1z3JTSijQiG4v95jND2lyzYRuHLtB9qPjqENgth4fzrFy2xAKmVw8a
 H3FZkhI/e1xr/+KfI4oWHoGb+YikzRe1l/NKJNPpfcsQ7s7Kl9+SkLrFoSdGz26lRDZ1
 qWPVBJgCyrmo8OL7BO/cy9bFRRXxNt1AB8q9Nv8i5UokaYuQ9ZiAJcnYJeEAiyaYblml
 vCHfrHhk5Fv7utNzERXJNl9sZzCwe76/1CTSGVv70xPXQveugOHdI0sKwLL7Si6SyQie
 eDeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRYFQXV/buEQHUuJlbMgRMdvqq7E/HVkMHT+ioi3D/ujb+rAWHs9vzoYGfhBTD6F7Cem1g/pQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0hEXFbgewLosZCViP6A4c+YPu7dzrW//EAkU4RqOlplUn6mFo
 yPb81UWSN+w2dO0yb0IzBMaVZdLpkUtxBfwgFWFWOrY/HJWLUPsv23IbLAILY8c=
X-Gm-Gg: ASbGncsot2ZZavQGeFT4WQxHlmWnhJDs1/1Z1MIVLojz4B1cxZbBORk0hwhhBvDsGCi
 ID4uFvO/+Wg8aPOwV78avP1oGnK1mepBmd13SGI5TuTPWwaSq92BY2ykF0vAdcxleCaufh99lq4
 f8PFkWHt/rDrXyg8jDyX0HVG06vhdJd9iSGnHwJ+uKSPM5PEIDAw5YhHizXC3G0/nJForzty75y
 wkSHSnppnzJVDSIsj2mMJEfanUOMyWkcET/J51bTlsVObUoYOHLWE7weAfPhD5dNxBgBxT+BLOa
 4I5Z/4QPFHudyr6KBe9u2T1IEEoGa05i+fWD8+0XKyAydJtkIx5oGzgU6QxeVpQ=
X-Google-Smtp-Source: AGHT+IFxDj2SFztgREOtw8RLN//rxPSkgFZfTennijlZYYytPuPIYhd83O/RhiHVpKvzcWuBuJy8Mg==
X-Received: by 2002:a5d:64e9:0:b0:391:cd7:82f2 with SMTP id
 ffacd0b85a97d-39ad2aecc7amr1047264f8f.6.1743087534896; 
 Thu, 27 Mar 2025 07:58:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4ce9sm20372385f8f.53.2025.03.27.07.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:58:54 -0700 (PDT)
Message-ID: <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
Date: Thu, 27 Mar 2025 15:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <67e5659b.df0a0220.19a25c.f830@mx.google.com>
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

On 27/03/2025 15:50, Christian Marangi wrote:
> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
>> On 14/03/2025 19:59, Christian Marangi wrote:
>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
>>> should not be placed here. Value is derived internally in the user
>>> driver.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Please drop my Ack. I have never acked such patch for uboot. If I did,
>> it was by mistake - probably you CC-ed me for some reason.
>>
> 
> Some explaination, uboot introduced the concept of upstream where they
> "import" linux patch for dts and dt-bindings.

I expected OF_UPSTREAM to be taking the sources, not patches.

> 
> This and the other patch are the exact upstream patch with only the path
> changed so I keep all the patch commit message with tags and added the
> 
> [ upstream commit ] thing.
> 
> Hope Tom can better suggest how this should be done. You were CC
> probably because the git send-email included you as present in the
> different tags.

Well, Ack is still not valid because I did not Ack exactly that change.
It does not matter for the ack, but for Reviewed-by it would matter,
because it is a statement (of oversight...). I cannot control what you
put into patches taken out of kernel, but at least do not Cc me on that.

Best regards,
Krzysztof
