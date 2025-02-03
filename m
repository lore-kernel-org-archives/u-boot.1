Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8AC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9519F80568;
	Mon,  3 Feb 2025 10:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="48iTPG3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B7AF805A1; Mon,  3 Feb 2025 10:09:36 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01237801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJqbUWsMqFZXflS7kz1soOLYYqmWMdJ3z2P09djphuudy06gWGkmsmhsEAtzU2Gz/XqFoiq9YT/MIHDUzkiBtTHRywU3eVDg8Gub25ywtvxELafIT1iyYg0u77I6wZbSzyEOOM1+gkXkG2NHiDpw/8X9VxEJ77LjMiRmOWCQh7trC61Z8rB/yu3VT+hoId7aePM93Q2bSR3xWk2I5hVB1G53mCKLIRKDReTCDoAJnofOf4Ek/AD7iLORJDYs/zpQPCnvfAbseFb0dv9WqRNSMkbQHzE9a4M28PgDTfDeC3F11kD+9Y1Y+xlPDuViltwBsElL0sCKC00ApTJ8MVXM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywcb4OreNOgPh5HQDX0O9ybRBVoTpjJJEFbasd/+GbA=;
 b=F63qO5nu/vHjAZXoUDfRkRS/rF1F7giZnEc5ESoHHWCmPSVneOy/AKcH4HFW0aEvnw7HuEXgRLyDOTb+bbyy9qlHIl1QewSo9qSHnnvT0i3R8zjZ/It/Nf0mDNd6dqpIId3bxUugMBVlcf5UkKQEnTa2o/74kYDzJDaJdpSUxdTbQHCrTMnM280QU6emIUomC3WUJD26gqKG+FstJdb0Ev0e26QC83lfIIsFBSVA91VuUJEWiagktPiw97MK88Eo4CRi8FgUX3qLWnNUpObLukOQh7EqWlKEdXnyDUMZbC0U/rMusjaILlEoZK4aqGU+SVpDA5i8o8vF3nGVeGAm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywcb4OreNOgPh5HQDX0O9ybRBVoTpjJJEFbasd/+GbA=;
 b=48iTPG3JoMoimbmdnIO4UizUele3nXy8afdryqxUAUy1pV9WbL1bO9XgcnLt89kSNICnREmPodMiAdcph1iWWT0Ryt5DlSUTQbp2oRuaz1VIq7q3BQCFH98AqDLTSIqLBKGX/tqqFqK1bb2QrQ7TSHdPAxf8KlUhKWIXg52DGH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 09:09:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:09:31 +0000
Message-ID: <dc3361c7-eb79-42c3-95c9-9fd324d2fab5@amd.com>
Date: Mon, 3 Feb 2025 10:09:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Remove SYS_MALLOC_F_LEN setup via board Kconfig
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>,
 Kristian Amlie <kristian.amlie@northern.tech>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thomas Chou <thomas@wytron.com.tw>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
