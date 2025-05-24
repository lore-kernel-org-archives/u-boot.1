Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A314C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9EE82F67;
	Sat, 24 May 2025 17:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fTNku4DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C13D82AE2; Sat, 24 May 2025 16:20:32 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1093383264
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601609043cfso1202731a12.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748096429; x=1748701229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cw0B0AzvuJvVzOxKbxKve4l67N/w29kuzyLEhvDc03k=;
 b=fTNku4DCJNgnv4DBWDdQgGIPy3FVYB1uM+448OageLpusRDtdOi4iHgbt3AqMPJ/qg
 s4pIbQ6ebbUjfhS76LcNrbFJQc75N03cF8cKxlvoZrnLEwi4fVkYBtlNup3Pql/7BBfN
 M5Z1BUViQKk9uOUNdxznoTnwHq2CyIoEZnveY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096429; x=1748701229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cw0B0AzvuJvVzOxKbxKve4l67N/w29kuzyLEhvDc03k=;
 b=U8n0eS4fsEGnaAgGWCV/E0gxw2nGYEkzrVInn/U0xHTCmtcohA1Na9ylr4r7Gwd05e
 d77/JQlxMxUcD3KOthbrhdN0eHFxmX49dzW80TlzXsUiDfJVMYKG3gaxpjUBHCc3WOw+
 LRQPA2OOS/PmtWZgUTmumNO9RVBFyW4L6UIvKOhtGcPVcCAKwT7+ApCUYuPJkR+GxEla
 1uY0mWxaiocUeKmMcxESYLqi31b4jfcO2loLyh3xE4mitBFYT+JCxese2hBdz3gCPYLc
 h3hxuXoGheyghk5eYtNGdQHcZofqCRFjQpjjHR8MuPfYudMDpasafCThwxNMZajw338p
 14ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzD2acq72eaEua3kiDpz/Qw+FPc5QIXgJxX2OpWHXvRDoOZZowkxh2H9HTDBxxq7hB8M/9acA=@lists.denx.de
X-Gm-Message-State: AOJu0YzzTUa5ih234ahPpUVK0nlyqwsI8Kbs7OUMP13tPXd665YatkJL
 diDwIE/5nyn69mfS8R1YYzeS+kV4X4LYlokkSwNF1fcuVgGMW+LuaFamSbvjdtZA8xhXK5GGv7i
 tfCXwRg4LsESFBAiQgVrliL7YCVOhFSf5u3RYPz9s
X-Gm-Gg: ASbGnctnPcRvUMKaTmBJmMz0jQOuomMv6TVvW6rnORLFEt+jPS/isx4egMNlqvCgges
 WIW2ivLlZ1QYf43izepoZUklzncMf649taK4GkDUHFChHLJ0WdPiCIJMw50WvwbkTKsIaifpZ7d
 GkW01Y22bFcwnB1/njoNrMtey2YMGuZAIvLNBvHJKruQ==
X-Google-Smtp-Source: AGHT+IHk0e4pjzfuM8EK4qZiPnHk+gAehBFnUJQ33yaB4Cb9+r8009wZ4NdfoeZyYGDEdwrqFqN1z8+FLZk+9YiPaOk=
X-Received: by 2002:a17:907:7e88:b0:ad5:4c1b:b49b with SMTP id
 a640c23a62f3a-ad85b22a5c1mr250526066b.42.1748096429342; Sat, 24 May 2025
 07:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
 <20250523221729.GY100073@bill-the-cat>
In-Reply-To: <20250523221729.GY100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 15:20:17 +0100
X-Gm-Features: AX0GCFuqbfa_tvj4ablTOV8wOtH0-4-rHjjT3cN1CuYnqq1kIYCrpviGGBqmOww
Message-ID: <CAFLszTiAdFTemZ9gJr8JCMO2EK2+ihsrKF0UxBHJhC7Fec6=Tg@mail.gmail.com>
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
X-Mailman-Approved-At: Sat, 24 May 2025 17:07:23 +0200
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

