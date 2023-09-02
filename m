Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4CEC71153
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 12:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BE281970;
	Sat,  2 Sep 2023 14:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qATwYbNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9A384698; Sat,  2 Sep 2023 14:49:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F071805C5
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 14:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 382Cn4qF073180;
 Sat, 2 Sep 2023 07:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693658944;
 bh=QMrva+Yxz6ZIz/N7R1g0lasc+lMaLMWLfFh/ehQXgG0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qATwYbNjJQ7NBu+ODXhWBxlV5goxWD1zgMkMjctjZYuqrYht3OdhKCPPIfCutWtAz
 NUg8jN/aTx81dmPRf6vKc8PIahPMphc08arhYQ4KInLxTRA1GmpmAdftG+GuENaW5J
 qfPzMiwroTK5JiRno9x3FrhiAYyPMcTPAHd95u6M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 382Cn4Ax087312
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 2 Sep 2023 07:49:04 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 2
 Sep 2023 07:49:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 2 Sep 2023 07:49:03 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 382Cn0Im122259;
 Sat, 2 Sep 2023 07:49:01 -0500
Message-ID: <1fed9388-dfc4-0b9c-4502-b5020b2aed1a@ti.com>
Date: Sat, 2 Sep 2023 18:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] thermal: k3-j72xx-bandgap: Add support for vtm
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>, <peng.fan@nxp.com>,
 <ye.li@nxp.com>, <robimarko@gmail.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
 <20230901061500.2342452-2-u-kumar1@ti.com>
 <20230901150640.u7nyi3hawwkz3rbs@leverage>
 <f3dfffb4-4a97-be0b-61d8-f0e4761b1714@ti.com>
 <20230901173344.fw7glgqmed3fm7ua@comfort>
 <8857fb8f-415b-2b59-585f-d6a3cff9327b@ti.com>
 <20230901191042.7iq2tunocqjxnyh3@paramedic>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230901191042.7iq2tunocqjxnyh3@paramedic>
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

Hi Nishanth,

On 9/2/2023 12:40 AM, Nishanth Menon wrote:
> On 23:43-20230901, Kumar, Udit wrote:
>> On 9/1/2023 11:03 PM, Nishanth Menon wrote:
>>> On 22:54-20230901, Kumar, Udit wrote:
>>>>>> +static const struct  udevice_id of_k3_j72xx_bandgap_match[] = {
>>>>>> +	{
>>>>>> +		.compatible = "ti,j721e-vtm",
>>>>>> +		.data = (ulong)&k3_j72xx_bandgap_j721e_data,
>>>>> So what happens to drivers/misc/k3_avs.c ?
>>>> Could you help me to understand this comment.
>>>>
>>>> Do you mean, why we can not add this support in AVS driver or
>>>>
>>>> need of this porting ?
>>>>
>>>> How I see, AVS driver to run at SPL/R5 time and this driver
>>>>
>>>> to be probed in Main/A72 u-boot when needed.
>>> you are saying the drivers are mutually exclusive - how about detecting
>>> over-temp scenario at R5 boot? switching on A53 will be a mistake at
>>> that point, no?
>> Yes these are  mutually exclusive.
>>
>> Let me see, how I can add TSHUT value programming in avs driver to avoid
>> above.
>>
>> But in case, temperature reading is needed from u-boot shell, we still need
>> this code.
> One approach might be to merge the two.

I think merging of these two feature could be done in one file, as one 
driver or two.

But on execution/feature side, from R5/SPL we need to set voltage for 
A72 (OPP or AVS)  before

releasing A72 core. Also can program TSHUT value for thermal overrun 
protection.

For A72/Main u-boot, provide function of temperature reporting from shell.

