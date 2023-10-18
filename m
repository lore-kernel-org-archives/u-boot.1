Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5942ECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9903786C6E;
	Wed, 18 Oct 2023 05:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kWCHEzGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EE386D51; Wed, 18 Oct 2023 05:30:44 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E1186B05
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso65472031fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599841; x=1698204641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zWWFuQ+WdBYLcaiwZgUr2x3PdUaFgMEnzjKnXcrHezg=;
 b=kWCHEzGtZE2OZtVBWKGkQmRDWlUP1o12e/Lyu3x3yNtHaUYkmKAmuC4+aDCsr86WMs
 akzI/x5gKFdqAwu32tdL1194495icdmlVFucie+clcoyVc8XOeGjkJBLqLrjkOpuzj4z
 mSwh4UcNDFjZ+trfwo6F2PNk8Qur2lCjpmQw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599841; x=1698204641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWWFuQ+WdBYLcaiwZgUr2x3PdUaFgMEnzjKnXcrHezg=;
 b=CX0+aHjDg/h+/i2Rp1hQDBU+Ikhhv9Ql7GPd0iFOphvwG1MyghtJ6EF+yBgbxV5ZXf
 At4mhiW/gdkmp1GfwGqJCNBAhVkrg9MXZcSYvVQdrLLvnXSAJY/2xTDNmXrPAEncSsaw
 drySOwEwz5Vub+tGxCrtLPnoGj2IOkOCXGZFwVFUaf5irp2+AvCQ/NaaytEyeEK1I85T
 6JEVn02p2HyRAgq5CdMgIidl/jxcUaQqkFebq3+HmWFY/B2f+B5UfW5D1vvgy9dyvgrM
 zwqwjG0DIGpbgGXh6MxKrkFyxXMisOg+O7/jy7Sqw1RWRNCVbhP49H2edjJTV2GTywo9
 vuVg==
X-Gm-Message-State: AOJu0Yy6NfPsbePsY1ReBURDRGmBjOs5CLrWkO4/Pn8vn5f98LKj/NRq
 Nbeycsufvhh6OjI2/zFRz8pAodmlKUF9lifr2MxGavgxF0oQVHxsGqA=
X-Google-Smtp-Source: AGHT+IG+VusPzZvvZrnppjh68L4jQHppKhKwNkyisrkf6Q7w1YhMIKHgzVd9zItN+QROtDcBWveOBLsP2V869VHMJLQ=
X-Received: by 2002:a2e:b003:0:b0:2c5:19aa:ca83 with SMTP id
 y3-20020a2eb003000000b002c519aaca83mr2921784ljk.20.1697599841273; Tue, 17 Oct
 2023 20:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-3-sjg@chromium.org>
 <20231017133224.GS3119521@bill-the-cat>
In-Reply-To: <20231017133224.GS3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:30:30 -0600
Message-ID: <CAPnjgZ1cEr_=EdnBatQ1_LMsC9KD0g5bCJt_qvBkQifV+tb0ag@mail.gmail.com>
Subject: Re: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Oct 2023 at 07:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:27:53PM -0600, Simon Glass wrote:
>
> > With recent changes over the last few years in boot/Kconfig it is
> > no-longer possible to disable CMDLINE. It results in various link
> > errors because some options which require CMDLINE are enabled
> > regardless of whether it is available.
> >
> > Add the necessary conditions to fix this.
> >
> > Note that it would be better to have all commands depend on CMDLINE,
> > but that is extremely difficult at present, since some functions use
> > CMD_xxx to enable feature xxx. For example networking and environment
> > have a number of problems to tease apart.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Since you later rework things to tease apart most, if not all of this,
> please split out the patches which tease things apart in to their own
> series so that the rest of this becomes reviewable and also reasonable
> looking.

At this point I fear I have lost track of things, since there is just
too much going on. Just in this version I have dealt with:

- some EFI stuff (which needs tweaking)
- teasing apart the CLI handling (which apparently doesn't go far enough?)

Before this version I already looked at environment (which you say
doesn't go far enough, and fair enough, but please review the code as
sent, not what you wish it was).

Perhaps you could apply whatever seems reasonable and then I can take
another look? Or suggest some small changes that would allow progress
to be made.

But do note that supporting booting without CONFIG_CMDLINE is a large
effort, the subject of 5-10 series, perhaps more. It is not my
intention to undertake that in this series, or before this series
lands

The problem, also, is that without this series, it isn't possible to
start that work. With this series, one can look at what code is
missing and find a way to call boot functions (for example) bypassing
the command line. Once you get it booting you are good. Without this
series, you don't even know where to look, since calls to the command
line happen silently.

So I think this series is a big step forward and urge another look, please.

Regards,
Simon
