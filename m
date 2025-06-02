Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B3C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 11:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B4481F6B;
	Mon,  2 Jun 2025 13:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vu8Cgzaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC41B8205A; Mon,  2 Jun 2025 13:32:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E64680050
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 13:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSNzPR8vDH/JlkURLLTrkCzh10GM/zlNcKsae53h5ZLKQ8QplZwY2DAog1U+wk/iit95ffesFohBQQl6vF/m4ypAnj7QcdFhHzVeSNxWNAHe6HeAnzqtqJI7SH9YA7+pZV9yU/UAs21UqgGe0d9qN891E426x6ZpCzzVkLqIGmsLnhsDT4rnJOTqEBR7jPu/G07r6lgDW1M/f5St0sxmHS8fwdG03if/ssfQ087TdAzYDfQR7jTtL0cSDKzGdDyXnoXGQgL/Y1M5ctbFXVwlvwbdSnhAc2H4vYUD/Sn5kDkyIa1LI/tK70m1VdiVQRVPFJvntm5x2h5Ry4J9P9KKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0qbH14LAgtO4VBOZn1ptEjwsPQLn04HqxBbsdIZDrE=;
 b=V9rEYAkjjv3sVwUKXaTbH4JJ3geBvdh8nuPFhlIRRVRXBnzLiQ5F2OPCRY7VeU+etxWTxjZ0yWsd1HOP340TRq/KZS5/wltH58tK7z81biSMnzdjJ0nbrF1hfyj4OV9qR+/qqwF7LURVEOad0QORY8sRpWS5g589zFpM/RJmWRusa1PyyBd+pt5T+PhTPlqpG24DSH/zcX/wilxMfr7S4zagG4DEuNYnRtCI9piXSnVs5QO/9VB74LhpUZuw/P0YiJihVswjYgQZe4boGCmtQ60cx+Lz9YREfpmoWQ3hwcEE8P15n3ZMOohido0QJWQOPlGgVJXFk0NERCZ9CA5H0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0qbH14LAgtO4VBOZn1ptEjwsPQLn04HqxBbsdIZDrE=;
 b=Vu8CgzaaHHnVS44xwFee2Vi8WLVxQ6vQN/JOAfUuRoUGlLhtV0hulOZGSiaLo7wRXEcWNCUfMn2iEEGctmEf3Axi/u6qvmbUNSgkAK4hNGvB3DGowS9ZlsWQmVBjEJGXnAuojNckdf58r5QlDt4PzPrR3/27lfsNrrxWsJzXKcfSnsbtidSI/+yBrURbca5OlfPq/XCIJEsTk7u6UNTmLgrVFrpfPn0fhKZ41NwXDyRvlK0sQGabkxxhpbPeTRWXeI2T8L0XsOITJmRPv/XQU3YBGQuXUsNV20DFVINb3WO22fyAOroxupu5JhO9nEK115VRuZEqOptUvgwmLcNwjQ==
Received: from PR1P264CA0113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::14)
 by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 2 Jun
 2025 11:32:06 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:102:2cd:cafe::59) by PR1P264CA0113.outlook.office365.com
 (2603:10a6:102:2cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 11:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 11:32:06 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:05 +0200
Received: from lws-schwan.phytec.de (172.25.32.67) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 13:32:05 +0200
From: Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v2 0/2] bootstd: New bootmeth for RAUC A/B systems
Date: Mon, 2 Jun 2025 13:31:33 +0200
Message-ID: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWLPWgC/32NTQ6CMBBGr0Jm7Zj+gKIr72FYQDvYWUhJW6uEc
 HcrB3D5XvK9b4VIgSnCtVohUObIfiqgDhUY108PQraFQQnVCKku+OYZB+/Tk5LD0L8MCj00pKx
 t27GGspsDjfzZm/eusOOYfFj2iyx/9l8tSxR40qKls1ajlvVtdksic7QE3bZtX3MjZ+CyAAAA
