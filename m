Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D14EC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 10:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DB882B07;
	Mon, 14 Jul 2025 12:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Vicc6JCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0948A82CFA; Mon, 14 Jul 2025 12:32:11 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC39805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2KlBSGjhSEnA4WL9hHsJlku+B4c+my02GTgLLAGvhgwZGtbh6Do8AYWFG4uMVFIY+o/b5FuHq+sBWY36ExxNpc28utmNmntUr825b5NF+3eLSO8LWZKKctXQoK5tfPLgrIjgZerAVKJoU7bupd/A6ZdQANQVSzeP5qtn7Jn9ctQ9g8bb4ECPtG+mj+mPsNCsHT0/0cmYmSk2fIcTgdQwM1WcUZ/XgYHmQffhud6NaZjbk6h5ObM3WrJusGsabUBnrsTGKUKbI0wbHTxWvhrhy7wsSxn72Xiwm+QTEwWU7cIPIPAGbGSvry5QI/vkTVuTYBdr8fet8c0FqPYJv03fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4JIi7TLWiGhrcnn4GEQwh8zKHtTtzXw7C1MShKJGYU=;
 b=Nm8zjCzZoIR3HzmnAmsKHUwW+W+p2nuoXczGXTEx293dYke22y7Xu3E073WqYeDmcel5pC+d+Tn+QcVWk95Rzrwm2RS1UReI2l8a7rgONxy23Mu6YaFtZREalO8i8gUmCSwEWtahsBGEszivw25X0+IDzVQv49NiuVlde/ztph3m4lf1f64Tnf9Br8Hd06C/tITxaru/otaHsWc8C2bQOJSFiEmAb4J31GD0ARcSD9+PoKPMtU2w/5EZT3ZdXAMPCTz0MnSKAeQXJPbHqUPy2Wsxkd+AZoHyhRCcq4AADQQhj2PRtxMueGEl97KELZhA+XkeFrCutyOoHSrZrE3Jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4JIi7TLWiGhrcnn4GEQwh8zKHtTtzXw7C1MShKJGYU=;
 b=Vicc6JCtMp9jkIGfl+6Hsp0FliCa1gd4Wj3QtdBIn38bTtfaz/NQBA+IqCVXHZs4QANnW47PpBm1RDreSAfWP1TNXNe4daAzTd+GbyKpFE2XypM4hzNurLrZDrZv4RLVn7BVm7E+EkylWhAjHjZE2AVYQd7IiqBN1t++SK8ZpZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 10:31:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:31:59 +0000
Message-ID: <262dd278-3b7a-4644-95a0-fda10dfc239c@cherry.de>
Date: Mon, 14 Jul 2025 12:31:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: rockchip: Fix spacing around the Kconfig
 option
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>
References: <20250702010346.18716-1-trini@konsulko.com>
 <20250702010346.18716-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250702010346.18716-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0059.eurprd02.prod.outlook.com
 (2603:10a6:802:14::30) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10980:EE_
