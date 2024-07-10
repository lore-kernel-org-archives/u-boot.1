Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CCC38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DB4886F5;
	Wed, 10 Jul 2024 09:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="E/tLNf39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12101886EE; Wed, 10 Jul 2024 09:17:34 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CB2886F1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koNcOYF2RNDq1c2dygrXSuXt65VlTn80NzZADFkKY3sQCRni2ffw8TIk/dLXqik4Ii6iye8UFfJbs1ezPmXvYStlXmFXD1Muw3YM07FCkuuyF3d0+csNNBUimN+lx9jGYZygdjdc240tQFqaVH2ac+h9hb4anEHw7jf/XI43cAesnZlgE15HntwD3qXZf2mvRDuDZnlE0M+SPAM3+ZRxvX6OWJcO9PyJn1TZzwHxcReGImbHE4Hmn7Bgbam2PbRluT+x9z/3CJkrsdZyPMbxT/2RHyLyQoeIxeKH51RsOGnGkY6HZXbf5I4NhzPZX+UAo81RcUiwPvdycT4AAKIpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9VnuPUQi1jqnKXmuF/wjoyx7dxCrps9qKSMN9HLnOo=;
 b=MTpaS8S+J4oGZ4EkYn9+OfB3aD3Q0uL1LFCexXu8Pp+hAp67+v9lE64UG7MS6J0LyyZlCxWIB4APgOlnctAlwahRt9Ku1N8VFkNGuFi/lvwBsoN+YZr3aHxGngWG3Q1QGqJOjPxEG4gaUyQz+H3cpGZ41u9/ZtzA/gZv//k/R9jFyg1ah03oLXnMpiwiMThTwKzKfjlgJETkW41giz7Zf/h5Z6lZBsULdQrviIFpYfSd3XyUZlQFhmZYrrp69DbVEDsQtP1yxfwJg8yAcS+slMOvQwPqXC48hrEQrtIKImGBv8rwyidjpc7SklYNsrAfXQyg2XTQH4MbTIuwoCWqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9VnuPUQi1jqnKXmuF/wjoyx7dxCrps9qKSMN9HLnOo=;
 b=E/tLNf39H9Gp/hAOI2rd4niyd2Pp6TF99sqcTjKexGgd7wWnDZ3fB3uNnSqDTIobaBlqIFYN3dpWPJHJ3aBHtPkct1bLKZjd2iFtf6tpjq5nsH9KS3gMedUHdwUdHMxcKPbMiQIPvgjpuqsoIOXm8Ue4Cg0ZTT5JWyuPj77ctlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 07:17:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:28 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/5] arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
