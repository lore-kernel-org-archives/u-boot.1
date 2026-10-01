Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E42CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2878181230;
	Thu,  1 Oct 2026 20:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YGuUP_v6Xkm; Thu,  1 Oct 2026 20:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A6EAC81202
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887824;
	b=fL5o4tRD66hHkzR6zfLetkM1uWnevUkb/7cWa9WteCxEnrQsJCw2GLHqK5CZl9WwoVDR
	 EHdnCsoAns/3/kKuec9dvbfcVzpjRgZQgAUwPrjKB531uXg04UmEWpNvwkGVGPBi4KTid
	 L4x3cgVL9bKGT/WaK04pZReHJlOMnVKMb/W9SLsBzyRZNfvEW04TASm1K6Ve300OFfEn2
	 1nvmpmB+HrTcbI+TUH5AdiSecFSnbuu2beM/97K1gUqP1kRt1vrgeCwpMSjzp2ovbZBCl
	 yiNNiys3S//EzlidvsSjQ/+kieNqeQxQ4Qa3LAbPhOcHVIWtysklmAQtaLsCtMg3GqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887824;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	b=nUA5Z9TmqtMNAehK2l0bltFpt5Ht4l2ogYgyVN66mtxuIX1wnqgWykzVpu2bYviDu3lW
	 sYbMf5cRcn3Lbfa4KGGH5pJx7F8okZAKk6zTAfjWbFeKlWdWAqbP4JwaNuGAiph7wtiB4
	 Tj3PjQHx9o++j7HUfMu+rRwVc57eMlWd++tI21hWqcCVjXYMcfjRe0aiFfoDA4B0P5Veq
	 ovvz+JrF1MaqDskvgLuweF2SXlC0+dLynn91/59pwOCvZ5aJ6eXz1Apa/cN/scCxhbdVN
	 rjxRr88d4MmEyasgyDEX+SXd1nt/KrZCTfZJAV4ZUpMPUhgniAK1aOiBOtn1nDo2Dyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887824;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kpjy+us958Xyt1uhijMJ3y5vsuQwi0dhJqb6dJhgCQP1TTzaqsXQO7USGqlUrkQTV
	 lTG9PbBb5GBSfWZEMTDRioU7qNNWQmltFJHnalnPO5w3pGQufPYnTsNKYgYNEezwS5
	 xmK2SKUgyvi7HGC7S8tnlweMbiUpeoCNAdowg8nA7HWMMr6daiBCsXBd9ms07XEaGj
	 7xZdo0h3uB2E00GvQBelOP9VYihbN3gZBsGUNmZ9bVJfNBF4SE2PcIkpOEFh3VuCts
	 uDmE3q83uSmkAPcXcG5UB/0xFegRNg1Gs4QSwt+Aahqr/7/PPpQkEnkmqC768RR0by
	 WUzD/6Q0u4pAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6EAC81202;
	Thu,  1 Oct 2026 20:50:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB53A1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C105F607E7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWjVUp8fLyCX for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:50:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1FA7C607E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887822;
 b=q/Z+1jufM0rNTYMfCDKu5YaceP1Ut9AI9ZeDVKwSCWtf6CIImyzCPts4JFsq4hiIvg9d
 cJyQH0M6OE5I+sOUCHuoqal7r5LKRwMn8YGu6SULzCMR4l/TZyStE0LFeMU0/EutANGLB
 tm9sI+HPzkJwzTPLIv7vbIMJcUjjUYuMttPdyJ0P0TPFmtaTx0k4KeUBHNnZuWOgpk7Ql
 nUrmrKjr4Jg/LtaP+nZEzsaw6rNMc1la1o+TxipSRSJN2YZuWvnMYkZi0IUN57RuHO3aq
 6PkA5wUR7zc4myH5YR/ltgET4BcTVvO9thYkMR6aHd1VF71xfqaye8Hk3roc3NiP6pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887822;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
 b=rDcelwETnkz+GrEr8kHOv3FConfBMvagFcJULyziqwO+d3oWxdO70dx41K3B3eiQYKOz
 sqIGk/KGRJjYPE0Q1twTAKGV7DCEjKjcIxbWNMQPLXPetjcPTuaA5JzVZNdQPrkfKOqRj
 bguwflKU7cg3QvGv9t9VWwHN6lG/HeH2pwqLNpxqinbM4v9kcud7fyA0TNjcTUe0uGGyy
 Kx2zQLeRU4fXYM2JRiecLqIftDFXaFmAjP+nGnGL+Y4er+fz+7duH0Ue6J3m8HxDWTeMG
 dO/PpmKBMmzH0o9CKM4F25Ovki2LirVISP+B0OGauGOuBExGf6u09cstkV+84vLuK+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=uj2Nz0oE; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=uj2Nz0oE
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FA7C607E3
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C4A74B0055A;
 Thu,  1 Oct 2026 22:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887820;
 bh=Opxz+RFZAppJK6lJ37UQV0A1K/QZGcL/ZB3CSwhC0Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uj2Nz0oEVeXa6qa4goq1K0FykzFLZA/GTR6/k0qiMiwtAIabOMD5UOuVIQjLnqCw2
 mYpxRuDZv7DSpLpxskVJOpPhE730cBK9/y7YSC2XBjZkrmPvs267gaONJPkAY+DE6m
 lY+l3UJI6QM24TFIqOfBEeD54XE0Mo0mO7A/0JGjaC/DFTfMCnOZQhOANz5QsQXtKz
 3zGVCWjEozvgj1/QouP5wbT3a1tO+KKRfGcOvivCJDZQlQPEHWrMVU/scl2+pSlDbz
 O0b4mfOA04d0PMaJDLEDp4h484amVI1O5xlAJvVBgzOvQy0eP618FlCO82kLRCELKs
 sgj0bSKWeXy0g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 07/13] board: lx2160a: serdes: no SD1 config once MC runs
Date: Thu,  1 Oct 2026 22:47:24 +0200
Message-ID: <20261001204731.1774613-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The MC reads the SD1 lane grouping once, when it boots.
lx2160a_serdes_apply_hwconfig() has to run before.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v4)

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 57504a2327c..ba3be4bc0d7 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -12,6 +12,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
+#include <fsl-mc/fsl_mc.h>
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -524,6 +525,12 @@ void lx2160a_serdes_apply_hwconfig(void)
 	if (mode->is_active(srds_base(FSL_SRDS_1)))
 		return;
 
+	if (IS_ENABLED(CONFIG_FSL_MC_ENET) && get_mc_boot_status() != -1) {
+		printf("lx2160a serdes: the MC is already running, serdes1:%s not applied\n",
+		       mode->name);
+		return;
+	}
+
 	sd1_enter(mode);
 }
 
-- 
2.43.0

