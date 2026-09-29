Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E9CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9507D60B24;
	Tue, 29 Sep 2026 12:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FG3uRvZFnBaK; Tue, 29 Sep 2026 12:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 77F27607F0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790686388;
	b=fLQQ4YuowXia5ewGUY+xOAABeD8Pju6y9QWKLXCXhmLDfkFzntem7iz7EFVOI2zFINfL
	 t4aCNyrMAw9XlNPVnXRvx9i/4c+mMEytMn9WCzRT9jOWx2F2PJPst6UuYIIxrm5ycVbvd
	 5n6/5pf4PyR98v8UmOjRdwvNy3vMhRWC2a8dWqB2RenRIaXfuZrkeEvulMIjaqARKqI9W
	 qrqGk3e4ZhppnT1VGp+z0tq8oZd8EHPYZUADhEJIoELXLj76Nj12HZIygHuOVaKx5QCeZ
	 MrAo1/O4A7thKiUpOZ3JZUWzB/7ODhmrHwaZsisgISbvkxGVeZz+KrwhTex0Dm4dYFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686388;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=xrvBD4uk+tom8SyMXm5mrthlWVqC+gt7sB+ms4CM/u0=;
	b=jCqNrzJCQJLI5PoJ0ayiwL89DGNwY2sJXIOPeu2rzVs7T0JW7MKCAVAaQyqieZcKpbMA
	 T+KURF3NMtCXQzaaW1C8eOdTgDrpbxFFkOOywocqzcrjAPdU2e30bByHYYPVSsPg7pRLY
	 OItQnII1M6ITrDWAgpAVPN8LDDjtHVoKBFSTQ4XarsJ7/JY2ec82KjhxA9TN80IC5QIkx
	 fwgyJQl20I2jvQA/AlfREEG3ppzix0Sr1t47mlAYAzMA5iaU1UFBYo/4bBWuoxcqCND9P
	 EDvyhWac9MGbnlHTB1OS+tBwfqhrmj5b2oC6SNAqxfqPfadyiqsKwE4iwD7tMYDQs6g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686388;
	bh=xrvBD4uk+tom8SyMXm5mrthlWVqC+gt7sB+ms4CM/u0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0ezfzCTUtzKjEL6IcG612eePglMsrSDASK/kYHiLzkE6hEVcBoN88P3GkGpSK7CS
	 u5DZah0NonajPjwDA0iyrh4Y5kcPuDmmcUd3B4OAe63s3PROKqTK7S1wwlPj0cZDwM
	 2s3JG9LK443uJ9GyewogL7x68iNCNOxAoovfqWdqVp/bT7mXcq51R7NVRQIEOJfkIK
	 rMC3hqTXDI9uVvGruETwMvVCpOYWJ9A+4VN4/aZQ4M3WON8aTG0CsEj/tyaTiSAdYE
	 7mbqInlr5LkC49R/WrXcsVerkmB0wO31xkEG6r22cHAzbSVTIzA/6tiebDF0FuCxt4
	 IkQRLifBnea2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F27607F0;
	Tue, 29 Sep 2026 12:53:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C706C32F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC7284069C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JiOCa5gaO5Ka for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D47F8406A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790683406;
 b=kf9Rfoq/q+8tvW+2y2em6zn7Ch3og9bQtxDSIf7TtpW+o8Glpzb9hDm1d5EtNNbFl2BT
 aw1UF+EpdC+c4txE+064IlPGj+wLPl9f5aFftJXsHHosBlpXyFh5c/h+uzKlqcwAOhIZv
 TYItZwXvyIDYnPdpovdLg23NXrhz9KSALlAa7q5Nh+x1pETiZi+wmszhLjVepkHAVop6+
 Dj21ehsbNwMZDVKLZkbanqC7Df1uLu3ZYSJOsNuVusbhcQRZBtoSlYuT9O7ZmuRVzDV3J
 zbda8G0Ds7VlhIYok8R0wXTyVnNCjKR1SBlG1B6HScOar/odksEadxkdwGDHbF+xIIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790683406;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=xrvBD4uk+tom8SyMXm5mrthlWVqC+gt7sB+ms4CM/u0=;
 b=NmVYJKTfk2W8B+QrYQ24RtAqHi+flPBuYcPnXwJIZOJFVNrNjtTVmQUSraJCXEDhSvhh
 vcZNJN3WeizLDVkgussusoNip8oZfLgjD6NPRkx8evhV0ISnZofM5ZyiwB1z/ME3bUPSS
 nDbUY/NrExvullOF6dsDxRvyOpt+aQ4e6s+bm6NcmvVTTX6rlKIqP8I2J6tjsApxz3Pbq
 J5TVjo/ZiY9lt9QHmE4djoF0Wvhbm+26EoNh0fZo7cdp5FStVBfiMDGvQQspDHBLTsOfd
 yXxknuPawBBnqZljCM1JtMYLsiag+7L5KhqaVfj2OjrfwIQxTQ8YRhRo+dqg2UmzTLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=lG+f3Xyh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=lG+f3Xyh
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D47F8406A3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAUpFOUufSPaYB21e95mtGROoh6jXO23nfdHfgyaxI+wu7cM6CP4yTmHGRQ3uSierCWEYcQXv1hYAVmETcWH6BMiwB8wyBaqqKA1+3BKG2693P1q4lAC8XNQoOnxTFhK9CGsInh13KeklL/VKY1d8EKuAPwi+cso2hmdZeam045ImiF+rS2qjGhQTYsuuNm196kloAX0IGRWHy2FGZaecmZeUPZTr4tdHdiRmvZ9jHVVeJikHf8+9f1cTCW9JZcwf2VXV91zEGPGIJKZCuPQBrNffQyAsknH6N9ZKf+WwRM5FGNKMwtF99ziJ6cPnzRk5mpB+DICpYuKFw4CRfUT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrvBD4uk+tom8SyMXm5mrthlWVqC+gt7sB+ms4CM/u0=;
 b=OVoN6aDE5rO2mQDEOCAAbBAyWACc1xLrEKVU1hjZr8vKeQINXXf2n9biZ8kb8ZWgNpwoc7l1yoKHqaoTZqiDBEkYXVZ/x2uuAc0p5DPO67Wp2P+KrFeyI9O3gZJmfmOcF81+FlQVyA+Rf4eYTs05Kb5NwYO416DE9PqZAegjotTkqKmZNt05EnMcu50/s5q4leDSq/ygybgerQhiSeifdtFGw/Sh6JoLKyoKbmyo0ZJQYyF3/KTp/+kGIcsH5PUkkejV2RLKQ+Q6D+iV0TdHQBHRxowp+LRhcxQevU0Ex0qCKu1rSBZWgu+YtenzOA4G6hCH8ekJzXO8r0q7JDCCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrvBD4uk+tom8SyMXm5mrthlWVqC+gt7sB+ms4CM/u0=;
 b=lG+f3XyhTUY/cJl1JpWjcODpFOOGhD7N2NmRubzdb4WcS1po7NQmywByUY9hl+UsBFU03FV9nKDKU4qKY11WbffdUdDVETj4x4aJmzfVCGd79n2IpMC+ITLecyMAkE3u1qN5BAuHRH4w7aBFzwO0zZ7r1a++wL82FtahAV+NbUI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:03:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 12:03:19 +0000
