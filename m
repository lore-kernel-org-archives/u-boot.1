Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E3BC30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4C588581;
	Fri, 28 Jun 2024 19:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hpsLv3xG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AAA8806A; Fri, 28 Jun 2024 16:10:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F56A87FEE
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 16:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebin.francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SE9vpt112685;
 Fri, 28 Jun 2024 09:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719583797;
 bh=pJQ/zou2ejjECj+X2QWETNKvnmzSZWAkF9/GkLCNIsk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hpsLv3xGoBo8mwu9agRUoP8JmYHjNegXyoN7ED4vp9voRgDijXppizbNX0i9/ku8t
 FWnLwKzYFw8aNptp0Umj2GJmW+O9dEOP2GdtlNeaH8ph5/J3S7b4nLfekbnCs9jLEy
 BgGTbeaMYc0HRsKrIWX9ygaanvOXzBxiK4tclFc0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SE9vrr013407
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 09:09:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 09:09:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 09:09:56 -0500
Received: from [10.24.69.195] (shark.dhcp.ti.com [10.24.69.195])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SE9rx2001435;
 Fri, 28 Jun 2024 09:09:53 -0500
Message-ID: <067d0bd4-867f-4d48-8852-f5d8e04ffc2a@ti.com>
Date: Fri, 28 Jun 2024 19:39:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/4] Low Power Mode: Pakage TIFS Stub on BeaglePlay
To: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
References: <20240628093252.1864609-1-d-gole@ti.com>
 <20240628130323.vxy7rruh3bdcklxe@brownnose>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20240628130323.vxy7rruh3bdcklxe@brownnose>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 28 Jun 2024 19:24:28 +0200
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


On 28/06/24 18:33, Nishanth Menon wrote:
> On 15:02-20240628, Dhruva Gole wrote:
>> This series includes the binman related changes required to package tIFS
>> Stub to support Low Power Modes on BeaglePlay.
>> Also, based on comments from previous patch [0] documentation has been
>> added to describe small addition in boot flow as well as tispl image
>> format.
>>
>> I am aware that the new boot flow image will need to be updated in
>> other places like am62a, am62p and even other boards that use am62x.
>> However, I would like to keep this series beagleplay TIFSStub specific
>> and so I will be sending a follow up series to update other places
>> seperately if that's ok.
>>
>> Changelog:
>> * Add new image format for TISPL
>> * Add new changes in boot flow for am62 family of devices.
>>
>> [0] https://lore.kernel.org/u-boot/20240618045610.271884-1-d-gole@ti.com/
>>
>> Dhruva Gole (4):
>>    arm: dts: k3-am625-beagleplay: Package TIFS Stub
>>    doc: beagle: am62x_beagleplay: Update the boot flow to show TIFS Stub
>>    doc: beagle: am62x_beagleplay: Add TIFS Stub in image format
>>    doc: ti: k3: Add TIFS Stub documentation
>>
>>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
>>   doc/board/beagle/am62x_beagleplay.rst        |  4 +--
>>   doc/board/ti/img/boot_diagram_am62.svg       |  4 +++
>>   doc/board/ti/img/tifsstub_dm_tispl.bin.svg   |  4 +++
>>   doc/board/ti/k3.rst                          |  5 +++
>>   5 files changed, 47 insertions(+), 3 deletions(-)
>>   create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
>>   create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg
>
> Maybe you can help clarify a bit. I understand from [1]
> that you are betting on timing to keep tifs stub safe. But then, why
> not plug in this firmware blob along with DM itself? that allows DM
> to manage itself the way it wants to and control it's own memory map?
> DM initialization itself takes a few ms, just because TFA is not
> touching any part of DDR does not mean that we can assume system is
> interference free, no? What if DM architecture changes such that PLL
> initialization or some other long pole item is performed prior to
> loading the tifs stub?


In Linux DT the address space in which FS stub is copied is part of DM 
firmware carve-out in DDR,
so if fs stub can get corrupted then DM also can get corrupted.

Regards
Sebin

>
> [1] https://lore.kernel.org/u-boot/20240621054337.qqjftv72ofiinlhv@dhruva/
>
