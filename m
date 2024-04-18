Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECB188629;
	Thu, 18 Apr 2024 14:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713444793;
	bh=nBl8alm7NtuafvWzUMK6D08c16Hrs7MndhsVxSqEdz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NcxdxAhqvDfu+93oyz12TVGObnRrzGnlF0Wlfa/U5HlQ5fK/aR9V+GO1gFPB0Tb0i
	 FphfPRnNc/c92RYw4G/mTI90Uqk3+Mfqy0xkhj+ef3hptlAiSQLQpPx1qp70fPoxNI
	 44ig61Xl/FXYKm5fJmYQgIB3k288KCiT3SYnlMsvuiLqyQ+RgqsNFp10BkUN6bmSxb
	 L+pMFoO65UVHtGgNCW//pvP4w9OnE1Ezb6dhpz62yv7LwZ1yvIF+cta+RUBQukQ2nn
	 1ot3bx1rdZ2D3gVCYP5W/fTlvhcMiNlrzJO9XTFSoNa101ipIJek8ofbP6EveYB2Fl
	 um+bLnkWK7j9w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6A25F8831A;
 Thu, 18 Apr 2024 14:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713444792;
 bh=nBl8alm7NtuafvWzUMK6D08c16Hrs7MndhsVxSqEdz4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L3JXuYELO/u029NyiHC+hG97GV1Kq9hofaeX/xX0xgN7AsO9zMOS+lXrBhnIVxRbE
 bRm7WGIg0qVBrS6qpV5xWGduhBV/iu2RqFWMWb+cyrLX7PJFtdtsekvPH5sRfbFcVi
 7h4GVq99FNY7oTojVbJB4oNfRItUg19nUoI2DkyuKy1Z3/ag42sxSRcMUf9mwd7ziM
 NfrIn51RPnswxxLCSHxh7wQ7/m0+BAzJvlkl07O2tiC56NbQe/zStZiZmVCOmMpzi1
 nab73W9dcAX0VjzoAofQyb20pjNYULeC075C7r5Q4weEEU9KeM/j1/Q4hDMnu4EsjF
 7OdaeAqqSWbQQ==
Message-ID: <34b12a6f-5159-4ca5-aaa2-45973fea0bb6@denx.de>
Date: Thu, 18 Apr 2024 14:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] net: dwc_eth_qos: Clean up STM32 glue code and
 add STM32MP13xx support
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240326120745.27581-1-marex@denx.de>
 <c0756783-64a7-4a01-a7d9-c24c5489615b@denx.de>
 <4d62ace1-1805-42a6-877d-90baa8c462e7@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4d62ace1-1805-42a6-877d-90baa8c462e7@foss.st.com>
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

On 4/18/24 1:36 PM, Patrice CHOTARD wrote:
> 
> 
> On 4/17/24 18:47, Marek Vasut wrote:
>> On 3/26/24 1:07 PM, Marek Vasut wrote:
>>> Split off STM32 glue code from the DWMAC driver into separate
>>> file, similar to what other SoCs already do, to avoid mixing
>>> the ST specifics with generic DWMAC core code.
>>>
>>> Clean the STM32 DWMAC board code which is currently duplicated
>>> in multiple board files, move it into the newly separated glue
>>> code, since the code is not board specific, it is only generic
>>> DT parsing and generic register programming.
>>>
>>> Add STM32MP13xx support based on ST downstream patches on top,
>>> although that part is mostly rewritten from scratch.
>>
>> Can either of you, Patrice/Patrick, pick this series via ST tree and create a MR for Tom (possibly including the other long outstanding patches too) ?
>>
>> Thanks
> 
> Hi Marek
> 
> STM32 pull request will be done tomorrow.

Thank you
