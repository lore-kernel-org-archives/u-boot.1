Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FF6E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 20:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B24803DC;
	Mon,  6 Jan 2025 21:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736196681;
	bh=7qc+wc8ikGOXUIFXzemi0/Nf5BSrWrJss8eFGqpYdAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjDTCx2gAxY+pdYZjHpk9jywazSYs15stdbs6YeALHeld/MieVxtWJ1w0M6DvhXGu
	 Ux/GwWDaeNhlkSCSduv0HcX5fPgVbUvEZ+es9YlXaZVG26NvgFgOeHePBVCbyjPmUa
	 6toIwztsTNne/JOTf66aRARCRTKQSMplp6iA5jG1orF0E2jZmvkeE7AXXklddvCkfJ
	 ArHxJ09Mt/CjW4aOo8tXCBv6g+7b5IESr49UK8C1K7d0ZOkmgMukX/A2+blQ3ms11k
	 4gFSUgJavpVCNvCQU3qDbEZbCwG0MLSxc0Mte2tj8aV9DYHDjP9FfurLa6y4Z3N/AP
	 mAdex7+cm6lLQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B66805D7; Mon,  6 Jan 2025 21:51:20 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA598036B
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 21:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QRe141xy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F98910090387; Mon,  6 Jan 2025 21:51:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736196676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qc+wc8ikGOXUIFXzemi0/Nf5BSrWrJss8eFGqpYdAc=;
 b=QRe141xyO4fl9/NlS1A2U3wAfJ9gOTlsqgDKb4dJjlNytVVUstpDY1uft5nbwGKe1jM3N+
 j4fxb4HiwpL86K51opDP4c5cpOJParxf4Xl+rvSuI3ApCckPntuAKmAKRdtKc/QmpPnc20
 eKGbAm7CDry4WUr8rzF0xrMRQ9wt77XF/RiMHwIuRi0amAXiYCIBchc8Sc4om1Bgf1PFht
 uzkTMp+IRc4j4Ti4zmbsAIEWGIKy0xfTkx99ceICK3S5vEpPzdotQY20CZRUeCA+U209s0
 kcXSbNkLuikkxQwY1j/cdnaQIhPo5ipRmCIqIuYjN99PoO6SXOoVXl5jzIsYdw==
Message-ID: <001a00ca-5980-4ffc-8fe7-67267a71615c@denx.de>
Date: Mon, 6 Jan 2025 21:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMS8xN10gbWFp?=
 =?UTF-8?Q?lbox=3A_add_i=2EMX95_Messaging_Unit_=28MU=29_driver?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
 <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
 <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/6/25 6:27 AM, Alice Guo (OSS) wrote:
>> 主题: [EXT] Re: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit (MU)
>> driver
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX95 Messaging Unit (MU) enables 2 processors on a chip to
>>> communicate and coordinate by passing messages (e.g. frame
>>> information, event notices and requests) through the MU interface.
>>> This patch provides a driver for i.MX95 MU using the common mailbox
>>> framework. Currently, SCMI exchanges on i.MX95 uses a mailbox
>>> transport with SMT format, and the hardware used is this MU.
>> Is this ported from Linux ? If so, as of which mainline Linux kernel commit ?
> 
> Yes, u-boot/drivers/mailbox/imx-mailbox.c is ported v6.12.8 Linux.

Please add that information into the commit message, including the 
kernel version and Linux commit ID , in case this driver needs to be 
updated.

>> Can you add older iMX SoC support while adding this driver ? It seems
>> imx6..imx95 MU IP look very similar.
> 
> This patch-set is only for i.MX95. I can add the older iMX SoC support in the future.
Maybe you could split off addition of the MU driver into separate series 
and do it for all the SoCs right away instead ?
