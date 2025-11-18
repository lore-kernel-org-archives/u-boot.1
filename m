Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1BFCED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9391A83EA9;
	Tue, 18 Nov 2025 14:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ilWR3P08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2969F83CD2; Tue, 18 Nov 2025 11:30:27 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1146183C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGRXCuyimSyNxHL2xptAJ/iKkpEexwfaZ+JZgpaLrCU2PS7XZ1DZVrwE5EIS89D3WzDelXwBoKHQ8Q3Lp/+hKa6N+3em2+ztaEYFiS6b5rt9CcMEN/zxkpPxoPECmMe3HcKge5w3ZJC0rKEWkWnhV0Fs0O8PyPVV33/dK/+EtCjptReLxDbkDF2P8HpMBYfv2uKtPedwP1Ji/0/mCRVLN3kklD0AG0Ke+J7DNOh1lXA6Qu4Rknll86Dex+3ZlvN2kyG44t62BKpOvA9PMz5heYeyAkNltUz7TSp2yBSEHQ8Bo73pgxuapp6xN/vr33JQY+IdrLzO15YZCnnHUfEMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OduYrF17JCBlius9Z8IVDuEpiC1TC0ATaBZ34kk1ek=;
 b=JN+ql6BQ/2YxsfKRHbQa2L21x69W1yvXUmHGOxtlfvjhneYZDeEPneCyosyyJOxj+cmF0uwr+US1rzyxtNtgD7Lcm0u4ZcglUg/7yqkeVkWrJShYWDg/+tvgC42M2polpPWACbitFszzq6wzt9naA8YW1uGiY1qft5+4d/7dWBD6pedV7yLOIOMubrCjG4axWBgjkS32mOiyqoeOSFfO5gtYb7hyodTjVsXKiBRQIXkEuUjZf/PJX2fyQ+BYXYyEF2MakZBUJ0+9CBNXPHmlGEN9FSxEM8tEYq2iA2XC+1ugNcN6mjtOmR/glC03pc/AmHhi8CB+q0ljqOS73AIdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OduYrF17JCBlius9Z8IVDuEpiC1TC0ATaBZ34kk1ek=;
 b=ilWR3P08rqL7sH0du6qDYpdfDg5gd4mTihhg132IaX38YcLnCMW+rpKka90mR45IAydsOq+v3CbWoibUQLlrXtte+lzvZJZDopyl/9z0i25/JQ0K6wUQi1RJEFxS/Mj58EcUovbA+kD1m6NKFPKgUtcAcN7sJyHtd4nbgDKBFfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 10:30:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:30:21 +0000
