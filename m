Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF8C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 09:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A98987135;
	Tue, 24 Oct 2023 11:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GDxUDyMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33E0870F1; Tue, 24 Oct 2023 11:18:28 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D5C87655
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbfSC0s2+q5BbLfD4l7lI/hiqKj/0wY2+zrg2iAyCJxojoIk9eMSBEuQVml3+FrGn3V1xINo4FSh60RqrMFfMn/g9Fuchk+Y9a5LMExoB1lC+8pqmuI67oug7kNA5dM2am2YuFOyAXEwSeLJnpWOeYMaBt4oVTIWH0eEI+CnLOQLw8uUyGaRI0psedBV5uF0wEa9QBM3AEqtfNvzDR6KUUeKxY2lxhNNi1t1P4hd15c4ciVLCuxXMMpMGADXYHMi0LxeXyfifuM4aGZaaBnoBdVsexoNQ80l4NRqLzVg3Ugn7F68ScB+cEuFD0G6xum4f99MilZOihyabKL62pI8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPqhVY/2N/tpzjT0NSKJiWe3+b3mPXIafARvSG0uCFY=;
 b=IS7UcDouYT71RcFq8Hngd8xTh7/RJ2stDQu7tHsI4lL9i2msMhFs6m7eBcUQRs+eaeGvzC22yzmIypydNb8y1xZMkldjOjWS1PMLP8KgtopMVzgrE9ArxSETs+5I5q5JbHdnAO3SWZYGesXxfA4RI3vIkjX87UR4kgegpSu0cLpLN1iRhihkIldLR09qHMwGQjuWAiZlz5BZK3NHNDoMmuGMwe9E/9rHAr4/jePMMbcge2kHNeR5qev1mJqke00N65HKDlHkVMt7ufmErDpBrpCFE2adDNEo3K1Kygy/GtFwY/uGAEc+HaVC58OGu/5neW0fkptuv3KO4cjPWTc7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPqhVY/2N/tpzjT0NSKJiWe3+b3mPXIafARvSG0uCFY=;
 b=GDxUDyMCJDbgIt0fKeCKommsL9mXQwswzPsKTSaknm1ey80Xo0DoAByLjciqMmGKTEPffQXwQgqPZHr1z1MEXKjI1pBr5KqAJnNNl2XAJgt3BLxk2EZDJfZvo/tp43LmjMGeC3+Un9aSMGT/qBL97QvqZOlhTGknaW5wwJUQN0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS5PR10MB8123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 09:18:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 09:18:24 +0000
