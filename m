Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C86AD60D09
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5128089277;
	Tue, 19 Nov 2024 03:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579198924B; Tue, 19 Nov 2024 03:05:59 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20723.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429DC89258
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5cIyfo/kOb9/83QjEl0ceEG1XK9ierzjPlWaUeUVgxSaacokbSvAfisK8jDKk6rWRy/uerRBt0HZ9O6x6i9BTfhIhHAMlHNbr8YBbgsIQsvDFc3YXgpD0LS7h0UAXwPhYOPN6OwLlNVIKKIWxt8w4lpQapAI2BOSWkYXxlGooNcxNzq7LvVzDRhknEg4bklEPDilq3wPSH6JKqNMhKkNe4gqx9iNizMNwHhsvm1bzepS68+AYqG3WBfX3gw9A7iv+xXrYQ/tT6Y+/8cBsh6F+7IPvh7yGaG2cJnoFm+3PJ+BVyyHcWAnFrhWXzFsTExgNRH3fGnBgQU5r5bStFp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwkFXu+Ht50MhPGFFxKtuXu21Zyrq3DuHX2pqJwS1qs=;
 b=NWXGCHwS6QSkIkoriZmmlehQpujwNRaoBMa0oyubmLr5be5SmlAAUuySH45mhfbp1eu90Hdz3YQgWzvovrt5pqfNqThjo2t5kHrMO5Q5OlPtNl6K+2H3vB/9b3G+GnWiR46SQryuNH3wPZB9ducY2wdiK1DLNRqX5OLw5ElIGy14VeB665oZ/4Hvv5AkIzIhd6tM5hL2bCI+vl7CbxTKyIcc1AaiOr6S1f4iBqehCq5nOliP+ywOrVEaWhRZAEGM4xuk/Q8qVNfriNdqNyG32aQt2S8vUAHqD+FPV8GfG5Ctv/qV3hBRjbb7SbfS7vsB1J91vrUM8J3cspbOUAuurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1275.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:01 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:01 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 00/11] Support OF_UPSTREAM for StarFive JH7110
