Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1026AC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D40831EA;
	Mon, 21 Jul 2025 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rE4HMQED";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yTa4/HLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8027C83214; Mon, 21 Jul 2025 18:20:05 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B3C831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bm5GB74BZz9scL;
 Mon, 21 Jul 2025 18:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753114803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2iSMsHhLqMyNvJqcyogAFVlAefue3DRllTQ22GedhI=;
 b=rE4HMQEDS4LDqgMnlc/BSF2MKqoYU8YBPbeuxhAO5TOlENKKRK6iRfXcfjD5ftEyJvT5uo
 Uw5q4iGhUu302HWWwiK5DvxpdXsWFmFJpWRy/5hKUe71nLsfT6wz+8tTLUOdh5NGaam42m
 IE8omGDRvdRbK8Ak+cbsANOPOiTNuoL0FpvEknTMA5PVKGavENLKY3qCvmkyak1m69Sc2v
 rYjrn5jItufwB4WT3sKqJ8rFR1yhaVSTGuPz41CGq3s2uMg4u4bCam0vuYNqIi/XM8keYg
 hSDT7rvG6wolU9l/PJV0HuOWshx7AD2kfuJkO2wjhpCH2AEFobtfIgcXLIJ1nw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="yTa4/HLZ";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f0c89f84-2d12-40d1-912d-c978f5c9ba76@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753114799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2iSMsHhLqMyNvJqcyogAFVlAefue3DRllTQ22GedhI=;
 b=yTa4/HLZBCP6y50GdoLY/bAI7e27oIcbYu8doGOzZvsfCfo75OUsnZiUH9GSFdhOuaHrKu
 NWv3dxOTaEv9VcirPGjdJW6QhzKcqBU0o+Tr9G01a4JfaQGkOwD5xkUmOjkPXYETfKa5Jl
 ewIKNI76BJiZ6yLjFGOmioDoAybhkUaVOYUWemnHXLFsYzI56I4ZsnjYOOaEMXaaYXVgSr
 iYdCKp4lXbMdkr97HE8m4uf3Ba+IpTaFwZeH6DbDQld5bjiTGhR5vjczL1BG/JO2bdaENq
 9zNpBIlPzB/ML/vECwf4/6T74trLZ9HdVi4EYU2Nyo4hfOWJFasvbHAcTw26Fw==
Date: Mon, 21 Jul 2025 18:19:54 +0200
MIME-Version: 1.0
Subject: Re: Aw: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
To: frank-w@public-files.de, lucienzx159@gmail.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 daniel@makrotopia.org, ericwouds@gmail.com, albert-al.lee@airoha.com
References: <20250720122852.22563-1-lucienzx159@gmail.com>
 <trinity-ffcccc9c-109f-403d-aae9-e1309d08c2b3-1753111569975@trinity-msg-rest-gmx-gmx-live-7b4f7c955b-vd6nb>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <trinity-ffcccc9c-109f-403d-aae9-e1309d08c2b3-1753111569975@trinity-msg-rest-gmx-gmx-live-7b4f7c955b-vd6nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e1345aee2d829d8caff
X-MBO-RS-META: 7i8gcnk3xo936zsfbj1t3fbjnkrmxfty
X-Rspamd-Queue-Id: 4bm5GB74BZz9scL
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

On 7/21/25 5:26 PM, frank-w@public-files.de wrote:
> Hi
> 
>> Gesendet: Sonntag, 20. Juli 2025 um 14:28
>> Von: "Lucien.Jheng" <lucienzx159@gmail.com>
>> Betreff: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
>>
>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
>> 100/1000/2500 Mbps with auto negotiation only.
>>
>> The driver uses two firmware files, for which updated versions are added to
>> linux-firmware already.
>>
>> Locating the AIROHA FW within the filesystem at the designated partition
>> and path will trigger its automatic loading and writing to the PHY via MDIO.
>> If need board specific loading override,
>> please override the en8811h_read_fw function on board or architecture level.
>>
>> Linux upstream AIROHA EN8811H driver commit:
>> 71e79430117d56c409c5ea485a263bc0d8083390
>>
>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>> I have modified the relevant process to align with the U-Boot boot sequence.
>> and have validated this on Banana Pi BPI-R3 Mini.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>> ---
>> Change in PATCH v3:
>> air_en8811h.c:
>>   * Add U-Boot environment variable(en8811h_fw_part, en8811h_fw_dm_dir, en8811h_fw_dsp_dir)
>>     support for firmware loading.
> 
> Thank you lucien for taking care of this driver...

Indeed, and thank you for the patience.

>>   drivers/net/phy/Kconfig       |  25 +
>>   drivers/net/phy/Makefile      |   1 +
>>   drivers/net/phy/air_en8811h.c | 880 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 906 insertions(+)
>>   create mode 100644 drivers/net/phy/air_en8811h.c
>>
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 8d88c142900..9f12238e1ea 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -79,6 +79,31 @@ config PHY_ADIN
>>   	help
>>   		Add support for configuring RGMII on Analog Devices ADIN PHYs.
>>
>> +menuconfig PHY_AIROHA
>> +	bool "Airoha Ethernet PHYs support"
>> +
>> +config PHY_AIROHA_EN8811H
>> +	bool "Airoha Ethernet EN8811H support"
>> +	depends on PHY_AIROHA
>> +	help
>> +	  AIROHA EN8811H supported.
>> +
>> +choice
>> +	prompt "Location of the Airoha PHY firmware"
>> +	default PHY_AIROHA_FW_IN_MMC
>> +	depends on PHY_AIROHA_EN8811H
>> +
>> +config PHY_AIROHA_FW_IN_MMC
>> +	bool "Airoha firmware in MMC partition"
>> +	help
>> +	  Airoha PHYs use firmware which can be loaded automatically
>> +	  from storage directly attached to the PHY, and then loaded
>> +	  via MDIO commands by the boot loader. The firmware is loaded
>> +	  from a file specified by the U-Boot environment variables
>> +	  en8811h_fw_part, en8811h_fw_dm_dir, and en8811h_fw_dsp_dir.
> 
> maybe something like PHY_AIROHA_FW_IN_SUBSYSTEM = (MMC/USB/NVME/...) as choice? or better PHY_AIROHA_FW_BY_ENV and then check env-var with default "mmc" for maximum on flexibility without recompile.
If we could use the generic loader interface, than these Kconfig symbols 
go away altogether , right ?
