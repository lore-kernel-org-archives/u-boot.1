Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D78CF5385
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 12:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE06389278;
	Wed, 23 Oct 2024 14:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X3yPWnKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9AC89278; Wed, 23 Oct 2024 14:45:16 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D708925A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 14:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XYTKH0y9Gz9tSh;
 Wed, 23 Oct 2024 14:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729687507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jR6hH7qQagObgfMRWn+Z30a2P5s5WAjKp9PuinFV2b8=;
 b=X3yPWnKibj+EKNgKF2+Iisy8q6T1hu3aTiGpLbcOLlk410G9XkNQxa/8SLaG6ZLqq0Xtzh
 l+CX2kH1ETJbBANzLE0WlpdcypA/HBK+wR9Y6OP7gPlCV7njd9TVLRF4PgA2YuY7/nZtnW
 0x97QTLsFTJwetmzNurYRPsq/VDGSdcBb/u5VtZk5OHlvJexb3UTG7OJYdAU/3gXWbey+m
 OVD6I8971xY4p7PnjVEukPuGTBlggqfACvGl/gyhwuUeFGjwAYXXOBx2wlxsJBhy0cKGKu
 X22nPT0ETaI1vg6ErBjqPnx39NiacggkDXGJsgi2L7Y/HHIEH3y9zVszCLWx9A==
Message-ID: <03389ee7-3da9-4160-a193-00fd517ad56e@mailbox.org>
Date: Wed, 23 Oct 2024 14:45:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
 <SA1PR12MB869767A8D003AB114830D46A984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SA1PR12MB869767A8D003AB114830D46A984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xajrgtgggyad68mcu13i416xeo4xuswr
X-MBO-RS-ID: 62ef564259d206bf4ea
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

On 10/23/24 11:07 AM, Abbarapu, Venkatesh wrote:
> Hi,
> Tested with the non-stacked default single configuration on ZynqMP zcu102 board and didn’t see any issue.
> 
> ZynqMP> sf probe 0 0 0
> SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
> ZynqMP> sf erase 0x0 0x4000000;mw.b 0x8000 aabbccdd 0x4000000;sf write 0x8000 0x0 0x4000000;mw.b 0x8008000 0x0 0x4000000;sf read 0x8008000 0x0 0x4000000;cmp.b 0x8000 0x8008000 0x4000000
> SF: 67108864 bytes @ 0x0 Erased: OK
> device 0 whole chip
> SF: 67108864 bytes @ 0x0 Written: OK
> device 0 whole chip
> SF: 67108864 bytes @ 0x0 Read: OK
> Total of 67108864 byte(s) were the same
> 
> Thanks
> Venkatesh
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Wednesday, October 23, 2024 2:12 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; Marek Vasut
>> <marek.vasut+renesas@mailbox.org>; u-boot@lists.denx.de
>> Cc: Andre Przywara <andre.przywara@arm.com>; Ashok Reddy Soma
>> <ashok.reddy.soma@amd.com>; Jagan Teki <jagan@amarulasolutions.com>;
>> Michael Walle <mwalle@kernel.org>; Simek, Michal <michal.simek@amd.com>;
>> Patrice Chotard <patrice.chotard@foss.st.com>; Patrick Delaunay
>> <patrick.delaunay@foss.st.com>; Pratyush Yadav <p.yadav@ti.com>; Quentin
>> Schulz <quentin.schulz@cherry.de>; Sean Anderson <seanga2@gmail.com>;
>> Simon Glass <sjg@chromium.org>; Takahiro Kuwano
>> <Takahiro.Kuwano@infineon.com>; Tom Rini <trini@konsulko.com>; Tudor
>> Ambarus <tudor.ambarus@linaro.org>; uboot-stm32@st-md-
>> mailman.stormreply.com
>> Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support in
>> QSPI driver"
>>
>> On 10/23/24 5:18 AM, Abbarapu, Venkatesh wrote:
>>> Hi Marek,
>>> There was some issue and fix is sent
>>> https://lore.kernel.org/u-boot/20241018082644.22495-1-venkatesh.abbara
>>> pu@amd.com/T/#u
>>
>> Is this one fix or three fixes for three different issues ?
>>
>> This seems to fix READ errors, which is apparently another error introduced by this
>> stuff. In my case, plain and simply 'sf probe ; sf update' combination with single non-
>> stacked SPI NOR does not work. Was such a simple configuration ever tested ?
>>
>>> Not sure we need to revert whole parallel/stacked support?
>> Please stop top-posting.

You ran completely different test on completely different chip.

Stop top posting.
