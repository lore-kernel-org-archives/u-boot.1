Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF7C02198
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE7D80A23;
	Fri,  7 Feb 2025 01:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="edSHPx2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089808083F; Fri,  7 Feb 2025 01:49:56 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AFF8003E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5de47cf93dfso275103a12.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738889392; x=1739494192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FP8zY3jhA67/YmWw9JkaGBmrG0wB4zHyfdcn7tOX3lQ=;
 b=edSHPx2Sa+zoasfo4EHHvVPPu1wGDpVkCkcJPeQHH+6+lVWOStieepoP99+aDIMhgj
 bMwUcfkb9ux3jVEDstDZfl3TdfhqHD0gCAOGXUd0SqHJFiiusOnKFaS6q3PfvP34hrK0
 3wQ1UeP4e1IhvhXrcaxLTYp7ykAG4r5SsjLkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738889392; x=1739494192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FP8zY3jhA67/YmWw9JkaGBmrG0wB4zHyfdcn7tOX3lQ=;
 b=lYflX3Sl30498eDRdchVFLwK+sV/icVVp5ueun/5szx0foaNGNgc+rFhXQWTxZ1mgq
 P5haldOJNZTbjSmGOAFpHu2ksVPbNmwVU3TBBtnHVHRutLZIaBhr6RdUtUgGODDwhSV0
 PmeeChzqhp7YGO5u5OHA54j87GdL7HggIma8QZbzXdpg2gZul1Xfqc5mtr9T/4h3HF5f
 NA1hSYVtXLLdTSJTtbq3wvpRl+EzGYK9SvD39R3keqE4gQfKv8b5WhMGxpFPQCXvhqJH
 kQzNZrBxu8lvQl3SWr1hg8o0bXrA3y2ydZ22Cs8Pxe9RjCHdHzDUgZVwIUlHGZzOmnrU
 1Tig==
X-Gm-Message-State: AOJu0Yw9wvJlWIOR+dBBZ7MDoVPxj0YNWzXS9WAJolo057d1k1nJ6Jma
 pX1PcJ258QGbI6qvoik0u26fpNYz+I8mw70a6Lh7W5HDFBYU34TPcUA6uCNwMcbSfCZpfHamY82
 tg2xnFHY5ADbaj+l8V3rNdcw7Sj4Fl+mM++rT
X-Gm-Gg: ASbGnctzPFQP1Zbf43FQrNWM9dkQxbF4oN/n1kwt1TksQoVXACnl2SBkfwvKiXl8h97
 Zi6bOTixc4COytnHOgB6Y1/6tMpCIlbepeHol1lrhj97/eEo+GTH0ngy07PXVv5A+COZePHRmZQ
 ==
X-Google-Smtp-Source: AGHT+IEevOT44ScUaigA3Fv3wPTOChzuiWq1hD9lKV2qMVEPVgFou0K+1M7n4/qEPpTy1+cXyRhTQb6kckI5VFC4pWI=
X-Received: by 2002:a05:6402:4606:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5de450706dbmr3391668a12.20.1738889392229; Thu, 06 Feb 2025
 16:49:52 -0800 (PST)
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
In-Reply-To: <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:49:38 -0700
X-Gm-Features: AWEUYZnQN57F8YzMrlOjqz1uYMdbU5GSw5b5jF624DaqDrmBzZBkIgMEeDOWVr4
Message-ID: <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
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

On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
>
> On 2/6/25 1:42 PM, Simon Glass wrote:
>
> Hi,
>
> >>> FAILED (errors=1)
> >>>
> >>> So where is the SRK_1_2_3_4_table.bin file?
> >> See the tool documentation:
> >>
> >> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
> >>
> >> 3.1.2 Running the hab4_pki_tree script Example
> >> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
> >>
> >> The hab4_pki_tree.sh script should generate all those files.
> >
> > But with binman we want to avoid vendor scripts, etc.
>
> I believe the script internally runs openssl to generate that file.
>
> > Could someone take a look at updating tools/binman/btool/cst.py or
> > similar to build the tool from source? There are examples of others
> > that do this, e.g. bootgen.py
> Is this relevant to finalizing this patch ?

Well, I don't see how the tests can pass if we can't build/run the tools needed.

Regards,
Simon
