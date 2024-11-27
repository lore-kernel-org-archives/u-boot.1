Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A1D609A7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 08:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D424B8978E;
	Wed, 27 Nov 2024 09:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1VS53x8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159AD89788; Wed, 27 Nov 2024 09:01:43 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF0889778
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqczBfKKDNrhpr3TJkqXQ8Njm5EuICD1cNnVY3yxbReCxPoUigDe6v3tBjnE2DGb2jKLjbAW3V/qbbGCh0oEqUTPV8ea40RPVJF8/YvuOiJQ8ZaijB7WFzCPi5yWNYNG0nqBiJQrGmzxEt/FqtOGm0RVnOFJkj5RKe6S/pH+eTCJ484t6JUxRT4k8PiOUsyT81dAohdOiPdKPvqR0R+HTGty9nrkdwYT3/SdTGjBlzADANQXXli9PV5GVklsy3s+RbokikR15V5sh1DoCFkqsH4WFvmCgFripKFtjHMJ29hot92eT/Lcl+w4IvvWvv97HobZ+vwWjA9FxhPbhzRV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvshxz8JC3jExBzsflNliWXt705n34GBBqyxmQgt6Ro=;
 b=NT1IjOqsMr3Evt+2eIXHMwc/KvsdBYnMVORC6kOoBVTC/3UkmkepHdVRJW18JsFWDPI6tolw5t9uiqmoEerjVDpK23ZXyPu4xMqPxjMT5vCm/QO47TXNJXyq82VhN+M7WcwYUx2OEfnl9NDy+e1uM1PUb+jgmc3ZV4W6KUjih+opjxjNLlW4L1nL7RMF9EpGCRB15i65PW01aqspMP3gosehCplopwcBS0JdzXjKqQ0MwptmQ+biWxsgThnHbQ3s0yg2ScMMO0VdK6nxidVkTFxaIMroR9MjkuAszH0FloyoJOmjZAZ5ID2PlIG8SzsgoZW3C7TKyH6TgV0bC6K0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvshxz8JC3jExBzsflNliWXt705n34GBBqyxmQgt6Ro=;
 b=W1VS53x8lviIz5i4ZVTm7W2+kWfaEirTluHpR+C0rF1tiq66r+GHDof5EucI7GaBg5Mnf+4KOSe68AEl1H4E0xahUHbvI906IxyIr98mn4DkfDyhWUV9515vYB9MdJtf88UW0qpDy5+hlntvNUUnxtEcrxL1WZo1o3rjlGZ6NIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 08:01:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 08:01:37 +0000
