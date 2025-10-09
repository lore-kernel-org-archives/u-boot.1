Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22C5CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 07:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6739B83A89;
	Thu,  9 Oct 2025 09:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cf7Htana";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F298D83A8D; Thu,  9 Oct 2025 09:09:01 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46ECA83966
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 09:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5xyGLAurcuLsC0vRppNPrHcvJfdlDmEX+6GN8B6+qNN5eI1CVkG9oIFpon7CM0VnQLb4tNXv1WqnMp+DQD2TxI4MDDRMHF9YLc0qDYkqqDxzhYGJ6QdrNk+28+opv9uEZJXdYqoQIUNp+kJ2uLQw2utbcOJalScaDHAp1p9TmaV7vEGlngsLOZfS/yephRsRSipES924W8sNNTeazNqDcM2ZbFEANVvc3IrmOIBShO7RBTS4p4uT+Fw66NtmpLsNfT2ufzCw6I4bJLljHLtW71O+rhb8eTdFnF6Zfp7HV2I0gbx2lln+dTf5k5+LdW4vzbZCwYtScNKRbpQvQvVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx9AHz4upNi0zbtIR5Z5PthCIBb04a5YKOt1TcmvTeI=;
 b=Eo+lUKAG8+5qzPgr6UL66HPmWcOBqq6CDm5TtfZs/H2axEHM25vHlBswkDERQyCFb3NZU+fs7M4RlVU269fr269ITK5CyBw76tK67tQi0Ph3xpqnNrzV2OZ5BSpNRiLbhzwDDkTG2Wf3voHaN8B6xymqxGWNfYQR74D/A05uQVLTbzW6W7sq7L1i7IZ8WYDGxKecE2aBmlopTKkYU8BHmqGMFpWni3cxjQlfcqnni3MPmGAPc7EmNKXePU13KmaayJOtxqvvGF2bv7sa2plJA0B2qs3ysLrY4m+oJ725jz6rER8NIhiAbeMC5tI+6YFXn8lae4teaa249ZigUiuasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx9AHz4upNi0zbtIR5Z5PthCIBb04a5YKOt1TcmvTeI=;
 b=Cf7HtanaFphkKdpbd/ROSslxRhK5684Qng8O1TIPdeAeRe28hsl9e8TRh6uGuxsvhdUojxzj6Dyv/0+P1y7FFlTOtkd+X4j6Jxpa5U5IQjCiW2Ru0vdDQvekZAiUIWkQ8kYpSkMl/iGXr5BdZmNwmT+SD5HcGOt4zeoTrQZXPhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 07:08:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 07:08:54 +0000
