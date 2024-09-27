Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0197DCF648A
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 22:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DCD88E46;
	Sat, 28 Sep 2024 00:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mf1oNsQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4782E88CB8; Sat, 28 Sep 2024 00:47:52 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1153E88AE7
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 00:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e01a6e5da1fso330121276.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727477268; x=1728082068; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZX8SfeyMvPsjtkQinGUpBk+8A6vb15/uNb49nGLpCg=;
 b=Mf1oNsQpoXvEoWvuXN4qUpDtVu3cgm+xWCCd8X0N0GVhM/D25qKoc4fT0yAr8uU5VO
 wJMeIB0k3DU8GjW3DPD2hGkGNecV2pYkNLov7MIIdSoYDZaC7K9nsuiWvJcx8kK3knMD
 N3S6qg9ppK/3ZHhNLtmqGgeDjUZDROjLYPNqUNq/aNMRdJStbRczNipKd727tlY1M+W3
 v9AG36LfJBcky++TJNyLPcmKkp/XFJHJQV8xp+TpiF3S8O+K72xm/EFHW8xdphcBL9wi
 nnnXYWfTH/XeWEOMEfr5u8M0CMaO2thiXgqFiv81gijY3gRRsnRp7a7DdAg0Tkto4KkU
 Cscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727477268; x=1728082068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZX8SfeyMvPsjtkQinGUpBk+8A6vb15/uNb49nGLpCg=;
 b=ZyCq1MgbH5nK2HEbwDKRMTdbpwQUEp7A21DmFiXohc20wIFoIgilxF3W19cQBD8nf2
 Y4xJWHN6jZ5YKk8jUFJxlFL8rYxGVwzG9/ZCgh7hRl7I6ZgZZcfAAHCKyeOFR6EqNyF2
 kFdKZv4EtmPAyVVJmqXsOp23dX90+iwHYXdcVJwlOm7aIA5kV/Kr8v8zB/qA24TYrtff
 FRENSmSeo+W7e/tyA3uDf/HOea6yLPQyNItiby6EBtw4m8ojGaBE6OAZ+UsUUYWXWGrt
 ub7A8jtIHZx4msmqMtZVJgcd8lS1HPu1mxq1uVs6z1r0thzQH5yV+y56KpleE7FdE8N0
 1eZg==
X-Gm-Message-State: AOJu0YzE7OZgfi3AnXefNeVXwYCOYp/dnv+yTTrzOEf+Ljsc26PL2hgP
 xtpsajrPd7xkSh/KpRcxBJW0TujuRtkGnIacmVu8cs0cSuNqUci4JkcMJpZeW7yvElUwk15Nz2v
 /1As3k7uvqYfloADsJipBfehCGAY=
X-Google-Smtp-Source: AGHT+IEGawH7Il350olXCKH2+NA5wmZbpnoxe19XNvoBJAmfpJHA6iwz0dgDLt8KipYiJVuWGRtcnJuoirCjXBRZssw=
X-Received: by 2002:a05:690c:b:b0:6dd:ca99:6a8e with SMTP id
 00721157ae682-6e258e1a699mr4833647b3.5.1727477268609; Fri, 27 Sep 2024
 15:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
 <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
 <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
In-Reply-To: <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 28 Sep 2024 00:47:12 +0200
Message-ID: <CAFXKEHYvNC5WKphy2LZ=w5tSv_0W3DM4BjSgT821RY5wsYB1jQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Sep 2024 00:48:49 +0200
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

