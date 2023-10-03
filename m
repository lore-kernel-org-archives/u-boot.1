Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CAAE7543D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 10:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC7186C68;
	Tue,  3 Oct 2023 12:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JIuBXOSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D495386C9A; Tue,  3 Oct 2023 12:02:46 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F047A86590
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 12:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE+/xrFj+7Is15YGOpXIYjlF5n1mE5irywifZM/09RvhrFzorVxei3SpNcm4xa/S5hCosK+1Vg5h3TPfHiAFAbRPmNxkV1aGuUzu/hT7g0axbA80aKzb0KZxcljyLh3zCV4qik2ClwN1nIoOfsMNueW2NjKqVPN0w+zwfN04ufqpDU0fxAOKo0KLirXbKsZlYRvo/6bou02yT5SOoP5imTZQ6qSoJ7B2EX0b2SQ1Pogo1dSpM0WTW5yh6ng7VGf4lKU8CVMKOa7suo1uXUDKJGkfPz9xPMIFEgBqZAMoIVz3Y+G1lhXUzXFw6DTPvoEwAmBODlyG6jBtDxDBMz2NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/vzxknDKMvRwd6RiR+E4QMNb+1RnRccfrFXp+rpq4I=;
 b=jlhRvWLErTyexsoik7kqb4P15XMV8fTTiudnJeAlo5yE3xFrys8b3Xh4KunjYWFVEG6dIf8wvxfHY3SuUpM2SjDWaGk2vdF/CPtQq3AyMSCz+N2j4z6MTMDcQLZGbwXhk4322Ik8DrJeY81KlJj16QgCs9mAMY9S4tObo+wdmJhpxIwelJ5YK7Bn4zeLWIC2TX8OtgQM1OMQknH6AoOheLJCd7Oexh2a+qSyrkWiKOtKAktxTnkD1a67uVXAFrKkx6qd6xEqSAx1jqDgMyGIGdWD6lWij7s76E2cfU6XHkTPTbq61WFDtRvTNBiGB8E0/GMLJuKBnHQ61v68DrQ+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/vzxknDKMvRwd6RiR+E4QMNb+1RnRccfrFXp+rpq4I=;
 b=JIuBXOSPrqCO1kPh0+n/Bi79ZX2jQAfHVuejTEGRicpDysFreRXIJnNfpBg5O6FJJVvV8UHNGdS/I5lIePF3U1Mf0fIfrG77KmFfyZ5FsvgB/qxprN4ubYggBmAgM8V+grj5zMB09rRlAjSWS1e2NUF+AyUK+zrNuj70x45y2QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7351.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 10:02:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 10:02:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tom Rini <trini@konsulko.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] Makefile: make u-boot-initial-env target depend explicitly on
 scripts_basic
