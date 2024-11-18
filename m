Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F917D60D03
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53D1894CB;
	Tue, 19 Nov 2024 01:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="WG4Dv9vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAA788DDA; Tue, 19 Nov 2024 00:16:55 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B71A89386
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 00:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trprq5HmXeyHVK3gbFHbCYeCHJ+2VUR1K9MvDhv58QDlpMrKFJ9IQ2RdMwdVT5zXaYijlIX8hBE3A9bqH6akyFBnmg887BhfI2Gf5TTytJn/PwYmhSkgu3AIG12s4N66hl1UNO6MNEE2dxSGuZ70dQIr+uZ4gMwxz+DOr3PJLzS59so7GOXVVskGSiHKhzqI6q20JU0e4JGIFLYWzZrWBqQTFhskOlK/nsPndoFJALD4TC19ZBC98StwmWMO4lQvYXJuiKlwF7b2zOwz1nk3xj/Ky83G9Z2OObb11hO1Aak8xBDRUT1b//EamE97znNIGyYtV6oZyOGnMxBYW8Obxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF5ETCx+giLzyiZweoxLJkBOWcYQMxRyxXWRJxtxB8k=;
 b=PdHA6vJbE/7V9RUFWimp2NuNeAoqS3gGwo2lEBRqL4dvJUwDD455OTheIQ+Xt3D63zdW2TPPLRLcm/h6pxOUI9H43Ev0Sbw9+izaRxD2GuZOaNI2JGIha03qg2fGoB84y3f1wFxcKQLhK8YG/zmhuPpsgoTWX4GwHdgFhC7P//jLZwKUtQWIYNYGAaZWmBCE4+bAQ7b9yEEF3ZeIztVhNbwJiqFMHtOzuqJncomRGEe6yS3kvR525Zn8c51gvAGPGv/prqGmTgr53jp/00pqaFr8XnAZZkWxT3j4+0cAad3ncGhAaohLO3FYnDRx7FS53W7eHlhDozxuGQ0tXMDt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF5ETCx+giLzyiZweoxLJkBOWcYQMxRyxXWRJxtxB8k=;
 b=WG4Dv9vyV5aFHDesOAWrErdFUry9uncIaYzV23nSBQxqGIF4/SxA0+u0+A/RC5vP4Lso82bsB0flgYqeq2sXQpS45cpUl76VZoO1gVbW7kFPUEmQaVkfSfsf4RV6qVOBcWQ9rc16EAg2uvo8wiwB67G+TuU6HGX2RrRNbPIGpws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV8PR22MB5275.namprd22.prod.outlook.com (2603:10b6:408:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 23:16:47 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 23:16:47 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, w.egorov@phytec.de, t.remmet@phytec.de,
 sumit.garg@linaro.org, kever.yang@rock-chips.com, marex@denx.de,
 festevam@denx.de, jonas@kwiboo.se, Oliver.Gaskell@analog.com,
 aford173@gmail.com, prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, bb@ti.com, nm@ti.com, d.schultz@phytec.de,
 nmorrisson@phytec.com, francesco.dolcini@toradex.com, vishalm@ti.com,
 vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org, m-chawdhry@ti.com,
 j-humphreys@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM62ax
Date: Mon, 18 Nov 2024 15:16:06 -0800
Message-Id: <20241118231606.3161665-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118231606.3161665-1-ggiordano@phytec.com>
References: <20241118231606.3161665-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:408:ec::16) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV8PR22MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1358c7e1-4b12-48bb-08ba-08dd082712c3
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UuBv80LuRLYorwuHTq7SyuAJJZnN4vOZG8vbOT0jmlRVgRYmBeOWmaV5gfM?=
 =?us-ascii?Q?AZ5NgyvlbpltWVxKjmSoGEFhfMilgu/bYFcRDcm/VBaYCJYYDgM4rBKk2VxF?=
 =?us-ascii?Q?5Bhm/HxaA0l0j+cS6SslTabUm4vfNMsBVwv6nZPZypN7AdE3ewmGMOhDUjjM?=
 =?us-ascii?Q?Npf4NiEcKueHLe98RK8OXeDPWAlKjwtfJGrB5SIfVijNZNDByn59Foi7Iiod?=
 =?us-ascii?Q?BcKkTZ5KWzIQ+cBIp6ta+qOWO4Fhb5PzbbZ7Ss0OpHnCN1SmgdJzil5ZwuW/?=
 =?us-ascii?Q?d+hphmEMDj8Gsm39e0MNOV918eA1R9T0RQxprTUsnmwFOQA/Q7lRJj9k78+m?=
 =?us-ascii?Q?a7JFX3pw8PJwzqxgtt0fG6rSv/csa5I2qK2f/y1U7PLgTSBWGNFf2hkIvklA?=
 =?us-ascii?Q?3Dwp0jP/RdPKda1AKen/E426/gPuxzkiWQusCQPAO1Op+gRXP/+y4b8UgFPY?=
 =?us-ascii?Q?9x7TJUvZzDfLUyPJL/SZlNiLGWv0TsWpgnYagXtvpE1keA3mlokTfUT1j0yJ?=
 =?us-ascii?Q?95dbGxUCEAnY6Pjp7Bc8Z2l1lne7JPGqK4iOx5tquX+9SFrA2Jcn1mGWWIGB?=
 =?us-ascii?Q?I8wV4Fs/thIQzwocEJ1BXPpGWbY55hSyHFQjWgQZYazzyTZr3T7B6B6LDo07?=
 =?us-ascii?Q?WaooBlyeQTqO+SHGIiMwhg4mEQll0+93aWDYVoeGYuaURKJpttQwCgObpXe9?=
 =?us-ascii?Q?Df7q9y+BurJsqIC2c1KnLIWIClfC7ssZZUAg7sm8S8DFLTK1hAjZehv4kVJe?=
 =?us-ascii?Q?LO/2q5e6LC+BE5Ny0BbCmcmPKHikUQjdvtGn3DcQAXWLz6zRrh+6gV81smP5?=
 =?us-ascii?Q?Z27trvIhLud8hiITbm4QIuHB7w5cOxUSLnLNQDnrZbrI0G0pJRsjrBazAM3o?=
 =?us-ascii?Q?5ogQXObMwuAAZJr7A3c93RPXK/3omKZFQXKKsQz8uR2Srn0ZNKchbRRcUsQG?=
 =?us-ascii?Q?tTLohgGOtrX1ViPquC6feLFmIOtI2IThu9KiX1XLnPkwG6cxAB4DAz3DKC/G?=
 =?us-ascii?Q?HUV5ScVCAafprK9C8NSnquNupAgdC2s5Eyx0r9pDcNIehERhbOaFI9YKcRVl?=
 =?us-ascii?Q?jTvVCSZZEBvY1lj30rKENTpyEgkX+fFB7/5DfljNEFIl1/9vnB1FOAtssJtF?=
 =?us-ascii?Q?Sjc8iT5otodwU8pLyjbKBvkhoTT+Cj51QMnKprlvRdYO+qj6L1EQppcyPBDo?=
 =?us-ascii?Q?1EQnruk5wnJoK54xSKjpT1d8wkMkCUGAsJONTX0qMX13f7HEFfZ7n1hH0gmd?=
 =?us-ascii?Q?hD8YZklBkY68sci/Q4jc8ovwc8UwgeEbDMr5zjgoz/R8kqVfSd5NErtWsJN+?=
 =?us-ascii?Q?2+F8mEm7Uq1lVGaur8C5l3MQLM/ER/t9FHsBfU1ikAOYOb+NuhGUShfTm1qo?=
 =?us-ascii?Q?Rby504eJR6ENxhvWLJOm1EJva0Ge+pRXnvQj4cy6mFgeMAVIDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jekoPC5ekIdTQqp7c+E5DFAy1hKIFdRZCj0l1YjDX48ECIwl11tgs0mzVD2?=
 =?us-ascii?Q?NjDrb/cs0h1FlufNwf76cdCx+MG/R/SumbHWgOXtcBJTHJ7UJTvb2NanClW9?=
 =?us-ascii?Q?Fej3DDPOjjNk3bEoKzys6qnbRPw1bW4T7cPsBoF/xKEnJzjET0Zc+hBalfg4?=
 =?us-ascii?Q?4Mi63JqOG8zl3/N8wWKDyPkWlmj6cKtwOBKh3VR20sm2kBXUpT9RRPv16jfb?=
 =?us-ascii?Q?RXGZ1jbrUKX/YRajd3qnllJn9IZg4exyqD1AHDDBJihzU1oFqpoPWsZby/af?=
 =?us-ascii?Q?/fXhOD5Fea0IRnPLEm+aAIQzEE7T590Q4yuUHDw5YmGHXA0o/df8lHsaM0HO?=
 =?us-ascii?Q?Md60P6lSYXk4EsHtHx9J+VKF/A1AoIIeWy8Ab1eMeF5t3dCJu8KfMz8Z2M8n?=
 =?us-ascii?Q?3TOR88CT4kMSdzk+DepAqF/ESzQeVnAirgbrbdtBmIJJFePBIEun+i6hnr78?=
 =?us-ascii?Q?H22saQ8oZWxmaS1U5g6bI/1fsHvpTi9GyE3o1lUzNPm0/02LaAhmgeozc4Du?=
 =?us-ascii?Q?F+rKNfyzX6Ya/kMHHdmCUwhOm94cHBCoO7qcoirj/1UOvaxUmBPmWCkXYaL2?=
 =?us-ascii?Q?I01DoTcB8ojfXfEa5W/5yLWZT8E5/JHqSs8IxkNRyIWBw4YVgYCHHnPgrWn9?=
 =?us-ascii?Q?pWEPhM4ZZE6BmVuvRdmhowdaNOKJPlWzBnz700pFYbaNQPsJnJnUxtUlCbod?=
 =?us-ascii?Q?6GmUi1MhHtoiB8EZv3qw8buDqtKZ3akAQWUwwt9wQTyy6HT2ReTqjbE8e3OE?=
 =?us-ascii?Q?cmWZjkA7YbENLQtvRy+hCuAfArYincP9itx8dUbTTPTZUO8sIDO445rWmrRx?=
 =?us-ascii?Q?RNWYBJWCiJqKEIR0drQ8DW+UpDjNsiT4DHeFE5iRfFk354vK5dHrn8012y4d?=
 =?us-ascii?Q?KrNvffoCoAH56N5Su4dA2PZWIE+3gKXCvmcBimPpO7fCiu/enWt6+8iwy9BP?=
 =?us-ascii?Q?9C1yuISuwFERp5pyWJ27Tp17EFr6XoNUp7AZnABM5WULY6UWFKy1d6lHdT7L?=
 =?us-ascii?Q?63bkeKfayyuSIdRkH8ZAcAN6f8B8IvhgRvd/BDLTWhjQ4GqWD2TWweYQzfqW?=
 =?us-ascii?Q?iEggHLEy/AWRGg1mwhG4Vi3SkeMtPiCPOaZjRo6Z3CFmUxV2xRH/EgmmLkIR?=
 =?us-ascii?Q?K2ZTQ7GjHe9Ln62Nw33rccmDQwBJ/0A3cDQC6GuuzDkw8Ww9gfRVGq0+9X3p?=
 =?us-ascii?Q?u0nMegzsjCFqzyX4kX9mC52vVF+iA8gorjRdbuhpoNwXXql7WvwAsSuFsVcA?=
 =?us-ascii?Q?bya38RFfhA7I7ZZBHXIKRnKe5unlXO7rHzrLjGTkQne/OGLwsaXx/gcc7lVy?=
 =?us-ascii?Q?6/raKucmT65BIZttbEeYFdpPhHWCHiRrIatz9k8IUOW/7YESjTUyztZ3SPyi?=
 =?us-ascii?Q?HEOFsMGPHQVhSbpyLeI0fv8nDTZY2meeVdxdF+qe/PqtG3PYQyMN4E9dMJ//?=
 =?us-ascii?Q?1FlkXl6AVjYp006hW5WmWHzJmBnjo39xUuqOdw2iAXhaDsFbq88w5+yfuOLW?=
 =?us-ascii?Q?dc/d7cdioDoaGURwOvPAVH7C7V3lFRSIV31r+YYVWJz1GsKABnYP3xjk64kq?=
 =?us-ascii?Q?X5iDjxjx0S4kXMMYsHrJkQt4CLVPWb2CEi3WbBZq?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1358c7e1-4b12-48bb-08ba-08dd082712c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 23:16:47.0200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pjDl67kqPEgI7I6iyQ2hgdwEWujIgjZAzlCopKQgM0Bzir0uOiTw0CCZKLumEYJgBWGR9bKEy0ttEZvWjt59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5275
