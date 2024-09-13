Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC5FA3727
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 07:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91C6889C3;
	Fri, 13 Sep 2024 09:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aWpNL371";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527A88A1E; Fri, 13 Sep 2024 09:55:24 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29087889C3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 326771C0005;
 Fri, 13 Sep 2024 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1726214121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOFyAiK9f9RpuAMBP/uhCyYTnAZRO/txdz86n6gpi4M=;
 b=aWpNL371OwwspWCAYdcieCoZPBWjI8n7uibeBVOdAJfczPn1siyzF2R3UWIcpGrMD0L8Kj
 IUeeVoTrwabuGkhpFPleAIR47gMfPgUTVlvwBDW18F6jz9fHuhFKtEqy3TxEqC5wgn/nMo
 XbCPFt155vEJtRG3SAb4ehIyZiZTDOQFuiEi+g8KhRvonACbisVJztcKfbX7502uH+jlG6
 YUNnU/s5obPZovctASvLzAOrY9LrADDbYvxkoDGpaJ0loL+wTIa0RFTQsLUcxhPDqU0JZo
 L/CqM/ixX6nm69QqZO4L7T89VGzmtYZ1TwvsEHnwLoMRkG+Dcrc68nQEcYdfAw==
Date: Fri, 13 Sep 2024 09:55:17 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ian
 Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 0/8] Add imx8mp video support
Message-ID: <20240913095517.3502138c@xps-13>
In-Reply-To: <CAOf5uwm-CAbYCqFtx43Ynp23kVTvWM02qchuuwDHXE4=8NY48Q@mail.gmail.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <CAOf5uwmzm=9=Vsu5cTbziyPG=KAqDGTcmrW0A36a2ix_+2WjNA@mail.gmail.com>
 <20240910145634.2ada70ad@xps-13>
 <CAOf5uwm-CAbYCqFtx43Ynp23kVTvWM02qchuuwDHXE4=8NY48Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

> > > Thank you for adding those patches. We are working on mipi support
> > > here and some of the clock patches
> > > are there too. I will try to look and rebase our patchset
> > >
> > > https://patchwork.amarulasolutions.com/patch/3401/ =20
> >
> > Thanks for letting me know. Indeed there are a couple of conflicts.
> > - My patch 2 can easily be replaced by your approach.
> > - Regarding the power domain we had two different approaches, I
> >   didn't look in details, but again one or the other seems fine, I
> >   guess.
> > - The LDB driver in my series is new.
> > - Finally regarding the LCDIF changes, the approach taken on your
> >   side follows the somewhat too ad-hoc logic and would probably benefit
> >   from being migrated to the driver I propose, which does make use of
> >   the (DM) clock, power domain and DT API. I am really happy with the
> >   core helper I've added retrieving a device in front of a graph
> >   endpoint, which makes the whole "get panel/bridge" approach much more
> >   flexible and adapted to today's needs.
> > =20
>=20
> My idea is to work on top of your patches and try to migrate them and
> cover conflicts.
> What be helpful is to get some of our clock patches and include in
> your series and then I will try
> to move our work on it

Of course, no problem. I'll be ready to test them again on i.MX8MP.

Fabio reported several typos which are easy to fix, but for instance
the DM helper needs a test, so I 'll work on it and share it with you.

Do you have a rough timeline for the next iteration?

Thanks,
Miqu=C3=A8l
