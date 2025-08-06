Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B2C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3635C84242;
	Wed,  6 Aug 2025 07:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hpBPZFP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B8C83965; Wed,  6 Aug 2025 06:33:26 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29EC83989
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfkIelliEcN7dVesKHhI57vTgjb81IIs2yNbhIVBg5hJhXdpZWy0FeuNkKVx7sDvwEjXTB2s50+4b8A/ziTC+bey6B/CnvfrZBnL2lADSbxbLjGxWZbcp8hfaSqFad7jkL9amw48vnY4+JZ4sNKDhAENS9si2Hr2THoJ1FbBMiVl0zYprv4U3jjcvg2swQBPjKAtELnjJ2AnC/geDOVV3DcGSUocAGB7GnGLHEhhyefqcBMqktv1tpBItN/yWx/2hZUbtzPvZy9aRpBLfvkkSzyryzQKjfVHiqhzZAl4pXLPY6g+H2Bp+tQ78oy+0/UA2jtmcs7hEtj+AKtEi/Jt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h4tjr9mscTaS7axKqQ7uYSuilnnHbk6xMU7rDDq7N0=;
 b=RthYwltMHa7gXExaxux07V88sZbwSoAyaODFWv5r682wAIodviv4pmXYHB/FM7jL4qRxLOla41lalIdKm9fngEIOWl0bEWg3TRRPmfn4ZYULZNSyBoWap83/t0IxotpYRCiHtnbrLaahlRcxrKqxZtpRFAMBPb/ZJK+B+MW57tBljC3+xbh6Aq9tiSSdaIinqslIjRkPlfJLA+BGainOzeLsnP0YoCNU/VUGv4NJSOFsQTrKuH7qQFmSRqQUmJVBRTgoHFw0DoelpWU5sB6wDSzosf0ePKlISvqQiQXUQSbKoK68yO8FoOAL/4huQXyXG6KJxKcTe5N3XFWaDePX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h4tjr9mscTaS7axKqQ7uYSuilnnHbk6xMU7rDDq7N0=;
 b=hpBPZFP/2lw2qPrZM4X7hc8XugCZLudDCz1l7ljR20TYNUVyaov1nQcs9QBQolAKgJHh0wIDPDvMeTLx9VoSSYpvsmRzgQQewYQB86MhcP65+V82TtU3XjPpB+i2PuObZtRKkjX1N119PpiVduo/vpnfwckM7f9g7vNCN4actazLQ/4JLp6yV7Pp0sY/On4Tmf8cKLsmTkpoSdKJyC/fkKOsG8QYSJy7DxQFQajupv35RJTwPahyK4ccEqZ1cndqlkjB7F8Uz7jwciKboqoXyjbZbAdw+qL1l0IgcDPfRU6sRtmMpheoJZuTN2ehvl4++i0BqPQozb0VTOVa8Tc3ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:07 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:06 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH v8 00/12] Add Synopsys MIPI I3C Driver support
