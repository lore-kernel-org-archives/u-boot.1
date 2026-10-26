Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798D606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uvbi917P;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=1klniayp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 512BC40781;
	Mon, 26 Oct 2026 18:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nla1sN7booN6; Mon, 26 Oct 2026 18:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF42640729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793040871;
	b=mqNbed2uUBfm2jbrp1bZWeyoCPJazAUvTBvGJanK0+K+fhKF9SXM6KCLZaQ5vSwyU74g
	 bQh0BbbZLDL+kkp1yRq28AH5y6MTfA6N6cd4XBpnKxKCOWz6u3iGDfeoCPTmwRdfyqrkJ
	 9rRMHYJHH9jq1/+cDcLoNM+ShRMKWytXMXiuoJPsh1JcTmE5kNTgWtO5xCUmzehJ3LJOF
	 eGbe6nygQBJIcbeWQ3QJ5McOLA2zcH2TnICXAG5NHqEEE0p7GvHShZsczzl6Vr3+IMssq
	 SeGtGYYMXXXGBrKdQyvflO1VubhA/cvTNv8xV65cZIMoQz83vrEOGD7Hw+XxhxfWB4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793040871;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jo1is1QLlFnhAtNEFwwIpuGdmnH/N5XeKV8YFuiL8h8=;
	b=b3V7zbW8PKIvW397OrjKia+KkjE1P2KRSX4lj9laE5XgCRZ5x+szUwzdhPh+jR/4hobW
	 nbxm1dBpTn93nAWbsPLNNcZSoj+Mq/2Q+zCBqPGtwUV284K5sGiZSBfhHdRDJ4u7stM/N
	 YJd7x13P2Kp3RQFWvFRIWfpu7np7QJ+zs6AmfPLHIEuSYVdhn3gyE6wQ/WLkKmVuzaDV6
	 a6kgNgKna+Rdd7+ger5xn7y/0HZlyprxHil6u6JzyA75HIa+SJirznxX/05mMs8TPXEga
	 0kwuknkyTdodQW1I/d0ewz5PNvVPJ6jOrPbBHV7oh7o2If4kU7h1M88TnUCEZapTuNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793040871;
	bh=jo1is1QLlFnhAtNEFwwIpuGdmnH/N5XeKV8YFuiL8h8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvbi917P98ajU+0r9379dyj80YJpIpjjwYR+qcv/NqaSmTDujth7zTMMuO/ycoh1K
	 SU9PDGSqHBE7qe2QIoLfWf5GyrAAohjmS4WY8/+8LvEGSA058/Ppgu7cnGqVnJ1gf7
	 WVAQLarXy2UxKQR1lq9XMwSUKeeuqf5QGWFax0t4Vcmc65kM21ViTXamzvkn8Zec8/
	 hkpvtoSBN/r7iki45soKjCugYScL786fESdaD6W6ivAN7KFBcmQFbnbdPBv60ZbPjn
	 5F6W0oeP1HH/H05NHyR4Iuqt72+O8jGJ9DhSs+cdHyPWZsgJCRdESVpe8+/VnTUuzm
	 9vpGGUzWpvI6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF42640729;
	Mon, 26 Oct 2026 18:54:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B08B380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C23480CCC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myOotBJ-45ok for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87BBE80CA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793040867;
 b=bWKKevM7o5ZTnwtMYijMu4Sdy1LfyW8+XpUZs+LwJ0lm7zTfk8FwnvJ9mY5eagf8dvih
 2yTlzxZb1+yQ8XNzpNW/JAaAIy6KgOH3X0FyKN3H05/20knBgI1AlXduhwThxM/FkANqP
 1EYUFap01gT8eF+8Y2OS4v2Y+MNkzHEH5ebnuuD6UokVusWpM7KoCMPEwY1fOKpOFQopy
 vvosJ30w8VwZJjEolOv/mi2Wn9vHZARmnT2qBEb0X+Y0jvxogdt/5TNh/cMnsohNasMHn
 /VfW8C/eKczn1IH+qyQsLEVclu2V8HXitwtuXLIxz15mZkGh0bP3B6lFu3i9HIB3TTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793040867;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=jo1is1QLlFnhAtNEFwwIpuGdmnH/N5XeKV8YFuiL8h8=;
 b=Y2r+WcQf1nIN5313BftJKJ0hpb1q8kYwJ6Uy6UmklKSVagE/Ia5CaaF4jrD5gUpZ+X9A
 Ci2ppDsMep4bkaKKQOy6jeE6SZAUFEHz9j3YJIinJEKVH4dU1ZE84ZeBKILQjOWbNv13d
 AfXBo1L9X1inOB75Vb4BmQBS6tcJSzH6eqFwPpiuREhvrtdamPQHJoETEyQ6OU6ibkb99
 krGeflXBfEweSMjw7aAtQ4Ghoe6MrGsmwH5U9j3Cj9l5fQZFjP1Kjy+fcGRzjRY2hpYkS
 xizfx+p9wiiIer+QnOquamVJcdgcJUpjQbjYnjXL7Ynnk2NciAxDpC4SPsZAQFeqC3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=1klniayp; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=752c32f41=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=1klniayp
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87BBE80CA4
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793040874; x=1824576874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JvQJEdMuYIJ2x/yd2HMKe0ScH+kv+skcwP5LfMAYOQQ=;
 b=1klniaypchhBoP6HZOdXYAUxAyApZ+b+w6AWvKf5In2DiaebYxPALEwE
 K16/1kXzQTj7Ah/q1dBCRG5UUaapk/gA3jO2ELLgllb43/qtDjwEPDOVm
 Vz1VGWyVgBk7F9Igb1/++Nsybs7eXT40b77RQEXOazdBB+3RhVXm9RJvA
 s07utdeCKGpF/0aUUZtsUQQVsMxhAQSw3/YTfrUQo1iB4sPUeocuXCLOQ
 +iz0z58wVD+6shhT4LJfe5FfseI62nJuK2SnXl59wbQ4aPlk5aMIVuF+d
 kzk+MDNS6253ZhtgNcqsdo5ccpP/5SB7HthtZh1jqQm41Sqz0AN7GPTwC A==;
