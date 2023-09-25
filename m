Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFACCE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6234686B5A;
	Mon, 25 Sep 2023 10:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mg1PxZwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FBA86B82; Mon, 25 Sep 2023 10:27:49 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A65D86516
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arUhCONbeBtLZ0Ub6b8WoGYYwdmnV6qGabdBceIvZ2LOby/wHqfd30/ilv7G1UW3aK0/3HHt9NuRzDwZh+YFlFTtkrJdH1YLgF1Y/WvLOOBU6FM3FfdFYZzSeO+FWUCny2XmPWb6Ld7g2afkrMClPjOoxGiGrC5H/SApqWypOrw93jJLY41v6dL7C2fTCTIyHDao9Jlz2XjLTFuk12z2l044Ld3ElYfqKirVu/YssGNd8CvNlUVQL7DFghIU3fDqp3QVhyxnFnLraeqShL/jKrn2DxtdTqMrGbmNBPQyAKyD+h0OD2l4F7tdK0vfTCmTLD3GRFRBT7nRYj0XTVtlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4ATXD+74Q9MMaJwX8iWst0K6UBBA7h/iCXsvJ16Yss=;
 b=dRL12SWY+V/d2ptzf2HmGbGfk0fTe6Ne//YH8QNUtXyGQgRg8UwDc+d7oJjlUIvBGLxpVDdO5stDWugz90ZQS9PLU606wN2wO4Rjfttz6XTxU9bWImDib4gYZJHG9K5G/XWdtDmMMgeH7ZdnS0I1Iru25pa8Njtd0h7d9MFX3FfONTwXyM7eiIsHQNlxYl2VtIntS2q/3mI3CB1heXdE8wuETuy0zHitR5028jP1bxq1YkBApggJ87DFiSzAE3ZHQVX4Si7OJf4DyxMOqnvQON4kEKUX8YcIbwR9x0ImHQ4MX4Nd+utboNJU52MoRvS9UCpykkk+XVAsqGMBR5hZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4ATXD+74Q9MMaJwX8iWst0K6UBBA7h/iCXsvJ16Yss=;
 b=mg1PxZwX4pdpnKUD/PsLBLAc0Qs+J8AhMSCZYiKEs899AffdBA/cMonAOzE/JJslIKq94tgNIW6mN4RwYkit57yAB+HSCZAKMRqLnLfkQ+lkvOKOi4NpHLSpHtfqyO/e/C0aiPfSE99sG/cP/k35jiflT5CddFzqgVfU6PJ40IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB5331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:27:45 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:27:45 +0000
Message-ID: <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
Date: Mon, 25 Sep 2023 10:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20230317102639.464263-1-rasmus.villemoes@prevas.dk>
 <20230425193117.GA1314607@bill-the-cat>
 <9658c219-1de8-3bdf-3beb-0c1e2a128569@prevas.dk>
 <20230425200932.GM1134230@bill-the-cat>
 <c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk>
 <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
