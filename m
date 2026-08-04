Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E74C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB4BA60799;
	Tue,  4 Aug 2026 18:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRbKWew-xikL; Tue,  4 Aug 2026 18:13:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C579F60785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867209;
	bh=H4o1jNgXPsxDPXfEkbp5g9XxIhAYy4CJDf5Qqp3/AF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHDJZ9+EgJIprjV4bVbF/ecVTFW7VwOIjJuO9CZIbfidlZfZfAHkxzwDbF/wOD633
	 w6nVeCBIo/qnBRBBJiUIIi3qnU4t8/WldjOlUmbdf7qE5rk1RNN7hI/yXeIU0+rhXt
	 jfrPWBdts94RXtzQp3aj9AgghSjLaESYD1fObRv5tELNvtnkbYcGrgs0C0oSo0rzCj
	 F932Kn2igzdNC3J5OONebobgjD0oVJzOMXkBGV/v5aHk30iUgFaOIZzC6VZX1pIDdT
	 eU7D8sLKhb/32fFEHtZ+KSiwYN180y/hn9VOSHPldsJFPfqBTmtQCZDgO0pSQEY5oL
	 BG76uC94C2yVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C579F60785;
	Tue,  4 Aug 2026 18:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6923026C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ADE06065E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jwWD8kJFcl7z for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:42:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A1DE160633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1DE160633
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1DE160633
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:42:43 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso3726380a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854563; cv=none;
 d=google.com; s=arc-20260327;
 b=fyhB3OCZAeA0hA4VC1EyjXEQh3GfDQQgScNqi8UqxGw7Q5MjU5u07a2wHu7lcKfj7M
 EFCTP7+B7i1oVmS5qe9yrHqnEtPmufEAq/dyD9oscizPvi5k4er9f91lOMlgQ12HpYZ2
 m1RO4Ul/HPArAPObkFGUNciomxWLHMux880+EQNlCQQ8INEOqcdbW/hcDCqb4M3uNAKH
 jAVQFS/Jy8Fsn4dS+Y9oTYPNcc8hgxEZrs/sbrtdRnxOQcRJbiS06vdx26xTROxhsYaB
 EzJWyDOvz2h30XjMfgPAihV5xyGw0tOw1yt+6VonwUg1HqpoklnAshzftrGW0msYHzeW
 Z5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H4o1jNgXPsxDPXfEkbp5g9XxIhAYy4CJDf5Qqp3/AF0=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=tATA7YiGvzLie10ioKjN70cVluSEbrrlgiwqPfZJ9l13yTsD/zT10rKhHYlXNKFJYI
 CBELaGDvaY3yQpw2YEv+UvV3VSdrs9630OdL7hKhJp59xoNmTRXlU3NC3+SHkSqHEPUM
 1O6urtJi57AQQzH3tcDc3rYiC9yS509iQrn29C6OeLwzsnCHyEqqvGS2z34kzSLgnhdV
 ZOIpyXs0KmrjmEyY4oOmnV7KT50AWX1HxtsZj/GlpyaolG+a+J0PLp0cuZUF4o94xRuw
 nn8Hgk8TsvnGQtBqe0ZEq6niENBRmAfxD3N/o8nVGyosdSJTXy0kzIrwh5rYNRB3EcBH
 qQCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785854563; x=1786459363;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H4o1jNgXPsxDPXfEkbp5g9XxIhAYy4CJDf5Qqp3/AF0=;
 b=dwagQDV1OGzmlrZXq3LzU7qPXSqkxj/ydG4+p1JNLJCPxg3dVtNgfWGAEdNUEB9wRU
 6EIUEFgC+nu5V6ks+YtTsockESwG2355ydvtAaQxawIqOh7h0+n8FBmhHRrxQjNiwLer
 YyBHHqpTl4Gq8clSFhtrWXGGD2lIRcBqSvTE2Ksg6b/LHY65A5rAu/xL4hnnT2sEcPSu
 +Bu4CSU0rNdj7V/FjSE6GDZU/lsoYIe4L9yj2/ie1aprZw+CGl7IV9dGHnmryfp0pJWg
 QFAbsp4DrXgphVPYJLfyl5rSI+v/wiVweRO1NuaiW1VmHT5kyY5UN+4bSgHlEUJ1NpNP
 je4g==
