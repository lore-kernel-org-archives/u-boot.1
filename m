Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB36C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0067180B89;
	Tue,  1 Sep 2026 13:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoyfr-y_F-4K; Tue,  1 Sep 2026 13:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788268616;
	bh=JFHDA1MJgA+akA/RtyAkZy8LIpBLkMezKK1UlE3+F8Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VoWKM9mt5HGr5Bqg7UjUHZQjFXcx2/FkzL+L0YT0YsLFJuKJAbnyCtIkydfPXkl8/
	 BLEus6wiQi5ZT+pSTssPXz0QqnCR4nJLNUAyxxMxYnfPjpFG6HmaTzjth62xt8+u94
	 W4XbHbO0c3NURKsETupQkJWix2Zc2daARdubmsCTuh8PqV91sN18X1vHwbw8pqrZSE
	 Osu13STGeGEC1kpUSeWbF+gNCVJO+58Xc1g2OvkcjHKCF01y+rSB9muf2fjFTUDkoN
	 L0MTDQfLiQQBlTQhYrTL0UExuh2a7hacDuoufsG9TblvMa7bfEHeTOB9A6sayYY7Dt
	 M8A6XedQ/VweQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03A9580A66;
	Tue,  1 Sep 2026 13:16:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B183E265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A352E80A66
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4tBHsaq1_Sm3 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 13:16:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=DfQZof1L
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65CA680A5A
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4tG5ZLe7MNBX/DCEqRCKe+K7ntiY2ggajCXwdFSf6EuIqR0rBOs0uJqk+w+ztL//JEnB7HMN1o33QM6QCPcu3ltn81xHyoeweBVmuJKAI6YOFM8mMDZ3vNquf8xJAUBFIn8niRvRwYz9cLLHoCPNz/dz/k2on+7ta3TD7ZtBNUDL3hTLgKbPQjam1mGJK5cdaV11phPrvhQe4QKTjqMZj5y3CwpYx3X86/+DDxmHKaKQwHBp8LgrenbsuBJQ8k31YmDfIk4DxfIqXKvEDqq9tKSznQ1MnNLe02gmR5XcpgPzKg8FRvkh4iCbaorJ7FKxneO933b0Qfs1fRp5b/stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFHDA1MJgA+akA/RtyAkZy8LIpBLkMezKK1UlE3+F8Y=;
 b=y7lQqL2UwD2C1/nefKx1Ma3SZZmYykf1aczfi6nuMHl4xq7NJRJ4O7CWYBoQloK2Ot6Y5VFR/n115yd+g2DuZ2Djf69+/wN1MWaY90yEPdmGVxHMVA91IQUeNXNd+qlriq+OeHzyhsj+HCUavhjd9/bb3b0Tlef69/iQsZn38BrWV98QFQwX17tZ6rPbCnKJQHl3EcSW33hm2rtTj6jaXvRGPSfIqUhng0VjqxQ7cTV9oI5Ie/zZYXp8EraWP8L5fWLeWGM8uVbezTpwXwF06zHF7Odp5gdLrAKxJWesoR32ptAdvvHnF2D9kjJIoW0QiHxTgJ7F6TIHLBEKRuIqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFHDA1MJgA+akA/RtyAkZy8LIpBLkMezKK1UlE3+F8Y=;
 b=DfQZof1LgCSDnLX9byhthuViJtpdk+26vH2E2cwfFEk9k2pvMlbLPMBNgBmEocAmOgcP8GBva14tqIWw7BjmGSTk22DfW5QwP7l1MWhDB14L5/JLBixvFDF7Q4/YKbkAydPJxIciT4JlmHx3G3SfTUallRfcC4HbqzARxvECqdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:16:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:16:39 +0000
