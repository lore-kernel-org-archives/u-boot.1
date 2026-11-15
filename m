Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE514606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C4Pcwq/R;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=WOSnF8T6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C54AC80E00;
	Sun, 15 Nov 2026 20:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVh1p6In0yIv; Sun, 15 Nov 2026 20:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D69E80DE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794773098;
	b=HZ/IwfFMVOmfG1R6npq4g4CBPyqzmF+Q4VnK5Oho1cP44eVhD0cTstRsdsMldeE4XGIv
	 /M5XU0mnpsKsfkZthy4yQrVdMxnKQOkkrk7NqQP/1iG27HxwKTceNE5EXF4MjQRPDo/ZE
	 czsqNpR76WMxwkBZ87P9Ei8qqVwr3HA7vGk0pknPP787V3P+i0QFEOSw+8HNcwyKl5B/D
	 IVdKDTzin+stEWbPFsV9ratm29VGyTy3hgD8XEv69WI4t+cpu6rPlLCXPrjOlA0LYV6fi
	 4u+1BCT8NguQgJ81e9dWo9FlmfAVOO8u2PXIsnGGgrDuUmtQ7i+gU4ZTrrGS0j5tgMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794773098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6QN/ofa7J18mzyxtuA+1AoxhwYucErfms+sNqPapR3I=;
	b=aL6VnfNPBzdj0A1yubLq3sszckDe3GZe6/xlKuJK/kWlqto3gNm7M66qrgho/yRm0C4+
	 mAhH9MP+ZK5iHfogGkzDxbzT6C0Mi23QPTKaizRDMVTF5ziiidvCnf5B1kdh89Q3Ji4IF
	 R2HXWNs2vWbLVEaqSn6Y6D2VhisqWgGdE1CnMHosxhGCkFOP3JEeUyKHJNGAhLWFeHDBG
	 IjSOUItMg1htF9BZuYQ3Cs93KjiU39+dGj1sDGJTMWDIFUBmBm+0DJdhHxIonRuY/xMew
	 jn6yUcMUzr1UFOyp8HiNh89hUEuNL/bU2aexzMHTCXIfZ0KHXxE9L0sheitytG8IBeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794773098;
	bh=6QN/ofa7J18mzyxtuA+1AoxhwYucErfms+sNqPapR3I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C4Pcwq/RO3whPDqROif/4lM3mR2Tg0JLbqHcZoZaHMU1QHkYflVPZzbI4j/G1ghoD
	 QaRV/vB1oG+1Iq5zbMJinYulFioPOeu45KM8Deqppz/P3qKf9AwRTy/4LOLliKWVUd
	 AQpxsyDoceK3wAwmS/87Wd1f7CsWVxi5gMr4qN/bUaA9VvWrp29fvpOXPpiFqb05+s
	 gWg6fFarqwvvVwuAffgytaXBq2TZLWRBupl/RdHj+/d/gNB2zXZ6wrTFZ/PmLVY0Qi
	 tgdwpO3i/sFc3tK3JLCRlaO/dSWjyvy/ExqYg3r3RLuOcq8pQ/ioQVEJ+cM0SabxD0
	 gmLCXNdztrMoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D69E80DE7;
	Sun, 15 Nov 2026 20:04:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C6721A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D39B60612
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qB7mt14FCPjj for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 20:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C446960607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=WOSnF8T6
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C446960607
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794773094;
 bh=6QN/ofa7J18mzyxtuA+1AoxhwYucErfms+sNqPapR3I=;
 b=WOSnF8T6isijrUrUNro2EUp+IiWEvWrDDY/pI63Kv8LlhWDexbWA/OSIZ1sqHmzwNl6J2EwFD
 5eAU3nneix3rXam6S+mQMQad113IV0q63ieYvlyMg/Mp3AGNrEFvFySLyrJ+iNnq9nABcUFAtqA
 8wU7Zflh2deAk8hr1rsdgvpXcWDwS887Nnujh1RfMeaX78oFBUoDybusw52memE+SBdxRwgGze/
 TY1WyoGhr8knpOvOV0TnxLvqaz0bdTEIPwbtCX9mRbj5qC0VOW4DTxne/VPiHSG3ZMNr56FLw6f
 S7yOUAasSBEr2wfAeRKIKyX8lhUjCE+L0m2FjBJqxHVA==
X-Forward-Email-ID: 6afa1063dba336f1fe1678e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH] clk: rockchip: rk3576: Fix ACLK_TOP divisor value
Date: Sun, 15 Nov 2026 20:04:46 +0000
Message-ID: <20261115200447.120668-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Write the calculated divisor to the intended divisor field instead of
the parent clock selection field when ACLK_TOP rate is changed.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 1a2ac14b63a5..a7e0febfdae8 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -306,7 +306,7 @@ static ulong rk3576_top_set_clk(struct rk3576_clk_priv *priv,
 			     ACLK_TOP_SEL_MASK,
 			     (src_clk <<
 			      ACLK_TOP_SEL_SHIFT) |
-			     (src_clk_div - 1) << ACLK_TOP_SEL_SHIFT);
+			     (src_clk_div - 1) << ACLK_TOP_DIV_SHIFT);
 		break;
 	case ACLK_TOP_MID:
 		if (!(priv->cpll_hz % rate)) {
-- 
2.56.1

