Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFEC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8060860846;
	Wed, 23 Sep 2026 09:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stJ4R3qBottL; Wed, 23 Sep 2026 09:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 541F960823
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156121;
	b=ofiVp7dYAvKMkHuF+doFQhHXULoxKcMHuOGzy6S9Od72InSH3RVR47gJHOM5pqK033XS
	 EKLSnWebDnX2x2csOSWy0SK6TI9AgYODYjK7pA2tPND3UDik2Oyc1q63dQEONqDncbRbR
	 eKfAOYE9pR8fW1gdXg28B/mG3Cjqm9P8adhDcH3rNbgsiiDRiJm/wBXFL98kSf7a5LFSL
	 PU4ih8AllFxWcdjQo+fEoN6pS0QwsDKeUUefqMKVXpCWJr6XYQfZ7HdoaX183W5jMIjn0
	 aChvYghOOgTHzvYIiIQVpyC5jTLWL0kFYL0dIS2z/eGVvCg90nKrV42cl6N2iOf2tbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tvDdxkQqQFu9ikiIVUPhKlhxINLnODiVwSWiJxP0CtU=;
	b=EYLbwYZKnz7WgMnSxY58JzH8WDt/Nu/FDMxaKImaI047OGvuHx7HdN3hnKvMsAhDXxxa
	 w89dsW5qesC0BLqaTUhB01XZC+6KUW7qVjMRgyt4JnxaD0lCYNRBmdkUp3/XWkg36WQi9
	 HzTw7Hk2BR/Z4VAOb6evZ3RNWNTAphDIoImTnAFWVSvqj9ybEs9zgbk9WiG0kljq95ZDy
	 B4rDHVSXWqsTEBSSu+oJZv+nmbFn+Ihy4SuBi7SLvcBUZHnqX+KkNl35GU3CMJhv+QMo4
	 VxFBM7tXpsczdA5PCVfT5zwwWRtBYYYksylzp52FEciIRI5C+Z0mJ7vUxnIBfwEy+4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4DJFAJq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156121;
	bh=tvDdxkQqQFu9ikiIVUPhKlhxINLnODiVwSWiJxP0CtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJNZ1Gczs36bSGZH+wCpPR7rK8xBl1r57krMlWV9gAsSI76To9wYFrf//KBAR1HMH
	 4Oo5rmH/dEv1fBtDRmvxGSIOZ60dpnPDx1PvKEYmkjVXvbSDt98y3EkorBB1Hf7YQf
	 gV0AQ3KparVi11LXPFnzUKR9Ca3lmZxA/kV7fIELacVSaXLaGtJlDJMXs0PADHxv07
	 ID1UTo/7zBCC7Gtx4gotrhtSY9Bqvv4SiUb4UP4lJVPnLuzMJ8C1QUtT/YI8eha3pD
	 lNgJuYyhY0EUvukmp9N1SJIDw52x1G8eNlu2eCpmi2E0HnnHrzIGVMkmGf1pYi4Fmw
	 ThAcCZXhCvU3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 541F960823;
	Wed, 23 Sep 2026 09:35:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B741D1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4A0160807
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6beM0qytan5 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C700F60837
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156118;
 b=Ui2lHcwUd6R7Do35dfA7ahkOjraOvC2fEQ0Q/O0NWvQawV7SKUXVKteMbG4YrfNX8aYF
 PsOVhqHCUl+yjvStebQjja1cTHtJojhBWaCDzC59vdT5+z0GX8InriNm3BwaizupDZVLd
 0AKw54rSCpdPUu//nW/1Of7BE4PQqQxmNnS7syiR6GMsR+ohYv3cHZtxaCYepKGQ4N8kX
 9EndE9qvkyiXXQbb8E3oWqKknsDJa2/fNeHd/6pyQqjVsbXJM+mj3slPuAmMPjtVkNWp4
 iMFyeM4h2m1fcvLKNur44Wg7jWZKnuBp0Nh8D2JgelKr7VoaDftW4nRgDxnWxbN6Wgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156118;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tvDdxkQqQFu9ikiIVUPhKlhxINLnODiVwSWiJxP0CtU=;
 b=A5X4i0XqWA+xNyCiquiY/f72zqu8pAwVUl3y0DwgMHB4HsjKQZNwXGS00M1Vax72PjEN
 gRZ8ySFMcUOMC+Qk+B98ygISIOhZaOfd3e4ZrwBZdDzekgNcvWkLeXinu1wwi5Bsa0vqz
 jg6+ytNYaMwZZeTZVxF3bVDwn0/6Y35elwY1lzTXFScCZauURIBUUSfGkBmoL2ORfHOdT
 DryD/aqPIYupvi9xlW5vdXuI4J26g3hm1wMt+9v9U3QCP50SQLb6Wdref4BBsVKwcLBUE
 gyEUxLHnc7tS65MWYk/m+HVmkTdc3gbB3yAyY1HiPxrs2NWCkWDz5TOjnhmZFuD2kwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z4DJFAJq; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Z4DJFAJq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C700F60837
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 166A440B70;
 Wed, 23 Sep 2026 09:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A951F00899;
 Wed, 23 Sep 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156118;
 bh=tvDdxkQqQFu9ikiIVUPhKlhxINLnODiVwSWiJxP0CtU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Z4DJFAJqpTBTQunxgqnZWEf/nKzc3R02W6gdSiXv6tTASpLbH6ekc1aNPau/UDR+i
 9O5+7LCSlmZkthoXW92qcBxYdRsYEYDzs5VY4VAZBvY7/yhRdx99Ys32WG5XFct65z
 ZHf6P4uc59La5Y1VRcxgosdDNqng+z8I6X2EyXaUGVIa3Z1wFVUH8MmN7ZYtklVZYs
 iLmQgirGgthpP+QAk6FbvyYusy/2AFKGDb0GiQNW7uBot2CIAElgk5imnaxGUsvkaJ
 gIbZNkcqz88nY+BVF/TfjqlDOZaRI7BQS3jLz/HqC7LizHh+hRzlDuR7yc9a+L4FNN
 fseh/k9KOUFug==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:29 +0000
