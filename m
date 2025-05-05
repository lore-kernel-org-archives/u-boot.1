Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D19C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E4D828BC;
	Mon,  5 May 2025 14:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="b5g0YQSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000708291D; Mon,  5 May 2025 14:44:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C061880F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5457lFkb010664;
 Mon, 5 May 2025 14:44:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 lParGN2kDvlV7W9dHBrxbT2FAB+u2Zsm0uNA21Tv1d0=; b=b5g0YQSWy8iF3RPi
 vaeRnBFiu3w1FGfTGgYbWJjvi1j4mkeeSRzrvMaOUaHVgl6PQsZu0A/RgxmyJaK9
 Sep1J8PYxPNA48d5sCrCu2Hog0ez7+swzJohvKcrVvikjhmkHWp4U/Em1oGe2j9P
 ngld7EN67D1RgEN+9ntKYCnPhojfIt302nO+/QN3aEgp2V0v3HYdyCXm0i+ZQoKh
 2RusBxZsvOviqXEr4zS70zCkScmWLsJ07BcQ/0Y55AzfMQSGXbTDopU+CsxUHSF3
 SZWcZMtzT6zGhnRpVTzziEzqfGF2XueU/eNCqYM2j1bJgB8IK4zLHvr9S57cvnQr
 ewwx2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbkq6pm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 14:44:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 26B5940052;
 Mon,  5 May 2025 14:43:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89EA9AB4FE8;
 Mon,  5 May 2025 14:42:59 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 14:42:59 +0200
Message-ID: <d5ceda58-bc44-4f60-b4e0-bb711f2688ea@foss.st.com>
Date: Mon, 5 May 2025 14:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] config_distro_bootcmd: make possible to
 substitute 'part list' in distro_bootcmd
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Pascal Zimmermann <pzimmermann@dh-electronics.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, <u-boot@dh-electronics.com>
References: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
 <20250327143843.19358-2-pzimmermann@dh-electronics.com>
 <696564cc-4159-4f1c-8f4f-54332b9022bd@foss.st.com>
Content-Language: en-US
In-Reply-To: <696564cc-4159-4f1c-8f4f-54332b9022bd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-05-05_01,2025-02-21_01
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



On 4/11/25 09:15, Patrice CHOTARD wrote:
> 
> 
> On 3/27/25 15:38, Pascal Zimmermann wrote:
>> Make it possible to substitute the 'part list' command inside
>> 'scan_dev_for_boot_part' with a custom board specific implementation.
>>
>> For this the new define 'SCAN_DEV_FOR_BOOT_PARTS' is introduced.
>>
>> Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
>> ---
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: u-boot@dh-electronics.com
>> ---
>>  include/config_distro_bootcmd.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
>> index 0a4e4b8ff85..df0dc8cfdee 100644
>> --- a/include/config_distro_bootcmd.h
>> +++ b/include/config_distro_bootcmd.h
>> @@ -194,6 +194,11 @@
>>  #define SCAN_DEV_FOR_EFI
>>  #endif
>>  
>> +#ifndef SCAN_DEV_FOR_BOOT_PARTS
>> +#define SCAN_DEV_FOR_BOOT_PARTS \
>> +	"part list ${devtype} ${devnum} -bootable devplist; "
>> +#endif
>> +
>>  #ifdef CONFIG_SATA
>>  #define BOOTENV_SHARED_SATA	BOOTENV_SHARED_BLKDEV(sata)
>>  #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV
>> @@ -538,7 +543,7 @@
>>  		"\0"                                                      \
>>  	\
>>  	"scan_dev_for_boot_part="                                         \
>> -		"part list ${devtype} ${devnum} -bootable devplist; "     \
>> +		SCAN_DEV_FOR_BOOT_PARTS                                   \
>>  		"env exists devplist || setenv devplist 1; "              \
>>  		"for distro_bootpart in ${devplist}; do "                 \
>>  			"if fstype ${devtype} "                           \
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Hi Pascal

Applied to u-boot-stm32/master

Thanks
Patrice


> 
> Thanks
> Patrice
