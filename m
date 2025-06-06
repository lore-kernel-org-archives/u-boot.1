Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2FC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F8482A9E;
	Sat,  7 Jun 2025 00:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="00F1zYjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435D482B0E; Sat,  7 Jun 2025 00:31:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F0A82A8D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV9aGsdeWXiURICwI5iYBP0wuw2ds6cRohG26UdWCGRb7J735030rdkuiwGDx4bJ2+LssO3ifNHuu4cts4R13vVQ0yz7yG2gQhCeanb5JTlpZeEHAmhMVcTz2DaIvKRuw4w9LJg6FVBQXovEAGCBz1PV5ipo70hXwyS4Ks6DeoqQ5t5ps2ihewSLx9e1n0gaBIahfw/xIAdiKNad96z4FpppssfwHCVaqFnULwifb8WT8Rrj6iNiYbTIqTgfae1HjWAeQbBdZjNj7XvtKgIxxt/J9mYl1o7fHSV1KyNKR6kmSZ6BFNty6vBKE6fAIS2BEdP7T0ZmGlfRf7j3udSUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV079d6QB3ois6EEbVudkyUYz95onb20QcqZL4xLxrU=;
 b=XtZpmWZa0VB56L+vw/FPq709Z4V+wzdjtPI5S7NTRtsbYkqDNIObWbvZ/lFDDod4iX8HuQog5/nprHO+zfYffrfD6NUqYgpTefgG6SULWGhTO1pjv0XBlae3yhd6B4O3kwShPCvlQE7MHGZr4c4ShLgb8WHbIKHEuBRSlWkMVpceH07f0VjXxpqpFYgXz8NAkmOdIEts86BfCASd8zq8xAX60e90JSCZY1xPYhg4cd81rDoW7mlOQ4TpHZ2cMfybq/nq7jqPT0fcoodiSNU0HXQ8ZqtdtXEwb4fkk51Q8QYSbMNJaE+k+YQYcX9AFQwEh7VVrVA6U5C8SyXN3p6QEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV079d6QB3ois6EEbVudkyUYz95onb20QcqZL4xLxrU=;
 b=00F1zYjsReRvUvn23ioP4hLCuVysY6UV/XGcuz84lmN/1OnFVhiypYcsztO7XHhDCqDDnjdmyEC35vAXaWa7mr4ibpz7NoyrZVsr75OXogE7zlT8QKL9RKbtp5Gs9K+LHi0QMcliy8OhucJe0Wb3QfR6cIgeROQ3bBxHzC5hV+/vY04V4tMPgZJjSeHm0hfdj93QWGQYpa0LrKA9iv7kBxwCkZ6QMWW6b1ZcnB28R2xrcsDzrfrTcJL5ubwKeWmIw+Zoa/vZGdtqa9mrAR7AAlKWLd6PVnwnZPuiDWGJPQwMsDMJSkYatd6oLCGR4kSOHENKO6LDagFE7ZpZNbtgww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB10377.eurprd08.prod.outlook.com (2603:10a6:10:3db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 22:31:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 22:31:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] common/spl: handle properly images with bad checksum
Date: Sat,  7 Jun 2025 01:31:08 +0300
Message-ID: <20250606223109.502055-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1bc0bf-61d2-439f-068c-08dda549db78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qI7iGZ54WTDPagt6gD4n72CGOOrH2tT06hAl4mPX/rMcIgaKz5U1jPyIFrYp?=
 =?us-ascii?Q?OwSSnkaC815COdDpCqfd0XZLjlTujNBHrQnUv1R0kzS/xu3ZMRyj7ZSdr6XR?=
 =?us-ascii?Q?3ID9Ug0/pBv4CfMXPkmj1XqppRtDetU/WN7bCo6vh6aMp+bXMfQavm+hdunl?=
 =?us-ascii?Q?3785t71N5yyvw6ZrxQjRBb07YenWAnQEl5aadEaPeCYIfZIcPFwVWBvOw6LK?=
 =?us-ascii?Q?CeYtGqmlJeI/AWbVM4DjZdUeUKETW9rO3Rqv9FcNGG1eyHilkvMs/7iz5pVG?=
 =?us-ascii?Q?97XsKe2dDzJNKvCvWW0jZKH8N/ZKTV9LmaSV7i7R160fypleZRPf1tUAGaes?=
 =?us-ascii?Q?vbCpQHDPUA/pYXisPazkUKpMNz8xe996BCf2McRs9L+yyjek+VRaoeEzIp75?=
 =?us-ascii?Q?l+Z11WKY/WjXS7pCV8DvEf4ALBQczHgaH9/3/g8HVbmR5biBe4uPUnR7MwgK?=
 =?us-ascii?Q?6jopYWzJRKy1KDUffr4F2rdcFxKDngLGAnFAfX/aRbNcwVg69L4OdVFx2NPa?=
 =?us-ascii?Q?jX7jG2qAJt10iYnGzWIK0gdYvkubgHyK4pYCFKuirCVJTiOPJwp4lLluqg+X?=
 =?us-ascii?Q?F1k71v2ktK6luQFYvkZzQ+YqRvbTjmo8ZhgSH5P/r+AaKMbHnfA5zwtMdwCI?=
 =?us-ascii?Q?8zOI1gJVAe+OO0rpm/w4WgB0ZbKtj71qPVG4kfPnb6/i7cnEu4iWn5ZM7CWP?=
 =?us-ascii?Q?UdQZmd5qoJKWn6+5I33RbZ9Ih1DygvHfUWX2Y00gfFOHxl7aGKjejuvFh17j?=
 =?us-ascii?Q?E6Ffq+iNEEaON1rh0q5bFvb/kFUpAWT1Nh6IiF/OaXz4j85GUM1CdOtmC/q8?=
 =?us-ascii?Q?Io4eYQdtJmcxoNQsHFQf04q6PMXqEBStEaoj/T5zbJLMei+Iuu0GY0iwEh7m?=
 =?us-ascii?Q?R/DpH5ZamRjSc1UvdDB12a3pvkhgr44iW08bDv95dyyuELE8F/HjUjG4lCHq?=
 =?us-ascii?Q?Zfb6aCc4cJdef02fS//aZkyVaqhJXW59jOoFQHJ9541420bDtotEe2exbDnz?=
 =?us-ascii?Q?2FwJI4RD8T6ozOu3NRThpAR04XEbUjO/CzprRiFfDwMQAKvecHYGVlkogmMj?=
 =?us-ascii?Q?JDo/DwpyEVQFVaOL6BGdTrS1BzR4NsD518U7kjpXRw0qVxZHsQVsdFptXdML?=
 =?us-ascii?Q?tYMJsr4V+lNyUvZ705+t+zHDsCZKdJmMSrEFd6W3jPCWHt+kIGxEn0gmWStU?=
 =?us-ascii?Q?Q3VffuJj6l2U38Qraw2h2YhWr3DATQMKxNgrLRR+oSQ1WW5qLX/FMOGvkjsa?=
 =?us-ascii?Q?9DVauJaCDqc7zaiFwyoU4iwVZ8+kfrszaDQ4mc1gbJ8JdK4je54PllxWVXDz?=
 =?us-ascii?Q?Tj62hDJVQ/XT/Q7XZ29nL/OABAvcOdh//nKkY9u2ErIMVuWfmFP1u+k/QK2h?=
 =?us-ascii?Q?n7GrDyqtdb0yBXEMVey7fJ5XSZVK1X2aVYxzieGmJ+vMWzeYan8FGmYJMkNO?=
 =?us-ascii?Q?EI2kmtRQGURf1xXw2a0tScWXL6NmXF3k/eWf5A9C0a4M0vZ/NFWCnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xu8rQHfV4pE014LPzAxRr0yTLjye4peUlOmmr0vquA1m2L1goEjQI402zDRE?=
 =?us-ascii?Q?KNNFWMveIHLgXWWyXkwRQ25zLbrLtgWFkuO90KZis6tkNIw7VTk3IYWbiDGY?=
 =?us-ascii?Q?rl4ZeAcYg1haGSUCN5xNtlyEbYAu5wP1/xUZv8SEOmzP+E2cIJlEU/JpP064?=
 =?us-ascii?Q?3GmbV89Ab6ihU52iQZjvlJNLNLrhkZByLXkDcV/DCEE2CIcEIqFHb4iO4vjH?=
 =?us-ascii?Q?BYGyuImDWHFumI6/6UnuV1enIJXsSubUrPThCi4rqw8pfKkjcKfoEzhQ+tH+?=
 =?us-ascii?Q?VA1d9FpnRD8uu5n867YGYrOW/r5d04qYO2ysoMM6KS3OQtkDs/Ot9erGE1Cg?=
 =?us-ascii?Q?620loI9b4Sc9ktHM4qh8ppykWN5VRVf6M17iaXuyM9GOCu2RxptOEoQf9uWX?=
 =?us-ascii?Q?3XXMFcc0XQyk4P/PAM/pdXVHKKnnn8Jza1XIZ6eCeDnR3JwcvZyKRQ45K4sv?=
 =?us-ascii?Q?WhA/9F9bnoM548/wk/FoD8OOuNlWKvCiWe2PvLohSLQ1Sl3T62fkEHhn2ddq?=
 =?us-ascii?Q?unl5WAZ25WnRx78i3Zpv5TycqvnOTZ4CyizvF/QuVB47mERBYP5zKyamcjbk?=
 =?us-ascii?Q?jJ2bdmFdUOzBFBwZ9b1HYunu85I4dDc/0XZu7gNhOJUm0KMM9lDzcBVx5g5m?=
 =?us-ascii?Q?fnBvdjqDeGCMOr4NSI8OurB7NmASFK1WRp6heYhl+MIEEDCXXfpa5kU6g7RW?=
 =?us-ascii?Q?CTyD+1EUGlRvTBLFBJZuzHHdNsK8/0quBnSENjYqAvfsT0yYtIM91pTKUU08?=
 =?us-ascii?Q?6ionwrfyHdIgFawnBe7JjjaXk/OIQsVbk81LrUmKicXkDevE32qGoVzxmhZg?=
 =?us-ascii?Q?4SiPX7wnGtdGULaCndifTG9BUdAgf/hzPKKFfvWRDsCO94dr4BfJ1vfKLpD/?=
 =?us-ascii?Q?Z5UM9llLIfA75G5ViPe8HD/mOe2EoatJGi5VPWODPrnp2JGZxWzpLmQFZTPH?=
 =?us-ascii?Q?48dhKhqcMkW2N4J7UY0cJ3onr/nSZ2++vsErdrD0p/QRIZd1u8ifLHsozTBR?=
 =?us-ascii?Q?d7FMQcKjMU3YecMdRP9sVwT8faUqZEjGBktxN7Temx3ddChK0h/MrZ8ybjKA?=
 =?us-ascii?Q?HgN1xU/v7FQXsPb7HsgSOQNPKFyj4TWWvFbbViw7SS7aqCtihbPU/+MCl9md?=
 =?us-ascii?Q?W34Par5WVeQ/IFZS23JQ1DLFNLalhWh+J/6ke3nq532S5es+k3U13Al6/9kX?=
 =?us-ascii?Q?3qNGfCGz04LYONebSjuAXGaDdZZMC1BRIsRN289wA3tmiFXVRzz8/TT714d7?=
 =?us-ascii?Q?F7Jo3jZCvjGcQa+PDqzGm72IhI31an7yG9EIcjMcjC950CN2Kx4lMkeC0bH+?=
 =?us-ascii?Q?8Wsig4FD19rRhBDVZz3lBhoeupQ4c+VEkj7O5xYKFbAUHu4M0uJVXGaeys3q?=
 =?us-ascii?Q?z+k0YuzBVMZ49b9cvAlZfhSOC9txG2yqyN3rnQ+Bae3/lzxsUPfue1ci1qxf?=
 =?us-ascii?Q?iM+4VYaQxE6/uEIywfwCR+i3GPyDwiSk6LEkjk94mAxHgWFFfXhc4u6kwYqw?=
 =?us-ascii?Q?dyNEWrltVw4kRpqHKph1nr3ZRTJU5L+/nanipE/Jk7L/H6oW+ivETPJ/LMGr?=
 =?us-ascii?Q?Ej1vb2keqNf7RMzKOKxlw+z1hDn8s6tA3rVnYjcEAv0l0WGWshhDuHEap1mO?=
 =?us-ascii?Q?SZVSSQ9FQfPuxkXKrF1AZdg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1bc0bf-61d2-439f-068c-08dda549db78
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:31:19.2099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LNW66PyATNyiALacNkoRagVbGOjBcLJddkynkgOpU92N5eCnWEXU4Qq4IJ6SJGAac9d0cIEnvQAj5vdMS2QOr4InKIzvhvY9Z/l9GDMxUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10377
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

load_simple_fit() returns -EPERM for the images with broken signatures.
Unfortunately this may conflict with image loaging selection on the base
of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT").

Thus loading of

	configurations {
		uboot {
			description = "u-boot";
			firmware = "atf";
			loadables = "atf", "tee", "uboot";
		};
	};

with damaged "tee" image may finish without errors. This may results in
board bricking. This should not happen.

The simplest way to resolve an issue is returning the different error
code for the cases of broken signature.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ab277bb2baa..783bb84bdb5 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -322,7 +322,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		       fit_get_name(fit, node, NULL));
 		if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src,
 						length))
-			return -EPERM;
+			return -EACCES;
 		puts("OK\n");
 	}
 
-- 
2.47.2

