Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE3D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD3688DB6;
	Wed, 16 Oct 2024 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NMfieEtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9439B88ECD; Wed, 16 Oct 2024 09:20:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5242288EEB
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGFKJf490V2GEWmmEf9i3aiFhCkVfrciY4SUQH8IgHfCRaijNnLLcQbSQIPdvFHrNP0qpJMMxbRJQILyvyzvC9C1zhh6k2rQJcDqsKA1YU1lZ4Cm3O9w+k00GVpZshUmRLmEM2qf/V7GaX4HuFNxvIyE8TMXusV2u4iuWtV5DZj32wuQhtSiVFY8lbMcr7ugnhOUKHibEvfqaXEEJwUJWbduPhUrI0mmLbKcMiljzY8jl/q/xD0TMydziShfySDVn7123tvfjyep+YV8yZb3gyqMBXP9EDThj+weiO3r9MoPTCyDXZK5nkqyo6XC7ta6H1vJANzFuVeY7H05x76EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zap8wLvi+oQENGdr28vtICv2Hy59r6qxMvbnCDIP0RI=;
 b=we2mNtoMQ0ah1v6IKOAZyrZmdS69c9ikJ8aZkGqTsuD1rBZ7RJV4WH1nMeXiQ1fthmdaJONFFJnnahRb7TUUDXkFBYmPKJorEP3mTelbI3JExs6t3uv3sNSdhjnE+yHloqV6J43vdeEl27fv4/1gdhhWSzNoxE8I0T/Sv+QLAVdAuseoCRngVqFqKehY3fWce/ApSOPOXg3XKHAgAFar2oLO+/+7CgU8FjZfzt7SxmOuBkNyis6x50OgoDOOHLic+dDJFTSmugQXqC1kkltJ6Few8dYLP/DIkaM1MnwYERbFGSgLKhfRos1bm5I5Au+3gMHkmvwIQTESLcSAhRHJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zap8wLvi+oQENGdr28vtICv2Hy59r6qxMvbnCDIP0RI=;
 b=NMfieEtWWBSZQyII/UApLm9AHvy2j+NInzkw/Ln+/vq7vreHpKAyzuhE5+2PDrUbknAKg+3cwG9WsWcNiXd/jt6ffUpyUt8d1M24HFZJgZq76nuicFxLc1zmSsZa5OjKm63edanUIaeWMPXEuQZLhV9nh+icJk/jqFXY+/DzWqzR1zfk6KlMzw29YHRAaZey0rptPHflEAP1cOE0LxxKBqYlp1kCjVukTc2UddT15vMTQoefiWj9tTGpBQ2yn3yszQ7AIx2Q96M2M5XwjIeNuzDW0NaNjUvS2El0Jm6wEkHzJdGLre+70f0BqUjPiLb8KpGA+4BILGPyKiud3K7pSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:59 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:09 +0800
