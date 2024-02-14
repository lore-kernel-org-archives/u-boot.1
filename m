Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB3C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B6A87E10;
	Wed, 14 Feb 2024 13:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uDyL+QJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F79487E13; Wed, 14 Feb 2024 13:26:30 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0E487DA7
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 13:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so2124830241.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707913585; x=1708518385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QeAh2Bxzf6Q03BdVMBH7AQRiMTnWi9uc5rSvT3XmW2E=;
 b=uDyL+QJk5PAbIWo12SK3KwUjEvXrWcOhYMuZ6Cp35BMCq2YG449zanhAtaMd1svz3h
 yW2f8/7jt3YBKpl7TzTYtcH+oGDNEIWYYYTRrpW2KYySv9jmgmpCdf+b+IwX0FfCJeEt
 HHs3kZ8NwBrqlWKApUDmIaU7ucjOZveVqTp033elV8DQ83kIAU2ygs+dpgEIWjgXUA4L
 3bnIBBOILRcUK8WSWP9QI8ERUvvWzgZgbJmN1H9Q2ykUKDkOShftPFIfiP7bwppfMCGk
 N6TllVqNq4BeRLV/jnzz8TcwN0IcRpOQSw/WlZEDnoRMDMMLdX2JOaZ3aStbZXdmjFjo
 Ys2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707913585; x=1708518385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeAh2Bxzf6Q03BdVMBH7AQRiMTnWi9uc5rSvT3XmW2E=;
 b=v8Rca4MXPHF96ONxKhzF2ZlkBo65uYjnGNl7L066NhDZXOeNzKKutFGqbJj2yfCES9
 s35iwE0iBHLFv8dQtPDaeia3NUbUk4taT8oAFTBgYGdg4SUzP5aGfRVejCNN3whPyRkj
 HmjIJAd2dfL0rwXoNxx8N17ZjrF5IvaaONWR3EvFo1xDMjN+X6unRWi6zwaNZnjvNoSe
 6do9e1v3YMZM8UmzdEMC7ilT2K/Pzs8jPRuNnzQAdfSpKKBaEah0FdqdvNBXUz+JLg5l
 /esBCfgvAnbF3MG+gC5yMblzW+VpyIcPEYsTIcxc5FpqO4qpCMxl7/x8xfONZvY1R+EF
 pukg==
X-Gm-Message-State: AOJu0YyjaXf4in3lopnMaJMvfF14swuSaWoupUwmNY/FyV1Fks1rPtWy
 WdWJ8f9mQGqTsgmsQPfB+jSok0fu8O5mmKgTh2D6lnZ3yLBypdj5FBBl7edvxs3UQumonS6owe8
 q8dk6s2BZ01U5Qp2XShoD2d7Hoaaf1MmiRLAmzA==
X-Google-Smtp-Source: AGHT+IEyy4jD25PfDOYEll0F/6Sd8Gx4ugkGcfR44laO53Vb1eh0+AhVfpeEYgvgEBmtBJVz1dTI6wz0nDv21O1QUgU=
X-Received: by 2002:a67:f885:0:b0:46d:2f42:2601 with SMTP id
 h5-20020a67f885000000b0046d2f422601mr2347707vso.11.1707913584776; Wed, 14 Feb
 2024 04:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-7-sumit.garg@linaro.org>
 <ae946009-64a6-44bd-9034-b035684341a6@denx.de>
 <CAFA6WYPgRM8xPQcoJLemXcKvxekgZMRWkc7XG2hH5MFmUmhMZw@mail.gmail.com>
In-Reply-To: <CAFA6WYPgRM8xPQcoJLemXcKvxekgZMRWkc7XG2hH5MFmUmhMZw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 14 Feb 2024 17:56:13 +0530
Message-ID: <CAFA6WYM4puvz-Az5dpms98SDS44xhV7rJrSXq9jgCmEkGX9LDQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dts: Add script to uprev dts/upstream subtree
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, 
 mibodhi@gmail.com, bb@ti.com, festevam@gmail.com, nm@ti.com, 
 andre.przywara@arm.com
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

Hi Marek,

On Tue, 6 Feb 2024 at 11:50, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Marek,
>
> On Tue, 6 Feb 2024 at 05:51, Marek Vasut <marex@denx.de> wrote:
> >
> > On 2/2/24 14:05, Sumit Garg wrote:
> > > dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
> > > Usage from the top level U-Boot source tree, run:
> > >
> > > $ ./dts/update-dts-subtree.sh pull <release-tag>
> > > $ ./dts/update-dts-subtree.sh pick <commit-id>
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > How are the fixes which land in linux-stable handled now ?
>
> Firstly, all the fixes land in the Linux mainline tree, then at every
> rc* release those would be mirrored into devicetree-rebasing repo. And
> then if there is a critical fix to address DT ABI breakage for U-Boot
> (for at least a single board) then they just need to notify us with
> the fix commit ID to be picked up. Or if people are willing to use the
> dts/update-dts-subtree.sh script themselves then we are happy to
> accept patches too.
>
> BTW, we will also work with Linux DT maintainers to improve DT ABI
> maintenance towards U-Boot.
>
> >
> > Do I have to duplicate the work which is already being done by the
> > linux-stable maintainers ?
>
> No, we don't have to backport all the fixes as they will make their
> way automatically via the next subtree pull. As above we are only
> concerned about fixes which are required to maintain DT ABI towards
> U-Boot.
>

Gentle ping. I hope my comments above address your concerns.

-Sumit
