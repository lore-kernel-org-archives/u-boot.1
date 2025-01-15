Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E294C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 09:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C0780214;
	Wed, 15 Jan 2025 10:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GsA++2HW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304CF806D6; Wed, 15 Jan 2025 10:58:35 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEEF80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiDOeLA9WaSfKxkCJlMaMr9/LoBeXxZm39JnAQNjr4ND3bDdUJ+nvV32qQPEcqDzqBBIjr9pLCaonCiL29TIyXUFHdYtz/TF/JE6C9l5Q9vqhK7R/QP1ERczvXBkVyUhKOho/jNika6a0bt5D7rZzmEkMJwSbMAxb71RMJdH+PF5Rg8NDqnf+7qHhm4N3Orsc4YqdVxhkJk4bYKzM6uQcfrqMU46Q0TanEWW9bkHJOPGc8lLw88js6H4i2NzBt+A5aKJb5IdE0L+uernfCUTpu7DjejPoJtkWLm3/RvCdkYVPOyC0lnT4v7JJ4cBm6K0IC/qEoSCu+agSGlqU5qn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yEJI/XttD8KKiH8vgNimjgzoL9AjuVzZhh/Ce8r18c=;
 b=FcDOYawM+melaSF6V7Q+b4zEz17Cxnty2KL7gbJt5zkreN5YHEpAp8ZHmBfeBlQvE9fQTMupcCJo1aJJajRlNYICxDke9ESiFn1KGc+xm4Sofpt47jEXqpTO1EnSpoZfSWKhf0kUKXbHRgjgLc4fUXrJaTZPzRhEjnfx0v+bbjXytRe59EkKpRLWCfjZ11CNmvrJ0QZeCjxlIfb0sBFEqMnayVMZodseuiERr561+TKFPYXT9DaXkYrbRzwaWGgxo3xfqaBG62k2NsfcKNAQS4tODZN3lBjAH/kKxM9MU39xKsLpCmQW21dtUavtT2SkwYRivfXEREwiX2Pjwg5m9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yEJI/XttD8KKiH8vgNimjgzoL9AjuVzZhh/Ce8r18c=;
 b=GsA++2HWPG5xqjHXaIQt+dEIsVoMioCWxDBmgLm2s8a0susn1e3lmA59CO62xQaViELLX1EorJztBzBuskH+jxQkupN2Uat5kolJAsoW6Y6om6ild9x+xpVDwSPjeu8hFQZ2A4pQHoPD1dIGsplBX+e+77FZYMwE/aeOfTbJ6Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 09:58:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 09:58:30 +0000
