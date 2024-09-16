Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFED7C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 11:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B633788D08;
	Mon, 16 Sep 2024 13:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ajpQShhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B0888D35; Mon, 16 Sep 2024 13:50:02 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62CD88C78
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 13:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEhUuZicOwymq1ry54m3TXXz3Fv7QyDo4XIUz0InzGpsdnM9YDQTE985AfZGQjkVim/o1F2nNCKCkjLYBAY73LlrwvUcth1NhwFgT4reGbAmed27ahnZ+bc97nANYBoxhgjNsqcn7y3rEtqWLVs0HBKk3iRVcN4UFuSkp73mIHRFAvXF5M9ebCregQxvMS32L30ezeCVpezbUVcbcBLZh5GfRoXsIBIjJuLTELZYU+awpKaH7zQipsYU6IHE6lR64b/o2srcT6PoHdP9+C3e4M2hbMdRk7B+W8Xw0+L5yCRGFt0NZMDcwH09/9IJqfeTNOxIF3uqALASVSW9Ebqiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCDOpeT/9ICmGkSjx4XLLcy8kWGvokyjjNXWm+Rhu4A=;
 b=fU830CdHHcNByhTKIyXjx4ZuEgMaTauxtKO85e4V8nsIkiDfzZ6QdhVj4zpMyRz7KPf5ZT25tt9uyliozmn7cL5zgg90vL+rUBGfNlY3bcE46zLNwnUIe+ikGRCxnaSrTwhRNmghqiRiSqL0GiqH49mE9SvTpkqhd0d16oEhe79IPuaM3stt80PBz9miBCWMBOgotL/Qa+7rINKBhxlQxzNPxsbV/JkudCfnle/vvg6d+O2ycYCVS27pNfGZSQaPFWrGOVBHeIw5wtAsKxIyeJhVPoY3AX2eV2nQLs3RIYfwKY3J3F+eMvInHn8gdxYXody026NnMFolIPj30TiupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCDOpeT/9ICmGkSjx4XLLcy8kWGvokyjjNXWm+Rhu4A=;
 b=ajpQShhiRGTpmOAvkrLmqTmtL6cD0dZQ90TAqEFPfGfbtxhgrKRWykPPnCueNo5QipEA8R/6HGtbD5N3TgRZ4dapnsa3H7XrCtvgWnNhE24x3qFpt/l3wOCckAO6EZuYhQBU/+ww7SVGjPHZ8+YwnSlSfbg7z6aIU0bdLb/17PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 11:49:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 11:49:54 +0000
