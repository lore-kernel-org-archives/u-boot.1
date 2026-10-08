Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069B2CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C310760873;
	Thu,  8 Oct 2026 22:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JceLbCh5jAHf; Thu,  8 Oct 2026 22:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19CAA6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499417;
	b=XxwdNJS4Jk+LnqUemQRnYjxqCMU7EeuHrIDz/X1RGKxwP+vYo+KJj+ZCbOUqa0Pdstck
	 5pNYVm5jYGszjjUoP398JOC+dU6QLc67CaWSAvePhl/JkyppGBn1NYXN81s6wKASjZAm2
	 PLWN0xtMhXdPMLYntTPy54RWrhOE8w5ed43oFbPq8EPqlTljwesp4H8gJqJHLhwx3yRzq
	 RW8ZnFIDWZjyM9q7ys8O6TmOKllgtgZh0yOSY//Tzy+F9fSN8yW8clau+iSy7Q5pgbaZu
	 ryGXR54DXlxXlvtn9+NlK3Z62N2HUWBS2NjW46yYhXn+l7GcFNQ9PCRDTsTzy670NzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
	b=SkA+p85gUWsaKBDkmelTnm2d4qBm84UlFn9l7KlOXMhVU8TXtMYZb/SuofXDp3kT6GyS
	 ns+SJfYR4IH7blOAGgG6al1gagqpHWKO9rt9cuSMuzhwmTfgq77UDo54AjOzGEFzxDOLt
	 +7vEQH2QblOxVcvP0zVn3ARbdnztprcZpaUZw4No08kmKP+IjF3PFiYT70wtk7aoLkBRH
	 REl5qZr314bJhX5AR8WmsuFr0XR9ee551GxTQF9/bAZeh9X4AMH7Kp5M0RICyPKUiXGTP
	 SHQd7RtprNSF8Z7wgXdPUHfUdy9UYCtCv0GfaGlorRWYUmKnd8e+Mqve3nSSJhHHnEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=UkE0TVuW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499417;
	bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xi9s63Jt7Z5k8Dh0QcutwE2QFgs6W2BQbbJGl1EjkWivDl7Ui6vvJ1sC/hzFRBF4V
	 Gn8/op7N2ABs397FzYmjKT4AeyCLdOuCsfEWLrbjKER+kHaqxlwfBIyDskkp6ptps1
	 3iI5lju1Aex2kr/pyVI2trscCRacCwll3jtc4OooWEWbgnrRi4aKfTDc4lUUAl8Yl4
	 ldqGeCnElf9k+MQj/SfSJ5PJF+fRjOsjcbDqdvvDNd1FA5o4jowoQlQDs8TbVs9sU7
	 HOdxxdr7Lk3AXORqQLGC/87+VW2EDBhZHw5kmH15z6CsHlh1lfJq96AauZeAzkcArQ
	 48E2h9dObg9wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19CAA6084A;
	Thu,  8 Oct 2026 22:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C05891A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A641A6084F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkh0yS5Bme6Q for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ED0886084A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499415;
 b=kwnl0VkvVYIuEeb9cuWCj57hpPhncFvkbFSDxz7XqVOvy3eiFT1965QIKU/eMjM2IzOC
 sFdbl2eCzjm/2Q7UhILIPYK33uxpv6RKSHUQRdj8G4YCaWgFIavjldkmxdf050OQ5xzwS
 niD+hKhXscL0/Uqry4iJVumI3Uu8AUv3u4MvhUE+yNrdkSBQZJUiM8/S3Abn6PrgQjPkX
 DknByCwJheu+Rlut0Frh9tcB/7gUNI2NEp+XuIeEimPHKwat/8es12PbL29D/dsfIN6qy
 lqk4A45VtyJV9rpgj0VTmo9N7KdFAZJTt40pB82FhIlzOjmvmIGe62qfq30Non2YZOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499415;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EgrwZBAoXQWirRFkEjr2puFkc7ORqhIxbb3q99CF2n8=;
 b=B71biURokLhQHQl02YPHixunpP+sJ5tIwC7FGTN2/O2FzI0Xyequ/gx599Il8pK5O2PN
 BwAqQe3kscEpo/RvqHxkFqqxB+FOZeuvjfnDy8oWKQDvVOPWLnwOgkIBZUSyTrh5gIAbA
 9n4eUthoDCR+mjLQX7SR98SE/grlAQqgaAmIykUsZW5RAya9oGqLnW8SYxymfhD7Wv7tU
 GlcFN+Zv3RMEAG72D0K0iFrBMmE4XIdJcaoHPynb2ghp0A+hlEikKOYj8GuIjWONyUZTw
 qf4mnDwB60bm3PftLblmIivIKtTJH4eD/yPP/SAvzrdupPGfnuOE8bZJyUE77hPZItw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=UkE0TVuW; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=UkE0TVuW
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED0886084A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 08F6CB00539;
 Fri,  9 Oct 2026 00:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499412;
 bh=pZsWzCg+5762IyVE0jKGHWGhJN4VMj8CanFDVTqJlw0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UkE0TVuWiqqgAWugp8WyX4SQFBpo5eIR1EDSF/q79dSC/Gft7h4zYddPR+EpQpysz
 iMiftlyjd1sNCtGllgg4FtwUTKgxa3MFRjNKVO2EOO026Vs1ua6mWPMp7vVGHqVXQ9
 Tx9iDqKWEryM0emGyiUMEsLjKb6bIQmJR4ctMsClGdY45b1UULAJ+7US14hyXe/7y9
 huBqWo3Y3gxIIGwQdgOHGMD6DcptwwUn/HpTTDSyrSuLd7NF0jJwBW/v4M9C6nK7KF
 wyGVjJhp/sk97c2Nr0It7JwHyfTESTTr7QdcOtEd2LFYxq3TIJXKAxv8rMbXxaEsK4
 o5geBWNeyIO3g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 02/13] board: lx2160a: serdes: rename serdes1:split to
 serdes1:100g4x25g
Date: Fri,  9 Oct 2026 00:42:15 +0200
Message-ID: <20261008224228.512353-3-vjardin@free.fr>
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