Message-ID: <97f5a7dd-e913-4800-a8ad-9c414a1e383b@amd.com>
Date: Thu, 9 Oct 2025 09:08:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xilinx: mbv: Remove redundancy in MB-V defconfigs
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <585f96d85b656803bd382ac25425d68998f24ed5.1759393175.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <585f96d85b656803bd382ac25425d68998f24ed5.1759393175.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: a32805f6-ed12-4fae-826f-08de0702b51d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkhKUGVDc1dQZGNzSHZmdDltYkdYbGxPZk1CSm5oRzM0Y2J5OGJSWnVJeTdO?=
 =?utf-8?B?TjdJTysxUHIzaGc1WWUwZUxxVnVIb3FyZXNDTHo5UzkrY29qSFJLakpFN1pB?=
 =?utf-8?B?WmlFd0FsM0JYblhnbWtxVUJvT054eXhjQWErQVVHWjFrZkJNMmd2YmpiQk9R?=
 =?utf-8?B?elpSaGEya0xINnY2YWhDY2NQL3dlTnR5NmpFRWtFa2pRMXJTbUdNWlRUYk1O?=
 =?utf-8?B?cDJDS3BOdFB1RnBzeTJYVU5ZcGJIdFo2c2prcjF6YnE3d2I2MFhhQUMydW5a?=
 =?utf-8?B?SE5aelBVUnhqR2R6M01UcS9kRnhQS2w0QU82UUNmN2lWL3lFRFJucGkrYytO?=
 =?utf-8?B?a2JuT1JSZFR0WmxuUzZuenlmUHMxTFFZRGhXakZxRCtGYmIxNytEQU5SWWN0?=
 =?utf-8?B?T0paanVpVkdPKzVBbFVlRUVCUUFWWlc1aE1RdXNYdVE4bkU1aElzTCt4WkpQ?=
 =?utf-8?B?MG5mT0ZxWmxwQ1FUNUNOM3FxUjNqTmNkNFZsWXh6WHV4OVBmQ2NIYjRBQzRm?=
 =?utf-8?B?MHdNaFFkK3BEOXB4akd6d0JjS2V1d3ZUbmo2S2JaVzN3TUF5WUljeG9GNlV5?=
 =?utf-8?B?eHJsdVpKdm55Nko0RjVNYlV5OVVGVU9sN0phRUxlTXptOThZdFdNbDVpcEVl?=
 =?utf-8?B?VXRxSEM5clVnQVQ0MnFYVmtIUWZidkdHVFpkU3VsSUJQb3FwblRCMUZwbVZZ?=
 =?utf-8?B?M29LUXptdXN0MFZwYzgrWEFMWURNL0Q3eVhiQS81bms1VDFSUzYwaTRaTXR5?=
 =?utf-8?B?TXpLaTBweUZmOWxtUWhBeUpvcUtRRmxtSVk3VjFEYjg0UDdwMldXbnBPU1lH?=
 =?utf-8?B?QnAyTXlZZjBaQ0NPakd6cjdoUC9kL0ZtUWZCK2dCeGVpSlBBSUtvTkcrWmQ5?=
 =?utf-8?B?cjdlbXBTQm8xOEV6K0Yvci90S3R1Y2JTZzZObTlGZWpVdGJ6dWI1KytLYUhW?=
 =?utf-8?B?TkdROTZhWGxnNU5Dak81aVRLalcvV0djSTg0K0d5Mk9peTlPWjlXWmIwVTJP?=
 =?utf-8?B?Q0lSWkFuYmlnLzcxRFVrZEJSd2drNUR4R1hxWm5EZW1MVjY1eit0ZGYxWm8v?=
 =?utf-8?B?Z2FXMGNuOGJhb2ZGM2FsOGQ4b245aUpYMmg0eU03YWhrREplRi9vYkxCV2ZU?=
 =?utf-8?B?SStRSFBKN3U3QS92U1k1enZXSHBZRmxOajI0Nmh5VlFCNWVFVzFnUHpiUFdK?=
 =?utf-8?B?U2hGNlNyMmZLV2VyZXdvRm1nNVY2U3VlbjBnQ3g3NlFNbGF4eWhhNkYxd1NL?=
 =?utf-8?B?OWEzTEE3Szh6NDRPTCtNQnkrRWZGeFBvRjRIdlJER2hzSEpGTlByNVlORFZR?=
 =?utf-8?B?cmxISklGc2Jla2lWMXNTemsvNWMweVpmd3QyYjdpMC9DK0UvSTRIQ3N6M25l?=
 =?utf-8?B?TVU3MXVnK1JvREU2TVkwSmZDTUFUMFZ2NjJndG1DZkRwWGkzQ0NOU2tTeW44?=
 =?utf-8?B?TThXeGJweHF5Z01uaTlqM3JsS0JGUEdXQkpJVWRxR1pMbVpYaUJvYzlIb2VL?=
 =?utf-8?B?UUNrOHppTzZsanBQNzlSWXpVT00zVUwrbkFvSjZvQWtUc243TWJDakkyUzAr?=
 =?utf-8?B?MllZTlFEQ2l6Z29sTm8vNHJRcU1XMmtXZnJHYWR3bU9zdXJxV0hIUmFnYURj?=
 =?utf-8?B?QkJBTFhYUzZxbkZpNnBkVktQNEFvVXliUE1MVDVvc2FLODQ0WkxGMmZrYlJB?=
 =?utf-8?B?alNYY0h1M2RoeE9JQ3hLS1NTMytFM0ErVk00S3JqbmRBWDZVOTYweDlhelAy?=
 =?utf-8?B?VjJ0UUcxdUtOcUhYcFRUa29VOWxLQk1ZaVBrdnJxVSs4amJ5QlBHUjRiOXVC?=
 =?utf-8?B?Qi9HbWZ3d2dGbWhHVHE5TUVXSW4yNWZObnlIeER6OHVibERiRlFramdJazND?=
 =?utf-8?B?L0orTG11ek9xeFZlcWdRQ0l3bGh1NStacldXWVdIU3dGUjQ3NXRSTjRMcDY2?=
 =?utf-8?Q?c0DOEM7woWE3ao0xRgDJNrbd3Gisa+v5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhTTkptYm5wTXNsMWJZRkE1L1hXM0xvSEdwQ3o5ZFhFZno3MnFVdjI3Q1VM?=
 =?utf-8?B?OERXTy9WbXVPUWozNkw5M3ZHdGZxMWlJUlRHMmVzaDJ2K256YTUrbVdKKzg5?=
 =?utf-8?B?b3ErbmMxWjYrakhlR0dtYWNWa2JlWEFtU3V0Tzc4ZzZlL2RJYnc1cHh3VmZY?=
 =?utf-8?B?RDJiazRVcDVUenJvSk5vaHp4cFZndGVlTHVpYU1qRWcvNXYwVmpXMlcwUXgw?=
 =?utf-8?B?TWh4VjF1WkFId1FBUk1ybTN2SmErcGNZdENYN0o4Tzc3Q1lRWmhzS2dzbHhP?=
 =?utf-8?B?NEZRUnlMVlNEMjFmYlVveGw2Ly9mcU5qeUFveGdVbk00L3FHbEZJVVdtRStx?=
 =?utf-8?B?RmgzakRtTFNRcEg1eWUxdm4xRy9MOUtnVzNFMkxvMmpjR3NCdk1xbG9TbDBS?=
 =?utf-8?B?NnROZ1ZJTDB3THRCTlMxZHRFd2ZLRmMyT1pTdWNiUkxHalVDMWJVaFFYQjFr?=
 =?utf-8?B?eXM4YVVxSUduVERoNE5GQnlUL1JZNmlSZ2NhOUVKcmh1Si91Mm5XOXFoclY1?=
 =?utf-8?B?ZWYzd2F4cTkvZkJCMnJYb2ZlUlk3TWV2c2xFQUE2MzRxOURxTmJHYWY5VnZL?=
 =?utf-8?B?bUpnTTU0L29EWmN5NGxWUFpIVTBuWXBPNXZHb3psd0E5UVBydU9ia0RHN2hj?=
 =?utf-8?B?dnBkTDNiaUVzeFNxeTV5b3E2TnpaTXBCczBQK2pzN0M2MVlKSjRDaktvSEVF?=
 =?utf-8?B?eDhQZW5CbU9sT1UveEpueXNIanNKV2MrSjNTTHI4aFNqa1crR3BrZTF0SFcv?=
 =?utf-8?B?YkxIQTIvWjNsYzZGcnkyZnphU0FmMEoyVGlENXF3Z0tsOURUSFpnaWJJSzUy?=
 =?utf-8?B?Q3g5NkpIZUdBc2hmRFZBSEVrTC9GdVk0SkdLSHFpWWNXTFJtNVVzQThrcmVB?=
 =?utf-8?B?Tk1uU0lzQkNqbDRQN0JDcWFLZ3JBRm1PbHBNSk0zTjJ5djBnNFQ3OWlTWU5I?=
 =?utf-8?B?SDdtbjVBc1pJcjJ1cEdRQk1FY0ZqdTk1RGhRRmlrdXQ2WmNUMXZ2ZGRjMTUx?=
 =?utf-8?B?WDRINkkrdWw5T20rdFR0NDJzb2N4MWd6d1E3bmZlMy9Yd0t3K0c1aGJreEph?=
 =?utf-8?B?a01tSGo5d0huT2NtMXhiWitid0dUVFQ2TnlhM2JIL2ZRd0ZDVHYwem1KazNV?=
 =?utf-8?B?TTM1RTExUXk0THZwa0NsNHA1MWEvNVpEL1BHS29rZ0tsZkhoTWxaSStpSUQ3?=
 =?utf-8?B?ZWs5aXBxTEsydWh0bDJBZlAxQlNKN0xmWWJwcWlublJKMk9uMHB1a1cyV0Ez?=
 =?utf-8?B?eEhycHVtQmg4QitIZS9oRHVXYk1ra3hpd3BpVTV6OStqL1RCUHF1ZGF1NjZ0?=
 =?utf-8?B?alZ4bEYwaTVtQkNNMEhRY0dVbTI3VzJCYWd3TUM1TS9yYmFEU0R3UWg0Yld3?=
 =?utf-8?B?amZpUy9IQjFXaUtLbVF5OGF3MXAvdzRPWDJGTlc5YnRoS3dmMklyN0g3U1JK?=
 =?utf-8?B?TFBVM003NlBRMVFYOHFsK0ZqLzdWMmxpNU9yb0YwVEM4RlY1T256SHAxQ1Jt?=
 =?utf-8?B?QWY3Mk5UUnpXcWczSWNJMWVDMk1JcHBFeENEUzhQdUMySnJvWGVtZXBSTmJy?=
 =?utf-8?B?bzBaM3NVWHk5L3lyYmgvVk5JSFlzTW5CVDJNWVpyWmVpNzJ1TXRWWW5hd0dS?=
 =?utf-8?B?VWlPSjN2TjhiK1M3aGhBNXNMWG5nREdPaCtsTDdUeGhMWTVmRmoxQ2Rtejdr?=
 =?utf-8?B?N2RuSnZYVVJJVDhMdjR1MUpISmtqMi9SZmV5T3ZMd1NnR3M3TDdYRzRDT1g4?=
 =?utf-8?B?OUV0RUVoQ0ZPNWx5aGFxamlKeml3cnppR3ZVU0R1Nmd1ZFZQU0djVWx3bmxK?=
 =?utf-8?B?SVRKY09HVGExVVp6ZTdjZVZjaUJSb2g2NkN0YlZOZjlodDdSekxkN0xVQUxI?=
 =?utf-8?B?MU4xWkVhN0g2cHFnMHdlUHRUeFFLeEIvajJxRnhSQW9QbkVqanZ1VTlaYk1K?=
 =?utf-8?B?Zy9YYWFuQjEzUCs0WWkzUHVaNThTNkR3cnNncVNETnhJdS85eEhici81ZmJM?=
 =?utf-8?B?dkM4L0NqaWJ4VjlHMUIrZ0ZhT1RFMXBYR1k5d1pncFA5b05tdW1PS081QUR4?=
 =?utf-8?B?bUpYWnRDekRmL1UwdHQydDY2dEVjMEpOMllpQlhkU0UwMndyM3NSUWpOcWdE?=
 =?utf-8?Q?VaL6N9o5ivsbIaCxJv9cmTQ/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32805f6-ed12-4fae-826f-08de0702b51d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 07:08:54.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x30cxcCMyD3bndiseSimeL/Tdyhb/bnZoWyf9fzF8F7uEU8h6JMTweLT6aG/rGq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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



