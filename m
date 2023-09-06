Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE6EB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 11:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 001D9865A3;
	Wed,  6 Sep 2023 13:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EHAep4+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1460D86625; Wed,  6 Sep 2023 13:28:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCDE833DE
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 13:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87F863F460
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693999698;
 bh=pwrTPHU/fJcbnESZlmtwEYaGOQnsEFsiMMPKF2rYn24=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EHAep4+H+T9uxmed1chv7P8OjbVjEcAHfJmIA7+6nREMhlMVAQTkUXBfwfORMi54/
 qfV7egZ/n+609wXB+Rlvs9yJVFB2aiYVOL1TNTu9VDgCIZLPKf+X6C+4l6ZHhmHUzx
 ptGeY4fI1cjmyvVH4qyGncxVrMpVCv5OhOWTENDn9Qt4SWasTN6hVYGN766TUwxGLt
 TKA0bvLVXXfzDxQe0Po7HmOLFibtSADvzwRNFe4jwJoVWC4AEfoOYZbTJg18Lw0j3D
 FQregPvtVKK5aSsmc2BX2U40xfDUapgnfjJaOqIrjYgGmSKkeKGaDcyrFStzOJbunT
 NzMReMrBKtk1Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so22838995e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 04:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693999698; x=1694604498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pwrTPHU/fJcbnESZlmtwEYaGOQnsEFsiMMPKF2rYn24=;
 b=h2A6SE67s+GyoiXoC2X8netZIw7bMSnBoq773vj8iHeBzYklRSoCfI1K18WqKxUcCt
 ldR7po5adPa5BgO3vDePuGfFIKkCshZkd+yyvktNiKlvoaT6M6QL7IvYSZ3Q50UnbNUg
 xlzLa+IJzIFZ64Snv8cyAq1NT6I5IDGtgktfe7uh/41ddtuNUiHNkfUiDSFVjDHdylZy
 0VRZUmp0huij/m9/oyF5wq4q7Tx954oKLghBO2u/XNNTPxauJIcqG2N44D/qsLA+la6K
 8Vk3ljxUi4HrJsHXcVQh76W/HjYCCTU76MO5XuXVif2oHv9AUgKpP4sURVClCmZJRkuv
 cG6w==
X-Gm-Message-State: AOJu0YwriBKW5PS15EwFUZXDpif0mFXg63f5PzPIP1GzdMERInEaFspQ
 BhD3QdmL19wpnkl+ELFGDH2746t94y3sokLUkhPR9N4+pnd6AaJJZ2Fm0P0/4U55iABrEffTzij
 4TgTZMTgzm0e3uIAIgnJhUnaztAQ7TnA=
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id
 t15-20020a05600c128f00b003fe25b3951dmr2103765wmd.5.1693999698184; 
 Wed, 06 Sep 2023 04:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjnVvBJUUxjux1UCw/DNOVmtAthMcoVTAkKTfC2oVvlrXB5GJhRwLwMPt7rEFJF8n0J2cCOA==
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id
 t15-20020a05600c128f00b003fe25b3951dmr2103751wmd.5.1693999697873; 
 Wed, 06 Sep 2023 04:28:17 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 s17-20020a7bc391000000b003fe24441e23sm19707634wmj.24.2023.09.06.04.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 04:28:17 -0700 (PDT)
Message-ID: <27863a23-de16-4a54-b427-4c4890fa2e91@canonical.com>
Date: Wed, 6 Sep 2023 13:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: mkimage: Add StarFive SPL image support
To: Chanho Park <chanho61.park@samsung.com>
Cc: 'Simon Glass' <sjg@chromium.org>, 'Marc Kleine-Budde'
 <mkl@pengutronix.de>, u-boot@lists.denx.de,
 'Yanhong Wang' <yanhong.wang@starfivetech.com>, 'Leo'
 <ycliang@andestech.com>, 'Rick Chen' <rick@andestech.com>
