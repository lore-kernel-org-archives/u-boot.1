Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A51CCD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931AE848BC;
	Tue,  9 Jun 2026 12:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jCoMmN75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBF3848DC; Tue,  9 Jun 2026 12:55:40 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DFC8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIJfp5UfgI0eIG/D5OTDKAFLwQ4bJwCoCnHq6VXBy7NNyAaZTf0lxk+3033xlsCHmPUBa5Ywu4fCuJXhzKFppSqzbzQB5+2vpTg/uySiq76tRKJ7wctXS39nVAshaflX9WOHdzEThJUVqUNqkazS6R5eOlVamMXQXKAlD8xGT/yc5uxA3PxzFeHhMhk4Q5Up1RTpyIJrxdlZrSZao/PT9Dszzc1g9P9tsUrHCVDGTMSjc7dHmI/ZshsEaNqscSm4LTHl5uY5wErnlpUEc9yzYSBPJ5Hmoh8ImvT2Nq9Ja9VVAtiKfQvHM+COVCICpduClUJ8zJwCjnz+1AsQ34q4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tNTMytci9ogIlNMC0k7X5l57wIA5vCXtzoL+3Zk+lQ=;
 b=Z88OAx9Tsl/wd5WbrjkwDDG1rF4tlcpWbBVNOMoGYTGcjMgYihLFpWvOAaK0VQjIy3Q7GQzNy/XqTj9e/7XmiQ82zzIRRRGhm0ebKSBTkxnuC7GMu4GBtHSPB4VMQC1VoW/ObO2bGqTbqhX6XLFylyzVFY1s672WVs8v70s0TYK+IBwR4LEciq2S7mY+bSYStgkfhIthSR4/17a8P1f97oYJ2cHYwkrD8YtMepo1LulwQCy9xdwYQRn/bC7NeQDTpMrdunw153h+rRp5Xf6XZNXFjKJSZ33LNVeox+bXWr1fzeV0xZYVLma4ofdSqys1tg50Ia2qtt0sx+d2baIMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tNTMytci9ogIlNMC0k7X5l57wIA5vCXtzoL+3Zk+lQ=;
 b=jCoMmN75fzskiVin8SWryr+lC31smfoXq7iGzuX58x70nqWiKIxbLmF+OnMqw7x+ChAJ+Ax94+3ZiozSan7YtITWl6XrL8MzLrBrWslSpHDJ6jPTlrTeEubHVdUt1UPZHY2s1Y6rZP0CA0InLPdIdNiOYxmPbuvFanzstD7c9pIewHT93qCxhfInIhO2PyVkdzpOh6pfIEAYZGW3gTtGup5vFPKAglxWy9PpBkcQvNuc11Tp23FhQmeba/OteMmolhY8FCHibyDidwzYqGizhU81EniZicnzGXIxebFFYa8aN2tRris93wUmsYx1GVH5sMOqtFJv6psQamnxgkK4RQ==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB11666.eurprd04.prod.outlook.com (2603:10a6:150:2c4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 10:55:36 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 10:55:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Nia Su <nia.su@sifive.com>, Jagan Teki <jagannadh.teki@gmail.com>, Simon
 Glass <sjg@chromium.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Viorel Suman <viorel.suman@nxp.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] cmd: sf: fix sf probe using non-flash device as flash
 handle
Thread-Topic: [PATCH] cmd: sf: fix sf probe using non-flash device as flash
 handle
