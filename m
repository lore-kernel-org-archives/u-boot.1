Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F831E937FD
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7447841CD;
	Sun, 12 Apr 2026 22:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MddzgLOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7894784119; Sun, 12 Apr 2026 22:00:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B5283F75
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 21:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3sh8PjA1oMvMHoMFf7CMVQgVqmXnVIqayEa+K46xI74LseCVGmlwvU2exaA7Y7Yu6g9QdkopUb50m4vQ5syxYiwMj7V7jiv9usgWlSC3BvZJI0kGEq7zU64XKQ6Bzi6yVaJC+KRMe/IQO3dSvp1SGbSwC4saiuMSqCPLp4BtZNS6EbCDF9EgpzUKE1yL/TgQkPV5NxwEokkMBuMJs4q2RKDCQ40bSB/qW2bmActCwldOmEquqFw4ohDasIxPKd9lm9NvJLusDdxj3oOqJgqCWDJDDLEHpY29Azbc/Ae3EppARwTrXmmUIwAlNnJnZoRDX16qpiVF1EQ/En/T9kK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYqP6ZPXz7Gi6V+4J66Fw9IzAwR1csZJl/5h+gGyHT8=;
 b=uvY0oKbrCP/lQCyspvUcDF6WS2Lx7UU8w7cmVbwh5KiJPp+Aj2VBiu5kkOu5r424FVO9jlaQlzirqQicqEiAYbADiq6pq25HzgyGulKSwJ6F/nD8CFYTb6vRNvC/KmL1ZNrlGLTsRnXkefqbsY6FMXeg2gyMqnbZt2d8dp1QExJbrj7B+aHo8DNOJbK4lNntwfLzt2OQlyY7h//VxnuEUDu+/4ZuPatxrsQduf5fbF7+sYEnA0Gdn5QcSAF1Hs0zSLqBHYl9HidFaDofYz1pHqIQY56pKEaK9Z/GFDeeQDOVZOc52VpIoQaHNWVMLoPEwGBRI6rT9iZDcvzTlT8EWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYqP6ZPXz7Gi6V+4J66Fw9IzAwR1csZJl/5h+gGyHT8=;
 b=MddzgLOKUUW2cgzZ9gROXEsfXOJLdxL8YhzjmmntXJKBP+VCXYeu9yefRr3gZVcEwQ7AYj/TNTUINSRJUd5Mdqc8Z8JMsOVGAJkqkazWKmTixLInKJVyQctGnslVMxjgX9TIspo+zd1szlXdyGNPM/hCEBUn2NGTBdkm0kJ3Njg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 19:59:53 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 19:59:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/8] add memdup_nul(), use it and memdup() in a few places