On Fri, 23 May 2025 at 23:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 09:23:15PM +0100, Simon Glass wrote:
> > Hi Mark, Tom,
> >
> > On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > > Date: Fri, 23 May 2025 10:49:09 -0600
> > > > From: Tom Rini <trini@konsulko.com>
> > > >
> > > > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >
> > > > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > > > Some functions provided in lib/efi_loader are actually useful for the
> > > > > > > app as well. This series refactors the Kconfig and directories a little
> > > > > > > so that code is easier to share.
> > > > > > >
> > > > > > > As a starting point, it moves some filename and device-path functions to
> > > > > > > the new directory.
> > > > > > >
> > > > > > > The next step would be to move device-path code over, but this will need
> > > > > > > some discussion.
> > > > > >
> > > > > > Hello Simon,
> > > > > >
> > > > > > Overall the ideas in this series look fine to me. But this series does
> > > > > > not apply to origin/next.
> > > > > >
> > > > > > Applying: efi_loader: Separate device path into its own header
> > > > > > Patch failed at 0001 efi_loader: Separate device path into its own header
> > > > > > error: patch failed: cmd/efidebug.c:8
> > > > > > error: cmd/efidebug.c: patch does not apply
> > > > > > error: patch failed: include/efi_loader.h:967
> > > > > > error: include/efi_loader.h: patch does not apply
> > > > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > > > >
> > > > > > Please, resend the series based on origin/next.
> > > > > >
> > > > > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > > > > this mailing list.
> > > > >
> > > > > The app is quite behind in Tom's tree due to rejected series.
> > > >
> > > > It was not "Rejected", it was "Changes Requested", please stop
> > > > mis-representing things.
> > > >
> > > > > In fact
> > > > > the app is pretty limited on x86 and there is no Arm app at all.
> > > > >
> > > > > My current plan is to move forward and eventually Tom might take it
> > > > > via a pull request.
> > > > >
> > > > > Do you have any other ideas?
> > > > >
> > > > > Perhaps this is something we could put on the agenda for a future call.
> > > >
> > > > There's nothing to discuss in a future call as step one is "post patches
> > > > against mainline".
> > >
> > > I agree with Tom here.  I did look at some of the patches in this
> > > series and now that I've learnt it doesn't even apply on top of
> > > mainline it feels like I've wasted my time.
> >
> > There is a base commit in the cover letter, so you could look at that
> > if you like.
>
> Yes, it's on a commit that's not in mainline. No one wants to look at
> your personal tree.
>
>
> > I plan to apply this series at some point, so any review is not a
> > waste of time. I do respond to review feedback.
>
> And since it's not based on mainline, this is why people have told you
> they don't want to review your changes. Since you aren't working on
> mainline it's unclear if it will ever be in mainline.

From my side I would suggest that you avoid bringing up this point on
each patch. It doesn't seem to be working towards resolution. I am
doing what I need to, for now, for the project to make progress.

>
> Since this series in fact looks to be addressing some of the feedback
> that was provided to one of the series you applied yourself (the other
> being part of Casey's RFC), it would be much more effective to start on
> the next branch now with the leg work on factoring the common EFI things
> to be usable by EFI_APP and EFI_LOADER. This would lead to being able to
> rebase other work on top of it and reduce the delta between your tree
> and mainline. That's the only way it will get in to mainline.

Yes I am acting on the feedback provided to Matthew's series and will
get there in the end.

More generally, there is a substantial amount of work needed on the
EFI app and unfortunately this requires refactoring the EFI-loader
code to avoid duplication. Honestly, I'm not even sure that I want to
take that on, since my ability to get things into lib/efi_loader is
pretty limited and it is seldom an enjoyable experience. I am pleased
to see that the ANSI patch [1] is now in your tree, though, so thank
you for that.

Re the app, I would very much like to send a PR at some point, but
there are other EFI patches not applied, so it is not trivial.

I'm working with Heinrich on this and agreed with him that I'll take
another look...

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250510125457.1571220-1-sjg@chromium.org/
