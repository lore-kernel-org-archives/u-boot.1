Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7090DD59F6A
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 19:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A605088D56;
	Wed,  6 Nov 2024 20:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="smJKQ3vY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49DF88D56; Wed,  6 Nov 2024 20:18:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D813888E89
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 20:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A6JIJII085802;
 Wed, 6 Nov 2024 13:18:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730920699;
 bh=6FUNsSPFzHtJuJ1B021tVJ5EzFHq7ND9rv+tjdOK9n8=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=smJKQ3vYlzul5ndYaUVh/nUpDZ08q4KLrJSy1/LsDt8g/Kn0fEepMPHwZR2AfNBSr
 Y+/k0liIMFNq5AntNupqRtRFnoHxcjDKg7U4ElFJkfvX0+RLFVDd3FBo+cGbPpccrq
 eNBnebhxWrk4D+61Mvf0IYVu993c6HNt/4j1RQLw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A6JIJ3S085738
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Nov 2024 13:18:19 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 13:18:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 13:18:18 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6JIIDR065489;
 Wed, 6 Nov 2024 13:18:18 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, <u-boot@lists.denx.de>
CC: Andre Przywara <andre.przywara@arm.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Jagan Teki <jagan@amarulasolutions.com>,
 "Michael Walle" <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Pratyush Yadav
 <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tom Rini <trini@konsulko.com>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories
 support in QSPI driver"
In-Reply-To: <e9929e0c-aa43-428f-8bf7-7b4cdef0e9c3@mailbox.org>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <b9cb3ec8-b6f2-4f38-8cda-d3d10278f503@amd.com>
 <e9929e0c-aa43-428f-8bf7-7b4cdef0e9c3@mailbox.org>
Date: Wed, 6 Nov 2024 13:18:18 -0600
Message-ID: <86v7x05fyd.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Marek Vasut <marek.vasut@mailbox.org> writes:

> On 10/23/24 10:17 AM, Michal Simek wrote:
>> 
>> 
>> On 10/22/24 23:06, Marek Vasut wrote:
>>> This reverts commit 1e36d34b52e7a1ebe5a2a5339d6905540f4253aa.
>>>
>>> This parallel/stacked support breaks basic SPI NOR support,
>>> e.g. this no longer works:
>>>
>>> => sf probe && sf update 0x50000000 0 0x160000
>>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, 
>>> total 64 MiB
>>> device 0 offset 0x0, size 0x160000
>>> SPI flash failed in read step
>> 
>> Reverting everything seems to me too much. Tom has tested it on his HW 
>> and didn't see any issue. That's why better to look at code which is 
>> causing this.
>> You are reverting everything but likely there is specific patch which is 
>> causing this. Which one is it?
>> Which board was used for your testing? Likely we don't have access to it.
>> Is there any QEMU available which can be used for debugging?
>
> The testcase including the exact SPI NOR model is above.
>
> iMX6 with w25q16dw seems to be broken too.
>
> Basically every board I have access no longer has a working "sf probe ; 
> sf update" combination ... so yeah, this means this patchset is 
> fundamentally broken.
>

I can also confirm that the patch series:

f8efc68b30e Merge patch series "spi-nor: Add parallel and stacked memories
support"

breaks SPI NOR on TI platforms, particularly SK-AM62 and SK-AM62P:

U-Boot 2024.10-00752-gf8efc68b30e2 (Nov 06 2024 - 12:25:13 -0600)

SoC:   AM62X SR1.0 HS-FS
Model: Texas Instruments AM625 SK
...
Hit any key to stop autoboot:  0
=> sf probe && sf update ${loadaddr} 0x400000 0x10
SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
device 0 offset 0x400000, size 0x10
SPI flash failed in read step
=>

Jon

>>> Since none of this seems to be in Linux either, revert it all.
>> 
>> This has been discussed with Tom before.
>
> Tom is not the U-Boot MTD maintainer ?
>
>> It wasn't in sync even before 
>> and we can't really stop development on subsystems.
> These patches have been rejected from mainline Linux for many years, why 
> are they added to U-Boot which includes an import of MTD subsystem from 
> Linux ? Such diverging code base with random patches will only make it 
> much harder to synchronize Linux MTD subsystem back to U-Boot.