Date: Sun, 12 Apr 2026 21:59:39 +0200
Message-ID: <20260412195947.1982729-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0e69b1-9a3a-4db0-5d41-08de98ce103f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1sXOXheLPWYnPzZ9n7iHzpYunnfnQEPUSU0kxaZaMQTDJ/CFjKFPsydEwRqsMiLna5uvNZkuVDa/GKCcDH/kCrsxzx6j49VpHGej7rbZkirCkQGmMMKCMqJRHWHt5yNbOOPS7TUylLGscwchn4R0LJABMoSDf9FzJF58ZlbHqmmSmvERGIMRq3tCpwcp4qQrkdnbD0M8xw+6dBHFoBFR8ro8YAEG1p7E+s4Co2YPq/q1YJDw3rp14imsTVtNbx9PGWL7b16QBm1gTbXYiRrCQWojnRfMUcqQV7BXV3JTnxVYFRplzcm78MgfO9ywCrtwExjEV9ty76jC2K0v7ptvjSPodPBGE/IeQ8kXrusZhRe1lLLG8FV41VBUjdWx5JV2aKmfrtP7TjQTEW9ZYcSGvUSHgrcDt44enCIT1vM60kPRXUliB79K5gL1YOIFUNMBJuDQnT9aqtJLodfxlQgaWye0cve+Ki776LUHDrlAvPedafdRZ2dh2WQ6RwBprOmC5XxBgP8hfKOGBO/fvl/DpEY/hI0Xo8+blfmTQl748+nRLNVXmXUTszJNvc5U7uLdJW4zx/HlRU63tn0cwHywvFe3b/fmJk/pLhapGSR0B+1vOPLMHwqCPagPYBZIWO5sapKwdCme0poBh9If5AjasBDotEQv3eyoSlCQxD6GXNcYDQTGVqA3AY75CZmgyS6qVX7RA+nuQ1jfujFP0R0Ok9AdmOAroX1JZKBK0zFaZFzQYHYhyck0vML5ug94b2nW2Crdne45Bhnu0PQ2v7GcdYkZ8NjCiZy3BImXyiTd8uI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jnr+ssrd0KPMJKgXInSNU68CYIfFP+yMdDcobXgotEeXzNGmEL7KWNnmX+gs?=
 =?us-ascii?Q?KqR0Ion5PvgtqmJstaQzyHiNVQZLfxPE4a+t5Gbfcma3fwC+6h6PZybcb7aM?=
 =?us-ascii?Q?AePxQpTkhcjRU51mUgWH1BgbqkFhnQKgq8wZe7miNbjEk31FjOIx4TWreCst?=
 =?us-ascii?Q?MjSDAEqHJQBjB4vG3T7v8T6/+Ak5bOGld6c1qxDWNoQMhbUgHZ5+8xKARkzR?=
 =?us-ascii?Q?q0eUvY9Mm3pAdOrktktN+kIUIeH3GhXMyT7yv+NqtRPAMcpFcErXFrm9vm92?=
 =?us-ascii?Q?nGMPS3ci7BWSTDiIqzeBI1Nh8I6CGlwJny5spjuezkzlcQFSfqDCBwDUFOAu?=
 =?us-ascii?Q?jGmh3stsLvvjre5UhlXOrZc+GLBJh8WnY9kxzrjc3TJPVRbR5hSmYOSI3ocI?=
 =?us-ascii?Q?4IoV/4S28t1I/JTdpqvo42dUf/ZMFucvNjz4RTJUPF3DqVcjrDxBwYyLLXV3?=
 =?us-ascii?Q?VZGAmb100VUPa1BOk8xO8jk6dzVg8qPsePXOxcnzUUcj+xGxCZ76SjLVzbUk?=
 =?us-ascii?Q?14KyPYjPPYCqzf4eHhUHYfjXwNwWO5cu98Z73Pzv3ou/pqtwq/CODBApAmp5?=
 =?us-ascii?Q?W21QdS6RNJY4UyMzeuZA93l9rwk3sp7KEbMdLJbiFt5pTH7Ec8b4NnoujBEY?=
 =?us-ascii?Q?1N7Y3466HyPkIMXAPAdDV0JLk0839R5VTKC8AU7elCnIEZR8qHx2AF8+AGo2?=
 =?us-ascii?Q?j71oC5Lw6Fm4yRgq8jRNF2L9GoScitbyZeUNbJkldJSKvZXhIz3159xZGBej?=
 =?us-ascii?Q?Uy1JxzliMdurS85DmB2PPF9lX1IfCuPF4Sk3//7/M10DIRvDwpoUio9C++jg?=
 =?us-ascii?Q?JRIohalXdJwetrTfQ2C0gWbmExj7dq2a/qvbFn8/qifQh0q7EFPm+BDunL2f?=
 =?us-ascii?Q?oA0PBshjGdfJpG4TMczdVcP0XjQmBwLxVQl0t+Hwsbgm1xnBE+pdx8m/i0yR?=
 =?us-ascii?Q?LMLoypfopon3cFvwnGBmr0AyVo9sFu/VoNkoMVXC56V+UYG8ZmYyVzDC5zsM?=
 =?us-ascii?Q?yMGsAK6YxK1TEnZXjYhNnurjqxmXQ3CHOd+Eg5GB0ZCYy33QlRn0jHepKGeL?=
 =?us-ascii?Q?cZKwQtPwOyLyVH9+Ey7rijkwIB5mE1byY2Q21Qekx9RUDf1HN3NRPT+UzgG4?=
 =?us-ascii?Q?IHf50luFnVCWGqw1bYhXkfsgZebAsl7HngOJIf0UeZJmStsVPDMzRseIpP6M?=
 =?us-ascii?Q?vlJPMmBTIgHzf18WtTmz+4uM+DQWWqOdfg5AZuYEJ6ZDoIBmvB994PE9daMS?=
 =?us-ascii?Q?L59qN3La6QnlTB2kpiTrVoiglbqsnOhwUfLnuQayoYTH0JFVwy6pgCQFm6MY?=
 =?us-ascii?Q?8k6nXz5m9HxjFTkRp/MGAD/xid1G//LfX+RxnDEuBPicYg8FJ7uuOM4pKWbs?=
 =?us-ascii?Q?7MVzUSpq2vPp8pICRG/QK1InFXuGh5jeaHR5+G71aGsXssD9W91NnCFBSrQZ?=
 =?us-ascii?Q?UgfKcPy1ivQWjORH49RDaQ38LbUXXPdycSQewvGbY3/BZpTsY76qJJK8ArTQ?=
 =?us-ascii?Q?60k/zm72J3lufH4FZWkr/m943IOUgrHW6E3g/9v7oa4LcATfH4/VPCraNsPi?=
 =?us-ascii?Q?VFwJE/8L6WE6acaoYhHwEcpsB6bQmqcMJ/2+nT9CagXM7vYZVWfw1gzYdNO0?=
 =?us-ascii?Q?qg5NcvHwofO6n/h/a2nmxlQAUpNLy0r26PHOgs+K3R1i+gJLUC2rGtLVEi/C?=
 =?us-ascii?Q?ao5wXd6pP7eV4bHOBJPjWsydwOR88OwROpxsFk93kv9nwGpAcXf+LoC+StCP?=
 =?us-ascii?Q?H0ZmiEPirOyVyfshJYtSviS+ttVMAic=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e69b1-9a3a-4db0-5d41-08de98ce103f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 19:59:53.7737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mnhAwlfdp0zpkyIZ6n9iap3DqGdlyQjuCOGziLcUIv2xDb0UloNhB1WNke0YmsaGZD+aRQ3CpDSrhr0lNR1CW5m83aUb6yO7fS2tvAj2+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

