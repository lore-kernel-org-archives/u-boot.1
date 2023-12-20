Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF0C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 20:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A98B876CA;
	Wed, 20 Dec 2023 21:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yp8j5IzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DDB8750C; Wed, 20 Dec 2023 21:12:35 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD02876CA
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 21:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28bec6ae0ffso27677a91.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703103151; x=1703707951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IXbb5Y7n/t6/blF1b7RwNIrHdPB+M0zsnYUxTHdefmU=;
 b=yp8j5IzK4UpDXOy2CzWOJkFVwbn2hg+kJ0dH6Ht7PiX6z84L1r9qvRZQBbaREequ/l
 2tYF+RNXaM2vnsdXHCJiBzbapAeN1PV5ozRnk+VjLc25ktRB9K3SKMlVA6+aVtAjWpV/
 QV8X7rmEzcL4mILs1VQ/m7l2NYRSoDM8+ftwOBw1GfrazxWiIExhePnMUiIksvUJ6iqT
 aHsQKnYxFllQauOM/RiTt28kLdh7aT24Gmk2OjrYqku92L1eexqnoRbGjx8i3aMEGyCF
 FJ9H5qFZEvmoQJvdPXh+Gg9bxd6PLMD7DaSNDB6/dlyeu369OIT1se8ahALbss6VcxQ3
 WNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703103151; x=1703707951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IXbb5Y7n/t6/blF1b7RwNIrHdPB+M0zsnYUxTHdefmU=;
 b=N3kO0F+IgMy65TVBA6HvT4smN/6dt9Ix/aIc9icjAgiqxK5p3BMgdqR5jwIFrPI5BO
 GTBi0p3tCyI4wuoMJGBpwCsJ6Ein6fkOeHXEHUnUlM9OtSg+gUIeSikZylF4RulDesKx
 07kWom1AXZ1QKFW0c2C42pWjMC3RoPCCa7/ipKAtxYYP/vToLRafaPFSeBCShZoqNSl/
 2PnVZOHZP+SK4BWVJGjnmaig/qtIm8MZz8ipT4HbgzxIe0PYtI/5ojs3H3XDJTF8SEHU
 wA63lb/gzpL4K22YOHpvGx4dKq2vMAwP0AAOA5NXbSvWBLlecHZYO09bE/9nz3IB05gm
 9AcA==
X-Gm-Message-State: AOJu0YxFry8rp9LBeWOKvZg/OzUEcWn6FZ8FOQVN/pZ3xEW0CbzotXBm
 ERjsU99Sgy5x6cBcil7gbGttcJJG8MRkPpEUq+05rw==
X-Google-Smtp-Source: AGHT+IGppd6JHmEjna1Ryu7sQm0QhEU7WS7sMzsIUZZp2anYO/me5LVBfE5mj+Ak9x/wHcWKID3bPXqgBum1jVJAucc=
X-Received: by 2002:a17:90a:e394:b0:28b:eacd:f917 with SMTP id
 b20-20020a17090ae39400b0028beacdf917mr157643pjz.31.1703103150892; Wed, 20 Dec
 2023 12:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-4-raymond.mao@linaro.org>
 <f2221d44-cbb7-4355-b9a1-ecea47af62c5@amd.com>
 <CAEfUkULk+gFBEg=6YPtzracvHJ6pU7AM=+fw0eB3=NuxjctNcA@mail.gmail.com>
 <ffb4597c-4031-4e1e-8c35-4b0c1c32bbd0@amd.com>
In-Reply-To: <ffb4597c-4031-4e1e-8c35-4b0c1c32bbd0@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 20 Dec 2023 15:12:19 -0500
Message-ID: <CAEfUkUJ4s3qP0R=mRZZDqKfOgXW6B_tDhqJKHz7TPZCrqZLWrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] bloblist: Load the bloblist from the previous loader
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michal,

On Wed, 20 Dec 2023 at 11:41, Michal Simek <michal.simek@amd.com> wrote:

> Hi Raymond,
>
> On 12/20/23 15:53, Raymond Mao wrote:
> > Hi Michal,
> >
>
> please avoid top posting.
>
> > Other vendors should add their own custom function under the
> > "./board/<board-name>" directory.
> > The inline function here is just to avoid the building errors on other
> platforms
> > which do not yet implement the custom function.
> > Otherwise we have to create a function "board_bloblist_from_boot_arg()"
> under
> > all boards with this patch.
>
> pretty much platforms which enables bloblist via Kconfig want to start to
> use
> this functionality and start to get information out of it.
> It means I think dependency is on BLOBLIST. Simon is using it for sandbox
> that's
> why I can understand that you want to limit it to ARM or ARM64 or both.
> But I don't think you should connect it to any specific ARM arch like
> ARCH_QEMU.
>
The reason I have to limit it with ARCH_QEMU in this patch is due to the
fact that currently
only board "qemu-arm" has implemented the required platform custom function
"board_bloblist_from_boot_arg()".
We can remove this limit and make it depend on the BLOBLIST only when all
arm boards
implement the required function.
But at least now, with this patch, we need it under ARCH_QEMU, otherwise we
will have
linking errors when BLOBLIST is enabled on a board which is not "qemu-arm".
For the future, I agree, this only depends on ARM, BLOBLIST and OF_BOARD.

Thanks and regards,
Raymond
