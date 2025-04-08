Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B74C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51793831FE;
	Tue,  8 Apr 2025 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GQDsy6WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8253F83211; Tue,  8 Apr 2025 09:04:34 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A958312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwrvUIH+hgdbog94RljvSaOiQc+kFVtRKJ40kJjrKrI2gUgWDSgi/mwBt3F54LAN8zXabl6OTV8HpjrZxsTQG3KTVQTaWFlL/0KLyd7LeR5oj6Ni6Ghr2cfwliIX5ndmyadeyyFQzR/r9xh6qYbbQE3dUJCJv/wjme4ZQjwZJlFfQOF2NCfFV0unEwv+peKmxXveCk0VexKCYhH+grzkfKym/WSKjni1cW3Hv0jwkqmBUbmIkoWR+EJRW3W9bnDM1JYyX4XScusd3O3xOU2E97EGIl0KN4LuHcD24h2uVLzaVlHPWR+H9TPN/iUrb4C310qX1r8aO4uYZpuc7Tt57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWPVuQkODe4oQJnpiK8JsAsmhJs/ubVaC11MYsJC59E=;
 b=PjillwvI6gvGA1hvBzSpwyS47DD7MUWIl7JRIc7KZZkVS+Do7Bdk9MqEXTMubjMe3z16hRG2Tp809Fvh0tuSjktU6ITy1lspdUb0mLjbp9ZvageUPI5vuxJnq6uq3eLTNzzzf+TQ21V3vO0d2v7PwK9FyAYgNLJZ9naIYHO7FQoz4uqBgUWpo3fS7bxz9vc8L1GDysFucDZQ9t0niEdUhD6UMQEsLCzYfJTxgVjwj0heCuAxOLq8w0iWcEoE9KMsLRcn5d92DNjpTlDZDjGvx+PcXdrw6Ec/CXLccKklHg2xQDOuLEx3o6dFptw6ZNIR3CpT/WwqQGWNABFkptgvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWPVuQkODe4oQJnpiK8JsAsmhJs/ubVaC11MYsJC59E=;
 b=GQDsy6WUxSbSDUadxh4jn8b7L5+ApzwOWMT7PBLVT58lrKEL3S5YAdQcqDKOVUipED6VuauevXIXkBtXjP+bpfBOBgw4HpzPOIVdYcu2I88gv7spzMWzgaOaA5qYCLLKpPhxGOGzMS78FhI7mvlAlZguZuobB14JOA+BLrsNLMvFsmiCiTM6LKzSxMfk0Y4Z31gJdK4RwQcTd6r5gVDjl3dwxk8MHf5O4jv0vVt/VdXGz/rbIHgzXoFKuQ22vXbDOx8W9Km5QUEsAvNSP+52VVWP6cwV+dBEZEsIiiL9xg2E4AEtWty6Dg2IpNvAN3lrXRIVWYqv3EDQ3mV8tqW5Cg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5205.namprd03.prod.outlook.com (2603:10b6:610:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 07:04:28 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:04:28 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1 2/2] arm: socfpga: soc64: Enable F2S bridge reset
 support
Thread-Topic: [PATCH v1 2/2] arm: socfpga: soc64: Enable F2S bridge reset
 support
Thread-Index: AQHbpQZI39kCfRYVK0+bEAOi//zlR7OZXtVQ
Date: Tue, 8 Apr 2025 07:04:28 +0000
Message-ID: <LV8PR03MB81370745A39BC47BE770623AA7B52@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
 <20250404020703.4261-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250404020703.4261-3-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5205:EE_
