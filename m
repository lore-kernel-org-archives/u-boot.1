Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C02CED606
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 06:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C443588FEE;
	Wed,  9 Oct 2024 08:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3Kb4jbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EC789058; Wed,  9 Oct 2024 08:21:57 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF2188BBE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 08:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy4WAeIAW3wIr6OBOXsDR39yo2KMJfLA3xqMilfa0khrJqIKaek21mEdOhcQHr5eDYSumRmiqmS4Zps3m3RUMXD9wZU+MUPUct7RllWUDzzUJisofDgv0el0UK29dl847RP8H83wMN+4eb7z/IyCqQFc5uQZFrQQzRxIosOtKqugi6NO94Azij3LURKGCXj2B0kW+OtCGbpnN1Oy9gchBd0J3jlNCIaPhT5Quzv8Aqjzq4/dD6AQaK/EnqESnBf1f3wd50GBcRLYqir63Lq3AjsoeaMZHmqAoGc438FJV+nbh1Un6ocCVBfgGA9i1Pr4ihe2WwqM2ji+HYhDy5ZQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4P0CE7UqsnQ8OOyniDky5wVwLxIhXpJg3dyB+EcNtY=;
 b=nv/xN/MjkjHuSqTjA+CsVZpbvAeM64MhJlCJnRPaard957kcvSMj1AjQ1nQf5hbA4W3Cy1zYoyFXRZj9VUgzG9u5RMyfPmlb4GBROPslG6a0KS0c7EyVAWCJiiU4QoMPB0PNvuwdc+JoryrfcXVIt8+T2xViuKdRQTP801WQufT9HtijprlWeYQJcENgH0quM3iTeK00cxx/sZlsIsimuh58Xl/Pz1fJTc+Mk+eGfDlSb7B3wIoI8oUUZwcwg2FzOaeqMuTK5A7aplzE79/CGIMkV5kPLE49h0LyUcl2UYZpIF95FnIl3z1BRBHcG7A9SEb4BHocyRBWD0/4Qxr5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4P0CE7UqsnQ8OOyniDky5wVwLxIhXpJg3dyB+EcNtY=;
 b=q3Kb4jbHFFGn0wPlFB1JfWgbc8NrFpA4z8JtDfigWeXDLmsfsebOuwm8N5vu2h/JDnYRPSSIjh1Hhnw0Uw/RGgXR1M0lhwAh+mX3QDCNDQfudMapdWiueagY/nEZy/CqzZFjHQhoiEsQkhUoFVM27tgtMch2zhNkddSAyjSqxno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:21:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:21:51 +0000
