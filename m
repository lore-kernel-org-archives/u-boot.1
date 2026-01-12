Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB467D2505E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6229983CBD;
	Mon, 12 Jan 2026 10:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zz5ue3Ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6541383D17; Mon, 12 Jan 2026 10:32:07 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5042183CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKfMNxyOHaLl7t5NS3vdFpm81Iss2Nfo36hWeIDMA+COymZDkU+I2oikv1jUwLITlrzdRb/wgWMxL+n3q9ngGL651+68ZFJVLwq1eILG+2rODHXWuLsKwd5fTm8Esl+03oMUlgULFK9LFUJZazZNkisRi8sMCCFHcmpTrTGwla66qESi4eCUT+rZov9NNOF89txH5l80lxlMEHefpjjP1W7yfe7nDHm/QJT7Fc01MvZrg6MlnE/sohlVICgDXxLaTNSvkqpGVvEzCR7CAC8/rMJjGdBwsF1wwpbASDkfDlxe/jpn32VYB2Xoppjyu6+gMpNl9GCcpskusQ4amTlKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gPC9BZMCBTMJc9HJSs50AX5LhRsy4OHz/ObDqRHN8o=;
 b=DYCCyJj/TZn3lwIUNTTKxcKb3oP+aHRcbTfVrKCmr5znpF6Ydmz5fFrFD73n8NXiUnprRvjyIfoCu8SyOWYsyX6giUQMuVbSgZnDP4OdVQq2tnIRIlK7yEioMPnNDTqjarj0DaJZT0BipTz6PAb9mOEuJHbOC/a9zp1M9ueOXqOJ8wn4HvlJdb2rdAI2a34OKQ78hC5z5RviZdmY2mgATlwsFybpPE4HuFDRvp8AOwtiyZu5P9FLq1ZFqdfqfLBBRsvwIzVASBdDzPZumAppihlGIfpKxy3G05EmFPabiQbSLTy8a5e7IKJEM98WHMqmsE08cpj9bidDCqjHDH17Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gPC9BZMCBTMJc9HJSs50AX5LhRsy4OHz/ObDqRHN8o=;
 b=Zz5ue3EwiHci5gEE0nRn52AmXGmTZ2xbkOQrtNwcYAAPlKFbR+EPEg5bA7je5eRFaN+UU3rjYtH/LYi2hy0w278dAhq87WVeqVm6CTKLlzw7SKN0kFC5I9/h4tNuCY6VFb7iTxlpr0/obm7pXzVMeCvGijS9sgAcTNA21r99MFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:32:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:32:00 +0000
