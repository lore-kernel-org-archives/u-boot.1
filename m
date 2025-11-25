Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D48CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108D683F8A;
	Tue, 25 Nov 2025 09:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s/Bf3prK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D89F83F87; Tue, 25 Nov 2025 09:13:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA2283E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6x1oA4sxL7mU7ltDjMNGLh0+xnwyRuum0/6IgAZt7po8x8e7R7oTo5zaMai4uSWiokLm7yJgDFwOls4cTaxhVa40NMS+XRNl7ygIuZZuMwUUhtFmQMQ9SLGhm7DcGThlL3IU2OhSFvlXfMsdCFhA4ihQFiVwfmWQNR2pbLxH6r/NB+SLVYVbDaBcddakCcrpF1Lw+UV3/VqJLIeM2Rt5NRWiRTqrlfF3In/qHrD5uuV9wAmwPpY6MAokemyjV0TsggoxdxvInVDIbnwQhmubJau1TU8PQ54oXoFw3EsFmTIeV/ei+nfN8me+BL3FkwP9lHOSeTVaINCoe/gqrVpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF9Rgpbm75/sFMBQ/ALKihAFozBoO6U0+bgGF/aUsKg=;
 b=ff90r5ykuRIATUmGFppEQjWOCOnPTfCv+Pb/AY7ObWEpO+RVy3Jf0qs2X5HPwna15PkltB0Xr5Wn+MHWCNAehF5/leXovxSWPZf1UN+qOCKQRLO77PoFHDVxshrCjFImHbsF6NOurVWHeGdIhK8yD1Flb0VRHCptLC2BWRvVRuiaMKEo3RQtHNvHRt1AUxo6dYHX/UXQra6NUL+Kx5LfWVeFw+rp5KosGuw20PTRHE4Vb/soSj6ARbyD8aBR1jHS+hmAu70bgkT4NHTIfShctPoHT4kZw2GiKUljGadE9BYrL/bkaCWeabimJd+I9jw+C0P7LCGnvyAkoVbJ/ushJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF9Rgpbm75/sFMBQ/ALKihAFozBoO6U0+bgGF/aUsKg=;
 b=s/Bf3prKZsM4Vwn1KG3sFThSK75GKwTUAYMn+JxbZ7cTRS6OWnv7QAU4MT40k20tTnMBJoL8HreAsX3iIeF/XC0DakMtN6R7IZZmWsp4TUUbSGaQwG1nINTamF12HOz4bwFoEjnoBWqn6t4+Qsy8vk7clg1dCLnfZsJZ5sikA0dg6tsBpaWdEerihaJopB7RX/ZrgWp5AioyNSzIPTymR9O1hTQDK7dVfGcq6Gd5NG+KebaYRDEX8dYqe1TEraVLid2YjcQFpaYkn4q5Ly372YjaE3MUUQk8OEJ0y5kGhKfMGz4RIpJAMIvY6NCp8jEpZ7k5QvDDLGTPe1k0XucwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:28 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 1/8] configs: cyclone5: Disable mkeficapsule tool build
