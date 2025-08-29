Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7531CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A0E7836AB;
	Fri, 29 Aug 2025 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D07C83577; Fri, 29 Aug 2025 08:10:15 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AE783447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN77FpqYVhDOY9vAA18M6ZxUx+q0xsDJGXn5ZJSuYfsHQhQbCOsNH7mfXz7QLzOLnjKhLQhNyvKuhtpHizbIfbNcSM/rg4SLDi/qoNHyDSDRjRAqMRSa/3DrILsIQZrG6LLyN3pIeSm/HklPhXYwaHqBhul/OPi2G69I/3Qx5Pxa4n2QKyUXjsao685DQzeyVjPdZvI5vNElMlPMe8+oDNZ1PEKRMdrMKiGZVSLgMohAryQYpJB58gS0iDh0ZTwgLzKQlwqIUmjfPFgnpvEglZDz2g6oCXl/nsTOacTw+ho9s6uRY5FX8kjOzlSvSH/ELXwdNWPX/DJzFMBqiA4wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7TVkzUZBFu/kuHrCEXXWJf6Sg6jaA9ClluApjOLzVg=;
 b=l3j4dCFVEam/pQW4d6bFlVnZqDYndUqCFuqkPEVSu9colFUYtQv7GXYrxsQj97DVDjPNi2iDvWb25Mv8Ybo0lR95pCjZ/8vf2rJ1DzjdcvAtVT5OB9paYebxexd8nFROgO27uljMmfkvsgkcx6+MsUFXK0fQl6NKqC+AyPQ4+29OEFypQy8ygGkwLszVjDqDG654yBVlQm5v4N7veDlHQeV3+mj4EVurgNmNwCgUHuqSDty9un9+Ewbm0mMKM4W94sKXTesHvdWxqC4NxKKbsg96UwPPbkXsmT7GeyY0rfDYDrZCm0xmJhdiHKwf1ZYi7kKkhfNT7PdCUHTNP7Dwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:06 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 00/10] Add support for StarFive VisionFive 2 Lite board
Date: Fri, 29 Aug 2025 14:09:21 +0800
Message-ID: <20250829060931.79940-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cafe65-5dce-4609-2dff-08dde6c2b37e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: LEsjmhVtN3atN3YDeJetLCGgzEsxGYN9nUivw7joX37h1y9n3lhEgBwNs6drGad97IRBi+6bCtUx/ef7ozYMBpvAMOunpwOo39NhmNBx8dl3xKLMjpZBXsAIXiSGOpC5mIt5JJen62oihbORKsgb8cchKZsAPf2LKJDvV8wTenQu4Dgr68mkQtmKedmwov+EJp7Rx17qWKXscfawAiDX+rKH7Of2+xCcdInf0wpB6A1Z6R/IQn5h+G4cYIv4CfCcykVEH0JeRFWY6GVlkClBpo1wsqUwT1NwhhKvkIMt1DXvWnSy+wbZxpGQ/JxEfCuStfkrhI4td5tm2sne7/UA5KJ0MgwIYIN0sz+xRJa5CYgHaaey9Nj9mV17UNgxqMp888a/nRRVcmoS6L1IJgkdOcLNFrzxDNsDeabTWDgEqzdGXjfjPHWKWSkqQKfm1wldQfLdJwCJhKy6rizrVF2snEqJJSj3SbVIFQdJwmPu240KHWRrVIFkWLzyiAHh7GyDt61Z7SIrsTlSw6Wpbept7ha425Bc3pFextg+g9r0svqsKv6TvNyQM94ENucUO9GoLQ54QtMMt8amxLon6fmmobyxVEvBDt94Fyza8h2eNoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+3JCPc95Bjnz4BYp+YuzseNN1TuA4F/447ONoRqsOjoiptWVcAluE4i6H6s?=
 =?us-ascii?Q?HWSQa8xl21/9BoSh4dhmxUhMLsv2SJClUcq8psxQxwOTzci+d97xt7Kn/ZxL?=
 =?us-ascii?Q?QKwXxPnqOocISqjCeoQWvw5hqhIT2mwYS9kaTXkUFXE5Dkms2HKeDxEGEwdq?=
 =?us-ascii?Q?ghcAiTHR6BtIlV68NRzg8k9WMUHQOcECBd5W2LRnc0AVGIgI8oyZlw1/4i78?=
 =?us-ascii?Q?FYn7rk2O6904x7Qf8BuqQXe8TqwtvbEAJCdRK/ekDjABDlocn5bJiILWDVtI?=
 =?us-ascii?Q?OC9YdxafPGLxlxInq9t8+8XITtRb+OiHoXxuLJbcfmj1XeYP02rRWjFJq67Q?=
 =?us-ascii?Q?nEx8fwcLEIfZasBBzFKKNUOvypFIpCC0DFqWWbAiZpbtn4MntWNg9kdaGlVo?=
 =?us-ascii?Q?/aTYMNWV8cu3QQ+pqVvcH7W1wyUcBtF6Vmz7CVMOO0mcPieENt7lW1YhDXiE?=
 =?us-ascii?Q?MBmNqVtF3IGytjgW3pe8S5YO6A3Cex047dLSsAxLKh49Cc6x2WE+11ck8fIG?=
 =?us-ascii?Q?3NmpqlnxzIJ+oqhLY572iLLoLJ9v/E1bWrExy5Ol+SksPkO8OZBBKGp04x98?=
 =?us-ascii?Q?ZgGgMV5Smju+wr7ekoIW+58RwH2QS9zkEZTW8lE2edjSozrNbYnmUg11E3tW?=
 =?us-ascii?Q?LlJ/sZcbDu/83U607TDX9XnMJLYN22MyB4hZR87Kmn3ma2hINmAMTHugnA2D?=
 =?us-ascii?Q?2cNe/XBiWBGdbpNgW3brO2L133LderAE5C8lnAKccAzIaas3eTJzGKIlldHl?=
 =?us-ascii?Q?2HX4ox99/XRhsf+Zqpq4FNtDmIDulB0ATqs7J6RwOneXRrHIzts50LCZ59jS?=
 =?us-ascii?Q?s5bS0rX3dhQnQALQRiqCaVEtYp/Wnm/fIvt1vWwdHKohRcGY4QN6oQpK7fLS?=
 =?us-ascii?Q?cFoExU+S8JyAo/KcSXZZQQOUMpgGrxJOpS6pl7nIl/yofShZs6CQFTOWX+dK?=
 =?us-ascii?Q?Um52lUi7F0JrLUUwAQBe6eNT3FaKwOs96yoBS/37kzudRCzolKK01W2MCUKB?=
 =?us-ascii?Q?mWvPolvhA4jz8MZjG5iKi12J/7cLtV+Jt+O48g+iMP3cm3OD7Y5vGY5ldp1+?=
 =?us-ascii?Q?kDxD76e05rs02+0zwzDtN/Bw3rGLqRrSXnC8paeB3V37JiTAttYYlLvlntyz?=
 =?us-ascii?Q?HK16yXtO0k+o1QzOGOszfrchZY8q6cjKIt//ULF6v38Uvm8SGnQGk9LKBttJ?=
 =?us-ascii?Q?SU3rx7/BY4xkQM7wTWz8UUDkSFzBw07E83iJrq+BPlnb0re2VQWL4/2gIBwh?=
 =?us-ascii?Q?Eet2qAiUb1JCsgaZLfSb30Dl+ckoGF30E7JkNiv8qQ6uXzW03mcxKWStngRh?=
 =?us-ascii?Q?DzPK/a9SCpu9ac5mQJUnsV5aew9YLOua0FDWfVMqr7tC84GmLdN2ypUWaMm9?=
 =?us-ascii?Q?zkZ0Lqn3tAzcmPAQQ/7cEb9joL2Cwzw32wq3zthjAkCusQ0cUkzLrOyw7qxN?=
 =?us-ascii?Q?I3QRlk8sggmEVEwj7b5uKkDKE4bSdojdsl9ZY/7LkLmzxVy6OteqRSdXAv2N?=
 =?us-ascii?Q?dt+hWBigNzoxO5FJdLJ14biw8N00rJEw6fkATNoNVUcBWOP3m70P/f6XruVZ?=
 =?us-ascii?Q?jFQmZ1j9AxCftro6vTgwIjTpxeToHOJXOQFSMeqdjrT+YiC0Eimn30IJbvZ1?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cafe65-5dce-4609-2dff-08dde6c2b37e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:06.7333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8VL7QJVtJ0YZ4q8xsI1hAQl8DpGdyTtntKgCwGm4WV52wTkg1sMwrXm5gP4qcaqfsylPIitPDykTyBlMoL5VXBUB9md1ZatoapLRPPmjt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.

