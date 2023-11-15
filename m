Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2705EC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 18:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F2587278;
	Wed, 15 Nov 2023 19:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="GUinyxYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213B687266; Wed, 15 Nov 2023 19:00:31 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7199870D2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 19:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2Y+M1ZWdE+CsvhZ8XXMMqDb/V/hRNlnngWQ/N33uvIhsa1KF179w1dxm3rY5r8e58ys7ZgbLU65d2JbaCsrLn4BtYivrtW6pUwD1/eV/nt0NRtq0mRkGsTgeWa5OwOQIUtI3N1QxNt4GWjIU3s2xQuNwLHXTJLsek7g1mmWZBqyxclBMHruZH7fRvlg/FPuh5ysMV+cknX30EUOva1PiAWhYOulavSYg00Rp5uVVhdACbHzLepfjB70/dmRJpdTdkLmagt/ssF7xe3gwI0eSp5sJtuoStGPTD4d7nP82LFunbMCLwp0y3URflT6eLX4mppq71VVCqYjiaa0f4ppmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzEzt48GKCnFWe19w+Fd3nAXjqBGzI48F7sp8MQML14=;
 b=mfT9LPbuNjGWaTr/LsCB16VaSgXVGjTZ2TLfEJAiCfuJa8kX5VU99S0x/dD+hTM10j4ZRQQEpI7XOVjVpucgkigr/gxrn3AImwx+165eE5tG6kgej6BkMF5RdLmAO44V0LIpomg4VgHSnu9PWE/3Ee2OG+6Pr43zPxwK6hy+IAQthsUy82ofgrWqxAddayW46NODid4YxZRwY6+5D2W1NUCS7go6RvKJEjPg0KquvvkgYTmputeglwVrHiCcIKfA3oPvCFT3T810b+4b80SA/Oph5bX9ETRVnK7EGWDys6zzbj6cg+uOWAVPU5jbh/8rEbDJhIBSK5Tkkf8GdI9iFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzEzt48GKCnFWe19w+Fd3nAXjqBGzI48F7sp8MQML14=;
 b=GUinyxYmkEMoE3oN42zZ7ADgz3IdTF426RUijeTpgJgqlS/5KmTvqoqjnpLdnEZDRW3UwVOJQrvbw9R4CCKyfY7NnvZuTLcJcfQyRhhAlNE+bZIxbQ2l7GeZTIgIwDXV3u1ic01LO3Z3TQkWMzzc2tTlLu+WLmzmbJuZGkWNROQTw7fDoPwqXgE6bdwo2bX/pP08vYs0Cv7p55/bot6au2ha7qPuYxJWLJKEfQ1qm03GXBSd7fsxcDTFY46cS9Rzqabc8ZUb4DUjR0i7r18ArG9w5yx8HGqtexqwSdP6Gxuof86R/dZKb5YzV7MY6m/ze5dSUUMaU62WBEQea+y4jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8905.eurprd04.prod.outlook.com (2603:10a6:20b:408::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 18:00:26 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::8853:974d:615:508]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::8853:974d:615:508%6]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 18:00:26 +0000
