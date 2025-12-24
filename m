Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB20E776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603C3842DF;
	Wed, 24 Dec 2025 17:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="vXwWIFx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E3E84295; Wed, 24 Dec 2025 16:46:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284D884261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhxBb68koiMejaQZThf7QRtNpSQTT0sopRt4+JA9T7JzK2qRsydFAIGwPhxNZzl9PKO08dua/GSEBO74gXu0w4pBjszN7sCPMNxhcdZtaTl2BZ3CBDSy7W186a2CctOwidYLgf9oFVHLbtkd8Jo3LYI9tme308tuNXDxpiJYa9yR4nZ4DyZeZJ2byq0HiiniVMOBr87bXAHFDXna8zb5FoqkcdznTGLTIeexlp0OONtTtbSItxNQyaDHt+CSe4AEFTf1f3TYPMlHIM5Kqc6FboQ8KgBKwsXX0DsK+7KRYQzfQPjT/7AnMZtWi7mg+pp7sP9LD60I8NEwNqUmVcFJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUxnlYURvULOmv2uh9eksMJqLttfUAhTL2ej7kzwmf4=;
 b=h2BFztLY7evP1BYFCjJmWHOQplbXfIaXOaF9Te5vciWPaYQavmz6Y8PAF7tXtuBrmGbvzS93GHkbiyaST94/YHfXT48qsyzpwhT9zaE9rpm08rwLFPkfX3D/9knLpTS09s+vx370Rm1keXHuugdeKNEymjwJDscEGOcue5tZndzjnDioV4IfwgNceObV82vkDWF75ZcSNnZuKzJsobMGimGJgs4Ouqgyn5yESNEI9qpbCws+YndhPebp88k3FQZhgfr8frTlR+HUWb/DixAQHLPlSu7b3W6byxussIeTvd5nGqYarsojwsh1DFGckk+cu4VYUrRPafd4ub4uWz6bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUxnlYURvULOmv2uh9eksMJqLttfUAhTL2ej7kzwmf4=;
 b=vXwWIFx/wqSE9RJoP6IeyfgPFLarlbfPZYCtaibt/jvFbUEGeRehCQHDfmcuUGCVPQxsh1Ztx1aF5q8elR6C41rLo7eQhy36Uua3AhNTi/griYoooJkh/Fj52oFIu9HeDGYKz/pTFwh3t8mX8Nfl4vCVRkznWMqyBCR8/tctmXe6r+ZR6qF+VWfbPytgDnz4K29aogwYRQW1vV8uohRtkzuaKp6Sk+t2cTTn+mdtD8D7NjUW05h+ydBZC9UlzAU6lbCrG6HjPI6HuwDMj5hnx+cpl/T6ULTUl9gmmP58VQRvxVUW+iEjv4GdYeYlXXMzH//dHGpKWkkzgv11kZtp4Q==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:46:43 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:46:43 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 5/8] riscv: Add syscon driver for MIPS GIC block
