Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BBDC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6D280885;
	Thu,  6 Feb 2025 13:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y7W3gFYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE90F808AF; Thu,  6 Feb 2025 13:42:35 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB2B807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dce1d61b44so1677230a12.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845753; x=1739450553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FZ/znteUFw2aOHdLRXwbAp/AL64/vFqrXd40Qs4rLq4=;
 b=Y7W3gFYmsiqH06ahe8OT5ZG+9tK7/JK1Bq4+xvKZG9lSY06Hbj9nR29q+4Hru6XeQK
 u7Knk+Bbmsfw/lNGWN1DLaZX9+Y3OTyXtuaObcOXolWFxrSxaQjjfE2X4duubtd3XJjy
 S1Z1xGUPAnlRCd6UMKfCP7c793yykS+jg6N9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845753; x=1739450553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZ/znteUFw2aOHdLRXwbAp/AL64/vFqrXd40Qs4rLq4=;
 b=IqEFvMYxYsl0OjYm+WoegoBPyKgqfqZFymbCUdMNTN0OIYLkzPg26x3ybTgY6VMFTe
 FQW5sxkC9SK9YhQVHRgP/iaZgW67wpoQMI8aPiTvqsW4bCUSTUaO9dbi9XguI7BtT4Gi
 nEe37pdKDR/0Gbosm82MNhmclKJ0v30JV1NTUp/BgxtcC+Z06Ep0AIOr2ul5QZFIgLGU
 Y0NPwSxiR1VyIA62OZiZxk0VRXDitCJUq1rJKlVh0MkPKgAO4JV72T9yY0rl2qGnWhlS
 X2Z0Jn5x/9wtDM4cynKnBGOrttqGQP6G8YBQ/2y9HJufmSeHkcaNYUxsJmFiRYqyACqR
 eQZg==
X-Gm-Message-State: AOJu0Yw5SfSKgyxcUjqN1JAzlHG/Am78uOHYyAsR8pLj10QCAxFtO4Ib
 U00VffjpZoAJuW7+1rQgAR1zX8iaxWr5jL2WE7mvJkPIGCneEB8Hz03gxFK6DAeX1rCop8TDwXh
 JU2hO2UpDj8V+YO3UsyWPwzX8w/9rZqZwf4ma
X-Gm-Gg: ASbGncuPJf1SZp5zlRVJy2SzV0L+EatxJuYEoL8i6o6IUpcfUNxO0Tjoawqe+LwDHGW
 d8ywtTcZANTwVswOypnGE2ws31Mus9amTJuO55rfYiWdV9UCK0FvIaZ9//q7p4rAnbode8Jz/jg
 ==
X-Google-Smtp-Source: AGHT+IFSxsjlquynQpJxX7snYwwyDMPP1iZ7GBwWUfpfhcbmimR1kRIY5pkHvwHU4iV3ioBEPGC0pEVctNmj21l9rkA=
X-Received: by 2002:a05:6402:348d:b0:5dc:c531:e5c0 with SMTP id
 4fb4d7f45d1cf-5dcdb776474mr7371593a12.27.1738845752548; Thu, 06 Feb 2025
 04:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
In-Reply-To: <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:42:19 -0700
X-Gm-Features: AWEUYZmB1Ru-9Tb3XkvGkr8DIg06XPzg13pwJ7ZdklYOcXcsEfmahoXhYB9yckg
Message-ID: <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi,

On Wed, 5 Feb 2025 at 03:20, Marek Vasut <marex@denx.de> wrote:
>
> On 1/9/25 3:10 PM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Tue, 7 Jan 2025 at 04:24, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 1/7/25 4:50 AM, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Mon, 6 Jan 2025 at 13:51, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 1/6/25 3:38 PM, Simon Glass wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>> I wonder if the cst needs to be updated (binman tool -f cst)? At
> >>>>> present it is using apt-get and has:
> >>>>>
> >>>>> $ dpkg -l imx-code-signing-tool
> >>>>> Desired=Unknown/Install/Remove/Purge/Hold
> >>>>> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> >>>>> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> >>>>> ||/ Name                  Version             Architecture Description
> >>>>> +++-=====================-===================-============-===================================
> >>>>> ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
> >>>>> signing tool for i.MX platform
> >>>> Perhaps. Can you suggest a fix ?
> >>>>
> >>>> I am also unsure how to get the CST test to 100%.
> >>>>
> >>>> I still don't fully understand what exactly are these tests testing or
> >>>> whether they are even valid.
> >>>
> >>> Well, if I could run the test and have it pass (like presumably you
> >>> do) then I could suggest something. Could you point me to a cst binary
> >>> which works for you and makes your tests pass?
> >> CST 3.4.0 from debian/testing works with real hardware.
> >
> > Unfortunately after much messing around I cannot install this on my
> > machine (jammy). I do plan to upgrade to Noble at some point. But we
> > cannot rely on people having a particular distro to build U-Boot
> > images. That is what 'binman tool' is supposed to fix.
> >
> > I got the package source and tried that. The build instructions use
> > docker, which I have not mastered. The container needs curl but does
> > not have it.
> >
> > I was able to build it from source code without docker. Is there a
> > public source-code repo somewhere, so Binman could build it?
> >
> > Anyway, with this patch applied and the new cst:
> >
> > $ binman test testNxpImx8MCSTSPL
> > ======================== Running binman tests ========================
> > E
> > ======================================================================
> > ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTSPL (subunit.RemotedTestCase)
> > binman.ftest.TestFunctional.testNxpImx8MCSTSPL
> > ----------------------------------------------------------------------
> > testtools.testresult.real._StringException: Traceback (most recent call last):
> > ValueError: Error 1 running 'cst -i
> > /tmp/binman.t45m9_fv/nxp.csf-config-txt.nxp-imx8mcst -o
> > /tmp/binman.t45m9_fv/nxp.csf-output-blob.nxp-imx8mcst': File not
> > present SRK_1_2_3_4_table.bin
> >
> >
> > ----------------------------------------------------------------------
> > Ran 1 test in 0.151s
> >
> > FAILED (errors=1)
> >
> > So where is the SRK_1_2_3_4_table.bin file?
> See the tool documentation:
>
> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
>
> 3.1.2 Running the hab4_pki_tree script Example
> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
>
> The hab4_pki_tree.sh script should generate all those files.

But with binman we want to avoid vendor scripts, etc.

Could someone take a look at updating tools/binman/btool/cst.py or
similar to build the tool from source? There are examples of others
that do this, e.g. bootgen.py

Regards,
SImon
