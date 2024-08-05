Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E8AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F4E88928;
	Mon,  5 Aug 2024 16:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zDpv+0TP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A6888951; Mon,  5 Aug 2024 16:12:13 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E7B888E0
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCQiqz0nlqQKQqjkS71URBw8pzEfzWHfCuCwmCh8WpQ9a95LOS0hINS22vyT3J+wIEsQkQkiWg9fZPIxvMx/+qxj4fukVLKtNxqW+Dkcwm3q62pVVY81kcyTBOG0AcsFSftZYccoL56YKbf7npIgo5a5Ust6rjkEq9y3+6lzeJ94MUybdRYbqBddVBCCifOUI9m3DR3l/Botzhwk8GEEnN80nfTU5/LOM7huI6c27cI0n1y9eKi8oeawzUy9iFnjbGxvg/6UroSod6CMn9tuHawa5rBr7YvhOvLBG4uM5zmsiK2dCMaAWfwqlphMFpsb44wPw6spdVcrydpLEujwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD6GTfYzoJrJFyB2cDbXaTM7FnSQZjega62q8mZdDW0=;
 b=TecKaRnfRmX5IlHnIk/VkTqhcr/A9GT365cNzI0quXw++748r89E+9YWjO9KZV87ujqLiLeca07R6UoFfnsdDHHHQStUG4m2jn14lkngLSpwFZvTY8gDJmZsDPU2mhXGrJhjkIP+yEHZkTnBQlRT6ePDQxQM/q5BN7vs+MmHp6IHwaQ2gWMv+yvluoicZ5k1yM9l3UlAFn9vfCfaPvoj9jUuPat026HqSBMO1OCbjpzObSrcl2s8K0D3Fv3l/RNEwdT1QfsO+U2zKOwitxdkD6bJ9xWST8uNcn5T1S0KQ0AUqt1XLcW1mo+rHL8sQ2ofNwVmDLBUPjAsD44ewllA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD6GTfYzoJrJFyB2cDbXaTM7FnSQZjega62q8mZdDW0=;
 b=zDpv+0TPSbRr3l13+aQ4bFPNQY1K1N4SKjJlXLjeTQg81hveXmDzUVQu3ORezWqVg/Xpv23duufHGnMsmHKimNG83hvACdW9Ind+M20v8KVF0FIAQgMvYfgFvg41yYqaTbHDaMDTbjwg3XSefmM7geYusFjUKgOLNwuUbiheYUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:12:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 14:12:05 +0000