X-Change-ID: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Martin Schwan <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.67]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|GV1P195MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e513862-0071-4ed1-5aa6-08dda1c91a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWQ2cnBFZGhaNUFyRTJ5c3huY2trNjdJU3VTa1RIVVhkV0dkbHYrd0xmM3V0?=
 =?utf-8?B?V2c5RHloZndnWkFBL3JNOEMwZm1tUTdFUldnK2o2VmFSVk96UTkwTEVWRmRT?=
 =?utf-8?B?aFVnZ0F3bzRFYnZGNXN2T3BQUXNmVDdLQ0JaUTU5eFozNWNVekEyc3VpWDlk?=
 =?utf-8?B?NXU4Q2hrVys3RU5kM2M4UlBpZllVdGZ4a0lReFhHWkhSK3RmSVU5TmxFVEE0?=
 =?utf-8?B?N0dPOFpaa2tOQmhwQ0QyNVVIdHA3dm40bit1cWF5ckt2Z0FsNUdMN05Sdm5W?=
 =?utf-8?B?cDFxeiswMnRvV1B2Rmx2ZjBiRkRLbmJPUDlQMDc2KytESzkrbGJleXllWU1R?=
 =?utf-8?B?SUpWR0VmcDNWSTNSd1NFT2VXMm9KaTBJc1F3TlgxbnVneGg3aXc3S3RKMFky?=
 =?utf-8?B?Zm4rTjBsOGxtdHY0OUl3MHpReWNJdGhiRmcvOEdIVWQwc3pjd0VxYmVqOU11?=
 =?utf-8?B?YjdYSktjYnF1czVBR3JHWTQ4WlZ5Nzc0RE5RY1JPbDkzcWMyR3hPRk5mUWZv?=
 =?utf-8?B?dXhwQncrbXBzWUNJcDduZ3JTV0dVWElvMW9LV0NmMEZvSGc0VmY5TjJwelJS?=
 =?utf-8?B?cHlBejZMTU91OGVxaE55TVdGb29ad0dhS0tCNXVYK0p2Vk9tOGV1RWEzTGtE?=
 =?utf-8?B?ZXk4bmgrQ0RETkhDVWVQNHRNWThQcjdLV0tkLzJObzdkMXB1bWFaQ2RaZDBm?=
 =?utf-8?B?TGkzaEx2TTdncitLRUhhckZwM0FlRjJUWFIxbklXc1I4bHdBNElLTlNPR3VL?=
 =?utf-8?B?dmE1T0ZLZmN3N09GWjYwU2JyQUpaSU5TVGFtc3BMU0w4bldrUTZHemFqZm9C?=
 =?utf-8?B?VkNocHVlMkZNNC9icEtKdnBBTk1GWFhsNlBjcTc3STVrWEkrbUF6WlEzb0l5?=
 =?utf-8?B?WG0xaDR1a1l5bkg5VGpQSTdvNE52WXR6M3prS0dLaGh2VUZ3bFo4WUpnN3R1?=
 =?utf-8?B?aXBHSnMxM09pVEsreE5CVlljcVNqcmJibW1taTVseTV6RzVSTEI4Y1NuWU43?=
 =?utf-8?B?SkNPNUszZjYwdExjWXhlZnJtaW1Zd1dDcERyL3paOUlqdUZFUGlqeXB3bUJp?=
 =?utf-8?B?MGZRTEl4OS81enFEU2ladnlPMDllK2puemNINjBoYThmWDVUZzZpRTQvL0Fo?=
 =?utf-8?B?ZHhrYzhDczlRaFlxTVNUcTBJdmxZZnlFSlQvbWROSmNzNlh2S2JadGgwYng4?=
 =?utf-8?B?RWlQek1VS08rRXZ6Y2lSTEVjVGxEc01WUEJhTkJUMm1oTnFhMlRmZ2xMZHNU?=
 =?utf-8?B?TUFacVh4dGNicW1jZ2tXL1U5WUtvdU8wZ2FXYkd1NGJHVk1EeThzV3VlVzhJ?=
 =?utf-8?B?emNhSzBzWks0WE1SQmpGTXVNZ3pFWXpmNEtENnJKSUl3QkE4bWdub1ZKcmhz?=
 =?utf-8?B?R3V0QlF0T0tLbmZuYjBvbStLd0pRbDUyS1prNnY0eTFqVTBmZU9VaXVXaFZK?=
 =?utf-8?B?SFhQRGNkekxIaHMyNDlWWVp3bWFRS0V1WENkY1U3ODBScm9nUHp4a2ZRYmFs?=
 =?utf-8?B?R2ZXdkc1Q0o1bk8zQURURFFHdEkweGxEaWp6ekF6djJEcnZSL056eUVTQjBk?=
 =?utf-8?B?NjJXakJxVGZjNFMzVWhCSWg2citHUHZkVk5FbUcveDN1OWp4M3NIbVBNVEg0?=
 =?utf-8?B?eHhVbFJaVmFTelovNnBjdURCQWlRV2cvT0VOVWt5c0RZeEdTM3J6M3R1NUQ0?=
 =?utf-8?B?Z3oxelI1dW1ucnNIRmpkSjZpQUYzSTNsWFZnck15eVlwcFJEdlRxRWxjc3lL?=
 =?utf-8?B?K2E2UTRpQkV6RFd0c2l1L3hITDlVRUwvajFmZUE1dmRyU0V3NHhxem9FcmV2?=
 =?utf-8?B?QjhLb1BtWXJnKytFcFFMYWRYU3lNcEdjR1dwQ3VLRlpqSW9pQTczVVdyZktQ?=
 =?utf-8?B?UExReUtudENjbG5GNlV6dVRXT3FEQ0F6aDQxT2Qxd0U2MXF4Vy81KzFnRDdM?=
 =?utf-8?B?SGk3Sk1LL0pCOElpZTNPamdVaDRJczdiVFJOSUpwNkxZa1Q0UFlhSk96cmhF?=
 =?utf-8?B?ZHIvY0szdGxnPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:32:06.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e513862-0071-4ed1-5aa6-08dda1c91a78
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2055
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
slot tries can be specified via configuration options.

