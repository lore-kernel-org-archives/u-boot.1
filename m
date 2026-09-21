Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C716AC982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67E4B4071F;
	Mon, 21 Sep 2026 14:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HAsuVwW0k0i; Mon, 21 Sep 2026 14:14:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 962504070D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790000083;
	b=mXudxSkFicakurhsWqNXDtg8kHLWf/3uws+aM8RqZeIWyoeHo3bMQ8wjr3NZU1IgUiQa
	 I92UyBlJoRfYOBSZ03ixyjR3eud3XFgbinbHFKKGCmRE0ON/9bfEN7oDGKeQMhZSuRA6n
	 LDlcSWvvIucMmAdXQEDRTWsz5qf4HnFPpUempQUc5MsH9heAuQ9ZmydzfqGV4HkYFx6qr
	 6pPLTbeP205VyGBPplkZxXy5i46qIhf/MCnkcNu1JNhN81jVkIJWNMCvZoZuLUsi+wuVx
	 WcauSnEaQv1mvqh+gWhprK42bK2qTXVT9tOh0y6kVlAFqbYEqBJVLMb5/IpIv/oNkKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790000083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mhA2ITliAkodHNzpC8fVfi7MQIwb8aDatZ1QWTU5OXw=;
	b=eTPHyau4suN8pCOZBROhWbgOBxO73dDBTlYtGHWjQl7XdjWPayovv6DCAm+VxnuoHy4r
	 7NCcenB4r+RIBNnwuH58XGUCy1Q7g2Y+TD768bG3LuxoV88IOGj+A/5PpkbICpGKfeEZH
	 gmsfEM452hfbBwHg7AzxwMB6psClNKE92iZJnRraxtMYhmzBLgMt4oqABVEACoI0HinWO
	 gLXJdWZrGKrRi1BBdQwvsD0GxM+R6yisKloW2pljCscuumr8CFeiAJPkRXUcayOhNPAGT
	 SKuPSxYQ10sJbq0Ld/yTpcE+HCGOO7/rXnWA3XfCSheyzlhqRh7SQVM6y090ZUYr4mQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790000083;
	bh=mhA2ITliAkodHNzpC8fVfi7MQIwb8aDatZ1QWTU5OXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBCSYYypxzWcrlAc5kFhB7vRlJL7kNQfqZOr6W6yUvmmsTNG3lADLUOBwxfybQtr0
	 xWCoqJ85hbf0JnprjWDj2U+AcqeWOgc6RPuiESHTHxxfBCGEGa7nqOwmQuv8y3n/tK
	 DdcuMVekewiFMTCX3nYDKTTcVkK3NAxwH5/vNmQwXLMQTVGLkxHH/MAJ/3yD2dACiQ
	 VANcFh/O7QW0J8RUp9UhC7KppDHDjzpollA/F9RTRU84BU4SXEINRwmtrcjb22oSYD
	 N058NU6v/OygJi25Tc6AqiuOuTLRl6ZnLm75I1pAtLno3KKBnn8O10R3eUCMBqvdX2
	 Iv3kp6dNl1LDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 962504070D;
	Mon, 21 Sep 2026 14:14:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC6A12EB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1E706060D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_7YrxVn6jve for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4225660601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790000080;
 b=NUbrpe30ujgXSHAK2O7XJuExKwmcGJYEbUqacWV2MZ23VljQrJTfXC+jNmJCu7TeLmEI
 O9NqF8VXOh7+r+WOspu4jsqROdZWa4za3ThI2S/ypYOJ2H1wIKZaeJTDEUAaH+L2RBIHV
 WbY2KmI+4QFbwJKFyOYF1gNePu3In9J1PB/vfKGFYgMNBaU+Zz6XSO9OixmYI3INJs3Bl
 sUXsDW65EG4tutty5DDjgDFs/FMKKUXNkIYYujnEZ8af/jAyVztaeB1+uT0o8p0zEzkHw
 fmvR5ODZniAQ7rIJADdLUSDOSFP+mqvKUVjLqufygP7rNILM4hcaZ16wJFdLzR7d2Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790000080;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=mhA2ITliAkodHNzpC8fVfi7MQIwb8aDatZ1QWTU5OXw=;
 b=W8Letd30GUF30wIBRRpvnORLDwZzsu9Znc+bl+6SPAXxhqZROkKT1sVmfnNZQYgtsfIz
 tL7QGyk0hGUzPhhyqtOR6zA0+DxeUT6GkcTjzgas9/DlvhbpfutDRBEbotAdo8znphhCS
 AWZiCdmJiMKnofYVjpM1jzADeam2Pw4/g8L3Nu9hwQXKr9m/ePMjSl3CXM84TaBC72OeJ
 ZwXGpsFX07O9U0g9zFidljuo1abv9ydMxTSK5l4L7zXUWiyEarvpRyJ8/lgD7OMwWC4Ho
 BFF5ett65o+dV/yHeTbsbSortRrJ4oWfYy9+7I216VR//6fCw6kdq6mMNaS+xJRJahQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LSEvZ77w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LSEvZ77w
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4225660601
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8J1CvNg4spUKLQl7EpAIXlZ440fu4GhoEqnJXsDbptrb+NpZGnfmuIU1pcVhU+csos54r734Gt/4eIDdGtwJ2MEFh9NfDDpiPEjSf6jzqNevffJO7cNumhN/3EkWNAg/xig9bCzJAdsGcV+AGh9VWf9Sv/X+I6u1GsJUaIY0qu+xxZFjyX7a4jjALBQdCYs62XINrqPyojKRBpwggQsLVH5Udg00KHOt7P3eAa9SasJ8ZyvchiDQXbGuE5UygvIw3PWQwgQLMxShIjdAVaT1j2uFjFDcH+G5CEIPHMb3LWoBR8tPoiQ40gSLvtyZ2X8fpJH0uR+/2nFgCtvqNtIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhA2ITliAkodHNzpC8fVfi7MQIwb8aDatZ1QWTU5OXw=;
 b=IgUgkHbAp6eRyy6oW/yTZy/azsbb4dhd04dhN758MRzO6jE5Bea+OPcGsMX9xUThM89PTjLckPymPmYy59LQpXJnB+y1hbZOT1OqEdAeqez+WdPZEXcRyFNuECAudIwM3D0FJjYhJ4GlxZ8/Wit7q7Lx/nSpCfIww5dxGtWXuV70AYm/zlV+mIUb/zK4iildn5RGSu3LBHXaf4A6+QGpBCvQEc4j/QYHnTxEyS8V5D2pEUCTBayraDVBuyGtkoamn3J13V4NGNu34bwfl5Fz5F7yfkls/8zcRJbhKluWb8vgfTJqtLvp9O9vep0smnV7CQw7+sjnJlpuo9Qfxpwy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhA2ITliAkodHNzpC8fVfi7MQIwb8aDatZ1QWTU5OXw=;
 b=LSEvZ77wVvXYhD4xLjDZtnz7eQKr4dWEyzDTDd7Qqw5nuSiquNF78RpFGBLRybw6dNnLAddp8pjIgX6jwjUh9D0j0BNX8yVoRxZdmFWOCF+oDjUAlpCiv5WgOKWvQzhRzP/7kPfQ7Zu3u6QB/z6AHuEgDMJt/0U9Q9PNFOS1PeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 14:14:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:14:31 +0000
