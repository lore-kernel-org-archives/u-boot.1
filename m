Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3655FCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB92440547;
	Mon, 28 Sep 2026 18:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kW3s5WWE1zi; Mon, 28 Sep 2026 18:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 33FF24054A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790621676;
	b=XzKxHmtmYdgyXjXFsGr5M1xRV5UPJT++cYnNahTCCZ62Ej+fNqSex7j491/ym628WfII
	 lkZnTTgO5RD4GuW6ApKRGoQTk7Wf4op7JnUiKFtrH6qhgqDA+YBZB45R4sNrjhabTOTZr
	 iyZJx8LEIo/7b7J56FkdN1isE6gBb58q5MFIDfvPmSv+62qy+Km3FElCtZBqCJPgWhLvb
	 NC9bhZC36BesmDk3Xl7tC8dL53aU+2CUV5m/N5XyOzoVkr9HCVk22v62k/FJYHwwKiAhQ
	 fEFTknpOOKoWY764hUVOSS2lqvKpwUZ5m8j0us1M2x58kbHHHi/kDkopodpNhjZaFhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790621676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=S/n4W8KQ1NsqfVskTqRP2EFrfs2AEmmEgpAA+HGnEj0=;
	b=etmp0y/d8cW7qdjvwRKFljjlgW5hNyeD1c/2ZGEbzugHdpUU+V8dXwWOxlrijhxe3n0W
	 vq9AlplWBL/f3b97eD3LzJKWslPRAHfGO2FTJ8LL2zqmz5hgkMvLrk6tv42jUREk6fDE0
	 XwGj1HO3Rja5tAxgqnukVlC04ArWm4pfllUl4gOMfl/NxYX6kY7FU7tCXNL1ZBwLqq1ec
	 3c2quZKhIlQd1r1OEHhorN0EjncP7v2y9ox+rJjlFjPpLo7jgUuUzirZGN618LMlrrdAQ
	 O4JnVoQM+UaYaD6opireorQ6wZH0B8E/cWbkqwAM1geMbVBEZi2gc5TtGM6ORw4IU9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=H3atwAuM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790621676;
	bh=S/n4W8KQ1NsqfVskTqRP2EFrfs2AEmmEgpAA+HGnEj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSNwSJ2oeVzIujiS4BvU7OQhM+uXn7KXo+fVJ3dcD1om9nUk43QuB+CSISu/2ftcP
	 QF/OKSkVCnkOJkEtX9iguifQ6Xjo9A90b9x4vijG82K+YwZacZVqr+tKm0eLrLxM93
	 b72Kqva+BuCnJQf6FQg7SQfLJlGXR75cfFGRgCX5A0Kaur2Ah2r4k11K8U+rQ9hlio
	 pPkeqcVQ1QN676XA3OMDkywTmBEZ97DNB/mWv7vyJWA24uFznReg62Gd4Y6Cd/ncUi
	 JaHDyTaL4CjyzJzKQhXILX4GOfVjXvQGmCAckEaFfV21pr44/xay32sDnP6fbhDWk0
	 /d/ewBegO9M+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33FF24054A;
	Mon, 28 Sep 2026 18:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2A1C3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFFE44054B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMYSuviqm9PL for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6685C4054A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790621672;
 b=HYYzbVgWOeb4YdL6Q1Rjtz7NBS5s8GmqhghjxLDpl8An3UerQOsUvTKqgIywTi+J63Ep
 3lA27xS9fSGebtabrL9qezrUaretLZXj0a/VhWe5ZSneP4y1qImhwaOS3TdbPXwAI191d
 5iHT7FeUpfK1kMpYA7vDSwL94yquN1vSWnO+tsy+uSIItxkWPtFv5Iw83CJOfQRQhHOqy
 dJFNak703TPkHSh+AAn1qC7XsfszJEfB75cVEjDIU/iX3IfTMHdGaph6DAM6+0aT7qcOh
 D6U6J3nsutPtfN2kM1hgB8v+O7UunMVFjM5KSkQVYCxPx63LOrQEVfGM/ZoKWYBCo8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790621672;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=S/n4W8KQ1NsqfVskTqRP2EFrfs2AEmmEgpAA+HGnEj0=;
 b=Mg5NK6q/6MECdJfwkUHvLc6eCXX217QX/qfsLP/oRvbpMdS/mtkKZahmtr9WsrMcthVL
 2HY5KcbqSQa25wpfbJad5a768esT4uL7hzeVUbvMPR1KiXpG5uZsjFMVXAOUnfNXmH3fq
 xwidfwFIxGW0+pTQjGSJ3SpLtsEwAl7Hv/g/LcwHKvoMo4Vzx3o+UxA7rJVm9l9pUxy6H
 5vR2dzmwejA0/kTCtA3EFh0xam1qi4YPwjk/dmiqjweJ27SSmjuJepj+BibldBXmrmRb8
 +nqHsmMM07IDUNi5hSO8zXTCfrjHpGT4iLshR6jmQKRUxL7f+Cz7xtkk3iV6+TNFjJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=H3atwAuM; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=H3atwAuM
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6685C4054A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4htr843XZJzKndH;
 Mon, 28 Sep 2026 20:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790621668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/n4W8KQ1NsqfVskTqRP2EFrfs2AEmmEgpAA+HGnEj0=;
 b=H3atwAuMyPWCFdkj8FUJ5IgqlYBbEIcd9K9JqrNjEYLaDx9xdlb12AsFtXp6QGlu1XDA7t
 lLtALr3RjUF5eWa66/4FL58y2fesr2b9+1kEUdnn8Evhy1hGW8/F9Epxk5Fzd8aemBTgdz
 Vj5vZHu/wTMLowhc0ZuQXjtsj0+vYDKi+pB7op9DbnSyggPiZ5Uq2UehyBclQ+k/IQFtZQ
 aMLoddFB68U+POkrsu2O6e3MqCiV/6xi+ihYwUc+ldAE+4Y475W42C2QfLL68IZjwJrvzC
 UeI5TRPG786JpJoOnsVPknc3MC4sZPV6az3dA8kGs+01UzgA1R3PIFdFi7X7jQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] clk: renesas: Add SDK SCP 4.39 map to Renesas R-Car
 R8A78000 X5H CPG clock driver
Date: Mon, 28 Sep 2026 20:54:02 +0200
Message-ID: <20260928185422.113757-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260928185422.113757-1-marek.vasut+renesas@mailbox.org>
References: <20260928185422.113757-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tsum4ti5qkg3imiu4yjsr1iu49b7cero
X-MBO-RS-ID: 736132082836ec854af
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.39.
Add SDK SCP 4.39 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index dc24bcdc000..0fd06f578ad 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -107,6 +107,7 @@ struct clk_map_in {
 #define GEN5_SCMI_SDK_4_32		0x010e0000
 #define GEN5_SCMI_SDK_4_36		0x01100000
 #define GEN5_SCMI_SDK_4_37		0x01120000
+#define GEN5_SCMI_SDK_4_39		0x01140000
 
 static const struct clk_map_in gen5_clk_map_dt_sdk_4_28[] = {
 	{ SCP_CLOCK_ID_MDLC_UFS0, 202 },
@@ -190,7 +191,8 @@ static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
 		   priv->basever == GEN5_SCMI_SDK_4_36 ||
-		   priv->basever == GEN5_SCMI_SDK_4_37) {
+		   priv->basever == GEN5_SCMI_SDK_4_37 ||
+		   priv->basever == GEN5_SCMI_SDK_4_39) {
 		map = gen5_clk_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

