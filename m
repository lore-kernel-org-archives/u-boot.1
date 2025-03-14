Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298ECC28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CC78193A;
	Fri, 14 Mar 2025 06:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NcqbGLIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16A480F9C; Fri, 14 Mar 2025 05:10:39 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEC580F4C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbeIFZnbiTjmehJDOe/AcifNUlkL72RvPbWIOQQoftqnbbhfX2VDn8S5eazBkPoN9Cf4YFSUmKOYxKOZVT0P9MdVZsogWFw5erYO/M93UdZsulyTFYB7gYmunsA2ddl8i4IRlORIeyTbv24HnoM3NrycYR+ELgg3ecxQe5RtmCm6mfMWJiBMFZoJRQj72bpsDYhkasWX8V5UHvXnXHymxe5uqptCBqrnz9oQCij1CLj3qz8mvdsNgArUGo7od8pqGrGDPxkYzwokuJUx/m1WmBBwA4QThDIo0UP57dW/9LZi2NWCpsJEwXLQyFu4OA0Z3yxHI79WlLlxHzTnh1sVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ+xitCYl4pAwroX12dqHokxtCJJKhOCeh1SIpN8C8s=;
 b=bKeRaOJPbrSXgDc1kMh+V3iHgTLXuoQ2pQ0Ao/blxBK1FIWO/59BS1951me5tmDKaZGb0w4hkQ2c+Q1Km+j5OUe1NOanpqu/gZfV/okSvpBTR12UTddy4p7bJnDxhEWfRt5LMQYvc4Ji6qYCRvaxLjPNYPg1kumIMWMCJ1jJ+z02+AW3fZ+Ifk9YF35f8KmWz47Sh6HalXPhFUSYFy1CmMZ7tl67JB3aKZksSPEqM6hjTVnxwW2Ru1I04Sv5joqPQ5yZ9YtdLef/pUEVv4u3G/rW1sAtOfX0qnQdM+VborzkXJ+EMz9KAdbXVQEq5cS47BcgY+CXKi+zKIMXOeSB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ+xitCYl4pAwroX12dqHokxtCJJKhOCeh1SIpN8C8s=;
 b=NcqbGLIgLSRfO/mDUlvj0wkFnXGNEwmKU8fF1Jf6/5p0MeNoSI+PO1utOKc16bZDoUuYJEG+NXPUCV/xFl7RlafMCYP/jrNK5kIG67n7TZ0/9yR8YWIIHF/05JSZxo4/JJXts2qU7kczSn1/apC32+pAgnA9Rt8aEnyt9HruC2N5nhP3KmF6gJOHiVDNHj2KzPCh9iT6HlYvytLfKX7kqcgfArwcxDJlLg+6lB0xmWde9jLlmhkm8VBee30BZkMN9ZSvj+Sj1fcttbX3S6jOa/IGbFeyDvFQKfqVqYNw1KzQECiR6pgx7C/o+zTrUyLDe/KMdpjxeu0zDhv1FVQqpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:35 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:35 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 10/13] cmd: Enabled Kconfig and Makefile for DWI3C cmd
 support
