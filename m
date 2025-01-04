Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED83DE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482E180570;
	Sat,  4 Jan 2025 04:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CAD3OHm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE366803C6; Sat,  4 Jan 2025 04:20:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAF680544
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1mmt8xQbgEyQLXMvDhi+NIDATucASONwQWrvKl8vrSvBJsdaN/njYej3VNangWKwxbUMtyvq5zharNVma8k0BNeNZzkuoWHKoE5n+50ZDsaJKzJ2K83VtcYr3A7nInWL44cmM82iOj1Wane4ROPwDW0HwtEpqJwueIJkhOjx3ejchKO3lxfaQDMVDsCbCCLu7uu6ZmyXxkehI/XYmDcHaL2rrXhozPPuYDe77LbRTVh9tDFHGUlkifBTDyemwhJWdzx+o/fDJbwoThMKEeusi5uJUkDVc5F9B5oop1eGozZCJa3DE9sYaB4MswkYksC+4rfbji/xMAGRfWYB++LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn+3GelrPMPA9WMHblcMHZq/cNdLuJqmHrQUTPQsals=;
 b=mPvk46Xz6aPacHbf+ZVRMMSsi44E55umarFqOiRBSWiAJZ15wW8F5iDXa+0FjX0SWC4mnkERb5dBmdVbF1R1rcu/XeZ8DrEQU7Ob1r3a6RMWBiItFUeeciKDms0hU6AbCxrXveuSXh587NoaxFFEvzG9UY/BR5LFlKgwqM/PwLoTJtp7GZUEjzJPKFviZ5x2nKZktqAeAGBdxj1TLgTDqUhJp9BTUaASf1DW3fvHwwpJEVSk9O2B9kj+SUCapqYNmQSgWKYhCQShkFB95zPdoGkOXyMNyjax6Cfag8oF+5GtKQlNEiLjd71DLGFQ5wuGgjbwVsS7ckazngRuLRABcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn+3GelrPMPA9WMHblcMHZq/cNdLuJqmHrQUTPQsals=;
 b=CAD3OHm5HVUa6JEHUDbXQ8n3BHRZpAA/LW5TOR6+z04ly7yY+nn2lRro+qUEusmvcQlKOZrdBq76GoORNLlkxzUV5I8jo0OvWO0AiR8brTuMhDJmJ9i5SRD7jOa/I2gWjpiDjsaI9O3YcFSzdTKKRIIFWi9MDqzII+Bk6v7P2q6QuhQXWpcFHknw4z979o1leu4mfYUzPrSNTG8zAMd0iqIOwyEbDEaR3NR9D0ZNEAiO2syAMvkNsaXrH3s9EWck9uYDvqP6awEfaYOE3uS+/Eqfa+1r9T4hJP8ZjPlFbbT+0O8D0jQIqQUsZg8GRBj+9OcoVT6IAb2g8e5RA/9FvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:20:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:20:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:46 +0800
