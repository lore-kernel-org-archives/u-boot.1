Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E7C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B65082CD5;
	Tue,  3 Jun 2025 16:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="iDsyVDsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D66082998; Tue,  3 Jun 2025 15:39:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE3980F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBkMJpxa9JAqBCEAexOvNw4cKJu2rzLrJpHABDYxANoVJODDAMgsxgQM9h70AezFeRsXGL5ANnYDCuKLHuCi7m8OY8addVWZMe5RL5tTyNalBMBLHTsZ4vOKhXFCTskQNOf7K3Qc1ugizK+cK9GCFRwfnvN5C/9Qon8iWI/TXpqVCmiUssGwsi25z9PuSyV1RLkWfvnDFEDJuoSzxeA16/zW7pj3VMkyO4xgJ7WCsc0Klni73wVp0qA3VtnY3YxSWuFYw3SD6V1Xv1rn1RmBXfEHGiSY2M3/IX1FvzBFIXBpgv0Ep3cJkdgtrheaj5zQ/QYiBMhV2ek8aBJqjnpQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=gWoNhlI/fRpBZMk9T5Pnhk7cmm1t0hC3lJpALxJP4SIUoQ7A2UOcd3nQ6YATiN0SFz0uuCp0vQKVEA83AkAMMSSjc/krDuAlYKwII9PF+b6ja2jfMIZNHyK1o8eQfoso76ryNp+U8s1fjRfaLnXz3lPKQH9WVMisZ94qCW/3XfJhOQo2zapCtQTLh06BGXEUlxt/03mmH1Ply/zIClAC1z1S6lLm1jzQI06m8dEqNz+wXREAsIxeDN3TOWs6TnSm4dgEX6HC/POYxS/ChOUMDF2NO780ISO3XKqbygzgAzeEgrfLamVAxm3/jE9EPoA0+ROaJHt058PB4irMre8lqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=iDsyVDslGLPe3RsRrzBMudOgK9h48y6yD8Oz6TJRc4mQSse/kS43g7KhVQ4xnUEADrTaVEAKyKDcODdxp7Hyo6oVF7mcrDtSEErYst8p2afVxnfAeZvOzbhDAlGdwX/5wuOki6XTit0PmMN2wPYvFfVOp8wVipW55QkdF0/zh3gT0zcckx4s5FlY06x5GNaAqDFXhvwXx/RlZfcYYHnGtbTp7oXII0IlEtixC0yyiVfjHCYly+cvaqGtMYJDLtnaSCnxkKxIxspjTnKWGVmC4WPyyYRlUk/CRiyzTFWMBa/E2Vs8gYf31A+T5WuncFZ+Dg8EHw+JztNi0ky62aLIiA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PA1PR09MB7847.eurprd09.prod.outlook.com (2603:10a6:102:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:39:13 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:39:13 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 04/11] riscv: Add support for MIPS GIC syscon on RISC-V SoCs
Thread-Topic: [PATCH 04/11] riscv: Add support for MIPS GIC syscon on RISC-V
 SoCs
