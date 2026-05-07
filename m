Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B1CD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 00:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72FF8490D;
	Thu,  7 May 2026 02:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Py5SpDbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA8984951; Thu,  7 May 2026 02:53:06 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D9B84903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 02:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcRzfXY5NBsKA5TPhFg/mZe8pr9igZ+iW5m32Yyw8WZkkqMJRZZ0Uob99F1ivpmS0v9lXmmaCvlWqDxw2Xppo5i8VA0Hno3U6xjjpgT/pPcplBBJgwf8BB3mwh6IKR2oYeNKxsEiUvOeeK0Cm95VlHZB73Pa1EFW8Tt7u0dOcFtzIc/8qGozxoACUhV2mFJx3M7scqje9P9mM5rHz9HeV3NEHXIjWXWNmS2fJjZgpxyDsazzGt1XRVyLt7CF9TTumhFIpyUQBU0/tQQlevH9MqCBKV/1xIZA8AagJ8Uiy96F7Y7IkWKTbEZdYDHCY8kwGWJvuZ9T5R+NAl3uO48tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW9n9XAikyBDy66ZRqdiZGDzpQg1qD5rrmPL5ZWVaiE=;
 b=tixXCGENNmJS6TY4repClyAwaL5ddlC0SnmderBZWkpihMallK3XyMm1MEJX/Ym8Aee7csu7VOMpNhwMBK9+/VgtQv3CU4tqQpYIh4ks6HF2eV1kaEeFhEXakuPIb+++qYD0+1b9+iy0e/1tnKmOyaT+f8YLsaqMehzaFES+MmVG+5dN8IW8EMrP9XHCPavRz8FG2UHazVlpHHXEA2JG07T4A5zKCFbTmB16Wq0onl8Vtvv1E61DgOjyNcuxtX9GA32VZHvN4UObIAzGm4aW12HS48kFbodQAqQQ0XQE5LS+eh7f8on2Tdpwytv0x2zelnAzXuReoOCOdNalYJaWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW9n9XAikyBDy66ZRqdiZGDzpQg1qD5rrmPL5ZWVaiE=;
 b=Py5SpDbwJbo93aEF6z4O0pzDOwng0yICRh+g0mXWmuitViE51XBK1G83EGyI+64GLqRKf/2/1qdDjKPvANcfjkYm0Of+EtmLxY3iDMrPmNgBBSBkuZaBUSx20dYx5s3d6BMjptwntm0XhTjWckRcCU/Q9x76BMoi0U6rcYZB+E87U+8Xn49huyhcjokRPJUSi1PjB3TSeVGizdlzOY1T09QITVW8EtqxGIwSbIycxPqEu/RzXaDxazNx6keTVLKw+vfwA1XK+Th83DMjLr3vrLAkfj+RqquW03REh+aB1KiL20gpECCQOSkrl7y43JqUZ/SNkP34xpYkVmdNKIP11A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH7PR03MB7810.namprd03.prod.outlook.com (2603:10b6:610:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 00:52:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 00:52:58 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] configs: socfpga_arria10_defconfig: Enable
 CONFIG_CMD_FPGA_LOADMK
