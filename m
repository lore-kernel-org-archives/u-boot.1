Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4526C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A2687A0D;
	Sat,  6 Jan 2024 18:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NgIyYHE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FBC87A0A; Sat,  6 Jan 2024 18:29:29 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA092879EF
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZzJOD3gLWjJGquppq2vn6NxahrUwizP9V6u+VoO4xN5N05NOkN5Gry9fnILjVPysfTZk+g6acbkKHwgFl8IEntJP0kkpxYi+hm2L8t80S0IyKOc6x+iWeUQ/a6RxUkMODwuQVMH11nkQYlsBfv5tKhwGITAEsd+NMHuhH1VDnSMGcpjp4VscimTCcqKVKO2QgqIDYhb+oiW9b8dERK7+w1xgQN73HTEYdNIcKYJw8hNXvA264mBfYMRQi0Kg/kIwjyRO/bhKQufvoKOamupRBM1f3YESc0AupSwzYUZhyY1OWIsW17uzOl3TtaH71yUMB8goSYuxpK/O4UIw8azNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYce9+N2We3gWi79/PQWdIV4W4HvhRgmehSoO12te44=;
 b=OqGTj6ey4gJ9vr8aZL+e1fSaf5tquePOZu4Lo6sLqNwYfmpKZhg+yCA0GXfe06Hv3zi5KLet5mpiG8cyneWwD/PkiJWdNS8u2IUkyEbXh1WfmQmI5vjR040+V7FCdihtIpo3TenMKfU368CzmPXYcG7PxglBDj8pKX885St0+9+M8gnJqeh7K4hFATXc6iPTuz91oLdcEUi00HpNxPIFekOyjakyp2TlFiwnxIdadrgnIl4X/iKnOFuw2yWk9KOF6atZghjL3wn9JcKUVuOQLud1wm0nzBlIrKwJFRH0o3K0TERUuNs4FnWiSq2UXZ25S8VKqorgxSKpFeMIH99rRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYce9+N2We3gWi79/PQWdIV4W4HvhRgmehSoO12te44=;
 b=NgIyYHE0oTeBaIpK+HSiyL1JojRq+4QXrtznfZ39NVzMxIK07Zs/gDMDy6DCFaZD5SbGgNyAfPCoGIVABGKc61f8+SZfPVijVCipBE8dvXJwOZge+ngK4xQ0Oo5cfJlhlBTild8/uRa+TL6NE1SSySroDCW+Z0eunM146d9GcYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sat, 6 Jan
 2024 17:29:23 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 17:29:23 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] board: solidrun: clearfog gtr: add serdes
 configuration
