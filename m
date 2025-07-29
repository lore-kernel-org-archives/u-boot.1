Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07723C87FCC
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE7081E06;
	Tue, 29 Jul 2025 13:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nD7l/v8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0546982103; Tue, 29 Jul 2025 13:30:19 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8DC805D7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrJFjfM/p+Z1HW21eAUuKmGWjUGtznMmtegRjI79Za+3OGKbyyt85N2hLVZk8fy805uERbmlE2xMTshHUKn3NOtJ0QVGP9eQImZkeRlIXzDnfRUno4qZsatRPRXQFgcTVrs45j2iCFnj6NSI+UrhErq4HIIZ9M3obJflw/m7fSOiljA/Z4PPqVT14RrYw4a0gfsj8eO3ABvmZ7PDQyltJ3Q1RmpbEqVhDbSVSdznnzeia6zJpwVTSsqBbjy/4WuTjZgLLPAoY2oxrl2KD6/d5FUMw6XfVCKHZXIC+BkaN2CzYBHoCOc5oKUbLPZ4lJ5EDjDaeVp49g+qG2707H2wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TFmmee7oB5kA+oNyLl41UYxBt83DjrRgRgBOhSJHQU=;
 b=uW3iIHYHBFe5fdxyWF+3n6ikwTjatxkHEsbBk+Ig1B9Si+mGyMHoFyMmQqF65NXdEXEoJCOzbABXGySQjRamkrLY6tCwRxeU0cNd7aPwmMUatVz5AUfYCgItlz5AV1t0iVcM9QsBVv0XeYBVoldqqOlDri6U/cHJOW2MgKvFck2CVHss2CveJVseTPgJ2p17CkWWRDcwe81LDbDwokR7wbDSbSOZmrlK2U43s53hXyQ2nPhAlYY0Q2U0o4/RViwxEWT5UO9wj7gk93ffkEA7MWGwI/pAiIQ2/SdkCIQn11DSH/MHhkDGCk9d15t0px5dZ/5rmwpzpFZZBjxLFFstWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TFmmee7oB5kA+oNyLl41UYxBt83DjrRgRgBOhSJHQU=;
 b=nD7l/v8r2YfNpXqf4kXVdIe+OgXMsUYNPikE7Z27RYMnIZ2wAy0sJy9hxNBlGInhfqqRMfVRV7R4he6kX5Ivs2o29PTarKlsV+IpEXljKEfmSE6nJQFTYu3UIObI/4zS1niJxRbikiWImUMI7faIFFM6+kNEc2UwvXH8Vcw8rnjRDquo/0VHLbocPNyTkh1qCLPTdl4o3xID/Pr5/Iz1+7hW2PGRnrqqZhV3l9vDD8LW6XAXx+lKbcRgUgscgqUAEiI2aDWf9HsmYPwoKPaiFff1o7iTPg8QHwwOlLqTjLZnfbkHBGH5SxIa0+ltMt+R6Xbj5wISxhYDkDvXbzmQTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS2P195MB2388.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:640::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 11:30:13 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:30:13 +0000
Message-ID: <be30680b-625b-414d-8aa2-b5a6cfc75651@phytec.de>
Date: Tue, 29 Jul 2025 14:30:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Add imx8mp-libra-fpsc board
To: Benjamin Hahn <B.Hahn@phytec.de>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
 <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
 <dcd0452c-1d9a-4968-9e47-f63f8d77242c@phytec.de>
 <92bd90da-5559-4f78-a7e1-df37854a2abf@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <92bd90da-5559-4f78-a7e1-df37854a2abf@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS2P195MB2388:EE_