Date: Tue,  3 Oct 2023 12:02:17 +0200
Message-Id: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:208:69::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: d01b12d6-4da5-4386-9d74-08dbc3f7e1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8kEuAwbFojuVdurKalo/ZicCrANvELKxzXdGStZxWjCPVeHn+spSNw30j73amCxzXAeMHkvMFBqsnmfC7PvlHJARsGumWqTqDqMFxaWXrNMR26M1rOSWLO2Hl8oNnJ4UVHDpO1lqKnwsQoqaEgFORKC8a5KyRXPaTKdHFmKEhhbaKBprSD2rhBOlvNLMGqG8TGmL009U//k70gq53V+XoONtWro0WQ3gyaQnXhtnZ/CPPL54/MnFva6lj9+gFEsCwyY/JlHUvgTTD3nC7cLBmjJK76tYHfiyiQ4DaXk3IMFHTYIpH1tSHRb2KieoDuMYS6blD3QrC1TXZdgKJDr9p+Vh2FdeCeNSyUWEe4fqatcuAJ3LcQcs3uo5bsJWwZoMSxqKCX26BBmVM+cB6b0lpSdhGcMDcDOYsq8PvZnu4o6lPOHPg7cFidBi1Ca7lFxbsyjAiERad2egKb9sBhzG/USu2y64YkZ5navPwdF3UjHv3IkTCWLv3gibSZDVd0Q4psAQHzRky/aZbgfMdy/fA40tpB7tcB14lQGqG3wqOlgzCLfkZhwEmyEq8H9mENygKFdVs3lQDeP9sarHjRs+Njs7Vs78szLMz8QuO4YX59G50DCEgZXXMXyaX6803Tf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8976002)(8936002)(41300700001)(66946007)(54906003)(6916009)(1076003)(316002)(6666004)(2906002)(52116002)(6486002)(478600001)(44832011)(6506007)(2616005)(26005)(5660300002)(6512007)(66476007)(83380400001)(107886003)(66556008)(4326008)(8676002)(38100700002)(38350700002)(36756003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cvunVR33bzRW6BH7wyf1vRUOBfVyUYNFLWDXuWjse/ktqbGB2pghOsn/DgR?=
 =?us-ascii?Q?yQMPvy6Gb9hixlNcpGvjoOaLw+/PnQHqHkpUp290qiP6fa3GUNRz84wrXqg4?=
 =?us-ascii?Q?9n/F2q4V2rE1CnDzhORnQNIzbB0MddSouHgIxdZ3lwXNYEAijw67JyiTqMRH?=
 =?us-ascii?Q?dHcwYsy6tAlH3JkOLft8Yo/ET/T846maCOFqz5fkuLZ/Cyq3mDEKROt8MclQ?=
 =?us-ascii?Q?c22WGG3H5hu2WC7QhTSXCMEk3W8SwHs7PKuoHyDdjxrW0TSLqFxecwybhAbn?=
 =?us-ascii?Q?Bp2/RngrZI14YQN69qYl4+JGOLMS0fASjDdxKFZ0bG9iDHssX/FKy2mVONbj?=
 =?us-ascii?Q?UQBqCo6FhvAF8rgsZ7eTwxsRcmSdk3JbCfMJy4edef/sDfEaLf4cwUSLT8Am?=
 =?us-ascii?Q?LLbHB6P4+IDU1r8q5+B2AVDpABM18BRdRSmta3udXkQMO8cam/Y1yfPuB6+2?=
 =?us-ascii?Q?/Bk+YaaGHt6/7JBVahv0IZGhvER8g9lvucSHZxILEsKA2IikqL+GjdFrgkx+?=
 =?us-ascii?Q?5P+STB26InXLQpO05tCwqaXG4HHUGVdIhPyJWGXvdPU0HVr0tM29UBxglVKA?=
 =?us-ascii?Q?T/4xmLbuZJwMxb3f+SKD5ZbNvvrP8M+msg1fyD1v6IBBi2bKCedrMh3Xux0Y?=
 =?us-ascii?Q?SCWxT/UEvSbbU2Sr+goF8R84bul1CpYxX1f5u8eyJ0/f9IVzBbjXlZeywFjE?=
 =?us-ascii?Q?xzOMDVKUOBfwaLADRP/w7bJOW2cDKyOL0w5pYjpf9hK9cwYXYS7UsiRCkt6x?=
 =?us-ascii?Q?etq3yXTYrvc8kcX+3iHwXzmjRMFmH+SlqSehgVEjzGTYjrFzYKOa9JrLXgB2?=
 =?us-ascii?Q?leuzKP/ykeWhLyPpnT2O15k4qveBhgOQOxCp44yZ15+n4Uep/3hIzdgYvRlf?=
 =?us-ascii?Q?yXD9AKZVlc/0nRq3vqgDSmi+DA72FTAvKURuuqwHKl7t1gwaNGG/U8Z9Ublw?=
 =?us-ascii?Q?G5lz4VYOaUNTBQGy2UfgXEKDrIMwXWXfxZ5CQnnInyGELfyTb6asmgR7eRTZ?=
 =?us-ascii?Q?IeR2XV5qiDWPiU85PvAUJQjZGpkrIkr7VIq2wa0rrKI4XKONI7dOpYedehbq?=
 =?us-ascii?Q?bRlmwZ000ZoKko0z5beFF59wbxCz51QySkAJ9j2wIqA1YHyabaK46iskdkk1?=
 =?us-ascii?Q?tEoy6gAR/DleS9r+Cdf+2IjfmM8nGlvCSlEfW4KEX+Jw1p7W2rv1Xy64HdYe?=
 =?us-ascii?Q?O0Z2MKB0lmIR85O2bDoz49f2l5CmkJM6VVJWZj0Da3eHl4VfLx7lOCm8q0s5?=
 =?us-ascii?Q?7apMFfkq1DLSsa18ZjRwmpynwKKhIPWZtV31vPoMXp6MBEOzJzn+tVjFghhr?=
 =?us-ascii?Q?HxpgiZSTFAKv1Qk7rW5X3ho1mEmI8DrX9xTRb5WW8LO7sxaHgKEBAQfz+8N7?=
 =?us-ascii?Q?ZxZ5JaVoXcskkeApNiZfVsCYJzn33Vc5sNZ1dGFeWoDNn+XWr5D/nantutl8?=
 =?us-ascii?Q?PbPuRod4bM3G1b+iKR2Daeccr6xd0JYIDkMYagJkovJF8q5fhhXmeUAr+MmP?=
 =?us-ascii?Q?ghx3FHDJVGEfrLHon+Pn7CK8Z58I6FzQRW8IZY5iLM6jXAALfjq1/OPQj7Cz?=
 =?us-ascii?Q?RfnVxKnDQDXz9U011w3df0ngAeN18FV8GPq9IjEtGqGFWhCFunGtOs9OFbmX?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d01b12d6-4da5-4386-9d74-08dbc3f7e1f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:02:41.9875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKDh3QkmYtkjoXCHEdr4/VCt3Ow9CKXycrtUV/cKsqRC8llSrl3J6YPGPZ0O8eoWwTTNeeBZBECwGfC7Sc6Vf1j2h9lWQH2KrMc/eci5+D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7351
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

