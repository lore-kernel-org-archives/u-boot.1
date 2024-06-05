Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3536EC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 07:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F07F882F9;
	Wed,  5 Jun 2024 09:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QKwI4c8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3346F88193; Wed,  5 Jun 2024 09:11:45 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C2387AEC
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 09:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c2039db0c6so445905a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717571501; x=1718176301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oiDMEm1WZUVQEqIWu8GK9jLLuuAINZIDc35lxR1Jp9w=;
 b=QKwI4c8NG5ZXN6KG7qEG58a2TGUcNqq016S0hjHPf+da8E1sc7RF2Gkk/WtqaQJHm9
 LMoqjZq0/HU7rd8YIzdcD+vzI53Nm48PwB1JcswFgzR9JrlxkwkMxXLs1L5UTHRgtug6
 Y59tc9+b+sFVaVyE0mzt1YiVaAP3wMoDK4+sKBrvuxRp1OPnJgVddGpD0KodDf5Sm1X6
 fSwhUP9owNafe9vIs7Y7fiYSg4pyW1EM8xGzVQQsZX+mEyH0Rf4PTrmO1Y9uyjHi7KWM
 eN1UmZ0ETdG39Q7Ri4+14ERjWJ7a9ugl4EI4Hlhk7o9yXuBvJsn1UsLkJXPSq7DV0m+V
 1UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717571501; x=1718176301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oiDMEm1WZUVQEqIWu8GK9jLLuuAINZIDc35lxR1Jp9w=;
 b=gaWcaxIsDb1/KqmOnnOkYZI+VRtgP/dKDtrYIQq37EIvH5XUoTtfkIcnOOOTzvXaTE
 mAPjU3DGT4rlvTttrnoIy6iS2u93a2ywe3WGxToAxqeTix/OpM4/MgAzmt0xKHsHO+bn
 dknhZ2LnBncRqB0gxi63UIHL7sGukxcf562xv7NQekenXbrZy2bg2AKJp602LoiBx6Kc
 WkD87xWRneFyNOJkiBXRao52eEeflVdbSDMjVlBW/UvegFFpjxUmNWOiy45bkqj1cV/m
 911N8ENGKlnMFMMu6I5oBgbQSnkHwDye6l98f/4kZPu928E6c66P9KyVMbJWaTlwa2T7
 FqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPWIj7j2YU3AFCnk1csMefyAVxSo4yL2x6/2xS1fgav8kJo5NjomH3wZgKW5KsyFw2YSapSxGry28UeakpKbzpnHM7g==
X-Gm-Message-State: AOJu0Yx+rGIzEAQn7fwTxASu6YGIVIaf9+LL6r/plqyCAsSguWHUQ6DK
 8uwZ898qB5SeUD0HUPVSI/76T9LcAOuoXUKpqsDEdNx2iskw68OAnQn+UV8ngzkpmTVKK8n2P4u
 UfHaiJ/1nCeXpmtVcvqOT95t2QDKnqqxc1sPadQ==
X-Google-Smtp-Source: AGHT+IFqbLj7/Qp8/npIS1d7oseYtGg/5+ThHBFzLKxGZ/VdUzuiU82ioJJWJm7sZXmf9xN9IB0KkaD3g9ka/PCHaow=
X-Received: by 2002:a17:90b:234f:b0:2c2:4107:4cb1 with SMTP id
 98e67ed59e1d1-2c25310879emr6285987a91.24.1717571501026; Wed, 05 Jun 2024
 00:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-3-raymond.mao@linaro.org>
 <CAC_iWjLhKEcFzNpAAms66+BYFOT_Q3AA2LBdOupFU=cXSVRXBQ@mail.gmail.com>
 <Zl90teNwRIDtgiKR@smile.fi.intel.com>
In-Reply-To: <Zl90teNwRIDtgiKR@smile.fi.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 10:11:04 +0300
Message-ID: <CAC_iWj+7MyQnN7b+e1egFCuur0wjsMuBL9FKbGYvFAqXzdk-2Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] mbedtls: Add script to update MbedTLS subtree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 4 Jun 2024 at 23:10, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 31, 2024 at 09:32:38AM +0300, Ilias Apalodimas wrote:
> > On Tue, 28 May 2024 at 17:10, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> > > commands.
> > > Usage from U-Boot top directory, run:
>
> ...
>
> > > +    if ! git remote get-url mbedtls_upstream 2>/dev/null
> >
> > if [ -z "$(git remote get-url rigin 2>/dev/null)" ]; then
>
> Why? I mean why do we need an additional `test` call? Above can be transformed
> to `foo && {}` notation to get rid of if completely.

That's the usual syntax we have in other scripts

>
> > > +    then
> > > +        echo "Warning: Script automatically adds new git remote via:"
> > > +        echo "    git remote add mbedtls_upstream \\"
> > > +        echo "        https://github.com/Mbed-TLS/mbedtls.git"
> > > +        git remote add mbedtls_upstream \
> > > +            https://github.com/Mbed-TLS/mbedtls.git
> > > +    fi
> > > +    git fetch mbedtls_upstream master
> > > +}
>
> ...
>
> > > +if [ "$1" = "pull" ]
> >
> > "$1" == 'pull'
>
> Why? Isn't this bashism?

You don't need variable expansion here, so I don't see why you need
"". Unless you mean the ==, I am fine leaving that to =

>
> > Also on string literals, you don't need "", 'pull' is enough
> >
> > > +then
> > > +    remote_add_and_fetch
> > > +    git subtree pull --prefix lib/mbedtls/external/mbedtls mbedtls_upstream \
> > > +        "$2" --squash -m "${merge_commit_msg}"
> > > +elif [ "$1" = "pick" ]
> > move then 'then' one line up and add a ;
>
> >  == 'pick'
>
> Ditto.
>
> > > +then
> > > +    remote_add_and_fetch
> > > +    git cherry-pick -x --strategy=subtree \
> > > +        -Xsubtree=lib/mbedtls/external/mbedtls/ "$2"
> > > +else
> > > +    echo "usage: $0 <op> <ref>"
> > > +    echo "  <op>     pull or pick"
> > > +    echo "  <ref>    release tag [pull] or commit id [pick]"
> > > +fi
>
> Sheel should be written as much as portable and less verbose.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
