Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E1CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F263386D5E;
	Tue, 17 Oct 2023 11:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SMbF9FP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA0986D5E; Tue, 17 Oct 2023 11:58:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F6A86BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39H9wLkr127226;
 Tue, 17 Oct 2023 04:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697536701;
 bh=5m7eIxBCh2lRMN8K5W8w6xI9lBMsHXFwEMsqYEZ9EHk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SMbF9FP0QCymY00iXqfmcpCApufJH3guQ9JrDPBiaDjIdlHA2tjBFXeQr0yqY5uKg
 vhWYgeANgHxKbvP5eOjXz+XUCHWp9TWzw7zBkccC0HG5u8+GYMeO/b4khrlzkr9/Av
 JLMp03fr7Y/hsvFtSVibiD47haNrtEKXxCL2g+LE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39H9wLQf073223
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Oct 2023 04:58:21 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 04:58:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 04:58:21 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39H9wI0P034634;
 Tue, 17 Oct 2023 04:58:19 -0500
Message-ID: <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
Date: Tue, 17 Oct 2023 15:28:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <trini@konsulko.com>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, 
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-nandan@ti.com>
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
 <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
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

On 08/10/23 04:39, Simon Glass wrote:
> Hi Neha,
> 
> On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> According to the TRMs of K3 platform of devices, the ROM boot image
>> format specifies a "Core Options Field" that provides the capability to
>> set the boot core in lockstep when set to 0 or to split mode when set
>> to 2. Add support for providing the same from the binman DTS. Also
>> modify existing test case for ensuring future coverage.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
>> Section 4.5.4.1 Boot Info
>>
>> Changes in v3:
>>          - updated function comments
>>          - removed inconsistency in setting bootcore_opts to 32
>>
>> Changes in v2:
>>          - included TRM link in commit message
>>
>>   tools/binman/btool/openssl.py           |  6 ++++--
>>   tools/binman/entries.rst                |  1 +
>>   tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
>>   tools/binman/etype/x509_cert.py         |  3 ++-
>>   tools/binman/test/297_ti_secure_rom.dts |  1 +
>>   5 files changed, 17 insertions(+), 5 deletions(-)
>>

[...]

>> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
>> index d1313769f4..1a3eca9425 100644
>> --- a/tools/binman/test/297_ti_secure_rom.dts
>> +++ b/tools/binman/test/297_ti_secure_rom.dts
>> @@ -9,6 +9,7 @@
>>          binman {
>>                  ti-secure-rom {
>>                          content = <&unsecure_binary>;
>> +                       core-opts = <2>;
> 
> here ^
> 
> Do you think there could be a binding file in dt-bindings/ for this value?
> 

Sorry for getting back to this patch so late, but wanted to ask about this. I 
had seen a last version of getting the binman compatible in dt-bindings but I 
don't see it merged. Not sure where I would add this property in.

>>                  };
>>                  unsecure_binary: blob-ext {
>>                          filename = "ti_unsecure.bin";
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon

-- 
Thanking You
Neha Malcom Francis