Message-ID: <2951c9a9-c9eb-4ae6-93e7-21e0c1dd62f1@amd.com>
Date: Mon, 12 Jan 2026 10:31:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Align distro boot variables with default
 memory map
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <988a6f38ed9cfbb9757b76a16cb9cfec4601de85.1767685538.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <988a6f38ed9cfbb9757b76a16cb9cfec4601de85.1767685538.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8e8fb3-c798-404e-6092-08de51bd7049
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmdYMEQwdVVnRkh0N0dwb3VDQW5nb1JKMXhySmd6OWYzaDZENTV6Vm5DRlhM?=
 =?utf-8?B?OFdrUXAvT0JkK0dhcmV0TU51cVl5b0lsV1B2M3AyL0FsdGxkY0VnWDladDk1?=
 =?utf-8?B?T2pGbVJWMXAvNkVHTFpQYmlhZzIwS2pBTm1uNWdMWUh0RDhDenorY2duSVdR?=
 =?utf-8?B?cjhzb3RaTVl4eFR3dGlONHh6VjNCQkxIeUpmWUhhZUk1U0RZL0RIc3dVeTV4?=
 =?utf-8?B?VE9DMlgxZzZkU2lDZWpIbGhVT3BieGhkMzFNcVNCbDlFb2tIZEZCelpWS1R0?=
 =?utf-8?B?UlFrNUNXMkRXc0FNQlkySkJXd3VndTF4YUhnR3U2NHBtSWRwNkt5aFlDVGVk?=
 =?utf-8?B?L2lVL3h3Y3B6aENyUW1wYUVCcGV3UHhlbU0vaUhUZG5XbE9HWFk3dW1ZRTZj?=
 =?utf-8?B?dmxWd2NSb0Nqc0tZNStZc0VXWjA0ckU1d0c1cGFQSlJGOC9LNWNlYk83RDlh?=
 =?utf-8?B?WVFydjlMTGp0Q0VNUmVWNlhMNWM4eTlPdEY2QnNpZ2FPUnVkYTJJaGlWc09U?=
 =?utf-8?B?RXA3M3d5UnRYUXFwa2dLekRVVTU5bHpPbEdOMi80cEtMVzlKNWI5UGtUWXFs?=
 =?utf-8?B?VTlJbGtOTVkwdXpxZzZMZE5hUmhTYUkxQVQrZlFWSWxsbmxtazBYSUUyTXBh?=
 =?utf-8?B?RlRpdFN4akFXdVBmRkJJZHhXVHpId2dTbFhlTVFJTzI5cmNzR0tvV3Rma1pM?=
 =?utf-8?B?aXUxd0VyZVROMTM3L3I2b1I4ZUg0TERGcHgzK2QzTTdIeEU4VVVwem5jYTBC?=
 =?utf-8?B?SklMZ1NMU0tzaTVqbmxjM1c2elE0YUEzN2Fldjg5L1F5d0ZBVm5sTzJ5aWE1?=
 =?utf-8?B?TDkwYklrR2l2QkJIMDMxUFZ0THNFWjIxNUFxZGVYbUhJVC9YMnB0YjJqenc1?=
 =?utf-8?B?QThXYzVlS1YyTlhXSTlZVWdDbHZhMzduSlJIUVY1S3NaN1QvTTRTeVRnTmt2?=
 =?utf-8?B?dFBZNXl0U0kyREY5YVpsUWtzYXFOdXZwd1RLc0Y1ZWRheUpUMUs4SVVDelE4?=
 =?utf-8?B?Ym12OUhISXU4bDdpejdnVHdOVEh5UzNsdHdjRlJDQVNiNHc2SklDK1JQVnRn?=
 =?utf-8?B?eVhlQ2t3YXJTUzBuSkVzUEpSRWxDaVB6V0E0a1JZYnB4NFVONXZuWTJGcW9i?=
 =?utf-8?B?ZWhOYXdJYmhiaitVWGZyQ01wcStNdXFJUm10WVl4MWRKQ1dxZUgzWkM2M293?=
 =?utf-8?B?NmtMNDZGM0tqZHRCSzRTM0ROUnZObU9sNm9sbGVFV3QwejhnRHZRQndRcVYz?=
 =?utf-8?B?aUd6dzlLREQxZXVnQi84d0lBVDFlNVdqRjhYZUxsamJaVGhvN0NtLzNHY213?=
 =?utf-8?B?cjhGRWcwWWczR205WTR1WVVMZXcxbkR0VDlyTDgzK3ZoNFdLSDNmZlBMaHU0?=
 =?utf-8?B?MVZxdHdwRkhhYi9pYndGeHg2bDFIeU55bW0xSUZ4OThYRW5IdXRtaVBibUhW?=
 =?utf-8?B?WEk5YzVKa2Y3dTRpS1kwenpUSFl2N2l2MGVwOEpaOVB3Nms4cjlsam5TNGhX?=
 =?utf-8?B?RTd5dlZ2SXRNczkxVmdTaGcxTVdhZnFnN0lOSDNQa2swV3lCY2dlS1VBUkJF?=
 =?utf-8?B?dDBNSTFoZ0k4ZnplZno4bXlIRjdDd3EyU01sQjdFcHo0cFc0YkIrT1VHbWJr?=
 =?utf-8?B?OXJNY1M0THFlYXJqWGVwZFcxaWdkRkg5aGlCck1wdUJiamVTYThOQlhIWGZF?=
 =?utf-8?B?c0wzYm81Yk9BQk1FOWdpajgrTGt1Qk5QVmNPQnBzWDNBR0pkTDdZVTVYaEIr?=
 =?utf-8?B?aFAwUSt5VE5yaDdGZ0wzVlpuUVZDbkxYbHNTZDEzUCtCSW9zcWhBRHlrKzZD?=
 =?utf-8?B?c04vWVliNDkzN2pXL2JnNm9PblRzUnBuS05jSENaaitqbjBHVWZSR3FzVFh3?=
 =?utf-8?B?YnNmVUJmSjFabk1CQ2tJbHZ1cFdOekx5dVJDVDhPTXROK0tGbUNYeFNLUXZF?=
 =?utf-8?Q?RfC/gqLRgwsyOD++Iu2So7wexBVFwOWk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRucVJZZmlXTGJDMjc1MjlOS1IrNVh2OVFjdVFGYTFUNUJLVUhxQVRGTUxy?=
 =?utf-8?B?Mkw3dkNVejRJdjR6cVlLc1lONjNON0RqMjZ4dTEyMHd4cy9Mc2lGK1hWeWcx?=
 =?utf-8?B?NEtMdG9lM1RjZGpOamd0dWpoSk5QaTJka0JtY1Mya0FpSDBCMnl2Q01xVmdR?=
 =?utf-8?B?TW5KZzhLY1JaaWpwSUFIVXhzUWVFeVhVWmRybkMzTVZJNG94UldtSys2WFA0?=
 =?utf-8?B?WHppRWsrbXlZT0JtWVcxWDFKM3VvazFhb1dvaWM4ZUdyVTFTYlJFUjZuZHNJ?=
 =?utf-8?B?Y2ZNNmZCcHROMGV3QU00NjFFZXFoMkpoV2tNMzNDbjR1V3pmN3N0azdBRUho?=
 =?utf-8?B?bWdZcDZmOHE0NmNQbEV0cmhaaDlnTjdRL1RHaTVUY3pXTE5Kb0Q5WGJmSitp?=
 =?utf-8?B?cmRmY1VmaFBESE8xanFYYWFDZkMxM1BPY0J1ayt4cm9DREtQaEFjRkkwaStP?=
 =?utf-8?B?RjFJMjRQOFZJY3BpQk9FVjQ2K1h2N25kZXF2RVF3Vysvd1QycGFqOEU1bThI?=
 =?utf-8?B?WmY5RWsvL3RJTk41a3VNa3o2NWxsZFlBWnVya3BFMDR4RGtlTGpGL1FacVF5?=
 =?utf-8?B?elBIeEFrL1Vob0lTdVp1TDltVTdPLzRGTUpVeDRrRGlzVWdnSVdOR3poV0c1?=
 =?utf-8?B?RWJ6M3dPVDNhTVlQbWNLUEVOaWsvNk9OdjJCSVVOVnZDdlFRN3FrNGZBMXpO?=
 =?utf-8?B?MXV4WlNPQVM1Z3JOLzgxVmtoVFlOZzcrQzR2ZE9vNnc5N0dTSTJhelIvekNH?=
 =?utf-8?B?bVFOMXExWFNHbWFVcDlkdTF0aFhUd2h3Ync3TndTT2VLWkF2aVhhZHU4M0tC?=
 =?utf-8?B?d3RqbUlidVYvRlBDcE9QdTZaUHlQZmZMWjJkMzkybmtRbTlyNjBTTGNYT2Rp?=
 =?utf-8?B?Mm43cWsyelpMMHhUSEI4dTVieVpJQVRoMGJrbmVSVTBoS2tBc2p6WFZqVDdU?=
 =?utf-8?B?dkt4M0NTcDIycDNHUWFwVlBUV3RzT2k2dnBIeEVKUG9UTFlJNlYzWCtaSDFw?=
 =?utf-8?B?M2szOTd6MnN1TGc1bUFIU3lBVlBRem5FYkYya0F0T2JmcmUxNjEwbUdCNnRW?=
 =?utf-8?B?dytHWUhXd0NKTGVtVWxYMlRGY2tqMmREK2pmeGVmQXZPSHpCRjFneXdwUkxn?=
 =?utf-8?B?NndOcnJJOUw2MmVES2cwWGNoSXZFL2JvK1J6T0tQTmN5R0MrYzdBT2JTek1V?=
 =?utf-8?B?WXoxNWUwSE5GM1RNK29ORXIyYjBPM0VTMmJCLzFPUXNqeW1BTUcwSGxHeVlk?=
 =?utf-8?B?bkpzUGpQNjI1OWRhZUVuS0FERDJoSW5CWkE0bGJVZWd0Uk9yOVlsdUFzWDhv?=
 =?utf-8?B?STRFUjJpU3RzbThKaWhnTzJibjlDemdWQ3dYS1E5L0xQTDhpcHBBMkVTNytS?=
 =?utf-8?B?aUl1eENmOW1tbWk3NVN5UzZ0SmxWY3hRVUxyVUtaNDBUM0JBYWRXdHFqZ1hG?=
 =?utf-8?B?aVgrQ0g4NFNFQmRXK2JHK3pBUWlpZVFtS3FLQlo4RUhtYVZzbm1HNjR2V2Qw?=
 =?utf-8?B?MjJNMVFVYk1ma0tXWXNtbXI1aDJibWZ0bkIxTFFKa2VpNkxlQW4wWVhTWHJh?=
 =?utf-8?B?UGVoK3JBdVZPa3RBSzM1elZ1NDFpTCsyNWZkaU56cXBqY1BaU3B0Rlo4S2k4?=
 =?utf-8?B?UW9CMjlBc1N3S1lqZkdxaGcxdi9RNUFVd1NRdXg2K3FuV01HUjlxc3FQTkpj?=
 =?utf-8?B?Z1NqVWdZeGZsbUppbGhTMmFzQnNaS3VPSmtBS0p1dEx4S2UxNEtvN2xXZnpY?=
 =?utf-8?B?cnp1WlZqMW95QzAyYVREbjRMSUs1WjloT0c3WmpVYzVLK1dLWkdhRHJNa2FC?=
 =?utf-8?B?VDg1VHRhaVVGS3pIaVE1MTVIMHB6U3RiN01IRkNOdURFbnNUTFQ4Q3duOUYy?=
 =?utf-8?B?WFllalc4c2VLaFhVWWNSMW5OalJ0WjhYTjJDMEg2U0FvQjNjbjArNkFISm82?=
 =?utf-8?B?RHVMTzhXVVRDVlUvK1d5UjFoL3YrOUQ2K1UxbmZDK0ZlWmpva3JsTnBaeHFt?=
 =?utf-8?B?RDBZQWlnWXlzbis2SnlRZ3k0Y2wyYnNzREdUNUNjRzBQWmNqWlBrQUdYOUZY?=
 =?utf-8?B?SDk3L25tVnRuSzhsWHo3aTcxVlFuaU5DQXhTaTR1SFlYWmp2L1krdUs5SnVm?=
 =?utf-8?B?ZDAxdjJQeVRyUFliUGZtcjQvOWhpQlJYTUp6QkdnYVpEMkRJN1Q3K2JjT1Q4?=
 =?utf-8?B?bXlaQnQ4NzFRT1ZqbXF6dWcxNUZrS3YwV2Y1ODBibFF1dmxaTWkzNWZ5aXlF?=
 =?utf-8?B?Z240VjJMS3FCV3ljZFVoR3VCNkdrNlJTMmFXNTNISXFOR1RZLzNLdXVzQmNG?=
 =?utf-8?B?NUc3MXFBZTVRSHNpQjB5aE9zV21GOWN0RlVOMWRYVTlQNUVGRnRZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8e8fb3-c798-404e-6092-08de51bd7049
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:32:00.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yo5I5uVpTTIJdqc6iBdkSNp7xqIiBcoYlXUBnwu/1xlszPIFbpX+U0Qc9EA6rXDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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