Message-ID: <a9c8526f-c00e-429b-8db1-daa189a27065@amd.com>
Date: Mon, 16 Sep 2024 13:49:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Add bootmenu support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
 <CAFLszTh3ew6fiZF3pyaV+6Pz+3BAy-LrLfnQizF=U0C--_DVZA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTh3ew6fiZF3pyaV+6Pz+3BAy-LrLfnQizF=U0C--_DVZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfd484e-2bfa-4d4a-e7f0-08dcd645add1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXptYmlTMHA4M0hXUW9yQ2VBbGZTZEZMMElDMm4wM2plTFMycWk3ckxWTXE5?=
 =?utf-8?B?VDVwVUs3WjRkek8zOHpvZVpCaEY2QW9nSW1KVVMxSmhFK2ZlTGVMVFBjRU9k?=
 =?utf-8?B?QWczbFNxb2ZpbXZDUjl6dUdzRnAxY24xbVN1R1BoVS9NWDlzNnNFM2MzM0VH?=
 =?utf-8?B?cFdNT3pyWDU3RFBOQW0zWjhmMnJaemdnaTM4N0V3RitsVGdmMDRIcFBDeDU3?=
 =?utf-8?B?VVFqTXJWcVYwQ01uSUgzZEl5L2lHcmtoakhEeC85R1VFRFpDU2lkZ1J5SWNj?=
 =?utf-8?B?czgyb1RVWFFTNUVESUQ5ZzVaM3FmbU9GN0Q0ZVhtWGJjZUljWEhMZHg3ak9y?=
 =?utf-8?B?UW1YamR6SXBmYmxSRFNyK3JSdHpib3RHelh3Y3pjYTRaUmYvWWlRNEhPd29D?=
 =?utf-8?B?ZDRvdGpTUmM4RXNxdFRxWFl0L2h2WjlFMzlXM1NtTjhQT1JtR2JOcE1jd3ZL?=
 =?utf-8?B?ZlI5QVJuRDBYeXNEU1c5ZWp5VWVXUE5HejhzZnpvQ0pZYjB0M2pDaWFZM1ZU?=
 =?utf-8?B?VzJTTFhoMkVYUXVpbWRmN2syTVYxbXdTc0I1ejFVZ3NHM1dPUGJ6aE5TK2ZX?=
 =?utf-8?B?ZXFwa090RWwyRWV4NytRWWxJb3FuUVdqZW5OR2dMNVVWZmN4U3hIWUwvbVVY?=
 =?utf-8?B?Nzg5aXhWdjh4ZVpZSFluK0lkdVlPMHdOZ3NkR21yY0lzZjN1RnpHZU85WjhF?=
 =?utf-8?B?M3N2aytSU3A1QTU5NVhHdmFxcFNkTnRQUGZGK20vSXUwTDczeElLdnA2bzV3?=
 =?utf-8?B?eUtuYmpVTDJOSkNLMTlGeWNrNGJzbDVxUkNaR0hoOC9vV2hCNE5rdVJGQWZh?=
 =?utf-8?B?K0FTaHhvYlIySXNLbjRZM0trWUk4VTdkdUVOOGY2OUNPUytPUUR0SnU0akJG?=
 =?utf-8?B?UVdvMmdlcWJzUHZHRTk0UzJtUjY2ak43dmVROHNMbC9IMHI0NGhHNThHczhM?=
 =?utf-8?B?VTJENXpoQk4yS2loYmdMSFhxTit1U2o0Z093Q0pWbUZScFFtNTVFWlRmZ0NB?=
 =?utf-8?B?MHhwOTROaXRubUdXUWZsZVJXY1lZQVF5Rm13QjU3eDNoa2NrNVFySHM2UkVp?=
 =?utf-8?B?enZ1b01EaHZXcXcxSkxTNGFleEJnbE4vbDFVRU9XanpLUzNLMkZnVjZ3RHdo?=
 =?utf-8?B?WXdnYm95WTN5U1lpeW1CaFU1NStwNFU0UTlEQmJrdlByVDlUUVE5ajBEcEdF?=
 =?utf-8?B?U1VGNkNaekd1M2tyN2tnSEpnaGFkSUcxelBpRDNna0pUZWgrR2xuL0Fuc1Ra?=
 =?utf-8?B?MWJNbEJGam8zVyt3U2ZPMTIwdnVvem8wbDJsb1BhSTBZb0J3bk9HbjEzTnIx?=
 =?utf-8?B?L1RwWkwyRENMVlp1NFpQUkpJQzYwd3NOMzY1Zm0vTUl6eENJQUpuTUZWL1NY?=
 =?utf-8?B?WFRuMHYyeVFvMksyY2VvelVwSGxwZEQxSVY3R01wVmxVZjdTVUt4cTUyd0FV?=
 =?utf-8?B?THliUHZhZzNGYlh1NjRIMWdtUjYzT0EvZktNNitXN2lJelpJNGljdEdLeEth?=
 =?utf-8?B?NUV6ZTVFOE5Kc3prUjMyNnpQQUpjWWJ5cC9PNXc4Uk5PUXFyeE8rSTZDUktG?=
 =?utf-8?B?RDh6aTRUQ2RRVU1YVnJHZGJzVmdyRXZpcjRpalBYMWttc1Q3SU1yNm8rOGM3?=
 =?utf-8?B?NkFXMm50UFl3Z0lsT0dmb2NMVHlnTElvOFJDK251amNSNGxXL1doajQ4bWlO?=
 =?utf-8?B?dGNJNG05cTJWSjBDbnRPTWVscXVjNnZJaHBaTnc0aXEvY0FQWHNNdDdEdFQ1?=
 =?utf-8?B?WkpISCtjZEZjaENXVzBkak5vdCtqVCtwS0lqUDVSdnNMMkx5NVBrMkJxWFk1?=
 =?utf-8?B?OXRPSy9WVFBCdXdiWE1xQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFZxcDgxeHBMSXRSaGhxNWR2TlBqczlHU1dhZFA5QW1NOEx0bjcrRFh5V0k5?=
 =?utf-8?B?eU5lNi8zMFRJUkNKdFVnQk00VmthdW5PdTVFZytUd3lQRlBOTXZWTTZqeWJE?=
 =?utf-8?B?ZTJiOWoyN1FDaUd5Um5jTVBld1EzRlpFamhBRFkvT3dnblBwQXNWUXdseURs?=
 =?utf-8?B?dFVRYkU0SkZHL0hvSzRDMFcvNmYvR1hGREd6YWp4WXFNdkg4U0N5ZEFqZ29o?=
 =?utf-8?B?Q3RheTAwc3kzemFpWHZUaDl3cXdYTlVCRnhSNFc2WCtqeFowcFh1OHJ5S1VC?=
 =?utf-8?B?dGVtUGhwSnRXa1VXRHJDdDZIV1BkMFNtUFdsMko3dFJYcExXNkNyVnJyaGFj?=
 =?utf-8?B?OXZ2V0krSmNYU013alRCeWliRm1uR3NRYlYrUVZ6MmpMVE9YZzNlN3ZtalJa?=
 =?utf-8?B?QnQrUDc2RjBrb0FaVU1iVk1WeFRKVE1YeEtGZW90SVpTeERTWFVaaS9QL0tS?=
 =?utf-8?B?elJIeVVFTjdKVUFTVWtKbHFzSkk2aHBEWnZDVUVHZEJiOUpvQzkvRDJFSHhQ?=
 =?utf-8?B?cjJFMlhKSy93V3JnSTcyUFhubW5FdnB0VDAwM3VnTWtmYVhxWGRTclMvQ0E5?=
 =?utf-8?B?VWZTSHpTUWxKVmg5aUVxVUlUcy9oYWxYNWhOSnZFQmE2ejczUkxLMmp6MEhG?=
 =?utf-8?B?c3VUUDNtZG5aaTIyZFVJMGNLV2V5b09wZHhLQUhwUnc5ZFUrTGJoYnJFVUJn?=
 =?utf-8?B?VHBJb2lhOU4zUlJyZ2k5M3pYbTd6ekJReWZlbDRCTzVUN0hYRkFURENpNFk1?=
 =?utf-8?B?TXZiR2Z6VFYrOGM4bE00L0h5ZmNiTExyZkp1bUc2NFpFRm5nMGl2TllVa1Z6?=
 =?utf-8?B?MENMOHdPUngydGVteXArdGZHZXdqK1phQmdxRWw2NU1ya0VtV3c4aTNQS2pB?=
 =?utf-8?B?eE1TY1YwTEQ4MHUyeTlURkRMRlFrT01PQ3dwWXB1aGtCUWNxbEQ0YkdhNEZ3?=
 =?utf-8?B?bFNrSmtWUEJYQkw1aitSbFcwdkRpSUhmV0pqUTRoVXdiRkFsUTlucThmY3lT?=
 =?utf-8?B?VWJOMmZ0Si9vKzM0anFMRzNrOWNBMVpZNVEzaEgyRVo4c01vRkdWU2ZrenBk?=
 =?utf-8?B?VHY1NGdYSXFtTFRuVEFlTEk0a2N2U0tCbHJiQk1tVlFJMFVRa2ZZQXVJWnNp?=
 =?utf-8?B?RXZpVmVsK0NxQy8yTEZJOXdoNnZ1M284d1J1MGtUVG5SQ3FRWXRWRXZsTzZ6?=
 =?utf-8?B?dXZ2VmJDaVc4aXlsWExLVjVGcFdjT2ZwS0dwNm1aaFEvL09Uejl2T3lwajdS?=
 =?utf-8?B?RkRTZEFLOXFhdXRGVWpTVExINlNOUmZMMU5HV0dPVm5wb0l4d3JGZTRFbmNq?=
 =?utf-8?B?bm01aitEajhwRHlXZFIvNDJ2d0puQWVob3MraTNiOGdnbWFVQ09HMFh1R0RL?=
 =?utf-8?B?VzE1b0dhVngyejU5YXJWUFJFa2hpRVlIcVpKZHBpb3plZElCb3dWQ2hXTVNi?=
 =?utf-8?B?N2JhRkJ4Z1dqc0YyLzNQUzVTOUZJcEpqaS8zbUFZU2JVem96dlprTVcvMWFp?=
 =?utf-8?B?TUlpeGt4OUV5ZjR2b3RRWithb1BQQy9VSlVHZkdPODMyaEgzc3JwMTJvcWFu?=
 =?utf-8?B?Y2lWRndrY3Y5cFpMYi9XaE15ZnVvSTJCekVsN1VmcUdoeFcvU2kxbDkybWxI?=
 =?utf-8?B?cEdHN1Fyd3RzSTVUMVdiSWh4L3lpNUtLdUMxV0FlbFJUVkk0OEorWDRUK2RE?=
 =?utf-8?B?WTI2b05WWWhQRiszbEVRbTFUckNXcjJhOUN2eVBVWkJhMDFXc1ArTFNhenJ3?=
 =?utf-8?B?YStYT2E3VTFDcjluMkQ0TVdCMm5ENXprY3p1WHpzWW9YRUNQbGZGa3orb1BH?=
 =?utf-8?B?NzArb1ZLb2RGY1JYTy80c0lUWEFyV3Z5VVdpSDFiZ0gxWis1aDNQMHNzSVNl?=
 =?utf-8?B?MzBFV3M1ZG1KSzNjRU4rdHpCcFlZZ0t3SHpXVEVQaXl6UDhzUkhzTityeE5I?=
 =?utf-8?B?SjZGL3I1eDQyVS8zSC8zYXNyVTN2cXBXVGpHQjdpVE9yL1MvcGZWalNNUVp1?=
 =?utf-8?B?RGM5RzIwOCtMZmVFZmlHRzJ4NGFnZVlXQWNCeUg1QUh6ZnN2S1lhYm8yUXRX?=
 =?utf-8?B?bUhWQ050SjF0blVIeG1meW5xRlhBOVQ4OGhVVjBxdDl5bGpDMHMxR0lYVmUy?=
 =?utf-8?Q?iOJtX1y0m9UPKTJoKmjeyrwTv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfd484e-2bfa-4d4a-e7f0-08dcd645add1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 11:49:53.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtPFjFpFUb5dh1FDbyJSdRtapfatLgHcW14NW6OpQD4Ja2VnPeTnmNyQyR4FKQVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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