Date: Fri, 14 Mar 2025 12:08:59 +0800
Message-Id: <20250314040902.43621-11-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc8a7ee-be15-4e80-1637-08dd62ae2b99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MOWz/KFRbDCJRXb4vAHZ/BE9AqqtEtWPQrnTWLC8phy4+YrVz8kTDh2Ca5Hd?=
 =?us-ascii?Q?GWxz19VwNiAodcEzMAGIXmt45ERKGwvTYnHlpEzes5XSOxSlc1NUmscybL7t?=
 =?us-ascii?Q?V0DvBSifFUfP4KMsa17daW8xW180n6naHd0O0xpUeJvbOnmKhSTV7QggisHe?=
 =?us-ascii?Q?+f1ENrDIAYsyl30vyTKU8vMOzioHTh6S2a0sWgMfNByMbP+xTTYNKjZ7RbXJ?=
 =?us-ascii?Q?IQ4k1C1Aq+BO3Ngn+PQJVr6ZPcy7g5EWAMb3jcU82n3f7IRkRwFfuz2IBsXo?=
 =?us-ascii?Q?hyO/ILtCSUGn/usx7KHLTo0YGaDKYJ+5t41qZDxLW7x1OsYg4C71zJ7cwDRY?=
 =?us-ascii?Q?WuwJ5PCADtqGsyug4OQBP+H5uMSCofKleyJuZDFNxWrhW29oAJRcJCXNOLF8?=
 =?us-ascii?Q?bTSJB2eD90vXo0JylyobUSXt49Kdu8KLu410KHDQHYsUmd6k/uQm6UE/cZFS?=
 =?us-ascii?Q?lEZV8T/5d0NTRqYfcnb4AOGLFzhauOEXZG7vgUfH+oC0YhD6/vOH/11aDvJY?=
 =?us-ascii?Q?Jyd2MFrZ00Irtw5mrFJy6HbeldJ/mScYU1V7rjERvpykn1LAeR95E98lbqjh?=
 =?us-ascii?Q?YY/+mR4pIzNGE3UCLABtOC2Y5CzZbnxlFS4q5ZSqKFwMhrOsiYZ0OG7obpY8?=
 =?us-ascii?Q?pVg9zgZna/kP6ylCffImbEy/KHMFk9qUxKt6Xzqvh70nC2dpP327QfBWW6JZ?=
 =?us-ascii?Q?Rk18XvID7/OK88+GrqqC32HNYyESPqkQmTPiJZDcAt8fp7+sascW1xkIH/Hv?=
 =?us-ascii?Q?ihYukl4i+EV/GJ+0KCAMdmK/df5VcFnaDFBNfU6Tvsy2xLL3uU9tyiiq76kJ?=
 =?us-ascii?Q?PdKA9OzJGGCDk3iaZauJSuE3ldjAwtvVlHyvS0wIPlCSzD7pL9pAWftJxEXQ?=
 =?us-ascii?Q?puV0IPqW/kawaAph/0Bc150Dn5jeV48v42d7eG1YGLM3IB24j4iKdYn5COny?=
 =?us-ascii?Q?TZuGZRXnpWQvMpw1cYe1IuXa1zU5w3dNsLqRx1sHi4vBRVdZuDBPRuOwUpxW?=
 =?us-ascii?Q?vCVjoWsibxR5S9K/KdwUbGCqqP/kFNAjdXQvIvQJsIDv0HczLP1+EckKXmcn?=
 =?us-ascii?Q?yfpjZw73aqIe/YBkwmlR8rI2mZWfbEStEQN+W2xAizJgNKWyQzoIU7o5BzHc?=
 =?us-ascii?Q?20zYHVOmiwsqLH8R+EvP+fHxqf+Y9Y5IMiGuI+oZfDoe+1RIydDU5apPB367?=
 =?us-ascii?Q?2lT1437jPjlryZhFKQ+47HUqCb6RidypphsYaFhHQBoMdw59ivoFB7Dv43/c?=
 =?us-ascii?Q?2OlYprH8i7bpopK+4vzT3Z1DU1ZoZG39YGdV9cMjTHaWtZHYBv0ka45IoL8E?=
 =?us-ascii?Q?osjQu7rHiJVWEdaJ9aOZRdJt6dbbNWHywm0xKgNzEWw0cPv4YZar6cxB4qiu?=
 =?us-ascii?Q?0aTQtQip0HSd+cCrCeGsEQeRfIOm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MOdLwrb9g76Pbg9nAvwJCdBoE68uo+DUE0+2CFcfWk/VY7VeIqm2MyZy6C6e?=
 =?us-ascii?Q?70O4SVFbdW06F2ypdCjrWGcmmQLQiaaW3i/E4TmRdGRgWhTXBjUdfsdPQWlN?=
 =?us-ascii?Q?m6NWlONtkAs65oZcn+GVXk7LrtXFJNZiKpxry2N/PazXOd7j59oJfl3PjoaU?=
 =?us-ascii?Q?gWq8tsUSC/70DULrWuyOtCqestd7oWKJ+9Z5JYWEKmIzTnBMFpZFk/ILHVA8?=
 =?us-ascii?Q?aQiTV0YCYs/IsfTmFqMQsyff42gnDeA7uRPMTFY1+UI0NXM+TnkLQg2ympq0?=
 =?us-ascii?Q?KtADTx/x6CXStdW+WMsRWPLnyLosYaD5h+FoR5F71DSe+E65J51sK8IXSfJw?=
 =?us-ascii?Q?5ALqn4pEUaRUcjTjNgvTm4V0Rf8MPxUl1hUUMZQTfQjbIwU0tOyBhuRjCSOE?=
 =?us-ascii?Q?R3Rudj/BLeHC0eyjFY3NOk8yphDuPiHyooGtlkF0UKTL6RlQVktTMG4YML3C?=
 =?us-ascii?Q?3VZXrTA6Qq10wDysaKkNoJIK/t70JysYrV0U9R2D5xwmjQtdccp3cEMjJDl/?=
 =?us-ascii?Q?re+jQhQEDQckWMsVriGnbsry3OZxTRL4FCrW6NgqH8HM051wz3Be6Rveg1Jv?=
 =?us-ascii?Q?0CGNGGfeon4fJP12znx6kiOtsvTJGYU0A1e5Carc4kzrCx5PRZdZHplfa1OR?=
 =?us-ascii?Q?E3NAYFs3aWh7ewApOOVjc11N62R8HbL2QVHK8aTohIrLXxMruJ2SwQT9JffI?=
 =?us-ascii?Q?RL6Kv90akzXvJHPWdK2FDIaeQAY6NdwFxF0c5HCNEZZDpZNxcR/+zOSxBy/A?=
 =?us-ascii?Q?K4yaWRSW+mekf/rhHp5doFE2TlEcdbhBLyE/8zgswTOR7ItG6fgX5Pfh7LWy?=
 =?us-ascii?Q?Cd+CLQUF3P14zYivXvjxXSa9HubMhzGtZkktyk0U+R8hO1EeZdr0dAZ+lvgp?=
 =?us-ascii?Q?Qv5nMgb2xqFBHjPG1PoNUaZm54uQuMQAibxuaLMCZS2Zj+tcKVpzYp0D414c?=
 =?us-ascii?Q?G6EHU4MTQWfA8xV4/fb0Tp5P9aCvK2rq2EKElrnickHI+NBIuGXjnIJzt09b?=
 =?us-ascii?Q?WZhv1qZbztDjwIpks9205hq0UoGZ+kDFIi4G7XV3Ib+hkUKeUsN9lFKaK99Z?=
 =?us-ascii?Q?xr1NsbnLW/5hR60TmGy2LpXI1SzA3jTc+Pdtt0Gd/qzowVlF4bXqi0eEL6H6?=
 =?us-ascii?Q?1QNW6LM/tM5niwButjWhjdugZZnPnsl0m24Q0aJtkgdO34v5oO9PGHt280kC?=
 =?us-ascii?Q?LMsb09j5DBZUokWNIJrUADaXKwuTkZ0ZqqDfEmSRzgzy2Q7n4NEAnv/Mq7G9?=
 =?us-ascii?Q?Gzks9Q3ovn9auK0SJsUeA42uU3vSljlg1TQNjDrHQ9YMLlk8vlK15QQxFBr4?=
 =?us-ascii?Q?LWOKbr9fV2Trv8OFFH3gXDfKqvTTFLzkOV3fGivetuIE8Wh6PWYmYzn+G22F?=
 =?us-ascii?Q?hGR9pbBExAxyN/VobQG7qLh5y6CSMT78JaWQDbpUgprc1dc/01tsmOuo3zq8?=
 =?us-ascii?Q?/pRj2ya6eKV5s2ergleyg50LYiUWqDHdNkz+FOFDvATr4XQZIL2SwVNDI60g?=
 =?us-ascii?Q?7j51YqrV1pPuI29olpbBkMXj3Hd5LQ2SnXwbpfQ68EXehGQ4KDF9bQmD7MPw?=
 =?us-ascii?Q?mKBN2cDaaxNZVhqYM0bFrqNaSaeYoQkogSqpi8Jh7ee7wMw1swaeX//U1z2F?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc8a7ee-be15-4e80-1637-08dd62ae2b99
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:35.3973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHZvTweBN4SNYS94QyjVzHEnt7AfiCF1b0x5qhF6Mp2v6R+ZOzr70woy6t6tJcvaLRV6bRn+77a/GV2bNdeEWgwO6I+UoAeSvz3EJ+NeKos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

Enable the Kconfig and Makefile for the
DWI3C driver cmd support.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 cmd/Kconfig  | 6 ++++++
 cmd/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..551959731f0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,12 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
+	help
+	  Enable command to list i3c devices connected to the i3c controller
+	  and perform read and write on the connected i3c devices.
+
 config CMD_W1
 	depends on W1
 	default y if W1
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb..082470fa104 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) += gpio.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_IDE) += ide.o disk.o
-- 
2.26.2