X-MS-Office365-Filtering-Correlation-Id: 693bc2e0-6dc8-435e-43c0-08ddce934871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHhLMEpwWXNIWE1xMTI3cGgwemRISjlFKzA2bks2T1dYWXNxdC94dlU1Q2Vi?=
 =?utf-8?B?ZEd0TkFLNlM0QjEzWnBIWm1UcjJyWDIrWnEyRXl0OWdIMlVucEY1TWZEdVBF?=
 =?utf-8?B?NG5IYjRLM2NxL2RXaDhGbWNTUC9aNzhBSVNuQkNVa0FmTG9zUElYaXB6aWFu?=
 =?utf-8?B?czRXNE94SVRuaVllVEhpQ0FnY2xnYWZZTUliMlcyd0tpOGV2T3JsUzl2Vmp3?=
 =?utf-8?B?YnhBZHRBVndRV0tpNmEwUTc3djhCTEVPVFJIM1M4cCt4KzlGS1NIWEJxRnpG?=
 =?utf-8?B?Z2FMa1BKMkd4M0dvM2lTZWozOFRNWGV1bGdITEJiMyt2QkVxdnFXenB1VzJX?=
 =?utf-8?B?MG9hMWo1YUUrV1NwZFVrb3VzR2Q1Wnh0WU91WnlhQmdzNHFUMzR6RjJzSlpu?=
 =?utf-8?B?MFFKOGczSy9WY0dPV0FWZXlnb1B5UktNM0hyd0VNNlM1N2hPSjBXMGV6Y1lv?=
 =?utf-8?B?SW53NXh4ekRYVllueDF2aTQ0SmUvYnpVWXZ1NDBYSmxkRTV2VGlQUy80bjhK?=
 =?utf-8?B?YlIvTkl3Uk9oR3U5VXZab2IvWGxHVHZmVTdjUlI3UGdQQm84VGZZdXlQZmRv?=
 =?utf-8?B?NG50eWRxWHlFSytKejZ3SlRVY1RCTUtXSVJ6TEowK3lNNGpCc2Z2a0RjdWhS?=
 =?utf-8?B?MXRFZzVqdC9sNGxidW42d09XMjZHRTlFdFgyTkorUGhndVV4TVRLaVV0UURK?=
 =?utf-8?B?dVRBUzFxckFTM1B3MmFmbk0ycGRGaHFUa3lRSVo5SS9tRlo2cmt2UGNURkk3?=
 =?utf-8?B?eVVNaHR1OG1BODE4Y05WS29YS05Mcm5MYU5CY0JvSjdGSFUwdXlKNVg1UlVH?=
 =?utf-8?B?UHNBdHR2UE5saE5TcmF6SEIwWGo1aW1UbzB1bVA4SFJlUXJrbDZ0L2txVjZ1?=
 =?utf-8?B?VC95RWE1WFc3cHA2Z0hSRHdWQUxydWp5Y2FTZnprWDBVamcrb3NvNFl2cTA4?=
 =?utf-8?B?Q2RuS0ZkMmkvT2Y1SUlJbHVWTlJoSmxmeVNNMjAzTlppWXh3V2s2ZnZ1Vldp?=
 =?utf-8?B?bms5SDEvU20reGdkZGNtL1NkK091K2lDeWovUm1DMFlMSllzbHRxTEdCanZP?=
 =?utf-8?B?MUVzMk5GdFUvRGpKK1JLeUJXTnJkL0k0QjZaeVNpZnl4NHQ4NVVNRjZQVXpU?=
 =?utf-8?B?L1VOT3VCbHNKYXM2STU3eU9oWm1tZFhuNWxQT3ZEclJsUFFZTjU3QUhwS1JM?=
 =?utf-8?B?cDgrRVNZMU1ldU5Oc2w1bXFXM0haNGQrbmxXaEZ5WERzcC9yaE9YNldhZldQ?=
 =?utf-8?B?NFJETSt5ZlFCZFVZOXVIbGpkQXJLU3pDK0FlVkNiZnhrSUZPQlZHVWdEOU9r?=
 =?utf-8?B?M3p5WXdTdlEzYWhLZnNtbjlYTXFWb0tZcWlEaWloTE5EVGN3L3BIVlJUekQ5?=
 =?utf-8?B?RmNBZ0Y0Y3dMdzJMVFFPTmhZaWYwQk9EL3JJNnJMY0dwRHdPRkFDSWhpRWNH?=
 =?utf-8?B?cnFnSkd0Y1hDeUlQSThNSG9hK1crVFpsNnhaTms4c2lRZWR5Nk5JMTI4Rzkx?=
 =?utf-8?B?cnFpNUNWUHpwTy9Pbkx5eTkyVzY0aFlRNkVHL0pZVFNRVmtDTzFBYTNxNEF3?=
 =?utf-8?B?VDlDNlI0VWtBUmtvUzR4VlBwa1dIUytnOU1KZjNDci9tZEVxNVkrUXFvWUkv?=
 =?utf-8?B?cmxJSFVFN0dvQlRTelRHYlh3eHc1bTUya2ZxTWpJcVZlTjBaWTRERm90NXBw?=
 =?utf-8?B?UTBpYkV6U0lGYjRiQ0xrR21lUjl1K0JCSzJFR3RIRWUvT2N2Y001TDhVMEVQ?=
 =?utf-8?B?RE5VOENGdFJyRFZvRloveGJEWUQ0aUwzOUtKcHI5WFo0S21YTkFCWmcwNjlO?=
 =?utf-8?Q?JylwsYC5H1Z6HBfPeiIAEj5aLNJH7+WTJIPmc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDcvNTZjL0lmR1dKMFlHWEp4VmNzQU4wZ3k0SEZyUHM2VWtuNFhad1QwdEU3?=
 =?utf-8?B?ME14WTUvcWFQYkczUUZOZ0wzYnJSbFNsaWNZcnNsZ0JyaEF5N0VBMS9ySkJN?=
 =?utf-8?B?ZkpGRXpDdURaNEw5b0JoU2F2OHJaSkRFaVVEV04raE5WWkcwKzRwY2p4Rkw4?=
 =?utf-8?B?T1dwaHRqRjZFUVJ1VTdsd1hGTFcyYytJcW03UXBuNUhXQ2F0YXpLN0ZFdG01?=
 =?utf-8?B?azMwOGU3UitnZGhRQ25YOXZ5OXhXUWNraUpCcEEvSkVQSENSd0JBYS9yMlNU?=
 =?utf-8?B?TitGRE42bTZTTWxqVjhFdEpFZEEzVVIvSW4rSE1XWHRGZThvQmZvUVpHdUZu?=
 =?utf-8?B?dzl6UU55cENjcEdkZnozYzN2eUl6bHpLc3BNUlVDeVdROGJhR0NHcU5TZ3BX?=
 =?utf-8?B?akZmL1hsZjNqdHUyK2JtV1pUSWl3YzNrd1JoNzRkZEp3RE13VmNiUFpiQU9m?=
 =?utf-8?B?YTJlUmlsclFWa3l3a3dYNEU5KzZieVdhNXZqYXR3ZWdRWkNraE1UcEtkdVlL?=
 =?utf-8?B?Mm9ITC9KS2dzbEhJMVI5Y1R3N1hxcUtxVGR0UVdxNHp1ZmZDZlJMOFp5a01E?=
 =?utf-8?B?ZzN0M21qc2xFM2pNVHpwb0lNdElPbzA2TWhNZFVqOElFdUNweTI1U1llWHZh?=
 =?utf-8?B?TWxndDN4dEpVaG05SHBjQ1gwVWcwTkZOL1dTVEQxUGVRMng5RDZUMkc3bEJq?=
 =?utf-8?B?U05ja3l3MzBJMGt1VjVlTDd4cEdpdTFaRXQrYmdkWU82SzN3UDdETWtXNEZq?=
 =?utf-8?B?SkhTeVpUeDAwY3I5Ukp6NVlKSDVyaWV2VktjOHIwM1FhS0E3VHVNeFcyM0FJ?=
 =?utf-8?B?Y2tqS1dtQUJvMXFiS0hheEcvSHdiVlBZU2NxamNhbUVlWUpPQ0srMXlicDgv?=
 =?utf-8?B?YXpndVdvd1Q5Q3QrSUY4RXc1QjROWSt0ZmhKdlZKWUZsUXRlRy9vTUNDM0ho?=
 =?utf-8?B?TFVoUVhzaEdPbHFRbVVZWHlqL0JXblFqbzdMSHF5THRqaTdhVzlFYURNL0tr?=
 =?utf-8?B?Lzc0U2ZNejZ1OWpMbEJrZVFMOVk5ZkViVHdPM3pCVXVuQVR1ektJbXZsNUtI?=
 =?utf-8?B?aFp0dWwxTUhyYWhPTVFGZThkM2VuUWdtUEJzS3dRZUY3dXVWQXNuMnNrMTJi?=
 =?utf-8?B?VXVBOTlrbG5oWnlsakhUSFViZGQ1YVhJOUJiSVJDZWdnTFhaN05zeHI4TGJl?=
 =?utf-8?B?bUw5UjhJL1RtQUFlT0JFSm9lTUJCcE1YYlg0a2pjQ2d3TGdTZG1jbDkyYlIy?=
 =?utf-8?B?WE5OendyVDhVTkV6cVZ5akR5OG4zSXozMUhXekcrUHlCWC96L0hiYU95d2hn?=
 =?utf-8?B?RzNuK0NMNWdtK0dLQS9HU1lYTW1BRVJFTG9PMVR5NHEzVVk5d2ZHUVBPbm1o?=
 =?utf-8?B?ajNsZEFOVXN3Nis4RXd5a0RLck9qWU9yaXgra3VHSkZ6RktiWVJKc2l2VkVL?=
 =?utf-8?B?N1JRTlVUeG5DdXVJSTl3bzNKN1BSVVNjejRxQm1HZHFzNXZZNGxITlNSandv?=
 =?utf-8?B?WCsxckVjRWVmNDF4ajZKa2JOWmQ1Q0VCdElKTmkwYnI4TFUybWFidWg3STdC?=
 =?utf-8?B?WllDZHBJSE11QmhLWDZnS243RjBxalJXbDlRZWdubm9NdmIrYUxNWEhWeUZu?=
 =?utf-8?B?WFI3QXdRTEduQUF2ZnpJaDVmNVIxdG9hUWZhZjczVk8wZFdSVFRzT2IrVUpS?=
 =?utf-8?B?c0xubGNFdmYxcEZKVS9GZEU5bGtEejZEUFpOS21VdENWZjhwMzdXRDFlYm5p?=
 =?utf-8?B?T3FMdUtnTHN5YURtNTZrYUNBUzVUWldNY0FuRXRkTzR5eFlScXZOYkZKZmNu?=
 =?utf-8?B?dEtKYnByejQ5aXgyZ3NlTDZMa3c2SFdTTnZNLzZwMW9oamV4UWVWbWVwUTA5?=
 =?utf-8?B?VGozYlBhZGFuYkt6eEErNkxyQVg5cExPTCtPbkNYcVo0VnlMb0NVZ3hIdzFB?=
 =?utf-8?B?cDV0NlVva3FYdHIxS1p0TkEzVFhxUFBsVTVxU0xGMndqd0p4U2RTblBiWFBZ?=
 =?utf-8?B?UG93UXE5RmRqU0ZYNi9uV2tvbTFFVk02OFU0b0Eyci9LZnQ0TkJJZkVINGNJ?=
 =?utf-8?B?cWlUdWxSUlJMcUxoTjJrT0xGbDBrNCs1SjN5Slg5R3hqNmJJSU1DcTFHR09J?=
 =?utf-8?Q?PmheWSdMmCUEyJMZ8HakvMPYN?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 693bc2e0-6dc8-435e-43c0-08ddce934871
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:30:12.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0El9JOgt9zYX/nGoX+SNx+LL58tvGU/6F6p5zwAM0fDVkgj21pwLRYvWMDyhil1SMVxBSkHpXwPDGbxJHZSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2388
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