Date: Tue, 25 Nov 2025 00:13:09 -0800
Message-ID: <20251125081316.17329-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: d84b691a-ff73-4f14-6338-08de2bfa83a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gmPsAF9pm8VAw7DuDbBODxemICusUKxI3V9nw6msNS5ORoabcA3O3lL1sk1W?=
 =?us-ascii?Q?g1Es382Z4oVLsw7RWlHgbt3HpgikrhYSV7o6u+8KK39JWmpFf+tbgsIbzx7K?=
 =?us-ascii?Q?Pfz9l066UOAg+2e8cntc4Ot+ZKE5HVt8LmWytexI0yq0QsBktpZ+JsHEAbcf?=
 =?us-ascii?Q?iyRACcgj+8tu09XBpKzNFbi1Ez+QmwRFRW0l55N/Tre95agJFiidfro3wSlP?=
 =?us-ascii?Q?GarYxFI797O3yHfDDMgHwzwWG3SE/5MnoNSvBgpc8NRH+U9mcRYcy60bakVv?=
 =?us-ascii?Q?+XMfbf21F96A4Rg3Wkb8SLF6P2trRi6Y6qvqdjzLHl5Y/j9q2WqD0I1OISbM?=
 =?us-ascii?Q?NhLJSWqazKw7IBTGTgZ7wqURCgxhwJzgpXG3jY3z4Z2FQ640EWNL0WnuupTA?=
 =?us-ascii?Q?eJqns3bRpgfzVqS2miTkDBZDSVjcGtNyFclxpWAxu6blfODSbTHYpSBu/4Rq?=
 =?us-ascii?Q?yt4FepDqehYlh1yoa7bm0N1SUmjZo8JwDwzq92auhmcCfL4444EivahvCIdT?=
 =?us-ascii?Q?YzcCmtYTMkGi9ZNOczBXV4sEl6EXGA9lr9y0RvGZeACsEp/b7toipKdxC8W5?=
 =?us-ascii?Q?nGC/8NkaJk2UQT/AHNJ2nJebBAuayyJodUChh9VfYxYMMIJNXdE+G1xlysk1?=
 =?us-ascii?Q?qb1IPrvXEoTVvpJ2gYm9K3Rybjgfl/CGVUfUwmcjCrj+ubXGAKFBNvm+/C8y?=
 =?us-ascii?Q?fxsWWFdAS+vfKcruj7idOSdvT34mtyIMVFLqOLs0/lwA7ta/yAInPyWRUCMS?=
 =?us-ascii?Q?I8gwjZCajwxNQCZ1bZf8sxLIRedNn2ejfILf1az91HVXIsae74Qb0Iva5XL1?=
 =?us-ascii?Q?4cOT2GgHFq8GaoBeXaYYSHKsK4LmA4bQQrtEekzmy7wNqpoYI8ScYEDnR8iC?=
 =?us-ascii?Q?f+QH9zZ1pkyqSjmtMbO2r/PVt/yV7KXpF+zhmp7PAmDxEGJXSyD31jgi+TAQ?=
 =?us-ascii?Q?5UtZp9TdhLtM0FTcQPyYPdmCuo6hpD4CdB48f0taNDSTf3Le8Qxma9TRrdPU?=
 =?us-ascii?Q?MILbp3+ID/muevqTFIYOmiwRUUODFS7CZhEKKb8scCxLiDfH14QN72nFiSQT?=
 =?us-ascii?Q?PatdVTeZTGs2d+bXlKcwLYXQ2KpsIIwKklbgkDpbqVImRZjshxYRzzCAWJJG?=
 =?us-ascii?Q?kYIUsZ8mR41unJpkyA1nLX6v32Ur/jvPsrsY4Zcinlbzh3OXjpIot4loLWet?=
 =?us-ascii?Q?iYHAB21zyDKLFbNewGv+RVO7Czuiu4Bh0CwRAHOjPdZTSTseD1qDZgf0wZ8/?=
 =?us-ascii?Q?gjsn5SFc1SKlH9wGXoYt5pd7fxhEJlRPI7fQoGjJv9i4Uciolyp8H4izjI5n?=
 =?us-ascii?Q?EbkZ8RNhbRu60qxHASRGkEhu9TuF1XZ2jw/lM/ZE0ztoBkSwsHVgXFqOOyc2?=
 =?us-ascii?Q?ylh0MHppsXC8/ynTMgV/1KRY2AR8JuhV5CsKM0IzqknBFMGqTormrH+g4JY+?=
 =?us-ascii?Q?JzwRa6CJb0gx5fdN4NP/Mwp0P+tiWWxS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rS8WXqQv2qKCgAfzhImyc6Mofy2OZ5dPestEv4r8PhSVfUiT4cUMn7ABNsi2?=
 =?us-ascii?Q?dX9xGN1aI5nXo6jcvUu5CgoOaURq+fm4PgRpFOu9lFwzOIT6n+5OulnVulS+?=
 =?us-ascii?Q?EhvHmJDXvniISYsmXNXXQnZqPVz+aHE5Kcjr7UX2wL9elgEs+nso+PywCesm?=
 =?us-ascii?Q?iznRuRyNRBv8mxydR7BDz9uZqNv5MKPwvKZ/43DEnlzyeHq7xLHZIxPJjuEU?=
 =?us-ascii?Q?g052YdWOyF6GUt0ZEoWmRuEDdHcIBjQsFdDZwqs4Jm57YsNh/+0RX8rF1y4u?=
 =?us-ascii?Q?sFuu3QJqUa22QkcKLXEdchN9qd+tQyjk39rTWshJgqLqZxi+AJeo9InIIrsP?=
 =?us-ascii?Q?gU2G2Zn9war2/3Ak6i3n9+5K2PKkM2zCHJWuMyWnBq5OGYl3K/Sl70swPCYW?=
 =?us-ascii?Q?QcA2yX3lB9J9PywHLEr4BJhlW08nXjnmfeTJN2Q1PyLTLUt4kB3kAU/8vqCf?=
 =?us-ascii?Q?SrQzmyjAiXkKuMZkXfwurc/REAMP+wxoWhcsL5x82FrJid0cKjp1tj595c/i?=
 =?us-ascii?Q?WpTOiR+o7669oAvQwItdN94kuuZv1IJsSlCa7mdwLPPBVQlmc3gVLBshn+PR?=
 =?us-ascii?Q?J2l7xn0xTbD2UhXr66LwQbMBxM4YuORW12Div3emnB3mXkENCPwY5Sze3VvW?=
 =?us-ascii?Q?GSDxLhLdXNgUwiiJWuCnhjauPZb4vSq+9XK/V3AZ/77oT3BmymiOXKsWPoIX?=
 =?us-ascii?Q?JBdqV+oXRRcv9IOuXLY0q6mCR0MMAYw0HXkhk4hsqX4uHbQEd1cUX3OMfqtE?=
 =?us-ascii?Q?hYTgdNgx6fDjGREb2Vqryj4hEvXZVtcD1rD5hzftCH4G7lo0uMVXl/vXhv/j?=
 =?us-ascii?Q?sa+XWNhgzCvPRq3/M9l1W4kbV8QjTroYZiJEg6tnoJCJgcc7Hv2dpDSr/pxp?=
 =?us-ascii?Q?sPG0Or+0nBiKJyR4FLz/2LCIIbnUi/cMZLIKEY833fnj505C2NGi8hNpFFv7?=
 =?us-ascii?Q?M0NZlLFZg1WmUOiJx5JKSIx0LidHS6svwFtEtrZqloy95F44XVMg3VPuR+It?=
 =?us-ascii?Q?YFTejLo7pyDZQX6Q39F2MUsYdSj82kCn0hUp8TIlvNJacEBSHgLNdAbaThM2?=
 =?us-ascii?Q?kBvjR3/w5a8FWAvYqMy0CHLGzWZ818aVr+7rR43Hru2zf0GuHnbqXSwOoMrY?=
 =?us-ascii?Q?ssHw1fNF31uJM+SUrQ/8Xy+cBK6g+Vf7O6x/YhT8KC/sSIpO/P6eJ0yPJ58r?=
 =?us-ascii?Q?XqUowjEUV2snYBlNVYGX9dU7+RT+TOk6gg2J0Zc4Kla37w3ssElX7LJBVFzE?=
 =?us-ascii?Q?GiA5W6goRbZOol4iUAWdo313QICohriGVjrXFHH0eo2sID3zyIhoeFCGOMAU?=
 =?us-ascii?Q?iG4G7V5cydxIpdDAwzbxkWeORrD/9fmb38zIYQB+upsIpa/PPwYpGWqAsGB1?=
 =?us-ascii?Q?lQGk0GGtlhbHTk0NbstdGAPab5hWlCOfCLf5BKnfDsusNAlZF7ZlvmztAPBI?=
 =?us-ascii?Q?OlZPnnh+7lxp2NOcgbij9pZ6L9d8tK6XVR5C1J2jWLr++8l8cBpSJrxaUqxm?=
 =?us-ascii?Q?AA0bsxh9d7kiKbZ72wARvnyC0Jptv50FKDgkQmwtd1VHKiBxxwJ8v9RgYc93?=
 =?us-ascii?Q?m/ICsvCNGpg2Q8idMgGXTb5hmXu4oWpt4Kh7QRLz8/n3AlmoLgY5rEilqbLx?=
 =?us-ascii?Q?T9PDTBFLNQOU7Ce+T8t0+w0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84b691a-ff73-4f14-6338-08de2bfa83a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:28.4613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nFy5mefjqBcnHcWjhauM1J6w+UbyutB81GOWf2Ij2pTM4SA6fsAcn6dasGWf/pDeQRNcFIZSHa3ZJW/bFAsg4liQ0KPaY3FUIlPaio2V6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

mkeficapsule tool will be built by default if EFI_LOADER is set due to
commit b7a625b1ce49 ("tools: Build mkeficapsule tool by default if
EFI_LOADER is set").

This will cause compilation error on all our SoCFPGA devices, hence we will
be disabling this config as we do not utilize this tool.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index fef4cb90516..4a6f9b336cb 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -79,3 +79,4 @@ CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 # CONFIG_SPL_WDT is not set
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