References: <c3edd75b7a19d5cc205c9d5c37c2d86189ca3de6.1737380025.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c3edd75b7a19d5cc205c9d5c37c2d86189ca3de6.1737380025.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 839d9655-ebc2-4912-d388-08dd4432784d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejl6Ukx5d25VYUlLSGhhNVhOUUJaRXR0aVhSdU9CNzl2Y3BsRU1YRysrSUhV?=
 =?utf-8?B?cldENDdaS2dVTnQvd3hpakJYMU5jQ200ZWp4SUx6OC9FZzJXcTgyZVJaa09n?=
 =?utf-8?B?Yy9VR0xrY3JiZk9HSXp6QnErL0ZSSGVjQlEwRTFua1lwY3EzYjkvT2EwbjNu?=
 =?utf-8?B?bHgxandLZzNYU1F0R0lVQlZHcUlBL25KakMxdExwZnhpTmpqMzlMOVFDZ2JN?=
 =?utf-8?B?bXpWLzRlaDh5MmREN0U2WWVWMkJMSzh5aTBqY0tYdk5iRTlVbEJjb0I4a3FY?=
 =?utf-8?B?VCtLT2d6MWt5aisxUWQvMjA1bjRRWGViU2d5di84L2tldzRXRWwrZ0RMa1BQ?=
 =?utf-8?B?bi9nTEJ6OE12RVlYN2NpSm5wZzhHRkIvT2FCMVM0K1VvUFhkY0thbTgrTkNw?=
 =?utf-8?B?a1FkUUJTbmlRMEljbVlQTGpvZGUxNDRSNVNCcWFMbkhpRzR6MEx1eDBYWWRE?=
 =?utf-8?B?M2NVdUZpU3AzeHcxM1YvTlAvdXFTWE9wQUhUQUJ6ZXpLcjF5SWo3UWhMVDlP?=
 =?utf-8?B?ZFY4RjRLNUU3Ym81TUFFaUwvR2lmQ2FMRkR4YnFkYmMydVJMY3FTYXl2NEF3?=
 =?utf-8?B?Y0QyVVlpVk5VRjBVakdIWVRiQkhrMkNDRnJEVUNxVUtuVGpweGhjY1VTWDQ5?=
 =?utf-8?B?SVpKSjdHbmZOSWxCUEtmSGNIVXQrdnhiUEVjWHg3WW1PWk9hN3hwKzZDMHlY?=
 =?utf-8?B?cDUxU1I0ZlVISW5Cc1pXMHdpU3VGOTdEOStEY2NLOGpWbkx1RnRFdVI3QkFy?=
 =?utf-8?B?YlI4WG1CdDI3QjJvYXJrNjI1U1p4NXRId3NpZS9rbTNpTEN1enAvNGVwZFFx?=
 =?utf-8?B?NWdqbFFybmwxLzMxd1Q2MUtMd05wUkQ1UFhJRGkrUldNTlBRN0FGTVBlTlRP?=
 =?utf-8?B?S0pCU2U1RkZ1TXFqNVRvblVzK0JGYVZmNVl5VVJmL2kwL2xiVlZMTVRNcW9u?=
 =?utf-8?B?bVlKeUJQVi9Cem81aUtBUTFmRm11TjE3b0V0V0E2N3poSitYb2J2TXZDcGNo?=
 =?utf-8?B?OGJHbXVIbXFnbDU2WUczRDVTaTlobHkzcW9JOHNScGszMjl3VEJrN3FxZ25y?=
 =?utf-8?B?Rm1DVGlHK05hckNrWHpKanYwZE9LeUtXaDVpN1AzS0Z0L1RXNTFUbUswOVht?=
 =?utf-8?B?cU0wa3hBYyswekxuVmV0WEE0VU93ejdzK3ZEZ2ZRNGpLdlVPbDgrQXFWMjVa?=
 =?utf-8?B?bHdDN3k5NVhjMEx2UnZzMVhNNTdYQWUyQVhKYTBRZVVJbm50NGExaVBFQitI?=
 =?utf-8?B?SU1vSFIyUDI3S3lxKzZyNU5LN1JnMU1UVGNCRCsydDZLZ1BieU1aUDdoc09Z?=
 =?utf-8?B?ZFdLckRPdlZ3QWNGWHN0R0J4Mk1sMDlwVzJMamVOcE82cmFLSGNtam8rcVhl?=
 =?utf-8?B?SlQycVlrNGJuWkw5b2NPczY1T2V2bm1HM25BTFFwTmNqMHlhMmV6R24rZ3hw?=
 =?utf-8?B?QVkxVDlEeVZrTlg3cEJ4V1VIRXg0cXQwb0RQcFFQSzJDTXl4RjFqZk9uZHd6?=
 =?utf-8?B?WEpoaC9PS1NwbUZobWZzY1E5OUpMTmNjSzBBZUJMWmt4d2tIL1ByQk1jSzF3?=
 =?utf-8?B?SERwWEVTTmk5VzBNWWwvRnkxeVdkbkRMZ1BjNkc0UjRUZ0t0VTdlUFpKQzJw?=
 =?utf-8?B?ZXpnOVh5WFNZdEhtZWhvNXdZdmc2SVRIQXppRDlGaytsZjdaSUE3S2RaRjFS?=
 =?utf-8?B?dG5MUjdrQVN2N0lKSS9wa3RDdUFtM28wd0dJMXc4eHM3c0J6eFkwK0VIblJF?=
 =?utf-8?B?MHNFTlVpNGZsb0JoenVIZy9QcXpKSlBzYzJUa1d5K3ZwU01KelB6VGZhWnVu?=
 =?utf-8?B?eHI2RWo3NEVGYnk4MjVocGJKNDFINFM5VVN3ZHQ0WGF2VUJ3aEFXcCtsSnpI?=
 =?utf-8?Q?S3KJA2UYpotem?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEYrKzNvdkVBclpvSDVJYy96UTRwYVNVSDRMV2R5aE9aNDR0bWIyamZoTXZ6?=
 =?utf-8?B?R0pCSXlrZ0IwdjNjMlREMlRseC9NZldsdDZ2N3UyL2YyZFpoU01tdWJGYVAr?=
 =?utf-8?B?UDVRTnU5V0gzNXJnR05RU0lhcE4wZjBNNDdKZ0I2RjJYVFZRQlZUcXBMMkRM?=
 =?utf-8?B?bXl0dWVDLzFrR3ZOK3B1cWVyaDBkNmNWNlpoaWpJY1F2Mk9OQWh3dG9nTXlp?=
 =?utf-8?B?dWZwM21wRU5FUnlTV3dPVFNLUlBYK095WW1MUEZHUTRCK2hBUnJOQ2llTGI0?=
 =?utf-8?B?T2JKOENIT2UyOTZocm4xaGU3aktOQnNBV1hGTW00QmVhSkVzWVlOVTVzQWp1?=
 =?utf-8?B?YWovRjUySlc3c1I5b2tGTUwzdEFreFVMM0VOTWhJMkFZazU0Y1VVdEc2QWts?=
 =?utf-8?B?MnpHaEtWWkVqU1BKS0ZqOFZuT1UrWjIyS2RZT0NqSkhjTXRERnV1NWJwZ2VC?=
 =?utf-8?B?VkJ0RHFTc0hWVGJ1dmdEeURvdDFpd3ZCWGJ2blIyeStkczFSbzArYmJsRTFi?=
 =?utf-8?B?QmMzSmdFNXFwUGFjU09nVVMvbkJ1MC9kWEJyQTJmVjU2ZjZxcVBYdUJXaGdK?=
 =?utf-8?B?ZjJDTXAxME4zZ2doWHJJM1hrSUE2Ynl0TnRXMFJkNVVUVnVyYlV6UXhFNVB5?=
 =?utf-8?B?aW85ZnB1b1NFOS9nb0xTeEdaaUlucFNrV3NhSmhXWUJjaUtqb1NEZGxJdUp1?=
 =?utf-8?B?dW1iS3Y5MENpMWFqTjBIMGRwaTBRVUdEeitoZFovSFEyUXV1WjY0Qk9mVnl2?=
 =?utf-8?B?YTR5Q29GSFJmTElaT0wyVEtwZmdwYkVqVG05U3VySzlyVzNpSndad0JLcytr?=
 =?utf-8?B?cHhYcHRaU2VBZFJjVGR2VmVWbDRTZmJpSVU4Q2dhWVB4dGlSQlJIUHh0SHor?=
 =?utf-8?B?bllYTHdiWlFHOUdiRVFOV3c5MUVTVnJ6Z0VZTG9OQ3VpNU5OckpSL1A4Sndp?=
 =?utf-8?B?MWNiYWlaSWJiSWJkMEtZQ1hlUDh5NmlkemVsQnUrcTk0RFpLU3Z1OVU4aW1q?=
 =?utf-8?B?d3ZyV3FyY0tJa0xQeGQ1Qk0rUXkyRUpmU1MzeHozaXc2QkNmRlo4WEhtdytM?=
 =?utf-8?B?OWVoQzEyUXV0a2xkbFA4QU9OMWFVYjFra21Ka1o1Q3FCbW9kQmxKc1IrTkJM?=
 =?utf-8?B?VVhXOHI5Q3BEMlBCckFhV1VUZEF2Rk5Ic0tSNFF2Uk0wSkVzd25lME9CU1do?=
 =?utf-8?B?QWduWkgrUHREdFZkaU5aQ3p1SUF2ZXkxUnVZTHlIYllYZVNVYzZFbjEwVXgw?=
 =?utf-8?B?a0FyNk9nYmlFN0trL3JDUmp1NXJ0bnF5U3ExNHNzemNWRTA0NzFURFY3SkdB?=
 =?utf-8?B?NXk5S3dqbDRBb3hSbFo5R3doTnJmKzQ2c29RZWFNdlZvNVpERHFucURCRnQy?=
 =?utf-8?B?Um5QMXZPejlEVGF3bkQ4cExwTUpBa2t0TXBWMUNvb3FFd0I0ZDJpQW9qOEJi?=
 =?utf-8?B?QWpHbFg0Ym5nSVVsaVhKVGlKeVJIc055b2I2QTRqU3F1YkZxMzVuM3Mrb0tH?=
 =?utf-8?B?ZG91cmJEcGVqKzJCK1FoSldFOVM4NWVBbnBwV0tDZTljYWpVZUE0cE11SUIz?=
 =?utf-8?B?bVp3Y1hwT1NwZ1k4eWhrdnlVQk43RGlhc3RuajMvcm1ramdQMEl0M1JESXQ2?=
 =?utf-8?B?a202NnJSRksrTktISGVYL090Z25UbTFtQ2I5RDlRV1FxNS96dStoZHdPdFhp?=
 =?utf-8?B?RUdkNWl3anFNdFlVNlNOQVp6VjJpeVZqNnI3ZDhyUHBIb2RIOXU1em9DSGU5?=
 =?utf-8?B?R3NBSDFIL2k1WThUYnZ4azRrSnhGc09TVjNiWHRxcjBIY2tiSmJHbFJvK3ht?=
 =?utf-8?B?endyZ1pDb04rMXJlV0YreUlMdWVvdnhvcUxSc0ZLQUZuZk1iNC9uZWNzT0sw?=
 =?utf-8?B?SGZ0VkVaRVZIazRScTgvM0t0cllueFFDSlp6QlJjZWNLS2d1Zk8ra3hLamNt?=
 =?utf-8?B?RUlGVTE5TFM0anFGaVFManV3dVJZS0ZIOTNnMFdSQkVzYm54elJNMjMzUG4w?=
 =?utf-8?B?L0hJb05LOFRoZEFtaVJhU012WjdqK2svaWoxdmRMVnUwME5lOGpRalZET0Vs?=
 =?utf-8?B?RE5OU3VmMXA2eVE1ckJRbXpUbE1US01jRGJvUjZxZmNWVlN5UnI2YnBoU3JD?=
 =?utf-8?Q?ejfj9R8uJBG+YoNAT+VNPigVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839d9655-ebc2-4912-d388-08dd4432784d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:09:31.6927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7rJUJVJvJgMlRF+MXjjaJnnwbPwmSHHBxRLe4clAayvtvctH+I4ugMPbGZ/AHto
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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