Subject: [PATCH v2 6/8] clk: spacemit: k3: add CPU PLL rate tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-6-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8345; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Tp6ghLSZW6DxaDVewRYtNBOtIgfIO3pF2UzP0xX8XtQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs502/YYr8Wnp6MuyD3r9LFiETPLYtsrwe/tCH
 IaMqYMRVwiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdNhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3Hmw//fB0FPgLNJ4b+oBrm2y81PYXXysQD+OO8LXuiW40l3bqOeydYanrOO
 7Hn1fAL9TPeKs7ZlyMfSOdgBAJ6R+eL7vS5LBJkgHxdGKEg+63KdS0CIePUXHCjKYGNsCxw5PHk
 +RDgNfqVAw2QstHb3649Awsd9NjacNEwIIWXtGlFH2kqxB2J266WzOhIx1UMx5JxJN0SaAymxbE
 r28Xq2JmLtufMTOGPN1OKH5IL8f1SjVkQDTTfjxk78r5BLXDY2W32RTIla66QTUgG3o4Akbf+eY
 EgaSsB0YqzWEcCQY1AtC0SEKD7iIwub4kDqA+8x8TqNLter2RO+YLgfvCz1kdnyhxKKwC6Jf9il
 JhRmPa/wojyB8LAmB0AM+7KSgVQw4f24Bv2Cquyr43Yq8uPedMaKzxO1X5wk+GCL6OnBtEKT+bT
 a1Ku/aPAG22I4a6HCyImccZ+tSCk83Aakkmu+NWwv98RUmaJJroPVv/obIu0expc0Bgsf1N9QoT
 7ZAzRGcE0Zdml169So04jVbccw35iaxU3DYFJovKmv/i5Kngwdg4WnxXvpHJmd2KjEbQFK6Ek/K
 Z55eXeaBEEZPJPcC1vIkeUrLmQI51tapUCGKujtKXeeanwF/ozlxdb/jGGdqh45DhZwI8tdz/W7
 4QMKEZK0kC0ptRqXtGxFjzVyee0OGI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream Linux:
  d558af8ee0bb ("clk: spacemit: k3: add CPU PLL rate tables")

