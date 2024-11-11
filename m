Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6900D2E9F0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656CC88AE8;
	Mon, 11 Nov 2024 15:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rc8tEcqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9985788599; Mon, 11 Nov 2024 15:18:50 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EDF88FAF
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABEIKaj2514395
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2024 08:18:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731334700;
 bh=mexHF/HfvnPJXZzDI+nyeRMjMYRV9SgopAZvmZYte+w=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=rc8tEcqTPSXrYN1nDcir7/+KmWLNk/asoH5Pd8uzPjOkyiMdK/HjbApFsAZ30q4sk
 ne5+zVSsihBf/nFgOrn0ykNGrtztaZGokuGyhvgvzcaUlCGgYnQUvoPTVp3vIyLghW
 052GFWT2LvoptMygqer5/GiRyNY02q3DHCy8MNLI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABEIKGt032660
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Nov 2024 08:18:20 -0600
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 08:18:20 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 11 Nov
 2024 08:18:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 08:18:19 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABEIKLJ059860;
 Mon, 11 Nov 2024 08:18:20 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
CC: Andre Przywara <andre.przywara@arm.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Jagan Teki <jagan@amarulasolutions.com>,
 "Michael Walle" <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Pratyush Yadav
 <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories
 support in QSPI driver"
In-Reply-To: <33e99705-77e3-4acf-95f7-fad65f60ae62@mailbox.org>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <b9cb3ec8-b6f2-4f38-8cda-d3d10278f503@amd.com>
 <e9929e0c-aa43-428f-8bf7-7b4cdef0e9c3@mailbox.org>
 <86v7x05fyd.fsf@udb0321960.dhcp.ti.com>
 <edcec18f-75a0-44d8-907a-f042779ca6ee@mailbox.org>
 <86ses458k3.fsf@udb0321960.dhcp.ti.com>
 <f7bb335d-681a-4b60-92f6-b605cc6f477f@mailbox.org>
 <86pln759j9.fsf@udb0321960.dhcp.ti.com>
 <33e99705-77e3-4acf-95f7-fad65f60ae62@mailbox.org>
Date: Mon, 11 Nov 2024 08:18:20 -0600
Message-ID: <86ldxp6ehf.fsf@udb0321960.dhcp.ti.com>
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

> On 11/7/24 4:49 PM, Jon Humphreys wrote:
>> Marek Vasut <marek.vasut@mailbox.org> writes:
>> 
>>> On 11/6/24 10:58 PM, Jon Humphreys wrote:
>>>> Marek Vasut <marek.vasut@mailbox.org> writes:
>>>>
>>>>> On 11/6/24 8:18 PM, Jon Humphreys wrote:
>>>>>> Marek Vasut <marek.vasut@mailbox.org> writes:
>>>>>>
>>>>>>> On 10/23/24 10:17 AM, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/22/24 23:06, Marek Vasut wrote:
>>>>>>>>> This reverts commit 1e36d34b52e7a1ebe5a2a5339d6905540f4253aa.
>>>>>>>>>
>>>>>>>>> This parallel/stacked support breaks basic SPI NOR support,
>>>>>>>>> e.g. this no longer works:
>>>>>>>>>
>>>>>>>>> => sf probe && sf update 0x50000000 0 0x160000
>>>>>>>>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB,
>>>>>>>>> total 64 MiB
>>>>>>>>> device 0 offset 0x0, size 0x160000
>>>>>>>>> SPI flash failed in read step
>>>>>>>>
>>>>>>>> Reverting everything seems to me too much. Tom has tested it on his HW
>>>>>>>> and didn't see any issue. That's why better to look at code which is
>>>>>>>> causing this.
>>>>>>>> You are reverting everything but likely there is specific patch which is
>>>>>>>> causing this. Which one is it?
>>>>>>>> Which board was used for your testing? Likely we don't have access to it.
>>>>>>>> Is there any QEMU available which can be used for debugging?
>>>>>>>
>>>>>>> The testcase including the exact SPI NOR model is above.
>>>>>>>
>>>>>>> iMX6 with w25q16dw seems to be broken too.
>>>>>>>
>>>>>>> Basically every board I have access no longer has a working "sf probe ;
>>>>>>> sf update" combination ... so yeah, this means this patchset is
>>>>>>> fundamentally broken.
>>>>>>>
>>>>>>
>>>>>> I can also confirm that the patch series:
>>>>>>
>>>>>> f8efc68b30e Merge patch series "spi-nor: Add parallel and stacked memories
>>>>>> support"
>>>>>>
>>>>>> breaks SPI NOR on TI platforms, particularly SK-AM62 and SK-AM62P:
>>>>>>
>>>>>> U-Boot 2024.10-00752-gf8efc68b30e2 (Nov 06 2024 - 12:25:13 -0600)
>>>>>>
>>>>>> SoC:   AM62X SR1.0 HS-FS
>>>>>> Model: Texas Instruments AM625 SK
>>>>>> ...
>>>>>> Hit any key to stop autoboot:  0
>>>>>> => sf probe && sf update ${loadaddr} 0x400000 0x10
>>>>>> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>>>>>> device 0 offset 0x400000, size 0x10
>>>>>> SPI flash failed in read step
>>>>>> =>
>>>>> Sigh ... can you please test current u-boot/master and see if the error
>>>>> is fixed there ?
>>>>>
>>>>
>>>> Yes I had verified it also fails against master, although the behavior was
>>>> a bit different.  The .'s below are our DMA engine waiting indefinitely.
>>>>
>>>> => sf probe && sf update ${loadaddr} 0x400000 0x10
>>>> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>>>> device 0 offset 0x400000, size 0x10
>>>> .....................................................
>>>>
>>>> I have not investigated further.
>>>
>>> Can you try and run some 'git bisect' to find out exactly which commit
>>> broke your use case ? There is a bunch of fixes for the worst breakage
>>> that landed recently, but clearly there is more.
>>>
>>> Full revert seems increasingly appealing ...
>> 
>> commit 5d40b3d384d
> So there is still something broken in that specific commit that I missed 
> when removing the defects ? Sigh ... can you try to narrow it down ?

Hi Marek, I tried to narrow the changes in commit
5d40b3d384dc536ec26ce9b76b20b0b84749d2d1 a bit by first applying all of the
changes in the .h files, and then for spi-nor-core.c, only applying changes
per function. The only function change that causes errors was
spi_nor_read(). With the changes in spi_nor_read() in commit
5d40b3d384dc536ec26ce9b76b20b0b84749d2d1 applied to the prior commit
fbe16bc2801, did I get:

=> sf probe && sf update ${loadaddr} 0x400000 0x10
SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
device 0 offset 0x400000, size 0x10
SPI flash failed in read step

Let me know if this helps.  

Jon