Board features:
- JH7110S SoC
- 2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

For more details, please see [1].

Note: Patch 1 and 2 are the kernel device tree picked from [2]. If [2] is
merged, they will be no more needed. Please ignore these two patches.

[1] https://www.kickstarter.com/projects/starfive/visionfive-2-lite-unlock-risc-v-sbc-at-199
[2] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/

Hal Feng (10):
  riscv: dts: starfive: jh7110-common: Move out some nodes to the board
    dts
  riscv: dts: starfive: Add VisionFive 2 Lite board device tree
  eeprom: starfive: Simplify get_ddr_size_from_eeprom()
  eeprom: starfive: Correct get_pcb_revision_from_eeprom()
  eeprom: starfive: Update eeprom data format version to 3
  pcie: starfive: Add a optional power gpio support
  riscv: dts: jh7110: Add StarFive VisionFive 2 Lite u-boot device tree
  configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
  board: starfive: spl: Support VisionFive 2 Lite
  board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection

 arch/riscv/cpu/jh7110/spl.c                   |   2 +-
 ...10s-starfive-visionfive-2-lite-u-boot.dtsi |   7 +
 arch/riscv/include/asm/arch-jh7110/eeprom.h   |  13 +-
 board/starfive/visionfive2/spl.c              |  21 ++-
 .../visionfive2/starfive_visionfive2.c        |  22 +--
 .../visionfive2/visionfive2-i2c-eeprom.c      | 119 +++++++++-----
 configs/starfive_visionfive2_defconfig        |   2 +-
 drivers/pci/pcie_starfive_jh7110.c            |   8 +
 .../src/riscv/starfive/jh7110-common.dtsi     |  22 ---
 .../jh7110-deepcomputing-fml13v01.dts         |  49 ++++++
 .../src/riscv/starfive/jh7110-milkv-mars.dts  |  49 ++++++
 .../riscv/starfive/jh7110-pine64-star64.dts   |  49 ++++++
 .../jh7110-starfive-visionfive-2.dtsi         |  46 ++++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi   |  16 --
 .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
 15 files changed, 474 insertions(+), 103 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts


base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
-- 
2.43.2