Message-ID: <e04d78b9-9078-43d8-b91e-9acd0e8214b7@amd.com>
Date: Mon, 5 Aug 2024 16:11:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix pwm-fan polarity
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Vishal Patel <vishal.patel@amd.com>, Tom Rini <trini@konsulko.com>
References: <4658ae8576882f5d28ad57ca74a7b798a546ec37.1722241096.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <4658ae8576882f5d28ad57ca74a7b798a546ec37.1722241096.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b34ff33-449f-4ffb-e2d3-08dcb55895c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWFhYnIvem54Yk9rcFM0MFpkdUduN2ZyUnQ4WjEzTzlOUlI0R2xrQU0rb0NS?=
 =?utf-8?B?eHpRRlByRVpZN2ZzQVQ2TWxtbmZKOTVYWU5rZlkzTGRjQk5zdGlQMnVDSHJV?=
 =?utf-8?B?NVhXQlZJUXdwamVCV25jM0toU3VnaGpDVUJOalpzamlIbW9sSGJHdHpsU093?=
 =?utf-8?B?S3MyN3pJbGlkazBOQlE0STA5OVhtdTlPSS9WMVFZeCt0N096Q0huWEVMcmNw?=
 =?utf-8?B?Q3dmQzdyVjE2T3BmcG13MVF4cXZMYjRVSER3QVVsOGZuRVZib3dFSC9KeVAv?=
 =?utf-8?B?eis2YWlGM2c5MjBtUGJ4NG1kM1JTSWIxeGNKcGdZNkgzYnhRS1FqZ2E0bmpq?=
 =?utf-8?B?MDBCOUVYb213bVRSdVUrU3V4NUh0bmQxZ1N3RWI3T1JDbDR4YXRZemRoMkRB?=
 =?utf-8?B?ckZXbWlBZ29WcXF0UHMvWVdWbkZmdVJlQkdVRGRybFpLWFNMKzVoeGhxWTVj?=
 =?utf-8?B?VEZKVnNZYnpJazluSDAyNmRlV2F4d2tjTGFZeXkvOTMrcGg2ZnROZUpzWm9z?=
 =?utf-8?B?ZmdvZXZibEwxdDkybXVuVklDQXVoMkpBZUFPVGhOTUsyeitBUGhxMmJRTVJE?=
 =?utf-8?B?eUkrWkhEdHE3L2QrNTdLYjZtUWdnTWdvYzZPY0lxMGQraUtoVmJNM003eFZp?=
 =?utf-8?B?RmsxdUIvbVl4RVhvY2dYKytuV2MzaHdFUFRPby9EeGRldTdLWkl2TXlLWW95?=
 =?utf-8?B?NUVMS2ZlV2hZT2tNb3N0ck55eFI4cERHbkNQZWhacVlJZ0s2MndGaGpXcWhl?=
 =?utf-8?B?Y1Z6QVVwWnNLM1grSXFmd3dBL2J5TFJDVDRUZnM3S2FFQWoyTU5tT1pqOEYz?=
 =?utf-8?B?ZVFEOUg3NEljMmhlYnlaQUJVZ0hKRUs2a1laWVFzTGQ4U0dvOWpocTZiTkN6?=
 =?utf-8?B?NmV3MEU5SllWeG9hOUwxT3RsQzJHek40Wm12SEFVR2xueUFGUW8zNkY0VFFO?=
 =?utf-8?B?OWZtV05qUmJjemcrZDhqTElMbit0RDl5MjdPVm1DaXlNSXRwUFdJYi9UeUY3?=
 =?utf-8?B?Y0twWkl6bExNS241UXVkbTZFeEliTHdUYkd1Q1k1RXpiQkh2QlZqWFhOZVBR?=
 =?utf-8?B?Nk5ZNFlpaTFtcmdHSHZ2QUR2UEo3OTVoQ28xRFc1ak5RSHhZWHhleGpHRW95?=
 =?utf-8?B?Sk5KejUxZUZJc2loREhEQkoraXI1VXF5elhNemZSeTYvTTU1V0tLeko0cGxO?=
 =?utf-8?B?emJIaE9ORHJjRndHbFd0NnZzaHVEQnM2S3dHWnJWSmZtcktxYUZDQnFnR2Nz?=
 =?utf-8?B?NUtTelpDRXJDcVQ2dFlORjhPRjVNekpzWmZJQjg3M0dpWk9naGFPVS9FS29I?=
 =?utf-8?B?Sk9rWWRURjJwMWNJK1c1NXNWbFBmWU9VaERFcDRlSjA2aUplZHdhRVUxNHl5?=
 =?utf-8?B?MWg3cG5NSXEzNU82a0NvaGUxWFl0ME1KaTZ1OXdKdnFQbUxWTnUrQVVuZUVu?=
 =?utf-8?B?c1h5S2FaVEJZVTY4Rytxa0FWNjlTV2NIWDBLWlVwSEhYVFFnQlZERkx4bENT?=
 =?utf-8?B?Tlk0TmZTUURIcm9lbXFXdnN4RWRVTTlRMmFjeGg4TE81TUJEellqdFpGb3o4?=
 =?utf-8?B?RXVlN2hibUZRYXcxN29LKytxQWVERnpsTFdEYXkvRXJBRWRJU2l5SENva1M5?=
 =?utf-8?B?Wk9NcDZ4elJyNlZzMkFGY0NQV0VmMlE4TlVVVHdoeWFTcUE0M0ZBS2RNSTF6?=
 =?utf-8?B?S2UrVXdWeEs3YXM2WWNvOTczUWRETHAzYU0xM3lRcTl3bjh2QmIvcWM0dmZ1?=
 =?utf-8?B?bXN2eWtJZ3ZuRDdHTXlNQnhxb2NpU1VFSSt6MFllNHNSakh6anZ2NWh5Ylky?=
 =?utf-8?B?SnBPY0F6bzlPeFBKNXpuUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hXRTc2dGpuMDFTaGN4Nm9OL0tUWHlVb0E0VjQzVGZkQTlZL2llWEpBemFo?=
 =?utf-8?B?K0FPMGRDNmRUVVlNK1F5OWRTTFNieFhhNUxtUk5tL0I2RXJnalRpS3JRUEF0?=
 =?utf-8?B?bkp1VjByMTFuKzY5OFVUV0U0UGlzVkVuRjNQMnJFTmkzM01PUzh3Qy95QUtI?=
 =?utf-8?B?NWtWZjFqdHhoK0lFR0YrdytEWmlFUHJoQWJSRFdpUzlJZFZxSjZWN0dhTlRQ?=
 =?utf-8?B?a3VabloySVZka0NaTVVObFhiR2RPbHlzUGNlays1ZEpKdkoxamVCMXYvVnJO?=
 =?utf-8?B?QzhVRWZ5ZGpKK1I0Z0xFMXAxYWxYVVNucVVXZU5meld3VGJlejJrbC95aDcv?=
 =?utf-8?B?bmk2QWgvdDVYLzd5b2Q0WWtiNTEzSU9uVzAyaEtlU0xUM3hwK3dlTUdXMnFF?=
 =?utf-8?B?b1krUlNMOHVFSDNHWHNSaGhUKzZsUXYrVjhub1lRR2gwNnNUbXFWMHlSbVFT?=
 =?utf-8?B?am9Wbi96MER1bmcwYzFjTUpJZDd6bVRuazZXbnlWeVFQMnJuK09BM0V2Ukd2?=
 =?utf-8?B?N1QzL0pSZjU1Z08yVzdwbEdLR3VRZG1EdU40dDBZWUJyejc2MDdKaHduVEgr?=
 =?utf-8?B?UzlvZEpnenVTR1pvWktjZnVlcCtGaFY5QlJRdXZqN0k4QjhwYWJwbkU5UEZI?=
 =?utf-8?B?Njd2OEJvczR3SEhvUXV2Wnljd0lhZG5panhmeTVtVHpmMjhjYlRFbU4zbHhX?=
 =?utf-8?B?cmlLb09OTGlxc2JXRi83c3ZhWi9la2pBUDJQY0JBRE15ZHNDWUNEWVlBbnRo?=
 =?utf-8?B?QzBoWWRDVm44emUvWW5WZzFFS1JQZTNZeUVGeDI5ZjBWdmdXK2NBY1ZuaVIv?=
 =?utf-8?B?L0FTcC9VZldXdjNmY1dyc2xyU0U4RktuL0hpUVVxWEtkL1dESFV0MXZJWm1i?=
 =?utf-8?B?ZXBkRWExRnp1TnhMNSt0d040SDcrdHhKQkgrUVZwNmJud1ExaWJDdXYwMXNw?=
 =?utf-8?B?Nmx1WW9hVDFoampSWDBua0hIV1F3UVMxdk5Zb1UwR0RSOHJnTCs0MTlpTXVI?=
 =?utf-8?B?VXI2emQ2enA2bmpySE5WQ3hjRXZ2a2xRcVk5Wm9CQmNLeDk1LzdodXFFbnZ4?=
 =?utf-8?B?RUo4bVIzME9DYkFZUFoxQnpXc01La2NOWjlSbzBySGxxMFNkNkFOS2U0dUdC?=
 =?utf-8?B?U3RQNFo0ckxiRUd4RWw4K2oxbnk3MmdiMEUxbHQ3UHozMG5UZXZmakdpVjVk?=
 =?utf-8?B?UjJYdytjbzdtelFEUlBvZU9vdW5WdjkzOXd5dlRzV0ZiUVpYdmUzQWVUL2J5?=
 =?utf-8?B?NG1jZjZ6S042bHdoQStaVmRBaTkyWXVselJaS2JjcE5oSnYvTzhjZFFnWjhm?=
 =?utf-8?B?elkzcUZkaWJtbkpGSHYvR1NxUFhRVXc1VzFZUTdwUnBoQTVTbWZ3OGdJclI3?=
 =?utf-8?B?WlFabTBLQ1JHOUlmZDhiZGtuVjZFUW5MZ0M3ZlR6L2UxamNOYThrWmpYM2hp?=
 =?utf-8?B?RUozZ0lPZzNhbUVRdGkyQUs0U3ppZStCcEp1VXRLVDNmOG11YU04MlZ5RUM3?=
 =?utf-8?B?VkRoSGtCVnJobWFxWUVmY3d6bGY2R05qUi9jWHBlUy9LMHAyREdDMmZJSU9E?=
 =?utf-8?B?VGlaU3N6bGNMVzltYW1SZ1BXbFVtdGs4YmdZWWx6b3RyWFUzZEJ4aWdJMXFK?=
 =?utf-8?B?aHJtYjBaRmZyQTdwcHF0MklkUThDZEI5dHJ3Wlp0YVhTRTZmSVAySlpZUVNB?=
 =?utf-8?B?ZkVIMkVmSkdxWTFsQmVhd3QvN3d1QWZNa0Z5SGs2aGdvTTN1NkRZQ2I3L2hx?=
 =?utf-8?B?c20vOHBMQjE3blIzRXcreVFDMWNBMXRDS0FBZU5aSmJ4RXZCbkNPRTNVcTNU?=
 =?utf-8?B?Wlh3eWRWRlN1dlovSDRRbDVOdm9RRWd5eXNNWHJSTmcyaXN3OXBlR3YvYUgx?=
 =?utf-8?B?YzBaZlhjMnAzVXRuMDFUdU5JKzBDMjVUM1R2cjF1cVZRRHBYclAya0lSK2Rv?=
 =?utf-8?B?RnVSV3hkNlo0RTJ3Zm4vQzJ6RVI1ODVkTFZOQnJJNlNSQkQvR2N5cDhiR0k3?=
 =?utf-8?B?bGlJN0ZpN3lKeGExeXZXQmk2R0ZFeVdwYlRiaGxKb0pNY3BXSFJQZXJ1UVp6?=
 =?utf-8?B?Yk5TUjhhNlljVnZFZHAxaHJPMnZZNzUwUmtJY1l0VDZza0VOVCtRTVV3Zldh?=
 =?utf-8?Q?lScxGlJrjCr9GPsX82JcH5tW8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b34ff33-449f-4ffb-e2d3-08dcb55895c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:12:05.6677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEKx/afEcD6wiA1nLpYRgbn0h6OQjxWyE24dEwgMmAzwngPC+UvAVt2ar1IN/kHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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



On 7/29/24 10:18, Michal Simek wrote:
> From: Vishal Patel <vishal.patel@amd.com>
> 
> The correct operating mode for the fan is inversed (1). The
> previous pwm driver implementation had a bug and the polarity
> information was propagated incorrectly to the kernel. The normal (0)
> polarity specified in the device tree was incorrectly clearing the
> polarity bit in the counter control register. After the bug fix,
> setting the polarity to inversed (1) in the device tree will clear
> the polarity bit.
> 
> Signed-off-by: Vishal Patel <vishal.patel@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sm-k26-revA.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> index 5859e6cd8c23..d95a05e21592 100644
> --- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> @@ -107,7 +107,7 @@
>   	pwm-fan {
>   		compatible = "pwm-fan";
>   		status = "okay";
> -		pwms = <&ttc0 2 40000 0>;
> +		pwms = <&ttc0 2 40000 1>;
>   	};
>   };
>   

Applied.
M
