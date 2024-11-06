Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67089D44D78
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 15:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBB088DF1;
	Wed,  6 Nov 2024 16:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ds0zqAfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BFE891A9; Wed,  6 Nov 2024 16:31:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECAAE88DF1
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 16:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhFPtMDgc1e9rERNIDrjUTk3AInm/6z2yOxqrAGe+28FptvL60zmPYP4yJFO1HlwcqFCIIIhS3UDjdCmMk91NCz9pi4qQml+hf4/xHpq42r87N3+53ZwtnFT62hvJTQ+MQNGD97LMlOKW5q19sJN2TfdvtvHtFJzKywJC1SFWz3flEdXFd7z/A+h8LRd9oZDrMaQhxkT1WOo/YzdXuVaeAcVjtJJ1AdbeOn1qj6d3EVupHqEnkNuf3SmlrqEtzFxftx/KmAu8vvfACARlwC+aTTUAoVwtZtIte/bLKPfxSudEhnKl4UUwG4ZjERQiyQ5Y9gdEbBYtmFJwyjdMIt2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QPZSjYX2XSIk+VPuB5Sq95XlaLci3Zc2l0GrOjKcrs=;
 b=roneZJlwWYQ3rWI6RVyX8Zb443Q6jT8pimNMEsv/BiMBOwLtLoiH7+KStVLfuukpysGvuHylmSn+PUhc/rftRr6epBZrOkBR3obJcd8jwlHPIxn7eavUY5lzwRm8jkGP3mOYGhWZcN1wKoIrlqCbO6rLD47PrMvqqbE5FRxoQKpvD/PelNFd3pT8l9lGxL5fx5xGp3EVz1lVPMKvwSuYzhL3CvdH8bnRxyy/034S+H4mrton7hLO2xByXyoaZ+k1OVV98aKlnGP888TaF002GR2h79Kllg1hxbHRkzvrkYIUSSclcdizRQESHcxewJKWOEQff9H9I4+u0qIU6VUAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QPZSjYX2XSIk+VPuB5Sq95XlaLci3Zc2l0GrOjKcrs=;
 b=Ds0zqAfAg0eLaq9HYE4YvJLD8HKl5DyaYhW5JO0EKFqUAmAPGAo3EgD9pUCFVZ9sSTOM3gb6IPgMxXrP6aoevtKheJGU1DcgE61HbRFx3OXLqDKm8Q7ySRMUNZmd3W6ciGubUj8YDX5OdBuV/RbeRRSPisMOVg+PpxmVbyw+Qxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 15:31:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:31:47 +0000
