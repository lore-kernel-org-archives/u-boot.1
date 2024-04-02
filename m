Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940E8CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D04388145;
	Tue,  2 Apr 2024 15:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8f3UWOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09A588149; Tue,  2 Apr 2024 15:20:19 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26AE88124
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRUyJBAiDpSvjE5ig1RLFBffNGHkWf4y2O91nLHzT9Wy42qiSrk8BuDvtCFWaSEbciGJlj5sY9pf1WAdQX9IRXZ3PW8XX0hluXrOyUERorHRfDgQMjAEHqCrnC7OJAlh0YmkTDliq/6eQBTpyNJficl2/em3CSstaX49WvtcDN7B9OY/3qCW8FnCfB3Yg0fcgboqKpD78N8+pgiF8IZaF59KpMnF1xbH1CZG9H/hVpUHID1UCoco9i/6mSUEMtSUlha7NoHYr8/ICLfveax29K1O+1m27JPKnUbB5Fd57z4QNSAulMbb9dc2JPj++vvpYea+ZiCvvxAgpZ9QSabseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyEnpof4Sb8m2AqJtySHrXII+XMzVh2IoD2CXsFMGJY=;
 b=mErFKC3oS7POy7VdNJqWi99rGSVsAGNmeTvIsOsfe8b+m8AqZ10HyuHKL1s+2gZbKi6PuUjVGvT43kzKhyCbNHoJMJz37fyWC1j0JnCqV7mjcdJRMSiq2nSGJsciGX4U+72afNP/wVpbU9UeSgNCb/G/cxDvKrU0KZP5aWf+9mEu9LHpKScXSXK+zLDP+ZYheDRE5KTHEe0i0dwGKOD4m3rWvgxhyOpSkpylFyJBx8TiCyRcsFtxOrjZ516+rIzVaSc3qFxigJ3TvnciITx7ZdwSaeIMde0CD1cw2A5e8sJvJIKqYGVk6456xtlnkoTojlP0p7+hNNRy+fvUcAdlZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyEnpof4Sb8m2AqJtySHrXII+XMzVh2IoD2CXsFMGJY=;
 b=s8f3UWOtYvwlo1xBK1SJNSQz4g0quRvWpF9dMDmNGpuQZttFoKe0NG+Rgy+6jvpoo5RlLFMxT5g1PUbApsgkSRa1/5AsDk5XQgdvzWbg98v/lsE1OtkOHgeshoPahPjnVheFTnskDLqbsZXDRpkbdN1Ic8iqvdxyd0Dw40oc8HY=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:20:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:20:14 +0000
