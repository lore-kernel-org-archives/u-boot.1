Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524FED2E022
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 08:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98174890AE;
	Wed, 23 Oct 2024 10:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UScHalKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1C2891A3; Wed, 23 Oct 2024 10:38:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A478908D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 10:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XYMs84czwz9t2X;
 Wed, 23 Oct 2024 10:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729672732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gASXJgUiznHR0p1X+JRPSm7AikBPSLcmc487qiFnAc=;
 b=UScHalKPOPVodHXvYzHKrpFemEijnMMxhSqf4oUYWM9lzqwtH80Xztml0YO01RGJqu5nNR
 RSRhzIH1OaNvOWpZkSYU93fQ6GIs5WRkcva1kJxUNK1Lu2c1UkEanCqH605rZRDuf2cv7I
 /COb+E39EpnTAs/X62xiulEbiZ01RltkBmfm8px0Uby+HErcza8pgVBlXUHOAlZdgSrTes
 5zXgHElW8fA15VFCA/m0Xy0dYv6RiNE5hEdk77Qus1tr479y3ZuyUU+rmzTLXgBWSSDmKK
 UbbpmivGuOJJ42hpexn5t05/qBiYhlP1wo7XkyOwqRqkoMLrDMKoIU0rwXNB8g==
Message-ID: <e9929e0c-aa43-428f-8bf7-7b4cdef0e9c3@mailbox.org>
Date: Wed, 23 Oct 2024 10:38:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <b9cb3ec8-b6f2-4f38-8cda-d3d10278f503@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b9cb3ec8-b6f2-4f38-8cda-d3d10278f503@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8ex3fc6de9nmyx7ddq4keeexdc6o6w4r
X-MBO-RS-ID: f99f85ef8fd36321583
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

On 10/23/24 10:17 AM, Michal Simek wrote:
> 
> 
> On 10/22/24 23:06, Marek Vasut wrote:
>> This reverts commit 1e36d34b52e7a1ebe5a2a5339d6905540f4253aa.
>>
>> This parallel/stacked support breaks basic SPI NOR support,
>> e.g. this no longer works:
>>
>> => sf probe && sf update 0x50000000 0 0x160000
>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, 
>> total 64 MiB
>> device 0 offset 0x0, size 0x160000
>> SPI flash failed in read step
> 
> Reverting everything seems to me too much. Tom has tested it on his HW 
> and didn't see any issue. That's why better to look at code which is 
> causing this.
> You are reverting everything but likely there is specific patch which is 
> causing this. Which one is it?
> Which board was used for your testing? Likely we don't have access to it.
> Is there any QEMU available which can be used for debugging?

The testcase including the exact SPI NOR model is above.

iMX6 with w25q16dw seems to be broken too.

Basically every board I have access no longer has a working "sf probe ; 
sf update" combination ... so yeah, this means this patchset is 
fundamentally broken.

>> Since none of this seems to be in Linux either, revert it all.
> 
> This has been discussed with Tom before.

Tom is not the U-Boot MTD maintainer ?

> It wasn't in sync even before 
> and we can't really stop development on subsystems.
These patches have been rejected from mainline Linux for many years, why 
are they added to U-Boot which includes an import of MTD subsystem from 
Linux ? Such diverging code base with random patches will only make it 
much harder to synchronize Linux MTD subsystem back to U-Boot.
