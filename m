Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056A8C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CC587871;
	Thu, 21 Dec 2023 16:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+IjhqsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4379187846; Thu, 21 Dec 2023 16:19:00 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7118786E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78109a21144so57534285a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703171934; x=1703776734; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nRp4Ikn/BMSAKXDSGXap2aTGs8XyLWOJRGXsc//YGY=;
 b=c+IjhqsY3jLzh7J4cs+tsY0ayOuijlztWKKDwsRBI9aavQcd0iMjvmZktn6UP7714S
 fZxRlIlBub9UxkbJZgtoAmvr24zOZC0n44YqKBB05wLu68kYKIk/AFwToWBsFOTwjyg6
 CkqHiT8tHsW6bQ26oycqjV9t/91eFPGAPLULw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171934; x=1703776734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nRp4Ikn/BMSAKXDSGXap2aTGs8XyLWOJRGXsc//YGY=;
 b=Abecu0zg4Fkm9uHmlyI3NZMC0MRmUf05xhF7iWZQRmNFe1QX0Sx7uOOPbbk0MNQRro
 D2sNog0MxTZHATP5gFjYCalzTJG0FjMhjeAXDzTRuY7CLPSNAY9vDXFKOA2DKsQ9JygC
 R577NUzHkPOx3j4QH/1g9jSUDI5/avm8mGQ4TFSqD2zuJ+fvFNjOldSqdCxmdWyo19ig
 FdXANLILDloOnnFDn1uTI2xPBfksojubueOpR+XoarmpxJGkArMy67JHqjdJLZemLa1u
 2pqOmMyxSARg3sSdAN/CA0tYcb40HRWZRHtJcBe7NpnJKl1LSCV05GVoVuHN1WD0vPfc
 3WNA==
X-Gm-Message-State: AOJu0YxlNqugeEv1K9435jlwaKtZgtSvUNjCn7HdgNH5fCoNDAt4oU3N
 NpxEW3XV3DN/EB8cuoVZoMRxLG+jv1aX9YqmyWxoP5TYpsMezgf1iHj5qw==
X-Google-Smtp-Source: AGHT+IEJAj/HtF7PzvexnznS5ZvyIgwGB9Er2JKB4Ye1Uy3Z9WQg2MqPWHplXkwRMGsBBzcr7jWR1FIqI/K6J/RyNzI=
X-Received: by 2002:a05:6214:411c:b0:67f:7347:9b83 with SMTP id
 kc28-20020a056214411c00b0067f73479b83mr2430778qvb.112.1703171934153; Thu, 21
 Dec 2023 07:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
In-Reply-To: <20231221150303.GI2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Dec 2023 15:18:42 +0000
Message-ID: <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
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

Hi,

On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
>
> > Prerquisite
> > -----------
> >
> > This patch series requires devicetree-rebasing git repo to be added as =
a
> > subtree to the main U-boot repo via:
> >
> > $ git subtree add --prefix devicetree-rebasing \
> >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetr=
ee-rebasing.git \
> >       v6.6-dts --squash
>
> So, I've played with subtree a little and I think this is the right way
> forward in these cases. If anyone wants to take a look at how this works
> in practice, take a look at:
> https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-devicetree=
-rebasing-since-v6.1/?ref_type=3Dheads
> In that tree I started with the v6.1-dts tag, sync'd all the configs (to
> have an example of a normal commit) and then did a merge of each tag
> until v6.6-dts, so provide some history. And git log looks like what I
> want to see, the squash commit has clear references to what we are
> getting and I make a merge commit that says what I did. If you pull the
> tree and checkout the branch, all the code is right there already,
> nothing further to do. Same with tarball releases. The only thing I
> don't like is the size growth there, but we'll reclaim some of it when
> we delete our obsolete bindings, and then obsolete dts files.

I spent a bit of time with subtree as well, as part of reviewing this
series, using the instructions Sumit provided. It seems OK to me. We
have to accept that it adds code and there will be changes/churn, but
it is not too different to accepting patches on those files within
U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
does support a good proportion of the boards supported by Linux, so I
don't see that as a big cost.

From my experimentation, subtrees seem to have no impact on buildman,
which is great. Am I missing anything?

I still worry about the board-level 'switch' between U-Boot DT and
upstream ones. I believe that should be at the SoC level instead.

>
> Maxim, please switch (back, sorry!) to subtree for the next lwIP
> patchset and just not in the prerequisite steps what the subtree command
> is, and make sure the docs have an example of what future re-sync
> "subtree pull" commands should look like. For CI testing, you'll have to
> do that to start with and just not include that patch in the ML part.

Regards,
Simon
