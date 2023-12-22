Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD94C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619FC8779D;
	Fri, 22 Dec 2023 06:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aE6QKcDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F70F8779D; Fri, 22 Dec 2023 06:34:50 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0D787650
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7cbf98dd9efso1476019241.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703223285; x=1703828085; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqMelCzGiaQzWelsK82Mbi10SFZqDHmg/xciAtSRl54=;
 b=aE6QKcDL6w91dEahVPAkTPRgCcG1xsMBZUHwBs3eFbBBxTmwVv8fIJDiURp6yfIx8U
 j5TTIGM+HrIyFSqGMr38Izpv99ll8rDhVVAEUW6G1HeF8pLUsG/+KZJsdWT3KQLB9Qnz
 nibwAy8BPSehaO/Hw0TtqHUs4EfW91jB4CUfgbNPv06TOgaBUMpNOM9bwUkN6WNGdGfw
 6kCEACp9rjD2UlmPz8GzLnf7HaFo9sqWuGzy0fV+zWpqryKnzl80xs85/8phNB5vM24r
 velCsv8viHVYNb6M9QOWT8f1ADlLPy2HetKgF963u55Z/aHZLKMe228i7O3jUlvS/eFD
 s64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703223285; x=1703828085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqMelCzGiaQzWelsK82Mbi10SFZqDHmg/xciAtSRl54=;
 b=iM3vb3+MOreCAv2yUvlYS24pI0FYE9U+c5K64NREziD+8oE8OM7ghm5qRiLaqJaYG4
 kzrRMlhdpWOckPZzDx53B1ZZyqP9yizS4f0ZNCb+otr3W+iLAqlpj8igpwa/ZDtxjqdE
 3CNL74IDc1d4EaqRcSeh9LCsySlAWWP6OAA7wBIUtpW/zE1X2Y/w4maDH+7FP3vnq2y7
 joRCeQ8CiCA8CyjhbG2KY1RTQ/h9QA4RYc1AVximPOTePBHUnclOLs+Vvemcc0yKNp45
 BloBBFTS/gRTK5xG1d6wVdgpkP1rmqaMF7aJsxCzs6vBJ1UomC/a855lMiTcrhE1gvSC
 uUtA==
X-Gm-Message-State: AOJu0YwlU4H7kPcIIaIz15QzZoqF/MU+P8B6GBc2f8rnjKprPO6TaozQ
 ZmnEr3vl3LN1hC0GHGmftsv1YN32YAmbjHUDAteKMk4yCHMnYQ==
X-Google-Smtp-Source: AGHT+IEwC2P6DbmOli8LoOMnuMnYaRAXg/rgTnxnBt7oEjx+QLhxbE5fWPfwI18L7auX/EJey0hYqJxpUAhYW+J2iIo=
X-Received: by 2002:a67:f5d7:0:b0:466:932a:8829 with SMTP id
 t23-20020a67f5d7000000b00466932a8829mr1482178vso.25.1703223285458; Thu, 21
 Dec 2023 21:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
In-Reply-To: <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 11:04:33 +0530
Message-ID: <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
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

On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> >
> > > Prerquisite
> > > -----------
> > >
> > > This patch series requires devicetree-rebasing git repo to be added a=
s a
> > > subtree to the main U-boot repo via:
> > >
> > > $ git subtree add --prefix devicetree-rebasing \
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git \
> > >       v6.6-dts --squash
> >
> > So, I've played with subtree a little and I think this is the right way
> > forward in these cases. If anyone wants to take a look at how this work=
s
> > in practice, take a look at:
> > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-devicetr=
ee-rebasing-since-v6.1/?ref_type=3Dheads
> > In that tree I started with the v6.1-dts tag, sync'd all the configs (t=
o
> > have an example of a normal commit) and then did a merge of each tag
> > until v6.6-dts, so provide some history. And git log looks like what I
> > want to see, the squash commit has clear references to what we are
> > getting and I make a merge commit that says what I did. If you pull the
> > tree and checkout the branch, all the code is right there already,
> > nothing further to do. Same with tarball releases. The only thing I
> > don't like is the size growth there, but we'll reclaim some of it when
> > we delete our obsolete bindings, and then obsolete dts files.
>
> I spent a bit of time with subtree as well, as part of reviewing this
> series, using the instructions Sumit provided. It seems OK to me. We
> have to accept that it adds code and there will be changes/churn, but
> it is not too different to accepting patches on those files within
> U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> does support a good proportion of the boards supported by Linux, so I
> don't see that as a big cost.
>
> From my experimentation, subtrees seem to have no impact on buildman,
> which is great. Am I missing anything?

No it shouldn't cause any regression on existing tools/CI/build
systems. It is just a version controlled way of importing third party
source code as a tarball.

>
> I still worry about the board-level 'switch' between U-Boot DT and
> upstream ones. I believe that should be at the SoC level instead.
>

Probably I wasn't clear enough in my earlier replies but this series
motivates for a SoC level switch only. Patch #7 is essentially a
switch for Amlogic meson-gxbb SoC and its derived boards.

-Sumit

> >
> > Maxim, please switch (back, sorry!) to subtree for the next lwIP
> > patchset and just not in the prerequisite steps what the subtree comman=
d
> > is, and make sure the docs have an example of what future re-sync
> > "subtree pull" commands should look like. For CI testing, you'll have t=
o
> > do that to start with and just not include that patch in the ML part.
>
> Regards,
> Simon
