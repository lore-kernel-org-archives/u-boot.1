Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D801CCFA1A
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 02:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C2E83990;
	Mon, 10 Nov 2025 03:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qTFWj0G6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF348397A; Mon, 10 Nov 2025 03:47:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A608397A
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d4YwJ2nDlz9tLh;
 Mon, 10 Nov 2025 03:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762742816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBAlSCjZllPqVfCupvdEofI1J4KvN9C4MyJwt+swgTk=;
 b=qTFWj0G6OalWfaw+sy+O4cnyU58/qDB518p4xr9oaA27T10iCJB2f03aUlI8eO3wi29PrT
 rkYUZJz3UGNjZIYzEVH90damgosnimTzLfiIKQ+s0dP+LuZQJoQSvOfoY2b3Iw3IfEetEN
 vkZUgYrYkYg2rM1EIEWewC7FFzNja6DEVnqis5un7BRd4PCZ+2CKW455lAwj8ami10oZ4g
 p7ECm+J/sOlELpFVUQMPE3WzfZ6mEzGnxtHjsGcLU2zMgpHN55L2x1b8HD94C2z+g2pUpY
 7ks9YfONOJbZL3tDBjZjl/B6eO3V9PnAxoWrYIXLx0iVJLEYw6yfwAgV9swjCA==
Message-ID: <30cf731b-d4ff-48dc-bd5f-aadd4988a855@mailbox.org>
Date: Mon, 10 Nov 2025 03:46:54 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBib2FyZDogbnhwOiBSZW5hbWUgYm9h?=
 =?UTF-8?Q?rd_directory_from_board/freescale_to_board/nxp?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20251108-nxp-v1-1-6169a1692ff4@nxp.com>
 <20ca3866-29e9-42c6-9224-a33c15034b9e@mailbox.org>
 <PAXPR04MB9644BBF3EE6675452285279BE2CEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644BBF3EE6675452285279BE2CEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 538ef67491a4ddcbbff
X-MBO-RS-META: yjpj4tdy3cxbt9gqctynjm6h15oadukf
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

On 11/10/25 3:19 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marek.vasut@mailbox.org>
>> 发送时间: 2025年11月8日 9:09
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; dl-uboot-imx
>> <uboot-imx@nxp.com>; u-boot@lists.denx.de
>> 抄送: Tom Rini <trini@konsulko.com>; Peng Fan <peng.fan@nxp.com>; Alice
>> Guo <alice.guo@nxp.com>
>> 主题: Re: [PATCH] board: nxp: Rename board directory from board/freescale to
>> board/nxp
>>
>> On 11/8/25 1:59 AM, alice.guo@oss.nxp.com wrote:
>>
>> Hello Alice,
>>
>>> This patch renames the board directory from board/freescale to
>>> board/nxp because NXP now provides Board Support Packages (BSPs) and
>>> tools for the former Freescale i.MX and other i.MX products.
>>>
>>> All relevant references have been updated accordingly. This change
>>> does not affect functionality.
>>
>> I'd suggest sending an updated V2 of this IMMEDIATELY after v2026.01 is out, so
>> it can be applied before any other changes.
>>
>> --
>> Best regards,
>> Marek Vasut
> 
> Got it. I will send the updated v2 after v2026.01 is out.
Thank you. Also, coordinate this with Tom, to minimize conflict when 
applying the rename.
