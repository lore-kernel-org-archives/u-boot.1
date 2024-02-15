Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2C4C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 19:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E2C87E1B;
	Thu, 15 Feb 2024 20:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="nprnYJ5K";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nprnYJ5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D4D87D80; Thu, 15 Feb 2024 20:36:04 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1020F87E1B
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 20:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=aWFDmaug7My15d70clSOnIS9ucLc4m/p8eOgjtAAoy98rv9AAbx/giAn/C+mP2zJYhKSnHi8dzsNLupgew1i3pODsARJhqit3q6VDUdexbFr9pNGoGlCRoKMrG/sQiImvXaf4HtfMkzhNW81+S63WYCoWkdzNyyrw//4r/iQikt1HTZeIlKK5MeoGhGRP0DVwYU/s77P0XZ9Hdq//xsaOySrDT1zcXm2/cGUiBPiBxWej0t4akDX/Wo4DAXP0E75UGa/zupDx/Ls6SYJndIaXYA0nk0MtwH7DJ2gOkxlmMTlG/VysDPapLgJTMqpmexXxgqe3n/EOQBII6PFoXhcrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW78uVokJxXIG6U2PeudsYnWiSREvuIZvZNNfwJ9QkA=;
 b=RKSHJ+hBeHGQ62zupeCz5NCHX9c3DBkxETAz5t9npaHFXnMnIl30hFpLmdKFf9AiLyuN7QXsx/mbyNN6mpKdpEcg9cEv/qDazu608ubmfbCx9vhQueKIQRu5vUH+ZvPX2mQbRmw9sTUFFwqL+AwUlSkO765Khks7zhDtkmUIVm/FATFwh8KItSzcw7bs0mmfBCU26svLaJ0WWUoUaMuXB0QKCayBc8VQDw3cux0+FBEXBdspxgYybWDT1mkPQ0m2LpnJsJsqoSFffS25/+CkFRH5xsf60CbY5lNknlgi9r4b+hEddsn+c0rJh83U92s6owHj8y/OKSCLwRUh7JlS7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW78uVokJxXIG6U2PeudsYnWiSREvuIZvZNNfwJ9QkA=;
 b=nprnYJ5KgfDsSOAolBv73xo6j/0E7TMTlOrwsfdSoLqAxj2+ohxGpeTFNeeLviWV3CDVnSxK7iSt08lcd1v7AhVvzuoOO5i3H6zwL27meJFJ6bcBc4Nw2CMeoRmvNHt20KBQ1PBCb+ho8bhxDUAtlosz3lkcCHrgSMpIH3sqPoZcp66O5uoBaTk32jCWUtmXC9bvedidkIVJkHtuucCyhyliLVtYBuBIzgQSs0jPTgA2xDjIbYJsJSOEA/S7vuFMRK2mlfQ0cETQZtOqxZwjLMDNBK0GXzLPhxtDLu0DYjyw6FIyCVfYH5lMTMR0CuBekv8AMYUGGyW5n5j/h50fKQ==
