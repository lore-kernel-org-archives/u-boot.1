Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65293C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F86587C39;
	Wed, 31 Jan 2024 14:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="EdprBrbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A7B87BE5; Wed, 31 Jan 2024 14:06:52 +0100 (CET)
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D65F87BFD
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from [172.20.10.3] ([151.34.228.121])
 by Aruba Outgoing Smtp  with ESMTPSA
 id VAIhrpHRA1KN4VAIhrD7Q9; Wed, 31 Jan 2024 14:06:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1706706408; bh=UKJ1kJYB6Jvo7wqEhz7nE44QVlc1gRsdYWLIGt42lT0=;
 h=Date:MIME-Version:Subject:To:From:Content-Type;
 b=EdprBrbWaoukdto2WmTQWv/ZIqxf3Ro+5Lufi6obQHB1OuoodjWIsG1RHvMwyIilX
 5kReQ0+sf8FiZdZnPtMhGxC35bD555bGiH7BYi/aGNn7zQmI1KymcSSVvRPkuLn7+b
 K4NCQFj3NRuJyK8B1nxzfFLXVFLjaOwMXt0Rr53mrSyUz4pX8TVotOmqTVpqvz9x5B
 wrWWeNCeG3ama6gchXPMBSRdschM2WfnvpMioXkvP9A5to+TSQU4kKcG7OLYNe7nvo
 sq4DmKKjAIappGTIRrzfIUvt9bGsJq2HUDPvYWDvkjykzJ3BljgjIyn8ZUpjeJG+Q3
 FaYNtt7+FU91A==
Message-ID: <b670f1a1-b3b7-46cb-8abb-3270e4457bf0@benettiengineering.com>
Date: Wed, 31 Jan 2024 14:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
Content-Language: en-US
To: Jesse T <mr.bossman075@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
 <CAOMZO5BJRDdD5a7JZ+ws7aqz0p0nmK_vXiq33=V3s5X_4m8+-Q@mail.gmail.com>
 <CAJFTR8Rn=y-vHfCktUjNjk8GqRgRaU2GJY0Qnfg6GmfEKd7pOg@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAJFTR8Rn=y-vHfCktUjNjk8GqRgRaU2GJY0Qnfg6GmfEKd7pOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHMdSDwWvf9QumuRTraswCPJKFnGiqVmkckR60WssOM9bCaCb3fDibB02Mz2hNgn6I0fhKeUF/rgiH0XsD4Qkqbpy0Bh6Feryhcz1ZP4DMU+SpXLjBuG
 FRD2wI7GwKrsnBtDiehvI3LRJQAd3D6/hgmuUR5CcreknlAvhSFD+RX8EW6UcXPp+IarpXs7XKgw8gZhpAUT6L+BjUYcBqv16UMjNbG+h+LyYBySnNhLEv8d
 9Vu8BX7VT7JeN+x3ShdcULXmZIN4vJzMxO7mei8AfWaFb2k2tzDfmmSTYuFiam2fOLP3QnRt2TFejPn+FvGcIVMe5gceIISij0BaT9Er9iIBQf2DVHeSVq9J
 pfyNniF4A9QntpdnzJxRZSdButyHs0Zkdva5RUFfTwyasosdlM4=
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

Hello Jesse, Fabio, All,

On 31/01/24 02:44, Jesse T wrote:
> On Mon, Jan 29, 2024 at 8:34 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> On Sun, Jan 28, 2024 at 6:43 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
>>
>>> +++ b/configs/imxrt1050-evk_fspi_defconfig
>>> @@ -0,0 +1,100 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SYS_DCACHE_OFF=y
>>
>> Out of curiosity: what are the problems if the D-Cache is turned on?
> 
> I don't remember this was asked when we submitted the original
> imxrt1050-evk_defconfig

The problem is that mmu_set_region_dcache_behaviour() is not implemented
for armv7m and mxsfb.c requires it when DCache is enabled, that's why
I've disabled.

So we can keep it as is or implement armv7m complete 
mmu_set_region_dcache_behaviour()

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
