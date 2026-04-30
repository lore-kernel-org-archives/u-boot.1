Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F43ACD13DE
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D89A843B6;
	Fri,  1 May 2026 00:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ZAF//jvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E03883A91; Fri,  1 May 2026 00:39:03 +0200 (CEST)
Received: from mxd-2-a03.seznam.cz (mxd-2-a03.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a03])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4160803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-w7th8
 (smtpc-mxd-5f4d8d5f6f-w7th8 [2a02:598:64:8a00::1000:a03])
 id 41c6d92b1ac88d42406f1575; Fri, 01 May 2026 00:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777588693; bh=JCzD4yDvlNeCkKW9x2DSEQ+Jts1+QKHQcn6H01HNTQM=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=ZAF//jvpn+akSrnsbN4H5JBKw504MrKKMixC/wIE66jGw9q7S/r9CLHOTkDq7scqO
 TCnh6VWkIXUA86KHKFhEhPBE2cd7NQYVgyaibcts/vEOtBgumhbQSnJmncyb+A8oNs
 KQ5cZVXK0nGE6ExMBn3edPEA/KzQBgXniSaqxClgi/yJ2cNue4tVmH8RVdZEy/K6qJ
 o2A63S6i7RA0anVV5BC9W3CSqfG+qOjszeaZL0SruEN4MV3m18/WqzXhnlbR9EaYHg
 vHq/Zhl8SCNd19mC47arW6M2+znvXhG1f0KlByB3+dE1fR0D5QQMmnoA+V0QqaZjIV
 LzlybuqW9peJQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-6597cc8696-kmkls (szn-email-smtpd/2.0.72) with ESMTPA
 id b4cdc01f-4c85-4b39-8207-b3e10e99df99;
 Fri, 01 May 2026 00:37:56 +0200
Message-ID: <55d7f857-c36a-44f7-bb26-77cfbfee96f7@seznam.cz>
Date: Fri, 1 May 2026 00:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 michael@amarulasolutions.com, richard.genoud@bootlin.com,
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
 <aeYpRSg2S6p8dNZt@sumit-xelite> <afMmNjz2u37Xy1yl@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <afMmNjz2u37Xy1yl@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 May 2026 00:55:30 +0200
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

Hi,

On 4/30/26 11:51, Varadarajan Narayanan wrote:
> On Mon, Apr 20, 2026 at 06:55:25PM +0530, Sumit Garg wrote:
>> Adding Michael
>>
>> On Fri, Apr 10, 2026 at 02:41:47PM +0530, Varadarajan Narayanan wrote:
>>> Add details about the SPL & U-Boot proper build steps, converting to
>>> flashable images, source URLs for the needed binaries and scripts.
>>>
>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>> ---
>>>   doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 69 insertions(+)
>>>
>>> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
>>> index 99cf8eba57c..d09dba52044 100644
>>> --- a/doc/board/qualcomm/rdp.rst
>>> +++ b/doc/board/qualcomm/rdp.rst
>>> @@ -42,6 +42,67 @@ on your device with::
>>>
>>>   U-Boot should be running after a reboot (``reset``).
>>>
>>> +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
>>> +====================================================================
>> Rather than just the build steps, please describe the overall boot flow.
>> And since you have created a common SPL file for all the Qcom platforms,
>> can you ellaborate on how the boot flow is going to be reused across
>> Qcom platforms. Maybe we just need a dedicated spl.rst document here.
> Ok.
>
>> Also, how does this series align with one for SPL support on SDM845 here
>> [1]? Are there things that both SPL ports can reuse from each other?
>>
>> [1] https://lore.kernel.org/all/20260411-qcom_spl-v2-0-9609557cf562@seznam.cz/
> As I understand, board_spl.c and spl.c (in arch/arm/mach-snapdragon) of
> Michael's patch and mine can reuse spl_boot_device() to include
> BOOT_DEVICE_DFU and reset_cpu().
>
> However, I still have to figure under which conditions spl_boot_device()
> can return BOOT_DEVICE_DFU.
I'm 99% sure there is a register somewhere that can be read to determine
if the device booted via EDL. I think that's exactly when we would
want to load u-boot proper over usb, other than that it could possibly
also be used as a fallback if booting from ufs/emmc fails.
>
> Thanks
> -Varada
>
> [ . . . ]

