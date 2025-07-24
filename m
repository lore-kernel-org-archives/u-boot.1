Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D92C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B25835C7;
	Thu, 24 Jul 2025 04:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oRQJIN28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C89E83287; Thu, 24 Jul 2025 04:03:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D70A835C9
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6cpgGfD241BXi1YHAKw4sMtblkdz40R7rG8MB5MtwYBnt6v20g8mkOT5eXOaq2kZhalQLvwXKXYSWGG4icJ7T0C/8CNdqkldD1qRl9GBE3q+rmXPYfApWcj0XYrU9Hb3j/F2nu6ChgY0jIlQrcbmTzfFaSgXvItY2N39CVP2O7vMs7Yu2FnEKLQcDZk7EMgs1NlBjFHrkjo80lUB82pDaHqXJu7K+uDK72RU32m0DLXr0ah7AdNEOD/klBP5sBUewu+Ht59geSIMCr7eaZsAV8lNuEroSHKAE5sfFgm4R+m6Vya6mh9MqtLSCZoTJbYKYoGRkUBe8T5c+hjFJ2k3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f83E6nqJy/JrrlWkvdX23RaqvJ13fxUGaPIFymzUXZI=;
 b=buyWnVcbQqxDjSVLhQrawDSOFwB6+3LCWyUTk40MI6hB2QaPruIEuMk2XmGx16GQAQ0q4T1Qwjbqznx+VT9f8rKpNDsAAn+1EGIPctP0gnpCrba+Ix2G4nR8Rgm5PqQYBGubIIMqhq7SMiOEOb8nURk4C61t57ly2GT+nrgAqlqY6MFzNntUsNyvPayBzkMhoJXNuOsSK57JzMbM+Mq6zZ0i9/2NI5mxSRASFKC/XHp8pvrlQrsrTWasTaxevA0OcZNnHSCmSYqLsvUJpp5zQXQeqy3JM9g1d6dsrhLgWU+D7gNQwlQVwP7p0tLruSULnmTQq491zNRr+nDTsF3UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f83E6nqJy/JrrlWkvdX23RaqvJ13fxUGaPIFymzUXZI=;
 b=oRQJIN28XVEbDPlJ5O8jjr0Pt+y3uvCzdp1ROFRHcOeOhIad57dIttotdeJ4D0E7WZ3OfCfWQ3k/MTHBxhhwNyRlOsZh3i5CNO1nyALkWJqFwvnBGD9ymjiiZ9qGI959TCtDF30WraVaHu9oqgdvG6nA9bu68Uxshe7SscjiSgDapbzMUHkQJm8Iq/tidVbmL7EtHmJq8j/1xD4qeXf7tKz7rPIhR++PBlGEZ1MDXuO6CVyiTFRmmv15brD4Pwwo+qI6ot+9i12xzXsbgZk7s2M4tTHZWy78N7XZdgKq0lE5un4QoADrt5AAZvIcpzj2ZwL/n/BJyEtjIrIiby72ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:03:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:03:31 +0000
