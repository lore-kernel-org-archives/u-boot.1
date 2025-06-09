Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE96C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7A382B20;
	Mon,  9 Jun 2025 21:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Pr6aO7Ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380F882B63; Mon,  9 Jun 2025 21:46:14 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504B68007D
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgc8CJwVCEF5Ivk9NhTlW1lulJlT0VkWs5InGgJr0YQGYzUOY5uzbu/l1mR9ZbqAva+2xi2MPJ4r9wiPm3Z3gnfbk0jDUD2xQN+VZys03Fv7h5hMa0pRedyxcAwulyE0aNtVtEbqxrjU5hY8NHeeV3ohXF3NlrYcCQ/bd76E5YZaYEfBOP4726yo3DVZKy+LVUHPUvbpqT8a2LTWcRQpG4PBNqHz3n+jXtpJ4c/12LdHLdCbEWdN0Dv3Kp4iLr9m2t08jGyPSjmet93uteg8pKmcrELM1ORWF9DYSLgm/JSNG3DUZuYLc5csRSHBPxqgisR+IKyy0Sk+DbH5xRombA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHWZsu6mJlMwghRdi65knUPaFhwAJ04UbzCpVCG0azM=;
 b=OVAoAAs2DXjKtKjwOy1dUHy4ihxbh+Ra8FS2QiSrGmltjqnxsZhdsSOLgNEYdbD+myNkwUM2L06d3ZS0oGpvfbx/C031qjz5L/ynwhrHNKi5pTRnlkiEtjh0JObHDUZW90vx7tlQD9Ao1ji7jGxvDmOTImMeuir9wYiyEOlwHckjI2DDQdIDQyAGK4pGLfEIBE5vGMvNyLx5zxF0IK3I/lOpW2bxGrbs7yu2VywfTHKcD0nY01KQhF0dLLkNPKEJd9Uf/D8H0teo8BdVnF4yGqvCkyxWIc2U7/XgmPUSENC2sjAr1ZvgPI3s8tpq0Fy/xr62vKEhFStwa4SGGSs77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHWZsu6mJlMwghRdi65knUPaFhwAJ04UbzCpVCG0azM=;
 b=Pr6aO7WsAtBuJQvjdeHiHNFfCAopWpACq8a+D9KipFghPyugFshzbZYHDbi6sWbhMEVx524rNrWOGrr1Xm/rsV7HN3wG3ahDlDeu2/L3sNTtQJL3zln5HfoXAb5bKgZpWMZUrzWPQg3GJYiNLdRdrqe2z4e87fcBbK8zWFXw1l35P2pchtCVG+HsF8tXD3dOcb2h2P7SoSApcp5sgPWYZGc/IT9W9/HDHUYBsL/QtD3Z9DTSvXjOP11RUIv2zqmSTZKM33+sIEyaStfP86pdGx0HyhdGmZd877g6MFu8bTo+dmJ95aEVJhIyeQqjsrn1X9fAbR5Rz1k6UUif8px1aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6047.eurprd08.prod.outlook.com (2603:10a6:102:e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 19:46:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 19:46:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/3] common/spl fixes
