Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E7606A31D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YTefiiQ1;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=u5ff06I5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37AA780D17;
	Mon, 23 Nov 2026 01:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98WCXZXzs3r5; Mon, 23 Nov 2026 01:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 858BA80D2B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795396563;
	b=SXqqnMGaVudM6yZhsZFuoLRH4oO+T67I3E0ExsfpmVsc8m3SJSgbk05dU92W5XahbuAY
	 e7OQpjrjvkf6EX6XBUcik8YtfcjLmA0EKs317A6XQbUO302qFE7q7WYKAJm69isq+eIZp
	 I/dzHh0rQDq2yxWDZR5JsQwVaESo/Gf4G7kxIcvR3/EL6wkVuKMjGkH1VtyUgSWjh1kle
	 jWEsfhZ+3uVtjFMQR37pWREtHHoDYGUUsEhwaYPae4xoJ+rappNbD27HlAv+EK+oyFHII
	 1mliaYyoHwQHub+Wxj1B7CVlW8YgW3VlVytoM0wbaxIVyHnAIkCdKGAattUnRm+EJbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795396563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xtlSslIv8yyKofUr6fezJE3hB+sqQhvOYjegQ+KxQ18=;
	b=IFkMJnmnBoQePUUnV6sjX1vKrq95/h88WDH3z6j1VkIFlIKTKDwoC608SbgYnzZrTTRP
	 FWcDEVIEFaa4Ahygo/SnNbmLo6wa7wo6qzKmWfzyRQCP3egrbq8S/a0TqAKJ/tn11PFWk
	 Dk9rnYKa0wShCGaHu0+Hi3YTIN1HbwIe4fNWY4h7aOru/iU2kbMsRqwAjORSUpZEY5+WU
	 91+muw3++NadSf0b3c3/Bu7NM/vrT4zeF0sYxlS5C4u/SJnFH/39m64F8HQAHOg6PrD2r
	 RT1tRzURZbX7SyuUeSnag0bjA278c75I9GbQLAdFpXwMQ7lmLNcmh8D0VFBTem4QIcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795396563;
	bh=xtlSslIv8yyKofUr6fezJE3hB+sqQhvOYjegQ+KxQ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTefiiQ1dah9fWCJ+oUM9/ak79HKrWeNKglHmo74/qEHQdejXEd04U4A5tiUa2bUI
	 M9zCeGypUfo0Y1KWBHaJa9fYFU3n14yB2FSOh/Wn3VynR9TR2kY8TY4hcUYTrK8XGB
	 puMuG1Fy4SRV1tdYKOFRAStSXaeZ1CyiFYFQRpcTOSbITov8LEAm+GuCxjCrMqh2Q1
	 qOkjGoc89GQvXDJCkGCSPLrFz59E+uCr5kXBmshu8SuZsSf7uNI5Ubwz3panZgCE41
	 SCYjAcE9MWKiVgcOLb+hS2hj/C5t55Wzt3tmyCGZi/Ehf1v2DXIDmDg32t8IRergvO
	 nVrTsOjxroEQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 858BA80D2B;
	Mon, 23 Nov 2026 01:16:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CBF9260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECEBE405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4wjpS4bF430 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 01:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B42D9405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=u5ff06I5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B42D9405AE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:15:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F501841F2; Mon, 23 Nov 2026 02:15:56 +0100 (CET)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AD084409
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 02:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=d-silva.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alastair@d-silva.org
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id BB7D642712;
 Mon, 23 Nov 2026 12:15:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795396540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtlSslIv8yyKofUr6fezJE3hB+sqQhvOYjegQ+KxQ18=;
 b=u5ff06I5ROBOg4cQRnyNz/DLf0k0Lqn0Am3zTaHxjO+RpBPfxZ6PNO8TWfd+2JLDIzs4bP
 jEk+sJKCziDo0GV/B9UzwUTpIkHt5GFMwxyS9cXZenSXEU4yIri68MdN/AkVAmRl0/0+Kz
 8usZsHhP8jy915oDA+5DAULbILcUL/0PZYllL4lwXJ5t7v8/hfSJMu/Zf48tRoIH9fPPjl
 LksRJrH9eH+eRyT8TqE1R75vIsE69l8kB6/84a6ANdntG9suvdPDSX6+nCQ1TTvKx8dKxH
 Il3CPk+spBSx2CP9sKVez8HB/+Lp4Oe1myeO3wd99tHQ5jI3POJkjKgcFdP6wQ==
