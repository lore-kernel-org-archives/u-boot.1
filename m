Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58022C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FC4E80E4B;
	Thu, 27 Aug 2026 14:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cmpYr-LnWSkh; Thu, 27 Aug 2026 14:24:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787840668;
	bh=En/ggTt3XLsL8yqkuEb+nd/Z0y26skn7YzXtjbOrVO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yj7OPcqk4hh+20j4Gu2ZFblJQ2pa8IdT74pkBQOtrsp9EJmajqTshZrqZeIMss2RQ
	 E98RHeWqamk3YE6iyNKZLPBBveACkkwjd30fk9Pgk3PxfFx7ZaXYFsiXXasKt9IQjz
	 PaIJeBjuxzYua9AUukacM1BsEQXQWkzVsQxlp9GQxzgMAomxjwN4cA7bF2MaOwCwy7
	 cRgid+x2awgpXZWe+PoOLfwPuW+ddGqnv9W/0BIw5zEuWn1AkSGs76o/Ooqf7OlikT
	 3Yy+FavLuC/aqcE3NOKgNcBUDVB6ae+S851MEZB2OBrt/mZSMjqjFCqHQ/g5ZBinOR
	 LDngvOQm4ga8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9489B80E1B;
	Thu, 27 Aug 2026 14:24:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEA101DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B073D4073A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ClcNEN9E-yvF for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:24:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=V6WQLglu
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8547406EE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:23 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so20562265e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787840661; x=1788445461;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=En/ggTt3XLsL8yqkuEb+nd/Z0y26skn7YzXtjbOrVO4=;
 b=V6WQLgluFXTXrw6hftQ/BZOAFxEyM/0DBk8/nCLNz9V9Teu12uE5JlRfd8oMErLRzQ
 LNJkBylFdnSY3SsKMdQp8YN4uJKh0DskKJSULXC6jWlZYbYAcT7U4NK6jcEGwp+W0UcW
 rOsVsOoodCMmrUIx2N2RhFL+F282GT0izUILx7JnmVige8nOL/3OtAdwbso9VBz7bJQ+
 PX+VP19ZpC3TiPgXwnSdMKS8HZLhfdCONy1kItYtkjJr26YCo0QrKhrDBkpmAcHzc1gP
 hfUwQTQGR4GB8wBVb8GMsTbSpDcpbY95nsZjW4Ykisw6NQqdpm+lDW9tmT4n17P0ExXG
 3DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840661; x=1788445461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=En/ggTt3XLsL8yqkuEb+nd/Z0y26skn7YzXtjbOrVO4=;
 b=rN/Q7Q+5uErh1kAGOwyMwBdCw5iVAlmqL1GIH19FYqs4WUlYk0biR8VMnSWNhmxlRL
 8saU/oDCslEvj80ax1+cu1Nec8yA8uxJeoioL2DT9/r1HeZ/iGiU5UFAVF70zCkpmbXG
 nmJsrzxjCUJWPsYoZI4PH4MrcsN6T/XYlDfDanoQ9nD27/hoD+nRNfNP7F1/N60GvGTS
 KJAEqcLjFda1QV4N1pmsE0virwc/QZTkZc5ljhl4jrTjZqVKE6Qx5yX8VbUkD68v0KrR
 HJjIFzfSJ5cGj20pWnjthOJuXzef8DfRPhfLLLMHTDwhquYficSQwBI2VGuDbBnjUvfF
 57vg==
X-Gm-Message-State: AFuF++kHf1O43wplq5DrtHhWrifoHQMplgICdZg5AqV8jXrspX58gCKH
 EYT+7d8Ta7ubowWq3zSBoJrw8pvo4tJUUKi/trLV5EJiWXisaHCqirs0stdQ26X4P2U=
X-Gm-Gg: AR+sD13Jrvpg35g9gUVn0zazIfWJEJFTKwBaS5gsORskcbCdj79yGGK3qWv2XL42jqD
 sg6CaD49e/zZlfQ5JWdAJt7YZ+8dwuSkQ1vvU5bOWGFQ9ueoKQEGV5SnUjK5A9tq2umrN5CfkBz
 bs0Vk5jY8qurSCaM7U1hXkdgYRBgfoA/yJSdqQWpQbkpZ8nklp75Bb62pX9VVJC6jxECclRM8sF
 YJfPbFNRqTyBgWkyoJBmmx4Qs7p0l36aSPTDGMOZafIVHcKUjQg2LKXt3re+UbIs7GWGwV26A3B
 OjxO6bAH6dA6dxIJOseTqVnf9HjP8NJE/YekCpp/egPLwZSaIAYfX5ih6QOgeEUzTA+926rRzbq
 LVyYAWPxz+2jyP8n8F0ozgmL2lP8Cp4iV/XiIoZ1BhgJtiOeoOgtFeFab6LfknCKCIg1sQTKAzc
 0Qjz1qbe3avVbMSRFb/OlJXreA6xpbiuqToHCnDw0op+39G9vIuKUGp+d4aSJUC6oXAXmg
X-Received: by 2002:a05:600c:1d15:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b0d4570b4mr116217965e9.8.1787840661380; 
 Thu, 27 Aug 2026 07:24:21 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b468009f8sm53988455e9.0.2026.08.27.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:24:21 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 16:23:29 +0200
Subject: [PATCH 3/3] bus: ti-sysc: Add omap2/4-timer compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-3-e2c43cecc71e@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=msp@baylibre.com;
 h=from:subject:message-id; bh=A6iCeoCX2TUE6BdgMo9vj7eU9CxWeMFjTEyimC9sPcI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJHp0e56seOIXO0BWeoN3La3hog8HTU1GSc8JnJqwKe
 pbQumh2RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzEby8jQ6t8dulU39CDVxJa
 dMOvlvPsKdHi29IsEXU3n5f/byTHY0aGd4uvcjHMPiBUp330vOPPwu5t054eX/nX1i1FW2DSowk
 9LAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The upstream devicetree uses omap2-timer and omap4-timer for ti,sysc.
Add these compatibles in the u-boot driver.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 3c4ae585704e..c951d857b575 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -24,8 +24,10 @@ struct ti_sysc_priv {
 
 static const struct udevice_id ti_sysc_ids[] = {
 	{.compatible = "ti,sysc-omap2"},
+	{.compatible = "ti,sysc-omap2-timer"},
 	{.compatible = "ti,sysc-omap4"},
 	{.compatible = "ti,sysc-omap4-simple"},
+	{.compatible = "ti,sysc-omap4-timer"},
 	{.compatible = "ti,sysc-omap3430-sr"},
 	{.compatible = "ti,sysc-omap3630-sr"},
 	{.compatible = "ti,sysc-omap4-sr"},

-- 
2.55.0