We're seeing sporadic errors like

  ENVC    include/generated/env.txt
  HOSTCC  scripts/basic/fixdep
  ENVP    include/generated/env.in
  ENVT    include/generated/environment.h
  HOSTCC  tools/printinitialenv
/bin/sh: 1: scripts/basic/fixdep: not found
make[1]: *** [scripts/Makefile.host:95: tools/printinitialenv] Error 127
make[1]: *** Deleting file 'tools/printinitialenv'
make: *** [Makefile:2446: u-boot-initial-env] Error 2
make: *** Waiting for unfinished jobs....

where sometimes the "fixdep: not found" is instead "fixdep: Permission
denied" and the Error 127 becomes 126.

This smells like a race condition, and indeed it is: Currently,
u-boot-initial-env is a prerequisite of the envtools target, which
also lists scripts_basic as a prerequisite:

envtools: u-boot-initial-env scripts_basic $(version_h) $(timestamp_h) tools/version.h
	$(Q)$(MAKE) $(build)=tools/env

However, the u-boot-initial-env rule involves building the
printinitialenv helper, which in turn is built using an if_changed_dep
rule. That means we must ensure scripts/basic/fixdep is built and
ready before trying to build printinitialenv, i.e. the
u-boot-initial-env rule itself must depend on the phony scripts_basic
target.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8af1fa9468..069c03696a 100644
--- a/Makefile
+++ b/Makefile
@@ -2447,7 +2447,7 @@ cmd_genenv = \
 	sed -e '/^\s*$$/d' | \
 	sort -t '=' -k 1,1 -s -o $@
 
-u-boot-initial-env: $(env_h) FORCE
+u-boot-initial-env: scripts_basic $(env_h) FORCE
 	$(Q)$(MAKE) $(build)=tools $(objtree)/tools/printinitialenv
 	$(call if_changed,genenv)
 
-- 
2.40.1.1.g1c60b9335d