X-GPT-Reason: This email is classified as personal/technical communication.
 The content is a technical software patch description (Linux kernel/driver
 style) that perfectly aligns with the mailbox's owner (alastair@d-silva.org)
 and the sender's identity (alastair@d-silva.org). There are no
 signs of marketing, phishing, or urgency; the message contains specific
 technical details regarding voltage masks and bitwise operations,
 and the From/Return-Path domains are consistent and authenticated
 by the personal domain.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 1/3] power: regulator: axp: Fix AXP318W ELDO voltage mask
Date: Mon, 23 Nov 2026 12:15:32 +1100
Message-ID: <20261123011534.1692975-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123011534.1692975-1-alastair@d-silva.org>
References: <20261123011534.1692975-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On AXP318W, ELDO1-ELDO6 span 500 mV to 1500 mV in 25 mV steps.
This 41-step range (selectors 0x00 to 0x28) requires a 6-bit mask (0x3f).

The current 5-bit mask (0x1f) breaks voltages above 1275 mV.
axp_regulator_get_value() masks out bit 5, reporting 1300-1500 mV as
500-700 mV.
axp_regulator_set_value() only clears bits [4:0], leaving bit 5 stuck
high when lowering a rail.

Update the ELDO1-ELDO6 voltage mask to 0x3f in axp318_regulators[].

Fixes: 71f07932756f ("power: regulator: add AXP318W support")
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/regulator/axp_regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index 16d3a8f7f90..e425f3bf8b2 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -227,12 +227,12 @@ static const struct axp_regulator_plat axp318_regulators[] = {
 	{  "dldo4", 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
 	{  "dldo5", 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
 	{  "dldo6", 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
-	{  "eldo1", 0x22, BIT(6), 0x3a, 0x1f,  500, 1500,  25, NA },
-	{  "eldo2", 0x22, BIT(7), 0x3b, 0x1f,  500, 1500,  25, NA },
-	{  "eldo3", 0x23, BIT(0), 0x3c, 0x1f,  500, 1500,  25, NA },
-	{  "eldo4", 0x23, BIT(1), 0x3d, 0x1f,  500, 1500,  25, NA },
-	{  "eldo5", 0x23, BIT(2), 0x3e, 0x1f,  500, 1500,  25, NA },
-	{  "eldo6", 0x23, BIT(3), 0x3f, 0x1f,  500, 1500,  25, NA },
+	{  "eldo1", 0x22, BIT(6), 0x3a, 0x3f,  500, 1500,  25, NA },
+	{  "eldo2", 0x22, BIT(7), 0x3b, 0x3f,  500, 1500,  25, NA },
+	{  "eldo3", 0x23, BIT(0), 0x3c, 0x3f,  500, 1500,  25, NA },
+	{  "eldo4", 0x23, BIT(1), 0x3d, 0x3f,  500, 1500,  25, NA },
+	{  "eldo5", 0x23, BIT(2), 0x3e, 0x3f,  500, 1500,  25, NA },
+	{  "eldo6", 0x23, BIT(3), 0x3f, 0x3f,  500, 1500,  25, NA },
 	{ "swout1", 0x11, BIT(3),   NA,   NA,   NA,   NA,  NA, NA },
 	{ "swout2", 0x11, BIT(4),   NA,   NA,   NA,   NA,  NA, NA },
 	{ }
-- 
2.53.0