On 9/12/24 03:00, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 11 Sept 2024 at 02:04, Michal Simek <michal.simek@amd.com> wrote:
>>
>> From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
>>
>> Popup the bootmenu for 5 sec with default boot options to CC on AMD CCs and
>> default to SOM on others.
>> Users can anytime disable the bootmenu by setting the variable
>> enable_bootmenu=0 in zynqmp_kria.env or setup it up at run time and save
>> variables to NV memory.
>>
>> The patch is also fixing issue created by commit 4c7363068651 ("cmd:
>> setexpr: fix no matching string in gsub return empty value") which has
>> changed return value from setexpr command (Before this commit when
>> matching string wasn't found command return 1 that's why was possible to
>> use with if).
>>
>> Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   board/xilinx/zynqmp/zynqmp_kria.env | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Can this use standard boot? For example 'bootflow scan -lb mmc' ?

We didn't switch to it yet.


>>
>> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
>> index 49ef3e7d7532..d0e431ebb46f 100644
>> --- a/board/xilinx/zynqmp/zynqmp_kria.env
>> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
>> @@ -49,9 +49,19 @@ usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
>>   som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; fi;"
>>   som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
>>
>> +# To disable bootmenu set enable_bootmenu=0
>> +enable_bootmenu=1
>> +check_cc_for_default_boot=if test ${card1_name} = SCK-KV-G || test ${card1_name} = SCK-KR-G || test ${card1_name} = SCK-KD-G; then setenv bootmenu_default 1; else setenv bootmenu_default 0; fi
>> +som_bootmenu=if test ${enable_bootmenu} = 1; then run check_cc_for_default_boot; bootmenu; else run som_mmc_boot; fi
>> +
>>   k26_starter=SMK-K26-XCL2G
>>   k24_starter=SMK-K24-XCL2G
>> -bootcmd=setenv model $board_name && if setexpr model gsub .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then run som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
>> +bootcmd=setenv model $board_name; setexpr model gsub ".*${k24_starter}.*" starter; setexpr model gsub ".*${k26_starter}.*" starter; if test ${model} = "starter"; then run som_cc_boot; else run som_bootmenu; fi
>> +
>> +# Boot menu
>> +bootmenu_0=eMMC Boot=run som_mmc_boot
>> +bootmenu_1=SD Boot=run som_cc_boot
> 
> Would bootstd find these automatically?

It will add them as targets but without specifying which mmc controller is SD 
and which one is EMMC.

I pretty much think that we should look what would be the best way to move to 
bootflows and how to do scan for some devices. Because I can't see support for 
NAND, JTAG(ram) and also dfu/thor.

Thanks,
Michal

