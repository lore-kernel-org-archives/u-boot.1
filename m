Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CD606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oGN0brnf;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hZsO0B8i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 818848104C;
	Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOkQN5woqHqj; Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2B5281022
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864925;
	b=L/2PgmwWyfX42hxcNP/UOCG5k9W9ClwrW5954Y4qjmuG2J3is0uvfonwps/Cm/UDBe3C
	 1klK/yIGhVzksCETv9UIdhFylSt4N9cNJURZfVtnqzFtOPMj4RsNP0ECwzPc7PKzYLPML
	 Q+WMBrbEXXMiDqPXpIxXcpincP/GACppOGpnfAaddsMoFNXiAQ8NSVC7vFEgbHhahXh5x
	 GWEz85lxxdjpg1UpaY3HdvtUgEvshGTu0f+QdRaCXK9hKA6bYjeyX0YUX0GJXz9/y8NUU
	 U+0/c00AkvIhB/KHPA4Gmu+E0PBd7VnNNdK64mdiJ3Wr35cdml32kfW9iBROx9eS/IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
	b=oXKxgYGlceBiHG6Xn2u7ykdIPfO54+bo4A4F+HbUmJUAJ+eD1PHNel4ZV1oaUqrVJ+FO
	 h9SUvBB2sBerIE3nCZZFVOPxVQixiPmOf3gwliQMpWD1v9EwQlBJlp39GRXTy47dzTVXk
	 AjcVQ9JN3rI05MPDZWlmavjVVvSe/6k8fHL+xZHrWHhN5pEhspWwgQSub36ZvFZ/4A+sw
	 270nUnoxlqt6AIbB2A/zVxqxPKiMd9F3Gh1g0Im3zqQaa+qL+gyn8GeAT17tL6ztX/vsR
	 lK+iLaiUm6MyaiWp5VwJigN/zbUaxzKJwH3VLCBj5Yr6Fqcm+2Lga/1/doP63o2PsbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864925;
	bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGN0brnfv0E6p2WPCRf+19g1RWJ9lhbcug6tjpuQ2QNsrmfWzGe9SCfQwNbqv5XzF
	 kmPuH4860I0lKsqnZUW09tSANqQfOxELBACnLtF7P9vJ90vfj1vXpHt/QkAzrEIUYy
	 2AA7Mfz0OJb1vdTYFHaTVGggpvY/m8bRBFlP0JY+o8418xdBB15x9xoAWFCJfY4pSh
	 VPUPNYUkPmknmY4HSKLkDkj5fzhfsLqMiv91ssw6aDqnr+uPFfou5HusVc76rWJ9WQ
	 9v0BLJH9klxEIvb0PrcJ/1tQ+8mHqlVt6SbQRfN8w1zE4c3ZudXapcHDZLPh4tfp3r
	 D/LY50GrDMXBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2B5281022;
	Mon, 16 Nov 2026 21:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A74D70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CCB140612
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCybKoMjfSPM for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 891A7405D6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hZsO0B8i
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 891A7405D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so234598f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794864919; x=1795469719;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
 b=hZsO0B8if+aiZcgsYQLPibFq6rQ1chwPCCSFcFhs3qDdB29NAjN9LrX2FP9EbHau0u
 /l7DCTkPiF0JKie2GxKrFhDhJHwhM+MHYzahdNbiW4A3wGbuwruOsYsn8yYenp8SNAsN
 ydrTWBkytSQcQMf57ImLiupejJvtSlXu6plD89K2SIP/f/s3BDC2olGcje6f4bMEEz6w
 GBgDWDlDkPqgZNi6XXzGbOt8F3TfoH/l3fxmdVWVZBcdvb7Yf4Lpv4G3R5ssF+8NQUFk
 9IbRTErXQCZUkG0pBE/ESNy7Qt+UyhzaFKt2mHjPn9ngCLnTgOy1YF/vUOX5EcMQj7np
 pSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864919; x=1795469719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
 b=fWCGou4ku79YauLbhq+lwAkoaa1r0DrHYjpuVudUdb9MVDGU/NaNGnwFGWoz9ziu7T
 UXiibVJaNlfZGPLpRc+32mBxlhK9d5TDb/H+TFh+qSh0gzrWMoKUiz/zDuhxKPtt+m/R
 gMc24h5jzW8zLWI+fvKKRZq9YpjJ8Kg4HX/Mz++sd6LhPdwxub/mQeKP++A5zxwiIdcw
 RD51+Y1v1nGa7eTuMRhjD+UMcian65d+EDqt6XgqkVknrrV21iGMskQcTbtIsLSXj7rG
 Dxp0AZ6fACLwKSJ1smnU+9bHR+ppg3R42lVOQWaAPxEGUeBMHxpboYJ7N21UpHX5aMRL
 1Mlw==
