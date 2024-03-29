Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14970CD1288
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 00:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74518881DC;
	Fri, 29 Mar 2024 01:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQ9XZC5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B9488150; Fri, 29 Mar 2024 01:59:54 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B7C881DC
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 01:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d715638540so2496221fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711673991; x=1712278791; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dv8rzNTLEmWcKQtpqqOn1a6h2Z+EasGvyUHqvq+Xw7k=;
 b=JQ9XZC5leUBgAEwfTRAUiH2Zdh/mIsTkU20TlMpJ1Agelca/2myZu0V5V93cFt7ctj
 YlEavW8GdsM00Jh7Ai/W/bNJbMfFQpgh5g5U1TLgOo7v2ANJQSaZGYuDPhVOBC4aAjZ2
 jHcdleLUEXiB2k0sW8FmBZLCZ43omZJpuG+NXQfuOZuF/xJHC/LaHQIdhJCMISj/afl2
 ud62XA/o5uiEpuTFDS3SWhHNdr4PiyR0HbC6JtKsgpR9MdpkqxGIAvZI0sI8Et6Z47Az
 tUhV47NTn8U4Un/7Vw1mKwY3w7G7CAQExvEkSytTvsf0ac26T0L3uj514/cK7v+7jhv/
 14yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711673991; x=1712278791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dv8rzNTLEmWcKQtpqqOn1a6h2Z+EasGvyUHqvq+Xw7k=;
 b=rJy9I1tdVJW+ousSW5/dBGHX72n9GhlDa3zux8DrrHesHMYKpUqd9YZUlFXGqHvQyq
 7RuOD7pEypRLZxiVLMsDPWOmXBYUUlSI1H/Rx3lNF8ZXq35gPFSpqsTbh/Hgqgj/RRSc
 bzlqDj4GZbQAJAkCDAC8Bq42PHjIApDScDbPmj4jLApVJtmeULOyRgU+1xygIGMPD1LH
 T3AtBz/CSIP/5Z7Q3DjXy1OBib+8RrnCH5L9nCUk7ru1ck3xNpJZzTDWO1jffQm3zAx8
 PKkYfhInjwm1ltFwbu1s0Q1qWUbQO7DORRBl7y7UQEwgLHfpR9WK08tL5NbFAea5p7R4
 ChbQ==
X-Gm-Message-State: AOJu0YwjOLu4UEhND7530O0SN8eUDCjCQX/Ol3rNJfqoXUtI4E2p0PzW
 PQxvG1tLisZcI6+JSuXCLOdXYxjCS7AiVNE1N2FvQJ/C/DV/LxgPFGekbsijT1rjmru36XWJUHf
 sWvxawlZ0Pg9YtTeG5V/kgzeVTNs=
X-Google-Smtp-Source: AGHT+IECOKbwTVxCOzb3LPuFnuHz9jhS08c5sx/wvmDT3W/S+1QxKVQ70yjwIoD2ldoapMXj0+PpuUt7rdZSy0587ak=
X-Received: by 2002:a2e:7e0d:0:b0:2d6:d3fd:325f with SMTP id
 z13-20020a2e7e0d000000b002d6d3fd325fmr420953ljc.32.1711673990591; Thu, 28 Mar
 2024 17:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240328021825.17935-1-mibodhi@gmail.com>
 <D057P1KGDU7W.1IWOBHLNV5GX@walle.cc>
In-Reply-To: <D057P1KGDU7W.1IWOBHLNV5GX@walle.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 28 Mar 2024 17:59:37 -0700
Message-ID: <CAJaLiFwcG4Hu_Ufx623gP=EmNcpGenU5DV1LO-2ix4hawutY2Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: kirkwood: Enable upstream DT on Kirkwood
 boards
To: Michael Walle <michael@walle.cc>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev <evgeni@studio-punkt.com>, 
 Luka Perkov <luka@openwrt.org>, Siddarth Gore <gores@marvell.com>, 
 Simon Guinot <simon.guinot@sequanux.org>, 
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Walter Schweizer <swwa@users.sourceforge.net>
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

Hi Michael,
Hi Stefan,

It seems either the Denx server or Gmail has failed to send/deliver
Stefan's response to my Inbox. Luckily, I also monitored
lore.kernel.org and I saw the response. So I'd like to answer that
below.

On Thu, Mar 28, 2024 at 12:41=E2=80=AFAM Michael Walle <michael@walle.cc> w=
rote:
>
> Hi,
>
> On Thu Mar 28, 2024 at 3:18 AM CET, Tony Dinh wrote:
> > Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> > DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> > DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> > files from arch/arm/dts/ directory.
> >
> > Background:
> >
> > Hi Stefan,
> > Hi Michael,
> >
> > I did a survey and we currently have 28 Kirkwood boards. Using some
> > commands and filters, here are the finding.
> >
> > git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"=
' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm=
/marvell/$1.dts' sh | grep differ
> >
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such=
 file or directory
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No su=
ch file or directory
>
> ...
>
> Are you sure you want to have all this text in the commit log?
>
Please see my response to you and Stefan below.

> You seem to have forgotten my tag:
> Tested-by: Michael Walle <michael@walle.cc> # on lschv2

My bad!

Stefan's comment (about the large commit text):
"This is also my concern. Even though I love descriptive commit messages,
this seems to be a bit too much IMHO. Not sure if and how to get these
findings of yours archived otherwise."

I can send a V3 patch. I will cut out the Background stuff and point it to:
https://lore.kernel.org/u-boot/55229181-3aff-4bff-afb5-df778f5f1849@denx.de=
/T/#t
And also I will collect Michael's Test-by tag and your Review-by tag
in the commit description.

Does that sound OK?

Stefan's comment:
"Tony, many thanks to work on this consolidation. Very impressive
results. I can't test anything of this though, but my plan would be
to pull this in the upcoming merge window, if nobody complains."
Reviewed-by: Stefan Roese <sr@denx.de>"

I think between Michael and I, we've tested 3 representative Kirkwood
boards. Time permitted, I will update u-boot for a few of my other
Kirkwood boards, and will send patches if I see any regression.

All the best,
Tony
