Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E34CD5BC9
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E614848B0;
	Thu, 28 May 2026 03:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uiM1fI6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FA9848C0; Thu, 28 May 2026 03:49:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC33846E2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMZ15WZqBtDdVGW3wWA2UXdIVI2f6HTnAHYbE4Zo9YQd3qG3RKLNMzNqtKe7oChHS+EFDOHg/sq8z+WwLzOiNaeGASu2RZzxdYDnkQjtqLTmVwH1gP05zoEBxEIb5Df70wVNgkIc/zgrJQ2XtF2nwH2i2aok+CU+Er6b0Ko8WrZ4zopiXgP5EM1Tcqh4xFOpSF+rmlmng+3QSsNL/iGkrIczQy3sqISZ1A8XUnx4oQbcxYEW5A3aEEMX4oMy41YsxRGjv5eB/I/YzHsLYl9qnKPpUk/Ea0A0+t2Dfpyn9tl3C1OjKzxyuxAoP2thvqsaW6D5QUToHYCow9NcOzfptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrIq7PUnYflC6UGz+qufAY47yAr0HDZzMVIDlQ7vtIE=;
 b=n53EecUt9Krana4Bf5WuPp4nsg7YZN0Xz2tam+mzgkFB2OU4gZjNC1UzaZqhuM0lRlaTFO3wEMIxj0yNWyXj91e5ibTkTapgnKtULM//uWHY/Oefar6OLy1r7Wo1B1P92tuyZOEBr3YGwXk8I7yYdVyljmv5tn4ONOJpBOCXqfq+aDgwfOpL5cIgAZDWtJWlHhnqbmosXwRL7dfF14DLMj4hqtQ4ehBTQK09ahGoxd7UxjmFhnCGYiRRjA7wYZl9gjaFTDr1TEG347lh3Ec++d+HvM0vQmVQvj1PsawR9xOXp+ZF1DHGxj0bIAyV6pGf9vzzv9Ea/ysXqpYhjC6Jiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrIq7PUnYflC6UGz+qufAY47yAr0HDZzMVIDlQ7vtIE=;
 b=uiM1fI6zL+4CAExyoSw14+WFjnb7JLPtTKxdbrenRRigII9VEzWpl6JbPao/BR0uDbz/uG49Omadg1vTRZjNt6k84E2+dHAf5OYmUYWgL35ko9gVymbuID46OlDQFBcymb78NkF/alFXTzEQReWZaGFJ5ysuzw8OPT7sktZxapwGk0/yeJaE2OFSQCpxbkr/jXqipFX+5h0Fb2iiBILu5AqBIQFxBtG4YQcNSJoerIs5/yhXTfCGvH3q0GfHY8PmwfSEOXo/QSicwuAFVUm6ezMIsEHxeWf+1M86J3PW8WqC3i2WE4ZvvXM5Mi4K8xOcc+90KsRgJmbZjtiY6N2PfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV2PR04MB12138.eurprd04.prod.outlook.com (2603:10a6:150:327::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:49:45 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 01:49:45 +0000
Date: Thu, 28 May 2026 09:52:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] arm: dts: fsl-lx2160a: wdt0 for watchdog node
Message-ID: <ahef7O8Gva/YMHI8@shlinux89>
References: <20260520214847.1987463-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520214847.1987463-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0216.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV2PR04MB12138:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c59657-0491-41e2-8426-08debc5b644a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|18002099003|38350700014|3023799007|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: so/gC7vKlovJyWTiZm3R7iI+RmASnkNqDOUwA3PEtwN9KD1NNYSKdKhbJA+MzSEupw5c8BsMrpsa7ah5WgS7Wx8lar8F0QtYeadXkKgJ5votrZfGXxkTgQaJGt5LKydrXApoGotWN+NsX5oFaPy36UFTVPfe8aNdSHCAQnLiMNNRUfRc9L20TMkZM4GNwnUtJYIz7kM8sobukS87UJ/jcsFgDbhvrADENBAiQWx4fkCa9abm5ZCg3S2WdMI67uqw1KSkNuO8KY2sdja9J1INYzQZHivYxYEXFFQAngOK9CoIR5bj1GaoUhKqIOFfXDDHfOgkkHV2k8HNGYvhRk/sfDhrUkF/uirOxjCjq/cdjdnEQaG9nEJUZg6g4GSmg8fgXumqIz65/MaFGX4oJ0Fw2CXV5CP56HqvU7Ft62JruH/8KRUY5W9/8puCXdOkJ5rIgeheB9ThauEy6HkpzW5+ZYN79pPW+dyW53ot6h8OFFGVpZmK3NZzU36HsnlkKN/xfRN7IDuCMTW5axqUaHht8lBEmyXGnwpLL7QiPaBiHWTwY2zu2Q6DsAIHs09fVmaLeyGTQw929em+7uRit/PL3ASd2kPldFFuQ368Es5OpAxELTM3jBarUHxZuFTcTN50vEAfIycldjk8FGr35lwY9SG9DzJxRuqhMLkLS2CEb9tA0nPF1uPZwh9atAjRRvpi2ZJeEUVLywPSTt/YE2D7Y8l1HI1GvGz/jCKPWQd9QUF4G1ZLU+v9OFsy2wGT2XeT2rn5iJ9NqwXrdbDDyPbcByKCxb7hqxzblD6e5kjLdbsWKbGYHjuYT9J65StKTcks
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(3023799007)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uxLEochjfMfgwgeLiMrb+LSlhbeclkBcl6cHuLH9GZ1CIeR+cWxQEtaiE2Qc?=
 =?us-ascii?Q?kSZngRaFKWJgsU3LZCCc0ZiW7giEGhxnHu2hu983OxiQt4QVVr4eH9dFgRWS?=
 =?us-ascii?Q?I05hYrMJeX5Uh3A1JfiS0q0cvR3wfs+KFPSOnKWxc3DgCXAqyvw7D0zxEpJU?=
 =?us-ascii?Q?5+6hR6LCCSKCHYXY8NPW5uF3uOd8bM70LeWaQaqAmxk0A+uXmxl3F8fFZhWC?=
 =?us-ascii?Q?2NQInpUYrzjCmNMIPc/MNFKAEze+7qBysluNdcQ4LFV2nmyyAijkD2UUCOWd?=
 =?us-ascii?Q?fukWMtNMub6WZ/19dgetfl2LfUzdKBS9eeBT2GbYiulxwUrPnt5QZYq9sWpU?=
 =?us-ascii?Q?9gv3oVOLrjdw53DsnrGVHE+ubpXqJr6d7Lr+PjqQeopUm1BVpTJlyYZIUaPy?=
 =?us-ascii?Q?rGEMLBHI3c9tvaxNwGPcqa8/L1hOwdhuhAp/AqUTck+9cJgtB3mfiTq0Q1Yd?=
 =?us-ascii?Q?MtbJZ+w9ZxwMOrz3f7P1eJXdIDWNwRtoi7KM1pFzBeM2XepYYfNmTEMXSxMS?=
 =?us-ascii?Q?LBJNO3BwxTmP08PVUja2/6+TNG2WIGfWxCbd0T9LtuDbQk+v3EQbTTw0dBJ+?=
 =?us-ascii?Q?R5tc81KGJZ+PJx9vRzEDSiq1wmve7Mz4A7J4godtE3xBI96KcQDmJ53FPskm?=
 =?us-ascii?Q?+EhAdmxKqO34URyOiAA7YmDOAu2fyCfI8/pedvWA8JetAQx7wLf2ocXnIhH0?=
 =?us-ascii?Q?egLaKeM6SZ4R0R48L186VE1CmwNjsJdup46AURPy0APW1PEwrgE/uSnpV0bk?=
 =?us-ascii?Q?nZFEhWQcgMbJ1zn8MS9zgAMK8D9yD6IPsIGzLe44Nfauu2wKXx3I+7p45t98?=
 =?us-ascii?Q?kJbwtwNfhUdSb6zgbancojW4n6HgTItjvW0pJFkOy+6FXTuGXJC3o4k1dr11?=
 =?us-ascii?Q?ep3m+dYj2qjYQwDW78sM9RuOpVQfQA0RpDZbJHy3zrKg/6dYrMwQxsqilJbn?=
 =?us-ascii?Q?Xy/6CjLAG+kKaWAiUCduAj575Y4CrG+El1AVM0IsebeZmpgclZtJ9eTpdpeA?=
 =?us-ascii?Q?xm4G+KRT32jSdtTh0PdiMQvd0dzztlbXRCPxgiGYxBWQYmPePK1CQhCf2CYg?=
 =?us-ascii?Q?8FKfP7oV5r3y7UTz0RKkLjcZcZPa9R0yfRYFxKeyHqNpAGDst4YnjGp6AJYM?=
 =?us-ascii?Q?TUTTMV9PwcqlK03F3/ZGri0VQi+5fqlQFKOEM50Z36IZcUXY4/8XoRfwFtSY?=
 =?us-ascii?Q?z6j4oN96CUSaLXtTS2L5WsUTB/2lUBmuXXkZVHKQcYNzaKJ9LU3UEYIirmMW?=
 =?us-ascii?Q?yQiDzn6wn7eMlHWNXfu8QAGzHELKbWJMGBaFoaVhqB0uPma4WHWpQY0IvqSL?=
 =?us-ascii?Q?nJYgaLW1mCRXYndB2fRipoPdWihnH3QxHd3LotqCbzdfTbrSZl5JV6c6q7kL?=
 =?us-ascii?Q?brPDJkwKOIwF8wre9RNCfjztcQO4Faeo/z8KVwaSaDyHFPWmAobjeiOmaFTs?=
 =?us-ascii?Q?eJnfcktcyvzZyYdIxpLf/A5tMeXe/sGk8itkU4+avvIZgGxSJhn4OCPHnxbE?=
 =?us-ascii?Q?MkC7cdr9eji2vtaH7GG0WE5gQFczvF/6L7w3+nLYrQmdpneA3Pxc84A5EeA7?=
 =?us-ascii?Q?SRbmWje17U7NzTpg1PHwuZ9gzn33j0bKn4yLoJxCcathitoHVQhAI31GqsSv?=
 =?us-ascii?Q?EcW3izqvq572bWZeLtj/CLCZJSa4fknycRrKLW/joOb/rbVw1YytIw1marbr?=
 =?us-ascii?Q?h7MQ89jboTTEI7jt3mqEkZ2n3t4QNKlWRgAh+cvfJe6HxJXDU+BFaCK4ma4S?=
 =?us-ascii?Q?Rd+D+gdH/A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c59657-0491-41e2-8426-08debc5b644a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:49:45.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH/1MfuY+j3FGGAjHbmMbZasqRyJwI/V2c4P3vK4OL9LW26K001B5lZzoKHv5HRiPvBp3hgbOc1gS+VSr9jHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12138
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

On Wed, May 20, 2026 at 11:48:41PM +0200, Vincent Jardin wrote:
>The SBSA generic watchdog node is currently declared without a
>label, so any per-board DTS that wants to override one of its
>properties has to use path syntax &{/soc/watchdog@23a0000}.
>
>It fails with
>  Label or path /soc/watchdog@23a0000 not found
>when the path contains an `@`, forcing to duplicate the node.
>
>Adding a one-line
>  wdt0:
>label allows to override the node with
>  &wdt0 { ... };
>(for example to change timeout-sec).
>
>Zero impact on existing boards.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
>---

Applied to fsl-qoriq/next

Thanks,
Peng
