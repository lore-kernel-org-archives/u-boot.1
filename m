Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6229C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 16:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC628404D;
	Fri, 26 Jun 2026 18:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JeEaLGkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A38C84894; Fri, 26 Jun 2026 18:30:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDF283FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 18:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTZQJ6o9vcUVEHuz7vVMMg6CAsZMPkGLzHcUTdeto27Wzz8HnebKf5IaPYJ71wztqZpVN+D8bOY5was8yyQBD1IROcNeWxRsGPYoi6UMJFt5NwpgBMGzLXyszneHW4B3bJauNmIuvzPlqModrpgaLYI3hwIxeUXAHEnbHQnejIix8A93Ro+SjMDXzFVYSLxiToK72fivBOiKOG0Y42+Bq5n3/24yfGe6adMVRwJ01H1oJWtjeyHkOnePR5QKUNJTld+KCVnGO1gWR1LLS7MC912+RSMHq/j0qezKznEDRrLQCA7k9e8yYcsjowOtz6zZKQ08gjjbJwV7V/XhTKrwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7C1tosLIYJfL7gYK7GStr/QiopasRVkQ2lEZWwZgP4=;
 b=zLaUDyOP8kQI64ikWsDZ4Kl/8uT3D4sspjWb/w/5BRZkYf/YQtpgRTC2zL0whOn7GGbSLyhCII0Tk3UJ/0zOO5CVJS5I8fxPOCkrQ6LMRzcAyVvGlMbM9QJbJDpOwYo3uicfrL+VQvUWP8N5kq1411Taw8LS6cpqSB7tpykoXLNP2p8oAptYtI5zmiKzZsJdu2VbEzavJIUD4DnC7tv5p6/PtEEJqh7RhsjP2JWZbBkCwMUov5XNT9MT0F9OMGW2uaIyjYWRlT4vNjZ1SrysSychMbmaiz5kzaJDPF2UanTqcOjoXQIX1Bml782IZGsmzVIYa8oMBWI5wwtajhOmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7C1tosLIYJfL7gYK7GStr/QiopasRVkQ2lEZWwZgP4=;
 b=JeEaLGkFFkSAcRgTlQKbxSLcTLPNadB6FlsYp9BcKt9OInTPHziPmdrkKmaJ+bkL9VEpg5JFYKg0H6hi4Y3IiZOKHDWJDx8HZhOsE8sXM8HtUI8+0x9rAwQsPJTvV+iJR/wDIS5KzUHvzf8dJd125Sm3cw5AvRixnsKufr5vcQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:30:14 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 16:30:14 +0000
