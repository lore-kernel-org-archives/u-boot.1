Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B47BC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84DDE84A91;
	Mon, 13 Jul 2026 12:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UQ60peir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CAA84A91; Mon, 13 Jul 2026 12:31:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDDA84A52
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMQu7yVsEFmh2I5XpwJZq3LcitvEwFpxpvqazNZArqjyjRCqQnT1FXVQBbdn56HAHjsdUGLlq1O3Tt9XRiPu4Aj78G4O8M6DTW6DP4dcIJyYgKfMg5XpkR2ZeSeo0w0A31vj7Wor0N3f7MHnP/3OMuvwJgNZsi8XqNZ6Hc//B0SMFW3s6PzaL+elV3zBl59FTG+/NH89bfC22l3s4/B0DXNPFkFZVenq9N4BPwWSV53iTB1HQE+9xhkH9Z3wTsbVjrxoDY6lmVLiEvYp2UA3C6FNdE7+maMrr8a7+4uEuU3ll4lawLUKzRXPovrnYVHtWlyqazm7ASr24vmSmtx6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyPKAsxQWi5HWlYWE9vNOcpP81KH/P4Ffbqr3e+7iUo=;
 b=vA3BqN1uDq+a+0iRsP94qR6kEieWy06e51hmS9vGp968EjfqqX9IigLECUM3sKHCEGq6ErORqV71SS/5WxY/U/XcjElvXvXLkDdow2R+Sf5jVbvLZqj7NjCGS8J0V/6UbJZPV4schZUFGsyOb/mkcTUyXlU7kBlbseKWErjOK8czAwDA9CyygXjjQSD/ww0zmUEjSSE5WuLCokkIWndqVKiPgc6l8/otHtC6+Fk/y1Ki6dbTPt6YEoITs/T7b7goPz98cDKEVoNh0oWbKepmEk5ARRJ0qkd8G2Famz6iJ3PYZmYN26BeYedYpY+her5pqdHt+S+0y0iBGIcESoDr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyPKAsxQWi5HWlYWE9vNOcpP81KH/P4Ffbqr3e+7iUo=;
 b=UQ60peirfu1d2h05rJyMb7TXlUqmLwIt4ki/sIdoWLctawmEBn5KjfiswswBAdp6pCHC++XufEX39XeF6hfPU8gABm8mnwOABlg/yYGzAUBKjOSRu04z5WfK8IDwsS1HvsdO2z6si5EIkVBUYPlzz/kSkL4c/tG9LbbAYT5vPpqGU/kCQx668bLmXCrsx/KNVMUkhBAm8pp4ATfL4PliOnC6bJXzPGRN7ni9ayHL5lLdcr6zOTUKOB8ubAMhqw8p5ZxTuGT6ghzdgugi1HLsQmy0jBoTCohfEGS1v/sIHZPBA0mNpZDK309/i3yNDdJMemelM5nf6Ol9Sp0QXGG9yQ==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 10:31:44 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:31:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jacky Cao <Jacky.Cao@sony.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "nora.schiffer@ew.tq-group.com"
 <nora.schiffer@ew.tq-group.com>, "Steffen.Doster@tq-group.com"
 <Steffen.Doster@tq-group.com>, "alexander.feilke@ew.tq-group.com"
 <alexander.feilke@ew.tq-group.com>, "Max.Merchel@ew.tq-group.com"
 <Max.Merchel@ew.tq-group.com>
