Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8890DCCF2D2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24F0839DF;
	Mon, 19 Jan 2026 10:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VJ85lCg3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VJ85lCg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC89839E8; Mon, 19 Jan 2026 10:30:23 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9557F83956
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NVAFl2TWud2NZmCWUvLUxJ9ih/aC2Vo3rq+TM1rFH2IbzZIv4zpk/gTKpNFI2UtDGt8uoBwBrnDT1LqQdGVp/vVlBr82/bsoC2qpcuCOvGAJ8GyoUXz8UzJnFkeOt7osNIGh/SHrDayfWjLuzh0AylvjiS/ANkFErC+47s4QjGH5IT1KTe7x+zP1CRIzMiQsTp4hugjnwDWwm6/aMpKMR52WspkPef5rHZyL/9va3hixjkIoH90DwbANpde+OCE1pvddpjlhN2C3X3n9MC4o5viaBRPEwo171ab1TZtTsoxdkRM/l0rVo/4GjRpvQTKpe6mZD3rHjCHI5av2yRDS/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrmcnYJ74XUl6/MByzYlvqJaYNsW5a8XvOm2BNlv328=;
 b=hN00jJOLW4lR3kgWWuy46zV1uxJLM/izuw6+TLnDPaH8a8LrGI8rfGdUKX0FkNDCljDuVJeRbju005+d7rmcwZOKwSmnTdEAB3qWPh33rSB5JkB3KW12kEIGmF8m4ZnG8dxjeOqBe3xRO9sqmoEsS/Bu+MPRWRQF0gTEVA3+YhDYkgn2yO5DwHwd912teovo92yj2wpbcJjejmV20KOqpbYUsUVrYV2cKLAMFdHWSYatZ4G9HKX8ttdAQZQQDW2vz41+Jo/Xuf3S03xQGkCLjx/ChG2FqXVqLiCnjqdTSeIiR6qbnuOPHO14MNZRF1pbnXSs3isc6st0zMAj7686ZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrmcnYJ74XUl6/MByzYlvqJaYNsW5a8XvOm2BNlv328=;
 b=VJ85lCg3Oj/5JceF/YB/wdE48TTGzDBma12gXb9ky2TqfnBIyA4Xg+IIt9KXh159woodBZ6u7kdYZu8wYqQJzIFyiZRH1XC29kQh1kMu7i1R19LEHxTMEWkS/OjkA3BOPQnmxSvFACECStx8YoEEaLcnC1o1LB5zXlFhJeSacHg=