Message-ID: <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
Date: Tue, 24 Oct 2023 11:18:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Content-Language: en-US, da
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "festevam@denx.de" <festevam@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0102.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS5PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: c153e55b-2ae6-4efd-c2d2-08dbd4722c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJHmVGNzgUKkKM/wXKy21i2k3E6cXXhyo8u3TniwPl/83YPK6BaIdiumbmKZDnT12GILQv6dgag0c5XhNJIxLvHiw6d4tIeaJ3vxKMvauFGRvVft8PjFFlytK4evzZpW80LF4l8uXttB0v9Dy8l9TCKUdeovBQmzoPkYQ/whSxKGfH3QI8fKFErEj+WS6Z6ZXKe68Eu/lVCcLcWU5qNSElxg38TRYhTI4ZX5aiByPLZrJZSWyNiFV/KVruI4HmJGVMcFuyXbUQmDXrDSgKBq9pzp9zz51H5R5uOM4fyW4BXRWC2LGGYQkZITVAcE9TDi7hwRXUSkMy2ZFefVOnwz5NpIkSejC+fZRmnEl6wg1WC3Bss3tRDukpYqSXGnjrS156p9lVKZkmAj1cLrNgBcXqzrnT0hBWphc7hQr7QH45jS5xOt0Hmad0weFqfGhLrh7KObSKLAT7R2/JaAgrrfReht+PzPbEOyQ6TAbxidK1i4jrzPP+DmJtvi20K4IlVQBR7Cdv9k+pTrwhdoxeqDsvwMmY5qlclVx43kqNXkdkID1LAMuT8Yv3xJ9pjsC9e7XzJFXYYdkjQhTGMBa3CWHBKQetx5I7xqqV7kXs9/QzQ0WCm5Zpy/qM5qoheLSSl8CJA0gzSqYrcNqiNIFF8wrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(31686004)(8936002)(2906002)(4326008)(8976002)(44832011)(8676002)(26005)(2616005)(36756003)(38100700002)(6506007)(6512007)(316002)(478600001)(31696002)(6486002)(5660300002)(6666004)(66476007)(86362001)(54906003)(41300700001)(66556008)(110136005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtkbVQyR3lHYStTejBJaDBaUXl6eTFGRTczM3NUS0lObTFwcnYzRGY3NVUy?=
 =?utf-8?B?enEyeGFldDdiM2NmNjVQMndzMmMyYjVnRUdlbmpwSktSa1N3cTlRTlpGL2dO?=
 =?utf-8?B?S1V5aitQdGo1TXI2ckNGdjlTR3BQQ2x1MlQ0bE1vSWV0Z0h5UTNBelM3UGg5?=
 =?utf-8?B?Q0RRN0NXb1hmUkZ1V0xZRmMvdjVEdERsYWFJQnRZazBoYzNOclo1OWlhSEJO?=
 =?utf-8?B?WVdKSStZK1NuWnZaM1E4UkZrMzRZV2hsUVRKTGZGWWNDR2hNYWVqbmsrT3Fi?=
 =?utf-8?B?elFCaXdzTzhieFZ1cXhXSm8yd3dHWks0aGszTzdTb1RUR0t5bk5mcHJaUTVm?=
 =?utf-8?B?dDNpUklhUUlUTHJRK1pJZHdWQldiNFJ3djZtRStlN1pFNEhQc2VGbWh1V1Yz?=
 =?utf-8?B?VmVGTk1zbXg0ZEhITllmM0s1UzNUeERLbDhKUFhERGpXVHk5RDVhb1JDUW5t?=
 =?utf-8?B?T0ZmSHhxQkpsbE0ybGVudktyWTRkT3MwZnBoQjJHSUwwRnh6enFLVlNKbE1F?=
 =?utf-8?B?MVd2MWNUK2VoQ2FPTFNPVEhsNHhlSHRZeldYeFZ0WTd5L3ZaSTA2WWc0cis1?=
 =?utf-8?B?RzM0Wnpqb1JTVy9aYW0xdUEva3FxT2hkVXVNNnQrbG5zWU03cC9lTVdyNktT?=
 =?utf-8?B?Z1FlOXF2SFdpYTZmNGtISkNnQlZsVldmSmR1ZElOM2dpOWZMM3F0WkZjTWZs?=
 =?utf-8?B?SWFRV3ZweTFGTEZNdk1ad2Vjdm81ejdYQ2h5YkJNTGtGM3g0UEhhQ2ZVeVRU?=
 =?utf-8?B?QzlDNFJjMEl3VUJGTFZ3UUNRenptZGc4OEtwSGppWHA4R3dSQVF5ejBmRjRi?=
 =?utf-8?B?aXI1blVUaDRMRDM1YlRjSDNpVllERDhzSml0MnhUSWs1SnBEWFJ2V0NMSXQ0?=
 =?utf-8?B?S1hyVlFBMis5bTBIeWpDRFRLQXVCVU9ZVkp3b1QyOU4vaCtNU1drU0hOT0JQ?=
 =?utf-8?B?d1dZQldGVHF0RFRJQ0haaWNqL3VOVTg2MkkyaGM4eGxvaFhkWmZLUkw4Ui9L?=
 =?utf-8?B?L1p4UWhqek5qcW9POVkwUUNLL2llVmM5S2VRY2o0djZQZDB2dTA4KzVBeXNv?=
 =?utf-8?B?WjUvU0ovWDBnMEwwK0xOWFFJT2ppZFhGZ3p5ZXFvTjJkMWpVd2QvYVZOZXkv?=
 =?utf-8?B?WE1OV2JoUmdFZmcvL0NVVW4xZXlJK1hCaHVyczhoMFF2eHdJZ21VNWFIb0V6?=
 =?utf-8?B?K1BURlFzcWsxSTVGUVd3ek5xaW96VC91OUtsYS9rdnc2THhteVlaM3NEMkdQ?=
 =?utf-8?B?VUFZcXZRcGRsMGNEOGFCb0JNSXhnakwzWVhJZEtvZXd3algyN3Y3NGdGZkE5?=
 =?utf-8?B?NUlVQnk1YW1RYWJvUDRsdE1xelRkZ0trT3o1Vk9JTXMySTUvdGpxNHpqNERu?=
 =?utf-8?B?R1RkalJreE9ZQWg5bURxak5qZ3BvS1pDWG96K1llOXNObWtjTGZMemN2V1Fy?=
 =?utf-8?B?NDAremE3YjVWejdDU3dPVkN0RjBMY09WbngvbisxTS8wTE1tYmpzQVZLZ1NW?=
 =?utf-8?B?N3hqQUduS2tYMVh2R285YThkL09wK3RVMVV0bWh6d0FMeVRhUThTTDQvenA5?=
 =?utf-8?B?WHFLbmlFSzEyY1lRaXhmdnBlekljU1dESm1ZRi9aMmJrOG51NzRBeDlPK0h5?=
 =?utf-8?B?TnVhWDBHYURuRGRTUEFCemg4aHdPUERxQ29ERzM2RUJyVFU0MUcxbHdXN2h1?=
 =?utf-8?B?K0FSbkMzcWNRSTVRbjFPZzN6b2dXS0h2cmhlSzF2QWVIRUpnZHRFYWkrSVJC?=
 =?utf-8?B?eE94bGlLSGFTLzV6LzYwTW4zRmdLUG5hS3hTbnUrTjR3MTducHlaUDN6ZVpy?=
 =?utf-8?B?ZnJMQmpraXRiYmI4OXVEQnVJTXZGQUY3L3owUW1NSkN1SU9ZTkpGR0sxMlVj?=
 =?utf-8?B?OEpLNjljaERVd04zazJQOEY4ejkvOWhycmk0Tm9xNHMvc082VGUvVDZ0R1lT?=
 =?utf-8?B?eWdXQlpsOVhtSFQvTmdGdDQrWHhZMlJDU3VwamlEY0FTZ21HNnpKSG5COXIw?=
 =?utf-8?B?OXN5Uk9TSFlORnJLUWxqOFBtVHoxelJmQWE4RENjSlJGc3MrTE9OdzhRU1kx?=
 =?utf-8?B?dm83K1VzaVdNaFRSOG81bjhZZ0JZVUNXVGRKR1k3UHBRQzNkazBvc2gvbk9H?=
 =?utf-8?B?S0hFV2l3QlRVVFRRbm9sZlpRVjRMQ0M0d0dtdXF3RE9pZjNHVjcwRmdUZkNT?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c153e55b-2ae6-4efd-c2d2-08dbd4722c80
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:18:24.2422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyLYreE6/FGm0/Y4MXlnDGg4B7qCe46YiM59Go9fVxnfxmeoagj+F06hu68G74qIUMkK7J1D0WPAUxVWymUSvoBMc2r7qAr5mUatfBrE9Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8123
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

On 24/10/2023 09.39, Marcel Ziswiler wrote:
> Hi
> 
> On our weekly master upstream CI build we noticed Verdin iMX8M Plus boot looping.
> 
> Bisecting pointed to the following commit:
> 
> commit 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get full FIT size")
> 
> It looks like this introduced a regression.
> 
> Before and after console output (with DEBUG defined in arch/arm/mach-imx/spl_imx_romapi.c) below:
> 
> 
> After (e.g. commit 4b4472438f5 or master):
> 
> U-Boot SPL 2024.01-rc1-dirty (Oct 24 2023 - 09:28:26 +0200)
> Training FAILED
> DDR configured as single rank
> SEC0:  RNG instantiated
> Normal Boot
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x4802b000, size 1044
> Need continue download 1024
> downloading another 0xc9000 bytes
> downloading another 0x1ae00 bytes

Hm. Can you show the result of 'fdtdump u-boot.itb | head' as well as
just the actual file sizes of u-boot.itb and flash.bin.

Also, in spl_romapi_read_stream(), can you add a print out what
ss->pagesize is, and also an unconditional printf() after the
rom_api_download_image() - we apparently don't hit the "Failure download
%d", but I'd still like to see if we even return from that
rom_api_download_image() call.

Rasmus