X-Gm-Message-State: AOJu0YzHMQhXAeHi24RqoudzXvpeS9GLG8OWVYc5tYtf3t7dlM+0v6Pj
 gfdxEi+yDCILNZ6DAVTdUnAG+O9OKACCRqkUNkBaHXUYzRwtNJco4t86K/+aSeGkDMYALfZjFZR
 CQ7f83NjQpqrc5RvdAn7N/R8b1EEzVaHGcXF0ZYW8dQ==
X-Gm-Gg: AR+sD11s7Y79zbENdAM/2f4/tULTuSW24C46XXapR6CFc4eqElFnDnLAbJL2dqHepmf
 rlWgYbfV58Uz2IRVhxRHvok+TDCFQAfVT0t58eF+F+Pa0U/97yMazX+R4Plrkbz9Q6U+Ogw6Bk0
 +R3vYtDPeqWHHxd3JRpIcBSj2e7pAKvS4iWwBvyE142kYNLt8Aiu8TbA5bxqcd+S1kBB2Ub6N/3
 Ne8LNg5fZpsojXUAyI68+ETaabF6mzy3t0k0Gigt2zAiLxf0MZPie7ubgnBsu9ZGqK6hjpD6i0H
 z2eY2qnA8upTzXPofe38cn+xW1hLjD7WedIOMmHnHu0XjAOxaQVZl545Vfb5G+EhbTJzRwZkqzQ
 2Vk08odXF6Dw=
X-Received: by 2002:a17:902:e88f:b0:2cc:b480:28ba with SMTP id
 d9443c01a7336-2d0523fc45bmr144676595ad.44.1785854563000; Tue, 04 Aug 2026
 07:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
 <CAFLszTieNn+JSgDf=DFh-m8c+gxJ6eWJvo-2F7G7VwZ7O9tWXg@mail.gmail.com>
In-Reply-To: <CAFLszTieNn+JSgDf=DFh-m8c+gxJ6eWJvo-2F7G7VwZ7O9tWXg@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:42:32 +0400
X-Gm-Features: AUfX_mz5Sa4Gwa8nheiQi3mbB5KS0qQa6gGzvbRN58wa-AbR1a5aOsoVMJtRCaQ
Message-ID: <CAKTNdwE4P9JVDhvDYvYXxPK0SCNNuLn6OiEg2HW29TLg2bqdUw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] doc: falcon: Describe booting the OS through TF-A
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785854563; x=1786459363;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H4o1jNgXPsxDPXfEkbp5g9XxIhAYy4CJDf5Qqp3/AF0=;
 b=NJBTosH3+FssGsw64VE/gx+Pumj9gT+oiLYyW50Et4oaH1iemyMQdPYDe7eJcN0Yxe
 3CPN1HEtfNv9wvySxfZh9qa9cR5FG3Tz7XNyMM/JL+HC7BkjYj+3WB6ZBMifGZZSLg0x
 +HyyXByBX9fQLondiEyaQM1reD2egtP7dkxUkJBa1M6WOxnYgdQ2zAHUw7X03ky5MORD
 lF0kjT9qU+DqUCMTWNwvJ6hJ6ZCkuwytC+ZxSXv2MX3p3cGPpXN8EEFvLKtNCn4A7X82
 mKOzfKYUo6NTD0x5qvJulIHZ+nHhQMnOV++SwMRrSpZBp9MlUX214OWDfDFH5iuWbNIS
 iLbg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=NJBTosH3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Tue, Aug 4, 2026 at 5:04=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > doc: falcon: Describe booting the OS through TF-A
> >
> > Falcon Mode documentation only covers SPL entering the kernel itself, w=
hich
> > is not what happens on ARM64 SoCs needing ARM Trusted Firmware resident=
 to
