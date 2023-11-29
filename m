Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6100CC10DC2
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 23:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A81486D34;
	Thu, 30 Nov 2023 00:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UFHQgFlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6F086D4C; Thu, 30 Nov 2023 00:22:23 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B924B863F8
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 00:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bc39dcbcbso539145e87.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701300141; x=1701904941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/HnZ3tBk4Rv10ctPha3htJ6jB9vSVJNy8j7jeHy+N0=;
 b=UFHQgFlpHxkNwpD/N8P/Eaut5hszz0N8V6aa/oDsZT+jNKsk+pdlFEf5GfFUZl8Xtt
 lq8Wfv+Qy7OXSwsaGKW9HtCZH7SOFWvzvow/ZNg7Mo9s01z/iGjte6z3dgUzwOGginb5
 kwqZXvgq34f9aMQYZiuavQJqZuf6BEUsUFHPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701300141; x=1701904941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/HnZ3tBk4Rv10ctPha3htJ6jB9vSVJNy8j7jeHy+N0=;
 b=inaIonI6cqL8dzkaUS+4UZMPdfG0/uWHzeYzYkKFn/SLksH+8pS17cFmP7rF8pwoQN
 gtxX2lXJpDDodG0uqg7oWOABgs5DNDQloRl3s73QIUglrjQ8GdjohA+gPn+oybjbtkPr
 YKuQa6TWgAiGlSlw8WoFWkJRTIAntydVZ0k5GP5uZLiumM13x1X/fk81kPzbAiamJnd0
 I7CCxC5BLsobUN6WiB/zS+ycMRmja2tAh5/6xrgDWDaCTqLLnSOBg2rMmuy1SqcHHSyK
 +FjH3qxAZam2bcX00PepwVlqpJdnW/tlijly4KWENo274aO03U60b/evFiurlZoGjaW6
 RUgQ==
X-Gm-Message-State: AOJu0Yynp5b2qLKzktwkotcunGmgR7mwILMDO56GK2bSnoNEVlMvaOJZ
 cUTL9RJ8BeDEcT+l6i+f6nyOG2KtjON8LJoZxLqoDg==
X-Google-Smtp-Source: AGHT+IFYwY557f0M/HBVYE3v9Lp8eNTCTg5oXoWdtSW9n3YuCd9BE+gko2nwt0HyJjEkoxBEYx0zOQD+alQIHP6FIu4=
X-Received: by 2002:a05:6512:695:b0:509:8db5:949 with SMTP id
 t21-20020a056512069500b005098db50949mr17477580lfe.6.1701300140674; Wed, 29
 Nov 2023 15:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org>
In-Reply-To: <20231116172859.393744-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 16:22:03 -0700
Message-ID: <CAPnjgZ0z_oMy0kDScMjE9jYOvFJ12dxWn2CRoTpTsmw7TfARGw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, 
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Michael Walle <mwalle@kernel.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 16 Nov 2023 at 10:29, Simon Glass <sjg@chromium.org> wrote:
>
> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v5)

Is there any movement on this series, please?

>
> Changes in v5:
> - Add #address/size-cells and parternProperties
> - Drop $ref to fixed-partitions.yaml
> - Drop 'select: false'
>
> Changes in v4:
> - Change subject line
>
> Changes in v3:
> - Drop fixed-partition additional compatible string
> - Drop fixed-partitions from the example
> - Mention use of compatible instead of label
>
> Changes in v2:
> - Drop mention of 'enhanced features' in fixed-partitions.yaml
> - Mention Binman input and output properties
> - Use plain partition@xxx for the node name
>

Regards,
Simon
