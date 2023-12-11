Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5966CC10DC3
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DA48773E;
	Mon, 11 Dec 2023 13:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="p3Ge2u4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A13B8775B; Mon, 11 Dec 2023 13:21:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28337875F0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOwfhYfCI6v2UWjecO2s+e1FAUzdSfUr2Nk+Ss8qJc47UsRh8kFxGC7z51LOe574O/A1ycCW9FZw/QnszAKSXgSAhRlfaAwlUJPWfETdcIhaYeUFJGuekPkmmNbIb5rPKLUJXTnenDBkhoE7+gln2Bllg4D5AD8xMXZt3qB4OQWf5ZDJdsssvTxBPjeG2ZoJjb0f5NDJDq7Zas0kJGoi9ETYA/9FOSsTeD5vhzbAfoxnBRJiB2rX6DGjtti9T+r9hhJ2U3RmYYC+BGIL3nX8fX7rSpMckQ4GQBYa/Zw/JZ1WzM0YJK04pthnpizPV3BIrH2Fk5WiRmVroHaNj0psBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVTbqi4OPGAldCWWtEuUa383m+SKvi0Rs6zEHEGpeg8=;
 b=HRnERN++VaJ8Mx3jo+2xtLG2Sl7whgZY6nJQzsFF1F2Xr8HoJEZFAqtgWCineoCYcpMoasyofq/P/WeRakyT9Xy66icGJAbr5AuSZi4Ydilo9fE34GUB+rwnL+uTEG+o2ilvh58ld8w3u30/doMfTH2b6qCuB9uzxc8eRcIHth+d2B6+30W0y6ydiAFnbwclUEbRC8KA14VQT3cZgPvjs3r4y7ygE3FZ6Bi/Vj2seJ7Ctl2/3A19il8e9ynfqJau27jIniIOUn5iE/9YVenulnjsh25SRfbJH44mZPVnpZMVHkNbp0yASMy41nCtqCsf+eX6xrQTzLBdwjX51TxGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVTbqi4OPGAldCWWtEuUa383m+SKvi0Rs6zEHEGpeg8=;
 b=p3Ge2u4dEwXhfdZ2rrBUBYsQnGljcjyqOOaJ336PFzKfDelGqIaQ4NkOgu4EjI/Mqfjjy6ELEbk8RZ2csT/sEtp6m6NDHJbgJlwOha9iFWi5sdXghxQFGlDd8tNVwRsz0RQ0KNMG9HHJsboG8PD4gA6ioV6UhvpsTx58zWUahig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8168.eurprd08.prod.outlook.com (2603:10a6:20b:58f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:21:00 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Mon, 11 Dec 2023
 12:21:00 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH 3/5] test: cmd: setexptr: Add tests for bitmap string format