Message-ID: <8856be0d-72e3-4411-8606-a9a963fe0fad@amd.com>
Date: Wed, 27 Nov 2024 09:01:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Also generate images with single DT
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <9362da506c13382da0c0d41ad8a111d9c1150f08.1732089924.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9362da506c13382da0c0d41ad8a111d9c1150f08.1732089924.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0042c577-88ad-4788-4163-08dd0eb9b799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE5WK2ZPc2pKMjIvWHEyZGt3Mk1pYzdrTzh0UzRCeVJGUitsMUEwMFRCYk9m?=
 =?utf-8?B?NytkZFlKYjVsbFFMRVBHeUd1d0l4QTh1bzIrTzNhZjdsenQ0VGlESWtEYnFI?=
 =?utf-8?B?cko0dEZaaW9CN3FZM0l5S0xucW5CN0JoMkNidXBQaTZHNnFUZlhvYjZlcElQ?=
 =?utf-8?B?WHBoTENGcFlrRkwyRTF2WmVEMDVycnpJUVdkNUdZekdIM0xmT3FUZlRyMGpt?=
 =?utf-8?B?TXJwZVBReFhHN2JVMzNPT1RhSk1rUkFzaEY3TG00T3NJMVNQdXFhcnpFelBa?=
 =?utf-8?B?Z3cxdTAvMlBLRkFpc3VzTXdGZU1raDU1MlNkNmRFSGFPWlMrUFg0U0I2Z0dt?=
 =?utf-8?B?VjJSeHVMUHd1Ukc4NmsyKzJSY3NpOWxDSXJUS1hQTUZTMUdodmZEZUZQRXgv?=
 =?utf-8?B?ZkhkV0FqTm1FbGtYWUdESjdHNFk3K0NRR0pZek9ic2haTkVMbnBobUU1REdZ?=
 =?utf-8?B?d3hPT256cllSaW4wOVVwd25zT2lXOERxTC9vUE1ScEhsVFdGdlJnSzlzMS91?=
 =?utf-8?B?T1ppc0RmY1hXaE0vSGxrbVhwSmgxVDk5eTkydm9sZ3lNSlcvMC9seTdVVk5r?=
 =?utf-8?B?UndUdURCWlRsTGRDTXNpY3FEd25acmN4ejJqSWNKR2RTdnRONm81V2d4bnhj?=
 =?utf-8?B?dDBsVlJTMnhscG51dERueVRxbnBmZyt1RE9yTGdOeXZDUXQ3QmM0cXpNS0NP?=
 =?utf-8?B?R0NkbjV4RmpHR0JURzlFN05FdUZSbTJjNkVPTEhLRDdWZVJLcmZCNkI3UmFs?=
 =?utf-8?B?UWlTMFc3OGR2LytaUEVhdDV5Z25MR1R5ZzNIanZlNTc0NUJVZ2VqK3ZlSjhP?=
 =?utf-8?B?bVJzR1RHcUtMcm5PNnlUT2FycUtxL2dJWm9oQzFHMkF5RmJVRUw2V291WTFr?=
 =?utf-8?B?S0JPZTZ2MDcxYkx4ZS8yMHI3MWtLWWJndVR2V0dnUnNJMGFLbnlkRFA4WTN2?=
 =?utf-8?B?bFliR2FJSmM4MGhzM0NHZDJEQk9iL3p4MG1hMXgrVTJ1bGNmTGEyT3ZBRTMy?=
 =?utf-8?B?d1pFLzFUc0Q5TTBOelowbExnM3Rla0VuM0FYOVJYZ0VoMndJc0FxK3MwdGN5?=
 =?utf-8?B?Q3lxTGhlbmsycHRVVXhyeldjcXlrcE5WaVprUlhla2ZLR1F3MXQyZ3dlUGpD?=
 =?utf-8?B?eGVYQUQvRG0xYllkYjRrbkVrbHpLbHJidEs1eTd5MjFVcDZCTk45RVVyckcx?=
 =?utf-8?B?QWN3bDg3Uis0dnZLZUN1Y2l1YTdiY3ByVk9zL0tMNnlHM1RuZWo0elBNZ0c3?=
 =?utf-8?B?cTgydC8vTENpeVByNFRMbXlKNURnSVhJTytCRmhVdzdLUTVram9taVFERmNZ?=
 =?utf-8?B?azZ6K09aUkxtNUhMNzJiT095dmF4cFc5dnlYVEZmcjY2am8rN2N6RUZ4dVUr?=
 =?utf-8?B?ODZZK0NXcU1YYjY4NmxXcXlwam84VFZzSUprbjk3QWRaMzZKMHFzb294d0c0?=
 =?utf-8?B?ZWJPb0lTWldRQ24xTk4vaXlFVFA5Mk9uS2Q1YXduR1lMTGM5engySW5lTVpl?=
 =?utf-8?B?MytYd2NnOGVsa1pPV2REVHBtSlhocEI4akx6ZjNKSm9QZk1xa1I1SnMwR3hm?=
 =?utf-8?B?SkhGSWRIUWtta3hUZlVIZFYyMVdCUlFvYk1RSVN2ZkhNTXdvVHNOUktJNEg5?=
 =?utf-8?B?V2dtVFM1dlBzaGs0aWRrQVFkM2ttWkJ3R3VidHNXMFJXZXJ3RlMyaEt0RmpW?=
 =?utf-8?B?dVpHeHU5UUhjL2Z5c3pCZERvN2QvdGxrdHlYTUZPUEV3MEI0d3pMd05IeEdI?=
 =?utf-8?Q?bJYc8mG+jyqHf2bqGU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2t1Z1pQSFArTjlIaHBJRUthSjhPY1RwVDNqM2d3ZnBWVEtQY2dQOVZocE9Y?=
 =?utf-8?B?a3pJbUhmSGNSS2x1SjExKzJuWWdQRnNMYTFWUnVEWFdMTW80SnpOd1RwRFFB?=
 =?utf-8?B?QXg3N2hyZ2FCYzZEVURuay9BZDJscEpIdldLVWxpbjN3V2FQUkNPOUtnZ1FB?=
 =?utf-8?B?aHV4dE5ESHBhOFY5SDh4U3IxT3BUMFFEZGpnNTR0bEJXQTI5S2NiQnZjMTJI?=
 =?utf-8?B?Y0JWTzRDNURsRHNyR3dEdlU2V1gyaFJDUUEyNExPTXRsVnRYRmZ2blN3R3hW?=
 =?utf-8?B?Wnd6WWVUbFl2ajhWWlZsME01eld0THJPY3cxcmlFL2pkZXU1NDJjTXB3cEsr?=
 =?utf-8?B?VHVCbnB0NFZzQ3dyMkZhN1dVYmFKY0FLN080S29qVEthTGNabkZDS2Fkd3ha?=
 =?utf-8?B?MFRhNXZ1aG5OelAvYldIb2UyTVBaWVErc29wSDV3YkRQREEwTzNEbWkvZmZ4?=
 =?utf-8?B?NXgvemU1TXNiUEZDdk93Q21HNHUzK3hQTnJ3bmxLRDJvcy85RUN2NFZKekQv?=
 =?utf-8?B?anZWUTk2MTBkRFJsWVQ2N2ZsVDI2Z3ZvYVdWZWpWSGcvOFpuVEw2VnlXenNR?=
 =?utf-8?B?enZCL0lSb3ArN25aRlBZVHJzRlp0ZDdBYUdMekdETkxzZ3dZT2Z6YjBXMWov?=
 =?utf-8?B?WHdtdGNCSTZZWXpLbzMybEdFSlBEL1cwYXF1RmxEazV1TmZQWDZhZ1dpN2Yv?=
 =?utf-8?B?WjQ4M0lQSzFpOVo4MzR2WWJNOVdYL1QyclFDbk9rNlErZ1o2a3lUZU1XRG93?=
 =?utf-8?B?anVjUTB4Z3dRVGJNV0lsSDJaMjRHaXN3aGYxMkVsM1hkNTkvb3F5Z05vN29H?=
 =?utf-8?B?aGd0Z1NYclpoUkN5V09BaUFsV0dqcy96bW9WQ1dDNGE4cytVQVZRUjdGTlhx?=
 =?utf-8?B?TGlLMnlmTzBLMU9IOVp4UmlmRGNKZFBFeER6b1hzZkUxT2w4Yi93YXF5V3dk?=
 =?utf-8?B?eEFUZ0F1dlJHTGlSUkc3c0lMTUlGdWFVZmhsVERtWkMvaVRBZUVSc3RuRnJv?=
 =?utf-8?B?U2RNU3ZMUG5UYSt5SkJPaldwQjR2ekVxc05GcVg5NUYwVTNNcVlYcFFtVU54?=
 =?utf-8?B?bE92bkZEMHdVSUpZWXQvVWhVUDJNZHAwRGxsUGlGYVRqT1J5RVgvUERCQzkv?=
 =?utf-8?B?Mk5taG8rYkE1MzEza3l3NnZneU1odnN5eVZpTkdHd1E3eVVrbFRxOC8zRmFj?=
 =?utf-8?B?aU1zU0ZpMEtGTWxualFUNjZtcFp6QlorTE56dk8zVnQ1MjJsV0QrblJLVTZX?=
 =?utf-8?B?Q213NW1UZ1VudE1DOXNkQ3dOay9VZW5oc3QwS1ROY3ZTQ0czVDVIck9TR29h?=
 =?utf-8?B?Sjg4UHhvVlBIY0xpV2tJT1dLazNCc041WFpFb2tNdUQxMVBVZFFKSmp3eWtS?=
 =?utf-8?B?S0ZmalZ4VjBVL3FaTk5LMTd0SVM4N0k3TlBtSy9ta3czempSSWRGWGlGc2Yw?=
 =?utf-8?B?SnpIT21MUjhqZC84NG5VR1YzMENIUUdRZlk4SVB2aVgxQ1cxMnpuS2Y5MWt6?=
 =?utf-8?B?S3pPcWV5ZkJQQ29MOVNIWExlbGxwTHRsTFQvL3EwSzExWEpBWEpsbjFzQnZa?=
 =?utf-8?B?cWovVUlsS0ozUGdEQ3RJeHNsNXM1SEw1dWpzOHpCc1drV21XbXBjeE0xK2dY?=
 =?utf-8?B?SlhraWRsRkVCL3hsTkRMb0lUeGQwSmd6cmlpN3dNcEtWRlpqV2hQck9xTjBy?=
 =?utf-8?B?UkRyT1A4Rnl1QVFtdGlRTDJWcVNaeVllb3FXUGU0S3dYWk9QbWFLU0FXUGto?=
 =?utf-8?B?MEw2b2VxT1dKbzkvZmp2Q25XMWc0a1U2QVNUdjRpalZQSkRKdGw5WXhBRHdx?=
 =?utf-8?B?NVVFeFFpaFMvUFY0alJycFZLVTNIb1BGWkNMK3BLS2hCS2NLNi9icStNTUk4?=
 =?utf-8?B?T0xTbytxU0FjeC9JRWI3Zm13MW1YUVZjOGJ6YlB3bytNZFRjblBLQ3dnWVQw?=
 =?utf-8?B?TXc2dExOQnhROUxjd1h4SEhKaVBJRzk1Q2FUU2hPejBRVHRyYVBidXhTT1Jp?=
 =?utf-8?B?amc2WGZnU3QvMFRaSUxjRXFvVk1laXoxZjJCTWl4MnFGcW9ENS9rSjFmWUdQ?=
 =?utf-8?B?MlVhNzkvQ3FsY2E1S1puUGFOTjFIYWNyKzFoMmNZb0FCM1d5RURMcHBFNGNZ?=
 =?utf-8?Q?HMDzdnVArikMJS3qhWHdJTn/M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0042c577-88ad-4788-4163-08dd0eb9b799
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 08:01:37.0787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PveEOxMGyWrhTcAYE0ipkSjO6a3+vrAhAgZE7hx0q6fDDOio/PHbnkmGfr+YRA6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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



