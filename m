Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B6DC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F3982F8E;
	Tue, 15 Jul 2025 16:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDF9VrrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9249B82FCA; Tue, 15 Jul 2025 16:49:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE19C82E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 16:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45600581226so35492055e9.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752590979; x=1753195779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMkxHH+9i+ZVsI2/Tknpd/Dq1v8W0V2pKliz6vUeAAw=;
 b=RDF9VrrUAQO2xRIrgtl1JG2XtgZAycZBiROk86SIgNxIYsRxB7RbagInM/7/Wk5aNe
 PY/q+4pceccWJqPOZydk9rHj8enVFhpgmSWH8WGTBNKzdh38DDuNVZBjUOGpTlbQjfYy
 fjSw2D5rdoU6HSTEDZbput2tDGauGmsp63dfG4X7OGLA0sciTSmkG0hZK/KRcmOcR0rJ
 LDq+U2A7VoI2ka9HpPDN0ZGq5VcZaNjIFEsKr7Xil8DUThHxdwSbq1usG5gcWlg2qSe4
 II/ngNYcjgIUhzf/5p0p0L46UukIq++V2PUu2RTO8NC/G16fuh408Krbw0EYiP5Visvc
 RS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752590979; x=1753195779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMkxHH+9i+ZVsI2/Tknpd/Dq1v8W0V2pKliz6vUeAAw=;
 b=kGH0gWsAFWWrnN8BALIekmdtrOsy01VgGv9bBKAAo+GYgUTD0GyVCz1rWuxBa2jTLQ
 T6iBKOzgShXOmla1yzu0dL5v/aC0ouXSDDN8hdJAkBNAf6mAtCv/ERZAkwoulckz6fWU
 Dbhx7B4NBQEzRSluZI2rhnQc7Pff56pAyYK5zfrqIwXqEgBR6hUQqsXTfSWkxJSlXk2d
 AxfvCai3WB9dQ086T2xMF7hExFgIjBCDUeSJ2rPUB2DV7fvQzyBpga06dCL0gY0IDA7E
 CTGZH5w6HD3pWY6dpjJD1IPeFXIIb2xSgK1+EX89u3qHiSgIDWCiXTUZq8fX4FEPwMDy
 yHEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXneOkrwz4/xZ7mTPbYji+Q/cXZNeq90q9O0zuIOYlyjv9on7pQMWJFLqzKtCdmacjMYIwpvXw=@lists.denx.de
X-Gm-Message-State: AOJu0YxW9pviIIalnoXrBFCUveqM85lScYaatCPhSk36TF92ehL1qMTv
 OVHo0kp0H/805N8Lq/aLwbQlDihQG0PMsaYUXrgR77ubywsiAIJ6lprXESWesH9tuQBhZwyhzac
 CA0025iLXWcgJLBhQV3F3SvCCz2MC/Tw=
X-Gm-Gg: ASbGncsiBInAGlL4SGI95PN1t+t56mDFFU/PIc++qviNbrD7MyL48ehW+sOPdKZLbvl
 F+xoAmp6D3fwEAXyCwKDMpxTbzH8GjGI7SpxIDYE/ZAjLaaa3IpuCsE+y3fObOnVsQqAOHoU5re
 O2PE+ij2pJmAMlTRoG4Q4iisKVkJadcysLK62lPsOPYUnEzVauG10blkt7Hc0m5Bco30InU9fs4
 TKxEFjM
X-Google-Smtp-Source: AGHT+IHeDXcyS3Ab1eKeIe78WwZFL7xcb2Yn+SdjBRpAFGGgE22p53xaHe2VUuKGybOnknnA92x7jug9WftlrR6cGZM=
X-Received: by 2002:a05:600c:310a:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-4562751c28bmr27760255e9.27.1752590978687; Tue, 15 Jul 2025
 07:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250715111103.1092458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250715143151.GE193579@bill-the-cat>
In-Reply-To: <20250715143151.GE193579@bill-the-cat>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 15 Jul 2025 15:49:11 +0100
X-Gm-Features: Ac12FXwuSpaUCwx-azEoSLMYfJXp8dQxiabxw-hR4n60ZCvimYJHmiCxNmztns8
Message-ID: <CA+V-a8u4hOPNijmqO4P=yvPoyOjxApiEeT4kNJ4mBt-vY55A_A@mail.gmail.com>
Subject: Re: [PATCH] configs: renesas: Set CONFIG_TEXT_BASE to 0x0 for R-Car
 Gen3 PIE builds
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Chris Paterson <chris.paterson2@renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Tom,

On Tue, Jul 15, 2025 at 3:31=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Jul 15, 2025 at 12:11:03PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > For Renesas R-Car Gen3 platforms with CONFIG_POSITION_INDEPENDENT enabl=
ed,
> > override CONFIG_TEXT_BASE to 0x0 in each defconfig. The top-level Makef=
ile
> > already compensates for our PIE builds by appending:
> >
> >     OBJCOPYFLAGS_u-boot-elf.srec +=3D --change-addresses=3D0x50000000
> >
> > so that the flash_writer and legacy recovery tools still see an SREC lo=
ad
> > address of 0x5000_0000. This change prevents the "Program over size Err=
or"
> > reported by flash_writer when programming PIE U-Boot on these platforms=
.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  configs/hihope_rzg2_defconfig    | 2 +-
> >  configs/r8a77970_eagle_defconfig | 2 +-
> >  configs/r8a77970_v3msk_defconfig | 2 +-
> >  configs/r8a77990_ebisu_defconfig | 2 +-
> >  configs/r8a77995_draak_defconfig | 2 +-
> >  configs/rzg2_beacon_defconfig    | 2 +-
> >  configs/silinux_ek874_defconfig  | 2 +-
> >  7 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defcon=
fig
> > index f5bb28cb0c7..931183cc34b 100644
> > --- a/configs/hihope_rzg2_defconfig
> > +++ b/configs/hihope_rzg2_defconfig
> > @@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=3Dy
> >  CONFIG_RCAR_GEN3=3Dy
> >  CONFIG_COUNTER_FREQUENCY=3D16666666
> >  CONFIG_ARCH_CPU_INIT=3Dy
> > -CONFIG_TEXT_BASE=3D0x50000000
> > +CONFIG_TEXT_BASE=3D0x0
> >  CONFIG_ENV_SIZE=3D0x20000
> >  CONFIG_ENV_OFFSET=3D0xFFFE0000
> >  CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a774a1-hihope-rzg2m-ex"
>
> With POSITION_INDEPENDENT=3Dy the default is 0x0, so on the next resync
> these lines will be removed. Please just remove the lines setting them
> to 0x50000000, thanks.
>
I see thank you. Let's drop this patch.

Cheers,
Prabhakar
