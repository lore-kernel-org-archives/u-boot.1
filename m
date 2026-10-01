Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A80FCA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB0D381161;
	Thu,  1 Oct 2026 20:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9C0-JBLCYDJ; Thu,  1 Oct 2026 20:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0FA4D81160
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887719;
	b=pgGWl5Bk0C7c2A0czgqVcKnoaXNtn5DcWXhRprtDNKSCDPfjmMj+inenLbk++ta5v14E
	 42lEgPQXnWRS/utTupmIGtlsoiFnDtNzilAirr0kVi07V0F2t5WYNzbUG+w9zVjugQG9t
	 bPPrJJWGPmOm7Z67Gfo0RUb5xE2fU/dcyKu7W++rIlo4JNPU2428kKLyLFneMFROTu7Ne
	 9kxY2+DjxDnjSbfCWIrUYaEeU1bS4lCtlobxagXY+YHBl1knWfBxLVHmRffvYDzTtYeW/
	 /y9GIcbroO68/70QBwH8YfzhwB3Aj65+qmnltgcYVPBoaUO42tIHA0L+P5qXpqAGGGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
	b=QM2AhT9W/YGe+uqxojRoeMg7FPWfphA2oKMVHDD3V2r17rr0VVk8KUnODTP5MwCJPpRp
	 rCBBYe7ozYpNbshtCNCFwE7m8RNLGHag4+kGzHKCvEG6c4PqBjJt9uxtmaCHJGiufb62g
	 SpXmuHseT8rms2vM1KpSQP49VZRVC+ukWGplA3iDuQAO9W3SP8aK3X+FkrgR8+gahZGrW
	 QwcJtCLg7xniVRsklAIWfFg1MT3DJQPqrMXXlB6zx4yb+bD3YcTWx8u/EzQHjkN6118BP
	 6DiePWBX9GryT8qsA8wxq4LvS06BSQuSocF8KMyZRtjqmhNsDIs5hvvLWOgS3QhE21g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887719;
	bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEBcOX1KkBn+/CbeX5ng2+SzACisa6piFyHPZFkXQDH4HaJNhxOcvc7CvW3vkv29d
	 tBzqlSu020+7E8ROyITWIHSC9CPWvVkxaID7cD1a6fSeb+j0hN9WgATRudD0x7Hvl5
	 QJ5YqZ351MXFNStGotQB/lY1Bno4A90b5i0e2zVn3c+QgOwYDSJnpHZhugeTlYz9b0
	 tgZsG/lws13Q234LV56IgiIDwqv6EC3wHZcQzm3mgccVJO9n8D9Oat5Y4lvUJI4n28
	 DhC7l2ETxAsCSo2iOsL6g2gwTklviY7r/AYs4Wn7yIloYo4si1RNYD6//fbfCMz16V
	 pktPrqwQdPMOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FA4D81160;
	Thu,  1 Oct 2026 20:48:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 924B122B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 901A640062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-jja14eW4Z1 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:48:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 89EC440022
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887716;
 b=bbfF9iqL5oEFAvkJqG24/nIhbNWsexOlO/m1QD7B0Az9DsQ+NtDdht5rQTeRMSHnG9Vo
 alNW1znles2mxBsZ2p+Vuj1+g4NpUs0R9chPl0RkiJa2Y6KFjwEJ/46DzTbPf/iftSpFC
 Wr6qK8eczCDHPSfH1hSnFdkAzWGBjkh5NoygWfM7KuqVyScxkzCsnUBL4tvoy2JwFJybZ
 C43zqkgkOSqi8HFh6lFtHaSPvfY5FHSf8CWbRZ8OI36exoZtqUpDWf4eHq0oVYj4Wfw+Z
 eLSVcynfJMp2Stpj6WkioH4pIsbflLJzCy84szcYqQKDJ5YNxkYJL1nfwBkIwxPgubQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887716;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
 b=kHPS3ISLQ7UXYTZNrOs1zyuxDQGU0P253Wp3kdIFMbPr8IrO7gzPPMn1+jA9USISHThL
 hBrL3btYVUYd2IORbmdpK1Q1LDXgDAMyIRuCVAburT+HGQynSFUmyONpeyn7dy1gDZbRR
 YVh7oAsC9GB3Eb0Idw4TACTOUqqW2nY/kVqbwrx/VpprmCGLCR2GOmC5xEe7fiJEp+4jS
 akrWIl+NU+h2q+h6yx9cYQfY/P+LIXWnnQdJ05WR4OjPH9BelM4AigAutYMDxpqLiSgae
 hZ89SV2Rn8Fan+n9BCpLYh4/2dTv9JjQTuFTi7UWzhTLwRmT1kOa+kf/WNI8glkv0dQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Bc9ur68E; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Bc9ur68E
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89EC440022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 94555B00563;
 Thu,  1 Oct 2026 22:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887714;
 bh=pZsWzCg+5762IyVE0jKGHWGhJN4VMj8CanFDVTqJlw0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bc9ur68E9/HTDXPM43/XMEuTNVhtSf+EkSVDRPZMzXpviEy1VTxQApvigNb8dMOvG
 DIl317L6yMVV4t2G3bHcBITA9Gi7kg4iPNowkc2UipH+UPuhn5TI7eq8e7EEZyiark
 UMfH783b509oORrXNwc+z/ITDXjhQgXCJWt1DdKnYX9F9Yn5Yd789vBUVE15mwZqL8
 gZodFhXNd628iya0EwXTlO56p/RoDP6iFRg2HE9BEbcd+Gxna+eq8Hi4ERzk66xJi8
 kA7kayqbxKVYKwBH7JNr5u6dcTUoJw4Ge7p69jCNcjYO4/0R4tm0yVKDmWPzozoTf4
 VcEmKsMPUXiDA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 02/13] board: lx2160a: serdes: rename serdes1:split to
 serdes1:100g4x25g
Date: Thu,  1 Oct 2026 22:47:19 +0200
Message-ID: <20261001204731.1774613-3-vjardin@free.fr>
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

(no changes since v5)

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

