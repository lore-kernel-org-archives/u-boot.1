Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F8CF8852
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 00:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757FD88F4E;
	Sat,  5 Oct 2024 02:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728086978;
	bh=OXIvlpLgZIZoSLge8h04Mu5hEaHCLEnFmlmc/2dv74c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPgG0shNJZ4v9gubPt5EvnIrdBND5CkOp32rU2OJvWllIP0rV4Z7BZVaP/y9p6ut9
	 +c4hS+yiXW16bft9iU6AtpjH9D69986DpVHTt4ErEOlWqtKsSMp7v5pXKlapZd6pya
	 DVbz0aP1iUxNziQyr5Tg26CbIARLkRZYsfrrC7ZzCJt2qM6crTxa+Dfoe6RSpVnPGH
	 sFwUcKEl2VGXYjnrliY8EtfDA/8EyyJUCYOK7mWioSvs7i+1tHuhWiC6mnIE3m9hTC
	 dp4NMkynnB1ddETKptyCeGElMxH7imEv0bplwZErHUoF0k4PneX8LjbeCgARcFSK7y
	 NnGBKgGctiQ4A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8895688DB2;
 Sat,  5 Oct 2024 02:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728086977;
 bh=OXIvlpLgZIZoSLge8h04Mu5hEaHCLEnFmlmc/2dv74c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kKpfOHdcQ+wqmKWCL55tGcfWEGw65RaHDZqLEaUq+eaO36B9lMcvqXkGsiyMfeSXt
 3H3gAPM0NIIcOBT0GnRurC8kWb0P76tp0mirdenEs5VV2BKuOpxZKNuqUw/uU37LZU
 k0x6XkqEKo1dT/mCNOOCOzUqy0nzLzTM1DGvt8sykbWoDlOzPH0IS32HkMRPWVmZ2V
 7RnDYLYYnWw8ZDfHqxpsVgAqSvTmihgSTW2C04nBmAlvN+sJIRbMUN41FzO96uwr+M
 N9vWG0Avdu+XfVpkWwUDJUdesdkxmK3EwssNL9kp2H3Xe0e7BAnqXrNhjbTCasGXGt
 LOuXVQeXTSIug==
Message-ID: <d6c5d0bf-0fbf-4312-94be-8f6acc999e7d@denx.de>
Date: Sat, 5 Oct 2024 01:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Update MAINTAINERS file globs for STM32MP
 DHSOM
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241004215213.252840-1-marex@denx.de>
 <20241004221421.GK4737@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241004221421.GK4737@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/5/24 12:14 AM, Tom Rini wrote:
> On Fri, Oct 04, 2024 at 11:51:46PM +0200, Marek Vasut wrote:
>> Update the MAINTAINERS file glob to cover all of STM32MP DHSOM related files.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   board/dhelectronics/dh_stm32mp1/MAINTAINERS | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/board/dhelectronics/dh_stm32mp1/MAINTAINERS b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
>> index 865588f5b8b..d6c33c15aac 100644
>> --- a/board/dhelectronics/dh_stm32mp1/MAINTAINERS
>> +++ b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
>> @@ -2,8 +2,7 @@ DH_STM32MP1_PDK2 BOARD
>>   M:	Marek Vasut <marex@denx.de>
>>   L:	u-boot@dh-electronics.com
>>   S:	Maintained
>> -F:	arch/arm/dts/stm32mp15xx-dhcom*
>> +F:	arch/arm/dts/stm32mp*dhco*
>>   F:	board/dhelectronics/dh_stm32mp1/
>> -F:	configs/stm32mp15_dhcom_basic_defconfig
>> -F:	configs/stm32mp15_dhcor_basic_defconfig
>> +F:	configs/stm32*_dhco*defconfig
>>   F:	include/configs/stm32mp15_dh_dhsom.h
> 
> Do you want to try the "N:	some-regex" syntax to see if that makes
> it less likely to regress in the future? If not, this is fine.
Fixed in V2