Message-ID: <93821214-2b8e-40fd-bd49-f7cb2d7b6ebe@amd.com>
Date: Tue, 1 Sep 2026 15:16:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Move u-boot-microblaze to u-boot-amd
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Tom Rini <trini@konsulko.com>
References: <0284af854ed280d87d0d083cb7a2c62b358dda6d.1787556846.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0284af854ed280d87d0d083cb7a2c62b358dda6d.1787556846.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0262.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b11fdda-2852-4aa9-8864-08df082b423b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|13003099007|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q0tQFRuwDgEbHiLPj8Dw0VJaS4pV0Y73XVQppkgD4KHw3aRnrLTsUskueJ7xSpCU54YAvlsqP9nDDNV1cBBiiuz5pvlsB3NdsYVkxAYANApzZJPM5SsfrSlLAIhEcJcOoRZ2xorn/CNgGLTQvvtJ2J4s8hGAX5FhdhE4NXsYd/2bdOAedQiMAkPICFkU43vOh8Mo4q9HnLc+4yt/cMDaBdMQyMPVIWQ8txvN+9xb91O0Ys3q9zohedck60ueLXdkF4Cor4mSQ4rUHqUbLRqcBMchWznU34mKYajavheXWsBiXboiCE7a86Kf0m4rkyVH499Fpw9YqWkgQaXMQAXvNNgFWtFpFb9grY6aCKJx/3uog4DIvdClRvAP4sWVpOW5j5IQfS3yz8fVEV+Pkb2wuNNM/LM3Ieg1/nv4zzaDc2hsYTOo7fuejRjSCN3CEg/tK1a4/qLX+cTAsUe8jTnAcEkQweodpWCILVDapa3U+263vwdAfMnZJOpwWYNxC7gKw3/HC94dmTl4cvO3bmukZ/R5NtwJcsUspf9a1613DlfWQ/4QKfhtcvH9v0QgVzk9VKj88tFBF5+nyf1i2HeGSoikZsqAOMyTWiOVX9L3M2nEXhmg0tjFKmIM4XMuGQI0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(13003099007)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUtOVHFhVjA5ZS9OVGxJRlhkLzZUbjhJRUI4Z2VWcGRlZEN2N0RVMjRSTTJQ?=
 =?utf-8?B?T0UyWThxTXZjb2cySGVhMlo5aFQvc1FYdXEwOW52Ri9QTEpQTSticmtHRjdR?=
 =?utf-8?B?WDFVb0RMMkZHeEF4Njc4NlZkZlIzbGJ3N3VTRVFub2ZEK1BnVm43bFl4YkFa?=
 =?utf-8?B?MUpOdjk2TEYyY1g2alpoMGNvMm9YVFI5V1JYdHpQckRmdVd3TG1IRVFtR3VY?=
 =?utf-8?B?cEp5NC9oRHh0R1g5OWRiaG41NzBHb1dnOGI5WjBTNGd1VjVZOWF6WWIwazlH?=
 =?utf-8?B?K09TdzBvTGFTSHI3b3dUV3VITEJ2ZitxRnRTL1pkZU5pUkNGMUJSZUdVZFBT?=
 =?utf-8?B?U1NhRVE0YVhSbit0b2hhbkRxYkoyV1U5cW1Td1dyVDZvbHJRMll3aTZGc3Fj?=
 =?utf-8?B?ZGJodmtvQzlIRmVGREZtVDFOSjRZRjgxRkpsZ1FwTjl4VjFVNm01WjdvQkVV?=
 =?utf-8?B?T3Bvb2U4SGtKSFN6SGtKQVZCZUpjTGF1ekJVakJ5cjNOQmt4bFRCUFFjTkk1?=
 =?utf-8?B?dDdLTmc0MTN6N1pTSVVPa05SWnJqc3Z0Q2Vxd1BYM1ZRc05UbC95YnB2c0FV?=
 =?utf-8?B?UmFkdTBUendYS3ZBTU0zVnQvbXFzUzVjeGRBcVNvRHQ4K1FYaTJqT3V6Qi8y?=
 =?utf-8?B?U0lBaFlXc2IyWmJaaFVmUjQ3NjZlTlZaRFM3RlZ5a1k5Wlo2ei9ueEhSeHoz?=
 =?utf-8?B?Sy81VldacEZSbGFnOW9uaWg2VUVkc0t0R1ZJMFlHelRtWHlpMzhYU2I0YUEx?=
 =?utf-8?B?VXVBZUtKNnBlQWpzT1ZLOTBMcUU1RVZlVmVwMFRCOElvRHliaWNqK1REdGdE?=
 =?utf-8?B?VHUzTERyQXJsS255MUcveW9qcHNqMlNaTTJkYk1EWE8wVkRlUURhQURDK04y?=
 =?utf-8?B?VXNiNGF4Rmo3QjhsckV2aUVMT2psNUdkL0V0Y2pQZ1RQbGhkR3dsWFgrdm9r?=
 =?utf-8?B?WHpuK2h2TklMK29xYjM0OXY0WkU3aEtYREI5ZUc1djZ3MU1mUGlEZ0NVcEtC?=
 =?utf-8?B?YTJRbFBuQTc1WGdudzhhZmthUjg0ZWtKQWZHSmJaRUVvZ0RDWURzdUJxbFFS?=
 =?utf-8?B?MkpldkRubGJIQ1ZySUkzTjNnbWIyOEFoVWFET2VpUmVldjBFdUVGaTVKd2xM?=
 =?utf-8?B?ay9FQVpWbCs3QUE1djMrMlVzSUp3V2dVMlJXNkJCRWFOSW92bmoyM1pBMUdT?=
 =?utf-8?B?aTVrSzlWUEhjUE0yd2paUmgvb1VWRTU3a284QkxTZUYydlpReTZnUWRzaDVu?=
 =?utf-8?B?M00rVTJIdmlDSVRwL3QvdW1zT0dwWDd2SWJMU0hhSGRYczlUQUhnbEV1NFNK?=
 =?utf-8?B?QUtBaVdWbzVubkZxUnZkTE9aa0VVNTJJaUI3SzAzWkhGNVFaSXhIVlBjRWRM?=
 =?utf-8?B?Wi9GREhiZjE5aXZvZndueDBMOVF3SlQ2UitDYVh5NHpxMUVTWm9KQkFiZmUy?=
 =?utf-8?B?NGswNkdPNXF2ZnZPZU9TUHlRSVdOcHFCU0NZcXJ2QmZBZGxtSFBBYVFLaWZ3?=
 =?utf-8?B?a0p0YldURG85aVFRSHhTcXhUak5VNFV3UHpmQUhtanlyTXZTaFVCam5yM3ZJ?=
 =?utf-8?B?NjRudWgyVEtMQ2x3OUgxS2p6WFVvS3FpTE5HbFJhTjlZL1FnTGM4bWpPMUQ1?=
 =?utf-8?B?Zy9PMEJTcHl4N0o4THgzMWNQTzgvWmx2NGZXekJtZFEzQ3MyUDMxSjZ4UEFn?=
 =?utf-8?B?Tkd3Z0dFaUE1VGdKNmtHK0x4aGF6b3NBcGVrQlBlVUxQcFdmaW5jWmtSdW9h?=
 =?utf-8?B?OE1ieDdwd0x1U3JUVUEwNUlOcTF6RVZWWUVJWVY5bEl0ZFRDQ1ozS2F1NDNt?=
 =?utf-8?B?eUFZUFppTUlrQ25lNXNicm1oRHducHRTSWpoYXA4alZybDVKT3k3SklBZEo2?=
 =?utf-8?B?Njg5cHF1UStOZEIzb3RPWUZyT0Rrby9nbkJrWmxpTDlNRGxyanVOR3EwenhS?=
 =?utf-8?B?ZFZlQjVOcGdubC9ZYWoydnFwaC9RY2lyR0dIa002VFdWVGNFd0xraFBiK1NY?=
 =?utf-8?B?Q3hkb1NlUXROUmVTNmJPbkFoMFgxK3dGZnJmUm93ckxmOHRwU0Fidm40STZi?=
 =?utf-8?B?MUI3Ym9wQ25JNDIrdkdHMXpsMUkxNmdtWHhtdmZJYm9SZVFyaWw0bkJXREN2?=
 =?utf-8?B?eEIvZWZuaEY0eGgyT3RtZDQvOFZJZXRUV3JlMTAyaFRUcy9GYlhVT1VQZkRP?=
 =?utf-8?B?dHRsNWRsRjJvd3NJbjhWeWUyUVQ3UFBFbWZqWW9ZTVZuYVZxY0ZSM0h4YlFL?=
 =?utf-8?B?M3lqNklQRlRmTVEyTjZiZkxaVWRqL2NSUjNudFNoWkhDbXVvSERRSjRIQkwy?=
 =?utf-8?B?eTZlZUpEZFYyT245RGZHZnFjamYwK3JwQ01rSTNYYUtDL0hTazhEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11fdda-2852-4aa9-8864-08df082b423b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:16:39.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvJm/voTjzvgQK/Vvp+D0jZRIDOv5ourzjNHZacbNUyChdMqFgxQd/8g3fkrHl2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/24/26 09:34, Michal Simek wrote:
> By moving to u-boot-project.org custodian tree has been also renamed to
> reflect current situation around AMD/XILINX SOCs but links to repo haven't
> been updated.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/amd/versal2/MAINTAINERS       | 2 +-
>   board/xilinx/versal-net/MAINTAINERS | 2 +-
>   board/xilinx/versal/MAINTAINERS     | 2 +-
>   board/xilinx/zynq/MAINTAINERS       | 2 +-
>   board/xilinx/zynqmp/MAINTAINERS     | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/board/amd/versal2/MAINTAINERS b/board/amd/versal2/MAINTAINERS
> index af7913d8db3a..282eaddd7532 100644
> --- a/board/amd/versal2/MAINTAINERS
> +++ b/board/amd/versal2/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_VERSAL2 BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
>   F:	arch/arm/dts/versal2*
>   F:	board/amd/
>   F:	configs/amd*
> diff --git a/board/xilinx/versal-net/MAINTAINERS b/board/xilinx/versal-net/MAINTAINERS
> index 50120a88d6e7..85d858ad3a01 100644
> --- a/board/xilinx/versal-net/MAINTAINERS
> +++ b/board/xilinx/versal-net/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_VERSAL_NET BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
>   F:	arch/arm/dts/versal-net*
>   F:	board/xilinx/versal-net/
>   F:	include/configs/xilinx_versal_net*
> diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINTAINERS
> index 07173ee916fd..00170a9cf665 100644
> --- a/board/xilinx/versal/MAINTAINERS
> +++ b/board/xilinx/versal/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_VERSAL BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
>   F:	arch/arm/dts/versal*
>   F:	board/xilinx/versal/
>   F:	include/configs/xilinx_versal*
> diff --git a/board/xilinx/zynq/MAINTAINERS b/board/xilinx/zynq/MAINTAINERS
> index 3eb1a451b580..d505a78ba667 100644
> --- a/board/xilinx/zynq/MAINTAINERS
> +++ b/board/xilinx/zynq/MAINTAINERS
> @@ -1,7 +1,7 @@
>   ZYNQ BOARD
>   M:	Michal Simek <monstr@monstr.eu>
>   S:	Maintained
> -T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
>   F:	arch/arm/dts/zynq-*
>   F:	board/xilinx/zynq/
>   F:	include/configs/zynq*.h
> diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTAINERS
> index de753c8fe4e5..dd585bae790b 100644
> --- a/board/xilinx/zynqmp/MAINTAINERS
> +++ b/board/xilinx/zynqmp/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_ZYNQMP BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
>   F:	arch/arm/dts/zynqmp-*
>   F:	arch/arm/dts/avnet-ultra96*
>   F:	board/xilinx/common/
> ---
> 

Applied.
M
