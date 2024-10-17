Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC35D374A2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AE288FF6;
	Thu, 17 Oct 2024 16:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729176395;
	bh=IXbuOsXVy2AtTOJbC6/ZPKfjhJeGAIZHWvJ2MuxlY4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAn4qvF8AZ21PMe+7GPjiHJCYVbbyU+uywGrVN9OIlgig39WEQZRtyAO0dM8koDNJ
	 3I+8DedYXisgRdL4yvCrDFPImntxFOgrrcQV/MYQ5OC8sG9qReL/nrB50Mn7oDy+bX
	 TSs07aHqyyYF0/W5BsmlEKvQebagbFgAR9dbyX2+Cg2VV7qOx+e96PIZhDDxUQZIlt
	 QZqMFhGCHNY2OJ4UYaqFjD5Q6g+EWQI2edTHTiHZYswGx44cceCPz1OmHPT3CSQh3e
	 jJnOUeKwFAkwW87gFk1Rqa+P3Lix6Yy/UlH2yIegn8tlJE3DgYElh37YVYtDdNeP9d
	 Q/qb5hlyej+EQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB11F88FD8;
 Thu, 17 Oct 2024 16:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729176392;
 bh=IXbuOsXVy2AtTOJbC6/ZPKfjhJeGAIZHWvJ2MuxlY4U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LwdiKTassyuHf9aStSji7nasG6roYUzxzkmOGAsERT4F19n3VzN7c7Rc+7xgu8yjU
 VWORE3qFBujEahelBOhnTKkcwgsmJGsIwyE42RqPKr828C9QRUazSJxJMXiuEQPw2m
 hsFQPmyrp/G02wF+iioGI96yRZKwur1UrAixfQjT2v+DSiDOyiTcvZ5GpvtM/OvPlt
 VfsrjCmQD5TAhOZNwYJuM8HC5RChjUsMJyOkpvy0t8yNa78qfVIE46RZZpbYO9m9yq
 5ZTHaKwMZ2aabqQn2NWL1uVq5GHOLFJx4IdoWz8J86684lqINImZdV40w0iKXBawiH
 Xa0S441UQkx+Q==
Message-ID: <1aacbaa2-6ea7-4669-8e48-02fc0d5a3376@denx.de>
Date: Thu, 17 Oct 2024 16:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
 <62b02b850c194dc080684db8d00cf413@dh-electronics.com>
 <504ec0bf-c3be-4663-ac79-1f8a332d8232@denx.de>
 <02e526c3714e46ec88432ac2d1f38bfb@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <02e526c3714e46ec88432ac2d1f38bfb@dh-electronics.com>
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

On 10/17/24 1:09 PM, Christoph Niedermaier wrote:
> From: Marek Vasut <marex@denx.de>
> Sent: Wednesday, October 16, 2024 2:16 PM
>> On 10/16/24 1:57 PM, Christoph Niedermaier wrote:
>>> From: Marek Vasut <marex@denx.de>
>>> Sent: Saturday, October 12, 2024 10:43 PM
>>>> On 10/10/24 3:23 PM, Christoph Niedermaier wrote:
>>>>> The i.MX8M Plus DHCOM currently supports parsing ethernet MAC address
>>>>> from multiple sources in the following priority order:
>>>>>
>>>>> 1) U-Boot environment 'ethaddr'/'eth1addr' environment variable
>>>>> 2) SoC OTP fuses
>>>>> 3) On-SoM EEPROM
>>>>>
>>>>> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
>>>>> which contains additional write-lockable page, which can also be
>>>>> populated with a structure containing ethernet MAC address.
>>>>>
>>>>> Add support for parsing the content of this new write-lockable page
>>>>> and place it between 2) and 3) on the priority list. The new entry is
>>>>> 2.5) On-SoM EEPROM write-lockable page
>>>>>
>>>>> Because the write-lockable page is not present on rev.100 i.MX8MP DHCOM
>>>>> SoM, test whether EEPROM ID page exists in DT and whether it is enabled
>>>>> first. If so, read the entire ID page out, validate it, and determine
>>>>> whether EEPROM MAC address is populated in it in DH specific format. If
>>>>> so, use the MAC address. There may be multiple EEPROMs with an ID page
>>>>> on this platform, always use the first one.
>>>>>
>>>>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>>>>> ---
>>>>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>> Cc: Fabio Estevam <festevam@gmail.com>
>>>>> Cc: Stefano Babic <sbabic@denx.de>
>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>> Cc: u-boot@dh-electronics.com
>>>>> ---
>>>>>     board/dhelectronics/common/dh_common.c        | 113 ++++++++++++++++++
>>>>>     board/dhelectronics/common/dh_common.h        |  23 ++++
>>>>>     .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |   6 +
>>>>>     3 files changed, 142 insertions(+)
>>>>>
>>>>> diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
>>>>> index 32c50b4f0f..8ea70fc984 100644
>>>>> --- a/board/dhelectronics/common/dh_common.c
>>>>> +++ b/board/dhelectronics/common/dh_common.c
>>>>> @@ -7,9 +7,22 @@
>>>>>     #include <dm.h>
>>>>>     #include <i2c_eeprom.h>
>>>>>     #include <net.h>
>>>>> +#include <u-boot/crc.h>
>>>>>
>>>>>     #include "dh_common.h"
>>>>>
>>>>> +struct eeprom_id_page {
>>>>> +     u8      id[3];          /* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
>>>>> +     u8      version;        /* 0x10 -- Version 1.0 */
>>>>> +     u8      data_crc16[2];  /* [1] is MSbyte */
>>>>> +     u8      header_crc8;
>>>>> +     u8      mac0[6];
>>>>> +     u8      mac1[6];
>>>>> +     u8      item_prefix;    /* H/F is coded in MSbits, Vendor coding starts at LSbits */
>>>>> +     u8      item_num[3];    /* [2] is MSbyte */
>>>>> +     u8      serial[9];      /* [8] is MSbyte */
>>>>> +} __packed;
>>>>
>>>> Is __packed needed ?
>>>
>>> I want to avoid padding in any case.
>> Every single field is u8, do you observe any padding ?
> 
> In this case, I don't expect padding, but if the struct is extended,
> padding could be possible.

Please add the padding only once it is really required, ideally the 
design of the structure or its extension(s) would be able to avoid such 
necessity altogether.

> This struct is for an EEPROM and therefore
> it should be defined with no padding. I don't want to give the compile
> the change to add padding if something changed in the struct.
> What are the disadvantages of keeping __packed here?
If it is unnecessary, then please remove it, there is no good 
justification for packing a structure which is naturally aligned already.
