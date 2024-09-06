Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E129CE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 02:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AFE88CD8;
	Fri,  6 Sep 2024 04:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OhUz+R4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1219188CE2; Fri,  6 Sep 2024 04:23:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D069E88CB6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 04:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0MD0Srxr0gYY+nKAHAmgw48TLZDDLLOUgBECe2RsUBp8cwBqYqPqH8ZJjODv/xAIaQW+k5Y5VeyWTaJHdhzqYUPUoeykuGPYA/Aw5RyYtGejsiKbk+aacQJQPOVCKeJ1ipasZyT+od07sz89W67gXNn7MjfKHBVz3/GishFHq6C6n86xmZwp4B/kWK0dy7EMsufOsa3fEXEQKFNgmNtEpCTegVtxGMhKJzi5b54xVvBDgeHK2td6+EMHishvU86ONmNQdPxDhbtDt6XUNEiKHNcQo09Ch7swtDeNHIlKwH90L+PfkssndVYmSzkNUIzJujaLylKO8PdlplYhBkMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daioj2iQTRQ4NKqogvv5NA4L6NQKx3PnsQqHc2EccF0=;
 b=EP1YYaKz7T1dbjeTMVFrVpDDtWv9QdECIiMgxLvUd4VzCD98He85A8vESOOTtQXTGXzCLSgiLldU/cq0S9/Y1tCL6WIkkSA6Y/kvkgnTjzV7C1BVb0yWytNCC8hgeTcCETxDmZJyEj+RJEGibIxdmpYs9eLwWmuTO2sMbv/dpBjGeMF8jT0Y36glh0jbtoalSPlQHrPTMTqTX/1QYjU4V9IjXg6GKWVkIRYuMQ/G24gwsNkZkiQHGFsC/0sz7jNjgAsZQUDkLglVFOXSRR/mi2tE57R7iv7Pmx4ei4HMjvLx1sdrIIFkIXHtTwTthjzkWAVSmK9cazK7VTir8ywcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daioj2iQTRQ4NKqogvv5NA4L6NQKx3PnsQqHc2EccF0=;
 b=OhUz+R4JX5OYqRcjCHIglPj8CaDgsGea/8V5DvkqytSoLr4c3qEJBu8CFwTc5If2dCRtn+CoD5owl6Fpq3PHXEGVxpe1sCC0Bhf7r2qxTbEZ/cO0nl+jFoeOz/k63k8xJBrirgmZyiso+AjBg5FDzJOBpv00KtzwUu7oAWdPAveSRJTsuGW619ZQGIO9sADKiM939NM+X8m51pU8PIT7VbSb+w12Lnd8CcpdN2WLwNRnNyjDQEsP5TORAUkmLEiX+xDNvhPWJsw0Mh8cN+e5dA9BGrQyjZvMYXWL3fFcC3JG3SKNF9W5ZeT+VcjeKTbxJ/wYRZ4jxBMUqcd+HXErlw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7329.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 02:23:40 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 02:23:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2] ARM: imx: Enable MMU and dcache very early on i.MX8M