Message-ID: <1cc78fcf-bc97-42bb-ac67-792ad047adc0@cherry.de>
Date: Tue, 29 Sep 2026 14:03:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
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
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
 <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
 <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::29) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd65d1d-65c0-4839-5147-08df1e21a6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|22082099003|18002099003|3023799007|6133799003|10067099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: qtWa4YqrTQpd22ydrsbs5SejFtpRs9JHUus4IQvEC6s3eCOoTDneHd+duZmbTR8KRxJpxG0aQJqpVl7LPvO4FncAQO8wMrLBIMN/cBQFljF+or7++SjLM9DBOSs9OA5hueDLcdna6BkPOVj+g5JgpjYq/IgaQWCH6ATqeyTjP/DYy52ELKPs3DPx9f8tQHibYfisEL3bQss7K+3gZ1WyyT/51mIVaDd2RLITdOzpX3epCHfle1dAktATCWViZDkf7yvfMynlm6sbEDhYsQdFhqdbjnGcThYu6LsjLB0LsEimHkB2rNt2ZhMFMsmiw1MZvZH+oAnZK2EzS7cghQW397kgOn06Of9y3JXKydmLVT0Smzl80dhc3ih584JqU9TzRikF7yr2JedD04bzcc3o/XWYVSaxXpLeeyo8jk5tuRCXfIhLnG9eYDHRkV6TtXaEN+yxrJYWuFyUH6iv1g6xbHkoxYVXTlagHz643jBtrPUw+uaZ3ZugdSNl2dA2yiM847yWD8CeEWediRZA17a7fleozshH1qPX9THBfxu0C1fGzdkPxCjiX8KNWBXbW2lypoeXApaVUOE7ZrLOPIV6I/ZOCyaD5rFTH3gPhZhaygQvWt53ZoUNElRgWLPgTwa7v3tS1PQyC71nhwZPXo9q81i7V8HOTQWZgttdqiA1R5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anF5ei9wRm5ZNmh1d2xyR3RGZmU1R2UzV3JONVMxcU1xNjNjall3WlBOT0VZ?=
 =?utf-8?B?NWZpSXRlc0hIN2xmYWJDNXV1bXZtZXpCM1M1T284M3Z2QjVSMDJTUDRwd2pW?=
 =?utf-8?B?V0Fuck5nN25UbmZmMWdkWFBxZHJuUGUxRFVPMnpEVEwyRzlsR1FrRGVrdkl6?=
 =?utf-8?B?YlpzNEZqWUtCeVdhcldQMXFxYjBWTWQ2NnVhcmxLd0p3NkZBa2FlYThPZ0cv?=
 =?utf-8?B?QzJtd2FhQUlvK3dmelBLQXBQZExmbS9hcmpyZUd4TEs5djBhSlFqNWJtZklH?=
 =?utf-8?B?bmdYYjlPSUZVVjJhVkRjQ0JoUGJZSDVDc0VSZW0zVldmeXppVXJBZGliTVBS?=
 =?utf-8?B?VmZVSjRpck0xejFyMjBaYWJ5ZmZoVU9SK3FlU3J3V2NzWkMyZnJIZkdBb0VR?=
 =?utf-8?B?elNGY0sxTHh5ZHh4d3B2YjdYVldVL2daa0NxZnU0cnF3UEVFeXRSWEs4ZHNZ?=
 =?utf-8?B?VFRnWlc1andUMXVlS0ROWUxDangwcFJKc1V0aW5vckNuWGRxcnE5YTh0VGI5?=
 =?utf-8?B?YnNTUWw3WUJmSTFUZWZCb0ozellpKzNYYjZGbyt5NndzWXZmSjFJSUZEdlQz?=
 =?utf-8?B?Wm1oazdFWTBWeHRiV3Nsa24xMFY3emNPeHkyS3FQU0RmM1hUUmZPQndkb0xp?=
 =?utf-8?B?WTF6ZXc1UGY5eGFwTjFqcVdoWHhwbS8wTityZHJmK2lJT1d3YXNJYTl4bWlL?=
 =?utf-8?B?U2JDbmR1YWVrTDIwMU5BTW00VWFwR0c1TE1LNjJLcHRiQWVKQ1hBWFpoSll6?=
 =?utf-8?B?WUhIbllXRHZCMVpkUDBySlUvU2lvVktSejJEbEw3bTlvbzdBcnJJcitMaDk2?=
 =?utf-8?B?OU5HRmEzYUhrdE45S3hYejZmNG5CNjk1MDU0SitZMzFkU2tNTVBYRjdHRnBI?=
 =?utf-8?B?cXhqVHh4TTdvNmpwYTViUm1EeHU3aFgrSzVvZXUvRUxKNTNmTFhPWjVNb2lG?=
 =?utf-8?B?ZUVvbW9BQnlWM1MzajlkWVBnK0ZNbk9lTzZtTEhIMDVhRkQzUHRiRHhXV0cw?=
 =?utf-8?B?Y0x2NGlRVVRHdXA4QWQ3em1OYW5Jb2R6ZUdOMWcrc1FVV1pETmRqdzdMS0JC?=
 =?utf-8?B?dWFoUVIvN3FwLzBXdHNKZkxmeXNsNmozZDV6T25yTWxpdTJPbklYZ1d3bzJk?=
 =?utf-8?B?cmpPK1ZLb3NXcTU0Y2Z6NS9hSDg3SUY0N2VpRE15aXA1OUpjaUFvVWRhcGpw?=
 =?utf-8?B?ZFlDbjVYWHRLMFQ0MHF6R3BhUlBoQzZ2UlF3UjByRUVwaFhOZUVyaWFNTlZ3?=
 =?utf-8?B?VjNOWWk3dXR0cTAwNEQ4bnJBeDltTHkzSlRQYmhPem1kWVU2WmszTWNIZ0R6?=
 =?utf-8?B?Zy9jeWU4bk10cThOR2Rwek9yaDRKT0lodkNDQXg5a2doRjRCcXJQVG5JT05l?=
 =?utf-8?B?ZGJIYldvNjlMazJKZDk3VGprL1BlM2tPcjR3RXhsa1ZQZWNFSDh3MHZqYThh?=
 =?utf-8?B?b2p1TDNCcHhQdlVwZldRQjNXYlQ4bUxrUzZVd3ZTNUdRaTJHYXNONTJKNnlQ?=
 =?utf-8?B?K1VpOFZ5RmE5TkN2N09sZ0xrZG9RcmRwbFNvTGcxNXhodUl4MEZhKzZ3Ujc1?=
 =?utf-8?B?NitmWlRDaVQwK2JmWnV3OUtvVHJBNy9aQ2hBNHdwZWJSTy9sOC9jWGhDYkE5?=
 =?utf-8?B?RDY3cDYvSHFNSi9rbU5tWFh0VVJ3R1UvNktQcEgrWnhUT0JOekZ4TXBGRE1v?=
 =?utf-8?B?RVZTUnpqMDRyMnFqWXFjd3MzT3hnRUk3UUdQdDJPakJoWEgwVWRKczBDT1ZH?=
 =?utf-8?B?Vno2L3pwSXNsaVY2UmdzOU1sK2U2ZGJuRjg4cmJsc1lRSFN4eGozMVFqWTFZ?=
 =?utf-8?B?bTB4bE1YelVHZ0o5WjU5bnFaYS9LY29aOGNGN2wwcG5sUUxUVXhDaThwOXI1?=
 =?utf-8?B?Q0JmTkpLUWVUU3Q5MHQ2aVQ3MkNSak1adTBDRTQzNW1PbkMrUTNIaFhTUVAx?=
 =?utf-8?B?akRKWHg1MHhCM3M3YVZYY0M5S0c4d0VETWUvRURtMTZmWFNmd0RVQlNzV3RN?=
 =?utf-8?B?OGZPSE1hU243bjNCT3J0MTB3YWx1QTRHN21aMDc4V0cwSWlqaFFPbU1FY21p?=
 =?utf-8?B?NnFnMlFkSUdLSExKV0N2elY1Q1JkUVJXc3VxUEFJWkdsa3gzUUVpVXl1WkIw?=
 =?utf-8?B?Sm5kY2ZoNlJSbDcrSEJjU2M1SEtjOEl6b3RvZmk2S2pNb1ZiNjU0aERmUFd3?=
 =?utf-8?B?NW4vVUNoTUIzVzV0bTVWbGRWSmVQK01hZUtxcTd4SUk1WGFsVzhpY3RxNW1o?=
 =?utf-8?B?am1VZkZkaXVFczhLdFpjQkpKSzgyQ1lmR1M5RTAremNDN0NnMStLWXlRa1J0?=
 =?utf-8?B?QkE2SzdKVHZSMmliTGVmK20rM2h3RW9RR3p5QTFING5hN0NuZHMvWDBzWnJL?=
 =?utf-8?Q?qbWC5DV1M8JE+2zcvmRCZLx0gqs05s6fRJduX1/JfQGlT?=
