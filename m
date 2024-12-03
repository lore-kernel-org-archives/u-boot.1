Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D414E64AA3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E747088E35;
	Tue,  3 Dec 2024 14:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VHIZzDDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C586881E7; Tue,  3 Dec 2024 14:45:03 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43A488E35
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPBsn7ydpbEOrq2SVzV7ennbGqKimMOZMZml0mo8OaDTWW9ycMThJUhTKoJ4dOYsh88HJWO67Mo2PVW9sq85rxCRE2TUtOnougkp7ny3m5hy5HZDAH2AdLBVKDXMspXE2wynEfSMLocvqsX9N40NqvsVQh8AJB93ofYM69Pimy5qpKytnuQyslk4yxhKypNF49XSGTJhCTYrE4CE9iXY/XfqOpvR8LjIPDmsonVGz11nUjKVwgMeMJfstrvXWk4KE8yEYVZ1rWY4JeFI3+El8/4CqYKpeGgqI44X7R1ldh1B+C7yuveUpFquHsHt+CB7VXWJlAI3SB5whAds2Lzo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w240PtpmS7RCBSs8O1P8w9dI2ICUZTDlFqZklWUMdmc=;
 b=TQtlAzBnZ3hbdvGCB8huSM4A4fIK/vfVfI/zmjst7n9nK0Wq1qd7r+qim+XrfbgR4hC8eK01BY1GlUgTs8/SDXjjjpxiCplVaRjlng8AEvXZrAal3FrnLSTwQ+3eRWtDfAy/tEvWbqMrkppRfcj+orvCWRZAoaRLKDNwDLp5d3Rnfq0uCT34h8rabxP43LrlEe6VYdhmzg5t1cKKebczRCiWAFCtOciI0AP8BmP5uJAEL+OGbmlRCDecdbmP5yVXJ33bQl1rUg/R0w5ls8VmkdLPizlceux+CpX1QmJuDwZ8wGRiq1uqTilHHs7eMkchEnvqI9htee/mU9LgtMBeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w240PtpmS7RCBSs8O1P8w9dI2ICUZTDlFqZklWUMdmc=;
 b=VHIZzDDAEttAoFLCDlnegau4oi5ZfanURO9A1XEBIZW+Nqw8fAAXCI/zc1vSYFrCIIGjdqkZ0L47Px5dL+jlHheh+kfWPl8QWbIT8FFwMZHctkFr9/Nck3Ys3agCFmbVbs6JHdMAYp7CnIt7dz22iHrx+0yVUNxNTUgPeQHETYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 13:44:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 13:44:50 +0000
