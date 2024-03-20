Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF0BC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 04:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5602A87F69;
	Wed, 20 Mar 2024 05:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yRLkP6RG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0901787F69; Wed, 20 Mar 2024 05:37:56 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABD787E1B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7db1a2c1f96so3164137241.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710909471; x=1711514271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=csF+IRM96vkrq6Pg54Hst4bVgg3TiL0T8RSvb4rdI7I=;
 b=yRLkP6RG35QTPzVSo03FozqSDOrNmNmgkeAQyCdvpT3swRfolTlbXzNJB9ZCvNHfMo
 1Ny9FOG1cfkbdS1NS1eBM6EA7Ugz4sM7nsrABWxZO9ZVaZDDMtTzu/pNl5U5237O+/QM
 eNbUt050cDu8aQX1PuCmt/7lgWIb9mAuxvURELo7k0dZcrrjGUE2cgY8ZVtWqwXsIUK1
 s6zE0woRSwLPKYNSdItkH/msZ01OerdmK9DJ2jObux6AXCUPDxXMD9kPVUubGKbO4jti
 OkCGvE7z6hnCz9R9qHZdO9g3ebcLM6IUa9V3OCqB2y0iiDYCgla0IWcnZnwPRN+fxxm8
 YkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909471; x=1711514271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=csF+IRM96vkrq6Pg54Hst4bVgg3TiL0T8RSvb4rdI7I=;
 b=hbM6OZa1riT2SMaTSSULljgnDJgXEjj2vAQPeZ+VgveowcgnZT37djWKsTyTK8wtFq
 zoSWFGvc6cmUjkZa4fg4kmJA/DI6ei70PmLqmRNehcnKh/ZyZzOrTkF2PWppSQrIldG/
 2lo+RX+1OkLWdvzT+Ux1GrnZiefeuLNbbMV8O9Gcw9f7TrxQwVH36voqLcsGL7pB9j0I
 fWwbKPbS7xS9a1ZWpsGaJ9M8I+Gxv/dJZxdqNnsYm6LqIAEvkVaesAidQZ4EAoPG/xQl
 SQ1wNiJ8G2w4KtjxwsNAlq2Wic8M620Vdl+YjKp4h0qIxd3QvQMf4IFAz7UBTfKeReTD
 q6BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVnx7cE9176tO8qcBefjSy53djyo4tgCdKIMQlP5zgvP62lHOL2T2s9sDZ+HUpN8jVQvI0PG6iDRwKQY8CD3ys8QPceA==
X-Gm-Message-State: AOJu0Yx3aNhtwfJZQ+4O+9RRLbOLuybZORCq14LfqHLnkBDTFl9brA69
 pnS7DvyblC/zF/HDvF5Po5tGD1jOM6HaZDnTnaAb2/WLxBLsbGeAuCFyzg5EPxiGmlaPp9A7M+7
 54z8pwIMWlbhc+51Q21WFduhasEfBuTsdU9WiXQ==
X-Google-Smtp-Source: AGHT+IFF6BuiI+9n269k16A5Q4E++3RaoLIG+p2DRsMpaPhkMweJSYFM4mU4zp3e0jFuQwjL8IgVzBRlckHpO8ATRZc=
X-Received: by 2002:a67:fe17:0:b0:476:6a1b:ebbc with SMTP id
 l23-20020a67fe17000000b004766a1bebbcmr10842449vsr.5.1710909470934; Tue, 19
 Mar 2024 21:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-10-e1b38d9b4fa4@linaro.org>
 <CAFA6WYP5Mm2PsBJe36jeP7zVHWmj0igwoVWp=e9r+sKcx14zSw@mail.gmail.com>
 <33f81c08-aa1d-4519-ad8d-0876480934c2@linaro.org>
In-Reply-To: <33f81c08-aa1d-4519-ad8d-0876480934c2@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 10:07:39 +0530
Message-ID: <CAFA6WYO4_Fkjp0QPLr1APMVVkZjxkz4EhzrKRXHBP_+rUonRZA@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] mach-snapdragon: fixup USB nodes
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 19 Mar 2024 at 20:15, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 19/03/2024 13:49, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> We don't support USB super-speed in U-Boot yet, we lack the SS PHY
> >> drivers, however from my testing even with a PHY driver there seem to be
> >> other issues when talking to super-speed peripherals.
> >>
> >> In pursuit of maintaining upstream DT compatibility,
> >
> > I can understand the reasoning behind this but since we enable these
> > fixups for every Qcom platform it may turn out to be counter
> > productive. There can be embedded use-cases where bootup times have
> > stringent requirements. Also, depending upon CPU speed/freq the add-on
> > times due to these can be significant.
>
> I have measured this on a few different boards:
>
> On DB410c, the slowest board we currently support
> * of_live_build took 7228us
> * Fixing up USB nodes took 131us
> * Fixing up power domains took 88us
>
> On RB1 (the slowest new platform with a QCM2290 SoC)
> * of_live_build took 2078us
> * Fixing up USB nodes took 39us
> * Fixing up power domains took 27us
>
> The time taken initially to build the livetree is likely made back as it
> is much much faster to query than the flat tree (as you can see, walking
> every single node takes <100us on db410c). I took some rough
> measurements of the boot-to-console time on sdm845 (see the "enable
> livetree" patch) and basically concluded that the delta between live and
> flat trees is within the margin of error.
>
> If a specific board for whatever reason wants to avoid using OF_LIVE
> then I'm fine with that, db410c isn't using it for example.

Okay that's fair. Let's try this approach and see if it pans out well.

-Sumit
