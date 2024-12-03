Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F50E6C5EE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ABE8963B;
	Tue,  3 Dec 2024 04:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7602189613; Tue,  3 Dec 2024 04:06:07 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1668952F
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaYKHwj+3QjNpYTamk1NgRnyrzTmB/Peb4i6HFsCIhJHHaSY1i/qQVSVpwlZJe6e1Q5e7fZNb/s7wA36mYnCZn9sZyNYy+zQl0IHML288CGYbYlsEgUXI1Yz21WMHDPyAzdVs8EdwDlOtsOciHXDYNIaaTw1RngE3X0MufSUiIVI0Inz4b4JgFhgwkobPS3bQp8ceq2MxuWJBQy5yixcy4Tccf0jRlG3xuah5EwHzHO9kLFlf+cnWl94kJ1/GonfNlrDpmszBAax0Jxgca3hrTY94cdWggJ7eI1w3+0mMloNfzB+apXE0jgffO3WBW7UgwpjF50PellP+AVdVfDRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NlBIVXLE/bkEHEsznHrCuo+1uDPO/ybOuD+Es2gRYs=;
 b=nTchYakTXbXeeG633jutbEInwjJxza8w37SnHKYAIWvtrKpSPERWvuNQlcZZKox1Bd4bTK+6nW1394KObcSBHkBpO15l8jXbQ28O5MlKyPHsaWP0T7ceGnK/GwLG5qro3PmK50/W9XegV0Md5drGI6+oFLKbbURWa7vuVpvZLF0P3dNlBo6wfXaDad+b1RUZrqYgZT05K6+IXohCcxaMyOS3TOk8P84u0DbASMoVt7I7Zmv/O2RACKlwEUGIc4dEIM4pWbjAGKcjy7b/cqb4o6bEayjAxgzl/7lyLx0PQy9qSXUej1mEmpk9q/fpsQM++B/HtN+ff2j8A05J75/n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:27 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:27 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 08/12] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Tue,  3 Dec 2024 11:04:26 +0800
