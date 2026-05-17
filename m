Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCDFCD4F47
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 18:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B39845E3;
	Sun, 17 May 2026 20:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rtPbv4+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A988460E; Sun, 17 May 2026 11:35:53 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFE88466F
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 11:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39378db197aso16558841fa.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779010549; x=1779615349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A0d8wVwI6RKTHFFEkTUad71DHw3uLY8Pzlk8ofrLWEw=;
 b=rtPbv4+I0AUi/nCc4vRMDzatwJDcf6ILyLVkTkpEaawct20KZ1QcLvZW05Z6UfEmhu
 hHpxbnIuJTJa1pFbfOn1xIpC7dn5IWJ2V9a3g8qJeYOHt0X1twBGE/GDFctQXcaEQsNP
 woQ6ByvOSyihIJUU0TaJ6yT13b2yyil3K9CNPjcYIUFnpF9JomeWbuz33ims4I859IqH
 geCsMX2nHsWwbbi+2fdhLUGqrYH7Zvadi2y7z0tU6EifAPEFfK6Jb9080V4yttph3VJB
 bwKuD6wXnnlr0wyoopRmvL8/KQsJ2l1+Q8bFOtSMEnX/gFNgwA1NcUJTvrocQCSj54aF
 aolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779010549; x=1779615349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0d8wVwI6RKTHFFEkTUad71DHw3uLY8Pzlk8ofrLWEw=;
 b=X40JmDRyhdC2/mQMIl1uKd/mVbT7ZhVmy2ntTrPDFrRHownUU5zX03lNK95kPQL0wD
 tXifhAQFTr3woJelq7xmhpSYYRuUta/kX9y+IYpaiRSXT9+fJQje2tPqNbbBsKb+d32E
 LqGbJI+Uf1SGPu7Q7kUYD0VgZamE8qhdoVltOg104iASyMSW2ObRbhrewN9VFTu16JxV
 CqQamxggyt7ii+SH43YLJHAs96lhpz3NevdmW126XhPk/blaNgR1Y9lZSdJ2ZPbGePZT
 ZndY75rFic9e5FXR2ZntZAY0bspvJqLosjUFF/ESIwRaZKoLZb6tBWvd/HwZyYruWTx7
 aOiw==
X-Gm-Message-State: AOJu0YyO7CkpoILmZptQeKYtLuq5o5XhfujmmSikPbg/I/O8I0FHA+pf
 580A7gI3pM5U+UQvD/8LYbaSH65hIFaSfFxGHjxI6i47PXdoTiDGFTPdG1SsYNVA
X-Gm-Gg: Acq92OEOxt0wZFj4+Rr5J+14y7a43rYFIIuMdSj1qcFsmivp3Sgz+Hw370qudi80OGc
 aAoxk/icnaJT6422kK7am79NC1IPMDgzE/oUH+pGvW+IeKFy8kHnq73N9iSCNDJFcRI57uwuaZ3
 wYQbbaRJKTYWXyp2JLPvd5vVZpaxgCO4wvtv9lBFcUsGR5d8zJ/4MamXCV22etP8rllWBBwfTSo
 IHn5lT6octZBgd766vTiw3C7n1ZOuoqJsmBp6rtTSB8dLxamWyXt0a0NNf9YtRzB7XWd+MACYC9
 4zeciFakyt0jRwdpvEo5KdF4eMPvqApbKubrrriQ5SKZv0VJTO4iLf3KCeRQwG+M/OVk109abQh
 Uth43ZDYtxS+PpBgDSfl8q6pyKLNeky0WWR0ZkqoIeW9zHUX7ojJBqsp2pI/f+t//dQaCjXIz//
 9/a6kVGDQtQ7vsm3+Up49zYyKdWbtzuI/Z0RNWFMzZglJMxwycL5nSel84
X-Received: by 2002:a05:651c:4184:b0:38b:f632:e0fc with SMTP id
 38308e7fff4ca-39561c076ebmr23336251fa.1.1779010549263; 
 Sun, 17 May 2026 02:35:49 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958874e9casm4061921fa.25.2026.05.17.02.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 02:35:48 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: festevam@gmail.com, brian.ruley@gehealthcare.com, trini@konsulko.com,
 shofiqtest@gmail.com
Subject: [PATCH] clk: imx6q: guard LDB clock init with CONFIG_SPL_BUILD
Date: Sun, 17 May 2026 12:35:47 +0300
Message-ID: <20260517093547.149665-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 17 May 2026 20:14:01 +0200
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

of_assigned_ldb_sels() and imx6q_init_ldb_clks() are called from
imx6q_clk_probe() which runs in SPL. SPL never initialises a display,
so pulling LDB clock selection code into SPL is unnecessary and causes
an SPL SRAM overflow of 112 bytes with the i.MX6Q LDB clock series.

Guard both functions with #if !defined(CONFIG_SPL_BUILD) to exclude
them from the SPL image. IS_ENABLED() cannot guard function definitions
so #if is intentional here. This reduces SPL text by ~688 bytes and
unblocks the patch series CI.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index a4649a1a9d9..379155096e8 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -156,6 +156,7 @@ static struct clk_div_table video_div_table[] = {
 
 static unsigned int share_count_mipi_core_cfg;
 
+#if !defined(CONFIG_SPL_BUILD)
 static void of_assigned_ldb_sels(struct udevice *dev, int *ldb_di0_sel,
 				 int *ldb_di1_sel)
 {
@@ -270,6 +271,7 @@ static void imx6q_init_ldb_clks(struct udevice *dev)
 
 	select_ldb_di_clock_source(ldb_di_clk[0], ldb_di_clk[1]);
 }
+#endif /* !CONFIG_SPL_BUILD */
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -488,7 +490,9 @@ static int imx6q_clk_probe(struct udevice *dev)
 		 * Need to set the clocks now and make them read-only due to a
 		 * hardware bug. Fixed on the i.MX6 QuadPlus
 		 */
+#if !defined(CONFIG_SPL_BUILD)
 		imx6q_init_ldb_clks(dev);
+#endif
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.51.1

