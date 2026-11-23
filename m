Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B19606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tc7RbxSP;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gM2eMBZq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43D8D80C13;
	Mon, 23 Nov 2026 09:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HCn0gVeHIez; Mon, 23 Nov 2026 09:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6148B80BD2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795425811;
	b=a4dvLocvhdKe16q6IyEUFwG4qOXDYciTSeeilP+dd/11S+bHChDG0/vhJP6MaJnAWXcV
	 yucAQSQMHu9HJKn+NmLpN38Omm/hVtxCiaT/bH9D0Ejg5vyrITnf1l425rGoZkSFntze9
	 1NR7MPvANLNb+ETPyn0WOBL2xvHlebaRBnT6vW9kZkL8Y/8xQp+Zj6jpJg/8WstFFO7Ik
	 v1bAVXjGwz7I3k+XWnke9TY+lHBNeQCNPpZq0NwdGam7Ns4mHunbTGkGuFGQJrgyFotYI
	 XWtt386flhpbh/MeK0I4C6sHER+uCpUa1fUyu3gFosJVbXRB1T2oASPq3O6RXUo6QxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795425811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KXcMC9KYzokhIoQEOD7fanJ8gCDI5DE2OVsoKRqsbXA=;
	b=sC0nwOv8UWzR673WB/stmI4DOAbaJxFqiixh3lmc+KQ6dEX4Ivr+rKo/O3nvt1MSjOla
	 nS2BZpGZ3UeO6r7ihQihrC79zfalnFDs9E67S4E/7lr9tEyfldsN7vZIx7XGO1LNLXQhn
	 AuKnjeUYL051EP/zee0UZ02eFPQe/u46I2+8RAiFpqhinSeb2dwH19MeUrg2nFW+9uZoI
	 +Rd2skuffgC0YSN84GMgxGE8fWMipkV6VSMX0ZJ4PFPKsRtXcH6PzsyRfazIajvxR6HBo
	 QxDGJjzL+LJAll+78mL0PdJLgRpEvLwEMRbs8tPtGjUowE5INC57SSDJZlbNkpz/3mA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795425811;
	bh=KXcMC9KYzokhIoQEOD7fanJ8gCDI5DE2OVsoKRqsbXA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tc7RbxSPKky1eKZ84gZdCN5LqLwVCVe66ily9PuEtgXZckGDyArkFJLSrIfkeWH6m
	 EMZanv2RBfAM26C2FDdkWxocuWwV8zC1wIi7l4YPIB8UK4lHWLc50RQ/TYUdSJAVPw
	 bH25xMVbUMtTlmMv6PHEuWnyl36hM5Vxm+X3olv86wNRvtdl0R1shqH7fXhX82nfPo
	 Tf/YTC7IYSd1m5PHBXnPryA9VoomrVNakf52SRh3slCeebGEurDeUSwUaK8HdDQ+ZO
	 KECtGCABES9iBJ6qvhkCIxZ97KTJoIoFxAKiDHcy/x9P7O/UY3SlnoolyYQUDemmTr
	 GA+wz1OhIqlnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6148B80BD2;
	Mon, 23 Nov 2026 09:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DE40260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EC5E606F5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9niEDZGzO_k for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6898C606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=gM2eMBZq
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6898C606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXcMC9KYzokhIoQEOD7fanJ8gCDI5DE2OVsoKRqsbXA=;
 b=gM2eMBZqUtApHW2O3ZOX72ViDK2bzJybps2qrBQNRUDtWnDb0dIGmVRPSwLqXba1vV+nKfZ5BvRLQBXRx/0Dao//zuD37kByexu9RZloTuNhUhbQ0nhx1+BhotcTxyiQNRWP6HeXzzHwGGRBYAluZZ8SwPrNOdMM5x0EUfaWHyr/yyPdYM4WV46QUhqAaqz+1/0RkW/Q422+pMrd09rXk0lPcxFO8W+gM9FAhXB6PfJ+jmhOgPQsHLLhbr1LiK1JU+pTrk6a5dn7nP8melfciTZm5Bskf8+93MDvOU4YVbJHIXhmyoia6wfOCFqF8vAmkBfQVY8LDX2W+LUsWBWFiw==
Received: from VIVP296CA0124.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:358::11)
 by DBAPR10MB4043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Mon, 23 Nov
 2026 09:23:18 +0000