Thread-Topic: [PATCH v5 5/8] riscv: Add syscon driver for MIPS GIC block
Thread-Index: AQHcdOyA4QBICvxJf0SD8mfYj0PHMA==
Date: Wed, 24 Dec 2025 15:46:42 +0000
Message-ID: <20251224154449.946780-6-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 1f5ba6ac-3d72-4bb6-f84a-08de4303a2e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2MIXbG5Ck8He3AmaNp07HrIfJ/gNP/NX/Su1bH/3y8KcWrJ6QYrEuEL6se?=
 =?iso-8859-1?Q?6a+/oI/PDEJTgOXwjesLm8XkTXNzP7M7nxxduXcl6mSvep26YKReB+kY6K?=
 =?iso-8859-1?Q?X2GXxlxD2j/IoAERZgzy6Jhm08jOCdbiJvekvUWer1AR24kXuV4MK5AqmC?=
 =?iso-8859-1?Q?SAsaJn7pC12nS/C0IbW5OraBwm6v8g33XvoQG2o/dcTF9m7DnjSocfIT9G?=
 =?iso-8859-1?Q?RPqCVfTGzvqPZc0KD4rP0nCSaDcUu9/Son5KcjchMKKHAsTVQpw6+2LKea?=
 =?iso-8859-1?Q?0BpMHfP+DIwXwGxAAarRp873HilM+PDHhuZ6MrLflI6jaZIJhE1pkQmf3M?=
 =?iso-8859-1?Q?91N0Ff4D2Tq7VV0SJdDk5KTvWtN/HRTdPxbOgDYEzyVm+aovPghvvePBMR?=
 =?iso-8859-1?Q?sDXlnsUhjpmKx/V/jKHXStgiGzQpVRrOWa0VNP3QVscSkyz3agBXmbfKZC?=
 =?iso-8859-1?Q?rXERdtaUapL5OewBXbLKx/FPbRHQCd0qrswJ0zBgNFaoQdrzwB1jfjKYjc?=
 =?iso-8859-1?Q?Op8GvPDDB0MRaWSBU0XVe97OI7plmDjWzjMjwgBK+hh0qXfZ4wJ3v0icnA?=
 =?iso-8859-1?Q?Ay7S28Z9rdID798EpUO/TedbmtX2kW1B0kOYTDCYyaIfrHI7rLo8ZQAM+s?=
 =?iso-8859-1?Q?4Zx16i9JPpmjEPqxFIKtx8nH9R9uF2mSdydJDR2zFOUcmwPGRIFBRJ6psn?=
 =?iso-8859-1?Q?4Kh6C6sJqg5zsQsYlXtvX9fE5AA24Z73tE7hKIKPssD+6EKWNVxNxX7Av9?=
 =?iso-8859-1?Q?7bwlpLB/6veh3x7Q2mxhPeen33ghq06yNn58XUhnapXYXkJ3o11YeY69k8?=
 =?iso-8859-1?Q?7ATNmcLKmdp/Puxt75cLAfba5ulTUt7DBPVbyIHOAgMnOfdz01CjTGnqfF?=
 =?iso-8859-1?Q?tai2Fn7cXV+nQBnCZ+6oTv4qrnu7NqGrZOwFfXeLlYwR5mNTO50kSfSlgu?=
 =?iso-8859-1?Q?lpXiOMkX0Q0O0kUXF6nPDvH5JC7Z8HsZS9+myL+8Pl2cCXbOdwWOQC+v/K?=
 =?iso-8859-1?Q?okW4YGdNKCD2VMS1X4gnUFIvXerIVnDsisLnu3fPGPvR45P+A7s7pX1giT?=
 =?iso-8859-1?Q?T5/4+eUiQq29Bh7DRfeP3oBT6eN7pXVXq6sIW2EOTlMPG6pNEdnLRioej9?=
 =?iso-8859-1?Q?pRDkMAph5FKoLNbviACoWBQhMp6s2WbJRLGvKYezbV/t9dgzfv2skDdm/2?=
 =?iso-8859-1?Q?ak4f64fKKTwRXI9cLEPy9I59CAnOMpY/VjonFobGtlsoMGbox1UTMx8KMH?=
 =?iso-8859-1?Q?O6e+ob51CudTYm91f5oTM/Ark0PsPiBB18BFtXhJqRdlBT9LUHv5PhZ5Z+?=
 =?iso-8859-1?Q?e4KA1IsYEmlpdHPEuvy13seGyKMdEaMNWX9zAk4TJHS/z0stgHH/Z9VOVe?=
 =?iso-8859-1?Q?zIHV+U1Labs0/Ztj7X2ruLAGd2ZoVkIsWdyow3EAFfdG1IA6zx2+cZzfie?=
 =?iso-8859-1?Q?l4cQYQLeMAsUUQB6WqJ96nxhU7GGhtlShbynCbwZ0P8bsEFEtLmctLkHDw?=
 =?iso-8859-1?Q?wYdkYQ1duKH7Mr/NPoSGcchwYW5BQLkItY3iIilzKXpyGnLLLP0FvNh4k5?=
 =?iso-8859-1?Q?PKto6kWF2nrXISG2maF1RC9d20N6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lMUVtHO2i+B2uc+IgOpC5yjuMKtgvjhhvVKG7DCPpqMnkEtO1gH7pQal6Q?=
 =?iso-8859-1?Q?3qTpWmLmo0BjqSCM7iJ1qshbRdrPYTvNfTo5WEoQODn65y4KVrLdumtniu?=
 =?iso-8859-1?Q?GGrZgVtHbPXOanyTKM0i7ODvP4/aTIgKbBjIx3GIc8T5QlVbPkUVgUUY6X?=
 =?iso-8859-1?Q?geIEzO6JFFIiVW2226QairpDUvkw+GPWdbgf0fP923dAZjo2dtYeOq9fMl?=
 =?iso-8859-1?Q?9rY3N3FyuNeu5rZr+hEoVsl6QROTVdJ9Gx85USm4+orwBfGkynlGOJqEZ9?=
 =?iso-8859-1?Q?Ve13lasaUwJx3LOdSIaLCpodNXOWFaC69asF+uccinCmb1vlpAPFvusPcI?=
 =?iso-8859-1?Q?IBUGBLhiLX70Kk5Ad1RsjhDns1pTxIGq+fEf19npDhzxFYrTjqxKNxvB6k?=
 =?iso-8859-1?Q?HR4XlJb8b2l4CmpuHOb9jhxKXOobOXtD+q1RyJMMCgO8vLt68HQOGVfkvj?=
 =?iso-8859-1?Q?VhzaYzZySM5XZSIrhmtkVwvlLGeHsTdhxSNqUrFHoT6MTbyo4efJh5xl11?=
 =?iso-8859-1?Q?esml2wNRRnVkJyiI4ETb3F67uMAxUHTJe3sn0eEoZ3o9GHotiE0Z3tLA6P?=
 =?iso-8859-1?Q?hgq/VLczmFznAREDMXYHbl/1LpfqfvXihi7w+j0Y80FAsSJ5lhA8wuSAZ2?=
 =?iso-8859-1?Q?qCRKwsPRFRFo0jqu0Ji4q1RRN1ADSoCXDovdDxXMpi12eWEf4y84fuFqcN?=
 =?iso-8859-1?Q?/yzg+kN7pHzc6srmTGT1aLwQ700TZG7e1N1xy+h8qZOo+MnsN4gX53hKAg?=
 =?iso-8859-1?Q?B6SF8bjpsvYFp8f4nshn6BqFBwkxIQePkGg8cPbxxBN8OrHJ6lp2u9DX4Z?=
 =?iso-8859-1?Q?QAPL21nJvHSMvvP6CAAAQ+Hm3Ir5yVW7F6dMlbQd7NQXiGa/FCWM5e+9yO?=
 =?iso-8859-1?Q?j2H1JrIR1fkMBL8nb7bT21GK82YZY1F7jmRurMTshRSLcgv6YwCUnNQoVR?=
 =?iso-8859-1?Q?1UDcOunxKif14lEAV25b5J4nSvWzsvX/wDgPzuqewQfn2zq+iX/7pP/hpa?=
 =?iso-8859-1?Q?Bb6fgasp1S6hl9tF3rvyxYqSO4+LVfE/hEJMfwXzAbJs82dmX3rmUkkp2a?=
 =?iso-8859-1?Q?Con8MJHOFLFr4QVFhDWwusrVLs2Gn2Wi7awn6KhC2ewBcYJxx30WWzjVh7?=
 =?iso-8859-1?Q?kg+lVZ3mfPyUvvcsdhRXCJJ81zYNNXM1j4UcTKSal1+hYgMDFcimubx5jo?=
 =?iso-8859-1?Q?njXfis1os7iqln6A1QST5ms/lMQREGYdxgT0SSJNhZh3BtuCCxXMMtk4r5?=
 =?iso-8859-1?Q?2NXda3ezXugq14mIMmUb7MgO1aJWsW15SGsch9fYm73jCL+W7fshHdCbwb?=
 =?iso-8859-1?Q?+bW3gRrlkFJtdedke3OdrVvo3uZ92y8Yt0zUOycRQxogU7o1uEaTXRy+zH?=
 =?iso-8859-1?Q?orQI9ZxTcbFx1zCU433x1nLUcSgIhyty7o4PPGbOOXtIJ0uAbD1Uf0uSdU?=
 =?iso-8859-1?Q?URTKe+kY28mVxW2e6fTRmjNP9XCUtUfvAVJcpT7Bp6JbmGKzJ/KIiuBR9k?=
 =?iso-8859-1?Q?JBkJ8IEAIaNVej3Qx6rIMigZB6nurd36sBgRDKaLBMwQ0ypd3pyWmPvC1h?=
 =?iso-8859-1?Q?gN4WjzFxkMPGe2s5Z3fOHlmEzotrbOyYzLrebD631oc+rROLiF2Mdz2QmN?=
 =?iso-8859-1?Q?kTExo6uSth+jz66gutk+u+mEs/XJNChwrLBxUcaUVAvebqgfsUn9XrNkJ1?=
 =?iso-8859-1?Q?pWS6SqE7yxuZbnr7J49pC9M1OFZ0GlN4yVFbe6DLJp87QZMAicsUIYX0iv?=
 =?iso-8859-1?Q?H8AoGHCJC+8d5CDI3NEgjEwZpA+STrqASmMPm4hdEKssYRoqwmon7S+YQM?=
 =?iso-8859-1?Q?bmDcy/rPZA5kqjMBmUOjHWx4OlQ6zD0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5ba6ac-3d72-4bb6-f84a-08de4303a2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:46:42.9957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHXV8krLnRZCtDVvRcDylJanBxDmCfZcLsri40DadE3bHQWYKvb4z73LlWUclURrgu86mc1Kc1R1bL8fhi13Es3HFAK8MqrmB7piN+Q1rro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

Add a UCLASS_SYSCON driver with DT match for the MIPS GIC block, so it
can be accessed via syscon/regmap.

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
index 8eb12d4eb4e..8436c4aaaba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -407,6 +407,17 @@ config SIFIVE_CACHE
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
index f1f50918eff..d4f845d9892 100644
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