On 1/6/26 08:45, Michal Simek wrote:
> By default Versal Gen 2 is using memory map where TF-A is placed to DDR and
> there is also some space allocated for OP-TEE that's why move default
> variable setting out of this location to avoid using it when distro boot is
> used for booting.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/amd_versal2.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
> index f1c432aa391a..05ddd4eabe16 100644
> --- a/include/configs/amd_versal2.h
> +++ b/include/configs/amd_versal2.h
> @@ -49,12 +49,12 @@
>   #define ENV_MEM_LAYOUT_SETTINGS \
>   	"fdt_addr_r=0x40000000\0" \
>   	"fdt_size_r=0x400000\0" \
> -	"pxefile_addr_r=0x10000000\0" \
> -	"kernel_addr_r=0x18000000\0" \
> +	"pxefile_addr_r=0x70000000\0" \
> +	"kernel_addr_r=0x48000000\0" \
>   	"kernel_size_r=0x10000000\0" \
> -	"kernel_comp_addr_r=0x30000000\0" \
> +	"kernel_comp_addr_r=0x50000000\0" \
>   	"kernel_comp_size=0x3C00000\0" \
> -	"ramdisk_addr_r=0x02100000\0" \
> +	"ramdisk_addr_r=0x60000000\0" \
>   	"script_size_f=0x80000\0"
>   
>   #if defined(CONFIG_DISTRO_DEFAULTS)

Applied.
M
