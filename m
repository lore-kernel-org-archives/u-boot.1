Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935FFCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A6780FA1;
	Tue, 19 Aug 2025 12:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HKQttCPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B1182998; Tue, 19 Aug 2025 12:54:25 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F77D802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c5mg11TF4z9shq;
 Tue, 19 Aug 2025 12:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755600861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1OxigwBtGBan9cEgK9RDUy6D/LPXwLIVu1xmTgQKOY=;
 b=HKQttCPpIaCn0CMUNwu5M4EA0WGa3QcT3XVj8mPFD7VZFauZitIqFBUqncVRrKERBpyNk+
 iAIY2FLtWp9drcfaDA5YnWLHV4ok49ujHsArKYE1sXnszLagt3olsfQuAfXPO5uPUEyT2p
 8ZUrHZHksavAs9Bfz5A67lmTfFz8GtywUTWw8kQvlQnnjTClTUWyaeX6yrNacQKUatBRii
 NpxrjY4BOR03so/wPhrGSkBMK9KY8a8s7FdA7tR6UbaMxmTgYnF/57C/2dJqFzhI7qKG15
 s4LqsNNNLUSxk6zYCbAiSFslPMSGl7ts81/uAgHUcA1Y3qrfdOjwxzvwEg/hQQ==
Message-ID: <81059c20-971d-43ce-ac98-421329efe938@mailbox.org>
Date: Tue, 19 Aug 2025 12:54:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
 <a10f97cf-72d8-4f82-870f-cb845e5cb72e@mailbox.org>
 <626aac73-10f5-4514-a6ea-0b67a7b2d45b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <626aac73-10f5-4514-a6ea-0b67a7b2d45b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tcmfwefw5cinw77st1z1wzj3dqat8nh7
X-MBO-RS-ID: e27c6d14c06c2477d7e
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

On 8/14/25 5:23 PM, Patrice CHOTARD wrote:
> 
> 
> On 8/14/25 15:37, Marek Vasut wrote:
>> On 8/14/25 2:09 PM, Patrice Chotard wrote:
>>> Initially, only one STM32MP25 based board was available, the
>>> stm32mp257f-ev1 board which was set by default in stm32mp25_defconfig.
>>>
>>> Since commit 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream")
>>> we inherited of a second MP25 based board which is the stm32mp257f-dk board.
>>>
>>> Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR to allow all
>>> STMicroelectronics DT compilation.
>> If I build stm32mp25_defconfig , I can run the result on both EV1 and DK now ?
>>
> 
> With this patch yes
> 
>> It seems only the EV1 DT is built into the binary, so why compile all DTs ?
> 
> By default yes, only EV1 DT is built. that's why OF_UPSTREAM_BUILD_VENDOR is needed to
> allow all other st/*.dtb to be built.
> 
>>
>> $ grep TREE configs/stm32mp25_defconfig
>> CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257f-ev1"
>>
> 
> Currently if you try to build U-Boot for stm32mp257f-dk board using the following commands:
> 
> make stm32mp25_defconfig
> make DEVICE_TREE=st/stm32mp257f-dk

Please introduce defconfig for each board instead of this hackage .

Look at this example on how to use #include in defconfig files, it even 
supports multiple levels of config structure for deduplication purposes:

$  git grep include configs/imx*dh*
configs/imx6_dhcom_drc02_defconfig:#include <configs/dh_imx6.config>
configs/imx6_dhcom_pdk2_defconfig:#include <configs/dh_imx6.config>
configs/imx6_dhcom_picoitx_defconfig:#include <configs/dh_imx6.config>
configs/imx8mp_dhcom_drc02_defconfig:#include <configs/imx8mp_dhsom.config>
configs/imx8mp_dhcom_pdk2_defconfig:#include <configs/imx8mp_dhsom.config>
configs/imx8mp_dhcom_pdk3_defconfig:#include <configs/imx8mp_dhsom.config>
configs/imx8mp_dhcom_picoitx_defconfig:#include 
<configs/imx8mp_dhsom.config>
configs/imx8mp_dhsom.config:#include <configs/imx_dhsom.config>
configs/imx_dhsom.config:#include <configs/dhsom.config>

-- 
Best regards,
Marek Vasut