Thread-Topic: [PATCH v2] ARM: imx: Enable MMU and dcache very early on i.MX8M
Thread-Index: AQHa/6lBoiopGi0NC0uty7MrktrtfLJKCB0w
Date: Fri, 6 Sep 2024 02:23:39 +0000
Message-ID: <DB9PR04MB8461056BE7BDE6AD01EB6A0D889E2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240905153517.24887-1-marex@denx.de>
In-Reply-To: <20240905153517.24887-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM8PR04MB7329:EE_
x-ms-office365-filtering-correlation-id: 05cb6fdc-8fd3-4794-ee6b-08dcce1aebb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3Ebf0y3KszsY8IrVPgj5tP96aDL3z6ohIAz1NCCDfLPPH3fij4gBggEAlJzN?=
 =?us-ascii?Q?MWrrwOSuci1mXS5xyi2CcnmIslP2yWfcKHyFLzY+d2MibS7j2Yfvh9wj8tfl?=
 =?us-ascii?Q?B8rCmZwFRoHam3xn70rjbN9AQbwBtKxRdW3Ax6UO25/CAiGh1Zb1EJxWeZf+?=
 =?us-ascii?Q?SdbTblPHQdyaXMylCeVJuzPulEbKWg0mAPj16EAXZUe/6qLQIv38zHlcY1Pr?=
 =?us-ascii?Q?V3ehllr/GYbcKTMCAK6YGZuu14yHS+Z6UD9YPw9KeOeVHMQpPRWeU334qWb6?=
 =?us-ascii?Q?PiGFi9nHBspOWEOKYvQbYUTyleOJye06MReUXixn2I0qqKUaookQ/A6XxABh?=
 =?us-ascii?Q?FQNUrJT6tkuw5aY/6WWKMD8Re2susGaIRgitwfs2LHRa9nErPMkfN3r/MGJF?=
 =?us-ascii?Q?i/ToS8kQu7Z/6MCLrLi5JCWJDFUumviFdtiMgwL7ouDlLl5utw9mDTPPomDL?=
 =?us-ascii?Q?VcFRLEwUOQmUTrpbvEPJDZdCTlspknSxsuRHWk4RqE7PLRz2kL0jJr5Qv/Lr?=
 =?us-ascii?Q?moZMTC6AwQ7+J6wY/PqbB/S0TPTjvkS2CsuFGYBVY8EHSq0N6tJXeG01ata1?=
 =?us-ascii?Q?ge6vP1LMiMzs5YFi6FX+gnQR8g7wAh7ay9F4Atr2lAEi49POx0dBKO/mc9qN?=
 =?us-ascii?Q?zO0tVmq3POrLxFUJOR1HE2/7LaHXwuzuNGuK5Gj/ijRpgIr9RLP2aK3pztgo?=
 =?us-ascii?Q?tKx3LxTZ+YFfrMJxSdtXdCANIhAZfD8Fau8i3STDpzaMY9xyDAve3765CrTK?=
 =?us-ascii?Q?IALwn5KDOTu0UyOa2fljU2kSbhXW2zXCLaAFktKOWomscdIzzyA9QfiLql9M?=
 =?us-ascii?Q?xf6Jv82dallJFB7CmGU29DFXhJ3JUX4wpqdyz9qvcasfPxGDC9bicKOYsJ2I?=
 =?us-ascii?Q?DvHGrh1tvzVf8hcQfaglMgFMGG0s3hWoc84xhvmAi/SYkKQppzexySpm8d7B?=
 =?us-ascii?Q?N6thsNirby96Q4LXkIcwo5JireKshUBcEqPlqBH3AMwDqmEhSDEhT+urlcq+?=
 =?us-ascii?Q?Xlhv7WJasj3MokHHp/x35KSdmgeqj2bfVRZKUZRYfKilwginNfxfQvAKfPgd?=
 =?us-ascii?Q?tnV6kLUtaZvlU0aGv+sDJa7oKbPIF/Ut8+U58/Ogs+crf/FgvO2ppWi9TB1Y?=
 =?us-ascii?Q?r0AraNnLz5v7fL/kvOlWXl/TBTdiAXaGFp7Pj3mXEBdChm3KjVhWg6uEe263?=
 =?us-ascii?Q?Ie9dN5FQv1r0m7g2us7JOmdOr3sR5SoXZ5RRyZFLocDjc7SYRyZ8HAzEnstX?=
 =?us-ascii?Q?4c5XhUxgJX0z7WhOE1Nc9IRRHwfN2NgSKUjqPjIJ0BNdkJ+zheJ5Fuq8dL7K?=
 =?us-ascii?Q?XEc5A5xhf4OuREIhcpRxwsxW2ikDaTlYcPwLBdI1iE/KmzuX0VbPEOrHepqw?=
 =?us-ascii?Q?QWMVDyan/XWxfxHumN9PECFuI1o0Tuti7wOE9UQUtUnu/Gvrqw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GjF5CYF8YpCFHzMe8AyHOLs/zrAT2XZz13IervY/Nd+asyAThtTrX48YdmPK?=
 =?us-ascii?Q?krbM4E3Zptht2KzZ1saFotZ1K0QJsm/bA/QFwZSlI8j1lpdVIxCJ37d36vr8?=
 =?us-ascii?Q?0tgHnI3o0fe5b0HaX5oQfdkkSD4SNxFYl1CQvqIQR1MYLk4vey/Ew+nWfl0u?=
 =?us-ascii?Q?jZczJ2hE1pYAy+lOfgX5vspoP7J5ecWzUr46XpYq5clGZ+k82mornX0AjxTo?=
 =?us-ascii?Q?6bJpWjFaNHMe+tFQ0KsSgpybYPr6vHSTdKQzeidDTdMDBHE21o+6fjwmcL76?=
 =?us-ascii?Q?yHTSY90NWj3YN4LJBFwloF5XJyT1lqK+qgU3ICxCKLQlks6mTKYN8f0vr2u3?=
 =?us-ascii?Q?C4uEfxa7+2v142lr81eiqJ/Kqe0qGSLLC55a66rnPsG2RHfHSgr/bdw5BGq/?=
 =?us-ascii?Q?iPGY5fE92KgU0w98VC1SlxNTHDCd4dPJAGhJrffJdCKkTUa9bqLbs0nZw4Ms?=
 =?us-ascii?Q?Dl6QywCy5Ev9nuyOAXE954tAlpNal7I0RCee6oNkob0jvRlMpKnch5f+B6La?=
 =?us-ascii?Q?BdEmkwNvKWGPdyo5suA2TPrnypfH7/e08CGp9NmOvXuKFLoPxZBZvyo5f9C9?=
 =?us-ascii?Q?aP7vJw32OyjezA67Aj0PiGWRDD+dmDn7cC5sKrwZVwphrbM/ZjjTeF8FYaQ6?=
 =?us-ascii?Q?SMHsWdaAo/jBvSRyDV+OHGCI4iotTUmlXi4xNsJumsRN/5bcVFgn4k7YQzUG?=
 =?us-ascii?Q?Z1ZrFdERC4ZxfHTqyHchw+qg8PEcIkXRiFvOTbuRlR1FeKXq5+C2MC3/HJGM?=
 =?us-ascii?Q?lKbE1KbIhVXfObWbhvXqj+80kzvp6jl2q0JL9r+mItiytj8oINW5n98beAeO?=
 =?us-ascii?Q?/Zg/FeREgOMfJgrte9QZ7MTDGr/c/U7fIQEbpovu04UYh7vOmGzbmlz5wqqX?=
 =?us-ascii?Q?yh+MbGRW+79IYG5b810J/temcS/hzT/2eFCmqNaNSyD4T6IrcChV4in3/mLT?=
 =?us-ascii?Q?Ptb2AO9JqZA5FV+wUJ/EynZRFFSIC0Tp3BzZFky8ED3HnEUuimsP7bzPK+6t?=
 =?us-ascii?Q?FCy4hO+oSMgdr3hBkiNVFPR/Zz2HRoeogfITpHicii4ry4dCIa+yhLrfZ8c7?=
 =?us-ascii?Q?X93ywQMtoXIJqc60uKzBsSqsULh8+2zEIOxsTtA0rxSN0xCu5EU7ESh7DIct?=
 =?us-ascii?Q?zhEiK+bfZ3mL4d4+jznkxhWbdabuCiQFdZQKjPXNuUrFco9uzwf4tU7BHp1f?=
 =?us-ascii?Q?gLBtJyNvzrn/OEif9WZRF2VWjr7fVs3zm3gZBM1byzv2fHNykBuUqE9N+VpN?=
 =?us-ascii?Q?W66TjUBp+39IpBENtdPAZI9Sr1eIuaZx8TFaV1hyEyQY5D7eMT1BPuElzt6/?=
 =?us-ascii?Q?0d7/cGqsOHUbQ5mCWem/2UgBUn954wIEFEPA5CvF0X/qLyPbqqnRTaBaoRY9?=
 =?us-ascii?Q?jVoEI/huzv/CtZ4YO609DaaDTaJmSNVrb1HP3e+1jv8ZP11dqR4U889ynV4M?=
 =?us-ascii?Q?WtQqGQBHaMY8sYewcyBBW3gzsSlGAjkDbh89ZOON+deOzXZjnc31gpA6cO4x?=
 =?us-ascii?Q?YKKEghDtodh1v+TPUMJBsbHw0kJEEIAo4LmdSPyy0FIXoJrhDMLPhTyATekx?=
 =?us-ascii?Q?rXLwxGTN6EQVBtAz1EA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cb6fdc-8fd3-4794-ee6b-08dcce1aebb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 02:23:39.8617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODS3OUl6be2tcQEUr2mZOPb5Lb+AcYkKLu7vVx6+/vXCLBoaTGSTP71yD2rZTDYdteZV4lrBs6LaS4FeykEziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7329
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

> Subject: [PATCH v2] ARM: imx: Enable MMU and dcache very early on
> i.MX8M
>=20
> Enable MMU and caches very early on in the boot process on i.MX8M
> in U-Boot proper. This allows board_init_f to run with icache and
> dcache enabled, which saves some 700 milliseconds of boot time on
> i.MX8M Plus based device.
>=20
> The 'bootstage report' output is below:
>=20
> Before:
> ```
> Timer summary in microseconds (8 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>     961,363    961,363  board_init_f
>   1,818,874    857,511  board_init_r
>   1,921,474    102,600  eth_common_init
>   2,013,702     92,228  eth_initialize
>   2,015,238      1,536  main_loop
>=20
> Accumulated time:
>                 32,775  dm_r
>                289,165  dm_f
> ```
>=20
> After:
> ```
> Timer summary in microseconds (8 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>     989,466    989,466  board_init_f
>   1,179,100    189,634  board_init_r
>   1,281,456    102,356  eth_common_init
>   1,373,857     92,401  eth_initialize
>   1,375,396      1,539  main_loop
>=20
> Accumulated time:
>                 12,630  dm_f
>                 32,635  dm_r
> ```
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