x-ms-office365-filtering-correlation-id: 9ee814b8-c796-449e-f1d0-08dd766b9ada
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3rB58C9mkEXei5TNYAsP97E8QaM+Xl4KYpbJNS3Do/yMU7MKTPS0sghN29Cs?=
 =?us-ascii?Q?UHxwXEX56kFhe+hZs6gHVP2+Jglon3gB2D/56RXZtAzQ/VLC0s8ic/mLbMqH?=
 =?us-ascii?Q?kb+q3Hqtv3gliPEe0oOZw6YydzUhB/vRCPq8ngNS5jWwF2NWmeT04DjwdTP2?=
 =?us-ascii?Q?oi0ElGlMkp816Xpc29SI4UX7vuysQX0CE5pbv3GRUSupJwivKEu6Qo53uaTO?=
 =?us-ascii?Q?e5PbXgzKLBmWNyXChHn41+hD9/0GidUD8Cd6y1CZj/ra39uB0VL+NUzdJ6kx?=
 =?us-ascii?Q?PJQQa0cqwN55gtEeH4fG1tZxyMNY1NS8Wh6JLzzfmp5WPG43I/9tC83aInma?=
 =?us-ascii?Q?kNKqoX5w5vlhdypo1rBy5ezH1dVW1D36bOWiABY+tN0VN13YrM/Xx780jEhU?=
 =?us-ascii?Q?dOx+4hRdpe3yAfTczUI7qK92ov62E4lmVA3vrVth7ZiUF877k6YO7xgfVnRa?=
 =?us-ascii?Q?pAgfwO667AwSmjlKhG6ffNYMy3BwHK6dhTfvrpwz9h65kUgfLpksiS39m2E4?=
 =?us-ascii?Q?c+xl9fBJLEB0f4XjP4VRZdJqb6nA3FGQCvX7EtwUJXiI5u/QW2M/S4bsHokt?=
 =?us-ascii?Q?qynDB05K8tuzTh1j1lafpmKXogigp/CpDX+w7P5JaMohZU9+m7tK6r9n7aEP?=
 =?us-ascii?Q?kGhRyvoCCj7+4pHVxmOI5gpZyy2mkuZDRK8HqkfwZFj3PulsHHjDb7RfEKvU?=
 =?us-ascii?Q?JvvIP2Ca8ANiF/WRlHicBD8AnMPCxis4JOHQOcbZhFWYeqLQAfVxq/JMLmnM?=
 =?us-ascii?Q?mxElOpAwA/2yJAS6RNpO6kVzg9Ql31V0xyJ8vo/0CaUSFelbvhWqO1bMqzEf?=
 =?us-ascii?Q?bhV6w7qKgp3GRCZfqICZBbQ8xzLKmDOdRh/Dci6AXad+NVJasMTFzzPEEylG?=
 =?us-ascii?Q?3upzYNT5VU9XHk1UjDZvbqwP5BUPqGvcpGou/xI4lmNFW3oChz1LpCU4oyn6?=
 =?us-ascii?Q?J3cW22kM7o0kPKA37MXJWnXG8bpIHpZ06sU+HFNflldjOGr4LWjapagY+8nZ?=
 =?us-ascii?Q?yBt1aWXdZo0eAcWgzGjE00h2u3ESAPWNstmRSgaAkdRBjHZf6ScPmgj5vGjZ?=
 =?us-ascii?Q?vqaxoW+q2n0umSs/Wrg5rGdspU96vzHOU9mcTUCiy13RzhnRd9weDuJTn8It?=
 =?us-ascii?Q?ybydXhPDYb/Z+9RA8D2zkkBHr1Wlrwwb1pk3siYoPZuJh8+zTyO8FmmlJlHB?=
 =?us-ascii?Q?I7zEnvSY6ppNw4GE2TmC2CBpgbhYp8A0c612ELXkXEqClB4/+8miwstPzB3b?=
 =?us-ascii?Q?BG4pZcMB1zaSdNmQlyUKc95TjvGCB/bM3Lu09yIuBW8N7Y604Kmu1eS8TMOq?=
 =?us-ascii?Q?TYc8CQWObc/18U3DvYZsGQGKqPU5N10Vz9szCYEE1RRGbPri24kNdHYn/WQg?=
 =?us-ascii?Q?0rXffyxdKCbEX+FhWfIA/09F8dkRVO4SNzxHkTv/KrOrvO1s5jGPNQSw2n2V?=
 =?us-ascii?Q?7g1FNbQNWko=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ncpH86V2oUdOf88v2wOS+l3/yEBOiGE1JilvsvrEs11bA7EHgw7Nqm8RdA5?=
 =?us-ascii?Q?ENwnROLRZiv2LIpXnkUlYaTv2ahf1BHL4QxBTxwQFMXyBWtOS3hYuzpYsB8C?=
 =?us-ascii?Q?WZnOIbu/W0ScKTqDglZa91YIASw21adPyJuJTCTznEMR6kwajS/QFQxrM5Uq?=
 =?us-ascii?Q?oeCErWBJbsbiKq8O9IsT1k+9R79WSBh3RrV1LZ4HE6EhtH8DT1TCedGsgxO+?=
 =?us-ascii?Q?x4pXDHvdAXpUqEqOXXCDK+5tnwejRDTXFwWZc/Vxnm192bmg5YYFX59T/vh7?=
 =?us-ascii?Q?RDlwtzTWJzI32l9SwF3HSBWV++EvzPy1E4jNZPIR1ukfasYlTJohDuKUCtj6?=
 =?us-ascii?Q?O+9y3YnqUHViOYfjWJ8z5MUDPrCbylYyujGqbUc1Ej83SqOLw3VsZ5DksC6m?=
 =?us-ascii?Q?YlvHYqSy7OTKrIANSOPXkLrNb3YhwTOw05mTbLqkFj5qUCx4uNR1ldWk1mJy?=
 =?us-ascii?Q?+AyuIiYmcQxm/auG5Ak44zHT5CACb3FLhW9qp4Je4WI2pQ/bpKZ7BBPRex43?=
 =?us-ascii?Q?5FukplJD4p3HGGPlGITWohIf+Vgz07ghcwy9L2Y8QfOBcnlsD2xK7mQHDeXK?=
 =?us-ascii?Q?Gne5uRvH1S93I25l68BbgyLmpIPrVqAfe6a4ehWcdZWB27uGavZVueDjSw4K?=
 =?us-ascii?Q?zwN9e/KsNaBFKUNLMczvKyj9xLX1mhL3FoLJ1B44wZzCpCWSKVSfZSdBGmrL?=
 =?us-ascii?Q?yweb2Ew2CUuiFSwH89tHJMLagoARj9D/LZvHJta7GGL9UREWFueIbt13HRQR?=
 =?us-ascii?Q?CKBYY0ASP/J6BBc4lljvPZukeZF05Drh0qt8g29MbTrHx5zLjPhoO7UZLGeM?=
 =?us-ascii?Q?uxOrEpyFfcCXZJDlWFqWVRPLZlKEWpqruWaXuXjZ+b5xj0K+5UDgOiHbONpF?=
 =?us-ascii?Q?L3Z9e0GLkdT802+LokBCkH4tkzEKDgt1Vo72Gsv7jJi71Kj/di1+Z117PDlK?=
 =?us-ascii?Q?6BPomyDaEmN/PROAcnlY3IhkQnvkEU7Y+3HRfVgYaFMWCTzU4Ib5VhmVLHkL?=
 =?us-ascii?Q?9KdvCx43556bjLPPFObilpwaTxUpuoYvb91cOQE/lGyTnjozmlka7bcMfe4i?=
 =?us-ascii?Q?E2YPEtpmuEOFOibp18hTMdb+gXC/xDckz5j5oD7NTD2W0y/ft0DnQW8QJ6nw?=
 =?us-ascii?Q?ShoMzUZRGfKhXVcgwMPJZ1JjjIdCFge4YjnX0+FvGdBJeHNXxcniSqKog5Rb?=
 =?us-ascii?Q?u+p+pDQ6agUWVY+F302Yt49XPgtUyu3JxCuNy+Jent11uaqurtlFLRIOFxAb?=
 =?us-ascii?Q?yG8Zj6eaD6n4NSh0apLAVUg6cKgdk7b38echvuMLYI3aU6DQ2nuYuncnHgyr?=
 =?us-ascii?Q?ZC5BUnNP4z5XXpMeFkpchJ1pg+kbwJHqWHEyPDAc3cRz8R8zcHL6wF+ISJ4I?=
 =?us-ascii?Q?pQKXDTxKIooNUN73E6auP2KUJ+LckfQeQh30uLKParjct28SYM4hpC/Xhu7X?=
 =?us-ascii?Q?+JXPRW+G4+XEQzFDBHQAxuiHj1xT0H7Aed6+73Rt8U2YRolkjyaPNXBOTkJZ?=
 =?us-ascii?Q?72y1V1khrbtonaXyHNyXzvVpiMjPvbJR+KRFQAyx8kd9wNYaXY3zqiyfReoz?=
 =?us-ascii?Q?qmpJryqHWO0b0Rrj+RlQ8eQaM2IyMMMFc0ybZuv7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee814b8-c796-449e-f1d0-08dd766b9ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:04:28.7535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZABN1PVFkpbRO0xAKT1v9QACldmkk+2PRmU6lJkZuLzFoq3b/itAAws+sqyQq+MGKUX4UcoZghlkQde0spsBPWENc9vR8YKgx8lqvItCWeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Friday, April 4, 2025 10:07 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1 2/2] arm: socfpga: soc64: Enable F2S bridge reset supp=
