Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C8C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 17:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2807180657;
	Wed, 15 Jan 2025 18:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="LUUh49mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E519E806DD; Wed, 15 Jan 2025 18:10:35 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0189A80657
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 18:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso11197151276.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1736961032; x=1737565832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nguoY9RPdzHnJuhxNmsiTyJyHrR2U62BCKgo8w48qj8=;
 b=LUUh49mtzj7pGSoKwODxj7VfshYbIYJLnVu1iE69aBy1WQiLZ68hQ/sxHLoirEIvNL
 mkGVqk/w/pnDHyIwWYfIRS/gDtwV8AQtDb0KnkquxyC15DtlKujlZWR8h2AZwoUOn68h
 X7oNqH88aXriXFJd/eBJwZ4DBiENhA6ssz6koHfOWj2SrJMxBWg23WTObb6rWUIKOYEn
 lbwcEYXttDe2+pK9vl//Sw6f/fUAje9qC7zo4W/fjQ8ZFkQGkJS4WdQg6xwrhaOIgr0D
 q3loOses0lbildKgP4U7yF5QCLtmvPBN+S3n2BqWtcisc75fNlNYzdsdELIZwcMXNfT7
 1+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961032; x=1737565832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nguoY9RPdzHnJuhxNmsiTyJyHrR2U62BCKgo8w48qj8=;
 b=JPfQPjxGgAfE0Ydi6kP0N+nQNswZPFuBGqSbk3zQbpiSoIlkddoVONWc2IdtsGQUSf
 N7qGLJtZVp0/DjCJt2SnHM3mUdIv/P2jyuaaFRloBBwPb6dUdOSq3xVFVZe000MdNCzu
 6hFzreq5mMg1vIF/fkSPnLkYCBQH+3cOLgHaVzYCNeN+utf6QGdFwtsR++tU1r1Ti84x
 eAun30E0Up+sAcjw2/yOjThGmyO2nkEEyfJTHdoXXMbpJgwhwt5zLp5WJW2EVAOIEQ26
 QQ0M4BLIJnKJm1BYBZEDolHuM/mRP1DIvCWJbRo63BWKcjC27KE7x+6ebJ6KJzpeEvKh
 nHGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBNGg30WMIWoEmYV7lcm+xBPt+EGUHjpPomkAPbaTHGXfIoydesIMjXvLM4bR5qNSyVGY5s1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0m/vYCyVsxIEU55SN9L0pYoZyrgisCef5NCxBcT/SSMCx7Hcf
 gR3wyqoMn1RZyuIsihgQBlqSYgohjpiWZUfW9LLUpXDE/nL2TEYlfykHtIjLB1j/Ad82k9UyTsd
 DwIUlJYN6U2nTG/LmaOFFk3L3VLewZBrpDXZvEA==
X-Gm-Gg: ASbGnctpIf3Hd55y3QuRCV/G2G118TOIRA/KXrDANA10nFoO/IqFj0nw+KTb8U4AL+q
 eqUTONQ+1dlYUsd1zvDdVkSPq5w/iTHBMUTpEvg==
X-Google-Smtp-Source: AGHT+IHfgkkRjGxG2gIC+kdCQDy2pYrCeF0hWfUHfPIlwj2luwkNinxsNp1X+ZuaHzJmuzIwTsOa+4zYCmfNmOUJ9p4=
X-Received: by 2002:a05:6902:188e:b0:e48:260f:2259 with SMTP id
 3f1490d57ef6-e54edf404e7mr19518725276.10.1736961031572; Wed, 15 Jan 2025
 09:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
 <CAJ+vNU1xAhYdnoTRLuM6fWa1mQgkLrVj03BsSObtd7NDq9oogw@mail.gmail.com>
 <84b18e4b-cdd8-4767-98d2-ef31167ed6be@denx.de>
In-Reply-To: <84b18e4b-cdd8-4767-98d2-ef31167ed6be@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 Jan 2025 09:10:17 -0800
X-Gm-Features: AbW1kvYjNjINA4ioI1Q_A--PuydVs6rbePAbinDiq7q_jzuMOPKZRGmP_C3GPuI
Message-ID: <CAJ+vNU2yL1XBbtg=FhHohR72Wj58Y0wOEpckpzrNJCNUM=Px9A@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Marek Vasut <marex@denx.de>
Cc: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

On Tue, Jan 14, 2025 at 3:30=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 1/14/25 11:34 PM, Tim Harvey wrote:
> > On Thu, Jan 2, 2025 at 10:47=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.co=
m> wrote:
> >>
> >> From: Ye Li <ye.li@nxp.com>
> >>
> >> This patch adds i.MX95 19x19 EVK board basic support.
> >>
> >
> > Hi Alice,
> >
> > Could you add in the commit log what is and/or what is not supported?
> >
> >  From what I see:
> >
> > the following is supported:
> > - gpio
> > - pci
>
> I don't think either the ECAM (internal ethernet PCIe) or PCIe host are
> supported, but the former is coming (I'm working on networking support)
> and the later is easy to add based on the current MX8MP DW PCIe driver
> and PHY drivers.

Hi Marek,

You're right. I have a set of messy patches pulled from nxp's u-boot
that is enabling PCI ECAM and enetc. With the latest patchset from
Alice PCI isn't there yet.

>
> > - i2c
> > - mmc
> >
> > the following are not yet supported by this series:
> > - ethernet
> > - usb
> USB 2.0 should be usable with u-boot/master now, although you will need
> to pull more recent DTs to obtain the controller node in imx95.dtsi .
>

Yes, I did get USB 2.0 by adding the relevant usb2 nodes to dt
(haven't seen this submitted upstream yet) and your "usb: ehci-mx6:
Add i.MX95 support" patch.

> USB 3.0 is possible without this TypeC switcher in PHY driver, I got it
> working as gadget I think.

Ok, the usb3 dt nodes have been submitted upstream [1] but I haven't
gotten usb3 to work as host yet but did not try peripheral mode. I did
notice there is no ptn5110 driver keeping type-C role selection
working.

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/imx/list/?series=3D914412
