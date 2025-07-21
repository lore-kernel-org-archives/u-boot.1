Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20AFC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 13:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23E18313B;
	Mon, 21 Jul 2025 15:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="B3gpABXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E83B83164; Mon, 21 Jul 2025 15:27:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB83C83118
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 15:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH097a8hJYjLl+Jw+MY6cEc2rQWbF5X/JjzFxsqXJheGL/txfBmlR813HdqP3HQMdA4BYkceB3nuCjaKf45P2qY6UCkgAGGWTGghBsX4KO9+In8nqyAGSEx1GwDDaNU4XiGWRw3HCFHa1uWKibLo31qB0WS9on6q4tEoiZB2W7p/N4wAgxHfH6LT/VYTOnlX6jLKpDescIacVfjk0GM2Al8jM+ZWLtx4GL1oVJ3TDjJLr6DHofCw8pk7JLS7bEKbvFTfA9gsayUNGEdYO/ySprw3HMf8IV3mIoLWmlYP4NCOxaCsaLRsTcpnoJqgP2LBF9ZEM+PyZIt3sNtQpBW72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJAyFF0y0deZi0MiWe+Sq/goWkmzkD3b/RPq5K1KaHo=;
 b=TZbSQYlYDnNlfYlTq2k3H9X9uXz36RbL4E0BqmmdcpPIfv2UjSsF3mwktgCuKJof4fpJusc1wX0ntoLBW2XiAzobdtPODoHkxl5IaLKrFx7E/qX9qt8B1JJ47Q56PymaiE2iGY6J55V9w6u5IFtY+aAweQYTfUlkeREVwZrZuevOhtc5o7pN7LTnhCPRdo24dnzyp/aioqU807YKND55ZIvAwEuKXHFzA0jG7aURAxHULLBBvx9Gb5yFyTwVdMlcnkxcfqeXOj/OPqxaXOzDPnAwu6myFHJCOtk48F3PjX/Qxxz+GNhntQRuRGPiKh3rfCRQ5uQ6MD6gotDMK9/vdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJAyFF0y0deZi0MiWe+Sq/goWkmzkD3b/RPq5K1KaHo=;
 b=B3gpABXGZ2MLb4pLcEaHQgebWOkzhpugoLuyhtzW595lODfw4vV526p7h2ih1lX9Zi8jzuj/SkzYIMDeWM/QSTLphDEN8MOMutASi8YsDsYqr7tadGC5UYm5UgKQKLNs+xiFPf0AOo0tSAQXump1VzPAGTYDFFpJUp7zmpQ2+QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 21 Jul
 2025 13:27:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 13:27:29 +0000
Message-ID: <4ed7baf3-861c-4d39-aebc-5c4f7d7e2bcb@cherry.de>
Date: Mon, 21 Jul 2025 15:27:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20250721125148.167020-1-frieder@fris.de>
 <20a08d1b-2b68-451b-b7e3-6e6f2bed7601@cherry.de>
 <cf5d5a08-9ed5-4500-9e1d-b36224d3ed75@kontron.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cf5d5a08-9ed5-4500-9e1d-b36224d3ed75@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba38977-3406-4b42-0336-08ddc85a576b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejB6Q3NoOWpvb045Y3NRSnUxWFYvaVAvZ0h3OTFBY2c2WlVvYTM3dkRsQ0h3?=
 =?utf-8?B?QzBiZXdkVytBbTJvdUtLbDkwdmMxclJ6dmZ4akN4bU5Wb28wYkNXUTBWNnNU?=
 =?utf-8?B?MW1MM2NrRXRKclNNM2xscUdPNWx0S0ZzTXRLUzU4VXpieGdNOWpkalZleEpu?=
 =?utf-8?B?Y0Q1bTJVaHFQODIzZnE3aUYvcGFtRWdrTWdub0ovdkw0ZjZ5czVmYTZJaTdH?=
 =?utf-8?B?dDdSRXo3eFFQUjBwNkUreUJBYkJQa3pKK0VpYmpzeWRCRWNMbEwzbXdNemR6?=
 =?utf-8?B?WmNMbUcwcmI2dmc3UmE2a2p0b1VEMnQrQ1FCUEI2V1V3dHFBQ0FIZE9UMVdi?=
 =?utf-8?B?R1FURjdWUU1iZ0pYUWxEMzFSVzNnSWhhUjNRM2RSSWNNNW13cWI4SGFpbU52?=
 =?utf-8?B?bTJQN1ErUEpNTWYzRHkzaGdscHMvZlI2M0s3V1k3LzdVVFExdFg2ZUJSOXE3?=
 =?utf-8?B?bmx6eHdzaWtDV2RGZ1AvS0ZvYno0SVNPZ3NiUnQ5WXRySllaUmZFTmsrR1Zk?=
 =?utf-8?B?UW9HaExaTldkWVp0M21laDNsaVBZR0dFakpaT3ViNmhZWmJQYmlvZFEvdEFt?=
 =?utf-8?B?T1hNay85TkdoSWFicW81WWVnYmZBMWZlUkRHQlk2NVdHWHp3OFY0V3A0UXd3?=
 =?utf-8?B?QjBlbkk3WDdHcnVjWnh1cVVFZzM2S010VmFuZSs3SS9LbDZLTkhyZHkxME5m?=
 =?utf-8?B?NWVpN0Ird2dqR2cvZkxEL1B2VTVSeW95VWJnVUpMU2xBUmdlSk1TK1RyNFk0?=
 =?utf-8?B?Szd3MnhLNERkM1pHeUhTS1VUMHY5aUNZQ00yL3VoRHNrd2RwZXpnNFZsYTh5?=
 =?utf-8?B?Znc5eENJSldURzlucUVJejhYUmpCN3ZqbEsvM0dwZHhHTG9UTHNTaHR3d01S?=
 =?utf-8?B?NVpCWlNOWWlMaVBNTG1RR0N4V2NjcS95K2dEaTlWQm1lRVZQaTdBUm1qV3Br?=
 =?utf-8?B?WGJFN1RpbzhGQ1d3ck4vYi9qRjl6bmFQN0x0S1YybkREQlFiRTA1MGpJSFZl?=
 =?utf-8?B?M2ZTVTJ0aElpc1dJYTNlZmF2WkRNL3Q5K0dYaE9FbkdCQ05sd0xvelFjaVNs?=
 =?utf-8?B?UGZlM0ttVnBUY3RHWGNpQ28wVG5JWmxjejMyOUxZdW1WbUFkd2FLMm52Sytk?=
 =?utf-8?B?STVzMFBFNHRvZ3Q3QStnYUdFOUxmbWNyS0xNRlBOYU90bXRNY0FMb00vWFF2?=
 =?utf-8?B?RFNjOU1Yc3JSZUN2UDE3YjhNeGpSaGg1ZUlBbFp1UG01aUJvZmVGdGNwS1ZP?=
 =?utf-8?B?UWhTdlVjek9DOFE2MHA4T1NJWGVMeTY2M2tQUjdHY2YxYmFHKzlxWFpvaHFR?=
 =?utf-8?B?cWNyNS9tZ0dhZWtIN3dXd2gydVhjQ3dHL3RuYXdGUWorMSt6UXJZblJjVGhX?=
 =?utf-8?B?WkRJYlo1VEx1S3NtNFJ2TThGNFoyU3p3WVNLYmpxaWVnczg2YzdPdWwwNTZa?=
 =?utf-8?B?dFZYV1FvR2J6NENpcDNKTDBoZmdOeUV1VG9FS25uQkRUN2FwMVN1QkN4aGZ3?=
 =?utf-8?B?cGpjSGs0Uzh1WFNxckRVMjliYTVhMFBiNDllNWxWYzk3cmJoaWVIaU9aTU1u?=
 =?utf-8?B?SGVWeU1yTWFodENGVmF0UGFiWEt1a2hMVDdiVzVHRGYyMExWbER2cDdvWGF2?=
 =?utf-8?B?Q2FzK0RCOG1NMXNGWlN2b3dSVjlBcmpVdHNSY095QlYrMXU3KzdueHorWjBz?=
 =?utf-8?B?MXNoSCtHTEx0S2s1TjZpODRaSnd0c2ptUzErYlFCUGEwL1FkNzk3cWxhdys1?=
 =?utf-8?B?UnBNU2cwc0dvU2JvZkw2dElDcEJpeU1CdlFqUkJxeXhmYklhSHYrajVRK0tH?=
 =?utf-8?B?ZjNCZ0lIejJqc1oyZjRJWVIvbzFwSnoxdDJkWmdRSFkxeEJ1Y2M3aVN1cDhJ?=
 =?utf-8?B?eExtRStUTU1HT1BBNWV3SEhFUHV0Q2U0czJObklaeU5BRGdWeVExMDN4a1BP?=
 =?utf-8?Q?yJ34OBiFG0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEV0ZVdtSEpFa3M1bHJZKy81ck9oaUlGMm1sc0RXQWlyRlJsaW52Y3RlTWFY?=
 =?utf-8?B?UlE4aENnc3ZOQVVJN3JRaGtGZkZJY2liMnc5NDVWZm5GaW0vL3FLc0RTY3B6?=
 =?utf-8?B?Y0NJTVQ2dGhUanBaclJnNjhwZ2N1b1MyZlJMQ3ViMGZ2eEN0SW9LK1BlbUVm?=
 =?utf-8?B?T1l6TlNxU1ZGSDRFOGtpaEZzM2lBeTJrb1k0dU5vL3hmS3VBWnFsdXM0UGdG?=
 =?utf-8?B?LzVWTlhuM2Rhc3YvOUxYQWdLTklVSkVVZ241M3k4cWhjeThvTm9ieWR5MHQy?=
 =?utf-8?B?Ynp4WFduSTJCWVVLQVBoRkN5ZXVpNmo3NHN3RmF6YU9LbFFsSFRmNlJ2OFZH?=
 =?utf-8?B?Y0RkYlVjZCtxaVdaT0JPRnVRZzlLakx0WmxVWjR1L2FtUGM2THVTRXRQZnAx?=
 =?utf-8?B?R2twTi85WHZGbi9DTnJyVk4vVWx0ckRhajNOenFBZEMzUDRURWg5Nm9IQ2c0?=
 =?utf-8?B?YjVQMWduSzFYQzlYVEx6TDVPT0RDeEJBS1lKWmxVek1vNUxNQ25NQmkrNjk4?=
 =?utf-8?B?WUl1ejJtU3NGK29UaHgzVGU2TFc0ekx5dGRsZXRKTUdIdFdybWR1OFlxYWJj?=
 =?utf-8?B?L3doakhid0JxZHFZeUdLcFNHR3Vvajc0VGJJVFl6cTZIYkRDbDByQVE2WFJV?=
 =?utf-8?B?akltVHFoM0xTcTRPVS9LOTljMjVJOXFXNUJCbnNLbmlQaVRWd1EreHBKYWdE?=
 =?utf-8?B?enlmcVVBOEpFNEhxUm40SHgxUEN5dk5WRkxzWWRZRytSdGw5T0VNdGVaSjRp?=
 =?utf-8?B?MTEwanQ2dmQ4MnVnSzFCeGZuSVlRRm1yRnArUGRqZXQ0ZUFsT2lGamh6bGkx?=
 =?utf-8?B?WmdHMGZIQW9wbzUvOXhGZkx6Qzl6N1llNnNlcUZ4MElOemdtVEpxWGRDUlly?=
 =?utf-8?B?M1U0M29HYnM0THFtc1Jmb1FUTHRiMUtHK3ExVytST0J1ckVqZ3BNSStpVlYz?=
 =?utf-8?B?MmtISFh3VHNEYTFibGNoYmlaMkxzdjhkYTkrTWdkZC9SSUx0L29pS1VGNUtH?=
 =?utf-8?B?VCtJTGxkbk84Y1BlNHVRSDBIRXNKNEJwOXdFcHRpMEtXeHI3YTA4THRNdmdq?=
 =?utf-8?B?M0N3VHJxckZhMGZKSTVCSG84QW1MSWEzUm1HeHd4a3NvWFB1VW1jWkpQMjB6?=
 =?utf-8?B?Mm9Kb3lHSWVaUkxqME5OaEsrR3h6Q1VZS2FDTnBEOWhGYXNtNS95SUZqV01K?=
 =?utf-8?B?cjZ2cjFBdG1SRmtycmd2d0hBV0FFZW0zMUR6OVNKV1pFb2FMU2JveUU4M3Zx?=
 =?utf-8?B?TkY0V0FqbGNmNmpMQWJ4SGlxRHF0RU5PSGN1ajB3WjdXaUZ3amFFQ0FoN0pz?=
 =?utf-8?B?ZUswWHB0NmI2YlJVWkNkL0U1b0tzQmxVTHNYK2pkUTM3UkNkcDgxSmcyRjVT?=
 =?utf-8?B?SnZyVExEVkFPdHRhVzdSUjVGUTB0VXJod3pGR3ZtS2RJZlFhMUNFWXlZM1B5?=
 =?utf-8?B?aVBhc1ROWlBLMXcvV2NtZEdJcXlLc21tSHErY1YrM0l0M2NSWktBajROa1Ni?=
 =?utf-8?B?S3VEVDA5c0M2NWlmMm5xZzFJbW5XeGF1d3QxZllENE1IUXQzSGZCUG1XT1RG?=
 =?utf-8?B?ZE5TTURmcmgrREJSbk5keCs4Vms1Tm01R2JFa3dJQkRLWEVXZE0yTTd5UllP?=
 =?utf-8?B?RStRMXpRV3kvanJrOFVLcUNnR05KaTJ0b1FzRVVSMkV5S2xsNlloMm1wWDZF?=
 =?utf-8?B?VG5YK2tqRFZmdHVad2lKZlRvSkNnK2dCL2doV2Rpb2dBZGR2UzVHbnl0N09w?=
 =?utf-8?B?Y055QStkbnBydmJYZ25sZHNCZEExamtIQ2twRzR6eXdtWjYramFnWGwvMDJF?=
 =?utf-8?B?Vnp4bWJEamRIeTJFMGNuUm1rZmY4Zm45Z0xVdFBBVHlzeFpiL3U4RWI3b25V?=
 =?utf-8?B?Umg2L3hRcHFMQTBTK29LcE9WbWhad1o0WFpDWHVBWDY2SW02SmNyeTZGSS92?=
 =?utf-8?B?K0o2cUlCN3EvM1huSFVRZW81Yk5Lb1hlVVVMSFc5MzdYZ2xYYWUwMlJhTk5F?=
 =?utf-8?B?aEhYKzhjUWRValZvRGlZTkdJTCtNaEN4c1NZb0VjcGh1NTA3d0NTUCtiT2px?=
 =?utf-8?B?R09oUlk3WmNmbXg1STJJc3V1SG84aHlqYVRLV0NMUVdEakFlZzVCMm4yUWI0?=
 =?utf-8?B?ajlwY3NQcCszUnZMeGI5eTIyR1o5S3EyZnNQNEh1Q0hTSWxOOFhmcnBWV2JQ?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba38977-3406-4b42-0336-08ddc85a576b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:27:29.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHRSKGlWLICOcpn7HeX39v1O2dyOl+brVDLj4rQzTDN0Vqxmjp/yfk2yP7SeZL0b9tSlZhxeelFq26IE6yNB1TKCkusfp04NS97kuWpSC38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9433
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

Hi Frieder,

On 7/21/25 3:08 PM, Frieder Schrempf wrote:
> Hi Quentin,
> 
> Am 21.07.25 um 15:01 schrieb Quentin Schulz:
>> Hi Frieder,
>>
>> On 7/21/25 2:51 PM, Frieder Schrempf wrote:
[...]
>>> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/
>>> Kconfig
>>> index 465e258f8e4..0798eac68f5 100644
>>> --- a/arch/arm/mach-imx/mx6/Kconfig
>>> +++ b/arch/arm/mach-imx/mx6/Kconfig
>>> @@ -366,6 +366,7 @@ config TARGET_MX6S_SIELAFF
>>>           select DM_THERMAL
>>>           select SUPPORT_SPL
>>>           imply CMD_DM
>>> +       imply OF_UPSTREAM
>>
>> Why "imply" only here? It won't build without OF_UPSTREAM anymore no?
>> Shouldn't it be "select" instead?
> 
> Good question. I wasn't sure about this, either. But "imply OF_UPSTREAM"
> is used basically everywhere in the tree whereas "select OF_UPSTREAM" is
> only used twice. That's why I assumed there must be some good reason to
> use imply. Maybe that assumption was wrong, but I still wonder why
> everyone uses this. If someone can explain, that would be appreciated.
> 