Received: from DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) by DU0PR03MB8598.eurprd03.prod.outlook.com
 (2603:10a6:10:3e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:35:52 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::ac) by DUZPR01CA0073.outlook.office365.com
 (2603:10a6:10:3c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:35:52 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 AF91720080F8A; Thu, 15 Feb 2024 19:35:51 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.17.169])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 4D7532008006E; 
 Thu, 15 Feb 2024 19:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWpSh1JUpPqaw2L0JY/Onz5Kmzh8CU2YV1vzYy2SAk1mzQiXIAbGZ4+RvPlTeYxd2L58kMB2q72Yy2TQJkc2KpPZcQAw1Uu1ciznitu+EKjUoF/WpXzuXoOfDmN1r8eUzSESyjSJnsZbBLziZ0jtUUGjm3cIn20/JOrjgI4Sp20Nz395/ZyVaXUSQmEr/zHzcrC0HHmSEZGNgEjCjVFEqA3GostVIiL2dp3PJuyLHloA+n16oT+a3Fg+uZXDwDW8nk+gTsnvoi5rcR8hzS5xasaoAYwgC82Oz+cpUQ5ZoUiHp0UnfOl2L2qhYiAnqe8aJ2n60GFiyuaH/XH5G1e1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW78uVokJxXIG6U2PeudsYnWiSREvuIZvZNNfwJ9QkA=;
 b=R71T3nrs9ExmuhJevF7JkgcGvZ0cdsjpN2KIEPIMEzRLd5vEjumseifNbyg/0T0jjajIWG+o+hVdhDVwDuNxTm1Mr8dMvGQh407IpHiWw8o2y35W2rmnb92F111rNprJb/F+ImT8EEplEOC0vUeaiqJUPSgM8DdyEFC09kXF4hUHjFsA7kgYdfU7pMjGIYN5pnrLWzxTioh7v4S/MR4byy/bSW+swPi6A1hOC2zXxMdiV9o5GZtPRDisVIwtYfYCRFn+e1DLIcCyAhLnTD3mCnkMASkH8Di4TxEdujLcKFkKM7wEuCY0KenXRgkXnBfYpP49JE6XCp1NazPm8sZScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW78uVokJxXIG6U2PeudsYnWiSREvuIZvZNNfwJ9QkA=;
 b=nprnYJ5KgfDsSOAolBv73xo6j/0E7TMTlOrwsfdSoLqAxj2+ohxGpeTFNeeLviWV3CDVnSxK7iSt08lcd1v7AhVvzuoOO5i3H6zwL27meJFJ6bcBc4Nw2CMeoRmvNHt20KBQ1PBCb+ho8bhxDUAtlosz3lkcCHrgSMpIH3sqPoZcp66O5uoBaTk32jCWUtmXC9bvedidkIVJkHtuucCyhyliLVtYBuBIzgQSs0jPTgA2xDjIbYJsJSOEA/S7vuFMRK2mlfQ0cETQZtOqxZwjLMDNBK0GXzLPhxtDLu0DYjyw6FIyCVfYH5lMTMR0CuBekv8AMYUGGyW5n5j/h50fKQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM7PR03MB6216.eurprd03.prod.outlook.com (2603:10a6:20b:137::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 19:35:48 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:35:48 +0000
Message-ID: <67193893-8774-4add-a7ba-b9f0b846290a@seco.com>
Date: Thu, 15 Feb 2024 14:35:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
In-Reply-To: <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:c0::27) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM7PR03MB6216:EE_|DU2PEPF00028D05:EE_|DU0PR03MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d01b1a3-4ee0-4c6b-a82c-08dc2e5d51f7
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: K1bdAHvTpAHlZRq1htUumHnIcHzmr3UxdtSvCIT412bh5cKySdSOy1/MWIMlsI/0Fcu2FRGbJosfLiFH6aLsNBrK0/P466o3dKykH1YaCFNICKhWNEpEGVSjv6uh9FqTZsr6xc690bw/CeCck8regF6Hf694XxCiX2D/BFMJbfX/8EezocCdWC2VHgkMwWz58HTYv/NPqY7JaDsf3pr4zxY2JIfGf01NJ5HQsYIOwF59RzDbkJvqWgdT+oduo/JLtMJtXnV+mX7xPgpCcdCXSkIDkoZsGCsLSy39zQqpLWVlA/dBJ2kw1P8lnwwI5Z4FtSk+nc7O3pOUq+u0BePXgxCKLWhQ1DoNYi96yrreQ055zh8fQHl0NqqbiX22hF/XFQ07bnoZDhsMJ5PIkDh6gZMPyScaisw/0HfbYhCzkPgx1Z9ohUeq1bNUlXpzRf9UK0XrqhoeA1arVMzUXFJLR4RMWfU8wJRTxQB0aHU0rC4MUav6T7hy29rnSM/6Xxzu4BdVfMJPLa2V6mNHdJr6hsHy7lFiKQhEAoxw24I4VdY6BQ08Qd4hbWJUniC02ZV8dTZzxWemWTWf72tSnoj+89c+36STyNmTf78Brn9ZyFg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(136003)(396003)(366004)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(53546011)(52116002)(478600001)(2616005)(31686004)(41300700001)(44832011)(2906002)(8676002)(8936002)(66946007)(66476007)(66556008)(5660300002)(6506007)(966005)(6486002)(6512007)(38350700005)(316002)(6666004)(83380400001)(38100700002)(36756003)(31696002)(86362001)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6216
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f937a3eb-64ac-4194-d32c-08dc2e5d4f8d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaA6aKB6+6vJRpzmEr3qbnxsta8PnGtITf/ntCFsPBsbKm9GWwdJP95V42Chqvhf0RgpeTaMW8qQzt5oD6Dqjx+M+wz+Mw67EVdyKDff3J/ueJCS8s9wYmcmW0cx3xe3nCtqdziusFPLyjfA25PKCg+y6f8ou/fEYDpzETDe19yyQq+wXTWIHmSWV1POaWCGvRPovheqKnFhBEQLq+vP9KeynN1/FHX4PCvb2V3AB2dk1dl/n+UyvCMAQyY4Xb+xeQwmh1ZF2mvXV2oiFKqOGEcwH1N6DME76DEy/HyMSTP9VtgZSqv0T6ZZQNJa+LBhFgt+hF1mWtgPkT8IKANHn2qjY/ZiVs9wzj2RtsTYvwibithK6RqOmeGWQTmsiUDz3UsqRMag0uNAG3JIMn/F7cx8bFh7pzaXaOiSLEwEwccUymbPkfb6Wy2sN7Lv9c2zCpeWYudhtwl7RnLKmj0vJSrfYSTg4Yo7U/TYnoskkF1x019W/PaxBg1xslhS6zd98MSfToqB8aP4rdmMDtVNBwWo41q3znegWK8II9pqjrz3fkB1xc0a0cWkVZbVhXw5OWDiZGMzGAw2GWi6icJXencAF/xUxtBmnFO/WOmjOU8zx50tqbhU5j2XvAaq/Sc5KDHdmGLTeBEEqYVKgcq4Cg==
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39850400004)(230922051799003)(230273577357003)(1800799012)(451199024)(36860700004)(64100799003)(186009)(82310400011)(46966006)(40470700004)(2906002)(44832011)(31696002)(6486002)(6506007)(2616005)(478600001)(53546011)(26005)(83380400001)(7636003)(8936002)(82740400003)(356005)(7596003)(41300700001)(70586007)(70206006)(336012)(5660300002)(86362001)(966005)(6512007)(8676002)(36756003)(6666004)(31686004)(316002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:35:52.0695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d01b1a3-4ee0-4c6b-a82c-08dc2e5d51f7
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8598
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

On 2/15/24 14:31, Sean Anderson wrote:
> On 2/15/24 14:08, Michal Simek wrote:
>>
>>
>> On 2/15/24 18:19, Sean Anderson wrote:
>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>> However, this is a bit tricky to time, since the debugger has to wait
>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>> long waits, since occasionally initializing RAM (and other things in
>>> psu_init) takes a long time to complete and the debugger must wait for
>>> this worst case.
>>>
>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>> debugger when we are ready for the image. This means we don't have to
>>> wait any more than necessary. We don't change the default config to
>>> ensure we don't break compatibility with existing debuggers that don't
>>> expect us to hit semihosting breakpoints.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>>   arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>> index a0f35f36faa..5af735aa5ce 100644
>>> --- a/arch/arm/mach-zynqmp/spl.c
>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>> @@ -9,6 +9,7 @@
>>>   #include <image.h>
>>>   #include <init.h>
>>>   #include <log.h>
>>> +#include <semihosting.h>
>>>   #include <spl.h>
>>>   #include <linux/delay.h>
>>>
>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>   }
>>>   #endif
>>>
>>> +static u32 jtag_boot_device(void)
>>> +{
>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>> +}
>>> +
>>>   void board_boot_order(u32 *spl_boot_list)
>>>   {
>>>          spl_boot_list[0] = spl_boot_device();
>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>          if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>                  spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>
>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>> +       spl_boot_list[2] = jtag_boot_device();
>>>   }
>>>
>>>   u32 spl_boot_device(void)
>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>
>>>          switch (bootmode) {
>>>          case JTAG_MODE:
>>> -               return BOOT_DEVICE_RAM;
>>> +               return jtag_boot_device();
>>>   #ifdef CONFIG_SPL_MMC
>>>          case SD_MODE1:
>>>          case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>
>> Good timing. Can you please tell me how to test this? What's the setup?
>> Which debugger are you using?
> 
> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2freview.openocd.org%2fc%2fopenocd%2f%2b%2f8133&umid=819f1021-60b3-42c6-ac85-f327c489da7c&auth=d807158c60b7d2502abde8a2fc01f40662980862-7485d72bf875c6ddb963725debf981fe8dd33731
> 
> My boot flow is
> 
> SPL -> ATF -> U-Boot (no FSBL)
> 
> This allows me to use a FIT which saves some time since I can
> compress the bitstream. Right now I am using
> xilinx_zynqmp_virt_defconfig with the following modifications:
> 
> CONFIG_SYS_LOAD_ADDR=0x30000000
> # CONFIG_SPL_OS_BOOT is not set
> CONFIG_SPL_SEMIHOSTING=y
> 
> I also have CONFIG_XILINX_PS_INIT_FILE,
> CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE, and CONFIG_PMUFW_INIT_FILE defined as
> appropriate. I use the following FIT for U-Boot:
> 
> /dts-v1/;
> 
> / {
>     description = "U-Boot and ATF";
>     #address-cells = <1>;
> 
>     images {
>         atf {
>             description = "Arm Trusted Firmware";
>             data = /incbin/("arm-trusted-firmware.bin");
>             type = "firmware";
>             os = "arm-trusted-firmware";
>             arch = "arm64";
>             compression = "none";
>             load = <0xfffea000>;
>             entry = <0xfffea000>;
>         };
> 
>         fpga {
>             description = "PL Bitstream";
>             data = /incbin/("system.bit.gz");
>             type = "fpga";
>             arch = "arm64";
>             compression = "gzip";
>             load = <0x7c000000>;
>             compatible = "u-boot,fpga-legacy";
>         };
> 
>         u-boot {
>             description = "U-Boot";
>             data = /incbin/("u-boot-nodtb.bin");
>             type = "firmware";
>             os = "u-boot";
>             arch = "arm64";
>             compression = "none";
>             load = <0x00080000>;
>             entry = <0x00080000>;
>         };
> 
>         fdt {
>             description = "U-Boot FDT";
>             data = /incbin/("u-boot.dtb");
>             type = "flat_dt";
>             arch = "arm64";
>             compression = "none";
>             hash-1 {
>                 algo = "crc32";
>             };
>         };
>     };
> 
>     configurations {
>         default = "conf";
>         conf {
>             description = "Boot ATF and U-Boot";
>             firmware = "atf";
>             loadables = "u-boot", "fpga";
>             fdt = "fdt";
>         };
>     };
> };
> 
> Boot output looks like
> 
> U-Boot SPL 2024.01 (Feb 15 2024 - 17:03:10 +0000)
> Loading new PMUFW cfg obj (1848 bytes)
> PMUFW:  v1.1
> Silicon version:        3
> EL Level:       EL3
> Secure Boot:    not authenticated, not encrypted
> Multiboot:      0
> Trying to boot from MMC1
> FPGA image loaded from FIT
> NOTICE:  BL31: v2.6(release):xlnx_rebase_v2.6_2022.2
> NOTICE:  BL31: Built : 03:55:03, Sep  9 2022

Whoops, I attached a regular boot log. Semihosting looks pretty much the same:

U-Boot SPL 2024.01 (Feb 15 2024 - 17:03:10 +0000)
Loading new PMUFW cfg obj (1848 bytes)
PMUFW:	v1.1
Silicon version:	3
EL Level:	EL3
Secure Boot:	not authenticated, not encrypted
Multiboot:	0
Trying to boot from SEMIHOSTING
FPGA image loaded from FIT
NOTICE:  BL31: v2.6(release):xlnx_rebase_v2.6_2022.2
NOTICE:  BL31: Built : 03:55:03, Sep  9 2022

> U-Boot 2024.01 (Feb 15 2024 - 17:03:10 +0000)
> 
> CPU:   ZynqMP
> Silicon: v3
> Chip:  zu4
> Board: Xilinx ZynqMP
> DRAM:  2 GiB (effective 4 GiB)
> PMUFW:  v1.1
> EL Level:       EL2
> Secure Boot:    not authenticated, not encrypted
> Core:  67 devices, 29 uclasses, devicetree: board
> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
> NAND:  0 MiB
> MMC:   PMUFW:  No permission to change config object
> arasan_sdhci mmc@ff170000: Sdhci card detect state not stable
> arasan_sdhci mmc@ff170000: Sdhci card detect state not stable
> mmc@ff170000 - probe failed: -110
> mmc@ff160000: 0arasan_sdhci mmc@ff170000: Sdhci card detect state not stable
> 
> Loading Environment from nowhere... OK
> In:    serial
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Bootmode: JTAG_MODE
> Reset reason:   EXTERNAL
> Net:   zynq_gem ethernet@ff0b0000: failed to get tx_clock
> zynq_gem ethernet@ff0c0000: failed to get tx_clock
> zynq_gem ethernet@ff0d0000: failed to get tx_clock
> zynq_gem ethernet@ff0e0000: failed to get tx_clock
> No ethernet found.
> 
> scanning bus for devices...
> SATA link 0 timeout.
> SATA link 1 timeout.
> AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
> starting USB...
> Bus usb@fe300000: Register 2000440 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> scanning bus usb@fe300000 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Hit any key to stop autoboot:  0
> 
>> Also curious if semihosting serial can be used in your setup.
> 
> I haven't tested it.
> 
> Hope that helps. Unfortunately, I don't think all of the above is
> documented in one place.
> 
> --Sean
> 
> [Embedded World 2024, SECO SpA]<https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.messe%2dticket.de%2fNuernberg%2fembeddedworld2024%2fRegister%2few24517689&umid=819f1021-60b3-42c6-ac85-f327c489da7c&auth=d807158c60b7d2502abde8a2fc01f40662980862-bc7bc969189f8a12494ee2b4c211c8f322e167f8>

