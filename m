Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F0CC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE0B82AE1;
	Tue,  3 Jun 2025 16:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="tDW9187g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CBE80AE1; Tue,  3 Jun 2025 15:38:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E0D828F8
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdtXb15Ax/E3OCpZ8kNhXejL0aZjUYQTyILMFR1KoiaaWqoYhLlTQFIFbBpKWBDm94itdjmmbNS8SNp4SKYkn7f/cv/zXkzkUG142BEldCLiqCrmlg0lwWzNj8MsQ1PgNX4pi47LAYUNIUDP2LgUOUXsyNce9kVpluahuKGu8LYuIIxOHb0w3FX85QUZ17Y6BohKD2/rd4BPNrCyhqmE07HTYAJvM5XDCFA2S+CyyHfzXQEuCjaUieFVmUJcyLOMGwN6j36kH9OGMbGXgjE7UIFiBZvuYzln9jLGtV+AZ5/sexq9l+ewc1SUdRe8gwodw0QOevu4x11N9wk8AE6WJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbIUFNsIs6wqCaG4Vh+CPsguRF9F37b8hz5+4Vr71jQ=;
 b=YqEDkXEjxloh3FEnLWIXfdAwGqlWONyEnVCW/N6P4O7QF1fdxEXSSM1y3rZU5x7gFo0V0VpWQR56ersBxv+1N0iqQxwyfjXWH2PW5qYibnFp9A7qSY6jJXAmg+swfrtNhS2w5CO6wtiPU7XZlOZhkqwIs52f+gCP0eYdEloV/8nCMJBfD4HtnWLk1rj9kJ+OIUJ7ckFN2CN3ygwD2ow1ECHT2qTUaHEcUIFJ9FaPxTIsSGyYine0z8sJdA4xe2jafpPxIf4847xO9D2DDtxCqzQaTVNiXmoeFtJF6M5IySdLNmnXTKqKEiab1+4haArGtFjoCDLH5lncF0KObBUKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbIUFNsIs6wqCaG4Vh+CPsguRF9F37b8hz5+4Vr71jQ=;
 b=tDW9187gcYKft8ejXkKf6O7D7vRKo/cLKBdMSGUezn4IuOrSC/K0ru6TCQC+yU4fLFPOakOKzkKV6S+Bi1qfam9sjrFYYPuQfkfxuoX/qRz8oHCsuhHP+Y0Oj+oWGbICAnVrmEmc8YtmzM8t6n45WHvbUULAU6SBkEgVxF/AvnumdUDMfczqaStrtEKV+C6x/ylRfm+fJKRu6194+2NJNp1yy6wYcDZLlICXxE4mmnnwO2pKDgi/ZFWQLDlodWL0XmgWEY1fDa+GFWy85z1KYF8zIY7lmpoq7Bga7iXk2mxQnYQXBNvFkf0RJJ68loNrM8Ekus8UCMoWwRAKIJTvOw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB4PR09MB6623.eurprd09.prod.outlook.com (2603:10a6:10:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:38:08 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:38:08 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH 00/11] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH 00/11] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHb1Iy9t5cyQ8vB7kq7VUpPT5vDNQ==
