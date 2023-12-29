Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E987C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B9487A17;
	Fri, 29 Dec 2023 07:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YHM1p3FF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E05187A39; Fri, 29 Dec 2023 07:53:48 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09F4874E0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e18689828so7051815e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703832825; x=1704437625; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PC47UD3AE5IDXy1WBxcumS+LZAXuKOoUipGpR7JiOm4=;
 b=YHM1p3FFW8nqZMP3d4fktH6nfVxF9TYYVX/3tEc423u0N9Wx5/bD6Hw8UaYm04iOBf
 zi/5o21RcEUzesD82Pyfu3hMfmU+dvGjRxCkZWmouqbi03CxqX0QzBbzW3L5rKXIrIGQ
 eDHLIUYhKRIvr1+YxBmdhX+x5UUdp2b4RGXks1THW4yaQcQ4YUc6tGUXeaHcGJq/qMlG
 1DOcn6rwahwxkWOS7lGQfT/TP1zH/V6428pQnx2BBuOtJVoTU2hd80d2Ad/StSRrRVzc
 pCRUwDGzzmrM2oGSWSqo5qhawKrZ4QoOj9F3YZMQDVw4Dyvepu0qY3BfL8kyKuDAQaIV
 vzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703832825; x=1704437625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PC47UD3AE5IDXy1WBxcumS+LZAXuKOoUipGpR7JiOm4=;
 b=AgVEVGxmV6bVOtpjry3Uxkr78v3V5m2d1FYQ7xi4Ku8zgImiRNEhuO0esT95ziBCCd
 R9oYRsDn1+BuFZ+HwSBG2nZmFek1J9LkZ/Z8PKZkHkeBYzd+B0+VNeApCxolAiHXsFD8
 zymTvy8vZPaElWIL6anrKOVFR32aGTLvPOgyqkN3XofzjlQleJDaxpzqhBW65TZ7A+CO
 VugFOZQuKEeetQqcTbOy2T9MhR76GAwBbSWkeAwdHHAmzmrZ/mjIcCc/xAF5o0pZMDUn
 i/nZB9z+GcA2P46f3c0F+kBW4Xbl7sC6jcauCKdgfKx0puoIp/Pf+4vdiTbB+f+fL58a
 rWuQ==
X-Gm-Message-State: AOJu0Yxt5KToi1LqbD7TL8zRhZWjOKBGrAM8A5WDqpgrx9JSvTswtDIa
 YD0qUdG2LIXsWVQcDrtLIc094stIJwUBzo68xTpsjfXYvJ5jng==
X-Google-Smtp-Source: AGHT+IFo0AKxhyc3Ok1xPQ8uqUwyEumTrho9PpNpYHL36D/a3cfHO6AhBlESk1l9LORW5Nrm8pldtCwXpak84B3msFA=
X-Received: by 2002:a05:6512:a8c:b0:50e:7f0c:7914 with SMTP id
 m12-20020a0565120a8c00b0050e7f0c7914mr2871221lfu.21.1703832825016; Thu, 28
 Dec 2023 22:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
 <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
 <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
 <CAPnjgZ09vvyhBTUW03armbz_sevRr0qQeqL2vaQ3BNq+Wo9_dA@mail.gmail.com>
 <CADg8p96yHf7gSzHX4H6zaV-nx-BQ7qwmnBn6n5+xn969FCZKnQ@mail.gmail.com>
 <CAPnjgZ2Ryvp9WWmMCBPSANThYPVVda2dqXerwH0QiWn4wvdtiA@mail.gmail.com>
 <CADg8p96ev-myFW7EQJeOXBR_31Scz9QpPmMWCqJAsVXKdFdrqw@mail.gmail.com>
 <CAFLszTgk4jmTdEy6YndS4h6eZNEjx+igWw8Z5x7bhVd3jqtokw@mail.gmail.com>
In-Reply-To: <CAFLszTgk4jmTdEy6YndS4h6eZNEjx+igWw8Z5x7bhVd3jqtokw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 29 Dec 2023 12:23:33 +0530
Message-ID: <CADg8p96RsM6+tJ99Y8M1SsEcrr=xB-+iLs04QZrOSjQLdyqBMQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Simon,