On 1/20/25 14:33, Michal Simek wrote:
> The commit e05689242238 ("Kconfig: Change SYS_MALLOC_F_LEN default to
> 0x2000") already setup default values from board Kconfigs that's why no
> reason to duplicate it again.
> 
> Fixes: e05689242238 ("Kconfig: Change SYS_MALLOC_F_LEN default to 0x2000")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynq/Kconfig      | 3 ---
>   arch/arm/mach-zynqmp-r5/Kconfig | 3 ---
>   arch/arm/mach-zynqmp/Kconfig    | 3 ---
>   3 files changed, 9 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index 265e9ce588ad..376d1bc7131f 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -43,9 +43,6 @@ config SYS_VENDOR
>   config SYS_SOC
>   	default "zynq"
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x800
> -
>   config SYS_MALLOC_LEN
>   	default 0x1400000
>   
> diff --git a/arch/arm/mach-zynqmp-r5/Kconfig b/arch/arm/mach-zynqmp-r5/Kconfig
> index b2ba896e9b41..45d8c0535774 100644
> --- a/arch/arm/mach-zynqmp-r5/Kconfig
> +++ b/arch/arm/mach-zynqmp-r5/Kconfig
> @@ -19,7 +19,4 @@ config CPU_FREQ_HZ
>   	help
>   	  The value, in Hz, that the CPU clock is running at.
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x600
> -
>   endif
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index 92d61e84319d..151cfada4366 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -93,9 +93,6 @@ config SPL_ZYNQMP_DRAM_BANK2_LEN
>   	help
>   	  Size in bytes of the DRAM ECC bank2. A null size takes no action.
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x600
> -
>   config DEFINE_TCM_OCM_MMAP
>   	bool "Define TCM and OCM memory in MMU Table"
>   	default y if MP

Applied.
M
