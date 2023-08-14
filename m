Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE25EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A56A8697E;
	Mon, 14 Aug 2023 23:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T94Z7+rV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C820B86983; Mon, 14 Aug 2023 23:23:55 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33EE833BF
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso29808285ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692048232; x=1692653032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRskrxUmBbnaOTBcVZaQR40kDPdpcl0NiZXQRm8wK48=;
 b=T94Z7+rVUJZkLHn7G6M/piK7GefqLFwV2qF0aIFbuczRNabGkVcfPJ8SfCLG7E7UmQ
 ROcYNhUzgwy4CbgXxNSvTE985X20Tnw508ERSlggNCXSlGwkqobOgSXumY4CbOBl8+HA
 3rC5Win7mepGp9qo5eM4MukDhd9WwOGQ1g1pzAJCLSWlANfKsQ0nrzZuNqu2DyPPf0XH
 jJPbFvM6WpCL4YaeSAFm78BEbPO6ArfcSAAc/S63Iw2KZpkNm9ygyheXbyWe+ZsHzm8/
 R8jv/PW6wkTIOTt8TfdNLFZ3/rHzzCSDeMaSI4zxao4zCFDqEIRPP4bo/lPdIuI8g4SS
 QePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692048232; x=1692653032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRskrxUmBbnaOTBcVZaQR40kDPdpcl0NiZXQRm8wK48=;
 b=k8Jut/6DFmt5rIU2n9ONWtwVW7ltBFu5TqAdDU9BfTMG5DQGwZGE9L6wVRI+TE3tNi
 8jjapdN9JFX7cWiyh8VCxgTbwi5WNjTrAVq9heVM0v/9QID3YyHJgUbSee+ZHX8Q614Y
 Ko6M8iHrLDv7f7dPojPCF5cgU5QwakLbuhSggoCDmHJ6e4dS0lPZnv3YIMPUUjeWzoUG
 49S3zMXXHXfrRn1FIovl9yOnFbP5b1JnYNRqi4JVt2yw9fUbZ5Wwlqa/YC04C6U3dCFa
 VGHjjChbkwT7Tu/dFfYCZk8bXFRGxQEAKqq8uBHCC9B7dD78/DKSm8RRWGO2Nup6+MYN
 +V/A==
X-Gm-Message-State: AOJu0YxUU7WsmFZ8H6D7G/szu/8TCYnV9zdPDItmEC1FfVkuSMXssxBH
 I2silICk7yiZmxgua6esamE=
X-Google-Smtp-Source: AGHT+IH11Odh/W3eaE9S1EFkhQG3SPxbM9dNytIpo65uBcrRxAozkDzrB0hobhUoqLe3D+6QzDTQGQ==
X-Received: by 2002:a17:903:191:b0:1bd:b8c0:b58f with SMTP id
 z17-20020a170903019100b001bdb8c0b58fmr9218847plg.50.1692048231862; 
 Mon, 14 Aug 2023 14:23:51 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 u18-20020a170903125200b001b53953f306sm9919002plh.178.2023.08.14.14.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 14:23:51 -0700 (PDT)
Message-ID: <154df0c5-73fe-7a59-41fd-6bbb53ebd471@gmail.com>
Date: Mon, 14 Aug 2023 15:23:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] sunxi: psci: clean away preprocessor macros
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-2-CFSworks@gmail.com>
 <20230814173714.61bd09a2@donnerap.manchester.arm.com>
 <1af2d8fe-0516-e67d-15b8-71248ac80fa3@gmail.com>
 <20230814220521.364addff@slackpad.lan>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230814220521.364addff@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/14/23 15:05, Andre Przywara wrote:
> Yes, I will add this to the header file, either defined as 0, or to its
> actual address.

Gotcha; my v2 will also assume you've taken care of merging these guys:
+#define SUNXI_CPUX_BASE			0x09010000
+#define SUNXI_CPUCFG_BASE		0

(As I presume from your comments on 3/3 that it's better to consider 
"CPUX" simply an updated CPUCFG than to distinguish between them as 
fundamentally different concepts.)

> Yes, but you handle both above explicitly.

No, I was passing a NULL clamp address in those cases too. So I'm noting 
that this must also be fixed in v2.

Thanks,
Sam
