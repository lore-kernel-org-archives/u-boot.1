Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD53606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PGPbfOKe;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=o0Vp7DzK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D59081005;
	Mon, 16 Nov 2026 17:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6DzdTK06ZVh; Mon, 16 Nov 2026 17:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D3F981016
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850909;
	b=MJ9hLaP34FDOmi3JyApud3nBwTYFcbmQG5f/+Bn3knXCR+uC/+/KKFqmuhz1HxMgqm3X
	 fzGEeKBgZeu6SNlY0mfqfd4aVEdY2W448KUPQxqMSrQbqjEVIwtxLuW5EQYoxfetGOkiq
	 w0AmxZgrQ614uWjEqu9bLrvyT4qaArVgjxbU61hU2JsJ/FX2xmNh4U7OH6KGcromPE564
	 Qwe3HWLQwdW17c5W2MJU4JxjumUCQIG2QpdGXuJmq8F8hmmJQ8Ltpg7pRhCJ4KZRPGzJP
	 4RcOGbnuSYrnLmrwPPvR2SVofsgsTjtLPnYtJCEC9J2PABqQRAAjNJboUOIHsgkAU2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=seszSjf6eYwAos76KBuJhZgJikwKIATyU/APqqFepA0=;
	b=Q0Neszi7IY50MzC7xEwVFerkWBtiTnHZjC5JBhcLlUI56AIQBqHqwvddypdDB7ZCagvu
	 gd2/G7QxgpSftEKnApzq0Nhmz3qpTtC+XojjouNj2wAD33EzgBkVnk7pJVwxjp0cVER5R
	 dzyQi94P+hgBk3bYutqpZ4giiExMD3H+rrD6I9EEyfc0xPz7AAO05b6roWjfZEYpp8//k
	 V2GQej1m4K/zRR01taOuaQ6kxWXBSNizUhUgDqW4J6fYWP9K5jnQYe7yQbd3De+YNUdlv
	 X7dUYbEqtUPOydujO856kiXu8Mk9g4IoE2SToH4FWyFJ9oWwx6G7lyxLeom1FRKCk0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=o0Vp7DzK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850909;
	bh=seszSjf6eYwAos76KBuJhZgJikwKIATyU/APqqFepA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGPbfOKelOdum8Q37/UIi8J51lmYJnFoSOBwFL+L3WJ3gFi9c9tY2qiWHGlhyQiG+
	 5P2J34C+KEV8gW5wu7QNEvjNFr41Y/H66m4R/0ZYqDKpPjii2V4Nzu1fEB9LH7AfrE
	 MtGMdVSLREPpvoB0aMBvA1D/MhW66W8wG9HEKovWJ1+J9hTk10rE/t3VyS8j88DHdi
	 fI3Mixjx99pypCSbw5CVJPIqx4vvHpb0Bhbewy0vBp4mOugN1a36VHwHpwAzVjA5A8
	 Zr+rAkAeVjLgR9Kg1xat96cJeCJ13wEnP32tD4D0jKxjfox4Ey9f+AXe+o69lj+uo/
	 qlUyqUk+k0jdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D3F981016;
	Mon, 16 Nov 2026 17:41:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58168169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55BBC81016
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5PL10SGYUeuq for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9182381005
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=o0Vp7DzK
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9182381005
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:46 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSwCV6S8FzMlLF;
 Mon, 16 Nov 2026 18:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seszSjf6eYwAos76KBuJhZgJikwKIATyU/APqqFepA0=;
 b=o0Vp7DzK2ijyKNWqIF3MuQtxRg9FcvD6bjuncZ5ahSrI6hPLA8azUCJpw81tWlQWOV23vy
 qf5T06stNqcjptKBXzG1MViynBYis/VrtDF6jZq3V6PjUZkGZNBYYI1XbTKUVi9HxopC1s
 IB0y9RL4nJAAtFlro6xfOBAUqfkT1DIjHXMQMwUuLWPfNBjgq5Ynt36JOHkUr7fgL/lVuz
 U694yjZc3X5/NRTWM0tLB2gl5g1OHi095BAAxnUlApM3nXsPfLF0SIeDi0a+kfybTELjjq
 uJmzB/XuTvWzdk/oMOX6eHUS7oTk7TTCGKC/wo8CD4G1/LrTmTpaNmsVQXgM/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] power: domain: Constify driver ops
Date: Mon, 16 Nov 2026 18:41:24 +0100
Message-ID: <20261116174138.3488177-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 81cbecc4f121e88fe3f
X-MBO-RS-META: faaw4ibu84judyofd3te5kbezfymdifc
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/domain/altr-pmgr-agilex5.c   | 2 +-
 drivers/power/domain/ti-omap-prm.c         | 2 +-
 drivers/power/domain/ti-power-domain.c     | 2 +-
 drivers/power/domain/ti-sci-power-domain.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/altr-pmgr-agilex5.c b/drivers/power/domain/altr-pmgr-agilex5.c
index 257e8b234fd..a0e076f3cac 100644
--- a/drivers/power/domain/altr-pmgr-agilex5.c
+++ b/drivers/power/domain/altr-pmgr-agilex5.c
@@ -98,7 +98,7 @@ static const struct udevice_id altera_pmgr_ids[] = {
 	{ /* sentinel */ }
 };
 
-static struct power_domain_ops altera_pmgr_ops = {
+static const struct power_domain_ops altera_pmgr_ops = {
 	.off = altera_pmgr_off,
 };
 
diff --git a/drivers/power/domain/ti-omap-prm.c b/drivers/power/domain/ti-omap-prm.c
index c240e2682ea..c50ee66f03e 100644
--- a/drivers/power/domain/ti-omap-prm.c
+++ b/drivers/power/domain/ti-omap-prm.c
@@ -24,7 +24,7 @@ static const struct udevice_id ti_omap_prm_ids[] = {
 	{ }
 };
 
-static struct power_domain_ops ti_omap_prm_ops = {
+static const struct power_domain_ops ti_omap_prm_ops = {
 	.of_xlate = ti_omap_prm_xlate,
 };
 
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index a554e659392..0905bc5a195 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -397,7 +397,7 @@ static const struct udevice_id ti_power_domain_of_match[] = {
 	{ /* sentinel */ }
 };
 
-static struct power_domain_ops ti_power_domain_ops = {
+static const struct power_domain_ops ti_power_domain_ops = {
 	.on = ti_power_domain_on,
 	.off = ti_power_domain_off,
 	.of_xlate = ti_power_domain_of_xlate,
diff --git a/drivers/power/domain/ti-sci-power-domain.c b/drivers/power/domain/ti-sci-power-domain.c
index 0a9f498b97b..5c5ac2db552 100644
--- a/drivers/power/domain/ti-sci-power-domain.c
+++ b/drivers/power/domain/ti-sci-power-domain.c
@@ -109,7 +109,7 @@ static const struct udevice_id ti_sci_power_domain_of_match[] = {
 	{ /* sentinel */ }
 };
 
-static struct power_domain_ops ti_sci_power_domain_ops = {
+static const struct power_domain_ops ti_sci_power_domain_ops = {
 	.on = ti_sci_power_domain_on,
 	.off = ti_sci_power_domain_off,
 	.of_xlate = ti_sci_power_domain_of_xlate,
-- 
2.53.0

