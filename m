Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14691C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 10:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4118283E;
	Thu,  8 May 2025 12:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kococonnector.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="Z60CPwdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CA9828A2; Thu,  8 May 2025 12:27:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B048982162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 12:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=kococonnector.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oliver.graute@kococonnector.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb2MVVo/SAOyeHZ3kXF4La/AxriZ9NSt5ywakhjqqjIbxgQ5oZRjr6ILyfuNeIswfw6WUtt3VfoAqEvYP8rCu7lEAasyiuBEqmLoCQufgQ+FiIWOR+Ug5npQ/S5UT7w+Aj7uHZ5ASgtkGk7IGxirgfF0KxJ8aoOfbJi+2pz3asZ9KuFe87YsYXhZP5Q0C8G6/1GBWVULhFTMgWlQlfonb5XIUQEOSytd+9O7nf9tJzSXGglogzmY6X5uJsWnlrnz5wzfw9A8u0jRZrwHJ/tqcksOe+oJedJFioMbWO8CbJ4Ti42uVxbWZVnMl5AwsJhwVK93HG6I46CkUKznqKm6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfyjDQ9LW2pGiKEiZe9sp85bUHTb/5U1KqFnk0MR9p0=;
 b=DkQCd97NdiuOHkzWyVsMW3ONDCxApV62GmKkGewmyny1xDS3hJEPioLb1L/87R6R6T/4xBo7cWKHG1bABmH8fGDAa/jKazflmUg9AIB9zd0MPvjw2KzHO2jgvQiWIZqNe5urnIgnLqGswhU3c7XSluLOTVTxnEwr7BRnU6DDQWxaX468Ub+edCtpMyoz5BoYVnh6yhJ5HN7YdGaG3q8PuK9S+O0mzb03s+IH1kqjAiHHI4HRFNdqyMIGp1m/bMQRNT8TqXZp0g7nQRo8A7a0QVTPEkRBx+utSL2TQAV1UFTVWvwtAjjkTvf51yrDEa/62Kj09O+n78gov0YsmRPwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfyjDQ9LW2pGiKEiZe9sp85bUHTb/5U1KqFnk0MR9p0=;
 b=Z60CPwdEQP6j5h/TVA+GqYdVXzK/2CuaqQ2MF8VoqYQb8wgeWGKYrfgLDxYJjYgykUThiy5UTBQpuy9VDLSl8bIsijePQ4qQdU0XjT7xmNK9J6ST+bo9IKsVMSpF1PtXQ/tFQsGQcZC5OVZ76SKdiHIUTb/ypVHzTHlawMKrw4o=
