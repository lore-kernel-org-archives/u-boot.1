Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4671DC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 14:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805D782FD4;
	Tue,  1 Jul 2025 16:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToT4Sy9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C33783018; Tue,  1 Jul 2025 16:36:55 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDDB82FAB
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8J/BAWqp98gJWS877eUqFXrwFbvASga6XTFP/KDORCSyI3RRayAXM8yOwenMbrXaq5+Shjrv/jrgU74B/+HfWj6BtKNBOpyJYkK57JaqIiyS162eMnWzpJaLfAK45Qn+hHS67TnbabO9tKuj4EajDTQ26JCviLzXnx4nAjTD82YXtmb+tbTdMsElKpvNZki7enzLt+1omDa4Wg+4z1bOA+4Q4pIJIdaHmfv9XGH3v/V3m29savnoca1aoq9Q58/DUmBIt1kHOcskQX5HUI0cJvQq9ZNOm7ikRbNq9RpAJA0Ay1l08o8NnhcMFU2ED/foRN3jKmiKAKGruVxIIaa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ixE9dJRecE5OVd9+8180Ha69SQB+l7/+IbN0Z+GNrQ=;
 b=OM72nb2gABphAk66CMsOHJVBndPhlkZt+Cnh3kVhxlnKVTv03P6RWshFmxUp6GBBdCjUBZT167YAUDeEHYJTDkb6tTmAF83MmkF++HYqGJuaRyIw+9bOxW9rmI1VqiXuMc7/ic9I5FQnqY7X7iOdxynGiT1br8Ti9/ER0lnZ0jdQo1R4DrZqjvI1VDX8Gis2dRwAMYSbs7JwLlekBFVMOIj5PqnFJvzP8IGdMcX3UvkO6NAvOyTaftiNnzqtzPFDBNyZFkKxjKKOKF3RDwSwoYHJoeiFMai1Yk4NLYVxmDrJFEHa+RZOo42fxz6cDgCvOlBW94smpO0NNrCyLrzlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ixE9dJRecE5OVd9+8180Ha69SQB+l7/+IbN0Z+GNrQ=;
 b=ToT4Sy9jBLVqVLG4Jlk5RxoZWIp8QTtF2DenjxX8MX22NKVxVEJDrCjoea96tFO4bGaT4UMH58NLs5EmHkXx0cDjYOHwJXwiUWMcAn63qUkkFWhqdRJ6WfEEgnTBs03kbhNS/g2kUI974XE1zEHkwCcPckn2XV8ImitzCHHNP5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Tue, 1 Jul
 2025 14:36:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 14:36:48 +0000