Date: Sat, 06 Jan 2024 18:29:16 +0100
Message-Id: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyNmWUC/x3MTQqAIBBA4avErBswkf6uEi0sRxuIijEiEO+et
 HyL7yWIJEwRxiqB0MORz6NEU1ewbvYIhOxKg1baqEa1uO5kxZ8Bwy1YsKOIvR10583QLs5CkZe
 Q5/e/TnPOH9mQVO5lAAAA
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ac5368-ff9f-46a2-d6e9-08dc0edd066a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJO+XEsXcACRLLeP2jDROvJuYZ2bGkcC2o3R2YEEJ2GALxf7Vqu080w7X4hmY2ykInsJJyXeXn5CTh3e3vybR1do331xxwqW7ahGyArVChv5bF6UWVn06JuSc2i/psftja/RTkWTSqnQpAUQ2C55cEjfHeR2LkPvkqpANUXqJajE6WoxvX73/SB3Fi1pyRgNS6Fl4SDi0QEVbOpskBvtBO7PjSAAPYie9tqvv1e/P1S5nmfJ//eFnqJJFVTYiksNnBXKh7/y46VFmJSmtU65QTCUmx4dBegby0tFI8JTwSIfZRUcC0HyyFAXVvVEFYQEfR0WJBJZ6YReIgBLk+Jv6k9hcRT7VPUn+Pp4yPnY+qe0wameEXfq7ri/g7iEzsNc9jMjaD51JGLpQdchA3vCvl9HD9S2wEYKeBLYMTkpL49XSYo2ab6l/NZDXcGq35uGKDJV1LMVvwRaqaLDD84b9WG+fpCgCssbBSYqetfYXOTDZ/MtUcEkG5/HF/GLHWPIDqNUkld15aOBEdZaT7gzoDVinSZm5w1WYKGM5Ep1vimX5MYO4O9FNmk2kTTEPbKOXHS/k3Ed/rX+091ouH/pTHdhj+bRODTdQnKSOtBT9n7niCwiuePAxdf51bcMwtow
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(4744005)(41300700001)(2906002)(52116002)(6916009)(5660300002)(38350700005)(6486002)(36756003)(86362001)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(83380400001)(26005)(478600001)(107886003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkswZzB4eHZlQWtRa1dBa25EQ3NhdGxVVmhBTldNclAwQVVJd0VrWm52bWpG?=
 =?utf-8?B?UkxOVzZWNnk1TVdISXdnSnduUXRlWUgrZnZRRWxrMFRmY3h0NEtYMlZqL2xv?=
 =?utf-8?B?Z1grVytxdUVodDYxbmE5MDlKVTI5NVR5QjJKWldVZk11bzdsVlU1WVZmOHZ6?=
 =?utf-8?B?eHI5czIzNWlHQldsM0hQd2MzVFVBU1MwaWdUZUpsdTlZNFhNYnBKeE5JbjFI?=
 =?utf-8?B?RFJYVnY2Si9WaDQzOXQxRGF2ZjZkSUhiSjl3K2traDBTUUxEc0dSbXBGMXNT?=
 =?utf-8?B?N2JaZUNDL0sySEJpZlVBd04rKzJmaHNwOGZVakFZTU84OFFIT211dUNuWnlz?=
 =?utf-8?B?Z0VoSFJNUEpkNnJaZE9DcGpLbEpPQnA0NzJ2ZllxVDk5d2t3Z2lnc2k1bW9Z?=
 =?utf-8?B?L2xrM1dZTWVpcm5STXNEcFpaYVVoTXZaTUJ2MGtCZnE3L3NiZzlkejZsaDlG?=
 =?utf-8?B?N0ZHbzYxZlNXRjcwSU1nejQvMzVOUHdFQ0xwdzZGdWU0VW4rVU83dG82aUJS?=
 =?utf-8?B?Yk0wUEpha1Bhb3U4Z1E2S0w2Z2JZYmlQSmlsMzZIUlU1WnU5TUZ2M3hXSUJO?=
 =?utf-8?B?MktVZGFXZTIrZkhqQy8xVVZoZHlBZUIzM3hkcUJNQkdIVWxBN0hFNDVmaS9z?=
 =?utf-8?B?c25oWE45SzhscWN4eDEzQThtbzYyUjZSQnFPTGdQVmRFVGlRSEhLZUJwZFNk?=
 =?utf-8?B?S09NSFd2YTNKUlRzVTZERmFINjZ4WThoUFFDT2lCMXJ5OXN2QVBjTFB3ckpD?=
 =?utf-8?B?eTF2Qy85UERPdjJHQ3RiV1BHenN4Ym5UUzJKUmZiUG8xTVh1aGdlT2FhR2Q3?=
 =?utf-8?B?L0hYSUpoZGF3TVVtcWdxWXNXT1lOY1FWZFlLeFVoWjlzV0JTS05uNlcvUlhT?=
 =?utf-8?B?NlRrR0xKOVZiYnBQTkN1VWFlQ252ajV2bk5oQ29ldGJKRXB6UytkckJJMGIz?=
 =?utf-8?B?dVE5Zk5hSTNZNFpJZlNFVFZwaXpSQTZHNk5HNDhsZHNvVVdEQTZnZWtZdk9N?=
 =?utf-8?B?ZmsxeDlIYWlNUjY5aFFSOVVkQ3htNXN6RjAwTk9pK3ZiK1NQWnF5bVhFd1E2?=
 =?utf-8?B?encrWXNQUG5NT1A3ZTFUc2tib21ZclRhUkxkY2tmQ2Z4YXJDbEJtci9VU2E3?=
 =?utf-8?B?UTZJSU9HRno4bDVXcXVMRlpnTHcwMmFrK3Q2MkdhMmFaWmNkUHZpUGtQQ051?=
 =?utf-8?B?YW9aREU3RWgzZk5VbytaTWd0MGpab2Q2aDA2clZ4VVUvOGorTmo3ZXN2RnNs?=
 =?utf-8?B?K0FyYmVPVGViOHVQRU1lNnZQTjlVOFFja2JjL0lxNFlzRnZUQ2Izd0pNVzkw?=
 =?utf-8?B?VU9aTHhYQ3pWM24rZXBESEU5UkZkNTR4MkVGbmhWYVkrYUM1WVdnWXlPTXdl?=
 =?utf-8?B?SGZHRmtvZiszTGo5Z1k4TjNqYXdYeXZ1UW01UmN5SnhRWUZzcFZ1eHljaTV5?=
 =?utf-8?B?RkszWnFJUnptR2ZHR2UrdUlwaDdRekd4WWhHWlBKd0pjeDBCSG52ZE9PWnZF?=
 =?utf-8?B?c1NmZG05NDQ0Vm8rRlU4cU1CS1BxeTMrQUlpQTB0Z0JlR09rNG5PUFpJYXo5?=
 =?utf-8?B?cWVQWDE1bDlLbldxMnYxT1FaUFREdExEY3lUdzErcjUwY3V0RGhVZGZqRVEv?=
 =?utf-8?B?OW9PdW1DQnE2QWo1ditzSFJxdTA3YkR3TGY5Wm0rbVlRZ3pyVDB1UWVFeEdl?=
 =?utf-8?B?NzRWK0pjZFNkMkNBVmN5TzgyNllHbGNrYWZDOVNvOHRXSk1yL2hrMnhiNFZM?=
 =?utf-8?B?SWdLancwL3pYcmMzR3Nma040bmRjZlBaSCtNUHFVZWVkbTlWVlVTMyt1bGx3?=
 =?utf-8?B?TXNFUDBZMmRTNk1ZaXpnalVqZXFDRTFzL1gyZXI2T1JscTJYWmF5UHFOZ3Bp?=
 =?utf-8?B?ZHhzZ043NDVKVmhOVVVlUmtIUVdqZGIwYmFwQ01qbkx2dTRjRVEzWCsrQWZP?=
 =?utf-8?B?Y1lmRkVlSll4TVFDMktSOU9jNEtuTnV4aWZoOGJPdGFVaTZmNkhGL3drMzFl?=
 =?utf-8?B?YThTNEl1WjFrZUMxMm1JdlFzaW5vS29yS2RHZi9IVWowcTlVV0Yzck5yZWov?=
 =?utf-8?B?T3Rld2xkNEZVUmlDajlVZy9UcnNhbi9pY2pOT3BNK1M5V2RSZWZJYktvTG9X?=
 =?utf-8?Q?g4p3cBCBV/Mp70Ow+YOteT3px?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac5368-ff9f-46a2-d6e9-08dc0edd066a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 17:29:23.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: out9sp6N3Dh2m+m93QYAkQvRQry6utRQnYoSwKmOSKdtuEHx3VYp9vSIB1hCKdTDBDlS7eM89fX3ygl1pVj3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944
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

Add missing configuration options for clearog gtr serdes:

1. select between sata and pci-e for serdes 0
2. configure serdes 2 for 2.5Gbps link with managed switch

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      arm: mvebu: clearfog gtr: add config option to select serdes0 interface
      board: solidrun: clearfog: fix serdes 1 / eth2 speed for clearfog gtr

 board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
 board/solidrun/clearfog/clearfog.c | 19 ++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)
---
base-commit: 82750ce44226e5f2b3bbcd79cf7b3ba3dfd3de4d
change-id: 20240106-clearfog-gtr-serdes-8a927f496bda

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>

