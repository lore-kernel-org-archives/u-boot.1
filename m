Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E7ACA6013
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49FFA6088B;
	Thu,  8 Oct 2026 22:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3SWzZIro6aZ; Thu,  8 Oct 2026 22:45:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0CD660893
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499522;
	b=IH+Cej6Sa98sokXi7EOP1BUuX86DBGyMxa0bVUTlXYKLmhP81KjCA3F1bh5Jgo8D2Z/t
	 FDnIb4w+ZGkemGlrYhjo2HlpHAJK5v+dv9PYyHcbPC/2UHpchd/qLmQWys1nenVgUjm9L
	 2Uw/4F2XEmCT8qxCNThOy7/XUn/3OvC4VSJI8PA3NXjv3lFJg6+tJNZetu523tK6PhHhK
	 pB8zxdYuY7UOV7BAN+7B552a58lP8Kgnygy9JqCK9+7QtLs1NHGkg6ndG0iMg9EhP+Kqq
	 KPqVAWgMEZ8L//SccEXH2mqumus0z1J7rgsHfan7p7mwxY2YoNIq7iLyk51TyBD//mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	b=oaUBP2lLRPh9FSiP1YVe1FfKOzGdkiKPptWwFIaN9tfvcp+U2E5QP/AqL4saCI00aiEB
	 uiS9ObBf8smmLx+wgzgR2xy0rFqliib80FApOtJPRgpdJc2XL0Mn2F+FVOW5vApES2a17
	 2YRAbsaLP/bQ9KmOg7eiEGJmwvCR3Fx8N1XF/PYqSGd9hg1wqa9KJWgeB0uwwXEuagM0u
	 zFP4RVENWp4AumchQLO5eKlSlWo0WJTDXJdUbt2s/KCTqMJIVR7WYZJ5+qzdwaxIOV5bl
	 1s5BCszcrpOipImQARvV1f5KXfjcqRCztQgqkmwhfsOA1QrbIseDBiTr8XCOfmou69w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499522;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jYv9vwkSwxEZel+tVqV4yGIV/dtfjTymUmxHkIdF9SqCrfGAsJKTTPNli7/9VimQp
	 4LRyB7WDf47BcNwWHSCQyx+APDPUD4gaihkeHwAAIynxCvc+J9J76V8qdmi8s9Esrw
	 nt9MKZX+l0x+b20hEwdPYlrsN8EuHAUZMbuC0QfmU0wAcIXKR5dP1fIDFG88+3vIZM
	 vT1qaFJVpZoj3UIYIntZuUHqjjudAlJOWE+7Xc0f/Sg16jC+5rLTIm/NAnnKeeTl68
	 Hez/QFsMV5Nr9kUaddcjIHj+U7FEK8hmsTAlmZR/Lv3nBuPVQ3s9SJ5D1WynpJMlCV
	 YJEusThAWyaOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0CD660893;
	Thu,  8 Oct 2026 22:45:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D967228
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13A2740938
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eHPQnK3EgziG for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:45:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F5C640933
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499520;
 b=dMvoMOFQiBwb+SgCXaMd83/LDvO/QgwFoeiBy5qrv+j0GFzVRqDifOXjgAXmwISqDSm3
 LZfTuat4TvwClrdnyeMMyuMgE5l6hs/NICzou69Ntw9RGAVBwXdXy94H5eDfg5GIb2XLv
 v418YIQyM5D9odFRSZyN869TqTRwsLjQFQbVrIkw2NAP++KPvUyDdJnrcpfDvyCCHc6o7
 RDopvpAEzVIwg2IhCKWvwPQ1SafDDjmXdMOumh51EvfzGjzqBtJXAewNKtClxCybRAz4+
 8E06jPk25JfsZqrfNwSvyl0Ofpogr/Y0/RhRM0r4JANimvWv1+xCjFlsoRTY9tabjoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499520;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
 b=N85JFHA/3uldlqslkVUEF/hJ9olRr4RiSn4vwZUXqW6dod6NtyT23gG3f7e3Hl4fiIq7
 MoBATTCHFvwM3Zwy6yk2VFwCy2Fj5UTMzRpA/4xhzF1h41uExxIWpSETBkhqWAoChA/yh
 f4VQg6APvki+/qEhqAeot2iB+plOGf6J3yIeKKWSKjSfOwgmf2D8xPEoRJz4UwlS9rNcT
 clJ1wdfxwknFHkNIUCjOlmtPhCMdsMcxjN0XmqTwUXOVuZD1ZQBY2a1TSPdwpXKYLhNrT
 /Lxg2gIFZEO/6e0iuouxFlcWXmwpk8yy4/ots/b2q0HKrUmurnK9bpssTzj/GkuSgAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=AcOYNgut; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=AcOYNgut
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F5C640933
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1F354B00539;
 Fri,  9 Oct 2026 00:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499518;
 bh=Opxz+RFZAppJK6lJ37UQV0A1K/QZGcL/ZB3CSwhC0Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AcOYNgutuR+pjWEIDKayRwvHzjQ2pBRb+hYHDu6fnSSJ8BBEmW72SpNk15nn+J02/
 /KofDdfNMsSjOmT/Zg7e4rn+BNp0G6KviQBVNXlc7MAjpF2dPFqf3MQxx3oBdoDgSg
 GXQQLq/KZJTkkQ0Vkb+pSMCT69vp1H+36YpzTrUnuXjAwMsXmlefOkNgxW/ZaGAi7x
 PdGSUHyO7exaO/5UilP1UMpJRu2fodYYL0b+vdMYBpbN+evNQbu9vtRhSH3Yy6YAYq
 RJsM+VSOiXbn1+ZAq7nRbdQY+q5QhbtSRirf+EVlJAi4E8xFqKmuYRcpz4WhYNRGhS
 1y6+WMsUaOuig==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 07/13] board: lx2160a: serdes: no SD1 config once MC runs
Date: Fri,  9 Oct 2026 00:42:20 +0200
Message-ID: <20261008224228.512353-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
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

