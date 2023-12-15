Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE97C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 06:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE72F8797F;
	Fri, 15 Dec 2023 07:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xv3r2+sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631AB878B0; Fri, 15 Dec 2023 07:01:49 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B321F8797F
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7c461a8cb0dso17156241.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702620103; x=1703224903; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EcJQblX2tRhsjBQ/rNWBpIs3gF9ltfyBAlIHwqklz6U=;
 b=xv3r2+sB9oobtz8pUC6/gKjrftrtt/Bz3i+iyP6VA7Tvwre+eoNM0RYMgRsfGOTHX0
 1hmCwK1LN6XKdkpdNZ+5FAPHO4coX6hJ6ZGKzeMqTnubBlhtnTvnZfnM+lVNOXCeEWeK
 n7/KgY6PVtJnTJETuffj1vD03PjD9MEOP5aDGvVBYL80OhJZfLPJNt0virKCU9zrIiWo
 bPh5teABmwWrWaR1JkSOmT1S4Utebi9mE0dg+3kdsgtJQpBnb+/7akZPAKR5DyCsLNEW
 7T+aHVUNAXeBUMQj30tUJdHEi+865RUmDE8iEMjeGjybb1Pa07pBNQrYhMGb9N1Qu4HW
 HOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702620103; x=1703224903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcJQblX2tRhsjBQ/rNWBpIs3gF9ltfyBAlIHwqklz6U=;
 b=Ko/vlBN/tvbqnSIce0F9uDFbWrIZ+6o/9LUMXl88Pn1PbBLq2AxNUBNR5P8fA5hwv1
 ReGn3c74Ay6mnzSkpl99zzL6pGp7VRc3tHIL9kOKh63kmrXS6WVECLzKFB8yV1dVqvcx
 R4QArD92psDT8/hl6wtmxs+/uSZ/y/HGKh7CTCCaiAOA0/CM6AHeebR5RnTVANuq8483
 78VMmxT/x7Q8zhTDI+spNa/nSVRuniarduR2R+WBA3c4IzHu/jfcN5yXr55ngnxL0ZWc
 VQSa9tx1jx1CmyiyySBsSIpZRkmRCVff2DHyyX615RTrHi1YAY1fdE91F+cGrt+ve6f3
 q3HA==
X-Gm-Message-State: AOJu0Yyv+Qqd+/7WoVGpcS5nM5vN7rvMCMPyFvG8Z3ENCf7V3WLPBA3t
 g7wNS2od56z71DMusVxxLqTmVp7M9RB+J6ZZkewgfA==
X-Google-Smtp-Source: AGHT+IHHKVxY1ej0g59hmYXDCTJ+VKs3sGjwAjRtrimfYboEQVTcnzPUcOa5NYaxNiApZcJsxf5EVMtj/poQOzXCDaY=
X-Received: by 2002:a05:6102:94d:b0:464:959f:4e82 with SMTP id
 a13-20020a056102094d00b00464959f4e82mr4321802vsi.4.1702620103119; Thu, 14 Dec
 2023 22:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
In-Reply-To: <20231214182328.GQ2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Dec 2023 11:31:31 +0530
Message-ID: <CAFA6WYPvKnAEKkJM1rTQkYwA0zRKNy7rHDtRw2J_Ld7AKYXO4g@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, caleb.connolly@linaro.org, 
 ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, 
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Thu, 14 Dec 2023 at 23:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote:
> > Hi,
> >
> > On 14/12/2023 14:50, Sumit Garg wrote:
> > > Prerquisite
> >
> > s/Prerquisite/Prerequisite/
> >

Ack.

> > > -----------
> > >
> > > This patch series requires devicetree-rebasing git repo to be added as a
> > > subtree to the main U-boot repo via:
> > >
> > > $ git subtree add --prefix devicetree-rebasing \
> > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> > >        v6.6-dts --squash
> >
> > So I think the big question is: when should the subtree be updated ?
> >
> > Because as we discussed in the previous GH pull request, if a bindings changes
> > was made in the upstream Linux DT, then the subtree update should wait until
> > the u-boot support is merged before updating. This could cause a lot of frustration.
> >
> > And this could cause a lot of regressions, even more if both Linux and U-boot are
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

Agree, also per discussion with Linux DT maintainers, they do care for
DT backwards and forward compatibility. I expect the ABI changes to be
rare. In case there is an ABI change then it will be great if Linux DT
maintainers can ask contributors to CC corresponding U-boot platform
maintainers too.

BTW, Rob is already working on a tool to detect ABI changes as he
described here [1]. If U-boot platform maintainers have any ideas
regarding what would constitute an ABI change then feel free to share
those.

[1] https://lore.kernel.org/all/CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com/

>
> So I would plan on grabbing only full kernel releases and in to -next as
> soon as possible. Our cadences don't match up exactly, but I think do
> fairly well enough.

I suppose that would give ample time to the U-boot platform/board
maintainer to fix any ABI change regression found in the -next branch.
That being said we aren't completely immune to changes to
devicetree-rebasing subtree. If there is an DT ABI change that will
take significant effort to fix in U-boot then we are open to accepting
a revert given that it will be fixed before next uprev.

-Sumit

>
> --
> Tom
