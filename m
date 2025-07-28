Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE9C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267EB831E0;
	Mon, 28 Jul 2025 10:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Y55knhCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D973D830C8; Mon, 28 Jul 2025 08:57:21 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE2C82F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ4KU4HxebzFMQycrK2zT6AzRkcCnZkJGfjqQOMTkGMbEnAJKL1I5sUBvCmQPH29nhRqefKnDJN6qqV3sI3xQd3BJ6l1y6v6UaHfki3LEvsjdhV4pecLXzO5ZwUT2/eHh/pHes8HJbViEQnYfltcZ6rRi86zjnhiwUfsQrumBeoBYlYCImv4w8o7BzpbIM6kNEVgcM8HrfEVSwwly3wxAWRm6vt8LjRJEydD4L7heTt59CbSkUmTfVrTjH65gSrqQxUORYPdiWclBorTeSoMUm/kW4hwer4bXtrF/ZBtCH2O8X2deg2UJsI1k9AHJ9uZDmvJqYFGkDXxDuyiggbF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWD88UTyoYP8O+BHbGqrk4cPRswnVkC8+tCKPcN2qII=;
 b=J0UoC41x7bO4txMs1LbDG+HvmNoYnsUhruPrrAThHIcuNGOHVxet/pgCtXyRtgvlP0dPqahN1rhU/Gs5R/9M0Ucm1BYVVV1lS3vJQaFfWwC4jXzXBfxol4RyhG25pTYekpvoKH7H1JU1izLFIWVEMNlQ6XqIt/wVALLkh6qM7ir2mqh5MuDd1zNQktxzQwBIymvCtyLdXqwuITYBpPoi4ZvjBHR+dPxy5YzjgNZZCF3BjJ09LU1vRm4QHNpC6UXVlG3881UQ8MAutALZAAoTATAG/e/vMz69U6mEi9ZiYVQpHgWf/1h8KPONntfiWJXgTHcXyHzpr0xvmsKjHPbQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWD88UTyoYP8O+BHbGqrk4cPRswnVkC8+tCKPcN2qII=;
 b=Y55knhCF+i+wkKB1X6asgMLgGtqiit3vcMlpMo3BPRyZKdYmKxfpLBeBrl9EjaXp9QMxueBOyhgxZJoph0ReccmzziR9ax2/4y7K/12NvHcJUo7At4jfKtcZLG69n7ZL1pP75r1WZhjYjj8vHMldF8sxZHHfr8pje90IQZl3qXRedFNetXlz5RbqaTlTLyxFBak+mA8joYkfDFVhRRx063TpAu+Evcj5lSdGNyn64ASJZ+boRwgWl3EfPow3sAFG1TyFhR3FPYVv9sddURq/pE+jW2JbcHYleLymRhpt1o8u7UeiMi+RQ/p1ZMqfmWtSo9fo345G+2jSRqR9ALUSAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:10 +0000
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
Subject: [PATCH v7 07/12] drivers: i3c: master: Enable probe i3c without slave
 device
Date: Mon, 28 Jul 2025 14:56:07 +0800
Message-Id: <20250728065612.6039-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b6164a-aa9e-490b-8ae0-08ddcda3f954
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4QF/1dCHRMM55Gpa+oqPeBihD+yMPaCHKZtVQNpIJzxktcT29fEFAcNEzUU3?=
 =?us-ascii?Q?7acEp8NVe7KtCRwF5SIVUYrISGSAH4NCLaZiHWjIs+ZNnsuXnY31taFZUpny?=
 =?us-ascii?Q?pzWYcvpanyYw/+x17ANyZjmmOtJydaafNRS20pmAnthRU1WMTytdXIQXvHyt?=
 =?us-ascii?Q?o4VTlCKWPEdln0MzwnPlIcHqUqxn5Zt9IPkHOvzIQxvK2GlT8PcapfxZERKQ?=
 =?us-ascii?Q?g2p+xeKdv6FcgXS4792hieWrod18G/Z/OUsGR9QtIdPyUNFJRqgmzQrKKqxc?=
 =?us-ascii?Q?XjWH4m79PXpvjtHtC3r56VnSSDMaN0hAj460UQ8QD1qxdMpfGhytWBTSDP9q?=
 =?us-ascii?Q?O+ODAcHwaHVpQkbeOIZfHXXguNu6DT6up74gv9u1TeSYCoa5X//FbiEG+VWt?=
 =?us-ascii?Q?BGNCN2Gp+32FfJXViSUlWCpyiwAY769PzX33NLBeCFzahmquSLog8c/d+BYW?=
 =?us-ascii?Q?5+h4pqGsev36UCeIb32VWeqdFAfaXFiDN2sxfmrKgaR/wCyIeWiHN6L/ygWi?=
 =?us-ascii?Q?EC6bgk2KMS12YdbgfuqkEuknKUoriigV8OGmwSz82HPR5aNq0eUgu77181e7?=
 =?us-ascii?Q?IxBUAD6O2+4Uk+J1CD2zOtew4/ZoHjI+DJ8pIRNcqcnYJKKMYU5Ky5cWH2+G?=
 =?us-ascii?Q?DFoo5q9HDBM2qb1sDqx/AOszHPLulicXJ4xrVSBKWq0G4BpQ86wMzqLTUspo?=
 =?us-ascii?Q?4t0lfWBps4v9mq6ZqGc5ODOkwSIWiLQk+myEMejg+QXH7y8VmpaXJ3jvjVvH?=
 =?us-ascii?Q?wVBKH2HZ2DzVDUTwRKowAQtKKkkiMQ3B0l3WVWcabR8vG3RhsFnCI7Y1vjgz?=
 =?us-ascii?Q?W0T42g3mYfPyoe0eoeFu5TuK8Ilc4Drd4gtDdko/oJZ/L7+Zj6RJuG5lJupD?=
 =?us-ascii?Q?M7qL2ZWUJnzx+xjXQXDxBOuABwpIwvDmIe1SjK+mzvoMMvDoWUtlsiMOj6My?=
 =?us-ascii?Q?J1QhPmbZ5E5klrHmC9VaT2vbkzzfCYBKLk7p3K6AKPHJmT2esd2oyhBlKHwu?=
 =?us-ascii?Q?8/ERMMool+iSLVE2x9hx9FbWFBFVuAmcsXN69rr0QR98QF7+tJTPFvYK06cr?=
 =?us-ascii?Q?UesnAUg8fo5m0BvozQAARMsAcW5IWt+h8EAU7e95QYyHLjswsvhrFe0b5Tim?=
 =?us-ascii?Q?sqZKbOE6a18Rp3qrogQQyNW1wee9lVW43mobFn2LcB91RiNxsORujx2+E8AZ?=
 =?us-ascii?Q?EnJrr6sMv73/nMRMf58LEofCrVuGEYxwPxjq13Ra7J0KzMd/frQ4jbJfrOLR?=
 =?us-ascii?Q?U/As3/IpcoseG5VFUebYrGaM6FWvLi9SVBeFyLrU6gpOOXyu9o+QqgDRYZ/D?=
 =?us-ascii?Q?eI0z0T45MGqw6c6TLURHDOZLTbDq9L8XT+1YBv0BNnIraH6lMGcLbb4gsYn7?=
 =?us-ascii?Q?2WEdhNyj+GwP8X2IUnfxo5yJ5PN3HexO6dPO9imUsOhek4vlnlXNyxprNG6C?=
 =?us-ascii?Q?Q2xNJ93sVQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WLONtDQiOvF98RhP0fVMSaYkSZcIfGTpj0xUt3IZaMl3/+IrCZ7stdbBXuAD?=
 =?us-ascii?Q?qUaXTh1f2QxKzN6ku0T++GOkh4Yul1D0dJRa08dlcmMNsbEaYzRqljOoxEYD?=
 =?us-ascii?Q?BbENRQaO6j7XoHqozD+zMK2IFR4DtWjDa8e3Vztisy6f8W/1JxNeTRCosHZu?=
 =?us-ascii?Q?C9CLVPq6JeIanw9hjj/42JLloD3hHKne5o8qAnlfIcblJlLMi95e0MMORfk5?=
 =?us-ascii?Q?L+0mLUzuwg/7LlcWvVOgv49q1aDBL3TKEZ2xGlGnqhJR9Bl5ni5hyD9K6Y4h?=
 =?us-ascii?Q?7ObKs0CmCnYlI34wikXrpsz4UR5jbUkNY/8kKYTNnKnV4ToYRu2UcYvjurET?=
 =?us-ascii?Q?HbLPkKnvspqavP8qS9yT/1FO0ZdkS3v+H2nSnOIKfv3CFFI7jR9t6DMraUAE?=
 =?us-ascii?Q?FF1MVdxMiHVUDOPTsryxptC6y8+My6Cfq2Qel4xqWZ0EOWXh3BfAp5Cpu0X0?=
 =?us-ascii?Q?fkOgg/mtmB8rK7CwsElEosaOwJmXaTCuAXRHFsD2z1DpN468tBYIXcxLlFuA?=
 =?us-ascii?Q?sbFPyNYCoGTE/InoofTJJ6mPrFBz0KxW4NYnNG6SWw/8aWRf5ONcAGa7mSGH?=
 =?us-ascii?Q?LgYY3waR/BQWSSc3hLVAAu8zLZD9wnEikwgl6k7yzXj/KYyUtGQvA4zlJZjs?=
 =?us-ascii?Q?cqzLHD6ojc3bENK88ho/8Klca6vpN3dvX42uOZskYpUQT9CRkOT3P3HtaIRr?=
 =?us-ascii?Q?zMWfzvGFSNQ4JSbPTfxxIhV14AiZ7kfYjJ0bYmlCaMjY/CBNRH00KZigK9y5?=
 =?us-ascii?Q?YqBvgI6b2fndVVm35WjF5TPBSEOczTh7yo6jCuyiP7tMJ87i4bbnFZ/1Nj/K?=
 =?us-ascii?Q?5dOzNnV24HlrjIoosW6rdY4lwIDNnPZaE8T8ubEHsswoMfampWlU7FLLY/tc?=
 =?us-ascii?Q?5OGj8v+DUHRgr6JDchHVwRDv8hU0pOcHENHxIHBmMWXvA3OD5JO1Mn9Uu5UV?=
 =?us-ascii?Q?RJOkYAo1Um4sL2pFceuXn5+p+lI0oU1KrvjeZa7dOJqVrIXeWKXZ6m32glaq?=
 =?us-ascii?Q?/BfhZPoUDUkTOcPw3cd5zqszL1miwBL361trwbp644tH4sIefbD4oFxbYuc7?=
 =?us-ascii?Q?Dv1pkwzuJGwTxxP/g0XMVwMDT3tCB2k0UtgUvtVjWqIGbuHmAlwwfl8sgIx3?=
 =?us-ascii?Q?DHdM2bYs6LUPxpjhOP4fQpDqCbSklbY0OoOEUNLc8BBpFlhEz0ZTB1zOkDV3?=
 =?us-ascii?Q?nm7YfXw+xIZop4gEyioFZL6gDgg+LfOfGL0BG/veYNFE7QNamp5cE4YS3csO?=
 =?us-ascii?Q?j+GuVxpXvHQgqv0MymfZaviDLJZuFnbpF04Gm4t8vWdv0cNaQvw/kFmw59hT?=
 =?us-ascii?Q?EAUuQV5i1eGWcQxCgYagQSsIxZLxaaXGtffXzKGGevFqzKupi9Jv7cjPHBo+?=
 =?us-ascii?Q?sG57TmxjrUrqmg5c+/ekYSk05o0CzjTPHt9F+PE6GDZOtnd8EafDch263YNK?=
 =?us-ascii?Q?LzgoVKwxrfMeqhr8gm4egD70QhECoY9cnyJpL97cbNSVkD52E8PeSk7IkKh+?=
 =?us-ascii?Q?D242Cm/lCC7xamPCK+Pt3/nihONEMpRNfZXhayKBxgroht0gs+VUP66irYxr?=
 =?us-ascii?Q?IzMgPC8SBBKxNm5zqMBK9+tFFrHtv1g1RW8PTz8GMP/ya1eKc1ZPGELQblhk?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6164a-aa9e-490b-8ae0-08ddcda3f954
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:10.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7CdI+0SmYTZP4x7M4Bkt5ukpn4mVmqa3kCv2z4aizGEuVb3UtlrDfXKLTZbtgAchvF2spKyikr26MBDF7prUpNnY6Oc8XiwViPt5Z1YGwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index cf659c040a2..019167a2dc5 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -452,6 +452,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -507,6 +510,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.35.3

