Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293BC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 21:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA17782D06;
	Sat, 24 May 2025 23:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZfZaGEWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C708382D06; Sat, 24 May 2025 17:35:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AB982B70
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad51ef2424bso147348866b.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748100915; x=1748705715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oHy+N6xK4yya9R0YkoDmJitdUEYek74bTCT+WoW7PEg=;
 b=ZfZaGEWq3UQn59AaOuhB4vdlsm7QyLGwr7X6nFOd3I9BgPMbFMWQhNJ9n6g+lCy3b8
 gwOhtt1TZz/52nRZrnV/+0ha9BmUqpyPfFemGpc+9xQeXdLME1/iM2zFHXMZp2xkPBaO
 gwGIZThHtC+vvOmtHbH2bsYLAO7rg3NbZaaQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748100915; x=1748705715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHy+N6xK4yya9R0YkoDmJitdUEYek74bTCT+WoW7PEg=;
 b=a20ypA7irT2/2fi70fVbJ6fYfwroH0VL6ql7eQPM7ltL9rj9zHUCixYonaInc3geDG
 ePjYJgyF5JxN8Gjp7cGLlaedznIF/aYmLSftUBVcxzFV5rGWIeNml8GOHvLMdRoysa6j
 Z5Tk6Qw9418J5K59o5c/VatAmUpy4bC7E9VBK6DO7YF5EbsIp6qjiG06I1CUlK4MCfXV
 ADovqoD5m/+tKVs1Wd60BmB3n7xE9J8anShGe3xMfOTQC1QOEJ/tCdaJZKCSjRdSIC1B
 hr+khOmcbmjYsWFcckqhmZ936912bZuYH8f+CjKskD0OzM+Gbyx0lPzH1Tpvwlz0Sev3
 GgZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfRtlChyhULe50xFFuBmFCAAcTVsz6lKiuBkZUchQ0M5N5VmxP/kp68D5tw6K+ybdSLJWdtCk=@lists.denx.de
X-Gm-Message-State: AOJu0YytUcXYLiuenbfd/n58cvjcj/lWxl7p0erDbJ3glzS3c4jSOKTy
 b2129EIsyaTIbHVmcuHWtT0JaDmrMm/35eURX5z5Astz+rH4MXQEbetLdKKN+AGC3Xk+vkkRCWZ
 5G4fFfx8uNhDlea6Cr+VD7oenvnaCd0SMuuGJ5UsD
X-Gm-Gg: ASbGncvBwexqRs7e8e/ZjrUrcNt4Z98MJOmZbWnBuvPT6oWKUqGWUFsa4TF1H0UZLsj
 LnCEkDwalE0FPBYlfw3hhZKUvrKtjYYcaVzeu4FpXIczi+Z+glAsWK2+O8mfAy03FnxjONppEJF
 WSeQnp3yvKC7zKKuB4mZpS0kLFRwpBMug=
X-Google-Smtp-Source: AGHT+IGt6UYDHVDIEl5cD419guKkVuI8uwG+AmlbrDBkEiYA36Kv6PMOTAVd2SSQcGu5VWRzy4nSgcl9L0uXuajmfKk=
X-Received: by 2002:a17:907:3e95:b0:ad2:3f1f:7974 with SMTP id
 a640c23a62f3a-ad85b12061bmr235215766b.10.1748100914837; Sat, 24 May 2025
 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
 <20250523221729.GY100073@bill-the-cat>
 <CAFLszTiAdFTemZ9gJr8JCMO2EK2+ihsrKF0UxBHJhC7Fec6=Tg@mail.gmail.com>
 <20250524144116.GL100073@bill-the-cat>
In-Reply-To: <20250524144116.GL100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 16:35:03 +0100
X-Gm-Features: AX0GCFuUFTv8UmuI2BZZSWa7z5H4z-wB4ObPR6mpORNVghJYT8FArIIT5sTzkN8
Message-ID: <CAFLszTh52tgBEiPvese17ugmzxKoyBVcOpV70hCc+mSEGwo=Dw@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 adrianox@gmail.com, 
 bmeng.cn@gmail.com, caleb.connolly@linaro.org, christian@kohlschutter.com, 
 daniel@makrotopia.org, ddrokosov@salutedevices.com, eajames@linux.ibm.com, 
 francesco.dolcini@toradex.com, hiago.franco@toradex.com, 
 ilias.apalodimas@linaro.org, jdanisevskis@aurora.tech, j@jannau.net, 
 jeremy.compostella@intel.com, jerome.forissier@linaro.org, 
 maks.mishinfz@gmail.com, marek.vasut+renesas@mailbox.org, marex@denx.de, 
 mgarrett@aurora.tech, mkorpershoek@baylibre.com, michal.simek@amd.com, 
 moritzf@google.com, Oliver.Gaskell@analog.com, patrick.delaunay@foss.st.com, 
 patrick.rudolph@9elements.com, pkochanowski@sii.pl, pbrobinson@gmail.com, 
 philippe.reynes@softathome.com, quentin.schulz@cherry.de, 
 raymond.mao@linaro.org, semen.protsenko@linaro.org, 
 sebastian.reichel@collabora.com, sughosh.ganu@linaro.org, 
 tharvey@gateworks.com, vincent.stehle@arm.com, weijie.gao@mediatek.com, 
 ziyao@disroot.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 May 2025 23:59:02 +0200
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

Hi Tom,