Subject: RE: [PATCH v1] env: Fix compile error for envtools
Thread-Topic: [PATCH v1] env: Fix compile error for envtools
Thread-Index: AQHdEqINARnpMVEBj0S9fvVbX43Nz7ZrP/Jw
Date: Mon, 13 Jul 2026 10:31:44 +0000
Message-ID: <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
In-Reply-To: <20260713083141.2772971-1-Jacky.Cao@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|DBBPR04MB8057:EE_
x-ms-office365-filtering-correlation-id: b5986e8c-d266-462a-fc8f-08dee0c9efc4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|10070799003|366016|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: 47RzsSJCPkC2BK2ILbTA2UhAhyPAV3msoMNC1ql2XDxTCo3HZzxmPX/zZzl2Udgdl0gsxYhal9LXm+cnkL9bedK9FcIUwi1yPPkxhdD6pYsywLtiZKK4a2tfU0Jg8ZNZQ5u+I+9Ia9ZppzPANd5xrlCLzRr+Jc8v/3HIfJyoJuOPDJIGiMYUVMsltDIn1M1Glo40GO9jbO4uUMLsxo6Qx9iGOeAd+YChyI1Q9ZYx6ZCnU6v9biK4Dz4fVVfUiErGptgAyRsxT8uBybfgH3eDn2Yvj6haRzSy5vWFUzsGfhkTUNjWpabnx/rXP//IIWJmq0dACe9LXXFVWfebdrk+zaSF/23fO7VhtcRGbjYv0ozjFvE6Y31Q1AypJiNf/eNNAt3YWpEYR1tt9NJAiu6hjUMyulXDHvkskeUFUMq3hrPtsRsKHeX90Ihr8rbh/ENo1MpfbmOJ3zWQPteubkqSsdt6DWriexNz+zvLthUSRZfzxx7U4LhdM81WMfHHHjO4aDYXmqzwW7rFpkhp+UhSfXUkS52wAhopSkevxOpyauEVuHiQ3AlIDVs8BmvDTpnw9ZYkxZlZkJmgMzy6L8NXDEvxpWDVKpTNbWxWk1Poc2cSpO/+GtH6xKmvFpUP5W8cB6s4M4THOwOGaS/9ej5mkISm16wTta9xFQwvvFZ76N3nn5a8ztLL2XO3h6CzUubxPagSl0oytS3j4O+IwrDuNx0SJeE+WuY+yUGQ0kjIwBo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7l8D0iSHAYO1PET46XM8oiOzRotxxpBvhrY6NwemG22a7m3whDaxQT2XEZpc?=
 =?us-ascii?Q?/57lgxGNXmkH9n8J9/P917bXwJpKYqAexz88p9z5hWhX9XQcZKGT5bk/xhA5?=
 =?us-ascii?Q?uVv7ro66YNqXq72FUPk39O4/Q/v2rYxk00QowNxea7FgrpqUVHrTZBHbRqTm?=
 =?us-ascii?Q?QKVAUYXxMlUyyavE5TmcNRN+navKB4v0F4qfGrDEkB3TGdTFEc7m3L3zevcb?=
 =?us-ascii?Q?ofHrZ/lYTtIr5rqAPF7tiHWCjCYcrkc8xfAzBQiSfZNxh07BxB0hLna2tUWq?=
 =?us-ascii?Q?BGsWWR1N1JeTkj+bfAFEtVBDOv937QNN63oxtMmY7LZp3MkGlzX9JbVzMd/h?=
 =?us-ascii?Q?1vkRXrzBVpmxhqF0GGRpJksIN/4CPeqTdRgaQi49UVVc2erCqIv+tZwkE0YU?=
 =?us-ascii?Q?A4v6KZKv25kk4FshPgfS77iCb+X25k1ekhEIWx5XW6ykqwL9k4uS0zt8FUV/?=
 =?us-ascii?Q?4qjIvMvXb7gifTLYnC6Zr/9PK3kaJep7D/krTS7Mk1z+8AGp/wq0r1DXSjuZ?=
 =?us-ascii?Q?rH5yeeKkx9pQiZXMKUsfzmzdXzZLPTVNx9uPy6LcBPvL0drdauDHVSuV4M4U?=
 =?us-ascii?Q?LI8saV2Ix1sr0JgOGKGRNnUMNW41vjp4w6ar0hiZ1GA6rhRBM0FMQvpQIdpe?=
 =?us-ascii?Q?uP+9p8mgM3/CSG5rXxERvzqo6ufwrYlF/pTMi1VWhsGGhkeC6k+zalDvHa4Q?=
 =?us-ascii?Q?K5fgToi4hP7FecgmohJn0GsT33YFkekhNOUdIWpjUaoAemL/LOPWhv3DfF7O?=
 =?us-ascii?Q?Wmfj1nnBztDrVmB77tA2nMsM4azCBYkk2qYuFPs4iHxGTCzm5QIg8f0UYx7u?=
 =?us-ascii?Q?GrOF12Fuup23LGrLxzQtqSLH4l42Ci43JZNxdaRH6buXCmcECYM75rBJAtaL?=
 =?us-ascii?Q?6813SiaiuPqpq65Zuv7PYnEIc6A+erqsKBUsReM6NV/+PFZFwt9qj1SVB4Qi?=
 =?us-ascii?Q?PbrR4d3u52gYJjHRMvJJTs0IYIhADT7fDB6YsToTBGPG/oXmWo+aAI7YnzVR?=
 =?us-ascii?Q?E7uM2OuRLv9GSDeAwqa6HBkyW+8KMt5u+mpC8op+PO199KQsECJtNqkc0qqC?=
 =?us-ascii?Q?lNfRElwBpjmQNhH+OM8WuPuuGoncrKfPB776VhKSNC3LO+AG0+D6IPItq7Or?=
 =?us-ascii?Q?rOBRcKwJxzXtWF9xmub9lVQ6+L1mQPmBxFAO6hSj59pvmXhL3CwtiHHBE2WB?=
 =?us-ascii?Q?of5hiwqd+08H7Kn/BjOArr27JKEWBUD2nB6XZPG5OvefrBtVWyt2ShZMND6V?=
 =?us-ascii?Q?L8D/V+7YH/hithnMPTXzc3YVNTi/xVcS1mr04nRpLcCunADiRhyCz5eZEirJ?=
 =?us-ascii?Q?n296z8FM/dZdZUn4ZDIz/Rnfxf3q+YdErqda0LIEXSzfZ058SBONvZfLwWeW?=
 =?us-ascii?Q?8Md94eWBKGJ7vlidGMu9bWz0Pk4e7+b9tolvNq0XnR9Bt7vH3CiwjQQBhAXo?=
 =?us-ascii?Q?3TtxDdU7irMmZ/30fIufMcgk9NK3ifELTXwVlW0jEIn586qU2A/mnW+h9/qN?=
 =?us-ascii?Q?dEW+tipyG+IQMtMUb/EwKcgTKjI9bffbN2ctDStvGvxmkZ90EUEi1ObL7xiC?=
 =?us-ascii?Q?xIOetPt3xtFQyQNNtM8l/RrV6uI59Tngx7wHnlNOdZ4ivKcBw8fjGZ85DUJX?=
 =?us-ascii?Q?I6rJF6MZjaO9cMDzRjz+IkFOuh8QoQSzd1y8Zff+rZPLvf90To2hvo66H7oq?=
 =?us-ascii?Q?4t10/ELCOJm4+1FkbpRBtuCE67elWjsQVRoQ7HpX8899mT3sLzWKrwqLHc+F?=
 =?us-ascii?Q?MYXl22X+SkoqC/ecibrftEjQBnmXdAwzTQ17dtmJYPVzGyfxU46f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5986e8c-d266-462a-fc8f-08dee0c9efc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 10:31:44.8329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwr9CkGloOA4CezKLfrJ7e4tgOB/LJAjDJg7dKnB5gj9J9iP6NjVaUtjoOaJ8qgnF+jv52nOLLefKv4HWzfP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057
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

