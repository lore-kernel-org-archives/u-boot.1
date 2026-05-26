Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD883CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4144A83FF5;
	Tue, 26 May 2026 08:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v1thnWlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9894483FF5; Tue, 26 May 2026 08:08:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974D38039B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZELh4L3PP/h7JAxs53iYv1JmgdGh0gi1lHSqDhCDkrhusW2IhYLktSBJ6XROnnYor7Ze1jdgCXYiy86vUsgVlFBolT3kj7XyWLx21FBpg0dZ+Jql+uE+wsG56s7SGuHb7aMqgyhQ085tJdLxadHz92C/cKeGtzPxDOsuJCIJ1rBdVvlcmJJDU4oOKT4WpSGUESy3IcxqSAXqDTBcT3nBK7qrC1sUXcZdLjgKPTRB0IGilKe6GYjOg3gTcXJ3qfuU5R2i83Rx736Fd6QgVNsmZMnXQixvhBI6C+z7lTt+D5rxWPImJearUCQXco+yO9rBYqgtg0SkpDDgRgD6eGUYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9YZg2h8RzQdPNZEd1iwq90szc6L1LRpvG6f9XxlVIo=;
 b=ZYxS+kJzYys7XUQEf8YIGQfsE1tsoIPftmHn5CkKzXfi7gIRSNkVgf1J7B3UovGnlxqTZjaebNTKZZIXNKjs7Yjho2LVogh6n7XgcKVM0qZLPjxJZ+2XF7zSgoN87NY+blzxuZAaObXJ5icgWY6/Bft+fiEVuX0pjfIOvjPoEgEcTfJzI5O7FXZcgvamVH67Iammk+rpDPCdVAUJ+x2HJkIenenQuhO1nrQU1zJDGiOAnL9mv3XlyKWBBDeghWiwq8hhJQY+5rKxsoVYq7Omx4meeqeaqcvFGLLehxSEDUnwoaeVR67LtmupYl78KFajgTXoCgq97vrDNMgjGrlPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9YZg2h8RzQdPNZEd1iwq90szc6L1LRpvG6f9XxlVIo=;
 b=v1thnWlu5mnuY7CiYMRzk0Sxo/9MpIXNFbPHjdEmEhD3ctJwqal2qzWG2Y15xrwrVODijO2xYi+KOMnwTs8OknYCgBwTAtnBg//yIvj8NfL0QeaYCwLXnhCctOILKX8QHp5/LwupjsBXvEdsD3dBAJTh6gEU+9Q3SznWphb8tPKLceM+Svm+E078CLwDzL5Ne2hdpHqk+lYMPj+9i0rQv64fa7oEMCi0HkUIvvBlNtj3e4OD9SUQ6NLwhuwM2Ui3h3h7O+ZHn9ieqaG7LJ370uVohKXtjzdVht/cHGlUdQDpRkhe2XK6Ha3BHWYD/OaBuTqTEwUug8uz0gSOcPD9xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:26 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/6] net: Use dev APIs
Date: Tue, 26 May 2026 15:25:09 +0800
Message-Id: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVKFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3ZTUsrSUEt281BLdRIO0VHPT5BTzNBNLJaCGgqLUtMwKsGHRsbW
 1AHhdRINcAAAA
