Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB64C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 21:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0B887A00;
	Fri, 22 Mar 2024 22:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHMh0Htn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCE9879A2; Fri, 22 Mar 2024 22:46:45 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C016387A00
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 22:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso1756606a12.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711144003; x=1711748803; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTj+4B65jz84qjXrftV225klKs5Uh3NCnz75GCAWQ4A=;
 b=PHMh0HtnXEF7u26URO36a+Z5nI2O7ZqiNFV2UV71/SKpqltpgzBozl7ots+lx012C+
 5Td0WS3tU9719oIdSsPbqkfk1KKbLXZV0N9ubZ5e5mpoNdIyTEzyDIAggV8qS4DhVxUN
 6Z3g0hysEj7DiI6TTXLckQW6sKD6wyZMAZGWLD8YH1QYJbG4+qDtlIPvPS9Frc6iWw60
 o9e1E1Ao0eVDuoisdHdK95aFc9FHAxfS5ru+sf02BoWHMmjCgtBoSUuh95vV6GF6oWKJ
 f/xEoLkbxyDLoaWyApu8JTpz3gKGc28tzyZY917ENx8kc5CTYIppNG0jUVIqm8SMoCn1
 wqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711144003; x=1711748803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTj+4B65jz84qjXrftV225klKs5Uh3NCnz75GCAWQ4A=;
 b=l3y3hufm36hjxr+SK6XqCmUUAfDaJMCqYP2vHNxKJfJWwjb29ZSyc5LPlwYSibMXaT
 xmyS2X2DhJcFtDMhRl1cnSDPpck1gxKIZ6uVDDWZE8BIDEODbdKwtkXYxysfQlADMXHg
 hdURvBi8Ix5ZUGVNuUohlT4TTRI9ViGiVzEr2853JUOmlibq/idqUQgpnHizqEFc+STe
 fATQwbX/Z+j2M9+e+SpoO3uE4lP6VXdyhPZ6zyYm69Un7D7uC8PtcdTSe9KYVGeISqII
 DWGn285DLT7PK+lb30KstJgs2eCDcXmlKXUd2lKwcwOUwwJxQT7ae4ts/sbT8d8ZxCuv
 Gk/A==
X-Gm-Message-State: AOJu0YzozHW5kljG2DFpAmlvE74+ow/AwuYP4OQCO9ika7Qr2kAFeQH3
 gAO1WoCgbgtxlYanZXKlC5+Wvmb4EgNJ4tV8JBj9YD2zYaS/UgMtOF48YHcBY1K8OVWZ3+QZtv3
 Q1xLJ6vsnaX7+MIFcpWnyOCWpEjA=
X-Google-Smtp-Source: AGHT+IECLxJ6nwHQSVGRglaEvs2phJNbg81o99k35KUQ6zb3sLP5DFEfhkZc07cHPrFHeyobWRRp4zC/YaKaFlrx5e0=
X-Received: by 2002:a50:c014:0:b0:568:d729:a41a with SMTP id
 r20-20020a50c014000000b00568d729a41amr525987edb.9.1711144003061; Fri, 22 Mar
 2024 14:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240322021747.14873-1-mibodhi@gmail.com>
 <D00L56D4IWTX.228PJHRM8H89A@walle.cc>
In-Reply-To: <D00L56D4IWTX.228PJHRM8H89A@walle.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 22 Mar 2024 14:46:31 -0700
Message-ID: <CAJaLiFz5VicgBzFoDHSQj5_vQRhGBnjuw9zBkBX-ZRqpm7j8sQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
To: Michael Walle <michael@walle.cc>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev <evgeni@studio-punkt.com>, 
 Luka Perkov <luka@openwrt.org>, Siddarth Gore <gores@marvell.com>, 
 Simon Guinot <simon.guinot@sequanux.org>, 
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>, 
 This contributor prefers not to receive mails <noreply@example.com>,
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

On Fri, Mar 22, 2024 at 2:10=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
>
> Hi Tony,
>
> On Fri Mar 22, 2024 at 3:17 AM CET, Tony Dinh wrote:
> > Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> > DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> > DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> > files from arch/arm/dts/ directory.
>
> Thanks for taking care.
>
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>
> Tested-by: Michael Walle <michael@walle.cc> # on lschlv2
>
> lsxl should work too as it is just different in memory and cpu
> frequency settings.
>
> > ---
> >
> >  arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
> >  arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--
>
> arch/arm/dts/kirkwood-lschlv2.dts
> arch/arm/dts/kirkwood-lsxhl.dts
>
> Should be then be removed.

Thanks for the lschlv2 review/test! I plan to send a follow-up patch
to remove the corresponding DTS and DTSI files.

All the best,
Tony


>
> -michael
