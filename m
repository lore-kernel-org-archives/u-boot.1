Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEA7C79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 10:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44F2D6067F;
	Mon,  7 Sep 2026 10:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zR9q4hW9nacW; Mon,  7 Sep 2026 10:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4E542605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788775437;
	b=UcisJZvnF18o6WRqDdZdi2+y4JS6ioJx3vlsX33tDOeWsTYU52MdjrTsj3qE2pCG5kGh
	 0XmPBZODjnNPtEkC1jxfQBc9OOliD0feyCBXfdS96UOghufXSAGJFfPTkww1TOGTujHm3
	 gcSQA2i6k7svWpEJ0T7NcWaU4Qs8sHNb+31zjez0yA/kQp4cOAhXNrJytM37PlD6QYTSc
	 pFjfBXxfZSTI9pDULRIjd38lqrUarE/Vj7FlAhcCTFRKRHsl3oWvG/mcSq3KynJWki7wt
	 zyCC1fA6XDLC+fpTSx2yNx7lfakgyBg6HKrbdlixwJeL9oWsYWNKM5Fm/RTMjUqkfcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788775437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dDCzi0ORapJliF8qix+X0boFZ3xnA1cKDdZ3FtxBWZY=;
	b=dyWTHAgGqiLAHo7enRqcJWhVPSZ42J3DN3fOGwVi5Hz7nsyY+CQJEop9egg68vCQe9S4
	 wZbpO6BMwYHchZiQh8+OjSnnDs3rHmCxgztVtexX0qXp/Rj7V8ow27mtVQ+kTaraKvbOu
	 YCA69Jz/vblLtyyntZGgVbIECsLdKwTyN252CZugGFfg3bYwrIhNTFge3vCrduFlFGdyH
	 6gkzkXGQQdfP5SmJiZjILMgdifHp+GlHQB5cG0bjvZ6Iifro7U9ZSqhwFfstvU5keoUx8
	 ryJ8AoUTYiBKbWgTAD6CcZWAquEgInMHy0MRrRp4GqxquUYKkZ+dnIael0qX2K23KRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788775437;
	bh=dDCzi0ORapJliF8qix+X0boFZ3xnA1cKDdZ3FtxBWZY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QrLM4AX1Evdbxp2xgJU9We2jDlCqg9a0BrOpm1hdagEM5csRCJL/GJvgmVWGMihX4
	 sHG2R1/xnWcroVsFh85hZ0/sz7Vfjmc9EH66JvOji8cw3NvF72QrAl8uCXjt469mvg
	 vlv1w0cQOMb1ksRn1AVHH98j3BTGMyjiedVD200hduUBgd7ZyQhK3fZHQ+z3WAUDDG
	 3JCs9d/3CXYHhLireZKxg/bKCI1sgb15bL4bMIDk2Ohkfdo9X6+a5Ggp9IKWbWwR9O
	 c9ESZ3uB4I4BkkfdzccgLU8/hIbLxxMT8epXqxufjHuoNU/KLRSuxWUkQ3eh5r1ySr
	 XlsUH6oHd4iuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E542605E6;
	Mon,  7 Sep 2026 10:03:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1404AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2B764054B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y112QPEfoLeo for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 10:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ABD8B40528
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788775435;
 b=dpWCMKc+F2LxFegttuBbqgCRmkTEwPPM8YVQ6GBTCEgBUVIXqWrNGMPuwZJDXwSaEybg
 7ca3EaNgiLSTsrnW/j9nSMKGE4c0O7wOL8VXvf9CHtLlz1SPonQOhf0sqMLUKCnyYQWYK
 AmY3WvlI6RCtNUwU79j10drNQ4+yqo5Lf41zTpDu6BjgWQi36vird9xNmrDe80Anh3/2Z
 IkdinW52V8sQG/5NrxODRUBKS16UPtxO1qhkmoWyL8F1KejUGZCMU58Mw4eNJ4ZwsjjHZ
 XGAM8rsmg6ydx2ya3rTpo8ttj1l43UwIKtOl7GukbIpc+pUqFZgpvXcnc6O6qnBA0Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788775435;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=dDCzi0ORapJliF8qix+X0boFZ3xnA1cKDdZ3FtxBWZY=;
 b=U6UznO51Csgjh/+BwYVp7fu+Ou+Lmc+kjoBasVOeH/VtYQX6kHcWkwp9PYlemesbDqy5
 9vPGj2WD4ikNY4fmzILDUOuqG3MJCBFvtTWLZS81XZdNGZx03IvwMeZxAGXjFt9hqi05X
 il4X3jrp0wOMrE5YNTExlt5KhRj2ws44LYYMeb0Ubqe7DV4rRX7lPaQ8XmCvqYcvVqSCR
 Tn9RkbucW3mSMe2WiFL9v00g6GaRKuqvMoV0+0dFAAGyCgJt7W+EIMQz3f9+Ydrfh6eE8
 1DyaOBn5i9Ir3atBoUiBapijTCHToGJ9LLFwg+0GiXIzaKz1fW8sg7U4egWHSt3pUZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=WbpMEPI1; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=WbpMEPI1
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABD8B40528
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=dDCzi0ORapJliF8qix+X0boFZ3xnA1cKDdZ3FtxBWZY=; b=WbpMEPI19vkXWv6ycT0IWT8kGU
 FvQRYjRDVrkhQ/npy1bUz2PdLazxKmBBuBM5u7UXQ4J16F6uoZcG+OPHKR1xjm9cYiaZtcDP+g+2A
 YyUeLpLse48gxrOFAJLImYgHm+bu3c+Iv0lwJLpkTpd5cbVYr2q6M/7wThxN2moGADPKWfaY6j/LO
 k7a+U2TXHPekdcBHFOZCFgskpCBSpFhV5g+ryE5HgZ9U6+PTpVcGqVI+fpnSsP5SsrJOvE1WDiSId
 kqPf+swVfUqNgt2PqbjjJSjvKHP2yGRAX6b9rm/R7LLmYJe6NlLRbYxDgg4sye9QefcTqHBDk87IA
 lSXXRJwA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3WCd-000Jid-1n; Mon, 07 Sep 2026 12:03:51 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3WCd-00099v-0d; Mon, 07 Sep 2026 12:03:51 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Alvaro=20Fernando=20Garc=C3=ADa?=
 <alvarofernandogarcia@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@ew.tq-group.com, u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH] video: pwm_backlight: avoid integer overflow in duty cycle
 calculation (again)
Date: Mon,  7 Sep 2026 12:02:30 +0200
Message-ID: <20260907100230.29136-1-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)
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

When the variable `width` was introduced, the cast to u64 was dropped,
meaning that the multiplication would be done on 32bit numbers again, only
converting to u64 after the value had already overflowed. Reintroduce
the fix done in commit 533ad9dcda38 ("video: backlight: pwm: avoid integer
overflow in duty cycle calculation").

Fixes: 8300cebcd604 ("video: avoid build failure on veyron board")
Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/video/pwm_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.c
index 1470eaf4cab..3cfe74caa98 100644
--- a/drivers/video/pwm_backlight.c
+++ b/drivers/video/pwm_backlight.c
@@ -64,7 +64,7 @@ static int set_pwm(struct pwm_backlight_priv *priv)
 	int ret;
 
 	if (priv->period_ns) {
-		width = priv->period_ns * (priv->cur_level - priv->min_level);
+		width = (u64)priv->period_ns * (priv->cur_level - priv->min_level);
 		duty_cycle = div_u64(width,
 				     (priv->max_level - priv->min_level));
 		ret = pwm_set_config(priv->pwm, priv->channel, priv->period_ns,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