The K3 CPU PLL rate tables currently describe only one rate per PLL,
although the hardware supports a wider range.

PLL3 and PLL4 support rates from 1.05 to 2.4 GHz, while PLL5 and PLL8
support rates from 1.05 to 2 GHz. Populate the tables with every
supported rate in 50 MHz steps.

Recent newer vendor FSBL release switch PLL3 and PLL4 to 2 GHz from
2.2 GHz. Since the clock driver does not recognize this setting,
during the probe stage, the PLL clock will treat it as an unknown
configuration and attempts to disable and reconfigure. PLL3 is critical
clock that drives the boot CPU at this point, so disabling it causes
U-Boot to hang while probing the serial console clock.

Add the complete clock tables so that the clock driver recognizes and
preserves the settings established by the FSBL.

Link: https://patch.msgid.link/20260907-k3-pll5-pll8-1800mhz-v5-1-5cc96d716b0a@linux.spacemit.com
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk-k3.c | 92 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/clk/spacemit/clk-k3.c b/drivers/clk/spacemit/clk-k3.c
index 1ac64aec6ba..3191654ea72 100644
--- a/drivers/clk/spacemit/clk-k3.c
+++ b/drivers/clk/spacemit/clk-k3.c
@@ -46,14 +46,87 @@ static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
 };
 
 static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
+	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
+	CCU_PLLA_RATE(2050000000UL, 0x0b2a2d55, 0x00005500, 0xa0558686),
+	CCU_PLLA_RATE(2100000000UL, 0x0b2b3000, 0x00000000, 0xa0558787),
+	CCU_PLLA_RATE(2150000000UL, 0x0b2c32aa, 0x0000ab00, 0xa0558787),
 	CCU_PLLA_RATE(2200000000UL, 0x0b2d3555, 0x00005500, 0xa0558787),
+	CCU_PLLA_RATE(2250000000UL, 0x0b2e3800, 0x00000000, 0xa0558888),
+	CCU_PLLA_RATE(2300000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0558888),
+	CCU_PLLA_RATE(2350000000UL, 0x0b303d55, 0x00005500, 0xa0558888),
+	CCU_PLLA_RATE(2400000000UL, 0x0b320000, 0x00000000, 0xa0558989),
 };
 
 static const struct ccu_pll_rate_tbl pll4_rate_tbl[] = {
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
+	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
+	CCU_PLLA_RATE(2050000000UL, 0x0b2a2d55, 0x00005500, 0xa0558686),
+	CCU_PLLA_RATE(2100000000UL, 0x0b2b3000, 0x00000000, 0xa0558787),
+	CCU_PLLA_RATE(2150000000UL, 0x0b2c32aa, 0x0000ab00, 0xa0558787),
 	CCU_PLLA_RATE(2200000000UL, 0x0b2d3555, 0x00005500, 0xa0558787),
+	CCU_PLLA_RATE(2250000000UL, 0x0b2e3800, 0x00000000, 0xa0558888),
+	CCU_PLLA_RATE(2300000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0558888),
+	CCU_PLLA_RATE(2350000000UL, 0x0b303d55, 0x00005500, 0xa0558888),
+	CCU_PLLA_RATE(2400000000UL, 0x0b320000, 0x00000000, 0xa0558989),
 };
 
 static const struct ccu_pll_rate_tbl pll5_rate_tbl[] = {
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 
@@ -66,6 +139,25 @@ static const struct ccu_pll_rate_tbl pll7_rate_tbl[] = {
 };
 
 static const struct ccu_pll_rate_tbl pll8_rate_tbl[] = {
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 

-- 
2.55.0

