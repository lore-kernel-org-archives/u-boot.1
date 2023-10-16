Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23783CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E4C86DD5;
	Mon, 16 Oct 2023 16:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467528;
	bh=kDfnHp9c0YWChx9RsY/d0R1fU5eMT9tBpx+AOh/nlmI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+p0YJAnh+u3QJ9YUE0D2cgpdLTpZt8Z9fAepAt3xAUqzooDnNys4czjVm9fz1dON
	 8YS2TP7AlUQuBMrSNYFtQojqF182p4FPEhouEETktk7y/yybE5VgBffTAHrjz54J23
	 XnaeihB7LSO0l91YfA72SBYAhiX51/Z3+GOzb+DOYJF6ReubYcrRg+PObo4/aRHW3E
	 A+QJgeCSn5lWvQ26t5/bJZqr8SDzhRAyyIbrCNjvEZCa1T6GWuunIuznB4x+MVJHdV
	 tSU/WICn5FL900ffHWMwpW7Mh4/SI3DCY8uVFFXF/lcaAV4RdIOTNDUzbSYlDW6//6
	 4+ezpeHX9f68g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D6C86F0F; Mon, 16 Oct 2023 16:45:24 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B754C863FD
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S8Kf72zCtz9slp;
 Mon, 16 Oct 2023 16:45:19 +0200 (CEST)
Message-ID: <c83764d3-68f9-478a-ad0a-cb7c4144eb78@denx.de>
Date: Mon, 16 Oct 2023 16:45:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: AC5/AC5X: Disable SMBIOS
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20231013030016.3307423-1-judge.packham@gmail.com>
 <af2b90a8-72a6-4360-baea-643098a5d4b6@denx.de>
In-Reply-To: <af2b90a8-72a6-4360-baea-643098a5d4b6@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/16/23 11:02, Stefan Roese wrote:
> On 10/13/23 05:00, Chris Packham wrote:
>> The RD-AC5X doesn't make use of EFI or SMBIOS. Recently we started seeing
>> boot failures such as
>>
>>      WARNING: SMBIOS table_address overflow 27f60f020
>>      Failed to write SMBIOS table
>>      initcall failed at event 10/(unknown) (err=-22)
>>      ### ERROR ### Please RESET the board ###
>>
>> The error is because the physical address of the RAM on the AC5X SoC is
>> above the 32GiB boundary. As we don't need SMBIOS or EFI this can be
>> safely disabled.
>>
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>> This probably should have been part of the series I sent as
>> https://lore.kernel.org/u-boot/20231003035800.2626121-1-judge.packham@gmail.com/
>> but I didn't have the RD-AC5X board at the time. There is another issue
>> that's stopping the RD-AC5X board from booting with current master but
>> with the suspect commit reverted you can see the same SMBIOS issue I was
>> seeing on the x240.
>>
>>   configs/mvebu_ac5_rd_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/mvebu_ac5_rd_defconfig 
>> b/configs/mvebu_ac5_rd_defconfig
>> index dbf1e3136cdf..e8fa22b648be 100644
>> --- a/configs/mvebu_ac5_rd_defconfig
>> +++ b/configs/mvebu_ac5_rd_defconfig
>> @@ -85,3 +85,4 @@ CONFIG_USB_ETHER_ASIX88179=y
>>   CONFIG_USB_ETHER_MCS7830=y
>>   CONFIG_USB_ETHER_RTL8152=y
>>   CONFIG_USB_ETHER_SMSC95XX=y
>> +# CONFIG_SMBIOS is not set
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
