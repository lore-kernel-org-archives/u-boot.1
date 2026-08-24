Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDFFC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E086C60672;
	Mon, 24 Aug 2026 15:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lRKP3AjknQO; Mon, 24 Aug 2026 15:30:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787585405;
	bh=unhS43CyNbShxEzdj740mNyi/RCnbQI0byHH4oZojt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vhTINrzcILXTHlv8Quchmw0eQTEjkjoD5xO+Yipb4vinoXQtiTdykmVPeA/b3ZwfD
	 FtWoheF5nWheGkrAjPFC6oUiNY4bUcMZ3dimG1cIIcAEohTcWimRqns/iPREC/qp5c
	 vFTzdXiIMUC4aZaRjwDwM4FOTtPnyX5KKmJDne29rzGV2NAHUFGMNHK6SxAB6v3PP4
	 sviSiDFWy9hRFyZ2nj6EomnjnEFsMBPXUiNe/dzzu2odmXF1W+TKp8vg8KdNV316Sv
	 p6G99O3UGsOH/J99ZAdJHAo3g5JhRFJXiXM0skcDk1JfvaI3sYch0eqsQxhDBw/OZ4
	 raD3Z3eDcrJzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35E9260626;
	Mon, 24 Aug 2026 15:30:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31E85396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2409B40068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFbq145pLngL for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1Q8UZsm2
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6736340029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwx17QSmFCyogxIpNnbDfOn0IEeZWa0x/a5ObVenMqevO78QQoF9+ZTat7ce+zvDT7RAwIjbYVF23AvR5Q8s+JNw4qEfx3Qa6PupoKGMOTcsCi9Us8PyAUMQHCI/bR0rCC7J2xlXyFVxFISqB7/Rl+F2EltjQaSZuqkihp0Hq6bfWlFJn7uYNsxXLlHjTFVV4OeLf9ETJIIyilpd7xMZP5KyNXCjxcx46Zg7KVp/9ggpKC7WeGa2V73sSlzlJfqZmXgWXC7JwRo/iirCmN42K2+5l4AcSIchaxX3hd77j6C9C+eu74ryUNcEH/cWBj2ioBVpkkFEptLiJsVzH5kWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unhS43CyNbShxEzdj740mNyi/RCnbQI0byHH4oZojt4=;
 b=BQpECPLpvRqWW8HZ5PHJR1kfv2HaXq7uT2UGnaYLHD8f5cTM57czZrtJi3KF6ggbSYS3T8zsTI8IuEfQx+rsPIlw//Si+AyO3u1WMAXTncZsWCVy99FibQS+OGT4xwPuM8GRIDYor1P9VOmZ/zZL7BAWRhbHUzErpkduwhKNrS+lq4eRbNuLO3wdx1eDA07Uhegl4y3/xwLXiTRBilcTBCgfo2nla1k+mE1rwWdXVl8GWNAcAmnK36mjfB14f1MH8ipWinJqrudHvRdv1A1Ww1q5qqKDVxfIcUu3iXVtXRi9h5e3Z4twTbesl92V2kN9l7HOZKYYSdLIz3GadObSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unhS43CyNbShxEzdj740mNyi/RCnbQI0byHH4oZojt4=;
 b=1Q8UZsm2qICaP2hzhZxl8elCdVBTQNQC6U1oKnhUdX6ch6y7lWI/6b7oQ7KPk7RKE2zZOFDJ8TLC9jGon0+lZldh8kG7X/i47nsZh7Aoa6z2Iwb/iyqWkSao/EPHwCU2yyMDH1sLbejfr9Hnv2StAcKopme2Dz7JCpdlRrbyfn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:29:47 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:29:47 +0000
