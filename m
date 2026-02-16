Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8457E63F36
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390DA8063E;
	Mon, 16 Feb 2026 18:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d5fU+j4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7171883AAB; Mon, 16 Feb 2026 18:20:03 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AA480325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so2075567a12.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771262400; cv=none;
 d=google.com; s=arc-20240605;
 b=XXyj2hkcfhzOhemrl5cPpL9g8CCtILN9LYUqquhx6iJnNiuw/xX2vQW+9IUq1BfV/X
 XaRJ4PNsTjngMm+pcBR4lEsSeQfXuVDfBgTsqmEmv/WTq2S5ceGOxW5ua538c+gB7cXU
 VKcWfMzcJTUgmyXqf6ObFD90GJjjR1+6Cn/kdCU8EVN0J2VkSlLINMUzV+v7AnT9cjJf
 BCpluM7R5SCD1vfXmG+sxrCSERtfrt4TqEy1a+ZwIsUE4U1n6PkB1UQLXFMs/bNRhnS3
 b0jDJ7WLwvyv3I5fkUT1G/3B+y2Gz2M5CTxyY8HULjjNCoDRi1Ie1DIEI1yNcpq6c1YP
 y8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WmcrNWJRUnfkiIPTpI7YDu91yXhxOhtS47S36bFUivg=;
 fh=VCXK+0/1N5FlYhIB/zMqGCXEmXhe/QfOEQc5hQLFJ+M=;
 b=GAcHVsTQ6Ng2boFaYe/a0/pqeLsrQLaHo45Tog9Af4War0mQqQRFHFeSwC5HJ0zsbx
 wbT5Lx9e8q8E9G0RmMKU47I9dyncqQ9p8ghPp1/oAP5QwQcVwu/A2K7adBl+5RNOof2p
 A4rpFDMnV49BJIaZjYBNT4vbQGOOqUjqHnXYYW4h5xQF9jTmnw1qQs8DRh4ySlDxNP93
 l5WOfokCvk+glLUO2oG714o7bKmpqoQdVWzwaslRexwvhLHLzWCjXz0Wk/4YdX8YKyLL
 w00XtIx5Bv8eEkAXexJepg9DKiuG26jTx1C6TWwn9qnr76ibnA+lqId0gfA0AFiPaFNO
 gxKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771262400; x=1771867200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WmcrNWJRUnfkiIPTpI7YDu91yXhxOhtS47S36bFUivg=;
 b=d5fU+j4QQlMobAi961/kzW/8suo3Higl0Q932mcU+LYiSmosTmFeM2Ln2D1JbmD0ed
 2xarflRJ8P5T6HmBq0vD6idMU29oSTtB0EIqzRvhp8mxOzOjq0UkPINrvYH0sLGjBgxb
 0zRvL+XH7NnfqUtz7SCoDW+PFb9RaeFduTQgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262400; x=1771867200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmcrNWJRUnfkiIPTpI7YDu91yXhxOhtS47S36bFUivg=;
 b=qG7+6zw9leA7TQbOq9AW9m3O9FFaKue2AwLDExTuCDyNfdm4VqlEsO/MUMFUN3FX33
 HcpIaUdyeUSHzlOrE2ebv1V5hqPL2EHATaZTEJnitlFnh+iaBGxTdjL85mZc6Vh6FgXN
 AI395VT7d3h6gRzBapS5PbRBecN36t8jDwf5fUPLLgUA5v6Gm6goTc9qw83ZuEXnVHbm
 IeErPGPmXeazrPxBtIkSZM2FaDXeiR/mA+Y3wZU6FL67KB5WJWPxAH7SbdSsAQhXvdtd
 mVnQd3uhVMhOj5Ts0kQMgPzyKNommCbXkY9wogY+5hFQIaLShDkDsCaMs/EtxCD01qwr
 rvSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGlK80TbHpb/FBxVAOGp5JXSmQ99x73amQaAh5D4wgZPR1dQgYiBrIaJ1ui7MNIdgBeuGy+44=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2tNrWRWqVJP3zHv4KjJoC8RajImkybSJACaEDKim5N7YR4O5v
 Bj4myiOnAEtyGZZ9xAp64FKAIu8ycr5DgSK/vtsKgfNnQ7cUjk6J+jbq582OBtcprJACnGT4SlE
 Nzk7ilC35vQyWDTYBWH2NmeDpVjroFGuK3V1p9zV6
X-Gm-Gg: AZuq6aIHcnM9u1c3T+lTLR9BKW+ymgxmzriURv2nuoOOSF1EdNq39EWw8YRNoQLQcA1
 TVTPeExOSTpfdBMSQlUX2naexrBPNH+XbH71Z5oeBtnl64cqxn4pCokaxBr5gUwdtkTky034d3o
 NMc1BAzidFvYnylThgVmi9T3MwcES6hgWvluWbEs7lsv7Qcg7j637n72KOvZSicpvS/fgBQWyZ2
 +sxzagYlQcACGMo40mP4PmmgQcNabiHqOH4b6aHRNt/848VQrosoomtHUp0uBwZTCxE52yl5clb
 POr3eg==
X-Received: by 2002:a05:6402:52c7:b0:65c:2af1:b7c1 with SMTP id
 4fb4d7f45d1cf-65c2af1badbmr1038613a12.28.1771262400354; Mon, 16 Feb 2026
 09:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
In-Reply-To: <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Feb 2026 10:19:48 -0700
X-Gm-Features: AaiRm51AzTtOYpRya6_ThPlUOvuIXGV7Az9g6vY9oSR_d8fGdHPodt_6xUjYJYI
Message-ID: <CAFLszTjB5OsdDRbSg7nduFtxzUT0jesvA7+dtU+op=YwfV+jqg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, me@samcday.com, aswin.murugan@oss.qualcomm.com, 
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi Varadarajan,

On Sun, 15 Feb 2026 at 22:31, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> [ . . . ]
>
> > > > > > I haven't been following this, but what sort of args are you planning to pass?
> > > > >
> > > > > As of now, an argument to indicate reboot to emergency download mode.
> > > >
> > > > So how about adding a struct in sysreset.h where you can include a
> > > > flag word and create a single flag for your case? We should be able to
> > > > handle reset without the cmdline being enabled.
> > > >
> > > > There are other cases where this would be useful, e.g. an EFI app
> > > > rebooting into setup boot.
> > >
> > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > option. This was added to avoid bloat code size for platforms that will
> > > not need this. Please see [2]
> >
> > Sure, but you are adding a new method, so you could make it take a new
> > struct instead of the string list, still behind your Kconfig option.
>
> Sure.
>
> You want 'request_arg' function pointer to take a structure instead of
> 'char * const argv[]'. Is this understanding correct?
>
> If yes, this string list is what was given in the command line. And is
> passed to the implementation specific handler.
>
>         Command line -> do_reset -> sysreset_walk_arg -> *request_arg
>
> The implementation specific handler can interpret the argv[] as
> applicable to itself. Not sure how to convert/parse this to a struct
> that can be used by EFI app. Am I missing something. Please advice.

Really I'm just trying to have it defined (in the uclass header) what
the behaviour actually is. An arbitrary string list seems too
open-ended, as well as being less efficient.

So I am thinking you can add a struct, define and document the fields
in it and then other people can use the same approach when they hit
this problem. For example, with the existing request() method, we
created an 'enum sysreset_t' to specify the reset type, rather than
using a string arglist. String arglist is good for the cmdline but not
for programmative code.

Regards,
Simon
