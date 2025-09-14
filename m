Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B6CAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5747A83443;
	Sun, 14 Sep 2025 15:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="B8KAI7Fo";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3TJn6yVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AC482A9E; Sun, 14 Sep 2025 11:47:50 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C898480B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 11:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842980; bh=lc/mWaP45tIWC3PfxiScKTn
 9TxhugPetulZ670C0O4I=; b=B8KAI7Fo98b9BWlyy6Z9/9TRjBU7CIX2wZ2wCnIMVgFJqjuKLP
 G6RQbJUvp6UO45EEjUK04TgO10yZhWkTYz5Ilkd6PCVuhAGIJtffSjUgsJmkXvNSF7BgoJrCLAE
 wQajhV6RG8LDlbcJNkzVkM55J5YpOgergof4k9/Y8eCJwSmTi5DCl9WOFbZgBpz3nRZMnTPJOva
 tUI/n3x4M+zntWnI42TigtyAf/GDKc9IqZwGrVcP6r7lWKL+7cGWFeKvMT+SIEmGCWzx2ptARqV
 zdYnblQ7ynR32jjNhgNBQlGPAWWvNe5xuDE5S1h3Xodmrr3XWgy8Ff4By228kwZpl8g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842980; bh=lc/mWaP45tIWC3PfxiScKTn
 9TxhugPetulZ670C0O4I=; b=3TJn6yVlv0aO+I5b6diCaaA/fLG5L3LEgrW5r+01CDbxs+u2yY
 /Z9nvBpEtMk7281xcdg0NlfkQKjJPEW4DtAQ==;
From: David Wronek <david.wronek@mainlining.org>
Date: Sun, 14 Sep 2025 11:42:32 +0200
Subject: [PATCH 1/5] clk/stub: add sdm670 rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-sdm670-v1-1-a344024062ab@mainlining.org>
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
In-Reply-To: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757842979; l=747;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=GB5dSxWooY8EBTrATPHHHyo07ya0tjd4NNx/me0BmMo=;
 b=61bbD54NXBDdyeP3zK8NDU79JIwS9gE9JNKVh+NxNdmpo2s+xkaXjhsxVjCZW1Ory3Mi/kYfq
 5RahBI8me93Cp4RRLaBZdVhqRLqZJHnKd+Siy+Up0kO1jRiNDFoUp3T
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Necessary for MMC to successfully probe all clocks.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b322537f070a740bf1f80531006036..d02107ff32a7a8920e352e53b2dc21805a010d04 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sdm670-rpmh-clk" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },

-- 
2.51.0

