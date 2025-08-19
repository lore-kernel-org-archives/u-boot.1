Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABBCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DFCC830A0;
	Tue, 19 Aug 2025 14:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="KLHPU+xC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D0981FEE; Tue, 19 Aug 2025 12:32:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F026802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNSYiD1/fS2KAbEdEY5tCMPC9wCruCdiwEqmxcz5bj6YL+E3FOp0Wp0K4NAyPbC+7wi8+laP7Lm0drTHAxCk785D+fX6oF5ml1R8rR1jNqp3nk+HoZP0xvjEHL2/a04kBj5msHQ8n4tUQsgg0+pzZrWdpFhTktd0DWyn70LvgJdIeQDHqd8d+BvXbTA5Phsj7Jh29MHPqeqfb2jJOvvjwcfcjzkWE2dWucXmSL6LdNl+Ijm1bg3+U2OYDQ2uqD5JUMR101kCM27ISLmC1hXURV920HMMaSO0tk2WjEwvk7Z+DW7jhqx5SgL4Q96btlaVK55gb3g+lvw8TabYT6Ux/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vOFNMbeFJnOC8m1xkLWLLkH6u5p3AWGdJHlYsNu+ok=;
 b=h8Loxb/NUjYSwodKmQXh/SkbTNnmrriI+KMY3hfeD251JbQbW6TxPJnfoxL6TWTU7lkMvNDs2GSjQn4AX/W90zANJxcVOn15tAmuTTU8rltZD8mMjE0gwBofo+uGBDokKcYzyVrFTvQv8LLxQ826daWBwMPWMNVB5Cvbi82z8rlNQxdGH5LqQzVBRGcrTwgKdpgYAX5H1Lcd6PvKuN7pdDMFLrXzQKk5RP/3rybH//dWQmFMzn528hB7fuXLcaFocFDgsGZpR+xoQxXryUCocMQwujTHGQKRtUwnnOmZTt1TJyTIWOfVlCiWqs+rfpLi+mfOVPR0eZ8rqwQuwmSz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vOFNMbeFJnOC8m1xkLWLLkH6u5p3AWGdJHlYsNu+ok=;
 b=KLHPU+xCS9SlFcjBSakY79RQomGZtg7N8sTsaREpm9XwhuGagaOahIjgRep2dMxu3etS5poKpYsSNIKzXNMbjCFFd7SSedch+g8RqXtgWoAhB6FhPcbe9xnsJ/LH0VgIvhurV5gG+BQiWaa8llelGGooXkOmBfcVSLalVfSgw4zB/iCVQmYXBPFZuuvIDASXYI8NOysNkot1PYerSFYU1+3VXY4rfJAHgNN0KRv8J26VAVi1zIL4Bbr2z/VrgVPVJ4+JAM7QzplgmMC45kW/JWa8L/uObGu+fffWSoWgVfmJWLeZQuqyArjsRXWODzjPK+0TGOKEEeCq4ngAC65xlQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB7338.eurprd09.prod.outlook.com (2603:10a6:800:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:32:53 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:32:53 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 05/10] riscv: Add support for MIPS GIC syscon on RISC-V SoCs
Thread-Topic: [PATCH v4 05/10] riscv: Add support for MIPS GIC syscon on
 RISC-V SoCs
