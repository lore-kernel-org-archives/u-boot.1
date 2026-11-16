Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C150606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HED4twEc;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AF352QYv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67531810D3;
	Mon, 16 Nov 2026 17:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ssDiHDIDMcxb; Mon, 16 Nov 2026 17:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB5E981104
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850581;
	b=TO8YY5O6h30G7qYk+gN+8E7+Y+lm4wPipiZ6W10Re+Yb+9N7SWrK9DZuY8bwAXbFrqaj
	 rSp4fsbTQOedB7R/R9oAAfjb/U7KYm0pjltKy5LKBZsiIxGbC9K3uRyGguDtL3o8IMxUN
	 om+GoFQMUzFn0szJAQJTakVWOLdR3QHnOGoat2j4jjcQijqegrTzaYMEvXfjAehMGMk9G
	 SNI+GAVKtDT+4uJUMZiJuyWZuwPgmfwfkz883dMjy1PhQLxIUtnJni9Va7lYwgdadO1Ow
	 +S7BcDTV4oedAPB6YZu8Tcp6uo63xcb+H/4tWUUN4Scd1bnqyaKkuBGj0VJWHRkCJ0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hYQaCu7QYXWUONJxGhfqK2FRV5hLkOjvGKWxZ6+wFBs=;
	b=NtjeWXhsn8HYXuxN7qbXoqnK5hrHdWUSKcorzMEODnam1NR6kUFAAdT/A9F1kyCT63ts
	 5bAZ0PBifqSPJxhJK22aNEzxbeD3qHS+k2eRufpIz6+mQNciJmRjEu1UB2IHNifNO+sQw
	 EduDY+O1tsAh+pGdfOEjIFdQJpqH3Ow6lkmtRrpOAer6oSXFwTFY+qvP9Svk+bncxsOoc
	 HpS4T9NUMnzsAKKctkNvrLUGw/niituurS0bgKMjnbnnVVNlzEJY/X/9RTD7bGyXheV7Q
	 mQ0lAt6wAX+3BqvZcfGYjQMEjhLjEpJHsZjUVbXI6w+OEzKSupI4uN5SzBiRPQGeVug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AF352QYv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850581;
	bh=hYQaCu7QYXWUONJxGhfqK2FRV5hLkOjvGKWxZ6+wFBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HED4twEcfkPv35Rh4JYBjijhWpxuf6ytKkPgPElInM3HD7UdcDIwrg19a1L+scHmn
	 BUH9yLf69YrF9PKpVH4Iy6FhLG8GaKhcmw+yb+PiF4oFKeeHrMB+N+J/72jFMQIM9M
	 l45FkqWV2rrEhUMsLZsNj9VXM9NtRaCO8URwnAe461l1DqKFN7M+3eZxVKDoDIN5xu
	 cZZnC/m+7uu+QsK95tjtbCeEaVorQ46VD7ZZBhEPbq7uz3e56s3okSP/N173gURcVI
	 a6jMosAAVunfaZpVdtRoGKOjZT5Z8EKJnvkVuw6ngLDs8+F0EWmG40zQFLYagvV1gv
	 SQ+ydgJaN+TOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB5E981104;
	Mon, 16 Nov 2026 17:36:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3686628C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 195A28107F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id na-ys9kamurJ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C85380EED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=AF352QYv
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C85380EED
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw4v2j1JzMlvl;
 Mon, 16 Nov 2026 18:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYQaCu7QYXWUONJxGhfqK2FRV5hLkOjvGKWxZ6+wFBs=;
 b=AF352QYvmEiCKt1sp/oxmdHHMkXBmPzSUrSTYiGtrWFxkkBBUUW02NkIdGgSaZcnsgSdQv
 pEzunL6wSODhmku/a5LgM3yg152SsMaEx+ubupLsq1PuOE+DNcjyUC/x8wZyCgoNK6CsC6
 tptvRZdlUF4jRqhuqwv3bqAESNkPJfBqNLxLjVowRAmIQGoIAgKgLquCG+2mIgf2vPzwg6
 59JIZAZuPNg35LfzNmIRppZ0iUh293EnBIoWLBE63veQpk5JHhFO5wNfsdb7Aw8H0u8OX+
 UpqUDHJaVoGH85RxggYceck8RiyH0oIrtJU8cuw7AS1P3PKkO+SXQTJNpe9JJQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 13/20] clk: stm32f: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:52 +0100
Message-ID: <20261116173546.3487841-13-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 047f5978f87346a2067
X-MBO-RS-META: f3unuuybg51d33yjen51y5mk3i8ut7tp
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/clk/stm32/clk-stm32f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index fceb3c44b94..0964e0b1617 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -717,7 +717,7 @@ static int stm32_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 	return 0;
 }
 
-static struct clk_ops stm32_clk_ops = {
+static const struct clk_ops stm32_clk_ops = {
 	.of_xlate	= stm32_clk_of_xlate,
 	.enable		= stm32_clk_enable,
 	.get_rate	= stm32_clk_get_rate,
-- 
2.53.0

