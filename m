Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6931DC55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F63C60675;
	Sun,  2 Aug 2026 13:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Mw7wehX5za0; Sun,  2 Aug 2026 13:39:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E26E7605E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677967;
	bh=XPXrbVnZG/QBqEJ3b+UBGoZE4xq+DUV0W/jV1m40Eb4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=elRtCBzRvavZXqSfy/32T88jhLG9VDgszTLr1vrnKtCEnnfyH63cev7R8TcX5wlwG
	 RdmFIr/iSmILvywavdLm6y5LgtKgZDbtQu6awNiX3lzcoYZ78BHlIPB/agu9mxRwWy
	 02NWLHOD+utdp+EC3T+Wp9O6YPVH4LbDdcywzhdNn8Q/dLZ1Rf+siTsGDwQEvDG2oc
	 vA76Jt8xvbHZnvgYKlbSm/0kyWqJZBw6dIOGC9Qvo0sN15Y+fe3xu4EGb3bbu42LS5
	 Wtad/ttBwfFkhA5vnMapNETEkgByuXczjKABolNIU7yoigke3pTWlM04Qtj+PIGz9e
	 dty8zQbznol/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E26E7605E0;
	Sun,  2 Aug 2026 13:39:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D23626C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 13:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63396605E0
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 13:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isXD6zXHA9ne for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 13:39:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mikhail.kshevetskiy@genexis.eu;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0681C605DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0681C605DF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0681C605DF
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 13:39:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D31805D7; Sun,  2 Aug 2026 15:39:19 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D44C980087
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 15:39:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG+1+tmQjmb/U5ajUT8omyeJ/L8+hayUhQmpOdoh85wLIRRNApeczI0Rhn8264x4fLFlGO9IwH5wIzA80e4o6oZ6nH84On6HGrc2qfz4sQ75XMuM0vYqP/PbVBiMd7UwYgahIzt+XMo4cVSUJreVjoP9OOcJ1cmECoNlE8WVn8ft2EE50iE21s4xmA4o/f8Cu/PhiF8vCEVqoGl28wlryCJ2lsPH0QgQIAKpUDD12hqK7k7rfyQpcOG5WqcoA0kC7pljAwWu4GEMQGPwNeKFF3yJzHorPZB2gneawnAWozrt0soT6NVM7f6wgsxEi0TiSDg0KafdyB3gO1yySBVfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPXrbVnZG/QBqEJ3b+UBGoZE4xq+DUV0W/jV1m40Eb4=;
 b=rx0l3KAuOpcW9KsPUGm2YWm5xpKl2rZq6SbXSMHMMFZxmT4YVmEzBqKOyYVW8ir7jTDdATcYYn0tCkiXUTryfEzuvhmmMChguk2xro3qH5NV2gEGWriabvpi4RJ0ub7On5n8UhPI0KJ4+UvKzeN02hHJu/sVYlosfBJiuuugDEez1GKfIz7jByTRWBQaRMmudMO/xMuCeLQ2T5J6ue9S+TLKZIeq3BptJ9CnqGBIYlizmAoljPM3o6jVb5A3kTsdUbTiWcv9Uvn+7kjxs93h1N+ROphXOX2Qz4AznyelQtQiuMr9+S9C/zoUbU+COj+uD54kshiZrV9Mb7B0DQ+gUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB10688.eurprd08.prod.outlook.com (2603:10a6:150:153::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 13:39:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 13:39:08 +0000
Message-ID: <6cad654a-b32e-4852-b7d3-e6e11fd0a4f3@iopsys.eu>
Date: Sun, 2 Aug 2026 16:39:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airoha: add support for Airoha AN7583 SoC
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Julien Masson <jmasson@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20260731065417.2285728-1-ansuelsmth@gmail.com>
Content-Language: en-US, ru-RU
In-Reply-To: <20260731065417.2285728-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBBB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6fb) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c6f0d3-f75e-4f83-4b25-08def09b6d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: I+5PrGz9sEJ7mkc35LN3ukSvAKuf4/wkqSCPX7LbIvjQeTV4EdqqiynBRivOqEWdly3WaR8lbraliJadtpdKz1QreB2o4V+irhX3MlD1wJCR36pXFfKmfDH+Y5ANAXzW1TKyGmtU7pN2hdCD7SiwJlwIFQPyQSFoIagbxT8iRKMYJfy7yEXxf/JbDv8vAbevxocWwx5hVL+yMV6bRlRAyIIiAZquQfagdBBdEPCEWV8fEtzCUqBKj5jQ6XprQeGQbGRXXKbuT11g5w4JhpJAzo8WtWW4AgAbBSIm7XviUYKDZrWSVC9lUuHpqZxvJOhmMJWPLMULrgerKeU47ElTr/vwiIBtVqz0D8mIxpe9UL8pkwwWqkhK/tAZJsG+/Lan1s8nNOkUThbm9KQDohIAqStcKKqFK3StnCl1gAwSQ/6vkmh8aUFyjk9s2LUuQLOGGncWHN6gboIuF1CJHwEzr3pQrzfEwC3vSRAPij3aJ6TAwL32/MCr9bduTdBqp3pax/CLAU7R2UdY1+vNclcVzEy6ZFryIvz8lMD8+hE5PlSfuQylAHv4edvSAxSU3fzoaM3oNEAoCgUJ5Kt6AVTB3UANxF7NaJMcu6DMgegxK02aL575x7QrDD81JyNItjkRGeJMz0oL6MNOQxcVq9rsdG5ZNwnQNOU8ppY7wRmn/c8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGRZS0lqUndLOUV6dTRFV0pzR3JMZm5obUFkMTN5b1hsZ1NVaTJJR3k5dDV0?=
 =?utf-8?B?YVhMUjRxQWRDMzFodzA1cTk0eUdNTkg2eUs4dFQ4cUNsclN1UlB2R0phR0pw?=
 =?utf-8?B?aW8yY25xQVV5OHpqWTBnYnZYZzIyNjVkdERIUXlSYkxtTDc0S1RhU016dUw2?=
 =?utf-8?B?c0ZhQWh6UzhxNUpDYllTOW1LSmhZWFZhbDcrOHZCZTM3VTVwRUYxYUtLNGZu?=
 =?utf-8?B?ZWJEbHFWYkNmNCtJL3dkU2syTWhGWVlLNjN1L3htcEllZmZxWk5lVnQwdC8v?=
 =?utf-8?B?dnFLUkhhR2txblgzN3RBeDFPMnB6TEFvMWVzT203VXhxQXV3Yy9HWUgyQ1lm?=
 =?utf-8?B?dVkxdzMzUWY1ZWlPNnAwMjZ5VnBkd3dPRlNaeFpvYmpIWC9JR3o4VGRTbWhM?=
 =?utf-8?B?OEFTWXdiQ0d1Nk1UbTFEMzVWclNyZDBWbDZuMkUyV29yY2FpUGpQL2d6V21m?=
 =?utf-8?B?dHllbzdzR2hyd3hMQ0xscm5FZlBSTFJYYk5oSlhMSjVodWdoNXJjWVRUUlYv?=
 =?utf-8?B?a0QweWpOd2dldzVOeE5FNmwzS1B3ODd3bGh0L2pFdFN0WWtwSjQySTNLN2JO?=
 =?utf-8?B?clNJdjBkQzdsczAyU2lYa1k2ZGUvVGQ2ZnRGcnY5Slp6eEZuRldWajRMR1Vy?=
 =?utf-8?B?WEJkSDFQQ1hIQXorbWYzMFA5MVJEVWlWM3k2T2hUVWNNT1JxR2ZXM1NYZVUz?=
 =?utf-8?B?bFpxQTFUdVliM2VzTkhlMW1SaEhvZG5GcjJZRk9qekpNTWFhVEljcUdjM2hy?=
 =?utf-8?B?T2cyc0JQOHNIWC9hOG1CM2RLK1lidi80dnlYbnBMN3Z2L0JyUEFnNkJlSGdt?=
 =?utf-8?B?TVVWOEkvMlpmMTgxSldTMDEza1V5VjNoTldaZHpDbUFSZE05QndlR2ZPa09R?=
 =?utf-8?B?WHprWlNDeHQvRHhra2tEVjdGU21QaTdWdlFDZ0k5NGZFVzJGL2lKc3d4WEFG?=
 =?utf-8?B?TzF0WW9BY1dFbFFZWXQ5VWRHSnBGN2lOQ09ONnpERnVlWkx1OW54NEpoVGtY?=
 =?utf-8?B?R2YrTDZRYVhDV0dTaGhEVS9mU2V6c2E5dFdSSTBWNXU1N0dsWnZQNHNzdkc3?=
 =?utf-8?B?SmNQSVUrN2xXSnpYRGNMME1vSDlMZHNTRnVDS2xxYng4dzJzZnZjYWhUMHFH?=
 =?utf-8?B?amI5Wk9aWkI1VXJKc0NjajMzSFBlbGxWVGJOLytsMDd4MWYwWDVuK05yMVk4?=
 =?utf-8?B?WHYycUhmVUJ2ZWhzaWd4cUtnMUZJWUpOY0dPN2FhMlZia0V6RDhxZWg3bC9E?=
 =?utf-8?B?dTVIZERUMHFWU0lvNlN3LzgvY3dYVDNndW1YamdDT3RlUStwc01USFRUcVl0?=
 =?utf-8?B?Vk0xT0RPa1h6U2hoZmRhVi9QbSthMjUwbXhlMjdYL2pJZHJTVzVBUHI5VlFu?=
 =?utf-8?B?RHk2WndhbmtlK21LTFM3a3htVkVpRnRVVmN6M3RaeG5aRXBUQnlQc3o5MVo0?=
 =?utf-8?B?MGs1MDV3T2lKbU5EUHpxYzVIRG5nekZLbHYvMVljanRiQUJtdytIbzk3dTla?=
 =?utf-8?B?T3dKRjZhbENNR1k0RFVxemlPeXFGSzladk0xbDROSG9WVkpwQU9QWm4zT0px?=
 =?utf-8?B?WWtSOExzVlJWWVlQQ1diS3FSSUg3VHZYbCtxTFN5ZDRoTUx1YnJYdDJXTjMz?=
 =?utf-8?B?a0dKT2hvWVdVTmoyNnZlNHI2ZENZbHUxb2dTYU5rQkFPQzMxU0xSSlcvZjJj?=
 =?utf-8?B?SjkyS1hoTXlBYTRYenZzM1dlZ2gvb2NtTDhFQ2tZd3BJd2dYaGVKbjUzVjNO?=
 =?utf-8?B?WThMb2NSVk5icm8wNEdqQlhiU2pWaEFZejByY0lYSmcvVXFnQzBOdzR5eGVQ?=
 =?utf-8?B?RTVJODdSYU5JYVM5WWw4OEo5NGFNTXNzdlhkcHlrYU5ZM0I0Q3N6L1Q5dDZy?=
 =?utf-8?B?bXpiaWhFL21nUEJ2VUZGb1J3Y1Y2bHQwUkpsSHltUmFIdDhtZEc2azJkZzF3?=
 =?utf-8?B?TzF6Q3I2Z3hQc2pObVlQWkJmYnZOOXdjNWtQbkc0NmdKeWhEVDJTK0pBZDd6?=
 =?utf-8?B?R1dIdkhaTVJRU0p5b2pOY2l4WGN1SzNDN3l4aytVTXJ4ekNqSDBuL3ZiS2lm?=
 =?utf-8?B?bHlCSTJqclpHb2Z4M1RjUENTUkFGYnl5d1A3NzROUXRUVUlIL2ZNWG5JOVd5?=
 =?utf-8?B?N3U0NDhhQzE0NWhuN2JJaWNaWjFDWU5uSGwxcmNHYS93R2xCdGNCMkVXYWVx?=
 =?utf-8?B?dENERmJTdkMvREhURGtWUDdud29CTEJpbmMveGlDVEMrOVNsVlc0QlJwN0Rn?=
 =?utf-8?B?K0szYVNXWjBTNDY1enphamZEcEdpaWtyRHFjL0xWbjhGMWtkUkVxZXBFenpT?=
 =?utf-8?B?YlB2V0Ewem5SeVJBcEhpSHFWQjc1bUY5RTZVSzdTMG04UmdSbThLYTFvVGRo?=
 =?utf-8?Q?d7dQuXy1MUcZeu6Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c6f0d3-f75e-4f83-4b25-08def09b6d85
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 13:39:08.2958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9hOqMyiM+w4MsHCD8j5rUnadijnl02ocUk0dulYjM97E7b+JLH1lmIvX8eGN47xAG7DjQQSEw0uTzje7MXSZlz5DUukBir0L364JyU1Fg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10688
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPXrbVnZG/QBqEJ3b+UBGoZE4xq+DUV0W/jV1m40Eb4=;
 b=LIOOdfKv19/xB+zMWxoNnxxMLN5ouFZN9eLmwn5s9ZQ3pejjA69j132nT9Eq83VlwoFIC9VeDZi7RDTDW4wk7gJ5xwnJ28NkVALfmyp3Nu7ehZqslwGgPzHKu9+js5baqraXGBFNHRkSmYldufN5FQ42dcDQT5Klf2cpdlfKs/R4CKPjDwb0ljhOIB0FnHP0gNe/56jDTJKDue8YOVM1AFl1Uo9udpXSZoB+URSmZ8CXqyTDlbf8AdA+YdUVSPYOdPHgoY5Ycek4VVprXviZNYBBoAlPG2sVYBG9QmUqf2RcTtCsO+G7xZP/s8TZVhyjAOc27mopHI1zw2F8/dT47Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=genexis.eu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=LIOOdfKv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LIOOdfKv"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/31/26 09:54, Christian Marangi wrote:
> Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
> entry for the SoC, DTSI and initial config for it. Also add the code for
> CPU and RAM initialization. Everything is mostly based on AN7581 that
> share lots of common piece.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

> ---
>  arch/arm/dts/an7583-evb.dts          |  67 +++++
>  arch/arm/dts/an7583.dtsi             | 387 +++++++++++++++++++++++++++
>  arch/arm/mach-airoha/Kconfig         |  14 +
>  arch/arm/mach-airoha/Makefile        |   1 +
>  arch/arm/mach-airoha/an7583/Makefile |   3 +
>  arch/arm/mach-airoha/an7583/init.c   |  66 +++++
>  board/airoha/an7583/MAINTAINERS      |   5 +
>  board/airoha/an7583/Makefile         |   3 +
>  board/airoha/an7583/an7583_rfb.c     |  16 ++
>  configs/an7583_evb_defconfig         |  79 ++++++
>  include/configs/an7583.h             |  19 ++
>  11 files changed, 660 insertions(+)
>  create mode 100644 arch/arm/dts/an7583-evb.dts
>  create mode 100644 arch/arm/dts/an7583.dtsi
>  create mode 100644 arch/arm/mach-airoha/an7583/Makefile
>  create mode 100644 arch/arm/mach-airoha/an7583/init.c
>  create mode 100644 board/airoha/an7583/MAINTAINERS
>  create mode 100644 board/airoha/an7583/Makefile
>  create mode 100644 board/airoha/an7583/an7583_rfb.c
>  create mode 100644 configs/an7583_evb_defconfig
>  create mode 100644 include/configs/an7583.h
>
> diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
> new file mode 100644
> index 000000000000..d02cd194e8a3
> --- /dev/null
> +++ b/arch/arm/dts/an7583-evb.dts
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/dts-v1/;
> +
> +/* Bootloader installs ATF here */
> +/memreserve/ 0x80000000 0x200000;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "an7583.dtsi"
> +
> +/ {
> +	model = "Airoha AN7583 Evaluation Board";
> +	compatible = "airoha,an7583-evb", "airoha,an7583", "airoha,en7583";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlycon";
> +		stdout-path = "serial0:115200n8";
> +		linux,usable-memory-range = <0x0 0x80200000 0x0 0x1fe00000>;
> +	};
> +
> +	/* When running as a first-stage bootloader this isn't filled in automatically */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x20000000>;
> +	};
> +};
> +
> +&an7583_pinctrl {
> +	pcie0_rst_pins: pcie0-rst-pins {
> +		conf {
> +			pins = "pcie_reset0";
> +			drive-open-drain = <1>;
> +		};
> +	};
> +
> +	pcie1_rst_pins: pcie1-rst-pins {
> +		conf {
> +			pins = "pcie_reset1";
> +			drive-open-drain = <1>;
> +		};
> +	};
> +};
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_rst_pins>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_rst_pins>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&snfi {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
> new file mode 100644
> index 000000000000..9362d2fbedf1
> --- /dev/null
> +++ b/arch/arm/dts/an7583.dtsi
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/en7523-clk.h>
> +#include <dt-bindings/reset/airoha,an7583-reset.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		atf-reserved-memory@80000000 {
> +			no-map;
> +			reg = <0x0 0x80000000 0x0 0x40000>;
> +		};
> +
> +		npu-binary@84000000 {
> +			no-map;
> +			reg = <0x0 0x84000000 0x0 0xa00000>;
> +		};
> +
> +		npu-flag@84b0000 {
> +			no-map;
> +			reg = <0x0 0x84b00000 0x0 0x100000>;
> +		};
> +
> +		npu-pkt@85000000 {
> +			no-map;
> +			reg = <0x0 0x85000000 0x0 0x1a00000>;
> +		};
> +
> +		npu-phyaddr@86b00000 {
> +			no-map;
> +			reg = <0x0 0x86b00000 0x0 0x100000>;
> +		};
> +
> +		npu-rxdesc@86d00000 {
> +			no-map;
> +			reg = <0x0 0x86d00000 0x0 0x100000>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-level = <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@9000000 {
> +			compatible = "arm,gic-v3";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x0 0x09000000 0x0 0x20000>,
> +			      <0x0 0x09080000 0x0 0x80000>,
> +			      <0x0 0x09400000 0x0 0x2000>,
> +			      <0x0 0x09500000 0x0 0x2000>,
> +			      <0x0 0x09600000 0x0 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		chip_scu: syscon@1fa20000 {
> +			compatible = "airoha,en7581-chip-scu", "syscon";
> +			reg = <0x0 0x1fa20000 0x0 0x388>;
> +		};
> +
> +		syscon@1fbe3400 {
> +			compatible = "airoha,en7581-pbus-csr", "syscon";
> +			reg = <0x0 0x1fbe3400 0x0 0xff>;
> +		};
> +
> +		system-controller@1fb00000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0x1fb00000 0x0 0x970>;
> +
> +			scuclk: scuclk {
> +				compatible = "airoha,an7583-scu";
> +				#clock-cells = <1>;
> +				#reset-cells = <1>;
> +			};
> +
> +			mdio_0: mdio-0 {
> +				compatible = "airoha,an7583-mdio";
> +				resets = <&scuclk AN7583_MDIO0>;
> +
> +				airoha,bus-id = <0>;
> +			};
> +
> +			mdio_1: mdio-1 {
> +				compatible = "airoha,an7583-mdio";
> +				resets = <&scuclk AN7583_MDIO1>;
> +
> +				airoha,bus-id = <1>;
> +			};
> +		};
> +
> +		system-controller@1fbf0200 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0x1fbf0200 0x0 0xc0>;
> +
> +			an7583_pinctrl: pinctrl {
> +				compatible = "airoha,an7583-pinctrl";
> +
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +		};
> +
> +		i2cclock: i2cclock@0 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +
> +			/* 20 MHz */
> +			clock-frequency = <20000000>;
> +		};
> +
> +		i2c0: i2c0@1fbf8000 {
> +			compatible = "mediatek,mt7621-i2c";
> +			reg = <0x0 0x1fbf8000 0x0 0x100>;
> +
> +			clocks = <&i2cclock>;
> +
> +			/* 100 kHz */
> +			clock-frequency = <100000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disable";
> +		};
> +
> +		i2c1: i2c1@1fbf8100 {
> +			compatible = "mediatek,mt7621-i2c";
> +			reg = <0x0 0x1fbf8100 0x0 0x100>;
> +
> +			clocks = <&i2cclock>;
> +
> +			/* 100 kHz */
> +			clock-frequency = <100000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disable";
> +		};
> +
> +		snfi: spi@1fa10000 {
> +			compatible = "airoha,en7581-snand";
> +			reg = <0x0 0x1fa10000 0x0 0x140>,
> +			      <0x0 0x1fa11000 0x0 0x600>;
> +
> +			clocks = <&scuclk EN7523_CLK_SPI>;
> +			clock-names = "spi";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +
> +			spi_nand: nand@0 {
> +				compatible = "spi-nand";
> +				reg = <0>;
> +				spi-max-frequency = <50000000>;
> +				spi-tx-bus-width = <1>;
> +				spi-rx-bus-width = <2>;
> +			};
> +		};
> +
> +		uart1: serial@1fbf0000 {
> +			compatible = "ns16550";
> +			reg = <0x0 0x1fbf0000 0x0 0x30>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <1843200>;
> +			bootph-all;
> +		};
> +
> +		uart2: serial@1fbf0300 {
> +			compatible = "airoha,en7523-uart";
> +			reg = <0x0 0x1fbf0300 0x0 0x30>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <7372800>;
> +
> +			status = "disabled";
> +		};
> +
> +		hsuart3: serial@1fbe1000 {
> +			compatible = "airoha,en7523-uart";
> +			reg = <0x0 0x1fbe1000 0x0 0x40>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <7372800>;
> +
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@1fbf0600 {
> +			compatible = "airoha,en7523-uart";
> +			reg = <0x0 0x1fbf0600 0x0 0x30>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <7372800>;
> +
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@1fbf0700 {
> +			compatible = "airoha,en7523-uart";
> +			reg = <0x0 0x1fbf0700 0x0 0x30>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <7372800>;
> +
> +			status = "disabled";
> +		};
> +
> +		pciephy: phy@1fa5a000 {
> +			compatible = "airoha,en7581-pcie-phy";
> +			reg = <0x0 0x1fa5a000 0x0 0xfff>,
> +			      <0x0 0x1fa5b000 0x0 0xfff>,
> +			      <0x0 0x1fa5c000 0x0 0xfff>,
> +			      <0x0 0x1fc10044 0x0 0x4>,
> +			      <0x0 0x1fc30044 0x0 0x4>,
> +			      <0x0 0x1fc15030 0x0 0x104>;
> +			reg-names = "csr-2l", "pma0", "pma1",
> +				    "p0-xr-dtime", "p1-xr-dtime",
> +				    "rx-aeq";
> +			#phy-cells = <0>;
> +		};
> +
> +		pcie0: pcie@1fc00000 {
> +			compatible = "airoha,an7583-pcie";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			reg = <0x0 0x1fc20000 0x0 0x1670>;
> +			reg-names = "pcie-mac";
> +
> +			clocks = <&scuclk EN7523_CLK_PCIE>;
> +			clock-names = "sys-ck";
> +
> +			phys = <&pciephy>;
> +			phy-names = "pcie-phy";
> +
> +			ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
> +
> +			resets = <&scuclk AN7583_PCIE0_RST>,
> +				 <&scuclk AN7583_PCIE1_RST>;
> +			reset-names = "phy-lane0", "phy-lane1";
> +
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +			bus-range = <0x00 0xff>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +					<0 0 0 2 &pcie_intc0 1>,
> +					<0 0 0 3 &pcie_intc0 2>,
> +					<0 0 0 4 &pcie_intc0 3>;
> +
> +			status = "disabled";
> +
> +			pcie_intc0: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		pcie1: pcie@1fc20000 {
> +			compatible = "airoha,an7583-pcie";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			reg = <0x0 0x1fa92000 0x0 0x1670>;
> +			reg-names = "pcie-mac";
> +
> +			clocks = <&scuclk EN7523_CLK_PCIE>;
> +			clock-names = "sys-ck";
> +
> +			phys = <&pciephy>;
> +			phy-names = "pcie-phy";
> +
> +			ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
> +
> +			resets = <&scuclk AN7583_PCIE0_RST>,
> +				 <&scuclk AN7583_PCIE1_RST>;
> +			reset-names = "phy-lane0", "phy-lane1";
> +
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +			bus-range = <0x00 0xff>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +					<0 0 0 2 &pcie_intc1 1>,
> +					<0 0 0 3 &pcie_intc1 2>,
> +					<0 0 0 4 &pcie_intc1 3>;
> +
> +			status = "disabled";
> +
> +			pcie_intc1: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
> index 4b0374001d0c..72cd14542086 100644
> --- a/arch/arm/mach-airoha/Kconfig
> +++ b/arch/arm/mach-airoha/Kconfig
> @@ -29,19 +29,33 @@ config TARGET_AN7581
>  	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
>  	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
>  
> +config TARGET_AN7583
> +	bool "Airoha AN7583 SoC"
> +	select ARM64
> +	help
> +	  The Airoha AN7583 is a ARM-based SoC with a quad-core Cortex-A7
> +	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
> +	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
> +	  video interfaces supporting HDMI and MIPI, and video codec support.
> +	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
> +	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
> +
>  endchoice
>  
>  config SYS_SOC
>  	default "en7523" if TARGET_EN7523
>  	default "an7581" if TARGET_AN7581
> +	default "an7583" if TARGET_AN7583
>  
>  config SYS_BOARD
>  	default "en7523" if TARGET_EN7523
>  	default "an7581" if TARGET_AN7581
> +	default "an7583" if TARGET_AN7583
>  
>  config SYS_CONFIG_NAME
>  	default "en7523" if TARGET_EN7523
>  	default "an7581" if TARGET_AN7581
> +	default "an7583" if TARGET_AN7583
>  
>  endif
>  
> diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
> index 91395b8a8503..51d82ea3e217 100644
> --- a/arch/arm/mach-airoha/Makefile
> +++ b/arch/arm/mach-airoha/Makefile
> @@ -4,3 +4,4 @@ obj-y	+= cpu.o
>  
>  obj-$(CONFIG_TARGET_EN7523) += en7523/
>  obj-$(CONFIG_TARGET_AN7581) += an7581/
> +obj-$(CONFIG_TARGET_AN7583) += an7583/
> diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
> new file mode 100644
> index 000000000000..886ab7e4eb9f
> --- /dev/null
> +++ b/arch/arm/mach-airoha/an7583/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier:	GPL-2.0
> +
> +obj-y += init.o
> diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
> new file mode 100644
> index 000000000000..4cf7f8caf85c
> --- /dev/null
> +++ b/arch/arm/mach-airoha/an7583/init.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <linux/sizes.h>
> +#include <sysreset.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int print_cpuinfo(void)
> +{
> +	printf("CPU:   Airoha AN7583\n");
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = get_effective_memsize();
> +
> +	if (gd->ram_size > SZ_2G) {
> +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
> +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
> +	}
> +
> +	return 0;
> +}
> +
> +void reset_cpu(void)
> +{
> +	psci_system_reset();
> +}
> +
> +static struct mm_region an7583_mem_map[] = {
> +	{
> +		/* DDR, 32-bit area */
> +		.virt = 0x80000000UL,
> +		.phys = 0x80000000UL,
> +		.size = SZ_2G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> +	}, {
> +		/* DDR, 64-bit area */
> +		.virt = 0x100000000UL,
> +		.phys = 0x100000000UL,
> +		.size = SZ_4G + SZ_2G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> +	}, {
> +		.virt = 0x00000000UL,
> +		.phys = 0x00000000UL,
> +		.size = 0x40000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +	}
> +};
> +struct mm_region *mem_map = an7583_mem_map;
> diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTAINERS
> new file mode 100644
> index 000000000000..71ee542a8bcb
> --- /dev/null
> +++ b/board/airoha/an7583/MAINTAINERS
> @@ -0,0 +1,5 @@
> +AN7581
> +M:	Christian Marangi <ansuelsmth@gmail.com>
> +S:	Maintained
> +N:      airoha
> +N:      an7583
> diff --git a/board/airoha/an7583/Makefile b/board/airoha/an7583/Makefile
> new file mode 100644
> index 000000000000..d582684d1f7f
> --- /dev/null
> +++ b/board/airoha/an7583/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier:	GPL-2.0
> +
> +obj-y	+= an7583_rfb.o
> diff --git a/board/airoha/an7583/an7583_rfb.c b/board/airoha/an7583/an7583_rfb.c
> new file mode 100644
> index 000000000000..aa73679d929e
> --- /dev/null
> +++ b/board/airoha/an7583/an7583_rfb.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Christian Marangi <ansuelsmth@gmail.com>
> + */
> +
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +	/* address of boot parameters */
> +	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
> +
> +	return 0;
> +}
> diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
> new file mode 100644
> index 000000000000..16466be51b27
> --- /dev/null
> +++ b/configs/an7583_evb_defconfig
> @@ -0,0 +1,79 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_AIROHA=y
> +CONFIG_TARGET_AN7583=y
> +CONFIG_TEXT_BASE=0x81E00000
> +CONFIG_SYS_MALLOC_F_LEN=0x4000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SIZE=0x4000
> +CONFIG_ENV_OFFSET=0x7c000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="an7583-evb"
> +CONFIG_SYS_LOAD_ADDR=0x81800000
> +CONFIG_BUILD_TARGET="u-boot.bin"
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_DEFAULT_FDT_FILE="an7583-evb"
> +CONFIG_SYS_PBSIZE=1049
> +CONFIG_SYS_CONSOLE_IS_IN_ENV=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_PROMPT="U-Boot> "
> +CONFIG_SYS_MAXARGS=8
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_BOOTMENU=y
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_XIMG is not set
> +CONFIG_CMD_BIND=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PING=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_CMD_LOG=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SYS_RX_ETH_BUFFER=8
> +CONFIG_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_DMA=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_MTK=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_AIROHA_ETH=y
> +CONFIG_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_AIROHA_AN7583=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_RAM=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_AIROHA_SNFI_SPI=y
> +CONFIG_SHA512=y
> diff --git a/include/configs/an7583.h b/include/configs/an7583.h
> new file mode 100644
> index 000000000000..c865afea1a2a
> --- /dev/null
> +++ b/include/configs/an7583.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Configuration for Airoha AN7583
> + */
> +
> +#ifndef __AN7583_H
> +#define __AN7583_H
> +
> +#include <linux/sizes.h>
> +
> +#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
> +
> +#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
> +#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
> +
> +/* DRAM */
> +#define CFG_SYS_SDRAM_BASE		0x80000000
> +
> +#endif