Message-ID: <d1abaa7c-cf34-457a-9b5b-f665b0fa4790@amd.com>
Date: Tue, 3 Dec 2024 14:44:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: marex@denx.de, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: f420e939-49ab-458d-6195-08dd13a0a8c4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEJqbUhSUGw0N2Joc1F5WU4rTFhJaU9OY0t2Ry9aOXB5L3Z6TTE5RGVnckFQ?=
 =?utf-8?B?SVJ4SDg1RGlyZXlFTHBEaUs1Q0FDS0Zka0Uwb1RiaUZJeHF0Vk1RTnRSSFFT?=
 =?utf-8?B?SjVOanVlYnhZVXAyWmtQN01vckg0S2FYRld4M3lZZHRmekFTN2paV3VKbVQ0?=
 =?utf-8?B?ZisyaWFNb0xwSEwrYzBSczVsRm5URmFzZTBjYkFhNnZDOVczTlM0QTUwazRC?=
 =?utf-8?B?NktWbVE4Y0JXS0FwSTV0RDB4UGxEMHk0VWhGVERqSDBGSHp6SEY4QVBmcVcw?=
 =?utf-8?B?K1VrNjdpNCtMK0diUlFKdEVhOWwrNkVEdGxkRFZuemRUNWl5SXFDMTdqQ2x1?=
 =?utf-8?B?VHM1VElPY1lVUzJFNmpLUytpQWF2SzJGSGQwczNlM0x5TVNLbjRIajQ0OXRh?=
 =?utf-8?B?ODhyZ2dDVHpYYTQvUVAwcm5KZjZvaTNoYjk2RU84KzczalRVR1JFYW51M0Rv?=
 =?utf-8?B?VWk4OHhrN2tLQm16MkRFRTE2Z0Q3VlM3MmpiTkVseUJPTkVER1N5eDFYRWJl?=
 =?utf-8?B?aWhtMzBKUldHaFNDOXFZNERRTkw3UUxuVDBQUmo4UlJtZTB2TFRxazNVZ2Nj?=
 =?utf-8?B?OG84Z0JneVVVYlVKVW9CVUtRTTBxelJoWUNZM2RtMGJCcGxOWE5NbnV3b2ZI?=
 =?utf-8?B?SElSSSszOXNKZlZFbitJTUxsYUl5ZGNFNEhBVkZLbGgyVG9VZFdZZGs3MkdO?=
 =?utf-8?B?YUxTOGZGR2dXMG9KVHczeVZXZUovWVNHc0hxTDZNRUZZSlZMTTBPSW9EOUp0?=
 =?utf-8?B?Z0lZUEtTZlFFaHVmc3R3Q0p4RFVqQzBFYlBLUTdNY0lpVW1yS0QzanpEVjB1?=
 =?utf-8?B?OW9hRktVeHpEbmtRaEJNMGkzYVJmZUcwWWRFam94YTQvR3NGRHRCUlUyQnpV?=
 =?utf-8?B?bWswaFpEVlhXeTY3ZlM2TFNYNjVPZnhoWGYwSHB1ZmdjVE1vWEhhTkNPWk02?=
 =?utf-8?B?TGxteXpvLzhyTFFCM0ZGU3lZVEVJMG1lUDVWUHVHOXVraGQva014ODl0M2F3?=
 =?utf-8?B?RUhGSzBWbHgrd1R0S3NGOTRVUVJxOTJZTkpidWJkVmhnUkE5WjQ0K0FzUlRv?=
 =?utf-8?B?aENGelJLMlNOUnNOWkFPMEhWU0dlZVlPdkZVSFJxZUdub1dQTHJmdnU1eGdt?=
 =?utf-8?B?OHppUzd4VTF0RVhEWXBzYWxxUGRhNFlRUjlka1UxNU1NTHYxNDRteFpwVkVn?=
 =?utf-8?B?WjhDc2lLTTU0b3JHM0VmQk05L0hLODVpZS9BYUhJakY1em5Tem9ZY21sRFBx?=
 =?utf-8?B?VGVKaW5qdUF1VE5Va1M4SjFGYkhTUGRHWGRBSGFMRVJDY3NmL055WnkwdXNv?=
 =?utf-8?B?ekJaYVR6RExacmRCTndOWDB0QnQxM0IrMlF0VEdzeVpOWnNzemhsSFFITndM?=
 =?utf-8?B?bHVHeGt3TVdFTHZSN1lhdmFraEc3WjVNWGx6cEo3cVZFUzQzVXcvRHc1QVVo?=
 =?utf-8?B?cnFFc2cxM3Z0TGUzbXZRdEpNSEJNL0hDVy9KNmNhTDAxVmhKMHJoNG5vanF1?=
 =?utf-8?B?cm1oY3B0SVhQRzNUTTJNUmxxVmJVZ1phN2t2TTRodW04SWdFdzJYckpvV2tu?=
 =?utf-8?B?R1ZkTjFXVXlnZUw5RzMveEpqdmVNbHlleEd4RzlEVVhTRVY4Rk53R2JGWCtk?=
 =?utf-8?B?REludU5aNU5aSXc4RDF0TktwRDNRbzBBK2JpWTFDSW9UUTAzTkhSRGhXbS94?=
 =?utf-8?B?YWlQWW9yZFptcC9CSFR4dEY3VHdieFhWNkNKTzJKeG9tNHdsRFEyWHZtWmRX?=
 =?utf-8?B?VGQvMjNRczJhdGNseEtRSU85Z0l1SGVCV05OSUVqMWNOb2ZVa3h0TEVHajJk?=
 =?utf-8?B?VzI5RWdZS3dUKzNienhXQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmREcEJiQjBVcE9WRUsrM0dvamMvMlJpWTVwM2hoNlJXUnczRzQ0R1QwaTRX?=
 =?utf-8?B?cFdLT2FYSjR1TnpDU2IycXhXVnpuTHJqTjlWSm4vNlJLellhOVVwcmNMWXFL?=
 =?utf-8?B?NHo5NFk3VFFkYzhRcUlzNUJ4dXpqYTliSUVYQkE0VllTUjBOeEdlZU0yK21K?=
 =?utf-8?B?Q01NZThGYWJRdHJBZjZCcmN1czBJbGx3cU0vbElFbUxkQXNVSm5QVWZEOUpG?=
 =?utf-8?B?QjF5ZFAyRkc5ODJXeTV4Q3NtWWhNZVNGVkM2V0lTRng4Y0NaK05jcEdZemdr?=
 =?utf-8?B?YjQ2d01taThnOHFXb1VPZDExTXJNSVY4WDJuU1BkZEF0MEdxN3E2bDY0a1Z2?=
 =?utf-8?B?Z0FWSzFqaEc5bUZWQzVqNmp0TTBqMzRIWWJFbStENmQzMHA0TG12Z3ZQUEZp?=
 =?utf-8?B?bmlxZTU1Q3J4c2UvWWRId2VSbFNFWDJkVlQ3RnlFcy9LZllXMnpxeW1BMW4x?=
 =?utf-8?B?Ump6cC9ZN1RGS1F4TDdPM1llMkh4cDZwNyt2WWpKMlVYZ3UrL2hTdDBvNVVT?=
 =?utf-8?B?V1BSNWF3ZjBzaHRkTURLODV5Nld4SWFYdWJCKzNCc1IvZ0JwdFJmdjVacG12?=
 =?utf-8?B?bTM1RENKbkJpZ0x4VFR3VVpjbmZ6MmtlVEQ3ZEpPekQvcC9QMnZ1SUdjcU0r?=
 =?utf-8?B?ZTNUNnRBN3NJaWdoS1FtSGhKOU5weVZVaFhOVG9Qeml4dzF1YVcvNUcwS1Fk?=
 =?utf-8?B?VnRkWmgvbUlWcFNjdVJFQ3hXNFhXbzF5eWhHQWpIVk5WV3YxQ05XL1B5dW9q?=
 =?utf-8?B?MEZidUtYQmNjaXovZ05rQy9nbmxCa1FSVGJPWWVJVGkxVHNDWTFsS0wrSUxt?=
 =?utf-8?B?NDlHWnB4QzlUbWtDQ2V2dFgwdC9VYWRabE5HbXczNDgxNWRQV0NrSExpTEtO?=
 =?utf-8?B?WFVjckpRQlc3cFF2RnRTSDMxelduWGV0TXJqcUEvOWpJL3NOQThPV3ZKdG9x?=
 =?utf-8?B?TjRTeHJpV011dWZ2TmhaVzZOTCtzZXh0WGVlNzVGdVBzTkhCN0wyRStzU3ZO?=
 =?utf-8?B?eEIrWlJBQkQvVVRoa2VKUEdJektjNHp1NlV2M3Fvc1VrMThrS3VpcFBYdFY2?=
 =?utf-8?B?V0YxazU1UWV2QmMxYnFSQllBck1FbkMxcVRiT1VjWm9YdkZhM3krc3hCeVlz?=
 =?utf-8?B?RUZWRElzWG1Sa0JEY1hYTkd4S1QrVTRSbDRpTVMwVDQ1MWh0SDJmQVUwTmw2?=
 =?utf-8?B?QnZzbFVUN25wbng0SGIrcXVpNHQzZHRidnFoZlB5OEswelRRWXJtdnFCSCtW?=
 =?utf-8?B?S3g0dFFTYVh0b1hSQmlrZkIzdGNsQS83SzREZ25xVi9uY1VMVW5HSG9jVXVv?=
 =?utf-8?B?MUZwN1dFVnJuK05jL05zYkdWMGRVcFVINzhVdmJvaFpMcm5oRnQyUzJJSVJz?=
 =?utf-8?B?eEhTYnNKQjZMZTV6Z0E3QWdQT3Q1Y1krK1FvWTRyUlZ2SWlwMkZzRldvalJp?=
 =?utf-8?B?OUE0UndXb1VNL25SMDFMc2tXYklsNnFSTGtXb3I5V1YzL2UraFJUQTlFZW1t?=
 =?utf-8?B?cCs4aWxMLzROb3ZPREswQ1JQcVNXUzkrTHNVZGpGdUhIMVloS2RocHA3dko1?=
 =?utf-8?B?NFJSK21iV2JQbkNCeGJzb2cvdHFxbDhIRmNjZkFUQ2ZWWkx5Z0J1OVpoeWo2?=
 =?utf-8?B?S0JwNWxxTjdzejRyTko0ZjJWdnlXU3cwTWpGL2ZvaVJoOVVqaDZJUi8ySVU3?=
 =?utf-8?B?UUUrOU5ZcXlQcjl5UmVMUnJldC9oTUdGaHk0MUFUOXBrTFZGSDF3T0l4akJi?=
 =?utf-8?B?TWQyOHlmZXc5ckJGN3F0bDQ0QjRvQ0RxbTFMOTNZQ0cvUHdFdGF0cmNWVHV0?=
 =?utf-8?B?QUZDUno2dGxUMkF0MlhQVlZHemhlUEYxRDBkMGIwM1VSTnRJS3VPMDV1NldB?=
 =?utf-8?B?NVZJQ1JuYnVLUDZ5N0tjS2draGk2VGNwa0ZDb0prVFlRREFrZDQ2VHJRVkFl?=
 =?utf-8?B?WFd3ekRTdnlBTGgrdjRLeUJZckxrR044VlJnVC9RbE1mZzNNQmNTeTRhSXRv?=
 =?utf-8?B?VVpMS28rcVI2YzQ2YTFiWElSYmlCcEd3Um4wSzh3bzZBY2V6aVNmSWwxSnJp?=
 =?utf-8?B?TVJMMDlHeVB6VlBNOEgzbW1yNWJDMWtycnJ0aUY4Snk2THk3WlhqTm1JWlhj?=
 =?utf-8?Q?WLIwfzml8E6NL1pbWYzI01o4J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f420e939-49ab-458d-6195-08dd13a0a8c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 13:44:50.6259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kgj4E2CNCxkCn1krwkKc7hdv2H9F8XHU8O4MnL3mezzIMZM/QvDPwNkVbgF5SFoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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