X-Forwarded-Encrypted: i=1;
 AL+hErFsdvAzbP7AqsTOn+KtKdQq4kpaMIzMvxVjPbEQ+DGuIv9op8nCnyYifONbldrhhgxLCqQaD9c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/v0if5hJnHh+I4zkQvJpL3raGgV8DaT84EQ3b1SH0DKa6fdxOA
 J/EZO9S+m41/F9Z6qdPOixpVGILbv47NL8mjhlVt9Tqr2dpYcyoc7bvT8fIGfQhE9WY=
X-Gm-Gg: AZFdTZdKz/ruyXJJKYVSrmBGRIOkYfTIAIETy8wajBHkLU5vpsaWtc79OqROItwpxfj
 3Q41mME35v7+wpCiFv8zO/Wy+AVbghc1bkmCsWgZCRrNKohAw+X6Y+krcedGpWKLR5ynJXGtohf
 p+YmJts5UnCSfN66AIPHsEn+mDxZgc+v9o6a/pDBoGAmd4ykOnEksFY2PI5S0ns4uBA7JsdTo5H
 bjAm3aE7PvDHEHWhnCUFFWMWHrMEAZe4Lx00m9NFl4Qn6uXFtvUk4gWQHMFIQSFQQi40tm26Sor
 02v+2jCQMPpqeT45kF2e3+zPh6n1S768TlrYvL+9Z64YPEHq6M/EKa2q9zw2sAeqiQkfhukxF0c
 bpS3btvwL7SijxRD/MYfKjkjzLmP18jA5pmU0SBAidae3NOOJZCa+CMxpqwlb5K3nI6Op1BQ1S6
 +b2/MzlCCwt0Uccg9hyDVO9oCfjN/5q2Jj1oBOggZAEJ5lmbQxCRnQN+HXfe1ps49WmiW6g2+j+
 EK/AbUMkH66MWdQsvtjOrnN0mXArIjFAfL6KbfHjltCkM573f6mzeS4jLBPb/LH325c/gSUqlLQ
 uNwrp6S0JWuGHO2kcQ6fEDQ1eLu8WpGNPC00mnwd9i4Vq8iAvUe+SBsU1IUpykqWKOJvt6VvLRC
 5fECxtpOYuqw/+jm50Q==
X-Received: by 2002:a05:6000:41c2:b0:48e:6651:5956 with SMTP id
 ffacd0b85a97d-4a36609c994mr1668298f8f.0.1794864919389; 
 Mon, 16 Nov 2026 13:35:19 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm26314066f8f.0.2026.11.16.13.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:35:19 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 22:35:00 +0100
Subject: [PATCH v4 1/4] power: pmic: mtk-pwrap: honor fallback compatible
 strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-mtk-g700-usb-v4-1-2de4cf90365b@baylibre.com>
References: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
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

The MT6365 device tree lists mediatek,mt6359 as a fallback, but slave
selection compares only the first compatible string. Consequently the
wrapper reports that no PMIC slave was found even though its existing
MT6359 support matches the node.

Use ofnode_device_is_compatible() to consider the full compatible list,
as the regulator-binding path already does. This allows the Genio 510
and 700 USB supplies to be resolved without changing the device tree's
PMIC identity.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 468af1fba04..75dd9f743ec 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -672,9 +672,8 @@ static const struct udevice_id mtk_pmic_ids[] = {
 	{ .compatible = "mediatek,mt6357", .data = (ulong)&pmic_mt6357 },
 	{ .compatible = "mediatek,mt6359", .data = (ulong)&pmic_mt6359 },
 	/*
-	 * REVISIT: Cooresponding regulator driver only supports MT6366 for
-	 * now. We can change this to mediatek,mt6358 when the regulator driver
-	 * is updated, but will also have to change ofnode_get_property() below.
+	 * REVISIT: The regulator driver only supports MT6366 for now.
+	 * Change this to mediatek,mt6358 when MT6358 support is added.
 	 */
 	{ .compatible = "mediatek,mt6366", .data = (ulong)&pmic_mt6358 },
 	{ }
@@ -683,16 +682,9 @@ static const struct udevice_id mtk_pmic_ids[] = {
 static int mtk_pwrap_find_slave(const struct pwrap_slv_type **slave, ofnode pmic_node)
 {
 	const struct udevice_id *of_match = mtk_pmic_ids;
-	const char *pmic_name;
-
-	pmic_name = ofnode_get_property(pmic_node, "compatible", NULL);
-	if (!pmic_name) {
-		log_err("%s: missing compatible property\n", __func__);
-		return -EINVAL;
-	}
 
 	while (of_match->compatible) {
-		if (!strcmp(of_match->compatible, pmic_name)) {
+		if (ofnode_device_is_compatible(pmic_node, of_match->compatible)) {
 			*slave = (struct pwrap_slv_type *)of_match->data;
 			return 0;
 		}

-- 
2.56.0