There are quite a few places where we allocate X+1 bytes, initialize
the first X bytes via memcpy() and then set the last byte to 0.

The kernel has a helper for that, kmemdup_nul(). Introduce a similar
one, and start making use of it in a few places. Also the existing
memdup() helper can be put to more use.

There are lots more places one could modify. But for code shared with
host tools, one would need to do some refactoring, putting memdup()
and memdup_nul() in their own str-util.c TU which could then also be
included in the tools build.

Rasmus Villemoes (8):
  string: fix prototype of memdup()
  stdio: drop stdio_clone
  lib/string.c: drop pointless __HAVE_ARCH_STRDUP
  lib/string.c: introduce memdup_nul() helper
  lib/string.c: implement strdup() and strndup() in terms of
    memdup_nul()
  lib/hashtable.c: use memdup_nul() in himport_r
  common/cli.c: use memdup_nul() in run_command_list()
  drivers/core: use memdup() instead of malloc()+memcpy()

 common/cli.c           |  4 +---
 common/stdio.c         | 18 +--------------
 drivers/core/acpi.c    |  3 +--
 drivers/core/ofnode.c  |  3 +--
 drivers/core/root.c    |  3 +--
 include/linux/string.h | 18 ++++++++++++---
 include/stdio_dev.h    |  1 -
 lib/hashtable.c        |  7 +++---
 lib/string.c           | 51 +++++++++++++++---------------------------
 9 files changed, 41 insertions(+), 67 deletions(-)

-- 
2.53.0