Subject: [PATCH 12/12] imx: imx93-11x11-evk: drop duplicated nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-12-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a85aa1-208e-4068-3fb0-08dd2c6eabff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXNjZjZjbi9XTFk2R3pFSE1jNEY5S0xlejJXeG1FaGxDRVlWeXRnUDVRbmZq?=
 =?utf-8?B?eTRrRHhuWUpXUjV4THhPZTMzMjVlMmIzZVZ1OWRRRWdRWE9iMUwrU0FheXVW?=
 =?utf-8?B?aTBsZ09HQ1RSeWN0aFdzWW5QZzdaSXlsMDhxSGhWVTFOa3AzVklkOHN1bG9N?=
 =?utf-8?B?cjRLS2JwSGNyTUt1d1Nja3EwR0ppaTlsMncyOEhqWkF4aWN0SlcvekhqVmpy?=
 =?utf-8?B?ejR6NTVrTzcrL3lneEVPYmtVdmZVLzNHQTg0cWlSdUZlQ2tBZ3lnOW9RNys4?=
 =?utf-8?B?aHQ4WDJ6R2dGS3ZQMWhBLzVEWWRTdU51V0tQekhmS2Y3N1RReXVXbjBQc0hi?=
 =?utf-8?B?cGRNeDhSVDAxNDhYa05uamJ2c1BJdkFJd2pqSXdBS090dXRVNVVPRmI0YWF4?=
 =?utf-8?B?MHp0T3NwRnFTZ3lNOUo5bXdVM29Ba3FnMjczUGZjQjUrUCtRcmt6VHV3RTFv?=
 =?utf-8?B?U21PMGlqN3dPRnkxS2pHcnBsY1E1bzgrd1ZPV0w0QkdLUEdMbkEwZ2wvempx?=
 =?utf-8?B?SkJqSGFxTmd3WW5OVE52a3hadkdjbDhkQit0bFhMWTUxSzRtQkxSc1c2OUd3?=
 =?utf-8?B?akxhRjc5N0JWQzZaWkplVFZrY2ZXVGthQnVJWmFTL3BidFM1dUZLL2toamxL?=
 =?utf-8?B?MTFqVU92bE5JMlhSOUwzMG8rRHlEbGlNU2Q2dzF5V2E5UVZ0czl2clZEKytr?=
 =?utf-8?B?UXVTM0FvbnVyMTF3S2NNTTN6TWxZUlNRQWZRZnlXTXNzSjhucUtBSlUvYmJ0?=
 =?utf-8?B?OEhrOWczbEZJQkN3V0pOWisvaUFWOEdoS1NENFN0Mjh5blBWQnNFM3JqaFFp?=
 =?utf-8?B?MGxpMjF3d25MNzl1NC8wT1B0aTVkeTdMRnh5cEtFalBLdHV2d242MGVYMXhy?=
 =?utf-8?B?eXNub09La3ZJN2lMdGxFdFBCazVjZHZ2L0h6bVdGazd2bmVwQkl2c1VwTWpM?=
 =?utf-8?B?Z2dxdm1IdWtHcXEveUlzMk9NU1V5Z0ZsdHA5V1FINUl4cVcxeFVrTmpwNGZx?=
 =?utf-8?B?T3dXdEVMMENGVk5XR2dhZlZHVjRqSmYzUXV0R0tOZms2ZC9rYkJqS3UvTE14?=
 =?utf-8?B?djhmMURzcWtBVTJLUnp4TEZHc3NDTWRuN3dxcjFhRDNBdHc3ZnhxYlJBZ1Vt?=
 =?utf-8?B?L0RrUzRreHQ1cmcxM0tUcEdVMU1PbGRoN2lDcmYzK3FTVkFQSHlQUkxRMkJm?=
 =?utf-8?B?LzFuSWNuU01sOXBCVTIyTDExazh0L2lMMEZJcDZ3ZVBKZXFYNHRiQmgvN0Z5?=
 =?utf-8?B?WDkxOG9JdWdBNWtxNTRUTWdlTU5HTWJYaTBYaTdNSUtjdmVieGRYdGlmU0w2?=
 =?utf-8?B?MGdiSFBzY2J1MTEzK3ZmaitvQUVaN1E2Q0ZzR1dtelZiUk1SQlAweVN3ZHVO?=
 =?utf-8?B?ZjY0cVQxZDczN2tPa1BKSlVIbkRLK0VGdWJiT3BGVFJUcGhvaDg3T3pXcmxX?=
 =?utf-8?B?MnVzTXIxbnRZRkV5RytvbUpUWTBBcUpGL1htaVRkMXoyMW5EWktwRXo5UXlx?=
 =?utf-8?B?WXE0N3FpNUM5QjhNMStqK1ArRVAyRzVsdUI1VzgrYlBmMStXb3JOWks5S2kr?=
 =?utf-8?B?OEMwb2pyRkVCR3FydC85RlBRMWRhbUJYd01QanlSQUVFTzhjSFFWZWhrU2VC?=
 =?utf-8?B?bVBWWDhRZXFPZW1ocFc2V0o2NGNpazIzOEkxSERVSXdGWFV5MTc3NGNrZlpQ?=
 =?utf-8?B?Q2xMakxvbUhnVHF4Vk16cmJ6WWlmRmJnK0FmUlUzaHZIakx2T0lRa0huTzli?=
 =?utf-8?B?ZUl0TFUzb2kwY2dLZVJqYVgvaWI4ZWp0S2pyajNCY2tKN1g4VlpscCt6dk9E?=
 =?utf-8?B?aGRTanRqVU9UTzJlU2NIVlNDMUZhNVZ2SS9URXAvUWNNTFZZcmR4K0F6b1VO?=
 =?utf-8?B?OGZXdDNQU2lCWFB5R3ZaOW84dTVSaXZPREduUi9wZHJNMEoyVk9BOTJSWmZN?=
 =?utf-8?Q?cTBfsskRUBgzW/bJdL2FzLkJCMHgx9ns?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW52ZDVZL1p4YVMzNU9rc3hTSXd2VUFJSExNTDhDZjJST29qd1U5STc3RVl3?=
 =?utf-8?B?Vll0aDd5NzZDS2lzQ0t1SkZPb0hzekRTdGlRbmttcFhFWVluU1NWN3VFZldk?=
 =?utf-8?B?dGgrRzZmTWxMcG5PLy9Mb3pFclIrTXBLbjU1VkhPbFdWTk5yUDhvNVRjcHBB?=
 =?utf-8?B?M0xyUm9WS0FzWnVIdkNsL0RMalB0QWRCYWl4MmF1WGQ2OEttQm9kUjhzaWd4?=
 =?utf-8?B?aUFnM2txcE9JemQ0UklCZUR1d0NHaHh3MERxZ2JyL0FtWFB5M1FFZ1lxRVBT?=
 =?utf-8?B?dm1kU3BsSkxyNFBtMlhXcTUyT0V5QlFiTWY4OEF3NFQ1cHNYcmNONWd3RkIv?=
 =?utf-8?B?eFFaMmc1ZnpOSVEvQU12clFVSHlDOTVLdFpPVG9SUndic1BLVUJMOXAwcVMw?=
 =?utf-8?B?cFFpWEx6TFRuSFFicm9HNEpKNHgyaDR1Tk5PQndnMnNjZlM2MzRXZmZZRGYz?=
 =?utf-8?B?NytqWURHUllqZGU1MVlXVFB1akEwa000S1NzYlEzNEhJMVR0citQcjFlR1Rx?=
 =?utf-8?B?VjZ4Ny9DY2pLMmx0cDJrVW5HUEhFazNhbzNxZEtZckhrZWVkb3NNSldJYm80?=
 =?utf-8?B?MzBxVnhUYnF2d0t1NFJmSkhXUTIrZGtLNDVNejE3YW1sTW0zd2ZsbXMrbjB4?=
 =?utf-8?B?cTNsSTlwV3M1cTc4bEtVdVBRSFhXb0lZMVhFUHM1N2tzWDZjc3FnVXNDUlhS?=
 =?utf-8?B?TGl3SzBHR3dOeTduby9MZ1FlU2F2Rk4zYnFyeGJyeHUwVUovR0FqM3Y4SkdG?=
 =?utf-8?B?Sm0vK0RYNXZMOE9qaFZlMm5sdHVmVzQrNGdTODUzai9rNjBmcFBWWlpycUZW?=
 =?utf-8?B?UjF2enAwLzE3OWdUdy8rSWJIQVkvaS9jVWpLZ3pDbDJ1a280VWtMaS85d1pp?=
 =?utf-8?B?N2R0MWEvbWtwU3ZlcjFBeTJvQmg2ZjdQaWZjcXNsMTgwcytJK05VSGk0M01E?=
 =?utf-8?B?YkF3bjcyYXI4OWdEWDV6TC9JU1J5S0wrK0lXelFjRUoyWlJQUnlHMDAxKzcy?=
 =?utf-8?B?emVrQU1vajJML2EwcXg1THNtUXFtQmg5YWpsTHRlT0ZWbndNNlp3Nkp3ZWhw?=
 =?utf-8?B?YTBpWE5UUmpBQWJLazd3TlVjcTJsVCtTbDJsRjBqNytoa0VVRmg0N0ZIZ3BM?=
 =?utf-8?B?SktEMTJDN0pyYWFxRzJpNW1zUmcwOHB5ZkcxVEw4cGtrYVllQ0tjOG1Wd1JW?=
 =?utf-8?B?Vm9oNHEwU0k3MzI5bjJOTGI4TzY2VmpkeFk5c1Z6aWUrMld6R3J6cWx2QStH?=
 =?utf-8?B?bW5XN0lNcHdLWUNwTDYxQ25ZK0ZUbjVad1grM25URm1oNkxaaHpjeVpzeEkr?=
 =?utf-8?B?UzVTRnlkN2orK1UwWlpyMys0QjBVNEdsdzhsWGlXL0NDUStxc1FReVJ2TFJl?=
 =?utf-8?B?VTVic0dsWm5tVlZHSFpOVWxxUXFIN2QyNHZaYmNaT0U0UW85MmdTSklyejhM?=
 =?utf-8?B?Tmgxa1ozRFhOODRGbXZWekFLOXdhYkdTMVZCVStVaG5OTXdzUDVYczl3b2ZE?=
 =?utf-8?B?dU1FSExDdHovSnUweTF0YVBkUCtoNDVyK0pmcktKbFJNdjNEb2VucUhUMkhj?=
 =?utf-8?B?SDRMKzl1NGwzT2U0bkVFY3N4ODFqbXZqSzNjVEQvNUloWG5rLzk4WlJ1aXBU?=
 =?utf-8?B?aUpsRWlURm5FcnpQbnlKdGtQMFJLaVV6eStaZmN1blliUTNtU3hsOG9TNG9u?=
 =?utf-8?B?NWVQbFZvMEFwNEUzdTlnemg1Snh3VXZKWkRIVHc1SEExaWZGNGhkVDZXZklk?=
 =?utf-8?B?c00xMlRJWXhGa3prWmlvaFp5c1lLTTQyY050YlhaYTdVL1F5WEV2MEdmTHFu?=
 =?utf-8?B?M1I1N3B0bnV4MVQwbnZmdyszVmtXUlpuSENLTzBLeXJXWURIeXR2Q0RyS29y?=
 =?utf-8?B?bW5CZG9kZDlsZjRmc2ZqL1hjN3NhR1A1enUybjdmbXJxYXV5U0NVZ2pabksr?=
 =?utf-8?B?aDZNNWcyZXFEeVFxUkMyd2lLQUwvc2hyWlczUTBZWkVnUk1kenNVNmhsaXB5?=
 =?utf-8?B?TGZrNndQYml0RDdRbnFVMHl2MU1uaGZINFdNWHFTMFJkUnQybGFqM0FYeHVG?=
 =?utf-8?B?dnE1VE8zNFpFME9wY3JnR2J4dytmVjhYbUxFdTJiYmlTQWJrZkNCUDNzSW0v?=
 =?utf-8?Q?9brHCvj8a6lhmNM7EMvA5ff6W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a85aa1-208e-4068-3fb0-08dd2c6eabff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:20:00.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c89KDpfWBr8+2AmdoYNJYD7Yh8bHrTaeUTChZqpkAV0ag2as9vNft5YazSB07Mz/mxg85zEVuMFA0iJv+Vu/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

