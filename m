Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5696AC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 12:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 751C9863D3;
	Fri, 23 Feb 2024 13:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="vKLfi9hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E816878E9; Fri, 23 Feb 2024 13:01:32 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB887807EC
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 13:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1708689683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=rPJbOzN4YPFcDA0DSnbYrAo8u2tbcDVjN6v6k23oc6M=;
 b=vKLfi9hnRmA2mVIkJztns27b/lSUz9fUu/7JaSryWG50GvENjuhqUVD0uz8RE3MVVfplgi
 3FOS9wbh5HRNph0ghqfQeDXZpo6aLnDGaneWCd3DoIPZnHn0Oy9YO8+KWxlL863jaVdrnH
 uvAmnI16cnUZ3kFKQu6WcYhmu2camo3KhsS/5cbIWyWenKSdry5YZNz0uJ/T02McNcSeQ3
 XCTzzrvw4WIpSIE75zrEoobTeNUseedqO+9e1I+ehQ3z60SqldwQp0ztRwXyhtSsrVmiAc
 5jlh4W5fmsqGXW6CwMoBbKntrQv46mny/qcilA+MeAJ0TjmsjIfGYw6ZtMouKA==
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: Revise help text for clk_get_parent_rate()
Date: Fri, 23 Feb 2024 13:01:20 +0100
Message-Id: <20240223120120.1605788-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
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

The function returns the rate of the parent clock, the previous text
made no sense at all.

Fixes: 4aa78300a025 ("dm: clk: Define clk_get_parent_rate() for clk operations")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 include/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/clk.h b/include/clk.h
index af23e4f3475..045e923a529 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -444,7 +444,7 @@ ulong clk_get_rate(struct clk *clk);
 struct clk *clk_get_parent(struct clk *clk);
 
 /**
- * clk_get_parent_rate() - Get parent of current clock rate.
+ * clk_get_parent_rate() - Get rate of current clock's parent.
  * @clk:	A clock struct that was previously successfully requested by
  *		clk_request/get_by_*().
  *

base-commit: 7bb761c42d75b2ebacc7190a76cc5385cbba1045
-- 
2.39.2