Date: Tue, 3 Jun 2025 13:38:07 +0000
Message-ID: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB4PR09MB6623:EE_
x-ms-office365-filtering-correlation-id: 8c035734-f6e2-4e64-7ea0-08dda2a3e02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?phEyrKGhQGYpP7SdWKr2aiXUN/I/qZbu0PGDth/Pcwxx5gohwCWSr8UugH?=
 =?iso-8859-1?Q?Fo8Vi/lugCGBumtWPUEepNOgcR59wS3sm33bETM8xJ0irlS/gt8y48v0Mm?=
 =?iso-8859-1?Q?AhLZ2jqMdmhQN7aES4gPb4Gp2vld8Rm6SrgHFYRMz//fXBmrRcYttZ+RU/?=
 =?iso-8859-1?Q?i53bxeIKOwl2WI2BtH2Jz5O2MRSZhVgwYpEuwyKg96wlIEIZ0WZWjF2x4l?=
 =?iso-8859-1?Q?+/PW4oLxAExX//H0SeMF3S4VUQ5oBKZUItaxabjrDyC3I0swOIFQLHCdCy?=
 =?iso-8859-1?Q?FKGwT6LsyjqaOZv7jsGdiKEMv7+EoBF15PPtfdXXxdT3H9oOxWr+jrlcn+?=
 =?iso-8859-1?Q?zyZoyRrVTHfomhNMO0A3mzg7vfwSdBLufPInkwd5sxS5eWi21XjnL5fUYr?=
 =?iso-8859-1?Q?330Q7IudpKbUMbhliRk13lvc9HBs/3G15bNsOuWfpwOTPtzZkykHENk9mb?=
 =?iso-8859-1?Q?mg0sAeF9/c8LQ1HLlz5v1QsG7BZ5WinT1kkf6LfFd1PVppdyMB7Y9fG2kN?=
 =?iso-8859-1?Q?sBKLHUjhzNGjrTU64c4Igl4dTRBq7nXk5VJ27JYvKfZ05hwQaSPEB14try?=
 =?iso-8859-1?Q?cJT2lgppfBE6Ci68JllW9h5gWK1nIzF3Fqx3hUQhBzW4VQOl7VMv9iSpax?=
 =?iso-8859-1?Q?MX569JbIdBLKOmcUGPXjiWxdXuaoTnvNV1WL96j0SncSaSLn+FWy3mXAqj?=
 =?iso-8859-1?Q?VOESa64CxM8rPSA8Q6bWscqwacrAnb55u+fMDxyoxKvV3FuHWz9Bsw4wtf?=
 =?iso-8859-1?Q?HjEh1GGd1GuvKepUjfx4QGgafhtPKgWpsnIuaO5i/vBGBbsDUaI1eIwUCH?=
 =?iso-8859-1?Q?ugf7OgRKp9JN7JaZB+XE2duIH0QbR8qHmAwabyGU2LLvQtIL0kbqMYdI9a?=
 =?iso-8859-1?Q?aE4pRAfAPnEPzqJMVHc73YsoyQIw9Oj/cArB9Aiyql3nOzeJgWfAfVRcC2?=
 =?iso-8859-1?Q?5ZdyHGrvMrDhUMpgoUIZZI/PxHq4cEqQQED1IVMn1/QvM2tx9/6IwaWlo3?=
 =?iso-8859-1?Q?S27j0S841QjlQtacen8KDnVvG9B2yW2P0CqbM1GRHswG9zZeouXGxfRkxA?=
 =?iso-8859-1?Q?GML6R+rUIqcxIAeekMebU5V/D50aRNo4TxVCOviGwwcL52ZwW0aifKrZqZ?=
 =?iso-8859-1?Q?0Xz9tFsJM5RZ20LjzJ57iMMxyLsXD+XgvSSRRuOZZyQ9gImBVivARdHZxH?=
 =?iso-8859-1?Q?6Ggubzu2XVFhgYHue3TomugdT5l652Kyc4UECnwz6/Ega9egqy8C7joWF3?=
 =?iso-8859-1?Q?S3yrsIEuiHfJvWf8hQ5vQH0d+HejemAA44OBxD0TMMxHVgKoMKe2kehih9?=
 =?iso-8859-1?Q?3MA5ATSe0ULRTi6pdnBy3820WjP+W07dik1wy7YTwZUVDTH9P4YZay/wiV?=
 =?iso-8859-1?Q?XozN47wDWJC5x8uLFrs2pTFhEAwAbE2EI5rb8il1/oIKGhkJ/PKiDZX0km?=
 =?iso-8859-1?Q?zXZ6VMtWGb8/uKgxExFFj2msgrq70CMW6eQevbOEOiAtfRHYSw9/7nI20p?=
 =?iso-8859-1?Q?cGc9GiKNbfFIx52pSqYFg33P3gBymOMU0UaQtcfVBelw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?urp1eleQoaMKSCUvNqWKbO3jZ4UTI9DflP/Y7nj2oJwyYoIr9f1FanoNrG?=
 =?iso-8859-1?Q?bO0KI3VOEOL7nwOLfFFn3tNza2zyl9DFAnjINoQrftuQZJEW5oe6s+oLJC?=
 =?iso-8859-1?Q?mmkgSxdPzNSqD20OFJR1PuNnrCrdRd1+raWZsbMIJuQfyxG0rUSM99OctZ?=
 =?iso-8859-1?Q?fqesJeOvME84uyCs0A8yh3b7YT1wW9dDpZYZoX2inAp+S2y+fxNFk0Ra4f?=
 =?iso-8859-1?Q?3nwcZTonPa3ov0xqeCQTr5QXaFmQApKwiqXVg8YZ56j9/5aN6MnmPzKfPR?=
 =?iso-8859-1?Q?MR9q7TcbwNLK+oDGK59F+DW64K5gwHc3myLk0bto/fYmTmEScwB4z4AYuP?=
 =?iso-8859-1?Q?I3SGFnBiEiAvNJOBQopFYA4lmuSz8lT9rKo5wUDFIStrIP+cq2jwYgSEqV?=
 =?iso-8859-1?Q?SBJkL/1H/e9y/3jpddk/V2PxD7y9t9Zr9yMjY++uHfqizfTSfJTXIz/Y7Z?=
 =?iso-8859-1?Q?jaYy2Ldi5IbWbNSkw5bGymLIXwa6f1kLOUsUeYYy1PZE6Hq+lWk+rMOs+k?=
 =?iso-8859-1?Q?mqsKR0PXdAZ/kIJ1K6nKmP/or6a+fubX7tU1bdH6hXIqhaTCh+fTHAzFJH?=
 =?iso-8859-1?Q?u7l0xfvZUoVDGbONq8/cu3W5wmkC0AIyulEhWEtVGy8JAIZ7wE8NeJNv6S?=
 =?iso-8859-1?Q?+IWel8YABbvrgI6uN4Jn7a5HAwfPnUBP3/YMY/IqoQZjZVtFAfyDRUb58o?=
 =?iso-8859-1?Q?SdIGqB7+/kP7p0Hz+nWhv+vzqF4oWlmR0FXXF8w9XEOgGWQVAirlgRoJRO?=
 =?iso-8859-1?Q?00swa8b5I9EIuNf7n5DzUS3Ry2BmoYmnFy3LtOU7n7js6K6jqakBRJcrv2?=
 =?iso-8859-1?Q?AiTfgPXjt8vAqTvn2W9XM1yN3HNQ3dgMN3gHpnRSoUaQf2aPHDCc40pUSg?=
 =?iso-8859-1?Q?1SyAmFoibYDo8caNWPT5n65Pyg470So4WIsLaY6yYxxotoUsZY8/66yxU5?=
 =?iso-8859-1?Q?2lIcQ3AaeZSp/uMbarByE4+LoqhuFl+BBl62KOx8Q3NIYq3NWKZkwRMuYM?=
 =?iso-8859-1?Q?1QVL488uqhg4UoV6IzsVXC5cAPiOb7l+TRszGyH8d5Ym6Rmrfe04SxOOSj?=
 =?iso-8859-1?Q?zPGW6WrDSa3oDY/lck0OcJxiCZ7N1vo+x4jaupoQjmap5p+R17TQFrOZ1T?=
 =?iso-8859-1?Q?uD+IyBzHuvxtToTusH+tOObA9cWgUSpmeyeDSZR+SVyp0c4WIXGuj4gvWj?=
 =?iso-8859-1?Q?VMaJ7ZyTdUNHLrVC/tqzEJWJlGSyFcj4DrbT+QjsdRgTlADUo0L6Absnre?=
 =?iso-8859-1?Q?5kz/RpkjQwxlEdN0fysO6Mzp9S1mey4e22ibUWElgAx/Rl9eLbzi56xQ/t?=
 =?iso-8859-1?Q?3XkrKKhv7AtaUujbl0vZtXyhudFZF/dNXDKjQJwEC9A0Iqf6RpTS5pZNUU?=
 =?iso-8859-1?Q?P6H7cjyMhU0HtOGBNH3P1ryz5q4nu4nzNhiTAo6YbcBek/PjuCL+YRBd4s?=
 =?iso-8859-1?Q?auHAYVqfrfn0cSeDj4I7GN/fwOFBkaq57cJMiUfF2wbqxtNlChEXu8rg40?=
 =?iso-8859-1?Q?9TvQvLE0/BB8oBm8XTonKBU7DunudLC4wlU3NPKPLwZxusG12Y+gHcHAcD?=
 =?iso-8859-1?Q?sZyYSKWMeE6qaQJxMrANRvBfYNjXpwPNb2AOaj84ILlddPCCPDiVXoav3F?=
 =?iso-8859-1?Q?d77Zo40sAJCcZZh0xrxCo9O7DNdsu6O+WXDN0NRXqlYDkjXQRCBUC/sw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c035734-f6e2-4e64-7ea0-08dda2a3e02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:38:08.0575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukK4J5R6DHFgpIdegzacETrP84gN6wZ6PgaQ/h6SZ+2AC8/irYzC+pZh4EwfYOniTU/Aw7YVDwISskuXpZn/vpB53inb44asOHmPFxEX2zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6623
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