On Wed, 27 Dec 2023 at 23:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, Dec 4, 2023 at 7:15=E2=80=AFAM Sughosh Ganu <sughosh.ganu@linaro.=
org> wrote:
> >
> > hi Simon,
> >
> > On Sat, 2 Dec 2023 at 00:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 30 Nov 2023 at 23:39, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Thu, 30 Nov 2023 at 08:16, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 22 Nov 2023 at 00:40, Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
> > > > > >
> > > > > > hi Ilias,
> > > > > >
> > > > > > On Wed, 22 Nov 2023 at 13:06, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> > > > > > > >
> > > > > > > > hi Simon,
> > > > > > > >
> > > > > > > > On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Sughosh,
> > > > > > > > >
> > > > > > > > > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@=
linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Add support for specifying the parameters needed for ca=
psule
> > > > > > > > > > generation through a config file, instead of passing th=
em through
> > > > > > > > > > command-line. Parameters for more than a single capsule=
 file can be
> > > > > > > > > > specified, resulting in generation of multiple capsules=
 through a
> > > > > > > > > > single invocation of the command.
> > > > > > > > > >
> > > > > > > > > > The config file can then be passed to the mkeficapsule =
tool in such
> > > > > > > > > > manner
> > > > > > > > > >
> > > > > > > > > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >  tools/Kconfig              |  15 ++
> > > > > > > > > >  tools/Makefile             |   1 +
> > > > > > > > > >  tools/eficapsule.h         | 114 ++++++++++++
> > > > > > > > > >  tools/mkeficapsule.c       |  87 +++++----
> > > > > > > > > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++=
++++++++++++++++
> > > > > > > > > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > > > > > > > > >  create mode 100644 tools/mkeficapsule_parse.c
> > > > > > > > >
> > > > > > > > > This patch keeps coming back :-)
> > > > > > > > >
> > > > > > > > > Can we not add multiple capsules in the binman descriptio=
n? Why do we
> > > > > > > > > need a new file format? How can binman decode images prod=
uced in this
> > > > > > > > > way?
> > > > > > > >
> > > > > > > > So as Tom mentions, this brings parity with respect to the =
other
> > > > > > > > capsule generation tool in EDKII that generates capsules. I=
IRC, this
> > > > > > > > is something which even Xilix was interested in, and Michal=
 had kind
> > > > > > > > of gone through these patches earlier. Lastly, it would be =
good to
> > > > > > > > have support in U-Boot's mkeficapsule tool for generating a=
 single
> > > > > > > > capsule file with multiple payloads, and having support for=
 this
> > > > > > > > functionality helps in that goal.
> > > > > > > >
> > > > > > > > Also, you might have noticed that, since your objection to =
the last
> > > > > > > > series, I have removed putting this in binman. So now, this=
 aspect of
> > > > > > > > the capsule generation would only be supported through the
> > > > > > > > command-line invocation of the tool.
> > > > > > >
> > > > > > > I think that overall the approach is sane. mkeficapsule is cu=
rrently
> > > > > > > supported and compiled for distros, so the multiple payload s=
upport is
> > > > > > > useful. If we want to add support to binman, instead of rewri=
ting this
> > > > > > > in python, we could just call that tool for parsing and creat=
ing
> > > > > > > capsules
> > > > > >
> > > > > > Given the amount of time these patches have been under review(a=
lso
> > > > > > number of iterations), I would request that this series be revi=
ewed
> > > > > > and merged first. I think there is general consensus that there=
 is
> > > > > > value to have this functionality in the mkeficapsule tool. If i=
t is
> > > > > > deemed fit to support this through binman as well, that task ca=
n be
> > > > > > taken up separately. Thanks.
> > > > >
> > > > > The point you are missing is that it is the entire goal of 'skirt=
ing
> > > > > around' binman which is suspect.
> > > > >
> > > > > If there is a need to generate an output file from the build, we
> > > > > should support it in binman. If people start creating configurati=
on
> > > > > files all over the place, then they are not using binman, right?
> > > > >
> > > > > I understand that there are pre-existing vendor-specific config f=
iles,
> > > > > etc. that the EFI thing is a grey area, but I cannot imagine that=
 this
> > > > > patch would lead to a good outcome.
> > > > >
> > > > > The goal of binman is to bring order to the chaos of firmware
> > > > > packaging...we cannot do that if it is not actually used.
> > > > >
> > > > > So let's figure out what is missing from binman's capsule generat=
ion
> > > > > (multiple capsules? accept/reject capsules?) and how best to add =
it.
> > > >
> > > > I think I need to jog your memory back a bit. For context, I have
> > > > jotted down the points.
> > > >
> > > > * The mkeficapsule tool generates capsules in U-Boot.
> > > > * Currently, when the tool is invoked from the command-line, the
> > > > capsules are generated by passing the capsule parameters as cmd-lin=
e
> > > > options.
> > > > * I had earlier added support for generating the capsules as part o=
f
> > > > U-Boot build, through binman. This support has been merged.
> > > > * I had followed these patches up with another series [1] which
> > > > generates capsules by parsing the capsule parameters through a conf=
ig
> > > > file instead of cmd-line options.
> > > > * This series also had patches which were attempting to integrate t=
his
> > > > functionality into binman [2].
> > > > * As part of reviewing the patch series, you had objected to adding
> > > > this support in binman, primarily because this way of specifying th=
e
> > > > capsule parameters goes against the normal way of image description=
 in