Subject: [PATCH 16/17] imx: Support loading container image from RAM device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-16-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f31385-df15-44f9-cc61-08dcedb2f1b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0JxUXFwUEZkWk9sdjRiT0hrVk5OcUcxYzI1RWJWYWJYZkM2Y3BsYU8wck9p?=
 =?utf-8?B?eWRjOG9BaDU0U2g0WWh1M2J1T1E4cFkzakFnS2VSb25oVUxKTjByVmQ0QmpK?=
 =?utf-8?B?aWNRZlQ3Y2pTdERvbXdKdlZsUlFqVU51VHk1NXFXaitBb1FvQUdmeFhCdVVF?=
 =?utf-8?B?MTRpQ29Ob2VFMnBRdkhJT21LLzl6WFRLWHVSM2NBOHJBcGo2VGJxNWVaZjQr?=
 =?utf-8?B?ZlQrQkhQVHRKM3dHeC9ObmVzT1FzQnM2cWN2R3hrdFVtbXJzb2doNThKZGtE?=
 =?utf-8?B?clJ6UndaallpcmdPQTFQTEZucGdKQW04N2ZlWDlTRXBlMk1jclh5WEdpZkhI?=
 =?utf-8?B?YWxteUFoRmNjblRlM01TQkU4OFl1UGZxVDl1RVNGaFNFZUMwRkJ5Sy9jQlNN?=
 =?utf-8?B?eGNpSGc1VElpaW1DOFk1MjZQbnBZNHZIUzBXZy9KRWVmRUpvY0hydHQvYk5H?=
 =?utf-8?B?a0Jic2RKb1E0cjRVNVR2SjJrRDRyRkd4QzdSSnpkcTZwM2FnZkxtRUszTGR0?=
 =?utf-8?B?ajhBdHhidml3NmdLWEtRM3gyZytwTFZyVzJ2QlovYzZtd3RuWHdDbkdRWFh0?=
 =?utf-8?B?bERqQ0VxY3YybUJvWFgwOHFUZ1hCaFFnbDZMTTVTMU11QXF6QnhpaUJSWm9x?=
 =?utf-8?B?U3kyT2xUTEYxRExmbWpSNHZwT003WmRyR3ZSWjlGNk1zWXRUWEV5cjc4OFVK?=
 =?utf-8?B?MldGN0thYlZ6OUtpaGdpMkRjTTlHaUZhK2hxZXZwMTdGTENNWFRobFl2TEp0?=
 =?utf-8?B?NFVZTzVwOTNwNDQ1WmtOV0ZmTTQwRkt4THVGUG5aczN1U1BUMk9rYW9ZMW50?=
 =?utf-8?B?Q2hMYkZIczRHdCtDanNESlpxMEJHYjVIRmdVZVFsbkVZRHZRaHBiOXNEMjMx?=
 =?utf-8?B?eXl5S3BSblJ3a2JBSE5DVmNVbk9GeVdCQSsrdEdtbUxPOEZkMnJNZm51S0dr?=
 =?utf-8?B?UzBWTTFtdkJ0eXFKd3lVUU9nUnhMNHdVWFZHQWFscFVQWjI2TUcxTzVXWWx4?=
 =?utf-8?B?dmtEM2RWYzd3WFF6SEdhbWMzdjFWK3hUS1ZmU3BBbkdXdVZQcm1Ia0JrSXFE?=
 =?utf-8?B?cTI3VXNkQ09ndWk2R2w2ODl3Um9abzJQSVFVY2ZiSllxTlZnTjNjMDFkTkkv?=
 =?utf-8?B?dzhPWFcvNXloaGZxK3BoSHduTWVRc3ZldmJJd0M5U21ZekRqVzE3UjF6SFMx?=
 =?utf-8?B?Z3UvcGt6SUhRQkJlYUhhOWJQZW1CakNFdnZkakVVV013enBKTkFPUGxPYmVP?=
 =?utf-8?B?ak5pdlNXbEdvZ1pYVTRSWGxNd0t0VWVaU21rVkVTdlhURmFDLzBtZ2JKd2hF?=
 =?utf-8?B?UFRBMDh2bkdLZFdsL0F2Z081WHVHWEJuamp1UkpXU1d3cUJieHl0eWQ1ZEp2?=
 =?utf-8?B?L1lWMGRXdU9YamhRNXFEajRqUUx4WmpKSGRTclVERENGNXkyT01Hc0RaZzNz?=
 =?utf-8?B?MVNpVEg5VldPa3hUWlV0R2NLR0ZQcDI5Qi95dzdRVHB3MnpiL2hHeDFHb1Bv?=
 =?utf-8?B?YjV4b0tuSUZMVUpCejdsMVFGaXk4Sk51T0xNQ1NKcWgvems4akE0OWIwNXBO?=
 =?utf-8?B?RHZPaUxSTGs1UWRYTWF6SzB4eUVrcS9GcVMvQ0FNclFjeVdVWW9tWlFtbXFq?=
 =?utf-8?B?ZHJrMFBDS3cxdVdLNXBtckp0d3EzcHdlV3hqVXpOUmh4aDl1K1daT3IvbFFT?=
 =?utf-8?B?UDVBc25EenBXMGxvS0NBMGhsbyt6TFJsNTZxQndYNjZhMWNqZVA1Z1JOM0hk?=
 =?utf-8?B?VG5ETmkzQmtYV3N6N21MUEQzbUIvNnJzaXFlUTdjYWRSTVpweGxqRys0aU5m?=
 =?utf-8?B?NnVVZC93djFuVEtrN2hqdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTliUURpVDBhNmNSQUtmQ1FKSmZDNnZiQzBNYzlUVU1sdVZMRFBmNTdiVW1W?=
 =?utf-8?B?akliRHpteTZtc1UraGdCKzdvaVBONVhFekdITFFUZERzQ2tFcnNWM3p1KzRE?=
 =?utf-8?B?YmVZYkw0eWZlaEFoeG5idVptckxubmljUHZsTXh2dlFyLy85RWMyMHNyN3dl?=
 =?utf-8?B?OFpQM0R5dkNoakZnd3I3NmhicThVWDlpQ0JaalBzZ3pZaUMvZUsvbUk0MWNL?=
 =?utf-8?B?QThzYU1UY1NsZEhJU3IrdDFGcmlxQVBEZlRFTCtiNHdmb1Uyb0U3LzdMYUt1?=
 =?utf-8?B?eFlPdU1oNUQwUzZkMGEyRkY4UERzQWpsaWlxUi9OTnd3aTFDeHRIZll0Y1Mx?=
 =?utf-8?B?SEwvd1NWUWlzQzQ5a1RFeDlTMm1UVktENnRCUDZ3Vm40MnFNWldGSER1N1pZ?=
 =?utf-8?B?RW5YVkswNVNWMlpVM0krR3QwY1hveWMxMXJrVHVFSkZob2VPZWgxSzVoMndx?=
 =?utf-8?B?THNYR0x6ZlNWTGJaeEZVazVVdEJhWVFZQ1FtbDd2NUFYbmIzUCt3RndzbTRT?=
 =?utf-8?B?M3Zna2pnR2ZDNUpjYkgzZXNqTUhEZ2xvSjFUUm92WERjOXF4ZFhqSnRJeWgw?=
 =?utf-8?B?aWMrcFl4dzZIQ3dkY2NKT3Bab0dLYUp6ZER0VnJ5Z2pycC9TUEp1UG85dWQ1?=
 =?utf-8?B?dVV4eEcweEdVT1QrZFdVRGdjVFM1cXZNbFJkVmZyMmFCY0p4YlJISmhXSWts?=
 =?utf-8?B?VjFYWllIU01UUXFYV3ZZUnVBMWZ4YUZNMHBDMjcyRnNybE1ROHRFWm9pdS9Y?=
 =?utf-8?B?UEdWQ0xqTUE2Y21hVHBBWkxlcThndFdRdVM1Qkx5QUFlamQ2VkNMRW1uVVpD?=
 =?utf-8?B?cTZ6LzVlRjlZblVwZk1RaXh2eVQrdkhiV2tLcmRpcStGc0FGcTVudWRtTkpv?=
 =?utf-8?B?WFI2VGNOK2xOZU95bWRzam9QbE9UdnNwWFNJMFdaMzZpQ1BBM2NaNEc1U2hK?=
 =?utf-8?B?ZlJGWEROUitUSElWQjFZeGIwb3hkR3loeDY2NXVlMElzTFRLT3RHUzU1SWd0?=
 =?utf-8?B?a0Q3VndmS05EZk8zZmhoelpwQUFSZmRhdnBkVHh5eXV1K3UzY2EzRGdFUUJY?=
 =?utf-8?B?UFdtMElqY0VUUWUyN3NVVE9QT09WV2o3SHJqL3F0bTdOR2kzTEN5bEdxT1RI?=
 =?utf-8?B?R3l2cWpEcDVCcWRpY2lPS2djZkRLNVZsaGdJbjd3WGVQVmpvT0ZjYUdhQzY2?=
 =?utf-8?B?ZFFXaHZ2ZWNucTNyRFpBcTB2TjNLWGpQNldKZjRKRkwvWDFURFhCSWthUDB0?=
 =?utf-8?B?cWpIS0tsVHZTV2V0NERzaVRQRXFkVW9nSTRDSVNvbVBrTHFSMzRQdFlwQ1hs?=
 =?utf-8?B?OExWOElBVVU0KzFDNVJVNnpwNXFvZmE5cGgzV3MrYkxIdjdqRzBMejIyMHo1?=
 =?utf-8?B?Rys4aTNobGw5eTRST3NWSVJiOFQrVGowSWdWdVNNK3hKVW5TOURuRCtJTUU0?=
 =?utf-8?B?d2pvUHFrM1R1WitHRU5FRjY1NFdRWHJoNWRuMXl3WjNVdzJjNTFoZ013Tk9W?=
 =?utf-8?B?TUptV2luVVVJdWhUdExhazVRYXh2NVFxUXBYeDZYU2Q3Wk4va0ZmS0xOeWtC?=
 =?utf-8?B?SStQeGRLUW95eUxRSEcvMzFidzRhUTcvUDU3S3RuTkVPYU1LclhLRGJDN0Vz?=
 =?utf-8?B?cndaQXBvVzF3R05NdUlHb09UM2FpWDNydmJuQ0NBdUorZVVhWFI1YjRQS0w1?=
 =?utf-8?B?WEdVRVkwM1NJbTA1Z0JvZnpFQ0IvdlRXYXM2WVNnanllUWdNVmdVWkRGVEVB?=
 =?utf-8?B?dENRZy9uc3Z0bmwvYlRLVVpuZHdUaGtXK25XQUNvZ3J0SjdHbExRUmg5c3Nq?=
 =?utf-8?B?QnFObTdvcTZrQVhvL2Ntc0FwcjlZZ2RrNU5PeTJmalgzS0MwalBMNVFpaGN0?=
 =?utf-8?B?WGJNUTg0dzVRZUdjR1lOczRhNlZ6RW5CamhOaG56VjFXbTBxSStMN1JERzZa?=
 =?utf-8?B?VldFWWZkOGVlWWxVS1NTdmVFVXBWRWN3SnZjQjYwZ2RHb3ducTZnVEtFUVNS?=
 =?utf-8?B?MktUVlF5U2xubHEwVGo1SGw0MlZ1WVUvT2tFbzQrZDJBcTNMaUxMY3I1VkIr?=
 =?utf-8?B?bW9XRmJTNGVoQXEwWmhxQnpGWU03UmVDSUZ3Wm54NlJWSDlWN01CZ0VWUlAw?=
 =?utf-8?Q?2a1xBLzIJF7lVber9NNY2S1xF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f31385-df15-44f9-cc61-08dcedb2f1b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:59.6340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ci3z/shiP9czFNIs079eCxGEzDQrXELCS9229byQqb1SCCOrg7TK6PFHTaWuyOmr0iokptF5r0PZDGfQ8k2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

