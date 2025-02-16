Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0131AC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 13:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3571A80104;
	Sun, 16 Feb 2025 14:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YjycecCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1877780F0A; Sun, 16 Feb 2025 09:29:08 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468DC809A4
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 09:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso6968018a91.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 00:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1739694539; x=1740299339; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByIlKAhGR/m5KJmJJ/zU3zgc7/kdICm0aX0ugBAJKLw=;
 b=YjycecCshX53rLBJGvZhbGJsJ/0/Vg+/v0Y21NYHn2AymP+wcgrO+OOe83GevEOEf/
 nw7NN4mdZo0jbCWM0TqahhV7OaDJhAhM4DREmOQa7XBG1Q3gtRcP9eIMd52VU3DPUbMC
 88CIUc//gN2TNaM0MVn2zvxHBbMX6kyhSMpMSkeXB3ucVcuaCJyayICOEEbbQbJ8CWth
 ZHG3n+DXgiMz7vx6m+xWhx5VJlmhkSnyX1TCPjCTURG1wYC6/e/vxVuPOMxPCqRAf5qg
 mkIPLCHIsYkFiwaw8ht+5XEIEPfBTb1QWjFIFi79RuEPA+Mkoai7jY7rlWW6aeAhpbUh
 r1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739694539; x=1740299339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByIlKAhGR/m5KJmJJ/zU3zgc7/kdICm0aX0ugBAJKLw=;
 b=YtuLteaSSDZKXWZmOcVkP/FW7fQD+akfcVF81e9hcxLNiutnDkObKbWJAkbSd5h5q+
 QiR1cspjFSWqDIHhuTUk63OCQIy6Ipt392DO9K0yUlqpeMY9Aa7yWW/6xeEY0uKscT6O
 XPkFHqKtHS3ahHKa/WoT7aVrxvErwKAnwQ9rcemPvi5CDpswMAQ7Go4YuEcM0denzSCW
 PU901sAopaWOvTXFSvpjR8PeAGNaRTqTrrfrhbVVjVoCPuSi87SRThpXN0LjTkVMQj6m
 hLvC9HhpBzfYD4ZqSMDe32+nkR/rgXcAaZgDG6tKhMo5JMbyCqNEfDDj+LssXwK3LoOE
 eQ8w==
X-Gm-Message-State: AOJu0YyYXvi8DglzWOi9ZjIyb1AGDl4SbU668Lvd5kvMpDH4tnebZk3K
 JIJUW+svpFdKcpCkhtfGnZ58cxvxkOKKMotLrhpPkNbJ4hzT0nWaFUd4JBonOHGitluGbw0GET8
 ZSbEMqkHJx+HTFhZvZZitHXGEXEDOaAHXUAZPjQ==
X-Gm-Gg: ASbGncs36KNUo6/cRzBkR63ph61N5gXYMKkWg1l598LQV17fZqh1mFVVXpyFeYXFr45
 zVOUgHOLqSFXR7eV9fzKfu50vnqhucYiPLWvNZt5mBVCyGTyrvVCFPVnMlrhPGbTWef0dnpU=
X-Google-Smtp-Source: AGHT+IFrigN8ibJMMRWvwxdUc9a69sVxYCDk0/AkxUqxS2C9BOYsem2EPFnzAgoWBO6IBLHmvXLrDfUyOFSe7GkRx9w=
X-Received: by 2002:a05:6a00:1388:b0:732:2710:956b with SMTP id
 d2e1a72fcca58-732618f1520mr8288741b3a.21.1739694538726; Sun, 16 Feb 2025
 00:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20250111000029.245022-1-sjg@chromium.org>
 <173764160279.210100.4402866218713283083.b4-ty@konsulko.com>
In-Reply-To: <173764160279.210100.4402866218713283083.b4-ty@konsulko.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Sun, 16 Feb 2025 09:28:47 +0100
X-Gm-Features: AWEUYZmjG3E0cniSEoj-PirnCLg9mNGgDh3KuDhYJms7XVrKlb2dyVvoJeFroYs
Message-ID: <CALNFmy3gdKBECUWswV4G3ixytQZrHWE1iXbfDDQ-TYKnO8ax0A@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] upl: Prerequite patches for updated spec
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
 Alexander Dahl <ada@thorsis.com>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 16 Feb 2025 14:31:13 +0100
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

Hi Simon,
On Thu, Jan 23, 2025 at 3:13=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, 10 Jan 2025 16:59:59 -0700, Simon Glass wrote:
>
> > The current UPL spec[1] has been tidied up and improved over the last
> > year, since U-Boot's original UPL support was written.
> >
> > This series includes some prerequisite patches needed for the real UPL
> > patches. It is split from [2]
> >
This series breaks booting on Arm64 using ACPI since the ACPI tables
are no longer advertised
using EFI. It looks like "efi_loader: Avoid mapping the ACPI tables
twice" is at fault.
Never calling efi_install_configuration_table() on
CONFIG_BLOBLIST_TABLES enabled systems
just looks wrong (it might still work on x86 as the kernel will scan
low mem for RSDP).

> > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> > [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D438574&st=
ate=3D*
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> --
> Tom
>
>
