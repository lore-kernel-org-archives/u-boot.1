Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70620CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BCA760AF6;
	Tue, 29 Sep 2026 12:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ET-k9SdMTDsX; Tue, 29 Sep 2026 12:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E31FD60809
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790686383;
	b=bT4ySYwPif1N1MT6FRYEJN1OSftAoogsA9J5BlDlmLhAJrIuPx+cJozVu3GBJG4WKXKu
	 KM0THKc71UKui+9eEDVPqRjYi4J0bpWATHblPWjLqinPggAeWm3Lcy1W3cRiDOZhvhYuL
	 jfBAXIKD97A3yluLcr05hrsfCZPpgTRYjXDHpMjh6bGt0SDhikkXaX8vPdTyltk835i8z
	 L2lKLi92SSCxyvnDPnRHZIz4k5pXA3TFNR8DAaSgDCJ2LnK14LHNdUdzd5fHDSJmgroxL
	 NTCQnNX3STANkZ5BCC99asOmo/DwH0F7UBeGJi1XVE7H6pJqgtRRlNb8m4Z6eoDjxMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686383;
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
	bh=Z/bl+/eaJHueLs3AWkEP/1Czuy8/ru6rgXSbAl/fqOE=;
	b=MP8L3DVlF5L/LmfB7551gHRXFZ1tHDHkaAVnR46WZA10bLwJcAQFemmhdwQNHGdJ+TFG
	 uysfI+aotb6BmARAM6jgWm7fe0DAWwfafyOQ1pjliqtlollXw0KvRJ45eUkPgW53LbGK1
	 I8riaeaV6LlcyTOcIhhgp42SRYMEsvTiWtm6HO8A264JBPeD92HPbEENMk+29YuyMeDbw
	 IqyUSt2Vpt4CT7UOj0vd0U2nDQQ2Ou/JKAtz/8fgVxhN1HGtap6ZgqJ4HEz8NdHOPu078
	 V78yYtjOJhoS6TWHlqs4Uy8d32NrWgUp/lEUX/7wR95u3hL4o1wRbtpZMZvTIgwyfWw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="cYM24Sa/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686383;
	bh=Z/bl+/eaJHueLs3AWkEP/1Czuy8/ru6rgXSbAl/fqOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAhTIMAzrX8at1BgSJy2FnJsnCYZOLs2chy4HrmXmRMvj17gQllK6JC9D6ONJ12pb
	 GbldM1nU+XkG8gT6v170N1EC6F/Um3+PfsB7nouVhM/fn3UXYZKRPFh3NvNyj5YNQJ
	 s0r8jRW6QwcFhhRrG4aNeAhjJwDJSxudKoNefA5DZOS5d8lFh3ccRbj2XWTXs3GhMD
	 jE1USLwDN6FPK0T6OUDq/UtBwmj6/UoYyFy1vR9GEf08QzTFYud32XcQLFziuuvy4k
	 SKkzEpFuwubuUI3VGPpCdYan4N2UN7r3QlwxS66tUH/lKqc9g7u9TrfbHt1VSp4bft
	 bJggu4IcyxVSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E31FD60809;
	Tue, 29 Sep 2026 12:53:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C8C361
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11DF76074E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXwS7NIR3Wkc for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1741A605D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790677091;
 b=WNzcRhyONDeTYwJuj863WbxfSWEwymd/TtXMoVEt8K0TCzW3NutC0HONLeqoWuyu7o2Y
 J9h3OUPo8ibd61b5c0rhL0L18u3btOJa8Xuv+KehZq3t/Se5+0dfGIQB8KYLa5jGfgrgL
 BppN4rRBKojS0hH09UwJmXqEuumDkInNBq5XwwXqCOtdYsvFevSPsRQbBWgCtmi5gilHM
 4CMPB7wA85pzUV5rYC/SRcrCvRSUX7wERc0IDaW0LfOyh+X5lCnPnKN90RuYCkl6SEijN
 3OHdzbtybGW5iH5FG0rDLK8zQnlZWq4O3Bost6b9hX3AXITNuwb1VK5GK140HGrc4Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790677091;
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
 bh=Z/bl+/eaJHueLs3AWkEP/1Czuy8/ru6rgXSbAl/fqOE=;
 b=nD3zA6id8qe1K5wC2jbOFGv8mxcqg7bXfb9cZDZVjAka5P1OFYutlbyWo/T+5gftBMB8
 dm5lLikat6FEJEpWHoL5Dq9XkuBIWf7EDNPoeGr30uBKBYsE3Drrm3PpDAlOnvEDuYJDS
 V9ja7PSsivOG4+3TyhREukXlzS850EYZnpuFEx54vkaZWaAedZmB7OQ4TndcfhGAivsKV
 rlhQwsWKnjXfkHpcm8i5LJVfqVVGDuT+KovVzfS+nKpPoj0pQoXTg8GSwRTHs3LLDvNWS
 tFnzU9DO/ECwGFCuqLPd6wRTGf3Who48ZoWpp+uMrsQHf8AQ84ZInnIJL/BRy+3sEYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="cYM24Sa/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cYM24Sa/
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1741A605D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXncMmmXwxiun8lVs8n/jH7CTE5v93SV7Wp9/UW9sOTkHfjs3AJXAAvn/tQr85xgeqj9w80HQqrcEgKbgqhsZg+cJvH775LwWCcE9+TWBlhuoJcx66hhQqhlblHgE+T5XUzURuNW2bBo2aZ7fYcWlii2de0WoaZhP7CPGJWcOfgN+H0qoJx+l8RQxD2aibmmTlhnkknzOHJ5+j+fQRCbfXpEmyWciaXjUdaUj2/VIjoxqxEUBgc54vAAPORHFJVLEz/zLZQo9TF8LAhXprZfDLIDLXdra99B0SOzsRcgxxeq/OWZsbLCi5zwSUwj3rzA/ryN35T4CuSi8LyMmiIdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/bl+/eaJHueLs3AWkEP/1Czuy8/ru6rgXSbAl/fqOE=;
 b=gAjs+XRV0D8FXiDifmt/PRPlrz7ulN6+jMJTru6gW6OXn4UujT7s/oPGJo3aDw1Hfky8FBaLVsVyTAciNfrNzXjnuxFaw2As610X7zMcP337HH6euQ8foTiv8hm7ALfEGhQ+M079KimfQarVQWDc/RRdWwAOqHV5mgTSuov4b+QKfi8OEGNtdGP6iWEl8Gn76IBiRpLSQHuD0S5v+dYAXG/TmXsKlLb/qt/HYhryia9D51lE13kVd0czBuA7KvtPwyYpxtkU/TXD/mnRVQNT2Jjkc0+pG60yYj1/Kpt2vcjQcF5DFqU4TyYYiPLaJQCLuvSym9qpMFC47iOaRy9v8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/bl+/eaJHueLs3AWkEP/1Czuy8/ru6rgXSbAl/fqOE=;
 b=cYM24Sa//LYZkSogZC/sS1UmHf5dF/4TbL0stfgqAQmfZEc7Ba69fOiAqgEYB8YajUUduQ4ngryU8QH1QYRink2ctIMncOg15WaElXRkw5oulMZ6ime9UFYW44TRgBN1JOX3xZb/farqmLss8f/169tRwWOyHVSWmiX1BmyQMGs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA2PR04MB10087.eurprd04.prod.outlook.com (2603:10a6:102:40b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:18:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 10:18:00 +0000