On Fri, Sep 27, 2024 at 1:19=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/27/24 12:53 AM, Lothar Rubusch wrote:
> > On Thu, Sep 26, 2024 at 3:36=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 9/26/24 12:49 AM, Lothar Rubusch wrote:
> >>
> >> Hi,
> > [...]
> >>> Shall I add the files to my DTS patches and ask for upstreaming of th=
e
> >>> handoff files into the kernel?
> >>
> >> Are the handoff files really used by Linux for anything , or do they
> >> contain various clock/pinmux/DRAM settings only used by U-Boot ? If th=
e
> >> later, place them into U-Boot and include them from -u-boot.dtsi file.
> >
> > Similar to the other socfpga targets, the handoff files are just
> > relevant to u-boot. So, I'll keep them in arch/arm/dts.
>
> Right
>
> > My particular situation then is as follows. The .dts file just
> > includes several .dtsi files. I place this .dts file into
> > arch/arm/dts. The first includes contain the "handoff setup". Then I
> > include adjustments (.dtsi fragments) to the selected base-board and
> > boot-mode. Both  can vary that's why I really would prefer to allow
> > for a Kconfig option on that, in contrary to provide a set of .dts
> > files for all possible combinations.
> >
> > Example:
> > $ cat ./arch/arm/dts/socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts
>
> Upstream DT named this way into Linux:
>
> socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
>
> And then in U-Boot, implement the extras which include whatever you
> need, name the file:
>
> socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dtsi
>
> The U-Boot build system will combine the two DTs, the build system
> should automatically append matching -u-boot.dtsi content to any .dts fil=
e.
>
> I am not sure if this also works if the .dts file is in dts/upstream/*
> while the -u-boot.dtsi is in arch/*/dts/ , but there is now definitely a
> use case for such a setup, it is probably a matter of tweaking the
> Makefiles .
>
> > /dts-v1/;
> > /* will be taken from /arch/arm/dts */
> > #include "socfpga_arria10_mercury_aa1_handoff.h"
> > #include "socfpga_arria10-handoff.dtsi"
> > #include "socfpga_arria10_handoff_u-boot.dtsi"
> >
> > /* will be taken from /dts/upstream */
> > #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_arria10_m=
ercury_aa1.dtsi"
> > #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra=
_mercury_bootmode_sdmmc.dtsi"
> > #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra=
_mercury_pe1.dtsi"
> >
> > Ideally, now I like to have the first part as default device tree.
> > DEFAULT_DEVICE_TREE=3Dsocfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts
> > When doing so, I noticed I cannot enable CONFIG_OF_UPSTREAM anymore,
> > the files in arch/arm/dts won't be found anymore.
> > Then I have the issue how to access the generic .dtsi files used for
> > boot-mode or base board. These files are identical to the kernel DT
> > why I would prefer to use them from dts/upstream. Including them like
> > ../../../../../... works, but... I think there must be a better way.
>
> Look at how the -u-boot.dtsi are automatically added on top of .dts
> files, that might be a start.
>
> > Ideally I like to setup some Kconfig choice for base board selection
> > and one for boot-mode.
>
> > 1.) In the documentation control.rst I read that the u-boot.dts is
> > combined of several elements. Is there a way to take this base .dts,
> > then add a base board .dtsi by Kconfig option, and similar a
> > boot-mode?
>
> The -u-boot.dtsi is preprocessed by C preprocessor, just like all the
> other DTs, so you can have a -u-boot.dtsi file which contains C
> preprocessor conditional statements in it to conditionally include other
> .dtsi files:
>
> #if IS_ENABLED(...)
> #include ...
> #else ...
> ...
> #endif

Going through the include list setup by the Makefile made me find my
mistake. Currently I may use u-boot specific stuff in arch/arm/dts and
include generic .dtsi fragments from dts/upstream. Note: I'm not
setting CONFIG_OF_UPSTREAM since I'm using the regular include list
which already contains dts/upstream/src/arm/intel. Is this ok? Or,
shall I try a different approach, which involves having
CONFIG_OF_UPSTREAM explicitely set in the defconfig?

> > 3.) What would be the best possibility to have a u-boot.dts with
> > handoff setup in arch/arm/dts and append .dtsi files from the general
> > dts/upstream - in case are there other boards are doing something
> > similar?
>
> See above, maybe some of it helps.

Yes. This helped. I can set base-board and boot mode now by Kconfig
option with a generic .dts file. Note, it may still take some time,
since I'd like to test the stuff still a bit on hardware before
submitting something to the list.