X-MS-Office365-Filtering-Correlation-Id: 8075b862-901b-492d-c796-08ddc2c1a9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THdsU0lBaFBuc1UyZllmcGpLMEhJVGcramNkeGtPTTNwdUxQK1F1NGdPQWhS?=
 =?utf-8?B?Yi9BbEMwWFRsWDEzRTFXamE0dXdKemlVazM0c1ovK0VmNmw1N3N2cUxldElo?=
 =?utf-8?B?Tno1Um5LRGZKTVVyWXVUOHNpUmVZZ3BSSnFjbjlkTFd5d3FiZlpmZnZGM3dD?=
 =?utf-8?B?Nlh6bEIwL0hHYXhXSDltSVdNRnN5dWRZQjMwMWlsWVY0MFJ4anRqUkRwcFpK?=
 =?utf-8?B?RU82ZXYxV0ZXeEhTUWpoVng5Y25sbzFIRkhCcjRTTVZpcnpuR0pram5ybmh2?=
 =?utf-8?B?YkZXVFlSUWtxSnZWVVN1ZFhOK2V5N1lsODdoVjhPUkNPSENFeDZaVy9BQWVa?=
 =?utf-8?B?ckMyOXJ0R3l0dXh0U0IyZW0vcWpuZXNxVjNFOE50cXJOeGFOU3lNMFcwUUV0?=
 =?utf-8?B?OVBiS1B5K0ZwVjl0OWlrTjh1SzgxS1NxTDIvZVJ5dkVlYlQyc3MrdS90RXQ0?=
 =?utf-8?B?eWN1RFN6ck1xMGM0dkU5K08xM2d6Kzl6SHcrRlExMHJXZk9KY2JLVmlqK2ZJ?=
 =?utf-8?B?WUtLNmdFZkE2L25wNVdzZE9YYUprUEhSd2w4UEdudVpRM2hZK010SExXbHBU?=
 =?utf-8?B?ZFpQOURpS1JtbjgxQjA5Sm4wQzFSanN6WGQ0NUdPK3BIMzhzbjFxcGlIWm4z?=
 =?utf-8?B?SWMxOGJ1R0ZMK0ZFTzMxN0VqTGg5UTEvb05pbU1hbXk3TUdnUmw5dGN2aEd0?=
 =?utf-8?B?cWIreTRzRndWVnhoc1hCbzJGSElFTDY5b1BHZ1VScUtMYTBOb01BcHZvQWpX?=
 =?utf-8?B?ODJ1YlQydFdIZHkxL09GQ2FrU2xDak1BdlVpWGtjNXVXVDI4YWJucjE4OXlI?=
 =?utf-8?B?bmNxcEJ4S2t5OTFwL3FRZEF5WkFRQTI5Mk81eEpOeFQwUHFqeGNDN0Y2Y2VM?=
 =?utf-8?B?dkVReS9JbE1HVk02K056YW04eU5BUm1oOURSWEFWYzRXNTl3djJ2UFBsZnVE?=
 =?utf-8?B?Yko2ekRESlE4MzMxM2dEeS9xSWRKSFdMMHdQekczUmQzTTVtT1lYQ3RQMmxi?=
 =?utf-8?B?ajR6OFh5ajNwVmNUTkNFb3FLNHR4WWdERWErYUJNN2tZQ04vcWJJZmg2Zy82?=
 =?utf-8?B?N2FqeEJFNU5vOFlWWXQydDlyQjFIa3VEY1c4TU8ySm9EWXorRGEvOE5Pem9B?=
 =?utf-8?B?QUZoMzhUSHc0OXpnMC82VHYzaGpoWjI4UjhqZy9jaWNzQ2dkcGp5TlRuc3VB?=
 =?utf-8?B?RXFHdjhVUTZObTB3OG14dnc3ZHlnTjRVV1d0ZHhoSWRScmtWSXQ2WElzWU43?=
 =?utf-8?B?WnhPWjNZTXJLbGNjQjR6dlJ5ajY1ZDM4aEt6L0ptRGZHVEZKQ093Wkk4RU10?=
 =?utf-8?B?dE5ibU9ycnptQjBWREE2YzJoZDRkODVJRCtEL25vS0NrOEFuc1lKdGJvZmlz?=
 =?utf-8?B?bmMrSy80cVdUVjRnRW9FaUJHSXZnY0V4K1VkVllHSkhwcFg2SHQvL1dPV2J0?=
 =?utf-8?B?djV5cmlJZlhXM0lqMEZGOTRqK2ZBM1JhbFBhQjEwUTR0eFVDa25BWjU4aWpX?=
 =?utf-8?B?M1l2Z2Y2eHhwZXpvQWNUV1E2VFdOY2hzZVJjcWpVLzRYWjZleHgrMG5Icm1E?=
 =?utf-8?B?blBpSVczd0JEWWVYNjlkUEQwL1phWm9WKzd4THV0VHgyT000NFBxRWtRY1dU?=
 =?utf-8?B?VDVNNXNGVDJ4M05uMnltMzZMT1o3UEsrQ2FuYmxROG9lbFhoL0FxQ3dTNVJS?=
 =?utf-8?B?KytQWmZteU93YjJocitJZDFDS2xKTFBLMWtQNjZEZTg2S2RzKzBaYzMwNUZ5?=
 =?utf-8?B?RVJKSDBkMTRMYzNBaTUvcXlmN0lveVdhcEJSbWhDOHU4K1FOU1lXa3o5RHl2?=
 =?utf-8?B?bUR0NzB4OVI3cmVnT1ZrTkpTZTRhVGVJeTA0ekxWb0NJOENxYjBZWW5hdDg5?=
 =?utf-8?B?S1o2MjUwK0V4Q0J0UC8rQTBmY1ZYaThGMSt5VjlsODludDV2UGZvU2VXYk5E?=
 =?utf-8?Q?mZHujeiCo3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZJTjBCVHV4bHcvSDlnbmVKZmkyL1VuY3RjWStVeENyeGhadDdhTU0xKzkz?=
 =?utf-8?B?clBENDcrejBNS25SOWkxVVY3Q2dCTWRkMkxvYUl6bDFyR1NrcXp0ZXFVSkhC?=
 =?utf-8?B?VmE0RmI4bTdTeGZlVHZHSWlLL0VqQW12eHBmeFA4aFRVZU9pQkhqQ2Jsd1pB?=
 =?utf-8?B?Z0JoalRzdm0wQ29WczJUbm9Dc2tQMHF2MzExbEE5eVF2VHk1bFc2QmMxWjI3?=
 =?utf-8?B?R3BqQ0xrWXBSWkxWNXR2dnc4bkkwS20wK3JhNlpyWU1aNDRRQVdlOHdCVFV4?=
 =?utf-8?B?ZnZ5bThJei9KelpycU5aQ0F2dE1LQVdkamd0cTBhQmc4NENQelFSdXdnL3Y0?=
 =?utf-8?B?dGhhaTAzZVpPYmxpN2RiV2FDRXZ6bUU0Rk5jZ05LYk93MCtYNmtrdlQ3bDR4?=
 =?utf-8?B?U1JYOEVIMXVubVJXVER1K210ODI2ekkyaHJpdmk5OGFXa1FQVnM2NHVncnY3?=
 =?utf-8?B?cG5GM2xWKzVxR3dNZW5WenJ0Ni9tRlVDcFdWQks1bnpobG5QNFNuUzJXa0Mw?=
 =?utf-8?B?Tk5rNkFvVnBIdWJxV3FCQlRpRSs5VVp2RGgwT092NSt2YnU0V3d3aUoydHBL?=
 =?utf-8?B?UjdlNU5ndTdtMkNtSTU5bnI1T2FOZ3ZEdmRxKzVjclY2TGZQbWxPOVNDblA4?=
 =?utf-8?B?SWNGdk4ycjhFNkJIbDVQUXFHY3ExQ0dMOHpXSGU4bDdPUTNzbXkvbk9PYWRB?=
 =?utf-8?B?OFhyMUV6QjJxblpLeWJVV0dvSExVSFNmMmtzMGVxTEVrUWdWcyt1cllKSEQw?=
 =?utf-8?B?aktGZ1BPVmdVaEprNTg0d2l0aHVyODRDU3BVVlFDbE11YjBKbzZRQWJMQlF0?=
 =?utf-8?B?NVdpMkJETTR4MUNhUFBjYmttWDJOc1RneS9RSm5JazlETURRWmRLZmNjOWxX?=
 =?utf-8?B?ZjlESmt1QitOL0FFWjQ0WS8yZHJ0VzErK2dKUDNaRjc3N0VxdGR5ckJHVkJW?=
 =?utf-8?B?RDhUZEZYcmd3WFhySFB5eHp5NExma0ZvaFk5WXorbEdGam93c25vaVFuUmww?=
 =?utf-8?B?ejhydVZ1YXRBTUJNbkNCMmZQOXc3dWRybGwveXVMbURJc0FBT0l5TzZyUnEw?=
 =?utf-8?B?dGx2bVU5UzJ1OFUzRTQzRjEyMkxGVjhEUEJGZ1g5Vk5tSkY1MmxyT0ZWbnVp?=
 =?utf-8?B?QWQybWxSZ29LRC9FaXdJakprU2lJREs0emhpemVObTAzQnN0U2RaNWdnOHNP?=
 =?utf-8?B?aitFVFl1aThzVnBaVTRTcmIzc25jYmQ2SGo3NkVSWDdac2Y4UE9PZEFXVUhn?=
 =?utf-8?B?dHVTNHhpbHlPZ3B3cGdwVlFyMEx3N2dkVnJ2MVJqbTlWL2MrQlh1MU1ZSWpv?=
 =?utf-8?B?cGxNTEhjM1J1WUVWcUdjOG5oMFFxVjRpamtjdHBZaFZFdDNuKzg5L3FxY2pC?=
 =?utf-8?B?anNuaUsxcEJVd1lZQnh3OUlvaGk3WFNrRm83djRnMkRCU0FDY1FkalM1ck8z?=
 =?utf-8?B?ajdQRkc2SUdEa0tnZSt4NzRDZVNkMUc4OGZXa1ZUSFFXc3dtNUtsUDdMczE5?=
 =?utf-8?B?UklqVTlLV0pJelBkc3JidEdTSllJOC8xTG1ZS0I1VUkxWkE3Z3BTZVpoVVAz?=
 =?utf-8?B?OUpzMFd0aG1ERlZoZWZneUVLanB2TmNaZkxJV3ZxSWxHd0g5Y29VNUZyRHVR?=
 =?utf-8?B?RG51TE1sQ0pibW8yME0yditPdGszRkpoM3R2emwvZ1Mva3lWSmlGTEtSOXpT?=
 =?utf-8?B?ZHcxL1p1OW4wRG9wSUVRRXNQVU1Eb3NFYmF0RlV1VjNMUWt3c2JKa0JheVZH?=
 =?utf-8?B?OTVTWUJDMGI3UG1GdmtoWVltcWtrR1ZQTU9FY2g4b1lCWndWWWgwTlJFZTYw?=
 =?utf-8?B?ajNpU2QvQjI1aXBNQ0duWU9vN0hvSElCRjVSVXNSbld6S0VncFQzbmJCNFg5?=
 =?utf-8?B?M1hKT3h1Y3dYUmZUWDNvazVOK002c2JlbU9MM0o2RXV1eEZqaUlHNDE3Wkhh?=
 =?utf-8?B?S2ZxV0tqcFlxeTA2ZjgwenpyM3FDc3MyUWtLRWtxcUFqNFFSVWtSbUFNVWVL?=
 =?utf-8?B?Vm1HRlBwQkdHUVFTNzBpcXpCTk9EN0F4V0NVQWIrNmY1WUpzcUM2blp4c3lX?=
 =?utf-8?B?bzlZSFc5d3hjWWxLTVdML2FmRDFTTDl5bnlpdkUraG4vMVR0MjBkSXhGTmZS?=
 =?utf-8?B?WnNLdGMrTmM0ekt0R1Ficis5WnVXT0Nic0Ryc1dtcGlzUFIwUnVWMGhnQkQr?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8075b862-901b-492d-c796-08ddc2c1a9eb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:31:59.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiKvKu041N5sIkR17RmeB51zQXH2X2I3v6YBDWcHtSeLjYl6mGsZinMjhJ08/SglRR1jph1NnOYIer3bQXXhNLb4bxoRWRSfk14iUM02D1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980
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

Hi Tom,

On 7/2/25 3:03 AM, Tom Rini wrote:
> This Kconfig option used spaces and not tabs for indentation. Switch to
> tabs.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