Date: Mon,  9 Jun 2025 22:45:58 +0300
Message-ID: <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250609164841.GU1382132@bill-the-cat>
References: <20250609164841.GU1382132@bill-the-cat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 1503b553-95ed-4edc-31e3-08dda78e47ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x7f7r4i1v6bfncvKYZEy8sRobdXRLjptKCX4WrRSd2u4YJftNqrZW3mxoPi6?=
 =?us-ascii?Q?x+DH8vSsQDHDrrKKFXlYFbyBJQeebx8brYr38GYSxDZfj8aGQ48dyedqPYRv?=
 =?us-ascii?Q?sw55HjjgOtubvlguiWPfPYpTU7wj8JvKZtremlicSky3Y2RvD2N5W6QvCAWc?=
 =?us-ascii?Q?x4K54xRdH3nLddcj/JFcCnT3RpdNKZ2/5XnS6Sh9TPKXw6M7BZh8D6in0Nh7?=
 =?us-ascii?Q?DlRG43VwaCVnszvisgCkvHvKee6nN6b9n7UH/pYQMh6jLHyT6Xeqec/y1YKv?=
 =?us-ascii?Q?QGW89trhbeKj+QnGy3u4vjczKEiSZZV3bCWn8wL4R8B4h7+9Kq9LCACSz1rD?=
 =?us-ascii?Q?mVNLpY6gHcWFm7jvB3GE/aJIUsPOa1buhxNMoSu35lFQ98Xxw3ppLc/FFqIY?=
 =?us-ascii?Q?N1XgFHOsYAXDUlNFd8QaGw15Jp9NI4fDQj7/MeKEGF0fkOYlrXesO0QxzLZZ?=
 =?us-ascii?Q?c2LiW4l0/WPV5I7zy4Fcr7wQqPCTrzraREzVcxbIq0zAFZynrwDR6StPOp0l?=
 =?us-ascii?Q?zPwRpGWOKLndYArWOunlaIXXRDa1A0R1RsQFEahAiMwY2ibP6yJyPhTb9H/f?=
 =?us-ascii?Q?plY1KdajNxOkaZrdYlsZazxvkSdfOIlcI1MQb13P68a4XQhxAiKq5Ir2ZKSd?=
 =?us-ascii?Q?qH5n/QfUpb3jZOSqe9Iy+0YyI/gX/Ut4k1hkRfQKaVBEkKvCkIZ1pg8wXOp/?=
 =?us-ascii?Q?IeU+4jAHrCkqhD8KFdJlESQOyqfU0LCFHx0CmuOBB09vOXGIXKY1DWUm+7Sl?=
 =?us-ascii?Q?q0jAwPen+RCHa81aBcDizn33b4+w8UhbjPu5DEBAzUECnoM66cu3QdkAM7gg?=
 =?us-ascii?Q?qWbNZIUuCbrSYwuIVdqLrB3vzoMUbSPIs0vpCIOYxUZOjoFr9W426ujTPJLd?=
 =?us-ascii?Q?UNdg6druCPGZmX4EjA4r43nTUWJrTqHQGvX6z+JiHV4hHFz+O2KZQ+l1hNDz?=
 =?us-ascii?Q?TFj2hjgSlmhoTQ+qWRT9yc99vLGQuiCVWhji5/QYuBe+V9DN5QOdFh96DYcd?=
 =?us-ascii?Q?KDqsFFIdtjxWAn6Ne7VtPNwwvdGnddEQw/DaYJK4iJDIyXYhOaUgB+htQWm2?=
 =?us-ascii?Q?zbziWQ9AwefSCSKJVs6RgO1tJxhpyy5T2RwxcetCEK7LEDU8TADrhdmbhyWd?=
 =?us-ascii?Q?aXlcIhr256JDiWkljZ/86D2KWX9xalwggfz3cRld5l51902XJX6kcyUU1j6W?=
 =?us-ascii?Q?YPKe+D6GzN4njks8uQHHHjVfRcg04IZ9iJ6PXatowR6WXsb91394WL8E4JKP?=
 =?us-ascii?Q?TJ3GfLuUQkjGNXvE2cZXdrxokIw0jCjqahBJIUfI6XGPE+nezqZOEu61ShDC?=
 =?us-ascii?Q?eu/A2dws8gSL12coPUXFIW2tBfpVGugH2Ai63gPe4KuvAs+a2toS5n1pJYnv?=
 =?us-ascii?Q?AwsKc8c/ZqFInSWU0YeGCAARIjOzypmm0rxs7CWU/opuXuou5Nb9q5ZlwdvO?=
 =?us-ascii?Q?4U0cIf5knzT+MC2I7qisMytyN7rNHPEOlEtxK00xIAx1m9qAsc+dwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oke4KDfO+UEfTAg4ZzCqAk08abQQgwT6hQ04ssSsk3B608O92hbOjTlkGdfd?=
 =?us-ascii?Q?C7mtVdjvnriHEVoFfFqnCT+/FapQ1RaSeHc3S8yJIZrNHe006cx07kZJaaFB?=
 =?us-ascii?Q?onL6lY8s77gHOJHdpNc/jPRh2J8uhB55bLWl/dMOLVGLnH6ORU7hzL9yKlWT?=
 =?us-ascii?Q?/mkA07A0lhRxrMqDXtcGgpaSMKo/Y4veguv9Ju9uqMShV+hgYPBSv1Ue4my7?=
 =?us-ascii?Q?A9ILs9e3V3wloYv9kZxiiGI6Jgux++QdbpyDWe7yOxd6x2x+UhpUecRdmgIY?=
 =?us-ascii?Q?l9pIo0IuXV4HYiwuOXxFGAl1gmbfpKqO+gzwJjDc8q9KxjkU0ydzEud1oXHs?=
 =?us-ascii?Q?BJIqB1Ovam52WJPWjCeRJEuv5nBXN61VGmm2mX4f4sDJ0yRmQcvTAiHO6k41?=
 =?us-ascii?Q?U2a5YDVBbd/KgjYuzpLdZcPKk+gv5Cca6pWPDxV4rpo1GohxXjDn47//sr43?=
 =?us-ascii?Q?afPRcobppRNhykIdzFoa1XY8xd7jzfLcoHSXdbBCUCI3wUHqxvjtGaKbJ0yn?=
 =?us-ascii?Q?diTm4W44lAZeZujDfAKy2A5jmbqaZTcjO0UQYfdVBv79AspES3RI88DyulIr?=
 =?us-ascii?Q?uY5mMo5mrBnb3D6jngvwNcCSJ7zt9BFU1NYbDQYSVH176uqzK4xD2+MJXnfO?=
 =?us-ascii?Q?wi3Q87XcijSIXtum//zCFG45UZW9HulmPghyTtaZ+Lnta2IJA8+/FFIrkFbp?=
 =?us-ascii?Q?WJdg1rh1oBM5Ykg6NbgMUwsAP4qbKH65jVwGHIFBboFkXJlWoyCUqHNQFuJ6?=
 =?us-ascii?Q?z0UHahSF6ZkVQ/F1WBuFoTURJRFKimlwsVXxQHPZXRNGyvoPEwK7odt7XWh2?=
 =?us-ascii?Q?hoFFYfKnQQYwkkv8/pMUJJKEUPFGxBL/6QEL3PtZ3aV3LZ8PDt+tABljEAHG?=
 =?us-ascii?Q?OYdcdGTigH2R7rDRckHqbU4VbCRsbGMEymXqYyXdwjDJJKP2MqKhndqCy+c5?=
 =?us-ascii?Q?TdX4OBI3zsoaiO5HJYVCG0svQhw8hBZAz6Yr7QUryfKcBzUwWzE4Eg2QCTEp?=
 =?us-ascii?Q?hH9grYOZpLYKrLS6N4FPBNcbW4WJ+epvgg122xeeRVSMK3ZE5kApq/dBAAgE?=
 =?us-ascii?Q?9Bp439HoSc+CbYs+wxd8R5M1Wz319F+MbrjnTZlQ2RbRiEcWI7YMsANQEtnC?=
 =?us-ascii?Q?8FHW4KyATTml2EExILM2PDXWIIB3LmyKiBlIAKUDH+jUal6DTnhz8QOAkNf7?=
 =?us-ascii?Q?vYi7QP9fN0viLmsoBkQHxBHGxAnCR1WYjQjvpEyKnXV04mcpVOiF4YkIgPBl?=
 =?us-ascii?Q?9gHNsNCdmtpnimO4NGvM4lekMQHx30b0Z6+RrSPYCJ8WsSQsC7wm0GFyuvSI?=
 =?us-ascii?Q?vqWyhlNidm2vCxoTRjCgR7MaI3KrWfW3H2TC/beTze4IVEG/lum6qp4g8Opj?=
 =?us-ascii?Q?jTcooSiaxLvzal10QwOGHrok3rES8kZiqu5ftN/uvdyUq+rhk9yMhfX3J/um?=
 =?us-ascii?Q?YsHAg3I/6R+xZ4sElZ4qmYqL/sChrTr/p7+GLiOA2YdBYcSaWcvnGMEmhdPo?=
 =?us-ascii?Q?T+NZ+s/YCPcHQle9AeIjre9OcZ7xw3PLOW63TrpuNtQQnzDA5fMiqOL6j7Ej?=
 =?us-ascii?Q?qkaGy+4Zfhc/7wXHj+5lZYSRhSe6CK0orsCN9Nl9vwMlV/caTwq1+nlv28rr?=
 =?us-ascii?Q?bampowlv7pDqx9JL0y6npNw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1503b553-95ed-4edc-31e3-08dda78e47ae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:46:08.9840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFu5gg1KxNP+jU9/4JBVpkTa9OkPJxCd7nAxQ1uEiuEDJUjyltup3tkgikEkB/bsJoZ9PyeWu8ZSBn2zCnToB9U3pSmpUUjSriCxpiXHM7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6047
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

patches for various bugs in the spl code

Changes v2:
 * added more details to the patch descriptions.

Changes v3:
 * fix commit 873112db9ce68c38984ff25808dde726f8dd5573
   ("spl: Support selecting images based on phase in simple FIT")
   instead of fixing loading of image with bad checksums
 * add more comments about memory usage by board_spl_fit_buffer_addr().

Mikhail Kshevetskiy (3):
  common/spl: fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: handle properly images with bad checksum
  common/spl: improve error handling in spl_fit

 common/spl/spl_fit.c | 48 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

-- 
2.47.2