References: <20230906100803.79812-1-heinrich.schuchardt@canonical.com>
 <CGME20230906100824epcas2p2e6073e8f64231f96953c92f665122c28@epcas2p2.samsung.com>
 <20230906100803.79812-2-heinrich.schuchardt@canonical.com>
 <000001d9e0af$8933c3f0$9b9b4bd0$@samsung.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <000001d9e0af$8933c3f0$9b9b4bd0$@samsung.com>
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

On 06.09.23 12:47, Chanho Park wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Sent: Wednesday, September 6, 2023 7:08 PM
>> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>; Yanhong
>> Wang <yanhong.wang@starfivetech.com>
>> Cc: Simon Glass <sjg@chromium.org>; Marc Kleine-Budde
> <mkl@pengutronix.de>;
>> Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de; Heinrich
>> Schuchardt <heinrich.schuchardt@canonical.com>
>> Subject: [PATCH 1/2] tools: mkimage: Add StarFive SPL image support
>>
>> The StarFive JH7110 base boards require a header to be prefixed to the SPL
>> binary image. This has previously done with a vendor tool 'spl_tool'
>> published under a GPL-2-or-later license. Integrate this capability into
>> mkimage.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/image.c    |   1 +
>>   include/image.h |   1 +
>>   tools/Makefile  |   1 +
>>   tools/sfspl.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 177 insertions(+)
>>   create mode 100644 tools/sfspl.c
>>
>> diff --git a/boot/image.c b/boot/image.c
>> index 5c4f9b807d..3a99d2e897 100644
>> --- a/boot/image.c
>> +++ b/boot/image.c
>> @@ -182,6 +182,7 @@ static const table_entry_t uimage_type[] = {
>>   	{	IH_TYPE_SUNXI_TOC0, "sunxi_toc0",  "Allwinner TOC0 Boot
>> Image" },
>>   	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat
>> Device Tree ", },
>>   	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
>> +	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
>>   	{	-1,		    "",		  "",			},
>>   };
>>
>> diff --git a/include/image.h b/include/image.h
>> index 01a6787d21..5f85bf84a2 100644
>> --- a/include/image.h
>> +++ b/include/image.h
>> @@ -231,6 +231,7 @@ enum image_type_t {
>>   	IH_TYPE_SUNXI_TOC0,		/* Allwinner TOC0 Boot Image */
>>   	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a
>> Legacy Image */
>>   	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
>> +	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
>>
>>   	IH_TYPE_COUNT,			/* Number of image types */
>>   };
>> diff --git a/tools/Makefile b/tools/Makefile
>> index 3d0c4b0dd6..1aa1e36137 100644
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>> @@ -123,6 +123,7 @@ dumpimage-mkimage-objs := aisimage.o \
>>   			pblimage.o \
>>   			pbl_crc32.o \
>>   			renesas_spkgimage.o \
>> +			sfspl.o \
>>   			vybridimage.o \
>>   			stm32image.o \
>>   			$(ROCKCHIP_OBS) \
>> diff --git a/tools/sfspl.c b/tools/sfspl.c
>> new file mode 100644
>> index 0000000000..428542d885
>> --- /dev/null
>> +++ b/tools/sfspl.c
>> @@ -0,0 +1,174 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> + *
>> + * The StarFive JH710 requires to prepend a header to u-boot-spl.bin
>> describing
> 
> Nit: JH7110 or JH7100? If you'd like to indicate both, JH71x0?

Thank you for testing. This should be JH7110.

The JH7100 on the BeagleV Starlight Beta uses a different format. Only a 
4 byte length field is prepended to the SPL binary. See
https://github.com/starfive-tech/freelight-u-sdk/blob/JH7100_VisionFive/fsz.sh

Best regards

Heinrich

> 
> Tested-by: Chanho Park <chanho61.park@samsung.com>
> 
> Best Regards,
> Chanho Park

