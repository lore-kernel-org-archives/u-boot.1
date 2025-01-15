Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADFFC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 09:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98C480040;
	Wed, 15 Jan 2025 10:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Li7vf585";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D05080214; Wed, 15 Jan 2025 10:29:19 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4F280027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcBmUiuDRllLC7+N5LaBnMp92k2W1JOfCCz9SxEsaZ3+hwPUSbEI//2KiLbG/AtNuTecQm8HHQIHHCdHVjqH7hffKMyowLcPdGAR4IE7Dx2sU7/b/mO6svmKj/YnSLvSnEO2pLVrZdFO75JrhoZR5PEC7err3bcK6iIik1zNJOqAIia5ja+On/YbCXR3T17Ch/T3FID3Ho3hbpcKO9chCJKH4Q/kzkRw8VmGUxeTwH0mzz2iUcNMz2/OXXV+hep7gizHFx+G5Cz21keCSYeih+ZldVyu7jECX4qiA9rRN8+/COCRFUYuHPMazrkXLhEFBowv+fR8UIC2yBAHjQwuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6ZJQwpE5Hv8qbzkU0Vk1sYpyhhHYCx0gk82yHpWRws=;
 b=FP39CYztJvcQ3n0Rr7I/SJ3KMtrp3ZZ2j1QHoV1TqHNATmxRxMrNzuXV3JuUemW9S3p4dAgf7+VNTYwzd8mSUUoHRJuk2au5cQbHBh4wc93D1paH5X6d6tmh31LxYRJR2jmg+kdVc894Zm3haPgrMVs884M2S7W/rRliQTCwzvZN3LyWWSs+4ucPEc8/bfiJPccOnoFWKs0kR5namWL06ZNAFk/B8QSeR/sCWfY3RkEmbQcKzNtyMuoc6Tz8fSu94JUBJ1dEQ/B8wdpKaeM7fS4lvaZIU6N9vLOUngykgc0Jbnq6gZdVJx+5gVBKyVAQO55qa18p4B7DBmbAlPc8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6ZJQwpE5Hv8qbzkU0Vk1sYpyhhHYCx0gk82yHpWRws=;
 b=Li7vf585ewPto31nSv/mqIrddY5KtjwCAEeWxVR+5XpMsUflrN4/MLq5E51Re9CadIPFN2poNB64XVh93D6wxWM1xAAyE9Pkb8+H3DdgmUxbG31HXk0QrJssFsyKwkhWd7eQJcZlxV1jJ5yr+P94OP/7mvXXyGyvVV44Y8/qNoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 09:29:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 09:29:12 +0000