Message-ID: <0be808ec-b97b-47f8-a599-ecbf5795fa31@amd.com>
Date: Tue, 2 Apr 2024 15:20:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for jtag disable/enable and multiboot
 get/set for zynq
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Michal Simek <monstr@monstr.eu>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
References: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcoH64D8c+zNQYAVEnU9nazEUEDcb053gW1dQYd4eMPjebo+nRr4d/6sm26EyZ90A3Uh5tE9ZTmm1AIEXgM66kggX5CoytKojzpJQenxYo9YNZ/9CpQVxn8kDOxSx60n0rr60hSSFgpSqCM5Lc2hIjfFUgL45adx9iqZmu5hrej5JsFPqtD3/jLFciBaBi6LtTIC7nUxTQcotFbvvvG0sJSYxHadMYUc/axA13bH1ynksRndxvuK5rfKxQk4hoDWdyLo7WKVcHnRznEQmdb2wsFO+wCo5fwfOUnQTZQhh6WgkNcAvypZbS5QTjF3n+CkKxq2CczyJRp/dcUNG3s3kUc+yRgDEfNQIFs4m3U5vWNu0e5MNtD0SFvbDnKiWZthFPdPfdKbBFoHT2Mt2kOC6PUIW1z32EK9aXCl3PuslT8tMVVXuMaSkIR1nrjr7QpKppGGMlrSDbN9Bv6r2XMbFWGVVe4ydye627RB9hLeOjJ2kTy4o1ztbQDe21J1ENV/+8BWc/AmvtMwOV11TVUdG5NOZEexgcDRiT74fsOw/3BYg1nfJDZfEsEguQAX/p1xtNTrXFOMyEZ1QFL9yEYqHzqbkM21lBe9snjDfD/1bS0liU7LiO37YLzRossRwmw9e4qquQ4T9ltVfbceHbX+PTLgCw5+JLUxnzt9eFt93dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpMVVpJZlNNTW1wRm5MTVdKdkhQNUtPcHVuY1A1N2c1dEcrTTFST21hbW1h?=
 =?utf-8?B?TlVicGNpV05XVExtNFJJaVVvcmNCeUdRaFZhTGhSV2Z0Sno1OERkdEI2VmVO?=
 =?utf-8?B?WXVncU5LeFRCNjBQamdzT2ZsZElscTl2UnJpakNuK29HcnFWSUo4TklISUM1?=
 =?utf-8?B?Y1JDVzBwMEsvYlhWU2wvVjlmNThRSVNrVHhNV2hOdUxrOEtwVGdjTTJnT3Vw?=
 =?utf-8?B?b2Juam1wYTZybGt1Q0RIdU9hcUFMTnhEN2JYS1Bsay9kQTRxamVDNnNyakk5?=
 =?utf-8?B?Z0JaQWI4dWlYRUxvWG9aTW5wUXl2ZFJYTU1Pa0xNYVl0YXpBcUxLZ09uMjZk?=
 =?utf-8?B?MlhGazlRakpYTkRBTWFEUGNHVU84VDBNeXJCYUlKM0ZHV2F4VXJRVW84S1Zk?=
 =?utf-8?B?S1laaDArQVFWb1V5Z3BvY3FOeWZNQ0g0WTQzcjFqcDlMQ3duRkIzWUlpN05N?=
 =?utf-8?B?QVBCU2pGV2kvMVRqdGdUQjRDVFRhZFBsN2Nrc25kYlJVSHNFaTZOUXVLRVF5?=
 =?utf-8?B?TGFsMDREb0NQNWQycm10S3pKbUF5YmZacGovM3paQTNkalBWZzd0YXljTDVV?=
 =?utf-8?B?czVkZjF2am90V2l4M2FGaDljVTdZcDVxUHBWNFlBMXp5SE51UHd5bUxjbHoz?=
 =?utf-8?B?S3RacGRGOE51aU5PWDIwaXZPY1E0M0JldkZkc0lpVU5oT0xmeCtoMEQ2NnNz?=
 =?utf-8?B?Nm1JKy9qUnhJR1YxS3k0VFFkWWl0Y3d2anNLUjZkb3AyODdCSkgrbUtrenVR?=
 =?utf-8?B?WWNIaDR2RDYzMEZnclluVzBoVjdnMzM3QnU1RExpV0Fld2ZMczRpMkdDbStp?=
 =?utf-8?B?MlJpUkZSeE9obHBVWGRVSHY0MFhDYUdVUVFTSjcxWTExN0V1bWR3TmRKL3Bu?=
 =?utf-8?B?MkY2OUxYcnIzeXBzdFVtaFNkTTBNWXJKdGNWN0Q2Rk9yZlEyS3VwZk9kWGw3?=
 =?utf-8?B?a1lreHRBTnFLVVNUb0x2UUV1WFd0RXBCbWQwM3AzOTN1MzlhQ3ZwbWgrTWRH?=
 =?utf-8?B?WGdrUS9rMTVCWmM0MEhHdFc3dXlOU2h4ZEJnZEhDU1Z2MUNkSGg0aXZsby9p?=
 =?utf-8?B?cWgrN285dUFDcWJNQmUzelVLYkFJVTlkY3pPek5kZU1Fd3dPUGo4QXNjR0VV?=
 =?utf-8?B?OGIzRHY0QUxZbEFkRHpMVUtVa1UyQ2J1bStBeE8reUVRbkFySGxvdituOE4z?=
 =?utf-8?B?c3BUek4vYkJhcDljczN3dXFhd2hZMytXY3cwSk8weXBVNkordVkyT24vQTA5?=
 =?utf-8?B?UjNjWmlHQWxwT1ovbmhsSGNQKzlhQWZyQVc0UGI3WnpCazhUTXY3SEZvclJv?=
 =?utf-8?B?V2RFeWdvMy9iaWIrZEdmZ0JHaFZLdnlrdGFXMjY0SDZ5RlRteC8veklaLzJY?=
 =?utf-8?B?V0ZrZ2x3TjQrSmtIbmViNHBTL3MvNnlOUEdiMGhGV2pNdmlGSUhrWUNzS2ph?=
 =?utf-8?B?ZzlkeU9aQlR4VmRVYWJKYVMyOTgwUk51a3pKV252cWhDMmh0c1Y2d2dZTW1Q?=
 =?utf-8?B?dGtLTmE1THp6ZHlvS0VPb01ZTEJic0FTYzhJOVBDNzVZQ1pqMVIvQ1FQaXRj?=
 =?utf-8?B?VTRKcWh4K0dMSlVHUERWWkhvWVh2Rlp2OWE2SUZCRk5yeTlEZU5CRWYyNXI0?=
 =?utf-8?B?TnhwMk84OHZ3dnBCS21zeVZvQWhIUkRqKzBCRzVsQ1htb241WlZTY0pvek9u?=
 =?utf-8?B?dHRJYXljN0UxdW0vTnd0YzhZWVBOZWhJcyttMHhQZUVXR3B1QzlRL3p2R1ZB?=
 =?utf-8?B?VnBiWC9ZOHZDRWNpbFA2Y3hRTjYycEZKbHh0U1RGWmwyWXhCbmFUVFozSUZu?=
 =?utf-8?B?TmZiZEwzaXhlMW9na2tieHc1UzZOd2RUS3Fmakt1cXJ5c09hVjZvWE5VZGEw?=
 =?utf-8?B?dUVWbEtOOG1XSjBDNXVPL2h3ZkxCZWo0UTFneHREM1ZmcFVCa01MZ2JEZnpM?=
 =?utf-8?B?UTJGZlV1T1lndHdSL2d6Wm5QWkdKL2M5dzBsWXQ2VWYyZHpPNGFBVWh5d25S?=
 =?utf-8?B?T2c0WXI1bFFMc2NqVzdnNysyejdVZkMxeG44M0NJS0VTTUdNbGhGMkZLK2Ra?=
 =?utf-8?B?dUtPbnZmMlVvcS9KdnpSUTJ6Q1BTeXpGZFluQWxtTFhEUUJIV015L040bVhH?=
 =?utf-8?Q?xqgqvsd3yv1tAIDquC08FDR6u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9bd532-9f2e-4deb-9425-08dc5317a195
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:20:14.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4bJJbuoAwVv8a2eJjkfPFkH2vBXglvu2Ul4UcaCzuZG9xTVUWA6d0uz5A6lwgRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

Hi,

On 3/28/24 10:01, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> This series adds support to enable/disable/lock the jtag interface
> from u-boot. This becomes handy if secure boot is used but debugging
> should be poissible for non-productions builds.
> 
> The series also adds support to get/set the multiboot register in order
> to ensure a freash bootimage search after soft reset.

nit: typo here.

I understand what you do and why but completely missing wiring for using it.
Likely you are calling it from your code but pretty much when this is applied it 
is just dead code. Can we wire it up somehow?

1/3 - showing multiboot at boot
Then do similar things as are done with SPL_ZYNQMP_ALT_BOOTMODE

2/3 this is pretty much the same what it is done via
ZYNQMP_RESTORE_JTAG (also please rename it to be aligned together).

3/3 - I would be fine if this is connected to zynq specific command for example 
(unlock can be wired like that too).

Thanks,
Michal