Thread-Index: AQHcEPSeFCkBab8C30iVATmJMHuZMA==
Date: Tue, 19 Aug 2025 10:32:53 +0000
Message-ID: <20250819103021.1518687-6-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB7338:EE_
x-ms-office365-filtering-correlation-id: 10642259-6bd5-4edc-f338-08dddf0bc13d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CU+Dft7WmXfE0aSRN7kOOHr3fdHgaEX+H5imhsMZGaejPdxiEjfjVe7NNz?=
 =?iso-8859-1?Q?nvBjOkKBJYay3aQbZ8leckv+zgNKdW36Q9dZsKSH8ZF4kcyjDdysnjkwzi?=
 =?iso-8859-1?Q?y3mUx5bkBDP3tWfOfrNwh9zTbJKPJJGVKT6TmRVxc9WNQjvOduhjgBsUTb?=
 =?iso-8859-1?Q?+AWLT2cwyJvt6WAzJUirlgoLr+zLVYo0Hp1/Id+RyN1RKOwzXGciKg0+Ao?=
 =?iso-8859-1?Q?lNa93v98oUyGT1W9TEp6U8lMARTGoWUoa+f9U/NDUXWsIfsl8JttclxQtd?=
 =?iso-8859-1?Q?dkUwa4JOGBLNoGIN6ReucFbQKMpgP2WMg7ilS48yw4VuGq0CXpVD8UWMdY?=
 =?iso-8859-1?Q?imv9PdeOslG1nRhbaOUMCGw2uvHEaq0//3zGx19w4T8PzIViv0lp/9E854?=
 =?iso-8859-1?Q?sMNQ7wepcwfg68vcO4Btq6erBvsZIH+SJ2ZOBpxMg8ElRQAd/5zvBV77dW?=
 =?iso-8859-1?Q?HAsbPWQ28m5l7GnNUNAb1Hed2snjy/QscEHOxGckaAbvvfVCzzoeAiWdbu?=
 =?iso-8859-1?Q?/D1RhwsLVyIvrYt9X5s3G8y/XNS21HoxazXjCgFxYkptXOV7sPIzcqfwuy?=
 =?iso-8859-1?Q?+br/y/LSRMOU5AfeHzL3scGW9nIuHZVnGwPauoIZH9qJ7VSZdaJLzCo6nL?=
 =?iso-8859-1?Q?f/q3SOClS4W+LT9Fg9Aq1DK085yuggT6gzKRW+5K9/a4AuUAvUxqYWP3+8?=
 =?iso-8859-1?Q?Z+YZJD2impWKFOwUK6Qcwh3OLZGCQuFQBkGPaZqGYsV55Q/6XRo7yEk8ox?=
 =?iso-8859-1?Q?PZ+EuGwKAocYmd8i4qiVopTLnDShu7djtUyqjUxZEk8gw1MsHkrkeCyPb7?=
 =?iso-8859-1?Q?ZsarvClurxZdPWNfEUY4gjE/oC6SKeJMe490RlbjFeoNwEe2QmuxMxrZER?=
 =?iso-8859-1?Q?CcEgEE4F6a2WLoh5cTGUZUSllAVxaKQrZbKmnO/hdrzPwSfv7L0h6uf0lr?=
 =?iso-8859-1?Q?YlyJRY73KW7XzZNbe39wVu71m7T7T3EtWKZCL6nspJU21ZUhgQ65hUFdR2?=
 =?iso-8859-1?Q?p0G/jLNCQ4UvpPSFPtuuN85nH/FD7X/qhnO2rLAex0ROPdnMexz30+3NA6?=
 =?iso-8859-1?Q?4Lo/g3pi8FUBG3HIAcH2+vp+iVpri0DLLc4pVjweJsZd8pOcdozu0m6bkK?=
 =?iso-8859-1?Q?1etiMSKAQZmo1y6nHmJkfhd3KRltSWTssIxUOnQ9FrrJypvwvFLu8EJk5+?=
 =?iso-8859-1?Q?Cu3NH8eV89Ho6cFvtfCQITpTTQs3o18UR7OP6daYvAWrIT3N46SJqsD9Qb?=
 =?iso-8859-1?Q?TdbGZz/InP1n2Ook22DHqY9wFTNuiceMVWvNGhjfgnYfPUIB/P7D9FMrtf?=
 =?iso-8859-1?Q?8s3JW+frecK1BRU5GgnpQ+lLt60M0pErK95qPvfys7k3OQXTTWfezoBkCw?=
 =?iso-8859-1?Q?ZVf2bPvqT5Os+Y/XPU8WDrONPSJv98VcbHhUG0DmBxUZzg61Ub1IytwEKX?=
 =?iso-8859-1?Q?FBnhhTY7Gc+OKk6xTaH9oeBjY0H2J/UPCvuvCU7ykWHdHjSU2TU3wzyz5b?=
 =?iso-8859-1?Q?EmY3mzwnaGtPUj2yWkK7xv2TZdATu5Mt54sSWbDylkMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2LBLiCzf0IBwWMvCdxr+Oquf/hJZ9yWyhjvj7qbTg1rgDV4DVvMYXzpm5F?=
 =?iso-8859-1?Q?FFLbpgEKOrbhkIXTE6m3gak9Wwhfi3XMfjT7ZOeeh9U1zmdIIY1Y05kmAc?=
 =?iso-8859-1?Q?+grnnGUjfg5ifK38QVZYV8mVjcF5r0Kk+gb6NVrUkkw5i79IwfnwfmPRhQ?=
 =?iso-8859-1?Q?o+N8xkMCoCQWIUmVhq/J2JS0BxG99tsjWivS7B3XvjcIoqJU4i1GhIuiNe?=
 =?iso-8859-1?Q?mmxjxTtFnr5LJH9QP5r/zw5vWPp+NGTFwMYd6scoAb7eKdfB30/wPR46Cw?=
 =?iso-8859-1?Q?L2ztvrEkZ954m3Ntb8L/us2i7QZTrht34c9ChPWhDbG8hm6Swyg37+cbs8?=
 =?iso-8859-1?Q?A5pgAwJs5fZXtiUzr/m2hRKr1Yo6DUxEc408bfgyitDPc1zcgpQJP5U4Ao?=
 =?iso-8859-1?Q?YFLE6pWAjkbV83gKJBsm53FTgxUmstIOcQNSIVS381m8gY2f/t8bYCPJHO?=
 =?iso-8859-1?Q?2gL8Qu+RkpT4elKqqtEpEaCDl0JG+rbwBl7uIdjYgQ400Tp+Vi7HuVAs0v?=
 =?iso-8859-1?Q?y99HGF7dMndYHXyK2ohKTHRQeyXNlQFXY+N9IlTryX48SkE1uHmUP9U9Ue?=
 =?iso-8859-1?Q?A6o+2hLRLJ3yXc6oxCNTH/zLUyE73/1ZepkhCB9CmlRuTdq1X7WKprQpee?=
 =?iso-8859-1?Q?wWoGk0iKQowimkYZ7K7hy9mh6ihdWYcNrlAZkBnktAxf/SpfJv6VB3Bk9e?=
 =?iso-8859-1?Q?atb5/F5L4Ef/xEGWeB6zj0VBZfchtD96bG668bC9QUrJ9ponG4UA12i5V+?=
 =?iso-8859-1?Q?vGtenvhe+bCrbdTQF7dgu82h7yNC8LlFdVHdnSKLCYsTmQY/8beTcS2hD/?=
 =?iso-8859-1?Q?WvUX5uMDo0XS8MxFbG5wpbJzjujkv9ufA2XRasoMuiUE/fjDdizRS4H3mc?=
 =?iso-8859-1?Q?3kNI/J5imlH5t2Cz8qfalfVxd78Lm+eNiW8AsAWvATpjXeSlovhqLXWOgU?=
 =?iso-8859-1?Q?yLIR99N5ML3hproc5vgpsncyl2m0WRG9J9jfsEjx5/vciDwHz08Z2W1eoA?=
 =?iso-8859-1?Q?cy+jTL8wuWja95E/grjXCpNwjsOX84e3YsqEhsSNhl+PvPLfBkbb+h0dA2?=
 =?iso-8859-1?Q?sT5X8PdFUCuMEGGrbpzKr7+KaChc1BSNb/osF0oEMcn+oiObSlFxw3ng2P?=
 =?iso-8859-1?Q?fNr90ks4RT3Do3OU8TnxfL49RugdV9rSSQSAivoPxqjDheDnjCWRTqbX5M?=
 =?iso-8859-1?Q?9cZFQcT2AU2VfG6UTvVO7OlRi1LntHnw2u3udoz/dxwMSAYBCx+ZKgTUJg?=
 =?iso-8859-1?Q?NCNRAHwmcD65ckEU6nHrAWxb/pJ+PSExw3eyqJhv3SQ+Q8OCRCzu6n6cCc?=
 =?iso-8859-1?Q?OAGEFH3IsQ1uiYJnGC6T4UGLAS/HHMOfvpCEVjUqSsmrbg/EwWBWQNHAVJ?=
 =?iso-8859-1?Q?JGjzB7JxrPhvDdyjU+hXzUvLBPA3eSvtMjOQjJ8+w/dO0XWK2efm4Vq232?=
 =?iso-8859-1?Q?SfWcb7pAWiWhhtYSyFCjkIIjqrNUvVa8dTHZzNBMf29mZ0XCVDFLRhtqdf?=
 =?iso-8859-1?Q?FXl2Y7cse35fhqqC9sf3jRnp03RhcEhlXzXocWo2WBXUVv8olpABFVKHfV?=
 =?iso-8859-1?Q?8lVWT79AYiuasr8CTphGoBkjgpafqcLBI56gdeGydiDT987A+Y/IJ3dtUx?=
 =?iso-8859-1?Q?0fBAb7HKxZfhwAM1xfemxbridFPLwDd4e8nXdLn08GhlUbEoi0oKeeFg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10642259-6bd5-4edc-f338-08dddf0bc13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:32:53.5583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Adv2MllWPa0A9YtfCXFIM9x3LAcNHY3v4Gu8pviXoU5WG04/1SLsR7dOY95XXZI7UV5cSiaYvulUuAzEsUg+y4BRv8P5/lCYecGG8iLDx5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7338
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add basic support for the MIPS GIC syscon used on the P8700 SoC.
Enables access to interrupt control via device tree matching.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                  | 11 +++++++
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/mips_gic.c           | 47 +++++++++++++++++++++++++++++
 board/mips/boston-riscv/MAINTAINERS |  1 +
 4 files changed, 60 insertions(+)
 create mode 100644 arch/riscv/lib/mips_gic.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9e176522e73..6e1c0686db5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -389,6 +389,17 @@ config SIFIVE_CACHE
 	help
 	  This enables the operations to configure SiFive cache
