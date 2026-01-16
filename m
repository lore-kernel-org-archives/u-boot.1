Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60384D4A61E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B8183923;
	Fri, 16 Jan 2026 11:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4govOy97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763CB83966; Fri, 16 Jan 2026 11:00:32 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6922383923
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lddFBp//s3n4zeDoJaLL7haICX2HZtmIqfKRWoMME2nm+Gq2hzbV5krGPhU3FBTrNaqPngINEu0Okzra+zP+19TxWSPXWkRsowSgtaktwcHqeZrPfcufkTZFN2s8jAxRN+8ORTQkOuGHWyDhEOtOGMGnaD461Rk8gbibBU8VGRT4P0QQsvIEvVPMmHrzEhw9HO9VMl/ZZMEQcdYi1Y/W2qGpXrv5gUavx53OcQkepiEiTGRwlPs0tQaVCOzH7P1ozN28DFpGb1RDwNyKmTA+tJAPeiG0XHZIIlRRkYaJ1fsU6RX9LZYE3EHetHLHXon3Nwm076na4klgWzX8TRtiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AovE2EZY5jphtkK3LKHTorjgeBchb71RWQUISXtaEHI=;
 b=yvKt7iyaBrwiBGxoBByBKvl477GcYmAZJATn0SIJJDrO8nepYb1l5JUxZw6h+kYIYlmjnGq/oBay3gQ55DMp2PvbDK1iL7HWlSJ0F6E+tPgTRnAIn+9SkalswpYX8ALo4NGCWkVR4csfp+nHANUlFoUs5h3eFCXtPr1xOCvnXJvvds/p+R7t2YYMqANbdRwpAo2KQzJsikzmDvQwr3YPLZGK4SeZGiWPohehLJW2TRu6hQ47yjYQekRciiAbWgoQdyXmzGPkB8ZZi+Afy36dbb6+RJkZNu7fWc5B8xI+XituyPwORV5y6Hb1hfUFJDhkDXe6VriHYwxH+PwEYy6YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AovE2EZY5jphtkK3LKHTorjgeBchb71RWQUISXtaEHI=;
 b=4govOy97OPLdk5P3pGf0VI2323i8C1nWMRH7SPGjUfXGLXosf6VQyAHBtOid4PdsIbXSOr0wBh/ZijyoCWo8+Yog5nejmxB6eJnsgPMY8c9K6dxFHn0gbnRsK7CrxLWzKGaMiwta51kGGDmUSSWdyEex7fgGPDvC8gPXRiSkB6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 10:00:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 10:00:25 +0000
