Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9103BE7C4DC
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C2687587;
	Wed,  4 Oct 2023 18:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AAtmCeH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F5D8757E; Wed,  4 Oct 2023 18:06:13 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773B787552
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso3955258a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696435571; x=1697040371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pen+iO+M2gIPTh3d/Qy4b5+52uIYKXLIWWiVeTqgDBs=;
 b=AAtmCeH6+7bC2WX6R14wEoT6lKY+lWi18WqU/VducODavvCOp4oQyoTTGY3T5JgrV7
 SchMhZX3y+Y/Z5WoCD+9xh+FRx66Q4tV3VJfpDaqsIqhTyblNyBDtUt9OtRVP7ZsWlWl
 EFjIjFHFmO9s3f2dNUMsSAXFvH1/rtaMIBUxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435571; x=1697040371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pen+iO+M2gIPTh3d/Qy4b5+52uIYKXLIWWiVeTqgDBs=;
 b=DOkaijvmk8cjUIX8nJ8waaVjC15/LFouk/9ibk8gmekYZ69wdlR3ky/mCd6EPeQeIG
 VwtSFGmYdd889bXDJDWOjZvO9InewQvVTcD78NDVTs6Mhyhy4HjwcCIfQJ4pjcx1wwoj
 Gx83ybqYYadGu+H4sc/Xqy8KGyYeSYipJV4HAzOBnHnnbtpA2U/2HtqJrptedd9QGPBb
 lyH7yvaTOluuCDWCobE7zcqQFK9H70e0YzjUY3x250lJECC4ZdZKUNxDyb66bXa03VtL
 tGYe4wqG/sQbaconrYUak3LhlvjzD2uc8VyIcAsKJxFcYYO0NVCDLi5m85Fmrln9Ulgq
 t6BA==
X-Gm-Message-State: AOJu0YzwMxqqvJyNY/jWMxxXUolAFswY1AAz299baRmopXQgBNPsYw0O
 NzOfmufXk7YeOLpJW6mJzD0MrE2CO4uemlBq+hGeWQ==
X-Google-Smtp-Source: AGHT+IGC+HjXrGlVggpLaITJAvjTLO3ivScXGdLTl7cSIhhUny2iwKVgBzqzdOgwmGmUkk091aGpHrbJD3kXd8yip/Q=
X-Received: by 2002:a17:907:7613:b0:9ae:55ae:587f with SMTP id
 jx19-20020a170907761300b009ae55ae587fmr2416199ejc.37.1696435570826; Wed, 04
 Oct 2023 09:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
In-Reply-To: <20231004113458.531124-1-mwalle@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:05:59 -0600
Message-ID: <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
To: Michael Walle <mwalle@kernel.org>
Cc: miquel.raynal@bootlin.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, ptyadav@amazon.de, rafal@milecki.pl, 
 richard@nod.at, robh+dt@kernel.org, robh@kernel.org, trini@konsulko.com, 
 u-boot@lists.denx.de, vigneshr@ti.com
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

Hi Michael,

On Wed, 4 Oct 2023 at 05:35, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> Add a compatible string for binman, so we can extend fixed-partitions
> >> in various ways.
> >
> > I've been thinking at the proper way to describe the binman partitions.
> > I am wondering if we should really extend the fixed-partitions
> > schema. This description is really basic and kind of supposed to remain
> > like that. Instead, I wonder if we should not just keep the binman
> > compatible alone, like many others already. This way it would be very clear
> > what is expected and allowed in both cases. I am thinking about
> > something like that:
> >
> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> >
> > this file is also referenced there (but this patch does the same, which
> > is what I'd expect):
> >
> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> >
> > I'll let the binding maintainers judge whether they think it's
> > relevant, it's not a strong opposition.
>
> What is the overall goal here? To replace the current binman node which is
> usually contained in the -u-boot.dtsi files? If one is using binman to
> create an image, is it expected that one needs to adapt the DT in linux?
> Or will it still be a seperate -u-boot.dtsi? > Because in the latter case
> I see that there will be conflicts because you have to overwrite the
> flash node. Or will it be a seperate node with all the information
> duplicated?

The goal is simply to have a full binding for firmware layout, such
that firmware images can be created, examined and updated. The
-u-boot.dtsi files are a stopgap while we sort out a real binding.
They should eventually go away.

>
> Maybe (a more complete) example would be helpful.

Can you please be a bit more specific? What is missing from the example?

Regards,
Simon
