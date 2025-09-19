Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D571CAC5A0
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 02:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0672881E13;
	Fri, 19 Sep 2025 04:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XbxsL9vG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFB8829E7; Fri, 19 Sep 2025 04:40:19 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52937800D7
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 04:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cScDb38ybz9tPy;
 Fri, 19 Sep 2025 04:40:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758249615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xvm/QlyrHUy06A/FQI3EXoQ3jokriy9jPIc8f1asrHw=;
 b=XbxsL9vG471GCvFHtFJXNCc0+OB4LCzxbzet6ViMXbNyiYqOVC2xlWHXubqhvVI4x7PlWv
 OyRUn+C2HtaUeee8J2E67U0czAgImFao/yw0gwnDXrbD6uXE2EAB46Q5mwFVv7Z1O4dAYr
 LuU+6ySfh7kBMPRVaPRZXTxlNxR9iMnV1Wej/ViOoAO/19hA7qEfarPzjkj9KWzd/nKxNn
 HCN4SB1pItJ7HSSJtkXjwNRYTtdi1IfXLm0L3hu6Dz/tWQ4oXI1vQcjaUtf70yopZArF2m
 x8NIvxGPucnhw/TtC0QjM18K5E09pjBABbnEYofjM/QZmrHt5hb/nSY0EgEUOQ==
Message-ID: <80e4418d-3b60-40d0-a06b-c73456c35dbe@mailbox.org>
Date: Fri, 19 Sep 2025 04:40:13 +0200
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxXSB1c2I6IGVoY2ktbXg2OiBFeHRl?=
 =?UTF-8?Q?nd_support_to_i=2EMX91=2C_i=2EMX93=2C_i=2EMX94=2C_and_i=2EMX95?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250908194649.3645232-1-alice.guo@oss.nxp.com>
 <c7645818-d51a-4fbe-8f4f-185429416e61@mailbox.org>
 <PAXPR04MB9644E58E169A43580389C52EE211A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644E58E169A43580389C52EE211A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8i9a1u5yyme1okm3b5gfoabasq7895r7
X-MBO-RS-ID: 9b24e62987393a80a0c
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

On 9/19/25 3:45 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marek.vasut@mailbox.org>
>> 发送时间: 2025年9月18日 20:21
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; trini@konsulko.com;
>> festevam@gmail.com; Alice Guo <alice.guo@nxp.com>
>> 抄送: u-boot@lists.denx.de; Ye Li <ye.li@nxp.com>; Peng Fan
>> <peng.fan@nxp.com>
>> 主题: Re: [PATCH v1] usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94,
>> and i.MX95
>>
>> On 9/8/25 9:46 PM, Alice Guo (OSS) wrote:
>>> From: Alice Guo <alice.guo@nxp.com>
>>>
>>> Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
>>> i.MX95, the condition check is updated to use IMX9.
>>>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
>>
>> Also ... at what date did you send this email ? I received it today
>> 2025-09-18 .
> 
> Hi Marek,
> 
> It was a mistake in my computer's time settings. I had not noticed the incorrect time before.
Ah good, I was wondering about that, I was worried NXP mails are getting 
graylisted or something and take days to reach me. Thank you for the 
confirmation.