Message-ID: <2c9dbe48-9be2-4c75-a34e-02384b338d3e@cherry.de>
Date: Wed, 6 Nov 2024 16:31:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] common: Move autoprobe out to board init
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20241101115028.214678-1-sjg@chromium.org>
 <20241101115028.214678-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241101115028.214678-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8df290-51c1-47ca-32dd-08dcfe782032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHVYL3NQTktTZW5rYUlyY0Y3bVltcHg3T2ViaFc1N2FYdlBYZjE4RkljZkNG?=
 =?utf-8?B?czNMTjh4ODArZHpEYkwxdENkb3pVTEgzVVB0bkVKK0JtbmVnSFoyL1FMWGVC?=
 =?utf-8?B?YzhWSTZHQ1p3RHBhajY1bUl3NUVTNzZHcEZ5clRUOWQ4SE5lWlNoV2dmRmpX?=
 =?utf-8?B?eGU3ak04TXYrYkJTajZpR0JWNXRpc0VRQ0o0djVGalJKNm85UkFycmFjc3pX?=
 =?utf-8?B?MUY5Vy95eTRqcDlVSmV0aTB1RGhzME5MMU9BZWRQWjZsYTVRSXNCT3p3OUlL?=
 =?utf-8?B?KzF2VFljdERNMjB6TE5Bb2dJbExuMG5WZ1AyVDRMaGpIMjMvcEZSS0J2eURy?=
 =?utf-8?B?ZW91QklteHN4b3hZa0JESnpScDFSTEd4eXFVOVJMclFBdW50U1VTV3JDNEJk?=
 =?utf-8?B?VWRsR09PcW9RRzVOb1V4bDEvcGloTEloRHhwWXFtS2IzZkxuV3Z4UXhUcGYr?=
 =?utf-8?B?bVBLT0tiTHBFTWt5THJhSHdFU1RWdG4zVnc2bW1pelo4cjhJU0hnd1VINU1R?=
 =?utf-8?B?cjlFMFJiS2xVV1RSdW5FSUdPMFJtY3NiQlovZ2lFcmFrUTVkRkZvblFxcTlT?=
 =?utf-8?B?YjhJYk9xMW5rRlpvZ2ZTU3FoSkxia1pMd3FDQXBrYXRiN0JuUkMwc2ZuQlZo?=
 =?utf-8?B?enZzb1dDb0pHQm1ZZGdyeUhCcVRaWnA5OUlCSHBaRVQrQ3BvcFhZQjEzam83?=
 =?utf-8?B?SmtTc1JEVnJ5RlhKQWFLOVI0Qmt0Tnc2OGNycTlBSDNvNzZnVVVoTTF1YW1Z?=
 =?utf-8?B?NG5LOW1qeU0wK2VUZmtBeFdCeVpyQXdHWlRHR0FnTGRqUXgrVU1MVk1yNEJs?=
 =?utf-8?B?V3RMcmMzYWFCZTRHYktQNjFhMmlCY2RFcTNOZjFEa3pTY2VFcmN2Yi9sY2FM?=
 =?utf-8?B?TjdmelAyMzQwRURiRUN0WDhKeGNObHkwUFFOTDFESjFUckoza1FIeURFbURW?=
 =?utf-8?B?K2E0dUZUZXBJSzcxT3h6YkhxSXNsMVJveEJHdXR4eXJZbEhGWnNNdUo1bEJB?=
 =?utf-8?B?V00xZ0NIeWJJa0pQODJMK29aMnFRcVpnYU1PVE5DbEwzdGNyaE1mL1I4U2ln?=
 =?utf-8?B?L29QaGpkeThBSlV3d0JxNVVTVzRKanpmWXdtNUdnYmdsQnJTQ3ZaYi9RUVhk?=
 =?utf-8?B?TlRrUEEyczB3bG9sem9TN04xR2tnRlhaTDlxNXdHdEk0VDRPNC9uZUN5SGRG?=
 =?utf-8?B?ZXE2ZE8wc2s2ZzFtT0VJN3l5NTJoVG9jQjN4dy9mK21XOTE1eEVuVkRoM1Zh?=
 =?utf-8?B?Z0orbndUTTdXcWc3ZnJGUkJ3aW1NbDJWa2tNR21LN1FqeVpsUzFCQ1VPY3BS?=
 =?utf-8?B?UmVQamhmdXdYbjVyK2dsenpuYWl5RHM2ZXEzUXNObmMwamFKS1dQajRsNnh5?=
 =?utf-8?B?cUQ4LzJ1L29lUDl1TEhOMU1KQi9CYWZWQkh1Qk5DbTZNTWtqQTQ2MDRQbFZD?=
 =?utf-8?B?Tit1Ylo4bHk4eGsyck95Z2hOVUhuQzdXYzRpa3VGRFNDbFNyR1NqamlLZHZN?=
 =?utf-8?B?dGR5cXMyeHprbC9iTmtTOUhEV29adDROWkVRSGh5YmplcnZKaEVsOUUrbFZx?=
 =?utf-8?B?MGlKZWhOQWY4YWswRUt3aXl5bjVOSm5oWWcrZ3BPZnZ1Z2UwNHM4cEJsS3VS?=
 =?utf-8?B?c0VtR0NmQjNrREtiZTZ2MFk3NzJvUnVQK2FzeTlEcEs2OWhZcSsrSVNWNWRo?=
 =?utf-8?B?TVd4Vjd0NXBsa3lSOEtXT2VkajdPME1rWXRUQlBDb2F5TGpMaXZjZUV2ZE1H?=
 =?utf-8?Q?pakW1Vklha0Tib5Cq2nHy1nYNWR8LByhS2Eo1ZM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZKRGp2Mko2Nnh3ekJHYTB4UGxBUHJxU21YT1RVMmVFRFJNNGFDUExEWWRH?=
 =?utf-8?B?K21jbXdzRzAxS05mMkdjUjFPV1MzV1pDalE1ZHpRcjJCTDBwMktHcnlOcS9M?=
 =?utf-8?B?V0xDb213ellLT2M5NHVwKzhZWGx5Vit5TVpxcVVMa0lIQzZCdFQ3cXBQRVBi?=
 =?utf-8?B?ZlBQNU1yZ05zZkRGTkNoeDlLeU9DemdYQ2I1aXExTXljUXNyQ3lEcThRcTFB?=
 =?utf-8?B?NXlRUTVaNW9LZlQyTk9idE84ZW4zdCtUQTU5dWxhVzFSb1dGRmNqQ3NJM3ZG?=
 =?utf-8?B?bEFDcDFkTEZuZUxoeUdtNnN2T0NoL0xSVERFTFN3SmYyTTZ0dG4vUXJvWFds?=
 =?utf-8?B?VTM1NmpxNnNnelR1OUg4bmgyWXN2TW5JTDFMMjRQRmR4K3loZVlZWFQ5bHlS?=
 =?utf-8?B?UkNyZHpjaEh2L3VDWjFYMFhPbFdsbzk4dVJQMlVNSEZFNDRtb3dWaUZLOWdm?=
 =?utf-8?B?VjIyTXBYeFZ5ek5zUGthakptRTdKMi9uN3ZncnBzZkQrcXZnWXM2eFVOeU1S?=
 =?utf-8?B?NkNERFJWc2FYT2hSUTdMU00xK0VaNW9hWTMwWSsvbXR6cVk1YlFjWVA2eVRU?=
 =?utf-8?B?N0x5dU41ZmxERDRja0RWdDYxMmYvRU5PNllhaWF4WmphSW9FV3dic1krbmZu?=
 =?utf-8?B?eC9YQjgvWWRNaGwyYjBtbjdCVW1HR01sRCt3K0tiM1Brdnp2aGNjZStFYzg4?=
 =?utf-8?B?dFNqT294RFdwQlJCaEFneGxtNVJhYXlqVjZxQTdjeDh4VXBpeTBNYVBLQWdV?=
 =?utf-8?B?UHRQODg3Y1o4djI5YjIyNU44T3k2UWZrdkZmbmpOdjJIZHBxN3VsaVVWZytG?=
 =?utf-8?B?dG9ESFdRS1BnSTFWcjRzNGRmQzRrc2l5cjg1aUVwNkUvMEJ2RGp0ams3Z20z?=
 =?utf-8?B?by9RcVBTVGQ5TGtyTXpaWFB5OFF2L1M5YkYyMWNQWHZQMU1aV3paVUlHRVNt?=
 =?utf-8?B?aWQybHhKMGNDRW56dWVsZ2ExTXR1TXhhUUtuNVd6dmd3azdGbXUwV3lFU21D?=
 =?utf-8?B?QlJEMzc3WlUxQytqN1RkWlBlMGM1ZlBSU1hrR2hhNXJmU21tRFJoekh1NC9m?=
 =?utf-8?B?QXJPd2p5dkhFUWdyYncyS0FoTmc3UkUwN1NWQmQzT3gvQm80TDV3NC8vejI3?=
 =?utf-8?B?MEhNY05TY2RFeG9EMlB5TDRNZldnaFpRTDRuTWkxSGZsREJrTm9jSWxJYkw0?=
 =?utf-8?B?WDBNdHVCWkF3bXY0UG1RWnNSeXg0L2FiVkc4QkNVYzY3bTMybVJpcG1DNUJ4?=
 =?utf-8?B?SnJGdnVGM25wTW51R2cvN3EvVEdXZGh1MllxVi93WWJxT0lqVWU5WDlhUm5U?=
 =?utf-8?B?TVo4d1M2ZjFZbWhGR1E1ODVYWmxXbndjaUp2OVFmcjBNZTF1M0h1ZDZTRDlE?=
 =?utf-8?B?QjFSbTBJQXc3K1Z1WXkzaHNwYzBXQ2xTa1FsQ3g2Z1lCZ1AzeFFXdnEvQTBB?=
 =?utf-8?B?Z0JmUlJ5TytlMTRHbFc3WG5KSFprQnQvTXRPWFBHNGNMbE5maDR1QUJOemxI?=
 =?utf-8?B?VnJUMm55RURlNHJ2d0xZeWprcnVCbWU1VXJDT1pRWW9CcG5yUVZvRWtHVk1x?=
 =?utf-8?B?VDl4cEhFYnZGaXdDbXJHYi9yNk5IZ0JCdjlCbjhRMVJCZE0rNG9UQVdwQzFH?=
 =?utf-8?B?SlI1Y3NxdnpRc2dORWMwOWF4M2x0bXlJQk1WaVRUQTUxNldpQ2VBb0VuSm14?=
 =?utf-8?B?MExvZ1hkSjRTL3UvSnhZdHdzclBPWk5nSFdqdkJnMWRwMGt1TlFKbUVmek8v?=
 =?utf-8?B?WmFUUGpLUTdZR2ZIZ1pKNmdScktNbzRteDV5YVNTSXFtenMwRzNJQldJVW92?=
 =?utf-8?B?T2JKS3Z4VllDaFl1QXNFdWxET3NiRi9LN3ZhL2RTVWdnNnlSSFdmOGVPdGsr?=
 =?utf-8?B?OGdvcEtRVDYvdXpndmJWUVdzOFFOYXZJUURQWnlUa1NBWFMrZml6bllLSS9t?=
 =?utf-8?B?bzBLeE82YWk5NmhBR0c2THpvaWtTT09TQ2JkUW0yaGxhL1NMRzdnbzFTV0xU?=
 =?utf-8?B?cEp0eHY2ME9hVmo2Q0U0WU9yUjJDT2NreW9QN284TFhyTGEwc215ZmY1Y01k?=
 =?utf-8?B?NmxYT1hjTkJGdENqT0xXdUVRV2NnS1VFaEVNQ3NQNEV0YWxIcmxTY1lrYkp1?=
 =?utf-8?B?cDg1N3c2N2k2V0JWYnVMclNXK0xMT3pUaS9QS0tDbDhtVEFjMllKRkFNUHVj?=
 =?utf-8?Q?Wv21m8AMcuTVESwDXjORgy0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8df290-51c1-47ca-32dd-08dcfe782032
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:31:47.1412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz9hI5b9V3C6Z/YGPp9vRoLrRgYFO6PWpMFW2xzSbVFhb/DO1JtdR0JBgDatqJ46U+LrWzMW318nTD71h3RJ4CjQ/5Xk79yHVnVTvoyUh9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442
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

