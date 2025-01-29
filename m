Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC88C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC24809D0;
	Wed, 29 Jan 2025 15:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rCApJw13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4DA81727; Wed, 29 Jan 2025 15:25:55 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED938096D
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oex9lWhCalwX9krDNh94PU/jhwNPDECo3YKlkZizs1Qo/+1n7fzuY7LJ17dQEQLV+ADBBkzAbT4moi6ps73jOWvyCnjNh52wg2SJAvJ6umZjscku1ULcmYTbM7eov5peb3EGyUVuXXkObMDjhG9rTRSDsHTDSIaO7pViU+5kux8un+cgx0BQhdhOUJLOQPNN4PYbXDWXZbjo4RCXru27pbZXjfLZwfTzE9C6GsAJ/sz22hiTykZKyX5cWG2i9vF3bOUHAvya9EG2Uw+aVRo1tmf+IaB43JSibmqFH2rg1YyoY1eBJVCjMbz9Gw7idavsKPE5/3GsGpUNuiHuBa4rbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8qL+eHcRzMS85qUBDwJWJeG9ExvUAvkwb416X8i74I=;
 b=iaMX30T1DX7U8B4eDH4qEVU6IKbb1RdQwSBBM4wmQXeRqMN1zc/LHopIp8i3rQkT/e314psKEHYtQcBmVQJduXHtYUDWlJSUd8mvfCtzbWYJAZsRfWh1z6Nn5ipCpxrvkAXd++unpHPstF0QD38S9R0kVQsRkkQ+cRIuQuYLHWKLP4ki1fO8pMrmFyBFFssxlDwEzoe87QmUsSyl5M9mZqDl212UvzJCf3TKu+9diqqm83xKnVesiUpxK0M1VKUYSOE/ASwNbZeyCP+/if59+YY3qpToRzfo2seFleDkKV9pvtndznPUjksDPoUoW4ifL1yYn1v9jUqG381cn9xWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8qL+eHcRzMS85qUBDwJWJeG9ExvUAvkwb416X8i74I=;
 b=rCApJw131qO54w7P4UTbwvjBQaFOmeCJNj1ooxbZbZSBt42YBABDRmwbush/EPWRXXEnTOy5OmGI5s3Bvb3RJ0KmV2jt4Ifw48CQmEK0mY6e5rwehxJHCQtX/2lHeuvowkZUsX3E1qOkXcgPac7NJqvU7GBUgrdV2M/0D/Qs4klkpokOeu2rK1L48m8SAGjKz6Invi8nVIYZn9bmPsuzy2HET+x4EQWfi/XQBJP1JiILAjKw6Gh47JJ0ITgr/HhBFzpR+wTbWSKjvJ6bCQ4Fq9B6LsSHtwuAqNIfo4bn8EmhSpG81rz4LUvxLJp6qjEcIHaxZRBut4O1NYZ6CJmBXg==
Received: from DUZPR01CA0341.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::11) by GV1P195MB1948.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:9e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 14:25:48 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::7f) by DUZPR01CA0341.outlook.office365.com
 (2603:10a6:10:4b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 14:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 14:25:48 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 15:25:47 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 29 Jan 2025 15:25:47 +0100
Received: from lws-schwan.phytec.de ([172.25.32.136])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2025012915254735-47 ; Wed, 29 Jan 2025 15:25:47 +0100 
From: Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH 0/2] bootstd: New bootmeth for RAUC A/B systems
Date: Wed, 29 Jan 2025 15:25:24 +0100
Message-ID: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFQ6mmcC/x3MTQqAIBBA4avErBswK6iuEi1Sp5xFGtofSHdPW
 n6L9xJECkwRhiJBoIsje5dRlQVoO7uVkE02SCFbUckeb95ReX9sdFgM86lR1KolaUzXLQ3kbg+
 08PM/x+l9P1s/UN5jAAAA