On Sat, 24 May 2025 at 15:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 03:20:17PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 May 2025 at 23:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 23, 2025 at 09:23:15PM +0100, Simon Glass wrote:
> > > > Hi Mark, Tom,
> > > >
> > > > On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > > > >
> > > > > > Date: Fri, 23 May 2025 10:49:09 -0600
> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > > > > > Some functions provided in lib/efi_loader are actually useful for the
> > > > > > > > > app as well. This series refactors the Kconfig and directories a little
> > > > > > > > > so that code is easier to share.
> > > > > > > > >
> > > > > > > > > As a starting point, it moves some filename and device-path functions to
> > > > > > > > > the new directory.
> > > > > > > > >
> > > > > > > > > The next step would be to move device-path code over, but this will need
> > > > > > > > > some discussion.
> > > > > > > >
> > > > > > > > Hello Simon,
> > > > > > > >
> > > > > > > > Overall the ideas in this series look fine to me. But this series does
> > > > > > > > not apply to origin/next.
> > > > > > > >
> > > > > > > > Applying: efi_loader: Separate device path into its own header
> > > > > > > > Patch failed at 0001 efi_loader: Separate device path into its own header
> > > > > > > > error: patch failed: cmd/efidebug.c:8
> > > > > > > > error: cmd/efidebug.c: patch does not apply
> > > > > > > > error: patch failed: include/efi_loader.h:967
> > > > > > > > error: include/efi_loader.h: patch does not apply
> > > > > > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > > > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > > > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > > > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > > > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > > > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > > > > > >
> > > > > > > > Please, resend the series based on origin/next.
> > > > > > > >
> > > > > > > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > > > > > > this mailing list.
> > > > > > >
> > > > > > > The app is quite behind in Tom's tree due to rejected series.
> > > > > >
> > > > > > It was not "Rejected", it was "Changes Requested", please stop
> > > > > > mis-representing things.
> > > > > >
> > > > > > > In fact
> > > > > > > the app is pretty limited on x86 and there is no Arm app at all.
> > > > > > >
> > > > > > > My current plan is to move forward and eventually Tom might take it
> > > > > > > via a pull request.
> > > > > > >
> > > > > > > Do you have any other ideas?
> > > > > > >
> > > > > > > Perhaps this is something we could put on the agenda for a future call.
> > > > > >
> > > > > > There's nothing to discuss in a future call as step one is "post patches
> > > > > > against mainline".
> > > > >
> > > > > I agree with Tom here.  I did look at some of the patches in this
> > > > > series and now that I've learnt it doesn't even apply on top of
> > > > > mainline it feels like I've wasted my time.
> > > >
> > > > There is a base commit in the cover letter, so you could look at that
> > > > if you like.
> > >
> > > Yes, it's on a commit that's not in mainline. No one wants to look at
> > > your personal tree.
> > >
> > >
> > > > I plan to apply this series at some point, so any review is not a
> > > > waste of time. I do respond to review feedback.
> > >
> > > And since it's not based on mainline, this is why people have told you
> > > they don't want to review your changes. Since you aren't working on
> > > mainline it's unclear if it will ever be in mainline.
> >
> > From my side I would suggest that you avoid bringing up this point on
> > each patch. It doesn't seem to be working towards resolution. I am
> > doing what I need to, for now, for the project to make progress.
>
> No, you're hindering the project with your insistence on posting patches
> for your personal tree. I am trying to make it clear to the casual
> developers of the project that it is your personal tree and not
> mainline.
>
> > > Since this series in fact looks to be addressing some of the feedback
> > > that was provided to one of the series you applied yourself (the other
> > > being part of Casey's RFC), it would be much more effective to start on
> > > the next branch now with the leg work on factoring the common EFI things
> > > to be usable by EFI_APP and EFI_LOADER. This would lead to being able to
> > > rebase other work on top of it and reduce the delta between your tree
> > > and mainline. That's the only way it will get in to mainline.
> >
> > Yes I am acting on the feedback provided to Matthew's series and will
> > get there in the end.
> >
> > More generally, there is a substantial amount of work needed on the
> > EFI app and unfortunately this requires refactoring the EFI-loader
> > code to avoid duplication. Honestly, I'm not even sure that I want to
> > take that on, since my ability to get things into lib/efi_loader is
> > pretty limited and it is seldom an enjoyable experience. I am pleased
> > to see that the ANSI patch [1] is now in your tree, though, so thank
> > you for that.
> >
> > Re the app, I would very much like to send a PR at some point, but
> > there are other EFI patches not applied, so it is not trivial.
> >
> > I'm working with Heinrich on this and agreed with him that I'll take
> > another look...
>
> If you intend to get things in to mainline, you MUST stop posting things
> against your personal tree. You are making everything harder than it
> needs to be. You do not have some special exemption from the normal
> process. Iterative development on top of mainline, not some feature
> branch that branched off ages ago.

So how about:
- let me speed up your CI
- accept some of the things that you've previously rejected

In general, I think it would really help if you could adopt a more
incremental approach to development. It would also help if we could
discuss things every now and then, instead of all this email.

>
> And please note, *I* did not take the ANSI patch. Heinrich did. He and
> Ilias are the EFI_LOADER custodians. That's why it's in mainline.

Well I'm grateful in any case. It has been *infuriating* to have
random ANSI characters spewing into my terminal, to no useful purpose.

Regards,
Simon
