Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2045C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 21:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACB5885E2;
	Fri, 17 May 2024 23:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715980673;
	bh=9SEpO5XfNA4EL/0y22+E7afgHL4HIanRHKrsfGIqNoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/1NnOU9xz24Ol3DuOb86MeukavMb5806GD/RZdCPeV79untPwMmyO6C5QKWt5vR6
	 g0NZbtrePBPqWfdyt8mbmaZ6H6UGAR1O76n7FFfzleLFfCsVPbgx4Z7h5GUZ2Wgwe1
	 /qKBujxP33hBb/4v+nql7kP1P1+gmo6c+rmWW1XKkKKTrPTONZPAppSTC6WX3dU5Ac
	 AQAfsAik1SBDOlwYibZHZrYSj72CPkv1iNyc0fueK6lVUfdXgT+sX3UMjfzKDNl+Vs
	 /KYSe/h57UsmkbnF+6dDmvG2sbZ0tnJKH6ZVYxgbyHJLZoTFNMqRYRo4DXzKSMs9zG
	 hA5Itq3DREDEA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1FFFB885D7;
 Fri, 17 May 2024 23:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715980671;
 bh=9SEpO5XfNA4EL/0y22+E7afgHL4HIanRHKrsfGIqNoE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LVZA/JcXHW6c1aA3kZRzSs94OI5i68WQDp+uv2JmKmtuZFRkUx+VdUTbyvMbrpgSF
 e3PfvkWFRH5ZvlG20dS2VCxn6fFcA+7McQwxKA3fvBn0A9CGdHbnlKTXDQxo+RHVpX
 JIiq1YiRO5xYrvpd1J1Df+/d5XQhcUxIM112O9xigxERZC33Spo1bzkYBZxatT55Xu
 rBu5zwvGU4J9V656YiEVVaABCv0K9F9lWp/ycEFKgYWQ3EkOHEetctUH4QWmeWD1aj
 /87lKC8gWigphqofSEn6KFrRgnw3wPDCpfxzGlFz2eeymuLIRRvTFtYMOQPGLYYHMM
 InLY5ZHo305wA==
Message-ID: <027bcfed-5004-4840-ac7f-8d36f390bf64@denx.de>
Date: Fri, 17 May 2024 22:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-8-minda.chen@starfivetech.com>
 <31783bbc-5efe-4721-aff7-53933c87baf5@denx.de>
 <BJXPR01MB0855BBB699F2FF59F1E699F8E6EE2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <BJXPR01MB0855BBB699F2FF59F1E699F8E6EE2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
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

On 5/17/24 11:47 AM, Minda Chen wrote:
> 
>>
>> On 5/4/24 5:03 PM, Minda Chen wrote:
>>> Add USB related files to Starfive visionfive2 MAINTAINERS.
>>>
>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>> ---
>>>    board/starfive/visionfive2/MAINTAINERS | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/board/starfive/visionfive2/MAINTAINERS
>> b/board/starfive/visionfive2/MAINTAINERS
>>> index d7f638f9b4..1faf83f581 100644
>>> --- a/board/starfive/visionfive2/MAINTAINERS
>>> +++ b/board/starfive/visionfive2/MAINTAINERS
>>> @@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
>>>    F:	include/configs/starfive-visionfive2.h
>>>    F:	configs/starfive_visionfive2_defconfig
>>>    F:	drivers/pci/pcie_starfive_jh7110.c
>>> +F:	drivers/phy/starfive/
>>> +F:	drivers/usb/cdns3/cdns3-starfive.c
>>
>> Thanks !
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Thanks for reviewing the patch set!  I will follow the comments.

Thank you !
