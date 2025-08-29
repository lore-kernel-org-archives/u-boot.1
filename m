Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3CBCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA6B8368F;
	Fri, 29 Aug 2025 16:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEy0q8AN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868DB83447; Fri, 29 Aug 2025 04:11:59 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500FF83443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4d223d7ddaso78242a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756433515; x=1757038315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlDaYfcigW0oUnP/qlONui4siEgUcjmU/x/WFO/LwVs=;
 b=mEy0q8ANVAegx/ROB6X36qGrZiJ5rBHazsLq7pAryNxkXMddMlwpZLjY8h6+A++Zsf
 SgwuWhMnSJmZUNmR0IuMA0M+WT1nCx/guxKoX7dxy9qAq3isEDDHui9/xMidKfGaxpAa
 5+8490GyBLT89fxyqSrFV3/U3BLknO2FdYjsHk2lvDJmt5huIGUFfgy6h68cA6jDAWqk
 hGdh5jV/DdI8JGw0WGdAUGhTIPI04gjz42FrbE5LfJP17L1d4KOJ+yZ4A1TdEetFUNP1
 3lmmo2ZkR9/m6B2PvtHUJqAfmsLXXwD1bNLFsWLl18VPEjrw1iayL6/ts7OHxAkBRtNZ
 2whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756433515; x=1757038315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlDaYfcigW0oUnP/qlONui4siEgUcjmU/x/WFO/LwVs=;
 b=s2G92f6Ay22hmEsQd37Zaoz6iJRHJT8ynUISWGTGOpM0vdm5oYz7LPlQzARrVNTd5k
 GqTtVS6SZkLFvWkHwgBeb9roXkhi4ik+yOmO5pNerkcW00mqOrHFIHBi5Cli6mt4CBPt
 uRaIJ3VLzEUj9cnFsJeRbCo2D+/gcdhT92EKenWjzfwEvGDXtSh6pxzZ+1s2jot6gOEd
 SzP7wR3T4Sg/amMPzWdbFKNE+vIJx+ZHu2s2EntX5dgthhmtthMrrYeiElJc/zk+JaUS
 jflssDUChGYJTyx97QI/IYb3th7DBzVYUinSILO6RjnnTfsPOhb5r+heH0JKu3YORxE2
 7C+g==
X-Gm-Message-State: AOJu0YyVttsSCIbgDoZQtpszkDx8CLIfZbf+naMTfqayLCHWI0NT75Sz
 Gv0O2ByckDuShl1WfaxiX03qsUCbREuphtTGZjlMj5lqYebaO7TOOo9GbAusi1PX
X-Gm-Gg: ASbGncs+hthBBYKjo7zYr78QKR9JX5cqX9m7XmSm3NNC18kDYrwB7Cx+0Qc9FbESQT0
 GptzhgUXV3zlA//O0GSE4cRp288vsa2KHh3F3mvcec0bb9TcXdwbcWNRe0VMJDA9AOG1TffQwTR
 ZXzjaYnMbZMTKUnmbSIzoowqM4KXqaT7/AJeTHhe5YMnlIGAxAoaBB2cqH7mTOKwDT9zQHtgru1
 ppzA1wVVgk0Wm9IUWDWtfNvP8hbYVDBxC1YzACGCmsdzVKL7TsD/de2xwpktgArT6ETBApo+kks
 aRexjsNHozTa2JxYTjAPkeafW+rN2OOQnCDnbs7mWiKIAYTy4q2dSElOAm5ToyfgNy0nHYyJpGI
 1ZeuTrmXXUemEZIZkDyMRKEQPIPSiPnfcnTl+QGV0MxNTMbzkTULEZY2Cz9vMUMGUSzT/PsM7+c
 dvWsqYh8t3hw==
X-Google-Smtp-Source: AGHT+IECEaWSzN7ZlvYZVo6SofYo6nNQ5qxKKKFLgqxedAPCBWUiwPh8/607Xk3hUfW1p0p/kMpCDA==
X-Received: by 2002:a17:903:98b:b0:246:de32:10d2 with SMTP id
 d9443c01a7336-246de32149dmr242012145ad.15.1756433515362; 
 Thu, 28 Aug 2025 19:11:55 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490cbc9cb9sm4694055ad.15.2025.08.28.19.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 19:11:55 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] mmc: core: drop space before newline in trace printf
Date: Fri, 29 Aug 2025 07:41:31 +0530
Message-ID: <20250829021131.28451-4-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
References: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Remove unnecessary whitespace before '\n' in trace printf
format strings (checkpatch warning QUOTED_WHITESPACE_BEFORE_NEWLINE).

No functional change intended.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/mmc/mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 5f2efbe6df9..20afcffde3d 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -125,21 +125,21 @@ void mmmc_trace_after_send(struct mmc *mmc, struct mmc_cmd *cmd, int ret)
 			printf("\t\tMMC_RSP_NONE\n");
 			break;
 		case MMC_RSP_R1:
-			printf("\t\tMMC_RSP_R1,5,6,7 \t 0x%08x \n",
+			printf("\t\tMMC_RSP_R1,5,6,7 \t 0x%08x\n",
 				cmd->response[0]);
 			break;
 		case MMC_RSP_R1b:
-			printf("\t\tMMC_RSP_R1b\t\t 0x%08x \n",
+			printf("\t\tMMC_RSP_R1b\t\t 0x%08x\n",
 				cmd->response[0]);
 			break;
 		case MMC_RSP_R2:
-			printf("\t\tMMC_RSP_R2\t\t 0x%08x \n",
+			printf("\t\tMMC_RSP_R2\t\t 0x%08x\n",
 				cmd->response[0]);
-			printf("\t\t          \t\t 0x%08x \n",
+			printf("\t\t          \t\t 0x%08x\n",
 				cmd->response[1]);
-			printf("\t\t          \t\t 0x%08x \n",
+			printf("\t\t          \t\t 0x%08x\n",
 				cmd->response[2]);
-			printf("\t\t          \t\t 0x%08x \n",
+			printf("\t\t          \t\t 0x%08x\n",
 				cmd->response[3]);
 			printf("\n");
 			printf("\t\t\t\t\tDUMPING DATA\n");
@@ -154,7 +154,7 @@ void mmmc_trace_after_send(struct mmc *mmc, struct mmc_cmd *cmd, int ret)
 			}
 			break;
 		case MMC_RSP_R3:
-			printf("\t\tMMC_RSP_R3,4\t\t 0x%08x \n",
+			printf("\t\tMMC_RSP_R3,4\t\t 0x%08x\n",
 				cmd->response[0]);
 			break;
 		default:
-- 
2.43.0