> > > > binman [3].
> > > > * I have described in this mail thread about why we need to have
> > > > support for generating capsules through config files [4].
> > >
> > > Thanks for that. Yes this fits with my memory, such as it is.
> > >
> > > I regard the tool as a binman tool, though, in the sense that binman
> > > is responsible for generating the images. For example, binman calls
> > > mkimage to handle FIT images. People are free to write a script to
> > > call mkimage manually, but the in-tree use of mkimage is supposed to
> > > be with binman.
> >
> > No issues with supporting the functionality through binman. However, I
> > think that if binman is to be used as the encompassing packaging tool
> > which in turn calls other tools like mkimage or mkeficapsule, it
> > should make allowances for accepting formats, or ways of describing
> > payloads that might not sit with it's core design of "each image is a
> > DT node".
> >
> > >
> > > >
> > > > So, in essence, this functionality is needed to be added to the too=
l.
> > > > I have earlier tried integrating this in binman, but that was
> > > > rejected. So, the way I see this moving ahead is to first add suppo=
rt
> > > > for this feature in the tool, and then see if this can also be adde=
d
> > > > in binman. As I mentioned earlier, I am fine with this functionalit=
y
> > > > not getting integrated with binman, if this contravenes the idea of
> > > > describing images in binman, and if no exceptions can be made on th=
at
> > > > regard. But please do understand that no attempt is being made at
> > > > 'skirting around binman'. In fact, I had worked on your earlier
> > > > objection of using absolute paths in testing this functionality in
> > > > binman. But then you had put the other objection of how this does n=
ot
> > > > follow the idea or concept of image description in binman. Hence th=
is
> > > > approach.
> > >
> > > It would be easier to talk this through f2f, but I will make an attem=
pt here.
> > >
> > > The goal here is for people to be able to create an EFI capsule (or
> > > more than one?) automatically as part of the build.
> >
> > That is one of the goals, yes. But the other goal is also to add
> > functionality to the base capsule generation tool which extends the
> > tool to support generating capsules through the config file. I would
> > be more than happy if this can be plumbed in as part of the build.
> >
> >
> > >  Since the config
> > > is in the binman description, putting it somewhere else doesn't help
> > > anyone. It will lead to .cfg files in U-Boot and Binman will just be =
a
> > > side show. That is my concern.
> >
> > Okay. But I don't think that is the main issue here. For example, we
> > can require the .cfg files to be placed in the board dir, similar to
> > how the capsule keys are placed. The issue here is that can binman
> > make allowances(IMO it should) to have the capsule payloads be
> > specified through a .cfg file parameter, instead of the usual way of
> > specifying it as a DT node. I think if this allowance can be made, it
> > solves all the issues here.
> >
> > >
> > > I would really like to see a capsule generated for sandbox so I can
> > > understand this better.
> >
> > I will work on the capsule generation for sandbox. I will generate
> > signed capsules, as you suggested in this mail thread as part of the
> > sandbox U-Boot build. However, this will be using the currently merged
> > capsule generation logic, where all the capsule parameters, it's
> > payload included, are specified in binman nodes. I suspect this won't
> > give you a picture of capsule generation through config files.
>
> Is there is progress on this? I would still really like to see a
> single capsule generated by the sandbox build.

I will come up with a patch to move the generation of signed capsules
for sandbox as part of the build. We can take the discussion forward
once this patch gets in. But I would really love to see progress on
this series, without or without binman support. Thanks.

-sughosh

>
> >
> > >
> > > Anyway, I hope that makes sense? If not, I think we should discuss it
> > > f2f or VC or somehow.
> >
> > Sure. I will be happy to have a VC anytime if you think that would
> > help. Let me know and we can sync up over IRC. Thanks.
>
> Perhaps we can do this in the new year. I think it would help to do a
> patch for the above first, though, since it might answer many of my
> questions.
>
> Regards,
> Simon