Message-ID: <371b6e12-7350-41c5-bc8e-8945c13fc044@amd.com>
Date: Tue, 1 Jul 2025 16:36:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr)
 command
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0258.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aad31cc-2301-4ae4-918f-08ddb8acb607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0NyMzRPL2MrWkRWTWlmd0EwUDNlbzBZNlhwQktRY3k0dHcxSm9ETUcxeVpr?=
 =?utf-8?B?dW9yNEFRWW5RaTdmWHR6M3FFY2FDdnZvT1JQSGlCYW0zcitYMm1uRzQ1ODVM?=
 =?utf-8?B?OFFGVVBIMjRGN2h6c2MweWJOcGFEaHV5bjY1RExqQlR4VEM2T0RBd1VuRGZL?=
 =?utf-8?B?YXpmMHBUR0FCM3o4M0JLZmtGcnJSblRPZ1N2RXdDV3NkOVpndHZ4enZmaGFK?=
 =?utf-8?B?dFB0a2FGRDhkRWhNZjhxalZZbHpYaGZxK01kWVJJTTZHRVN5YzczZDdpTXBR?=
 =?utf-8?B?U0NMOWorcGNGTmZQTGFUcE1vTDVpZEd2andzeWoxWlI4UXhXZEpkZW1BWDdu?=
 =?utf-8?B?UGFabmFqZElpOGtlNHVYWm1aN3hhZzBjU2FzUlVhRTEveEh0UDhLSENpWm1K?=
 =?utf-8?B?cFpYbldoajN3Z21US0RuajIreGpNMW82cnVSN0Frc1BCZFZ4Z1EyS1dTTmZK?=
 =?utf-8?B?MXg1c0VFYzhsak92QTV5R0NzSy9LUXZ3bjd3OUt0V3Qwckt3dEVscXpidjkr?=
 =?utf-8?B?OHRpNHJXby91cFd3NWpndVBaNFdDOUV4ekVqVlN6K3MyL0xucWhzazgwZi83?=
 =?utf-8?B?aGVCY1N3cDdRSVpPSm1MeFRCczRva1QvKzBobGVRTnZ2YllsUDQrNUJLR1l4?=
 =?utf-8?B?K0RnVlUzdGJSSXBFeVc3TGhDbEVYbFluU3BZQSsvVE1SZXc5NVhwOFRibkdx?=
 =?utf-8?B?S3k4VlV2am5ETStsR2FZR1BLYjFocW0xT3VEdVhlU2E3ZThFc2pHUnJOcHZz?=
 =?utf-8?B?d3lldWxxZFIrejNjKyttbnZYc2c1eGlhcGUzanNSMG9MWVdtTUlrZEVoVzRi?=
 =?utf-8?B?NzluKzFGaEhqYXJHbVJBSUJLYTN0TlFqMTBoQmI1WGdUWjZtMHFmRHh1UGR1?=
 =?utf-8?B?L0xSb3MwSnhwUngvWnJURkJiRUFGZ09kQ0k2K0R3RitrVzBmNmJvNEM4SmVk?=
 =?utf-8?B?bEdsLzB6a2xLcCtJbitDNXE1TWhTbE55V2NjempMTEZFVGxIbzlFSzBSeStp?=
 =?utf-8?B?VG80a0JNUFoyUVdjamNKZUhWQkUvM2dxUUpCdFNXUjg4OVppYlBvYlNwc3BF?=
 =?utf-8?B?RHlBWTBLTmQ5aFlGOGlPSGp4VHBYWlh4V25oTktzNXdFMndJVEdIamJSK1dl?=
 =?utf-8?B?YnRreUozWU5NVi9iRE1ycmUzby9pQ28wMFYyTXUwcStNNEN5K2NUY2NrN09R?=
 =?utf-8?B?c2dSQmNuR3NrOU9Fa2RTUUV3dkN1b1FycVo4TlcyeW11TEoxQkZ2OUdsRUxv?=
 =?utf-8?B?a285QXRwb1hIVHNTaUdlZklhSUNzaUZ6U3hta1NQd2dFVWpvSzlON3NETmtt?=
 =?utf-8?B?SjJHdm9MTFkwTUppeGFqa1ZuenVOT1h1VWlwMTRHbGNJQWVNVzZ1Q1NibGk0?=
 =?utf-8?B?emZYVFVzZUloRm9jc1dSakZjUGJ6MGlybVVyakpLczlIUWc1dml3cUdDcXN5?=
 =?utf-8?B?OGxQZnNzU3N6ZTJDenQwRitvQU1tMGdqeDVjN2RCM3g3OFNhU0VDWk4wS1lx?=
 =?utf-8?B?cGJjUWdsKzFHMHJWRndCcDlKaDJ1STFJOVNPZ1luWXlsbEpLaFZtNTFVUEpB?=
 =?utf-8?B?Ry8rcXljSEk3ckczYlFaRlFTcjEvYlFScGVaWGpmbHM5OG5IYjhwc2VoY1JH?=
 =?utf-8?B?ejBuT2YxVzF3TmVrMlhuMkVuUEM0aFNBZDlvcTdaMXJ3WXdaNjVJeEIzcEdT?=
 =?utf-8?B?VG5PUFZsc1BNN1ExTklSL1F6THp5NWw0ZmZ0cklKcU1sdzVIaHJpTTAyR3V3?=
 =?utf-8?B?dC9kUWt3MFc2RXZyRlFpeXFlT3BBc0N6dkVBVVRhekRDSGJQUkJHeC9KMlBq?=
 =?utf-8?B?UXRLTlZDWS9MYnlWTTU3bVFzamN0MnNpS1NIdjEvMlFqV3pXcFhMeUd3aXN2?=
 =?utf-8?B?d2k3TlZ5UndseExmZ3hFb3M0N081ZE1UQjRieG9nZnlZdCtQMFBFdnlnTDBP?=
 =?utf-8?Q?BEmbXhj6Gtk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxUY2MrVzRiVUlkdWR4bUwvZ1FZak8wN2UraG5GMmtNb3hvV25GbHdaTFFp?=
 =?utf-8?B?TnEybHl2Q0g1WmswL2hrb3FyY2xyMm4vb2NtSUYvaXdhMG9mMDIwbHdEU2FJ?=
 =?utf-8?B?WVFvdExnQW9rUEM0RDRYc29QYitDZTAyRWQ4WWhYR2NDOURxZUMydXFNOHFO?=
 =?utf-8?B?alVLZVk4VEY1d3V0UDhOZnV3dC9tZmUvUzZiN0Q1a2psRDZGMEs0MFNnTlI3?=
 =?utf-8?B?cTVlajlmeUkrMnV6djBDWkhQeHZ4MXV2eG0veVFOOVRPNUVuaHd1YTF1OXU3?=
 =?utf-8?B?cjVrSCtIcUVVYjdyUEdBNXB2YmZqbWxTeVZ6eFN5OVB3VDRSUTM3aHMzTExS?=
 =?utf-8?B?cmtjeXQ3ZzJuaCs2b2tTc1VNYU1Nc0kxVDRJSWVBWDliZjdZaXZDVGlhVEdM?=
 =?utf-8?B?UEQ0YnR4N2R0WDlzUytJMEFFeG1jVngxQkhHY05WV2c1NmFwSjF6U2NhM3h2?=
 =?utf-8?B?S3JRSHRULzVCazhXcVQzdElWODljay93TDNNeWFNQWluUXNqMGdGNzNyaEdV?=
 =?utf-8?B?ZCt5dW9YM0RyZ2dXUWJzd3h2Y0hUUUVHLys1V0t3bzhsK0VpMU0wakhPZmJu?=
 =?utf-8?B?dVNURGpuTnNvdU9FdnNId1Rob2lFL3JYOExIazRLYnFIQmdhYVhWN2FBOWRX?=
 =?utf-8?B?RjhkL2o3NlZSYlRtT3RUYndHY1VZTXhUMDEvY2NESGVlMnpoVGFNL2pZRnh5?=
 =?utf-8?B?aGwzbDFwVGNqaXdCMGVReWllM084aUY5ZHBVaGxmS3luYlhIY1IxenRJbFgx?=
 =?utf-8?B?YWJjVnEvdGpsampYNkxTbFRQMGNheFpqMkZhNlFnbmxGN1A0SDhtSkNITGJh?=
 =?utf-8?B?N25UVzJ4a1BRQ3ZhTGsySW1SVjBnRWZFTXhtUDYwOXBSY1ZQSHZLUG40azRK?=
 =?utf-8?B?cFVQb3c5eGJabkRnQnlubVREL1NOTWprYWJsS2pLZ3pITUZOajFoSGR6WWd4?=
 =?utf-8?B?bmw5bjZkUktjMUhRUnR3eS9uVU5KZTdiNWtFSWZ4azZNUjRKR1ZUd2x0OS91?=
 =?utf-8?B?bTNlZGM2THdMelROcjR0NjZJaHNmUHV0N2NselV3VFp2cXRia09VRzArTVh2?=
 =?utf-8?B?WTZsaW1VWXNHUWlBQktRZmpoNE5CTTZuQlRmZ3RiczZFZjZwZWV0RDdoL0dO?=
 =?utf-8?B?c0RJMGRPMkJvamJBd2JRRnBvMmZsTFJlV3FBY0pPUGdMckhjaVEybTFRbVg2?=
 =?utf-8?B?aXprQ284bWpsWUN1T0V6dk40STB4dHdKcW52eitpNnhpR0swRjFKQVhqMzh1?=
 =?utf-8?B?SC9JbFBvT0NpWDFKaFBRUC82V2tUUnVHV1VwQ3JJRjlFOHpFanNkRFVKYUF6?=
 =?utf-8?B?K3JPQmlwdTdzb0dRbWJjTU5nRElWdzRQMmN1WTl3dnhUSTZCOHg1eXVCYzlY?=
 =?utf-8?B?bzdRWVI4S3AzaHlIOXNRdmxNSWt3eFMyRlg3eUhMbWtqZWJUTjNLcklyTUhP?=
 =?utf-8?B?a1VZMVlMMTk4ZS9nSnVnUlhaWkxVYWloN3E1VENvRHBRcUlZME01cWRoSGV1?=
 =?utf-8?B?cDF1Z21HQ0pIR1lSeTZFNzVrd1ZQWVlHV0RGSGJPUzE5b000c3IyaGd6Z1cr?=
 =?utf-8?B?Nkh5QklQdTlNbmc5VWw1Sk5QTTJFcEp6c2JvTjZrSnJHUTV2UFArRHBORmtZ?=
 =?utf-8?B?VTVxY3l0MUtIUHpxckM2NTVWdUVSMGFEN2RzMnI1UE1VRTllVjdTcUtTeXZS?=
 =?utf-8?B?YVVxYThBdlVydm5SL3Z4dDRwRks1bnVnZUl3bDN3OGdqTjB5MndxN1hHQVBx?=
 =?utf-8?B?Y1ljM1ZxaEtLZzV5dmFHK2pDdGsxTnIxRkVtZ0pRUnZtNzdNWGxraVNNTzBR?=
 =?utf-8?B?VUlrRlZtL1JGMXRDTnNycnBMRzdtTXRRMmpnTVdvQzhmUkF1Mll2NXFBajVV?=
 =?utf-8?B?SXlMTGJYQUY3WnMxOEJWNVpkNHRRRXlUUWMyU1hkVkNMWUM1VExGcDRuRnE4?=
 =?utf-8?B?Vzh6RzlhOVR2aFREQTIvaUhqMG50Qm52R1V0OFpWNXA4YVplNC9VM1o3Q01x?=
 =?utf-8?B?N3VZOEx6clNTVURobFNVR0x3R0hGeXlXVU5EVTltTjJqc3pMRkRvOE5ucVdJ?=
 =?utf-8?B?azR5SXU3MFhkWHNsTjFySG50NXE0M3BNNVpuRCtnTWh6NmJXK05RN2tDMEo2?=
 =?utf-8?Q?4eZafXl9XRI6TedLWfAwfrbgo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aad31cc-2301-4ae4-918f-08ddb8acb607
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:36:48.6622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UahU83gCpKTGYTrfIIL5dd1IwQRg0feQln3+j6vpkgMWwiTB9X2a51apCb539IS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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



