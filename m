Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A6C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 05:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF1C87032;
	Tue,  5 Dec 2023 06:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rZroSD+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD468757E; Tue,  5 Dec 2023 06:27:20 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF02186F6F
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 06:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B55RC9J110700;
 Mon, 4 Dec 2023 23:27:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701754032;
 bh=ApgGcRGzYWpV1u2YrIIs2IkQaEXWdY6VwTBLrvvgcqc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=rZroSD+82D6epXgOG+5TBe8IbdXU1nM/QdEJTtywi5J8WQeRKYNnQMt1KlEBBsMcc
 zAsqAKoaTZ5BCq2klN4tqIFwl+QilNZQbZp1CIhOduWWdVyyU/IW3+xMQk3djxHgRl
 MZTtRuysR+xi9zYV2RHLzVYB8At6oO/nCt7G6EKE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B55RCGD047984
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 23:27:12 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 23:27:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 23:27:11 -0600
Received: from [172.24.227.68] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B55R99O016520;
 Mon, 4 Dec 2023 23:27:09 -0600
Message-ID: <422e60a8-7118-4ecc-9490-1f8274ae16f2@ti.com>
Date: Tue, 5 Dec 2023 10:57:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] docs: AM62x: Remove SW_PRNG Flag for OPTEE
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Kamlesh <kamlesh@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Wadim Egorov <w.egorov@phytec.de>
References: <20231201102954.47582-1-d-gole@ti.com>
 <20231204193031.57p64bitdb7agoh7@client>
Content-Language: en-US
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20231204193031.57p64bitdb7agoh7@client>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth,

On 05/12/23 01:00, Nishanth Menon wrote:
> On 15:59-20231201, Dhruva Gole wrote:
>> The CFG_WITH_SOFTWARE_PRNG option was needed once when there were some
>> issues with system crashes/ hangs after a suspend-resume cycle. However
>> this seems to no longer be the case with newer firmwares, and this
>> config is not needed for basic boot support of the SoC either, hence
>> remove it from the docs.
>>
>> Cc: Kamlesh <kamlesh@ti.com>
>> Cc: Vibhore Vardhan <vibhore@ti.com>
>> Cc: Wadim Egorov <w.egorov@phytec.de >>
>> Dhruva Gole (2):
>>    doc: board: beagle: am62x_beagleplay: Delete SW_PRNG flag for OPTEE
>>    doc: board: ti: am62x_sk: Remove SW_PRNG Flag for OPTEE
>>
>>   doc/board/beagle/am62x_beagleplay.rst | 1 -
>>   doc/board/ti/am62x_sk.rst             | 1 -
>>   2 files changed, 2 deletions(-)
>>
> 
> NAK to the series. RNG seed is needed for KASLR. either enable h/w RNG

@Wadim: Please take note and ignore my previous suggestion to you to
remove this line, keep this line as is.

> or at least enable S/W RNG in OPTEE.
> 

Agreed, I will send a patch to use HWRNG later on then. For now let's
just keep the PRNG enabled in these docs.


-- 
Thanks and Regards,
Dhruva Gole