I can explain for the Rockchip architecture :)

We have "imply OF_UPSTREAM" at the *SoC* level so that if someone 
somehow wants to be able to have their board to NOT use an FDT from 
dts/upstream, it is possible (though we wouldn't accept such a patch, so 
this is likely only to be nice with forks or also inherited from partial 
migration of U-Boot FDTs to upstream's (e.g. there is px30-firefly which 
doesn't have an upstream Device Tree, so we cannot move CONFIG_PX30 to 
select OF_UPSTREAM as there are still boards which aren't supported)). 
Finally, we actually make use of this ability to not use upstream DT for 
generic Rockchip platforms. While I don't use this, it seems like it is 
appreciated? We cannot upstream those as they do not represent any real 
HW but it works good enough for boards following closely the reference 
design from Rockchip (which is most boards for typical things used by 
U-Boot to boot Linux like eMMC/SD/SPI).

For Kconfig symbols only tackling a finite number of boards which are 
all supported by OF_UPSTREAM, it would make more sense to have "select" 
there? We also have "generic" Device Trees for Rockchip boards that we 
cannot upstream to the Linux kernel (as they don't match any actual HW) 
so we need

And now to come to think of it, I believe most/all the options in 
TARGET_MX6S_SIELAFF should be in the defconfig instead of under the 
Kconfig symbol? Not sure if there's a tree-wide consensus on what to do 
here, or if it's up to the architecture's maintainer or board maintainer 
to decide. I know the additions I made to the Kconfig in 
board/theobroma-systems/ weren't much liked at the time (but ultimately 
still merged), and this seems similar, so not sure?.

Hope this helps!
Quentin