On 7/29/25 12:06 PM, Benjamin Hahn wrote:
> Hi Wadim,
> 
> On 29.07.25 08:25, Wadim Egorov wrote:
>> Hi,
>>
>> On 7/25/25 1:35 PM, Benjamin Hahn wrote:
>>> Add new imx8mp-libra-fpsc board.
>>> USB is not working yet, as the entry in the upstream devicetree is
>>> missing.
>>>
>>> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
>>> ---
>>>    arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |   78 +
>>>    arch/arm/mach-imx/imx8m/Kconfig                    |    9 +
>>>    board/phytec/imx8mp-libra-fpsc/Kconfig             |   16 +
>>>    board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |    8 +
>>>    board/phytec/imx8mp-libra-fpsc/Makefile            |   10 +
>>>    board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |  114 ++
>>>    .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   30 +
>>>    board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c     | 1846
>>> ++++++++++++++++++++
>>>    board/phytec/imx8mp-libra-fpsc/spl.c               |  131 ++
>>>    configs/imx8mp-libra-fpsc_defconfig                |  170 ++
>>>    include/configs/imx8mp-libra-fpsc.h                |   27 +
>>>    11 files changed, 2439 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
>>> b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..8f0f86d9f09e
>>> --- /dev/null
>>> +++ b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
>>> @@ -0,0 +1,78 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
>>> + */
>>> +
>>> +#include "imx8mp-u-boot.dtsi"
>>> +
>>> +/ {
>>> +    wdt-reboot {
>>> +        compatible = "wdt-reboot";
>>> +        wdt = <&wdog1>;
>>> +        bootph-pre-ram;
>>> +    };
>>> +};
>>> +
>>> +&reg_usdhc2_vmmc {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&pinctrl_uart4 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&pinctrl_usdhc2 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&pinctrl_usdhc3 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&pinctrl_wdog {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&gpio1 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&gpio2 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&gpio3 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&gpio4 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&gpio5 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&uart4 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&i2c1 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&pmic {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&usdhc2 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&usdhc3 {
>>> +    bootph-pre-ram;
>>> +};
>>> +
>>> +&wdog1 {
>>> +    bootph-pre-ram;
>>> +};
>>> diff --git a/arch/arm/mach-imx/imx8m/Kconfig
>>> b/arch/arm/mach-imx/imx8m/Kconfig
>>> index 74416a788473..2e4b86473c63 100644
>>> --- a/arch/arm/mach-imx/imx8m/Kconfig
>>> +++ b/arch/arm/mach-imx/imx8m/Kconfig
>>> @@ -345,6 +345,14 @@ config TARGET_PHYCORE_IMX8MP
>>>        select IMX8M_LPDDR4
>>>        imply OF_UPSTREAM
>>>    +config TARGET_IMX8MP_LIBRA_FPSC
>>> +    bool "PHYTEC Libra FPSC i.MX 8M Plus"
>>> +    select IMX8MP
>>> +    select SUPPORT_SPL
>>> +    select IMX8M_LPDDR4
>>> +    help
>>> +      i.MX8M Plus Libra is an FPSC SOM based on NXP i.MX8MP.
>>> +
>>>    config TARGET_IMX8MM_CL_IOT_GATE
>>>        bool "CompuLab iot-gate-imx8"
>>>        select IMX8MM
>>> @@ -411,6 +419,7 @@ source "board/msc/sm2s_imx8mp/Kconfig"
>>>    source "board/mntre/imx8mq_reform2/Kconfig"
>>>    source "board/phytec/phycore_imx8mm/Kconfig"
>>>    source "board/phytec/phycore_imx8mp/Kconfig"
>>> +source "board/phytec/imx8mp-libra-fpsc/Kconfig"
>>>    source "board/polyhex/imx8mp_debix_model_a/Kconfig"
>>>    source "board/purism/librem5/Kconfig"
>>>    source "board/ronetix/imx8mq-cm/Kconfig"
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/Kconfig
>>> b/board/phytec/imx8mp-libra-fpsc/Kconfig
>>> new file mode 100644
>>> index 000000000000..449bfda79632
>>> --- /dev/null
>>> +++ b/board/phytec/imx8mp-libra-fpsc/Kconfig
>>> @@ -0,0 +1,16 @@
>>> +if TARGET_IMX8MP_LIBRA_FPSC
>>> +
>>> +config SYS_BOARD
>>> +    default "imx8mp-libra-fpsc"
>>> +
>>> +config SYS_VENDOR
>>> +    default "phytec"
>>> +
>>> +config IMX_CONFIG
>>> +    default "board/phytec/phycore_imx8mp/imximage-8mp-sd.cfg"
>>
>> This does not seem to be right. I guess you want to have a copy of
>> that file for this board.
> Will change to imx8mp-libra-fpsc.
>>
>>> +
>>> +config SYS_CONFIG_NAME
>>> +    default "imx8mp-libra-fpsc"
>>> +
>>> +source "board/phytec/common/Kconfig"
>>> +endif
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
>>> b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
>>> new file mode 100644
>>> index 000000000000..16b18b605e0d
>>> --- /dev/null
>>> +++ b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
>>> @@ -0,0 +1,8 @@
>>> +Libra-i.MX 8M Plus
>>> +M:      Teresa Remmet <t.remmet@phytec.de>
>>> +W:
>>> https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-plus-fpsc/
>>> +S:      Maintained
>>> +F:      arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
>>> +F:      board/phytec/imx8mp-libra-fpsc/
>>> +F:      configs/imx8mp-libra-fpsc_defconfig
>>> +F:      include/configs/imx8mp-libra-fpsc.h
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/Makefile
>>> b/board/phytec/imx8mp-libra-fpsc/Makefile
>>> new file mode 100644
>>> index 000000000000..8f956eb2ffbb
>>> --- /dev/null
>>> +++ b/board/phytec/imx8mp-libra-fpsc/Makefile
>>> @@ -0,0 +1,10 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2025 PHYTEC Messtechnik GmbH
>>> +
>>> +obj-y += imx8mp-libra-fpsc.o
>>> +
>>> +ifdef CONFIG_SPL_BUILD
>>> +obj-y += spl.o
>>> +obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
>>> +endif
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
>>> b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
>>> new file mode 100644
>>> index 000000000000..89b3b6f90ecb
>>> --- /dev/null
>>> +++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
>>> @@ -0,0 +1,114 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
>>> + */
>>> +
>>> +#include <asm/arch/clock.h>
>>> +#include <asm/arch/sys_proto.h>
>>> +#include <asm/global_data.h>
>>> +#include <linux/io.h>
>>> +#include <asm/mach-imx/boot_mode.h>
>>> +#include <dwc3-uboot.h>
>>> +#include <env.h>
>>> +#include <init.h>
>>> +#include <fdt_support.h>
>>> +#include <jffs2/load_kernel.h>
>>> +#include <miiphy.h>
>>> +#include <mtd_node.h>
>>> +#include <usb.h>
>>> +#include <i2c.h>
>>> +
>>> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
>>
>> There is not need for this guard. Please drop it.
> 
> There is a reason for this guard. We only want to include it, if we
> actually use it, which is bound to this config.
> 
> We have the config deactivated for now, as we do not have EEPROM Images
> on libra for the alpha release yet, but I expect that to be added for
> the full release.
> 
>>
>>> +#include "../common/imx8m_som_detection.h"
>>> +#endif
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +#define EEPROM_ADDR        0x51
>>> +
>>> +#define TUSB_PORT_POL_CRTL_REG    0xB
>>> +#define TUSB_CUSTOM_POL        BIT(7)
>>> +#define TUSB_P0_POL        BIT(0)
>>> +
>>> +/*
>>> + * WORKAROUND for PCM-937-L 1618.0, 1618.1.
>>> + * USB HUB TUSB8042A has swapped upstream pin polarity.
>>> + * Set i2c registers to inform the hub that the lines
>>> + * are swapped.
>>> + */
>>> +void tusb8042a_swap_lines(void)
>>> +{
>>> +    const u8 pol_swap_val = (TUSB_CUSTOM_POL | TUSB_P0_POL);
>>> +    const int addr = 0x44;
>>> +    struct udevice *dev = 0;
>>> +    int ret = i2c_get_chip_for_busnum(2, addr, 1, &dev);
>>> +
>>> +    if (!ret)
>>> +        dm_i2c_write(dev, TUSB_PORT_POL_CRTL_REG, &pol_swap_val, 1);
>>> +    else
>>> +        printf("TUSB8042A: Failed to fixup USB HUB.\n");
>>> +}
>>> +
>>> +static int setup_fec(void)
>>> +{
>>> +    struct iomuxc_gpr_base_regs *gpr =
>>> +        (struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
>>> +
>>> +    /* Use 125M anatop REF_CLK1 for ENET1, not from external */
>>> +    clrsetbits_le32(&gpr->gpr[1], 0x2000, 0);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int board_init(void)
>>> +{
>>> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
>>> +    int ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
>>
>> What is the point of reading out the EEPROM at this stage if you are
>> not using the information? Drop it and add it later when you actually
>> need it.
> See above.

Currently, the code does not read any data from the EEPROM, so including 
logic that may be needed in the future is unnecessary at this stage.

Please don't blow up the initial board support patches.

>>
>>> +
>>> +    if (ret)
>>> +        printf("%s: EEPROM data init failed\n", __func__);
>>> +#endif
>>> +    tusb8042a_swap_lines();
>>> +
>>> +    setup_fec();
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int board_mmc_get_env_dev(int devno)
>>> +{
>>> +    return devno;
>>> +}
>>> +
>>> +int board_late_init(void)
>>> +{
>>> +    switch (get_boot_device()) {
>>> +    case SD2_BOOT:
>>> +        env_set_ulong("mmcdev", 1);
>>> +        if (!strcmp(env_get("boot_targets"),
>>> env_get_default("boot_targets")))
>>> +            env_set("boot_targets", "mmc1 mmc2 ethernet");
>>> +        break;
>>> +    case MMC3_BOOT:
>>> +        env_set_ulong("mmcdev", 2);
>>> +        break;
>>> +    case USB_BOOT:
>>> +        printf("Detect USB boot. Will enter fastboot mode!\n");
>>> +        if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
>>> +            env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int board_phys_sdram_size(phys_size_t *size)
>>> +{
>>> +    if (!size)
>>> +        return -EINVAL;
>>> +
>>> +    *size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE +
>>> PHYS_SDRAM_2_SIZE);
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
>>> b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
>>> new file mode 100644
>>> index 000000000000..edcd05aedd2e
>>> --- /dev/null
>>> +++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
>>> @@ -0,0 +1,30 @@
>>> +bootmeths=script
>>> +boot_targets=mmc2 mmc1 ethernet
>>> +boot_script_dhcp=boot.scr.uimg
>>> +bootenv_addr_r=0x49100000
>>> +console=ttymxc3,115200
>>> +emmc_dev=2  /* This is needed by built-in uuu flash scripts */
>>> +fdt_addr_r=0x48000000
>>> +fdtfile=CONFIG_DEFAULT_FDT_FILE
>>> +fdtoverlay_addr_r=0x49000000
>>> +fit_fdtconf=conf-imx8mp-libra-rdk-fpsc.dtb
>>> +ip_dyn=no
>>> +ipaddr=192.168.3.11
>>> +kernel_addr_r=0x5A080000
>>> +kernel_comp_addr_r=0x60000000
>>> +kernel_comp_size=0x2000000
>>> +mmcautodetect=yes
>>> +mmcdev=CONFIG_SYS_MMC_ENV_DEV
>>> +mmcpart=1
>>> +mmcroot=2
>>> +netmask=255.225.255.0
>>> +nfsroot=/srv/nfs
>>> +no_bootenv=0
>>> +no_extensions=0
>>> +pxefile_addr_r=0x58600000
>>> +ramdisk_addr_r=0x5e000000
>>> +sd_dev=1    /* This is needed by built-in uuu flash scripts */
>>
>> Can you bring both variables next to each other and use only a single
>> comment line?
> In this file, variables are sorted alphabetically, so no I can not bring
> those next to each other.
>>
>>> +script_offset_f=0x400000
>>> +script_size_f=0x2000
>>> +scriptaddr=0x58500000
>>> +serverip=192.168.3.10
>>> diff --git a/board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c
>>> b/board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c
>>> new file mode 100644
>>> index 000000000000..dd5b4ad8347a
>>> --- /dev/null
>>
>> <snip>
>>
>>> +++ b/board/phytec/imx8mp-libra-fpsc/spl.c
>>> @@ -0,0 +1,131 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
>>> + */
>>> +
>>> +#include <config.h>
>>> +#include <asm/arch/clock.h>
>>> +#include <asm/arch/ddr.h>
>>> +#include <asm/arch/imx8mp_pins.h>
>>> +#include <asm/arch/sys_proto.h>
>>> +#include <asm/global_data.h>
>>> +#include <asm/mach-imx/boot_mode.h>
>>> +#include <asm/mach-imx/gpio.h>
>>> +#include <asm/mach-imx/mxc_i2c.h>
>>> +#include <asm/mach-imx/iomux-v3.h>
>>> +#include <hang.h>
>>> +#include <init.h>
>>> +#include <log.h>
>>> +#include <power/pmic.h>
>>> +#include <power/pca9450.h>
>>> +#include <spl.h>
>>> +
>>> +#include "../common/imx8m_som_detection.h"
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +#define EEPROM_ADDR        0x51
>>
>> Why can't we have this defined in imx8m_som_detection.h?
> 
> Because EEPROM addresses are not standardized as far as I know and might
> vary between different boards/SoMs. So this is board specific and not
> general.

Yes, you are right. Adding the define to the imx8m-specific SoM header 
still make sense.