On 11/20/24 09:05, Michal Simek wrote:
> Create u-boot-single.itb where only actual DTB is used not really multiple
> of DTS from OF_LIST. This results in small files without option to change
> DT.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Based on the top of
> https://lore.kernel.org/all/cover.1730452668.git.michal.simek@amd.com/
> ---
>   arch/arm/dts/zynqmp-binman.dts | 95 ++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
> index df0fdf465107..675f6bf51ebd 100644
> --- a/arch/arm/dts/zynqmp-binman.dts
> +++ b/arch/arm/dts/zynqmp-binman.dts
> @@ -89,6 +89,85 @@
>   			};
>   		};
>   
> +		itb-single {
> +			filename = "u-boot-single.itb";
> +			pad-byte = <0>;
> +
> +			fit {
> +				description = "Configuration for Xilinx ZynqMP SoC";
> +				fit,align = <0x8>;
> +				fit,external-offset = <0x0>;
> +				fit,fdt-list = "of-list";
> +				images {
> +					uboot {
> +						description = "U-Boot (64-bit)";
> +						type = "firmware";
> +						os = "u-boot";
> +						arch = "arm64";
> +						compression = "none";
> +						load = /bits/ 64 <CONFIG_TEXT_BASE>;
> +						entry = /bits/ 64 <CONFIG_TEXT_BASE>;
> +						hash {
> +							algo = "md5";
> +						};
> +						u-boot-nodtb {
> +						};
> +					};
> +					atf {
> +						description = "Trusted Firmware-A";
> +						type = "firmware";
> +						os = "arm-trusted-firmware";
> +						arch = "arm64";
> +						compression = "none";
> +						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +						hash {
> +							algo = "md5";
> +						};
> +						atf-bl31 {
> +							optional;
> +						};
> +					};
> +					tee {
> +						description = "OP-TEE";
> +						type = "tee";
> +						arch = "arm64";
> +						compression = "none";
> +						os = "tee";
> +						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +						tee-os {
> +							optional;
> +						};
> +					};
> +					fdt {
> +						description = "DT";
> +						type = "flat_dt";
> +						arch = "arm64";
> +						compression = "none";
> +						load = <0x0 0x100000>;
> +						uboot-fdt-blob {
> +							filename = "u-boot.dtb";
> +							type = "blob-ext";
> +						};
> +						hash-1 {
> +							algo = "md5";
> +						};
> +
> +					};
> +				};
> +				configurations {
> +					default = "conf-1";
> +					conf-1 {
> +						description = "Single DT";
> +						firmware = "atf";
> +						loadables = "tee", "uboot";
> +						fdt = "fdt";
> +					};
> +				};
> +			};
> +		};
> +
>   #ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
>   		/* QSPI image for testing QSPI boot mode */
>   		image {
> @@ -106,6 +185,22 @@
>   			fdtmap {
>   			};
>   		};
> +
> +		image-single {
> +			filename = "qspi-single.bin";
> +			pad-byte = <0>;
> +
> +			blob-ext@1 {
> +				offset = <0x0>;
> +				filename = "spl/boot.bin";
> +			};
> +			blob-ext@2 {
> +				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +				filename = "u-boot-single.itb";
> +			};
> +			fdtmap {
> +			};
> +		};
>   #endif
>   	};
>   };

Applied to next.

Thanks,
Michal
