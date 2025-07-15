Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291CC83F10
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 03:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD1582AC4;
	Tue, 15 Jul 2025 05:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DAXLIhlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2897C82B07; Tue, 15 Jul 2025 05:36:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C148277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 05:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnCENgnji5yNuaipkHqXFFQWIfSqJKcZfYMiNEj0enWLmP2Pu+owHoH+PB27H3Qcq3OTZyaPUEMQkrZ5KOBykTY86Wrzeg4uSy9QURG3s4DqjbQQWOidxUcZq16K5WwEeRoDRnpahVK+1MfamzFvdvkV2lOeRFXDDdrlXt/yXeMyJvsbnuI/gOFH2Aobgz6R20fGVDYSKBgh56eaPj9Jka+dYRF4tmG+B90W+QbbBvMaBaSa+h425eCGBhTeBXHVxLDz/eB3wjf4DrKnlsRZqGqahAJfInHVIQYIvBThQr9ELMGLaaE6zqSp6gPe4iME/UawQ7fVqGweIjlo69ttGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5UsOF08QBodB2r6JkJYfrALqQrRy7gkDdVpKnz1uaA=;
 b=IZt0TM47EG7LytQ4VjtnUL+CkODPZDrQ3DKn6ZGTAjRP5huLhKlllEgJcbiZ6lRJQF8IUkYotFdNp7BRhQ8Wig7WsL0KcaRZONDxAULf8jU0ZwkZfpSOGt2C1VhyyK8iJMQfpbUe8LrifIyLCitkO8VsEbccV6tSfcwsBIrvFWOouHnL+fC7tA0sFRqwX3FbMxJ/jX/JqZOU/0t7nXKD1ovPWWcP/1TtDHtfy977lJyPINvaV8CSv9gzXC09ElYGJWdXAphk74jFfoRiVhzZxZbpWOVm5c8PMcEi0eHNAFmnSFslGsXdbCvtxUxdKi27XCO9DtMwEi0fYPK3HzP+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5UsOF08QBodB2r6JkJYfrALqQrRy7gkDdVpKnz1uaA=;
 b=DAXLIhlCG+ESzcTpqMqXxaqYNNPRLS7QQnuDSHZ+nqZen4MBucb5vF+H7BzulROskMR8cR6bfpeMPcz2QVemG6ZNrbg/pxVTAKodx5t3Sy6aca5vBLeNao+fvFVM6WizvoVwBqTVn255upDB1YaT7u2xpizfCsBe30zQbmPrDAn3dO6qEFb7Ah7g58b9d3mtSZAODD7e8xOv5E8Ou3UWgTZDDX8x8S03qG1lABR2s0WR/yYd6sYfYUo0aXih9XES/RxNJnTFOgDWLkp0Z+DJoa4m9jCaz57Jcau+7a8OILmqKEJmx1dBKq5gu8deNI22xLOntc3Oc4dCyROmxs61MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7993.eurprd04.prod.outlook.com (2603:10a6:10:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 03:36:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 03:36:22 +0000
Date: Tue, 15 Jul 2025 12:46:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Tighten some mmc driver dependencies
Message-ID: <20250715044648.GC632@nxa18884-linux>
References: <20250711151607.2224269-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711151607.2224269-1-trini@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: badd2d15-08a3-44f1-9ec4-08ddc350c4fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+xyiP5I1C10zg4kg1cEmt+x2ZRU3396wafxqjA/IZ211zm3n3sKFYIBAYmbi?=
 =?us-ascii?Q?KP8rtkD9Jj7zeqj1VKVQOZmW5X/1LEXLYE6A5a9WgZLebTrh6SZd9Z+OWPeS?=
 =?us-ascii?Q?aX7dl0SKk8uRvxwPp5rksCj3i9DFUkNUE87qAghCO8517obwhytvfRSs5tMd?=
 =?us-ascii?Q?58HeEaO0041erTCCbkDRmFqgOAKoHZEITqzqaCDjkMef0mAL5OVAbr9Fz9Q3?=
 =?us-ascii?Q?3JnL5iDAgJxgfdYgAXs7zEeYd9shVsO57itsybANBWyKiABm7v2hqNvhICpz?=
 =?us-ascii?Q?qI+t/3kKmTl2hZBBkSA1kY2WtJuaRbQW9j+n3SaiAcItfy3J/uGOJV0tvpaG?=
 =?us-ascii?Q?KkCi6UtqSjv9R0bVtq+8KoHBxdQLKlZmYexG8yBb/sd7AbgD8PYnek5T/kKT?=
 =?us-ascii?Q?mUDfD8dDSdNZIwvyiu/sZ0iu6Bxqo2cJqDvFCYe+d9/vztWhqNMApWKulpvF?=
 =?us-ascii?Q?DSV9gTLE0HWwP0aykvVOXnckgoYy3nJIH8CwQRRtj0iAv3ErVzXjQ+VOdmCJ?=
 =?us-ascii?Q?32Z5e4YlCNi3GY38E0toaJB4fRxHLJRYWwIenvphumijcLTOAiVabyzerXkT?=
 =?us-ascii?Q?V1j5xvlvCSrjZXd0JWoSAkBvzNVcZOs7YsjMDNxY14875GLpi4NlcuhFZcQu?=
 =?us-ascii?Q?hmecOXhMjIQvJuwbK64lVIq8hcRqi+Rg3y5L7BTb2N6pFiWlZKsXxFZVk3Kz?=
 =?us-ascii?Q?72IhZx6Mc0hcabH5fWcGCbNjLGdz2ciqP0uDlUElOSKMTLitlRs1XV4buR4v?=
 =?us-ascii?Q?Zxd4M00CpF5Sk0Get92LCCY5w9ea2d02SBEGhcILhEUgXv423cVwlK1MPmAj?=
 =?us-ascii?Q?PaK+Ri3nNjOufkd8gbMXbR8PE9/2PjMJ7YmrMjyICp/JE2jChR9+6rEj8e7t?=
 =?us-ascii?Q?gAdESex2/pZxzl3fD69q84+zGjJsR8ILNLSu14FWYykGeud+RWQmi051lkOy?=
 =?us-ascii?Q?40uIkKw7QTzzKmayACahK7nVojsiv6klloOh04YtTJCbG3h8Ft/0GkGx9oKb?=
 =?us-ascii?Q?gQn1fJyxCx/niA8u6laqrB91SbD0Hz3tZ1zs0TFJGZtmB+HW89aJr6aHtjZ5?=
 =?us-ascii?Q?sGcMyDYnRjhxD7piPNpTVc9LOA37qCwnODEEIt4qHD3fmDlhcolh07790wuz?=
 =?us-ascii?Q?GrbF7ONVWHQLsmjEpzd8dj+T0eXdQP0pnVQQ0voTsyISdBrqrUVwwTd+Gby1?=
 =?us-ascii?Q?4SJZnhUmFzCiENGpdNT/nAWg2xCl+ltr9aKtzyzLFqIhmx+DmMwIGmum6X+R?=
 =?us-ascii?Q?icXfIfugaByTuojZtPQi6MtS44Eh1WHEtGoQ6pEHLeVcWxtHeezA3BZf7LQy?=
 =?us-ascii?Q?tmip0ttPKIj8k50CGK9EzFUcAzGDWES3RxkbZR51eK5mxaPYYuVFFO2y/M0h?=
 =?us-ascii?Q?JvzZvRAhV1r+ESiqISSP6tn5+8bHYMyE5rwRMicsA9lasbmb3BRasKovs6/6?=
 =?us-ascii?Q?dz6fb0ddLALsomQ2dD0VbjNHttY3sbey5fCm/LBO6E3WGx20caZJAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoJADqP8zI0Eojnaa7xtgBgkZU8yojamumlA0ZaOYYKele5U2YkKEi4cHpwt?=
 =?us-ascii?Q?5mFh3PNMUYMFoLdgAMkiWy98b2/U08jGFGD3YvfQ6dR2pfxtSserkuBWfJdW?=
 =?us-ascii?Q?WSxtXduKaU7kQikoATR2aZBCEvEv6d2Oc1Wt7yUOicnqBWFZMxKL4o8PYTfg?=
 =?us-ascii?Q?spvGj9/OtUuQ2CH4Ygan+VFVZECTQ72BRg7ZIP7rR4WZEbD6AhWIG7Jm1gxz?=
 =?us-ascii?Q?4QGl3eD7l8XpE/i0I7rxhYCm8FeCCtXWobqMj2/pM2VLElREj4RGgtUE5ip/?=
 =?us-ascii?Q?vJSgskZz/dB0N3Mdrb86ONA4Sj5LaqINOaK4ojfBryU9cQ9nwcFV50F/D1L0?=
 =?us-ascii?Q?jdvBTqUDE/JseTLMCbKSpAixIQ0KjxbAdHSdqqPKAEvJSCK1qJK6N3d2OUeF?=
 =?us-ascii?Q?jmIz7yGxv+kRPzU4ak/M4MmNhOonQEUjgimvCWtVEL63OLmQzUPeU6WtWZUY?=
 =?us-ascii?Q?05zlcCuGXY8UWIbK2PjuEO53lwzXpDMRrl70PpKjt3C8vNo9X0ESG/XBCk34?=
 =?us-ascii?Q?C2JW/oHeOCe++I6VfcY3j4w9apiC7xU9CROcyiLYzjpeZW0bxgD2QEvmra8X?=
 =?us-ascii?Q?VBMlrSV3CLkg++/GQKiHQd9hhySSFPt84+88ColPJdk/kTYWa7U1Y3pM4GfP?=
 =?us-ascii?Q?g8U0ZcMdyug5dBCUrh4ksVjtwCiW1zFEl0btOXztz5CMgQivH+e6MWKUMyIF?=
 =?us-ascii?Q?OxM2LqbFVlw2/uYgGY5gJdtTJ5J4Ysx2+/FXMLTZY/6nwLdOqUzCxYMHvQ4L?=
 =?us-ascii?Q?hPl1lGDuI3cqV2nA8FvwXNvoKcL+jbAj3pJaNJoCbAIr+FJHnlAcND87zqxv?=
 =?us-ascii?Q?LTvY469dHVkluMzgxohx+0KZTkECaoCgehNArf/fEqP18aRM6RBA52pjt7zq?=
 =?us-ascii?Q?Tvxbh1agwv+/vp+3vX8NuxFJn34GBfEtw3DyXm6pOImYUiyi5OsZwlveA1Ub?=
 =?us-ascii?Q?eJ9XRJOxE9gY6Tndcs4HUmJnRYTJEFmCRiHo5LM4GeVfUK+vw0DG8MEIKc8B?=
 =?us-ascii?Q?vjYdAWs3aq6S1b+vWqJCUBpTogDv8qmXk0b7LcssLTFVc1geVuc6VCZYoNrm?=
 =?us-ascii?Q?QsOWsTlM/sQxQzxVUriRF2sgN2gW4kN4ZmXxdbsyNkgWVreLuWtKoly8dIDG?=
 =?us-ascii?Q?NMSMmv9bHU/es4Ffpa0YF/DVO7J0SU88ZTvVriV3yLD9gdKTS6lo/sqp9Pb0?=
 =?us-ascii?Q?rTTKUY65o3bF/vv8OBKHayTmQgFb+4yUkvUoUUN+Yiy0Te2BhfJWwo2llgNY?=
 =?us-ascii?Q?y6daHZujyypRlEsvJi1z5hwL1JU1nQtaRJOfTW8Pqrlez5u9f6R6UUXFabg6?=
 =?us-ascii?Q?67S2zT44v+TehXrOIk3t0tj4waHZXT+uPD6ksciWbZ2QvCv5J/nxmY4B/7NN?=
 =?us-ascii?Q?oSlZscaVto0K/QkYPx0NEK5+By3qED3+kGa1TQDWEOq60GFnLumJLPG4qD6T?=
 =?us-ascii?Q?kXq174NUc/MQUIJRlfPAJ/n+d/i5WHZ0zXbv4pveIskptjuiJ0n71x3bTVxl?=
 =?us-ascii?Q?4pHFzgytWTDUPpfr5e+ECWfDH67vt+u++3Y0G65gQ7LEGqwriuYbm3ZzkOWo?=
 =?us-ascii?Q?A6x15SpKjhnkAdSCUw8unRBolAR5SeH2F2wEutle?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badd2d15-08a3-44f1-9ec4-08ddc350c4fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 03:36:22.8352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI9kwGJJN7MKKSAxnNoI0JqAGohzv7n5WzRB4aH7E8pOief1SzvNXUE2WuuMVOSMgHUA8K6E8M2ZHX4Z0R608A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7993
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

On Fri, Jul 11, 2025 at 09:16:07AM -0600, Tom Rini wrote:
>A large number of mmc drivers cannot build without access to some
>platform specific header files. Express those requirements in Kconfig as
>well.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