Received: from MI3PEPF00008486.eurprd02.prod.outlook.com
 (2603:10a6:800:358:cafe::49) by VIVP296CA0124.outlook.office365.com
 (2603:10a6:800:358::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:23:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008486.mail.protection.outlook.com (10.167.240.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:23:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 23 Nov
 2026 10:24:05 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 23 Nov
 2026 10:23:17 +0100
Message-ID: <913b5977-84e8-47a6-96a5-1508b47bd393@foss.st.com>
Date: Mon, 23 Nov 2026 10:23:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
 <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
 <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
 <afce74bd-8bdb-457a-b2a8-31f5211b0a7e@mailbox.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <afce74bd-8bdb-457a-b2a8-31f5211b0a7e@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008486:EE_|DBAPR10MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb34339-477a-4d1c-52a3-08df494368e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fiSdfL5P0X2nRcEFcVrj/Y9Pav3fOfCtwORyibLEbylKCzO5TldUmLIpkYEtd7tLJVbxqUzH0RQYazRAN3FoAImcFId5TuhS2sp//4NQdxJqqqV2lSwH5B1TpYjiq05pXKN0XfSpqGCaJyojojtZbTay/3lutxc5lzh4+0f0ikJahJrX0NDQMGOhkjtFRlOuScD902u7IrKmRZMXBEjeu9iENw1f+LZkoRGnOY0Vexs3MCASPbCdFMbCId/kRpoIg/kcdQOJvxnAxTvc4E7sCNLSy+SEAnaBYuiVe8rdEBGqSjiAhB2wJjXSW/MvBUrSGznosFIiFi9JTfMWlDBBhf3cYYJoZXzOi9eUvEEjGCNOC+9NhoQiKXt02b0N0jRG+OtSXA/b+gH/VcnoIFOJJXbK3LXbi2j8rtRW1IRTzHu6rPH1z5C81r2eXdiMEkHgXGw/pm4q+yeoKMC4vxOa2PV+pkQ3dC0XDsixg4YAcvbIm7v8ZuYqOC2jQBx0Qo23aPCh99WMQkSgs5S2cS033AMUq/pCXk4cJ/IMTxQYblOwcdv5h7eWHlvaKBH3Xnuqw94reVLAYyuj+Jt25WuU35yF3Bz05q5Rp/WIhQpQ0BAnfWZQ9c5UQKO1XDKa5mcjGmMs8u9ffoe+2YngPYqp6A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KoRzdQX2f2/fI2E8RB5UU7Ez2N4N5wNHoNogiB2qoPFC3N13Qz4wBv8uJGbez09IVRO321vIc+NWYZBz4IrvdflRw6c3suRb1QGVwAPA3XBKdodYOdadB7KQBYP/iiYH+Semv5W0EPs0MUgY3p62/cPVvGzamiGTkVIcUgcwfX7xUYshTLvCH3rft8NVN0wcT5otH7MDFg8pMnql55kL7PDMnGg6pdPWxdluztUGgxzdvGJH4ONKk9YG90g7bXarGqatoFbnCicEdRuuTeO0Rims92fuLF+2XK4D0t5oPO6njjw3gLLXzT/RJM4PYHMvOelz7o9sFtb/25KMjC5fxKyHi4YjKEkVD0oUSl8urldZA+i0DnhfTiyD8Rwp4s0DgbJICyighQ1JiRikenYKRCsApAEtsJ8+cBTvk9MwtcsbZxj79IquHbySmu5m/cOk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:23:18.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb34339-477a-4d1c-52a3-08df494368e0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008486.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4043
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 12:02, Marek Vasut wrote:
> On 11/20/26 9:24 AM, Fabrice Gasnier wrote:
>> On 11/19/26 13:14, Marek Vasut wrote:
>>> On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
>>>> This hub is powered by digital and analog 3V3 power rails, so provide
>>>> the possibility to use different regulators for digital (vdd) and analog
>>>> (vdda) power rails.
>>>> This is inspired by the Linux driver [1]
>>>>
>>>> [1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>> ---
>>>>    drivers/usb/common/usb_onboard_hub.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
>>>> index 0c84c1fede03..4b96defc2d93 100644
>>>> --- a/drivers/usb/common/usb_onboard_hub.c
>>>> +++ b/drivers/usb/common/usb_onboard_hub.c
>>>> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>>>>    static const struct onboard_hub_data usb2514_data = {
>>>>        .power_on_delay_us = 500,
>>>>        .reset_us = 1,
>>>> -    .num_supplies = 1,
>>>> -    .supply_names = { "vdd-supply" },
>>>> +    .num_supplies = 2,
>>>> +    .supply_names = { "vdd-supply", "vdda-supply" },
>>> Is this an ABI change and does this break existing users ?
>>
>> Hi Marek,
>>
>> I've tested with and without on stm32mp157c-ev1. There's no breakage on exiting DT.
> What about other DTs that are in U-Boot and possibly not OF_UPSTREAM ?

Hi Marek,

It looks like there are no users in U-Boot DTs that aren't OF_UPSTREAM, e.g. users seems to be in
dts/upstream. Some of the dts don't use supplies at all, some just define just vdd, some define both
vdd and vdda.

'vdda' regulator has been added to the dt-bindings, as optional. U-Boot usb_onboard_hub driver get
regulators as optional (e.g. check for ret != -ENOENT). So there should be no breakage here. Please
clarify if you see some case I could have missed here ?

BR,
Fabrice