Date: Wed,  6 Aug 2025 12:32:23 +0800
Message-Id: <20250806043235.2260-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: e70f63a2-dafe-46a1-c24d-08ddd4a256f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ih1a3qGjHfG+ZCwosllb97LkNp6eL+44WDEC4TLSteYhiQvrWut3jLqKAw3K?=
 =?us-ascii?Q?0spbVmGGtLKkPbeYyQlC5H6HrWqf4DchUzhhXJlerIkafkH+OtxJ6nCYSdZk?=
 =?us-ascii?Q?66cmreTFWY2eWsBtUmE/PK9M4UR9iMmsSbs023x+pTOr3XcCt85j7vy5CRiF?=
 =?us-ascii?Q?2T8mv3v3Ah2IZFG/Kt8fCLQpQ6NF+C9JQaTZHArVYWNOGvTe9+aEZ9asMtw/?=
 =?us-ascii?Q?LoSKyHa8PldWyEipJPq7pnOJJSfFM1aTIGpusfNNibEmi/a7oD2z45TIAHXP?=
 =?us-ascii?Q?DQ4HE0UGOJGoh/rUdnBDLssl9OrMAva4Iho/Ab2ja753CfQcg2IBtvCgmzhn?=
 =?us-ascii?Q?yGYYNvmPCtgnXGxGMcNyYAxNY7ok/eHv4FZC4MZOCy2bJHo1HBknDzvw92kB?=
 =?us-ascii?Q?nLGg1JkirgCZLSN4n8LAcw1sq98xQngQmZnOzUBUT6zeHy6+dSVjPbL3CGwi?=
 =?us-ascii?Q?RuO95YnuprEWICecOE7EAoWqq+0lG08rJlz3KdOHa2nb8dMsucuMYpiKLPeS?=
 =?us-ascii?Q?bITQNPPLa+Tn1h4ZylhKh52b9zE+O9TAFNIr4nnH5wOJoCZr+G4QEXi+Sjol?=
 =?us-ascii?Q?oyablx+SI9wFoAFIGnokl6zUyIch0qIc5wwzrpP/2fDH2ny0cVFjSEuuJt58?=
 =?us-ascii?Q?d1foxkzxbGxxJ1VhGfsm08jdy7RtDiJ3/KPQjH9dShTWyYODOyF1Cr38qUHV?=
 =?us-ascii?Q?CPhw9loFGnGynMhpF/5ZiVmtn50Jk0LjQVD7z5lrjiClY8UQgJ0gS0/enPAS?=
 =?us-ascii?Q?MeE1ZzN5qb4ynYDu+jDr+9UMezmIv1dnIHmvMyhGWE15kMM/DISD/03J2AwK?=
 =?us-ascii?Q?wgW/39dGpvXe5Lm9sBdJq5b7rtXQhcK2hYLpYj6PJmpY6fY2ejOmgYdzhnuy?=
 =?us-ascii?Q?rYLvQ9M03b90PvrTocEPkWOi189YimdzAJGmxZrlnaWAZtPhZNLUE3Wnqp9O?=
 =?us-ascii?Q?nAWKfQRqMb3sqnbxhdAad/mgWO+Bl4iRHJ+41X+F61zmSHiPZr/NUiYwW8rq?=
 =?us-ascii?Q?netVHuPjEJEYR4BecJj3rPCeZ/PkewIqRnaVv8WcBxwxfTmGdMrUJkrHI/DP?=
 =?us-ascii?Q?qWUPWPaL7ZRyoQ4GUViGHs9qoLI65r/JLq9IanUpHR7Oz1l8Ui48uqkeViIt?=
 =?us-ascii?Q?T+J2C44YzwJijgKHhm/Xfkr8AW0QVcWzFSBQ/NQyQ4MuuTItUprV9JCBxWib?=
 =?us-ascii?Q?snGlJE5v/zH90OdjSoGYbVdgeOm61JQocZq6wHwOIlrCMCFNhPjWPkm1QxWh?=
 =?us-ascii?Q?YwEki/uOyj0k/qShLekURBEJIMZ05nSuuOBNuRdzBgHLLpgoWqPr+78GXsjN?=
 =?us-ascii?Q?HWxY8IQvUEAEaUpPueqJ3/QtAPeDxDC7k9IlCEUj9qJus0+VgTEEptrmEkOs?=
 =?us-ascii?Q?WZOpa6mKyuseUugJfvtrRff0iUOLJzTcPnVkKo2uPz1phU0r9rm43EppXQ+8?=
 =?us-ascii?Q?DzZvRrIBWbQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/XFb+QnacEDOGQZBbn3O7srxH7bQ5Br2DwxCiIPN2ebO025IH7No+jui+sW?=
 =?us-ascii?Q?+5uPQ9kgqo5Pzpg2sV4SQVnh2jDAMOAKbEHgpRvc3Yav9h2mE9bUwJgbA6XW?=
 =?us-ascii?Q?TXK/ow0OjYuGyix64JCJX11uyRvoASCG2L31tpOBFa6KiNUz//EYQ69cY6eD?=
 =?us-ascii?Q?FcnbEB8se3U1mhlEbJOtAg6ITGBiMaqW7cwhsGY0FVboD1NZprZ3HuPGvzyx?=
 =?us-ascii?Q?1wvOczV6/h6qfIcBzR6TAFht+2mOo3pxtcS+6GHqabBVUJ7vSxkY+2KhZ4aM?=
 =?us-ascii?Q?+yQfAltfMlokCDZyDZ2z1Gi+faj81jFVvpPVacpZKzB27WqBjnJfoRCSEGbn?=
 =?us-ascii?Q?RRZz3zHwRfU0fzwn7EhCOzM/GwukhYGppklBplHLcH2t8hl+5d2ocO9wTIs3?=
 =?us-ascii?Q?H9lvDcw+KZn9SI3QO0FaVcwftnM+eMPW72sO7aLMjBL5yY29cetvIvKjSm0d?=
 =?us-ascii?Q?O+bp4E4azlMc7UnJLJam6aNpo2iHcCiq+kSbRa/ItFitpkMVB6OyIhn6meKM?=
 =?us-ascii?Q?j95R0cokruVhYB+b4GMpSotopiy1tBYQOWYG0dksXebcwKrj+zpcu2ZhJfTt?=
 =?us-ascii?Q?P/Z7bLIkLXoOlR4IVUnwhGmvYcKNePajcQhctY2uUdZuJSY2OVUqqmDZDwVP?=
 =?us-ascii?Q?S+Is006B7syGbJ4bbthH4nXTGJmjz/erW0wePraHOTlG3bUb8P9JjgHEFUL5?=
 =?us-ascii?Q?ijPmF2NhBoX8h3vFmR3J1ceZbWqVq0NcBinOx3sQj/gZFOxVYKwd+ZS8M2re?=
 =?us-ascii?Q?iM1xh7lgBwUoJUhXkPmAIyMeRikSwa1kcSbIAgdv5uSaEbKgXESjDkuSRagr?=
 =?us-ascii?Q?LT92iCQVd4hpORRPkmdfCLF+Ct4/B6m4qkd7AF0HuBW7DTt2mZFfsOchUR8r?=
 =?us-ascii?Q?hO5PdmcvcsDfpB9S30pJT7n0bX/yhpCQpYMcKom7NecFJyvrsel/bydjekNm?=
 =?us-ascii?Q?fimaRY9kmY33LENfgN6GEs3a7fyqbk/lZyCdy2MU+nTd1RbUsJOhn7PAE+HL?=
 =?us-ascii?Q?27zq68TfwcbuE+/3el4YlozlwZ4NXfRv980Ma6W4qEl8lbVrbNgqI6S3Bxbe?=
 =?us-ascii?Q?qrLMB4I4fRIUlytT1fenR7lm5N9LJBLKJjo7fp7M+Y0d1rygQeW7Gbngx4fV?=
 =?us-ascii?Q?R7zZ3XwNffnZg1gqC02V8bPBwf+JlTfKlKJRedGSjzmzmCvqdoKXxRanT+qD?=
 =?us-ascii?Q?kGtL/fhD48QA9gS7rNkw2mYAV+yVPD/cv1ZFddjU3et0U29/5pnGcc2gnWGY?=
 =?us-ascii?Q?71dVI0GADU3zDN1WD/EMbt7HqPmgjfnjIutofD/t5LmBvkuTltmGEAOMrQzT?=
 =?us-ascii?Q?Sjh+eXwnMGenUQuyq4ggEwCTevCse22EjI6xlONWqcYshRNRoP79zIDoKDPB?=
 =?us-ascii?Q?25KrPzho7ORBGG207PpfhL3wHrbF2o42ELO9BNbSHGm6D3eBIrB5VYL4X0DG?=
 =?us-ascii?Q?6Sn1TLXofCjKa+QyiJpr4rkMGBSAilEwVwXRgRS6taAkMeCRJINaloSUYbmN?=
 =?us-ascii?Q?Q21WlyYu2nj0UIXmQsNDhJ8STMDfvewF2TpBp3DzHQ2rUM8HzSkFoOGmSkRq?=
 =?us-ascii?Q?Oi8Ymb/GEvZ6kMsvVTvNGf0y00uPYcg/cGcnB4M0X6e3ZcqOFrHuwHsxUe7t?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70f63a2-dafe-46a1-c24d-08ddd4a256f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:06.8404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V795Q7ZSilRTwpeaYb4wg4dMkCvYE5QYIF+iu12JLkk9OSLmdf3yTgLVV4F1Obr3o9gXQWOL2uG05Kb+k4F36MMeKedLvf3FkSHc0wPVxPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patchset add Synopsys MIPI I3C Driver support for
