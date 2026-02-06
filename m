Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EA0EE20A2
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBC583A64;
	Fri,  6 Feb 2026 14:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cb1w1qDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7CA83AA7; Fri,  6 Feb 2026 14:27:24 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E3A8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkkyo2CgapQ9f2aWbd3GVl3lQDRGYwZHgKldajRWuWGdx31eBQmm259gwaAu8xyD5xRaharcJjQyQzW4WHU4RvSeStiFDykepSydx9gaZDvG402pyd4cEKIBlfUAbq/skT/rArbuo4gqmrXWnP33UC/XXFyV82jevDREXHqH7SCyL8iBQb+QNX8ixLSXwpkOHhJQ3jvB6YWb8U3lM1GReTtB4l3gKp17MUik6gqH0cVKJuha2WR55LzPfvjnqvWnmeMmO3ByHhtwmzEv92MvTs6GhyOOKSal085Gg+EVTkQidf4fWZQQggJSS3gJNEe/p/oFoOxXFSzQPF99/X92Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQha+qL29cNkzVs2tZ4x52Xw6hGRV0NVhnOBzHrlEzM=;
 b=mFlbO+MbSCIcKmkIvuuj0Sj/xBfsCdLIQrEzVOB5i4+bOr2XfhZ9A0dgER+IqBeYR8hRNdW7Ai5jBo/y7Ah9HZaOVwRXSH0GHbHjx/V7SRfhjGwUyCzQEVBfObj4Zt3+z52okqW+cqkfZ/gHzdCfa+qHgNCPZyi1nv0E/B3xOIWDJSzf4gdXYMx7aKC+EvSyV2/7PUD1Xh+wJJAkIN1pMNq65BVXnFXxH/OwuDJPzMgLAxTNbJ4WNMo/AzkA9S7i6JWWj7L9H/Ixhekf95Fj9ZIJ5cQDWE7AvEMwJtk5XsLAn5xpAwMqYoEO+HmJOdlBdYs+GR510v/jufOQpTzNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQha+qL29cNkzVs2tZ4x52Xw6hGRV0NVhnOBzHrlEzM=;
 b=cb1w1qDjjlT+I+Mo7JxyYihKSfDamzX59vNboa5Apn2T0P3B2CUAZY+GYIx2bWWVPcVxvrWbf4cVDDEbfbN5gPGIZ7fSh/LMVRzT/8DZcbA1ohaZ6PS5S0EM+nFqtWKiH5FS1edzX3MnpWUUN8BhvRcTiz8O9PBKOkaVd8/OwCKPZHhiwhfG9+doJWG5rCZcwmJzwGzorImbfu0PrvBGtMFx3yExUM0j6aHgPU3UOgEK2vsOdHO/szBWM16ScL8btCXpMY67+IBlFCLnJlcyyE7yX7kBlE0soxZEvLOABdk+aNoGRTAKRoE1EBJgpEXc6ugaSkN72Wm9mfXlw14JHA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11055.eurprd04.prod.outlook.com (2603:10a6:10:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 13:27:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:27:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Thread-Topic: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Thread-Index: AQHclxY7y3vq5T+jjEihB2v1cSDjqrV1WQMAgABQWBA=
Date: Fri, 6 Feb 2026 13:27:20 +0000
Message-ID: <PAXPR04MB8459463458F3A45EB0D0F0158866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
 <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
 <20260206083548.GA17806@francesco-nb>
In-Reply-To: <20260206083548.GA17806@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB11055:EE_
x-ms-office365-filtering-correlation-id: 73fb0b5c-69b4-45b6-ca22-08de65837466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IXW+60E0RUHwEem3u/cFhOBnaPsiqKRardF1cV2ClbwVfWXuOZ9T0zjH2I63?=
 =?us-ascii?Q?tTWAv47e6ZFSJ8AKYqD5C/rxciqaJdV/XtVMTwnXsl69fV+iRYMRBGaW2iLz?=
 =?us-ascii?Q?p/wdcEU/eZ8XpIvQQo31QDXu6jXbBzmcK8nGf+6zDrcMeOdV2NAgVvg0ZZfj?=
 =?us-ascii?Q?auiD369FVdKUpkxlZRj+0DwHLsPS0B5tdkUEvc0xSv9asi3CTxnkEVs+MjjJ?=
 =?us-ascii?Q?NrpkFcy2MhtgfQR95RVQ+cYjXwrViJHmjmRMa9z+WnNjA50GZ2v/En3oN/Pp?=
 =?us-ascii?Q?P3P6hKY6GabRINsX5EBK+nYuk+Ex3+5Vaj1HgBw7bqixGiGXW5/yaTfVhdme?=
 =?us-ascii?Q?xI8peTkepej0OmhKvmL+UVcENBfQf/gnbq8Fy3vWMnpBx/q8Mzsvva2GR5sg?=
 =?us-ascii?Q?CNe5ja1Rsv6byK0iTMxHLcuH9Sihdu8w5fcP+hDOgSikDKZldA1qf9EJsSQU?=
 =?us-ascii?Q?SOGWbOumKI7G+W2oqSE3MrLSrODMIEAfRwz0fdSWp+lZHfb2VW+ttopedfIT?=
 =?us-ascii?Q?pr3qQc5cO2NgA/vS8SWWuGxndvfGBD5uj2LflGWhSpsBAjaN9ms8CmlkD5AX?=
 =?us-ascii?Q?A9amzxRCRWlz4hRB/UtDTfk/VsJc9Oa1V/o4RRXxthxMZXKDkoHk2UySlmL4?=
 =?us-ascii?Q?OZbRRJWFEiIxb+2JH/T+Ejv/JIjTLlStw7caVRhwUOOjpUcukWkcVUXlsXzS?=
 =?us-ascii?Q?AfocRjy1oBq6JIfa9xSnNlzlM0w/wBhd46uyTwAqi6J59wmNjY+2JCn3p+gX?=
 =?us-ascii?Q?10mkTHv9JR42ZJkFp9iTjs3cQVdyTJPnk9yZe4zd6nw4ljSZYsVnCKJZWM5j?=
 =?us-ascii?Q?MJ+jLWhPl0rSTy7wRVt1y4CLT0DZ+B5rshC4SFkwZpgiAu2pKWX4WkmgeLqo?=
 =?us-ascii?Q?98nPb5VtLT+TWR+CtH7kTDEAtxiPmgwqhFn8JS/FHGop6lulKdD8IvGfTVVM?=
 =?us-ascii?Q?oBSKYDAhGN1XWATOQk9Os22Zfvb9em7toPwk3tXRcKfRSWwMOcRH7yxh6yVI?=
 =?us-ascii?Q?3vxiEHEPwgDFoYJ2Updtha1F85uxmtSGQ6dBZwNUR2a1Hat6BeDwegSmFm/z?=
 =?us-ascii?Q?UKPoOh+T+/2K+eh9jKd/SPqqlLxwv0NWwHp92OYtd4gwHSGAztx2rcAtW7Bo?=
 =?us-ascii?Q?mp6hn1rGYsC+lWaIcf4JOU0Le1tJU0nLjGe5dfc2n8GwVrwFSOVSNzqHQK6Z?=
 =?us-ascii?Q?Hen9U5IjWm7aPcpO+TuP9hgpFCOz6zQpOsJ9JvKZY40hbeBuNPw6Wu7G+zx1?=
 =?us-ascii?Q?HC/zYubAvilkIJqc3umRsAJFIItNrCmLM5hCx40ww3JnHBlb42lA+rIn+Q30?=
 =?us-ascii?Q?iDQrBdDB+ZRqBNcC7/Lmn/SCc2JulAK91/eOMBXKpLinCu+oQAV+G5XfdXlL?=
 =?us-ascii?Q?rTlJuXgdq22/OwcjLrq4R/hQAEUT3vHNxiY6LT9RvIpbsn6gxDY5xiqnoiA9?=
 =?us-ascii?Q?uj842DMlp9LmTqddxc+o/se5AMNWkPV5IPRtvtX8glmfryLEvg5DMrLPjzrM?=
 =?us-ascii?Q?gxdz3RkW6bWJMl4UnDEdvIEmzsea2DdWX7gZ+TLc9MO91r2ZLunlJvZB9v5j?=
 =?us-ascii?Q?M4p70qYUxX7m2c9TFhthjufYp/HA9tBYDXV2svzRGCIy8V+R0q7y59tUz8NZ?=
 =?us-ascii?Q?3nJR0vx53UlG0nLuYym8fF4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqcZ/AhC6zIYHJKiw91DX1Xco9RW/cPusC93d9+rLX1C7IZdYsKc6lFdS3fa?=
 =?us-ascii?Q?E02GtvmsaoYhqojI5FhbHyODm4btGW2WTZcIJ9xLyowtbhHpgUBS06bT7DqE?=
 =?us-ascii?Q?AMhfe9FhOBO2gDKbUwPO664Ub0iNrC7pY+NlX5OcToLObMnYSvGw9Nyi1z7C?=
 =?us-ascii?Q?+DqSR92UDVPAt+BWhNkKh0a9h6wMeoIUQstOvAh3RPgvEUDb8aSQCcbSSJgq?=
 =?us-ascii?Q?shfgUdzI/g9LIcsA+CmnBq+2coz9Iu5Slj/2p4+rSxRw9ZV/wQ5y1IHJ1cmg?=
 =?us-ascii?Q?SU+hfE19I1xT9LC1Ni1hRRQZI0olBVsE1FmU9DdiBC3BUix57J9dPWwKMtro?=
 =?us-ascii?Q?g+ektm6hs+s2LY0vkq9Z59TgsvWIsCrgW5E5EwiDw0WQqqmQXvVKsguWzACV?=
 =?us-ascii?Q?qu+WMk1ejtClV5hXIToP3LpkhsaH/iIK1OuoZNpOHp39pU82f4RfW2MFWxOy?=
 =?us-ascii?Q?iCcI19Y9cVL6z+WdnSLdK1KWN+ygBh7PHlNA/6i2sOMLEEH4TpcOSeLzXZrz?=
 =?us-ascii?Q?i+QvrKszlqA0WtX7IiWaPYnKQf4yvdTlKj2dT+DxEv1EoD8Y/DtiM2fwTp3z?=
 =?us-ascii?Q?7VeV2jBA/15NKqaj5HvSNsXCriaaKyNMPnIePnNPpQeS12mbY6RjF7zm13w1?=
 =?us-ascii?Q?t6eMuR9NLRffrBrZhUHXaT452k63XtCbASJryWQKXJUk0XbntHpgHDj6p6xB?=
 =?us-ascii?Q?lCpkO5rlAvdIvKFcF8wl3MXs3oo6Y4pmbZ9JAwEBGtwbTqOM8YxVJ3/eIRPB?=
 =?us-ascii?Q?MEur5/+Xo3yVtFuAdzFAEYoqIxsY1ipxRmw6/US6hbJWkuP8bgZmKO0ZmNni?=
 =?us-ascii?Q?iycx/xriE3aofx1Jytvehc4IeS/A/6TH8rpTDiez268do2NQIFUpS41aD6x5?=
 =?us-ascii?Q?5mZOFrVdYoBm5KV8JVLOs+ZunPW+q6sWV48t9xPmgUBbO4hAA7WcTzHT/Kpj?=
 =?us-ascii?Q?QoLHmXdioRqRw30mdFBbgiW0rQE6sgCrMkQ3fpvvhKD5BB0JtGcPeQLbjYb8?=
 =?us-ascii?Q?iRogfz9kY69BPslwX/gfTut4mVBBhxsYlrNQDqa4ypovyHj7RByHTSxYKUlo?=
 =?us-ascii?Q?ZSRzOkdQBjUDEgSnOlRRlzJ5YMxDfQQ50rorgE7aDSV6oKO9E21HgVMq7JOj?=
 =?us-ascii?Q?gT2vhPi37npGp64xfMdZDTkTlE6koNnWFyXDGbf4t/jsDgwI1oXu12NXUEhn?=
 =?us-ascii?Q?a0H55T5N8yKkBA30zpRBN1BPIMrBOR09EM91jz1EnCFNnhYb9gpKXXjdy0qB?=
 =?us-ascii?Q?Yk4J6kevIlmxRASdhC5qWVNlnDy48wJidkEjFRqT8XaH45Qis0/EkluO38K5?=
 =?us-ascii?Q?r2cPIryBGQ2C9v0zmxn0B6/ohTg3DXa8xwac1u1ehJpNO+BqFV3Soxc6vabN?=
 =?us-ascii?Q?/NhhQu3ZlcETjKP4emHBd/Xz2ld91nzMqHHWBpfgOqYD/DdmpKEuz+98e1tu?=
 =?us-ascii?Q?whtBBptKq90SFXYFQC878ngklJqkpZbwrYqvjqHI5f2s3rz12efGLGdM6aIE?=
 =?us-ascii?Q?hAoUwqn07cOIz2NRfUNnEHnA0IyCmfyoOvrPOJEiLsc3RbHghMMWvZBRnN4K?=
 =?us-ascii?Q?7uWfIOqKe67lAZ14CPeg5Rf1wGeEtib1IAliHINHozvMaUSXE8UZoyM9r+W+?=
 =?us-ascii?Q?olC9Di1cukcOUetAAREWFEuy5PWsFxJPSy2of6MZhR0bq4WGz5QL6XwNTSnP?=
 =?us-ascii?Q?XfaNF7RpAxvj38YFnZeseUtnqlu6DrnT32LT6mxg0/psmlTP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fb0b5c-69b4-45b6-ca22-08de65837466
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 13:27:20.1181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YIHECY3bIMGo26Dn9kBzIs3pvFRPKb1wrO+r117FwkzIEfaOeFKnRNrX7tc7d9KQsf9aW2F3SuOK4KDnMfJRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11055
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

> Subject: Re: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
>=20
> Hello Peng,
>=20
> On Fri, Feb 06, 2026 at 12:25:42PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Rely on serial driver calling clk_enable to enable the lpuart clk, no
> > need to do init_uart_clk in board_early_init_f().
>=20
> It seems we copied the same mistake from your evk on our board, see
> board/toradex/smarc-imx95/smarc-imx95.c:board_early_init_f().
> Maybe you can just fix also that one.

ok.

>=20
> And I see init_uart_clk() called in a multiple imx8m board in U-Boot,
> any comment on those?

I need to give a look and test to see whether it is safe to remove
the call to init_uart_clk.

My previous cleanup patchset also touches the board file. There will
be conflict for Fabio/Tom to manage the patches, I will defer
imx8m init_uart_clk changes. So V2 is still only for i.MX95/4.

Thanks,
Peng.

>=20
> Francesco

