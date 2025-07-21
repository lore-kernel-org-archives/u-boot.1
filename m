Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690DC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBD083290;
	Mon, 21 Jul 2025 18:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="A5Bh/NkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B797A83290; Mon, 21 Jul 2025 18:33:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BA683214
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1753115583; x=1753720383; i=frank-w@public-files.de;
 bh=6sZAWrTHQ+0t+tM1rfvbJmGutb3WEUZFIsV5SaDLpN0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=A5Bh/NkQpnqa7gaaHOCzQh+XeELrY0TrnydNbobqcpgG7Wn/CesJhk7QGY3FY/iH
 lE6aXOjnRuZus9/na9lpdP9Q2eyOWuFtS2ttrXmtmRs7yQiEyKUFHXSs2L1rG23vo
 ujJ5FMphlqcurcwGyHVjkeJzoKOsOvtZTEPNwd9e2IUj1zQnmMgc+YWmxJxiqA5Ol
 4Ywf/rQkrRCTxwTpQV4EgOsIxyWWYEiUu5oJ1jLzcPuBUnaTt/OZ+6qA8BUoR7K4q
 oUlDmVvZBfafiyehcYrX8C115zjEvLTtRbbG1DDcOTFkYXpz0YZufo4rLiNyxEQ4G
 Mlqmk1VWqJCoVrC5VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.73.96]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatRT-1vAk1U1nBb-00fKK2; Mon, 21
 Jul 2025 18:33:03 +0200
Date: Mon, 21 Jul 2025 18:33:01 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Marek Vasut <marek.vasut@mailbox.org>, lucienzx159@gmail.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com
CC: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 daniel@makrotopia.org, ericwouds@gmail.com, albert-al.lee@airoha.com
Subject: Re: Aw: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
User-Agent: K-9 Mail for Android
In-Reply-To: <f0c89f84-2d12-40d1-912d-c978f5c9ba76@mailbox.org>
References: <20250720122852.22563-1-lucienzx159@gmail.com>
 <trinity-ffcccc9c-109f-403d-aae9-e1309d08c2b3-1753111569975@trinity-msg-rest-gmx-gmx-live-7b4f7c955b-vd6nb>
 <f0c89f84-2d12-40d1-912d-c978f5c9ba76@mailbox.org>
Message-ID: <DE6AEFFA-B38B-4A7D-85B2-2F5811F3C11E@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZWXqdFjgVdCFTy6Sxy8zkIxPOcCYDbWiNfqCVyHR4s6fbifXDdL
 /AeEQY9QsvljaXtST8d8NteZ1ovPwnkf1xUxoj9UOOoreTcGf2ClDTrwtrdKGWa6wMmAq4b
 cW/sEGZrG+91ypo2s6l+FuIDYO2taRi/NmK0lbH53OitAiWM/J1LGgDdBmpU7HEK+oqYrzF
 slTP8GHDGym8k8bcLjx6A==
UI-OutboundReport: notjunk:1;M01:P0:9A9/WXdVbp8=;GW+HKrIVeOtKV5zXBmh6eBVyhLD
 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
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 21=2E Juli 2025 18:19:54 MESZ schrieb Marek Vasut <marek=2Evasut@mailbox=
=2Eorg>:
>On 7/21/25 5:26 PM, frank-w@public-files=2Ede wrote:
>> Hi
>>=20
>>> Gesendet: Sonntag, 20=2E Juli 2025 um 14:28
>>> Von: "Lucien=2EJheng" <lucienzx159@gmail=2Ecom>
>>> Betreff: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
>>>=20
>>> Add the driver for the Airoha EN8811H 2=2E5 Gigabit PHY=2E The PHY sup=
ports
>>> 100/1000/2500 Mbps with auto negotiation only=2E
>>>=20
>>> The driver uses two firmware files, for which updated versions are add=
ed to
>>> linux-firmware already=2E
>>>=20
>>> Locating the AIROHA FW within the filesystem at the designated partiti=
on
>>> and path will trigger its automatic loading and writing to the PHY via=
 MDIO=2E
>>> If need board specific loading override,
>>> please override the en8811h_read_fw function on board or architecture =
level=2E
>>>=20
>>> Linux upstream AIROHA EN8811H driver commit:
>>> 71e79430117d56c409c5ea485a263bc0d8083390
>>>=20
>>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h=2Ec=
),
>>> I have modified the relevant process to align with the U-Boot boot seq=
uence=2E
>>> and have validated this on Banana Pi BPI-R3 Mini=2E
>>>=20
>>> Signed-off-by: Lucien=2EJheng <lucienzx159@gmail=2Ecom>
>>> ---
>>> Change in PATCH v3:
>>> air_en8811h=2Ec:
>>>   * Add U-Boot environment variable(en8811h_fw_part, en8811h_fw_dm_dir=
, en8811h_fw_dsp_dir)
>>>     support for firmware loading=2E
>>=20
>> Thank you lucien for taking care of this driver=2E=2E=2E
>
>Indeed, and thank you for the patience=2E
>
>>>   drivers/net/phy/Kconfig       |  25 +
>>>   drivers/net/phy/Makefile      |   1 +
>>>   drivers/net/phy/air_en8811h=2Ec | 880 ++++++++++++++++++++++++++++++=
++++
>>>   3 files changed, 906 insertions(+)
>>>   create mode 100644 drivers/net/phy/air_en8811h=2Ec
>>>=20
>>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>>> index 8d88c142900=2E=2E9f12238e1ea 100644
>>> --- a/drivers/net/phy/Kconfig
>>> +++ b/drivers/net/phy/Kconfig
>>> @@ -79,6 +79,31 @@ config PHY_ADIN
>>>   	help
>>>   		Add support for configuring RGMII on Analog Devices ADIN PHYs=2E
>>>=20
>>> +menuconfig PHY_AIROHA
>>> +	bool "Airoha Ethernet PHYs support"
>>> +
>>> +config PHY_AIROHA_EN8811H
>>> +	bool "Airoha Ethernet EN8811H support"
>>> +	depends on PHY_AIROHA
>>> +	help
>>> +	  AIROHA EN8811H supported=2E
>>> +
>>> +choice
>>> +	prompt "Location of the Airoha PHY firmware"
>>> +	default PHY_AIROHA_FW_IN_MMC
>>> +	depends on PHY_AIROHA_EN8811H
>>> +
>>> +config PHY_AIROHA_FW_IN_MMC
>>> +	bool "Airoha firmware in MMC partition"
>>> +	help
>>> +	  Airoha PHYs use firmware which can be loaded automatically
>>> +	  from storage directly attached to the PHY, and then loaded
>>> +	  via MDIO commands by the boot loader=2E The firmware is loaded
>>> +	  from a file specified by the U-Boot environment variables
>>> +	  en8811h_fw_part, en8811h_fw_dm_dir, and en8811h_fw_dsp_dir=2E
>>=20
>> maybe something like PHY_AIROHA_FW_IN_SUBSYSTEM =3D (MMC/USB/NVME/=2E=
=2E=2E) as choice? or better PHY_AIROHA_FW_BY_ENV and then check env-var wi=
th default "mmc" for maximum on flexibility without recompile=2E
>If we could use the generic loader interface, than these Kconfig symbols =
go away altogether , right ?

It depends on how generic loader interface works,but yes for the fw one if=
 subsystem, partition, basepath
 should be defined globally and vendorpath and filename is set by driver t=
hese could be dropped and also code below has only 2 calls
 to fsloader passing vendorpath and filename=2E

regards Frank