Date: Mon, 11 Dec 2023 13:20:49 +0100
Message-Id: <20231211122051.1240855-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c6354c-b017-4069-97df-08dbfa43a2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbEAEYpsRr1GeY6VWi5xlGKsDVLYQkaGeYumMLKVIHj5p/eJZD5XUyg957KPp1m9SemIuA9YCzalEacWewU6A8CeclhHv/TwmZXGe13rch4VCeo2r1asCrLkFjei4bD7RCoM8XLlyBj4EixURbZyPthPIQc0NQdgmMkridEsgXLp6DMRbNjTOM/9nhDCVmq0hRt+AWgg0DsiXTA8WWEvwu44OTfGFzUrGuNNEVhnPn74ttp9pbAkFuQMWWqKQJ4eWNi+uU/8UvxeWh+2AxjG2nLUR2LtS9TKvyXz9V/+P+M5REbRJv7pA1CJP53sQUUHTuRrFhwBabFO31rT96Lyt+ZceYaevlORppUyGsOSwFtVgALUDf3ftaAsFbSlutb+0uqwQbKY7U1d+IUcQlUKdc9vo4+0aOX9TIIDXs1pwauuS4Gf45R2HUy+LenGr+7AmwHG1nAyGvh5q1twlcjYHrVWDs2sVDqgip9VFA6fxVF/dWVS0lKrpuy26KG5mPxj28W1wGNo0iT3DWbpMzH+9hoAalOIo6Mf7eVe5K/MCjuZCCggPac0usSOSjS2jCcJTBdswaT8OiixTxEMRTSHloS8usWL/Iy/XHzrg1NQ9Aew27Is9l5swDfi5tOwOvFL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(107886003)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(66476007)(54906003)(4326008)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCJQOjlo2zlWr05o+lBohmNuqVXlKCUnktn6XROFimiXAFuXK0yARSKax+YO?=
 =?us-ascii?Q?1iiU+W6XKHpgFhNuqksjk8QCYR5J84TbOv2UuEVR/1wDiOL+ZBF07GV18ys3?=
 =?us-ascii?Q?pxsLAui4CTNV402K6w5hXV+BKJO6R3QiF07i93xFkg71+b215QbJcD0/LOdU?=
 =?us-ascii?Q?iCzqV2nVnaDUk9ylX4cdjh/XxOertd3Ejm8B7fLP7nZUAhsy71Jdgaqsyxjw?=
 =?us-ascii?Q?Fx8OWoiYIDo9X0Es+dY1WIiMmptZnlrpc5zQSlI8TkxjJj46KmqVtxvefyAe?=
 =?us-ascii?Q?gix07XpY+ZWFTlhol4mjnz1KbZaSEQcEdSVRc2ZxS+7/kuNjhyq9X3pWrxYO?=
 =?us-ascii?Q?tAzaxZea8UWhKYkfQ0rLa9m4f99a4uojywZaSOO3mRQoaDjF1BZeXPM3UyW5?=
 =?us-ascii?Q?uOcWxtQ0RgVuQ+xl9aRWR0TigyM8eJCedRhb5Bf63DDfz+QFKxkVZgSnGp97?=
 =?us-ascii?Q?0AfW2mgwYBVU/XQiNVduDSPuojab8+HOZ990b8TDalOxGQoXYiJO6jO6d6Mw?=
 =?us-ascii?Q?/xCvlONmK/1XS+LeGm6Aqx0gtaU/w4MnmKfM4hXiNXqF0+0/0EMDfjut5Ut7?=
 =?us-ascii?Q?7eCQazY9vwZsTwrK5/UsLEJEtdAO9CO2uIP7Ml5RMv9jQKqyWyJE3kLoFTRk?=
 =?us-ascii?Q?tbqEyChZ8LdhqfECdy4crziVdUmiOfIkz8fm+xDA27s42GF0/anqJye5Nbjd?=
 =?us-ascii?Q?3XRXoOVmIxy92Jlv9mJpl4vusETQn8hPHbv8/Nm6KUBJ3u6cK0dA4Y/k6bZx?=
 =?us-ascii?Q?oCma0rdXBMOs1JEawEyn/4xA3LNT4fY8NciENmbVzaGmUiBfPt5k6CbWJ1RP?=
 =?us-ascii?Q?7f3YsrHdWz7iMu0RcjYNzyLw0KtVyq0LJSvdhhhKKaBEZZVDAvTy0Tt1mdWO?=
 =?us-ascii?Q?PEe4YO86Z/QrtZ6GuDS4TTp02NlCfaBzegFizbaAyQPXPBFvJxq9OIkUWlS/?=
 =?us-ascii?Q?FE5dKXD1U9b+oiTwg1C3f+j/0KRRUtWNdjm6I7U/lupT2bX90Z9OS9WAoAny?=
 =?us-ascii?Q?88/1C0uH+zWq0bgVaf32OIysVuXS7b9CGHWpNeMzbhkqxv9r/Yddy7wJZVGg?=
 =?us-ascii?Q?z4TVlv4v+svGTxJrR0QRHKYQ0vnFWZPh8gA9xv0Nw4oiWJuK3tpJiDssC2FA?=
 =?us-ascii?Q?lx5c0TuhNi5QLLfMXw/dYQcMs2jG0G5QiCDbvb7ulaTjS/8A1id9PqOArh5j?=
 =?us-ascii?Q?P9a9qri3JrJRXyJXqSZ7OWymUBgssWlbMM6nk5HQk20io3lh/qcl1Pm8ULCW?=
 =?us-ascii?Q?/zp/ke7x3KaykbUgZbRoC0bbSw6X+MA+u6gaAD1+DLcKHcLl1N/67JPg8xOt?=
 =?us-ascii?Q?T+ooLpinyIlW1spcLyxm93Chznrykkqcsdz/IqucZPUUMslOXtO2zeQ80w6Q?=
 =?us-ascii?Q?IOqh24562poPeBSpcbOJgSlaGRehlRZkHhOzQeFF+sWLE2wJDLlPZ5Hreo8M?=
 =?us-ascii?Q?czPOPYmP9gfFVV8B0QDPhN2XIlal39bQnKZUiyaHkSvv5p110FRSbK1lawbg?=
 =?us-ascii?Q?PEikwkjL9FZzMPWsumsPO3S1HXH8ZqioSwYziXWZpebm+PkIO4AAVncFoCGJ?=
 =?us-ascii?Q?FMjPQsUghvfr2OxMB3UfBzWEcJngeTiFjYsdhTNsUTqS4DI1LplCGRVyQCYw?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c6354c-b017-4069-97df-08dbfa43a2c9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:21:00.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl0YtJXNeV5SXXTf8Qg1XP9oCWn3WqKcCvj/qHByi2rJ43wdmFa4e/KBfyYHx4EHQT2refYhOIFhIYZhHy1Q7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8168
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add test to test the bitmap format specifier

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 test/cmd/setexpr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e3..4e1c9e983b 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -465,6 +465,15 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("setexpr fred fmt hello% bf", 0));
 	/* Error exceeding maximum string length */
 	ut_asserteq(1, run_command("setexpr fred fmt \"%0128d\" 456", 0));
+	/* Test bitmask long string*/
+	ut_assertok(run_command("setexpr fred fmt isolcpu=%32pbl 0x1F1", 0));
+	ut_asserteq_str("isolcpu=0,4-8", env_get("fred"));
+	/* Test bitmask long string (more complicated) */
+	ut_assertok(run_command("setexpr fred fmt nohz_full=%32pbl 0x55555555", 0));
+	ut_asserteq_str("nohz_full=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30", env_get("fred"));
+	/* Test bitmask short string*/
+	ut_assertok(run_command("setexpr fred fmt %32pb 0x55555555", 0));
+	ut_asserteq_str("55555555", env_get("fred"));
 
 	unmap_sysmem(buf);
 
-- 
2.30.2