Message-ID: <bb03737a-a680-42bc-b097-4d989c83e82c@amd.com>
Date: Fri, 16 Jan 2026 11:00:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Fabio Estevam
 <festevam@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260115222828.3931345-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed5f44a-a3fc-48dd-d313-08de54e61238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2RyOWhzalFZTTlkUHNBVUUrdFQ5SGNuaTZ2ZzVIQzhDYzl6Wjl0REhPWjYz?=
 =?utf-8?B?UCtYMFJseXpVZzRRc1U2cytnM01PNG9EZWFlaWJ5TkRjNmZNUnFXeGhtTzlx?=
 =?utf-8?B?dVorWVhORDRUQXZYdEQ0M1dBZXcrWGJNMFpFa3JkcXhCMXhaUkRIOXhJSWI3?=
 =?utf-8?B?VmFzdDRpdUhiVENGK0FWQlBjSnUvaGx3SFphUHA2RkRPb29KRVFMd2ZxVmNo?=
 =?utf-8?B?RkVVcUFqbmozZTJwcnNVZWhyZngvK2hQWnI4ZmQzMmZEdS9LdTFqRGo1Wk5X?=
 =?utf-8?B?TEtyK3BiOE5wdUZzc2N1azNHNkxoNXU0M2s3dm4waUlZWHpBK3BPY3VyQ0dk?=
 =?utf-8?B?b3hiTWJ2YTFVc0tNeWc0MHRFQnBGOW5kemFaU1ZzamdnbU90cHdjRFVzSHdR?=
 =?utf-8?B?VFg1RXZmQmlhaG1RRjBDY2VlR2pCTEJ4UkMrQ005NENZQ3RtVEJzWUpMd1R0?=
 =?utf-8?B?bW5vMVVjbFdteGw5TG02dHA3cFFTL25ibDR6aXg2RFAwNldDZG10bVV2Mk92?=
 =?utf-8?B?Q3gwVnFzY3hsYTJvT1dPWUlraFdpaWhPREszeDVycWRaOGx5LzMwS01mdXZz?=
 =?utf-8?B?QTFKY0xoOHpjdnhBeU11T3FxdGcxeHlkSE5NcE9aajdmT0N6M3VqaEYrZGxW?=
 =?utf-8?B?b1hvdExrZ2RORGtzZUtpU1VONVNjdlZ2U1hnRGVjZVR0RkU0TDV6RXhDYnYw?=
 =?utf-8?B?NVdNS1Vlc3FoM2ZYY3BNdG5YamVobzlzREJkSXVabzE0MzFxMmtQYy9QRGsw?=
 =?utf-8?B?a0t6MUJScm11NWYwRVRVNkU1SWswcXJsY1F2RU9mbEFqRU5RMlhQWlVwbXVk?=
 =?utf-8?B?MGRaNWtValdOVnRnYng3c3BxUUE4RFhUOVF2Z2pVTjRPK2ZXWUNxNDdaaDF1?=
 =?utf-8?B?L2RRMTdRUFEwNVBuWGJqNlFkZ05RTnhrenA0d2ptSnZacFhqdFVJeU9zSmJD?=
 =?utf-8?B?NXBVNUU1YkV4ckp5K2xxTlZFQXJJamF5R2JKV1pHdFJJd3B0RXhRNDlhYW1X?=
 =?utf-8?B?dSs4QURhSHYva1c5cjR2eFYvQzRraFBvcmNtQUFGbXY3aks4VVFidVppakNy?=
 =?utf-8?B?Q0ZMT3ppWHNJcmxmUjc2TStVWGUxdEJpZmZ1eEJqV0EvblZJaDFWRkFaVkJx?=
 =?utf-8?B?cm0xMnVOOW9NaS9KYkVkMm94eDhpMnRqUDZpbmhVdGNsZ21vSmg4RThicHhF?=
 =?utf-8?B?Ym9OSlJtTk1lOTlCTGxjd1hFTmRtdGQzUHBzRk5TZ3JEUUJEVlZqT0NUMm9n?=
 =?utf-8?B?K2U0dSszeWxpbDAvZjNjTlVuYlFJdWtjT0lLMXkxOEFCdDVjYVpHQTR0TjIz?=
 =?utf-8?B?TnFSQXROeW9UN3RkK1dkVjh0b0RWL2diand4TmF4eXo5bjUxU1QyWU1LMHdF?=
 =?utf-8?B?UmhWOUpNNlEvVnRuTkg3SWx3QW8zVTdNUFZLZElGb1hBSGtrQjVxTGNkQ0FU?=
 =?utf-8?B?YXlWVTYvZGt5NGF2N05TVmhRQWZ6QzJ2TjRITDFvZkpvR0JwMWxzTDhlTnNx?=
 =?utf-8?B?U09EK21TbkZINXNlak5zdFhRVlQzRHJpK0Fxa2dQTGZnUzh3VmNndnZXcmZ2?=
 =?utf-8?B?Y2NzRkljdDV4SExOaWxmRXYzdTFDeGJSd29NOHI3RzV2QXI1a3lScDBjeGhr?=
 =?utf-8?B?SGREUnN6by8yekwxTWY3aU5QME5nZlRiWmtvR3luanpsbkJsbi9rSHFRNXUr?=
 =?utf-8?B?d2VwS252bHpSMzJRMFFGOFZNWGxLK3hMMk1MYS9EM010QWpjRjFiVWM5NWZ1?=
 =?utf-8?B?cWJtbGRDM2EvVTRvdVpZZE5lK1NXS05FbXVBKzlZdGtNMTZEbDE3TW4weGI4?=
 =?utf-8?B?blRvdXBydnlKTWR6UTlmQUtBMWt4Z3d2QmxWT2FINkUyK0JQVmtQN2hxd0dI?=
 =?utf-8?B?NklJWFZscWZnU0dGR1pFMDNERVVqSGxlZ3F4VVJDSFM1enZCcWU1RE16dVZE?=
 =?utf-8?B?Mk5MMXNxODMzZFNHQmVaNHJidDVHb1oyNGZuSG9YSmVNTTVDbE1FRFJSRmV4?=
 =?utf-8?B?TVNMTXA1YlNmQlVGaGpCNUwxNXMwckxGU21iNFRJYlBvUWt1MHZhWWc0T0JI?=
 =?utf-8?B?QlZLZ3MralZkTVl0M25ySmcyaXhzVE9oOExWS0ljMTdPT0FKUFFjT1UxNGk2?=
 =?utf-8?Q?upps=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBsVVhmQ0t3cVdDUmhIbHNJbHNKb0VnQXFEK3VINnN1UmZoMkxUZkhORTRN?=
 =?utf-8?B?TG1JOFBKRTFjaXAzZmJ0T2EyMnpKaHVNMWdBejdhU2xCL2I1NlpuVVpRYllL?=
 =?utf-8?B?UHRhQnNmL1ZibDNXOXJubWd3RkVYSDJOMmNPMEJHUjdBRlVISHY5c0NKa0Rl?=
 =?utf-8?B?TUdhMEZYWiswbTlDODcrdDVRTC9sQm12WGxYYWpBNHptQVJxdkMvMjkzaDlh?=
 =?utf-8?B?TjVDYTRSZmNISXdjVzY3cjFWbklqdzRzaE1yNlZFWnJlaW8yZTBjRlhTWUdw?=
 =?utf-8?B?UmltQkxUbFRUL24rYlFpSkVWVzFtcFVwSVlIZHNDdUxIVFI1RWpuNGJZRGlE?=
 =?utf-8?B?QXZVV2tkWWoyRDR6andtWTB0Qk5wQXMzcGdGT1puVUZ4dmtpTmxKa0tqV1gr?=
 =?utf-8?B?eHM2bnhGTjNNcGpRak1kTXNQLzNRa0ErZjQxQ1lBT1NEbDM4eXMreWJ4cVdI?=
 =?utf-8?B?bUZmaTBtVjZ6R0VzNTBta3dxWVdzVDZuRnc3VGFza0pMamh1QStxbkNDbjRJ?=
 =?utf-8?B?dXp1YVRERFhQSTMzNmFpYjRUWVRIWTNCSElkWWRmakRRN1VCdmlSWThiK3FT?=
 =?utf-8?B?RlRpc2ZwNWhIVHNpVWFHb0d1YWxJRnR1ZWJuQy9sc0tGWU1EYnlNMDRmc2lx?=
 =?utf-8?B?a0RhaE9HamMyRnc4SUpwQzBLRktuNGNYMWZLdWszV21zWloweWdsbElRNHdo?=
 =?utf-8?B?V1Y0Yk8xRG9vMFZhYlFZS3NXQUtialBCcUNIamlwckIzZG16UnBWWTR4eEdy?=
 =?utf-8?B?N0c3bGpTYjJROUNPUWNyQ0pOTGFLS1hUa1RscVBiR2x4dmxRd2ZLZW14ZElH?=
 =?utf-8?B?ZWorZ3ZwOFV0WllQTjIrVm1WbGQwK3Znc0xubHZSK051c0ZTS2pJVXlmcDhj?=
 =?utf-8?B?SXM5djNKYTd3bEx6VnFVYWtMSHczK3hNYXN1V3hZajVXRmFQNkxsQlI4QWtF?=
 =?utf-8?B?TTR3eFhNeWpncUs4UkVZVVpQbDljcWg3Mlo5VzVsSTVlT2dpMmgxSkRrVEEv?=
 =?utf-8?B?NStURHl6eHJ2MlNCYXpIWjRnVmRSbG54S3hCdG9kYkhLQy82VWtPMkZPYng4?=
 =?utf-8?B?clNqMmVNZ1diOEN2YVl6dXN2c3oySTlsWVMyRmkrY0FmRjRRTmRUS2xsNjZP?=
 =?utf-8?B?clVHV0R5ZExJT254eng0VWp6MmQxTjdhMk9lSmRPTjBQMEQyWWVyTXp4Nzc5?=
 =?utf-8?B?WmhHWWxkV3lueVdKYXlqQ2U5cGVodFo3cGJGaWczbjVVVUhSeHJ5K0x0UTZ6?=
 =?utf-8?B?SncwOExRUUFtTnZ2aW5mVlRDUXgzc3ZqZlczc3lNYzBBdEdTR2d5L3JWUXJv?=
 =?utf-8?B?QXFaYjBmbm9sYlJDdjZZKzRWNVpuak4xL2VHakR0Tk9FMVVieWR2UjQyR3NP?=
 =?utf-8?B?dEhsaUE4WjZyS3B6bDd3R1ducUkrN0lmS3ZqWHJXQ1luTGZ5ZUNOQ2tCdCtU?=
 =?utf-8?B?bGxhT1BlVnNUaExRMHBxa0pWQlZ6QmFQUFU2cTRyRUpCRm45UlBLTkhydG9Y?=
 =?utf-8?B?Wkx0UDZsUDcwRXdRMW1rOHl1RUNBYlcxT05yeEVhc0ZJaWdxZGlINGJRMDc5?=
 =?utf-8?B?S1JtZU5SMVlzRXhBWmtDcEZMcGZmYmx3cXh4N0RQUklpZXQ4aUJ1WFh4YTZ5?=
 =?utf-8?B?V0E2eDFOajRBSVNRcDBzRjBCQTRTSnpOL3E1bkhiQjBRT3BuR2VWRHowRW93?=
 =?utf-8?B?c3RuSDBGMDJoZHhabk9XTWFVbTg5dGJ5Vm8rSFhJazdRSFY0ZGY2Q2xWMVBW?=
 =?utf-8?B?enhBL3krZGpwemdWOGNBd3lBK3FnWWFTbHc0THFaRERJY0hBT2xQcTJ3MmdZ?=
 =?utf-8?B?QTh6QkdaSUtNRkRNdFNoR1gwY2h4dFdyRk9CbVJMb1FSdWpQWUUyVVluR3Y1?=
 =?utf-8?B?UlFpdTRxbkZGWTVuTHJXQktOREpJYW9lMmpVeWdZcmRjWE4xVDNEdWNDYTRJ?=
 =?utf-8?B?QVhGem43R3RTbmZzNG9sWCtZOEtPanVuOUsyc2w5Qzd3N1hwVFlMSDBmSkZs?=
 =?utf-8?B?TVE4N0lPQ0dTY2Q1Z1psTDlqZUtybG9hWVBmcHU4OUNNOUNpdXFLUWwyWTk4?=
 =?utf-8?B?UThhNEJERXQ1ZUgwekV0UUs0TXVtTHluWVBXaGtFamFST1lZVTEwTnV2aC8z?=
 =?utf-8?B?UUh0TzlKc3ZPMVB1ZjBXOUgvWUtrb2tZeHNBbmx2eTVMdEpLeE1mekpqVW5D?=
 =?utf-8?B?MVlDUGRhMWZlbVpVYW1mYXZRVkFtQ3FTWnk5NUZseEVwdDhhamhnTXcyaVUv?=
 =?utf-8?B?dC9ZRTJjRko0QWlaeEw5OThHSjVPbU9JL2JJNjJ6bTVkaUc0VUZDMTZxbXNp?=
 =?utf-8?B?WW42RWsveEVuTzRrRzdZbmxyaWc1SDZKK0tJcjlsTkQ0OFF3VFJvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed5f44a-a3fc-48dd-d313-08de54e61238
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:00:25.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIbRiEKD2/2HssWG5O2CvPrkqbSv0DJ/sJ1UJP53asNj/CfdcamNHCsW14MDJoOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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