Message-ID: <1ca36fad-6c54-4453-acf2-64758187c682@theobroma-systems.com>
Date: Wed, 15 Nov 2023 19:00:23 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sr@denx.de
Cc: u-boot@lists.denx.de
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Error building PX30 Ringneck with WDT support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c93246-ba63-4384-2586-08dbe604bee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtlgVCWVZkppBVTrvspmTW9228cKIvZyopJTDv+pgUV4Dr23Wa1h8D8NeSwRDvt21ZyNbV+bfDzWHgO5rxfAz7GOr76TDcrQ3VNq8la3Tqt9XC521FB2Zvq4WHokKSG/uufJtX2hEieBhsIhpRKuK6ivkP+/jHxPIDpNzQLdE7b1zyuohhxLlYcj3EFJo4a3mu/gWsu8tYoq3T8LfOOTB7ZTSV06sucmvwkSbM3S7MIy/zO46o2fH0wrgJ5gqatH3yCVGQZ3g2r2q0HueP68F5byQPsJkbH2LrQx1WsRnxfzA/s4FXxk7GLQCypZMZVSUY9NML6XeUpDmpPGIe53k8gpvCo3FOZJI47YgZWOepkoMUOKjaqZqh0lATg7EGvm7Nm4vw7tM3H6AWsXv3e6f6+R5GkXoVcQ8YghXrneAumrKjZZKVaeRIVpvexMLbRQjAfXxTvxdybd2d1jPek1ZrvZiIPhzcbpsuhTw07iQzdB1+nmYsdis3h0hv+BcP/YvYA4g67KxaTg/N6UjedUZXdkHRL6kHPfLRQt7Z/HudBzdWUhACsmYBd/H0VnIm6tVgD8+GmNALaUZs2lI1uz48i+fqJgWiVb9eyaqhBz4JENKcc8rSD5dzicLjwY7QH5a6vAuJn2B1sHlkCe2gcmJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(44832011)(5660300002)(86362001)(2616005)(31696002)(6512007)(41300700001)(2906002)(478600001)(6486002)(966005)(66556008)(66946007)(66476007)(36756003)(6666004)(8676002)(8936002)(4326008)(6506007)(6916009)(316002)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9KTWdxbWFubGkzR1lleDU0T3dTNDJFbjFmRmdUWFlaL0JUb1c2UFdoTjhR?=
 =?utf-8?B?UXpVZzd4NHZWRXUyZnNmd3REZWxrOEI4dFcxREJWeGQxQnozS3E1c3NOZmNI?=
 =?utf-8?B?K0duTmxkMEc0Zk1FZkFyM0lVQmRsUGlaV3h6NmowSmZUN3k2M0ltSCtMRVRu?=
 =?utf-8?B?RVVNbm9GNk96Y1BOL3V5dXUraXA3SjVwN1Eyb1ZIR0s4alFpamlLME1jNU5G?=
 =?utf-8?B?ZHRPTXkvZ2x2cDFzV2dYZ3BsYzg0by9DZVVnNEpOWktmTmpOYkpSckxFSUhD?=
 =?utf-8?B?WkFtUTh2VkRyYTZnVlBUZC8rZ0ZUZFRwZnltR2w5UFVFMVRRbkMyT3ZrMFpS?=
 =?utf-8?B?UXpsUThla0YvT213ZzlseEJ0cUQ1QWpoNzllMmVibC9xUEVGUHIveXN0MGln?=
 =?utf-8?B?ZmhiNFcxUHl1NWNRZDBlZ1NjVTlOblBSZGUyeEs2eWVFcVdSS24xZFlQTnhD?=
 =?utf-8?B?QnNhSEFDMElDeHZsT08xUTlmOFh6ZVdGRFV6RWo5dGh3MUlNNkJOU1ZWN285?=
 =?utf-8?B?dUw1RHRzVU56UFhjd2JXUEppejA4WEJ5UmdtWGhjeEloeVBWOXRoNDlFUitr?=
 =?utf-8?B?czk2UTFDSWYzY1VlVDhMdWRGR2hqNGNQdzF6a0xSdFR4MjlhMVRVekZuUHVj?=
 =?utf-8?B?ODBobjNIbWhWSXhQc0FXYkJrL0VJWi80YjhNbXorNkFlV3EvbUhSNXhlbTM1?=
 =?utf-8?B?RGd3NEkvL2pOenZNckFmTXFpcWpoeWlQREdOakphclNjdFNLSjB1dTJXSk1Z?=
 =?utf-8?B?ZCtTRlNtTmNmdjhIVmt1bmJjbnErajY5VkhnbENjUzhOK1NnUHY3dHJadVlW?=
 =?utf-8?B?NXNLNW5qUUEvN1I3TUVSSy9xSkZXZDkxcmtOUW9IbmJ3VC8rUzI3aThzeERa?=
 =?utf-8?B?MHk1YytiTlVlK0wydWl3cEpZc01iOVY2VjFDNXE2YlcyRmV1ZENBYUdLdnAz?=
 =?utf-8?B?VUd5dTBYSEVnaG5DekZLaEFEWEx3KzdUbkNHQ3dxaXZKc3p0OGNKTDl0RnNE?=
 =?utf-8?B?b0RGTnlIRWJXdUxlVWw4MXAxZmxMb2pLSFlNbzdBWEsxNXQrZnordTFtSXpW?=
 =?utf-8?B?QisvZ0dkYnU2L0VuaENla3ZoaS94RTBLZWJLZ2Vxdmh0bGQrN3dqV29pRXc4?=
 =?utf-8?B?eHhNa1BqMlcwUUw5d2hvamhhVVU2Rm9HVU1LV3RhL1BnV2pTMmo1V1VpRGIr?=
 =?utf-8?B?VC8rRnEzb3VnMzFZSU9nVk1hbXl5NHcwNVdnUjYzaVZOZ09LcFVBRDNiRG02?=
 =?utf-8?B?L1JOdEJENEFGOUxHYnV5a1dtT1V4M3RDdy9idDZrNWEzT1FuVnphZHdsNTMx?=
 =?utf-8?B?M1NnMWRJeStUK0laTDYybXNoOUFhQVdlRzh1amxhN1IrbUhuQTBQbzVHQ2Fy?=
 =?utf-8?B?bXR0L09qQTI1OFZPQkRBVFEwRFF6L05nZDhMNC9aWkpVOThscVR5bmxTNWc2?=
 =?utf-8?B?NjhqcHhZQjJIZ2Q1ZFo5bTdqU2F2SWR2SlBWd0YrbHB6dlA2MXJXZWk2R0JU?=
 =?utf-8?B?UmQwejhHNDZ6bktvemdIOFJKVFY1Q25BSVhvMFN2azJ0UWNHOG1HKyt6VnRW?=
 =?utf-8?B?eGwxUWpyUzJzdGdMc1IvTDgrR282NUFlOWQzeHdrN2JYWElSbWxaS3BNZ0d0?=
 =?utf-8?B?eG9uUlQ1RHdRUFQrNVdzNXo5bTZvU2NXZDQzUVVmcERYWkt4OHRHSTQ3b2JY?=
 =?utf-8?B?RmdGSU53Kzh1TUFHTU1UYjhBdExKN1pLYlg0d0piWHJhN05ESXoxNkZrTVBT?=
 =?utf-8?B?ZWZobnhKNytYdFVIRlcvVnR0S0lCSUMzR3V3a29BZFU1eXIvWTMrSUpGajFu?=
 =?utf-8?B?MERuZ0JlUE5HQzlDRkdvenZqL1VWNThCR2Y4QmxKVGU4anEvRm1kTzlrS1Ix?=
 =?utf-8?B?OEJlRzF1UUp0UUcvOXpyaUhEQmVPSEFtcGtlemFoWnNYQ0UxZTBrd0NkdjdQ?=
 =?utf-8?B?TFVkYWxNaS9sUkVYZFFCU29LWjJtdVRDV0cvcmNMU2x3UjJkRklaamRwZUs4?=
 =?utf-8?B?djE5K3IwczFtLyt2bGVzVUlNUGN0QWIrOS8vVXFzbnhScEVVVTNUK2ZNazZB?=
 =?utf-8?B?cnBGTzZ1bnNSNXhVcHZtSTZtbVNzL2ZDY3QwbzN4NUwyaCtnQmYyaThnQ0Nj?=
 =?utf-8?B?bVFjOGNvcGdadWIvekJaWGdCTlF4OUZlWEtFOC9jUlkxdlpMTkFHdVkzYytU?=
 =?utf-8?B?QmRHc1BrNWJYR1QrN0lNOE9uRnFlOGcxT1owZVh4K3pwMmp6a3dtVktxd2Ew?=
 =?utf-8?B?cWdLVnBzMUNiOWFFd0Nkb04rSm1BPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c93246-ba63-4384-2586-08dbe604bee6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:00:26.2899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFIGQ3xqIGvGmXdASIEJCI8/pKYcLu8whBJwIGgW/foXMKmMek+ufCFVtSLK3YZriQyJv0noaPX9pEM4YY34rnIK5q51Hir5nIUM2/2ETX0D1tEWjNgqJj/IO/441qXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8905
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