X-Change-ID: 20260526-devfdt-net-a0fe75cd7f49
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: b3341e36-b4d8-4bfe-a77c-08debaed3304
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: RgNC0P9rH++tLUNp4JPWxTqlat9t42MbyBsW4PjneDzVrpHCenqayJ+C3VjBMkY3GUyWcOv4LkhJAfppYfkHtuiRPtT807TIyhHxRQT1Qxri9jIIk6pU345K4H4afNoqg+eNLLRLwa/i/pZ9b0NfY1l+AycZ8oKMN6XwAKUm8QRPuXI04/vJ/azoT0cQqArnp05DKq13M6JiC8pCoFI1RfD/6HMDLfUWNsamkIADYZWG6r2anmbkhKGAMjowawnGSdmTrqxwkcvJM2NWj+VKC724/bfQFlwmx5R5REV7HGjDeuTDuiK2FBsA+lX4L4TtRolGf0C8JkPx9dIJcOkQLWng1lvlHDsq0noIfAGXNicYli18Fzz6fmA2qgQuX/K27QfMIAYCMBI3EYNJRTtJOPeerXbEYGepsUUhfqRhyL8uFh5VID6myXLTMwbxEJ2BzFZNiIVWO3PvL4UNDEuUrIJxrLPiT0RluRcN/b2R6PriDICwT6CShRILnYM0b7E/fMvcfBy/X7vmr9QetuZ3NeqpDc/SNwkw3rLF96auagWI0NQrPFogEbaW2Y7FPRSIB4kh27MFP0drf52lutjikxyOBKpWCqpWVC88dOybwevbEvkSBMIi7B3E0410FbUnDM204/XLszvoAwA+D2dAX1DeAkOo8sw79ynrAkM9Xdbtepnb42W5gLF+J+JC0Q7aDd0qLZ96drvLPkSmaG5UMb7DvPSorw42oH9p9ooxN/AMbm8S5GMgMinIW6UBUv3q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlPUVcrd3NYY3V6S0hPd1VNYXVFTTBxWnZDWkFPTFBXU2NYZXl1WnVLSVA0?=
 =?utf-8?B?UTArWFVlUTErMHdiMGRKd3NXMG4xcEFLdzU1Q3RYWGJvWUdEMzljY0lvMUww?=
 =?utf-8?B?bDZrdlBmUnBOSWthcnE2RWFSanBuTXZiS1dRWFFIUEx6RmFTdUNSZk5wMWxh?=
 =?utf-8?B?QlVoSTFrcXhQcllaMXlOSURaVHhXTHQrL0pMUk5JWlJmOVFISUk2R0s5blll?=
 =?utf-8?B?b3hBSzZDM3VwcXBRblNVYmN6Y3VTSmVGdmxSbFVUK3UvWXBlUStjaTYyOVhv?=
 =?utf-8?B?M1pvZHhjdmJsQXpqRlFGYytxVy8yMjNXMy9OSkI2K05YbnFVbmluWFVnZFpO?=
 =?utf-8?B?N2pWcHoxUFpCSEFmSHpJM1NteTRUTlhaOVFwRUpJR2FKSVNUOVRCS2syVmNM?=
 =?utf-8?B?V3NPdUcrc0VjbHQzQUFuSDFMQkdNWFZiaytOSmFVc0Q0cVNOYmlhb3dBMlNj?=
 =?utf-8?B?OVJJWDFmR0pMbFhmMHhrRUs5Unc1c2V5U215dWdicTArbWswZnNxcG9oaHFt?=
 =?utf-8?B?NjRrTjNvZDgxbzZZQzZhR1RFWWtmaW1aeGtzc2UrZ1JGbHE0VGNwcktiR3Fm?=
 =?utf-8?B?a1ZSenk2Rk84c2l4MnQwdWs1dFRQL0w1SzRESlFFdFk5N2JySjlYQXdqT3pI?=
 =?utf-8?B?bkNOVzZZYW5yQ0RRTW03RVArV0ZNZ0RyeEY2Vjg0YVpXNEEzK0VpeVNBcjU5?=
 =?utf-8?B?NkFBMjdha1NIalZmKzVyUnFsTktrRzZVdGVBL1ZQbmRSSHVQa1hSdXZFWlox?=
 =?utf-8?B?aTl6cHFFbnRnaVN2VnlCeFdpZUdlUzkrNUhOWWdtWHR1eVg0NDkxMmExck9a?=
 =?utf-8?B?QnBQU0EzYmtDZExuQ3JaUjBnbjF2amZUWEoxaUlpV3l2WWpPcG5JdWxPSTc0?=
 =?utf-8?B?OVpXQ3FTR3FyRS8rWE03TXMvT2QyNHoxaFNDNlFsMGJSMnFiTitZck1ITlN6?=
 =?utf-8?B?VTl6NnBXS2I5Tnp5T3Vhdldid09RK04rU2ZNY0pOc3c1cThxSlFsSDM4Q3hL?=
 =?utf-8?B?a25NTUJUSXk4azBqdDlRd0dPNFhQQWpuM2hvMGpVLzRtSjdzY0RyMzZEL2J1?=
 =?utf-8?B?ZGE1RjhZOWcwYlp1UzBTNHlBcUNDRnhFYlovWlJJMWhBY0RxZ1BpcmxtMFhS?=
 =?utf-8?B?VXVSOTUyWHJCMjBVZ1dKS1lHNnBaYjMwZVBLNG5UZ01TN2xSWTY3OW43dUcr?=
 =?utf-8?B?S0xyak5tZ2s5SGRhT3JGbVVGczVwMVNxRWdKMUp3T2VaN2Y2N1IzcFBRdEVD?=
 =?utf-8?B?bFpYdFM5OHljYlc3L2krbkhPUVUxRklockFFVHpCd1RMZVNUY3N6dDBvK2th?=
 =?utf-8?B?eHdsd1NoRFE3UFpVYkgrSldWTE12RWJKRDgzK0hHSW0wb01BS2ZKcTRXQkRK?=
 =?utf-8?B?bHhYUEp1UkpSK3hNTEZCVW1wY08wUUp3aVZhMUhyZ3RUTGxjK3VBN2RwOWxM?=
 =?utf-8?B?SDNjWHhhNitpLzRkVXJBQlpNN1lLT0kwUDRGREpibmg3VFovUllTTHZDMFFB?=
 =?utf-8?B?UlB6cWRFQkRLY0ZiTVM1RTlBQmt3NnNmNDk0c1FwTTdYbmxjckVHL3Npbk9O?=
 =?utf-8?B?Zzd5UGRqUHdmS0JTcnZiWEdRQ3dQeXJBT0xOWkRIWHhFVmMzWVJVaEJ0VSs1?=
 =?utf-8?B?R2d3MHJiSXU0RFNHZG16WmljQlBUc1NtdTZrRHgzZlFFcE5iaVdubFhmQ2tm?=
 =?utf-8?B?VHAxbVlZQW1QekpFUURhYkk0OS9UTDVpU1VnY1o5UkNvenRRaW5MakF2LzA5?=
 =?utf-8?B?OVh2dUYwWUNsQU5rVUVDZmJhd3JxcW5rVmZjQkVUSXM2UE9GSHppVHg4cjRC?=
 =?utf-8?B?bVJUTkJPOVlSNUZrV1MzZlF2SXU1U3FKalNKbzIyNXB0MEgvUk5aM3JSQmIw?=
 =?utf-8?B?QlF6Mll2b3BFbVB6YWsxYUpsL0xnblBnWVJlOFNOWEE0MjFvSTZGZkZQLzdt?=
 =?utf-8?B?c1dMREwyOUxUeWNaZDYrR054bXFYemZZVnd1MGZBU0Z3dUVuREQ5enI5MkdM?=
 =?utf-8?B?SjNqdTNUWi9uVnJWeUxQY0hOYUFhYmpLbUNnT2dYbFVheFZVTmF3Kzd4bFhL?=
 =?utf-8?B?MmJZZHFpSmJDa2YwREcvdlppYm9MVThIbk1pb3RrRTRYOThodUx5S0NEV0ZM?=
 =?utf-8?B?RUVUcXl4Y1F5Zmc4cHNONm5DZ3BKRUZ3NWJ4Nlk1aGYyU0NabWxlWnpTNC8x?=
 =?utf-8?B?N1ZXSFQ3N1VYbStvQjdCU0xkSUNNNTZvQWZlL3kvS1ozb2dRZ1VzN1AvU3FL?=
 =?utf-8?B?cG16OXM3c3pLeEE5NHVCVHFzTzBXcHR5Yi9NdENDUmYzcG95NEw1RUF1Nm5S?=
 =?utf-8?B?QWR6UG40QWRMdG9NM1pLQjQ0bkRRNXhxVU0zTkVmSmhseEtQQ25BZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3341e36-b4d8-4bfe-a77c-08debaed3304
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:26.1514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vd2QKZl+9ziXNrueKOZPRo2lJ8WKu9kIHbj3CjlRYs2b4oElEBfILucIUlIh3nO3/YieGEFKsS0mLR03t/Bog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

