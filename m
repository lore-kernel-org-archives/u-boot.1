Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73B606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eoGDVT3/;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=COkGc4ge
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06EF38113C;
	Mon, 16 Nov 2026 17:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c_NJoZH6s2H3; Mon, 16 Nov 2026 17:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D95368114B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850589;
	b=fHMGKBRnuwaXfWaqL3Wgd6fvHRsw+wIJVvYoLzsd82YOYLeqfJs2Vsdn5UlSNN87H71E
	 JdwaAEvp2WY8zcydV2sBkxq2qW8dGscxB3k6KaZRnGBT61TBmCDQrCGpq0uc7D3NVhcSy
	 gdhbOKpK7RTG5DyEXNmXAXytcK1b+NEGaJoYrzrcyvqQLmL4dw3rorqnl7TAEkoborxjX
	 nO2LX7ju/u+dc4sieaMafWiEpKsWS9/EIvvagK9DesLSYUjWHcJzZyycPHR/HHtGT71JS
	 M+S4mccaMMqlrfwKjZ2J3hBJXnDKi7F6jXQO11hR3/lpJ4VyBv/B3l6qlo+Kh7XoqvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c7lroTC4DeDFGy7fpq1LbrQZ0X5zl1ncMHIP9Awf93M=;
	b=UZBNPJquuEgZro7WNLv0+U4WwdDRcFoNy6E2VCrJMtf8w0EBqZpDSvFZ9FNfXL6ca9DS
	 99a4MMXRZOy6KkxM0rHjigf9LUiC34knPvEOoQbkgtcoctY4Cf64CxkzXcUTrykBkSRHE
	 1hPTnIiMR5oH7UPi/KTYS5mk1jBaFH0FrspbKQMGFNiilqGl79+0fYjTCO6s4/32enkwb
	 nze41Dti1QgmZhd/uLlkZPRptf9BmbmtCXdCNX1wyTWOFVELhuG1y3bq0mYA3TcCDVA5k
	 EdlYqAmflaX4CdKzlCiqv9sdHryJ58p26dtXJnRMF/+EfT4RrCHIEFSqUHakpj5VDhg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850589;
	bh=c7lroTC4DeDFGy7fpq1LbrQZ0X5zl1ncMHIP9Awf93M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eoGDVT3/1t3Af9D1zfOA6wUJnsky7ZUUkOiGXHlaf8WEUPjZl5jE0XABS5UFvzl8v
	 VVnKkQuIuMN9MUKJEzRCa5u9cnJmZhPYIDKFqYlzzimC4OE3INeY4Jv7Yvq5XI/lsl
	 cwWFXM8mMrQLVMEorvdKBCwAzLulQmiN0cl2SZJepO2zvL3GJr9KyilpogS6GGIzN4
	 A4ToOosrkg6xJFvz2q0e5ZdzewlswYzCdM3OfIHxlDRYBD0yh3FFfwicGHZKD7g54U
	 YE0DolGzGzuOGS3qDLF2ssqrsI2D0l/yGgpCSLziXjNb8MmXw4N6vQrjoecBnKGn/y
	 Oah93H6KTFWHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D95368114B;
	Mon, 16 Nov 2026 17:36:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E3264DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40351402BB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sD3eR2fPj7MQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5DAE9402CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=COkGc4ge
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DAE9402CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSw4x21Jkz8vC3;
 Mon, 16 Nov 2026 18:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7lroTC4DeDFGy7fpq1LbrQZ0X5zl1ncMHIP9Awf93M=;
 b=COkGc4geO3tfI6AQpUWsI9ESWWGMenOlTlEZTpreC9uPpR5D4z7ZsumxOqZIaznHZH3/Fe
 yfh9U/TsDDBEWSUjnicBlu7KTBU03Bn7gH4H9dkyyIIFwsUrcJumxaJqIm5pZIUkNGMh5K
 o8kTLAs2FNerI876FB4/V9eVH4mtQu7ZJDygSnS+/4GcAtMCGMYBDaztgx4u8cfOKToYIS
 ngtIFqbA3vwI9/tjJrEAjx2qww5KeUAfeH50PpSRJwjDZqTnDkOwDx+Q42JBxZFFkXUiAd
 kkY7+aAX6CjwIL6++A+9nf6NPKnfhD0amWZ4XSIdb2ocoGsTRXN3P4yf0gBU5A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/20] clk: ti: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:55 +0100
Message-ID: <20261116173546.3487841-16-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b99f45710c644f704db
X-MBO-RS-META: 7neapwi8hax8p7zyykd3hrwctabbz3u3
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/ti/clk-ctrl.c | 2 +-
 drivers/clk/ti/clk-gate.c | 2 +-
 drivers/clk/ti/clk-mux.c  | 2 +-
 drivers/clk/ti/clk-sci.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
index e3564277982..3feac53a7ff 100644
--- a/drivers/clk/ti/clk-ctrl.c
+++ b/drivers/clk/ti/clk-ctrl.c
@@ -187,7 +187,7 @@ static int clk_ti_ctrl_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops clk_ti_ctrl_ops = {
+static const struct clk_ops clk_ti_ctrl_ops = {
 	.of_xlate = clk_ti_ctrl_of_xlate,
 	.enable = clk_ti_ctrl_enable,
 	.disable = clk_ti_ctrl_disable,
diff --git a/drivers/clk/ti/clk-gate.c b/drivers/clk/ti/clk-gate.c
index 873ceb8a2ab..3159e75a9a8 100644
--- a/drivers/clk/ti/clk-gate.c
+++ b/drivers/clk/ti/clk-gate.c
@@ -73,7 +73,7 @@ static int clk_ti_gate_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops clk_ti_gate_ops = {
+static const struct clk_ops clk_ti_gate_ops = {
 	.enable = clk_ti_gate_enable,
 	.disable = clk_ti_gate_disable,
 };
diff --git a/drivers/clk/ti/clk-mux.c b/drivers/clk/ti/clk-mux.c
index db539341431..007bb7ab120 100644
--- a/drivers/clk/ti/clk-mux.c
+++ b/drivers/clk/ti/clk-mux.c
@@ -171,7 +171,7 @@ static int clk_ti_mux_request(struct clk *clk)
 	return clk_ti_mux_set_parent(clk, parent);
 }
 
-static struct clk_ops clk_ti_mux_ops = {
+static const struct clk_ops clk_ti_mux_ops = {
 	.request = clk_ti_mux_request,
 	.round_rate = clk_ti_mux_round_rate,
 	.get_rate = clk_ti_mux_get_rate,
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index e374bd3bcc2..e16f8d83219 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -196,7 +196,7 @@ static const struct udevice_id ti_sci_clk_of_match[] = {
 	{ /* sentinel */ },
 };
 
-static struct clk_ops ti_sci_clk_ops = {
+static const struct clk_ops ti_sci_clk_ops = {
 	.of_xlate = ti_sci_clk_of_xlate,
 	.get_rate = ti_sci_clk_get_rate,
 	.set_rate = ti_sci_clk_set_rate,
-- 
2.53.0

