Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48568C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 05:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06B9340641;
	Tue, 22 Sep 2026 05:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TX8JxmPe7CtZ; Tue, 22 Sep 2026 05:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F78640655
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790054852;
	b=IIUDp9ZRtm8G444ttq7qU/OXfwuqvWBKzzSVMaAOZW4Iyp+zHMw12MfMHbACrQvGAB2E
	 v2kbfdSPth4HblJxMOaG1hiDnnIW+bIK584gWny5C/H2TR1KwKs9E3fDu9sWQQeiXFlzk
	 C+LLYhvsCzeJ+kcE1Til6VL+D9zFYmssvpnYyPNz71nw+mz9oKyl7YzfBtwLBjIQKd//H
	 ftt9vFGBwiLm0uD8vsBIBlAsf4X5YKKy5ggtt/SXpL52ZaOXZBWBavJ9XQpUbSABocRQc
	 wzPhtcCfYN9X1DrTkZnsNLNcCN/7rJ9Cee65vD5lKlRnPrjAT5weJmdMPv6osgSk2KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790054852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BFZ9XdLZT1zCrCiH7w8zytggcOinR1TJYdAKUhaVX+0=;
	b=Poii6Ni3FdPQ0hmHgE06HgyagbV/ln807rvQtQiX5qiBjYWuduEVyOVpYeSLsCJ9O0VD
	 G7G1IkaMC16BMhRHSuRBphcvJ5moEKLA/uLO3Cnym5LIlXO6SNm7eUwJXF5w21Knl+afY
	 58Hu/XE/KmJVe4b377KGKdccelkHoC0bNydgHgoLFFERaDkXu/yEJbkhKQnjIVecqjOwJ
	 ZA5lFq3CHgpeTAbjoJU3g3l2GaVpHb3fejdTNs2UO9vudUyAdz7WMx+uzpjY57v+QALNb
	 jgmHmmusxNt66qStpwLhgIW/TmCQvNRuFPSLaHt6IGn6S4FCSmAU4BfzZcSzYWwgARg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790054852;
	bh=BFZ9XdLZT1zCrCiH7w8zytggcOinR1TJYdAKUhaVX+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8FjbtLZVfx9Tjdn/tOE8uXliKo05LSPrSsHISz4B4GU4n+vMPWLe6hnrOKISccxz
	 SmDUb3lrZI6VaEpksGovNhsCjaysYas/GX6v3ygBwI4R2FDUrzWjjouIPIMa8SCqNc
	 vumrsNJNSw9EKjt5fO859/KraCLxt9Rw62Fio/TC9yjfEOCZeG9SeaavaeHK/mo5qO
	 Zabwv1qF7b4HT0M3MR6kgdRUb407dJxVQ/T5AxpBcBbV3VNtzDghL+v5PMdMgbq0fx
	 g381u38QKiRlI0woUj1e9AWl5YEET/g1uBLkczIegSNXfgcGYqZtYsXYtV73c98yrY
	 aMynguI7VlqyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F78640655;
	Tue, 22 Sep 2026 05:27:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEFEB13B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D534C80D4B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HtdCJRfIHOTD for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 05:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5BD3D80C7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790054848;
 b=Em3SSSykgUTWZzf2IebMjHxL3o3CfuAmU69YZ5uHx94DkW6Ho1bJrRNsa4PIB0PSwo//
 w/UWKzDNh0K0O/8e3k0ZlOp0/adaB+lCdm31LKKpkv45JRYuv8teh8RlPg+Ys5EJmEw+M
 hBZg2JallOlp9qJXY/RZJWWYPWUhX9UC843w67vttGGui47STQf4Ria1ABk0ipZlruCR2
 EY3ASkeNQ/er20SZcaI/iUFRBP6E8Y2Tk76sdcLO6bFq8wbA48snjEOhEVdIMeFR40DXy
 kXeU4WhifGMohw0h3/VNrG+jmJ2erFB65yFlgezxATkPk4YFQaf7422bQog+yVZZpYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790054848;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=BFZ9XdLZT1zCrCiH7w8zytggcOinR1TJYdAKUhaVX+0=;
 b=pB9S90fPKWaz8rYnMstcmYt1uB1zTZVYFi76v7uHwZ3tOKjOvq4KWRHA0mbFgKJEckoZ
 O9l1uNYcwKHbtqrNhqeChiWBvbVIQcvGmvOpmyijPiuA/sht44frlsB+UAjjcWJHOs8ai
 n4jnmCRuj1CKUk94PNLszl99TeluMhnNTILqXBMMujzoavQr/XtNJWAhMpntFkQhGamJS
 jPnxrQNR74JZE5g0bI7KSPsgcNdmo9X5MnUdQN4UxPsXmzACatr69ONWEsmH6V8TLLS6W
 IyxhtSk2pMQxIglwXJzanVVD3ho8g4vBSQudQLmACasGM/SsjyF21nfVuJEXShR/9FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VtRaj0UT; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=VtRaj0UT
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BD3D80C7A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 23D79105678; Tue, 22 Sep 2026 07:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790054842; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=BFZ9XdLZT1zCrCiH7w8zytggcOinR1TJYdAKUhaVX+0=;
 b=VtRaj0UTWLwIRiTiVVL/bICmGfRCWFOM0toC2CxbE8sgoDWtVn+MtNjUHuZRe3SrvSCLGl
 Kqf3u++wOLAMb95+pubtiG5bqmEhv8WDxs+Fp+kuBm6Km5ExcdT2h+yW6cnU7JT21ILyjv
 ObeSckGZWgfJLrQ3Pr+SRjWs5ARyQCEVeq1VixRD3XyQ/KRrWB82jhgCGSn2CTO8yRzg/h
 /eDse1ulP7yboGg47hJMFBhAfSGJMznlUSNI3BOVshIgiAIXJ7eWRcbKa8v74Mf/uh+Bib
 rMMSJxPZcBncxi8kkYJfcPCE0Mcn0G2xg6b4zrGbNWny3Nj3SQp32a5I6RMJyA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] imx: hab: name the event left behind by the boot ROM
 RNG self test
