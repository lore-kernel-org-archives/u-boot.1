Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C876C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2DC80FEC;
	Tue, 22 Apr 2025 12:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fQ3Y2kR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC2F810F4; Tue, 22 Apr 2025 12:23:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E4480F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8LEElhzurQWKnHSrhBPKt6ApBZkIg3sSZ2MmkNaVHcMF405IX+/dKnPNRiCvsk989s0M1+NCKiIJ+u84mHp5fhUQH8I6vT/jVzr9O37tkExdhxYteniUM+telXbWwwy9LuUsppdtL90iwxEhtOHt19YO3Gcyv0pD4U1L3V2sekaymp4bwusTE3l2gBN5luXyKUIIhSE/bEwFI1O020mpOnytdnO4MM5G7bI0SgtJernO540K//NaLATwDNuiNX5LAKJtc6HsjNJmQ9veeIuCq2yvAKPdidNAlJrRM72BiEq8zHx7toog1gUqF/l3jB46aYWFKgaB4FIc+9jljOIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tSkIkKMRRbDhuxDo0gO3UZ2+eEZEcHO+z52cY1jRz0=;
 b=nLm9qi8sMKNdXn3box5glR+PnimzJzVn8SxPRhMsJjyAxI5xI87OtyLZMOUgSvFYxYsdvusWAPgo0kQn4pNydVqBlGmHXXxRquY6owlDWhiYVZWjj5Y+nZAYtYz/DL15SbtbSNfI17R7QyUyVuK2ESO2+FZ2gAmL+RomWlpl4gqPYBEtJpzecePFxwPB/6WCUMRSFSdF49MA2FuI1NF6uqGGaUSTuH1hvQQ+R9cVxjOZBFayBp8LGIn5uPTi8/VDO/Lgl2pxwgzPIXSaSEg73keMP2fwcHKLvu2+JmuEMTjFD+PkzHqaUBOuBbwHtDuzW4cPB+kHOcpaZskGpMtoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tSkIkKMRRbDhuxDo0gO3UZ2+eEZEcHO+z52cY1jRz0=;
 b=fQ3Y2kR7N3LFRzTWFbL2DlRG6p4INvGioCdM8I7aB+o3M7tINDogSAxA+2M5cop5w6NUIdqdDX5HuW/2SRD+XZBZPcyRC0qCXQ7cGslTkmlgQlXQ74jxJji4wSL2iZKn3P8K99s145FgPtBiWm2EwtouIi6/kKzKnj6dhlAysU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7204.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 10:22:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 10:22:58 +0000
