Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F46BE732C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 12:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500C986537;
	Thu, 28 Sep 2023 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bGuOov+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411D286504; Thu, 28 Sep 2023 14:50:14 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E5286504
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 14:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg2orrLkEn/p5x25UoRpXri/5cZ+qUFsCA70u51gx7CphoQ+ORTxc5QRzG39hd9RwD72C/TFU21wvn4CnB2mZS8Pn0rAY2D6Ycr2hT64xP4+mImHXo14yh71NgL4ElVJpEdRBuIe3XLp24/0BmGQmy/+O54VdwxRd5644GiMRvT0B7Jqg5OnGN92GAWk5ySEdyEx6J1EHlehaGCRM1uck21QGVMTPVWwgeuvFNYzguFAD3zPuoJ6hY6mMd7Q5etzHatfqTCC1mu0K3tq/7+cdCOScx3L2jtpRvgcnsz/o27RtZqoQlSXUD30wXdlYZz7baLoB8WHbIYEOVvJpyychQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+kBmEQjFAzUnd6otMl5LiERVKs7sITbOhEv+GXwhtY=;
 b=HnLmYQqUFlNY5UkN0FpS7WjpH89WsJnOEwo+JO6vjI3GcXnREkZvL4D+RTrwHDhkcNoitk3s8UgA8R8mfMVprihTjmYTCzgSiO0CXJ18n57Z6SGhUEbLvAeX3UaJmsRXfhAmkYezsI8jFsNE0Xwivd2mwk8l/gfG97rohudr6lsPnMExLiM5FWvtfqYWIXEJ8BkXg5C3ZTFQmPvt/6KLQkjrH3lFabtycMKnNon+d9au8AHwntbNUJA2clIRfeLqzDx6+8XcTd7d9qLXWlnRCpLDOYfDTHzLtaNizzKaeE3+2Wr7jttYim8+xPpLJcfsO3e5rhJqoK9Vw9vYJ2CQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+kBmEQjFAzUnd6otMl5LiERVKs7sITbOhEv+GXwhtY=;
 b=bGuOov+qs37XpNDg381msRJrszUsTs8RGq0tq2k81hVS19XYDIqSLc+O1lr9ZXGmajSxPVx3aQiCha3zErwhyotveKJ5bVVx8mdjyx7EvXgaSeenXsLZWHTTvNQcRn0ehSUQUmoY2cM6Bq+cNhH1+wOj5tgdw8p2dxLCydhWF+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3487.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 12:50:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 12:50:08 +0000
