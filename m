Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE61CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE855407B9;
	Tue, 29 Sep 2026 19:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZhPUrLCFeTP; Tue, 29 Sep 2026 19:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D6CC407B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710494;
	b=qh6NocLaM5jO66AE+iGxtmbh3CI+/8dhlT5wAlBkzyk/Lm4fa2jI4Bph1r1kkYCna9Li
	 faxT1Uye96pNHzzjMltslneLIpKwMkpXjAb+T7MVSnDAbpVkubqiRRTZhyjaP+J9K/hLE
	 qsoMuZS7P2xNqeDoHoyyd6tyAlZwc43lwE/Rdcvfc8eEQ8INkVaueD7Ww87ZBJnWfQSo/
	 SR43C62fwBYbiq75uaozDU90T5rm46oPGMpGL14+oCCH2BkUO4Z8TVBzZ2CSpKbHiMenE
	 S/+tNWBMsHnIw3f7zdUoSk51tPMXSKVU4YkBHPmQibLr+VkthJ4O2JiQcnI6JF5PsrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aWwygf00VUdjbu47+IoMJ3Lgz2NJLIYYVtJ1w1HuWiY=;
	b=TRNIHxSD3d00lbTL0QI8AY1oQEeKJ1gVPiQvlU3Zi6OOWCEZHI/paQrln3N7E8+M++Rh
	 tUBdzSzdbmGQw6mO+3igA7+ITYfXpDMayLIl+jjU732MmK9PIZXb4fChoEJBkpXIYXctp
	 hFe13/uQh920AN+uxGOBio+8np17akfclAkZLDDkBQQWeOPE7R3LoKsR8ERv9CCJpbLjv
	 w48i8Dco2sl7YvDx0Wx0qe4sCHXxCz77yVAYzUB5DjrBhRKEv0SSAhKcNhQ1926oEevTT
	 yq7Cyf/JnN+soFUtEyXryTbi7LS1yfofv/339+l2o8PutGZIK/CwNpFUFVQ6yKjbHgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710494;
	bh=aWwygf00VUdjbu47+IoMJ3Lgz2NJLIYYVtJ1w1HuWiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UY7lxyhnRxijh0pN+1KdUj92NePbfagdjnViwg9bz+2l7nz6KoTEta1GB2/fBuyCK
	 d72at2NOKnRLFvEUCv9UDaSAB9NRXYOL8IGpYZVxt9J9lvVJaS9tuG+8rDSsmppQmX
	 C9Iv9VQzDQ8HGyJ3H+AYm0b/55XJNaQ232mgdsyloOwZ5siXxx6VPRrnTlvMocZjG2
	 nj6A3KFFgNOfqVnSHKVOayZH1Z+7eVvWlrzPHtJGFAlPdeKKYjPMbcXOZzMhp7kFH0
	 VMCg4qd4X3RgvzDaulvGE44768oXV4ZN4w+XgKn1iPUtth5DJMKAG+ARa5NMKgXpAX
	 1drivdRsek4ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D6CC407B2;
	Tue, 29 Sep 2026 19:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 690B932A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B2AA40333
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6UXoEUpsGRtQ for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0F6C84032B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710491;
 b=fy+JDFJZcmcVoFdomuMHa5+qsVQ9pqZsnJ9w9d0/nlSdnegg7Ah2jFAxW2xyJOMxjQzh
 W4gJ1u0MeCLipVee6VZBWWWhmsZlEbhVNa1OCrMDN4EEJHnQdDQjhGhdhQ/8/Xfi1wKFU
 iXd4jSDN63+6Wyo72ZGckhaxZwA3+nNvKj7KTh9VukGwfaJEeXiBofY1ZBm32PQhRbR8g
 DSa5+uY65DIEeSEbiUCXvrRVkL2/8zM2iap0Gs9fwfZ6rFQMJivnndc+/diNdNs078Xvg
 Q5m+jRJ+0nwTfcdJu72cZBdAWjIL7ymyDz/HrT0ddj2dlfhIrgs6cNTkqftbHf30eIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710491;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=aWwygf00VUdjbu47+IoMJ3Lgz2NJLIYYVtJ1w1HuWiY=;
 b=sgw3IaTeTo/pOHM5BWTUJg+1G2+pKjjJ6bQuJQNJS4kp+d4d/lmtDjUi4CodSN2a/Gij
 7QIeSTR5XkGIlzu/7e9QSX+8lGZbYnwTFauMEAVleDZXB0+TxzlJ7FFd2A6WaCiRm/+TT
 WxHTc07DitOq85wwKxZdMkQ4TqspUJA8CRUWdQANVXXJjvJO9Zs3vsskDkzu61u5Qnpby
 MQ1Z/mIBbxpYQkjXLKr5N+G0FTg+cQEnkuXdpKXQl8fArWT4xCcwI7Z3NQcBe/9jlds/z
 uUpV+H6C4k/58d7/LP86ESwZqwe7U8qAnQPSwL6qL9oPQpnulebriXb3ICzj2MV1Aeg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="p1pic/Af"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=p1pic/Af
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F6C84032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3BFEAB0051B;
 Tue, 29 Sep 2026 21:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710488;
 bh=tIonJwQibOMMfyq0nx5OWln6yAVAKVRkMaCLG4miq9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p1pic/Afh7J+/34ea2iTOXbD8MNZ8F+ReNJNIowVFSrFb7buv3fdcDrO05vA2FKTW
 fL0Ed5vSScsao7H29kLEuhs0Y6Mp+HcSF80SBO4cEOuQLSAmW+zNqfLWLkwHvFUQTY
 K6NFa9qeYz7xowB8HEdz2m8RMHtnN72vRQuHOwmFBDh4OJcm7JDgma7ftgIBI4sSBX
 +c0jz4THKxfi7hHvYOEtCQcPL9Lqm0SblRAEejY+6bmuNhqqdWwchfluLbz6GpriHy
 w6cv+RFlFjF1WbBebslqbL4h661pkCuCkv47VU+VXDpwxf/sNKUyKqmTCeKDtoq2Tt
 iyTa9IaPEkPIQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 02/13] board: lx2160a: serdes: rename serdes1:split to
 serdes1:100g4x25g
