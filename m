Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD2FE6FE41
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2FF86199;
	Fri, 22 Sep 2023 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bQtnha3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5FD86290; Fri, 22 Sep 2023 17:10:04 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1D585DFA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-503397ee920so3680786e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695395402; x=1696000202; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eBbLfmPpKzgVoeBpgucGlr3BpZFPgPf0mz1waJgwt2Q=;
 b=bQtnha3hGJogxh24j2gA9A1fXKh9j/XaRF7yO7JbiPliXa0UN2g/+1a66z8q08qAtz
 xuteeaexLPFp5QbRkj6FxfdFnkbKXFk7Aok+wjnyLK3GfceUnhf5ImDbcs5+9TbtiRB1
 wBMUZ3VkFo27kNjt90totvnhnryL98177F+x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695395402; x=1696000202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBbLfmPpKzgVoeBpgucGlr3BpZFPgPf0mz1waJgwt2Q=;
 b=M6Cu8yNU+drXY0plG8HUpvw6kt6MVUV0laKv31Sir41+H2IOl3eQQ7dJZ/nxy+I55a
 142EVqrYpWDpWneu90i7BI1hWIRJFxVawy7AYWvyPaNfOJZ2UpnVwA7zravZgcp7qsZy
 Dl7bL3Zl3uj/7jOejqDaskoSnUuHu9jmIEvR/PEdWQnNeCeLIDN865niag9KzDjA6/MI
 0EOGn0u6ssNl7i0NXKfj3QPSp7bM921qiKabYG2HFO3QlQfZ+pgBKuMoMOnCS859KPl/
 cCHMmCFXKdbTjuNEkwrYwLJDa5Lq7ePYt+vkFIwimgbyHmHhsK09lBDK5VlyBq7Jfapr
 2T5A==
X-Gm-Message-State: AOJu0YyONPXVruZpb675NJ/MXT8DvkDN4qt4hGk0VAxpshKIG6gg1xnE
 CqpAzrMHpexR8mEcBeUZR5+IL2DcfhgyPwCJb6BdT1eQOBxe7cfvAoU=
X-Google-Smtp-Source: AGHT+IG0+FTwy7leUuJNc07mqM4ZpBxga4kMOkpvPH1KKuybgHujWbeNV789s9axdxdQeWXDb18UprYq/1LXcelxM4U=
X-Received: by 2002:a05:6512:449:b0:4f8:77db:1d9e with SMTP id
 y9-20020a056512044900b004f877db1d9emr7510046lfk.12.1695395401203; Fri, 22 Sep
 2023 08:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <e045afaa-bc38-4fed-966e-a034e106c86c@gmail.com>
In-Reply-To: <e045afaa-bc38-4fed-966e-a034e106c86c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 09:09:50 -0600
Message-ID: <CAPnjgZ2sN1bRKOFpDXXc0QfYsiHMxEFR8K+p=swLWs8ZCQBusw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org, 
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
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

Hi Alper,

On Fri, 22 Sept 2023 at 07:57, Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> On 2023-09-21 21:45 +03:00, Simon Glass wrote:
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
> >  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  MAINTAINERS                                   |  5 ++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
>
> This doesn't match the schema in [2], but seems more like v1 of that. Is
> that intentional?

Yes. Based on discussions with Rob, the idea of setting a general
format seems to be too ambitious, at least for now.

Regards,
Simon
