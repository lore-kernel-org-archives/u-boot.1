Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B24CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 23:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDFB88FBE;
	Fri, 27 Sep 2024 01:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6087deI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E0E88FD6; Fri, 27 Sep 2024 00:54:16 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76C688F89
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dfdcda2bdbcso65503276.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727391253; x=1727996053; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUZIATogLOdChvAUgtMHNNJc0MQihk4cJJ+mfrjnj6Q=;
 b=T6087deIcO7pvN9p6FvXOov5Z0y7umumTcjd2Q8an6h1P4yKodQhrJ6t8uvMjtz/N7
 fFFK9WmHJb0BXOt0Blj0DuZPWtCKrOuRD7DCN7u0LeEnXJhv7QSyulYj9jr/IAs6W2tW
 fN+cmZWdxgYE5EuBtOGMwZ1BERSUT9cqKZAIPcJShbeNvVOt95LxdUQHw8RmtaWe5Okp
 827CbQiONQeWTP9rnP7JDz/IHrNv6MRs8edNFakg2DvmKbpjAswmuQ6psUXeFaddKpfJ
 H1XP3FmvloeISkq5b8U+q4sj8oTQG+hq2tnH07LygSKavHna2lbXPEfdxytdOMcKF9kE
 beDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727391253; x=1727996053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUZIATogLOdChvAUgtMHNNJc0MQihk4cJJ+mfrjnj6Q=;
 b=BMIY3bQ7cByEZ22Bvuib7cPWY/Do8YlC1Ewxr1NZ60Eag/JzMU5PKHZwo+MHPKCkmg
 B/wZIpSy26EKwhGZt/K5shJQqvFBK1kSWyYXj5b+PUWwpmLItRWyUYfcmb3/3Rm6KBrr
 buejmEDqENj7Jr3xPtJ0cGDtUtAodLN1aIOzah6WEKvNQHC0zHUNq+xLAbMLbtU0GwkP
 nNANbR7pGajw4EM6lMsh7r43XvVyTho5ITmSZAq3zpwbZT+vaTL+ObUqNZ+8aOXji7lm
 vhs3HSi4YyZ3UAf/5Yg1Q2IoIUccb8dHUzDCm/ToikvJS7eCzz+OE5oTMAXIB02C+/nb
 0lOQ==
X-Gm-Message-State: AOJu0YwXao+v9SaiLsydan+5bSzPPrjBcOXzhaeTDeWZJvjvHUSza3G6
 RlqnY5EO9YU7tLxfg1u6zfka1WcmxFINgfp+5yZt0bo0xNiE/WeC523uOoFckfAibeVYpO2zFtd
 FRvzQ37KmFLKutzuDduGFAYSyrAc=
X-Google-Smtp-Source: AGHT+IHmIKff4MmldZ6i+c/nwGkOOL74NYPcetYj9aV43N6UPEjdrDPGjJR2nMZyAf8eRRJaP/MI+XVYikfuuAfSPPk=
X-Received: by 2002:a05:690c:7286:b0:631:52c:7b72 with SMTP id
 00721157ae682-6e24751b63dmr4793357b3.3.1727391252671; Thu, 26 Sep 2024
 15:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
In-Reply-To: <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 27 Sep 2024 00:53:36 +0200
Message-ID: <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Sep 2024 01:08:37 +0200
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

On Thu, Sep 26, 2024 at 3:36=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/26/24 12:49 AM, Lothar Rubusch wrote:
>
> Hi,
[...]
> > Shall I add the files to my DTS patches and ask for upstreaming of the
> > handoff files into the kernel?
>
> Are the handoff files really used by Linux for anything , or do they
> contain various clock/pinmux/DRAM settings only used by U-Boot ? If the
> later, place them into U-Boot and include them from -u-boot.dtsi file.

Similar to the other socfpga targets, the handoff files are just
relevant to u-boot. So, I'll keep them in arch/arm/dts.

My particular situation then is as follows. The .dts file just
includes several .dtsi files. I place this .dts file into
arch/arm/dts. The first includes contain the "handoff setup". Then I
include adjustments (.dtsi fragments) to the selected base-board and
boot-mode. Both  can vary that's why I really would prefer to allow
for a Kconfig option on that, in contrary to provide a set of .dts
files for all possible combinations.

Example:
$ cat ./arch/arm/dts/socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts
/dts-v1/;
/* will be taken from /arch/arm/dts */
#include "socfpga_arria10_mercury_aa1_handoff.h"
#include "socfpga_arria10-handoff.dtsi"
#include "socfpga_arria10_handoff_u-boot.dtsi"

/* will be taken from /dts/upstream */
#include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_arria10_mercu=
ry_aa1.dtsi"
#include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra_mer=
cury_bootmode_sdmmc.dtsi"
#include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra_mer=
cury_pe1.dtsi"

Ideally, now I like to have the first part as default device tree.
DEFAULT_DEVICE_TREE=3Dsocfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts
When doing so, I noticed I cannot enable CONFIG_OF_UPSTREAM anymore,
the files in arch/arm/dts won't be found anymore.
Then I have the issue how to access the generic .dtsi files used for
boot-mode or base board. These files are identical to the kernel DT
why I would prefer to use them from dts/upstream. Including them like
../../../../../... works, but... I think there must be a better way.
Ideally I like to setup some Kconfig choice for base board selection
and one for boot-mode.

1.) In the documentation control.rst I read that the u-boot.dts is
combined of several elements. Is there a way to take this base .dts,
then add a base board .dtsi by Kconfig option, and similar a
boot-mode?

2.) Is there a way to enable CONFIG_OF_UPSTREAM and use explicit DTS
from arch/arm/dts for the u-boot?

3.) What would be the best possibility to have a u-boot.dts with
handoff setup in arch/arm/dts and append .dtsi files from the general
dts/upstream - in case are there other boards are doing something
similar?
