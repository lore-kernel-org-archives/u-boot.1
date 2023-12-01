Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929E5C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F6F871A4;
	Fri,  1 Dec 2023 19:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Irbc6DJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2BE8749E; Fri,  1 Dec 2023 19:32:16 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8142586F95
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c9caf896b7so29083521fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701455533; x=1702060333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VY/vj64t+3isstSSfMxoWVPmQI6/kqCaRheXsVj5UeY=;
 b=Irbc6DJzMLAPMHWzzHgM0ReokPZj358s6RHnTPI25P7SIHAqZ4IYLtmbGdN2CICNz7
 K6Xo/g9EDyd8lFFy5WRwioXHr607x+kTsv24eZJKsOPaPHxehTGkyR9jYh2ysXLDPnFz
 HKtOU6J723jDt1eUddlVR17mRhGr/KklsHfTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701455533; x=1702060333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VY/vj64t+3isstSSfMxoWVPmQI6/kqCaRheXsVj5UeY=;
 b=QHAGv3k5SkjAzuD/CC9i8YXKA/kmrrxbn4TxeoEAQeJuJX/fdTwDKxvLNNzX7YNbOy
 W1C563VyfgVZF5wOO/Q6JAFCdnkZUD6nY38vU5GjCCsju0+y2yLP7wO0bQ0N8MZilheI
 YwHDhNE2SUk2ZlnWyO13EezrMd79QVaI/ygrMSVzyXeyA90m7/46QvzjV6sa1K4qJ8Q4
 J9vQg3gx4qt0kb2A0Bgx57EenpenwuUWZr7widDaF+67XtPMUADC6OpxmW1x6K47fRvO
 2cBdKJh6irFSeL3DlaI0kkB5U2vWF1pbl0/tkj1B3kgor5l0Tk7GXeUL1FHjx/gzYlf5
 oN0g==
X-Gm-Message-State: AOJu0YxbQi3XIsevStXCjn28PUOhFoMymyU8FQ7duaJ1kn43//i6zj5W
 z0x9sjOZhfOoyBIK5tdkWw342iBqxieBlCQLf/Bq5g==
X-Google-Smtp-Source: AGHT+IFKGk4vILIl9cP+bCRlkwRlXoivz4eoXRSDG3p+P4pApqrd61d0GEjEALoajhJsBwOB76XZNksgwmBqyU8rCaA=
X-Received: by 2002:a2e:96d5:0:b0:2c9:d872:e7a9 with SMTP id
 d21-20020a2e96d5000000b002c9d872e7a9mr1087941ljj.96.1701455533244; Fri, 01
 Dec 2023 10:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
 <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
 <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
 <CAPnjgZ09vvyhBTUW03armbz_sevRr0qQeqL2vaQ3BNq+Wo9_dA@mail.gmail.com>
 <CADg8p96yHf7gSzHX4H6zaV-nx-BQ7qwmnBn6n5+xn969FCZKnQ@mail.gmail.com>
In-Reply-To: <CADg8p96yHf7gSzHX4H6zaV-nx-BQ7qwmnBn6n5+xn969FCZKnQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:32:01 -0700
Message-ID: <CAPnjgZ2Ryvp9WWmMCBPSANThYPVVda2dqXerwH0QiWn4wvdtiA@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

Hi Sughosh,