On 5/24/25 22:37, Naresh Kumar Ravulapalli wrote:
> Partial Reconfiguration (pr) FPGA command is added to U-Boot console.
> The "fpga pr" command supports multiple regions for partial
> reconfiguration by specifying the region number. The implementation
> of the command is specific to the underlying FPGA device.
> 
> In case of Altera, it is used to freeze the specified partial
> reconfiguration region, then user loading the reconfiguration image
> followed by unfreezing of the region.
> 
> Test set currently can't be added as the command is implementation
> specific. It involves opening of FPGA bridges and loading of external
> images during run time. Currently, existing FPGA commands don't
> have any tests/sandbox environment. The design is being worked on,
> but would take some more time to share and get the community
> feedback.
> 
> Changes in v2:
> - Change the command implementation to generic FPGA command
> - Add usage documentation for the command
> - Correct "_" with "-" in alias name in Altera dts files
> - Add FPGA partial reconfiguration support for Altera devices
> - Address minor comments in v1

I think this requires a little big deeper discussion how this is supposed to be 
working. I expect you are adding PR support because you need it for booting or 
you need to load things to fpga before you go to OS with maybe some changes in DT.

You are getting freeze controller address based on aliases but that is tighten 
to fpga region. It means I don't understand why you are using aliases instead of 
following current fpga-region/fpga-bridge DT schema which identify bridges via 
fpga-bridges property inside fpga region.

Thanks,
Michal
