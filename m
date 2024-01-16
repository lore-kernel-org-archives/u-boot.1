Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B391FC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 07:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E06875A0;
	Tue, 16 Jan 2024 08:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JlKX0gm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CDB87252; Tue, 16 Jan 2024 08:08:56 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3FE870DF
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1745c6cb32=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40G31tqB002614; Tue, 16 Jan 2024 08:08:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=wMxa5yR2jXzylrwQcd+8XVOjN5E7X/mUTc4vCb/2TJ4=; b=Jl
 KX0gm7CDnLYpmRLBdYXfk/OGaC31hyX81OowXCo41ueBnhsQiATtSweDLTXEbsEB
 iSiHyVbLP3AUR3D3d7LUdLuAA0V9T21OAbAJf1DGzn50BfZz7EjwCa+7pKtZ4gkS
 Cpfennxp6yzzSBgYU9WahIJaZz0gzzeJizK4L98cLJU2R4cVxWfRF0ZlPtWikekS
 oalKihpDpW9reu3Klkdu/2SW/T0Txv0tj6E73iJf1nOnlijsBWzOClHEuL3ZDVG/
 DmnUpf0qQfeDNPlNE37BxfztdrHEQu2UIUPLZ6XRzRv1j/TJOO4o+GV80ZPofUzl
 xPH5ljRK6iji4rJ84FPQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfycsd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 08:08:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C699110002A;
 Tue, 16 Jan 2024 08:08:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BBF2A21231B;
 Tue, 16 Jan 2024 08:08:36 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 16 Jan
 2024 08:08:36 +0100
Message-ID: <805dd72a-32cd-49f2-8bc5-cb8ffb12bb6f@foss.st.com>
Date: Tue, 16 Jan 2024 08:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>, Michael Nazzareno
 Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
 <5740853.DvuYhMxLoT@pwmachine> <20240111170418.GA7220@francesco-nb>
 <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
 <20240116004618.GA12635@bill-the-cat>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240116004618.GA12635@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/16/24 01:46, Tom Rini wrote:
> On Mon, Jan 15, 2024 at 06:34:24PM +0100, Patrice CHOTARD wrote:
>>
>>
>> On 1/11/24 18:04, Francesco Dolcini wrote:
>>> Hello Tom, Francis
>>>
>>> On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
>>>> Le jeudi 28 décembre 2023, 21:58:59 CET Tom Rini a écrit :
>>>>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
>>>>>> During 2021 summer, Sean Anderson wrote a contribution to add a new shell,
>>>>>> based on LIL, to U-Boot [1, 2].
>>>>>> While one of the goals of this contribution was to address the fact actual
>>>>>> U-Boot shell, which is based on Busybox hush, is old there was a
>>>>>> discussion
>>>>>> about adding a new shell versus updating the actual one [3, 4].
>>>>>>
>>>>>> So, in this series, with Harald Seiler, we updated the actual U-Boot shell
>>>>>> to reflect what is currently in Busybox source code.
>>>>>> Basically, this contribution is about taking a snapshot of Busybox
>>>>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt it to suit
>>>>>> U-Boot needs.
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied to u-boot/next, thanks!
>>>>
>>>> Thank you for the merge!
>>>> If there is any problem, do not hesitate to mail me and I will take care of 
>>>> it!
>>>
>>> This change, specifically setting the modern hush shell as default, is
>>> breaking our boot script, just noticed since the current U-Boot master
>>> has a regression for us.
>>>
>>> We still need to figure out the exact details, here [1] you can find the
>>> boot script (that has some placeholder that is replaced during build).
>>>
>>> and the error is something like:
>>>
>>> ```
>>> ## Executing script at 90280000
>>> Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
>>> 69025 bytes read in 11 ms (6 MiB/s)
>>> 82 bytes read in 9 ms (8.8 KiB/s)
>>> Working FDT set to 90200000
>>> syntax error at 'done'HUSH died!
>>> resetting ...
>>> ```
>>>
>>> that I _assume_ comes from this line
>>>
>>>     env set set_apply_overlays 'env set apply_overlays "for overlay_file in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} && ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} && fdt apply \\${loadaddr}; env set overlay_file; done; true"'
>>>
>>> [1] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-bsp/u-boot/u-boot-distro-boot/boot.cmd.in
>>>
>>> Francesco
>>>
>>
>>
>> Hi all
>>
>> I observed a similar issue with STM32MP157c-DK2 board.
>> Since commit 78912cfde281 ("cmd: Set modern hush as default shell") U-Boot crashes :
> 
> I wonder if:
> https://patchwork.ozlabs.org/project/uboot/patch/20240115134656.50917-1-heinrich.schuchardt@canonical.com/
> is relevant to this problem or not.
> 

Hi Tom

Unfortunately, it doesn't help :-(

Thanks
Patrice