Date: Tue, 29 Sep 2026 19:59:34 +0200
Message-ID: <20260929175947.1379710-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929175947.1379710-1-vjardin@free.fr>
References: <20260929175947.1379710-1-vjardin@free.fr>
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

The following patches will be adding other cases for SD1 lanes:
  2x 40GE, 1x 40GE + 4x 10G and 1x 100GE + 4x 10G.

So "split" is no longer meaningful.

Let's name each hwconfig value based on the SD1's lanes settings:
  1x 100GE + 4x 25G.

note: serdes1:split has only been in next, never in a release, so
we should not need a compatibility alias.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

Changes in v5:
- Fix typos in the commit message

Changes in v4:
- New patch

 board/nxp/lx2160a/eth_lx2160aqds.c | 4 ++--
 board/nxp/lx2160a/serdes_split.c   | 4 ++--
 board/nxp/lx2160a/serdes_split.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
index c1a060877cd..8f48b14c0e3 100644
--- a/board/nxp/lx2160a/eth_lx2160aqds.c
+++ b/board/nxp/lx2160a/eth_lx2160aqds.c
@@ -18,8 +18,8 @@ void reset_phy(void)
 {
 	/*
 	 * Before the MC boots: it latches the live protocol-converter
-	 * configuration when it starts, so `hwconfig=serdes1:split` has to
-	 * be applied here and not later.
+	 * configuration when it starts, so `hwconfig=serdes1:<mode>` has
+	 * to be applied here and not later.
 	 */
 	lx2160a_serdes_apply_hwconfig();
 
diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 6d9743a28dc..1a5c44e7740 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -409,13 +409,13 @@ int lx2160a_serdes1_split(void)
 }
 
 /*
- *   setenv hwconfig serdes1:split
+ *   setenv hwconfig serdes1:100g4x25g
  *
  * Idempotent: a board whose PBI already split SD1 skip it too.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
-	if (!hwconfig_sub("serdes1", "split"))
+	if (!hwconfig_sub("serdes1", "100g4x25g"))
 		return;
 
 	if (lx2160a_serdes1_is_split())
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 67e8c4873a7..8dce9ddf97a 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -25,7 +25,7 @@ bool lx2160a_serdes1_is_split(void);
 int lx2160a_serdes1_split(void);
 
 /*
- * Apply `hwconfig=serdes1:split` if the board's environment asks for it.
+ * Apply `hwconfig=serdes1:100g4x25g` if the board's environment asks for it.
  * Boards call this from reset_phy(), before mc_env_boot().
  */
 void lx2160a_serdes_apply_hwconfig(void);
-- 
2.43.0