Message-ID: <b541c7ce-eb71-491d-acc9-a224617ba46a@cherry.de>
Date: Wed, 15 Jan 2025 10:58:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ARM: renesas: Rename board/renesas/rcar-common to
 board/renesas/common
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1735860e-a255-4d5b-fe38-08dd354b2a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmNkVnlyNy81T2pwRjZid0owWUFjTzJManVHZjNQV0JUWDkrek1SUG8zYUhw?=
 =?utf-8?B?SUR6cityODZIRG1aLzhhQXg0MWdxTXdMNzVOYm81R3FyUnN6MDFzbWsvSHQx?=
 =?utf-8?B?ZzRoZ2UwN04wU0xVL0lHZ3lQRnh3Zm5FRk05VVJjbnhiTklSajVlOHZ4UW9i?=
 =?utf-8?B?K2gxVEdjQm1JMzZia3VBRUV6Y1hJMkkzclZkMmU3bG9QWjJwdUlpcUhGZ3Rj?=
 =?utf-8?B?YWo1M1NXMFp4dmpFWlRyeTNleElKdm5tWTl5SnVNWnIxbXR4cGN1L0lyY1hR?=
 =?utf-8?B?VXhpZ0VsamErMjVJSTR2c29qa0wwOXdJelgzOEdaa05Lb2pXNXJIZ1FHaGhi?=
 =?utf-8?B?NlVDYnE2cnN0ajNDQ2lVenhFWEMwTXVFYy9vRHY0VVE4UnhFR0hCKzEwYnJz?=
 =?utf-8?B?YVFudVNOTS8yblZSS2NIamR3SkN6WnNpMEg0ZzRseWJVY2hIa0s4R3E2Zmor?=
 =?utf-8?B?eWlGb3h4VzdKVHd0OEpMcGJxR2d1OGRPajJUeUFUUmtSbTJhZS8zWkRvVmYx?=
 =?utf-8?B?eDBOaTU0bWJQelBWRzNIWFlmZEg4dkdHMys3STJDaExKWkIzY0E0L04yWjh0?=
 =?utf-8?B?K2RjMU8xQmxPQjMzN0ZrL0ZkMFRoOGFDWnhlc0xQblNCZEROd3Q1MEt1ZjNB?=
 =?utf-8?B?aithSHVWVzVtQm1NNjNVT0tUcHJkUTlnVmJZUzBXVktIZGx4RHpZSzZvRC9x?=
 =?utf-8?B?dTZhbFpMbkJTUXZDVHhoNjF3S3RHOE5USEl6blB5dnpjUHh4bHlScm1vR3N2?=
 =?utf-8?B?Mm5qbHBjcUM1Tm1mYkxQenlCV241MGU3dHRHcUtNRHhic3lzRkRsRCtwS24x?=
 =?utf-8?B?NWFGTXduNEY3Z01xUGIzWWxDOGZGb0x1Nm5ReFN2MU1XQTYwaVR5elZUTWNC?=
 =?utf-8?B?M0pWUWcxNlZ1MzVTRXNOSHdVbHpCc2FsTDQ2eVZKR2NSMWFLcGJhTjduZ291?=
 =?utf-8?B?b2JBeTFLSXF4V213TkVtV0VNbGp6czlFY1Q3RkkwalZyT1ZHYTl1ZFM4UEpT?=
 =?utf-8?B?MXBCdVVqbnhNOTZNQ25IV25RLzQ2TU1oa1gvSDhyUVRReHMyVk5RVUROTVl4?=
 =?utf-8?B?TUNCbkZ3SDNkeENBTlNPYnpVSmZoR0M3aktDZFJ5UFVsVXdJdWZSSGdYZW5M?=
 =?utf-8?B?N0xlY0JmZFVHTzVYdmVEd3dMTWNmU2lSMnFCS01FRmY4SUgveHZEQkpjOTJy?=
 =?utf-8?B?WUdxWEJneHd1VkIwZTFOd0c5eUE1emdjZnpPKzY3QnJLL1hBUVJHMnI1bmNU?=
 =?utf-8?B?eVJPMlpaRzdFK2o3UmhkaWdwcW9yc0hEMHRHUmg0ODJFM2FEZTlwUTNjbWFF?=
 =?utf-8?B?cGZHcFkyTjVMTmkxSWZndVVJVVVmdjNsVXBsNGI0RWV5R095b1RrKzNmUFBz?=
 =?utf-8?B?T3h5YWVOSGlYRTdyZU50clV3UHBla0R6amVqcExiZFhtcHh3a3VxUXJvUGRj?=
 =?utf-8?B?NnBuZCtHY0JpSmpIakVMTEl2cmRsR1NFT0dVV2dMSDZ2WTNPNWtYdEZHWkc2?=
 =?utf-8?B?MVkydWJZdSt1V3Q2c3Q0eFZ1TFBTcktLOGtGUnBOUUF2c2JvcktpQmx1Nk5t?=
 =?utf-8?B?WUFjTW8waHpMK0ZyWVVLYjlVeDRXMWQrYUNjSFpHbFU4S0tEVlR6eERrSzF4?=
 =?utf-8?B?U3NZdFlqa2lZMmdIOHF3NUpzWXJNa2FXV0pneThabXlWSW5Wb0dyd3czV1l3?=
 =?utf-8?B?ai9FRzdSTVg2MGlZY1NucEkweXdZS0RzVTdVb2JCNEtPUzJ1M0F4cVUxQllS?=
 =?utf-8?B?TUp3dE1ERjJtNS9iSHlZb25iYTVrby9Nb3FscHBmdHNzczN3blNHQndpM241?=
 =?utf-8?B?a1FCUDRkbFFGeklmZEw1WVBvVTJIU05vQmV6VFNyOTN4YUtuTUQwa0VTaGVC?=
 =?utf-8?Q?tlz/XrKUnri9B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJONWJITG9YYW1NNGVrQS9iM0t1YVdiSnJ1ZFNzcG5SeFVNdFlpeXQxZWRj?=
 =?utf-8?B?VmY5Y0hWRjR0TGlvRlNKNFVualhpYTNvam1ESFQ1YjlPcjFvRjhHdnpHWjRC?=
 =?utf-8?B?WDZMeFZzWTNRWEZCZ1pCMWlFVWRQTk5mZ1lpYTI4dmtiTi9jVlpIem50OFZx?=
 =?utf-8?B?MXhlNnZPeWxEZnFkRkZhQnAxWHIxY3JIVVVzMXl2QTlCMVBIVCtPclI3NWl5?=
 =?utf-8?B?SFZQUXI2cXVEOHBRcEtEV1lLaEJQbUd6NGVLeDZ3R3ptdXN6SE5MTmJaMDZW?=
 =?utf-8?B?Y1pQbGJzdDhJYUhxNDZaTGdlOTFJY2hleHRtMk9MSTIreHdjK2FKYWZVUmVa?=
 =?utf-8?B?TVhyY29BZmZKYnFweEsvQmtNd1pjbmt0ZTBtUlZKRnd1bWNvRzhQRGVvYy9n?=
 =?utf-8?B?WjJDODVScVFWcnExcEY3ZDA4Q0pjb2srSXEvOFI4UFlxOVFMM1JnMktrcG5Z?=
 =?utf-8?B?Qml4ckhtWEZNd2pVMTJXdVpBZWpmekJqL3dQajhIemZwVEUvSUUzZjUvcW9W?=
 =?utf-8?B?VG05ckd2b09mVW80YmZRNU5DUmJZOVcvL2twc3F2bnBvOHRFNEVrek5uTVZJ?=
 =?utf-8?B?Lzg5R3dITk95cjV6L0I5TFVSaXJUWlhNb1Bta0V3cWlyZ0pyWVZoZjN5ZW0v?=
 =?utf-8?B?RDlleERFUjdOZ1BJcUZ5aGZNWTdXS2FLenZqa3g5bUl2eHBlNWpYQ2VOVDMw?=
 =?utf-8?B?b3hPVkYzTDBYRXErVHV6MDhiOGprTkZOcUM0aWZZWTQ0RnlRdjNwbWdqRVhL?=
 =?utf-8?B?RXJ3aDRXSnZvRE55SUNCc0FTaWNxU3Y4dFl4OGxjb0JjZ0RqMGZBZE9TSy8z?=
 =?utf-8?B?Ujc3SFVacDNMa3BMTUdQazRUbmI0WDJncU15ai9oQkxPL3M4UHFTOVlFUUhS?=
 =?utf-8?B?Y2dLYitVVFhuRUt2d0k0ZU9IYUozZnlvZTY4MVVoRU5GTmUrK0x0Y25OK1Y0?=
 =?utf-8?B?bHR5My9QSEJCRUF3T1FPa2FkN1d3WVBraDZRZUFvcFMrSE5vVEgxUTEyVjlP?=
 =?utf-8?B?Y1hyTTN1S2dubG4xTUFETGhhVEJnRXVwOTc1S2FnQ0NhSmFkSy9uYWZ4QnUz?=
 =?utf-8?B?SkNyRFdCVDQ0T2FJTXpqeXowN01RdW9rT0djRVlGU2VUSml4dG9ma1A2cDRO?=
 =?utf-8?B?ODh4TTNOcVhteUJZZzlhanBjREtRYmFXdXB6Um9IYzVRZC93MGFHVDIvUC9Y?=
 =?utf-8?B?a21YenJOR3EzWm12cU9TR1NscjBPQk40NVNpNFZyTWlOcS9sVENoTEE0K0VU?=
 =?utf-8?B?Z0hJRXpEL1dNcU1hQVVNSlh2QUNQUy9zS1hUN3ViWDZBVjdYWWs4ZVRSOWdq?=
 =?utf-8?B?NUhPZWZsVFhBZjZkbmFhRTVZVi9oUldhU2FoUnE0MlhvLzZrYWJOSTdHY1di?=
 =?utf-8?B?OXdCcGdjK2NkZDZmbWlJcWM3ZU5OZHc5WEZVZWtvTDdTL3hSamtRbk56cjZG?=
 =?utf-8?B?WHViN3JqeE5kSDcwZ25WcFZMSE50b3VZUkpvTmhwa1lHQjV2bTE5WEU3Qzda?=
 =?utf-8?B?VXFTc2tLaGpmajN4aXBPOTFZQWc3RnpIREc4TG0zTXo2Q1UwVTliNHJXbDYx?=
 =?utf-8?B?VXdKWVIrT3dqeXQwMTM3d0pxa1FtR0h4QjNjTXhqWW5iWXZaYzhXUzZwKzNR?=
 =?utf-8?B?NHJ0bE1URENyU093VERSWW01aEtvWGhQTDc1UFdsclp0blpkR0RYZHJTa3lI?=
 =?utf-8?B?bnNxS3I1dmtsQnZTelh2ZnJyS1ZPQlhiakpDL0dEYjRhQWs4dmg1WkdiY3ZO?=
 =?utf-8?B?SUJzU3lsWEpDcHUrbzJqSC83eVEwdVVKSE12a3hXUnM3OHVhRGJpa3F6YU9s?=
 =?utf-8?B?VHNvUXN1aE5ic21ISUIwTFZEd01PSklkMWxTQk1xZFRtTGVrTS9tN2lHa01M?=
 =?utf-8?B?aGNnMkNHL0NXcEhlWnQ1L1NXYnpTbm8yTXc2cEtFdkJWS1IyaUxIR2dEdTg3?=
 =?utf-8?B?b3pMQUNTNXg0ekNLaFkwandkYW51L3ZOWEZkVFJmU25ZdGdjV3JyWGs4MGFG?=
 =?utf-8?B?S0NqQWJWOTVETmdyVlZiSmg4OTlDOC9mY1JsUkNyWGM3bWQ5VzlkWXVGTWFh?=
 =?utf-8?B?b3g0MGdGVEhEMDkrTDVNRC85bU43N085SklQRE9DZTF5eDMzb0ZBazRsTW82?=
 =?utf-8?B?M0EvcU82N01IVW50djZPbVNaRFBQUGxXZmtnZ2trQ3NJUDVwcHlHbVd5Ull1?=
 =?utf-8?Q?Os/MVcxSHJh5hC3BOEXn1HM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735860e-a255-4d5b-fe38-08dd354b2a37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:58:30.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YY0Pfmie0GFQIR9PcoylMA/KvcJUKvFHILEcF5K9QDETSrfpDOOKoi9iVRxjKetBQ5mB1QHbMcOAaboIEoU71c9718lfcm58BPQyNdc/1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092
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

Hi Marek,

On 1/12/25 11:34 PM, Marek Vasut wrote:
> Rename directory board/renesas/rcar-common to board/renesas/common and
> move files. This allows the build system to use HAVE_VENDOR_COMMON_LIB
> which automatically includes board/$(VENDOR)/common/Makefile . This is

Please mention this is NOT sufficient to make use of 
HAVE_VENDOR_COMMON_LIB as board/renesas/common is missing a Makefile.

Something like:

This will allow the build system to use HAVE_VENDOR_COMMON_LIB once a 
Makefile is added in a later commit. This mechanism automatically 
includes board/$(VENDOR)/common/Makefile.

or something like that.

> a preparatory patch for board Makefile simplification. No functional
> change so far.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

The change is fine, but please make the commit log a bit less confusing 
around the use of HAVE_VENDOR_COMMON_LIB in this commit.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