On Thu, 30 Nov 2023 at 23:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Thu, 30 Nov 2023 at 08:16, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 22 Nov 2023 at 00:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Ilias,
> > >
> > > On Wed, 22 Nov 2023 at 13:06, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > hi Simon,
> > > > >
> > > > > On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > Add support for specifying the parameters needed for capsule
> > > > > > > generation through a config file, instead of passing them through
> > > > > > > command-line. Parameters for more than a single capsule file can be
> > > > > > > specified, resulting in generation of multiple capsules through a
> > > > > > > single invocation of the command.
> > > > > > >
> > > > > > > The config file can then be passed to the mkeficapsule tool in such
> > > > > > > manner
> > > > > > >
> > > > > > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > >  tools/Kconfig              |  15 ++
> > > > > > >  tools/Makefile             |   1 +
> > > > > > >  tools/eficapsule.h         | 114 ++++++++++++
> > > > > > >  tools/mkeficapsule.c       |  87 +++++----
> > > > > > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > > > > > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > > > > > >  create mode 100644 tools/mkeficapsule_parse.c
> > > > > >
> > > > > > This patch keeps coming back :-)
> > > > > >
> > > > > > Can we not add multiple capsules in the binman description? Why do we
> > > > > > need a new file format? How can binman decode images produced in this
> > > > > > way?
> > > > >
> > > > > So as Tom mentions, this brings parity with respect to the other
> > > > > capsule generation tool in EDKII that generates capsules. IIRC, this
> > > > > is something which even Xilix was interested in, and Michal had kind
> > > > > of gone through these patches earlier. Lastly, it would be good to
> > > > > have support in U-Boot's mkeficapsule tool for generating a single
> > > > > capsule file with multiple payloads, and having support for this
> > > > > functionality helps in that goal.
> > > > >
> > > > > Also, you might have noticed that, since your objection to the last
> > > > > series, I have removed putting this in binman. So now, this aspect of
> > > > > the capsule generation would only be supported through the
> > > > > command-line invocation of the tool.
> > > >
> > > > I think that overall the approach is sane. mkeficapsule is currently
> > > > supported and compiled for distros, so the multiple payload support is
> > > > useful. If we want to add support to binman, instead of rewriting this
> > > > in python, we could just call that tool for parsing and creating
> > > > capsules
> > >
> > > Given the amount of time these patches have been under review(also
> > > number of iterations), I would request that this series be reviewed
> > > and merged first. I think there is general consensus that there is
> > > value to have this functionality in the mkeficapsule tool. If it is
> > > deemed fit to support this through binman as well, that task can be
> > > taken up separately. Thanks.
> >
> > The point you are missing is that it is the entire goal of 'skirting
> > around' binman which is suspect.
> >
> > If there is a need to generate an output file from the build, we
> > should support it in binman. If people start creating configuration
> > files all over the place, then they are not using binman, right?
> >
> > I understand that there are pre-existing vendor-specific config files,
> > etc. that the EFI thing is a grey area, but I cannot imagine that this
> > patch would lead to a good outcome.
> >
> > The goal of binman is to bring order to the chaos of firmware
> > packaging...we cannot do that if it is not actually used.
> >
> > So let's figure out what is missing from binman's capsule generation
> > (multiple capsules? accept/reject capsules?) and how best to add it.
>
> I think I need to jog your memory back a bit. For context, I have
> jotted down the points.
>
> * The mkeficapsule tool generates capsules in U-Boot.
> * Currently, when the tool is invoked from the command-line, the
> capsules are generated by passing the capsule parameters as cmd-line
> options.
> * I had earlier added support for generating the capsules as part of
> U-Boot build, through binman. This support has been merged.
> * I had followed these patches up with another series [1] which
> generates capsules by parsing the capsule parameters through a config
> file instead of cmd-line options.
> * This series also had patches which were attempting to integrate this
> functionality into binman [2].
> * As part of reviewing the patch series, you had objected to adding
> this support in binman, primarily because this way of specifying the
> capsule parameters goes against the normal way of image description in
> binman [3].
> * I have described in this mail thread about why we need to have
> support for generating capsules through config files [4].

Thanks for that. Yes this fits with my memory, such as it is.

I regard the tool as a binman tool, though, in the sense that binman
is responsible for generating the images. For example, binman calls
mkimage to handle FIT images. People are free to write a script to
call mkimage manually, but the in-tree use of mkimage is supposed to
be with binman.

>
> So, in essence, this functionality is needed to be added to the tool.
> I have earlier tried integrating this in binman, but that was
> rejected. So, the way I see this moving ahead is to first add support
> for this feature in the tool, and then see if this can also be added
> in binman. As I mentioned earlier, I am fine with this functionality
> not getting integrated with binman, if this contravenes the idea of
> describing images in binman, and if no exceptions can be made on that
> regard. But please do understand that no attempt is being made at
> 'skirting around binman'. In fact, I had worked on your earlier
> objection of using absolute paths in testing this functionality in
> binman. But then you had put the other objection of how this does not
> follow the idea or concept of image description in binman. Hence this
> approach.

It would be easier to talk this through f2f, but I will make an attempt here.

The goal here is for people to be able to create an EFI capsule (or
more than one?) automatically as part of the build. Since the config
is in the binman description, putting it somewhere else doesn't help
anyone. It will lead to .cfg files in U-Boot and Binman will just be a
side show. That is my concern.

I would really like to see a capsule generated for sandbox so I can
understand this better.

Anyway, I hope that makes sense? If not, I think we should discuss it
f2f or VC or somehow.

Regards,
Simon

>
> -sughosh
>
> [1] - https://lore.kernel.org/u-boot/20230908120002.29851-1-sughosh.ganu@linaro.org/
> [2] - https://lore.kernel.org/u-boot/20230908120002.29851-4-sughosh.ganu@linaro.org/
> [3] - https://lore.kernel.org/u-boot/CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com/
> [4] - https://lore.kernel.org/u-boot/CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com/
>
> >
> > >
> > > -sughosh
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > >
> > > > > > Also, could we get sandbox to produce one EFI capsule as part of the
> > > > > > normal build? I think that discussion trailed off.
> > > > >
> > > > > Yes, apologies for missing out on this. Slipped my mind. Would you
> > > > > want, say, all the non-signed capsules to be generated as part of the
> > > > > sandbox build?
> > > > >
> > > > > -sughosh
> >
> > Regards,
> > Simon
