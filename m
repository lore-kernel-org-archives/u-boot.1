Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569A1CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 07:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF4D88D4A;
	Mon,  7 Oct 2024 09:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qemSpZVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669FD88D7D; Mon,  7 Oct 2024 09:31:47 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D8F885B3
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 09:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOPz99WPN0w7pzmZSLnKUUi8ZDXrQ8VKx1v8GBKMMzivfrTi0GVrBUi7YtQhJTumSHzl2N8xh1KphMOM7Eflje6knubelmlpbpIrdWCQnePtrPYWrxf0qPh4mXzg0Heg4biTc428vnhDLpNUAHdEKtEUkTjxgydGalo2qZFyIRp1GsraMoJZTj1R4e1SkKxEQiTKeQfSJe8oNRub70F+prEfMpy+IIB6V+tCg0Mr/3EOBjXLh4fUKLsg7Ioi+ntzuuALFMoYTnRk0AThiM3JYwf02LXDPndG/Ll10GAfaXl5DIlrGoEiWmMlax++aianYJr8xvaWViq0tUbIxGBQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouWA715djGbVn5aJVbTt1S5uydsWFImiDo5RHezo+4A=;
 b=A7iao+21dbCQLrKS+NVtGGxrdhd3gicvsguPU1EfeV7gniSXW6Pvq6XvHXvxUGug/h4RGAJG57BPIaoHNKAH4SkCLgMWopHtFKUEIugWetexC8H1EE84MDSnMaI9hVxSoP3s/3KTqAnjBbClByc8QjN3XCeBww2EiPPx7ShvSAIfMg7NCbUR8uq2xaMSg+HvcEfHBPt7Ovv/KrD4KZqxI2oMiv5Rx0l6xscQIms9zeRbfW+Zby+tUmL2kTNq4r/U9sJ/7IKJ2khixQu+VUMqtDw/aS7ByYUSuI61hZ9fugHUvRNVQ82MSRoaKNA7pyJWQoJySeA7s58QN0FjwL281g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouWA715djGbVn5aJVbTt1S5uydsWFImiDo5RHezo+4A=;
 b=qemSpZVA/GWFaBnbfBVZNmRwjBVTmx/PbRYNI0GLHQA4A26HHRrjQ/AR8VT6t1EBeUNqlIMuzBkYYRUjnQOTJqMHOuTtURlTME2gSZh3F+wX+YzZZ6qWjHb6pBf+M7wVrle/b2v8UUv682FxwZLF2zyd807vPlsNjL+QYWX0pjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:31:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:31:42 +0000
