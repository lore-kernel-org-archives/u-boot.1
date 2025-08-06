Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16403C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B817A842CF;
	Wed,  6 Aug 2025 07:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="W5xk1VwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2BF83989; Wed,  6 Aug 2025 06:34:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38DC83965
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzQKJkwsBvjAsirX05Pb3KW2wsO8sbt0RCEfViLRodU87j+x8N0czFNuK2XMURzMMo4/dIFx3HcBImyBZ3tFAVLesJQEKpFmGWH+BcfUhlUDsDi45ZsRHmqEbzYDPje5TTxeJ1Ye2vPi28/fV7pNjyp9038mT4xgI6q7r/hJpdtwzFn0f27ORsVEYGgv/DHxDH73s2P60CguyNOc9weQsp2VxcndRfP0dQiZkA+M8txvk9/pWy0reiWfKzEYJWHsaEgodUH7yDBk8gpcUvfsvQI4Ob27ErssI/IAl5+wve8MokHuEB8Z9lIJLbu77nyPBSs7boo1Hbqk7rSP1jJseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=MQfNRrNg33R78KoLwUMJ7mSx/DfBOEMHhAcrOS8gTXGzOovmO5xkbW7/qsZ1gaQ1GU+MfOJkdbQjTW1F1yKEuJHuADidWmIJv9ZnGPT+gDF6syN5m4RkGPNVsT0x39rT8Yk+Gwdni2Po82Vk0l+gil/cZjSELT4wed6DMGH6ZOaJQs9lDscirYMEDwngrGCHRAww24jAsOYa0axYWP7fYjIDbwXUklzoWNeetUxZQIHDkaQgNGkoCFvGS1+4W2clqSHUGR+tod5P1woD9Vo3Eu+idW+/k9dIVqEa9xR0lMiIRND2Y8THdLiiXZvtKUhHVYITJAN+bSt4+ptDBOpZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=W5xk1VwAivqcXzdcst1UKF87Sx5nLocphCqIE8QrEcF6JJuq2YVEtWk/GEZk6bdS1x86/ve/qtDMlP4cVseYBgOzTnkFziFOoLdQbOw7XpeV9G2Af/N8eY6/pRpAnkmbCYKXRnGHR95C+BwQ6B5XSH71CbbPptB58DjlYOJVez77byEyGuiI31z1nP4fpbTMh62hH3x3LRTb0lXLw7BqmDgifaTC7ls3AyUbboZTJ7CmRLgvC+wlHD6TTdIFHOBDC+XljYLIPwFcEmBo6NHhXp19L62YEfinVAxthny085JSTBxwtuMrSgzbe2QFXR32FRED48V3uQuYrsd60cciIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:34:16 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:34:16 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Wed,  6 Aug 2025 12:32:35 +0800
Message-Id: <20250806043235.2260-14-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: b443e33d-492d-4a6f-8b09-08ddd4a2807d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?33OgLT8D4jOfjC1NhhlEN4qbUezvqGUQjG4dQquhZ8OmM3XX0+qXHw7SXU/G?=
 =?us-ascii?Q?o3HfALhzSgpDVYeSm4tvAab2m8ByhnwZIVyYCvwFfi9SiJ7ZcYFcY5VkYjUq?=
 =?us-ascii?Q?XjeBhTRc2HfvJ+Gbx/NL1U2fNDTmoKLrWu07pbyAgBujvV4zGzNPlzGZ7tW9?=
 =?us-ascii?Q?UEW2oFhO40h8pe8snTwD6MTWVtHonWm9bjmiyoaCd1K8H5uwxmK4zXt4F2UL?=
 =?us-ascii?Q?LHjJtQ74oIjH9PZehgUMQazMROxZNoucCW7eZ8XG8pul5AErGN8X2rHcW7O8?=
 =?us-ascii?Q?rpveEqP0XEV7p9Bx5iG74516Uk0336cprr9Aq33qqOOyoCOaqGUftIuNrqsa?=
 =?us-ascii?Q?hk0Iyug1RFvgd94tbgfPeoy/7uE7BgT28U5WPJZP1r05SIFc7sVlaGchdLzj?=
 =?us-ascii?Q?J+VEBiwTRitxgfQqcBBYG3xVen6NkW/cG0xWEy2WclLC3F7O45D3XcZ11scG?=
 =?us-ascii?Q?oMVDVYfTHj3XUdlt28waqDjX7s7XRozL6CDKyltgLK+mq+h8aNF5MgAjedSo?=
 =?us-ascii?Q?WYylwT2fHBiw6onG3ZG/KzmxbZ6xoc4Qf93XhkyjmSOqPEfys/GgoyYkqZkh?=
 =?us-ascii?Q?7x/O/rxT9ay8flKanX+KZi460Q1d7Mi+18yVp+dY8yPFbNpDDMbp29tjTU8U?=
 =?us-ascii?Q?GA3Lp7SbL3Uc1Rscyl90bnnou5U29NocIBDMmMwL4EhC7YTRwMVfZIROBeo1?=
 =?us-ascii?Q?fp7bEvv8W26To33eO8cwHmuG0bBMP6HnwGLSApfmKccUexAGa0HOMPG4Kg7Y?=
 =?us-ascii?Q?Nacj6mhamyQVfSMF+yPa1NIzl+BVacNv74DCWKgmWKhaKfn6iAphJHc/vnk7?=
 =?us-ascii?Q?xull8COwT4euq93z9O/6UNeJPNeGVSlZIA9pVbxla46hApgY38e2jDcse+cI?=
 =?us-ascii?Q?jWDxrouPG0maP8hOaItZgzA1GFaVr01qPiomMx93jTrsOj9MkFFGDx56KB5Q?=
 =?us-ascii?Q?uu9sxCQZtDrB+S/BckjX5Xz7sLRaKoR7o7cX7P8boyc7O9IDxgthgNMTS8Jh?=
 =?us-ascii?Q?PwMRzhF/TVPSz371Sv1qVw086JTFKFdoNybHgTcL/VLtyd4IMnW+uJquAoTR?=
 =?us-ascii?Q?nkT0+MKbB88zAFlM9DNMmryAPmKrQFYHtCR0m5fZ4Y3OSfXLqWSN4OLQQnuI?=
 =?us-ascii?Q?HQ2mT2k93nghj3dKQjBtzJD5wFacRn//0oS7ugmHoCFcTFhU6qUePIXKqi+C?=
 =?us-ascii?Q?xoKnJkPnmfXyV5d1A6r7ZU8Y/QUyNhNQqiaV0i3DjwmbclFQJxXeA1wFWeO6?=
 =?us-ascii?Q?Q9nxwhUwmIJniALxb8M3rwnt66kl/yKG3LFA3xAh8kbrz/t+hUQymFmtDOpl?=
 =?us-ascii?Q?OTsCBEDxI7jCgaB5lou/B8US2vcBNoZ3EhAWEpaUXBrxU3exeIDJft+Qnyjx?=
 =?us-ascii?Q?nSf9NEMzHkjz+bLCXn3Ea8yDe0fq8GfCmANWiir7Vjo2hMVXG7eRvALP0Fa4?=
 =?us-ascii?Q?bubI6QHgrFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OA5EGMbxn5fG4kCEXRKLKZDDETV2un6NVpTeaf8+Qf8v2dm01ln0pihpeGyT?=
 =?us-ascii?Q?vGuEj3K1uYsDtKVCDa/KlcSqn2DTRncpwPbpJpjpuQXxW3pKFsNLEx0Ce66+?=
 =?us-ascii?Q?VGjofUsHszGYKd4fKjAx1EwWdRZUMaK2uFBjp8p/th83gM7XWPYI+ZbYyd5i?=
 =?us-ascii?Q?qCs3J/O5rLg9OWavbM0e0LErdCmQ6Qrk/5hd5lFPiF7p1RrPDYxDWuEJn8MP?=
 =?us-ascii?Q?H1B6/o0erBYUjAbTz0Aj7eGZx9GL5rGHTetfv6pHegLqDO72/cmi6XDfBBQy?=
 =?us-ascii?Q?iGZy7BTH+d4MttIRPi20pLoIzaGae4XVK2tdbsPhU1cRfTsfgaoeDlwPtfO2?=
 =?us-ascii?Q?aXZGqE2TUK+Yr74ocFriQ3TSVYyGvUiHC5kB+hdYKmeB8WnEf/p1xcUAW80a?=
 =?us-ascii?Q?cezVIcUfehGnlXoYHyBNsl4xMURWzYvOOba2A1rvv8aWhKvarOs5ai3oKpEU?=
 =?us-ascii?Q?cHeYJ1l/8rMrS78kKcg03/BNU1TK+OERpzyEGz2H2E+4/rESRB2N6nfPE7mv?=
 =?us-ascii?Q?0wc+dYNSFUw4FldegNc1Oam3vUvsV5UabWOl2/CJschksTSExZ+UVDjb3z1v?=
 =?us-ascii?Q?5MUwDjodCczjEnjCRvv3rp8DevD7kaSzl/Kb1l83LXpks2fz6DYCVOcRmlps?=
 =?us-ascii?Q?DDcsbGfKjFjcqDaxMNdm98Lf60UlGiCBIcrhdPS3aFJ25OY/Nr+LcT/UT7y5?=
 =?us-ascii?Q?gQazQbx4yvzLkIpwcalLgYsa0in8UvT3aLVTtsXBrAkk0N54GkJj49TMb0We?=
 =?us-ascii?Q?tytorUzL8hiyqDUBucCbPSiERsyv9jG6j4g9SfZMVmXgjJ7jQZfpJjtXLM3c?=
 =?us-ascii?Q?4RfgJnAgmiwNRgEeJKFc3Rh5arnvOqvyowPswg0EV/zZTnCXgNcPlHyC5Aho?=
 =?us-ascii?Q?4a87Z2bYL/nO54Y0LuGxEMwgoR2mWebHEewLPl7oxGg/jj1/MfoRTzDQKY7B?=
 =?us-ascii?Q?LRc2lJKSFcbSIN1ipgqyp+3/RZPlsXLE4KVN7ueKprlu7emUBmzKwm3GGB86?=
 =?us-ascii?Q?peqvZ4Y/iKaHntXH5Z9XuTvahmPxwZXVi1qChPkf/XOwy8kazSGZ0nzdxdtU?=
 =?us-ascii?Q?qNfz1ZAPT8p8ZBdAV+SEyCXQ/P7TeUDnh3gQ7HOwY52z5FkAkx6pFDfKsY4I?=
 =?us-ascii?Q?v9LmOiDi5nrJ1zprqaFyMpDpiPgPLDMLq1KmaE88aDc/KmZS5Plyju4clawn?=
 =?us-ascii?Q?xUR+tR42+roikVb3QGlTkcbX0LzPVQydzI17IvReOnKUJwl+ta9LGON7ysFC?=
 =?us-ascii?Q?j08iBR5ifgr1/AFzSr1/CZdAyN61hwHQdqW8ndclN3ieOY5R0iM//9e1DVc3?=
 =?us-ascii?Q?5est+RegosO8e2E5ATuGZKVkmovplUrd9VN/9bSTxp5iakmdE6zGHt4HG2C4?=
 =?us-ascii?Q?HFxfFkK4GlUHzVM00LRZYTi8umB9vLrah/aGaMnY/x9aGvF/+gwcxgcdf2qm?=
 =?us-ascii?Q?uIZasPaYUZYI15v8OtSUfTyk08dj4OEE9QxnucZ1ls4rBqS79ZZ09x3BLGjE?=
 =?us-ascii?Q?g+KfSBMqEn54EZxU9Na4m5E5RFmcIWACbubAT1m5YpQkD+bqOZ5M0ztq8g+C?=
 =?us-ascii?Q?tRcXLQJAo+F/h34iLrqooJoPVO4lBr8TtlV3iaBKFeM4R5leTp/J/E8Rqb2P?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b443e33d-492d-4a6f-8b09-08ddd4a2807d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:34:16.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JANKmQRVABsEdCARSFR4y8viEY1jSJOhWWxxY7Ul0xeYMBXWmmPmx3frUclQkUsOUceX8GJjCKziJADCf4vmaJqQt9fUijeInsnu1JZTM+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.35.3