X-Change-ID: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 29.01.2025 15:25:47,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.01.2025 15:25:47, Serialize complete at 29.01.2025 15:25:47
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|GV1P195MB1948:EE_
X-MS-Office365-Filtering-Correlation-Id: 389ec936-5684-4b36-8b19-08dd4070d33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzR6RU1pWVJkblE0RG5hN3BoWUpOSzVLSWVNQ2RuUGFpM0FHS2kwTVk1Y0NE?=
 =?utf-8?B?cklWVzFpYXBJdHdub1FUWHRLdkpYV2dvSkxpVjF2eXM0WHVzc0Z5cjYwRjFU?=
 =?utf-8?B?RWV4emU1dkZic3laQTY1MXFSRjNITEtrZmtZMG9VK0tvUWg5M3Y4OHpLVTNV?=
 =?utf-8?B?MWJRMW9WVTFZRE44YTNlMnd4K0RjQ1d6aW1HcjBLcWxRZFExKzcwa3crQy91?=
 =?utf-8?B?YU1zMi96N1k1czNXRFNBQ3h6QXhrT0wwTXFBKzZ5a0JWa2NOQ08yTjZENTBw?=
 =?utf-8?B?TG9kM2tMUlIwZC9ybERzMUpZTDR3eWVmYXk4YThJNmhTM1F4c0pVYmZlN0pK?=
 =?utf-8?B?RTR0RlNuTmVSMW5TNElDcFZYVlYybkVGMGNYYjdqZmEwZTd6UEtVaWxsTE5J?=
 =?utf-8?B?dW5mUHYrZmVtWk1CZTFEZkcxQ1VHRkY3UWg2L2ttR0VCRThxQVluUzJ4cVJL?=
 =?utf-8?B?b205WnIrVGd2SzdkcXdadExnQXgyajFlS0ZQVlJ0ZHJOODhVWUxoVVdNZU5V?=
 =?utf-8?B?T1dRR1kzTE9uNU5PM1ZGQmp6b0FwMFdkWW1mSVRlVlZCb0hLU01Ra2RaSFpB?=
 =?utf-8?B?RHpPVE5HR0pDQ0pQV2JOMEh1enBoN1hyVUtPZTh3K2dJWS83LzBoeGw1czhQ?=
 =?utf-8?B?ZUhJYlVUUTlBT3JXY1dMeVo1aHdTanFINThEenlQNzgwVC9OKzBJbHdkQjU2?=
 =?utf-8?B?NXU4SFZjU0J3eXpVa25ETmFaY0dhL2FLd3Byc1Z1RXc4OURodGlqRTQzUUhs?=
 =?utf-8?B?Rko3cVM1d0ZHUWlEWHg4OVhmVThhUjh0RFZGei9penhUZGY0cUI4STl4NlZJ?=
 =?utf-8?B?bi94NEgvMHVVQis5aThFSDJyOVo5VlB2VFE4VmdBWVJkQnhoT29OZC9lN25z?=
 =?utf-8?B?bWZxdFRmMm55R01VamFxMDZqL004RUs3TmVieTlWUDJIa3h0UzEzQXVjT2ly?=
 =?utf-8?B?T2JvSk4wM05MSHVISGhKVHdPZmpUZzhVa0FnNGFUZzRBdEFTT092dzNWRC9q?=
 =?utf-8?B?WVg5SHZZNnl3Z3NOdWRwM1hCZlFidFBRNHhaMklYcC9GMzhMQ0tNbGw0Q3BB?=
 =?utf-8?B?bFFhQnFyT1JiL3pSaHowbWxBVWFpU2Q2VFRPMVhXb3pXR255SjVoeGoycGZz?=
 =?utf-8?B?RHArUHQ4d2ZVVzVlZHVVc1psY0toSmhveVJjTnZsNzN5OHN5S096blE3OFEy?=
 =?utf-8?B?V1FMazF2bytJa2hKcVdGeHRCNzRYcC9EcTJ1ZjAyV0UrbENrWE1sazhMbTNS?=
 =?utf-8?B?YTh4aERtUkFpcnM4UHVsaCtCVVlaYzlVZXdMT09NKzZxYjVPT2JrWmdrRStF?=
 =?utf-8?B?Nm5pRXV4RXRoQTZrK2ZnNnJOWEtzS2tHTzUxRGRqNFdXVFpObDQ0Y01ZaW9Y?=
 =?utf-8?B?cW82TUxxYkhUM05jUTRnNE1scjdBWFcvbnFVYVlFWFBEUUQyVVM3dU9GUU9J?=
 =?utf-8?B?SzZHZTlEU2FQQVZySlNwRDJybzdwZFI2ZmZGZHhoYU5vSnNYZk5ydVFnOW1C?=
 =?utf-8?B?bTc2VDdZTUFCZWtSN0pqd08vb01pVVZMRzRpczhNcGUvak0vNTVGejRxbVgr?=
 =?utf-8?B?UTFuWlZTVEg1aWdKb0ZJbGM3c3VuUktEbGhDSUc5U0UzYnNxOWpuMis2YURt?=
 =?utf-8?B?aW5lcnFvSWdsUnZsNFRYSzJEMjBXUklWL2llOExjYkZaSjQxR05aeE94Y0tq?=
 =?utf-8?B?bFo4cklsdHhadHYzYTFSYjd5aW51aXJpbEEvTGdRVWhpK2hpbXZra0hKVnRx?=
 =?utf-8?B?UzZBbWNsTVFMTWtFT2k5R0ttc3N3Z080eWRPZml1UTZPRjZpaTZPazJybG8y?=
 =?utf-8?B?MWNUelMwWHltcTIya3AzVWdzUjlLdVRLaG1TVDdxYmo0UldiTVZmQUVyQlNC?=
 =?utf-8?B?M3BBRUo0cDhvS29HSElDZTZOL2cwU0NxdVk4MG8renBWbUVuSUdEOW92ZWNu?=
 =?utf-8?Q?kTQFb9acFgFlxyXAL73lVKwIXvdpaaGA?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:25:48.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ec936-5684-4b36-8b19-08dd4070d33d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1948
