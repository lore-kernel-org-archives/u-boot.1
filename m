Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F8CC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B20182E5A;
	Tue, 24 Jun 2025 15:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="NOaNaym+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4423482D17; Tue, 24 Jun 2025 12:26:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26ECB82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuD14QeBjk7fFfXGMhtUZ7vSi0OPMDcnp2RZPBJNzJQ6kcC/m8C2wF1unJkw2NcEFVG2sGPunTVGFgU2CEm1b/zos7KrcCn7MoWvC6zc5qawgJ1TUcuC0A17cyMpCVqjm6C+0uy5So/lBkbwEQdaawtJY2ieXAI06bQEcCHw4hmZoRuSQKC6q2L/vaTSbl02mysXHqyd11Vph9YxIHSAqL/MBP+8pV9e9bqIh9zQUlSF7jCIbaQAcxFp6gaJ7ixt2U92eGpiIUfI2Y3fWqMMRyWmrMwIUWbU0S3kFZgg/3CcbaX7bvMU4up2ibBdz/CIjOg+ccAVjMk9ZN3tRscfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=jQ2o3LrBcwcazxLMD//epUaRCo/g/cc2nxDisvI6ypGpvUJSv0YnygrAbAr1TfUdUpIycl8ixgOMojYwLdn8VEuvJM5R8DyzNqh5dF3M5twRQJ6xJ7qRdsoqUFH9jxUjprRbmCCGeEQb53y8nF+0OTplCQI+mkG+7Me29GYb59W1IG+3WJpDJebJDSbgGTlzh0rHfwxfl2bYElB6Qn03MNWISzTAa12oKetmUpAEK670tbjVpp7LP6hzMwa20Vb/cVafbFM+v6if2SwNn2pJjpLEImlSGRhfUKJ7Q3eiuopWKC9aJDJwLFXleHRqs2M9NrS10eIQgUpkDx1G8ASTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=NOaNaym+7PqwNq3PYLksXypbTjVFOb+KNNRJbjBdKvibUpaBhVnnfb2gGV6PfisjliIu2P7vqgzCiGTabdEorFAZ1l3ncmrF5+MOCwQ327Dlfs/7Xi45A4MixdHxDJawB33yMvClZuxiW7gF/TMTVmZNFV9qI67SJyTg6fTKa6CVdinZ9EV9fy4KVLzzBTiuZzvfH1UpNcXQB0q96FhL7sYrsvWd5095Lr67/ZFU8gm5fMQvmDSKMDGl9DZ8Vmuf8/B7HsFlVuoAHOIWEg1vODtz5aASHEizg8KjjqWugu92y9YWsffqknk0SduW9BjOBMlaV4JWbAQTlVX699QwWg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PR3PR09MB5475.eurprd09.prod.outlook.com (2603:10a6:102:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:26:32 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:26:32 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 04/11] riscv: Add support for MIPS GIC syscon on RISC-V SoCs
Thread-Topic: [PATCH v2 04/11] riscv: Add support for MIPS GIC syscon on
 RISC-V SoCs
