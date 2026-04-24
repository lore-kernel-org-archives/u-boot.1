Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF21FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF1C84368;
	Sat, 25 Apr 2026 18:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hnGwKtcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC36842F2; Sat, 25 Apr 2026 18:30:32 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D91842BF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
Received: from GVXPR04MB12267.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::11) by DU4PR04MB10888.eurprd04.prod.outlook.com
 (2603:10a6:10:585::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 09:27:52 +0000
Received: from VI0PR04MB11537.eurprd04.prod.outlook.com
 (2603:10a6:800:2cb::17) by GVXPR04MB12267.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 07:02:46 +0000
Received: from VI0PR04MB10493.eurprd04.prod.outlook.com
 (2603:10a6:800:21c::14) by VI0PR04MB11537.eurprd04.prod.outlook.com
 (2603:10a6:800:2cb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 19:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlM9bivvW9Aj3xHEqsQvhJTJEwi6JgqZy5j5PYkFJJ/gj4+u1hw/fsfjKipiiFEhPJysubx0tHR/xCTcGny65xpTcvIdzd5mO1xgAXkMxo6BsxjsHQzLYk5l/WqJlNJnfF9d7PZqzx7d/Tgwlli0X+kkckLhgPvJn8RX4aWtHT8kNgi4a2pRfJyx+l8lt21Eu5qsYhxQdw0YiwOB6KD7MRxOO3lR9XnPZLAEodqBB8t38n5alXcV0XanVNDxEJnyY1TOk76BqJj9M/u51+3ua57XSJRzMdh/35Fm6T1NJhF73Cqjwz5UX0uH+AOkSvhPc0tsSBRcTbEe9YElEN0uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R1bwMndch/oOFoxaBbKeApu1cHVhXNjWmGKM9lHgAM=;
 b=FTRdHCmYmkDn+XhbWDnPrzBOP6f6ScsGYzdDzo1p9HVzorVwvdf6jW09HBuY3eKp8/401tzwnBQQT5LKDy5bbE7Mrb9bXut/SQuisNVkM0UbYQkPrMSz6VNvk0NQGhkWCADEAVtVxQoUWtp27Lbab0LGDiOE54IWo688S0MIogn2iJ09wijTtMngXZKWVQCGrRPOwTqXJi9w5CjZuyaFgoEphhg0B1NTUKOGuLJ3tSVVGAV1wNHYerp9MBo1UgJNesGYXL/6sq8LJRGB2xxv6pJPfoOWXFxqU660sLqdbuYQQUin2AJaDJWxATYlo3J2/chAPyis5DBVtcYxiW6jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R1bwMndch/oOFoxaBbKeApu1cHVhXNjWmGKM9lHgAM=;
 b=hnGwKtcpnRgYdpWAmlvZ0hZ3BoJQZr1BwCv2IN6+DbKAjKRLH0y5Q52N4MaZ2YZZ+dQu41Kxi07EELohDv36+JHgtZdgM2gc8CFRIKyEEZ3lECqWGNjjn9nJzCGeDE58LYrPdpHFbHLkgSWoGoUNWLijwAxXEKOMHiMhAI2tZCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10493.eurprd04.prod.outlook.com (2603:10a6:800:21c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:55:58 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 17:55:58 +0000
Message-ID: <35038a9a-fa5a-4f9f-b34e-17cc80a7824c@cherry.de>
Date: Fri, 24 Apr 2026 19:55:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h
 import
To: Simon Glass <sjg@chromium.org>, matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
 <CAFLszTh=NVKYe2NS5t_kj2t9C+3oCfUqpY919fqEr9jyHgpN5w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTh=NVKYe2NS5t_kj2t9C+3oCfUqpY919fqEr9jyHgpN5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10493:EE_|VI0PR04MB11537:EE_|GVXPR04MB12267:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cef522-e886-44b5-6c7d-08dea22abd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /B6q3YqRmpZHIadUWEpNqNB2bvdA4TkC9RqVKuqh2HOPLitdrCKlmg+HhVaOQ1755V0J/fqxMK5jASPGUPchS0BnbbaE2oknrpHdV67Szls61f8A8oO6EPFEVOnn0hiaEFGZWjKmvJ97xVGheQXdzxXBffV4TKmP41+tNI05Gj64xvQkdX4QsrM4rx9ICLIrDcJMTQqNH4YnfOzehLLgzTaFDHeQqnmU/dR6nWTRKuH3uZTV2XyJg4hLmcjk9oWb3CKTwQuPu1PBXlPCZSQGHMFywqiw44ZjM+rHZ1T5wfBS3rZ+LGP6Xn8TTLAdUAcJs3LqlWRHYkFP8F9ezMJ5TtaL7zTZVUutPCj6QxlWSo0Zyahf3UkZ7If2/Qg+o8t/4SnCdm5iRrN8Y2WRD+5b9r8cvlNCDBjG/5mwY/ZUObOQPqg4ixOIwIzqwLMLcRnJGnBA1sEE4EhtilG6ASaMWKBhrTaOfL/Qw9pXrdki8Ud6i+oT0JJtnqT3+tK93dtET6Y1mu2zhB1FK226Zg5R+1Gvx+i14t5EHmd8WQ+Y7KUFuB/GkHPDFSMuCy2PUbD7LQw5xSCB7558iZPKSSt/kHKLQBks8cG+yhDy5OBKWBt9PyGF+qbyfdi/fBmqug/iZbWluItl66F3fcftlvS5BgqnTPbh6iohmceGDcLxR2uB0UfwPRtOcKd4QO7ILyUwIVh/5IkCPx0FAlsIBCfddro1xprXjn9iIVNlO5SrdQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlM3eG5nNWJhcHFaYmtDbnZCSGRhTWhSSk5lYyt2TmNVSlBYVVJ1b3B3WnhD?=
 =?utf-8?B?YzlWYk90RlRSMFpjQVUrdXdKQ21NdG5aQzJUQytlOGFuMWwzY2F3aDFMVlhE?=
 =?utf-8?B?VkVwVGZFOUg2Z2lJME9jSDhQQWlhWVFCMjB0Zi9ock0yOHRrMUIzaUF6MTQ2?=
 =?utf-8?B?MEc4N1RzcHdnVjZVN1k2ZDg1azJhbmdLalBnaFFJRVRLQUJQd2tkRWtURkdE?=
 =?utf-8?B?THBIcUp5bkJQREpkY1hjM1g5c1Y5N00ydHNQZTNjSlo1UkcwS3VmWTNHUVMv?=
 =?utf-8?B?V0dRd0JwdUN2eEk4b1JCanZCUzdIZStLb1hrc1AzUWRHVnBLSlUyVWNaYURq?=
 =?utf-8?B?RHAzNzB1a0NZdktsTTVNNEswM0pZekozNTVRV2RyeWN6UXZ3MVlZbGJ5aE9D?=
 =?utf-8?B?T0xyNStRemVEUU1pYUc4TGFwZndWcVA5aE1QdFNiQmY1UVVUK014RDBkMXZC?=
 =?utf-8?B?T2tLVHc3WEJ6RVFMSHYrQVJ6Zzg2eHFJaUM3TyswdCs2QTdaL1NZbTBWVzNy?=
 =?utf-8?B?QzRNYklhVDM4dThBSGxtWFRSbVBicTFNYTZzbmVDL2Q1YlEyWVBwZERjTXdq?=
 =?utf-8?B?aS9La09JZ004TFBWUTJzRXRzb0R2WDdML1pRSFZSSUtKWnZTVTQxNWVxSjJx?=
 =?utf-8?B?YWw5UFNkN1pmWnF6RlpPZkRJd3E0ZnA1emFEdG1vb245T1JnT000VkUvZWdC?=
 =?utf-8?B?N2Jld3pkOVdPTlVaRVd0UVRNUFc0YzlNbFNWOCtQS0tockVCSnFaOTZNa05W?=
 =?utf-8?B?OFJCUUVuWlZ4U3NBenh1YjVDTmpxM3BwMkVkeWczVmdzZXFoeno5cE5ZSUR5?=
 =?utf-8?B?OWtYMnN6cU04QzJraW5pZmFWSFdCd1lIQkFsOWNCWmdhMVpUWFZqWUJBYzlF?=
 =?utf-8?B?b2VWL1RMTkJ3ZWV5TFp2c0dsMkI4RlJrUm90VXdrSjRITklJK0dpYkRBQ1lz?=
 =?utf-8?B?OWUxWHBaM1VKaWhrck9KS3I1Rm1kZnFhVUpoemVpaUpWeEdjSmpEU1V3djYz?=
 =?utf-8?B?dkh5R0VnNk8rMXNLV3FmRVFWNTlOQS9sb1ZaTm1Uc0gyQkUxeTNmOXRGWDRP?=
 =?utf-8?B?WTZSdDJkelFHWGgyU0lUNGRvRXRPczVxYjVZV3VjbFBhZUc1MjVIMHl6MGdk?=
 =?utf-8?B?dHZvZm9aUDNXYlBpWXFEUm5XendMc1poenl3WHIvQ0gxcU1mN3pNdzJPVlFv?=
 =?utf-8?B?TGxhSzVaemdKaGxwd2RINVBPOG1SaXJGTXdLbVJ0UnVHTFJlcTNMK0pBVGp1?=
 =?utf-8?B?cTlDRThhSEhGcjVqakd1VW95L1h4QzUvMERSSjNtL0R4bDN1Z2ZKclJXaXFh?=
 =?utf-8?B?bDV5WVUwM3dVQnVxRCtNMmZ1UTVrbEtGUVBnUm1NdU1YbkZtU21KNTJDQ3FH?=
 =?utf-8?B?ZXJKM2pTRmNYb0FuK2JINTNaRVBUNkoyanJLVFB0dnV2SmNaOFAxWmE2dkNx?=
 =?utf-8?B?OUJBVEE3bzRvVTcrS0VFNnVMVS92bjRqdXNaajRVekNIeHpEMEgvRGF1RjBi?=
 =?utf-8?B?OG10cytDdHhDN0RYb28vWTQxNENBVU9RVDd4eWFFcFBSaTN0c0JQb0kyRlBC?=
 =?utf-8?B?RW5JeUI0ZzIxVXZYZWNYRHQvVk1waUNjeHBhQ3c2b0tCV0s4QUtSZXoxelNv?=
 =?utf-8?B?S1Zqdll6M094ZzMvNTlYS3l3RzlyQWZ1WnRxNXFjUmh5YVZ3aWFtSE5hV1dr?=
 =?utf-8?B?TXVseXJjQlBmU2JpdnRYSFMrMGxMMUYxY2hXd1V0cEFqRXNwMXNaTnlJWEdy?=
 =?utf-8?B?dkI4dUNLRWlUN2R5Q0RxNnQ1bXA0aDRUQkIzaDhJVU5mdTE2T1lGTlBKOWJt?=
 =?utf-8?B?b21kdUlnQ2MwdnJMMXhjT1g4WjI1U2gxaUxpZXY1c1RvZlZDS3NHT2RkcXJw?=
 =?utf-8?B?V0NrTElNVE5RLzJVQ0pJVXNtNlVRTVljQzdwcU1GZHAvRUp6VVlRVE1ua0hG?=
 =?utf-8?B?Z05TZ2ZBY2RBK1lRQ0htU0trSitlb05nNlJsRXArcVdOdEd5YWpYMDFDOUdy?=
 =?utf-8?B?RVBwYnNXcnVDOFZhc3dyN2lINXVpdDJyK05BMFNrQkt5YVo5QkYrYWdkbG9X?=
 =?utf-8?B?dmtPZWxFcGptTVBKSE9GZDlmZEVUa3I0UWlLa2tTdCsvK3Vud0laMkZTWktX?=
 =?utf-8?B?Z2JuV3RzcnRPR0tMNEFyTGlhbEdweFlZaXU1UDgzeGxXMGFra1BadTB2Zlcz?=
 =?utf-8?B?dHluQzZnSk9HUnBvczBTaEJmLzhWSDArcHRBUDd0QTBIY3VIUjVKdVNMVGdj?=
 =?utf-8?B?N3h6ZXRkOFZrTnluRUVSRHBONG56V29GYUZGaDNjKzVvdDRBL0lzbjM3RE9H?=
 =?utf-8?B?L2NXT1R0QWZwUEQyNFV1aGp4eUd1YmlCbmFRMXc1ZWxoU2NSajQ1b1JmNFZl?=
 =?utf-8?Q?LAKx3Vp3Ce68rtCl1TPRcwW0NsM9fC++QU3wq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cef522-e886-44b5-6c7d-08dea22abd9d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:55:58.8483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIQTR/dEUaa0sQUi2SbnwKUOT1GUmdXe9t21+321VA8BAxIftvgWZdL+ikatgUu/EOd9Bj7aYPGoBnaQb5u4MTs3DVjUo1GvnlDzupkaOYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10493
X-OriginatorOrg: cherry.de
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

Hi Mathew,

On 4/22/26 3:15 AM, Simon Glass wrote:
> On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
>> usb: onboard-hub: fix compile issue with gpio.h import
>>
>> This resolves the following compile error when compiling
>> ten64_tfa_defconfig:
>>
>> In file included from ./arch/arm/include/asm/gpio.h:2,
>>                   from common/usb_onboard_hub.c:10:
>> ./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
>>     17 |         ulong addr;
>> ./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
>>     18 |         ulong size;
>> ./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
>>     19 |         uint ngpios;
>>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>>
>> common/usb_onboard_hub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Only received the v1 so commenting here again:

Well, it doesn't fix the actual issue which is include/asm/arch/gpio.h 
use types that aren't defined in its scope.

So what I think we should be doing instead is to add the proper include 
in include/asm/arch/gpio.h such that the types are defined, I'm assuming 
it should be as simple as adding

#include <linux/types.h>

to include/asm/arch/gpio.h (or replace the unknown types with something 
that actually exist in that context). Otherwise, we'll end up having to 
fix all users of asm/gpio.h which do not include linux/types.h one way 
or the other. Can you please test that?

Cheers,
Quentin
