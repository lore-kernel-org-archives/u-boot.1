Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0840FCE064
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4777583AA9;
	Thu, 26 Feb 2026 13:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Sm/OKbfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38A883E85; Thu, 26 Feb 2026 13:19:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5D083642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOBYbjEJOEpgyoc+A5AFo0R0doj3U7zWWAxb3U0ov5bHAXUhZc5m3DNsfI3CGLB8Tf9ZxbezaHOHttNW2U/BacCxeoM+zAEEoRx5xWa+tcEjdRCR/jzmzYRIL6CmG97Px9+1hcGkbbDYgk3gaA37pJzNj5P3nfBrjup7fa9kkQDj6d7L8cFYpvg8Ln9/LxACDXBGZME8TY63yGNN2ISVq4tzCCUfoIo1XCm6MPzP6mAo+FI2c+Ya6ucGyvksKgv9yURaUjhLvBsm762RYnP+KIz/lnktnuD3+HSEO61tMVQMY4wNlzb9C09fphkbo5De3Njkw2I8F4YNdOe7AdviVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To+P82oIR6azfFwuG4PkcA/FVYwixWWdYfxrIlOkQ48=;
 b=luXORGnJV0J8bW/6jojOocmzjaSmzDzrAu1RvsCUXN95M8xYS9kUzWywmyC0V8SpXUsZYuTtJ6mww22cXU1/gobtneIQvp1yfSyWkTazyyjY/0xASYnLYLfOb/gxfEGa5veowcbvT3ZQnOzM1y0zdlqnx8oGh+9tmG2yclaBUX9hW7k07uOf7Gat2ACyyPAMbo47+izYPo81XjguXMNvL0omGP6shJUvT/uvG7VL4TDIAHZ/VapZatCS67RpO9WmMQlnlJWtWVUiTkmGfP7/0hC9yyyCzt3Qin6wn2MEUtOoU6PWuB7g7m5p4alSAIdiiBOkl+dTXuvI9dLgeiIMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To+P82oIR6azfFwuG4PkcA/FVYwixWWdYfxrIlOkQ48=;
 b=Sm/OKbfTnk8yNA7uACk2tGbTLTq45t94Sksvzig1tNaR9LM1mo+JAMEy0CYVJpwMLPE32I1GZ0Zuw+/cz6pNKP97FVsqz3VhedYacvmLCZE3/aE/gDgRRsGkHgLvU7ceDGuGyxUZKpURxt8DJkojTRrEtTUTGRsbJla6IkzFgl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 12:19:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:19:46 +0000
Message-ID: <91c68cc2-7be5-4930-bb67-303adaf0bacc@cherry.de>
Date: Thu, 26 Feb 2026 13:19:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm/mach-sc5xx: don't select non-existent
 GIC_600_CLEAR_RDPD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: Tom Rini <trini@konsulko.com>, adsp-linux@analog.com, u-boot@lists.denx.de