Received: from AS8PR09MB6459.eurprd09.prod.outlook.com (2603:10a6:20b:5a6::14)
 by VI0PR09MB7229.eurprd09.prod.outlook.com (2603:10a6:800:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 10:27:10 +0000
Received: from AS8PR09MB6459.eurprd09.prod.outlook.com
 ([fe80::b21d:696c:59b2:f0fe]) by AS8PR09MB6459.eurprd09.prod.outlook.com
 ([fe80::b21d:696c:59b2:f0fe%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 10:27:10 +0000
From: Oliver Graute <oliver.graute@kococonnector.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH v2 09/22] advantech: Include env.h in imx8qm_dmsse20_a1
Thread-Topic: [PATCH v2 09/22] advantech: Include env.h in imx8qm_dmsse20_a1
Thread-Index: AQHbujUrWdnIvyre1U+7pVIxtHeXzLPIkvOA
Date: Thu, 8 May 2025 10:27:10 +0000
Message-ID: <aByG3-3WqbYTpcxx@graute-macos>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-10-sjg@chromium.org>
In-Reply-To: <20250501010456.3930701-10-sjg@chromium.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR09MB6459:EE_|VI0PR09MB7229:EE_
x-ms-office365-filtering-correlation-id: c6befcdb-cf22-49d8-033a-08dd8e1ae430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lRf+k7aJ++c9HuQvFRgsKFt9vZvVoHBJ4+IGC14cgDC3k+zjyb/CRh7bBgZW?=
 =?us-ascii?Q?RBSkEY5wviVkYvwcOt6pGnWh7/fHQuHNypdNfJHullCGXxy/WJ3aULKqln0S?=
 =?us-ascii?Q?AyksRpAvUcuzQBejyool4gK6SLS7dFqb9Dt84Hb77c7pOWNUb6At75XB8FKe?=
 =?us-ascii?Q?xex05Tl8eTvDS01JCV4S8b9o2isoEmyd4zguCcP1f5CbCwkn4mxXJyYGPRWA?=
 =?us-ascii?Q?4S4kgBg+zNtj1u6EJJbWliFkQm/3CaYERAyHpAdtxYDBZRM2g2ii9rNaHv4L?=
 =?us-ascii?Q?mYsO8yRBuBnOAhmVQw/SLBx8ZO+koAGz8wqccR3Wb9lnAOpKHi2ml8qLSzK/?=
 =?us-ascii?Q?pP+sCzqfE57jv2kPtfuumOzVXi3masZzD80gEnOKkTYooT4sBF3UyA+Scg84?=
 =?us-ascii?Q?51OrhyJKuI+u5SgkjJOHsZ5rmf3LVXeoYBPKWzEMbpp+caNNU7vnXMvOrAuo?=
 =?us-ascii?Q?VqJD8xST//vTowmuQuBjeliX513ZcFbanWaK4ORGl8OMch22JAEmSo8kGSfU?=
 =?us-ascii?Q?UMqeBObQgXS66B8wp/uBZzStRnL7NijuBbjwYyH0N6eJrKk/kFsIiSOGsqg6?=
 =?us-ascii?Q?x1zMTQM3nTNcfEoafdiXNov0/nXk9IFqxwbTcJ5n13k2G8iwvPcoYJ8D6g/3?=
 =?us-ascii?Q?Lupv7B9rZ6Fnt5WGbAH+rRMW6IWKOfXXGFL83hTmzrFavx9l2orv3gWtjZ+W?=
 =?us-ascii?Q?jvndrucWuab2eHORzySy5xYYAAV5+kxIc3ka1xWcQMDY8H/UMtXQn5hOSx0r?=
 =?us-ascii?Q?AUvoLJ+9mIyg6B24Trdllt0255Qxk5mbac6tbuG+B8pNOpCTsW980nLEuIWp?=
 =?us-ascii?Q?0XdLRra/riJ4NHhPW5YM7mt15ow52dTpy5ZeGk8tSett0Z+etWnaSC2lH9rL?=
 =?us-ascii?Q?XpWAHTqAhLjnuFcrnkEHkLOFcpuvj3eW5EtFzu1PcIpGT09TLvHOt7a0NQ9c?=
 =?us-ascii?Q?IQ3/hHsPCecUFE3fhKJgDbOmjn8peFXFhG2+G98jlE7P6uDt3JpW9hkiQDaw?=
 =?us-ascii?Q?9Kb96pCpzaDZ8yK+ATCeXtfZG8jqBki0IL+sxF2xL821K0WC57ze9VO9at6R?=
 =?us-ascii?Q?2rB9q7GL22qKcRD+CGLBZtT72j8J3Trf/CtA5ylnAgNq2rL/ssrrp9NdbGpD?=
 =?us-ascii?Q?BmWp28ULYPdfdPuzW1j3aWCkEbfsa+3Iww/z79lrV8EDRQuaJUjEhAeRptCH?=
 =?us-ascii?Q?XY3myGruKVnEq0kz2VMdZ1W14CW+IK0IaYMRidwuJBvV8nZUu57U0025CIM5?=
 =?us-ascii?Q?IT+jCrjpkpW7hIASj5yxzuWnX1CIkjSrZu7UZhwymFtf1Ws9vFxV8J3+znl2?=
 =?us-ascii?Q?SGedezoBUt7AQhwTyncxsCiwl/tkgX+GmBRtPqvc2mFqkfyMV/JoJNXw7HMT?=
 =?us-ascii?Q?HKe3LxZXVTnl0ZpnJybZxyoCIq513gbpzb+FNKudLdqc1c6P4S23sgLtwDk3?=
 =?us-ascii?Q?213J0Z9ObdkypTTfu+V4DpIZlsD041zkUmUWA6/60v8TuReWy8GjsA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR09MB6459.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7U59W1epvmPuIMnUeuPj2Tfn+KcwO34ra2ym+KShTKlrDW074bmdZ7PCtoeD?=
 =?us-ascii?Q?+wtfOtg2jAskJsl6NLL2tyWuHC3wIlZqeXyAnE9kbognDyRnPlDpvnLOfseQ?=
 =?us-ascii?Q?niny2MIZvbkdfy0Yn0j8Kj+owxvVD14rQyPMQ3gsjRP9YYfckZNrJu7LQPQH?=
 =?us-ascii?Q?y8n03JqjcTkjpEQ58RGYyo8oKmSodBtywJbcSahE27Vcp0QgZ55mY7pg3GYz?=
 =?us-ascii?Q?7v5If7s2jfASKkIWBLzqTlPTwHHZgRG2il2JEOrpUBGxzl3ShxMKggGnzub4?=
 =?us-ascii?Q?i3/JQaZ1/6j8YzPkajAKis3CUzqjvR3XVEFE0vYIvxKJEZBL2af/xqUNvdrV?=
 =?us-ascii?Q?hVj03CR+ArKBYwgxqFl2lX2DtY6hA2Kj+3QejlYx+CZrnpNiK/8uxji3D/u0?=
 =?us-ascii?Q?MkgvJ14/3q84fPfu3V3ItLlRvh+51LeDZvD6dG8AycwbOJJNQvmC9NEFjZgi?=
 =?us-ascii?Q?58Rq3cuE1KPVmxyrpJBUm3mZ6xVQvN+n39uveKcD0p+vNpaEOvOmOfLNWUwe?=
 =?us-ascii?Q?xcQsFFJlzohoMmWzaGDMRGsbqAxdW3IWXebSvzhRw4QehFkl2XZuTXVmU9Kh?=
 =?us-ascii?Q?LR/GM4X0pgB2ke4zxPMwZ51UiBfNX2aF4yn6wS5YJYzRVpPU8uLUJLB+uH8x?=
 =?us-ascii?Q?1cmuCsMf8BEMuALOs/XZQ/cCBYeIVR3RdHGSyBlUX/Kc9jvNuQQzW2IDBQP8?=
 =?us-ascii?Q?ra1idVhKDOkVJgV2zqofX0SJznRNyYTDFM0a/QXduwojne2c1oaoSIgQPDN1?=
 =?us-ascii?Q?A/8m3b8TaZvmJwl9aHS5vqbgoMghEm6FWnMmcIWwPgwWT8/ZRA7jEz47Te8x?=
 =?us-ascii?Q?UO/iez9UVJ9bptrRKPIytKMuquqq7in6xksgf1o9jc5zNsvf00v/9Z8Id+IS?=
 =?us-ascii?Q?g4RY06X23LVf+XCLdbSxylUVbr7YyYPhLSalpdKjjNiOiWeJqiYiw6T/A1j1?=
 =?us-ascii?Q?kBDCZ1bk/YmIXJQrvqW1JfKAUx/3/nyuuLzdc/c7xSwM0wpu9/D7vWBos9t0?=
 =?us-ascii?Q?TxCUc7QfDNv/YQc2O9VQjK7LEKBNXUklP0mMUnjHkOq2on57Lbi7cgYQ8Nvl?=
 =?us-ascii?Q?Q5ANds8wQAi58pTHdO2PeCC1EXxl4U7PI5Eplix6bS1/TLnXjMSY3+KDayCc?=
 =?us-ascii?Q?6d4Jft8YP/9szttBNfShZNPCrtXUYa4wk+xPU/kD+O5PFyIq41kkZcpeCUbt?=
 =?us-ascii?Q?DO0hONR5eyy1S2MbueDUXPH02HAQxIC5I9uzwGVHQY7MAZ/uXJbH8gMCg7Dr?=
 =?us-ascii?Q?ucrkq7Sg9ZbLVkh6dlYGmv4+jqS6nnqrb++vpHBZBX08sAi6La8GUSngIaSJ?=
 =?us-ascii?Q?odxn9IguqoYzfXu4/V1yynYduXTGnYzMef3YuhxyefsMMZkwJLbX9eAfSdx8?=
 =?us-ascii?Q?IiLvOWJt5+CO+auKnyr5FaorbDt59eRkN/w8iK+8vG2pTub4q6H5MXMkvtMy?=
 =?us-ascii?Q?cvfgN4VrRUVW3vsdgk7u0p3exM2niHduK7pNp91g5WsVCUBFQOud7JZF8jvi?=
 =?us-ascii?Q?ws+nTcnskDCnIw4l0vVxdwzgdA2cBwRnDMbFitKCkb8GIIHHQRCk83Ko+59M?=
 =?us-ascii?Q?aCMCS/RV+cXM94CwVp0NooxV/UqnV4sJi4m1M/fVIzPJLAzjP2+UGZNc00BP?=
 =?us-ascii?Q?DEpKyPaC+5F6u59n2qVpxpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <012CDFE69E081D428D56059B13F8300A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB6459.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6befcdb-cf22-49d8-033a-08dd8e1ae430
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:27:10.4534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NERirJoO2cR5t/WSt1X+p4E9yD2mLEYrRU02WQ3aEtZ9c+zVmR23j4VwAOHzjBmU+LXfKxVfwVPWUEiUGhAQ+JfZfyFEwiN33NJep59/nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7229
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

On 30/04/25, Simon Glass wrote:
> This file uses the environment but does not include the header file.
> Update it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/boar=
d/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> index 50b35db5f6c..accd300df04 100644
> --- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> +++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> @@ -4,6 +4,7 @@
>   * Copyright 2019-2023 Kococonnector GmbH
>   */
> =20
> +#include <env.h>
>  #include <errno.h>
>  #include <linux/libfdt.h>
>  #include <asm/io.h>
> --=20
> 2.43.0

Acked-by: Oliver Graute <oliver.graute@kococonnector.com>=
