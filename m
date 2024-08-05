Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CAFC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE28F88908;
	Mon,  5 Aug 2024 16:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A029dfVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDF388986; Mon,  5 Aug 2024 16:14:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC7C888E0
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9+h28TfCDJ4ahWcdRbMgS0mbjzEFmzrqN9v6NDadloVIKplEY/TCaKVjb62RcJFN6hIn0za4twrhW411thTdH9P6m2LeUuz/Tym+vtgXC9JLJuEJhAYo56q8WtukjTk1OrkeddjdsDVg+i7CvCxx3OXOC3ADkDoV2leIpasTVHHawiEBGhGqaHbt96tDyxl8c2YqoayKCk5jK20SWrWbBUU+JslCD0J/NrQ8bvqgvy/34e1/9b2IFx/EOWO5yZmRWe3J7hH+x91Eyy0YHRvyHxFi4KlN4Z9ftcHjEAZCzKj34bnMW0U5g5km/ujr1QrEQYs/7p0VWjEFQVqQKb+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STUBXYSGQvKz0K516Pih49+xIEbjwrwNNoEMa6zo/UM=;
 b=Ga3Wj0vsIMA0EcrvOwlVKwM///9mvlR/PpIfaoVqkiPcZz3NpoYE2lfUXdNGEMsNibY5g7Ro8J5Xrip2nwV6B2wuQAHNUSsMFm9DapEQ0rL9lkhFyQW9mLk42Xauut9n78XvkseHK9LAeKz2PAk/hdRf4o5N1F4Ggqfi/63aCCLNQgfRpLTzA/xWvJOjOmQqt/dHOFwWgfx/4Va+/dE/caoxX0PvF0wydh2637ShpSzvb3EpivjoZbrj8IHb/SURUlLtq8qmhGfaA5XZ2WRCnJpBlRFMFOwOlpWodSByW4LNTjnUtL6ujT+ge8I1mmYhOGoOzLJEM6Sdm5yXhLW6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STUBXYSGQvKz0K516Pih49+xIEbjwrwNNoEMa6zo/UM=;
 b=A029dfVbvsA3PyDrBt28HC3ZDmmrSfbeXxsvVlbWiMDJpbwMFD2EfHOxE8kLp13328TNfV7qpBMmNQyNy2y1CrGUbuni7E4JnHvAs++ZspP77IW1AUDzQ3jwQZG/BoYmTuDKPa5EEcKIEUNK4ZEoihw8yVE5cwGH4Q27fXL5log=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 14:14:29 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 14:14:29 +0000
