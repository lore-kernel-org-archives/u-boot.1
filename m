Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9720E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB15089100;
	Sat,  7 Dec 2024 00:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AJZjz65M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EECD89124; Sat,  7 Dec 2024 00:44:03 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A728890D9
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa63dbda904so245140766b.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733528639; x=1734133439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/yUWgOU8PGJBtgV1sgH8hyftJoIhotkTvo96ff1hKNU=;
 b=AJZjz65MMAnT8LXcdWkoJrfmc8a9Ad3RCnAA9tJQ9x8mL477kjPK8kqDiP3dFEJxO6
 tq+6r6evm/O72d5J6W7dpdqeGUW1p35TgbDscPSKLGXHzfl+xSJgmShk4RVVyk5qbycC
 XH71XzbnrCDn5e8qfD6CGJ7KK+ia/1ergvYdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733528639; x=1734133439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yUWgOU8PGJBtgV1sgH8hyftJoIhotkTvo96ff1hKNU=;
 b=aifEhgHDmP2q/jgkUGoBgi9jZwYiHl/A7Ea6L80qVzB9ELZDtLSMwybIXY3G1kTqLb
 NdNQ9EnTsHf5ZpEW9GWdNO94tuphaqa8a8AxIrwP/ACXxTF5iaCTsAWDg1YOHAuGXZ54
 LV8LMc+ZpTzNT1sVB3BrkeHHcFao2Z4Tkp4/xYRFFP60ne51fJ1fZtEl87nvE714w5Es
 Fsx02iWu/gN2vVqEJ1/7y9YvbH5ngdh2RhdXFoMUeVYga4VdekaaG6emPk8z/zU5XUke
 2bojP4bzHNiOVMqONDMdMuPSl3mtihVI9hNHlWZN7T9T0DdkLKucAGa2oJ2+0Eb1F7qn
 OuSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZe2zcoin8Eg1i2U+nRC02FvKuq7wRe0Rrh5A6SZGa/j2VCz9E//GvyerbcmICSA1mDTHDVI8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1xa9Mh4RwbYPP0iYMhwJqih/X2e5xOvLeJID7IMdDBAbkR7n8
 8A1QTjhYt3zPhF8p8vdxN6Kn6zHnZlYPymkqhf+P3YnCPZk0316xA/PgTLScXDx5kaP6To2Rl21
 1MKaY5+fVeb8TKKohsVG3fg4XHxcjcauYymU7
X-Gm-Gg: ASbGncuocD2HXMPSBH+0K6d18OVoSTU5iMs9hgb22axOh+obCqSpzA4Ja3pBSZqhwNz
 ofSFFS+9nAKbBB9gTaQFyt2nAPzL/1BU3
X-Google-Smtp-Source: AGHT+IE5BQUiwL+OglCi/9/alVZK72tekXrkmt7xFYybwYmN5cbujiizETz5OkB75eAlCxSQBUxEM9tnPSyay2MWr0s=
X-Received: by 2002:a17:906:9895:b0:aa6:2987:9a48 with SMTP id
 a640c23a62f3a-aa639fa52f4mr434470166b.1.1733528639315; Fri, 06 Dec 2024
 15:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <20241206201236.GA2457179@bill-the-cat>
In-Reply-To: <20241206201236.GA2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 16:43:47 -0700
Message-ID: <CAFLszTg2Y13iUsL7EHcw=8cKY_ii==ANoG-ztpS0Y5eMc_UKow@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Fri, 6 Dec 2024 at 13:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > > >
> > > > > > From my side I'd like to change the conversation a little, to how to
> > > > > > land code, rather than why we should bother. "Code needs to land"
> > > > > > should be the motto. If someone has taken the time to create
> > > > > > something, our bias should be towards getting it in, with sufficient
> > > > > > changes to make it fit the project. There are cases where something is
> > > > > > just a bad idea, or should be done another way, but for people working
> > > > > > on major features or changes, biasing towards not landing the code is
> > > > > > just going to make them go elsewhere.
> > > > >
> > > > > This is the wrong approach I believe. The goal has always been and
> > > > > continues to be to have reviewed (whenever possible, our developer
> > > > > community is small) incremental change over time.
> > > >
> > > > Yes, I agree with that, but it isn't what I said.
> > >
> > > I don't know how else to interpret "Code needs to land". I'm not sure
> > > what reviewed patches we have that are outstanding, but also not fairly
> > > new. We do have patches outstanding, in general. Much of those fall in
> > > to the categories of:
> > > - Custodian is active, but also very busy (virtually everyone is a
> > >   volunteer so I have a hard time getting forceful with people that have
> > >   a large queue).
> > > - Custodian isn't active / no direct custodian and the code hasn't been
> > >   reviewed by anyone else.
> >
> > Here's my intention with 'code needs to land': to bias against people
> > saying "I don't like this; I don't care about your use case; please go
> > away"
>
> To me that applies an arbitrary nature to patches being rejected, which
> I do not see as being the case.
>
> > > > > Just because something
> > > > > has been posted a number of times does not mean it's ready to be merged.
> > > >
> > > > I didn't say that either.
> > >
> > > It's an impression you give however when you repost a series less than a
> > > day after last posting, without addressing all of the feedback.
> >
> > I'm going to ignore that comment as it is not helpful and
> > mischaracterises my contributions.
>
> I stand by it, and will let others judge if that's the impression they
> have, or not.

I'll put the relevant threads at [1], ditto.

