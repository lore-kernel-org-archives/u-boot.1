Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E63CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839CA831BB;
	Wed, 27 Aug 2025 16:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="eHoMHLqx";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="0UrNxcB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AE083145; Wed, 27 Aug 2025 01:20:47 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625498311B
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 01:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756250306; bh=5jTG3YXoYAedDenYJKVCqpe
 QDUure1JZ8cLrktAVjo8=; b=eHoMHLqxN5svCBaYWtXN/H0701sJMmYWnDGwUh7AkMssazx1fI
 dOn4OChLresfEmXVswsLqTpsFaVR5q+s9Z5U7HMDCDcePqr2I/6GwTz5K6DLgdUJQeHRf+YObgB
 oDchnbZ45hP/p3j8lXlXfc6Ld85QAZaroxkFoqRTYk4liODaVSQUlFoHqtlvQKsvljvZ1zjfa6m
 ljdJ1ils06HSKvbade8NyBEBUaMAKl+gCM1hBXXKyvtbrcdMJWOWgdB4r1J1DVNdDO+t8CHWB8k
 GFctysMO+0azEj1/oc7FBXgVnrRXFFDAS5cHX1dsIlwFVr9fYYvjAaIrHYXK/OMKfOw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756250306; bh=5jTG3YXoYAedDenYJKVCqpe
 QDUure1JZ8cLrktAVjo8=; b=0UrNxcB/Bp3Bfz9SCP2HcXOqUN9WEcwydNeOOu+6fXi7Tec/Wq
 JmQcKKFaV5RLaMPrFAYbugra69xBy/nMy0Cw==;
From: Jens Reidel <adrian@mainlining.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>, Jens Reidel <adrian@mainlining.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH] clk/stub: add sc7180-rpmh clock
Date: Wed, 27 Aug 2025 01:17:52 +0200
Message-ID: <20250826231752.60633-1-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

Stub the RPMh clock controller on SC7180.

Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b..23670c2f442 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -51,6 +51,7 @@ static struct clk_ops stub_clk_ops = {
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
+	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
-- 
2.51.0