> > provide firmware services: SPL loads a FIT holding BL31 as its firmware
> > image and the kernel as a loadable, and BL31 enters the kernel as BL33.
> >
> > Describe that flow, what the kernel image may be given that neither
> > booti_setup() nor bootz_setup() runs, how it differs from the classic f=
low,
> > and how to configure and build it on Rockchip.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > doc/board/rockchip/rockchip.rst |   9 +++
> >  doc/develop/falcon.rst          | 131 ++++++++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 138 insertions(+), 2 deletions(-)
>
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockc=
hip.rst
> > @@ -321,6 +321,15 @@ To build rk3588 boards:
> > +Falcon mode
> > +"""""""""""
> > +
> > +ARM64 Rockchip SoCs can also boot Linux straight from SPL through TF-A=
,
> > +without U-Boot proper running at all. Enabling CONFIG_ROCKCHIP_FALCON_=
IMAGE
> > +makes binman build a ``u-boot-rockchip-falcon.itb`` holding TF-A, the =
kernel
> > +and an optional initramfs, which are passed in with LINUX_KERNEL and
> > +LINUX_INITRD. See :doc:`../../develop/falcon` for the details.
>
> Please point at the rockchip-falcon.config fragment here as the easy
> on-ramp - patch 9 adds it precisely so users do not have to hand-edit
> their defconfig, but nothing in either doc actually tells them to use
> it. A one-liner like 'make <board>_defconfig rockchip-falcon.config'
> would make the story complete.

Makes sense, will add, thank you!

> > diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> > @@ -95,11 +95,138 @@ Function that a board must implement
> > +SPL picks BL33 in spl_invoke_atf(), which looks for an image with
> > +``os =3D "linux"`` in the ``/fit-images`` node it appended to the devi=
ce tree
> > +and falls back to ``os =3D "u-boot"``. The kernel is entered at EL2 wi=
th the
> > +device tree address in x0, as the arm64 boot protocol requires.
>
> Just to clarify - the fallback to os =3D "u-boot" only happens outside
> secure Falcon mode, which is stated a paragraph later but reads as
> contradictory on first pass. Consider folding the exception into this
> sentence.

Ack

> > diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> > @@ -95,11 +95,138 @@ Function that a board must implement
> > +CONFIG_SPL_UFS_RAW_OS_DEVNUM and CONFIG_SPL_UFS_RAW_OS_SECTOR against
> > +CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM and CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR,=
 so
>
> 'against' reads oddly here - I'd suggest 'versus' or just 'and', with
> a comma before 'so'.

Ack

> > diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> > @@ -95,11 +95,138 @@ Function that a board must implement
> > +DRAM which clear BL31 and OP-TEE, and can be adjusted with
> > +CONFIG_ROCKCHIP_FALCON_KERNEL_LOAD and friends.
>
> Please spell out the 'friends' - CONFIG_ROCKCHIP_FALCON_FDT_LOAD and
> CONFIG_ROCKCHIP_FALCON_INITRD_LOAD

Ack

> > diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> > @@ -95,11 +95,138 @@ Function that a board must implement
> > +Enabling CONFIG_SPL_LZMA or CONFIG_SPL_GZIP additionally compresses th=
e
> > +kernel in the image, trading some decompression time for a smaller one=
 - for
> > +a 30 MiB arm64 Image, roughly 35% of the original with LZMA and 39% wi=
th
> > +gzip. Note that this compresses U-Boot itself as well, since both use =
the
> > +same setting.
>
> Just to check - is 'compresses U-Boot itself as well' actually true
> for the Falcon-only image (u-boot-rockchip-falcon.itb), which by name
> does not contain U-Boot proper? I think you mean the same
> SPL_LZMA/SPL_GZIP knob also compresses U-Boot in the regular
> u-boot.itb built alongside. Worth rewording to make that unambiguous.

Yes, I meant that the same Kconfig option applies to the U-Boot FIT
creation (not just Falcon) because of how the current binman template
for Rockchip is organized. Will reword, thank you for highlighting.

Best regards,
Alexey
