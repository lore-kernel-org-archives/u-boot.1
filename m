Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC1C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 17:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60BBE8118B;
	Mon,  3 Mar 2025 18:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e52usnq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC37681249; Mon,  3 Mar 2025 18:15:02 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA9B80786
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 18:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390f69e71c8so1769309f8f.0
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741022100; x=1741626900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EHeZQZ02nq+bnvKwWhdoRdyWKKBytm7uC0mGP4xDWI=;
 b=e52usnq+GKLz/+XWkWBEYOzxitH+dsCVpJWPhMQair+UVBcNaFWJtOgh9hDb9SGMLC
 hXE2Hn+lbwVyt8IHYAVooNfjXx/qqM2ivZLm5ZwjuLFAc1aRd+qCW1suRGGUfMqLrq6C
 lMF83cug1q67cHrqm/iOCM9Av9TSVveX9HGVzFsCCPR62hdGTdotniWiJiBWYNF0ZCgE
 yjAOgwG7H2k2YDpKfMzSScElwsxI3Uml0zEIHBGQKs7nZYhShQgZfvRDssQNna6WISHb
 XIFdhlfa/URd9mA7okN+hsMRqKPzzEtZ0tRrtpNJvQegJwQ5EgPU316WQPyVNT3/wzln
 UMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741022100; x=1741626900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EHeZQZ02nq+bnvKwWhdoRdyWKKBytm7uC0mGP4xDWI=;
 b=S/XHNv0oa52AkkdPlvHsRkHYi8WD2ke5N49qwWPD6UWUkmBmnAHaPbbk4fxYjHJlW/
 /7QE2wb7zFj/LtTKxmlMxNyyQckQ2Vbt0UXIlvxoz7JxbkWR9Igp7OTYhXEo79Q71L4i
 eG9WRSN4bPinIpz+rsm0QclPSDCF7QPJ21aYrn3ARVzxAVaidDyLJGKrlkwre1yAuHAd
 O+2wb/eV2RkFtGYgrE3hLAHDxaqKZjAa8c6EpsAVbx7rnIGgqoU0JQuNZmVrztOQ4Nef
 sIJnGw5Id6nh7ooD1r4wLS2WrIIc1zWt+hXaNK0GT61ehml6My0fQTzxGl0mkrYnRtrP
 IYvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwmzf5xo41v9Wb1KZwF7VesnHcfH0mpWK7NjGDqb5C970Q1cEVpmm98QbZnzLycNHXQDKkTAY=@lists.denx.de
X-Gm-Message-State: AOJu0YzXxlLaDYqdAEop+FEaTjBxoBq554b4qJMN/I8VSfUJ/IyT66E1
 OMIGSW4SMotlb5ocNr0VXhWcQ1YI3jr1O9Ggg49OF1SHy0dMnlPvjC83EFT7yypRnn4Y2Bo5CvM
 tYcvxVSs+mZ79YcNDRea7GCCY7tM=
X-Gm-Gg: ASbGncuicraZVx9TbpZhRQWNVUQCBggsEqkSTnX3q37XgP86qpDywHrlVE9xQHW7wZw
 /HI/ncLR8+ImoGzh9HR2s2q8xpqpxAJuc67COjePQSewXHvj8xHD9QQOU1wXhd3kmVsdnQGXN4x
 LAv4jQkKRIo4ZzFdP/ZNfNGRsJRsA=
X-Google-Smtp-Source: AGHT+IGVTcmS1F3h4sdTsczqvaxCu+u6wiDvu2Nxy/eq5vTcGQqvpv9GVwQxRSUre/4O0R2MGepJ60jrPVAbB3xdekQ=
X-Received: by 2002:a05:6000:2a81:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-3911561959fmr4522f8f.27.1741022099875; Mon, 03 Mar 2025
 09:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
In-Reply-To: <20250303170640.GS2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 19:14:47 +0200
X-Gm-Features: AQ5f1JrGqCzeM5j_u-NR8wAuYsqDnq5v8izvfaYjJE_XzKRRR4TXMD21QWfOBAs
Message-ID: <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

=D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:06 Tom R=
ini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 03, 2025 at 09:31:37AM -0300, Fabio Estevam wrote:
> > Hi Miquel,
> >
> > On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > >
> > > In order to display a boot picture or an error message, the i.MX8MP
> > > display pipeline must be enabled. The SoC has support for various
> > > interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> > > standard 4-lane LVDS output. The minimal setup is thus composed of:
> > > * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pi=
xel
> > >   stream
> > > * One LVDS Display Bridge (LDB), also named pixel mapper, which recei=
ves
> > >   the pixel stream and route it to one or two (possibly combined) LVD=
S
> > >   displays.
> > > * All necessary clocks and power controls coming from the MEDIAMIX
> > >   control block.
> >
> > I am seeing the following CI error in sandbox_spl test.py with this
> > series applied:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1045491
> >
> > Please take a look.
>
> It's a tangential failure. Svyatoslav reported this with a series he's
> working on and Simon wonders if bloblist support got broken but hasn't
> had time to look at it.
>

If seems that we are working on the same OF graph stuff

> --
> Tom
