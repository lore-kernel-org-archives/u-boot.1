Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD00CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726E98380F;
	Fri,  3 Oct 2025 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="iNMrW3vu";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="a+oisHSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56E08366F; Fri,  3 Oct 2025 12:02:46 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5FA836B4
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485670; bh=ei5osPSMsNy6t/XsCHHScoB
 CHvSQctlh3uNxMEQhZ3I=; b=iNMrW3vuF6ERfPh6S3LlBJW+J/NTr6Mhss1S9HeyVpQRNowO2e
 whPDHgOgoxAzmdBke7p1tn2HN6pwntYcJ99BaZW+7FsDMz/9FkIV8aZtTKF/S4xl7Z2hpku9Ea8
 UQ+DUVhN530ec7aVq5jWg/Rs5i/eROXo/9sPupeNo+iWpkNX/wupnE0Uq3W6/iWRYEnSshQSpAT
 C29mFID1DdoBhIGaSU51PhhxGzEV0Rzyez1dvnr7BXR8zUD64DeAGKQ98r2oE/eVhz4J2cnYaT9
 Y8IGuCucktHmhfhNePNXURzwZZgPwMXDeIfhAprh1KD9jIxRgF6waeRqny0Oz97xsjw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485670; bh=ei5osPSMsNy6t/XsCHHScoB
 CHvSQctlh3uNxMEQhZ3I=; b=a+oisHSVANXsajxgiua8xjsq5NDIYauATzEApNw2fH0RZ2RrZ9
 ZidI6IgVyb/6T/7i3E01O7mK6qtMo2J/EqBg==;
From: David Wronek <david.wronek@mainlining.org>
Date: Fri, 03 Oct 2025 12:01:09 +0200
Subject: [PATCH v2 1/5] clk/stub: add sdm670 rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-sdm670-v2-1-52c0fa481286@mainlining.org>
References: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
In-Reply-To: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
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
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=746;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=hBvjc1A6gbSlveolZ9s2Fs6hFKhpkV/+kjJM0GpvSZo=;
 b=RsfHd8z8bGwmZa1RE3hyZG4/pZpcpssF+X5jJHvsH/AoCV7SelcoypX9sY3fYvz84BSobr01z
 lAxBhAHRbcDDrruYXTcN/dy+z/DbKARybA9sPacoulPXtjcoJ6Kbiuh
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b..d02107ff32a 100644
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