Date: Wed, 10 Jul 2024 09:16:08 +0200
Message-ID: <20240710071612.1717460-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf04e00-4b79-4f41-ca7d-08dca0b05b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gTLMEGpi/W0iuXJ88TGo0QYCgBxLrTwemNfWwqYKN/MMtZheS2YPY9Uo4zhd?=
 =?us-ascii?Q?YcKRqAQG1zHn/jwcYWtc8V4AyhNvxHw/1QtumTl1Be5CHJAHyhGKkJK0n7qo?=
 =?us-ascii?Q?pwYqBTuJgocurK4l0EDfnce5GAnVZkVY/YrK0bdl7Q+lbtAxgam7LWzmHbbz?=
 =?us-ascii?Q?H3q2KVAfy6LmRPUMn8NY1/fr64fo/v1kQsNdPcWRMuPOi5FTDanuNX/eWX+2?=
 =?us-ascii?Q?D29Gd81i/GEpJtv5bEsrtS9MSDKCg8LvcC/ZK8Qr8lX3AHpYbGUIOjtu5Che?=
 =?us-ascii?Q?m92jsZ/wSHDO8Dg1KVlnQJPd8Zh9hve0Y9NoM51mIHwTYgmktuuKoAVz/s4T?=
 =?us-ascii?Q?qDqoTR+6tNt/c4ubL84pK/V1o3z8Jqw2wJhXnScJWnM/qeKRMQ6lCymJuz7I?=
 =?us-ascii?Q?2OeIJUBT1ueYcxPub6XtXb6kkuQlg0QQO8ntL0IRDgEAi7AIY4F3u8EbKT8h?=
 =?us-ascii?Q?4C81JXL6wNIuqKZ8lja7vWGeRMbGCa39b5vpZxXpjeMHC1NgnPz6BOxzxHk/?=
 =?us-ascii?Q?F4e8rQ31rggmdevuNVXCcuM3vi0sXNtYOJJorZXdzbFq1xhv73vDMSYqkgq4?=
 =?us-ascii?Q?+j24PJR5DWVEE78lxJ0Opy6TpjOosrpZi21IowpszcdNtw2I5WTcJkMEsCCA?=
 =?us-ascii?Q?HGq0ndtU8gkq3KkpBcoNUiCiuhoSJDjKJa5+2NnyVtA9DLxzIWR+3cvapH6d?=
 =?us-ascii?Q?ag7twmcpDgVqkUhTcu13zxNkATXrzJGhMPUpWcFsXffdJZHwNyxvV9te21J/?=
 =?us-ascii?Q?zmMLgZI9pQVL35yVAQrG8k6sAWvUziJOGGqiZXk0qXiQEn74n0Komn4NGDuj?=
 =?us-ascii?Q?OJuh7SBNqvYFQgYhbPO4fBWEh8DTHSFBIbAahBZDnra3xPldRuNfWQmQO7mE?=
 =?us-ascii?Q?uNx8HC0foJ9mZGUmk24EfCJgzGphQ0XG2/qDb2lPXOdcVMmEoXioHlc0S8Dz?=
 =?us-ascii?Q?9hL/9Xvhdelr+YluqVOGHqodb+ROOzF0S/0UE1WfjX2FCElSypUAI0MVcgID?=
 =?us-ascii?Q?OymVi8ykVJ5JWa3BO/1h52xcZd1sQYGxaEl159El28yXN3iHEK7Qw5dFEo8G?=
 =?us-ascii?Q?tzpVGqD16Kwvz3kqgyCPbJDDQjLAgygkOlJiAUVPQzq/O91hy9bURTVtHCVl?=
 =?us-ascii?Q?PTV0X9IT5nrfQUTNEm45b3WWJMadyWR9PO2IeKQ+I2XeHx0A0zHacEFPtvQ4?=
 =?us-ascii?Q?hveVO8psVtDIcFAH7Oq9pxTQ/wKOX6KPwHpi+q26sijRJcsxT2jSMwjyHN89?=
 =?us-ascii?Q?8aOGgqnlelPTERORPjOOstU4sT74Uj/VOyyPq0/SNi99Za2lfW5HF7PyqFqY?=
 =?us-ascii?Q?cXEu1pkkgk/UXFPqfZ9YEqvzLawVBKhe7tJZBVyeKcU5so0bDkpI1Oaqg9+2?=
 =?us-ascii?Q?q/iHQkRtHDx56XyX6d1BMRcpPSrFyvdKTMgjBbkkimiinEYIYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8Nlmvuxje8d9DioP3cjEmex6EJ2+Rn/j8prllW8BUqsRLe+degZ0og/YT+I?=
 =?us-ascii?Q?2ZvpvldYYraq2v89rEDe/fEAoeCGaH4Dqh8rDVUsFHeg4yla9OROmP70EVxP?=
 =?us-ascii?Q?Jwc/ColL3wANotlA20uM1/NMPUJLWmH5Pe1iESz0n6ujIeB2ud6qxNwSTsbF?=
 =?us-ascii?Q?FdxJATpb7qMk362FOZmuUeLbpRV/jnNX56fJ3ya3V1BTuYFi8JiVzHXjlvuH?=
 =?us-ascii?Q?F+L0pgaoLBUvIwnupP8VHZDWBUgZVVam1g0vsyrNMbxg89nhFB+DkgKWSinO?=
 =?us-ascii?Q?8yfyz2xJQFpAZ2rwzb69P24zhnGuWl5KNM1BdYyJw8VS4kDoxhXGj86vLyfA?=
 =?us-ascii?Q?bzEZT1Bm7tlkblebH89HONKRqD4MAN+HgmiSGcse++OZEDOLXA8DlOhLvlBU?=
 =?us-ascii?Q?W+ljfPBIihW7wTydl7k61wk/Mwd2hOJcyegRn1KZyvQfNt2XDfopgoDWkfRR?=
 =?us-ascii?Q?bkOelPMFBEdNDWZDvEeEuNaapVudvZ5pd0QI+chjPsdtoVsuCssu1eTJiJy6?=
 =?us-ascii?Q?Ulr3OACJI4tPOVoduKG5oKhpoGb7+C9JVGWnMWsJ9wssTnw5tqADYdMnjIah?=
 =?us-ascii?Q?Yi3pIvLUCC1HPk5vigzgy0JmhPNK3jvu9CKSaBnMJkfn1DBnIB9XuFY3WFSn?=
 =?us-ascii?Q?yWgKzrZHBvopPw9AxLF5uChjZe0YjVBe1f/njvt4SPxTTgFUmV/pSJCvtVpp?=
 =?us-ascii?Q?6gofeUdyn3VGPos/9jRUgD5qJ/si545uq8UucZuV/jVs19gQcPMrSXUY+Wy1?=
 =?us-ascii?Q?FvMnJFZH4uvuqxAlyEQ3DJ+KYnT11D8CZdMQ1hi76drB8cbNXn5KMtCi84LF?=
 =?us-ascii?Q?aiI9Yjr8StB7STDRbjBgzok5JLgF2lmUFCFKMRfEJj4EmNcLIwUgZA9bUn1F?=
 =?us-ascii?Q?Zu5lv/cInuyw04ofGhKekr/SKQdW9AzdqU+7zTxRggGYaGVVnHrgPb35H/G3?=
 =?us-ascii?Q?aqu5bjCAD+olZaqZm5eoz4fzHEar1QPKnAA7InhT7dIX0LPGxYvG1n8mn80/?=
 =?us-ascii?Q?TvZ3KSmmRFZZxNE9PEHDo6Y0ykVa/PQSRas/Y9dn6uHIUgDWw+u9SY899prs?=
 =?us-ascii?Q?vgQCoeD5v1tq6oi9TWq5/F8Jy3x5oU6pYJbQKJZPZ7RxSCz8RDJD+3zEndrW?=
 =?us-ascii?Q?05VbZKy62lfcixMhXDpYiwrpHjTcT9MYApU83Wm2BlYlIvl1NR8ml5eHv9+U?=
 =?us-ascii?Q?OfDMOKflipNwGPqmcabbQm1ZphLcbeWQnCEcWIZ9kg7G76XsJ/uPlBwu1XFw?=
 =?us-ascii?Q?dreXBbFiyV0AHyS8f0XMja3heNDmp/KEEdIvptoaq9X9g1knhxDs0sbyXuJ5?=
 =?us-ascii?Q?AXuYvu2FwLraxCayggAkdxuFsdgThvqkPK90hE8MLvAJAjjwuGpTYNH5p9v7?=
 =?us-ascii?Q?mul9t2mVO+UppVYry3EjBL5giMYuPNOHFqYWrlVgYr1bJ2KSiz/KtlThMDTF?=
 =?us-ascii?Q?5jtedd/6DhiVVwuhF5k/t8vvm1A2AFs/3PL3QbFl+h4P2CqZeJQD9zXBXGba?=
 =?us-ascii?Q?rrT67RJb9+WRKxUb0RUUJCqySNC9av8G+noo5QjZkmfCSgyxbOp0GFD3X/zr?=
 =?us-ascii?Q?UnKK6vTSyCC8lBCQGFcypyWPTSUMNfE3NZ/ZQJg1CA9HhEdxGlSjV3ClA7Fr?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf04e00-4b79-4f41-ca7d-08dca0b05b46
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:28.7428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDmgjqc5z8t0is4xVdbl6gJ/aqgOQZ1yNmTQGMMc/PLYqxTUH6bIHCkBwTLcWUtRUADvRBbMKWGesykAG4Xxd79AK9TLnSYquGkWBzzSo1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 ...ay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} | 0
 ...overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} | 0
 ...ay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} | 0
 ...ay-eth2xfast.dts => imx8mp-dhcom-som-overlay-eth2xfast.dtso} | 2 +-
 ...-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth2xfast.dts => imx8mp-dhcom-som-overlay-eth2xfast.dtso} (91%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
rename to arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
rename to arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
rename to arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dtso
similarity index 91%
rename from arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts
rename to arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dtso
index 82dadcea96c..f2d768cdf91 100644
--- a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dtso
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2023 Marek Vasut <marex@denx.de>
  */
-#include "imx8mp-dhcom-som-overlay-eth1xfast.dts"
+#include "imx8mp-dhcom-som-overlay-eth1xfast.dtso"
 
 /* Dual RMII 100/Full Fast ethernet on this SoM variant. */
 
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
similarity index 100%
rename from arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
rename to arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
-- 
2.45.2

