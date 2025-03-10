Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE5C28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 03:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EE2811DF;
	Mon, 10 Mar 2025 04:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741576059;
	bh=QqSYbDORskD6dxlW0QaxqlfCsQwiX4x/4dLVH/LRNlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUF+sNqRN0DZMXronibiLHDq2osaBMzJLVKUIbPBZ6g4yIZNH3+T2NDi9DtdB9O08
	 RwehviM2VzTbu3XNijXnprlRMDY1LQw+nixOcw2ImlwwlOIvsyWp34V48viRCk4QuY
	 XNj7lEOFWcQaLh9DeGXcWawsbYcd7t0eEg+Ib1qDjVPmakzB/o1aCbvv878UfGnfaO
	 ZFr/j7vLBwvg/K2tvOnqXR9D6+d05oEXEXIO0+g4TnusVw//naZdCK5MG6wFu/WNXz
	 vWBvSGS3xdgk98MtmQHJVZ67r4HBmWYI+05ljOckPre1UxYJoGFL8aNbpHzH8qJHOC
	 zImfiQ4BI5Kyg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D543811C1; Mon, 10 Mar 2025 04:07:39 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2154809A4
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MsBr0VE6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8F8E102E6338; Mon, 10 Mar 2025 04:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741576055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=QqSYbDORskD6dxlW0QaxqlfCsQwiX4x/4dLVH/LRNlk=;
 b=MsBr0VE6eYVJ2dimkKEhdzbYUVbhavzZpInVGFAFfjqK+7eURNMbzP4uXMgu5aDR7N0C+I
 kZ3+nYZ1xHqGWks22Kkz653ZCrZbdr6Trxucl0LS0W0CAQhWrDI531ySPQqdSjJIDqa+xI
 sA3zMqhCKrgra+R3q/4qCwE0iuGK9ga6xnvKbsXAitdqwxs0f8KH5pvdlbxNlGQTCQKQWr
 Yngc1aM8RkcXfPmx2l1AdNZHtBuHkMhhMFX2q2Ulwf4hJKS46hieLjSaxOoqyZet5eCo1w
 2RGt1O8JGlAuXmQ/rpbvoHOg97beguS/4CzAZR9+aAezpC4+Fs7eYTssZRXlJw==
Message-ID: <fb46746a-1d50-4226-8f56-2dade4f52891@denx.de>
Date: Mon, 10 Mar 2025 01:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENI?=
 =?UTF-8?Q?_v4_04/20=5D_firmware=3A_scmi=3A_add_pin_control_protocol_support?=
 =?UTF-8?Q?_to_SCMI_agent?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
 <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/5/25 2:36 PM, Alice Guo (OSS) wrote:

Hello Alice,

>> - Basically duplicate the mechanism in 7940a93eb977 ("net: phy: Iterate over
>> both registered PHYs and struct phy_driver linker list"), call it e.g.
>> U_BOOT_SCMI_DRIVER()
>> - Switch SCMI drivers to use U_BOOT_SCMI_DRIVER , have each one list a
>> protocol ID (instead of the PHY IDs), and then use the scmi_agent-uclass.c to
>> iterate over all the linker lists
>>
>> About the MX95 specifics and handling those, it is possible to have two drivers
>> which support the same hardware compiled into U-Boot and have them decide
>> at bind time which driver should bind and which not, look at
>> drivers/mtd/renesas_rpc_hf.c rpc_hf_probe() and drivers/spi/renesas_rpc_spi.c
>> rpc_spi_bind() for example of doing this.
>>
>> I hope this helps untangle the SCMI implementation.
> 
> Thank you for providing the example. Please review my patch set.
> https://patchwork.ozlabs.org/project/uboot/patch/20250305-imx95-v1-2-286d15acbb8a@oss.nxp.com/
> https://patchwork.ozlabs.org/project/uboot/patch/20250305-imx95-v1-3-286d15acbb8a@oss.nxp.com/

I will try to review this this week, I apologize for the delayed replies.