Hi all,

I'm trying to add watchdog support to the PX30 Ringneck board but it 
fails to compile:

"""
diff --git a/configs/ringneck-px30_defconfig 
b/configs/ringneck-px30_defconfig
index b314636b4d9..3dab0dab5d4 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -122,6 +122,10 @@ CONFIG_USB_EHCI_HCD=y
  CONFIG_USB_EHCI_GENERIC=y
  CONFIG_USB_GADGET=y
  CONFIG_USB_GADGET_DWC2_OTG=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_DESIGNWARE_WATCHDOG=y
+CONFIG_WDT=y
  CONFIG_SPL_TINY_MEMSET=y
  CONFIG_TPL_TINY_MEMSET=y
  CONFIG_LZO=y
"""

$ make CROSS_COMPILE="aarch64-linux-gnu-" ringneck-px30_defconfig
$ make CROSS_COMPILE="aarch64-linux-gnu-"
[...]
/usr/bin/aarch64-linux-gnu-ld.bfd: lib/time.o: in function `udelay':
/home/qschulz/work/upstream/u-boot/lib/time.c:199: undefined reference 
to `schedule'
/home/qschulz/work/upstream/u-boot/lib/time.c:199:(.text.udelay+0x1c): 
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 
`schedule'
make[1]: *** [scripts/Makefile.spl:527: tpl/u-boot-tpl] Error 1
make: *** [Makefile:2073: tpl/u-boot-tpl] Error 2

FWIW, I had this kept on a downstream U-Boot (v2022.10, on top of: 
https://git.theobroma-systems.com/ringneck-u-boot.git/log/?h=v2022.10-ringneck) 
and it both compiled and worked. I assume this may be related to the 
"new" cyclic support?

Looking for pointers as somehow I don't really understand the error. 
schedule() definition seems to be existing in headers included in 
lib/time.c so a bit clueless at the moment. Probably related to TPL also 
as it doesn't fail in neither proper nor SPL build stages it seems.

Cheers,
Quentin