This patch series adds platform support for the P8700 processor
running on the Boston board.

P8700-F is a high-performance RV64GC SoC that supports hardware
multithreading and optional multi-cluster configurations.

Chao-ying Fu (10):
  riscv: Add initial support for P8700 SoC
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Add probe function and improve memory region handling
  riscv: Add support for MIPS GIC syscon on RISC-V SoCs
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  libfdt: Allow non-64b aligned memreserve entries
  riscv: p8700: Add software emulation for AMO* instructions
  riscv: p8700: Add Coherence Manager (CM) and IOCU support
  riscv: boston: Add support for LED character display command
  cmd: riscv: Add 'startharts' command to start multiple harts

Uros Stajic (1):
  timer: p8700: Add support for reading time from memory-mapped mtime

 arch/riscv/Kconfig                          |  22 ++
 arch/riscv/cpu/Makefile                     |   2 +
 arch/riscv/cpu/p8700/Kconfig                |  15 +
 arch/riscv/cpu/p8700/Makefile               |  10 +
 arch/riscv/cpu/p8700/cache.c                |  84 ++++++
 arch/riscv/cpu/p8700/cm-iocu.c              |  75 +++++
 arch/riscv/cpu/p8700/cm.c                   |  92 ++++++
 arch/riscv/cpu/p8700/cpu.c                  |  22 ++
 arch/riscv/cpu/p8700/dram.c                 |  37 +++
 arch/riscv/cpu/p8700/emu-amo.S              | 254 +++++++++++++++++
 arch/riscv/cpu/p8700/p8700_platform_setup.S | 155 ++++++++++
 arch/riscv/cpu/start.S                      |   8 +
 arch/riscv/dts/Makefile                     |   1 +
 arch/riscv/dts/boston-p8700.dts             | 253 +++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h      |  61 ++++
 arch/riscv/include/asm/arch-p8700/p8700.h   | 144 ++++++++++
 arch/riscv/include/asm/global_data.h        |   2 +
 arch/riscv/include/asm/io.h                 |  86 ++++++
 arch/riscv/lib/Makefile                     |   1 +
 arch/riscv/lib/interrupts.c                 | 299 ++++++++++++++++++++
 arch/riscv/lib/mips_gic.c                   |  47 +++
 board/mips/boston-riscv/Kconfig             |  51 ++++
 board/mips/boston-riscv/MAINTAINERS         |  15 +
 board/mips/boston-riscv/Makefile            |  10 +
 board/mips/boston-riscv/boston-lcd.h        |  20 ++
 board/mips/boston-riscv/boston-regs.h       |  38 +++
 board/mips/boston-riscv/boston-riscv.c      |   9 +
 board/mips/boston-riscv/checkboard.c        |  43 +++
 board/mips/boston-riscv/config.mk           |  15 +
 board/mips/boston-riscv/display.c           |  33 +++
 board/mips/boston-riscv/iocu.c              | 104 +++++++
 board/mips/boston-riscv/lowlevel_init.S     |  20 ++
 board/mips/boston-riscv/reset.c             |  15 +
 cmd/Kconfig                                 |  14 +
 cmd/Makefile                                |   2 +
 cmd/display.c                               |  51 ++++
 cmd/start_harts.c                           | 103 +++++++
 configs/boston-p8700_defconfig              |  95 +++++++
 doc/README.LED_display                      |  26 ++
 drivers/clk/Kconfig                         |   2 +-
 drivers/gpio/Kconfig                        |   7 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/eg20t-gpio.c                   | 138 +++++++++
 drivers/net/pch_gbe.c                       |  36 ++-
 drivers/net/pch_gbe.h                       |   1 +
 drivers/pci/pcie_xilinx.c                   |  35 +++
 drivers/timer/riscv_timer.c                 |   7 +
 include/asm-generic/global_data.h           |   5 +
 include/configs/boston-riscv.h              |  11 +
 include/interrupt.h                         |  19 ++
 include/led-display.h                       |  33 +++
 net/eth-uclass.c                            |   2 +
 scripts/dtc/libfdt/fdt_ro.c                 |  11 +-
 53 files changed, 2636 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/emu-amo.S
 create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 cmd/display.c
 create mode 100644 cmd/start_harts.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 doc/README.LED_display
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h
 create mode 100644 include/led-display.h

--=20
2.34.1