X-CSE-ConnectionGUID: rDbIeDhgQLiHkA6Y8yytZQ==
X-CSE-MsgGUID: lIxhF/l9ToyoEB6mSb1mSg==
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; d="scan'208";a="297001630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 11:54:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 11:54:23 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 11:54:22 -0700
Date: Mon, 26 Oct 2026 14:54:15 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Peng Fan
 <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 5/8] firmware: rpmi: add a test and a sandbox driver
Message-ID: <at-h15c5Nn-PpUZi@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-5-d53d34a49780@microchip.com>
 <CAPxK-6dAV__Pu4ACk+GNK6kXZUcWvp1jUpNd-7-E_ysCs1=18g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPxK-6dAV__Pu4ACk+GNK6kXZUcWvp1jUpNd-7-E_ysCs1=18g@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:49:39PM +0530, Subrahmanya Lingappa wrote:
> Charles,
> 
> On Wed, Oct 14, 2026 at 7:47 PM Charles Perry
> <charles.perry@microchip.com> wrote:
> >
> > Create a new transport layer that sends the messages to a simulated RPMI
> > firmware.
> >
> > For now, this only contains a simulation of the clock service group
> > which is implemented using code from librpmi [1] and adapted.
> >
> > Also add a test in test/dm that makes use of the RPMI clock driver.
> >
> > [1]:
> > https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795432e260f17e1fc5091c9a3a/lib/rpmi_service_group_clock.c
> >
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> > Changes in v4: None
> > Changes in v3: None
> >
> > Changes in v2:
> >  - Reorder headers
> > ---
> >  MAINTAINERS                                |   1 +
> >  arch/sandbox/dts/test.dts                  |  12 +
> >  configs/sandbox_defconfig                  |   2 +
> >  drivers/firmware/rpmi/Kconfig              |   3 +-
> >  drivers/firmware/rpmi/Makefile             |   1 +
> >  drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++++++++++++
> >  drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++++++
> >  drivers/firmware/rpmi/rpmi-sandbox.h       |  47 +++
> >  test/dm/Makefile                           |   1 +
> >  test/dm/rpmi.c                             |  48 ++++
> >  10 files changed, 716 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cf45df9a027a..6ca7709c64b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1564,6 +1564,7 @@ S:        Maintained
> >  F:     drivers/clk/clk_rpmi.c
> >  F:     drivers/firmware/rpmi/
> >  F:     include/rpmi*
> > +F:     test/dm/rpmi.c
> >
> >  SANDBOX
> >  M:     Simon Glass <sjg@chromium.org>
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index 25c99ef81472..d7998fa0da4a 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -882,6 +882,18 @@
> >                 sm: secure-monitor {
> >                         compatible = "sandbox,sm";
> >                 };
> > +
> > +               rpmi: rpmi {
> > +                       compatible = "sandbox,rpmi-transport";
> > +                       #mbox-cells = <1>;
> > +               };
> > +
> > +               rpmi_clock: rpmi-clock {
> > +                       compatible = "riscv,rpmi-clock";
> > +                       mboxes = <&rpmi 0x8>;
> > +                       #clock-cells = <1>;
> > +                       clocks = <&rpmi_clock 0>, <&rpmi_clock 1>, <&rpmi_clock 2>, <&rpmi_clock 3>;
> > +               };
> >         };
> >
> >         fpga {
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index a2708e6fb333..52df7cc08b14 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -198,6 +198,7 @@ CONFIG_BUTTON_GPIO=y
> >  CONFIG_CLK=y
> >  CONFIG_CLK_K210=y
> >  CONFIG_CLK_K210_SET_RATE=y
> > +CONFIG_CLK_RPMI=y
> >  CONFIG_SANDBOX_CLK_CCF=y
> >  CONFIG_CLK_SCMI=y
> >  CONFIG_CPU=y
> > @@ -214,6 +215,7 @@ CONFIG_FASTBOOT_FLASH=y
> >  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> >  CONFIG_ARM_FFA_TRANSPORT=y
> >  CONFIG_SCMI_FIRMWARE=y
> > +CONFIG_RPMI_FIRMWARE=y
> >  CONFIG_FPGA_ALTERA=y
> >  CONFIG_FPGA_STRATIX_II=y
> >  CONFIG_FPGA_STRATIX_V=y
> > diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
> > index 421a1fa9deba..b462d3693987 100644
> > --- a/drivers/firmware/rpmi/Kconfig
> > +++ b/drivers/firmware/rpmi/Kconfig
> > @@ -1,6 +1,7 @@
> >  config RPMI_FIRMWARE
> >         bool "Enable RPMI support"
> > -       depends on RISCV && DM && OF_CONTROL
> > +       depends on RISCV || SANDBOX
> > +       depends on DM && OF_CONTROL
> >         select FIRMWARE
> >         help
> >           RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
> > diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
> > index 4f4bcb929db4..150e98a72df9 100644
> > --- a/drivers/firmware/rpmi/Makefile
> > +++ b/drivers/firmware/rpmi/Makefile
> > @@ -1,3 +1,4 @@
> >  obj-y  += rpmi-uclass.o
> >  obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
> >  obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
> > +obj-$(CONFIG_SANDBOX)  += rpmi-sandbox.o rpmi-sandbox-clock.o
> > diff --git a/drivers/firmware/rpmi/rpmi-sandbox-clock.c b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
> > new file mode 100644
> > index 000000000000..fa205d067b24
> > --- /dev/null
> > +++ b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
> > @@ -0,0 +1,446 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 Ventana Micro Systems Inc.
> > + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_RPMI
> > +
> > +#include <asm/types.h>
> > +#include <asm/io.h>
> > +#include <asm/byteorder.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <rpmi.h>
> > +#include "rpmi-sandbox.h"
> > +
> > +struct rpmi_clock {
> > +       enum rpmi_clock_type type;
> > +       const char *name;
> > +       u32 rate_count;
> > +       const u64 *rate_array;
> > +       u32 transition_latency;
> > +       enum rpmi_clock_state state;
> > +       u64 rate;
> > +};
> > +
> > +const u64 discrete_rates[] = { 20000000, 333333333, 500000000, 1000000000 };
> > +
> > +const u64 linear_rates[] = { 50000000, 100000000, 1000000 };
> > +
> > +#define DISCRETE_CLOCK(name, current_state, current_rate) \
> > +       { RPMI_CLK_TYPE_DISCRETE,                         \
> > +         name,                                           \
> > +         ARRAY_SIZE(discrete_rates),                     \
> > +         discrete_rates,                                 \
> > +         0,                                              \
> > +         current_state,                                  \
> > +         current_rate }
> > +
> > +#define LINEAR_CLOCK(name, current_state, current_rate)         \
> > +       { RPMI_CLK_TYPE_LINEAR, name, ARRAY_SIZE(linear_rates), \
> > +         linear_rates,         0,    current_state,            \
> > +         current_rate }
> > +
> > +struct rpmi_clock clock_simulation[] = {
> > +       DISCRETE_CLOCK("CLK0", RPMI_CLK_STATE_DISABLED, discrete_rates[0]),
> > +       DISCRETE_CLOCK("CLK1", RPMI_CLK_STATE_DISABLED, discrete_rates[1]),
> > +       DISCRETE_CLOCK("CLK2", RPMI_CLK_STATE_ENABLED, discrete_rates[2]),
> > +       LINEAR_CLOCK("CLK3", RPMI_CLK_STATE_ENABLED, linear_rates[0]),
> > +};
> > +
> > +static u32 clock_count = ARRAY_SIZE(clock_simulation);
> > +
> > +static struct rpmi_clock *rpmi_get_clock(u32 clkid)
> > +{
> > +       if (clkid >= clock_count)
> > +               return NULL;
> > +
> > +       return &clock_simulation[clkid];
> > +}
> > +
> > +static enum rpmi_error_codes
> > +rpmi_clock_set_rate(u32 clkid, enum rpmi_clock_rate_match match, u64 rate)
> > +{
> > +       struct rpmi_clock *clk = rpmi_get_clock(clkid);
> > +
> > +       if (!clk)
> > +               return RPMI_ERR_INVALID_PARAM;
> > +
> > +       clk->rate = rate;
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes rpmi_clock_set_state(u32 clkid,
> > +                                                 enum rpmi_clock_state state)
> > +{
> > +       struct rpmi_clock *clk = rpmi_get_clock(clkid);
> > +
> > +       if (!clk)
> > +               return RPMI_ERR_INVALID_PARAM;
> > +
> > +       clk->state = state;
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes rpmi_clock_get_state(u32 clkid,
> > +                                                 enum rpmi_clock_state *state)
> > +{
> > +       struct rpmi_clock *clk = rpmi_get_clock(clkid);
> > +
> > +       if (!clk || !state)
> > +               return RPMI_ERR_INVALID_PARAM;
> > +
> > +       *state = clk->state;
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes rpmi_clock_get_rate(u32 clkid, u64 *rate)
> > +{
> > +       struct rpmi_clock *clk = rpmi_get_clock(clkid);
> > +
> > +       if (!clk || !rate)
> > +               return RPMI_ERR_INVALID_PARAM;
> > +
> > +       *rate = clk->rate;
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes
> > +rpmi_clock_sg_get_num_clocks(struct rpmi_transport *trans, u16 request_datalen,
> > +                            const u8 *request_data, u16 *response_datalen,
> > +                            u8 *response_data)
> > +{
> > +       u32 *resp = (void *)response_data;
> > +
> > +       resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
> > +       resp[1] = cpu_to_le32(clock_count);
> > +
> > +       *response_datalen = 2 * sizeof(*resp);
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes
> > +rpmi_clock_sg_get_attributes(struct rpmi_transport *trans, u16 request_datalen,
> > +                            const u8 *request_data, u16 *response_datalen,
> > +                            u8 *response_data)
> > +{
> > +       struct rpmi_clock *clk;
> > +       u16 resp_dlen;
> > +       u32 flags = 0;
> > +
> > +       u32 *resp = (void *)response_data;
> > +
> > +       u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
> > +
> > +       clk = rpmi_get_clock(clkid);
> > +       if (!clk) {
> > +               resp_dlen = sizeof(*resp);
> > +               resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> > +               goto done;
> > +       }
> > +
> > +       /* encode CLOCK_FORMAT */
> > +       if (clk->type == RPMI_CLK_TYPE_LINEAR)
> > +               flags |= 1;
> > +
> > +       resp[3] = cpu_to_le32(clk->transition_latency);
> > +       resp[2] = cpu_to_le32(clk->rate_count);
> > +       resp[1] = cpu_to_le32(flags);
> > +       resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
> > +
> > +       if (clk->name)
> > +               strlcpy((char *)&resp[4], clk->name, RPMI_CLK_NAME_LEN);
> > +
> > +       resp_dlen = 8 * sizeof(*resp);
> > +
> > +done:
> > +       *response_datalen = resp_dlen;
> > +
> > +       return RPMI_SUCCESS;
> > +}
> > +
> > +static enum rpmi_error_codes
> > +rpmi_clock_sg_get_supp_rates(struct rpmi_transport *trans, u16 request_datalen,
> > +                            const u8 *request_data, u16 *response_datalen,
> > +                            u8 *response_data)
> > +{
> > +       u32 i = 0, j = 0;
> > +       u32 rate_count;
> > +       u32 resp_dlen = 0, clk_rate_idx = 0;
> > +       u32 max_rates, remaining = 0, returned = 0;
> > +       const u64 *rate_array;
> > +       struct rpmi_clock *clk;
> > +
> > +       u32 *resp = (void *)response_data;
> > +
> > +       u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
> > +
> > +       clk = rpmi_get_clock(clkid);
> > +       if (clk) {
> > +               resp_dlen = sizeof(*resp);
> > +               resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> > +               goto done;
> > +       }
>  This condition is inverted: a valid clock ID returns
>  `RPMI_ERR_INVALID_PARAM`, while an invalid ID leaves `clk == NULL` and is
>  dereferenced on the next line. Please change this to `if (!clk)`.

Oh, that's bad...

> 
> > +
> > +       rate_count = clk->rate_count;
> > +       rate_array = clk->rate_array;
> > +       if (!rate_count || !rate_array) {
> > +               resp_dlen = sizeof(*resp);
> > +               resp[0] = cpu_to_le32((u32)RPMI_ERR_NOTSUPP);
> > +               goto done;
> > +       }

...

> > diff --git a/test/dm/Makefile b/test/dm/Makefile
> > index 5dd6b57bbe84..c6372fa40583 100644
> > --- a/test/dm/Makefile
> > +++ b/test/dm/Makefile
> > @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
> >  obj-$(CONFIG_$(PHASE_)DM_RNG) += rng.o
> >  obj-$(CONFIG_DM_RTC) += rtc.o
> >  obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
> > +obj-$(CONFIG_RPMI_FIRMWARE) += rpmi.o
> >  obj-$(CONFIG_SCSI) += scsi.o
> >  obj-$(CONFIG_DM_SERIAL) += serial.o
> >  obj-$(CONFIG_DM_SPI_FLASH) += sf.o
> > diff --git a/test/dm/rpmi.c b/test/dm/rpmi.c
> > new file mode 100644
> > index 000000000000..7cb4fd11a46d
> > --- /dev/null
> > +++ b/test/dm/rpmi.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + */
> > +
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/test.h>
> > +#include <rpmi.h>
> > +#include <stdio.h>
> > +#include <test/ut.h>
> > +
> > +static int dm_test_rpmi_clock(struct unit_test_state *uts)
> > +{
> > +       struct udevice *rpmi_dev, *clk_dev;
> > +       struct clk clk0, clk1, clk2, clk3;
> > +
> > +       ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_dev));
> > +
> > +       ut_assertok(
> > +               uclass_get_device_by_name(UCLASS_CLK, "rpmi-clock", &clk_dev));
> > +
> > +       // Grab clock 0 and retrieve the rate
> > +       ut_assertok(clk_get_by_index(clk_dev, 0, &clk0));
> > +       ut_asserteq_64(20000000, clk_get_rate(&clk0));
> > +
> > +       // Change to 1GHz
> > +       ut_asserteq(1000000000, clk_set_rate(&clk0, 1000000000));
> 
>  The test does not exercise the supported-rates path above. Please add a
>  regression test that sends `GET_SUPPORTED_RATES` through the sandbox transport
>  for both a valid clock ID and an out-of-range ID. The current get-rate/set-rate
>  test passes without invoking this service. Enable/disable coverage can be
>  added separately; shared-memory and MPXY command tests belong with their
>  respective transport/command harnesses.

The RPMI clock driver doesn't even use the GET_SUPPORTED_RATES service as
of now. I'll add the ->round_rate() callback for completeness so that we
can test this service.

Thanks,
Charles

> 
>  Regards,
>  Subrahmanya
> 