Thread-Index: AQHb1IzkvVAhhgduoUqC/AjvZZVlgQ==
Date: Tue, 3 Jun 2025 13:39:13 +0000
Message-ID: <20250603133744.278790-5-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PA1PR09MB7847:EE_
x-ms-office365-filtering-correlation-id: e283ffec-38ff-4e62-91df-08dda2a4070d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7G+r7URRPpk7un3PpsL0BVmmRbqF52lkfCRJlOxSjV8iezLYKo41Am0/Ic?=
 =?iso-8859-1?Q?G2ghtCBgG6od6GSZkG4ASg2967RqIp1wKcwzxGaexcNGCeJC9Yd3+F0wYH?=
 =?iso-8859-1?Q?wpzS3YBR+TCUwW2/k0akxItWOmCsoAuvPMajbEu25xRygaymyahZeeJBoq?=
 =?iso-8859-1?Q?7ArP3exrjIq90hBKavylevW3UuNaDkpd09K7i1c6JznQRaW04Mui/8+ejw?=
 =?iso-8859-1?Q?8Tzhi5B22OlVzK5nhnxL7BOlRBM0HhTQFwKPaIdu2P+MqDcr1VSY3mAjju?=
 =?iso-8859-1?Q?poDXox2NDtZvxNn48MJbKXq0tAILt9YYsjo9Bd2QRn7uaCgJXN7UCyw4oo?=
 =?iso-8859-1?Q?McWxByqYq2w5gTglOygFytPwLCeJFA+y7N64/LYgTBV7CR3rvbgBUhN5dg?=
 =?iso-8859-1?Q?JZ0RxdUkPzTdU8f5zZsGfjPUXZ5/8aZm9RhOjzHktPsCSJR/ILUrQsCUSz?=
 =?iso-8859-1?Q?8LweO+zz61RC4mx9Jv5tHunClkLLxlAP8rJ/gWnSfPg985HHi6xY6rCsrf?=
 =?iso-8859-1?Q?sMFY1zCWBBHMs6BSPrObMgWqkiIvM3Uzry9JDv4xRwLFOL2K4yXdZzs+b4?=
 =?iso-8859-1?Q?+pReap9/XJ/AYcaMFpICczr5pyOYgtAiSxSgXAsyZIOjOFUGnpRdW2s+z5?=
 =?iso-8859-1?Q?pLS7zzXhHkUFRlXGqerQ9TqnKiU6yyvCRLQnRX4e1lQqbR7iYhg48hgMwB?=
 =?iso-8859-1?Q?9mKoLpNos8uYbkzXdnwEJfmjGD/Q653LzaI+TVfi0JqNNDG3yR6NATJBKm?=
 =?iso-8859-1?Q?BUKasF50bQlpvrNfM4KpJj8ZQzM7DZ9l1Wh7nUtGh+8KaHirquolnDAvHt?=
 =?iso-8859-1?Q?t060Ca081nPCX7H1ah/i9HwGtqhgGdRCfyyI6LutMRRvTb0XSRPxyJ7che?=
 =?iso-8859-1?Q?CQ2smsrOyg4p9e47eks1+zN1hFMSC2sivMqMCa7caRO8629A6IaFS3hMBU?=
 =?iso-8859-1?Q?iPrderuXWyEtYrg21xdfx4g3Y2pBVPkLR+ylFXCZ4102p0f50VLWCn4r91?=
 =?iso-8859-1?Q?ZVQz5j9+m7T3tonp5Zc3jM+xJsTGRoW+rHNHxmqZd7qpwEnMkDzO/my4JL?=
 =?iso-8859-1?Q?XD+Tri5j5Hn58Tn+2oOCG6t/fIQ04WR7WvvrhIyJ9/kXDvhi/vBfahFyEP?=
 =?iso-8859-1?Q?IZrnqtPD1uGhuhzLDl03t+Qf60czuXlAKRyPgZHuIMNmq4KbEGh7vjLP5F?=
 =?iso-8859-1?Q?GmjvzJAjoBJn21Z42A70A3etlMBIR3FH1ygEVUy9NqygaUazllz+90N85V?=
 =?iso-8859-1?Q?hg5toU+K6jRAtQZk9khpVdluTtcmRbngpDei8Mcxb2FclG8ATTSNj5MOWX?=
 =?iso-8859-1?Q?s8gDnXYUUInXRHu70mF31TdZBe5AsQ/ipYBeXlU6GPftmgRVgXKAjhyqOL?=
 =?iso-8859-1?Q?6Lyr/sdlFmLhWL9L3j+0zQxYPAJDQP06/Mp89Wiqk0F+lOIdhhS/n4TzCK?=
 =?iso-8859-1?Q?hsP83wt5TPkamtHCDhmBtzvh0xI1NeSyz/V3pl9Anah4MWTz18R8HP4mTk?=
 =?iso-8859-1?Q?MxOpkJ7gxX8r4FJTDWAijiaekucHNd7PsMJMxItlb8aQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R8xY+6dw+iQM0TEFikTVe5voiDO9We/nJIu0UjC5TNfXmstKZc69mHAYo2?=
 =?iso-8859-1?Q?ek22eCcjGYJny5DwWvS+MZMx4ej4XUMGr7JMfFx0D/SIqd3EE60aWWNaa0?=
 =?iso-8859-1?Q?yBGRoTY/J7zYuwF4iUX63QOihz7wHYWZqz+juxZDmZjQjBEMdG1wiPNVVj?=
 =?iso-8859-1?Q?eJpCaOT9aUpnj7ekOueKSpd9r7SWEzrukCJ7oe5XcahI39RoD7ci1vuhJq?=
 =?iso-8859-1?Q?4HlJY6dZ65UJRlPSEovvjOfidEy1zgoYv5xaiJ592ya0xDZgxxLLvqye5D?=
 =?iso-8859-1?Q?HcpR4lFRDF7mxfYUf8zFOit9yegFLYvyKIFaY4fqTmj5u0Q4Gus25Ebld0?=
 =?iso-8859-1?Q?guNW+mV2/FjOEYwoZSyXOEDtR+zNNkUrLFZ6u/FN8kIw9dH5UCWrUVOsrL?=
 =?iso-8859-1?Q?GBFJM4RNVhIDkG+4TuOAwrZQxRzqenR6sNHd8o0DVaq/5oFFgeTZSxIQqg?=
 =?iso-8859-1?Q?eDrbXD1OMqolQ5uTRtrlMiSM/bLvct9q8gOc9aK0WkFvSTRTieeRqVfd5T?=
 =?iso-8859-1?Q?fZ2Uc19C1BCfN7LevspFGf88zxdBiNAsunb1/WD5NMHnZZUqxGaYG81tt+?=
 =?iso-8859-1?Q?BuePb3FwpOG0S/MKYrVPQWz8Ssy8L5K5TXZ6Y42C21XI5sy019l7yGLIRo?=
 =?iso-8859-1?Q?RnGNRD86pRDHYiZ2J1R1yP+C9vyF8fPRKTFCcjoRcbTiQl9rX2vB9u3cjf?=
 =?iso-8859-1?Q?IWQJiR/6YSuBsTxGu5WTkKEMxmUx8S2KX3F+D0ULqUmv2O93hOdHhWiNr/?=
 =?iso-8859-1?Q?uxooixD37WpNWK2NqY+iTDMdsVXYbjeB9+UJTJptdop5c4nZAwmBQ0nNSv?=
 =?iso-8859-1?Q?hjKbN1rFdXw83vuvpLLprdPcnIK1tD48dw1TTA6lOSyVdX/uA/3gfGGmdX?=
 =?iso-8859-1?Q?ZEIw8dtCnm7OUB9IjeQ8c+mH4c4d84h7vgIDT1xpbEDXHEU3epvtH7lNcx?=
 =?iso-8859-1?Q?DqUG08DJx6gWg1/MfzZeSqWFk+8QTF5WQPw6XlBWmAQYSW33ihwuxpDe7m?=
 =?iso-8859-1?Q?DwsqqjKAxKVz1JDix4pEHVQczOBMsnxp+JlLJnmYmMcKHpIQsljpvfMp69?=
 =?iso-8859-1?Q?4WQ7qEUpG/yl5ZkCSieLzkqmk/cfHTatNRQidUKT7kz/Ie150MAlJRMtfV?=
 =?iso-8859-1?Q?Z/jWQNkzgjlA0TL/jSyJ5c3GQvfSErj7OHmZoA4pqB4m5Hhuntvob9ZZpf?=
 =?iso-8859-1?Q?nnfC2x0rgUUM+sOUubbT72JvBeGmAhkQwEtqWRi89QaGUQ0NT2x3FocIZL?=
 =?iso-8859-1?Q?Cl0SXyAdW3eVhoi99Wk/HITvK8kmMxVUsPftXA/Ao2Fz/xyfco56385jD0?=
 =?iso-8859-1?Q?yQHQ+gQY6WO522/fWT3qvcpwx7DwsBWhsVv3UBEiZwrltRCuEdeM66kVbn?=
 =?iso-8859-1?Q?hW2u0hBKzxwafieNVEPT/vda06VgrJo2BHpS3J+XGZ0iykESvXYN5IzxQt?=
 =?iso-8859-1?Q?pxZPBpJ4anz6smyIrFiKktBC1g5vJjlpNYceB86KkU4Qbdd+DluzEpxCkI?=
 =?iso-8859-1?Q?0byoe/Fl0TC11mzGXOzX9ov94vC5imU9rB611LIkUSFZ7Cs9qtxtMIMlpE?=
 =?iso-8859-1?Q?ZpVJW3kMHFCv/8ytii23JtbvNPZG6i3Ad8PKoswZux+hHakxRURMmBx+Tr?=
 =?iso-8859-1?Q?XXRVYKJ333vZHAcncEVgezZ0vEoRbQ5DGlRGxv9VRqddFvyYZjWdv7Ig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e283ffec-38ff-4e62-91df-08dda2a4070d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:39:13.3034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoOj7mEO9BEYa3dDdO3GgERxI7T4Q9PHn0vKNkicRNzXXs+aMD8lnnyw/BruT+9SSck21FXOiZbI+yp85P0GZ4/rmomjxfATeu+U217MrdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7847
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

From: Chao-ying Fu <cfu@mips.com>

Add basic support for the MIPS GIC syscon used on the P8700 SoC.
Enables access to interrupt control via device tree matching.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                  | 11 +++++++
 arch/riscv/cpu/p8700/Kconfig        |  2 +-
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/mips_gic.c           | 47 +++++++++++++++++++++++++++++
 board/mips/boston-riscv/MAINTAINERS |  1 +
 5 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/mips_gic.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b05e0622908..aada4f4061e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -385,6 +385,17 @@ config SIFIVE_CACHE
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
diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
index 0e5e4c9eda6..223130d5443 100644
--- a/arch/riscv/cpu/p8700/Kconfig
+++ b/arch/riscv/cpu/p8700/Kconfig
@@ -8,7 +8,7 @@ config P8700_RISCV
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER
-	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
+	imply MIPS_GIC if (RISCV_MMODE || SPL_RISCV_MMODE)
 	imply CMD_CPU
 	imply SPL_CPU_SUPPORT
 	imply SPL_OPENSBI
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