Message-ID: <d5fce5c1-0661-4449-aefb-dc0eb960a71b@cherry.de>
Date: Tue, 29 Sep 2026 12:17:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Andrew Davis <afd@ti.com>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>,
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
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
 <da1e4a57-a511-4e6e-9f53-8e781b9a334b@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <da1e4a57-a511-4e6e-9f53-8e781b9a334b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:802:16::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA2PR04MB10087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc7b6c9-e7c9-4470-90e5-08df1e12f09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NFROTdBXxN5ToIW8pA4B4ieNxbGXfrIbnyKfexogmfdc9C2IbUGw7ptWM3hULJc2yk9UA3kMvUWqAfeg0wpuz5YIqqrSEy373be0njXSA7kOQnbUJEKlF9WTVXkBk5C66G83ezs0Wr4G6uBSjpUtID8zpf9BmWNXm5wy+36UBfDMBKtZvi1SAOinQgi611zbUdop1yBATy4OzGmudBdEI+PoFRC7NJWmO3xWjq5rPg0Mlj0f97ATL/+wJl1wjvWExVqt0WvXgFjDzMT2XK2ayA0NbhB5NiP5b6IkYrTMyAwCsKO26WpyYoAxRHz0GfVp3wN1U/JN0eePdPWbnJE2LT+7wZHiIMxY2ThS07VplpGm1n2MuKPjZfWg5JPluU5+2h1xhSU7dGjHZnm/Q9BqQ4yUYVdECO74yA52VeF4BkeZ+G8e8hXoMJmo40WzmacLIgJSkx84Co8G4+y+O7RWyJjg1sAXk+4eCyGmUx3F//VDDrJltsPdQ2HA5TpdgaOkGqNqsm2KnbfNR1sJJ66ffMuWXQgFMzxfaiK245Q+EZB75a9WIhQBCvBCHEnqhSXtFzmE7oi988OG0TEHzLtGjDDglYKCYDaMnRKSe+K0N03NsAnwmGCxJLQq8t3sEv1gCJMNdD9kM35pketPl5Gv0OtyeHqTvMwHAraxZNGJSfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDYvWitFcW45enltTTZKK243RXNiSHNZZi9oamxNU3puUE5OdVpOdytPOHZJ?=
 =?utf-8?B?VHFRU1ZHWk5ORzFHK29YcDN0clNkMWR3aHcyK2N2ZmdDMU5VNzdyZjZIU0Mz?=
 =?utf-8?B?aUJiVTRYYlBiQXI4YmZNRlV2RXZ6U1l1dFVFN25lNGxzRmpTTTNXa0h5M1NX?=
 =?utf-8?B?Mjk2OEwxTHZUa0FKNWh2WkRac0VGVnRtNzRpNDRsdnB6b2hTWkJCb0xoOVlK?=
 =?utf-8?B?dU5vTkhteG8yM1FvQU9RQU1KS21QWTlqWUNIMWphR0JHMkhwdWFRVnEzQnNU?=
 =?utf-8?B?U2MxbUlPVnZ0WnhrckdQcGRqU0Zta1JXUmhuM2RBVlRjNkZPSnpFbTNtb1Fk?=
 =?utf-8?B?a2JON20rSnBwWVQ0VTlkMW92allUcDdIMGVRZFFEMWo3TzJ0cXh4MDVEcURk?=
 =?utf-8?B?bllaR1luRDVtMUVQMXBjTTA2Q2N3ZlQ1LzlmeVd2NnJzM0xBTUoydksxd1Zm?=
 =?utf-8?B?Q1pieXBpOGRvb25BQ2lLTFNZV051Sm1PVTk1dnF0cXJYUUhLQzFvM0Z3ZUwv?=
 =?utf-8?B?NFFOdTJhOXZTZ2xtb1FaaTQxQm4zVkQxOUw3Y0ZXSS9lbTBISkg4VkRFNkVJ?=
 =?utf-8?B?T25Tak1rUSt1cEFDZlY0R1duWm9TOXJvczJSWitoNnlkYUplWUVQdC9SbEZ0?=
 =?utf-8?B?ME9tS0JjczdKSno1Uk5wcHE5R0ZaT1N2K2xMby85L1JQemtKTTdqT3dZMnV3?=
 =?utf-8?B?c0pJR29VbURvOFIvdDNQTVJQRG53c1dpZTV5TWhFcE1ab2hQUTE3VElMdVN1?=
 =?utf-8?B?RjJDU1A5aXpQeGU4bzloZldNalNrejI4WVhtdnI0WlRnMEFoOVZFeW9VSS9x?=
 =?utf-8?B?djFBRkFBT29BNDNsOHVnQXhYUmlwS255YTVpeWpHYVpXUzBXSU8vTG1ybCtm?=
 =?utf-8?B?ak80NWtkVnBDZnROT2FDaVNIVXFOdXNwcXFsQ2U2Vnh2WDQwVlk5R0lnd1A2?=
 =?utf-8?B?M0ErT1J1cWsrdjFQY0JqZFNGMzFqbE9IcXkyL2V0bnpwRll0UzNQekx3WVd1?=
 =?utf-8?B?SEsrQllDckNPQlMreGNqdUZsN1pFK094MDQ3M3R0YXZMQ3VjcXVFaHJvaElH?=
 =?utf-8?B?Rmlyd2dOZ1JtRjVscFBGUFlpRHZjMFBvVVVkMmVjRXJ1YU5yeE1hLysvdUlp?=
 =?utf-8?B?NGh4dmVLVWdEVGNDV3FiQU16Uk9leGp3cFFTY3hpOERnWVI4NE4walpLeUpZ?=
 =?utf-8?B?S1BvY2VUaXp2a0Fud0I2Q04zdGtqMnUrdGplRDQvU2gyTU5vY1ZOSGdtY3NJ?=
 =?utf-8?B?bDFiemZqMU5PT1VXOUQxU0xCUEZJdXczQzQzOHdNQXNhQmpjVVoxNUpiMndn?=
 =?utf-8?B?SGp3VStKanpFMHBSVy9sUFFxb1Z2Rk54MG8xUXhpVFIxSHVPZWRKTCtkYjJU?=
 =?utf-8?B?ait0dDNmanlpdGxxeUJTenlqWVhpaE42L3Y0cWhKY3BCYlJWZlo5UkFLa2V2?=
 =?utf-8?B?QUgvK3ZtcDV2ZWUyQW1iK3N0Q3M1L3VLWktvMDUrV1dOZHRMeGRoenFjU1k5?=
 =?utf-8?B?Mjg2ZUNSRm9kRVlSLzhjaFh0RWtpSmU0d0cwSWJqclFrYkpJSVJZajBNdHVI?=
 =?utf-8?B?bFVvS29zZGRWYjhrTXdIbFpvZ05OcFlGT2hvZjRqTVRBYk5NU0hYNGNjb1Bl?=
 =?utf-8?B?NkZBQURUSS82d2sxbDR0b1JWZEpuc3B5MWxvZ1ZsTW9ieFVBSnRGb3RaNDFp?=
 =?utf-8?B?dDRpeUc3d1BpejJLZitneG9YOE5CWG4wVWJJRkRjdDFHWXd4VHBHZjFESjhC?=
 =?utf-8?B?bnFFbU1RNVY4c3hQdHlCZkM3V2RHQWR4Z0VPSGRQYXhidDV2dlRFcEl3ek9i?=
 =?utf-8?B?SXM3VkF2aDFwRTBxbHRLcS9XL2pjZG1BR1YyRVBMSDBmbDRoRUtraE9ZeURS?=
 =?utf-8?B?Y2lVakxWME0raE5zeFlOVnZZTHg5eERpRGI3T2l0RUZyaWF2aUZRNEtKWTNQ?=
 =?utf-8?B?MGxDZUdGZXd5eUkreHhNMmZJSytQQ2JEak9PRnhlYk52VlZ6dGgrQUlKZmls?=
 =?utf-8?B?SFRBRkJBWEluM2ZYb0NmeGNTektqMlUzRHFCSWRIKzNmNVdzQ3kwNmVLb0Fv?=
 =?utf-8?B?U1JQakFjL0hqSStzR1ZTRTYxTyt4cmhDSEgwUlBaSDZYSVAxNitEanJFZzJr?=
 =?utf-8?B?UDQyMHM0bkRGeHdVc0R5RFFZdGlZTzh4azJRMXkycWdoSytxMUd6L0ZKRjdx?=
 =?utf-8?B?ZFJtVkw5ZU4vQzdiS3VFKzgxTnY0VEM2UEU5UitDUFNxeWZJSnUwZ05ZV1Fk?=
 =?utf-8?B?eVRQZGc5bUZWaGFkYWwrOXZNdjhsS25yalBqRFJHZ3lyUmlQajhVSG9KbXRi?=
 =?utf-8?B?Mzh6SytaZVBuSXhXSXJhWW1JTU4vYVZCYlFVVElSTzBVaUl6UEpVTmN0NFVq?=
 =?utf-8?Q?ZCgtCcI6S0ykXyzDDZN/KEKlxC6TL03wVsSUUQrrXnffl?=