From: Ye Li <ye.li@nxp.com>

For some debug case, we have preloaded the full boot image to RAM
device. Add the support that SPL can load the u-boot-atf container
from the RAM device.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 22 ++++++++++++++++++++++
 common/spl/spl_ram.c                | 34 ++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 54ae7721888dbc93fdaba8e5aedc52c4506bb1c1..27dc162f2517b6d75b0ed95510c09385f7cbc859 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -21,6 +21,7 @@
 #define NAND_DEV	2
 #define QSPI_NOR_DEV	3
 #define ROM_API_DEV	4
+#define RAM_DEV	5
 
 /* The unit of second image offset number which provision by the fuse bits */
 #define SND_IMG_OFF_UNIT    (0x100000UL)
@@ -148,6 +149,11 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 	}
 #endif
 
+#ifdef CONFIG_SPL_RAM_SUPPORT
+	if (dev_type == RAM_DEV)
+		memcpy(buf, (const void *)offset, CONTAINER_HDR_ALIGNMENT);
+#endif
+
 	ret = get_container_size((ulong)buf, header_length);
 
 	free(buf);
@@ -222,6 +228,8 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 			CONTAINER_HDR_NAND_OFFSET;
 	} else if (dev_type == QSPI_NOR_DEV) {
 		offset = CONTAINER_HDR_QSPI_OFFSET + 0x08000000;
+	} else if (dev_type == RAM_DEV) {
+		offset = (unsigned long)dev + CONTAINER_HDR_MMCSD_OFFSET;
 	} else {
 		printf("Not supported dev_type: %d\n", dev_type);
 	}
