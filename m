Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A535C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807D2848D2;
	Mon,  6 Jul 2026 07:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.b="EAxCueEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230D0846B4; Mon,  6 Jul 2026 03:45:20 +0200 (CEST)
Received: from sender4-pp-o96.zoho.com (sender4-pp-o96.zoho.com
 [136.143.188.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08F784105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 03:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhuxu_ran@zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1783302287; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hNjussiNvX9mx77uRK1Q6QVAauFijgoeeTGMtgWIZjSd167ra6l4dXIA29MrdUrW+bPbutFnHwf0WEFGZ981iWpNZIUk1zHJcouLETFmkO97KQpcwaqKu3pNd/oZR1K/In9FdBU71Xm3b6Eot1lUAk6xLwgm7/eU0XQhERH4IV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783302287;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b4zfnsk4WYVWovfGoSyIAhHvjqsskbOGPcUlGWJ9s/4=; 
 b=mdnLeoPR1xLa1Ch4wf+5tH1n2ZYt4O94bRAu8ofs3vBi+Z7U9i0UlMJlEnPaXhQt4mItfTMN/J6usGwzj+TlQzkDY6IzqemQIUVqRY5+ykf+V9s2WNatmLzzICavAoAbuMK4AoBFilxOxXJcf1OPilM8MgTljWWokZ4bq/bVlgo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783302287; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=b4zfnsk4WYVWovfGoSyIAhHvjqsskbOGPcUlGWJ9s/4=;
 b=EAxCueEQEnhIggfry2JcH49r19ExczbrmqFvvGWTZ0r7A44ic7CLMOwLvciLjQIP
 g4/8Y1tTncvoG2nC6I8vFFEnEfdgltq8VdGmsQ9ElDnL9xDnAwUhe36nI1WQmgAKvrw
 g03AteAj0mWovvyVOhlb6nKUTyRwUsBjjCVJGOKc=
Received: by mx.zohomail.com with SMTPS id 1783302285612341.7313985971492;
 Sun, 5 Jul 2026 18:44:45 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 06 Jul 2026 09:43:41 +0800
Subject: [PATCH 1/3] clk: sophgo: cv1800b: Add cv1800b clock compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-milkv-duo-upstream-dts-v1-1-8d010ddda7ca@zohomail.com>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227071c2b34ba4a8f38c47b704f000022b7e5b74b69e834fe1348a8b740a8fe4c3dd99502b6bb78a7:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The upstream CV1800B devicetree uses "sophgo,cv1800b-clk" for
the clock controller. Add this compatible to the existing CV1800B
clock driver so it can bind when the board uses CONFIG_OF_UPSTREAM.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index d946ea57a46..9cfc1153f2a 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -741,6 +741,7 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800-clk" },
+	{ .compatible = "sophgo,cv1800b-clk" },
 	{ },
 };
 

-- 
2.55.0