X-MS-Exchange-AntiSpam-MessageData-1: jVSbD2sTut6sFs2lrn+GtXWZtmmLmBhNjAw=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc7b6c9-e7c9-4470-90e5-08df1e12f09d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:18:00.6406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNhNUEQfvjF0bfBMr8F2DKy6ikMyETwdh+AGv1ugvu0SI/Gnu6efGYwtl9ENulF41bp/zMFCJ8hp8eU9h6oFGHYQ7GhsRzBWAboCvBDQWJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10087
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

Hi Andrew,

On 9/28/26 6:33 PM, Andrew Davis wrote:
> On 9/28/26 10:14 AM, Quentin Schulz wrote:
>> Hi Alexey,
>>
>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
[...]
>> Honestly, all those concerns could be alleviated if we had binman as 
>> an external (to U-Boot) tool, then I wouldn't need to care about what 
>> you do with it. There was some discussions about which tools to move 
>> out of U-Boot's scope and we started with patman but binman was also 
>> on the table. Neha Malcom Francis suggested it could be useful to 
>> other projects, c.f. https://lore.kernel.org/u-boot/ 
>> f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com/
>>
> 
> Just to provide some more info on the need for binman as an external 
> tool. We (TI)
> had all the boot image packaging, signing, blob fetching, etc. as an 
> external tool
> originally[0]. We moved all this into binman with the hope that someday 
> it could be
> factored out into a standalone tool for use by other projects. Like was 
> done with
> the tools in `u-boot-tools` package. And like that project this doesn't 
> require the
> source itself to live externally to the U-Boot repo either, just that 
> binman can be
> used outside of a U-Boot context (not so strongly coupled to the U-Boot 
> build and DTS
> files).
> 
> One such use would be in Zephyr where we are trying to build standalone 
> bootable
> images. Without pulling all of U-Boot in as a Zephyr module, this is 
> currently
> requiring us to duplicate all this binman logic/scripting into the 
> Zephyr repo[1].
> 
> Not sure what the next steps would be in making this happen, but it 
> would have ours
> (and probably many others) full support.
> 