Message-ID: <934141ba-8565-463e-adb0-93bbda9f975f@amd.com>
Date: Mon, 5 Aug 2024 16:14:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: zynqmp: Add support for zu1eg_lr device
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <12a939e2c88e82a9828852a8f7f33dfa14a6a4b8.1722351201.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <12a939e2c88e82a9828852a8f7f33dfa14a6a4b8.1722351201.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfb9e2b-2df3-452c-9299-08dcb558eb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWdSWXlzU05CS0FkWjNyZ3FhTit0RERkOHlPZUI5bjBuRDFzQ3ZsYnNISW5l?=
 =?utf-8?B?eFA4Q212ZWR0THhGOG81cDUweUU0TkpLNHRsaStGazFtOUQ3SnA5OVY2MWZ3?=
 =?utf-8?B?ODVYTkdCYTFBT0xUYXFla2VoTG41VzI1WWcyR0w5T2dEckRoZHNSN0NKWktr?=
 =?utf-8?B?djJJUXZlNmg1TlU3QTJCTXRDUTI2VEZqMFhWalJGb3VLT2lXYVBSRnl6RFRZ?=
 =?utf-8?B?ZlpqSzM0VzZNRjRMZmhIQ25YK2s4VmR5b1ovZnA0NjIvaTJzRmtvdHhaL3Na?=
 =?utf-8?B?cHVrSUxGaS82Y1U5b0hoNmtZQ1ppaVMra1ZWTDN0blY4OWZlMklmcnhvNTc5?=
 =?utf-8?B?K1Q2MXhhUUl5ZXZKdFYwTFJMQnorVjZVNjhvVW11Rko2N1FYTTh2V0RnT3U2?=
 =?utf-8?B?Z3dUcFhlb1ZhT251dGZSOVdvK0ZUNjFIMlJWL3ZqLzRMSXNoV015ckEzVUVv?=
 =?utf-8?B?bGpONkxiRDY4UmkyN1R6MFpISGNuemZhcVRraHl1SFVIZk5iOXpDcVcwaFBB?=
 =?utf-8?B?M1dJV0owOFQxbzZkK3JtdW5KUVZVWU5ZY2p0MUswN0RMRVFPdFY2US8vaVgz?=
 =?utf-8?B?N0tYTkZDVk1DS2hCd3BmcTJhaVdKTENrSWZzUExpbG1ma0U1YjRhT242eWJj?=
 =?utf-8?B?R09hMHQrTk5IRFpvVVlPY3dJSDIyWHp1eEJ0OFcrZDdvL2tVRjlNdWxrUlBW?=
 =?utf-8?B?OHY5aTR0dExpc3RGd1FDbWxsd3F5c1BTM3NHc2ZnTUZ4K0lRbFNkUFZ6WHdy?=
 =?utf-8?B?L1FoTlU0NGZnc3VoNnp4YmFLb09zdnZDZ2hWWmpKV2cxU24xZmlTWjRNUmZU?=
 =?utf-8?B?YUk0cjlZc25CNlh2aSs2TnJjcDgwRlNWQnFwMjUwVzU5RWJzcXVLT1hkd00w?=
 =?utf-8?B?T1IxdVd1MTBBckw3WHpub2dadTQ0YkdGdDQ0VjYyZjVSWVRkZ1NkUVNMaDZD?=
 =?utf-8?B?MWxUdG1PaWVUWncrY3pzaG95cDRlVWpVMzZESjJraWV6aXdJenc5dVcrUGpR?=
 =?utf-8?B?bk9uRU1GcjBsSTRNbXE4Ri9lTldZY0IvNXNKY1k5UWlQTi83dE9QcGtDdGM1?=
 =?utf-8?B?bThJTUExd21xejNwYi9sQUlkRml3MkRmMnFCZmF3bXVkWllWQ3FrdlNvOTI2?=
 =?utf-8?B?TXVhZ0g5QVJMd0s4NjVLajNXK0NjaFRjZUhLU1Via2xsTUZJSmF2MFJhZE5D?=
 =?utf-8?B?bm9UcHdmVHArYjRTR0hTYnpvd2lWMHdSNVRqd1ZLN3BjZ2pZVkZkQnZKSXBO?=
 =?utf-8?B?STBmQk1manhRRk9XNklhRk9MRlRnaEJSR2JTRTlGQ1FqSXk1QWVVV05Kc1F6?=
 =?utf-8?B?WW16bzNpR05FMWcrKzZqZlZrMUZaRnR3blhCOGtDVXFhT2MyM2tnSmdRYk1p?=
 =?utf-8?B?RkwwOXZBVk9heWI4UGZrd2JEdTZYOXdMMzNUUktWTkNKeTd6cVJqTVp2TDVm?=
 =?utf-8?B?QjNyRnJlM2xZSVQ1S01hU2N6VC9qbE5XbVJUV0Ribzc5eDZNTFdUSXdoMU9H?=
 =?utf-8?B?WTFhWHBUeEdhalVsNXZFNDlCcVBESUZuYTFmbFFTWlJSWURBb1NHYlNadUpH?=
 =?utf-8?B?K3JQeisvaHVSd041eHFoOFZ3aEd2OVhQSndnejBHa1B4eWZLNTdhYTdHOXoz?=
 =?utf-8?B?WWNwbXpRUE9PU2lYU0tsblE2THA3cGk4OHYycVVwYmYyWmQvamxjRzNyb0Zt?=
 =?utf-8?B?YlVDNDAvRWFza3RZOGlORWdkRmtnMXlSVC95ci9kWWVyR3FsUmJYNXk5OGda?=
 =?utf-8?B?dnlzUGoxR0J0N0VWUnJFWTBlNzZpeTJrQldnOUtGRi9wNVFvanc4Q1dFZ0dh?=
 =?utf-8?B?TzlpY2M3bGFsblM4d3RpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFrS2NodXk3ODloNU5Rc0RWdnpjZ0x4djVZTVoxKytXaGViSmRmUWI5NWtX?=
 =?utf-8?B?Y3czc1hkR2FncDMyME1WcGxraGQxeDkwejJjUmxEc1hUQjgrdjd5ZnNwV2Vs?=
 =?utf-8?B?V2V1eG1UK3ZpZTNMNHFPRmxFOWRkcnVHMTlqNk1RSldaZXhhSHpKUlNJN2xn?=
 =?utf-8?B?VTkzVXRHNGNoQmJnblBub25oZFNDTDc3NFE4VW5YMTFzS1lIZ3lFc2VEdFB4?=
 =?utf-8?B?dElRQkFMa1pPQTdwQjBWWEdvV1NJa0ZoL21FWWZ5WW4yQWVKTEhZNjlPNGI4?=
 =?utf-8?B?M3o4aG1ZcG9NbCtidjNFNTZNdFplZWFsTlg1emNDTmp4SzRiWitFeEc1anFp?=
 =?utf-8?B?R3RiaWZkN1pvNG9BdXkwNVFHSGxWSTh1WWd5MHF6Z3JKbzhVU3VBYk1jbnRE?=
 =?utf-8?B?Y2p0K0E5RysrdGc0YkpoTlJSWlVVQWI3OEI0SXpTUTlzcEk2akxLVWZQNk95?=
 =?utf-8?B?UDVKczJVdXVaTnhqa0pqYU5RVVZWV2xwS1N3aUdtK2hQUHJ0aWVYbER0OWxT?=
 =?utf-8?B?Qlp6WEhkdGFsT2ZGOUxoQ2VUaWdNWGdzc0hnTC9tTzRLZ2p4YjZidW8ydlNv?=
 =?utf-8?B?K3YyaVZVbWpBczhnbHdlblVibE1VWVNGa0cwaDFlSmozY3pwWVExcWgvc0lL?=
 =?utf-8?B?VlVNc0o3N29QS2tlWTJLcTlqemRZeTZOSy9qemJDaURsTUN3Rk5ydTMySmtR?=
 =?utf-8?B?RzZBR3RwYXBNZGhKVytZT1IwdENyR0FFVHpXZlFwSW9McjRVQnh0WitDc3RJ?=
 =?utf-8?B?dTkvL1NnYktCK0QxMWkyNXZ6OHI1ZGs4eUE0Y2hqZTNwUXlLS3pJUUFLS3o3?=
 =?utf-8?B?S09DYnhqUVJoVkdFRTdqYXBaZWM2ODFoR3BWM1lnWloxV05Gc3hzOTlZdGJl?=
 =?utf-8?B?cjFoZ0NPbnRyZmp6YTJxTmRWWEo1dzlYemFmbHVxZ1NRNFN5SDFRL3dyQXdQ?=
 =?utf-8?B?WFVzYmtIejlRUmVBUWIyb3RZSFlTWnJ4SjRFdzFVTXJoUXNvVHNwTXJkNFR3?=
 =?utf-8?B?OEUwVng0ZzlXNUoybStxUzZnU3A1bC9zSzBweGdkai9KaDR3T1MyUDEvRmZX?=
 =?utf-8?B?aWxkN3dmdzh0MDBNU3UzaWtPUFpvcjQ5ejF0ZUVmbXM5N3I0d3h3aUp6L3dh?=
 =?utf-8?B?VnplLzJZTE1lQTA2WUg2UDdJd3FBRUlmcGxyUG5LMzk4VnBkZXE1Mk9LeWI4?=
 =?utf-8?B?NEtLcG1Mc0Zxb1JpNzNHaG4rckVqSHRWYXJsSzl0YXlON0J6c096UzB0UDlG?=
 =?utf-8?B?a2xYVFdGZEl5SmZ4Sko3d2dXMy9kaTlhYkJJS1F6SitVNWJIdFc3Sm9jcThM?=
 =?utf-8?B?UUdLcFFDZ3plUmVtNTJsc3JNN25NOVpROXVobTRiZld4NG5XTzlmNGdHMGVx?=
 =?utf-8?B?MkJGRnlQOHQvT0V0TFJ5dFNybTY0ekZVMVZOL0pZaHI0OUgwWFY3cDk3ODJW?=
 =?utf-8?B?eEpVRi95alIyQys0dnVpYXVmS3RTUy93VGNTWXpGNXJySzFZeXBmY2dIMnU3?=
 =?utf-8?B?SEJkbUl2TnBKUk9jY3hoOXFTekc2SStFNXJCSS9reWFJS2xDZWprREVjb3V1?=
 =?utf-8?B?cVFDNkw2ZjM3YUxUakRLMmdNYWNlRHJ0UWpKNUZ5dnpFTURwQWhqMWs0RjV5?=
 =?utf-8?B?YlYrb1RPODJaL2ZpSGlZV0JvYXFSeWZDeFAwTWFhWlNYQVBLZkEwSkhxZHVk?=
 =?utf-8?B?OVNSVDA2Z1ZHeVhmSmdITWZiUnhHYXFqV0N5THd3YlRWVW5OTHo4ZnBzVUN1?=
 =?utf-8?B?dXFKajdOZWplKzZiK0tEcC8rL3Fkdzc0Q05IaWRaZi9Sc3c0WFVvSnBHZkNH?=
 =?utf-8?B?OU1CU2haSm1RR3lZeFR0dDQ4Nk45cEV4dTJsQzlOS1NTd1BFcHp3UytIcmxN?=
 =?utf-8?B?cGUzTTVwWUxtQkt4UmF6dnlKWlorc3I5M3dzUG16KzU1aGtuNHkvZVlpZmxs?=
 =?utf-8?B?andaeGdIUFNoRlJCcnVrcm1IUGFkQ05nSmJJaDlIUWRselROT2MwRzRkSVhu?=
 =?utf-8?B?dURwM3VRVndFT21SelZCa0VCcytuaHBhUm1CMFBvN0FuVTFRMW9RZW4xZDhM?=
 =?utf-8?B?SlhvbXg1NzM5NEpsdVVKMWphdFJaeEhBcEt3bmlSQmxzcVR2VE9pL0hMSk1T?=
 =?utf-8?Q?DA2u0ciLTZoc4ZY0TjFfpdIll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfb9e2b-2df3-452c-9299-08dcb558eb50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:14:29.1645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKjDxFq9l+2Zjvu0oZRysl1kVmzqjL4Ol2FfsyiehNlMcR62t1XTAzeOSn/R1SQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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