References: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 039de677-2861-4296-dc8c-08de75315495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: FyNeL/kXqD2S7eyTpWNOjjWTn0qKKDH20ISOQTyJRvAbB7F2NocYpEb5vu0hXGTZ6zAW3wzHDoWZtiSR2wGyRvWc2MJObH+KgKxk16Lr4hvOF6p9abRZGA/H7FmP0Sk8tWGRnuzRbcy2eKEnQiYhzFVcnMPZd4HLO9gEo2mXl1Fmaig1wSX4REUHMTLL2MCVL9K4avSYD3FjvfAAS0qFPUv436db7YUFonIe3qc7RuokOnbEdC99UurFRluWTGsKbeECjwRGpUUQJQ71uZ3jh+7CjXQzMV/6ufE1V94ckt2GdFgejlis8JUB2B9hnDyya3QOwVhLmkmeRKIOsZvKsT0+NWlj8UQ7/nHnOxiZ3sHE8zzskhYK/fMFJvrshubTL0HDpjXbnpy8kq39/O60CV0xQC7v+3MBEMOwozcvktEWAsS2foTRw5FBtx9BdS3x4qOR8HVn9QXIPHPAecFAM4QYPjULY7jTGuJ6lHMPYk8U3wR7gy8o8D3NazCVb8EvCUk9qqCkizop8EC9miaWpNksUkMbirBCpSwvKW0iKe9Y3acs679YTjMaOM22ADYxVGFGslb/dP7Ik0iWEpQemX8Q8CxokppvMM07SPxTJ0FtDMoaq4n+dmC0DA++WyLXWAIyCVt8tSK6knKCcaFBiExw6klKYI3Hd/KLTLZtYRWg+LQuQM892FsaK9C0M90lnQH9vLsWqLoFozUED8E3wYgrPZUe7r5xFhKrm509DAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFd0eFVqMVo5WG1SR1F4V2E1WHVkQWZVa05PNDdwU2thNWVnUE8rdkxhMHhT?=
 =?utf-8?B?eFdrT3JyYnV5TlpGU0taWWVhaVg0TzVwUDRwVDlaclZIdkFkT0FDLzZ4QW0x?=
 =?utf-8?B?aEZpSER5K0IzNmRZN0k0N1FBdGtNUkFFV3ZmZUlaZWpQRHZkTUJsUklYL3lw?=
 =?utf-8?B?ZGpHOUx1TjEzYU1yVmt1UlRrYU9YMUswZ3BFZUtGamM3Um1vS3VGVk1TTkRy?=
 =?utf-8?B?OENnY2lVQ3A1ZHV4RVBrTkJLN3ZzRTcwNzVwUUVucGNpODIyK2RSYVRad2xz?=
 =?utf-8?B?V3dmRzdTMkQxQnpFWEJZaitYOEFCSXBPbkNWZzZJVjI3b3ZYd1RMQVpjRjY0?=
 =?utf-8?B?MW8rbWNjVm9TRjNKYklCVFg1aS9SSjhPWTBwNXZvNFJUSTFMNXdJZ0hwQ3Vy?=
 =?utf-8?B?ZHRpWVZGTGY3eGZsTThyTW9HVVNsSEF0NlpEZ3Z1Y3VtTmdWNEludGhVOWVi?=
 =?utf-8?B?ZUJXUlZmNVhDeFFqZW9pSzBNRjJlYWNrRFBLeitDcVMwV0d2OVBFakFmTmxY?=
 =?utf-8?B?OEZmNU9kaHZyYStYTXpaMzh2djZhYXJKb1JlTWltaHA0aE95SDJjTW1TN0Vs?=
 =?utf-8?B?Szk3cnljcU9NZStnMDNHMVR1Z0t4M1JCS1I0dERVc052aUwrR2NOc0VLSkw1?=
 =?utf-8?B?cTFUaDBqY0lFY01VVG8yL0N1ZjFyVEtxSmZ2b1ZaWk1JR3pyaUQwcytjT0Vq?=
 =?utf-8?B?T1cwbysyNXFISDgzR08rS0RoRm1aU3V3Y0tOZEdhWVVxTkc3Nm1jNGU0VURx?=
 =?utf-8?B?dU96U1pmcFRJZjVWUFZsSFJiWkY1VFpiV1BHc1YvSUpXK1hzK0I0ZjI2SUFR?=
 =?utf-8?B?R0d0OFhsWGtldnAzemZOeGlxcXNZQU4yRDJuaXdrTUV6RlZzc3N5ZyszMGFX?=
 =?utf-8?B?M3pTODVxZlE2bWxjK2h0ZjJnamswOU01aGNiVm9tendTTVNaZGJzVnFkRVVO?=
 =?utf-8?B?NkRtLzJraStOdlcyV2pZZWNOU1drVVZseHdWSFBnK3pzdGc1UTZtSldmSkdW?=
 =?utf-8?B?THdRdkdmc2NFcTM1SkRHT2Rxem45UEoyY0FZZVNJTkxrR0p4WHh2S05MelVk?=
 =?utf-8?B?K0FkZU5xM0hXa1daV0oxOEhvaVhJL0xyRmx3VVJScW5mTlJJS1Z4QkpMVTht?=
 =?utf-8?B?VklBVHV5c1lmK1lGelpHUHIxUm01b1pOYnBIckx5NFZuem9xV0NZUG11cm9P?=
 =?utf-8?B?WGhJZjZrMC9ZbWhNUFN6VGV3R3htRjNSSFVTTkhNeEhJa3BMVThodFRoM1ZE?=
 =?utf-8?B?VDJvL3RYSHFKTDJvYXJuWS9SdEdFRjAvMEo0b3RadXdxdTRyMlh0TWQ5UWhR?=
 =?utf-8?B?QXNUZHIwSjJTcWJqL3hXdmlPeHBQeWF1aDN6T0dPR0lGYkF3SkZFSkRnNTBa?=
 =?utf-8?B?bzFYWDMybFJqejEzdUR3UTU3RnUzcUxMclBhMzgvKzQ0azdqR2Q4S01Ec0d1?=
 =?utf-8?B?NHJQa2ovWTMzbkdqaHF2UUxPMUY4U2Q3UEpKaWpNcG42M0RrNkw0N01NbUdT?=
 =?utf-8?B?dkNwVUVQZUQ2TUFCWjVESFdYZWx6dUU5aGMwMEVselBuTGU2OVh5MXlTUUhX?=
 =?utf-8?B?dk5vTVpReDlqcndWYzNkeG5zNjdLZExNazcvQnZGVzRzaUpWVUZ5S2oxZDB1?=
 =?utf-8?B?MzRYN0phNm1Ea0loT3NIRVM2S0xFM2IyTWdrZU1Bb2t4WkhlSGswSWNMYXNF?=
 =?utf-8?B?K0c1aVd1Ym5ONCs1aWhqalpKU1ZtN0Zsb3lvTmxUcFZpSm15TDNDWWZtODFV?=
 =?utf-8?B?aDFFcDRiNm03bmtJeGlKQTZ0WndoMEJBdkF4OVpwbUx5dXU3REgvZ1Z6aVpa?=
 =?utf-8?B?VGJVd2ZiVU5pL0J0STFZTnRIWTllWjlwaktLUGdmWnlZOXlMazQrYk81M2JG?=
 =?utf-8?B?V2lEamhyMGNMaTJnSExrZUNjTUFzUmNZQ2N2UG1udk44VWdvd2Rra3hKM0lm?=
 =?utf-8?B?ZmJOOFlPNlIyZjJuNE9mNkY0ZW1jWmNwdTFUWDhQdm54cStmNkM1enVnMVoy?=
 =?utf-8?B?SVNOMlV2R2pJTUhGYVhKSDJMaTNtdnhDQ1NPS0drR000NExFRWVicE5iM3lQ?=
 =?utf-8?B?SnZTYjBlTk1WKzc5SVVXV3FDby9NREhRMzJDcTR6dEhuVHpzRXRBVVFRUXNs?=
 =?utf-8?B?aFovRER0SXNsdllubkgvVTE0emI0SmF2eEdUeWRCeGF4cU8xOWkyRVV3dkc0?=
 =?utf-8?B?bUM5Zm5JQk8zSGxldGdQM0hDeWo1V2tSc254QVZka0pRSUhpSXFFSXE3TTVH?=
 =?utf-8?B?b0RjY3BJeDZqSmdrdVR3d09nd2FiQkY3Q1FYQ1BKRlk0TGtFKzF0dlJ1bXd6?=
 =?utf-8?B?aFJRT2F0K2FwMmtNMFM5cTAvT0Z2SFdZK3hGa0tDYkdPbldWTktlYzlOVTBE?=
 =?utf-8?Q?pLiyAs2QMUE9CMIk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 039de677-2861-4296-dc8c-08de75315495
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:19:46.7651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVpRJXMwHx4eBHbcJzjvIKw5mMzI38TgAt13Ca92WSpJ+o/8oo/YBg+Z31EHdmMJ88yo/jLYZUOQurKBdHGwXlB3346d4fheg4gGkXfvXFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465
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

Hi Heinrich,

On 2/25/26 7:19 AM, Heinrich Schuchardt wrote:
> The symbol CONFIG_GIC_600_CLEAR_RDPD does not exist.
> Don't select it.
> 

Fixes: 48a0b0b4b7d7 ("arch: arm: Add Analog Devices SC5xx machine type")
Fixes: 03de305ec48b ("Restore patch series "arm: dts: am62-beagleplay: 
Fix Beagleplay Ethernet"")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