Received: from CWLP123CA0250.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::10)
 by DB9PR08MB6475.eurprd08.prod.outlook.com (2603:10a6:10:253::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:30:14 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::59) by CWLP123CA0250.outlook.office365.com
 (2603:10a6:400:19e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrzmwi1xvd4QTHKtvr7PyeXTnj9e/ufZTAal2+0wXg4Vi0tsJ/1eOSiicOAEzsYbLfYjIey2gz+LqgG/tBL6FiU57oiy4afu1Ny7bGzZFTDHE2SSOjsSeHS+QtKtxdifJCXSb1/plx5ee7txoN9590/Gz0Tgf7VAWq53Q5f+OpdvZGFcC3RlHaO8MehkOHZ16jfZyGNfLW8IQbpvl3qxu9ebsQI9A9fILnw3ANF6CIu2F+44OkUyqt4CHLbWjuFTJeOnIEcp4Z74uMoONtRLXDAxImB0CcPNjEocDHxqEN6JCBvkSUTE/f2YYYpb4n5b4MkShOnUReW0G4zRF+BhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrmcnYJ74XUl6/MByzYlvqJaYNsW5a8XvOm2BNlv328=;
 b=N1x1MdZXl3QIvBhR8Yf8mW/tttHqai7Wqlb4ONObIyc0ECLiu96SNPQgi8WhtXzVUHYztm4fAKxgwP3wVYGiiltZ/gBbIMwPGZ0Nwl9XWRdnhAfbrz/8Pp/vuWW/1K/+2iGVunwg7TYsYa83WR8aTkDEqHUm5oUCb97v2QrACvCmFVyEPaSv0e7q4j7NbkmfC8kTHSEsEUrs8AFlYMSjen+Mbc54iKkEc3mLGmYgRYOS1RCK6BznGDIfejhLM4DBb/zFdbdJMBbPa1NvuIWnC2qfbKw6QRYAeMkxZPeVtv2LZG5TpE9bbYwBgWcYxSvyy7QqCQLTGawEojz69QKkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrmcnYJ74XUl6/MByzYlvqJaYNsW5a8XvOm2BNlv328=;
 b=VJ85lCg3Oj/5JceF/YB/wdE48TTGzDBma12gXb9ky2TqfnBIyA4Xg+IIt9KXh159woodBZ6u7kdYZu8wYqQJzIFyiZRH1XC29kQh1kMu7i1R19LEHxTMEWkS/OjkA3BOPQnmxSvFACECStx8YoEEaLcnC1o1LB5zXlFhJeSacHg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB7929.eurprd08.prod.outlook.com
 (2603:10a6:150:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:16:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:16:03 +0000
Message-ID: <ab7d4b24-6986-45b8-9cd9-365dd359d685@arm.com>
Date: Mon, 19 Jan 2026 10:15:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] net: lwip: Use ipaddr helpers
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-5-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260117002452.1026310-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB7929:EE_|AM4PEPF00027A69:EE_|DB9PR08MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6634ab37-f129-4c68-1d6d-08de573d5797
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Y1YwRVc0c09uOElzQkdYVFBRK0JPUFFwc0ZVQmNjcUZXSWRIY0d5Y1d3V3py?=
 =?utf-8?B?Mm9jdWpIdktwY25UZktrenRaSjVNMTQ0bFo4aWRySnNzcmtQMjBJb2paSjdz?=
 =?utf-8?B?Q1FxU29CanFaaDltNEUrblNnYzAwckpNZHEyaFdTcmpjc1dMNmcrODZvU0xm?=
 =?utf-8?B?TWJmSERuL1lwa2JyTzdqUktob3JNbkd2WFhNamFOZUFSL3g3aFRYVnAvMktX?=
 =?utf-8?B?Q0ptNG9RUWtlVm9MbHlnaGJlTU5qMVF1bEtIQVVwajR2eE0rMkk2d3ZRVVU2?=
 =?utf-8?B?VjJYZVhSdnhMeGdsUWs4dkFocnZHUHptRzBYU3RudWxSM2YxT2ZSSHNpcFhm?=
 =?utf-8?B?RzhHSXRvVHpDOHBSdnAxeDNLSHNzMmYzaEpjcndJSTNuVGhsaEQyNHJ5c0VF?=
 =?utf-8?B?N1l4cEc5QnM5NXY2Vnd6T1BKMHluMG9mOE5qVzV1UnBWd3Bjcm52VWd5WFFX?=
 =?utf-8?B?b2M2aktrTWNIY1FwVGRNYW9TZ1JkT0xzYWVnY2JZQVNEd3hLeFA0NG5HbHo5?=
 =?utf-8?B?MnY5YUt5T3UraHdWYnhFcFNhU0xtbURtclJ0VlF1KzR2ZXkvVEdVTHdGVVJI?=
 =?utf-8?B?QnpxcXM5cFVyNXFRRUh6RFJLZjlMMzFZakZZdEdGeTA3NHpGWXJSSk9sRGlR?=
 =?utf-8?B?Z0hSSFBPdlRWZmFuRUxFcXZGdm5UTFlBdVVBaVI4U1dONVhjeGtwRTN5OXFL?=
 =?utf-8?B?Ymg2ZU9rd1dnQ2hMREQ4K1ovYTdDSlZSRlIxYkFzQ3dVTVBFRG5RaFFOMmtE?=
 =?utf-8?B?MGpDb3dYN21UUTFwcVEraUlXUjdtMlY4ZjFQa241QUpONEdmdmlMa2QvOUtI?=
 =?utf-8?B?UTdZWXVTM0RPN0RVRlNTT2g5L1pibmx1blVXZTJiUXNrY3p4K1JEY2pkdy9B?=
 =?utf-8?B?LzE2VmtwUzJNeDVmVFNjb0JTYUlibzVCMnNFNUUyYVRTdHF5bXpyeUtiNHY0?=
 =?utf-8?B?TjRLM2VHd1I5UVU3cGwzOWx3WG9mTWQyVmRCOXR4dnN4d3orRGxKUWpiN21M?=
 =?utf-8?B?Zi9JL0k4WWhML0MyRnVZNmVBSlFJU0RDM3M4MW9HSjQ0ZUFTdUtWazFaK2Nz?=
 =?utf-8?B?TWVLdkxTeFl5WkIvRWcxRUtzTHFLQ2wyemcxTXBnTlBhZ0tnbWdPOWREckxM?=
 =?utf-8?B?aVhaK2dweThYUHhjTG42aWJJb29VYktGMDg4Q3R3cXZsTVhEM0V2Q0hxeXc1?=
 =?utf-8?B?Vi9YWDNtOTEzak1xK2JhTngwWUpaZE9FT0pEV1FxT283WEhoYmt6bjlpUlpq?=
 =?utf-8?B?ZDJzaVJqU0pkWUVLNFkybk16SkVMT1hOUWEyL1RMNi9BWldtbE05ZGtxWklj?=
 =?utf-8?B?VEhJK2U1bU5zTUtBVmpiLy9yRUtzUVZCSUNFdmwyNEJ0MGNJRGNCUnJsajBS?=
 =?utf-8?B?TGtjOXI4RE5INU16bjl6TWQvMXU2RWtmUTg3TkMzdi9SazJ1WXVrNVZOVFJF?=
 =?utf-8?B?Y3ZaNmNBSEpRNUU5Q2t0Rkl3Y2FHUUpnTW5KNzlNV3l4bEJXVmJWTmRGa1pn?=
 =?utf-8?B?dEJ0Z0hLSE4zS1JaeUgrM2xIdGRiWTVOUmNnVFZUWk0wdSt4Z0lFNW95WnNV?=
 =?utf-8?B?dDJ2ZnBUQWs3M29uWkwvOUhzbFFiSE41RDRaUVVrT3E3NmhCS3hRdncrYzNn?=
 =?utf-8?B?MlJsZ1Q4ME1PRzYwQng5WmFSazJ0MkRxbDhBbzFIZS9ZTDhoOTJnTjE4Si9q?=
 =?utf-8?B?S1hnbm1aTW9iOVR0cXFUWHJvdXVTUFNaVkw1ZU1IdXVJalZadDVhTnY0RWRZ?=
 =?utf-8?B?OUIyR2JrbVFrbXRPZkk2emRwTHN4WEp0ekdyMm81QW9MSVVwZHFEUmI3NFJp?=
 =?utf-8?B?VXozeXhGY3Z5alB2M2JyS1dzOWFFSFd2Njd0a2phc0FNU0hEN3BhaUpKT0pR?=
 =?utf-8?B?Qm9TY3dvODVsMWs0YlNZbWpNWVpQNHYvUVdqc3EzSE5kUWxpWDBlSCtpRGdp?=
 =?utf-8?B?Y0NwbXI3K2lTbmh6T2tMZVVJUmVnbnNBVG1sVXlKSERVYXJDRnVFaUxiTkVL?=
 =?utf-8?B?anRTMzNyZytLSjZ6Q2M4aGlPRjd2VjJlRHhhUGlzOUJJV1hDSFFzQ0E0T2h0?=
 =?utf-8?B?Umo5Rld2alhEUUNHWmVPYllZZk8wSFlNNUljVXcwNnBuQm1mS1ZISVFGTGQ0?=
 =?utf-8?Q?YHNw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7f894e6-37a2-4d08-7f59-08de573b5ec3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|36860700013|82310400026|376014|14060799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTJjWDZQWWxJZXJaSTBDa1VlckVDeHJITTQ3SlAzanl5RnA2em9zMVo2OVlV?=
 =?utf-8?B?cDdIbGpRem83ZnVXa1VQNHAzeGl2MmplM0NUd2lPU2hPWFFITDBLRVQrWE1j?=
 =?utf-8?B?NElGdVRxQVQvWXZsd0hyUjNTemlDSFA4RlZESDNmMW5kS05GWlN3aHNyZUdV?=
 =?utf-8?B?cCt5bXg2cm5UeC9yNlQ1VWJKQXEvOWQrdmxBK2w5czVSTm14ZVE4UktvL2o4?=
 =?utf-8?B?WjRZaW11N1pIREpvVmRuQjRUMk1tVzhUVUxaSHFUVzF1Vm96QXZkSDJsdWNB?=
 =?utf-8?B?WlhHSzFKSXM0d1VTTjB3UnI2THQ4SUsrakVycWFEWFVWeCtRN3M2dGplRU85?=
 =?utf-8?B?YU53RE92UFZlQUYzTUhNRVp4cytDUzJ6bC9JM0FReVBIdVNHQkFRSzZRb2tG?=
 =?utf-8?B?VENoYWVEZ2Y5cGxyMDIyYnQ0Q2RvNnNyWHZpZFlPMEZ4QitOcXIyQldaUUJi?=
 =?utf-8?B?ZFoyZ3R2bHk1eGozS1UwZ3hZWnJRNmFtNGZTTkY3RnRYWWRIbVBKZ3k5alJy?=
 =?utf-8?B?RFhDR1QvMFJscEJ2QlNYK2ZkS3Vaa2w4QTF2L2JiQ2UrMjVPM0g4VGpKV0lP?=
 =?utf-8?B?elRSTXgrNGpIQ0xZcjhRS3N0eGVTQ0tEei9OSzRGRVlHRzh4ajJkRGY5d09K?=
 =?utf-8?B?MlVLNFd0V0xHdmtVUDB6VUJud3A1LzRsQ0VldjVkS0o2NTdrMjhmdW9ONWdM?=
 =?utf-8?B?WWptS285ZlprY3R5NXR6Tk5RU0lIbFdCTHBCWTF4WnR5U3VSdWFNbm1MRkdr?=
 =?utf-8?B?NVZxSWhwaG83Skk1em1VN3pBWFlwOUZMbUx0aFdHWCtVYVM4bXBVbjI3N2pj?=
 =?utf-8?B?bExiaURQVVVRdGI1WUZud3ZzN3RpdEEvQnVIZFAzZ3pTRW9sUkQ1NStoVi9R?=
 =?utf-8?B?SzNOZStIZlpNYVJBMlNta2RuTFFkc3NMaDJTOFRwS0F0VUpYWTFlc2RES1Ur?=
 =?utf-8?B?Y2RVZWVqd1krOG11TzEvU2JrN25ydXEzSGxkK09uRnZzMnQ3MEZLRVg3bUNG?=
 =?utf-8?B?eWFxbHZSK0R4RGJOeWxnbHluR2VFNGFQK1hzdGNaazlIVW1WaTEwRXExT2JT?=
 =?utf-8?B?cHFpMWNHODJRYkQzcXV6RUpkQXRFQjgvRkJrUHUrSEJkVHo0bi9XY1NuV0Rp?=
 =?utf-8?B?ZlFSOTIxVW0yQXl4dGNjcnIvN05ydXRoL3AyS29GdjNlRDl6ajNNRGFJTTRp?=
 =?utf-8?B?dDJSUnYyVmkzSG13WWVBV1N0aFdjRTBEWTN0V2hUamFWQVBIa2RJL24xVVpi?=
 =?utf-8?B?YkNHRWY4UTVxdUhIbG1JZVhNWEU4V1U4bWxtM1FDRDUwSGJrd215MWhaam8v?=
 =?utf-8?B?clFLdzVvODVaUDBtcHVkOFJLLzBxdk9uaWRLeEhnUVdNK0IrNFdseFB4di9t?=
 =?utf-8?B?R1JQdk9BM2RNQ01tTEpVTnk0ckNqd0h3WUR6TC9RSWFUTTRnbGJwQkkrTzBT?=
 =?utf-8?B?U3dQUGcrQ1ZJNlUwZDZFcXVYZXpRZVpWUm1QVmpaOWFkWDQ1aXpuZlRSdi94?=
 =?utf-8?B?TEdqQUFFaDhsQVFWN08yN1Rlc1JWOWlXVmsyRDEwTE10ODJwdGdJSmZzYlVm?=
 =?utf-8?B?R285dzNwZG5mdlErSVFjZnJwTWZycXRRWENhSGhxTjRrSndaQTJsRTV5MTVm?=
 =?utf-8?B?SDBjY0xKdDVCNjV4T3VscURLNjg1bnRNUytCUXgzL0NUbWVUYlNLc2h3dmNo?=
 =?utf-8?B?YlZ5bUNXZDc0MXBkRVZCS3FKRkhDbTBBS3NCQVRTOXh6NmprMC9WeExTUitt?=
 =?utf-8?B?bjc3WEt0d2FNdjNYUmpXbS8wL0JQSUxDT1NaZWJEYUE5QkszQWY2Qnliekln?=
 =?utf-8?B?TVBLSDBCakM3aDk3bGRzZFByejFJL1ZxUFc2Q25PYXRMVU5xcXBiN1A0VXg3?=
 =?utf-8?B?V2hZZGtBZEd1U1pTSFlnaUJtMGFXaGVYaXFGL1l6ZkNyaG1FcGNTT2szeDNa?=
 =?utf-8?B?akpJbUEvTDdEbGVrWW1sa21RY0gySVJjYXZHYS9NMHdvVWszb0tZdzFxcmFY?=
 =?utf-8?B?TVRVSEtmS3FYVzZMdUhHNHlqZ3dwVVdla1NNYjRORE1DdjRmTEJNWCtJSjFw?=
 =?utf-8?B?U0VTTDRVNTdpd21TaDNZcVRIaG1iR2IyWW1UY2JjNkprRTRaU21kRVFhZDNJ?=
 =?utf-8?B?VkN3S3hCMCtQQ3AvRHEzYnFpY3JsRVZ6aWJJS0xQT2VuaW9FVWVid3JpNk1w?=
 =?utf-8?B?eGdkeWJuSFpadHo3UDNRcjdwcmF5VWdkV1ZDeGE3ZW1JSkFla1lidkpDY1Ns?=
 =?utf-8?B?WW83eS9xRkcrN2dzd2RZSjFsRzV3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(36860700013)(82310400026)(376014)(14060799003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:30:10.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6634ab37-f129-4c68-1d6d-08de573d5797
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6475
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> The ip_addr_t of lwIP has support for both IPv6 and IPv4 addresses.
> Some lwIP commans is directly accessing the internal addr field of the
> ip_addr_t instead of using ipaddr helper functions.
> 
> Change to use ipaddr helper functions where appropriate to remove direct
> access of the internal addr field. Also change a few instances from ip4
> to the version less ipaddr helpers.
> 
> There is no intended functional change, besides the change from using
> ip4 addr helper to using version less ipaddr helper.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  cmd/lwip/ping.c | 2 +-
>  net/lwip/dhcp.c | 4 ++--
>  net/lwip/dns.c  | 9 +++------
>  net/lwip/nfs.c  | 6 +++---
>  net/lwip/tftp.c | 2 +-
>  5 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
> index 6d090fc530d6..fc4cf7bde5f9 100644
> --- a/cmd/lwip/ping.c
> +++ b/cmd/lwip/ping.c
> @@ -35,7 +35,7 @@ static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
>  	struct ping_ctx *ctx = arg;
>  	struct icmp_echo_hdr *iecho = ctx->iecho;
>  
> -	if (addr->addr != ctx->target.addr)
> +	if (!ip_addr_eq(addr, &ctx->target))
>  		return 0;
>  
>  	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 731b57de3ba4..4cd4184c42bb 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -93,13 +93,13 @@ static int dhcp_loop(struct udevice *udev)
>  		sprintf(maskstr, "netmask%d", idx);
>  		sprintf(gwstr, "gatewayip%d", idx);
>  	} else {
> -		net_ip.s_addr = dhcp->offered_ip_addr.addr;
> +		net_ip.s_addr = ip_addr_get_ip4_u32(&dhcp->offered_ip_addr);
>  	}
>  
>  	env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
>  	env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
>  	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
> -	if (dhcp->offered_gw_addr.addr != 0)
> +	if (!ip4_addr_isany(&dhcp->offered_gw_addr))
>  		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
>  
>  #ifdef CONFIG_PROT_DNS_LWIP
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 2222e2b0b045..8b7b3b7f970f 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -28,13 +28,10 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  
>  	dns_cb_arg->done = true;
>  
> -	if (!ipaddr) {
> +	if (!ipaddr)
>  		printf("DNS: host not found\n");
> -		dns_cb_arg->host_ipaddr.addr = 0;
> -		return;
> -	}
>  
> -	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
> +	ip_addr_set(&dns_cb_arg->host_ipaddr, ipaddr);
>  }
>  
>  static int dns_loop(struct udevice *udev, const char *name, const char *var)
> @@ -78,7 +75,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  
>  	net_lwip_remove_netif(netif);
>  
> -	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
> +	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
>  		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
>  		if (var)
>  			env_set(var, ipstr);
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index 5fc2d3bd8736..1812bbda68e5 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -59,7 +59,7 @@ static void nfs_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
>  	int plen;
>  	struct rpc_t rpc_pkt;
>  
> -	if (addr->addr != ctx->nfs_server.addr)
> +	if (!ip_addr_eq(addr, &ctx->nfs_server))
>  		goto exitfree;
>  
>  	if (p->tot_len > sizeof(struct rpc_t))
> @@ -120,7 +120,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	printf("Using %s device\n", udev->name);
>  
>  	printf("File transfer via NFS from server %s; our IP address is %s\n",
> -	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
> +	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
>  
>  	printf("\nFilename '%s/%s'.", nfs_path, nfs_filename);
>  
> @@ -144,7 +144,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  	net_set_state(NETLOOP_CONTINUE);
>  
> -	sess_ctx.nfs_server.addr = srvip.addr;
> +	ip_addr_set(&sess_ctx.nfs_server, &srvip);
>  
>  	nfs_send();
>  
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 6c7ffba661e5..86516e662732 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -180,7 +180,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  	printf("Using %s device\n", udev->name);
>  	printf("TFTP from server %s; our IP address is %s\n",
> -	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
> +	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
>  	printf("Filename '%s'.\n", fname);
>  	printf("Load address: 0x%lx\n", ctx.daddr);
>  	printf("Loading: ");

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