Hi Simon,

Nitpicks below.

On 11/1/24 12:50 PM, Simon Glass wrote:
> Rather than doing autoprobe within the driver model code, move it out to
> the board-init code. This makes it clear that it is a separate step from
> binding devices.
> 
> For now this is always done twice, before and after relocation, but we
> should discuss whether it might be possible to drop the post-relocation
> probe.
> 
> For boards with SPL, the autoprobe is still done there as well.
> 
> Note that with this change, autoprobe happens after the
> EVT_DM_POST_INIT_R/F events are sent, rather than before.
> 
> Update the docs a little, for this feature.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Add autoprobe to SPL also
> - Leave the function name the same
> - Fix 'Prove' typo
> - Update cover letter since SPL is now covered also
> - Update the documentation too, with a discussion link
> 
>   common/board_f.c                    |  4 ++++
>   common/board_r.c                    |  4 ++++
>   common/spl/spl.c                    |  4 ++++
>   doc/develop/driver-model/design.rst | 15 +++++++++++++++
>   drivers/core/root.c                 | 13 ++++++++++++-
>   include/dm/root.h                   | 10 ++++++++++
>   6 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index 1e1aa08530a..974eb4f39e9 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -822,6 +822,10 @@ static int initf_dm(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>   	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
>   		ret = dm_timer_init();
>   		if (ret)
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e1..d1507b06f8d 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -241,6 +241,10 @@ static int initr_dm(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>   	return 0;

return dm_autoprobe();

?

>   }
>   #endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 1ceb63daf31..c4256f237ee 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -500,6 +500,10 @@ static int spl_common_init(bool setup_malloc)
>   			debug("dm_init_and_scan() returned error %d\n", ret);
>   			return ret;
>   		}
> +
> +		ret = dm_autoprobe();
> +		if (ret)
> +			return ret;
>   	}
>   
>   	return 0;
> diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
> index 8c2c81d7ac9..1dcac1408ff 100644
> --- a/doc/develop/driver-model/design.rst
> +++ b/doc/develop/driver-model/design.rst
> @@ -842,6 +842,21 @@ steps (see device_probe()):
>         cause the uclass to do some housekeeping to record the device as
>         activated and 'known' by the uclass.
>   
> +For some platforms, certain devices must be probed to get the platform into
> +a working state. To help with this, drivers marked with
> +``DM_FLAG_PROBE_AFTER_BIND`` will be probed immediately after all devices are
> +bound. For now, this happens in each xPL build as well as in U-Boot proper,
> +both before relocation and after relocation.  See the call to ``dm_autoprobe()``
> +for where this is done.
> +
> +Note that autoprobe happens after the ``EVT_DM_POST_INIT_R`` and
> +``EVT_DM_POST_INIT_F`` events are sent, since these events relate to
> +device-binding.
> +
> +See here for discussion of this feature:
> +
> +:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.272219-1-marex@denx.de/
> +
>   Running stage
>   ^^^^^^^^^^^^^
>   
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 2d4f078f97f..371a37fe752 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -299,6 +299,17 @@ static int dm_probe_devices(struct udevice *dev)
>   	return 0;
>   }
>   
> +int dm_autoprobe(void)
> +{
> +	int ret;
> +
> +	ret = dm_probe_devices(gd->dm_root);
> +	if (ret)
> +		return log_msg_ret("pro", ret);
> +
> +	return 0;

1) Should be log_msg_retz since log_msg_ret will only print the message 
on < 0 and here we test for ret
2) Simplify:

return log_msg_retz("pro", dm_probe_devices(gd->dm_root));

the message won't be printed if the return value is 0.

> +}
> +
>   /**
>    * dm_scan() - Scan tables to bind devices
>    *
> @@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
>   	if (ret)
>   		return ret;
>   
> -	return dm_probe_devices(gd->dm_root);
> +	return 0;

Simplify with:

return dm_scan_other(pre_reloc_only);

>   }
>   
>   int dm_init_and_scan(bool pre_reloc_only)
> diff --git a/include/dm/root.h b/include/dm/root.h
> index b2f30a842f5..cd240c6a716 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
>    */
>   int dm_init_and_scan(bool pre_reloc_only);
>   
> +/**
> + * dm_autoprobe() - Probe devices which are marked for probe-after-bind
> + *
> + * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
> + * entire tree, so parent nodes need not have the flag set.
> + *

Can suggest:
"""
It recursively probes parent nodes, so they do not need to have the flag 
set themselves.
"""
which is what I believe you wanted to say? "Checking the entire tree" 
induces the opposite of "parent nodes need not have the flag set".

Cheers,
Quentin