In-Reply-To: <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94d506-5562-4bc3-eb26-08dbbda14b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9uTEeWnhW9l91PXyA0Eu7yJV0Mo8bdrWfSJnZzsz+7ndoHFEt6BtKr2/2vFWqHkg3hRP+lbTXaAXelfKwMbCeL/+g4FKSCMDsmINkWTW2xbeHCuyZXYwOm0dAY28qJLiaaCaDG6wtYyCEomTgAJaUWy9CLIsIanVP3tQnvlrbsNgdjdPNT++RKXdM0TmdPouD1GH2RN9Pr3gqnorSEyYbOtOJWqX+m+1wqH4qii5qTURQm1QtiQVPdNeXpPwIzASdl/5N4hszBx2DZ6B4OovlOcoBY7nwGeKzA5Hu6QAFRNmOfwMzgng2XNcXegDTKMoMfu3X239Q1BwYNjSBYuQPMF7FTrmT0XvkoBBjQtqUMqUFI2JiEvMHPUUlr+Ch4yFrm3vbThUVyZwcltCrvoyRBgZ7MX8hYa1y5+BYamymOwNd0Qk6qZUd3EUIJ18oR91LsHKcYYHAezCSj2fES+2B5xhBnEV5iNC2IrYeMZbpF8SUZyGyCMXtHpWo7IzolOi65vfFIh6ZXT+iVeqn75+9yUcomcUqSV6zGQmZA4MVtBMhfkR7N3t9HidHmG8e21vGlP7L3Z7FdOLfpB98vZMTvCvHwONeA740mVWCj/VsD5qBCOQGFfdbOCFEmc4HJ0uw31zxJHsOtbBE1u/hAzAmDM7Pah7xcF5VWS4LGbF7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39850400004)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(36756003)(38350700002)(38100700002)(86362001)(31696002)(31686004)(52116002)(4744005)(6512007)(2906002)(2616005)(5660300002)(66476007)(478600001)(41300700001)(966005)(316002)(66556008)(6916009)(66946007)(44832011)(6506007)(6486002)(4326008)(8676002)(8936002)(8976002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0tGNkljQlY1bVBEbHNUeUsvNnZRWW5uVHk3d0FCTU9yNFBUczV3WXNLVFJK?=
 =?utf-8?B?NUxLcG90bUxsR3lLZFFoOWVoMmMxM0dhT002dlY1ZWlqWXp0aDR2UEQySlFO?=
 =?utf-8?B?TVYzU0YrQ0tyTStyYkhMTjg3akNlclg1VE9iMXFManZWbE1wY2RIcFBRRTZo?=
 =?utf-8?B?dldFUllaeUJWaUdLeUlFN1J6UlNVNHNPdWZINGJMVThFNGo2Z0tJZ2NhVkJy?=
 =?utf-8?B?WHVXTmdEUFpmUjBZbnoxazRsa2RwdDAyOWhpUDhWUHF5SEU3NWh0ZjJkYW8v?=
 =?utf-8?B?em5YRUw0bUYrcldjckMxSUFsYkx3S3dvMEFqb3EvRWxiRWxXYzdHd3hHYU0r?=
 =?utf-8?B?cWswL0VpWXZ1cWFZOWtEeTJLTTZiMHZLTXJtQmJuT05jNGsydlVlSTVGdlFi?=
 =?utf-8?B?akdQekFLR1BwcHU3WGYyaGFMczZWR0dOaEhyRDdZK3VJSE1YY2d0Ym9tNW4z?=
 =?utf-8?B?R3lpNFgyZXNWcTk2ZGg1UEFXR0RSUEtzb3JwQzY5ZmF0YjlqSEhObTBmeCtO?=
 =?utf-8?B?cXF2Y3hRWEVmcFFDRGYzdGd3bTlkbHdacnhaK09PY3c5VXJYa1ZBZ1NadU5D?=
 =?utf-8?B?NTI3T1hPWkNxaHJZb3owOVdmU3VBdEI3RXFEYmt2OFRxNHpSNEwzNlZVMFAv?=
 =?utf-8?B?YlZIbnlsaTRGTG0wQXFJeWdjcCtVQ1pManBwNXZOTnMxWmJPMGdWZFZlYld4?=
 =?utf-8?B?bnNtUXZDK1VNdXVnVkJlZDRITGdvUEZZQW44YW5GcW10aUV6TlM3bnEra1ZL?=
 =?utf-8?B?R2lTNUtFa3ZiSVZiMTFDT28zMHVrajhOSWRuazdvSkZCTWg5OUdqNnhQcTZX?=
 =?utf-8?B?UndEUUExd3VMcEpYR2w2RVh4aGNJZEIxMTV5alF5emIva0dNbVZuWGZ5bE5u?=
 =?utf-8?B?VVhNVnY5R2NFWmo3dSsvbUJFM0RTL1NCVVRVUVkxRTRuRFVVN3B6WTFzcjdH?=
 =?utf-8?B?OFhTdk1ISyt4NXF2dnBhTVE0WklkL1BPempvMUQ0S2J4Q2hMWUw2aVQwUTRu?=
 =?utf-8?B?TGtEelBrREQwUmlMTENWZTVlTVFzNzZiZGpwM0NqdzhrWTlGVDZDaE14OGtn?=
 =?utf-8?B?VW1wa2FValNYTmZHaGZlVVc5WEEwWGNmQXF3dDE2WjdPYU8rNzJzRHJOWXow?=
 =?utf-8?B?RThoK0tpQVJ5cjRVVUMwc3BoQnhuZG5VdDNKbkV4QjhNQk5xaGtVSncrTlVv?=
 =?utf-8?B?MTVZRnpwT2Z6QWtTeWdUOCswalhhbEVoSGEyNnhEbGpkSUgxS2JaaE9QdUtk?=
 =?utf-8?B?UXczZ1pZdndoeUQ4b3RGajQwSUVhU2hpaldaRzlYbEt6dUdJc1dFUFE3cUoz?=
 =?utf-8?B?WTdHY2JHVGsyVTlkTFdCM2N1ZEZyNkJxdGhUNnp2V0FFMUwzVnNGV2xvdjFE?=
 =?utf-8?B?NllESDI2MmRUdzF1ZENIK2o0TFE3bjdTTHJNNkhoV2RiYVVrSVdRa2JTWHlR?=
 =?utf-8?B?Tnh3MHB6Y21VMWU4M1hrK1hHbno2NjJwNVllZWJxVU5qQXlWNytNRk1wNWsr?=
 =?utf-8?B?bDZZNXZOU1B3T0JyYWwxVk5FdlpLSHZ2M1QrS3RUcnpPTkJTRFhrTUJpeTFG?=
 =?utf-8?B?MXBta2N2Ly9yUnVqU1hjYnNjc2VCM1paWi9JZjBPV1d1OUJsMVdQNG8zZWhU?=
 =?utf-8?B?QU1MaEdscy8rT0xyV1RTN09CM0o1akRGZWkyWmYwYjdMWERpdTRHbG5UZ25U?=
 =?utf-8?B?NUdldmpDZlBCWDdqdmNRT2MvZ2YxRXZRT0ptWVJiczI5S0dIdStiVzFKcDI1?=
 =?utf-8?B?QXpzVlhPVjRhQXhEZzk1dHcwa0JoUVZtNVJnS3lMUHExQjdiWXQ0NklMdUVy?=
 =?utf-8?B?SEFSRzhzenZ6cy8zN2tWbWxTWmZBVk9rSVBpQ2JLUmNmVElwU1RzWGNsUzVU?=
 =?utf-8?B?bysxSHlld2FhdnY0andaSnlJOXlUNndzYmd4SkxrNkUxRFlubXdyTGdsVXdx?=
 =?utf-8?B?SDAvamdRdGIvTXhaOVllb0tnd3ZiRTMrcGoxeWFVM1NhRy9tc2t1TXNzazRO?=
 =?utf-8?B?RHJZaURUVkFpclduS3U5TlgwTEtKYXBTVi9Fd1V4SDZDZ3pvdjdRWWd5OXpH?=
 =?utf-8?B?eVFncVpLOXp6akFqQlJDQ251dytKcFNHV3ArYU0wdVR1NTNnRjlGMXFqUkxs?=
 =?utf-8?B?eklVcm9LQVY4dExZRmg1VlJTZ3IyYktzeGNGdFdibnNWVStJRlZhMVJtV056?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94d506-5562-4bc3-eb26-08dbbda14b67
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:27:45.6737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DQjlaQwhCh+CDwLRdQqtB+oE4iSndcH6/hZPrWqBwxLH4j/8u/BpTAQVyrPALYBfC4mfk694tsZLVomIeXoyfUlpoWMGSXjZ/cfDn3XrDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5331
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

On 04/05/2023 14.35, Rasmus Villemoes wrote:
> On 03/05/2023 16.54, Tom Rini wrote:

>> The one last problem now is on stm32mp15_dhcor_basic which is a
>> defconfig missing one from OF_LIST but including it in the its file, so
>> the above is the patch we need.
>>
> 
> Hm, well, for now I think at least all .dtbo targets need to be left in
> the Makefiles, since nothing in the defconfig tells us to build those.

Hi Tom

Can I persuade you to try something like
https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
again, but leaving the .dtbo targets in there?

I could send a patch, but it's entirely mechanical, and not really meant
for being applied until we know if there's more to be cleaned up.

Rasmus

