Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07551C25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 07:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EF888027;
	Thu, 16 May 2024 09:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BhAUzFuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F25880DB; Thu, 16 May 2024 09:53:31 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B0A88077
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzkKTGPjeiPMMCCIplaKsKeVkeUxvqozvEvjDStqDBg2wNINZ9w9VIKXOc1hT94FZHW06v0OSIfJuABFv8sCamvmgzT8Z0Cc0RB95xNCt14Q7K3ae+QXQJ/9jJk3nv6CSqgdcZxH5JEY0ebbuhhSX0lKCy9t74YjS3ubebVHEwBEDwEywKWYjdJbxQddpKScN1APwK3D9jxll+kVyOyp4FkKYgsRAFNWU6FjTcXB4zjjsiX4EUp1oqNviORtXCRI2gyYyQK9Lru9frea6e0+0KE/1A5ETGPyTnt/lzxjY+XZ1pS5UEKql+4in7kqasxdqTsh6rz9KYseLzf7JVbz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=a1uesfwKBMNtrpPAaYE1tsGn/yyHrpJ193s0d0ZDgvCcRhCOeoCE5zuKX7gLMFemZfFZuF+IRTbB1/QDg0RH/yGved1kw7b/bnl2CK/PbIA7QPf5vd7cN8xUFNxNotMilcmtq+Y2Exs03jG8yYov0KxtwjVtsK5yGt223dr/+EOHHiuziAmNoRjw44H6PhNfkM+htDZ9pUMvubR1OxknmKTdVI5EgFMS8eTmIca+MHVnt7h8VXQhHM7e5UPz1vG2Dg1XrF5KkTk0G2aE0dVuTdPNYn1w9pnOX7/pq36IRTZBllw4WIIt5Y6G+9kIO0DzvtAPq1XWqq+Us6L6CWuPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=BhAUzFuIyEpHkM5UHrdu/ieYx8QDxW5hkx2MX2g5/qYrjSb/bAhJEnw2WsoQIlHUjrLhxd/GJXIP27zE50gcvVECUfyGeE0JxJAVpNWgZh1um/MVhgHYkziOoVbvthRsKii4serxdtioZeoUkuio+WT75V+RQ2sb13z9ZIGx+1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 07:53:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 07:53:26 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/3] cyclic: stop strdup'ing name in cyclic_register()
Date: Thu, 16 May 2024 09:53:12 +0200
Message-Id: <20240516075314.1548051-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a550979-be21-464f-fddf-08dc757d44bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gMW5C9SO3ONDsNHxTfaaP76TSGGcaN6QVdJT9imucKhtT0pI8lr4RuXeKVEt?=
 =?us-ascii?Q?ojLLZDocgGC4L82dE2kSydXRODRlTf3GuBn5tKwBu+fyL5NHoO2u2HlC6ctC?=
 =?us-ascii?Q?dlDqAh53Yq/IjUF4xQED7HcOR+WWoxVOa92XhFO+unCF9nt4PaKNXHi5bxXA?=
 =?us-ascii?Q?azhvh5FiMLOJ8fw2O7zqJeuVxS2eRIf0wSCRrhS97cPVTYwEYIWG1cm5+Vv/?=
 =?us-ascii?Q?gOFP+cCb1NIdBngv8Woy3Qgu//lc6+byY60Mi3HHvcrOsTwTXIFViYLHay8H?=
 =?us-ascii?Q?EQ7wnbEErhaHwRcYs5ghOfAdYmOa7LxIjigIfodA/RvIJ02jbOsaVUOTiBj3?=
 =?us-ascii?Q?Ym6qCWSq+h6iyW2XxmL5lB5hdQj2Ti2fxTtlg/1QL6DSclTTvyyxwScxUIrt?=
 =?us-ascii?Q?Bj/0vdfsrhzv/l1hRxhTci0eAyuucVSE813Koy9PqRK0m7QypbpQcS4MP03q?=
 =?us-ascii?Q?gUQ35P+0piuOZHFPWmdmhj2ADq0hqEcIc55cO8u8UZJKocMOFgGcx7h/LWsN?=
 =?us-ascii?Q?XvQN9YrMTzU6w9zd0QAefaVSYuP3Amu2cISPczLrigqKVtvPN9PsSs2Cmojx?=
 =?us-ascii?Q?PCo0U+p2+pSSh7Sq50bu33V5Zm2L/3qpMTbvj5CO2QwWBN6YweEBAncECfPK?=
 =?us-ascii?Q?fLmx/Cl67evODPCOIDrKfeLtdtgK1u+tMyHBUYhlUPrmrdZR91UI+Hi9K8OX?=
 =?us-ascii?Q?BliQCRgUOhBII8lVpPhPyfph9+J+kTanZXxucfmzmNQfuUAuhjInNfaEf4jz?=
 =?us-ascii?Q?AiB7aSJ+eqncngPUcLTtSF2D6VuHjIDHYnyOP+bdHSf/JCt8FYSybVPSxBM1?=
 =?us-ascii?Q?1GANXIVxpY27A/QBkDdNuvwTIRv66skJPiyDR+5/vqbYuKkrd+7X2Qrjw7Kl?=
 =?us-ascii?Q?hqmQfMsyZ7o6dFAyqK8GyvpOIqKAGqYH7vb17sYn1KgpxWVNIXb/P4ScRxT+?=
 =?us-ascii?Q?sZ/6TTiXU48vEzmnuIXyrG18eSWXb8VraP1MqYMrXXFLA+IxZJ5KlT8WWEgG?=
 =?us-ascii?Q?vfN/ioTzf21fgTEDzKmZXPCAgxDuk4tLY4u+sdTx+mAOnEK3drvA8/xNnnAl?=
 =?us-ascii?Q?yosZ+OAwqj5gGOd7Sz+ES+yeJPHuqLOvhdHdW5sOKrqi1S8OhuI6hBXa386M?=
 =?us-ascii?Q?pulV8ixwOhPqRmDwbswn+VVb03nokUN/3UUdwxruvfm2YBfR8CY83d6sYVZk?=
 =?us-ascii?Q?JfKZfWgK2qzEqWB84fjPQP6MTsWht3Ik+xK5SGcgby3bAKCn9smeT/KU5TYc?=
 =?us-ascii?Q?q/DZ8GbUvwvUa93gTR1iwu01EG9dTroJoQ4mBdZ675/k21nzqpzusLxbMlHU?=
 =?us-ascii?Q?COMqvhgQrQL5FQ/SJLR7cXZJR+X4ocjx2ZYLPtoYV/mGdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQ6C+Th32dpTpypZL2xIQFrF6NbrAB3ALCCaaBcfGC8fUas6/LnvSF4AmzCn?=
 =?us-ascii?Q?tixZgRMH3DLLb76XA2yFEE0G6er0yQgXVzL8iGRdWPrWkV7qwxrYdI37hap/?=
 =?us-ascii?Q?9GKYA+Tu6GuvrAldam5+JRC2qKsiJhRWlUAMdFaMDRUCb+Fh+gNOUhwzOquB?=
 =?us-ascii?Q?/s/7ehKeznUTqUr16J5Q4ET5+4kT9Y3ugVZ/xGNJdzYtQBrF0O/vL94eptvq?=
 =?us-ascii?Q?uzXvPPxWKgy80x8L1tZEbg0cEAxk1E9hm7aKRmDfxUpqbpQE6XM63CfGAnJU?=
 =?us-ascii?Q?qhANlMythKv5UEG+bREvZ/o/S/tIm7e8Z6skjNHnhjm+B8krfK4a8E7L7bxt?=
 =?us-ascii?Q?/ctxnB8/I/LmoCXb/xXJV4LcFVZw7EqrEiSmlVvBawlUFmnvTORlVJPsQ0OO?=
 =?us-ascii?Q?b0dpM2eWrdbzCwt5wFCtqUfqIT91QcRIpA9XxSdcPVM42HD2axcekLpB5Xkv?=
 =?us-ascii?Q?PJrygYt3dvhu/PaU5VVIMz3PSU1aRrGggyEpAOoAkPUYVrbPVev6wwJDGpQc?=
 =?us-ascii?Q?VsxaHMSuxt11XGWBhApX3d6Wp6ecIl9FmwhvTQtEQvvEkA2j+qaUCT2DD/0W?=
 =?us-ascii?Q?rewPWCVNfKAbXQ9Hlvq8R3AS7GOnHJSH/qa6n1bH3qo+TaZPtNxouBvNkSrh?=
 =?us-ascii?Q?MAnmrxfUtSp6pBtLbtcnzuflgzYyHhMwhVKI3Q90S3Mq9rFZfI3GTqroHPIZ?=
 =?us-ascii?Q?bzmKpZZgLS4fNVm0R7o8Fh/9fYo2uxE2oyRlTYm3pzBZs1S7uiBRznp7xmY0?=
 =?us-ascii?Q?bOTXgXk1eZbq6MXLBcwhQbetBKluBQd/HrIMVsqYyax1TyyyM2vrZd8s5PGm?=
 =?us-ascii?Q?TMYo/zIrHzOh+e7O0yhAD9/2T2x4dr19wulez2yoyNEt5SItkQzC2kfJ7Rnr?=
 =?us-ascii?Q?FsfOFO7FbkCAgDA0mTDrgeJTnhitQobAzae81xAnjRFoL2fAc4s66uyCMLHc?=
 =?us-ascii?Q?6kun/8awMGEj1x3tznPpUUtJZrGiIqBuai8S9Ls7LNC1T/yWUbRieIinIi2A?=
 =?us-ascii?Q?kN0H9O+UGyhHo+BsY9S/EnI3dq4+uwcSvnu1M3mzy2QbeTPoSPvf31wEegh7?=
 =?us-ascii?Q?bA+trBpX8JD1b5JEkDjUa7nVGCcLUU3mmuchye1yghb/yvdXAybHeIg4psUR?=
 =?us-ascii?Q?Ot2Mes7hLi24lVVLFPpMw+IWjQo/Ncx8Z/eYjddEFDasF0+7E90UoGvSuWwT?=
 =?us-ascii?Q?tXv7ZcH/PiPanFhX0jd/r/vhrTuLq23MZ5FYOTsOb7mTnWAOyff9OC/J92Th?=
 =?us-ascii?Q?XL94KP6mP3+OsrJUmnQHX8Y+4Xg6j3pno6Jfc0nO+e6M2EaID/ghd0unAMAl?=
 =?us-ascii?Q?c++uzjQlQleI6sJCABvNewoRVwqmjSkotpdVhTUR/3U2vbUyFPenD9mhHsn7?=
 =?us-ascii?Q?b2p66/sNVTFR3yeEpEn/YVyLScD1UJfXSw6NhpaBE4822lTxie6Jnq4ZaQ+0?=
 =?us-ascii?Q?oEh8cwg3EwrcDhWtKpNGSGQ2LeDZMQ2XUO7kl06JcHrU7MBZnt3bIHYQuMcX?=
 =?us-ascii?Q?orV82coxrscLjrDLlWP0VRPnBvQOkPmXcWJ6UNnMJUTAAgZLhaNdrMbnbOJI?=
 =?us-ascii?Q?9gXwLuEK++Z8BVXUDdktf2DhvIIfEvz4ObMKIEIJuS6t80Llsw5QFJiip+6O?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a550979-be21-464f-fddf-08dc757d44bc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:53:26.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNet5Z3eV351LLvbS6Rf/MgRgsCrSf//dSTNzaB9vek8AZ38Pp8iUQBec9mT+CNGGVyGXuOmwLs1VCQ2pff/cFLE7O5YKp4b+YdiRsoGyi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6752
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

We are not checking the return value of strdup(), nor
freeing the string in cyclic_unregister().

However, all current users either pass a string literal or the
dev->name of the client device. So in all cases the name string will
live at least as long as the cyclic_info is registered, so just make
that a requirement.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/cyclic.c  | 2 +-
 include/cyclic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c..c62e7fa7d19 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -40,7 +40,7 @@ struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
 	/* Store values in struct */
 	cyclic->func = func;
 	cyclic->ctx = ctx;
-	cyclic->name = strdup(name);
+	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b80..38946216fb8 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -31,7 +31,7 @@
 struct cyclic_info {
 	void (*func)(void *ctx);
 	void *ctx;
-	char *name;
+	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
 	uint64_t cpu_time_us;
-- 
2.40.1.1.g1c60b9335d

