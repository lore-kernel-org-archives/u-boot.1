Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73605606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UKh66/jA;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=XQa8dXJN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20EF940636;
	Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yC5Ai7c_EB0Y; Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82EC94063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095553;
	b=lCypbpXS3Ck7QOASig3SL+nCEkmoqbsSrwXCuyVSDECOm/VqNWywfzLXxQBgPgDNdtyg
	 8maYYzbBPbyFkAtJvmwx//65jj6BgVVey/B+E/AvF/5/fk4aYTDk8ZzPrhoXZO2p9vDxG
	 V3QOdeFT3I6yHRxulJBqGIgSsB4kq+jM4MUo6GMQ/zgR/XWl0wxV9lTwmUcs8ifFOILVx
	 6cTKfyo4jlqGt9jRFZr+vVcMbgv9KOQkrB2MU2Z3fCfV6E0oxm8abechtFGizMZZwJTUp
	 wneIdPkoXQUOAZDMU21cJ+7fig8fyom7Bz50vEKe1+dxGpMRHoIIJ/x9YwoIles9LRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IELwHQ7PCKucmXjGlWy9YvljMdi3OVqmI+KCpJBF4XA=;
	b=SN5XIbVwcE2i70Chk5YIO6Jsd7B6Qv1WK5D/bE+GCU1QNuRDDD+4iN3397wBLVGtHHNA
	 lrBZosKJqQq0dxkBbm/d3ddEMcZX8cWMozN3XisPFkS3nYMNUudg73UOCVjyFgC2X2VHf
	 RtZNlGWujvrqogCUckxTcwNZC6VfFvvnrMKXwvnFKzOtCz2bYOCzbjzWH52h+ZYmrc/ml
	 9wv48JkPa3AErh2Vr2fZTqGq1HP9tcuSBzLazZnXdYqWtDz3P7nXVVu+XAVWFkALputjg
	 hCiG+4nlGfuCxucZBMsGosqOgdGxH9e0FaKjxSzAvu3azxAM4QLe3/9UkJ3fPxiLm5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095553;
	bh=IELwHQ7PCKucmXjGlWy9YvljMdi3OVqmI+KCpJBF4XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UKh66/jAZY5WMbfXhftlwArr2lsVu+gcijzcE+XF62hNP5xy1T0n/m1bSfkjmOfDd
	 TeA38eLdy+CYioq5zJTgHCSPFEqXGZMCRq32BR28AC1aF4VYIDDqgt84gmmWIu/+HP
	 VOQOtQo07r1ayNqfbU5wf86v9Sa9xPdUuDGuUmkCokWLnzfZ/FVV8tZ+guaK/25YT1
	 pLNZdpdD/pvy0scCWTHNNfckxb6bEscYF2EmQQC8ddac6TMN0QxN88D7ctISHr5e0e
	 7WDmcrPp7QVJaAP7wqqIIXG3CpnW74uW31WUfZtz8rsHtJibUzngOr+jak0wkrXlrt
	 jJtDtsykkidpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82EC94063A;
	Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 912281DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82A9980B89
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVucbH8JBVl1 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70C07809F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095552;
 b=doiPZbN5vfw9SXnRVtGesjyadAMLQKiPZbOcCU5na2S9gdly3SlSRyEunXVVOqsmbWOM
 cATY89Un7azGRKuagVqCwyK/NLCcA4xdeQyDaTFnxZbnKVQRlsPE9G3KqyKtUqAYkgj4c
 S4vL7hrU6mL2b0iWxtQFnpQxavUazOtTeAnFh73gfbj72FrQSQ8vmJx0tmSNCzI8F1fdh
 AVCnz2+ZBRNH3LFSHyX8iKqTgzgGwpUnuqYco0Ak8gRhmSnkOzxQAm7LTs5l/13Bh+ujj
 42a7fDddjVTxeVk4IdjwXsoG4HLip6HmRQU25C4phwHMdS4hOVvToLrLnBjnr4HJqEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095552;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=IELwHQ7PCKucmXjGlWy9YvljMdi3OVqmI+KCpJBF4XA=;
 b=bAAEckonWz9NNaDEWYKui71qpTs9VDkn5ofDA/Ut2zwufgszoasdW9Xm7NiG7jLxH9ZH
 Y9yBGC4ONC2tAZs5ek0y5BlNaRrX41u7q+4xUafIAnXSbq/AQm/lMYP9MYioDZjDuh7cQ
 JTFqC0P1Ul26mhh0vBdZ4DhYTihqBPGroCzdpz73UIAAiY7XTDDS2mHPYLQzcuLYHkI+J
 YXPvgg0og1ei9MQrmKHz0gbHeLzZP8DWQDutwrjtWYmQnQrqXfuDltBTHXAZrtaJqya+M
 mDOuZqOTK37sD+qUnnr3IGiN6u/ELo+/uYfiNczcofPbsNVTgQ0pJYBdPo+HoSG8aOg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=XQa8dXJN; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=XQa8dXJN
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70C07809F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IELwHQ7PCKucmXjGlWy9YvljMdi3OVqmI+KCpJBF4XA=; b=XQa8dXJNml9MtK5suSiwxBPSkC
 5TXAiryZsymOhQtgtNKJ3Yyxf6Zz6V71J4nv2IwXWc3hmasDL5njnJ304+A4mTL0W5H7yNmi7uiOj
 mr6zmyXcm7b+t3hlPKaYVT4YxSbN/kUjRhwzYxxUMXr3KWOftlFRdWiVSvT6o0/hvKcECDWZo4w5r
 J368fNlBVYtkvHvWBbVr/AbOqLqbWkVbTVcg92QquV2WZFGKHvMQ1QShOBp5W/YQnUNuJroUQWsVy
 KsYco9lchUFArJITJsOFj3hjg2PCECH3ksgmYAwoewDmFubNhtX2vcPnb5EOQ29zja7xkjn6I1NWi
 R5uulLGw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3w-000C0K-0M; Tue, 27 Oct 2026 11:05:48 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfI-00022y-0X; Tue, 27 Oct 2026 10:40:19 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 15/16] configs: tqma6ul: drop obsolete
 CONFIG_MXC_USB_OTG_HACTIVE symbol
Date: Tue, 27 Oct 2026 10:39:12 +0100
Message-ID: <ce7f78b66f937bb8653cab5da8055db840ccfbdc.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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

The MBa6ULx Device Tree sets power-active-high.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 configs/tqma6ul_common.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/tqma6ul_common.config b/configs/tqma6ul_common.config
index 6b1fecb9071..6ff772b0b97 100644
--- a/configs/tqma6ul_common.config
+++ b/configs/tqma6ul_common.config
@@ -123,5 +123,4 @@ CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_SYSRESET_WATCHDOG_AUTO=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
-CONFIG_MXC_USB_OTG_HACTIVE=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.55.0

