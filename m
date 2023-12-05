Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF29BC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 05:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63228759E;
	Tue,  5 Dec 2023 06:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B468KQ1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD13D876DA; Tue,  5 Dec 2023 06:09:19 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F33875EB
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 06:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B55947m061724;
 Mon, 4 Dec 2023 23:09:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701752944;
 bh=WWZQll3OPRak3b7+6CpInpz2mcAPYIFuzq/5byXhIcc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=B468KQ1JVGPrluSq7E/oux2/SodmV3i71yx1V308XxKs0uVSjLNnp5MHws/tMJIuK
 ZE+mLsi1Oal4MNuDF0/tujPk6Qa1Qlbp1k6lmDqzLCb9yIzRMqBfClktNfiJI/1vq8
 XVmr63j0uQQIola+YZfmMbBwfNc7AI63o648g8B4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5594g7090542
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 23:09:04 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 23:09:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 23:09:04 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5590aC030032;
 Mon, 4 Dec 2023 23:09:00 -0600
Message-ID: <b41b26d4-ee9b-4c40-ae03-8f754f408ac6@ti.com>
Date: Tue, 5 Dec 2023 10:38:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: board: ti: k3: Mention TI_DM argument
To: Andrew Davis <afd@ti.com>, <marcel.ziswiler@toradex.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>,
 <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>
References: <20231204112141.2036907-1-n-francis@ti.com>
 <20231204112141.2036907-4-n-francis@ti.com>
 <5e41ee08-a632-4cb4-a568-5f0cd65a299d@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5e41ee08-a632-4cb4-a568-5f0cd65a299d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andrew

On 04/12/23 20:36, Andrew Davis wrote:
> On 12/4/23 5:21 AM, Neha Malcom Francis wrote:
>> Mention TI_DM argument can be used to fetch a custom DM binary in the
>> A72 build instructions for K3 devices.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   doc/board/ti/k3.rst | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
>> index a127215ce5..15916b088f 100644
>> --- a/doc/board/ti/k3.rst
>> +++ b/doc/board/ti/k3.rst
>> @@ -320,6 +320,13 @@ use the `lite` option.
>>    make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
>>           BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
>>           TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
>> +
>> +.. note::
>> +   It is also possible to pick up a custom DM binary by adding TI_DM argument
>> +   pointing to the file. If not provided, it defaults to picking up the DM
>> +   binary from ti-linux-firmware. This is only applicable to devices that
> 
> It would only be "ti-linux-firmware" if that is what you had set as BINMAN_INDIRS.
> 
> s/ti-linux-firmware/BINMAN_INDIRS
> 

Thanks for catching that, will make the change.

> Otherwise whole series LGTM,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
>> +   utilize split firmware.
>> +
>>   .. k3_rst_include_end_build_steps_uboot
>>   At this point you should have every binary needed initialize both the

-- 
Thanking You
Neha Malcom Francis
