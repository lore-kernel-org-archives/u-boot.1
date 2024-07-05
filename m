Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CCC2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40AF889D4;
	Sat,  6 Jul 2024 15:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gE1JKM7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1E7889AA; Fri,  5 Jul 2024 22:30:16 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245BA88905
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp/PfUIWu/SYsNSNPJsT8wY1HtiZNRtjF6h91Kz8iqXK1LUrCIc1QDMaVyiTUZzenRc8OoWDrFcBfi41g0a3fieLealpW7wubjlfqNsUe9KKlRvsTiOmt4NPZmNUvkW9hoMFbBTJ3GclTMXSZYtT/h7CY17I5wtatzG7eCYFYF8giToQfBxEVtlLenpzZWfvEhp6eqvf+5WiGT6gxYi6OBJBTWVbPHkf2fDqyWLu686X9wixyWVT+m2Dmu1+nnMYzYu0J8av1SK6JQnnk6/DDKYSLN7BUuJ++kPv2rVGogq2bxlCXu+pVr0iKEY2nH/ujFbBJz+jLIRZ9UYJmWn7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+pDfKRI7/Sny/AuHA7r3O3y1RNK2JtG5bq6JmIwvfE=;
 b=BdMlsFHPwv/OPu0ixqdba4S9BWAA5FFRwWmkojmrVRpCSdV4XUNS6vCTehU3DtGV3h70psXo00Aba1OXAF2/SuWsx6XTuXClp+N1gFELDlOBuIopgIxU+fR6MowDjq4vbTOglH6eDr1Xv1TL1WeYdkNSdZsJM+mpgT4A/u9ykgEe+2aP5XNkWuYmkA83SmcQtISTGL6jkH2rbpLyU4UwsVFaSIfGiIf3VqokNzqQKws7g4UwbNA5ThNPAGV9Fsniw90rC2zK0T0F1S6LIzVil/AcxjWAO9yQeH+EK8yEeW5O1Ul71+wNjMaRqhMYa2dkIvM01/7AnQTqOXrqgW7NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+pDfKRI7/Sny/AuHA7r3O3y1RNK2JtG5bq6JmIwvfE=;
 b=gE1JKM7mioPk887n6WRxrdGBJtmki+ugW4MpE4SfyQFGDLOKsiUq7P+0MQ1yY5GFIsxku27jszb0hGb/aPPjI7+AkcfxTNKfJ02XE58HGCHKGLxur+ZPfH9y3HJkcKXb7hXFPhY8YAa3vR39ue9aCkFWXr39SiwT38MUqFl/Hpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB3PR10MB6860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 20:30:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:11 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 5/5] kbuild: Disallow DTB overlays to built from .dts named
 source files