> Subject: [PATCH v1] env: Fix compile error for envtools
>=20
> Following error happens when build envtools for mx6qsabrelite.
>=20
> $ make tools envtools
>   UPD     include/generated/timestamp_autogenerated.h
>   HOSTCC  tools/printinitialenv
>   GENENV  u-boot-initial-env
>   COPY    tools/version.h
>   HOSTCC  tools/env/crc32.o
>   HOSTCC  tools/env/ctype.o
>   HOSTCC  tools/env/env_attr.o
>   HOSTCC  tools/env/env_flags.o
> In file included from ./arch/arm/include/asm/mach-imx/regs-lcdif.h:16,
>                  from ./arch/arm/include/asm/arch/imx-regs.h:371,
>                  from include/configs/mx6_common.h:21,
>                  from include/configs/nitrogen6x.h:13,
>                  from include/config.h:3,
>                  from include/env.h:12,
>                  from tools/env/../../env/flags.c:7,
>                  from tools/env/env_flags.c:1:
> ./arch/arm/include/asm/mach-imx/regs-common.h:51:9: error:
> unknown type name 'uint8_t'

"#include <linux/types.h>" was already in
arch/arm/include/asm/mach-imx/regs-common.h

Are u using an old tree?

Regards
Peng.

>    51 |         __mxs_reg_8(reg)
>       |         ^~~~~~~~~~~
>=20
> uint8_t type is defined in linux/types.h header file.
> The config.h includes regs-common.h that uses uint8_t type, to fix this,
> include config.h after linux/types.h in env.h file.
>=20
> Fixes: 9f1807e57cbb ("env: add env_set_runtime() helper")
>=20
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
> ---
>  include/env.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/env.h b/include/env.h index
> 9b872fb26eb..dcd017fa5e6 100644
> --- a/include/env.h
> +++ b/include/env.h
> @@ -9,10 +9,10 @@
>  #ifndef __ENV_H
>  #define __ENV_H
>=20
> -#include <config.h>
>  #include <compiler.h>
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include <config.h>
>=20
>  struct environment_s;
>=20
> --
> 2.34.1

