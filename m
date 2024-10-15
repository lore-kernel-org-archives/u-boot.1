Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A7D216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77DB88113;
	Tue, 15 Oct 2024 15:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I1rpRCjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5741A881A9; Tue, 15 Oct 2024 15:26:10 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168B6880F4
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e57872eb49so1818445b6e.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728998766; x=1729603566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TYufjr2VgAcKZTgKzGVGVm1a8gkjJ+WTwEuMsg737j8=;
 b=I1rpRCjEmD/gncG81T07qZpYQQ5N8yJr4ObZJVkXKPXbIIwUgjurRxwL9CK1J2rB+5
 lBbfl6b0Vys7HcrrkEatH/mWQzJG3g5gQ4p5Y/TtV9OpF1jZnMlb+SNk6jFtdZhOA4J5
 U8xQi8stVDGv6U8kX34fmmIJwa/+iozi5wr9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998766; x=1729603566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYufjr2VgAcKZTgKzGVGVm1a8gkjJ+WTwEuMsg737j8=;
 b=O2AO4EqeVfZzY/Po72n5CCVMvk8owyRS3+PRvzIS7uhrpAFPLvS8BbAFxETCSucyPh
 fyo3IBt7QCbnSTdGWUF2qrmsm5XWIa4cZTlzRagYtFFNVBXB7kg/xMf/v64XTDhiFyiP
 j/Mo97UXxWtjFINgZSlLkq7VtBS46YSvudF1336XzeOeDMkOWyNhKFwpGGduJpxAO540
 u9uU+RFAiSkOvi4kJBITxTvuqDlw6IpqmTZEpq+LG49aVgMosFVPThwHTgy9AprnHOFC
 FYUVSTvWvBs/JCA0wkTUEFId2B5xX1zAbEo4QCfqCZ7yNxSgIYfdK8U1hjdOfoKfxJKg
 OmTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22cX6zMBjklRKJKQ8kDPmSuwdHVK9s/+S3GH0r7FX/Ea7aQNF4umB9gumtpzF+umxRLkNvOs=@lists.denx.de
X-Gm-Message-State: AOJu0YxwxpwGgjM0nzLEwis81qADZDq1o9DZzLKOG9R7ikKPBjT3eyfd
 SbLdOW6PlDJozErshOBXh7ebNENlulLMsYQE9dqVYFYQ2ARP6qq+VxwSObpz4oKfIsMQhGI877n
 Mo8KUO2kRMjnYID/Cb2hESkDhO2ZI4IHS2pys6eNsXcliJ7U=
X-Google-Smtp-Source: AGHT+IEXnefjnSgpJn4a5mjIsIpPyEeNqBgh6mJEO78dDLAVDsfFH90+2+pwzq5E5xBfNpivmN0c12O93kNvwU2zMJk=
X-Received: by 2002:a05:6808:3996:b0:3e0:416e:24e8 with SMTP id
 5614622812f47-3e5c9128850mr12175963b6e.41.1728998766669; Tue, 15 Oct 2024
 06:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
 <20241014211150.GX53053@bill-the-cat>
 <87cyk1hdne.fsf@bloch.sibelius.xs4all.nl>
 <23757cf3-c27a-498d-9e66-59261f060102@gmx.de>
In-Reply-To: <23757cf3-c27a-498d-9e66-59261f060102@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 07:25:55 -0600
Message-ID: <CAFLszTikKJ29TEzCQHBL1JfYz4b+O0eVps2Aa9_pMuwHBZgByA@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Tue, 15 Oct 2024 at 05:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 15.10.24 12:19, Mark Kettenis wrote:
> >> Date: Mon, 14 Oct 2024 15:11:50 -0600
> >> From: Tom Rini <trini@konsulko.com>
> >>
> >> On Mon, Oct 14, 2024 at 01:13:41PM -0600, Simon Glass wrote:
> >>
> >> [snip]
> >>> Or perhaps just have a way to turn it off? I first sent this patch
> >>> last November. It is just wrong to generate output like this which we
> >>> don't want. There isn't even a test for it, so just add a way to
> >>> disable it, and be done!
> >>
> >> I don't know that it's unwanted. As I'm trying to get Heinrich to
> >> explain, _why_ does efi_setup_console_size need to exist, and do what it
> >> does? This isn't the case of color-coding the output of tests as they
> >> happen, there must be a reason we care about knowing the console size.
> >> At that point we can figure out if the right answer is:
> >> - Don't generate that check on serial ports, it's somewhere between
> >>    misleading to wrong.
> >> - text-based tests just need to expect and skip it because there's a
> >>    good reason to need to know the console size and not just assume
> >>    80x24.
> >> - Something else we won't know until it's clearly explained why we do
> >>    this.
> >
> > Sadly this is a misfeature of UEFI.  The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
> > is required if console devices are supported by the UEFI
> > implementation, and is built around the concept of "text mode" with a
> > fixed number of character rows and columns.  That pretty much assumes
> > there is some sort of terminal emulator on the other end.  And this is
> > pretty much incompatible with anything that just want to log serial
> > output.
> >
> > I think it is possible to do better though.  Instead of calling
> > efi_setup_console_size() in efi_init_obj_list(), we could postpone
> > this until the application makes a call that requires us to know the
> > size.  This would mean that a simple EFI application that just uses
> > EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString() (such as the Hello
> > world EFI application or the OpenBSD EFI bootloader) wouldn't have to
> > do the size query.
>
> The implementation of EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString()
> needs to know the output size to update the cursor position in
>
>    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorColumn
>    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorRow
>
> The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL is passed to the entry point of any
> EFI application via the system table.
>
> We could delay the invocation of efi_setup_console_size() to the launch
> of the first EFI application (efi_start_image()).

That's a start, but I think the right answer here is to use my flag
and in efi_setup_console_size() don't call query_console_serial() if
the flag is set. Then the default (80x25) will be returned, which is
fine for the test which is the subject of this series.

Regards,
Simon