Thread-Index: AQHc9/NEPp7jA4G0CkaJWPnanwPoQrY2DPDg
Date: Tue, 9 Jun 2026 10:55:35 +0000
Message-ID: <MRWPR04MB12330C52014706E23A1D4CFFD881D2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260609-sf-validate-uclass-v1-1-263ae3619b75@sifive.com>
In-Reply-To: <20260609-sf-validate-uclass-v1-1-263ae3619b75@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|GVXPR04MB11666:EE_
x-ms-office365-filtering-correlation-id: b3575413-7e14-4703-fbbe-08dec615a2a3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: KL2nMx75Illkk6iPIHcvBvzXDYlJFfoJKfMIrH8vqn2UxUsg3ho9xlPw505hLnsrq5BAx67NfFlg4aL2g6BKLEkK47LdBa8ngnNoNlqqr16F5rat9KsvVI0RDzLhXYQhCk+D3G23MqK3NHoN0LMxFcVzMXycictHFiC+I851WaljU5lgGI/bn6QYSBULjHQAiMcer7hhgzhwHyvOO5zu7OSHerVREbxDXS8r2OpOufVlupPsftfIZrdryYbQS9qQHp6jz5AcZK2+Nfd4Qw11rg9Uwvxb9Sjut45Auck2nSsZvWdLLbre0CyXJ8kCpTAs98rdCqMNk3f0A4ZpOqDapoa2lYoFQAiJdU0zl6aB3AYegQec03oOX6xMnD5JUmWEkx2G8B7XyUL8MY250LCzWFZS/5JitS20vCSXF/SOwNH7viJ5dxJ3eGLDff5WiatEz2BxvKL0M3N8gVSDfyQWj4plYI/F5pl5v+cuHLNn3k/QF1PtdDM91eYpy2d0jtdq511TnArshcShCBN5Bll2yWEQ13fyor4PDs2OXCCFj5zoRL+MElNq8soGMRAAqn0IOQeXAogyM8rxnJKLPUkm2b7I6eHt+7ERDYgeC/vEqh4bp9kVq6TMHTj+xnK0PEqSmB3AkzWqecJDswYy66KRPWx5GQ+5Wc8wLTmybp3ebrRMPcywBHUcFddMf68Upxji7PhgVxdqHPVhFHVHO6/wV41f563CV8YTzTU2T0b67nHIsJqWil57YyBV0UUVfWOg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oAKGUy//8wglCZ0ylWQ5hBmE5yur39Zrf1B7+ZOWJKqBUL8qXvy/suhqCIBv?=
 =?us-ascii?Q?sKojniu1l/4LUOw2opjrpM5sH4CyWMdPrAW9egYAfv6FGd+pJydIW9C68apK?=
 =?us-ascii?Q?a+bvFVscWxIBOckDYU49WC6NRIPAtfk195uKpEKb4rI2TEMg+scTdfTTIQQM?=
 =?us-ascii?Q?qmOK0soFTpF06rJkYaQCmGot/5MAM9kqqnTj7GsxC/9l6iUKN9wQGRZm2oly?=
 =?us-ascii?Q?mG0G0uvOc74GDo2jVV1uMfdng7cTgftMw42eJVh10wtmcpFP6pu6JGuQngGn?=
 =?us-ascii?Q?kV1pTwdGLLMrzMB3JJM2FC/ACELlaroNDOXTI3ulEChVbhlJFpjvPVzvJ+Zi?=
 =?us-ascii?Q?Sa4Bob9Ukb4R96xjk21asAa0CCD62jIk75pH4jpoHXxWAUE4JBEAWwwVXuGU?=
 =?us-ascii?Q?2IPR5qVBV7dUUG1i4NoZ03iwhEuNlmpx24qlScu73CUI+rD1Fu0YW/L8orTw?=
 =?us-ascii?Q?EtL67u8aSj2AzCjcVq1Oq59IDMPHcIa17Lukp9n379cYk9rVCP14xVhJdZfe?=
 =?us-ascii?Q?cSYaQUoLSaUKjaODndTiliE2U06XXuuYn+/GzIdPETd66hMPeSxOd6ak1BlW?=
 =?us-ascii?Q?HGbG7v2kjz2oSHTeOm7ed70VAA6EIG6sZDydxph0a1awToXsR2+b3sx8jVq+?=
 =?us-ascii?Q?l1uND4GxJ9D2bjBMzOp5zbD1WK4RVCuOcNsXnrJnLXGyfwbY/UJImRajVD43?=
 =?us-ascii?Q?uXfaA4OXHIqcsUbu503ustra3iU3Ok1fmCxDqy/0PTJkKYc8H9cILwUW//6o?=
 =?us-ascii?Q?0JS2x3In76W3zEne0AVbPPhzaY1ejMO7qIV1eXOehTc1L+x4QVNX6dyD82nW?=
 =?us-ascii?Q?OOZvICV/e2+2oEigKFc72UNv0Ju0DNRFCXiQSBUhwNJns/mlrcPopzHQOGGP?=
 =?us-ascii?Q?uP6PtLwcPkgfW0WuQF//BKT+qSHTzNpq2cAEtwcaz4akXlSRZM4CFklOJfwb?=
 =?us-ascii?Q?L3QwOUPUWGtfgxT1S3ixlCdVzH5cGWIxYDxzXUQWBzOc3svJtHXLCFXVHo3q?=
 =?us-ascii?Q?iCuWgkt9qzmv5Spl21Sk2FV6jyBsyXK3WxceY3LbZIt2yqJrH89jY74bEYtx?=
 =?us-ascii?Q?fac5I92vb6gfqCJmhdMouUQVPE5nbPyMl5PROdmau++XxwLRWHnjUaeNuL5L?=
 =?us-ascii?Q?fQpzfdBOm24khmYkWISfsoSz9dnZGFS+UOTY4tJrS3EoW8rHXf5ESlAdj/RK?=
 =?us-ascii?Q?RKONNCjneFJjn2lRMfj9sIG+A56ydPwQAUhv4PGafsmgEO7nNYUAKbKaUM7T?=
 =?us-ascii?Q?q0BI2DEZCs/xUPdVmv219EXAGRaM0a9mx85Z7rmJGMkxQxdmzP8EvL31aWE5?=
 =?us-ascii?Q?JbzROLp/bAYfna+Vi+AVYDXksmXevIWuEvol76pvePicJcy8+IQucu9GX632?=
 =?us-ascii?Q?Tu+gH43NEBMuPGSOVXUfFbW7vhoD86wnTZH+Qqna+wKdhoy74cDfoHav4vDM?=
 =?us-ascii?Q?jesLyzgVGQXVZhOh1KdbvVJRynmr3TYtMmWQXL5wl0hSK1yj7BpwOseOseJq?=
 =?us-ascii?Q?jP1kyUa++X4qvy01sMNpGlnXaSKfUsrcgxIJk8LY1Yp1SKnRlJ7PHSJnLMTx?=
 =?us-ascii?Q?LiMxWXPeOjxnQgnZyqCJTOpCmvOcAleMr5BJ2GA+KIAVL7P8ibiKGCzX1Kuq?=
 =?us-ascii?Q?6WP/eeCb3yvYoYpYsuE7NZbMcLQtm5L770Nnl1cFF2KBTRENQq0ngWViZW1Q?=
 =?us-ascii?Q?x26Q9MrFRkolmzHbFdYzqoX4jUthsOHC0MUGSAwNSMRzBdWL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3575413-7e14-4703-fbbe-08dec615a2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 10:55:35.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69wiG0krg8gF6mlobLRQmC69dDaNx5HvaEGMNTve6a8RQHloh6majNAi2n/kNVkmoGGTqx2ediZgyWrCmCeApA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11666
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

> Subject: [PATCH] cmd: sf: fix sf probe using non-flash device as flash
> handle
>=20
> `sf probe` calls spi_flash_probe_bus_cs() which returns whatever device
> matches the given chip select, regardless of its type. On boards where a
> non-flash device (e.g. MMC) shares the SPI bus at cs 0, `sf probe 0`
> would silently use that device as a flash handle, causing undefined
> behavior.
>=20
> Check that the returned device belongs to UCLASS_SPI_FLASH before
> dereferencing its uclass private data.
>=20
> Fixes: fbb099183e3a ("dm: Convert spi_flash_probe() and 'sf probe' to
> use driver model")
> Signed-off-by: Nia Su <nia.su@sifive.com>

Looks correct to me.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