This series converts several Ethernet drivers to use the generic
device model APIs for device tree access, replacing devfdt_* and
fdtdec/fdt_* interfaces.

The goal is to improve compatibility with both live device tree
and flat device tree backends, and to reduce direct dependencies
on low-level FDT helpers.

Patches 1–5 perform straightforward replacements:
  - devfdt_get_addr() → dev_read_addr()
  - devfdt_get_addr_index() → dev_read_addr_index()
  - devfdt_get_addr_index_ptr() → dev_read_addr_index_ptr()
  - map_physmem(devfdt_get_addr()) → dev_remap_addr()

These changes are mechanical and introduce no functional change.

Patch 6 converts the mvpp2 driver from legacy fdtdec/fdt_* APIs
to ofnode-based interfaces. This removes dependencies on
gd->fdt_blob and updates phandle parsing, subnode iteration,
property access, and device lookup.

No intended functional changes.

I not have the platforms to test, just best practice for this work.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (6):
      net: ethoc: Use dev_read_addr_index()
      net: qe: dm_qe_uec: Use dev_read_addr()
      net: calxedaxgmac: Use dev_read_addr()
      net: dc2114x: Use dev_remap_addr()
      net: mvpp2: Use dev_read_addr_index_ptr()
      net: mvpp2: convert FDT access to ofnode API

 drivers/net/calxedaxgmac.c |  2 +-
 drivers/net/dc2114x.c      |  2 +-
 drivers/net/ethoc.c        |  2 +-
 drivers/net/mvpp2.c        | 63 +++++++++++++++++++++++-----------------------
 drivers/net/qe/dm_qe_uec.c |  2 +-
 5 files changed, 35 insertions(+), 36 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-net-a0fe75cd7f49

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