Message-ID: <aff08d67-1efa-46a1-9463-f3c8a951a0e8@cherry.de>
Date: Tue, 22 Apr 2025 12:22:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: remove duplicated "commands"
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com
References: <20250420143941.300903-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250420143941.300903-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 8629439b-33a0-49e2-136a-08dd8187a70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVE2TWxEOFVtVEJ6ZGhxbmFjbHJWQ3JtMmxMek1kYlpyeU1pUTBRYmhKUk9T?=
 =?utf-8?B?dWsyS1hsazdXODYzZkg2ZDgwb2duaFhIY1ppSDJ0SldTV1NLcmJPZERhQ2ZI?=
 =?utf-8?B?cGhsemphNWRPTXBlajk2d3V4bU82UzgvYTBncSticHBONW5VQU8xUFdyNWwy?=
 =?utf-8?B?M1dHcGplTDh5bkEyWUZ6cml4eExEN2llRVFNa0NiN3k2S1ZOV2xNdC9TU3hM?=
 =?utf-8?B?YU5HczdFVlAvY2FtdUEwMVIrMG91SHVLV0JpVTRaOElMVmJOQzNJZWdYdVdN?=
 =?utf-8?B?ZS9CNmZWM1BaRWxWdFNhQTZzd2NON2o4WkFjSVF5MFVESmEyNGk3VDFhS1dl?=
 =?utf-8?B?aVBLbW9jUDVmODVLbHBaOVQ5T3k2VG94NVB1UXAwcUhmdWFCWG5kVzFldFZR?=
 =?utf-8?B?VjQ5SjRDMlNPblpNVCt3aXZRUlNTYTgzbzdFVUszOHpzTnZkdjg4ekwwQUlk?=
 =?utf-8?B?cEVKaUlxaFpSVk8wbXhPY2tqOTdieXcraWd1elVaTVkyeGVsc1ZCbkFlMDlO?=
 =?utf-8?B?ejBqTFRYTjJjSm5VSWoybW41RkRlMWVFWEVIK0pDV05EUWJIdkk5VEZrOFlY?=
 =?utf-8?B?Wi8yN2J0Mndjc2hISEVJVUk5STg4RzZZNHJxY1JMaDBGRVRmdkd5VlliN2JL?=
 =?utf-8?B?cDhBNG93d0ZwYVNzUXYzaGVQSTk5eEowS3huUjZVUjg0c2FSeHZmYTRVZnQv?=
 =?utf-8?B?aFN1NndtTzJJWDFPUSs4bHNpTFBxODBEaG1PM2xMUDMwRWFnN2I5Z25DZmZm?=
 =?utf-8?B?SWZXNno1RGJlUTkzeHJDQlVwc2dDcVJwV1VPU0trY1Q4SDVibU9FOTBoSXR5?=
 =?utf-8?B?ZDB4aVB6bDlBTHV6amVLU3pHMW5MNGV0eXZZYXNEemRvbWhnd0NIZEIwRFFL?=
 =?utf-8?B?QXBMeStPTzlOWm1xRHk2KzZVM0grUnQ4L3RXazhLOU1rbTd6ZTJUeGhIUUpV?=
 =?utf-8?B?Z2xaMnJ2TlpBRUtabkFPSmtCUlVTZXpsL3hVSmVKbUpURm8rVXRDNmFDMmFV?=
 =?utf-8?B?d2hoMHFvcnUyQkJYVlJjTnBMb3luR2l5YUQ4L2FpMXNGRmRzQXVRRURZZjZD?=
 =?utf-8?B?UTkxNlF3VVRYSUFadVNkeWo4OEw0ZjE1LzlGZ1BHQ3BlRTFWbXgyNnNUUkNQ?=
 =?utf-8?B?ekZ5K2wxWVV4OXMvbHdNM0xkMUhtVlBaa1JYcUhKUGZwTDFXS1dzaURtQktW?=
 =?utf-8?B?NDNLUjJUZEcrbEZZZ2I0QWNydC8wWjhmVGoveXg4WjFESGRuQ3VXZm4yRDNj?=
 =?utf-8?B?akFJQjJRQVdLNEFGOVhSYXoydW9WdzVxUVdyYUNPcTNpK3FFdEVBRDRncWhQ?=
 =?utf-8?B?TE5ud1NMSXVGRjZGYnZZT2RuL29DTmdCbGcyaU8xYzB5Q0x5UXdwU2tOZXhP?=
 =?utf-8?B?VWpxbG9Ga1FQSGM3TzlOS3VuK09xdGF5eDZ2U2ZRQk5venBRYkxkLyt1cXZl?=
 =?utf-8?B?U202dFV5aXlUZWFlN1U5U3VEb2luVStLTFNJcGo4cDRKR0UwaDRzaTBNQTdY?=
 =?utf-8?B?Tlh2QU9rWHhlRFZXd09QSHlCb1NzMzl1dHUweUlFNHlTNTFHRTVLQ3pwYTZ3?=
 =?utf-8?B?QVg4Wm5YMERNeWczSVR0SmlsVnlzRzJYNVZuSWpqMmRWTlVmNlJLS2pWNFlI?=
 =?utf-8?B?WG9aTlJBZUZBR0xSVXVnNDNtUFh4OXp1Qk1PY3NzOWpSYTFzcGtzU0VXZmsw?=
 =?utf-8?B?RlRwdWVzQUxwQlA1dy85b0hsTURmWE1wTUhzZU9ObHRMenMxVUdjc0o3ajI5?=
 =?utf-8?B?K0YxYzBXYm1CWTV3NkYza0lYVnp2bW1OMnN6cFZhSmFpZ2Y2SmRPTVFNMk9x?=
 =?utf-8?B?VnQ1bExjNlEzektYNDV6d0JBWDhNYWRyYWR5L3g0dnd6Z01rOStYd1lnRkxG?=
 =?utf-8?B?U3pYS1pyS3JzbHVkQWh1eWswNXlPY2RmM2puVDZ5UHR4V1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NkdCs0b013TGdla1ptMng5cHViU1JJMjVzWk42ZW0wT1I2d1QyRE9DSGVT?=
 =?utf-8?B?Q2pKTVB3YWdoaEFremdkcHRiTU1jRGZFTzVNOHhtMFh3Nm9Mc2tOa3l3bXRR?=
 =?utf-8?B?NEtubDZuYjdJUTh1QTF0VFRCV3I4eDZYQVpNQWVPUDFRc1RhVnJJVUpFWEFq?=
 =?utf-8?B?MlBLM2tIQkxMNUlZQzNLemJTd0t6OHpkSncwNFlMb21OYmY0U1JCOGxwa2F0?=
 =?utf-8?B?UGpkY01pOXlQaXZVSkdtTXRZQVkxaHgyOEU0Q2U0a0VOZitUbVdWMmpIYTMv?=
 =?utf-8?B?dGtqajA1N3B4VUtRKzlRK3crcnE0WmV3bFJDUHZTM0Z5dzBZbTBZaWU1Ynlm?=
 =?utf-8?B?MEFXS0I1R29ub0REQkIraHhkMFVPUDFZaVg5cmNQdzVqWWc3WFVWWUVndXh6?=
 =?utf-8?B?bnV1MEN5NDU3OURQVTRqYXJCbkhodG0zam5wc1VxY3I1dnZ6QXN5Zks0QU1t?=
 =?utf-8?B?RitRcTl3TGJKUWVMSllkZXJKZU9KaysxYWwybWpqdTRncjhqS2o1NjdTWklz?=
 =?utf-8?B?M1o3UjBWYlh5a2ZJbTJ6QlQyVkxqUGhldHl3Z0N3L1VNYVgzU0ZtUCtvc2ZS?=
 =?utf-8?B?YnBzQkZ0REZyZG9pbkplc2N0UEhlamY5dmlNYUVIY2RXOXVaRU5zOTAzdk9q?=
 =?utf-8?B?Q0ZuR3pRQWVKVGh5NjUyQ3dKMGpFVHE3ZnBwcE5kRit6TjJpNGtqUncrbHVh?=
 =?utf-8?B?VlZlMGRoVFRGeWNWUi9lUStUNDBEeEJ0VVYyWmNKcXNDenVWTHJYbmNwS3BI?=
 =?utf-8?B?VlVBNHFIZnNvaHlmZ1R2WGZaUzd3d2kvOVB2ZzFCQkZibUI5SGNMV1Q3bGVU?=
 =?utf-8?B?bnh3bnh2eVcxYkJDY1lGY1pHSzV4eGtZU2E3QWV5VTR5V3g2dWRMMjJFM3BY?=
 =?utf-8?B?anc0MWFVaHhNQlhtRUN5KzBNQ2pOaHRkR0E2ZWNsei9jblpPK0tJTlQ3L1hu?=
 =?utf-8?B?bnFFTCt4K3MxWW5QdjJFblNGcElBVXc4UFlJRkdEUUd2LzRWUlQ0YUdDdC9h?=
 =?utf-8?B?MGRjWW1pcVpFdjE1VFBjOFJnM0dLUVhEVkNaSWRYT3V0Z2FrRXg0bVJTRkoz?=
 =?utf-8?B?b1JGeWpEZnZTMDh1N1lnTGExNlg1Zzl1UWxaNjFEUjNvSGxmbDAxcXVndXJz?=
 =?utf-8?B?dEwyK1d0dHBnZGZGc3lxQUtXQWZmektNbE84ZENyLy82SUx5UEZCYTNhSEJF?=
 =?utf-8?B?SG5GRWkwVlhlMG5QM0dmL0RES2ZvdmxTSVVHd2VveE45R290V3dXRmttQkZv?=
 =?utf-8?B?SHhISHpEUTVBRldTMGdmbEhoK2EwLzRlZjJMNS9WdWhSdmJCSjdQZGI1TUhP?=
 =?utf-8?B?YkxsQ3RxbTQrUEpZZEpYQStmK2RJenJCdThRLzdlWHFvemFHbkdvZW9UUEF3?=
 =?utf-8?B?ZnFibzgwaHNXK0Vwa3Q2MDRjT2NTeW5OMEZWZ3VCMkNaSTBRSUNxN0s3eHdY?=
 =?utf-8?B?YkkyalB5TElQU3Erb3Y1ZXUrT1Y0S1dkN3FwVlpzVnNGVnpUaFExdXZoNytj?=
 =?utf-8?B?OHNTcm1Oc3hCMVQ3SzBubi9tc2lIcXdGS0RXQlkybmlKWFlGb1Y3UG56K095?=
 =?utf-8?B?djV0azdHU3ZjNjJWTlJuYVdnUkhadXFKakozbEdSS0JVNm13NU1kNklwTnIy?=
 =?utf-8?B?c0tlWjNQaTg1eUxEbmFKV05MZXdYYXNEcU92QVVrbCtrM0hjZTFiVytacXp0?=
 =?utf-8?B?T25kUUZPcmIxRFJ5ZlVZM1p6RUZBTnRJQk4yaUpxK0lmeXVCeUREcUkyZ1lI?=
 =?utf-8?B?VGU2RElsRDI5L0NFTEI5cWdyNG1YbGxGNkJlS0g2ZlFIR2xjT3UxNEk5RVdO?=
 =?utf-8?B?OU9FbS9RbTZIaXZsUDd1bjBWVEd1Q05WSkdpZzdDVUZ0YmdObVk0WjZaNGRs?=
 =?utf-8?B?L3B3S1d4ODZJL3ZYdE9DT0YzUEhyNFVXc29ISGZzc2d3NkNxSUFmNm1SL1V6?=
 =?utf-8?B?SFJqTnlLc2c4eTdnb2pNRS93U1R3UWxCcjJrejVMUVpHYjY4WEF5dFZJNFdy?=
 =?utf-8?B?dnh4Sno0SDcrcU9TRzdFb2ZLZEhRSTY3Y2svQXJNSEprSitUUkNtRC9FbzRO?=
 =?utf-8?B?b2VCT0VCbnpEU0VpYU9UZkR1QjhGWGkwVEhwV3BEaHJ3a1Rjdmtjc1hjWmti?=
 =?utf-8?B?aHU3VnlBY2FwaklHUDhmR01XblorL0grc0kzNGh3Z0NmcjRYMS81RE1YZzJI?=
 =?utf-8?B?YnI2SDRwMDdpczVVOThEZzBZd1ppdWhpSEJjWnJ1TFZxTUJad2ZLeEFNeTVP?=
 =?utf-8?B?Qlk0bWRkWmV6c0dHSUVidWw0N1VRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8629439b-33a0-49e2-136a-08dd8187a70e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:22:58.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r0meHoYNCgvNShRXBSmVl15KDpDdUcIlT2lpNoWapDFD5AdBZE8VP0NUjN6owzh8evmLuTFUs8vOBF9uFowEgg9fPId4WGo+QH+Uv/w8Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7204
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

Hi Aristo,

On 4/20/25 4:39 PM, Aristo Chen wrote:
> [You don't often get email from jj251510319013@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The "commands" are duplicated, so remove one of them
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
