Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74A4CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 08:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D3886ED1;
	Sun, 15 Oct 2023 10:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="korLb1tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1AD86EDD; Sun, 15 Oct 2023 10:25:32 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F859869C8
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 10:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9ac9573274so3594335276.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697358329; x=1697963129; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhcvSvDM5nUQ25FjQrMJb7AvonQFbcKG5q490z3lUgg=;
 b=korLb1tPsfw1dl7sKfdcAAu3R95kR6+I7AfVv2UfK7NY5VGcB1crye0BcuBO1TzEV1
 ZzrzQTUmR55RqtiZE5Y49dDxcgwc6x3Y+Hir/H36YfglgIZ8MkrnDy+xJXl535R9f6Pb
 HOzIOu3Ldpn2q/KJxlRNQJRrNmWL28uLIFK42e6kUQxTErQhe9tc0m+dSezcQl0/D9VB
 3WDXEZbod/DBrXwI2wkBvJyhRQ6ipBYIQORIPkUX8KcnEMbQKWWHY79gsrFDehI+9gLO
 gJWSlkLgemIMp8oLfZJGL3ILtbQBhf2JtP1/KWGpK0BWUFSvFu1DqrJJL8x5Crkr97Ys
 6a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697358329; x=1697963129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhcvSvDM5nUQ25FjQrMJb7AvonQFbcKG5q490z3lUgg=;
 b=diS4ivRQsQeZmVezITt7Rbt7h+eEr/rdedwewjG1BDgrQqLWTGyWblho5fpbYRJhne
 5KYwgDlr3gQA6f1EKARVB0XwIVfCWapwaZBjJdaWx/+UbTGIWEG5C3SPFaj/3gd9arEW
 9OI2IFTIJ9CS5xM/Zfy8Ekanc+pkNmS/+vPj+bcEMn2Q827ZhV/31ajP+VQbc/OT9Y1R
 EGIziem908FapnD9riLdKZiJc4bSSY30PLtTtIbbiQMHE/NhTF3Z9O5Bs84D2eagkIra
 8WDu2cCKy+4f7kkMaqBuCWks3BoutmuABAea92jFw+iGUkSEpzNr5Xy37V+NoNPYpdMI
 yMfA==
X-Gm-Message-State: AOJu0YzvAB5EuGUGOUg8KQXoN4b0qIXlzd5gxc1PQ4+lQiBxOFDX0Lbc
 YwA4w+FAfwDD1Bs2fOvyV9ntKbeLVc2ExA==
X-Google-Smtp-Source: AGHT+IGgDv2H9MYyUOsn333CLaJkcKLRJzcPRpE9fckVuFHAwQ/fNARMPYc/Z0a4PETsId7W8pvC7Q==
X-Received: by 2002:a05:622a:3cc:b0:41b:6627:2046 with SMTP id
 k12-20020a05622a03cc00b0041b66272046mr1389651qtx.17.1697294265169; 
 Sat, 14 Oct 2023 07:37:45 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 h4-20020ac87444000000b004179e79069asm1518926qtr.21.2023.10.14.07.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 07:37:44 -0700 (PDT)
Message-ID: <e6129aa4-9bec-fec0-2177-9c45ec7d3095@gmail.com>
Date: Sat, 14 Oct 2023 10:37:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [SPAM] [PATCH 20/26] test: spl: Add functions to create images
Content-Language: en-US
To: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-21-seanga2@gmail.com>
 <ZSmeAWkQl1f2F-JS@xdrudis.tinet.cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <ZSmeAWkQl1f2F-JS@xdrudis.tinet.cat>
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

On 10/13/23 15:44, Xavier Drudis Ferran wrote:
> El Wed, Oct 11, 2023 at 09:56:20PM -0400, Sean Anderson deia:
>> This add some basic functions to create images, and a test for said
>> functions. This is not intended to be a test of the image parsing
>> functions, but rather a framework for creating minimal images for testing
>> load methods. That said, it does do an OK job at finding bugs in the image
>> parsing directly.
>>
>> Since we have two methods for loading/parsing FIT images, add LOAD_FIT_FULL
>> as a separate CI run.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   .azure-pipelines.yml             |   4 +
>>   .gitlab-ci.yml                   |   7 +
>>   arch/sandbox/cpu/u-boot-spl.lds  |   2 +
>>   configs/sandbox_noinst_defconfig |   6 +
>>   configs/sandbox_spl_defconfig    |   6 +
>>   include/test/spl.h               | 117 ++++++++++
>>   test/image/spl_load.c            | 352 +++++++++++++++++++++++++++++++
>>   test/image/spl_load_os.c         |   5 +-
>>   8 files changed, 495 insertions(+), 4 deletions(-)
>>   create mode 100644 include/test/spl.h
>>
> [...]
>> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
>> index 1a57bf846d2..ca3777cab37 100644
>> --- a/test/image/spl_load.c
>> +++ b/test/image/spl_load.c
>> @@ -4,7 +4,15 @@
>>    */
>>   
>>   #include <common.h>
>> +#include <image.h>
>> +#include <imx_container.h>
>>   #include <mapmem.h>
>> +#include <memalign.h>
>> +#include <rand.h>
>> +#include <spl.h>
>> +#include <test/spl.h>
>> +#include <test/ut.h>
>> +#include <u-boot/crc.h>
>>   
>>   int board_fit_config_name_match(const char *name)
>>   {
>> @@ -15,3 +23,347 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
>>   {
>>   	return map_sysmem(0x100000, 0);
>>   }
>> +
>> +/* Try to reuse the load buffer to conserve memory */
>> +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
>> +{
>> +	static void *buf;
>> +	static size_t size;
>> +	static bool invalid = true;
>> +
>> +	if (invalid || size < sectors * bl_len) {
>> +		if (!invalid)
>> +			free(buf);
>> +		buf = malloc_cache_aligned(sectors * bl_len);
>> +		invalid = false;
> 
> Should size be updated here or am I being thick ?
>                  size = ALIGN(sectors * bl_len, ARCH_DMA_MINALIGN);

It should.

--Sean

