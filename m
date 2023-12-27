Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D1DC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 04:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245F2876CA;
	Wed, 27 Dec 2023 05:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bfgg+6Wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F3587735; Wed, 27 Dec 2023 05:50:08 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1508D876CA
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 05:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-594bea92494so570927eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 20:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703652603; x=1704257403; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbhcOWFlntXXZJttEOlpnv2q8+uuYX3z4EQy8WxUBIk=;
 b=Bfgg+6WhxNB/Dw4sdYdEHO0XOIfkyk8xM9ZpfwNJQ/thQSkgMSt6ce58SghfcojXIo
 pTMLVh4JTOF0UIUgE4cuh5s0VlRfOM60a/trdgZZQWNhLSlZNls3GworkqbeRcVQszbj
 xSQijRk9cjfijeEPgtp3aS9dXpfp9Az/wUhhsHF7Qfcw7Je137K4ovuyXycjEh18eZp/
 WK0+n8TSgLklW6cQe+mgQDzCd45+BCZHVEenPaCHenylgkWn84F6w7NilWjaVPKTxx58
 NhwaRSe8VellfwTnYbbzvEjBxTUgH1OP6zeXC/GYgohBnN3wlpZf5sdSDFUEnbNI0Y4x
 mj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703652603; x=1704257403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbhcOWFlntXXZJttEOlpnv2q8+uuYX3z4EQy8WxUBIk=;
 b=Kby11RGfrcOfHgDJkNeZf7PtevVIejsuG2oHzS4FlK3AYe3PkVnRj03525PdkCTRNM
 k1p+PcGszMbxbRR/1HRqGiIR9fzkifQjdY0VO3Iwc6eY0W/10n+1uQ9BPP0mwnrIuKzs
 iPoMIEM/ct4mIOC2EcLBj1i7iccXTpX/t3miW2KDqinFiLFWt7TsSV8y+HP2eHLYnZZv
 I8IN7hwNugcGbnTI00wMwGg5O9D5ksuFGGVFsjzb7Rl8mc2BTt15wyQTpVPkrzI379ct
 whjeLqC5zehCjWWMgeOnDXVx+1bdHV7DfN+N3O210s6YskSGCdOTNh0uXcXb5mBrcTZX
 6Q5Q==
X-Gm-Message-State: AOJu0Yw7dvc0SQb3aTD3cLyxAcy/mKBihvc689S5G91yFK/npKLZDPhX
 bKo6iD+avJG+JyRhHZ6vRPcYZJcTRPmEfLnppQhQ8m5q6mheog==
X-Google-Smtp-Source: AGHT+IFqoJqyeUXxJ0ETpUtjJ+MQo3TwyEd699GaT8Zes+K6CQcvBrH8l0CNgCY/YD5RQj/6ztxfHuchvx4iCWrmxwQ=
X-Received: by 2002:a05:6808:1899:b0:3b9:de70:7b with SMTP id
 bi25-20020a056808189900b003b9de70007bmr6902623oib.82.1703652603603; Tue, 26
 Dec 2023 20:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
 <CAJaLiFw64BOfMKLXU_iYkFfuYZnk2XKxwbjVZEWHEJGRdZTkvw@mail.gmail.com>
In-Reply-To: <CAJaLiFw64BOfMKLXU_iYkFfuYZnk2XKxwbjVZEWHEJGRdZTkvw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Dec 2023 10:19:52 +0530
Message-ID: <CAFA6WYOyi8ck0oomFFKDsd_eTmmMSuFhQNC1YQh_1JHEBggGLQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
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

Hi Tony,

On Wed, 27 Dec 2023 at 10:11, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Sumit
> Hi Simon,
>
> On Tue, Dec 26, 2023 at 2:13=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > > >
> > > > > > > Prerquisite
> > > > > > > -----------
> > > > > > >
> > > > > > > This patch series requires devicetree-rebasing git repo to be=
 added as a
> > > > > > > subtree to the main U-boot repo via:
> > > > > > >
> > > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetre=
e/devicetree-rebasing.git \
> > > > > > >       v6.6-dts --squash
> > > > > >
> > > > > > So, I've played with subtree a little and I think this is the r=
ight way
> > > > > > forward in these cases. If anyone wants to take a look at how t=
his works
> > > > > > in practice, take a look at:
> > > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-=
devicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > > In that tree I started with the v6.1-dts tag, sync'd all the co=
nfigs (to
> > > > > > have an example of a normal commit) and then did a merge of eac=
h tag
> > > > > > until v6.6-dts, so provide some history. And git log looks like=
 what I
> > > > > > want to see, the squash commit has clear references to what we =
are
> > > > > > getting and I make a merge commit that says what I did. If you =
pull the
> > > > > > tree and checkout the branch, all the code is right there alrea=
dy,
> > > > > > nothing further to do. Same with tarball releases. The only thi=
ng I
> > > > > > don't like is the size growth there, but we'll reclaim some of =
it when
> > > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > > >
> > > > > I spent a bit of time with subtree as well, as part of reviewing =
this
> > > > > series, using the instructions Sumit provided. It seems OK to me.=
 We
> > > > > have to accept that it adds code and there will be changes/churn,=
 but
> > > > > it is not too different to accepting patches on those files withi=
n
> > > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Bo=
ot
> > > > > does support a good proportion of the boards supported by Linux, =
so I
> > > > > don't see that as a big cost.
> > > > >
> > > > > From my experimentation, subtrees seem to have no impact on build=
man,
> > > > > which is great. Am I missing anything?
> > > >
> > > > No it shouldn't cause any regression on existing tools/CI/build
> > > > systems. It is just a version controlled way of importing third par=
ty
> > > > source code as a tarball.
> > > >
> > > > >
> > > > > I still worry about the board-level 'switch' between U-Boot DT an=
d
> > > > > upstream ones. I believe that should be at the SoC level instead.
> > > > >
> > > >
> > > > Probably I wasn't clear enough in my earlier replies but this serie=
s
> > > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > > switch for Amlogic meson-gxbb SoC and its derived boards.
> > >
> > > OK good...but that's not quite what I mean. You have a fragment like
> > > this in multiple defconfig files:
> > >
> > > +CONFIG_OF_UPSTREAM=3Dy
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> > >
> > > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in th=
e
> > > Kconfig.
> >
> > Okay I got your point. It makes sense to me. I will do that for v3.
> >
> > > We should not have to specify the filename like this. It is
> > > laborious and error-prone.
> >
> > The only differentiation in naming here is just silicon vendor prefix
> > addition (amlogic/ in this case). The reason for this being that I
> > just want to mirror the whole silicon vendor directory from DT
> > rebasing rather than mirroring individual DT files. Given this do you
> > have any better alternatives?
> >
>
> So how do we handle the case where the DTS exists in u-boot, but not
> in Linux? For example, the DTS was developed for u-boot first and has
> not been accepted in the Linux device tree yet. Can we set in the
> board defconfig like:
>
> # CONFIG_OF_UPSTREAM is not set
>
> Would that allow the DTS to remain in arch/<architecture>/dts?

Yeah that is expected until DTS becomes available in the DT rebasing tree.

-Sumit

>
> Thanks,
> Tony
