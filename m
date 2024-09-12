Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DCFEEB572
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 09:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A6F88F42;
	Thu, 12 Sep 2024 11:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Yt4V0va6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D535588F3E; Thu, 12 Sep 2024 11:21:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D66988F43
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 11:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSUysgvJ1GRgk9i2hLJYueDjC/sh9lC8iPC0eQWFAvhXIXUZlvKegTFKl62SSThOsSos8bznnQRRdcXdck+0/pNm/arM9ASsZSYsOWzeTJsw9Ru1NdFqTMdFkCLqTxkwADOOJQRlk4GRSqs7A4jYj21Gqj9j+MUUT0JgUVPfpmNfSjTnT00ve3JA/sUgW4sQqBXK5qnjRqBl2HJyZ3rJZRkswBilLG/eetMLK24Yy4jnNdsV60m9WqKXz38h9kyKgwKB2DjNSn9BxkULBI0Os5unyB3hFjIRI+1IMUjIzx0TUIpGK5OGFH2WF6g/bluXJnAmeHb0TOqlmEwGxNaPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr16ExJqLcXyGTp9RzGTeGn/UAQ4O89kdQO0enzdNw0=;
 b=VSs3t+pkq7Wov/LOx/tsZdAteW3l6p7BE02CJr/hAjU1gZkBVcBrvS/flLfR8Uk6dM88H7AmSNcFLpAvtDINAqCsM9hhrWjSTY4MIswJl4DPfIK4K1ggqDbey6IIXZRNrh0yCyR3efbrYRpZK6dZvoPjU5bnLGK/N8+0yCMCMFnLFBZlWewiHMZ9EEpbo8pmbsDVJ5sjXEWm6FuLFkjCjTQcgoxsavjkLIjr/MaTV8ZNRJuwP/YhztsmIM2tdom9l9ctiS1um5jcCxGTfZHR2qCsjt8p9hO8HlAPRThJKwta/76KTo31mg2Sfk+nM7UDLt+JPGimjHG2KKvjv0m+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr16ExJqLcXyGTp9RzGTeGn/UAQ4O89kdQO0enzdNw0=;
 b=Yt4V0va6i3eZj6Q9OrBOHsNR/n48MZDkTUNidmS3qUV5yrYBRbvnuBRUsoveTZCF0b92ycEXqm25QygoMgF5dyp5KUy4ULExrNYOZoVqORD/iLnJDpcB95C0LoBL80VPSGfE+JNe42UwbYFu+qUCa3cV6iWLNKkEVnO3gzQGP88U3KuVqkSlGa64QAWE4ayfdECONv/GYZK3uRXY2EQzxjp4Pd8DF+uzwx3HWqdVXn7NmJPuy3Kb2IVyChnVPaYVdBOHmYLzFnX5YBwQvECijFDNDk2de7vjn1o/LBg3wOZ16PqXl0na5znF3+620d3rQ33ijr6ligkYgOk0MFQvsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM7PR04MB7000.eurprd04.prod.outlook.com (2603:10a6:20b:104::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 08:48:19 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 08:48:19 +0000
Message-ID: <45629459-5e0d-468a-ac6c-789dc11d44b3@oss.nxp.com>
Date: Thu, 12 Sep 2024 16:48:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix chip erase timeout issue
To: Marek Vasut <marex@denx.de>, Ye Li <ye.li@nxp.com>,
 jagan@amarulasolutions.com, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
References: <1726051530-56280-1-git-send-email-ye.li@nxp.com>
 <6c353eaa-1609-4a72-a557-0b81ee337c5f@denx.de>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <6c353eaa-1609-4a72-a557-0b81ee337c5f@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM7PR04MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: fa91fc54-a900-436a-ba44-08dcd307a649
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVRqVFNIeWJtVXdvU0luRFNpcEdHWXVsNmJYbjRxTHRKbDRWcXNhRnpRT0d5?=
 =?utf-8?B?WU9BU2xFQnpBUUkwNlBvZnFUMFExc0ZoZHNRQTdIb25mWG5CbE9iOEQvUFU2?=
 =?utf-8?B?RXNDM2JFbEg4NjRMejdNNTkzY3hpUjhIQjU0VlU0b0E2cmhPRWhyOEZRVTUz?=
 =?utf-8?B?bm1paVFJcnpIUGhYZVRwcWl4SWhkRlJyUDJBcTI4SU1YVFVxd0x1K29pNElU?=
 =?utf-8?B?YzdVRFJIU0w3Njd5bVliaGpUM09jbWtxQ0ZBN1dWZnYwZUZMbGFERU15SzNq?=
 =?utf-8?B?TURoUVJkenhtSVg5L2ZXdzRIRmIrTk1XN0ZlQ2RNUGFTeTJHZXdCK2FMUGxR?=
 =?utf-8?B?VkVuQU9UVi9YTUg0cll6cVZleWY1aGZyZHpZbWtHYTRwd1B5NVBjR0psV1V2?=
 =?utf-8?B?OHhOeWZFS2lPNUwwRlREU2s4NGdlaUt2SkdjaExYcHFKdUxUeHJpL00yVzFz?=
 =?utf-8?B?Ti9QNkZtTXRJQXYxcDdjU3dyS1ppcm96RlJ3bTZSWjF5YnRvZkU0WUZzNm50?=
 =?utf-8?B?TFh1NnBCeWhuWW4wWkFKdzF5U01aSmhodDdqMjh4YzNTdFkzblBJZmlFc1Y5?=
 =?utf-8?B?c2RLaXVLaXZHU0tSQzZQRzNMUkthVm5RZDM5TlhsbWExWndFdllxT2VJMFha?=
 =?utf-8?B?Mlk0NHFUQ1J0QU1pTUp4UnlZZklkOUt1Y3dhMjhWSGZUQkUwenNQdVN1R05W?=
 =?utf-8?B?RXBmS1N6cUxIUmtDNXkxbmRnQ2RaOWk1SHcwUkQ5Z3lDUlgxUEQvcXREb3FT?=
 =?utf-8?B?bEtnLytINGsvZENPZDF1cmEzMldEOEJMRHhZMkU2UkhMMlIwNnI0aVlmNzA5?=
 =?utf-8?B?cEJRUmlnZlIweFJtM1E5M2F1UUwwWUZEK1YzRDRZZHh6LzkrNDJQSHU3RWRa?=
 =?utf-8?B?Uk8yWFNyRVIwd2VCTXR4NmZRenJucGZobjRna1JCQTJ5N2J3Vk9vZ3JvY3Nz?=
 =?utf-8?B?akFjN0ZLb1lqdzc0N25pWlhSNUl0TTkwVWN3a1pFUkZBZFBGYmxoVnB5NU9E?=
 =?utf-8?B?RlNkUjFpRnpaUFduZS81b3laVHdoU1JoUXRzR3NZc0RNTTJlQXhhanYwUmlZ?=
 =?utf-8?B?bUpSZmNNckxhM0x3Z0JneTV4T0JadTUwYml0TDYrK3J2UE1pdGtGL0hUUTJR?=
 =?utf-8?B?azJuQ2FhYUl3VHgwUVhrVzFZVG5pVnNtak5UYU05b2x6RFFqcEkvQmdMa1JO?=
 =?utf-8?B?ZzZqRnRndGFsdVhMZVUvWDFMbGRQZmMva2k1Q0pPbWp4QXJkNTJBZWl4T01Q?=
 =?utf-8?B?S3dPQjUySEJZMy9wbFh5eWlEUWFNOEJ0NFBtUy8wVTI4T2tkaUFMbmZpWGRC?=
 =?utf-8?B?UDZCeHJBeCtNZ2JxbzI1K0xDNUsyRHdRRWszdHh0VFNVOGhSTjhJVzJTYVlx?=
 =?utf-8?B?akhFN2ZrN1FXRnFJRVpEWWtKWTdWRzc4UHVlQ3ljU2trUHNEaVpOTkk0bGR6?=
 =?utf-8?B?bU5mUDFRMjNDbFBmVTRNZEh5bTc1RTVoU1lZL2dGK01mbGhhUnZsbVhmaWJy?=
 =?utf-8?B?REs4aHczeWR0RXZJa0JpYm1zajhmdFBKT3cvY0h2N3FIZkdrcUdNNW5RWFZ6?=
 =?utf-8?B?ZXZqeDRjQlVBQlNVT0diMmJxVHNaMmF6WDR1SVduWUh3YjZhR1h5eWhJdVda?=
 =?utf-8?B?SUlTNkZWVTdrbGdHK3dSanRmczZycUFDVVFNMktCdS9ya3pRbU1BRUVldTRh?=
 =?utf-8?B?NzMzSUZ5VWp4akhMNjNhMWo3UzdRTG52bTZBekcwQXduc2lFOGdQRkdOcXJM?=
 =?utf-8?B?VDVDVWhpVmt4cjFyeHAvQ1ZSMTVNbW9GQXpzaTJOdnJkUkswS1FyL0IxK0tn?=
 =?utf-8?B?WEl5bW92YjhkVkk0UUVuZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1WdXlSWGdFLy9XVDF5U3J1SWY5RncybU1qS2JJUDFCU2kveW5FSHZwSU1z?=
 =?utf-8?B?RUo2R1RTLzlGdkJSNlZQUEk3QnNBc2dMWnRwbVBZa0lMaGxhYXIrQ25yamxQ?=
 =?utf-8?B?SDdjM2hFRWx6MnhxSE9aWlhSM0lUVWpuaEhINi8rc28wSjNRTTZvaTdLbmNn?=
 =?utf-8?B?TDUvSHZNRnNaSHBTbldob25GZ1BGVGhONCswNUpOTDNRNWIxZEVYYW5rK3Vo?=
 =?utf-8?B?Q3FFdHNJUXIvV25LT3hRcDhMUzVibVNZZitndjJBcmFkcWVnRCtLNC9WbDVi?=
 =?utf-8?B?MVNYaEFlZUtHQnlwem5lZnh6aU1CbVNpY0RoTWVSNEFGSERIdjgrNDBpZ0Fx?=
 =?utf-8?B?TXdXb1Z6cHpvN2ZMSWcrMFpwa0dVWVNvY0h3aSt6bU1Nd1hpck1jYmlBRU5y?=
 =?utf-8?B?dTNIV0ZTV0JrZ1BzYkRvd3R1Skh0cGtzeE9QRUYrWlhrSGYvK1h6Nlc3di9U?=
 =?utf-8?B?TnhkVW4wVFZaVFVyMXdyYm0zNDVsWXZLSGUvcTlnUVg2SmRFSmM4OXhTd0p0?=
 =?utf-8?B?VCtZQk1QUEc1UFR4VkVLaWF3N1doWWVMQkR1dXJxQUR0V0xRMnBkMTBGdmpW?=
 =?utf-8?B?dWhqbFhZdGUxZmowN0pRZjltNW1BR202aWtvaDhmRUltZjUveE1FUHBFdFJo?=
 =?utf-8?B?c01MRkNycmRwcXc4dmdUVkxaV3cvQjNQb2EzUnVCRU5ESzZVdjdISXRwNzFE?=
 =?utf-8?B?cGNHLy9wV3pSUE91WS9yZDl6OW5zZ0h1YWZBZmFQNnl0Mmt4YWZZRnIyVnFk?=
 =?utf-8?B?cWJYWG9sMFp2K3pueDdwZnRPN1FUTmNMQXhzbzBHem1DWmdHakRoQW9mNkVi?=
 =?utf-8?B?ZERMK2wyTUpVblMxWDI2WVk0Y01VVGFBV1F6dHEwRUpBRERmV2lXdjhYNDFr?=
 =?utf-8?B?NW5mMS9tRHZMdEZXalA3NmdaeGtFQ0l5d005aTVkK2hDdDZZUGsyVkl2OGQ5?=
 =?utf-8?B?bytHRmRuR0huL1RWSmdJZVBFeWZrM1FXbjNyWVRrNjFkbUJQQWNlaXFNS3I1?=
 =?utf-8?B?MmlYVW1tS1BzRWEwcWVZYStXNlUybXFrQTZTVGZ4dHgyR29RcnJkT0dXNXdQ?=
 =?utf-8?B?WEhTZ2kzQlpLd3JiTmZPVXNXekJvNnlyaldSYytnS2dRQ3cyaEV1N29OK0F0?=
 =?utf-8?B?YWlRVmkxWmtWa2I3Qm9DL2w0NzVaK00ycCswYU9zVVhnZTVxMk5ESEZIRVY1?=
 =?utf-8?B?aGhHNDNJaFRSTHpveWthL1cvYW4yWFJjaVB6VGZVV3N0aWViUmlRcG1rclM0?=
 =?utf-8?B?NVY3Y2pBQ0I0aUpSZG1xLzVJbFR0SitCKzF4U3pVcWcrdDg1RWpWSDM5K1Rt?=
 =?utf-8?B?MEV1a0xheWtHWXNENVcyUktGTEcrUTZNSXo4OS9qTmpZVWxsSmpHNlZieEVH?=
 =?utf-8?B?OTAvVm15UkJrR1B3QkxjaXVVSThiU3FXNm55T1NBY1dYb21URkhNTXcyRVV4?=
 =?utf-8?B?Y3AwNXhoRmE3eUxpSUYyNFFKRjQ1eXpXQ3k4M3NGN1NGTG9ScUlhNG5JTXg0?=
 =?utf-8?B?aGlyVE85VklWYTFnak44RFNSbzVwM21hckI3UDAzUmVKRGxtQWpJZUNNclBk?=
 =?utf-8?B?aVhhRXJQdUFhZkFISTFNR2hGSitEQ3liRUMvWGltWDRNbFk0dHdpdVN6Z1JL?=
 =?utf-8?B?bnRsL0JwQUhpci9iN0p3YVVkcTlIRXJQM3hUTnB1ZU4yemZMUDhhN1BNTDFq?=
 =?utf-8?B?OXA4cXB2cU05aUVBa3psY1l2VUtYS083Z1h1QjN4bXVOaEptSmZLSFd6bU8r?=
 =?utf-8?B?c2R2UUk5cjdMWEhCSmF1K2x1WWtwS3dhcytOR3NMaGo4UERvSzI1ZFpQdGd0?=
 =?utf-8?B?bUkwN2w4a0RzQXU5UWFlRVpLbzkyOU5oaS9mVEhGRjBKZGYzTHM2UDlWSVZi?=
 =?utf-8?B?a3ZVWUxhNERpcUh6OUlBWlRRaUs3cENtQmE4UkY4b3E4OFRtYS9TNUxndHli?=
 =?utf-8?B?UjJsWnhEQ3pPdzVPQkM2Zzc3aENzZ3pPajRudS9LUEJFRnZyODFxUXVlS1pR?=
 =?utf-8?B?bXluRUpMYnY1ZWhCSUNzanMraVVMajArTFVEeVVPSW95QTFkM3VGNjBsOVBn?=
 =?utf-8?B?OVFtdXpzQUZhKzVpb1dhQm4rZldVMFVOU1dESkp1SUxIM1c2RE1yaVNEZ1lo?=
 =?utf-8?Q?cons=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa91fc54-a900-436a-ba44-08dcd307a649
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:48:19.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHG2YHK7xiKcPUAKveAcgqUuekmWRKfEdT/nGvGtExdnvxvpNelaO2/6CJ8OtdX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7000
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


On 9/11/2024 7:05 PM, Marek Vasut wrote:
> On 9/11/24 12:45 PM, Ye Li wrote:
>> Chip erase support was added to spi_nor_erase, but the timeout
>> for polling SR ready is not updated and still for sector erase.
>> So the timeout value is not enough for chip erase on some NOR flash.
>> Follow kernel implementation to set new timeout for chip erase.
>
> Is there a matching Linux kernel commit you could point to, from which 
> this was ported over ?

Yes.   09b6a377687b mtd: spi-nor: scale up timeout for full-chip erase

>
>> Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")
>>
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> ---
>>   drivers/mtd/spi/spi-nor-core.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-core.c 
>> b/drivers/mtd/spi/spi-nor-core.c
>> index aea611fef523..338e5856337e 100644
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -44,6 +44,12 @@
>>     #define DEFAULT_READY_WAIT_JIFFIES        (40UL * HZ)
>>   +/*
>> + * For full-chip erase, calibrated to a 2MB flash (M25P16); should 
>> be scaled up
>> + * for larger flash
>> + */
>> +#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES    (40UL * HZ)
>> +
>>   #define ROUND_UP_TO(x, y)    (((x) + (y) - 1) / (y) * (y))
>>     struct sfdp_parameter_header {
>> @@ -991,6 +997,7 @@ static int spi_nor_erase(struct mtd_info *mtd, 
>> struct erase_info *instr)
>>       bool addr_known = false;
>>       u32 addr, len, rem;
>>       int ret, err;
>> +    unsigned long timeout = 0;
>
> Keep the variables in reverse xmas-tree please.

Will update it in v2.


>
>>       dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
>>           (long long)instr->len);
>> @@ -1026,6 +1033,15 @@ static int spi_nor_erase(struct mtd_info *mtd, 
>> struct erase_info *instr)
>>           if (len == mtd->size &&
>>               !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>>               ret = spi_nor_erase_chip(nor);
>> +            /*
>> +             * Scale the timeout linearly with the size of the 
>> flash, with
>> +             * a minimum calibrated to an old 2MB flash. We could 
>> try to
>> +             * pull these from CFI/SFDP, but these values should be 
>> good
>> +             * enough for now.
>> +             */
>> +            timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
>> +                      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
>> +                      (unsigned long)(mtd->size / SZ_2M));
> Is the type cast needed ?

Yes. otherwise get below warning


In file included from include/linux/bitops.h:22,
                  from include/log.h:15,
                  from drivers/mtd/spi/spi-nor-core.c:13:
drivers/mtd/spi/spi-nor-core.c: In function ‘spi_nor_erase’:
include/linux/kernel.h:190:24: warning: comparison of distinct pointer 
types lacks a cast
   190 |         (void) (&_max1 == &_max2);              \
       |                        ^~
drivers/mtd/spi/spi-nor-core.c:1042:35: note: in expansion of macro ‘max’
  1042 |                         timeout = 
max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
       |


Best regards,

Ye Li

>
> Thanks