Message-ID: <2c9ac202-68a7-4017-a8f9-91e9b3579166@amd.com>
Date: Mon, 24 Aug 2026 17:29:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
To: Tom Rini <trini@konsulko.com>, Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, padmarao.begari@amd.com,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <20260824150937.GD523975@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260824150937.GD523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0128.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc1d806-1f54-43d3-c36d-08df01f4880a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8r2FGn1+dR1oPkjI7P8gSPfqmjQNXjUX9Yh486z3OBtEAimbhRNE48nKgt7ViMm8XgTNfstTcyh0CLo1bipRq2sQaLQsTjdux9b9c1mbuD0C1Hac3NaRd7liPfOQAwOj9ErPi1DS+s/F/h6UfmJ07DI/SE+9ja8JFuw+JKZII9TiB5xOXx7vvpZIekP79maBtytfBxZoouyrMrHaptmtJlv/monWFdopzODN5Be7/gHu3kLPq9wk6e3ZkMDB3iChD+YGyTQtVoDv/bIz7UDw7J0H7Hq0UMMeCv5QEngnHz2/4cMFt72w0IrukJFAx30xuNc9NGbgkBlFDVPBejl/M54mCKLd1of+746h9KXaaY6LDkc5u+aiYzub1p5GeGf/A4Xg4lS/4XEyj/g/LE3gGgqLIWjkPduNTRAnJqS+b3vf9XfiMr3yCqnoEHGBA5acIzU1GP/YvEBZEeMODVX9SORDw9FuDk83WN/cgtJiT2pTskuyA7CGqrI5j2ZGj+B9mXCWojDzS1b2pio/doFRubfQykXdSUUCME6sRR7/oIvXBLJvcjRunuJ6p4yn8uifFZC4UyQn2CWWtFSws2BTX3uLILVfbUVChxbNhxcgAnnA2xvcHIVNSjPYZaRrvtnOHILnWiy7nsJMz213fe6GcvCONnin0SvoLmTniBQDNWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFGZVhNamtKNnAvQ2szNGhFcjFMeEh2ZXYxbzZWRnRSTUMvMGlDTnl3U1pq?=
 =?utf-8?B?cVkvOGorL003WTBXNnFoZHBzTnErQlJWVjliOFlwSk0yNjZzRkRUZ21UNjRK?=
 =?utf-8?B?NS8wQlFoMHorRnBHQXpoNEFHK1A5Ri8rbDlxTXNNTHZNK1hIQ3dGTlVJdXM0?=
 =?utf-8?B?cFNLazJuVWtxTHEzY3BIS3hhOCtJRFFhNzdMd0hXMmNSODFWbUoyeGxpNUdp?=
 =?utf-8?B?RSt6K3NTR1ZqU0w1TVZsUUR6VGpaZnIwdXFVVTcwNnJzS2h6WVZJRThzNEk1?=
 =?utf-8?B?Tk5zbmJJd25KZ1lSUUdUdm5KWk1nd0JzWkFaMlpncXU3K0tSUzdmZVhnZmQ2?=
 =?utf-8?B?Qm1qdHVpaER1bzlLaWEwdWRQRTdnM2laWEtkQzlvTlh6RE1VTWdXeHRmTi9P?=
 =?utf-8?B?bXpMeUdCeGhONWlxc1o4QmxXeURnRzI3WlVjR1prSnhVUjBabEJlTjlGd1hC?=
 =?utf-8?B?YTIxRVM0YlFaQjg4Q2VzWnRMTmRqd212TVh1K0pma3lrMFNjNFdlOFFFSHU3?=
 =?utf-8?B?VUpDakhjVnQzWE5MZWNwYUE0VFNwL1NVUjlpaTRpemFXZ3ExeUZZR1dOY05r?=
 =?utf-8?B?Y1BqalZ0R1NQcnBBdW94VEdNUVlyNnRZUFZDT2FuUFh2dUtoQ01OK2NQK1NL?=
 =?utf-8?B?V1hHT282MkFaVkhOanlNSWdpZk9GbjZ1SzY2dVUrNTBDdk5ibE16bW9YUUly?=
 =?utf-8?B?VGZXaS9sdXFkQ1BtTkZxZURLU1hNSC9oaVJ1WGlndmRjQjR1cmZSUmVJQXRa?=
 =?utf-8?B?M3k5a1NzTURGb2c3WEVvdlV0aFdBR01CdmJpTDFXZkNNaW9vZDd6M1cxdVlS?=
 =?utf-8?B?UXg5REIwUTFoaEs4L210Vk9YT1F1MU9VVXA4QWNPT1d2dzZzeXAza095Q3hJ?=
 =?utf-8?B?M3c1cjRsNDJFTFk5ejJhUjVtZWZzTVdWd3B4OVYxL1dMeFlSOGdLb2sxYnRl?=
 =?utf-8?B?WW9sZWc2WExvZXV2dENhenhWMktxWU5TTmVPSzIyOG9PbXBsYXp5NnlSM01u?=
 =?utf-8?B?WGlJQmlhc1MzUFBhdXlybXBwVFpUU0c5TmJ3Y0swSTFLM0s0dVo1c28yS1lF?=
 =?utf-8?B?TXZJM1JRRURnNmdVcFA4dlhXYSsvay83SnpuQVY4RDM5a3hqcXFPN2RBK25s?=
 =?utf-8?B?TkorSFNvMjNrVmExOTBlZUFlUVUxckJEZjNqVmNzMkQ1cVlMdnJqQWhQOVFt?=
 =?utf-8?B?L0oxcGZabUxrZkJ6MEF5VHp4Q01GVHljS2xNMERXOXhRMHV0QXZNdDA4VUYy?=
 =?utf-8?B?NXhhSmJScmZWV2ZvNVV0ODNTc2puY1VEUXBXREhGeSszL2tOV1hKMHRRTkFD?=
 =?utf-8?B?NzkxcWY1cjlwbjY3a3JTd3VwSVpyS3FpL2RNR1ZYUnFPZU9MVWJQb0tPNGY2?=
 =?utf-8?B?cGU0emhsNjFDYzVvSlcxRjZDOVcyMjNGdDk4T0N5Y1Q5WmszZHkzaEFuQk9h?=
 =?utf-8?B?NC9iUCtoZnJBaTFNdGFxdE1TR0RkWHNhbFY5eU1xUDhrY2N2OXdGU1B2Y3k2?=
 =?utf-8?B?d243U0VVQW5BaXdkWXlDVVYvcktheDJzUjhXbVp4ZzVUMVdhdEx2ODhVSUcr?=
 =?utf-8?B?QWxEdjk0ZVpibUNWRUxtT1JXMXlEZm5YNnVPVU9IWnRLeXllQ1dSSGZ5Nyt2?=
 =?utf-8?B?anF3L3BueS9lSnMvNU1lVEQ3eG4xdkpHUG9YQWxQak1tcXlUWkpYV1lGSlVP?=
 =?utf-8?B?WGV2cEFpRXRydXRHYnZYRmVHRmxSZDlDK2MvTDllNVZjcnBnUHRBRVdHLytU?=
 =?utf-8?B?eDF4UzI2Y0Q3RmNiRFp2K21uU21FRFJNaVg5S1kvS3NGc2FXR1doZjlmWnVu?=
 =?utf-8?B?Z2d2NUFEMXZoN0RFaFpLRXVxR3JrbHNXUEFObDlMQ1hHWVI5SDgwbFNZRFI0?=
 =?utf-8?B?THczVUc0eDB2QnVONUkxY0dMYzJWQnEvY0E5S3hKZis0alBtODRCLzhFSkNw?=
 =?utf-8?B?bkYrQ3d4TW1RQ1ZrLzRUV2JuL2NrUmxydmdxR254YTVsMVZ6VVFEc1ZnWWRX?=
 =?utf-8?B?UmF3c3JPelpWK2NHcERsSDlXRUUzN1RCa0FNTXRsRDUyUTg0N09HeWVBdFlS?=
 =?utf-8?B?USs0blQ0NHBIUkxGazZuc3paYmd1MlhiZGpDbitiZ1ZlVHZ2dW5NV3RMb0F0?=
 =?utf-8?B?aTJaN2RqYUl6c2RuWlcwZGlJeDlYbnVJUWNPdlBnb0VOTkRuSGNvWVl3Rklo?=
 =?utf-8?B?MkpOZzVuTUVLUkdneXJoenJZQWs1VXVrSFprNDlZQkFBWlVCU0g5NytGNVQy?=
 =?utf-8?B?cGN4bkV3ZXU5Z0lUcmdQS1k2MVl4U2o5dkwreUh0Q2JONG0yRzU3N0ZQNXZt?=
 =?utf-8?B?ODhrY1BIVkZoTHV0bDdXVUFmNmFIcE51d2E1bmc0SjF0bGhEY0xMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc1d806-1f54-43d3-c36d-08df01f4880a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:29:47.7920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEo4xrUpxPqOWwz7EcoUtNL+2dROqx/SgafMV0c7ZEx5Nu0puJFe5sIp4hm7gCBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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



On 8/24/26 17:09, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 10:17:18AM +0530, Suraj Kakade wrote:
> 
>> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
>> path) in the HOSTCC command. With a long $(srctree) that command is
>> too large for /bin/sh -c and Make fails with "Argument list too
>> long" while building a .dtb.
>>
>> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
>> HOSTCC/CPP so the shell command stays short.
>>
>> This change requires GNU Make >= 4.0, since $(file ...) is not
>> supported by Make 3.x.
>>
>> Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
>> Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
>> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> 
> The linux kernel, and so Kbuild, says that 4.0 is the minimum version of
> GNU make required, so that is true for us as well, so this is fine.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

We should likely fix this too.

   94 # If the user is running make -s (silent mode), suppress echoing of
   95 # commands
   96 ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
   97 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
   98   quiet=silent_
   99 endif
  100 else                                    # make-3.8x
  101 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
  102   quiet=silent_
  103 endif
  104 endif

Thanks,
Michal