Date: Tue, 22 Sep 2026 07:26:48 +0200
Message-ID: <20260922052700.528451-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922052700.528451-1-hs@nabladev.com>
References: <20260922052700.528451-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The boot ROM of a few i.MX6 revisions runs its RNG self test
incorrectly and logs an event for it on every boot. An event that reads
HAB_ENG_FAIL on the CAAM and nothing further sends the reader looking
for a fault in their own image, which is not where it is.

Print from where that event comes.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 arch/arm/mach-imx/hab.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index f92f77670a8..35c497619d6 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -421,6 +421,19 @@ static inline u32 get_idx(u8 *list, u8 tgt, u32 size)
 	return idx;
 }
 
+/*
+ * The boot ROM of a few i.MX6 revisions runs the RNG self test
+ * incorrectly and leaves this event behind on every boot. Say so, so
+ * that the reader does not go looking for a fault that is not there.
+ */
+static bool is_rng_self_test_event(struct record *rec)
+{
+	return rec->contents[0] == HAB_WARNING &&
+	       rec->contents[1] == HAB_ENG_FAIL &&
+	       rec->contents[2] == HAB_CTX_ENTRY &&
+	       rec->contents[3] == HAB_ENG_CAAM;
+}
+
 static void process_event_record(uint8_t *event_data, size_t bytes)
 {
 	struct record *rec = (struct record *)event_data;
@@ -433,6 +446,9 @@ static void process_event_record(uint8_t *event_data, size_t bytes)
 	       ARRAY_SIZE(hab_contexts))]);
 	printf("%s", eng_str[get_idx(hab_engines, rec->contents[3],
 	       ARRAY_SIZE(hab_engines))]);
+
+	if (is_rng_self_test_event(rec))
+		puts("\nknown to come from the RNG self test of the boot ROM, harmless\n");
 }
 
 static void display_event(uint8_t *event_data, size_t bytes)
-- 
2.55.0