@@ -382,3 +390,17 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
 	return end;
 }
 #endif
+
+#ifdef CONFIG_SPL_RAM_SUPPORT
+unsigned long spl_ram_get_uboot_base(void)
+{
+	ulong end;
+
+	end = get_imageset_end((void *)CONFIG_SPL_LOAD_FIT_ADDRESS, RAM_DEV);
+	end = ROUND(end, SZ_1K);
+
+	printf("Load image from RAM 0x%lx\n", end);
+
+	return end;
+}
+#endif
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 71b7a8374bbbf534e1b2c28e02205af035fcfd8b..c3a1df59e3f3bcc19a6cdff21ec66a4bd4df7b93 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,24 +16,25 @@
 #include <spl.h>
 #include <linux/libfdt.h>
 
-static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
-			       ulong count, void *buf)
+unsigned long __weak spl_ram_get_uboot_base(void)
 {
 	ulong addr = 0;
 
-	debug("%s: sector %lx, count %lx, buf %lx\n",
-	      __func__, sector, count, (ulong)buf);
-
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
 		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
 				      CONFIG_SPL_LOAD_FIT_ADDRESS);
 	}
-	addr += sector;
-	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
-		addr += image_load_offset;
 
-	memcpy(buf, (void *)addr, count);
+	return addr;
+}
+
+static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
+{
+	debug("%s: sector %lx, count %lx, buf %lx\n",
+	      __func__, sector, count, (ulong)buf);
 
+	memcpy(buf, (void *)(sector), count);
 	return count;
 }
 
@@ -44,10 +45,7 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 	ulong addr = 0;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
-		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				      CONFIG_SPL_LOAD_FIT_ADDRESS);
-	}
+	header = (struct legacy_img_hdr *)spl_ram_get_uboot_base();
 
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
 		ret = image_pre_load(addr);
@@ -70,7 +68,15 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_load_simple_fit(spl_image, &load, (ulong)header, header);
+	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+		struct spl_load_info load;
+
+		memset(&load, 0, sizeof(load));
+		load.bl_len = 1;
+		load.read = spl_ram_load_read;
+
+		ret = spl_load_imx_container(spl_image, &load, (ulong)header);
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 

-- 
2.34.1

