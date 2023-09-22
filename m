Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E937E6FE2F
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 13:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47CF8667B;
	Fri, 22 Sep 2023 15:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mZjGEW3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C0C86680; Fri, 22 Sep 2023 15:57:01 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFCF86484
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-403012f27e3so23158355e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695391019; x=1695995819; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYmcQp7vI7x84q3XTY7R5Vsp8JpMVN4Mce8y4Mffa3s=;
 b=mZjGEW3WhJWateHDPx++4uso+R/vls3bkA4QVVsJCG1Q5K1LOyh1f20DJQp5Nuts3z
 sLa11p+7OEupmO0bSgB7jRRHUpITwz7alqRYQKu/y20VJd33bqS9WpXHps3W7L6t86Wm
 P9Gnq+vn+9y0yvJpZeJzgKHV7QlADO9kCkki0zoxnHPXrhb7KgR7RCyeGoAY/i1RjqBA
 iJtnd9q+Cyw4E+ed3VCAALmUbmKs8F0gkM8gE1n9o+HEwwy0Bu/jRhgiZAubzDc39ISa
 YcEm5kJhaxXdkcaqCpgYv5sGNiu9VX2MHpaUQ56b9Y8y2oh01vK4SqsX4S6yUAY3pwt5
 f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391019; x=1695995819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYmcQp7vI7x84q3XTY7R5Vsp8JpMVN4Mce8y4Mffa3s=;
 b=v9u9iMhfzeCGO+9NL8LYdhffqQEnXWO3SHPTO6FlXUp8mw7b9gxpMtxM/NKhnxMIsj
 aNUIYTOe/HbY4mzKw1lDAw0kvzWdiqN9IAw+8jKSjIlh0SqTgLHopXahFNdefZ9KRkHh
 StQtsx1p9n2G2yHY1CZlt/Baca3hObAa6asVWmK9S1anAoDPSXM52T291smCZUqUbC5S
 qgRr04p/7Q/MPuaT7TQ5Tq6BKhuumyUtKG/sfAcSKqi3S7K9g/MyMVV9eiOAZZ2gi+E9
 xdGk1MzMw0giCvHGmKUrp27qhfNgVI9NWNrYNLZhafnIjHEbk2FHzfHGp4zhtvexRt1X
 yNqg==
X-Gm-Message-State: AOJu0YxIVaEv0A+XAFMzPgrp4NQkZC4gfXCroM/OOyFu95MAFqjFlZ6C
 fRbriHHv4cAa/I3fyC4tXSI=
X-Google-Smtp-Source: AGHT+IHETahtZVL/bYzSY6bMwgQV/TMYomewYLE+hdM2b2wIWq+JY9YvTsNAagOx7mEnUcaGH/8z7w==
X-Received: by 2002:a05:600c:2304:b0:402:8896:bb7b with SMTP id
 4-20020a05600c230400b004028896bb7bmr7939578wmo.6.1695391018517; 
 Fri, 22 Sep 2023 06:56:58 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.52])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff90c000000b0031fb91f23e9sm4498772wrr.43.2023.09.22.06.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 06:56:57 -0700 (PDT)
Message-ID: <e045afaa-bc38-4fed-966e-a034e106c86c@gmail.com>
Date: Fri, 22 Sep 2023 16:56:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
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

On 2023-09-21 21:45 +03:00, Simon Glass wrote:
> Binman[1] is a tool for creating firmware images. It allows you to
> combine various binaries and place them in an output file.
> 
> Binman uses a DT schema to describe an image, in enough detail that
> it can be automatically built from component parts, disassembled,
> replaced, listed, etc.
> 
> Images are typically stored in flash, which is why this binding is
> targeted at mtd. Previous discussion is at [2] [3].
> 
> [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> [3] https://www.spinics.net/lists/devicetree/msg626149.html
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
>  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  4 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml

This doesn't match the schema in [2], but seems more like v1 of that. Is
that intentional?