=20
+config MIPS_GIC
+	bool
+	depends on RISCV_MMODE || SPL_RISCV_MMODE
+	select REGMAP
+	select SYSCON
+	select SPL_REGMAP if SPL
+	select SPL_SYSCON if SPL
+	help
+	  The MIPS GIC block holds memory-mapped control and status registers
+	  associated with software and timer interrupts.
+
 config ANDES_PLICSW
 	bool
 	depends on RISCV_MMODE || SPL_RISCV_MMODE
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index db8d235c699..692b56cc3f0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_CACHE_THEAD_CMO) +=3D thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) +=3D aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) +=3D andes_plicsw.o
+obj-$(CONFIG_MIPS_GIC) +=3D mips_gic.o
 else
 obj-$(CONFIG_SBI) +=3D sbi.o
 obj-$(CONFIG_SBI_IPI) +=3D sbi_ipi.o
diff --git a/arch/riscv/lib/mips_gic.c b/arch/riscv/lib/mips_gic.c
new file mode 100644
index 00000000000..7d761c58e74
--- /dev/null
+++ b/arch/riscv/lib/mips_gic.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ *
+ * U-Boot syscon driver for MIPS GIC.
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/syscon.h>
+#include <linux/err.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int riscv_init_ipi(void)
+{
+	return 0;
+}
+
+int riscv_send_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_clear_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_get_ipi(int hart, int *pending)
+{
+	return 0;
+}
+
+static const struct udevice_id mips_gic_ids[] =3D {
+	{ .compatible =3D "mips,gic0", .data =3D RISCV_SYSCON_PLICSW },
+	{ }
+};
+
+U_BOOT_DRIVER(mips_gic) =3D {
+	.name		=3D "mips_gic",
+	.id		=3D UCLASS_SYSCON,
+	.of_match	=3D mips_gic_ids,
+	.flags		=3D DM_FLAG_PRE_RELOC,
+};
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index bc59a628c79..0d9a951441f 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -8,3 +8,4 @@ F:  arch/riscv/include/asm/arch-p8700/
 F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
+F:  arch/riscv/lib/mips_gic.c
--=20
2.34.1
