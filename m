Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A5C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C2080F56;
	Fri, 21 Feb 2025 20:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740166887;
	bh=F9NfwVkhouuHf0SyvZmQWhWrn14l4jLd5Wsy9v9XwGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VboHp9HrtwUq3zAMoCAfE3NgSjAuvjqUshXZQM9GB/O7PDS6ouLVjtTnq7Dn2F9Cv
	 3J+jKyiCxAH8nsiY+13yfU3IkwXPfKbqUZqcJySfigMQRPeArkOgT2VmCfBn3yAu58
	 wLPRfwF+GxITDCXBF0AzOPjRxKG9zxTJ2YHsLoGsib8vYdnOcDoCIQbs3hP5PWsMc3
	 R+SoyQo3SzK3OQ3pjKLZwvc76GsmBuqqgP4P5hBnrij+kzS7f/MNgxxIn6jAc0nalm
	 ZmBjNoyO7o/eg8ZdKW45kvZWR6ixSURnkLPhBfvjyo4QUQYYT7iRzlj+opebkw/aQf
	 RBgnJuqIsymIw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762D680F70; Fri, 21 Feb 2025 20:41:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD7E806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="L707/A2Y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB6BB10382D37; Fri, 21 Feb 2025 20:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740166882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9NfwVkhouuHf0SyvZmQWhWrn14l4jLd5Wsy9v9XwGU=;
 b=L707/A2Yh7FDoZt1aWfkjUBIUTkpGXgsBkT4sZsChVNPM2fQoX17GpLm/lpXaNieleKp8H
 vV2onSnlbXTarHPm0/tuAQofkh7g/v/+bf3JB1TCL0KbIIhFj8WpKzDgM3WsEbaraOiyMV
 RGhkKLrSeEIZUPPul2WsN0ViTgEurMa7mcIWgxmTX8RsGr4TQJY34cLIsu2JCUHU1zd96s
 2e48x78g8WiorOkW/5XeRhJ0safLEpl4MO9/K8cqRkvn0x/9ycEzriGtQLR2XH/HSL0xSr
 DqDUXpLTD/PLQJ/qmyNpmcjuy6UkZmHQdLFlbgGo2efiyZAhGq9Ma4VCdOThtw==
Message-ID: <b23faec0-e950-43db-8b75-0664cc68a16c@denx.de>
Date: Fri, 21 Feb 2025 18:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2NCAwNS8yMF0gc2Nt?=
 =?UTF-8?Q?i=5Fprotocols=3A_add_SCMI_misc_protocol_protocol=5Fid_and_message?=
 =?UTF-8?Q?=5Fid_for_getting_the_ROM_passover_data?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-5-93b28a514dea@oss.nxp.com>
 <24cdad35-a255-4941-b6ed-0e7240857fec@denx.de>
 <PAXPR04MB96445DE3BBBC8E0F16DEB41BE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96445DE3BBBC8E0F16DEB41BE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 2/21/25 10:39 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年1月24日 21:57
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Alice Guo
>> <alice.guo@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ye Li <ye.li@nxp.com>
>> 主题: [EXT] Re: [PATCH v4 05/20] scmi_protocols: add SCMI misc protocol
>> protocol_id and message_id for getting the ROM passover data
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> On 1/15/25 2:28 PM, Alice Guo wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> SCMI misc protocol is intended for miscellaneous functions which are
>>> device specific and are usually defined to access bit fields. This
>>> patch adds SCMI misc protocol protocol_id and message_id for getting
>>> the ROM passover data.
>> Is this iMX specific or is this generic protocol ?
>>
>> If generic , then the symbol SCMI_PROTOCOL_ID_IMX_MISC should not contain
>> _IMX substring .
> 
> SCMI_PROTOCOL_ID_IMX_MISC is IMX specific protocol.

It would be good to explicitly spell this out in the commit message , 
that this is some non-generic vendor-specific extension.