Message-ID: <20241203030430.26089-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 932b2056-0b67-4855-beee-08dd13477a25
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: rpWYwTJlfhWH2F3Fe+LqudGbHmdyVIIqMq4SNg+Ag6CxejVdu4bUZMWqVXMggwhsEa7Lj3+asQOpNK4XXPYiULOgu7csQS3Fdip60AWufRmkjd9YhtU4oELzCAZZ2kIeLqOkDCWrZ2TXoqOKm3jF8+FNEyWS/3XpvAwv9CNXfJGmJlr5mHRziJnTH3Pf3zVTBUl6LpvOjjlkfOYTrEsJK8c10mwx+eyIj7SnFmHHah6AsPqmBIlSPQFzZTxDIMVo+JnevvxoMhglP3caa41sDfj4h104dl0Q+Og+m9+CJjOiAWAAXmW6JY3O2ynDjYXJ7iGkpRgPYnsJoyYM0hyg6EPo2Pa5wZIsjHCpUPmAqPn+AJToEgb2xHnTGFOGNGkq2xAkihTo0NPtIQucLebJNraFwPgC04IVZzN9N+/j2/79eN3fk+wIu4QfM5ocYx2HaZtB+bAkaBvH4l1Y61F1SzpQIAOQhmuYJimWn9DfM2zOzTt4wbRB05qtC8TuoBE2h0OeGCS6e83RmP8w5i5kT6X4TJkO689TJg8cuQw7lLfSNV86Gd3b0UJ5KJ36K+eaUBdU35zBFlFQBF7fOEYGuecQ7+7y/evhWMlCT78uJTw3tBHBkuLQ0kKzqJuGV1FAUfCbF//jpAL5OlFaXrM7Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0k14BMxCxaN1gqCCXtlae8XYNA4dMZ+GBRzk20tM7Io+QeHzaIq1oWQDmGm?=
 =?us-ascii?Q?FZpSAV9WeCJariragp/hkX3QYsPffN6Xg6oVxu7MHAEn7G1OmKSjfY0054Pm?=
 =?us-ascii?Q?+ERkDesZvE/DxjXRsxxTiexeajFqAcKeMBs2AdynmyxN3mCDb2YPLp9YtPTj?=
 =?us-ascii?Q?LU+Xd8TYz7MRYn1EpOwsvnqv1m4c05aCSSiG8XXvByy7GXYxjmeZEhnB2cY+?=
 =?us-ascii?Q?6tmQ9O7qpa0eXOO/fdalY4Zuv+hmQwRmysn+IVYKWqrMd7VHLEpnXCy6fKql?=
 =?us-ascii?Q?TV/X7Djd/YrdBm/KF6tbZIwjw2l+Xe3EBng9OVVq8zyR3a1l89+AeTPTQduC?=
 =?us-ascii?Q?vp8X/bDI9d2X1dFvjduKGUQ6Lq7uB+Pa9uUbpmwaximF12OMUf2EEaQmcFVB?=
 =?us-ascii?Q?OqnXRvY3pkpxYxRC/D48aaNtAZ9uNvqgZqdfAfzv3DwIXjxlpUt1eVO2OjnO?=
 =?us-ascii?Q?mEGMLzYE7VlrZJtS42IlR7vPWcXXXLTpFIa0LNkPqNGv/6i3yihxIYDpiWuG?=
 =?us-ascii?Q?86fRknuFMFMCUMlbZ69uXBDRRzftakUGQQhSH/c1a0OAHNFd6/46OsCUeyrW?=
 =?us-ascii?Q?7MEq4YG1KJsU7+j4XbkY8qHt8ci5ov2yWSes5DYtAmk5XwY3S2tguRKcI4Bh?=
 =?us-ascii?Q?H5FQfKB/kofx56sF1q7tvwAfSv4JKqx4OIqoAubMdjfHz17QdG+Jknc5U4ex?=
 =?us-ascii?Q?u7SeBSBlUsPVq00SBSNYO0HQePOjwrChxCnEEatU5fgxWkHsDMyYishq7ohR?=
 =?us-ascii?Q?QgeQ/rqO0TbmSr/xBFS/M30NlBJVZtcLtqXtoTgMgNN6L2ptzItO/Qn/xhBW?=
 =?us-ascii?Q?v/O1GNDvhKO6Gb8ceoK6Esy3fqckZmamf3sJ8JACwaUjSuJdT39Sn8JcQxu2?=
 =?us-ascii?Q?/qylCX2easGf0gt4MqolNw5h6daK+AELhIgPIWVpoR6h4BiFWmvsKBc+FAH4?=
 =?us-ascii?Q?ZBIX9lFevGD+p7Ebm0eCmfvUfpQboVgho2FuWCyDGKTYeLak8sA09K+WVNHz?=
 =?us-ascii?Q?obWIKvdedBNBrdYjRC6C3UcACEdjZJNqvumuIxmZorBfWU73Oq/uZCT5Kom8?=
 =?us-ascii?Q?z1SwsCgi73DLQo+K1sTDwdpKH2uGftuGj0gQTCs1i8kAKv/s6pecnwGHsIST?=
 =?us-ascii?Q?Qbox8MzT2oWziV+EJG6KmOdAVUXgFqKhv5hf60LuzVCoIy7Cd/ExCwZG1It7?=
 =?us-ascii?Q?cRJTmzv93lMYv5rEdL8tXEc2lIoAqEyrbo8mC48z49uFZvKAn1DiHtgOUZZg?=
 =?us-ascii?Q?UQiadXce1S//RXg0s8qEiJT/UrJ9A1csOV9WmGuleAx5CUyWcw0G+8jMyNfN?=
 =?us-ascii?Q?Lb5dakaP96+dGmlnBUBPlsZHhp584JjPBBeIOC9Mxon5JHDfkpRzdUD2u3da?=
 =?us-ascii?Q?18qv0mpIj8znSuaII3Jtd9o4KQmrwJoSG4vLNn4L7KVlqKweVpxOMHwI3euz?=
 =?us-ascii?Q?nduH9NoNZX/UuW7skRto7DYFQi+JDPA6lBTkFhNpBB/hkqteOLNYHvogE72F?=
 =?us-ascii?Q?kcP1mlMDSRWZVKqC5I3EvkdlK1QPi9D+y3ogiqYHox2vhGlJD3lHfzZ+OlOj?=
 =?us-ascii?Q?K+LCvh4kgQ5qTjraCbd4ae2eGt0gVfyDlprc+FuKRjzzPSUpLnW1un3tGE/R?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932b2056-0b67-4855-beee-08dd13477a25
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:27.0130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m07iHUkH+pQnCo75sZrZ4uKo2dER3yXI1zbTErsHnimBIYNlJhy5sSlVPKVLSkm/oSk46q4PWYhrsgcSbbe1nDQf+DN9Mg1CFiLnStngpnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

So JH7110 based boards can select their own DT at runtime.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 3385c25b3f..b19931fb0a 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -82,6 +82,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