On 1/15/26 23:19, Tom Rini wrote:
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Expands some linker sections to be more readable when adding a second
>    statement to the section.
> - Aligns the final section before _end (for U-Boot) or
>    _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
>    '. = ALIGN(8);' to the final section before the symbol.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>    aligned we fail to link (and explain why).
> - Remove now-spurious  '. = ALIGN(x);' statements that were intended to
>    provide the above alignments.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> The only part of this I am only mostly rather than fully confident in is
> having caught all cases of having SPL_SEPARATE_BSS being false. I
> believe I have as the generic ARM SPL linker script enforces the BSS
> ending with 8-byte alignment, and the point of the ASSERTs here is to
> catch the case where the section we're adding the ALIGN to ends up being
> empty and so that ALIGN would become useless.
> 
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Stefano Babic <sbabic@nabladev.com>
> ---
>   arch/arm/cpu/arm1136/u-boot-spl.lds            | 8 ++++++--
>   arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      | 5 ++++-
>   arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds    | 5 ++++-
>   arch/arm/cpu/armv7/sunxi/u-boot-spl.lds        | 5 ++++-
>   arch/arm/cpu/armv8/u-boot-spl.lds              | 4 +++-
>   arch/arm/cpu/armv8/u-boot.lds                  | 2 ++
>   arch/arm/cpu/u-boot-spl.lds                    | 5 ++++-
>   arch/arm/cpu/u-boot.lds                        | 4 ++++
>   arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 4 ++++
>   arch/arm/mach-at91/arm926ejs/u-boot-spl.lds    | 9 +++++++--
>   arch/arm/mach-at91/armv7/u-boot-spl.lds        | 9 +++++++--
>   arch/arm/mach-omap2/u-boot-spl.lds             | 3 +++
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds       | 5 ++++-
>   arch/arm/mach-zynq/u-boot-spl.lds              | 6 ++++--
>   arch/arm/mach-zynq/u-boot.lds                  | 3 +++
>   board/davinci/da8xxevm/u-boot-spl-da850evm.lds | 4 ++++
>   board/samsung/common/exynos-uboot-spl.lds      | 5 ++++-
>   17 files changed, 71 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/cpu/arm1136/u-boot-spl.lds b/arch/arm/cpu/arm1136/u-boot-spl.lds
> index b7af29183a97..22a9302275ae 100644
> --- a/arch/arm/cpu/arm1136/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm1136/u-boot-spl.lds
> @@ -30,8 +30,10 @@ SECTIONS
>   	.rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } >.sram
>   
>   	. = ALIGN(4);
> -	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
> -	. = ALIGN(4);
> +	.data : {
> +		*(SORT_BY_ALIGNMENT(.data*))
> +		. = ALIGN(8);
> +	} >.sram
>   	__image_copy_end = .;
>   	_end = .;
>   
> @@ -44,3 +46,5 @@ SECTIONS
>   		__bss_end = .;
>   	} >.sdram
>   }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> index 7c6309246f8b..b4adae272eba 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> @@ -45,7 +45,7 @@ SECTIONS
>   		. = ALIGN(4);
>   		__bss_start = .;
>   		*(.bss*)
> -		. = ALIGN(4);
> +		. = ALIGN(8);
>   		__bss_end = .;
>   	}
>   
> @@ -62,3 +62,6 @@ SECTIONS
>   	.gnu : { *(.gnu*) }
>   	.ARM.exidx : { *(.ARM.exidx*) }
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> index cf65e8c46281..2225985c79c0 100644
> --- a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> @@ -31,9 +31,9 @@ SECTIONS
>   	. = ALIGN(4);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
> +		. = ALIGN(8);
>   	} > .sram
>   
> -	. = ALIGN(4);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -47,3 +47,6 @@ SECTIONS
>   		__bss_end = .;
>   	} > .sdram
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> index fb7a789b28b8..e69291d8be6d 100644
> --- a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> @@ -40,9 +40,9 @@ SECTIONS
>   	. = ALIGN(4);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
> +		. = ALIGN(8);
>   	} > .sram
>   
> -	. = ALIGN(4);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -56,3 +56,6 @@ SECTIONS
>   		__bss_end = .;
>   	} > .sdram
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index c4f83ec9cfc4..d9963846c4f4 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -52,9 +52,9 @@ SECTIONS
>   	__u_boot_list : {
>   		. = ALIGN(8);
>   		KEEP(*(SORT(__u_boot_list*)));
> +		. = ALIGN(8);
>   	} >.sram
>   
> -	. = ALIGN(8);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -89,5 +89,7 @@ SECTIONS
>   #endif
>   }
>   
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
>   ASSERT(ADDR(.bss) % 8 == 0, \
>          ".bss must be 8-byte aligned");
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index f4ce98c82c8d..704e0bf9468d 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -175,3 +175,5 @@ SECTIONS
>   #include "linux-kernel-image-header-vars.h"
>   #endif
>   }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index 5aecb61ce902..d780a5060774 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -51,9 +51,9 @@ SECTIONS
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;
> +		. = ALIGN(8);
>   	}
>   
> -	. = ALIGN(8);
>   	_image_binary_end = .;
>   	_end = .;
>   
> @@ -80,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
>   	"SPL image too big");
>   #endif
>   
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>   #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>   ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>   	"SPL image BSS too big");
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 78aad093d3b2..8e2266a90fe2 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -164,6 +164,7 @@ SECTIONS
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;
> +		. = ALIGN(8);
>   	}
>   
>   	_end = .;
> @@ -192,3 +193,6 @@ SECTIONS
>   	/DISCARD/ : { *(.ARM.exidx*) }
>   	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> index 9502a7384b53..c9664a6ce566 100644
> --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> @@ -59,6 +59,7 @@ SECTIONS
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;
> +		. = ALIGN(8);
>   	} > .nor
>   
>   	_end = .;
> @@ -79,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
>   	"SPL image too big");
>   #endif
>   
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>   #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>   ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>   	"SPL image BSS too big");
> diff --git a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> index 09cf838cf96e..1af4f7b6524c 100644
> --- a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> @@ -29,9 +29,11 @@ SECTIONS
>   	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
>   
>   	. = ALIGN(4);
> -	__u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
> +	__u_boot_list : {
> +		KEEP(*(SORT(__u_boot_list*)))
> +		. = ALIGN(8);
> +	} > .sram
>   
> -	. = ALIGN(4);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -51,6 +53,9 @@ ASSERT(__image_copy_end - __start <= (IMAGE_MAX_SIZE), \
>   	"SPL image too big");
>   #endif
>   
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>   #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>   ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>   	"SPL image BSS too big");
> diff --git a/arch/arm/mach-at91/armv7/u-boot-spl.lds b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> index 460a91d93ec4..287764df48ff 100644
> --- a/arch/arm/mach-at91/armv7/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> @@ -36,9 +36,11 @@ SECTIONS
>   	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
>   
>   	. = ALIGN(4);
> -	__u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
> +	__u_boot_list : {
> +		KEEP(*(SORT(__u_boot_list*)))
> +		. = ALIGN(8);
> +	} > .sram
>   
> -	. = ALIGN(4);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -52,3 +54,6 @@ SECTIONS
>   		__bss_end = .;
>   	} >.sdram
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
> index 5ad169a37b73..86ab692ae390 100644
> --- a/arch/arm/mach-omap2/u-boot-spl.lds
> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> @@ -55,3 +55,6 @@ SECTIONS
>   		__bss_end = .;
>   	} >.sdram
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> index 958a1b70aefe..2c0f5c3e5f32 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -42,9 +42,9 @@ SECTIONS
>   	__u_boot_list : {
>   		. = ALIGN(8);
>   		KEEP(*(SORT(__u_boot_list*)));
> +		. = ALIGN(8);
>   	}
>   
> -	. = ALIGN(8);
>   	__image_copy_end = .;
>   	_end = .;
>   	_image_binary_end = .;
> @@ -69,6 +69,9 @@ ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
>   	"TPL image too big");
>   #endif
>   
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>   #if defined(CONFIG_TPL_BSS_MAX_SIZE)
>   ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
>   	"TPL image BSS too big");
> diff --git a/arch/arm/mach-zynq/u-boot-spl.lds b/arch/arm/mach-zynq/u-boot-spl.lds
> index d96a57702886..17f0d7c9b72f 100644
> --- a/arch/arm/mach-zynq/u-boot-spl.lds
> +++ b/arch/arm/mach-zynq/u-boot-spl.lds
> @@ -39,10 +39,9 @@ SECTIONS
>   	. = ALIGN(4);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
> +		. = ALIGN(8);
>   	} > .sram
>   
> -	. = ALIGN(4);
> -
>   	_image_binary_end = .;
>   
>   	_end = .;
> @@ -62,3 +61,6 @@ SECTIONS
>   	/DISCARD/ : { *(.interp*) }
>   	/DISCARD/ : { *(.gnu*) }
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index f52523edf490..2a8e3399e0bf 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -66,6 +66,7 @@ SECTIONS
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;
> +		. = ALIGN(8);
>   	}
>   
>   	_end = .;
> @@ -98,3 +99,5 @@ SECTIONS
>   	/DISCARD/ : { *(.ARM.exidx*) }
>   	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
>   }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> index 56d6f4f114b9..d1a82e118af1 100644
> --- a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> +++ b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> @@ -43,6 +43,7 @@ SECTIONS
>   		__rel_dyn_start = .;
>   		*(.rel*)
>   		__rel_dyn_end = .;
> +		. = ALIGN(8);
>   	} >.sram
>   
>   	__image_copy_end = .;
> @@ -58,3 +59,6 @@ SECTIONS
>   		__bss_end = .;
>   	} >.sdram
>   }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/board/samsung/common/exynos-uboot-spl.lds b/board/samsung/common/exynos-uboot-spl.lds
> index 9d3b57e98dbb..62e150bcf335 100644
> --- a/board/samsung/common/exynos-uboot-spl.lds
> +++ b/board/samsung/common/exynos-uboot-spl.lds
> @@ -48,7 +48,10 @@ SECTIONS
>   		. = ALIGN(4);
>   		__bss_start = .;
>   		*(.bss*)
> -		. = ALIGN(4);
> +		. = ALIGN(8);
>   		__bss_end = .;
>   	} >.sram
>   }
> +
> +ASSERT(__bss_end % 8 == 0, \
> +       "__bss_end must be 8-byte aligned for device tree");


Tested-by: Michal Simek <michal.simek@amd.com> # Zynq

Thanks,
Michal

