Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A3C3DA60
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B5D88A52;
	Wed, 17 Jul 2024 16:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="SA407o08";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0rEk16H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3838D88A52; Wed, 17 Jul 2024 16:33:52 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6F4886DB
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id C8B93138008D;
 Wed, 17 Jul 2024 10:33:48 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute4.internal (MEProxy); Wed, 17 Jul 2024 10:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226828;
 x=1721313228; bh=c0z8zFdMIcVhcJouguDSuOZ1/pRLRt/7bPhDQCqQlJU=; b=
 SA407o08emUzqyB7V2/gcNaaUJmG0UqNM0J8hb691Bpj6+qtvCT4Y3mFYro9IcS7
 eL8r827wm5n8dn3THKcMSMfB+YqacPxUX2FGzaaPSN00blhZ/ZKXPADqlYX0cxbC
 /XGaA/6YkOUr9oP0P37bfbvd668fgdEupZkD7P39bp7+j96hVG0jxIO/0we6aQHt
 26YIQq6OPl4rbycYbF1N1hXZImrFJN46sASk1Sldtm19IxyNF+49REIEX5fERgBN
 dHDvKufamZF7IhQTrj1MM0uVTd1w16cq94rYvg2wjREmzUDAksNmfAjaANu7cpDf
 ABLS4uU6bUIEwyCsSEJRgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226828; x=
 1721313228; bh=c0z8zFdMIcVhcJouguDSuOZ1/pRLRt/7bPhDQCqQlJU=; b=m
 0rEk16HslLnyT5jVuejsl6zXuRHv1VkkplVIUdEChch4Mdh7yL2fsKUm+DbV5dmV
 EZljpySlI8dZnTwKVdRu+NxPKavzi3OqzuimwulclthajnVFoTbMd0CH45Wdmg8Q
 qPGJqgmVeJP9xWfHHyIFSJ94TAKJo/icG74FJ22hMQD18sjnXVPn9syuIypr+JlG
 ZxtadPctf+h2X2ZJAFD2J2gKRRbFSsbyjXcTLTQlgrGM4HlortdGXl4XD/FykUTu
 l2KBWJTLj6mRwvyFIiZEp5qO/wIu+rPP9Qbn8WYHF/y5tj9mCg1XycE2Qfri3HIo
 AsvRQ5UVwUksfywjfzzcQ==
X-ME-Sender: <xms:S9aXZngpdk7932sAhksYbbaqvaa36yctY_AIpim_PrMxyHCwJG4Vqw>
 <xme:S9aXZkCUJyS2jj7jglXFHnbwlC-gNu8YjFudYZ9CHWHBkPfTs9XkFt34xlcw1HY9I
 qRSJr53LvLwC1R8XYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
 ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:S9aXZnH3axYLtTUAj86FC4QeW35gdsNWNKIlPLdhJBsPU0NkX9xMyw>
 <xmx:S9aXZkRNV-vwKmkz1qqb6pQar4KjE4brH4-yF72-lj-YJHI57COusQ>
 <xmx:S9aXZkzCihJ8SWN6mNcQmTPRhj3gICphmkHfnnQ1rSf9pZEERtUCWQ>
 <xmx:S9aXZq6emxZnmMaqLhy-f65Vz6yIQUjgfuRFBdCVf0Vdwgs8ABop3Q>
 <xmx:TNaXZgdHqg_m5JIX36wIdK5kgP2WhTW0IAERr7u9SjlPgyRL2tIMgrgC>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5CB6436A0075; Wed, 17 Jul 2024 10:33:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <54ad4e1c-b6fe-4bfb-a8ee-e3b2b0946df2@app.fastmail.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
Date: Wed, 17 Jul 2024 22:33:24 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: u-boot@lists.denx.de
Cc: "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Simon Glass" <sjg@chromium.org>, "Lukasz Majewski" <lukma@denx.de>,
 "Sean Anderson" <seanga2@gmail.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v3 00/12] MIPS: Boston: Various enhancements
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8818=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=882:14=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This is a huge series which promoted MIPS/Boston target into a
> usable state, with fixes to drivers and general framework issues
> I found in this process.
>
> I also converted the target to OF_UPSTREAM.
>
> This target is covered by QEMU, to test on QEMU:
> ```
> make boston64r6el_defconfig
> make
> qemu-system-mips64el -M boston -cpu I6500 -bios ./u-boot.bin -nographic
> ```
>
> This is my first u-boot contribution, please kindly advise if you
> have any comments.

Ping for apply :-)

>
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v3:
> - Slight change in clk_boston probe order (Jonas)
> - Link to v2:=20
> https://lore.kernel.org/r/20240516-boston-v2-0-77938800d1dd@flygoat.com
>
> Changes in v2:
> - Drop "[PATCH 09/13] syscon: Probe device first in syscon_get_regmap"
>   in flavour of fixing the driver device life cycle (Jonas)
> - Link to v1:=20
> https://lore.kernel.org/r/20240513-boston-v1-0-fac96938417e@flygoat.com
>
> ---
> Jiaxun Yang (12):
>       pci: xilinx: Handle size of ecam region properly
>       pci: auto: Reduce bridge mem alignment boundary for boston
>       pci: Enable PCI_MAP_SYSTEM_MEMORY when ARCH_MAP_SYSMEM is not set
>       ahci: DMA addressing fixes
>       ahci: dwc_ahsata: Generalize the driver
>       MIPS: Provide dummy acpi_table.h
>       MIPS: boston: Imply various options
>       MIPS: boston: Provide default env vars
>       clk: boston: Allow to get regmap from parent device
>       dts/upstream: Add Makefile for MIPS
>       MIPS: boston: Migrate to OF_UPSTREAM
>       mailmap: Update email for Paul Burton
>
>  .mailmap                           |   3 +-
>  arch/mips/Kconfig                  |  28 +++++
>  arch/mips/dts/Makefile             |   1 -
>  arch/mips/dts/boston-u-boot.dtsi   |  10 ++
>  arch/mips/dts/img,boston.dts       | 222 ----------------------------=
---------
>  arch/mips/include/asm/acpi_table.h |  10 ++
>  board/imgtec/boston/Kconfig        |   4 +
>  board/imgtec/boston/MAINTAINERS    |   3 +-
>  board/imgtec/boston/boston.env     |   9 ++
>  board/imgtec/malta/MAINTAINERS     |   2 +-
>  configs/boston32r2_defconfig       |   2 +-
>  configs/boston32r2el_defconfig     |   2 +-
>  configs/boston32r6_defconfig       |   2 +-
>  configs/boston32r6el_defconfig     |   2 +-
>  configs/boston64r2_defconfig       |   2 +-
>  configs/boston64r2el_defconfig     |   2 +-
>  configs/boston64r6_defconfig       |   2 +-
>  configs/boston64r6el_defconfig     |   2 +-
>  drivers/ata/ahci.c                 |  34 +++---
>  drivers/ata/dwc_ahsata.c           |  82 +++++++++-----
>  drivers/ata/dwc_ahsata_priv.h      |   2 -
>  drivers/clk/clk_boston.c           |  19 ++--
>  drivers/pci/Kconfig                |  10 ++
>  drivers/pci/pci_auto.c             |  16 +--
>  drivers/pci/pcie_xilinx.c          |  53 ++++++---
>  dts/upstream/src/mips/Makefile     |  14 +++
>  include/ahci.h                     |   4 +-
>  27 files changed, 232 insertions(+), 310 deletions(-)
> ---
> base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
> change-id: 20240513-boston-45ef6edc219f
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun
