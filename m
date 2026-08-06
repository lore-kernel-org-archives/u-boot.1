Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D3DC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89435606E6;
	Thu,  6 Aug 2026 11:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rXpHXpI934j; Thu,  6 Aug 2026 11:00:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5C276070D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014033;
	bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0agdMF0n2Xpik9R5y8868D82MalGh2kvXle46148TSGo4W5f5suC5GDv1fypdNhQi
	 QCW3qIQWimKDxlFm0m6wdFxrxdjOo+Bm6UR8Vbi6zhchtoLe6/FRy0PZXI5OcSrWCw
	 nnym57rzybjveZiIQChBPQtsEhzozFXG7vuEWv5ega07ItrIhWTo1lt+Vw7HAWuiC0
	 +WUHctpE7IsktCYmqv1M6JinOD9vkFFHxokEFidO1bsVRguEtwnBNE+G+9Ot1NYZYg
	 YN3ZtVdIzsxhQQYWZ1EIJPK/SwrKArtkAowKchq/Sgz8cgp6gt2axcBotGtR+Tfg6f
	 7HxYFXcUcUUAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5C276070D;
	Thu,  6 Aug 2026 11:00:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA776198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC26380D77
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBDmgfnO1MTm for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:25:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c409::2;
 helo=ma0pr01cu012.outbound.protection.outlook.com;
 envelope-from=pratham.malaviya@siliconsignals.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EB88080D66
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB88080D66
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c409::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB88080D66
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJtVg4qHpGEYl8XV4hCjv19npSNcyL4L0HBIbqkP460WtwdXE10N4KxrD++K0sUDca5Xe9qIzY6oKnJF8eyJ0wthGT2TbIY1XGU3TrTUJjFSb1s1fwt8mrXJufeyOR9tcPEbUUzggzHF0kPASwldPooC6NmR5/lLfJ/FqjS9mnGEcNSaNCTepCGe3y0SIL3LlFGV/IBhTBmVcCAwDr4SlVzfOgzwr6mcae82rUYyvXZZXXedeQKQdrfUpFsWMSLUXmskrAGPdMJOW0j1aIf3hUHHtKPbedPZ9ztgvVMnpWvEUyLtJp7CeSaYi+teSOwOUSVg9S3++XvSQvOtz2Ob7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
 b=XsZ0V2CaEJwGqjprlequQVstr4Xlsf/4ABsDM46ItQuc3WAzCQhgudksslAewMrdbB792LH/h7I2aOpmCA5M/Y3yWHHHYr/Tf/we9LpP7WkyNCVgR+C3TTNE8fEO0BCS1yajruczmi9b+ORobGivF97MR1jUDAnr6/pu4rRmr9Uma5rtdKckPQ6QEQaboyl4sNRQFsRNho4KuP85GCwMtjK9xVvNXi/r4CUCx9JCQBhbCQfxJQ5Jmt1mcL/mD/GN19Ip3pxGVpggGqVrGsrMJqjSq8au+jN8NvuX0dk1EHKBPREGrDJiqQeWZO2bR27nreuFAxTxAEtsSznJxJU4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB3499.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:144::7)
 by PN0P287MB0851.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 09:24:54 +0000
Received: from MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 ([fe80::c20d:ef85:f70:88e0]) by MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 ([fe80::c20d:ef85:f70:88e0%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 09:24:54 +0000
From: Pratham Malaviya <pratham.malaviya@siliconsignals.io>
To: advaitd@mechasystems.com
Cc: u-boot@lists.u-boot-project.org, ag.dev.uboot@gmail.com,
 clamor95@gmail.com, dario.binacchi@amarulasolutions.com, ion@agorria.com,
 michael@amarulasolutions.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: [PATCH v4] video: add ChipWealth CH13726A AMOLED panel driver
Date: Thu,  6 Aug 2026 14:54:40 +0530
Message-Id: <20260806092440.457221-1-pratham.malaviya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722131626.77086-1-advaitd@mechasystems.com>
References: <20260722131626.77086-1-advaitd@mechasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0099.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::8) To MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:144::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB3499:EE_|PN0P287MB0851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0172c854-38c7-4544-b6ee-08def39c9327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|52116014|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ukw5TXrRDJkhZpfwz/zdEJstTD+OUuhC+cehpPzTeVaS/LeiD4GAsZCHkGt7xqVGGT++PXSUCZBKkJKqG/xjERzZTZAmoVJc7kPs+2cet8Goo+VDbAFw8YyeK/vXOuoj1xnIZz5Tz8EettMe6ZJH1RuoiO4OWvJUt4ISn+FawCzPdRheWdNCqiNNEw4KTKz+YgoOBtIxHxvKr7JpdT/YuMcGq09mbHNx4bN4d3VlVpw0SL+3jh/qpWciRW8Z/+mMGl2ac5YBoKmnrt+9jeJYNWt66KCLn1YELRGWYpIhGp7BmNC0kkxdiIvml3nnO+Y4XewUce02CBVlbrjEhxIsCTQJUBOgFvxW+0c7l9AaRaxdtofRkR5S6Z9t4HzGQF0iMF3RirD4IRDVOW7b7iWN3bwO2H4+t7GVdfNAOCaSVlsCkSCttOCnHGKB/958qp3QT0jlD6mDrnh88uUJWdD7dg4SlT7mQR46HKO7yd1z228kNPrCFDpZW0wamZrbdpTZPDexIYAEz7kkFpRqAuWkMYEP8S3A1IgGiTnJH0DPrDpvwViBVI2hhHEoM5ZoGxjfvFehkrX8V/Cq/7dAvTV/HX8RzGc0Oh7cpFkrhvrAgdFuBtGDW6BwvwqxltqrMwFpG3YgfCXA9rFIB7tNH1kM1Pgm5SqVKpoXM+kQpG0ILFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MA0P287MB3499.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(52116014)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0ewbUB1rJ5KSO3yBpSYfWh0ftY0Yocx6tS3GwNrstb4GvEyTMjGlGwd3ZW3?=
 =?us-ascii?Q?plwX0G4mXvrUzIS00tvTe5HKN7bh1TaduS0i7CVknRtUj9gpO+Sux6ANiJJu?=
 =?us-ascii?Q?6sNPQbo+5spYdKNN/kGKh96vZHz85T7qcwVGGyNZzJN+5uMWevFn/XIp6WVd?=
 =?us-ascii?Q?vE7PPqxVUTvf0yhIB11KUQsVfEm+Rl2E8+m2uOz2F9fHcHAwpInmfbAgWxUq?=
 =?us-ascii?Q?buU2uml1/8ZdkwT8ZrljwX9tHeO03y6Q+dtvHSmsAdY0jH4Dldd2R4e2zrDX?=
 =?us-ascii?Q?u54BMVUrWUXkKr7Zmp1FhRJDI3vgVzwn5uMLHveQnxRE8He7CSozX5WO00h+?=
 =?us-ascii?Q?ztS5CxkG/0/ZlG/3Yr9A9MsKz9t8b92KQ5dgl8C0Ud8N5FFxMhm3Tq8zNlsF?=
 =?us-ascii?Q?rdr/pGYjdRej8F8s+x91Cq+mAFg2spnuxgPqgP7Mk8CVuIo+txmslyezpTy8?=
 =?us-ascii?Q?iN2MMTSw6P49BgcX0TirKBoK4T0UXFYp9WtHDl3AldIZlokUFZ/ciCTDUmqg?=
 =?us-ascii?Q?V5wFg7RZSnYnH1Y9+g3s416KCChzet+8ZFHo6on36KB2XfnmUwAoMKQywxbV?=
 =?us-ascii?Q?eBxXthsJGWyxMxSSQLbRTqs2q7McrKZ/VytaTKHWyRc+bFHxL6yoSzHjwE4T?=
 =?us-ascii?Q?m8/1KKs1r9pghdwj5flEq7TgSrf/MI9vkR2yAgOU159QYdENuXcxeSgZzYvz?=
 =?us-ascii?Q?Yk2gmDXTVzRgR1wFIfMI5/pkuJEksXj5S1yKsVQf0vVky51U9Rgpi7nPfp6k?=
 =?us-ascii?Q?laSUg7PMM2XZ3PMAEwG2wBg8t+k77IAUt4tTW/w5tay4y2jSzaMYfLZMBN87?=
 =?us-ascii?Q?BSdt5zCnVvzxHy+QzJYeDH+1jY3YNYAaxDn2QNKONChDPBdtKvo//H3R5PAc?=
 =?us-ascii?Q?zQwmsRg0k/78T+OPOJhYIhSV9m0nFszKvRYU0PKCu4H9WEuv7tziZRZMoSL5?=
 =?us-ascii?Q?Xbz4JY8EYVemlTJls4L89bQ0PUMW2+EZAagS6SKXejpkpaXEHCQ65pyLubzC?=
 =?us-ascii?Q?NRYR5DzBD9OruY3+w0DBbDfHNx/wZagM/Kh6rhMNjKrdvbOhGc8d5vFx+uPv?=
 =?us-ascii?Q?P4foW7rvSpkwy+poqIpGpKy/0qogbNMGOOVyMkVgij1uzbf6oHbZMQqD6YR9?=
 =?us-ascii?Q?7VYB+WtleeTsC7VLE/Cwq9Ehq+2WohvgAY+EHw8a4t4F00O90GDEqC3aDTrw?=
 =?us-ascii?Q?FSNK4fn8W9MrzeORUoLQuSx7iw8EukD6Y8NnMHaSJu87FL+070KkuxDf9sRv?=
 =?us-ascii?Q?1eknfrqMy4wc08JHOeQsTWKKcW6CeU9q2TW9EmLY1HcIf3LYYEeZALw98XFZ?=
 =?us-ascii?Q?IAoG8XFzUssx9Utfo+2R5MesXJvjvDbZNAMMFVMvvy1TfGO3ZNqgKXAeBumG?=
 =?us-ascii?Q?I8RkJvin7sX8SvxyOJHH4EcPL355JmcsmG9Ms+pvFs7+e29AiWsJuCXOsxDs?=
 =?us-ascii?Q?IHzEEXHeVyt39mXsefKFKiZnIwEm3f4GhsfGecGACteBCoOOxR3H6tgOaPH+?=
 =?us-ascii?Q?wTjA9Mj7gErFLp9zl8geWKYwm2shj2vliqKH0MrezBWGBq6YiIAG3hEODAJE?=
 =?us-ascii?Q?sCwGy+5yg+OkBOsqDOI2RpsS6Hua2fAOMaS46DQ12++cTT7xfYakrJWshsNJ?=
 =?us-ascii?Q?SpIsBElV+HTsQlSjIgF5TSdRiZG8x8QygN83muve9Kxm7YC6bAG/VRLOfd63?=
 =?us-ascii?Q?XfhMaOZqYL/PF2067z+an1AM7w9V7CggOL0uqVgbEwzKjXYj8pMALRvotUup?=
 =?us-ascii?Q?buzcrsUTnQl3PGyBxKy8V6sL7rvL+IXStcgbJUxI811a2jgTTr7sFi/NdZ9v?=
X-MS-Exchange-AntiSpam-MessageData-1: shLxQvS2bM5jZYmMrRvPRh02YXrsC5Z43yr3n4K5x88GYdquZbLIagYh
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 0172c854-38c7-4544-b6ee-08def39c9327
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:24:54.4982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8kjIIKP8OH972wBLG3koWcWqAKUJKm7v8edxVTI8KKgaUea05omTmm8aFzimnj2Mf3tQ0++SDvsTtP7TrdLfMOr5EqqJKSSpjw7EARHHctLnodosORjYo6QR2TuwP1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0851
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siliconsignals.io; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
 b=VWP6DyTzohOY/gSVYCnX13/IXJULPyrp9GxraJiryNGx3PDZLimxb0SkdVk0IoTf5KqGQb205S/4St8mnsS38L2oHQ+vE3Q3IDcKK4zJMl6regHjpfL1pDg3CAq7Ya5sZT9xeXB2/5g34CMuhwl8G8GPD0ovZ/alUuYC5ry3O2NaE64g4Dfehzjdr5+bLwOnSKS8Sue5/gKqPS4dmM/iBAONlgmSz4ghuNclTeKqE35yH0EBNSrOVUcmXhzGq/qFJKme8tHkANopatNrsN+93E4HNZfGR3V2TpErnUr3UAkUsI7vjGWuy383hzCkOa5ns7i0THlNfxHJdLL5V9uECw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=siliconsignals.io
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Advait,

> Add support for AMOLED panels based on the ChipWealth CH13726A
> MIPI DSI display driver IC.
> 
> The driver configures the MIPI DSI interface for 4 data lanes in RGB888
> video mode, performs the panel reset sequence, sends the vendor-specific
> initialization commands required by the controller, and enables the
> panel using the standard MIPI DCS Sleep Out and Display On commands.
> 
> This driver is based on an earlier implementation by Pratham Malaviya.
> 
> Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
> ---

...

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ChipWealth CH13726A DSI panel driver
> + *
> + * Copyright (C) 2026 Mecha Systems
> + * Author(s):
> + *   Advait Dhamorikar <advaitd@mechasystems.com>
> + *   Pratham Malaviya  <prathamm@mechasystems.com>

Please use pratham.malaviya@siliconsignals.io instead of prathamm@mechasystems.com

Also add Copyright (C) 2026 Silicon Signals Pvt. Ltd. along with Mecha Systems.

Best Regards,
Pratham.