X-MS-Exchange-AntiSpam-MessageData-1: ED0vcQmHSl6HVfwjRsxzSZmYERZ+otPsKFQ=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd65d1d-65c0-4839-5147-08df1e21a6fb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:03:19.5252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEMudcsI7nyVs8CFtAN/wvLB9pqpo508Q2zxI4TCEzbHla3WndB7TebCH1dDXFmSy2muHn/j4IUQO4hUA0YJt4kUjHoGLzic8kRmmXuBE6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:49 +0000
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



On 9/29/26 1:03 PM, Alexey Charkov wrote:
> On Tue, Sep 29, 2026 at 2:29 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 9/28/26 6:44 PM, Alexey Charkov wrote:
>>> On Mon, Sep 28, 2026 at 7:53 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>>
>>>>
>>>> On 9/28/26 4:03 PM, Alexey Charkov wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On Mon, Sep 28, 2026 at 5:26 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>
>>>>>> Hi Alexey,
>>>>>>
>>>>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>>>>>>> When a generated FIT is used to boot Linux directly, bypassing U-Boot
>>>>>>> proper (Falcon mode), there is no runtime code to discover the kernel
>>>>>>> command line and (optional) initrd location and include them in a FDT.
>>>>>>>
>>>>>>> To facilitate easier preparation of a ready-to-boot FIT, add support for
>>>>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
>>>>>>> the bootargs and initrd location.
>>>>>>>
>>>>>>
>>>>>> This sounds wrong to me. Why should we hardcode those at build time? We
>>>>>> already do DT fixups in U-Boot proper *at runtime*, so we should
>>>>>> probably do the same in xPL when booting in Falcon mode instead of
>>>>>> hardcoding stuff. Since you're aware of this, I'm guessing you decided
>>>>>> against, but you don't tell us why. I'm a bit worried going with the
>>>>>> suggested implementation means we'll eventually have a binman node
>>>>>> property for each DT node/property we want to write/override.
>>>>>
>>>>> The "regular" Falcon way of doing things (i.e. the one not involving
>>>>> TF-A) has so far been: "capture what U-Boot patches into the args to
>>>>> be passed to the kernel, package it into a fixed binary, and boot only
>>>>> that". No runtime fixups. So I more or less followed that pattern, but
>>>>> tried to make it a bit more accessible by eliminating the "capture
>>>>> something at runtime and save it somehow somewhere" step, which I find
>>>>> unnecessarily painful.
>>>>>
>>>>> Maybe runtime fixups could be brought into xPL, but they are
>>>>> excruciatingly slow, whereas speed is the main reason for wanting
>>>>> Falcon mode boot in the first place. Right now with Falcon mode on
>>>>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
>>>>> (i.e. full graphical UI drawn on the screen), whereas the best I could
>>>>> get with U-Boot is just over 3s to its boot menu, much of that time
>>>>> spent going over the flat devicetree before relocation in O(n^2)
>>>>> passes. And those 3s are after stripping the massive pinctrl node with
>>>>> hundreds of its always-present children from the pre-relocation DT,
>>>>> which alone saves ~0.4s.
>>>>>
>>>>
>>>> Are they always present, even with /omit-if-no-ref/ instruction? Or
>>>> maybe you're building the device trees with -@? Trying to figure out if
>>>> somehow we have a bug in dtc (or in our scripts making use of it).
>>>
>>> The problem is that there are a lot of `status = "disabled";` device
>>> nodes referencing pinctrl nodes, which keep dtc from dropping them
>>> altogether, so a lot of unused pin configs end up in the binary -
>>> enough to be noticeable in boot time.
>>>
>>
>> And we cannot really get rid of the status = "disabled" nodes as they
>> may be switched to "enabled" for some reason at runtime by e.g. U-Boot I
>> guess? I'm wondering if this (stripping all nodes which are disabled) is
>> something we could still allow (e.g. gated by a Kconfig symbol).
> 
> Yes, stripping those entirely would break DT overlays and runtime