I would recommend to either answer to 
https://lore.kernel.org/u-boot/CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com/ 
or start a new thread specifically targeting binman. While we could 
easily remove patman from U-Boot source code as there are other tools 
that can replace most of what it does (e.g. b4) and have it live in 
another location, binman is a required part of the build for many 
architectures in U-Boot so it needs a bit more thinking and preparing. 
Being able to keep it in U-Boot sources would make this easier (and 
could be a transition phase if in the future we want to have it a 
separate project for some reason).

One issue I see is that we technically have only one maintainer for 
binman at the moment, with Simon and the situation is (was?) complicated 
at the moment. I'm not trying to restart a discussion on that topic, I 
just want to highlight the reality of it. Alper hasn't been seen active 
for years as far as I could tell.

So I think we need some sort of list of issues you've identified that 
made using binman outside of U-boot difficult. We need to have more 
people/companies willing to invest time into binman maintainership 
(sending patches is nice but we also need reviewers). If we keep binman 
in-tree, we also need a way to make sure we don't tightly couple it to 
U-Boot again once we have fixed the current issues.
I'm suspecting someone who needs binman outside of U-Boot will need to 
put in the work as we are in the situation where binman works for us so 
there isn't pressure adapting it, but hopefully it piques someone else's 
interest and you can share the work load :)

Cheers,
Quentin
