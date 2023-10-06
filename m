Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325AEE92FF9
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 08:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1BF86CE7;
	Fri,  6 Oct 2023 10:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UPzWllj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05C686D17; Fri,  6 Oct 2023 10:43:57 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A008B868BB
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 10:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3968hpTV026952;
 Fri, 6 Oct 2023 03:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696581832;
 bh=jkk7ENtgj8oEUIxA6qgvzdZM6xgFVmoQ4eJkEJxpRxA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UPzWllj2ZfWlHrsFJlSeGJzBXQdJ/5fmAtXmmuziGGfdujq7hdbAsiMWgKEOzKvHb
 isJthfljJCuluWIQa4fPfZdWN2iCxVCwQb9rVDRXjaE5+72pPkH3V/kmR938TcFvNH
 aYxPiKuwzuwFphKtZ21Nz2qfvMP1dGUKvHvvbrP8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3968hpIH015718
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Oct 2023 03:43:51 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 03:43:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 03:43:51 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3968hmGf117302;
 Fri, 6 Oct 2023 03:43:49 -0500
Message-ID: <31170828-a7d6-49d9-919c-5795fc17f67b@ti.com>
Date: Fri, 6 Oct 2023 14:13:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <trini@konsulko.com>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, 
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-nandan@ti.com>
References: <20230927040751.622194-1-n-francis@ti.com>
 <20230927040751.622194-2-n-francis@ti.com>
 <CAPnjgZ2jiWVDpcW9LaMMNOkVoueaUm0GWftE67qXbxSwjwJjYw@mail.gmail.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAPnjgZ2jiWVDpcW9LaMMNOkVoueaUm0GWftE67qXbxSwjwJjYw@mail.gmail.com>
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

Hi Simon

On 02/10/23 06:46, Simon Glass wrote:
> Hi Neha,
> 
> On Tue, 26 Sept 2023 at 22:08, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> According to the TRMs of K3 platform of devices, the ROM boot image
>> format specifies a "Core Options Field" that provides the capability to
>> set the boot core in lockstep when set to 0 or to split mode when set
>> to 2. Add support for providing the same from the binman DTS. Also

[...]

>>           self.content = fdt_util.GetPhandleList(self._node, 'content-sbl')
>>           input_data_sbl = self.GetContents(required)
>> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
>> index d028cfe38c..fc0bb12278 100644
>> --- a/tools/binman/etype/x509_cert.py
>> +++ b/tools/binman/etype/x509_cert.py
>> @@ -136,7 +136,8 @@ class Entry_x509_cert(Entry_collection):
>>                   imagesize_sysfw_data=self.imagesize_sysfw_data,
>>                   hashval_sysfw_data=self.hashval_sysfw_data,
>>                   sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
>> -                dm_data_ext_boot_block=self.dm_data_ext_boot_block
>> +                dm_data_ext_boot_block=self.dm_data_ext_boot_block,
>> +                bootcore_opts=self.bootcore_opts
> 
> When you add args to a function, please update the function comment.
> 

Before sending out the next version, just wanted to mention that this was a 
function call, the function comment has already been updated in 
tools/binman/btool/openssl.py

-- 
Thanking You
Neha Malcom Francis