Message-ID: <30490adf-01dc-492f-aaf8-e280bc526a24@cherry.de>
Date: Mon, 21 Sep 2026 16:14:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] spl: fit: Generalize compression support
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIVP296CA0004.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::11) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a94f6dc-6691-4e77-6b19-08df17eaa7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|4133799003|10067099003|56012099006|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: xu2VtgHPvW82JOmAx1BAMi5HK5XHeu3EqqQnQp/1GDuYHZysRFnLTbKOfpYtiX6d0T0CbKhhO22+fioiu6+cMaQ3JLTQql7sHYXo1X4pSszjNFOhWrXGJzfy4nStQGrAZH/P7d3cCaCTWY26GzBEk9FMeCB9jTWYoIFOA2x9HtAxJHzcdA7BOMkVgHutPspWFY+OOfdVdKBVyYNyHUKr6Empd2+Gv5OPZ7hzErVH71KR7EjV9F5b7Hj8iFJX3Cn421b5VUSTBool1b02ghJ2xxw/aw1vxE8OxlRbXT8w/GgiiNjoeo6jal9F2dVlz6uQuNTe5ecS9dTX8ZgnWt689qE45S7RAcVZMiZtE5gMlIAT4oroSEK4GIo/LWFNAmBWzMXNewgnwZGEy8cn8Uk4NY9FAcGCyNb+QYbF+bRCbI9csSBWBi4k0doWqqcWUHg5EntGp8guWelamtaYa09d3Lj/rE9nsnC29zbJVzjoLCgomxFS0gwAgjlHB3puHIbaUv5YbbXVw4SX2AVxh5I8Ur13/GLzKndLn5iO+b6d70FnRqp7+Cy2kUz93rtfF1eT6ho0DqZhm6xYMSFnd8rJ7J1+eK1Dtg5HhSCgIf4tSVxYbp57ZZNL4c/6cvvBKnh+rkg4HtBD1GLSsZjSx27X1Jl5ULHB5ZiMh2cC8dgS0Lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MExTTUd0VlB2eDdyWWtlNVNwNHRiV05qaUxZZzk0S0RTUEtnRXRjYmJzbTBx?=
 =?utf-8?B?WGlxRDNSdUMzWXpsaG5XQ2JJc2g5SUdBQTRwUGZKSFl3bDg2SVNzOVFqS1Nm?=
 =?utf-8?B?My8xY3VJOWttMDRqeFdBZFArSnk1cHhjNUpWeWc5Y01iNFRXWExCaUNId3ZF?=
 =?utf-8?B?VXB1RVBCZGtxdHJ1eFdVMUc1ODNoQ2phVTczak41Nmc2a3JEQUFaT2dMSGRv?=
 =?utf-8?B?TS81NWNhYU9GOFRsQjJ5NnlDLytiSVJJeWlYdDZlWEY4VVZLVGtYbTljWmo1?=
 =?utf-8?B?am51REJBWGxEWnQwazNIWS9BODBNdDBDMGxtNTVYMHRsd1ZKWEZWR3NUSTZ4?=
 =?utf-8?B?aFVvT2taaDhyNEI0bmJqUHlGL1dzckJYeHBxL25XVUdkMm1zdk5GN0Y3VjZM?=
 =?utf-8?B?SkFzMlRMZmhjZzV0a09YNVJybmxXQ2tJbTUvK0dnR0pReHdDYmNpTzViMmMz?=
 =?utf-8?B?amtZeS9wOWxhSkRTVnhBc0E2ZGhwUEtvSW81eVoydWJFdk9RZXZzN1J5elo0?=
 =?utf-8?B?VU1iYTlnS1N4b1k1MUdXMWVpUFdaWWZWWjdmUGE5cWpVa3I3dWVhQXpsMXVP?=
 =?utf-8?B?a2ZrU3R4eFpQSERHZmtVdWRZMDAvdHUyaGliQ0pWdXVMVDBhM2k1MVNYUnhm?=
 =?utf-8?B?OEdYaFV2V0IyWEE3NktXNXA2ZG9OMXpIWDV2U2NXVEF3SlNQMW9GVXRrMU5G?=
 =?utf-8?B?YlVCN2JiTWo3MWJqSDRLelVwVk9xaldZNzFpZUd3ZzFOUGYxNksyQkM0TElh?=
 =?utf-8?B?Vk1Yak43WFZ2bVN6VkhubFZZaEQ4Q0laOC9tMmdmd1MvUXN6bWE3QUxBMFJr?=
 =?utf-8?B?aHJudGd4cnNwekNOSmZ6c1crSE9qTm1oS1lISDZiSld5cERHSHVQRnQ0MmRW?=
 =?utf-8?B?N25ZNHFSMGhoTldma2VOV3pjZGlRWlF1SkJycmZONVZ4QkcvQUdTYTVlUTZy?=
 =?utf-8?B?cWtueUcyMlR3Y0xYOUdBTEtjcC9TbExHSWVZakJVS0EwblZQbHJrVmx0V3hY?=
 =?utf-8?B?T2l5NUNUSXhMTEJ3Rm9BMG8rd3dvV3hhVkc3MC9XTURIL1o3bFo0TnFxcm1P?=
 =?utf-8?B?TzZHS3V5VUZTbVVZckZOcVNteDl0Si9vSG4rQUwxa3htM0pOOEZSTURYTEFZ?=
 =?utf-8?B?Mm5Hem5HMEVaQlJ4dU5uempTLzRncThvVWVTamdtWUZ6eUwzaFIvd0ZkSkFB?=
 =?utf-8?B?WlB2cmx5TU1qT1FqZEdKNlFBVGtBb0R6cjRxelc5dTFJZC9GZENQUnQ4TlJw?=
 =?utf-8?B?RkV1UnpXQ0xxQzN0RW9LWjk4NXJjSEtGaHYvTzhvZjJheDQvZGZ1d0IwUmlN?=
 =?utf-8?B?VTdLYVAvV09qUVIwNHc4dmtFcGpnRFJSN3RPYzZzSXN0TmtKTHFJckNGZDZa?=
 =?utf-8?B?R09reHFQZTNnWnU3c21NdFVWWTlGaHNHazBpOVAwZ2E2ME9FRHhtVTduUWdW?=
 =?utf-8?B?T3BuRHdRRjRYNHpGUmJwdzFnelFhSjd6RUNlQ3ZEMG56VkRHSGxQRU5zUm1q?=
 =?utf-8?B?NyttUGlid05UdkNoaGRaMXYzdWU5Z2ltU0ZhUDU1NU5uV1E0cVdzRkhFMk5T?=
 =?utf-8?B?cDMwR2tPTUpSaVV5TEEvMDFnMTZYcWZpdko4S3ZmOU9iUFl3OXU5bUg5VjZG?=
 =?utf-8?B?WnZTRGtwdlI5K1ZkTWdiV3FmSUFSdFpycThBYytzVVpIN0dCeGdkRmVuOXZN?=
 =?utf-8?B?R24zQ0dQRFR5ZDZDN0lYc0xHN0NZem5wN2t2RGgxYnc3ME5TYTAwdkhvcHF1?=
 =?utf-8?B?VGdaMHJvcUNldE5NaFVQNXgvTlYrMlFNbEpNb3RkcTI1dVoySDZraWozTE5w?=
 =?utf-8?B?ZkFFenFFOGVOT1huSFUrdWpVOGNjRk83ZzVCRTdTaysyWHpUOXBsZ0IwQmc0?=
 =?utf-8?B?YjhPMFNnbmFFeTY2ekgyNkVLM05EZTM1a3JNeWpDdll2UzdjRTV4TFRJMFll?=
 =?utf-8?B?cGt3QVg0L3hEaWJLcmJjWVhCYlJ5TVJMNEtYK3dOMndxNnZEeW1oSFgzOEtn?=
 =?utf-8?B?UjBoOUZKcTNHTmF2THhTVEVLOXI5YTRWNjM4N1RWYnRrcUZHZDQyUUJKcC82?=
 =?utf-8?B?NUhScXZrczJ4WHdJdEdtclFaUDlrVC9XZzFvT0pkUm9ucjZoUEwralU3NVlM?=
 =?utf-8?B?bTFWR0tvSFBVQTVDQnZuRFV5VUxQYjNrTVUwWHRuNEpFUEZJbW50SStzNVBs?=
 =?utf-8?B?M1JaMHp0MldmYnRweG5LYXYyMUdubmo1bDRqRXVuQTF1aFZQTlNYc0tpN3Ay?=
 =?utf-8?B?dm5OdGtHTm45NFV5TENyY3JaWFY2ajJRVytFM1lmOXdiYkl0ZisyaitleFJX?=
 =?utf-8?B?c2hGdkJ5T2xTUFBzcmpIY0RSN1Z6RXExd1dEVmVtaFJhUW5lSDNIdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a94f6dc-6691-4e77-6b19-08df17eaa7e2
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:14:31.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhIwzdHiWaCxufZjc3evWyeNv3Wp7L+w7EbaJX+Geu4YE/uot6KMSFje8N7VLUbjkmGYQAbiohSp0ydutoFQCEdpxuwY7B6zb+iWDFGuewk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
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

On 9/18/26 12:52 PM, Alexey Charkov wrote:
> SPL knows about multiple compression algorithms, but only two are
> hand-rolled into the simple FIT loading code, in spite of a nice ready
> made helper already being available right there.
> 
> Generalize the compressed FIT handling code to accept any compression
> algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
> requires xxhash in the SPL but which was absent to date.
> 
> While here, also extend binman to support passing a compression level via
> its image templates, which helps squeeze additional ~15% size savings in
> my testing with Zstd level 19 without impacting decompression speed.
> 
> This is done with Rockchip RK3576 in mind, so a small Rockchip image
> template refactor is included.
> 
> CI passes all green: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1319
> 

Doesn't work on my PX30 Ringneck for any of the supported compression 
algorithms (didn't check lzma as I'm daily driving Fedora and it doesn't 
have lzma_alone binary).

Doesn't work on my RK3399 Puma as well (couldn't check zstd, SPL was too 
big and overlapped with U-Boot FIT, note that Puma is special in that it 
only allows (256-32)KiB for SPL, due to backward compatibility with 
older versions of U-Boot that had U-Boot FIT located at offset 256KiB).

On RK3588 Jaguar, all worked (still didn't check lzma due to reasons 
listed above).

Cheers,
Quentin