For now, the bootmeth_rauc uses a similar approach for loading the
Kernel and device tree as the bootmeth_script, in that it requires a FIT
containing a U-Boot script loading the desired distro. It could be
possible to support booting without a script and load the Kernel and DT
directly with this bootmeth, but I found the script method to be very
flexible for now, in letting the distro decide what to load.

The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].

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
Changes in v2:
- Remove LOG_DEBUG from boot/bootmeth_rauc.c
- Reorder asm/cache.h include to be last
- Do not check for RAUC-specific files in the rootfs anymore. This does
  not work on encrypted root filesystems and is not a stable indicator
  for a functioning RAUC system.
- Add a description of the term "slot" in the corresponding private
  struct.
- Remove boot tries left from struct distro_rauc_slot. The boot tries
  are read directly from the environment, as that's the only correct
  source RAUC is relying on.
- Remove the current boot_order from struct distro_rauc_priv, for the
  same reason as above (env is correct source).
- Add function for retrieving a slot struct, to ease finding the right
  one when e.g. iterating or getting by name.
- Fix multiline comments.
- Fix various if-statements which were explicitly comparing to 0 or
  NULL.
- Free various, temporary instances of allocated string lists.
- Set default env values for BOOT_ORDER and associated BOOT_*_LEFT
  variables. These variables are mandatory for RAUC to work.
- Use calloc() instead of malloc() for allocating the private slots.
- Use config options for configuring the partitions and default boot
  order, instead of setting them via the U-Boot env.
- Use bootstd_get_prefixes()'s return value and check all available
  prefixes for the boot script.
- Add a proper boot order selection logic for the rauc bootmeth, similar
  to the previous environment scripting, with fallbacks and slot try
  checks.
- Introduce config option for resetting all slot tries in case they are
  all zero. This may prevent a system from locking up in the bootloader.
- Rename env variable "mmcroot" to "distro_rootpart", to be in line with
  "distro_bootpart".
- Change the bootmeth flag to "global", as the rauc bootmeth does not
  work for individual partitions.
- Update documentation accordingly.
- Link to v1: https://lore.kernel.org/r/20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de

---
Martin Schwan (2):
      bootstd: Add implementation for bootmeth rauc
      doc: Add description for bootmeth rauc

 boot/Kconfig                     |  51 +++++
 boot/Makefile                    |   1 +
 boot/bootmeth_rauc.c             | 432 +++++++++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |   1 +
 doc/develop/bootstd/overview.rst |   1 +
 doc/develop/bootstd/rauc.rst     |  56 +++++
 6 files changed, 542 insertions(+)
---
base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