>
> > > > > Your challenge today is that on patchwork you have over 150 patches
> > > > > covering a wide variety of topics and of which many series have
> > > > > technically-merited feedback that needs to be addressed in a technical
> > > > > manner.
> > > >
> > > > By my count I have about 10 series in progress, with a small number of
> > > > patches (< 10?) with pending feedback
> > >
> > > I'm not sure about that less than 10 number, in part because it's hard
> > > to keep track of which feedback was applied, and which not. And part
> > > because some of those series are places where I told you I'm unsure
> > > about the core concept but you asked and I'm giving you leeway to show
> > > me the end result.
> >
> > OK
> >
> > >
> > > > that isn't effectively just a
> > > > NAK.
> > >
> > > To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> > > technical rationales and requests. But maybe they're just lost in the
> > > volume of emails you have in some cases. I know for example I mentioned
> > > a few times and places that we have tests today for booting the OS, when
> > > you mention that we need to add a test for booting the OS. We need to
> > > expand that test, yes.
> >
> > If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> > see any other way to interpret it,. So several boards in my lab have
> > been broken for a year.
>
> To be clear, you want to revert:
> commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> Author:     Simon Glass <sjg@chromium.org>
> AuthorDate: Wed Jan 3 18:49:19 2024 -0700
> Commit:     Simon Glass <sjg@chromium.org>
> CommitDate: Sun Jan 7 13:45:07 2024 -0700
>
>     fdt: Allow the devicetree to come from a bloblist
>
>     Standard passage provides for a bloblist to be passed from one firmware
>     phase to the next. That can be used to pass the devicetree along as well.
>     Add an option to support this.
>
>     Tests for this will be added as part of the Universal Payload work.
>
>     Signed-off-by: Simon Glass <sjg@chromium.org>
>     Reviewed-by: Tom Rini <trini@konsulko.com>
>     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Which means that you did not test your changes on your hardware at the
> time? And wish to (seemingly) replace that with an earlier version of
> the patch which was objected to on technical grounds at the time.
> Without explaining why the current code does not function on these
> platforms, only that it does not, for entirely unclear reasons.

It never worked on my board, though. I spent 6 revisions trying to
explain that. After number 6 [2] you got in touch and said that I
needed to rework it, which I dutifully did, in version 7 [3]. I did
that purely to unblock Raymond's series. I even put that in the patch:

"The discussion on this was not resolved and is now important due to the
bloblist series from Raymond. So I am sending it again since I believe
this is a better starting point than building on OF_BOARD"

Are you now saying I should have refused and argued for another few
revisions? Patience does have its limits.

>
> So I do not think I've arbitrarily nak'd the revert you posted, I've
> been asking you to explain why the code doesn't work. And I still don't
> have an answer as to why after at run time we don't find a valid
> bloblist here the fall-back use cases aren't functioning. To me that
> seems like the bug to investigate and explain. Reverting code to find
> when functionality broke is great, I do it all the time. Saying we need
> to revert because something broke *without* saying why it broke is a
> problem.
>
> > > > It isn't a particularly large number, if you add up the patches I
> > > > do in each cycle. It is in the nature of development and code review
> > > > that things are often not right the first time, or someone else has
> > > > another perspective, so I cannot see how this can be reduced.
> > >
> > > The easy way to reduce it would be to go from 10 series in progress to 1
> > > series in progress, and finish that before picking up series number 2,
> > > and so on. And then in the future, stop when you have more than 2 or 3
> > > in progress at once.
> >
> > That's obviously not practical for the amount I am contributing and
> > the length of time it takes us to get things in. I hope it isn't a
> > serious suggestion!
>
> It's extremely serious. For example
> https://patchwork.ozlabs.org/project/uboot/list/?series=435516&state=*
> is a 46 part patch series that touches 3 or 4 different areas and the
> only type of review that's feasible is "Does this cause the binary to
> grow too much? Or in unexpected ways?" And that sets aside that I
> believe I did ask you to rework "bootm: Allow building bootm.c without
> CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN is always
> defined. That's not even a hard change, I say as someone that had to do
> that as part of Kconfig migration of oddly (ab)used symbol names.
>
> But in this case, your series that touch areas of code actively
> maintained by other people is even more relevant. Whereas areas without
> other active developers, or where you are the main developer, I can find
> some smaller limits on what must be reviewed all of your *EFI* has other
> active developers on it. Who are providing technical feedback, not
> arbitrary or stylistic feedback. Please be explicit about what you are
> suggesting in this case, so I do not mischaracterize your intention.
>
> > > But really, it feels like "Code needs to land" is another way of saying
> > > "Just a NAK should be ignored".
> >
> > Yes, a bias more towards that would be more healthy IMO. A NAK needs
> > to come with a full understanding of the use case, an alternative way
> > to meet the use case, once that doesn't involve boiling the Pacific
> > Ocean.
>
> As it stands, I do not like to, but sometimes feel I *have*to* break one
> board to unbreak another board and keep reminding both parties to
> resolve the issue so no board is broken. There has been, since I have
> taken over the lead of the project, at least once where I have
> over-ruled the relevant custodian and that has resulted in the custodian
> leaving. I both feel that was the right technical call, and regret it
> came to that, still. I do not want to adopt a more broad use of that
> policy. The default for absence of agreement must be to try again.

I see that Peter sent a few indignant emails. You can't win.

Regards,
Simon

>
> --
> Tom

[1]
https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20230921015730.1511373-31-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20230924192536.1812799-37-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20231228133654.2356023-1-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.2482268-1-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413568-1-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20241201144240.1664398-5-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20241201144240.1664398-6-sjg@chromium.org/

[2] https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.2482268-1-sjg@chromium.org/

[3] https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413568-1-sjg@chromium.org/
