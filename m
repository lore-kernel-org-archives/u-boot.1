Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ED0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 06:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E9A87AEC;
	Fri, 15 Dec 2023 07:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xTD2MQjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F5E87B4C; Fri, 15 Dec 2023 07:06:32 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8B687AEC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-464a3b84ef7so836756137.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702620388; x=1703225188; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgQDb2dMpB2gLncYNtzo5iKnhAw3wUiPEOkXIqBOgMU=;
 b=xTD2MQjWDGh2jxMYOJ083gy7JJQiCXxPXd9O/Ty9LenP+dX8RkxvMdwNHH78CWIGnT
 SV8Yq/L4TOFYlLyIFg6TA/7Sj9IaXAh83ym/Xw1+DC8w+7dwqAe99/F5Jc9YtAFZk5ZN
 kJWbbiewXGvdow01emuf59E5h6faWbi/kZYyQSdpe0LTctBhNa284p/gmsZiIF/MTydW
 R/N6ApslXvKSmDzztjYfeentLyb0yfQqWE1k0rreY9PYUQNu2DKbiA6QyXT68ekX+u9g
 6nXsgNlOnloA98KMIKiDwoBxBLYA6R3UPPElc1G16FicN0zXLnqlvMxd9QSXSLEtH6Sq
 vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702620388; x=1703225188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgQDb2dMpB2gLncYNtzo5iKnhAw3wUiPEOkXIqBOgMU=;
 b=Y2zy+DnDsNJq0BVeevJUA9+K1nkXbxudKR4Yv3cJh8oXgMMzpMLGLNUYs/8FDijeZ4
 jrdlkBGw9t/WH05P+DdeVgsX8xFWtmEmz7YhAtwURNGiDb55bGhc8rTPnH6jfNsklhG1
 323bh6KGzxg1mT5zPQceEsLrSv27gk/PqFctQKKzPfkA4gULEVB2R9kDHPxlJwja8Iew
 SqdEGJI59JFctseNT7hTewCYTdL/RVRCGviUHKtOtiNqsv/AmuJ+Pg5sTxJAbwWegTRx
 Js3bEX+X8NZwAAckq2iLjcZnCtUhM6GbEKVrBju4+Nb9ovgK5ltPfdSR7DYDBRUf0IhG
 h/vQ==
X-Gm-Message-State: AOJu0Yyo3b5r14QGFRWbvoqVbZ4+DvZXMD/c0a9R344IGuJ6jddNHjwM
 zyZrk5GYLw2ezBgk51lJiqnIomztL7AnWvqtZdYFFg==
X-Google-Smtp-Source: AGHT+IEaunAA8hpa6RM0FTyIE62dqupY6k0Ik8ie4irRPZ/LVR0m+5aZijZfz+Q6hyOhN2dAxWTxXFiPsXGV6gPGlrc=
X-Received: by 2002:a67:be02:0:b0:464:7ad2:2dc with SMTP id
 x2-20020a67be02000000b004647ad202dcmr9915243vsq.28.1702620388476; Thu, 14 Dec
 2023 22:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <20231214201511.GR2513409@bill-the-cat>
In-Reply-To: <20231214201511.GR2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Dec 2023 11:36:17 +0530
Message-ID: <CAFA6WYME3EGnedt=1ASm_mTzp+--OTjPSKvQG-Pj=9RbxgeYtQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org,
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

On Fri, 15 Dec 2023 at 01:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 01:48:42PM -0600, Rob Herring wrote:
> > On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org w=
rote:
> > > > Hi,
> > > >
> > > > On 14/12/2023 14:50, Sumit Garg wrote:
> > > > > Prerquisite
> > > >
> > > > s/Prerquisite/Prerequisite/
> > > >
> > > > > -----------
> > > > >
> > > > > This patch series requires devicetree-rebasing git repo to be add=
ed as a
> > > > > subtree to the main U-boot repo via:
> > > > >
> > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/d=
evicetree-rebasing.git \
> > > > >        v6.6-dts --squash
> > > >
> > > > So I think the big question is: when should the subtree be updated =
?
> > > >
> > > > Because as we discussed in the previous GH pull request, if a bindi=
ngs changes
> > > > was made in the upstream Linux DT, then the subtree update should w=
ait until
> > > > the u-boot support is merged before updating. This could cause a lo=
t of frustration.
> > > >
> > > > And this could cause a lot of regressions, even more if both Linux =
and U-boot are
> > > > not maintained by the same people.
> > >
> > > I think some of the important questions to ask are, how often / likel=
y
> > > are the breakages to occur? It seems like these days it's either:
> > > - U-Boot had an early version of the binding and we already state we
> > >   don't support backwards compatibility here. It should be on the
> > >   maintainer to be proactive in this case.
> > > - It's a "the DT was wrong about the hardware, sorry not sorry it's a=
n
> > >   incompatible DTS change now". This too is hopefully the kind of thi=
ng
> > >   that at least board maintainers will be more actively aware of need=
ing
> > >   to deal with in U-Boot, if it's really a problem.
> >
> > A common issue in the kernel is with forward compatibility when
> > platforms add new resources from a new provider. Then the kernel
> > expects a driver for the provider and waits for the dependency. Of
> > course, older kernels don't have that provider driver and so the
> > dependency is never met. Not sure if u-boot will have similar issues?
> > At least you should/could know if the provider driver exists or not.
> > (The kernel doesn't because modules.)
>
> I think we'll be fine, but time will tell. And perhaps the more frequent
> re-syncing will make any sort of corner cases show up more quickly and
> be something we can figure out how to resolve going forward really.
>

Agree, frequent re-syncing is something we should aim for. However, if
required then we can always revisit our approach.

-Sumit

> --
> Tom