Message-ID: <75a1e7a9-3a66-49ca-92d4-75dbecd7ff4a@cherry.de>
Date: Tue, 18 Nov 2025 11:30:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] lib: sm3: implement U-Boot parts
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
References: <20251118043042.27726-1-hs@nabladev.com>
 <20251118043042.27726-4-hs@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251118043042.27726-4-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::17)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ad964b-53df-4b82-a9a6-08de268d7961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejFJelZHdUdoaTZ5MlN6Z2QvY1c3UWFMdGNPcG9TMU5ETEc1eERRYXl4ZG95?=
 =?utf-8?B?N1pCNFpjWTJFT0cxd0xUSEhKQkpJcmJIcUY1QlV3eDBHb3EvWi9MZ0NvNkpx?=
 =?utf-8?B?eVVDdVJYaDdkdG5CeHdmNWFCSExSbjRLZTA2NllHN1BrQ0JTcG5EbVlPSisv?=
 =?utf-8?B?UUZ5dlFEMGxOSlVCNVNLQXQyRFhJbjhWZUVTYWN5VVMxenhsZUxtcStqQTVX?=
 =?utf-8?B?MUlWM1daT1doWVc2Z3VlbGlqUTd1TFhLNkFjQ0ZSOUM2dG5SejVNTWpwa0FI?=
 =?utf-8?B?UHBkdCsrSUtxUHVxaEJ6K3Y1blEzOGJwajIwR0hvQ0tEVTh2TTlwYmNZc3lz?=
 =?utf-8?B?ODB6NitWeEpMK01SNmUwS2FrZ1lKallvZ3MzRDFXV25pK1lRaElYWDY4L3ZD?=
 =?utf-8?B?d2pSZFAxdTk4NWlEQlF5OWRjb2g2YnZ5bUNxSFdKeWRRWndKbUk0V1g2WHBB?=
 =?utf-8?B?Yk1YTU5sanBQdDFFejZJT3dzZ09LN09DRU9KeXUzSFVXMkYvTS9qTTBURU5R?=
 =?utf-8?B?Z3VJekNkZk1nWlNDbEo4eVk5dWxVK0R0SUdYR0FTQldiNk83OStHWXM2K0Rh?=
 =?utf-8?B?WXZpRE9YWjIxa1c0TDNQWko1M2tSb2tYbWFjdW83d3FLdjdTOGJWVjZ2NTdz?=
 =?utf-8?B?aFY1R0ZBMUNPZDJpSVRFRDlpOHBLM0Z1eWpUYmdIeXdKYjRPVjdPUTZad0l4?=
 =?utf-8?B?MTd6cXB1QWFkb2hxTXpCNjcwMTllblZNVm11UkZCV2tpdmR4Y3orRStPbUZN?=
 =?utf-8?B?d2ljVndraVlhUGJPejhjeGFhV2tBZ0NUUlhhK2ZQUFlBeU5pdDhJREttUzMz?=
 =?utf-8?B?RTYvRFJ1NWJxbUJOU3dva0NuREJ4UkI2VlhtajFycUdkZnJIdEFnQkI1djFF?=
 =?utf-8?B?VG1IRTA1QitKbWR0aEFhaG92ZUxWLy8zaGFoSUF2Q0dBckVMTWh0SUFYSVA1?=
 =?utf-8?B?ZThZTlNvMjRLWUVTYXBVajhsRFc1cEs1N2NXdWZUWFFNK0FNOTRrTGZRSzY4?=
 =?utf-8?B?UDBOMUJJd0U3bFRrdEp1UHNaamswaGFGREJ4Qm1NU0trSUVEN1hyTjZWNHJs?=
 =?utf-8?B?VmxGQU92U2c4OGVldlVGcnF5MDVxaXNiaTBMdjh5Z29pd3BaNXlpeGNSMnhV?=
 =?utf-8?B?T1dVbVYvNHpEdEE3Z1FBaC9mSzVQZytJN3ovM1ZCY3FYd3JlTHdvYzZsM1Vq?=
 =?utf-8?B?aGJmODFRS0VBamQ0SHh2Q0JZY3VqZExYeC9KSTJLaWRrTmNSNm5IUXAvTU0x?=
 =?utf-8?B?UWd3YTVyY1A3SklBY2xyWVZzZkd2NzJhYUpVZVdSL09jRnFqNTl3M0xUaTI1?=
 =?utf-8?B?dEt6dE1tblNXSThER2J3STNKTk5SWW5QWVA0bHNrTGVlaCtqbkRlUWpxVnRy?=
 =?utf-8?B?YWh1dVlSOXpzSmEvQTJkR1NIVWtJU1Z0TVhaaC9kTU5weUppRGZJcnBqUUJJ?=
 =?utf-8?B?OU1RMEp5U3M4Ym00QTZvUU0wdDE3QUhxTTFuNnMweWpRa2JubFoxTzlRNlhT?=
 =?utf-8?B?blVFTGdaOGhYeklVaktVdWcwZTZPbjRKZlI1RkplVnZMUEJDN3N5UGFxNFBQ?=
 =?utf-8?B?S3JsVDZCTGROMWpESmtCcS9FUy85SU5UclQ1bDVRbDdRMWlEZTI0Nlg1Q0ZL?=
 =?utf-8?B?L0w0dE5Zd01lQldUL0FqcFl6MmVDZjhTRXM2UGVLSVpkeGduK1NaL2FaTlV2?=
 =?utf-8?B?YXFCWUREa0RnVWQ3VlhsdHJOdWFPVExleEIwaTg5VGVRWmF6SG9Bbkd6VlV5?=
 =?utf-8?B?NTdveWVReFYyMUhLSHpZelJaWmFEbC82Qkcwdzg4NlA1aXFLR2tXdHVBUkZw?=
 =?utf-8?B?WTVkdWtWTHlBcnowV2dhbHI0ckVuRlBSajVsZEFyKzJtSG8rRkxUdkx2QjdS?=
 =?utf-8?B?T1VndnlVa29ZcFpZV2NTdXFDVnIra25WVGplNGJrMG9TbnJUNFpxUzJFY05y?=
 =?utf-8?Q?+SlzHv6Svmi2Npt5I59qkbZMvv9iwyno?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blR0cEdXR1plSFU1UGtwVkVJQmxkR1BZenhyNDZDZFVaWENVL2gyUVp0eDEz?=
 =?utf-8?B?aG1mZDhjcUUxYklpRjlaVUl2Smp6bjJVZHk0eVNjQU1qUzAwSEF1TUlNZ3dw?=
 =?utf-8?B?VEgvRnhFSHNMUGhEZG1KT3Y0RERoTXlnTldpZ1Q5OWFnUjZUREpDUFgrK2hP?=
 =?utf-8?B?aXhpTzFuNGpuNG9EUHpPbHhJTDFoY3FiRk9RMnJFN1A4MzdvajFReGZtcHlG?=
 =?utf-8?B?RWZzcVE1d3loK0x0V1pDS2p6YjlxclEzYmFGSTQ3bXR4WGo2aDNPYlpHZDBx?=
 =?utf-8?B?aDBkUHBBWW8zL2djK0lCdVdBcHlRYWtoZVZOZTlIQ1MxSzBZTno1cmprdzU4?=
 =?utf-8?B?c0hFanRuNk1KZml1YnR0R2F6bzhqKzlicnpnSzZLR2IwMGxVNmI3d01LeGJi?=
 =?utf-8?B?cWFYNnpRa1dyNnhxdUNQMXAzM0NCYmdnL1ppUW9mc2RxV0dwcWlqc1dwaThM?=
 =?utf-8?B?TEQ1eGwzOS92MGRIQno5SGk3QzRDRDZMbThBU2VxZ1FPTmNnbHlHemFOdXJp?=
 =?utf-8?B?MnFJNTA4QU90dXVGQXdEMUMycWJZSUxhakhQNEVyUFdyYTlZYUpXVm5pVGN1?=
 =?utf-8?B?cjU4cjhuZUtvMHNOcFZXb0NxeDU5Tk8yZjVWNGNFMk9Vam1YUER0bU1ROWcx?=
 =?utf-8?B?enF2TVkxNU5YQjdPbFF5SHhpMlQ5ZGJhSlVuNHFjRGE4RFZvOFVUUThzdHQx?=
 =?utf-8?B?ZysxUitBd3dybUdqWFFDZjgyVGZQa2ZwU3MrOWNGalQ2d0c3WWgwQXhVenpU?=
 =?utf-8?B?TzlUVDhvZjFVU0t3OGdmUGtyVGtMY3RwY2JZWkFxRk52QkRvOGtTNjR4REVy?=
 =?utf-8?B?MVAyM1A5WmQ0cGh0T0JoZWFEWXlsT2tVb0Z1bFlyZHg1SGNkMlVXcUxNT3Vp?=
 =?utf-8?B?TmtOUy9ZRTg4NVA3ajNMejR5U2ZUbUt3RzIyV3FubUYyTUFjdmFCdFlYUk8y?=
 =?utf-8?B?WDZmeGNNcWtJNWE3OWc2MFUrY1BNS3c5N3FoeFhDUlBQY2R6QUEybC9YOWlk?=
 =?utf-8?B?YUUwSCtrZWJFM1pSWEoxQ09XMEFDV3dzK205QURjMUM1L3ltajJGclpFM3lt?=
 =?utf-8?B?NEJLVUl2MHJMenV0UkVwcHJjb0lraTVjMEdlcWhvSWJoNGkvTXBsUkRZU0lW?=
 =?utf-8?B?Qk5GSXBQQXZyVXhLU2JjUlhxSzNCTWxTSlNjYU9nbFNFZERsRThiRk5IVTA0?=
 =?utf-8?B?VTRxQjIyVUhQZEdoYVYzT09ZYmd5ZWNEYU1PNmJJamhBVmRHOFRKb25pc2xT?=
 =?utf-8?B?QW9EaUp3MWlaZG9BV3B1aC91OFlXRlk2RVZTYWdIeW9lS2cvTy83UXA1TVZj?=
 =?utf-8?B?UUZqeW1wVDcvbFp6bU9uMVhlbzVmcHV0SE1WWkljQTBLQkpubFF1ZDhyTXp1?=
 =?utf-8?B?MTFGSXRqb3FJLyswdURrZllxUngyNWQ5Y3JlUmQxUGdic290eWFzRE94YnZQ?=
 =?utf-8?B?aHNLTHcrZGpSNys2aVY4dUFpRTUySXdnVWx2WHhLTEQrcG80Q2JLTk9ZbGpG?=
 =?utf-8?B?cUJ6RUlnQ05FS09DbjVsTU1qaXU0Wnd3TFNTNG9qd3dlN212aVpNdml2Qjl0?=
 =?utf-8?B?SGFVa0VaVTZod2NCaXd5RXZEbm9ZQmQyQmJ4Z1o3bnBoSXNMRHdnYmFkaXA2?=
 =?utf-8?B?YkJHSzArR3JrT2FVYXArSk1QNmVkQzl6cWdqNWFhWG5aemRPcVJGN21jd1g0?=
 =?utf-8?B?NWgwRjVRRjQyRWpRVG5aUjlwclhZelBqUk9xbU42V2JMSGx6QzBWT3BLSHV6?=
 =?utf-8?B?cTJYVC9saEFaTjNwMGN2L2Zyc3lLZUlucU1ZSC9CT2sxaC9OQUNDdENZZ1FL?=
 =?utf-8?B?aWlmQi9yR1I5R2ludjF4L0h2YnJnM210dE9VK0N6YURYYUhnOWxxMkVBL3Rp?=
 =?utf-8?B?M3ZTcjZQUFhDeDhmQ2RIdlZvWUNXYTVRci9XQjh3UDdlVFM5QjNWREN1WGw0?=
 =?utf-8?B?eWo3MnRvTDdKSHRlWjgvY083aXJ0UjhUc0xKVHFZdGdCVW84dEIvWlkxaERL?=
 =?utf-8?B?R3ZraHRQZ3V4WmYvNEpLTFZWYWhyeGFhbFozQi9QM3lHWlBpek1KVldPVmhl?=
 =?utf-8?B?S015OXBLdHVIYWdJc3QrSjl3RHFQNDNuSFBWME02YXZLMkJTb2Z5VzRlMTg3?=
 =?utf-8?B?R0RvNzRyREtydFFORS9wRFVjbElnMC95QTVveCtiWjg3Y1ZoU3pzQ0ZUbjBU?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ad964b-53df-4b82-a9a6-08de268d7961
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:30:21.0298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: momji5iHysmYD9FpEKKx7Ry8mfCPpsaSk/SJdPMfk1OBaOBMTz0cFQCFgIDC3GCkTizVwsZcWDUHE3lEmCQbFvP+gKQMHltQBg5K+eyRm0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:15:33 +0100
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

Hi Heiko,

On 11/18/25 5:30 AM, Heiko Schocher wrote:
> add the U-Boot specific parts for the SM3 hash
> implementation:
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v3:
> New in version 3 as Ilias recommended to split linux
> and U-boot changes.
> 
>   MAINTAINERS          |   1 +
>   boot/Kconfig         |   1 +
>   cmd/Kconfig          |  15 ++++++
>   cmd/Makefile         |   1 +
>   cmd/sm3sum.c         |  48 +++++++++++++++++

Please add some doc for the new command in doc/usage/cmd/.

[...]

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5b9c13d85e7..8e3efff2bee 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -264,6 +264,21 @@ config CMD_SBI
>   	help
>   	  Display information about the SBI implementation.
>   
> +config CMD_SM3SUM
> +	bool "sm3sum"
> +	select SM3
> +	select HASH
> +	help
> +	  Compute SM3 checksum.
> +	  add SM3 hash functionality
> +

Spurious second line?

Cheers,
Quentin