Message-ID: <0b88a0e0-626c-4550-b59c-d118290d2e96@cherry.de>
Date: Wed, 15 Jan 2025 10:29:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: coolpi: Fix the defconfig name
To: Andy Yan <andyshrk@163.com>, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de
References: <20250113105617.2403788-1-andyshrk@163.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250113105617.2403788-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0160.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dead98-5c2f-44b1-88b9-08dd35471207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEpiY2p2czVxRUk4MjVNL20vK0pNbW9XTTYxTFZzWWxab2VMUWd2b1VIV1RU?=
 =?utf-8?B?SXR6anRuUVp1dk9JQXoySkk1VE9LK1FuVGIvS1VBTW80dDc2emFhZFNocjBy?=
 =?utf-8?B?YmZPNHFNdDZBQmJCY3loNktvemZmNTFGQjN0ZUNETWVDT0tBTVMxcUw1ODYw?=
 =?utf-8?B?SS9sT0JrbTMyYmhLNzVPRlVFZjNuUm1UUVZxbnd6aWYrdWJuYksrK0xBbjVn?=
 =?utf-8?B?eUhoalJnSnF1UFNScjVMeWpmcmpjaWswTmkwTXdUcWE0OWh1UjBNQitSeENt?=
 =?utf-8?B?NkJtVlkxalZSYzVRYWN5ZGc1cVZxTGhsdEJEWUIzaWV5K3dFVFdkZm5PZExY?=
 =?utf-8?B?VUF2V2hXc3N4RTU3TGhtUVBwUWRDS3dvcWtMZExEL3pmSnd5VHdIQmNNcXJs?=
 =?utf-8?B?S00rcDkrY3lrcWFzQ3BReU55YURvM3Y2NHdLS2JvRHRCSGtFMVVKZkEwTThw?=
 =?utf-8?B?YWZ1SkN1R044RWJKNTZVMTlSZStqL3JTSVNSZmpNV053SGNnNEFDSzRJWDVG?=
 =?utf-8?B?Z1hvSnZ5eG5JZE5zSk9qdmtHM21JdkdQajl2SWVORGlaOTcwSGJzYitMV2Vq?=
 =?utf-8?B?MEplQzVwczZ3NHZpV1Zjb2hTMThrNm56L0NwYzRrNFZnNEJ4WjNoVXVNQzdR?=
 =?utf-8?B?b2ZCSzYzdXFTTkpGNlZxczB1bGZSSGM5SE0vV3E0ZDcxU2pHcUQzZEVjaTZN?=
 =?utf-8?B?Wjh1R2FQMFBESjBiN0hKc3dYdk8wb3NCOStsRVFFdi8zdmVoS25lNjg3ckQw?=
 =?utf-8?B?Mm41d0Q1WlRldWZHR0xCS2g0eUw4NGNrVFhLaTdoSnVOYzhGREdWTzlVb3Q2?=
 =?utf-8?B?QysvNktwR3hkMXlEV08xa081OXVFSHBxeVVVOEFpQUNLNXlxVzk1US9EcmN0?=
 =?utf-8?B?OTR6WGRzQUFXVExBRDlHTnU3RkIxcVk2dWxxWHo4L3IrdktDQVF0SkxPeE1Y?=
 =?utf-8?B?czB5Y1F5SWFQOFk2ajZzOXZ2dFl2eGl1YUJYUE9ZUnJjNmhwbUJiOE1Cd2Zr?=
 =?utf-8?B?QzJPTC9kS0tzdm92YXhVeVkreGxua0hadkU3MVV1QWxibTVlT0p6bVV2VHF2?=
 =?utf-8?B?SVJSVWVBd1laQjM2ZzVxcDhnTHFDTm9obXpLZEp2QzJGclJPd0NndTZHSThE?=
 =?utf-8?B?WXJSL0FwaFpJa0pjc2U3TlVtczlOcUpUTktQQkZ2c1lTZ2Y3NUNIVy9qNCtJ?=
 =?utf-8?B?d3d4aWxZODllSFRnd3ZnMGpzd3VNZVFweFI3V1RRVGZTcGtDdzN0SE5UNk1L?=
 =?utf-8?B?dTk1RXFpTk5tT1dFNnYvQTFzU2R4dUhoQVZGdnBGamVQNUR1aVFlb0YwdjVk?=
 =?utf-8?B?c2luWmFvTXIxVUNQS3Q2Q3kza1piU2x3L3RSVk1oMjl1aHdyMEdBeXhBQmUy?=
 =?utf-8?B?QkRYZ3lGaDk2U3Ewcm02YmRCckZyQkZROFM5MEFYZm91S0FKMnk0S1pBQ2Zs?=
 =?utf-8?B?ZEZSbTlUUGZUR29KSlBjbEJlckNIbzlJTlpUNmM5eFV5ZWh5Y21jZ3RUb3pR?=
 =?utf-8?B?azFsMnNMc0NjU2RPS3c0T1VGSWsrekdIZWJjNWRBT3VSc1pjTnplZ01qUHMz?=
 =?utf-8?B?ekxISHdJSFBhOTRuR0pQTERralo0bjdNNWVWT0h3UjdxL1hDaktMVGMycEs1?=
 =?utf-8?B?VGV4ZC9oK2l0dXdVTWVRV1hWak1VdmZmaEJ3TVc2ckgxTWF6UzJKUERZT3cy?=
 =?utf-8?B?UHVTM3gxWEdtREd1Q2g3QXp4VlpQZFZWSHpEYi9WSEN4UDlvMzVmc3R5UFpV?=
 =?utf-8?B?YWxZeWptNVNaa0luVnhpbGhFVzJKZWxaSWUxOG0rM2R1S2plKzBhSFJvUDFX?=
 =?utf-8?B?N0xYNnpWeW9SMEY2M0tEQ25TOGVnZTFhOTlQNDBGNG9rZDlqNWQ3TFBJVlJO?=
 =?utf-8?Q?S6T010LKe4tcC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNtaGFSZjczUllTTVFXdlJDamZ6REU5QlRLT1UzRXl5dUlKUDUwWUZybFR3?=
 =?utf-8?B?b3Rwbmx6dnlzMmlnTGI2VUc3UVhhR1cyUkJ4M3NZTGNuUGhzN2lGU2FPNXdF?=
 =?utf-8?B?WVFSRmxxME1HRkphc2g3S29jV1pNRXNQWERSKzdlQmxlRnJwM00xc1JBdEx6?=
 =?utf-8?B?Q1hSMkZiZllFeFFFTE9vMXFHY09McnZFTHFOS3dKeEVCd3ZkOXBGUElPRFFk?=
 =?utf-8?B?U0lKU3JSUjArRnlnYU55OG9iR0xTSDZIOU8rRzBLaXdKWjlURXVOQUxsZzhW?=
 =?utf-8?B?OGpiL0dJaE8wbXQyMXRpK2ZYNmI1UkZQclY0aHRiTFFJVzZOaDUvWWxaUXBI?=
 =?utf-8?B?RnVKRlJ3dmZhbE05akFVVDhYeEluMWRjaTlRd245RW9TVjNibllkVFo4L1Ew?=
 =?utf-8?B?TU5mU25SRldRQ0JkRjQvKzZjQWR2U3hNalRoOGpEWE1BMTJySEViQVlKdmJv?=
 =?utf-8?B?REFHaGpaWkxHTzNEcURHdVFGZWttb1BXMzdscVUyQ3VFVzliQ09JL09HcXor?=
 =?utf-8?B?eUhhcXdpdUxIdWF0Mnp1b1h5Y2tSdEdFKzRPZEhkNTMreGFzRlp6OUFLL2Zh?=
 =?utf-8?B?cEY0S0xJeEY0VXcyVWN1MDF1Y2NaVE5jUU1VNEJMZTdjalhSQUNhYU9qMDls?=
 =?utf-8?B?TDZ4eHRZYkl1MW41dFZsWEszdERYTGRBc0h4UTlZd0xUNmRvQVFSLzROazRk?=
 =?utf-8?B?N0R4dzNNSUZDZXFYYnM1L3g4ak92RDFFbGhscjAydUM5dHdCZ3MwZ1VOVUk3?=
 =?utf-8?B?R1UyeTg1WC9wRklwdE9aZWlkZ0w4cmNlVWF5cUZDUUZpMlo0YU1zMUZWNnFi?=
 =?utf-8?B?MGh3UlhTZFB2RmQ5cEMyZHZVekJFdmp6SjRTMU1tQUNSR3lRbVNDVTJYZHlX?=
 =?utf-8?B?MjU0MTVlYm9iZldmZkFUdVV1eXNmTWNDYTFpT0ZGcmdyM2JkbTZSYjcwam5N?=
 =?utf-8?B?am9VYjl6eFg2T1BUanIwcWlnSU92NDkvdlVyYjBuK2tYVndMK2RRYzRCSmha?=
 =?utf-8?B?ZjdadDErV0M2bTE4SVZ1K1Y2U1FXNHlIQ0R3cGgzMk93ZVpNT2RwZUdyUjRX?=
 =?utf-8?B?MVFqb0JkUVFBdHVKWEVWZ1pJV1Z4ME1GalV1VXZTME5XOFJCSXhGbGVkMHZx?=
 =?utf-8?B?cnlrejF5cTA5bWEzaVI0NGduUTkwSjg5REc2dTJSUmFKZ0pyVWpFRitTMlZU?=
 =?utf-8?B?dzNWeWcydWs2L3daMDA2ZCtMbUMycWdnU293WjI1L1lweGc2RHcxV3BKdXpz?=
 =?utf-8?B?dkFYKzFmYXZHbDdQRVp2VmR3QWlZdXZDVVBSb3JRbnpQYm5QSmxCNWJBRHA5?=
 =?utf-8?B?S3lwTjVxd2ExUjYyQk5BdkVPcldlZnQ1eDFFVnJQc0ozM3BDREhmTGM4S1Vt?=
 =?utf-8?B?Y09ySHcwa05YdTFRQ1FJMVE4SFpmTFFVbUMzL2tQdjdFOU5xb2o1czNKZHBj?=
 =?utf-8?B?d0plTGVWWUhJTjNLM1ZNRzN0WDdqVEFHUzlXS0FUQVRQTXJtL2F3QWJIOThH?=
 =?utf-8?B?WG4wS2YxV2Z3R2M4S25UUzdFTmYyZk1jdHFsWEZ2OFJ0dHFmSlIyei9ZazhQ?=
 =?utf-8?B?Z2ZGbFc5SkVONXdqTFNtTG5ud0F3WVcxMVBqS2NyZ1VSL054MllSN3BrSUdJ?=
 =?utf-8?B?Tm9NTHF1MyswK0RzUmVpTFdGV0dzeDg2WWF0MTU1RWVSNDRhNlMzWXNsT2lX?=
 =?utf-8?B?SUhNa2RLTUpzV2tCUm9FNCtuMlA3azBxcEFGMitxZ0xjalMweFA2VU1HVW5i?=
 =?utf-8?B?VzJHTmwvWE9URjQ1V2phQjhuTDdMZTU4RHdVaEUxOENBeXNUcHBVN0JsTzJK?=
 =?utf-8?B?b2JYY210NFlHMVZrMDFuZXRXZ3hmaldBbGRUTWRyUDd1d0h3ODVUMDM5dTNH?=
 =?utf-8?B?ZUlIR2R6WTUyTDA0UWwycElORFVDVUJVMy9BdUNxaXZ1elBsM1AzL3NnUjJi?=
 =?utf-8?B?TFFmTCt6SEdKNmNlTFBFMDc2cFZteS9FT2wwcmJXY1ZRT1ZEZU54dE9zVVpu?=
 =?utf-8?B?aWpVZXNRajJFS1JNMlE5amgzQWREQWhpN2NnNGNhem54dlhrU21oVVRzamgx?=
 =?utf-8?B?WGtNSWdQMVZYdDlJU3MrTDQ4VHY1WE13Uk5ILzhBQnRIRDdWSDg5czRnRDBX?=
 =?utf-8?B?dUVQZzYyaGRoQ0c2THNPYisvM3EwSjFCdjhUV1Y5ZnM0TUtxblhBaWJqT0tv?=
 =?utf-8?Q?9MjWem85p2O2Mpi5GvpZXJQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dead98-5c2f-44b1-88b9-08dd35471207
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:29:11.9890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5kKWua1qMUJ52u48/Jo1Ya2Ey0EpSpx4BHyyGZrj6+W9Lazm1SayLxIz1p5jzKoECh9p2aa60QBIOX8aK9DsOKxrVc8zunTNr+MZQEly7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
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

Hi Andy,

On 1/13/25 11:56 AM, Andy Yan wrote:
> The defconfig name should be: coolpi-cm5-genbook-rk3588_defconfig
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
> 
>   doc/board/coolpi/genbook_cm5_rk3588.rst | 2 +-

What about renaming every file that are inconsistent in naming?

board/coolpi/genbook_cm5_rk3588/ to board/coolpi/cm5_genbook_rk3588/
doc/board/coolpi/genbook_cm5_rk3588.rst to 
doc/board/coolpi/cm5_genbook_rk3588.rst
include/configs/genbook-cm5-rk3588.h to include/configs/cm5-genbook-rk3588.h

If we do this change, we also need to change a few variables in 
Kconfig/defconfig. If we do this change, it needs to be done in a 
separate patch though!

What do you think?

Cheers,
Quentin