Date: Thu, 24 Jul 2025 11:14:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] imx93_evk: Remove PMIC and USB header files
Message-ID: <20250724031406.GC18395@nxa18884-linux.ap.freescale.net>
References: <20250723134557.1972331-1-festevam@gmail.com>
 <20250723134557.1972331-3-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723134557.1972331-3-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: a7166551-d6fe-4068-a13e-08ddca564a28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvBDt70CiPtXi3RB1BsM25J+f9LwPjWVQBsImoj8tqf5nMhki0UPc+S4Co9e?=
 =?us-ascii?Q?R+iZGw2voUCRlwukUY8ADpz4jl1Yqh3kNQ9KN1uzbO8srrZ5ZcaAqT2WH3R+?=
 =?us-ascii?Q?sN0NvP05se1kb0I/swaQN4zYdNIB+LzPyKETpd0LTDZdEJeUA44RxVR1JP8x?=
 =?us-ascii?Q?3lq+RqF6SjSMcVjI++mH/cRB5wLkrVc6E43Kqi37ck10L6K0LTOlR6gMjN1u?=
 =?us-ascii?Q?5NATrs/33rToBvsAGYea37vUqIS+qtbz2XxbdZamcM0BN3ywnuM4Z3MJNGPt?=
 =?us-ascii?Q?43JIn08BRiChCemrNybOEubUBCqTQVdnalG3AIh4n0rEgy8N02ZWvFwHMlsR?=
 =?us-ascii?Q?fYc2mkHZjZO/EG5CcHcpLVuU4ROZ//wRgFQ7KB97t2PATiEGw0ztaEeCoOXk?=
 =?us-ascii?Q?U1xLg8oOnNV4HSG64rKPO6Ya9k8ZXP7cKGVefs58AHlqVXb/rour9mdIL6Ri?=
 =?us-ascii?Q?zxehWYOFUm4CoyhakjrJ/AjP0+IdpAR/nEexD/93jCP3fdotuaZIi5ADBnRY?=
 =?us-ascii?Q?8H5YWoY7FXFvd7K96xhlp0v1P7LFdfRKGrwkqw9YnOnSc6hwdVJ1oIKtlyGk?=
 =?us-ascii?Q?8gNg6+TtXcuB5DrveQzlfMOJy2uaO5Yi+/vYps6ZRKU9MU2LJPNWDogqKVRI?=
 =?us-ascii?Q?AXMw0Bm/cteRU+o6XHYOwHouufRVOX7y+AGj4OntGmcXmp/40AaDquJWEx4U?=
 =?us-ascii?Q?mIn05OUsowRnfCCBuMP1ZbgEOabVVHRgPwUWlssBK58EsvFY3Du0nSEHO7Wh?=
 =?us-ascii?Q?Ofv4dnPwpGeq+cYukthYKdyxyDl4BJzyAh9bpBtNYuLQvV9x7rZlY+d5oka5?=
 =?us-ascii?Q?osF4dSzhYKsTRCZaHpk4lNkrZsjnGJXDr5uTlO6VEXU5WS7RMLoySiSCmuNw?=
 =?us-ascii?Q?ijTeETbL3+TpnwYCLJu3YuZ+Pv+jGneZ+j3mB7WrokbmViVw6bbrXzp8jInT?=
 =?us-ascii?Q?KmFGBn3D/vpBMMXNwFJ5ReklhkaAF70ohrO+PDx1RXk+E7wEfFKInFYR3OmR?=
 =?us-ascii?Q?hCnHrhlP3Mv8NIgrr42jSSIxveXb1QdftWoKkAb7dysVYdlz/foPdnEw3qDY?=
 =?us-ascii?Q?+TXUyfMDBk2PrQo1kEy/zD/y1iHEpPSO9Nv1QNzLvoLme/L/nX4VbvaosGDg?=
 =?us-ascii?Q?J3sUXT+W0SsBuliAw0lUXj9tG8sifH+un2w2Dv+CSfYMZMkjmimSDfqrQVyE?=
 =?us-ascii?Q?b4BIQrySZsF9CgGj1MDjBQy98mJZbcUXo1xtDfAhvBZJxcH00fEx1/Fyiyj6?=
 =?us-ascii?Q?ASOWoPwq75OBALMYKBaRxF0wlqp8yke14KoegLFpIBIyteh7mWlb5vGAPBq3?=
 =?us-ascii?Q?93htqJEv5tAmbvfX7m2PQwDnleb5E1YRbhBIMWD7dl8NRadRyqBFeJjb9cH+?=
 =?us-ascii?Q?SSRjKL8X9VRz8s91K4Zvs2LArGla9UNwahhreviSHLzOLtLImXujr2gW5Vye?=
 =?us-ascii?Q?Z4MSOzh6DBo3rynTaZRTc3T4BiwlAifL+bYXH50WY8aWjeKsvTn8WQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DQTWgXiFjEtkDlZXNLBTyjeurYX0JOni8RjdqcfQhJdgrLxluwYOcbgneJY?=
 =?us-ascii?Q?+W6JgkY+wyqy2gKYP7p6j3+93NjIVo+6iizhmiPwh3briEe2UNa0BMmiV4n8?=
 =?us-ascii?Q?Hjku55IAMXye/+aX/M8YSMe8uGrDqwuvd7eN7p3AYM8KyGPtc1BVVmOGZ/k+?=
 =?us-ascii?Q?Ab9k5UzbRBe2yg2igi7SxKOQA+QLkUQtD83ap96IFoHE1CRzrexGZd93F/fK?=
 =?us-ascii?Q?7BbGv4W2emAB+dSkjcvXRX2a3G0o1MmcEOY8tKQtdMUbny7yNf9u5M19Cf1p?=
 =?us-ascii?Q?k68O27t0JIEitl+EBJq+KwtaFeRUMbv0qUQWLGiG9GxgpNzerVesMbfV8Zlc?=
 =?us-ascii?Q?k2AbjnG0PrJY3pxFIxuEtMUZJgzWwTj4h2X18tEHGCI5wdfrkF1vdJeI5O1n?=
 =?us-ascii?Q?IUdykKcnVZiNb1S4uNk/04NjYdctau3xk0lhnst1NNXKq2pSmXjzmBkcBqai?=
 =?us-ascii?Q?ePqTFqiWkld9XJ61WW+sjFOG6zOhYaWu9BDkoPMgDMe7Bb84Di4XH2aCzKFR?=
 =?us-ascii?Q?4DgG+kp65NAgXE6aBZMhURYQctC84PgGejOa7XPDXJrAfr5IaqlSEI9Dk9nW?=
 =?us-ascii?Q?4my/cP+JCnb5xHqNA2DuRY6mwv7EFVHw3n801m/VQL9j0x3QWfQ6yndaD327?=
 =?us-ascii?Q?hJcI/iZlit3ePMEeDWZWjtpq88JWTsOkn31MLIwl79KO/LisOleNjeXv+UQ7?=
 =?us-ascii?Q?6j7L7sIUKg9LyN1Qauww6aYAiIeuMy9qQgN3pDw8IpAREd0AwNsGN3YnHw9H?=
 =?us-ascii?Q?OSr4qplPBwquhav9TV7GdsbnHbWjvHcqYa+8UxXwQKweDzmO/gMcOpK48kil?=
 =?us-ascii?Q?uTI1XKAiIvrGqC+wU/Ie9d4Gb9fBPAcDkwr8Pu0cZmT0/aVqy3vP/CVTbX4b?=
 =?us-ascii?Q?VSnHHUMb92TpbDvq1/Q5bv9qJ03f5/EKkS1s0b484dZj53syKsop8Ad2GH5o?=
 =?us-ascii?Q?4yqODp0NUefANrj7X10cKXjWEGWHLdTj1EAnf1KgINvAL99GUbrfF4qo1qmF?=
 =?us-ascii?Q?YdPRDKEJ5ielwn+JXetr+iK0haUQa2zdVteOLleMtYqCWo82MYiNO95l337S?=
 =?us-ascii?Q?LD3JMBHFyMffkseqFMYY5OQVSYnITqIj/8IOGI5r6CqZgIHoT+BsMK5IOutd?=
 =?us-ascii?Q?TppRTHiNEo00clsXQYxOqcdCOR/UbcQnC+esVGAwi+g6ebC8lhhlCa88Kuer?=
 =?us-ascii?Q?eekIYxzUWd1ofDSYQr91C1pNKcrYZlgbSE6F0tuWYLT4jDpp4qmrqVz7dyDT?=
 =?us-ascii?Q?4gY8nj63/xKJahmnobD6a6iDFzxBFN/kgHY18YW/Uf+hH7ISWuhhhqRISV/W?=
 =?us-ascii?Q?16BNrkFGIdeaLPLyuP6gW8m//DqZNPksw2cJU5ZUOrrH0SYBtJz4E/1Cpapm?=
 =?us-ascii?Q?QxW3h8YYXqO7FMxA874MbDWMWXjhxRDZiZPq4V4yLJZdzYRXuhikD91i2xIO?=
 =?us-ascii?Q?Wf4F4Zs09XkVbpwwqPe9RfqKOQvMXK9fh6h7ASWpnaWUX5mIwI61nqwsQHa6?=
 =?us-ascii?Q?E4ow13+OUZQAuwpJGspj2ujtSAfEW25wPvR64k8QUZxa8aX9aPgL3MA8RrVC?=
 =?us-ascii?Q?H3HhS3bDdKcADfzA/d9jrwX1iijTyG5H5tOgw/es?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7166551-d6fe-4068-a13e-08ddca564a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:03:31.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqMYzesFe63ZUXuU9L6/L22T2vq+LIEOQwMMOBEIeg7xKiyHdbmwv7gviacUP3F6kKQHxhyz0MC5wduAdhfc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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

On Wed, Jul 23, 2025 at 10:45:57AM -0300, Fabio Estevam wrote:
>There is no PMIC and USB related C code in this file.
>
>Remove these unneeded header files.
>
>Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
