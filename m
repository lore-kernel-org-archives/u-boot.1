Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCD4C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4E880F32;
	Sat, 15 Feb 2025 14:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lyf2IdTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4636580EAF; Sat, 15 Feb 2025 14:38:48 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA9380C98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so3604356a12.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739626725; x=1740231525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V5W32TFzJOqAMg76yPaWTNpgDkEx6vGwNDJvWITUfRw=;
 b=lyf2IdTD12HtHPGjilQ37hUsZbIJBU/XXSIJ1Q3lkt4A7c9i1HgUyvCSLxeq7M+9Qv
 xTGEMjrpbNOyCZkI8Nd9UDQ2NhXKf0yp9Key3XzwnCP+ep9lsbwmjSj4vZr0lixlTMie
 uK5i+xnX5qmltDC2Upsyu/8puOZ+k22kjqjRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739626725; x=1740231525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5W32TFzJOqAMg76yPaWTNpgDkEx6vGwNDJvWITUfRw=;
 b=dok9s+kO5id9tzl9qcxDwMzLOJ4pjxoaPESF16Z5Hy46q/uInu8RaFY0HcEdH9AyWl
 CLVTBrw+SdO7GunoD1g+Dld7OLKDkDGNQXtumC8ZyNIuMw6Es44TPLDPnUAF9zy3CjMN
 fYc1p4bHGmg/VQwMEKiX+8q8nqubRdPmmq+GHLjNbQa1KaRJTDKmuWO1EAEF/bO/Hyop
 qogQrMMJYN0iSRxbmoYr+c4rNYAI8d3jBY9TQNryjPbrh0vnhQvYcYVDQTSli7i5xHa2
 MXgu8/bTe2BN1D3iZrxPmMbtBv3RBauJFK1RjTYj9BsfscHu+0mTqJDpelp3drNgWYcs
 5Mjw==
X-Gm-Message-State: AOJu0Yxxh1YbVD1UuZguWF7YbTUWEj8YVQXyPlU02WWc9iH/gcLmNUVr
 /DR9/EJwIlNMyGJKhepDRAY1EmjZ4oMeELjgttAZnRri1AgZKD5kH6rlTUKNjABZ2SlEjNPls9d
 GSGANha3GPCwb/4U5wYWBZkgYqrMn/x7loixFiegQY5In+YY=
X-Gm-Gg: ASbGncuTnAQlP1BY22Ng2tC/LNpbAc0mymDvX3tgCU99amwDS2LoYxIVOiX0mBYeRVO
 4IlYYaNt0hZ13/V17MRjDuVsPqhdMSFYJ10wdELhHvnZwITO1y2tg3k+Qd1e3IQs1LUxxRsu48w
 ==
X-Google-Smtp-Source: AGHT+IGax20soH/ON1vI541OgzgSuKZHaHJwAR9uCfASOb1CyGuO5IY2BdhMSqR1tesQ9Sr+MxpiHRI6bLrk3rVpYP8=
X-Received: by 2002:a17:907:72d2:b0:ab3:4c32:aa6c with SMTP id
 a640c23a62f3a-abb70aa62e0mr215741066b.20.1739626725349; Sat, 15 Feb 2025
 05:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
In-Reply-To: <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 06:38:31 -0700
X-Gm-Features: AWEUYZmmiIG0ixsJQTdtTkgMlmM03rPSFGaUwF995sMVDuIYXJA2upNyg1nL8hg
Message-ID: <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
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

Hi Marek,

On Sat, 8 Feb 2025 at 14:27, Marek Vasut <marex@denx.de> wrote:
>
> On 2/7/25 1:49 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/6/25 1:42 PM, Simon Glass wrote:
> >>
> >> Hi,
> >>
> >>>>> FAILED (errors=1)
> >>>>>
> >>>>> So where is the SRK_1_2_3_4_table.bin file?
> >>>> See the tool documentation:
> >>>>
> >>>> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
> >>>>
> >>>> 3.1.2 Running the hab4_pki_tree script Example
> >>>> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
> >>>>
> >>>> The hab4_pki_tree.sh script should generate all those files.
> >>>
> >>> But with binman we want to avoid vendor scripts, etc.
> >>
> >> I believe the script internally runs openssl to generate that file.
> >>
> >>> Could someone take a look at updating tools/binman/btool/cst.py or
> >>> similar to build the tool from source? There are examples of others
> >>> that do this, e.g. bootgen.py
> >> Is this relevant to finalizing this patch ?
> >
> > Well, I don't see how the tests can pass if we can't build/run the tools needed.
> Maybe you can try to use the shell scripts to generate the missing bin
> file ? I suspect the script does some openssl invocation, which can be
> reproduced in binman ?

But 'binman tool -f <toolname>' is supposed to build/fetch the tool.
So any such building should happen in that bintool.

One of the main goals of binman is to reduce the work needed to create
a working image. If people have to go spelunking around the Internet,
build it themselves, etc. that is not good.

Regards,
Simon