X-Mailman-Approved-At: Wed, 29 Jan 2025 15:30:27 +0100
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

This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
Auto Update Controller) is a lightweight update client, providing "Safe
and Secure OTA Updates for Embedded Linux". See the following links for
more information about RAUC:

  https://rauc.io/
  https://rauc.readthedocs.io/en/latest/

PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
default way of updating embedded devices based on PHYTEC hardware. So
far, the logic selecting the correct partitions and files to boot was
being implemented in the U-Boot environment. While this is a
straightforward way to do it, adding and supporting new platforms became
somewhat tedious and is platform-specific. The introduction of U-Boot's
"Standard Boot" provided a convincing alternative, promising a simpler
and more portable way of booting, even for RAUC systems. This led me to
implement a new bootmeth supporting RAUC A/B systems. Note, that this
new bootmeth is not proprietary to PHYTEC products and is designed to
work on other hardware with a RAUC A/B system, too.

The bootmeth currently only supports symmetric A/B partitioning layouts.
E.g. A/rescue is not (yet) supported. The partition indexes and default
slot tries can be specified via environment variables, so that these
settings can be changed on a running system, in case they may change in
the future for that individual target, without needing to update the
U-Boot proper.

For now, the bootmeth_rauc uses a similar approach for loading the
Kernel and device tree as the bootmeth_script, in that it requires a FIT
containing a U-Boot script loading the desired distro. It could be
possible to support booting without a script and load the Kernel and DT
directly with this bootmeth, but I found the script method to be very
flexible for now, in letting the distro decide what to load.

The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2] and the following changes in the
U-Boot environment:

  BOOT_ORDER=system0 system1
  rauc_slots=system0 system1
  rauc_partitions=1,5 2,6
  rauc_slot_default_tries=3

Supported boot devices are currently only MMC devices, but it should be
possible to add SPI flashes in the future.

To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
board, you need to adjust the boot files to include the boot.scr.uimg
containing the distro's boot script and set "optargs" to "${raucargs}"
in it. Also disable any legacyboot in the U-Boot environment and simply
boot with Standard Boot:

  bootmeth order rauc
  bootflow scan -lb

Regards,
Martin

[1]: https://www.phytec.eu/en/produkte/single-board-computer/phyboard-pollux/
[2]: https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2/

---
Martin Schwan (2):
      bootstd: Add implementation for bootmeth rauc
      doc: Add description for bootmeth rauc

 boot/Kconfig                     |  11 ++
 boot/Makefile                    |   1 +
 boot/bootmeth_rauc.c             | 408 +++++++++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |   1 +
 doc/develop/bootstd/overview.rst |   1 +
 doc/develop/bootstd/rauc.rst     |  55 ++++++
 6 files changed, 477 insertions(+)
---
base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

