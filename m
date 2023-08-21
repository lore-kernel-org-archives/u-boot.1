Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4A1EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C046486E80;
	Mon, 21 Aug 2023 15:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j7LzaeTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F386A8708E; Mon, 21 Aug 2023 15:57:40 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98E786813
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37LDvTNV060351;
 Mon, 21 Aug 2023 08:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692626249;
 bh=RB09AM5bg8cSmMfoM11OO/R4yQIL6EPGd1Ah90+etbo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=j7LzaeTS2J/UtO3lEYQTMA5ksqQxpYoPjgxS+5t1NZ0zNCHcAefyLh5J7rEnH3SAU
 GVebdyt67EKFrML64MpvCgGuDRwT+QG30CLpjP2m+TeMKImCUE5Vj4wxWfbb6dbw2k
 3OtWsr8jy5ukHyE7B4sqfq0wVqjRYTrId0kRFjqk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37LDvTXm087912
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Aug 2023 08:57:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 08:57:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 08:57:29 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37LDvSmo053375;
 Mon, 21 Aug 2023 08:57:28 -0500
Message-ID: <870ff0af-bc73-5ff0-ecac-848ebb3e01c1@ti.com>
Date: Mon, 21 Aug 2023 08:57:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Dropping CONFIG_SCSI
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Mingkai Hu
 <mingkai.hu@nxp.com>, Andre Przywara <andre.przywara@arm.com>, Mario Six
 <mario.six@gdsys.cc>
References: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
 <20230820175915.GR1515023@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230820175915.GR1515023@bill-the-cat>
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

On 8/20/23 12:59 PM, Tom Rini wrote:
> On Sun, Aug 20, 2023 at 11:49:21AM -0600, Simon Glass wrote:
>> Hi,
>>
>> The deadline has passed for the non-driver model SCSI code. The boards
>> below still have this enabled:
>>
>> $ ./tools/moveconfig.py -f SCSI ~DM_SCSI
>> controlcenterdc am57xx_hs_evm_usb ls1088ardb_sdcard_qspi_SECURE_BOOT
>> ls1046ardb_sdcard_SECURE_BOOT ls1021atsn_qspi ls1021atsn_sdcard
>> highbank ls1021atwr_sdcard_ifc_SECURE_BOOT
>>
>> Please can you take a look at migration?
> 
> Looking at am57xx_hs_evm_usb this is just a case where one of the
> configs is out of sync with the rest as am57xx_evm and am57xx_hs_evm set
> DM_SCSI.  Andrew, it might be worth looking at dropping
> am57xx_hs_evm_usb specifically and adding a config fragment under
> board/ti/am57xx/ for just the (I assume) SPL via USB case. And
> dra7xx_evm can mirror that as well.
> 

Yes, looks like several of the TI _hs_ configs have gotten out of sync again.

With this new config fragment stuff might be time to drop *all* the HS
defconfigs and add HS fragments..

I'll look into that, in the meantime sending a patch now to sync this one
missing config option.

Andrew