On 10/2/25 10:19, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Removes redundant configuration options from MB-V platform defconfigs
> targeting both modes. Common settings are now placed in
> xilinx_mbv32_defconfig, which is included via the #include <configs/...>.
> This approach centralizes configuration management, reduces duplication,
> and makes future maintenance easier.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - new patch in series
> 
>   configs/xilinx_mbv32_smode_defconfig | 49 ++-------------------------
>   configs/xilinx_mbv64_defconfig       | 47 ++------------------------
>   configs/xilinx_mbv64_smode_defconfig | 50 ++--------------------------
>   3 files changed, 6 insertions(+), 140 deletions(-)
> 
> diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
> index c95b44973952..dd1221a6904f 100644
> --- a/configs/xilinx_mbv32_smode_defconfig
> +++ b/configs/xilinx_mbv32_smode_defconfig
> @@ -1,50 +1,5 @@
> -CONFIG_RISCV=y
> -CONFIG_SYS_MALLOC_LEN=0xe00000
> -CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
> -CONFIG_ENV_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
> -CONFIG_SPL_STACK=0x80200000
> -CONFIG_SPL_BSS_START_ADDR=0x84000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x80000
> -CONFIG_SYS_BOOTM_LEN=0x800000
> -CONFIG_SYS_LOAD_ADDR=0x80200000
> -CONFIG_SPL_SIZE_LIMIT=0x40000
> -CONFIG_SPL=y
> -CONFIG_DEBUG_UART_BASE=0x40600000
> -CONFIG_DEBUG_UART_CLOCK=1000000
> -CONFIG_SYS_CLK_FREQ=100000000
> -CONFIG_BOOT_SCRIPT_OFFSET=0x0
> -CONFIG_TARGET_XILINX_MBV=y
> +#include <configs/xilinx_mbv32_defconfig>
> +
>   CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
>   CONFIG_RISCV_SMODE=y
> -# CONFIG_SPL_SMP is not set
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_DISPLAY_CPUINFO=y
> -CONFIG_DISPLAY_BOARDINFO=y
> -# CONFIG_BOARD_INIT is not set
> -# CONFIG_BOARD_LATE_INIT is not set
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
> -# CONFIG_CMD_MII is not set
> -CONFIG_CMD_TIMER=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_DM_MTD=y
> -CONFIG_DEBUG_UART_UARTLITE=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
> -CONFIG_XILINX_UARTLITE=y
> -# CONFIG_RISCV_TIMER is not set
> -CONFIG_XILINX_TIMER=y
> -# CONFIG_BINMAN_FDT is not set
> -CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_GZIP=y
> diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
> index a3cc1a5669e5..27d674fc34fb 100644
> --- a/configs/xilinx_mbv64_defconfig
> +++ b/configs/xilinx_mbv64_defconfig
> @@ -1,47 +1,4 @@
> -CONFIG_RISCV=y
> -CONFIG_SYS_MALLOC_LEN=0xe00000
> -CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
> -CONFIG_ENV_SIZE=0x20000
> +#include <configs/xilinx_mbv32_defconfig>
> +
>   CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
> -CONFIG_SPL_STACK=0x80200000
> -CONFIG_SPL_BSS_START_ADDR=0x84000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x80000
> -CONFIG_SYS_BOOTM_LEN=0x800000
> -CONFIG_SYS_LOAD_ADDR=0x80200000
> -CONFIG_SPL_SIZE_LIMIT=0x40000
> -CONFIG_SPL=y
> -CONFIG_DEBUG_UART_BASE=0x40600000
> -CONFIG_DEBUG_UART_CLOCK=100000000
> -CONFIG_SYS_CLK_FREQ=100000000
> -CONFIG_BOOT_SCRIPT_OFFSET=0x0
> -CONFIG_DEBUG_UART=y
> -CONFIG_TARGET_XILINX_MBV=y
>   CONFIG_ARCH_RV64I=y
> -# CONFIG_SPL_SMP is not set
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_DISPLAY_CPUINFO=y
> -CONFIG_DISPLAY_BOARDINFO=y
> -# CONFIG_BOARD_INIT is not set
> -# CONFIG_BOARD_LATE_INIT is not set
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
> -# CONFIG_CMD_MII is not set
> -CONFIG_CMD_TIMER=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_DM_MTD=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
> -CONFIG_XILINX_UARTLITE=y
> -CONFIG_XILINX_TIMER=y
> -# CONFIG_BINMAN_FDT is not set
> -CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_GZIP=y
> diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
> index 3d49670c60c4..56bf0bdc7e4f 100644
> --- a/configs/xilinx_mbv64_smode_defconfig
> +++ b/configs/xilinx_mbv64_smode_defconfig
> @@ -1,51 +1,5 @@
> -CONFIG_RISCV=y
> -CONFIG_SYS_MALLOC_LEN=0xe00000
> -CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
> -CONFIG_ENV_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
> -CONFIG_SPL_STACK=0x80200000
> -CONFIG_SPL_BSS_START_ADDR=0x84000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x80000
> -CONFIG_SYS_BOOTM_LEN=0x800000
> -CONFIG_SYS_LOAD_ADDR=0x80200000
> -CONFIG_SPL_SIZE_LIMIT=0x40000
> -CONFIG_SPL=y
> -CONFIG_DEBUG_UART_BASE=0x40600000
> -CONFIG_DEBUG_UART_CLOCK=1000000
> -CONFIG_SYS_CLK_FREQ=100000000
> -CONFIG_BOOT_SCRIPT_OFFSET=0x0
> -CONFIG_TARGET_XILINX_MBV=y
> +#include <configs/xilinx_mbv64_defconfig>
> +
>   CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
> -CONFIG_ARCH_RV64I=y
>   CONFIG_RISCV_SMODE=y
> -# CONFIG_SPL_SMP is not set
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_DISPLAY_CPUINFO=y
> -CONFIG_DISPLAY_BOARDINFO=y
> -# CONFIG_BOARD_INIT is not set
> -# CONFIG_BOARD_LATE_INIT is not set
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
> -# CONFIG_CMD_MII is not set
> -CONFIG_CMD_TIMER=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_DM_MTD=y
> -CONFIG_DEBUG_UART_UARTLITE=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
> -CONFIG_XILINX_UARTLITE=y
> -# CONFIG_RISCV_TIMER is not set
> -CONFIG_XILINX_TIMER=y
> -# CONFIG_BINMAN_FDT is not set
> -CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_GZIP=y

Applied.
M