Message-ID: <f2d53fad-04ae-4d7d-9a21-f0a5b3ba905a@cherry.de>
Date: Fri, 26 Jun 2026 18:30:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] imx95/952/94_evk/: enable booting Image.gz
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
 <20260620-imx-gz-boot-v1-5-143c60a572b7@nxp.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260620-imx-gz-boot-v1-5-143c60a572b7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: ac57581e-4b86-445b-bdb0-08ded3a03362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ejDcJ9tazyJJBIfR6beBql6c/ocPyw1DB3Hdl5+AhIl8ruZGHePcWJFl2wrrGiLvr07WXLAvPOA3FYxkDSKvy/fTJMd5DoqockHAnYYa2zRoTysWNRuwn43xuNayMdumJM8lhyi/HBWUZPeZKYPp0JXLa/J5d6RAIUUhQY16FwTeQvIYJQCZKOnjiAMtwST8HBkN9ddk6ujoRYVzcbz2Q7lBno5M1GsomYMSs61hs3YAcDAIpYhJXjIlMXyIUSGkRSWO+0N/9F3C05El+JBfOc3v3QRIJnnJFVJ19ya3pigBARCBIP64f6yYI+J/62813kHOnNrciCMv//QxcBq6aNfXuFFJj/Xe7pNRcS8wbpcQMOBiVILQkHkaBUpL+K5+nLM5Yrj9Q21GjkeMbz/ZtnmOfXxsOATDCBmZvhYedHKiUsUfGcMbH+4liA6ZN2NBeICToATsqsIMVYSVyMORz5SftnJvLKEeXgI0o2g3unM618N/8ir5axVhoGlUsq7jGdw72dmI6C2Jb1wyTHg5McT7uVc+0uG2O3wLAgggtI1J/cf70dnQ7li8Wi+/bHzR/GXiZd9pfHrVw2XUDuu9wtUvLn1U1TrfQkEzXYipHHbVGE5ULfdFtZX0vEXo/qFA1syBWNo7jARSeVMdtXDQuRZmwP84fn+9ttDtpxAHONA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBvUElrZ3N5djRJc3RmZmIzU0N3TmR4M2NCZFZTWnFiV2c5bmh2aDJZd0dR?=
 =?utf-8?B?QXowajFyOTJFUkJkV3lVRGw3MGtFY1lUbGpsWXJnTGFONUVDSUxacW9jYk80?=
 =?utf-8?B?WFRFdXhheFhXdnFvcWx5eFJiMUFsMFhYQ1hHdkoxUWlWWUFUQWgyb1lkRlhR?=
 =?utf-8?B?bHlnMkt5SzdDcjYrSFc0d3p5VTlwc1NzUG5rSEFJbllveFIzM21wMGtPWFIr?=
 =?utf-8?B?dCt2WEZWTkhqWmh0RFI4UnpYdGpvbFdaT0JFMXBRSnY4bkg4Z2FQTHJ2TmUv?=
 =?utf-8?B?NXVOeUt6blNEdTNTUVBYc2ViYUFwRFBRUUo3ZURKNkVMQmUzMEFqWjN2akJT?=
 =?utf-8?B?L3VRUXB3KzRjZXYwbHV1NldoZWxmWVl4eW1OVzNydHAvS3JkOGFLVGhyRnE2?=
 =?utf-8?B?djk2cU9RWVdHODFpcU5MQjVUK3VFY0FPVUtZeGxzcW82TWlkeDVycWg1MWs1?=
 =?utf-8?B?a0F2M1IyOWQxOWNXVUNYTmFsQUFRZHhhZDFCQjFPWGtDeGx2cWFITlYwUXM1?=
 =?utf-8?B?VXQ3SldlMFA3MGE3RXQ1cFczQnIvb0V2L0srN1JSVE9taEJuQXdnM2w5MGh4?=
 =?utf-8?B?bzdsSDNDbDJ1SnYyUG9hRVpmanlGT0MzWWJGY1Z2amlUc0xxY05LVjV6WXZF?=
 =?utf-8?B?REdGSHpNVUFzUlBjM3A1WkxiN2VhV1dLZ3ExVmE4YUNDYktvM0NXZUJlakFx?=
 =?utf-8?B?dDJJRERTVUtYemh3RG91azFPVTkzQzdQV3g4ZnpmdDFFMEJQNTVnc1lsSm45?=
 =?utf-8?B?WDRFNlBOMjZQVHZ6ZnU4Sm9nUHhjMGNxTEZDbnN5TG1CQy91Sm1wR0NNOHZi?=
 =?utf-8?B?eGJEUkV6bE53eDh0QmlBRUtuWHdTTkNnL2lTeTNVZnFZT05ZSFRERis5V1dQ?=
 =?utf-8?B?aUhKSDR4UnJ1L1FzV0RFWWhNTzF5TG55WGkrOFB6UVRSQ0ZtYlBWTkZQbkMw?=
 =?utf-8?B?aDQ2aG1EdzJPb2VxR2ZraHhOM0M1NG0zeDJDMXJIN1RnVkwwOWdpcTQvSW5B?=
 =?utf-8?B?RVdhMHhaaGtvblJxeTR6VHNQM3E3UzVNelRhRFNqWUx0TUpQUmlhRVBUMVk4?=
 =?utf-8?B?NHI2bFpKdGxmeWlGWkJ5ZFY5MGxoZ0RCNmdBSVNDTStmM2RwVzkwbTBYbEpN?=
 =?utf-8?B?aFlvdFd1cWg5MXZFU1dKQnpGV2tzcmJOY1JFRVoxaUFDWEJZM3pRcVJqTURY?=
 =?utf-8?B?WloyNDdxNVBUTHAwWm1XUmJuZy9iaVA1QjJ5cEhOdnhmYmVLR3UzVWFsenla?=
 =?utf-8?B?KzBlSDFyMktKSDZ6dDhPaWRWZWJpUXhSZ3g2ekJoa2oxK0VsaXZXTjl2SWtX?=
 =?utf-8?B?QnppQmpsdlI3czJ1RWpHZXJYQVhkdHFYaTRqOFpYMy9udGM4QUM3VzB6aUF1?=
 =?utf-8?B?SVBML0pQd3QyNmRuWXJNazBUQmREMXVWYXdTNDBxSU5mSjNGZGk5cUVidEdF?=
 =?utf-8?B?QUxMVDh1dko0N3lFVE0vT0xHK0liZlRHT0hibW9aOHdQdWVZSTk3UkxrM2Yw?=
 =?utf-8?B?T3NpM3Bzc0g1TzNJcjFiRFM3bUExREZ0SGtKVkpMSVVNKzJoNWhWRW1sVGQ5?=
 =?utf-8?B?UUoyY0VwTkx5bk9nQVFLdFpVY3V0Q3FvemhQd05zc2JFNnVPK1RCOUNVMlFs?=
 =?utf-8?B?YzJWVmlZNHd0Z0laYjBUWWhVVHQwNWJoYUppclZDV0RQV29JTGxVSFFrblc3?=
 =?utf-8?B?ZTQzUFlqb3dzRGROckV2dVJYbGFjSzZBVkFhT2xLQ3R1WnZyaDhKNXZDbFZH?=
 =?utf-8?B?RWxqVXZPQVdGaWp4enY0SStKWlVHWElCNitDWFRxQ2I3T0hVWEg0Y0RCYTdn?=
 =?utf-8?B?TWFzUDF3L2RhWFlUb21sSUhqS2x6RFdKbjNwcDVaRmF2NWRMTks4S3NSYkNE?=
 =?utf-8?B?OE9MRjFkV2s4a1dkZXZPUUo1VVZoUEVPRHBYT28zMkk5b0RicGN2enJUSFll?=
 =?utf-8?B?d1ZkS2FYdTJnMFBTRHNhMnpsMGVXWmhDc25uVmJub1FZLzdwdVlMNjc1bEFk?=
 =?utf-8?B?ZlQvT2trY3Zmc0IvaG43VTg5Z2VDOW91MnYvdUE3bmRPR253TGM3bDdLUkRZ?=
 =?utf-8?B?bWlwK2svekhpN0hKb0U3c1htWFFHR0IyekVTVk9ZK0pqcWhqQ0ZsdnhSOUc0?=
 =?utf-8?B?NXl1NkdGN1RhRDN2R0FabmlYU3A1MnZuN0JUZ1l0UlFtdjIySkJCbzV6bWgx?=
 =?utf-8?B?UmNJWFRJQW9WMjNGV2t2dU15bGFJeDJ4SU9nalZzMUNRUVZhcmNiZWZXN2xR?=
 =?utf-8?B?dkt1OFpuc0xQWjlZNEpiaERjZi9tWVlvSHBlUmZJU2NJcEo4aFlkUVNzTXdF?=
 =?utf-8?B?cWJmdFRDbHNHUHZJWmU1Sk9aZFNHdjZpU0hjM043T1NPaUhwYWdvQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac57581e-4b86-445b-bdb0-08ded3a03362
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:30:14.5356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NMS5tAXy/dU+W3N6iLWZfDeMnrtPzJohZSUlTGWenW9fFO8m/s0tFAIcAFD+WpP8/jrVUAZWioNpIz6e1h+3+mCp3/klax6kxPUTxVcMWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
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

Hi Peng,

On 6/19/26 6:06 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add support for booting compressed kernel Image.gz by defining
> kernel_comp_addr_r and kernel_comp_size in the default environment.
> 

You said it in the previous patch but not this one why you added 
ip_dyn=yes here, please add it.

Cheers,
Quentin