From: Peng Fan <peng.fan@nxp.com>

The upstream dts already has the lpi2c2 subnodes, so drop the duplicated
ones in u-boot dtsi.

Since the adp5585 compatible string changes, update the driver
compatible string. i.MX93 11x11 EVK is the only user of the driver as
of now, so it is safe to drop legacy compatible string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 -------------------------------
 drivers/gpio/adp5585_gpio.c              |   2 +-
 2 files changed, 1 insertion(+), 119 deletions(-)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index 408e601bc90eb69744ce1198498e01b12f814ca9..a99ba99bfb4f2c08752472536f2450c8e79fb87e 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,111 +26,6 @@
 	bootph-pre-ram;
 };
 
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -149,19 +44,6 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/drivers/gpio/adp5585_gpio.c b/drivers/gpio/adp5585_gpio.c
index ea0cb75459b741c0157aa9077c44163b3c0cab01..114583b3c3bd9a51fbe1960b7532150d0d7cabdd 100644
--- a/drivers/gpio/adp5585_gpio.c
+++ b/drivers/gpio/adp5585_gpio.c
@@ -224,7 +224,7 @@ static int adp5585_probe(struct udevice *dev)
 }
 
 static const struct udevice_id adp5585_ids[] = {
-	{ .compatible = "adp5585" },
+	{ .compatible = "adi,adp5585" },
 	{ }
 };
 

-- 
2.35.3

