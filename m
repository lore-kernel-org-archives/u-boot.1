Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FDEFEE4E9
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 11:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA88683EC9;
	Sat, 28 Feb 2026 12:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iu85NzlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C036183E76; Sat, 28 Feb 2026 12:47:48 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A75F0801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY1l0ZqdNkhAR+Lp6iRVrYU2uc/UzRA0uVB/4e0NLdnP4SSdY4y+YB7b2kitcg5y0LYFEit5mrghuASBETXxcU++hemH8tVgb+Z1ysNdt14efee7fZg2flkp0nzHeHYm2WNHGm+uX/+aDraZWjbLfi8pTugbTek/m3x3Vw+3B2WCab5CM2XqIngVo8dxQJjhba2Q69Z0y9tcZpAJIpKX66BaHDhmNjBWT68EmSifOIVMUkuJe33H5YKerQJuYK4+eLby+UEgcMgBOHC7v6NwmTLlkcXQ0oRgnTdl3R2+iBlRNo4vy4QR/rImHOvAYQ4EY+26Ii5Jvu/Nt5QzPMe9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4aFTTMpOkfC9Hm1x0TYV51YSxvBhR88yJahXwmSOU8=;
 b=UvKb5ZlAUWwUstBpPPlFSw3ALfsyeZXlT1w77jhci5XbT7HXZX+wa7feOrUdpZtY26R6GBpn6uS6b+8zchX6z0J4XqLcCyHvVN98UmliVohk5AjFA4PPE9rXIBG8ALai8lpJrBmpG5rq/rY3DCJh93XgvsZHFgpeP4glK7mg7AXprOAPoiUP3qA3uX1pnraSF8oXrGm6ltvb/bhvWm5wdDzlD/BGbN/7sLzu+mBBGW/Jsiy5QPrMxVbblvw74nUAINt2QNhBQgodKSeSnIav9nKFknRbwb0xN4liH9S2LITGzePiOIeuXtubAkt54YBonRUtDu9Vb/eufcLElHjLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4aFTTMpOkfC9Hm1x0TYV51YSxvBhR88yJahXwmSOU8=;
 b=Iu85NzlJxsPCOlGij4G8vLbCknKm4o/GXOrwK1ZNM9mF9jI4o4mpEirsItELaMF2O9KFMIGdzY8rKzsSJh/dNrO08PkSWGx8vaTOCYKpf7ZdiCldKMlmW9xuEP05BEdMpOqdUzEPpx2NH5M70eBwtNu+bK2rA5CeBU0QQX/TDaolzxTnGei3Vv0Jy/Z2nU0J1VuGa3R3xFZUOMGS7K3nwj2ggageATIOU9Hyt/V0UTy+OwbrjdteZJZybv8BLqx5EywI88/ouUlJyzo5ABFISYlk5/UruuPWXrxmxoohbFjPyypVUh4ZOZ9hI9M2AWhij2rdxYjR1qaWpImmFZpF1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11713.eurprd04.prod.outlook.com (2603:10a6:102:51f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 11:47:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 11:47:44 +0000
Date: Sat, 28 Feb 2026 19:49:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx95: Use arch override for env_get_location()
Message-ID: <aaLWVAW6gLIv1YWj@shlinux89>
References: <20260228-imx95-arch-location-v1-1-b04896b35b20@armadeus.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-imx95-arch-location-v1-1-b04896b35b20@armadeus.com>
X-ClientProxiedBy: MA5PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6733feae-37d7-4589-ae9b-08de76bf2fdf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: jJ08UkNSfjD1w4IjNxTxz7d52sD/sv1aYo8oq02G5HeurVnUuRDDAv84xYJcROaSJ8gQbIueUHGS6hEedeBls016hswnTuG7xn7R2J9Snf/FaMr592/nzOnytvGP0eVFEgihG78z1ZlSIuMcOFukaN8GWf2Z++EkynPmF92mh+UV5Ikue0fRzbJxGhR6Wbau2DxFGy7oQ+4ET105vH8gqULvdP2yWotYsp3N7q2lZG4F14+7Fgg+JVYpzerCHpGEFJeVxmZIUnWmon6c8Iignr5BjqjaEluM5WFZklyPasYuw26nBAFXszKcbsVGM6RYNzCt12ooBfXMxXs6wPVS9kXCO57LjovgMQ4ZrixGzXhYMaHaEBRCpqIi4fsQgcsKNDRl6KP+r+gS/Nmlo9anpo7yd8Ef1bI1l0ULOc2+k6MLPkmtFbDufG1ledlnuWQ06M7NDxY+bYMRl3taWzy3k+7EX6qlye6qcGZRqdLDiiunCHi0xkDe11KzdUAJ65Yk9RYDN2xk0B5YXOc0U0IkS8SBoFJtB+k11Mjy9jQddRyl/X02zrruCuT/HE1hV+pxPZqgSaRkwQ445ULOxUaeCZDI/wop90vx5lox0Js5QGmVbSfvBwntTc/+xX5jbKc1EdMbgkyRQcyzu3ta+3PruIJxJKCrj4Ib6X96uatduakZlNALjzAGDM/Qp9KsUqmjGp7r1Fnc5wWUau0OdD1UK7VZjLyL6f50/7B0+dL6x07RISHA6oukJ7lEykHGFVpf2KEStIDchdsyyXmg3TvfSxR7/xf/XritOolKGR9XFhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bc1XWOH2LWosENzS//BOBZP6mNBJ0O3AK0FcY4cz2SVE5EMhvRf+kNGf7I?=
 =?iso-8859-1?Q?560/5XNGnQybHLZ6i07IubIPcPVG6B/Dal/AoI3Yf6Cw44JGzt7RUOZWn7?=
 =?iso-8859-1?Q?ihJ/FJhrkdXxvvsqghUUH0DLw5n3gAABNMuJCJtmgKA0ewyptAy1x063Ah?=
 =?iso-8859-1?Q?hOgurFVjG0qslY/hf79UWxk7fpWCyIUfOyS1PZtvuDvC82Jmrl7DGIcv1w?=
 =?iso-8859-1?Q?WtlR5TL9wCY3K5x5fDxzLeL/xl72USivawRmTJYNONHctTeKqB4EzeD787?=
 =?iso-8859-1?Q?O0kkVuixLmnlmGwUy0vSHh5JuPmN0mtSmLKN0ZpY4YwsPTpz3LMlFIoLCO?=
 =?iso-8859-1?Q?k0p+2vt0Kl9OFG/r++JsKPoKUM0it2esbpQObxu0IHOee5PTBD7Q9cwVod?=
 =?iso-8859-1?Q?WIYbUjmollhPCQm7pSLKR2ekJOZ14UGJhzlK6ihmIU7W8FPFnWT9Z3O5h9?=
 =?iso-8859-1?Q?4xAjY2qdJ2Ek9ekF1GisowYHaMNQNZEaVUMBsXL7eibuY1pbt+X8OVD7lv?=
 =?iso-8859-1?Q?DSOX7hP6FxPhVcjfZHACpvkh8ksoyHPE97sAsLuvfuQNeVYpER+sm/PYbB?=
 =?iso-8859-1?Q?95bOcnV7vH4ildBKjTSmPG6zZvgksfNarFh8cwak6dN759E6tNrP+ideKh?=
 =?iso-8859-1?Q?CNpq0AUjnQxUJoFowfOynLeaeXep+CdTNi9tItPqbZnLdToKPf4ROZlGUw?=
 =?iso-8859-1?Q?lFVSV4LYlpcXcFbwH1NkWLVDBQ/rjcefynr8OsYYRgdsJ59T8YMSlWRRiM?=
 =?iso-8859-1?Q?0DNVz2LGEfo+8Nzl8gObtS+9b0pqhESi8nPSwn8w183UHw2bdkwzSozQx+?=
 =?iso-8859-1?Q?IK1SialsnnK8xuL3HWR0gklKm+bqQBj3Na5W5pVVVvfGClFIAjlXa6u3Ri?=
 =?iso-8859-1?Q?v3PPMNtd+Ufn0anuG+4cYOxA0tM2RV9VcmmUMCsrROmeVHqRzNmWrMXPky?=
 =?iso-8859-1?Q?64a1J4VU1XSdAUM9mOTobImE91dj3dhS7kYIDyOuC+SpO1BpgXzmduNkEg?=
 =?iso-8859-1?Q?9Se3kD7oZApsSQ3otdWjCaQ4AxJmblQOzIIvH7uHDGlPXRAbDYNx6crM9t?=
 =?iso-8859-1?Q?L1BZqHmRBUf/OD3j+VIiR1AE+Rco3SpmhBaJEK0JdfEDXCa0ezrgSeam/k?=
 =?iso-8859-1?Q?Gqm13lT1oXbR8H3lRic8bhuZ+T2BSnTfsr+JOGa/RWDOnPQVmX+t3KlZaT?=
 =?iso-8859-1?Q?EARKIc8JRW/RYgDUwYjUagz3ps4wYXmGL+A2zpbKddplfGDIONKitoTAJy?=
 =?iso-8859-1?Q?jpSlCmO9XS/PHtHi3WoB2bCnS1HIhz0JhrqIlgyw0IulFRXi+9/yMgEwN8?=
 =?iso-8859-1?Q?Ge0U1bJLpf60MM4KD6MsBYhIRKFkVPuHG2MNYEZ9N/d6SR3jHxk99Flm6y?=
 =?iso-8859-1?Q?9J2dryteSC6NZfe+h/iTaDlcPcPC6pnZ+TxqOJ8Bu4pKJYktwVnh/Ypk2O?=
 =?iso-8859-1?Q?jH4EvYTxhS0GBO/TmFHMedpyUIYeiL+UF9LuDVg4T4uwbIyWgpNeSk6aw1?=
 =?iso-8859-1?Q?DqKwdxR4G1/b8n3yoTShXf/l+ncnIeZs/ksqNcqci/bX6E3/VTp0WuVXDt?=
 =?iso-8859-1?Q?KhvZccpQlel6q3ofoa+Jhs//VW3eWPYbQKMnSyYGMEDLMVjr8kfHusQlTA?=
 =?iso-8859-1?Q?25cQQhdBMYs2rTplUKTj7wqN/5dnlg8iYLv8+qHtzmq8mNaC7OyOPbNwsC?=
 =?iso-8859-1?Q?QZIkjZ1826bCsR/R/coTxlDT4IzuPiImQrd8YUcrEcGPYPWhMVBPjINrEp?=
 =?iso-8859-1?Q?Hk4Cakdu/lB7im+Oqg4x8ENkLN6kZNjSo1/+eAHBGw0f9FRUUSm9ms1R/l?=
 =?iso-8859-1?Q?e+cx8g15qg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6733feae-37d7-4589-ae9b-08de76bf2fdf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:47:44.8293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgAZAneuATQePTwE3Gl87A30amJ1CHCFjHNqAHX6puJ5/O1FzNk+SwBEeT/13tx/5xJuxMwSTF962j28jayeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11713
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

On Sat, Feb 28, 2026 at 11:09:51AM +0100, Sébastien Szymanski wrote:
>Like commit b9e48705e0b6 ("arm: imx: imx9: Use arch override for
>env_get_location()"), use arch-level implementation here so that
>env_get_location() can be used on board-level.
>
>Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
