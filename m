Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F25C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 19:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C835D87AFD;
	Thu, 14 Dec 2023 20:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CMY1g64V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C160587B2E; Thu, 14 Dec 2023 20:49:01 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714AA87AB1;
 Thu, 14 Dec 2023 20:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 46A57CE25DA;
 Thu, 14 Dec 2023 19:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F7AC433CC;
 Thu, 14 Dec 2023 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702583336;
 bh=2OHNBL0KPKCfkJjy/Jh3e6xj+lfQm31QP6cU9Jahnqc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CMY1g64VE6ez+YShb+N2VYfddocbcAetaHpcpNt+wc0ZjpnLNzO7TYaIpK4NqhA3Z
 FKkkt0ovfVFplW72yyKyB7lgy+BvhYdhjXYhHxQRkRuYMgCG/+7DwgYvnwA75eCavK
 KlrqPSQzO+YGb4V4QU10XjsjG2FAV2wPN0WTFWYLVoKvawRfE88VErI+8lVMI3ponT
 FiWdoxT844uhe1qMOZ/B1+zclM7SDAT/w5TWgpFwyhWen4jscmSG67IlqpagrQSDQh
 TPyqmfOVloDWmxgC2bFJYLb+I1O+QlNIoes0n1lNZwP90sFDMTsL5s+SS47hkB5fY4
 iUafBYzQLveJg==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-50c05ea5805so10069655e87.0; 
 Thu, 14 Dec 2023 11:48:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yy6M2mI/ilbjOvwZEssMxPB1/WvT+fsp3rakLXYh9WLc2v9S+w9
 0AxWWNwA4pqQB5JpA4GmQ8pw0Po13M4bzh/ZeA==
X-Google-Smtp-Source: AGHT+IGk07Ll7sLz9WnkpCtX+HV6f64vblwuyIyU6K4TjKkXDQdZBNh/F5RYnaKdXOWBgyvItMS+weZZ4ez9LWYf/TY=
X-Received: by 2002:a05:6512:3094:b0:50e:16c9:180e with SMTP id
 z20-20020a056512309400b0050e16c9180emr1080975lfd.34.1702583334706; Thu, 14
 Dec 2023 11:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
In-Reply-To: <20231214182328.GQ2513409@bill-the-cat>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 14 Dec 2023 13:48:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
Message-ID: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote=
:
> > Hi,
> >
> > On 14/12/2023 14:50, Sumit Garg wrote:
> > > Prerquisite
> >
> > s/Prerquisite/Prerequisite/
> >
> > > -----------
> > >
> > > This patch series requires devicetree-rebasing git repo to be added a=
s a
> > > subtree to the main U-boot repo via:
> > >
> > > $ git subtree add --prefix devicetree-rebasing \
> > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > >        v6.6-dts --squash
> >
> > So I think the big question is: when should the subtree be updated ?
> >
> > Because as we discussed in the previous GH pull request, if a bindings =
changes
> > was made in the upstream Linux DT, then the subtree update should wait =
until
> > the u-boot support is merged before updating. This could cause a lot of=
 frustration.
> >
> > And this could cause a lot of regressions, even more if both Linux and =
U-boot are
> > not maintained by the same people.
>
> I think some of the important questions to ask are, how often / likely
> are the breakages to occur? It seems like these days it's either:
> - U-Boot had an early version of the binding and we already state we
>   don't support backwards compatibility here. It should be on the
>   maintainer to be proactive in this case.
> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
>   incompatible DTS change now". This too is hopefully the kind of thing
>   that at least board maintainers will be more actively aware of needing
>   to deal with in U-Boot, if it's really a problem.

A common issue in the kernel is with forward compatibility when
platforms add new resources from a new provider. Then the kernel
expects a driver for the provider and waits for the dependency. Of
course, older kernels don't have that provider driver and so the
dependency is never met. Not sure if u-boot will have similar issues?
At least you should/could know if the provider driver exists or not.
(The kernel doesn't because modules.)

Rob