Base DT for overlays need to be compiled with -@ so you have all symbols 
available, this is something we could detect (presence of /__symbols__ 
node IIRC) and bail out...

> board fixups (e.g. what I do for the Flipper One to switch between
> SATA/PCIe pin modes based on the M.2 key B config pins strapping).
> 

but that would also prevent that kind of things and since you actually 
are already impacted by this, the hack I suggested isn't appealing anyway.

>  From what I understood while investigating those boot delays, it's the
> linear FDT representation in (uncached) pre-relocation memory what
> kills performance when the count of nodes grows to real-world numbers.
> Having a more efficient data structure to hold the tree
> pre-relocation, or enabling D-cache pre-relocation, would both speed
> it up considerably - perhaps more so than trimming the tree itself.
> But going down that road sounds a bit scary.
> 

No experience with cache so big scary word to me indeed ;)

>>>> Don't we have FDT and DM in SPL anyway as that's how we probe drivers in
>>>> that stage (not counting the few SPL-only boards we have)?
>>>
>>> SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
>>> time I counted for my RK3576 use case). Making SPL parse the whole
>>> OS-oriented device tree, along with all the relocations required to
>>> insert stuff at runtime, will hurt.
>>>
>>
>> Ah yes, missed that.
>>
>>>> I don't have anything better to suggest, I'm just really worried about
>>>> the potential ballooning of properties we need to mirror in binman.
>>>>
>>>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>>>> ---
>>>>>>>      tools/binman/entry.py     |   8 ++++
>>>>>>>      tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>      2 files changed, 111 insertions(+)
>>>>>>>
>>>>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
>>>>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
>>>>>>> --- a/tools/binman/entry.py
>>>>>>> +++ b/tools/binman/entry.py
>>>>>>> @@ -636,6 +636,14 @@ class Entry(object):
>>>>>>>              self.Detail('GetData: size %s' % to_hex_size(self.data))
>>>>>>>              return self.data
>>>>>>>
>>>>>>> +    def GetNode(self):
>>>>>>> +        """Get the devicetree node which describes this entry
>>>>>>> +
>>>>>>> +        Returns:
>>>>>>> +            Node: Node for this entry
>>>>>>> +        """
>>>>>>> +        return self._node
>>>>>>> +
>>>>>>>          def GetPaddedData(self, data=None):
>>>>>>>              """Get the data for an entry including any padding
>>>>>>>
>>>>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>>>>>> index 32caa03a7e16..750ff5b47ed5 100644
>>>>>>> --- a/tools/binman/etype/fit.py
>>>>>>> +++ b/tools/binman/etype/fit.py
>>>>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
>>>>>>>
>>>>>>>          See :ref:`fdtgrep_filter` for more information.
>>>>>>>
>>>>>>> +    Patching /chosen into the generated device trees
>>>>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> +
>>>>>>> +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
>>>>>>> +    proper never runs, so its usual runtime /chosen fixups do not happen. Two
>>>>>>> +    optional properties on the `@fdt-SEQ` node make binman patch each generated
>>>>>>> +    device tree at build time:
>>>>>>> +
>>>>>>> +    fit,bootargs
>>>>>>> +        A string written to /chosen/bootargs of every generated device tree
>>>>>>> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
>>>>>>> +        via the preprocessed devicetree source.
>>>>>>> +
>>>>>>> +    fit,initrd
>>>>>>> +        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
>>>>>>> +        Its `load` address and packed size are written to
>>>>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
>>>>>>> +        the device tree's root #address-cells) and reserved in the FDT
>>>>>>> +        memory-reservation map, mirroring fdt_initrd(). If the referenced image
>>>>>>> +        is absent or empty (e.g. an optional initramfs that was not supplied)
>>>>>>> +        the initrd properties are omitted.
>>>>>>> +
>>>>>>
>>>>>> This sounds wrong, why would the FDT image node need to know about which
>>>>>> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
>>>>>> configuration node, and then patch the FDT based on that information?
>>>>>
>>>>> Falcon mode boot where these are useful is for a fixed-configuration
>>>>> boot flow anyway, where one wouldn't have a way to select among
>>>>
>>>> How do you plan on doing A/B with Falcon boot? How do you know from
>>>> which partition the kernel you booted originated so you don't upgrade on
>>>> the currently booted partition? There must be some way for U-Boot SPL to
>>>> tell the kernel at runtime where it came from?
>>>
>>> I don't currently do A/B with Falcon; instead, I rely on the fallback
>>> to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/B
>>> native). Making A/B work with Falcon would be a nice follow-up, but I
>>
>> This means supporting two completely different boot flows with potential
>> side effects (U-Boot proper probing/breaking stuff while Falcon mode
>> doesn't).
> 
> Yep, not ideal. It's all heavy work in progress, so I might still
> rethink the whole approach more than once :)
> 
>>> believe it will require some external metadata to choose the active
>>> boot source anyway - and then the same external metadata can be used
>>> for the upgrade. Such as the UFS device attributes, or whatever people
>>> use for RAUC and such.
>>>
>>
>> I guess you could use a U-Boot environment for that or some more secure
>> location (via OP-TEE/TPM, etc...).
> 
> RPMB with the key managed via OP-TEE backed by hardware secure OTP and
> on-chip crypto would have been great, but it's a mighty detour from
> where we currently stand, so I'm leaving that for desserts :)
> 
>>>>> several ramdisks to go with the kernel image. So putting this
>>>>> information directly where the user (i.e. the kernel) will find it
>>>>> cuts out intermediate steps, which in turn improves speed and reduces
>>>>> complexity.
>>>>
>>>> You already have:
>>>>
>>>> fit,firmware = "atf-1", "kernel", "ramdisk";
>>>> fdt = "fdt-SEQ";
>>>>
>>>> in the configuration node. So simply have binman derive from
>>>> fit,firmware which node is included of type "ramdisk" and fixup the
>>>> device trees in fdt-SEQ based on that info? Less user-prone IMO.
>>>
>>> Ah, I thought you were referring to runtime FDT fixups based on the
>>> selected configuration. Patching it in using binman based on the
>>> configuration node contents should work, too, but what's the practical
>>> benefit? It would still use the same ramdisk node, just written in a
>>> different place - or am I missing something?
>>>
>>
>> Not written in a different place, written in the only place it already
>> is, removing the need for duplicating the info which the user shouldn't
>> have to do.
> 
> I think I start getting what you mean, let me see if I can indeed make
> binman infer which "ramdisk" should go for "ramdisk" and write the
> attributes based on that :)
> 

I'll try to be more concise/explicit next time. Trying to review too 
many things for different projects at once at the moment so I sometimes 
just do "brain to fingers" without putting much more thoughts into it.

>> Re: fit,bootargs, can't you simply have the property included in your
>> -u-boot.dtsi directly, so we don't have to have yet another binman
>> option? I understand this won't work well if we separate binman from
>> U-Boot like talked in a different thread, but we are not there yet.
> 
> That would mean rewriting the .dtsi every time the bootargs need to
> change, which in this setup is just an (already existing) Kconfig
> option. The property is also not useful for U-Boot proper, which would
> inherit it via -u-boot.dtsi. Plus, I'd rather not make the whole
> Falcon thing too board-specific, as then it makes trying it out on a
> different board way more pain than strictly necessary.
> 

You could reuse the Kconfig option in the dtsi. But ACK, no perfect 
solution it seems so far.

Cheers,
Quentin
