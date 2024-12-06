Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF58E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 03:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EDE891AD;
	Fri,  6 Dec 2024 04:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WiHImy9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD578957B; Fri,  6 Dec 2024 01:01:22 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2308957B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 01:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso181856466b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733443277; x=1734048077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k92sKxFlNMmCAne6oe4pe794OpLTvB9KIfNrlyxYQRs=;
 b=WiHImy9zVR6yEBlw+GljsuP1zVtWuUkd2Veak/oN47ziGseBduvcJiD1xIOc00pBGx
 Wz08CD1ykFg9rgR67tiSQZTSyv9U5MrakAwIcpejfJkYkRJLKog0zClaZaWDVtWvW3Hl
 WgKfXF4Ni/w64lo3WqPhZIkNPdTGx4Ib3Epdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443277; x=1734048077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k92sKxFlNMmCAne6oe4pe794OpLTvB9KIfNrlyxYQRs=;
 b=QQud3PntofggFOORKVpGhACFkiKyjshty+ywHpF56+VTLlCqylXuZ+aMawB9ulx9/K
 i2/nISrDcY/VVQqL5Pb6Zquthy2xsPHWvNAjh3EZ/AXqaLP6Ktzz3S187VaEmAHRCUyc
 yF2Kxb4OH83Q58Q/LxXRkkTucbAuWtvbkXXDkMuBK5c1w6rV5nGFmQNkPLlx5nGrKi2i
 E+hkhFAJC8ntGr0YzvA1vMDg2poyieG8CyBJWFl0S2juR8AQ+uaxv9Y4c9UBT4c+fhc3
 VN+jsf+1aw8XiPYyNznIcGrcs4GuoYQw2c4+4E+F7PNAWt1alalXvobXHj0Tv38knwwW
 Pw5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP7QNAKgIbl7otkuFAbAcD9cPeUFZr7KswmHwvuSLyqf1HjSJIUeHeBvLD7ekyUoZ/021T1k8=@lists.denx.de
X-Gm-Message-State: AOJu0YwVPvJxI5qi61ev0ba+qcjiRQwCcXTEdxR5Ueml9Mpe5GYo9a6y
 aebkaXxIUj7tm9KGVWZJrBlPma3U6xM2oIJcxGocf/koX3KX1ukw8DZ5qTRBJi9IqFRcr9fc2wv
 HRSCeJd2zWK6teGdc7Efmv94XjCZL2C4KxZ5i
X-Gm-Gg: ASbGncs7iKyrclj4KUOwz/ejpOTuClfsKmPPxveianpES3qE2pZ3FZzeh3EJ9IOkE6R
 2Dkb43qg2cuCbf4Ttys7tuNJcXLC4iWkN
X-Google-Smtp-Source: AGHT+IGZ2gW4vd1o3LotH87EgoD1UBkD1H+y3vYQeJQUp4ZNx80D0cTlMCWTPmp1xFHWPNAZNkAeTsIqlORpZ2bfmQ4=
X-Received: by 2002:a17:906:30cc:b0:aa5:1d08:dad7 with SMTP id
 a640c23a62f3a-aa639fb0e5bmr43308666b.9.1733443276944; Thu, 05 Dec 2024
 16:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
 <20241203194847.GA4022002@bill-the-cat>
 <CAFLszTgZiJuWMKZg6q--LEp+58Exgs8P+KaeCBgqmTd+B=SNSA@mail.gmail.com>
 <CALeDE9M1aZwVM40gbhMRWsvhKZXL=m1GOeLhDgzR5H2bTShFuw@mail.gmail.com>
In-Reply-To: <CALeDE9M1aZwVM40gbhMRWsvhKZXL=m1GOeLhDgzR5H2bTShFuw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 17:01:05 -0700
Message-ID: <CAFLszTja7=ku__b0+LUbjhVmhML9uPv2613VxSX1pBk1vt24OQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Dec 2024 04:03:43 +0100
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

Hi Peter,

On Thu, 5 Dec 2024 at 13:36, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Tue, 3 Dec 2024 at 19:51, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Tom,
>>
>> On Tue, 3 Dec 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
>> > > Hi Simon,
>> > >
>> > > > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrote:
>> > > > >
>> > > > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
>> > > > > >
>> > > > > > There has been an LED framework in U-Boot which uses driver model for
>> > > > > > about 9 years now. Recent work is underway to improve it and provide
>> > > > > > more features. It is probably a good time to drop the old code, which
>> > > > > > is only used by 5 boards:
>> > > > >
>> > > > > I don't believe, from what I can tell, they are feature comparable, at
>> > > > > the very least I have not been able to get the Pinephone working with
>> > > > > this so as it stands I still don't think this patch set is ready yet.
>> > > >
>> > > > I don't have that hardware, nor the other 4, so cannot do anything
>> > > > with this feedback.
>> > >
>> > > Don't you have any HW that has a LED on it that you can substitute to
>> > > see what it does?
>> > >
>> > > > Can you please be clear what you are asking me to do?
>> > >
>> > > Either produce patches that work on the the pinephone, or docs I, or
>> > > other developers, can use to implement the functionality.
>> > >
>> > > Currently on the Pinephone the green LED lights up in the TPL/SPL
>> > > (very early before ATF) stage and is lit up right through the the
>> > > various FW stages, with your patch set I get no LED what so ever.
>> >
>> > Please note that needing to confirm that we have equivalent
>> > functionality between old and new frameworks (and
>> > https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
>> > might cover that) is why this series isn't ready for -next at this time.
>>
>> Yes, I'm not sure if Peter saw that, so I sent him the link.
>
>
> I have seen it, I have not had the chance to dig out my pinephone to test it again because I was traveling and had competing priorities on my time (and I do this as a hobby).
>
> But also I think we have a little time on this, the new functionality only landed recently and we've had a LOT of deprecated functionality hang around for a lot longer than that. I think we should get this right rather than jam it through.

There's plenty of time for you to test. But we're really not losing
anything by applying these patches (and also [1]). It is more likely
to work for your board, but if it doesn't, we can focus efforts on
what is wrong rather than trying to keep the old code around.

One of the challenges I have, as someone who also does this as a
hobby, is that few people are willing to take on deprecation efforts.
This work is not very interesting, most of the time, and it is
extremely hard to get things to actually land, since anyone can raise
their hand and say that it doesn't solve a particular use case. I
suppose most people do U-Boot things in their spare time and few have
a lot of time to test or try things out. So there needs to be a
balance struck, to encourage more people to help.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=432093&state=*