On 7/30/24 16:53, Michal Simek wrote:
> There is new chip coming which is using new _lr suffix that's why record it
> in the list to enable bitstream in bit format loading.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/soc/soc_xilinx_zynqmp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index a2d5b82fd34d..0c45c781fef4 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -44,6 +44,7 @@ enum {
>   	ZYNQMP_VARIANT_DR_SE = BIT(4),
>   	ZYNQMP_VARIANT_EG_SE = BIT(5),
>   	ZYNQMP_VARIANT_TEG = BIT(6),
> +	ZYNQMP_VARIANT_EG_LR = BIT(7),
>   };
>   
>   struct zynqmp_device {
> @@ -64,6 +65,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 1,
>   		.variants = ZYNQMP_VARIANT_EG,
>   	},
> +	{
> +		.id = 0x04689093,
> +		.device = 1,
> +		.variants = ZYNQMP_VARIANT_EG_LR,
> +	},
>   	{
>   		.id = 0x04711093,
>   		.device = 2,
> @@ -300,6 +306,8 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
>   		strlcat(priv->machine, "eg", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_EG_SE) {
>   		strlcat(priv->machine, "eg_SE", sizeof(priv->machine));
> +	} else if (device->variants & ZYNQMP_VARIANT_EG_LR) {
> +		strlcat(priv->machine, "eg_LR", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_DR) {
>   		strlcat(priv->machine, "dr", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {

Applied.
M