Message-ID: <700e3480-4196-4dd9-9ac1-134a0ad3a209@amd.com>
Date: Mon, 7 Oct 2024 09:31:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: versal: Remove description for USB1
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
References: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7635d18c-0fd5-4aa5-5b7e-08dce6a21702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXgwWTN6WXVrQ2NlMWNKbk8vR0svb25UN2c0eEdVanFycWVack14OVlNU2M0?=
 =?utf-8?B?OGYvYUNjaWhQRWFDWmxlbkljaWcyVktaZGRwQlNONUd5dHVENWo3NTRGNHN1?=
 =?utf-8?B?Si9nMkVrdDR2Y0oySkRMTzJPR1VQRFI1aHgyQWUwUGJ3aTUvczVuSjZtOHYr?=
 =?utf-8?B?UHBuMDUvd01jaXpZSmNHZmFBRDcwMWV4aVBnRVNnMG55cFJVNjBGZmN2OUYy?=
 =?utf-8?B?VnZkWDV3NVB0Nks3WTFVcmEzZ2Z0SHZCeVhLWEFOWWszNnhKUFRXb1RwY1JJ?=
 =?utf-8?B?eStMeWpvME9wZVZEczFQNzZZY0RZd01MRzMxa1hJcWlNanZMN1B0REh5bVdW?=
 =?utf-8?B?QVV1RFkrcElVSUtlY0k4ZWZhdFhGZWpjRGtyaTNMWVJ3WTNldXRCcUNsVWZo?=
 =?utf-8?B?d3NmQzhoQ3Nzc3U1RERFT2UyNVdUTVFRcW5TRDl1OFU4RUN4TTNkc2E1MEhP?=
 =?utf-8?B?SWVWZG0wUk1tSkx6MlpkRHVyNXdzYjdrRElyUUQwZ2tzc1dNVE5MUDJ5eWxL?=
 =?utf-8?B?WW90YVk0aW8zZGkyaFlTSHI2THdEdUQ1MGZwbnAyMU56NHhSZlJYejA5UnRY?=
 =?utf-8?B?MVZiNmYvOGsrQlozUHpwaEpQT3NPT000ai9DOFNaTDBZNitiLzQ0b1RaVGNo?=
 =?utf-8?B?M3VJODRvWWdldXdGODVpQUltK2RsUExSQUk0Q0cxV3N1cTh1Y0dJenVha0pJ?=
 =?utf-8?B?YTJBaDJEZE4ydEhXZ0t3YXV3VUIvbHk1TzdyYjRUMGRERUVEdko4YmpsWEJz?=
 =?utf-8?B?N1BmT2VabXV4WmtlSkFubG1ia21vSVI0S1dJM3h0QlMzYVdDRmRxc0g2N2ky?=
 =?utf-8?B?dDFhcjBEYlR5amVWRkIwYU45TnVLSzJGT3ZWUHNqaHBrSVZvT0FERzc0Zk02?=
 =?utf-8?B?OEFzRlY5R1dKY2dlTldrQmZIWk0rd2VYQWR0bTgvRlJSR0tqbWs5NkcrUEo5?=
 =?utf-8?B?dUQyYmpXNTl6eDFLRlZBcHE5UHRnem1ueVZCd1JKQllwRi8rWnZRQ2lqK0hE?=
 =?utf-8?B?Smw1R28rOFIvY3BNdG5jbkJNSW5USWxHQXJOZS9IbFhIZWpCanQySnRBeTBR?=
 =?utf-8?B?OEVmR01ZdTVTUmpyekNBRHFNNXY2RVU5UitCRit5SnIyS3dEVWJEcXphWVVa?=
 =?utf-8?B?OUMyaWtCKzBlTklhZUZWWkh1QVlWMEZMT094bXNGem1Ubm9YUDJxSnUzRkRF?=
 =?utf-8?B?OHN5RGhwY2FuUTlaQnpTSm10RHlxUGRyOE9kaFRETUZPU3JyMzVnVWtKelVV?=
 =?utf-8?B?cVlHMkdDeWNPS2lFM2RTYlJvR2p0MDJNZU9LcTc3L1AyU21vYW5La0NXdGIr?=
 =?utf-8?B?T0k5SVk3aFZ4RGFRcE16U3RTZFVBN2VkVDZYWldiS0VodmthdTlhRlhDeUs5?=
 =?utf-8?B?WTRjZkNrOWJhSHBIOGVBTkJZeEdpand5bHdnOEZNelM4ZzdrNUtybTVPRGVw?=
 =?utf-8?B?aFRveWZGUkIyYkRwN2txbDJSU3A4ZTZINUVTYXU3dFFCUnBMNXZ6VURLSmwz?=
 =?utf-8?B?M1p3bXp5STVrd1NzdXJ4U25DUFBiNytNN0h1UWtCZWNmSUQzYlFTcHFYMjEv?=
 =?utf-8?B?ektFNUl2M3NOOE9WMzV5Y29jSy9EY01vcVBHK2JFTkowMGdQZ0JYWVhYOW96?=
 =?utf-8?B?SGFvVHVpZXR1N0szTUtMTW5XM1dDK2dxNnB2Y2x0Q01WK0lHNFlWNzBhUHIz?=
 =?utf-8?B?cXh0TUJmRDhPZTNBSWIrRXZmWlNMR0hqSktKbHBFY2phRTdoMEdrUE9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRJeDc1THAvbHNubDF6clFKRkgvTGl6QjA5R0oraThDYUR5bnNTU1BhM1o4?=
 =?utf-8?B?Uk1Td0wwU29BZVV0WC9jSmtUYjlmdTRlNi9jZlVLUXdtMUc3LzVkYzhlTVh5?=
 =?utf-8?B?WFZyUTVUWDFwa0hHa1N1S2RyU0huZXlScXY0czN1bisxbnRYWXV3aG4rSm5K?=
 =?utf-8?B?NmVIUldGSGpzUzlUbjFvS0xtYkNNNXFNeVBLZEZ2SGVuZjFsZHVNaEViNXA3?=
 =?utf-8?B?N2lRZHkxRSs4UU9rdjVWVThUUEdoTWZESHlRd0ppc3dOWkppY2tFRjNwN1di?=
 =?utf-8?B?cFhYZDFQV3lCUWZOWHY0dTJPeDZSWWVINFhsTy91NWp4U2xVWkVaMWJ2TCtT?=
 =?utf-8?B?cFZjejF3VjExQU5ZWkZpMVp5VWJjOFRURnZWZnFuell3UEJXa1Q1dG9JaWpB?=
 =?utf-8?B?bFpFM0h5dXVka1dacW0yMUxLaTJXaWxJNEtHZVpTTnhKTXc2di96YWcxWDBY?=
 =?utf-8?B?SmNSQkpFcmNwbEJ0SjRJVTVGcWVpZDBlZmNzTy9IZmhCK1RyUEx3aVo1SGd5?=
 =?utf-8?B?dHJ5ZldYVjA5cnYvYzF6bGR2WEY0RkkrbzlsMGRISmJEU3YyK0xpS1cyR0hh?=
 =?utf-8?B?VUlyODZlK0wwY095d3hWNThaTW15by9ZLzhKZ0FPMXkyQTk3N2dlVXhNWFdF?=
 =?utf-8?B?QVRMVjB6dGsvcHZaMU1ZbmtVd3hGMmdtRVIwVzdMMkhieUxpM2t2YXJ0UkNI?=
 =?utf-8?B?SlNYZ3VGOVVZS01ERVFXcy9RRUdOdGVJMDVOMEhmbUovb3hzVi9QV2YzZFBw?=
 =?utf-8?B?Nnh1ZFVkenlXcnZqQ25lcFFnZjNPWVVVaUxybmd1cGxFSW5OeUNudWRES3N3?=
 =?utf-8?B?aHovU2oya1RzcENXNjE2L255aTVDeVErcUkyWEY3a3IzWTJVNldQWlhBL1RU?=
 =?utf-8?B?T1pBMVRYdzhRMVZRMGZ6VVZPMytxYzAxaU8yUjZRZlVLbEYzWGNHUXNiVHJN?=
 =?utf-8?B?ZnVnbmo2TGNHazFpQXQ1N25GOXRHbTFVZVl3ZnIvWUZ5TStkYzBUZWJBUVBS?=
 =?utf-8?B?VEFsSDlEbzYwTTlEZTg5SUlvem9OYzY4SVRhMzIrOW1ZWUI1WG1HYTlJNTZ0?=
 =?utf-8?B?cFVTN01jNnkxZ1FMdDJjQVlXc3pwYmRFUUdzWnpid1dkb0lnZ2pqSXFlQlJN?=
 =?utf-8?B?R05xeU8vUTdEUnBGaDhtZTlkVVRtcGVsd1BWWU55UkxKWVpDcWNnYm1ORnBX?=
 =?utf-8?B?RVYrQW90dGRPTFZ6OG5VNXlFSitZNGpDOElPbnF2RlhhTWhHR1JNM29mMVlY?=
 =?utf-8?B?OTVjYm9jSTRMQ1NGNk1yaUl5VVFldTZFbDR5Rm1JRTFRQ0tiQkV6cVpkbGR3?=
 =?utf-8?B?d1hDbHczRXRXbWpYbXprZHZ0SmdkUTNOOGNKYmFvcC9RUEZwUzlyRFFUZE9p?=
 =?utf-8?B?eDlCUndhakdKemVZUTN1aHVsVGQ2dWwrOTczbVhJZ2JGU1pvTGRoTmdaZ3hv?=
 =?utf-8?B?Qm1XNzNGSGZMVU1NNDA5VDVMbktMTUJTSGgyTTJqRi85OUxXVlR1RDIzWnQx?=
 =?utf-8?B?RkE4U1o5djBTT0taUEtKdTZhUnh2cHM4S083RFU4Rk14SVUxRVFrbGFCSUpx?=
 =?utf-8?B?K0xVRFpKN3VHSnlyOTZvUUZqcGNkL09Eb01EMGdiODlqYUdxRnpYem5uK0lk?=
 =?utf-8?B?KzJNbHVNczVySExqUkpsbi9HUFNkSUlqSythTUFoT0hsbUE4bFN2WXFDelJl?=
 =?utf-8?B?Y2FRSDZZWG9NMWlzVVd1cCs0ODNNTnJrRUZoQkU2djBNWk9YbFBCTyszWktn?=
 =?utf-8?B?dEorL0VJR1VwUFRyRU1Ca2EvODUrV2o5SUoxZ2R5TUlzelZhWVZSUlJSNkpq?=
 =?utf-8?B?eHNkQmMzdGcvRTZpUm1nUzZVb0dwdkNWQnZjOEt6Z0h5UWl2VGlrSUxsTXRk?=
 =?utf-8?B?MHA2emNvL2dVSVhiVFB5ZW5Eb2JtTnBTck1RSW9jQlMzaGdlcGh6MGhRQTZ5?=
 =?utf-8?B?L0FhRWR6Zkk5WENKck5FRVJXSEhreGh1OVNEcTdNL1V5T25TcmdqZmJzUmtS?=
 =?utf-8?B?WXVNVk1MZnc3S2w3K3BySjNqb1h3R3YyUVJuTklTREllampqNENJeWo4c2ZD?=
 =?utf-8?B?cFpHazZHRmlYcGZ1N3gwM0xtK0ErYnVRcmM2azBPRHo2OW5WRXh4eHZJNVVM?=
 =?utf-8?Q?+hfZvjzWx3b4ovXtpbwnssRPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7635d18c-0fd5-4aa5-5b7e-08dce6a21702
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:31:42.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVhZFY5WrtuK8lyXgZxhSLncsG36rkH29EpRMD1TNx/72wmUOK1i8WqtgzgFW0Jf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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



On 9/30/24 13:03, Michal Simek wrote:
> There is only one USB controller that's why remove description for USB1.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/xilinx_versal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
> index dc3f41b94a29..212dc9df2a2e 100644
> --- a/include/configs/xilinx_versal.h
> +++ b/include/configs/xilinx_versal.h
> @@ -85,7 +85,7 @@
>   	"jtag "
>   
>   #define BOOT_TARGET_DEVICES_USB_DFU(func) \
> -	func(USB_DFU, usb_dfu, 0) func(USB_DFU, usb_dfu, 1)
> +	func(USB_DFU, usb_dfu, 0)
>   
>   #define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance) \
>   	"bootcmd_" #devtypel #instance "=setenv dfu_alt_info boot.scr ram " \
> @@ -99,7 +99,7 @@
>   	""
>   
>   #define BOOT_TARGET_DEVICES_USB_THOR(func) \
> -	func(USB_THOR, usb_thor, 0) func(USB_THOR, usb_thor, 1)
> +	func(USB_THOR, usb_thor, 0)
>   
>   #define BOOTENV_DEV_USB_THOR(devtypeu, devtypel, instance) \
>   	"bootcmd_" #devtypel #instance "=setenv dfu_alt_info boot.scr ram " \

applied.
M
