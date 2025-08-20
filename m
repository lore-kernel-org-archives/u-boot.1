Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A079CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 13:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6194D82E05;
	Wed, 20 Aug 2025 15:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0ak2GKmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1AB82F49; Wed, 20 Aug 2025 15:15:37 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485E38211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 15:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0327bc9e63=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KDEZbL027057;
 Wed, 20 Aug 2025 15:14:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 3rNFkPolCW/dReZKXryMfEKmqMIZuqxiI7nsuTgSahM=; b=0ak2GKmD0Ix38Z+c
 YqLAh8teoCbpgWofLwXJpTV/OBInBLBm3v4wwzVEocbRatFaYfpWL+mMlaykaa7F
 mmMuhk0EyeLfVW5uiifpcWVxzXY+IndWEDnU2JmD0FQWlXWbFP2u6PuIli9bmAoz
 tzbzLIWE1KJmQbUoojD2aVo3sXn0Id6YTQE03n145HkNpFL5Sn0JHnAuu792bQCi
 YNEr9KcULgFesm++VT3rLN0RDar3FlpTyVNKD/1OGmh+dhYrNhDP9ECnrRZGYTNA
 o/UaHYo61Hs0fUobxNhYrb+ltm9JaifEOCjkojaytVaimiEhpvdqEPwfZf2hYXCg
 HuewUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n70da5y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 15:14:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 91D2F40044;
 Wed, 20 Aug 2025 15:12:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F8AD6CD021;
 Wed, 20 Aug 2025 15:11:35 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:11:34 +0200
Message-ID: <d7d281a2-69c4-4bc3-8392-dd772f889a18@foss.st.com>
Date: Wed, 20 Aug 2025 15:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] stm32mp2: Add SPI flashes support
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alexander Dahl <ada@thorsis.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Jagan Teki
 <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Watts <contact@jookia.org>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
 <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
 <9c805dc1-fc95-4d01-99cf-306264fd4b2b@foss.st.com>
 <905b7b4b-a216-4bdc-868b-5b38efb61317@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <905b7b4b-a216-4bdc-868b-5b38efb61317@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
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



On 8/19/25 13:10, Marek Vasut wrote:
> On 8/13/25 10:53 AM, Patrice CHOTARD wrote:
>>
>>
>> On 8/8/25 17:24, Marek Vasut wrote:
>>> On 8/8/25 5:11 PM, Patrice Chotard wrote:
>>>> This series introduces 2 new drivers:
>>>>     _ STM32 Octo Memory Manager driver
>>>>     _ STM32 OSPI driver
>>>>
>>>> It adds resource check helpers which are used by OMM driver.
>>>> It adds and enables OMM and OSPI driver support for stm32mp257f-ev1 board
>>> Can I test this with mainline TFA and mainline OpTee-OS ?
>>
>> Hi Marek
>>
>> Currently, it misses regulator support in OPTEE.
>> But you can enable "manually" VDDIO3 and VDDIO4 in U-Boot console
> Actually, I need to enable VDDIO3/4 even earlier, otherwise I get no UART and no I2C, so that's not a problem. VDDIO3/4 handling seems to be broken in the ST downstream TFA with almost 1000 patches on top of old version of TFA, and upstream TFA for STM32MP25xx is entirely bare bones that it barely works.
> 
> I also didn't manage to start upstream U-Boot on STM32MP25xx at all yet, I still have to upport about 400 patches (reduced from some 800 from ST downstream old U-Boot fork), and the result won't work unless I use the obsolete ST downstream OpTee-OS 4.0 fork with almost 1700 patches on top.
> 
> Maybe the upstream OpTee-OS is missing something, like the entire SCMI implementation ?


Hi Marek 

If you refer to my previous e-mail with the stm32mp257f-ev1 boot log, 
with the following upstream components:

TF-A: v2.13.0-304-g000fe221b8
OP-TEE: 4.7.0-26-g847ee2932
U-Boot: v2025.07

I am able to boot a STM32MP257f-EV1 board.

Patrice