Intel Agilex5 devices.

The i3c driver is leveraged from the master/dw-i3c-master.c,
i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
And few header files included to be
part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
include/linux/i3c/device.h and include/linux/i3c/master.h.
Additional i3c uclass driver and command files added to support
i3c read and write in U-Boot.

Patch status:

Detail changelog can find in commit message.

v8->v7:
--------
- Patch 9: Make the CMD_I3C dependent on I3C support
- Patch 10: Sorted i3c.o in alphabetical in test/cmd/Makefile 

v7->v6:
--------
- Remove extra variable in struct udevice
- reuse the existing dev_ofnode to get the node in  master.c

v6->v5:
--------
- Resolved documentation warning in include/i3c.h
- Move declarations to the top in cmd/i3c.c functions

v5->v4:
--------
- Add header file to doc/api/i3c
- Rephrase function description for i3c.h 
- Separated subcommand as a function for cmd/i3c.c
- Used memory address to transfer msgs from i3c
- Rephrase description in cmd/i3c.rst file
- Replaced int with unsigned for positive variables.

v4->v3:
--------
Resolve ci test:
- Add i3c node in index.rst
- Formating error in i3c.rst
- Resolve cpu_relax undefined for sandbox

v3->v2:
--------
- Squash commit 10 to commit 9
- Resolve index for new files to pass the checkpatch