Message-ID: <5cd68a37-2e26-06ef-47a8-581f04d48053@prevas.dk>
Date: Thu, 28 Sep 2023 14:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] Kbuild: Fix cleanup of generated sources in tools
Content-Language: en-US, da
To: Tobias Deiminger <tdmg@linutronix.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, emkan@prevas.dk
References: <20230619224107.284372-1-tdmg@linutronix.de>
 <20230619224107.284372-2-tdmg@linutronix.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230619224107.284372-2-tdmg@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4379889d-e285-4617-d930-08dbc0217201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdXRC9FGMQ/RDvsgjsOikHERJR5TBGT06H6bzIf22KL1urdaMUcSQmVDiRLSL0BtxmzjdPaQVQiZmPiURvW3NNc8Tn+rdzal6ugaBHv9rBA5dD54hXCZwjULMIFuAyu0plPwMdh+tJqmNNBVxkF1f2iVZ65Lm9OgPmEhrczmkr2OAOJEb7Px5jodAqZahKwfeZ2DDHn6eTglrJWO4dKkWKMtLrJprBAbnynFXW/WqIfkA0HpQ8IuIx+Qahhu952FcvRtmzcd60a+PglPtWMyN4D50v7ea63AqcYtBXoEobwTITN2dvQDlrAZEDxgAxvVNet/JngvNFYsL0tNhVGQiZpqPpJbBe3X2EkpRSzzKGpIJ/nXNQ/P6shW5xO+kJT/aiH+mYmBPm4KqYp0deG6eWnS/PHtkAqb9AC0Ra1d5tHV3p2yuZZAEOa59q9fsdCKuKucDcQJi1Gj04eZIV0lmZlSEjYuBle+/GKpCEBhh9FCQ1OuJ3xhhUAElGCI1M0cTOI/lB6+DeJQu0hF6Y6sRkhayRUfw7/m9FVFrcSGGyHWZ8gR3y8E7Pl2exen2LHJYoUsZgMHxzzU+/bSvhZ9hcxfKxzmX2sqXrLx24FpKXRW2hCaK4XIVbc0IwAKaUjpWTvNn6T+mehUhCoITjeGOJywYvReRtr3o8o+yMpyZ3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(39840400004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(66946007)(5660300002)(2906002)(41300700001)(316002)(8936002)(44832011)(6506007)(8976002)(8676002)(36756003)(66556008)(86362001)(2616005)(478600001)(26005)(966005)(6486002)(6512007)(38100700002)(4326008)(31696002)(52116002)(83380400001)(66476007)(38350700002)(107886003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njd4RlpMNWY3dHYzWElTWlo2Y1pEenVKWGc0VHpxZ3g0eEtqVC9Cdk1NQkF1?=
 =?utf-8?B?SHg1VlhzWDlmaHVZTmN2TXNSbWNOUFg1ZlVHN0k5UitKOG9GSCtmYTh3RWFU?=
 =?utf-8?B?WGY1NzBQZ0JKWm1vbjdDdVdtYURTd0wyOVBDeGp5bDZBb2JQcEdLVHF5OTRt?=
 =?utf-8?B?akR4dWRJaVRqdWN4QWh4Y0JXSlJZZk1wdXZOb083anhCUFBScWFYcExkMXFa?=
 =?utf-8?B?UlBFOGNVbmszb1VyMElkRGhObDl3ZEpTem1wYXJib0luK2VxY0FET3lpMkZD?=
 =?utf-8?B?dk01YVlRYTl5dEFvaDczbnFab3pZUzFjRmVXeXBVemVzTUJVcHBLUXhwbFI4?=
 =?utf-8?B?RERsTUpKSkZ5Sms4azFpQUxXNW5aSGxsbkx4d21CZ2pPS3dqKzhhbjB3dVRq?=
 =?utf-8?B?bm1NSmVxZmpURzc1QzkxcXZPc1F5L3dQSTltM3RtZDh2YlFvNGdNMERmemU0?=
 =?utf-8?B?WUNOaWdBa2t5ZnRxWTRwcGRFQVpkNjFvVmpHRWpjWGNHaE1HY2c0WGhUdTBj?=
 =?utf-8?B?QmpmcVRHbC80RVRKbjdtaXpDZmpWRlQ4UDUwaGovenVkdzQ1YnRHUEhUZkJC?=
 =?utf-8?B?WVdyRnJ4S2VRZTJ3WmZCdjVTNkZzdW1Ra0lOVjFZSDZCYXVSRFpFU25hT2dR?=
 =?utf-8?B?eGZYNXNON1RzQzFMZUVUVVdsdWRuQ2I3aVEyanQ4NStobjhFTDNodm84bjZh?=
 =?utf-8?B?ZmNPdk9hYnlzaVVjdGVhRDdrYWJpcDkvUVRwVVZDYWUvY0wzNTFHL2lFNkFs?=
 =?utf-8?B?QUhML0FZMUp0T0dtbk13UzlUaHdoUDFMbHFSclF3aEhIdUdJdUVJUVUvd0RJ?=
 =?utf-8?B?dW1naHlXaTdSZDNZSmZqN0dyLzdGNDdsd0Y3Z0UzNXJFRmxFa2NQQXVMVUJW?=
 =?utf-8?B?M09wZmZDSE5mQWNwU1BsTWI4RTNjNmdOcjg5czJhemllVis2d0tTSUJCN2Ro?=
 =?utf-8?B?UjBWaXVHanJkaE9QNmk4Wm15NUJ6cXlwcDBabXpyR1JuN3pUNEtRRDBhRFZU?=
 =?utf-8?B?b2ZUNDFNUzlIaERHdWRINzBjT1pZek1qNGFPWGR0Qk5Md2o1NjNManF4QTlQ?=
 =?utf-8?B?M3duYVIxS01UY0NmVWxWM2pqM1dDZUxqZG5NWXhHNmpGazdPZHJIRUVEb0la?=
 =?utf-8?B?NytqeXh1dEFtdzlHaEh2MWpMV2pUMFhUQTNVU1lDUG5teUxlajJZQnBHSzN1?=
 =?utf-8?B?RlpHUm11MDdaaDFZV1VTa1BEMXlNNkZTVmdmb0RpdWs0dExXeG95WWp4OG5a?=
 =?utf-8?B?UUF1Vk4vZE5yelY5b09aZ3NIWGZyVzZYQ0pXY3ptWFR3Y04vRFdkRDNOVlFz?=
 =?utf-8?B?YW1QZ1AxMFVKQ2I5bmJ3V0lKWVZXeC9FemdOeTRmVHBDNVZSLzJkd0V5Y0d0?=
 =?utf-8?B?TW1BeUppOWc1ZytGaTFCSnM5NUlDTEtKMkl5NVY0SWJTZDFzWlE4WFNxRUwy?=
 =?utf-8?B?KzdUN0tVa3FGZldWaS9vNUpKYmEzeGJBbkhLdWNLTHJ4dU1MSnJ2VHJndzR0?=
 =?utf-8?B?SXFiMk52RXRodzZ6Z29lWWV0ZUFqUm9nTmorRHdEc1p6WlZ4NnJuN2RyRTZ2?=
 =?utf-8?B?cVh6alRFc2ZGTk1VOTJUSkZqUi9KUG1aSDF3a2s2Vkx2RDVoeFlxTUU1clRN?=
 =?utf-8?B?QjkrbmtjakxpRWdYOE04NnVBdTdXTlVHb0RQUUVHTGNZNzBSblZZdXV0MGUx?=
 =?utf-8?B?bGFBVytDY0xIVmJkd1ZYSHNqZkt1NFR2NzNlcXFGTWpGZnRKVEd3Y2l4TUdy?=
 =?utf-8?B?OU9obGUxRVJGWkRiYWhJSU8xMitDQjExSGY3SFRDbVRDN2hyZVNpTjViK1gr?=
 =?utf-8?B?V1cwcU9nZjFRSGpvZ2VMVHE2MjA5RzkxdjZ2dTV4VzhsTnN0NDZpTEwrSGxU?=
 =?utf-8?B?YlM1SkdlanZ3ZU9wbTU5Vlo0N01pVGtyN0dOU0t3Nm52cmtHRXQ4aUk2Q1c5?=
 =?utf-8?B?Q3gwSTM3MHYvOGNxRUIyc3hvUnQ2MStJMFVXTU0vZVRWOWNNeDNKS3pHQXhI?=
 =?utf-8?B?Vm9aMGxNTmNKSkdEZFZFc09DOHp5cVVpckVxeWdka3dNR0NlVUM2M2cvcy9L?=
 =?utf-8?B?WUpuUGlYRzJ6aW1vQ21BOElHOU41NlhCRHBsNkEwWW9pSWZlemVQU0EwM2da?=
 =?utf-8?B?SEtKdmQrYU85TVFBdjNwYWJydFhqMjYrdUFlWERMb25zRmxkckYwNHA3d2lI?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4379889d-e285-4617-d930-08dbc0217201
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 12:50:08.3682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc0QJxagrR2XkjPg8w6F/uuycDHnOmCF8aeTkBTEIBEYSxG5uWQWo8NSUnv9Ee7c9ZHbJTSX9EhykyH32L4XCbMFjE2z/afiHRP2CBsWg/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3487
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

On 20/06/2023 00.41, Tobias Deiminger wrote:

>  quiet_cmd_wrap = WRAP    $@
> -cmd_wrap = echo "\#include <../$(patsubst $(obj)/%,%,$@)>" >$@
> +cmd_wrap = echo "\#include <../$(patsubst $(obj)/generated/%,%,$@)>" >$@
>  
> -$(obj)/boot/%.c $(obj)/common/%.c $(obj)/env/%.c $(obj)/lib/%.c:
> +$(obj)/generated/%.c:
>  	$(call cmd,wrap)

FWIW, this change incidentally also fixes a warning (and future error!)
from GNU Make. Building v2023.04 with GNU Make 4.4 produces

WRAP    tools/env/embedded.c
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/common/crc32.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/boot/crc32.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/lib/embedded.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/common/embedded.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/boot/embedded.c'.
  WRAP    tools/lib/sha1.c
  HOSTCC  tools/img2srec
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/env/sha1.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/common/sha1.c'.
tools/Makefile:264: warning: pattern recipe did not update peer target
'tools/boot/sha1.c'.

etc. See the first "WARNING: Future backward-incompatibility!" bullet in
https://lists.gnu.org/archive/html/help-make/2022-10/msg00020.html .

Rasmus