Message-ID: <a529bacb-3b74-4d41-bba8-de59a48e5d88@amd.com>
Date: Wed, 9 Oct 2024 08:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: versal: Wire USB0 in distro boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
 <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
 <CAFLszTjrWaRyWXi45s2uNAXwhV4Lk1Vm2H7JH5i8xKRuPy4n-Q@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTjrWaRyWXi45s2uNAXwhV4Lk1Vm2H7JH5i8xKRuPy4n-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0025.eurprd09.prod.outlook.com
 (2603:10a6:802:1::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: d19bf779-0933-4d06-95d3-08dce82aa9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXZ6SGYyMS91TUVqMmJYMmp3Z3BnZGQyVXJ3RGhqQWNHWmlTdnlWQjdxRjBB?=
 =?utf-8?B?VGpDK0JRL3RQVm9IMjVhaXpwY0RUYkZGMGQ0U1U0TmVmcWJmWERSeUJKMFI0?=
 =?utf-8?B?QUh6dWhIY2s3ZkkyTytOTzl0WFVaZkZXL3FYL21aa2lmM1hQc0IrNXR3bE1S?=
 =?utf-8?B?bkdEZEhYWTZPSGNrZS8rRk1hUU5PcVQzUkF1dFd4WVMzVHd6MFFQYnR3Umdw?=
 =?utf-8?B?RmRNU2VYKytDdlora0h2S0NsSmdZWjJ0eWdZb3hHU1V3UmtPVkRkc3VuVzFH?=
 =?utf-8?B?SWlnV09UbHB1OUZQTFFqRjNIeXhmdEVJRklkaUowdXMzcU1WcEwxTFMrbTFH?=
 =?utf-8?B?QnM3bFRqbFNDWncvbGFtR01WTXVnczQrYUwxT0dpY2ZyZGZDTEJGS2JCNDdG?=
 =?utf-8?B?Nm1mUUFMNFFtU0tIVStrYzlkOUREaVdjK3BtZEdzbFoxSEoycUtjU0NuMG1K?=
 =?utf-8?B?bjJKS25lNzFGT3U3Y3MvQklJUHF3ZnBuOHplbXVTY0pIS2o2a2ZSVTJVRGNh?=
 =?utf-8?B?ZjIrQVNEcnd0WEltazVHcDlBb0YwL2dPdGptR2JMUTZzRmkyN01sTmxlVzQy?=
 =?utf-8?B?dmsvYWJhblBvSFdtc01aOFNZM1hYSXliSHpVSksyR3RQMWdkS3N4a3gySDJD?=
 =?utf-8?B?WEN3OTRKL08xcFVIUXF1d3FyeXNTMzNRdW1JQlkvUlVCclBscXByRzJZZHpm?=
 =?utf-8?B?VDFYR3ZuUlI0OUpqRjNLRllqRERGSE5sMjBDTDF6TnIwT2RhYldIZm15OGNT?=
 =?utf-8?B?VDkwb1A1WThYVnMrdWpLVCtYUkdWQmp1cEVDV1BSeUlobVhhU2dRdURIRUZ4?=
 =?utf-8?B?QTY4R0EzczI2MjZpUUZYT2J1eEtyMm9odGNTcyszRzVXUnRTcUZhYmlVQ0hW?=
 =?utf-8?B?RGM1M1BFeDNhck92OTk2K3F6TmQ2MlVJdllocUtHNVlaY0pFNWVOQnlxb1Bz?=
 =?utf-8?B?b0R2aUF5eXBsVmZXUElaK2FmTWJXTnFBU1R2ekVzUFo0c0Rxd2RrR3ZaK1BV?=
 =?utf-8?B?QmVCTlNsbmlhWFRoeUFZVlA1eHhtdEwydUpzVzlnUGlUUTFzNXZCOVRCSEZt?=
 =?utf-8?B?bzR2SktNc0l6cnYyTVNFZGdIb0VER1JKSTZ3S0NBUjJHdDhvdm5uL0FQbExE?=
 =?utf-8?B?YlpKVXZ1VUlwRmhrUGxuZmJPKzY4NGZabU40L1E1ekdzcHJDeURRL0swWTVz?=
 =?utf-8?B?Y2ExTmZlMnlMQkIzL2hVWEpBTWxXWlZxWi9jZExmRlFPVDFCUHA3YWNKdzhi?=
 =?utf-8?B?MXc0MG1oaTJmZWp2VHkva3I1elYrMmlScVlzaXRaeXNxYjNDeDc4Sk93eGRY?=
 =?utf-8?B?TnZVdHlGemY0WElyQk1Fa2YvV1M1REVnc0ZWR1NyUkxwSDVZcGIyWVluUXJK?=
 =?utf-8?B?am1mWUxjeDFkUkE5bVJyVDVOcnRLS2RJRHpuekZPYVRvb1RaOVpKaktRRGtX?=
 =?utf-8?B?aXQwZGtFWi9ZOEh6R3FuYkh5bVBWOWhpSkhEbHRHWFhIcjc1UEJ0aW4xM0NK?=
 =?utf-8?B?MU5lcWxtcC8rVFFRbFhUeHpNeTFFQnFJVXhVc1ZCcGNKU1M4NWVaQlA5YitO?=
 =?utf-8?B?TlA1MjZndmJuSEZ2ZzZBd2hsRjdsQk1WeVVNb05LVUF6REc0SlRIK2xOUFVC?=
 =?utf-8?B?OTBucVAxczlpS2JyN3VoaFFPbjFaUGZLVzFaVnQ5VGNyRHViM1J1bncreFJD?=
 =?utf-8?B?cjVVYTNmd0NVdVFFMktpZEJkVGZXL0VEUEFFS0FFakxCUFRUMW1EdnpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QS84QkJVeitZY1dadVR3MlN2NjRmWjRNWjRRRERZSG9Icm5OKzRQdmptOUJS?=
 =?utf-8?B?ZExMeVhyQW5YQS80ZDVxdjNPajUyKzFpNnI5eUdRcUY0SGhDdmZ3dXQ5YVFn?=
 =?utf-8?B?K2ZJeDQxODJUaVBHVVJSMFQ5NHB4Ui9KSUsxeXdOOVFMWGN0cHk3MFRCNXFP?=
 =?utf-8?B?c2NQVFg0Nk9iY0dKUldwcG1pczhpNnZWSzhoRkV1MHViQndDSUVMR25ENDVD?=
 =?utf-8?B?OFMxOThHRUFFT2o4UU94eDJxaVdtSk1PS01qdDZrUkZ4bnBNbmM2emRVem9D?=
 =?utf-8?B?ZVBPV0VDaHpSa2ZuaXNNM2pJRDZEZlQyc1pQUlk2ZnNiNG0rMlNjWVc3QkFE?=
 =?utf-8?B?SjhWcSsrS20xVXYrbHo1K1dvZXpzQjN2NFRPYVB1NnNGLzNxQ0NyN0ZaVCtF?=
 =?utf-8?B?VlI4ckxTUnNoMHdCOSs3VGUzWndDSFVzWDc4WUNqdHFsWlBFMDAvSXdobi9X?=
 =?utf-8?B?enBHNG12WmhFcVl6RDUxMTIwV0RFUmo5dlZlQWNFLytCSTNqM3BFV1VPeHp5?=
 =?utf-8?B?TjJMUFM0VXVMOGpIcG50RVlmVm1RR05ianNmc0JSVldnOW1mcUNGZDFMZm5B?=
 =?utf-8?B?dmxQT3AxKzRuQ0lEVTR1RCtOT2dRVzBtSW5pYnJvNUFrTFF6UFV0RFhIZlFl?=
 =?utf-8?B?ZnRCV1Qydi9EMmFyOWhNU05kMWNYeTlkNHdIejFvK1pRcTZFZGVTZEJYMmp0?=
 =?utf-8?B?Q0xQRmQ2czBrSGJsb01FNmpGTG1JYkdVWGx6YzhjK2NiZnlnVXBmczdudmJ2?=
 =?utf-8?B?RXI5VjFiSWFyeFVmUVBVSWp6cFQ2YmJOaHVnWkRHYWNpbHRnMGR4M0VHaE1R?=
 =?utf-8?B?OTNoMUF5c3hVYVVLY2VpdURmQWh3a3FmcjN0UVdtVUdNZlRMWDJVL29nelk4?=
 =?utf-8?B?OFdwLzdkWFVlMEludTBaY1duUFZ4blhaZUNIL1JVS3hGNDF1ZEdGSnN5czZv?=
 =?utf-8?B?eEdiZ2tYcXZLcGhqM21UNG0rSm1QdXZtam9IdktuVGRQVjdNeFB0cUJvWU13?=
 =?utf-8?B?Nk16NXhVYjRpRjVONWZpc3NCWFNmcnozemh3VitqMlE5ZmlibzdVNUt4TWhm?=
 =?utf-8?B?MDJOMDBJNnVGcEVnZUV3YlEvWXBlbkhURGFUN3FFNjBocG9vUlg4Q1lieVBH?=
 =?utf-8?B?ZnQvWVlHdkg0ZlZTR1U2L1djeitSaHBqU0VWZStIZEs2UVc2UllTNVdIY2h5?=
 =?utf-8?B?YlFQaXo1dWRyQTBrOTdNUkU2Vjh5Q0lUK1FqajhndnRpTnNFWEFnMDlKWVdT?=
 =?utf-8?B?TzRkTGt2TDZwY2Z0RWFJaGQ5RFBBR2VUTmxBL0NQd0c0bHU2dzh0SDUybks0?=
 =?utf-8?B?c0ZBQzdSemM4aytOcEhSa0ZRZGtnWFppTnlwbnlURm5KMzlaYXl3U0haN1BB?=
 =?utf-8?B?Z21BZi9leWpNT3VxY2MwditDaFVDYUJtM0FtTUlUd1hIQmFQL2VJZXRuTGNH?=
 =?utf-8?B?YXlUMC9sazlGMWhwbnVyNHFINnd3R3kxbjM2WTFLL3dOT3hnZXhGWWxhSm5P?=
 =?utf-8?B?WllhRER5czdGc0Niek5IbzF0aWJHMGpaQ3Iyek9vV1FpUWhuNVAyL3E1cGhK?=
 =?utf-8?B?ZENxL0d6NHdSTGdQK3lwTVJnZUprZlBCUStvVTV3NnZmSVhtY29DemxNdmEw?=
 =?utf-8?B?ZGZSVkwxM0t2NVgzSXJjdXF0aU01VngzRWRGMEpDYzloQTg2WmUxVGZLRVMy?=
 =?utf-8?B?eUhHWmpWejZLaGFPVWNENmQ1K3k3ME9WdzZ5RmJNRkk5VGQ1SDRiVHNFOTVu?=
 =?utf-8?B?QXlGSUhSbkVva2FDeEM0am9nRHo5QzcvUFpyb3ZqK2tBKy84ek1HUDRpQkVT?=
 =?utf-8?B?Q05DRzE0aWZISTlUOEJsMjY2clBCV1orbGszN0wrSW9JVVVtSUNWTlFtZGla?=
 =?utf-8?B?WU9COWl6L2p4alJ5VVRtSHNyMG00aE1BWkxwRWd3STg2alNjZXUwVFlHN3lM?=
 =?utf-8?B?dTkzMndFN29pbEYrV1dpOGdxTzg1eWROb3NUb0JkVGtzQXgwY0srUUlwdFRq?=
 =?utf-8?B?MGg0b1h0d250djdiNVZLYlZuUC9ZR3ZROHZYenorQjFlWDZMZ1IzYnZFNzdM?=
 =?utf-8?B?UEFkaW5mSmpKdGdIZ1A2eTFVVkgwdDdZazJVNE1ZNURvZjFPV2x3cklINGJq?=
 =?utf-8?Q?HhVLPKYceHQPehNA+vf/9QfeL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19bf779-0933-4d06-95d3-08dce82aa9c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:21:51.6375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbLi+B/LB4ZofmJdWazeIZdCTD5wNw0CM5RsLodbVrBa4bHjt5uHPxPTLt5Drntz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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



On 10/9/24 03:56, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 30 Sept 2024 at 05:05, Michal Simek <michal.simek@amd.com> wrote:
>>
>> For unknown reason USB host hasn't been described for distro boot that's
>> why wire it now.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   include/configs/xilinx_versal.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
>> index 212dc9df2a2e..64f123424cf7 100644
>> --- a/include/configs/xilinx_versal.h
>> +++ b/include/configs/xilinx_versal.h
>> @@ -48,6 +48,12 @@
>>   # define BOOT_TARGET_DEVICES_MMC(func)
>>   #endif
>>
>> +#if defined(CONFIG_USB_STORAGE)
>> +# define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
>> +#else
>> +# define BOOT_TARGET_DEVICES_USB(func)
>> +#endif
>> +
>>   #if defined(CONFIG_CMD_PXE) && defined(CONFIG_CMD_DHCP)
>>   # define BOOT_TARGET_DEVICES_PXE(func) func(PXE, pxe, na)
>>   #else
>> @@ -118,6 +124,7 @@
>>          BOOT_TARGET_DEVICES_XSPI(func) \
>>          BOOT_TARGET_DEVICES_USB_DFU(func) \
>>          BOOT_TARGET_DEVICES_USB_THOR(func) \
>> +       BOOT_TARGET_DEVICES_USB(func) \
>>          BOOT_TARGET_DEVICES_PXE(func) \
>>          BOOT_TARGET_DEVICES_DHCP(func)
>>
>> --
>> 2.43.0
>>
> 
> I wonder if these could move to boostd? It would require implementing
> something for dfu and thor, though.

I will get to it in near future.

M
