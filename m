Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B0FC25B10
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 07:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599EB88AC0;
	Fri,  3 May 2024 09:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Z5EZj2E1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AAF288AB5; Fri,  3 May 2024 09:20:21 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED3F889B3
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 11AA01487CC4; Fri,  3 May 2024 09:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1714720817; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=3vJ6Qozv5cRkWipo4jL+3pJQJPo+KFLYRe2kLNrwC8Q=;
 b=Z5EZj2E1eTbY4cHbseizIR7tKDdk6NvSB502SbEj+hjTprgis7Rair1z9WWt0JpPPghda4
 ZVNH0yxu55DO/+593GlT+FJYF6OtTWu1u8QMI9B0I61NTXaKYAVR/Ddu/BXQzVhcivCBOp
 9oFxnAJjzBS/ZTqf/14cYIQujFvoOzwy9V8xQtLGq6IWb95rt6sa4rLNGm8PmeM8TsWLwi
 bceqw6+h+cO73PQXeKlm4ASD4L3TBk5wl0WGVLP155vc8ylxB0kp+lm2Cef34tDIMSF/Qt
 IuPJIc7QKwyVGvmK835deMiRjciR96ytzRSRoNjERJBwaQBwI3nFUlEwFsdOcg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] clk: Revise help text for clk_get_parent_rate()
Date: Fri,  3 May 2024 09:20:09 +0200
Message-Id: <20240503072009.11602-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

Notes:
    v2:
    - Collected tags

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

base-commit: c92d48f8b2909d08584f17612a23d959467f14b8
-- 
2.39.2