On 12/3/24 05:49, Venkatesh Yadav Abbarapu wrote:
> Add the bool variable "peer_hub" and set this only for the
> hubs which have the "peer-hub" property in their DT nodes.
> Skip the bind function for usb hubs which don't have "peer-hub"
> property.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..0a8fac38ee 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -26,6 +26,7 @@ struct onboard_hub {
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
> +	bool peer_hub;
>   	unsigned long power_on_delay_us;
>   	int (*init)(struct udevice *dev);
>   };
> @@ -178,10 +179,15 @@ err:
>   
>   static int usb_onboard_hub_bind(struct udevice *dev)
>   {
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct ofnode_phandle_args phandle;
>   	const void *fdt = gd->fdt_blob;
>   	int ret, off;
>   
> +	if (!data->peer_hub)
> +		return 0;
> +
>   	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>   	if (ret)  {
>   		dev_err(dev, "peer-hub not specified\n");
> @@ -212,12 +218,14 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   }
>   
>   static const struct onboard_hub_data usb2514_data = {
> +	.peer_hub = false,
>   	.power_on_delay_us = 500,
>   	.reset_us = 1,
>   };
>   
>   static const struct onboard_hub_data usb5744_data = {
>   	.init = usb5744_i2c_init,
> +	.peer_hub = true,
>   	.power_on_delay_us = 1000,
>   	.reset_us = 5,
>   };

I don't think this is correct solution. I think if optional property peer-hub is 
not present in DT bind should return 0 and that should fix issue on stm board 
where only one hub is present.

Thanks,
Michal