Commit: sandbox_defconfig: Enable configs for sandbox i3c
Commit: agilex5_defconfig: Enable i3c configs for agilex5
- use savedefconfig

drivers: Enabled Kconfig and Makefile for i3c support
- Add maintainer for i3c

drivers: i3c: Enabled Kconfig and Makefile for DWI3C
- Add empty lines for if/endif

drivers: i3c: Add i3c sandbox simple test.
- Removed DECLARE_GLOBAL_DATA_PTR

v1->v2:
--------
Reorder commits.

Added commits:
- drivers: i3c: Add i3c sandbox simple test.
- test: cmd: Add simple test for i3c
- configs: sandbox_defconfig: Enable configs for sandbox i3c
- configs: agilex5_defconfig: Enable i3c configs for agilex5

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-dinesh.maniyam@intel.com/
[v2]: https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-dinesh.maniyam@altera.com/
[v3]: https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-dinesh.maniyam@altera.com/
[v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.6212-1-dinesh.maniyam@altera.com/
[v5]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/
[v6]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/
[v7]: https://patchwork.ozlabs.org/project/uboot/cover/20250728065612.6039-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (12):
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: Enabled Kconfig and Makefile for i3c support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c sandbox simple test.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  test: cmd: Add simple test for i3c
  configs: sandbox_defconfig: Enable configs for sandbox i3c
  configs: agilex5_defconfig: Enable i3c configs for agilex5

 MAINTAINERS                        |    7 +
 arch/sandbox/dts/test.dts          |    8 +
 cmd/Kconfig                        |    7 +
 cmd/Makefile                       |    1 +
 cmd/i3c.c                          |  271 ++++
 configs/sandbox_defconfig          |    4 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/api/i3c.rst                    |    8 +
 doc/api/index.rst                  |    1 +
 doc/usage/cmd/i3c.rst              |  146 ++
 doc/usage/index.rst                |    1 +
 drivers/Kconfig                    |    2 +
 drivers/Makefile                   |    1 +
 drivers/i3c/Kconfig                |   27 +
 drivers/i3c/Makefile               |    5 +
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/i3c-uclass.c           |   38 +
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
 include/dm/uclass-id.h             |    1 +
 include/dw-i3c.h                   |  252 ++++
 include/i3c.h                      |   93 ++
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  698 ++++++++++
 test/cmd/Makefile                  |    1 +
 test/cmd/i3c.c                     |   50 +
 test/dm/Makefile                   |    1 +
 test/dm/i3c.c                      |   34 +
 33 files changed, 5817 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/api/i3c.rst
 create mode 100644 doc/usage/cmd/i3c.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
 create mode 100644 test/cmd/i3c.c
 create mode 100644 test/dm/i3c.c

-- 
2.35.3