ort
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Enable reset support for FPGA2SDRAM bridge for Stratix10, as well as
> FPGA2SoC and SoC2FPGA bridges for all SoC64 families.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/reset_manager_s10.c | 236
> ++++++++++++++++++----
>  1 file changed, 198 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-
> socfpga/reset_manager_s10.c
> index a634c11a028..abb62a9b49f 100644
> --- a/arch/arm/mach-socfpga/reset_manager_s10.c
> +++ b/arch/arm/mach-socfpga/reset_manager_s10.c
> @@ -1,21 +1,34 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   *
>   */
>=20
> +#include <errno.h>
>  #include <hang.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> +#include <asm/secure.h>
>  #include <asm/arch/reset_manager.h>
>  #include <asm/arch/smc_api.h>
>  #include <asm/arch/system_manager.h>
> +#include <asm/arch/timer.h>
>  #include <dt-bindings/reset/altr,rst-mgr-s10.h>
> +#include <exports.h>
>  #include <linux/iopoll.h>
>  #include <linux/intel-smc.h>
> +#include <wait_bit.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#define TIMEOUT_300MS     300
> +
> +/* F2S manager registers */
> +#define F2SDRAM_SIDEBAND_FLAGINSTATUS0	0x14
> +#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
> +#define F2SDRAM_SIDEBAND_FLAGOUTCLR0	0x54
> +
>  /* Assert or de-assert SoCFPGA reset manager reset. */  void
> socfpga_per_reset(u32 reset, int set)  { @@ -56,66 +69,213 @@ void
> socfpga_per_reset_all(void)
>  	writel(0xffffffff, socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_PER1MODRST);  }
>=20
> -void socfpga_bridges_reset(int enable)
> +static void socfpga_f2s_bridges_reset(int enable, unsigned int mask)
>  {
> -#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
> -	u64 arg =3D enable;
> +	int ret;
> +	u32 brg_mask;
> +	u32 flagout_idlereq =3D 0;
> +	u32 flagoutset_fdrain =3D 0;
> +	u32 flagoutset_en =3D 0;
> +	u32 flaginstatus_idleack =3D 0;
> +	u32 flaginstatus_respempty =3D 0;
> +
> +	if (CONFIG_IS_ENABLED(TARGET_SOCFPGA_STRATIX10)) {
> +		/* Support fpga2soc and f2sdram */
> +		brg_mask =3D mask &
> (RSTMGR_BRGMODRST_FPGA2SOC_MASK |
> +				   RSTMGR_BRGMODRST_F2SDRAM0_MASK
> |
> +				   RSTMGR_BRGMODRST_F2SDRAM1_MASK
> |
> +				   RSTMGR_BRGMODRST_F2SDRAM2_MASK);
>=20
> -	int ret =3D invoke_smc(INTEL_SIP_SMC_HPS_SET_BRIDGES, &arg, 1,
> NULL, 0);
> -	if (ret) {
> -		printf("SMC call failed with error %d in %s.\n", ret, __func__);
> +		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM0_MASK) {
> +			flagout_idlereq |=3D BIT(0);
> +			flaginstatus_idleack |=3D BIT(1);
> +			flagoutset_fdrain |=3D BIT(2);
> +			flagoutset_en |=3D BIT(1);
> +			flaginstatus_respempty |=3D BIT(3);
> +		}
> +
> +		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM1_MASK) {
> +			flagout_idlereq |=3D BIT(3);
> +			flaginstatus_idleack |=3D BIT(5);
> +			flagoutset_fdrain |=3D BIT(5);
> +			flagoutset_en |=3D BIT(4);
> +			flaginstatus_respempty |=3D BIT(7);
> +		}
> +
> +		if (brg_mask & RSTMGR_BRGMODRST_F2SDRAM2_MASK) {
> +			flagout_idlereq |=3D BIT(6);
> +			flaginstatus_idleack |=3D BIT(9);
> +			flagoutset_fdrain |=3D BIT(8);
> +			flagoutset_en |=3D BIT(7);
> +			flaginstatus_respempty |=3D BIT(11);
> +		}
> +	} else {
> +		/* Support fpga2soc only */
> +		brg_mask =3D mask &
> RSTMGR_BRGMODRST_FPGA2SOC_MASK;
> +		if (brg_mask & RSTMGR_BRGMODRST_FPGA2SOC_MASK) {
> +			flagout_idlereq |=3D BIT(0);
> +			flaginstatus_idleack |=3D BIT(1);
> +			flagoutset_fdrain |=3D BIT(2);
> +			flagoutset_en |=3D BIT(1);
> +			flaginstatus_respempty |=3D BIT(3);
> +		}
> +	}
> +
> +	/* mask is not set, return here */
> +	if (!brg_mask)
>  		return;
> +
> +	if (enable) {
> +		clrbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_BRGMODRST,
> +			     brg_mask);
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
> +			     flagout_idlereq);
> +
> +		/* Wait for mpfe noc idleack to 0 */
> +		wait_for_bit_le32((u32
> *)(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGINSTATUS0),
> +			     flaginstatus_idleack, false, TIMEOUT_300MS, false);
> +
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
> +			     flagoutset_fdrain);
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTSET0,
> flagoutset_en);
> +
> +		udelay(1); /* wait 1us */
> +	} else {
> +		if (readl((socfpga_get_rstmgr_addr() +
> +		    RSTMGR_SOC64_BRGMODRST) & brg_mask)) {
> +			/* Bridge cannot be reset twice */
> +			return;
> +		}
> +
> +		setbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_HDSKEN,
> +			     RSTMGR_HDSKEN_FPGAHSEN);
> +		setbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_HDSKREQ,
> +			     RSTMGR_HDSKREQ_FPGAHSREQ);
> +
> +		/* Wait for FPGA ack the handshake request to 1 */
> +		wait_for_bit_le32((u32 *)(socfpga_get_rstmgr_addr() +
> +			     RSTMGR_SOC64_HDSKACK),
> RSTMGR_HDSKREQ_FPGAHSREQ,
> +			     true, TIMEOUT_300MS, false);
> +
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
> flagoutset_en);
> +
> +		udelay(1);
> +
> +		/* Requests MPFE NoC to idle */
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTSET0,
> flagout_idlereq);
> +
> +		/*  Force F2S bridge to drain */
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTSET0,
> flagoutset_fdrain);
> +
> +		/* Wait for respond queue empty status to 1 (resp idle) */
> +		ret =3D wait_for_bit_le32((u32
> *)(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +
> F2SDRAM_SIDEBAND_FLAGINSTATUS0),
> +					   flaginstatus_respempty, true,
> +					   TIMEOUT_300MS, false);
> +
> +		/* Confirm again */
> +		if (!ret)
> +			ret =3D wait_for_bit_le32((u32 *)
> +
> (SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +
> F2SDRAM_SIDEBAND_FLAGINSTATUS0),
> +					   flaginstatus_respempty, true,
> +					   TIMEOUT_300MS, false);
> +
> +		setbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_BRGMODRST,
> +			     brg_mask &
> ~RSTMGR_BRGMODRST_FPGA2SOC_MASK);
> +		clrbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_HDSKREQ,
> +			     RSTMGR_HDSKREQ_FPGAHSREQ);
> +		setbits_le32(SOCFPGA_F2SDRAM_MGR_ADDRESS +
> +			     F2SDRAM_SIDEBAND_FLAGOUTCLR0,
> +			     flagout_idlereq);
>  	}
> -#else
> -	u32 reg;
> +}
> +
> +static void socfpga_s2f_bridges_reset(int enable, unsigned int mask) {
> +	unsigned int noc_mask =3D 0;
> +	unsigned int brg_mask =3D 0;
> +
> +	if (mask & RSTMGR_BRGMODRST_SOC2FPGA_MASK) {
> +		noc_mask =3D SYSMGR_NOC_H2F_MSK;
> +		brg_mask =3D RSTMGR_BRGMODRST_SOC2FPGA_MASK;
> +	}
> +
> +	if (mask & RSTMGR_BRGMODRST_LWSOC2FPGA_MASK) {
> +		noc_mask |=3D SYSMGR_NOC_LWH2F_MSK;
> +		brg_mask |=3D RSTMGR_BRGMODRST_LWSOC2FPGA_MASK;
> +	}
> +
> +	/* s2f mask is not set, return here */
> +	if (!brg_mask)
> +		return;
>=20
>  	if (enable) {
>  		/* clear idle request to all bridges */
>  		setbits_le32(socfpga_get_sysmgr_addr() +
> -			     SYSMGR_SOC64_NOC_IDLEREQ_CLR, ~0);
> +			     SYSMGR_SOC64_NOC_IDLEREQ_CLR, noc_mask);
>=20
> -		/* Release all bridges from reset state */
> +		/* Release SOC2FPGA bridges from reset state */
>  		clrbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_BRGMODRST,
> -			     ~0);
> +			     brg_mask);
>=20
> -		/* Poll until all idleack to 0 */
> -		read_poll_timeout(readl, reg, !reg, 1000, 300000,
> -				  socfpga_get_sysmgr_addr() +
> -				  SYSMGR_SOC64_NOC_IDLEACK);
> +		/* Wait for all NOC master ack to 0 */
> +		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_NOC_IDLEACK), noc_mask, false,
> +			     TIMEOUT_300MS, false);
>  	} else {
>  		/* set idle request to all bridges */
> -		writel(~0,
> -		       socfpga_get_sysmgr_addr() +
> -		       SYSMGR_SOC64_NOC_IDLEREQ_SET);
> +		setbits_le32(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_NOC_IDLEREQ_SET, noc_mask);
>=20
>  		/* Enable the NOC timeout */
>  		writel(1, socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_NOC_TIMEOUT);
>=20
> -		/* Poll until all idleack to 1 */
> -		read_poll_timeout(readl, reg,
> -				  reg =3D=3D (SYSMGR_NOC_H2F_MSK |
> -					  SYSMGR_NOC_LWH2F_MSK),
> -				  1000, 300000,
> -				  socfpga_get_sysmgr_addr() +
> -				  SYSMGR_SOC64_NOC_IDLEACK);
> -
> -		/* Poll until all idlestatus to 1 */
> -		read_poll_timeout(readl, reg,
> -				  reg =3D=3D (SYSMGR_NOC_H2F_MSK |
> -					  SYSMGR_NOC_LWH2F_MSK),
> -				  1000, 300000,
> -				  socfpga_get_sysmgr_addr() +
> -				  SYSMGR_SOC64_NOC_IDLESTATUS);
> -
> -		/* Reset all bridges (except NOR DDR scheduler & F2S) */
> +		/* Wait for all NOC master ack to 1 */
> +		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_NOC_IDLEACK), noc_mask, true,
> +			     TIMEOUT_300MS, false);
> +
> +		/* Wait for all NOC master idlestatus to 1 */
> +		wait_for_bit_le32((u32 *)(socfpga_get_sysmgr_addr() +
> +			     SYSMGR_SOC64_NOC_IDLESTATUS), noc_mask,
> true,
> +			     TIMEOUT_300MS, false);
> +
> +		/* Reset all SOC2FPGA bridges */
>  		setbits_le32(socfpga_get_rstmgr_addr() +
> RSTMGR_SOC64_BRGMODRST,
> -			     ~(RSTMGR_BRGMODRST_DDRSCH_MASK |
> -			       RSTMGR_BRGMODRST_FPGA2SOC_MASK));
> +			     brg_mask);
>=20
>  		/* Disable NOC timeout */
>  		writel(0, socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_NOC_TIMEOUT);
>  	}
> -#endif
> +}
> +
> +void socfpga_bridges_reset(int enable, unsigned int mask) {
> +	if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
> IS_ENABLED(CONFIG_SPL_ATF)) {
> +		u64 arg[2];
> +		int ret;
> +
> +		/* Set bit-1 to indicate has mask value in arg[1]. */
> +		arg[0] =3D (enable & BIT(0)) | BIT(1);
> +		arg[1] =3D mask;
> +
> +		ret =3D invoke_smc(INTEL_SIP_SMC_HPS_SET_BRIDGES, arg,
> +				 ARRAY_SIZE(arg), NULL, 0);
> +		if (ret)
> +			printf("Failed to %s the HPS bridges, check bridges
> availability. Status %d.\n",
> +				enable ? "enable" : "disable", ret);
> +	} else {
> +		socfpga_s2f_bridges_reset(enable, mask);
> +		socfpga_f2s_bridges_reset(enable, mask);
> +	}
>  }
>=20
>  /*
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