Thread-Index: AQHb5PJ0HaxbHtcvg0m1aqIOICJnDA==
Date: Tue, 24 Jun 2025 10:26:32 +0000
Message-ID: <20250624102449.324410-5-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PR3PR09MB5475:EE_
x-ms-office365-filtering-correlation-id: 7951c7ba-6cf8-4ad1-8c63-08ddb30996d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5c4GDdd59aBa5314Ms0HRaQ/81lsLr8sKAaE89Ge+Emmqn7CU0l0WDbiOG?=
 =?iso-8859-1?Q?eIsM8xhc9M3fY38vScSz5V/5UDshLQAW4Y8rlRIvN8Ypsse/8NAZijND6G?=
 =?iso-8859-1?Q?e1UJu5zt/hqJFzm+ZQeBUdL87J6jgNfzN9OGnk+cIhll0O3w4xiGHIPbUR?=
 =?iso-8859-1?Q?d0V3S8Wp7om7r6I7FfKhlid7HAHHaQziSNBAM+98ryAIdW/ywWqgNNTBxK?=
 =?iso-8859-1?Q?jovAeRUTZmAHCdWBQVQlnF4YvWMlXW48vT7adYqzgF5YeWD6IQ4pqvSqvQ?=
 =?iso-8859-1?Q?NlegRA55wGC9KBdUNMct+IIIQcBQ2k7TgEpvqiEneFVU3Si1BLw6JgLinx?=
 =?iso-8859-1?Q?wvnVJEx+S6I8lyrYQgXmdxOu5mdgKBoCpjDHiBTSMkdKrrpJqnSXtfM/rJ?=
 =?iso-8859-1?Q?raFTQ7MCjNWeQoHymL3tzousuBuGZdx2xuFvnmEj1DbHyjVYhsT3byOwqc?=
 =?iso-8859-1?Q?8IwFKB/CFg4uJ0uHr1ifAgNBvlsgcE4mL+HdQWZyWW2y9uTxcwKxP1+yaV?=
 =?iso-8859-1?Q?wT6/Ngbyw6mn1dAtoqTHnWLnXCrdri9eNMfXa2OnY7QqpuQosUsxHgs6TQ?=
 =?iso-8859-1?Q?KM9zkxcWRi9BV7V7D0w2jNXnl132HjZK5WhDRtvEhUPgDaehiBmKle8Dp/?=
 =?iso-8859-1?Q?sEuf7VkKhrlIKedeKSNoG8nd+I7LRs25vRu5glvCZdxeiUiYHCHQhlrHsm?=
 =?iso-8859-1?Q?XDWVaaH0e8f1WAAPrsVmmzD4B2OX7YfN4nXFt8uMttuBnOCVDlEGlQsc1+?=
 =?iso-8859-1?Q?ft4rYyloeBgE4vh+OKOHc7Zx2Ks91tyIUUHLJTcGKZzn5x2lZMneTiI/OG?=
 =?iso-8859-1?Q?yVR8M5z8bd/KtP49K5D3fA8Xmy8RqGzCluSTEe1mLCkSXrDeilKy3WcNa3?=
 =?iso-8859-1?Q?ywdupzQ36eP7QmILP4hPWJ3yizva9ALngIyhC/57tzSK0cukG6Kfb2U9I7?=
 =?iso-8859-1?Q?10+L7y37Os61i2P9lIHTntuPV4+mLTKjPpOKSAQa11TMxXQu8agT5LhtuT?=
 =?iso-8859-1?Q?zm/Pm07SfKG6E0y4kMBHQ4POd2EctHuKJzeVSuQkF2FffTvDWqA+9OUPZb?=
 =?iso-8859-1?Q?Enmy7NnzMgbMO+mBobsNW13X5U/UaWGdt/fUB+QPW5RDMu1LrifmtIBg3L?=
 =?iso-8859-1?Q?CaDV8rnsTjLUL4nqHZuFlE4r+2kpDvIya0jvsjUf/SVYl1JxQ5f54Nr+rp?=
 =?iso-8859-1?Q?r7S5Ba8cBiehGenVL+vB3ADZynH1bFX0cWM/Ox2TS6IaLohe4SYMC2Jwhj?=
 =?iso-8859-1?Q?zqBmrEyf5NZcZdY0DCIjfGkZVr3YKc5/KTObJbWn8jXPeYlqPXjHl2c1XQ?=
 =?iso-8859-1?Q?ud6nVGPuqz7pfOj82XoGCHyo1++im31AR7eed6exNDEIU3ct/qIE/rq3am?=
 =?iso-8859-1?Q?dnoV5EkTi+9pMpTPrry1W+36DWjMAYAqfEDTnfJL9yr8Zj6hr4v1LbnnDZ?=
 =?iso-8859-1?Q?MqknF2z5iSzYXFWEjcXpJfm0VuXF8pMdAQz9lp59xWvqOzpG/qqQ1UHAgb?=
 =?iso-8859-1?Q?RucAkJrm4+QZn7A0kA60qwlm7dHCRjS6Wj02uXkBoXrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ve6b5u66wO0CI6ETrLwJQBUFkNoYUhGYfnGdb8sQj9fzSynlYOe9Lk3eWj?=
 =?iso-8859-1?Q?P3aZaqtTp3HVH4os4n4jXwiP4jFUPteN620qd6XhkOwMINa6VmUd17cSIz?=
 =?iso-8859-1?Q?/OFIXNdd/kAbCfpE88rxpR16RaI34+J8D9nuXuU+YnFJzKW3qogshG6q5L?=
 =?iso-8859-1?Q?iuFzM83NVyVVOcSZ0/DNATF0Ekzqd3LYpv0JjIo6PBJ5d9i+53MhF2fbw2?=
 =?iso-8859-1?Q?G47nqs+CbzFz1nGGn1tVmMzmqZI/4ZiVx++RN8JOBFJTTN8IWUt56AzUyd?=
 =?iso-8859-1?Q?6c4pwQre4wb5nA+A0oD5p+3cdjjwUCbW5AimmPQZ5YGEWvID/DORi7yuDb?=
 =?iso-8859-1?Q?ukaRW2dHkPfJu7myiLMvyFWq5PNKntJLoqbCpvwvOnRgM/gKVSMcKbYca2?=
 =?iso-8859-1?Q?I2K35ntHEoaMeRicclxWOLbNc8RMuWP3gCiespWC2n0e/QgC2J2ochX7lK?=
 =?iso-8859-1?Q?psrn+zSft5erC+jDfPIq8LYfdJZAjTJ4GUmU/vdfGai5vixdPKqdUk75KM?=
 =?iso-8859-1?Q?bpU40/JMNvT9gcEeTOp+uxKR+BgvdQhCPw0KYb8JXm7SSZi7U0wViUI6RQ?=
 =?iso-8859-1?Q?3Ttit9apqVRPSQPYtAoRtVbM5AKfkwHQ5kw/1KfdJuRiE+9GYfTSEknQRx?=
 =?iso-8859-1?Q?L0W/HiJc/mTyR+CPNmWtRJ8/IpuZRhyBSZ3yI7r4850sbQoTig8w8LmiYk?=
 =?iso-8859-1?Q?bH4HsMHLrwdwR/ppYFaPxFGQFyAdxyV/L7pqIBM0BaXjYYt8/sGDuLIj4m?=
 =?iso-8859-1?Q?RFEUe9YmcyBQ7GkpPoQftCAPeKc7qjZXlE6wILPBgAALtJ62tP7wIFDsct?=
 =?iso-8859-1?Q?qAHz0eZN/ddDiRDyPjChUkB89CmhVb0Fc5gMGYx7vpKXm6UNuONmyW5Trr?=
 =?iso-8859-1?Q?AAdnjhcqi+2zDwqJBVkQUK/2r8BFriqek8ApV15H/mBcfqqvcWEEMFRlP7?=
 =?iso-8859-1?Q?9MDXda9jj2agCohiRbGpj+oNh6HNXAE7Re2qXprPz05B3A07R7V4b/OnXf?=
 =?iso-8859-1?Q?T3qMuaGiC6WTeo2DG670g8jEayOT1oy3sBdfy8feNoZs1VAnptAXWUmutM?=
 =?iso-8859-1?Q?YDB/jv/aJaV4kuonb2I8HuQiYHpVagNux5DSYrM7SuZimVcpQri67uUhCQ?=
 =?iso-8859-1?Q?4BazAO9bLJg4nBdhmrgc8T6IjCVPbIx2ZLIg0oTKKItM3TNoIyFKmPwJH0?=
 =?iso-8859-1?Q?2KxzhADTfg488+9YU2nVhoEnyZ+lJWFbF1bPpJ2jblyXGBUmGnffQOJ7ji?=
 =?iso-8859-1?Q?d48XrvnkAy8iuMmoIlbfS0CqCKVhj3n7kj1D5WmOdCoXVe7ZthBTXHVJj4?=
 =?iso-8859-1?Q?k+59oS0mSUWwTg01bpOSSseqT6PV9jPsGcA4TM8fq5TVhG/P79ESyaAOqZ?=
 =?iso-8859-1?Q?oQmTFmWExo4e4JQbIH4HsxtOGIqom7jN4AiDFRYqBMvdwjLBk47/5aWp4Q?=
 =?iso-8859-1?Q?y9psxT85lrEEpPCUrQy+xtCIaqgWXXBdxdAVfaXwuje8LpXJ/ZOrj0MSWI?=
 =?iso-8859-1?Q?1RUeee3+NvUGIy7g9HuBGpYf0VzlMoCOp7+HbZBiVm+4qqwC6Mcd7PcruF?=
 =?iso-8859-1?Q?Fhgg1S5fosoqmnTg4qLZFT20+ypU8pMKs+X5fbQRovafAaJNJtUFzgzsDN?=
 =?iso-8859-1?Q?9kNiMn0X4EvsrMg5lrsmGD99TBWz1EyVeSNic28Q3YGm0FMzgdqJFu+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7951c7ba-6cf8-4ad1-8c63-08ddb30996d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:26:32.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXHB9/GbJFXJvJfgsKcTgMXdmdgHSYqlrHVRPntst5Y9ZOfclklQ7t3hfJfBakvWxylFsOpPqlKBRukL11LVvRN4O8UITiECvUNBic1ZPXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5475
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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