Date: Fri,  5 Jul 2024 22:29:54 +0200
Message-ID: <20240705202954.1149590-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: f564eb92-c2c9-4b07-1b45-08dc9d3144df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cNfv5lthfKKi9qIJCDqxzoAsBOxpIlYBFljxhk+YEdAwRNNynxH0csjEAxGM?=
 =?us-ascii?Q?RmuTsPv8SbYCsWi4aAegvLZ7QqX4DNtgOR8nq4MyQpFdO41dmaQ+Ok8wJClF?=
 =?us-ascii?Q?9Ko5ai7iiaHihivyS6+eacdULJ0Yhmthe2yxXxW+CCKhLpq3JUD0khSx1nbD?=
 =?us-ascii?Q?Y1dJLzU9Qvcc7cOTn4qkzgJmp5CGOATmp2NlmMz61De19H45ugzEGSIdP68k?=
 =?us-ascii?Q?OYLDiAUBiZLWxH+EGl3b7iTaA/8XjYD9Ok08kIgEzjSHI0+WFkZa/Zg0iPhX?=
 =?us-ascii?Q?RXJ+H3nrM6a0NUln8PS17YYCELM6GkT1Y20IZ/9SctFisqWjpE+cRm/4p6el?=
 =?us-ascii?Q?Jtrd+hIf8W86wbJtZ57J3KaGS9Y81Av523vjkx9pCBnVd4SDI96WCu5luhRw?=
 =?us-ascii?Q?VX0iLmLixVzmeGmODkkmdlcT2XGqWyiOoB+nAxQZ1KlwLKLdpT+3GzcSXkFY?=
 =?us-ascii?Q?HP/oWKB2atGb6+hc7XkUdfJ3yoR5z16+UqkmO1z7sEeEfSY2Ck8FBAGJoO3z?=
 =?us-ascii?Q?WxgaXGpWABaKp9nC+rxFFIJPSnRuXtWOiFgd1Yeb4t1mwcKa20wO7V+XzdPM?=
 =?us-ascii?Q?SqYCxzgffdpxy738LBuXMEhmPlLn3xo8tO+0T4cfSuZxhr2i5m2lenporJE3?=
 =?us-ascii?Q?rHepq2/amQBwZQ76Kvzk1wjquyvzcGtZGpM+42peqmV5wUQLYIXcv8hn8at6?=
 =?us-ascii?Q?48aS8oW6XGNsJSWbeE+8tCRKsO0vr86eJjeaeowX2RCjoaWnO/HNG4xFQRME?=
 =?us-ascii?Q?uBaMbh0rVXmKFC+F8JdmYx1xrbpBh+jn3f/5hOEZJNiJj5OdMCcgWjCs0Y39?=
 =?us-ascii?Q?PqfQa9o1mK8f4srZ2B1kcyMODa2iaiX432WAqsOoagIkreT3bNb0BJg6inDZ?=
 =?us-ascii?Q?nOVWYKKJakjZixI4gOUb/OedQTAT++yZwbI6lXMuWT3GCPZPheMz5fFleX7w?=
 =?us-ascii?Q?BYmPi+cUV9GAmHhw7N0NqLsOImFaLNXb/Jf+xF1VYLekXv1uO5NQGbgmSS9B?=
 =?us-ascii?Q?mGyIq4l3oUuMhdTc2HGMee9SaKsBvR5ENyE4h6LdDnhnOitgLqFYUgfstwzg?=
 =?us-ascii?Q?U4kAyuIgOi/SBfdgJDBkHd+diSvVylI9iwk/Wh9cA38FFDh7G1XME+TzD8r8?=
 =?us-ascii?Q?i4TXMpH+qDQxvpIf0AL56SPYoFynsizNeeQLFOlaFYVzUM1q+C5hHjRKYeK7?=
 =?us-ascii?Q?4adMWLM9aZHRSSSEWE1g96poN0DWRtmte8cJ4Ayx/EWIsxU1mTqiMYXA8M+6?=
 =?us-ascii?Q?EURBkSYSZIDC3yojGyILadifXKyhE6Zb+CeBvezpP3o2RvqAoNCucbUXEGVm?=
 =?us-ascii?Q?RFJDxDVfVpvHD+in9gbSMeb/+floKB5FX8xp72fSEEBY8LyiqQ2OXR6VdR8K?=
 =?us-ascii?Q?+4vRjqwCpwQeTZkOWsKdnc8YJUJSGdHSqJtEJ8UUXSQcoKguNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YeE0QJ+//2WfQ0bDvMUD0sQpfZy0sASwjdErQTfBuOb6o4U4YWvqnGYRBB4I?=
 =?us-ascii?Q?Dq0+XWwcgQtJRw9/aJct7Vz9K4zb1Wme0zbUgxhrPF4acrZUnmlto7agM6w9?=
 =?us-ascii?Q?Gf46qHxe55Nf2alua6d9XeqYTvKLA/pAv1T47B9KzV5Ffmx+D8PRprQtdgpG?=
 =?us-ascii?Q?8toEmVc1Rv+vu9/MV8uEKM6wyo3TJ+MycVZnTZ8kQpGW2keixjNgeFeXduWo?=
 =?us-ascii?Q?LkDR86uhulH1Br39fQVjMRrJxs8T0se7eZY+tTX6+v3RrbvWEdHlaFm5ikrv?=
 =?us-ascii?Q?0L/mNYEyqO0iecjnI70QueaOJheoueqOBx4BKJPBvh7DcHTLue3nV0r+zcQT?=
 =?us-ascii?Q?n7P6kpokkcvkTlZU9AdM1ivcl+NcbYGCGdWvJ5pr6nxtyra5nHu9Hjct0kEd?=
 =?us-ascii?Q?haO/0JYYVm1nUbtiCgGl2HjjUp6b7TM2erjwMpisI4RHCumTxpQG8GaIoJYL?=
 =?us-ascii?Q?IeJwLL2Rfl0gJls/7Gftn0G+onk2WF7IurlePx1EygloeKpdIL7q4DyuOWZk?=
 =?us-ascii?Q?7q/RmdazmOHIV+SJVn7CKVzCo0m4i79L4zBFDQOtRgOnNhJAAlvG26DvT7Bn?=
 =?us-ascii?Q?OzVhJ/6TBga5XHUXQyr522M0wcWZqRK48D39XepGCDdoPr5hduedwhDVQVFA?=
 =?us-ascii?Q?SqjOuImmBGS3t8WkdHVNadXnJIKfMkoMq9ry812+kIHs5kD8cHAYoWosQX5B?=
 =?us-ascii?Q?hobPLSGB7LA2Ylt6qENEpWnIE2Fz6YRzQxiT0JOyqxcbZzf/hYgQdxOUxzj2?=
 =?us-ascii?Q?v0Cu6j730zl9ySAEzC1Zw5zJFNXyyVxhVeOBPDY77igj3NQOidlai62HzicK?=
 =?us-ascii?Q?2XP4ZR7+U0M0qCBhKTdhm7M8Ttr+vqE5ybfS0DqAiCvR2t3gMyXxM8jBjfg8?=
 =?us-ascii?Q?a/OumplOFoEAlOUS3XYSOUUfsYMcuPMG8FxPQyroCfaauRCxWa/fUbwK3B3L?=
 =?us-ascii?Q?vPuZWIKCFZ/QjvtjG4GzAkCd4VE+Yvc3l1Rx1Xf/scSG1/YGLXvWEPiGkwrm?=
 =?us-ascii?Q?m7fCg+zJm+gaXztcAbBtRx+P4UZrn2mJPKdbxe5uopUMkuIqmwaQSavw5mcS?=
 =?us-ascii?Q?gPv1577bwYz5LP90LrRgPrKvJA9mf+pMObsuZdETiV7imSW3EYVCHUrDPflM?=
 =?us-ascii?Q?onpdyomc/1IBPpq9/+8t85dkQJ0s093Ph49LPpzO5w2XSW1Th4t6TTMdwYFJ?=
 =?us-ascii?Q?IubvSW56qSM2ItZ1nsNYiuMuvr80+cjCOb80+Eyrqdz58bp4ljp8erur/jnl?=
 =?us-ascii?Q?ink2Vu+yF5utgzxrs1lgWxRXXGYnqahf037plA9oLY8pUhkjvjCmxNoQJxn4?=
 =?us-ascii?Q?QgMiGYgEIW4PP9IG/dJGOxoRBkCmBcOQUbGrIXKBvhfgFsVS+PIS+BcXXN+S?=
 =?us-ascii?Q?gXBkEdXTwk3rBvqxGaaclquVREWLpfct2cnMs34wP2Uj1nH03UF1vNxspSQM?=
 =?us-ascii?Q?wyzzqbQteo16h+tUlp2nk3RVeM3Ebl8ulTE1i6SouV2/wOcz02s691IqiBej?=
 =?us-ascii?Q?ao0Yd49kq/fu/mMxLhT/LMB3d67fd3gMIdJxjIGD7rcA4MRHlcgLDSfR9KEN?=
 =?us-ascii?Q?Bk/BpQGJBu4K8zELVyJ6LK9USWBiNMK0Mu7mWKIakbUFsLCjnb44Uk/jvibe?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f564eb92-c2c9-4b07-1b45-08dc9d3144df
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:11.4672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP29jz3MfFIWWCF9zic2AQvTl3+YSskDrYvxPygalqepZHynt1bF5y3m3cpVa6lts67hHrWxc8MhCvkZqymMGP0KvluN3kSgLgffNSYYqH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6860
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

[equivalent to linux commit 81d362732bac]

As a follow up to the series allowing DTB overlays to built from .dtso
files. Now that all overlays have been renamed, remove the ability to
build from overlays from .dts files to prevent any files with the old
name from accidental being added.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 scripts/Makefile.lib | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 549c3619472..d6fbf9a7659 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -416,9 +416,6 @@ cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtco)
-
 $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtco)
 
-- 
2.45.2