Date: Thu,  7 May 2026 08:52:10 +0800
Message-ID: <20260507005210.30014-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH7PR03MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dd5c69-c290-457c-cabd-08deabd2fb25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: g0Ioktxy0dapV8m9zEkuh611yIFbGAK8aNilv8ueVdAtd2DPcOwyJb5PyTjskY+BfRV0hIC0GXFkah7b/9tI9NVFin2TG5v8C8mzj7Gqxfr7hFoU90Fyc909gcpOywAh7SxK7mlNHjvd6XLtRwnXd/kzKVjwnkTOhTEZxY1xSmNuTgr2/1m7a78WrXe394nxTPPFBjNtLFv/N/heNTXd3jSYsXBMKydnzo4ToDVlQZf2uPK8ZAQ8i/wXDZEp4OO9jqQCJ1oobSXezVFpHRM+kqvg5HPNtzH6HuGT8EFSgPd9UP+nmfGSLus36nUludsT4/HuzIbea2UqBHFvksR2xdYDELwF7ERvsNwizlipAUueggLmMs7iZak1UkipOJCkc053l0oF7ZhR3rNRzIoXLq7pPDfrjIySWwaoOOUkey++YZLhKl2gVikfL4as0IIMFB3UtmTQaY6nnxStHl0xwT6sNtVSiJY56HLUCTwWuhqNPEVKrswZ7Lf5+o6nb43VPEe7I0RFn+bpWsKQ1m/v3SXLy35n7HmYZjUeA7fb2+fkzuIhMNRsxHL0ENQoDLsY7fG1k/bZGL4yF8xQuAdTGuwahrP0nKhA7m3yNRjy0s5wQVyw74knTl2OL4VP8zwN89SE/RnsDQIwqfr51vsz3rHq1GSzlXeDFwZyeziE7tL+JmmhsbB/OKXkRWscYato
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l024U9s8Wnhj85qDUxq92LUg9+Zjz5icvkFCYMzmCOxduq+sK4iC767lsFyc?=
 =?us-ascii?Q?3nUWh6uvX8lJVqxWw71jv5UIqeP61z5tnO1tMXygcZ1Vx3Y+NSmzsClBl/tV?=
 =?us-ascii?Q?WMU3SXQwTb4Sx4ZiyFIlSkKEZrariy4SNSvO+GGsQCuK7XPIlgq5ta7aJ8v7?=
 =?us-ascii?Q?i8HIQ4/PpsTFqyLgfxCQ8vJANGRCPvE4aNlPC9/wtU24oxWG1wCP1pEoUbS+?=
 =?us-ascii?Q?1Sf91M1a30JMyt/ZlQBMutBUADORlhJDcfOl5ucyq/CXfzt9mtt0457b5mXw?=
 =?us-ascii?Q?Kt0TwO/MqvngzGmgBOgn7BbCsYv4DRZud+7JooVJPgGG5QrFbMEarJuN7LjF?=
 =?us-ascii?Q?W/hjYY4PBcG9sXGTlEOCEE1fLn8xDMbOsZHaTujeeZsr0K/RtDHaUMUX+Wch?=
 =?us-ascii?Q?l95X50nm1YkkLOmUtOaFEYajdY+Sqt0sLt+n5AEi9o8tD4feKoEdbSMfkcgd?=
 =?us-ascii?Q?Z8+rNVwN/DBpRlA7L2GbfcyqTabVShmXmmdRjBje525+Cc2PDkS6QRG9EmXc?=
 =?us-ascii?Q?RSXBfvctWxGqpMSDs0O59KjsvXGAzwO8qXjpFt6ndnacwXDynYJ8ZscCJ1wN?=
 =?us-ascii?Q?O+5ZnEugMblLALJkrzLvQbZVpQh1AtW0gGsZqqSa5kAdJGjSOV3EkiO3Ddyt?=
 =?us-ascii?Q?6aP0ERNHFKfXv0wN6WUprGenGevc8Nuo3J2E4WT9dcTx+SUWKwMKcKO8UQ05?=
 =?us-ascii?Q?lspy3nRLuW+Z7mXbz5rbhaGYDaOC1hfmeV/+Gk8NHC+eDg4gJeT1ySBoeJWY?=
 =?us-ascii?Q?cC1sXSLuObxQNCUJtqPlsYc+NIcY1afDF2jRGjhdD5+RogIKm2F+kXzRVqi+?=
 =?us-ascii?Q?OXfGQiDQ8JyC5QDtJR1qCNKT5mlqAuEhHdgApeKCqWMyYwgJpqX91p6Tt6y6?=
 =?us-ascii?Q?+Ta39Sgwq6TOZ5vhrUr+So37SXHzL3wJwU/CL8XYHA8vaCv8TGTufip0DkkV?=
 =?us-ascii?Q?yzTpdKQMfqHBitT8BgbHfiz9KssKxS/sG14zTXde8xd9oO3hguLLK6TAjSYl?=
 =?us-ascii?Q?seotR3GqM4ogpMhRuGJhmZKw9/9w2ljwGhp+eO9x/JLMgGIk5JOC8hOhp9ic?=
 =?us-ascii?Q?fdnbxpFvRDoUU9DVNCTeqDzAOLmX9aG4nrRqwT70rR8WwzYLLFBTn3+wr70+?=
 =?us-ascii?Q?opJxCBpgOt6vok/jvzgHCC+8RVvBjcy1pSnr02ZY0FsYsRQwHXtSm9jr2Flf?=
 =?us-ascii?Q?fqqNqlqjikwFsD6jQFaIuR82eTPV2qpmS27baxOR9hhVnYDijRzv8/vC7gP/?=
 =?us-ascii?Q?7rmweAsIF2GqXxXoLfKr3vJV/n8+CH9pgWn0y77tyLz72fSAVvhPK/V98DVQ?=
 =?us-ascii?Q?f8ZFr0Bga+cR2Vn+McrcgoLy0yXDek9fC/md2dXTrSxoiUqCvPHdLhFCkUqr?=
 =?us-ascii?Q?87PefOij6TAF/Hh5vMGh8PSy+IpZO/uUyu6bT7JwkRoGNV97oyx+0f8LlI9A?=
 =?us-ascii?Q?7/J9iODMaV/xC+Wnc/y7qExMjHxs8ce6pPsUMAT9ayYpoZBPW358CX7TgesU?=
 =?us-ascii?Q?wbKXZfbMK4mwiKHIOjn4YbQKEL9R3EIJoOPZAeyPB2qq9pE4Fjritr5fKIRW?=
 =?us-ascii?Q?SmztXwB6YSoCdC/pcBMhJ7Uy5go7EzB0cRHdfKp//40jlwgv24sIlCZ/rxcp?=
 =?us-ascii?Q?/gtx/KnDfZnhYk8gX/cnW4ssTzvZrSY8pGEkOu9t9XmJ/yGJyzsqBS5X4on3?=
 =?us-ascii?Q?Q6UBy42drO1yIp8FBaFIXfzdHUEnGJ23sp6ckN52Gv66U3jt2iNsOpeAN8QC?=
 =?us-ascii?Q?f7+jqj6qgAHre/qmy9oYmPGZpzaikPw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dd5c69-c290-457c-cabd-08deabd2fb25
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 00:52:58.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckNE/CaF+mncaTCtpiqRqvvFzuojPfjLYg7M6cj70pxf8U8QKZ3xfjIWTCm/wTHuQi4SxvJ/sv3uVkV/Uz+AFl4ZJYtFiadZTTMUbyd5cS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7810
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Enable the "fpga loadmk" command on the Arria 10 SoC Development Kit
defconfig so that users can program the FPGA core bitstream from a
FIT image already loaded into DDR.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_arria10_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..3e3689dbec3 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -40,6 +40,7 @@ CONFIG_SPL_FPGA=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
+CONFIG_CMD_FPGA_LOADMK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
-- 
2.43.7

