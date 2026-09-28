Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B23CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD0D80F86;
	Mon, 28 Sep 2026 13:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsEk4oqLabH2; Mon, 28 Sep 2026 13:42:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F29D481061
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790602970;
	b=JDdW2Nddvwk8XnKfllQwptxZqd25fTyvW9ur4vrIqUB1bwsmnyn2Y2OTMD4FTXpFclVQ
	 E9x9j6tfhF/y1t7ptwbhpB92DxLVEg7HNLh4nlLsncE3xmYDj6LqmTUuAEB4cCuVMVpNh
	 xy9yDUClT1fTPis8MenvCgOMMpQHYhDcYdBKEQzjVHicuRk2COEbH15nptUFtwbzIjPLR
	 bFoGFpGB+O7mgVcNVYjK/MWu8aJ8nNfnpW488SMDZu5ql7V4ifT8uP+P2rQURtUaHDAmr
	 1XBumyVbaYu0oRGkRJMb1fi84jHFQBuHPrMGzdgHSt1suSnTZJ187eVBgO0y/Gumabw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=grDw7fLi04RdDtIF0KnZ8+ihvzOxxQFyOyRR4lhCi/c=;
	b=Z94qPpCITeFCAVB1Epp2G3/SlE2yMuaHX703dDTYN08HbiDSkQmEcZwS2IZ2QHs6O4UX
	 gNkxn88lwDAJ6iOa6sL9rZTiWemLivaadvZcCCY6I/uI7kUTC8SHGGLRdFm7rlbRacfRu
	 aWjaQKk0aJa0RbNBOCKI9BcCJxXdug9MZzKGnAJ2fT650KzObd4UzhkF26BEUz+ARjOFW
	 pzPaRC7p87f2NK/MeVxz3T9yIYHbX61dDXUBYDQHbr67Ry7d4/aMN7UJ3dJze3nLNODbS
	 irWFjH7JIQACy22v8kT5tXmN0FRMNL32SSZ+tNtubzIOeiU2QMrxEGZM+3hWXyfs5pQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602970;
	bh=grDw7fLi04RdDtIF0KnZ8+ihvzOxxQFyOyRR4lhCi/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0O9SFef6/Grlv5HvDnLgD0OFZM5OKENBys2uvjaiTBUvTpZIOq2/erNXHVIRC5RF
	 yl948lCtYEiJ3/KdeiczB2WZwwqYgspCZj8s+WlOKEp60uo5g+wgQ92WiqOLtCqbeI
	 hU10EvMkjyqR7cubBcZMZF9AQJRn3Z+eqp+Tzy48ORa9Nj/Rp+EJLCuX3Beyrx4ri1
	 QT1xNNvYX8Yi4+2ObboWFc6swOKP74JYeVabsg7lsIl8eeFtqq8p8HJaW6dVdSS5S3
	 Ib7m7JlYG8jQfgEiFzfss9VRExiIIT4TLr/l5j1GnMGA5hUnRulfEem7CorJ1zguk7
	 RtOlQFqSDGjdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F29D481061;
	Mon, 28 Sep 2026 13:42:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D5DC3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 733B6401DE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAZd9Nhck1YN for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 13:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 66538401C2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790601977;
 b=SYA/yzoRZ5kNLFXuVR3ccBcNa6SZbfkuTwmWhFGRJsvetVV0FJQd0KJyvuT9Z3ZvLGt4
 RpMOvqjPdpJ9i3bYqnZsMa5f0o5ufh4ngP66RcHKz5++8QWN8KPpRPCWhAxaetnnz7QQz
 shCjBORuuXKGmEYu5beXQZ0qtppp6LWy++Pz7BeCFo/mn+e7WVwRNqhPVvXEJ9SUM6lda
 N4LqKzXc5/wEF96RrMfFIxwd3cp8G9gaYI6WAN0T0416EmUZiAMdeeiMjW/ZnLJtcvADR
 nAz8nIJ9Tmjqd9SZMtBps2QUsFS2aprXNFRfqF2RR4GNn/UkVP6Oy0txLidrDbxfFaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790601977;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=grDw7fLi04RdDtIF0KnZ8+ihvzOxxQFyOyRR4lhCi/c=;
 b=IJwnyew9Acz5dEqCYAvC1rc8ySP379S0veXRM4vx4ifTw9QHBlxFuSM1k4CxrwQC+ro+
 0nwOpmP9lEPbtNK6VM6SYAa90tskJH9U2XcF3bWetaVHvqUZPXjlDWDbD5FfhuxzMqywO
 ZSRuEBgoprAXPrPXtBo+QXNYpQBmzCqC8bYE89KH5iXCyx9QCs0KO7lBYALvzYCCufgIL
 fkgAg+huEwWtlWCiPqVZOQIQkv12FI3YTYhCNgf+ZwCdOjRDY+ChxnuE+2XnXRENYigdH
 N7y4+mhXX3ANwvBvKsgkTRjSR6kiL6kehZywnOIRgHZ4/z+kBYTWeWrSPvEYG32JLxw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MUpLmmil; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MUpLmmil
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66538401C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK9auJqmWmxvdWX2fWz1HZdWfnTmPhOYGLeB4VQap9L6nk4FA/XmtvP711bRk23/fclOcaxYSILpIIzkNJVXmdFBrMKAlhwT6D1mqcCOHmJ3+en641wikyroh+UXE4gOThhonPNvntF9s4e0KH3KBEp3fKTzQFd3o8ax61LqBs0hIFSColeo3v53UlTO6JWMLAjnPFtN1kkUNoZaX4POJ85AAwMDbMYWaYZP+gM3eJ1R81d8n15/48msHj36XdzwTc/XXz7EBxfu9LGKG2/zVg+EbAskZJj+4SnyVx8w+M/w4LL7uJaSQqBi7FrdSsS754yw4dUdA8i6tuEg2yfAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grDw7fLi04RdDtIF0KnZ8+ihvzOxxQFyOyRR4lhCi/c=;
 b=SXgR8JHbPiyLMCHrqZB9ZyqyeeROT7+kWYM16fwPNvg1Kflfpp5iuDunC80o4wHN0DAXH1LpcI4SpmYE5T4rB+r/vrhTCBXUiFSBQFhGZ9+s5P4Kf5LM0oxMniMDP0OJmRgjqhOVNH94+TY6NqnfCfX2uVr+u8ZYzIyy8BtC/ZljsyOs/yJRBEtiziXPySr8EPj4tsG/PUFgvvjtR4oRw+464LKgDzAslESdc+BnVmpEvXpyUv5GBs8RLJ3oDBJwA4LcrI7l8EAhPFnIs8QoeQj3KqYTvJILmumTqFSwaC5/3J1IBimzYtlxlgFFzmCBocPvE26ojBK5Ri09C6QsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grDw7fLi04RdDtIF0KnZ8+ihvzOxxQFyOyRR4lhCi/c=;
 b=MUpLmmilOa/eQaLzRThth7JuDvSLHmKA0PC594ALhzr8jd8N4dTZ6DrsXxVv2AT/dhX8l60oaAK2Bf49Zqt4p5rsWwoPwafFgRRC459wIoABkMouNKwwKfoVW5r6pnXNBq56HlbR6xSXF4VhWTO1/frSfTLk0Vhm7+qG1wOh2+s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVUPR04MB12195.eurprd04.prod.outlook.com (2603:10a6:150:33e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 13:26:07 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:26:06 +0000
Message-ID: <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
Date: Mon, 28 Sep 2026 15:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0093.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVUPR04MB12195:EE_
X-MS-Office365-Filtering-Correlation-Id: 64403654-7237-4ba2-5558-08df1d640d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|3023799007|6133799003|7136999003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|17002099007;
X-Microsoft-Antispam-Message-Info: wTBcgcNl7efSsQBwpyVrdCcF2OC1MEQdNPsex1O7ULMBizudnlP8OOMB9S3HYpsiTsO2D524N/2+udNw3vuFAiNMBflea3y62DP6Pn/WKzQjxJQUH62Hhe47D27F2ZQbjznqMbHavjwAmk77sk9UxDUv7CCyUkyGbj8BCH9afA4SmzmDgGAdvmDoDlt6cNbw+U4yjB3X4GDhPx7/b3l7r5ZpoliPzS+ptWSXMbmSoXNnRBmiXVDYtX1uqNCAtDTIgiNfqGmiXYcn5rgvEqOxNe+hUHGUR2ob8NvnYaiZocBAv1rXN1PfuGWODiAyBHyKd4iuwTP6a7VKOBe+kItrrZBeiAcdgkWZjZz22hCP3Fp63slHNDLaZcTt4eZvnMxHT7ezmNVL9eJUp58ePNra90l6HVatZbv72QTIUW2kwfh9iqkmYvQiuuTEAg8NPk+vyP8pDd4tOaipYKxOiSVO5FtzpnSIS27xvOueiv0xuDgnebEoicO4u79qqazfeBvv14ROCTqc622IQNVCAeZNBg6TcAPUu8/R1nraSlX9lDCDaaLt7ijrzAXpcyruhLuifhQYNV6sM5IpBg2p+h4SLkra0M1lB+6w9ftlzUTZJ9LJmikYAr+GE/2Ks4+vzFU1geLYPdpAZXIaFTAZEm2i/d7Wk2o5mokifwJq8N1EiX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(3023799007)(6133799003)(7136999003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(17002099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnlDYjRlNitndEVGblVmdTJxOFZqa2JYMUw5eDVzYWJtZUdjbWM2dmkrcUY5?=
 =?utf-8?B?akdnMG4zN0lMZGdSQUNRSzFqUjdSVmpCa1NzSE9SOTdTNXJVb3F0UXFvWE50?=
 =?utf-8?B?aEl1KzdSQ0IwWmEyOFo5alFIcEZRMXhPTWIzTUNBczZESnF0dGRVMzJtMEls?=
 =?utf-8?B?d2hHNUtqeXk5Yk1TdFhVVC9IUGlwMEVWYU0xUENjY2gxWm5IMFRFazZNY1VD?=
 =?utf-8?B?NDE4dWJNYW0waWVZSC9UbzhPUlVTTnB2ZmFWbjY1Z3RYd3lpSW91RzV1MUdm?=
 =?utf-8?B?aFVPN2xHa2FrMGNIOXhVRDJsRHZBM09qM3JtSElyeERKd0Yrc3hvTVVFaUVN?=
 =?utf-8?B?Qk9QMXEzc1JPWnZhbE9mNWZpUXp5MmpZZDh2K1haWXJZSmE1L3VmUldMTFgv?=
 =?utf-8?B?KzA3ZVhtbStJMEZKWEZzK09XOW84OHF5a3dRbzlYd3lTNS8veGdBcW00aDBv?=
 =?utf-8?B?NmlDcUYrQTRCbHAzVWpwSVpYTExqVFJaQnVBdm1jNzU1S3M3ZlVDQlNHL0ZC?=
 =?utf-8?B?NlU5ODJvMUpDSFhOM2c0WUt6YlExMCsxN2gwN1hXVzhTTFRpTnVpUlpVeWRB?=
 =?utf-8?B?aG50Z01qSVlnUEkwTGpFSjNZc3gvbjBmZG5Md1lLZWQ1emQ5ODNkTmhlZ2dE?=
 =?utf-8?B?RTh6SDdDc29IaW5yWmR2U0dCYVpwS2gvTG5kSmFvMFh6a0ZIdTJQR3VDZkVN?=
 =?utf-8?B?ZGtqVnh3NEE5aCtRaGpHTS9ENnBSTFExTHd0cTFWczNGc0l1L0lGSXkvdHhp?=
 =?utf-8?B?TWhCZ0pqcDJYU0dEV09BdENPQXRlTDVWbC9tck5mMWRtZHcyKzA5ZWlaaEJO?=
 =?utf-8?B?ZERNUlNzVXZURE5XbFpTb3FZY3dlT1VBWmNKVEhrVXJibFY5UkdseWxzZDVM?=
 =?utf-8?B?K29yUVFkdm5KL1E0YXhYVlNkUTkxZmY4aWhsbXc5b0t2N0F1V2pSaUdPekE0?=
 =?utf-8?B?bDV1K0I5SHBOWFMzSzd3OUFRM3ZuMnVPNzZPL3g2NXZuTzU2WTFaaWFXQ3J4?=
 =?utf-8?B?WDAvSmZTWWVvTFlUQXM3enROeEhnbXJMMmlXUjZ1THVnV2hDL1dYY2p1azYv?=
 =?utf-8?B?NlBqRWpuSmV3a1NQc0N0Q1JCa1lCT090MThIeThteTRjUEFEYTRzL1F5bEJ1?=
 =?utf-8?B?cHVjbUViT0cxQmZBNjNFU3UxaXRub0s1KzAzcG9tYWtqeE5JdHRJdGJWZ0g5?=
 =?utf-8?B?a1JoZkpWOUdPWEtFZGVLSDNnelFmNnlWaktUVzhYREpDbVVjYndUaDBrakJR?=
 =?utf-8?B?WVc5emdxME80WlhPeWhLTmxKV1d3THJlQ1dGbExNeTJpQ2ZONHM0TGZjTVVi?=
 =?utf-8?B?Q1dLSlhERUZEdzY4N2FaVzBURmo3Nkk3WlRISjdyaW41WHU5WjJGZVdvZ3NT?=
 =?utf-8?B?UVltZU5GbmVIclp4djVvMlArRXptbW5lVForaHVva3NtODFtZW5LY3ZPM3Q4?=
 =?utf-8?B?cnpEZGYvWmRjTXJNOFgvbGxwc09hK3JHbXUvM0YrRmdka0NJWDc1RjgrODRO?=
 =?utf-8?B?TE12Z24yZGJwejZLbkhDQUdjak9BMGNINTRLK09wOWk1alI3WmRWU21HN3oz?=
 =?utf-8?B?VEV6THkxNHZ2ejM4TWNscEc5RUtDRkIxbDVJRFcyZVF3bFhtcGhsSXlRQjF0?=
 =?utf-8?B?cFJ5dFZ2RVRFczZpY1dZNUd4MGl1cVpMSm5nbW42WWVDMUo1QXkxRUtzcWdL?=
 =?utf-8?B?eVRwRmIrbEkwSXAzTkxWOGY5eTJQQnVKT0sxaWpLVnhsRklZbk91TC92Q0tj?=
 =?utf-8?B?NHo0S25wZDlVbW0ydDAwVDlqWEJhdHF6dnpqWWtKT1ljczhRV3phY0NmMTVj?=
 =?utf-8?B?aG9JUWZIZGFsSHZQc0RndXNoVVd3S2o0OFlFdGdjY0MzcFZuRDU0TWtoVko4?=
 =?utf-8?B?RkJUN2ZNSHFtR29UbEV5WGh0NWFDcDFJaTN6Mm5VL012YjgwdytjTkdxbFFs?=
 =?utf-8?B?MnlsNGRTaGJCcUR4VzB4UG1LRFhHUlpPZm1XNDk3OXYvNUl6NGcrWG8wc0ov?=
 =?utf-8?B?RExKd1ZMSEdvMDJmMitubUh6UlpNOFI5Mm1mSjUwUDVOUG9pYkZyM1paalhL?=
 =?utf-8?B?VWoyeFd3WEdWcEFVTDYzT2xPVjFSSWRGKzVvV1pzT1QwT2NaT29Oa0ttUklY?=
 =?utf-8?B?RTJZSG9nVGNDNnVhYTdPT2NRVWRnUFB5Y1p3SkIrU21mQXRvMWVQbVM4YUNz?=
 =?utf-8?B?QzBFcmRBWndNa09ZVjY1bW9JK055UDRncFhPTUpLTUlVNFlnS0lLZm5GeW84?=
 =?utf-8?B?RWwzdi83UnNwM2JiOHpYZ2RTdUl3a05hSDN6bG9PbEc2QXpSVDdsTmQwSlNG?=
 =?utf-8?B?OTJYZmRGdWpyc251dVJxZ3JiSWhiSFpESGE5NDUwM0piUzdFa1FFZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 64403654-7237-4ba2-5558-08df1d640d25
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:26:06.6509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzxeWh25J7ZFaFn53I5SJRtRVUmPgaT4UhzATicm+u9MsmuMRcv8re5eljfq6uTSB4Byl4ng/iLLoLdw0KOncTwTZtdRMXsc2tmTpyhCX7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12195
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 7/31/26 7:10 PM, Alexey Charkov wrote:
> When a generated FIT is used to boot Linux directly, bypassing U-Boot
> proper (Falcon mode), there is no runtime code to discover the kernel
> command line and (optional) initrd location and include them in a FDT.
> 
> To facilitate easier preparation of a ready-to-boot FIT, add support for
> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
> the bootargs and initrd location.
> 

This sounds wrong to me. Why should we hardcode those at build time? We 
already do DT fixups in U-Boot proper *at runtime*, so we should 
probably do the same in xPL when booting in Falcon mode instead of 
hardcoding stuff. Since you're aware of this, I'm guessing you decided 
against, but you don't tell us why. I'm a bit worried going with the 
suggested implementation means we'll eventually have a binman node 
property for each DT node/property we want to write/override.

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   tools/binman/entry.py     |   8 ++++
>   tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 111 insertions(+)
> 
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index ce7ef28e94b1..e0dea8bf3a49 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -636,6 +636,14 @@ class Entry(object):
>           self.Detail('GetData: size %s' % to_hex_size(self.data))
>           return self.data
>   
> +    def GetNode(self):
> +        """Get the devicetree node which describes this entry
> +
> +        Returns:
> +            Node: Node for this entry
> +        """
> +        return self._node
> +
>       def GetPaddedData(self, data=None):
>           """Get the data for an entry including any padding
>   
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 32caa03a7e16..750ff5b47ed5 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
>   
>       See :ref:`fdtgrep_filter` for more information.
>   
> +    Patching /chosen into the generated device trees
> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
> +    proper never runs, so its usual runtime /chosen fixups do not happen. Two
> +    optional properties on the `@fdt-SEQ` node make binman patch each generated
> +    device tree at build time:
> +
> +    fit,bootargs
> +        A string written to /chosen/bootargs of every generated device tree
> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
> +        via the preprocessed devicetree source.
> +
> +    fit,initrd
> +        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
> +        Its `load` address and packed size are written to
> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
> +        the device tree's root #address-cells) and reserved in the FDT
> +        memory-reservation map, mirroring fdt_initrd(). If the referenced image
> +        is absent or empty (e.g. an optional initramfs that was not supplied)
> +        the initrd properties are omitted.
> +

This sounds wrong, why would the FDT image node need to know about which 
ramdisk may be used? Shouldn't we rather have a ramdisk property in a 
configuration node, and then patch the FDT based on that information?

Cheers,
Quentin

> +    For example::
> +
> +        images {
> +            @fdt-SEQ {
> +                description = "fdt-NAME";
> +                type = "flat_dt";
> +                compression = "none";
> +                fit,bootargs = "console=ttyS2,1500000 root=/dev/mmcblk0p2";
> +                fit,initrd = "ramdisk";
> +            };
> +        };
> +
>       Generating nodes from an ELF file (split-elf)
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> @@ -749,6 +783,66 @@ class Entry_fit(Entry_section):
>           return self.fdtgrep.create_for_phase(infile, phase, outfile,
>                                                self._remove_props)
>   
> +    def _patch_fdt_chosen(self, data, bootargs, initrd_name):
> +        """Patch /chosen (bootargs and initrd) into an embedded FDT
> +
> +        This writes a kernel command line and/or initramfs location into the
> +        /chosen node of a device tree that binman is about to embed in the FIT.
> +        It is used for Falcon-mode images, where U-Boot proper never runs to
> +        perform these fixups itself.
> +
> +        Args:
> +            data (bytes): Device-tree contents to patch
> +            bootargs (str or None): Command line to store in /chosen/bootargs,
> +                or None to leave the command line unchanged
> +            initrd_name (str or None): Image name of the loadable to use as the
> +                initramfs. Its 'load' address and packed size are written to
> +                /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the
> +                width of the DTB's root #address-cells) and reserved in the FDT
> +                memory-reservation map, mirroring fdt_initrd(). Ignored when the
> +                referenced image is absent or empty, or when None.
> +
> +        Returns:
> +            bytes: The patched device-tree contents
> +
> +        Raises:
> +            ValueError: the referenced image has data but no 'load' address
> +        """
> +        fdt = libfdt.Fdt(bytearray(data))
> +        fdt.resize(fdt.totalsize() + 1024 + (len(bootargs) if bootargs else 0))
> +
> +        chosen = fdt.path_offset('/chosen', libfdt.QUIET_NOTFOUND)
> +        if chosen == -libfdt.FDT_ERR_NOTFOUND:
> +            chosen = fdt.add_subnode(0, 'chosen')
> +
> +        if bootargs:
> +            fdt.setprop_str(chosen, 'bootargs', bootargs)
> +
> +        if initrd_name:
> +            entry = self._priv_entries.get(initrd_name)
> +            initrd = entry.GetData(required=False) if entry else None
> +            size = len(initrd) if initrd else 0
> +            if size:
> +                start = fdt_util.GetInt(entry.GetNode(), 'load')
> +                if start is None:
> +                    self.Raise(f"fit,initrd image '{initrd_name}' has no "
> +                               "'load' address")
> +                end = start + size
> +                # Use the device tree's root #address-cells for the width, as
> +                # fdt_initrd() does (4 bytes per cell)
> +                cells = 4 * libfdt.check_err(
> +                    libfdt.fdt_address_cells(fdt._fdt, 0))
> +                fdt.setprop(chosen, 'linux,initrd-start',
> +                            start.to_bytes(cells, 'big'))
> +                fdt.setprop(chosen, 'linux,initrd-end',
> +                            end.to_bytes(cells, 'big'))
> +                # Reserve the initramfs region so the kernel does not reuse it
> +                libfdt.check_err(
> +                    libfdt.fdt_add_mem_rsv(fdt._fdt, start, size))
> +
> +        fdt.pack()
> +        return bytes(fdt.as_bytearray()[:fdt.totalsize()])
> +
>       def _build_input(self):
>           """Finish the FIT by adding the 'data' properties to it
>   
> @@ -857,6 +951,8 @@ class Entry_fit(Entry_section):
>                       else:
>                           fname = tools.get_input_filename(fdt_fname + '.dtb')
>                       fdt_phase = None
> +                    bootargs = None
> +                    initrd_name = None
>                       with fsw.add_node(node_name):
>                           for pname, prop in node.props.items():
>                               if pname == 'fit,firmware':
> @@ -876,6 +972,10 @@ class Entry_fit(Entry_section):
>                                   fsw.property('compatible', prop.bytes)
>                               elif pname == 'fit,fdt-phase':
>                                   fdt_phase = fdt_util.GetString(node, pname)
> +                            elif pname == 'fit,bootargs':
> +                                bootargs = fdt_util.GetString(node, pname)
> +                            elif pname == 'fit,initrd':
> +                                initrd_name = fdt_util.GetString(node, pname)
>                               elif pname.startswith('fit,'):
>                                   self._raise_subnode(
>                                       node, f"Unknown directive '{pname}'")
> @@ -896,6 +996,9 @@ class Entry_fit(Entry_section):
>                                   data = tools.read_file(phase_fname)
>                               else:
>                                   data = tools.read_file(fname)
> +                            if bootargs is not None or initrd_name is not None:
> +                                data = self._patch_fdt_chosen(data, bootargs,
> +                                                              initrd_name)
>                               fsw.property('data', data)
>   
>                           for subnode in node.subnodes:
> 