Date: Tue, 19 Nov 2024 10:04:14 +0800
Message-ID: <20241119020425.51989-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1275:EE_
X-MS-Office365-Filtering-Correlation-Id: f5841796-033e-4dc1-a7e1-08dd083eb71c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info: e3IqMSQWS22NHAn71iKsAZyZOwu+i1+Sz3X1kIz7bvCFAM7+9ANfcZ2MWJoadJyw6+rc5kt+mpN5Tje4rYxfK6q7XqVQ46cFrtX5y08Yt+j6xA/oQUPgC9JTmsIQLbvyrZkA2aRZzy4K1Lzp4rB1NioA1N6xMcBCg7NwN3/1N7ViGfVFibcSWMHwKWzLMtp6iB6yByCL1c6k5hmFzIw30YEshJD38lP2B01XXOV5udpluzv69MRDCIXElyOGblUqHOA3ElxuOKQdXdELY9Av9zEt5hHeb6z1MxSBpzON9UnvBvqErOpMmATKl8ixDz8Y26nnHH9CiD8lR80a18tvgGGcwtl5KKhtSB9zet+X0fXOhefU2l9/0Bez3dJGZU7iOtdRdUi2l0S2Y9GPyIFTX2OrvoYhYgDQZYIhXKCCs7G6/j43gX6VfcQRBQjA0fpGG80ZKVkxyHjBwZSdKMUquekyx15dY0rFLfQWg6VCNQxVMQ1rX3dA4HV/V6dsLDUdsSPLqB7telfRYApP970UVlZ6EqkDJhNNwvQve8BTD4jXTbLFG/H0WrCxMQSc/mUDG4JM06meRREn6dCL9UEWwmk6/YnGjOwd6L7OL4x/S7vf9lX7/0G+dvBLfsDbEY0k0pNU3bQD6e+RGovkd9wywg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8o5O43kPFj8tByHCgEKUuFdxZiBBXiJU/I7WJNgHM/msJ6+XJM7tEtzI6YQ?=
 =?us-ascii?Q?2XPKgoy/+XNJBS1xNESOAB/tLJZYZJN7Lbh0BQfQsu8+Dl2p/gjuG3DBokCB?=
 =?us-ascii?Q?f0lCMB8ZzjOTb0eaE0ezG252MeoMdXZDWiMERccLPQh+c01c8XGJMw4RCeIj?=
 =?us-ascii?Q?tZ9h9ly61/+Fcew60eYWO646LScwMdfrDaER2qgdgYqDycJOp8YioWok4r1h?=
 =?us-ascii?Q?Q6VcUmJ99Q4EExV/O/Gtasnzw0dCuMXnhb3QtOYnannhmTWMm6D/MQXZERQ+?=
 =?us-ascii?Q?yFMuz0HF8kIX5InBBvE4QCJud/ZQmJPAYGTfyPRoh71PQSHe5ZyAJ6wueGvV?=
 =?us-ascii?Q?ilpYiPaDiwb/9MQyvqbmCFLfBCt8RwiGIDENMihS+AuQlxnNSpRNl7/kIolS?=
 =?us-ascii?Q?PcrffIHyq/tOvKcM0xTZbubXkLCiyE3aaOLw4vJRlh5XZTML1by5xjnchJlo?=
 =?us-ascii?Q?JkH5fCqo5BMSpP+rtu6k2jU/4JX2EBPFAEN0nXFiLT5Og512q7dACiSS6b1e?=
 =?us-ascii?Q?igrOyvYbbPT1YXFZHVFGHxk/KF0Bil9OeSP8ARXPIO2yQm6xhTstmoKK4gVz?=
 =?us-ascii?Q?F2/Bw6ODDXCS993UzZuVgvOR7jwo7AqheOb+5tYpPpt6M0zL8kK6LHwg70AK?=
 =?us-ascii?Q?m/XDruOrFI/907GsC63dxGrQFhRS1FvbpdDIeNabUkcIqYpRwekKMsBlw/OW?=
 =?us-ascii?Q?kNG7bxHQCuSASOaThVKTPBiOpwI3gyVKeViAfnCn8kvCl5BI4i2l382LJcZv?=
 =?us-ascii?Q?WrTd7DcJvXz+Qtb5PfJXinByafme1oCXiDJ6yiUq9DfsAJ3hey6tAJT4Wh1O?=
 =?us-ascii?Q?dB/OoUJKlt5wFRLNXzAoPI6oROrqzsuvjFv7CEVZx6lrR2+qWIVU4Pd1nUZ8?=
 =?us-ascii?Q?3RkO4V1VIn+H8DDyzetVM8aTlsI9pm9gsW9V0KHkEDYhW7ITnIhKJ/fkWbw8?=
 =?us-ascii?Q?GkA0KbI5bSbBiuSsE20xVDzAOQQaCZC4mbctU/OQCR1CojbHuOe7S7YAd1Uw?=
 =?us-ascii?Q?gCLjpO0yfXvpfGkjEHXA2pZLDk6mZU7yvJfKsjDaGPTHIu7iRNp9KXJ9bPoO?=
 =?us-ascii?Q?3oq+UmhO9BNDnSGWK7aibI+29stDiWD25PRxMS7Ph+OxJ7A+Ti0s/tLb/DOG?=
 =?us-ascii?Q?z2ZYA1MMlZCpa2phXCDLs+/g3lMWf4V2z/50ADF6yDIxzJJRV+L4Yj9Q4ojb?=
 =?us-ascii?Q?ukX21sc4/DNngl0+BPmz5ChO8FU0hThqOq7+UHEe/vcC8G7wCrdnM9iEK/lz?=
 =?us-ascii?Q?MMHVn6mlTXphZvMsG8BKD6+B7elLmZhTJq/A5r1afCyGXw0h0mk1G3CRCdcI?=
 =?us-ascii?Q?Lg7+N5FdA4sNcQ8hPYu6enTRdfioYYKyJE0+bjjdDUaXaGrmTOgBFoscFIUy?=
 =?us-ascii?Q?7Kd8betv+gGVF2c+DNPYe8uP3xMe2QMvZRC9dUQArnr/IkgYXv/bZfMhb8OO?=
 =?us-ascii?Q?R2ZxKBcyBDKI2nDvNJWRHtBPfTObnKexJVU4NRZwTJEKEVSgew8cXRujdm8o?=
 =?us-ascii?Q?TpRAVoQ47Wi2WdV+h4Nw4KN39/aOPGTf5qVR4UjeXhY2Eek9XgLUPLAwfdbT?=
 =?us-ascii?Q?L762XoVzsVg3qhBN5YzCvl1mnDnsX+wCeRgIQzGA2Wb0tmdJbbPfZBKtDIO5?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5841796-033e-4dc1-a7e1-08dd083eb71c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:01.1697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE8Tlmhnqzjr8lZ8nwZacT+yEB9aRx40aChNe7LblOgqXy832Qh09oKMilohhAwpmv2aPDNGMGzVjdRc3UvYaZ/7qyBqdnD2zh+8QMUxMV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1275
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
All the JH7110 based boards can use the DT from upstreaming linux kernel.
The v1.3b board device tree is set as the default device tree. Support
CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
EEPROM information.

Changes since v4:
- Merge patch 2, 3, 5 into patch 1, ensuring git bisect works.
- Add a new patch to sort the list of JH7110 imply statements.
- Drop the reparent of clock JH7110_AONCLK_APB_FUNC in patch 4, which is
  unnecessary and will cause errors in gmac0 initialization.

Changes since v3:
- Add detection for Milk-V Mars CM (lite) boards in patch 13.

Changes since v2:
- Drop patch 1, because the riscv of_upstream Makefile is created by Conor
  in commit 239e4705099c.
- Drop phy0 rx delay for milkv u-boot dtsi in patch 9.
- Add a Fixes tag for patch 13.
- In patch 14, the PCB version is only obtained when the product_id is
  VF7110. Improve the commit messages.

Changes since v1:
- Drop patch 12.
- Modify patch 11 and add three new patches to support
  CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using the
  EEPROM information.

History:
v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivetech.com/
v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivetech.com/
v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/

Hal Feng (11):
  dts: starfive: Switch to using upstream DT
  riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
  pcie: starfive: Make the driver compatible with upstream DT
  riscv: dts: jh7110: Move common code to the new
    jh7110-common-u-boot.dtsi
  riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
  board: starfive: spl: Drop the unneeded DT modification code
  configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
  riscv: dts: jh7110: Support multiple DTBs in a Fit image
  board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
  board: starfive: spl: Support multiple DTBs for JH7110 based boards
  riscv: cpu: jh7110: Sort the list of imply statements

 arch/riscv/cpu/jh7110/Kconfig                 |  19 +-
 arch/riscv/dts/Makefile                       |   1 -
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 198 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  10 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 391 +--------
 configs/starfive_visionfive2_defconfig        |   4 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 19 files changed, 369 insertions(+), 2135 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 0e6432e19f9c812b4986ca7fd8e6db9fd2c199d3
-- 
2.43.2

