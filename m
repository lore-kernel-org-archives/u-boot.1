Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC92EDEBFA
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 21:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9C983E7F;
	Tue,  3 Mar 2026 22:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="W/fMGQMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3188683F2D; Tue,  3 Mar 2026 18:00:27 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80410838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 18:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms3FWwTJkiXDQkMGu0u9sBAthzOW86VkO8lPBQMAchaCTJ4UwaRRan2VRkfDyXXaVPJlprbtdGNLW+lKJlEwGjLCKb7EmcD/8p0thyeQzzAeAHPHr4Z5nj1K1MR5psM/EeE9BdPJDKx16qnPaVA3khMmFjKbTzrZ9T1+D9t0sdzxzJgjyKLr71CNbQ6ul4YwLPvhLreRXUxtbXHzu5KYkoxpMIZP4fxyHCYbs+bLeL7gS4d0C9jWyBQsdsRhUQ849COwDvaG2A2AlhzNKKQFygFkPM6jmDPi5vITCQdo+4HwZDutEbw3/NQXvzr/Vf+rDoDOwXjVIYh7FSfB9IKVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akft96oLd/Dd9NKNLiQtoFwupMT95ItPdjmQin8VP7k=;
 b=ssTODi02rivTqy31tMYbjBDD5g9e4frnoHe0e/nreCdegXd0voyMEnJ49P1XcI2rwRDZdGjUYxe1a/BTM6CUhQfQ1Rd9UatXUgwDfalss9rj0/nj+8FC/oxcqekLgxYrvVOrPvI+gLK8qrYl2oGcjzRUbeX9RlKzeRazkGSWViIT7lCasvYSLnHy3ryf4EzUMAeNsUQB9Sc7zUaK+uQuiAiYYXdcW902GnRybRwGYMs1sEbmxFB0aPa/eHpc2xNvlB38WObliXqbUM5mcIl/GOuy4mEsfJcMm/3PKZUH5hCbYqaJFU+C8MOS8VMSuTRv4kOvJ/WoouDT/b1Y2W/HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akft96oLd/Dd9NKNLiQtoFwupMT95ItPdjmQin8VP7k=;
 b=W/fMGQMTvGdzUkMBcm8GUjlvIqIsYPvmrAgbaHtg0DHj1p5ReAfFtNatGHoYHdHkZTDWffHMACbFwLStH2k+SvrbW1mTnGOQC0Fak2psZqjzzgFWff6WHsGtxnBkbdVMettP3aImJl2VNTV0GWFe8jDjn4PVn++qwuYikkUp0BdOzLO6ROB01i603npaowmnXyPb6S+/WiWwDEeXS5Sr6HyIsGVLNGmYdezXbi7Dyz5kIQReEBK7Dqo9KRHY/FPzikCqF606myXJeQRqJgPtzGHHo0mJDNX2gE5UJ3El/3e73G2pbMlRptJAFgBKuMediiHXBS9qQLkzMfgyaKE1Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS7PR03MB5654.namprd03.prod.outlook.com (2603:10b6:5:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:00:20 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 17:00:20 +0000
Message-ID: <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
Date: Wed, 4 Mar 2026 01:00:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
To: Conor Dooley <conor@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
Content-Language: en-US
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
In-Reply-To: <20260303-choosing-chivalry-6f892a14eaef@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS7PR03MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: d772e92f-2aa5-46e9-8c64-08de79465a28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: nllXm+ULhQMQpz3/u2s2/TYXBt3qY6DoUQesVbMb+AWk8Q85eM07RbJtIB2T/o5IPVL42qFV3jxj4JxuZj48ctx/+weCpR+oUlUxEfRDc30UJ5YtxPIrGFYkPYUcYXkB1uK+1PGZSYwIJkbSd3zxGpA7JVM0xlxkVClbks7PpOJRRsAmX3nEs0q86AyM3mwfqZtJzrpVB7BdInrDnlnRKaol3/qk1W+UNr/vBiq5cJkbWdgfejbXj/FChRkYnIWwYTj2VtmPVRuLZQoxclCADAYihPiPiZAz/4Nw+caUkbtrW7RFvmNuGvkYlUI3dLP6YguBeqkZfZtyRRFRzfyYZ+oaIjihhrjL8r20UGlHz+m6glb/d2BiW4bYgkHazTLea4tE5l1JAk7vaUaLRKQYeRfG15uAWEj2ng8YCwQQwpBPVTyMoaIYGhB7XsQAgAUVd/M4WlK88wIE4O9dglT/VnPpB+Yv0WHp5dfxmFXLMZMKSukgMXZG/wjcsupJflXKk1iETTduj8XoJzOCz4XPt97EfGXEMnHgG3uxRt+Z0OJhjFhlKOgGBCZCAaeSZ8hLasJYw3+/1Ilih4jdV6Q/Kiq0Ltn178DvEO6skHEuHPIb9H50S+yQg/4q6XWPEhOXFucxEXx5PeOJeq1QncCtZ0XjxCR/WbhMIb/jBiJjzRxD7yZR4BqTDKA29wCH2t0C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0dnWkpoZUhxRDR4WTNuYzQya2l6VVdYbVBRZVpiR05QNG5ROXN3ZFJOSTJn?=
 =?utf-8?B?N2NIZTlSRjFGSjdTSVJDR0RGTUt3K1F3SWRBVStpOEVqdEwyQXJlZUczZW5J?=
 =?utf-8?B?djZIWUVQTWl6OGpzc29sb3ZFTmsrU1o4aG4xa2JkN0ZSK1NXK0hBVkxIQTJZ?=
 =?utf-8?B?bTBjaS83b3dzeGg5RDlnM2xXUzZqWEJzTGI0ODViNmRPOUYwbFkwbXEwelRn?=
 =?utf-8?B?ZEpzMGd3cnE1WlYwVHhzeHJVOFJpb2luN3FkVllTd2hsVVh1Y0drQmtxTGNn?=
 =?utf-8?B?aFo4V0pLemQrajhLSjRGNmR3c3RhWjVkQy9mNTZjeFVjRi9mVlI0TVcrOEd5?=
 =?utf-8?B?ZGVtNTArYjhybWF5UUwvSloyMGRLRzdhS05EbEhtUW9hUWgvK3NIdE9oczkz?=
 =?utf-8?B?ZVRzd1lDQ1dyQjNUblE3RXRjTmFtZURiSkREcGNuZVRRVi85amk3K1hYWTlR?=
 =?utf-8?B?RlBnL1NPTnI3OUpQdjlWRXo0VjloL255WGFRUm5GK0piVk9wdUdkdUVocVpU?=
 =?utf-8?B?RDJlQWNoUVZEZnBmUUkzdTlWK3EzUkpjcUVXZVFOVTBnWm5FRUxneHZJSC95?=
 =?utf-8?B?NFhQc0hmTDZRclBxZGtZVWpVbHl1N3RKU2pwNjlYTjNBUWU3NllYdEQwa2w3?=
 =?utf-8?B?S0hXNUZnSzVyM042RThIRzJUK0c3enRJUFZPYXE1dG1CcEx1QlA1cnlJUmdr?=
 =?utf-8?B?NnIzMG1la01WTTdya0hKSWZ0Umg1bUY3RFF3WFNCWjlwLzczaUVGdy9wZDdi?=
 =?utf-8?B?Y1NVcWhoblN2OXE2THFvL3lBc1JnV293WHpSbzdqOVVUTUZVRjRyNlhQZWRi?=
 =?utf-8?B?Sk5IaTBheUtVYlM1elVrZjR2V3g5VXhQdzRwazVGbmJ0R3RtM1IvajVEZjQ3?=
 =?utf-8?B?Yi9yZXE2VHBLVU9weHlaU29CUElRMWgwc09YUG04Rkp2b0JFOGtIcXB5WG5o?=
 =?utf-8?B?aEdsd1NoMzFxQ3E3b3M3R0tPYS9kWVN2Unl0L0xEYzExdTNSLzBHTW96cFY2?=
 =?utf-8?B?MlZWbUl0WElyQlEweXFEOWhCTWVoVEdxMVJiQnArcUVrWS9RTG1OQU9oUkU1?=
 =?utf-8?B?Yms4Yk84TVhoS25TZngyRzd4VnpNTEg5T3NVd1FINExWd09GdmhKNmdOQ1Fk?=
 =?utf-8?B?QzZtSVFxS0NUT1ZVVmFENGVQN0x5OGMzRGZ2MGJDSjRkNkRkS2xrOUJYaGs5?=
 =?utf-8?B?Sjg2OUUyeEdvY2E1RTZ6ZU9hbUN5RUIwZzIzdjBKVTh3OG5XRUVCMmUyQmds?=
 =?utf-8?B?aW9uMFBPZWF5Z2FhUkRRTm41Wm5DdXEwQUh3UG56U2c1anFGbFpKNkc5bDdq?=
 =?utf-8?B?Q1djSjJtVFlJUVh0OWUwRkl0dXRHY2dob0xuNVpTSnVWNE5kSTNrZjgwMGI2?=
 =?utf-8?B?RFc1aFRDTjBCaExJQ1dEL2I0em5DaEh5T2dhVm81aVhSY1NsWjJjamh0dU0r?=
 =?utf-8?B?dkNtc0hqb3d1ekFhZHRVZUFhTmFZTnRNdkphcWExYkxPTE5RbkRCSDMrTkJM?=
 =?utf-8?B?OWFsTHhzYVZQMFVFL2V6cGVMalRIRjBKSE93aVhZL1FiWlVMVzVXMTJqbDJi?=
 =?utf-8?B?K09qYUJMY3hMYTZzeExRK21DL2hhaEJFWUZIY3psL215N1F4K0VSTmNSN1N3?=
 =?utf-8?B?MUJpSXBkaFNIei8vUEQyZWxYMllBa0tYSGRWdU5jUW1XVEJYNG5ZcllxajZG?=
 =?utf-8?B?cUZLK3h1ZGtVNGlRVnhXbFEvTjhxTklVT2sxQ095Mzl3bDBxNmF4UWJSS3N6?=
 =?utf-8?B?WnhFUzZJSHNuQ2twd0k0N0wrMjlWQmRxZnZjc3U5NTI1aDBQZjlORjdwUzNI?=
 =?utf-8?B?cHY3SC8xSUVndVZPSG5laFRTNVl6RXN2QmZvMGgvSDNhMTBFMndVOG5QWVBG?=
 =?utf-8?B?NFhlY0QyMzIvdzl0TVhEVGFBSDFSSnNOdGszYVhHdEIydTJldWFOY1pxdWgv?=
 =?utf-8?B?Vi9mVkt3cFhUWDZha1ludXVFNmh2ZW1lVnZJdmxodXFNUzk5dEFjamErTU94?=
 =?utf-8?B?N0tRbURvZEw3MnRZeFlUcEl3S09wekRsREhRa2llU05zQVdhc01makExcTh1?=
 =?utf-8?B?cTR5dUJ0WDQ4OUQvaXFkcENUamUwbU1mWmdWcThiS0NBOWs2cFRxQWNQLy9G?=
 =?utf-8?B?NEFYZm9wVXVmMXVhamFuWnByR3EyclVmQk8wMzNUOU1icE1IdCtLN1FId0ZQ?=
 =?utf-8?B?dGZOVW5YYmtkaC9zK0VheEtxTEwzNVplcS9jakRmZC9HYWQ5TGJJVWFUSkFW?=
 =?utf-8?B?cGRsdzgvZUJ5YWtacVVuUkFSR0FBTU83MlBrOWd1ZWVUWE8wK3U0bXFoMEJi?=
 =?utf-8?B?NlZsYjR3T1N0Z0pvODhWNTFtUDNOMmFSVzh2b201YkZHMkV3cTlWMFNzeW9O?=
 =?utf-8?Q?IjGM72S/ey00+DT8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d772e92f-2aa5-46e9-8c64-08de79465a28
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:00:20.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtKMKqkECx1whPmoON4TVMVYSs9RrfagqoRdqhDRB7dSXfzNYF4CBTzwyMJILAlZcsd+VhEzo2NNQeJfQnGCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5654
X-Mailman-Approved-At: Tue, 03 Mar 2026 22:54:42 +0100
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

Hi Conor, Tom,

>> Why would this be inappropraite for the Linux kernel, once the system is
>> fully supported in Linux is the first question to answer. Thanks.

As Conor mentioned, the bits_per_word setting is obtained from the 
controller and validated at runtime.

Additionally, bits_per_word can also be sourced from ACPI, as shown in 
the Linux SPI driver code

https://github.com/torvalds/linux/blob/af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08/drivers/spi/spi.c#L2739C7-L2739C20

> in its spi_device struct. I don't know if u-boot has similar
> functionality in its code, but looking at dm_spi_slave_plat which I
> think is your version of spi_device, that information is not there.
> 
Currently, U-Boot only supports an hardcoded 8-bit bits_per_word 
configuration.

> Were this submitted to linux with the current explanation, the feedback
> would be to set bits_per_word in the driver for whatever this "chip"
> that's being talked about is, presumably that means setting it in some
> sort of clock driver given that it controls a PLL?
> 
No, this isn't required by Linux, as the PLL only needs to be configured 
during the initial stage. This commit is specifically necessary for 
supporting the Agilex Smart NIC board, and I'm currently preparing 
patches for upstream submission. More details on the chip can be found, 
https://www.microchip.com/en-us/product/zl30793

Below is the link to the Smart NIC board:
https://www.silicom-usa.com/pr/4g-5g-products/4g-5g-adapters/fpga-smartnic-n6010-intel-based/

Below is the link to the patches I am preparing for upstream submission:
https://github.com/altera-fpga/u-boot-socfpga/blob/socfpga_v2025.10/board/intel/agilex-n6010/plldata.c

-- 
 >