X-Mailman-Approved-At: Tue, 19 Nov 2024 01:22:52 +0100
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

Add documentation for PHYTEC phyCORE-AM62ax SoM.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 v2:
  - Fix underline length in phyCORE-AM62Ax docs.
  - Explicitly define build steps in docs, replacing include.
  - Verified make htmldocs is working.
  - Pick up Reviewed-by:

 doc/board/phytec/index.rst          |   1 +
 doc/board/phytec/phycore-am62ax.rst | 183 ++++++++++++++++++++++++++++
 doc/board/ti/k3.rst                 |   1 +
 3 files changed, 185 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am62ax.rst

diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 99848a9e958..697aec30512 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -9,6 +9,7 @@ PHYTEC
    imx8mm-phygate-tauri-l
    imx93-phyboard-segin
    phycore-am62x
+   phycore-am62ax
    phycore-am64x
    phycore-imx8mm
    phycore-imx8mp
diff --git a/doc/board/phytec/phycore-am62ax.rst b/doc/board/phytec/phycore-am62ax.rst
new file mode 100644
index 00000000000..0c5b4814fc2
--- /dev/null
+++ b/doc/board/phytec/phycore-am62ax.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Garrett Giordano <ggiordano@phytec.com>
+
+phyCORE-AM62Ax
+==============
+
+The `phyCORE-AM62Ax <https://www.phytec.com/product/phycore-am62a>`_ is a
+SoM (System on Module) featuring TI's AM62Ax SoC. It can be used in combination
+with different carrier boards. This module can come with different sizes and
+models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.
+
+A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
+is used as a carrier board reference design around the AM62Ax SoM.
+
+Quickstart
+----------
+
+* Download sources and TI firmware blobs
+* Build Trusted Firmware-A
+* Build OP-TEE
+* Build U-Boot for the R5
+* Build U-Boot for the A53
+* Create bootable uSD Card
+* Boot
+
+Sources
+-------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure
+---------------
+
+Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=phycore_am62ax_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=phycore_am62ax_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we dont use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62ax
+ $ # we dont use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+2. OP-TEE:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 3.1 R5:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.2 A53:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+uSD Card creation
+-----------------
+
+Use fdisk to partition the uSD card. The layout should look similar to:
+
+.. code-block:: bash
+
+ $ sudo fdisk -l /dev/mmcblk0
+ Disk /dev/mmcblk0: 15 GB, 15913189376 bytes, 31080448 sectors
+ 242816 cylinders, 4 heads, 32 sectors/track
+ Units: sectors of 1 * 512 = 512 bytes
+
+ Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
+ /dev/mmcblk0p1 *  128,0,1     1023,3,32        16384     278527     262144  128M  c Win95 FAT32 (LBA)
+ /dev/mmcblk0p2    1023,3,32   1023,3,32       278528    1693883    1415356  691M 83 Linux
+
+
+Once partitioned, the boot partition has to be formatted with a FAT filesystem.
+Assuming the uSD card is `/dev/mmcblk0`:
+
+.. code-block:: bash
+
+ $ mkfs.vfat /dev/mmcblk0p1
+
+To boot from a micro SD card on a HSFS device simply copy the following
+artifacts to the FAT partition:
+
+* tiboot3.bin from R5 build
+* tispl.bin from Cortex-A build
+* u-boot.img from Cortex-A build
+
+Boot
+----
+
+Put the uSD card in the slot on the board and apply power. Check the serial
+console for output.
+
+UART based boot
+---------------
+
+To boot the board via UART, set the switches to UART mode and connect to the
+micro USB port labeled as "Debug UART". After power-on the build artifacts
+needs to be uploaded one by one with a tool like sz.
+
+Example bash script sequence for running on a Linux host PC feeding all boot
+artifacts needed to the device. Assuming the host uses /dev/ttyUSB0 as
+the main domain serial port:
+
+.. prompt:: bash $
+
+  stty -F /dev/ttyUSB0 115200
+  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem tispl.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem u-boot.img > /dev/ttyUSB0 < /dev/ttyUSB0
+
+Boot Modes
+----------
+
+The phyCORE-AM62x development kit supports booting from many different
+interfaces. By default, the development kit is set to boot from the micro-SD
+card. To change the boot device, DIP switches S5 and S6 can be used.
+Boot switches should be changed with power off.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW5: 12345678
+     - SW6: 12345678
+
+   * - uSD
+     - 11000010
+     - 01000000
+
+   * - eMMC
+     - 11010010
+     - 00000000
+
+   * - OSPI
+     - 11010000
+     - 10000000
+
+   * - UART
+     - 11011100
+     - 00000000
+
+Further Information
+-------------------
+
+Please see :doc:`../ti/am62ax_sk` chapter for further AM62Ax SoC related documentation
+and https://docs.phytec.com/projects/yocto-phycore-am62ax/en/latest/ for vendor documentation.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 5d01f487622..0deb4d768f9 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -46,6 +46,7 @@ K3 SoC based boards in other sections
 * :doc:`../beagle/am62x_beagleplay`
 * :doc:`../beagle/j721e_beagleboneai64`
 * :doc:`../phytec/phycore-am62x`
+* :doc:`../phytec/phycore-am62ax`
 * :doc:`../toradex/verdin-am62`

 Boot Flow Overview
--
2.25.1

