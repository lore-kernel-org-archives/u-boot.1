Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC48CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 08:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A0B80422;
	Mon, 27 Oct 2025 09:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U9SgH+hY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76AB182A9E; Mon, 27 Oct 2025 09:08:39 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2298B80107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 09:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59R88WHK2367642;
 Mon, 27 Oct 2025 03:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761552512;
 bh=3U48fkymKUKH2vtE9X/2DRYb/tXzgPVZ5nh2xzcj3fY=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=U9SgH+hYeqUKJpuRfNycCsDoB9b5eCc8QJOp/KrHNG6yBUJrA+gTuyBW1XhprckE6
 z0p8Bka6SlTrT5Pm92te3QJsc0uiGSnneeODcCBOXw8tHklU9kgGQtUC4akXnhgosm
 Mjx+GEj6xX/EiAIVJQT043nHfS2oV+AgTkvuJvvY=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59R88W2J1251051
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 03:08:32 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 03:08:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 03:08:32 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59R88VaV333273;
 Mon, 27 Oct 2025 03:08:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Oct 2025 13:38:30 +0530
Message-ID: <DDSY8ZND5P7O.3GJV0YE4G8WL3@ti.com>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Vignesh R
 <vigneshr@ti.com>
Subject: Re: [PATCH v9 1/2] spl: remove usage of CMD_BOOTx from image parsing
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251025-fix_cmd_bootx-v9-0-dccf0aa0587f@ti.com>
 <20251025-fix_cmd_bootx-v9-1-dccf0aa0587f@ti.com>
 <20251025135227.GU6688@bill-the-cat>
In-Reply-To: <20251025135227.GU6688@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Sat Oct 25, 2025 at 7:22 PM IST, Tom Rini wrote:
> On Sat, Oct 25, 2025 at 02:38:37PM +0530, Anshul Dalal wrote:
>> Using CMD_* configs from spl doesn't make logical sense. Therefore
>> this patch replaces the checks for CMD_BOOTx with newly added library
>> symbols LIB_BOOT[IMZ] and SPL_LIB_BOOT[IMZ] which are enabled by their
>> respective CMD_* or SPL_* counterparts.
>>=20
>> SPL_BOOTZ is enabled by default for 32-bit ARM systems and SPL_BOOTI is
>> enabled by default for 64-bit ARM and RISCV.
>>=20
>> The respective C files (image.c/zimage.c) are compiled based on library
>> symbols BOOTx instead which are in turn selected by both CMD_BOOTx and
>> SPL_BOOTx as required.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/lib/Makefile   | 13 +++++++------
>>  arch/riscv/lib/Makefile |  4 ++--
>>  boot/Kconfig            | 18 ++++++++++++++++++
>>  cmd/Kconfig             |  5 +++++
>>  common/spl/Kconfig      | 16 ++++++++++++++++
>>  common/spl/spl.c        |  5 +++--
>>  6 files changed, 51 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>> index ade42d0ca4370b7df3aec59615f12e28a96874cd..3ea94709dfcdc2c9fd057ad5=
e129e041c59d6716 100644
>> --- a/arch/arm/lib/Makefile
>> +++ b/arch/arm/lib/Makefile
>> @@ -7,6 +7,13 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) +=3D ashldi3.o ashrdi3=
.o lshrdi3.o \
>>  				    lib1funcs.o uldivmod.o div0.o \
>>  				    div64.o muldi3.o
>> =20
>> +obj-$(CONFIG_$(PHASE_)LIB_BOOTI) +=3D image.o
>> +obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) +=3D zimage.o
>> +
>> +ifndef CONFIG_XPL_BUILD
>> +obj-$(CONFIG_$(PHASE_)LIB_BOOTM) +=3D bootm.o
>> +endif
>
> I wasn't clear enough, sorry. When you use $(PHASE_) you don't need
> CONFIG_XPL_BUILD. And if we select SPL_LIB_BOOTM we want bootm.o in SPL,
> yes?

Yeah, you're right. I missed the CONFIG_XPL_BUILD too, will re-run the
CI and post a v10.

