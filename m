Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A2CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF09836B4;
	Wed, 17 Sep 2025 18:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="xmjZ60Is";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDE5835B9; Wed, 17 Sep 2025 14:47:54 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44737835A2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-62f0411577aso8252799a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113271; x=1758718071; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tkgs9wZW1tFVXV4N7aLw6/8gX1ezs3BpyW/1Oc0zKkA=;
 b=xmjZ60Isd2XahgGQmwqfjUAC+sydjBuRqBJQNt/3UtNIujwjr/E5NNV/GGMHtin0AM
 FcWGK06ubS5aTy4jBlefhuNTnyHMZeUS6odclusxVcanBrWAfXR6IUCZ7tIfnm3uDCxj
 t/x/Mgpzrwmic+VCHtN2LhRiArRYI968+Ae9bvmqFwKS9cdmJQvNpkIqkOaYC1ft0fKW
 vYntdQVRw6VnIoDHaGO7X3vrrcTm91yCmqg9lYkqoMvLWxqGOFan7lWp7RWK0ShvLp+p
 MYMf7sUW3kyMQAxEOyMIOEEMtwHJNfO0EO8cp/ou571T+3qc+0E87mRqw6DTMpJpgrXg
 j1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113271; x=1758718071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkgs9wZW1tFVXV4N7aLw6/8gX1ezs3BpyW/1Oc0zKkA=;
 b=KQQ/4TU6oPQOsjn1QalwLul93iTHL2ipD9LFRRRK9g47ngscSuayLvGA1iOtr4yywk
 TF70QwyntlSmCligR7iZi07Hb4lIFC6skoZZJM0f3cCDR5ucLEOv5wLVKXvH7F4dkBHT
 T7t1gIX+TIffQHa50yHpCliH+YHgdt0TUjcIqCNc36TYf1f+m6XLceofN8A959WdVkNO
 /KwaaFfkVIR6zT7oX979DMCOH0Q0akJ+hEovPX1/qDQFYt9GydJ2IQm/gwltlzfo00KF
 SjYvH6mVO5TbcCNcMkAO3Z3nmZrEKEZon1RFexYa6nsQ/rMFrgZNu+TaE8JJ4FqJmHki
 Sqjg==
X-Gm-Message-State: AOJu0Yw1lrRR2th2B2MHZ/G3Zm4855MS/zNftQdCxedF1WEVJxKmlUR9
 gkR5cqyH5ZYUZibkYrzEUrThHn8vnzPnP0zQEbFRXc97OoNEiZjhtWRPkc2mZRYnh5Yg2/lRxFv
 67n+Jij6WuA==
X-Gm-Gg: ASbGncusEM9bIYH/rQaBfG4hI1SJ91XI9+JJRXpD6VhXe2GvDuRTvIYIfuLYVhXsGSP
 qHd8V4rLwQ+HAwDbFz1PRSeFXrDmahmsOfctguRDiISq+oOC8pWPGdj+N98olb+mIqfUFzDM2v8
 gqoYKoP23N8nJ8X/PUw/4k5VyeuFeQe4nMy24QUwDyWeg0g1YTPcoc27WIokWkzHkgjy0eynpEh
 ffhYYHyC+4zogj7iT+cautUdfbcFNVIc4OUVV0rwDzfVhb/Neepos+QCbADSLcbfMmChDdZgwvr
 ly5tiTdxXGPalWMZa4N3ffFqVIQCowQsq9Z0xCWUbH/XL6+KNTYpuvY6bj+YIlTI5zn7qz9IH69
 yWeW/owsB1avbbaXXUeqKew+zyDCv1WDtkodLj61xhJ2amNjxXFUNdMckrCPDhuXTFvuz1Q==
X-Google-Smtp-Source: AGHT+IGg6Voypx2LVxgPvGbefB9mDLoXOq+uR+Io9NUNkmE9NDVa6a6999UaG14x8N0BZ3lndC+2dw==
X-Received: by 2002:a17:907:6093:b0:b04:3513:5138 with SMTP id
 a640c23a62f3a-b1bbd3a673amr230339166b.41.1758113270673; 
 Wed, 17 Sep 2025 05:47:50 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:35 +0200
Subject: [PATCH v2 2/9] clk/stub: add sm6350-rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-2-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=835;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dLYOahu5YvfJrkxZHEJfVej0XoYUX5IICY7AnNL21Ag=;
 b=C14xG80P3SMTPXLjIIEjfMqhLgCIcz5j+jfCFgZrEGJfcqiWJdODfAhZIDEcuOm7v0UnDlsjq
 vKlCcKJY3mKBxfksRm9FWoIO7tQ5dfogJthQ0DvCwGlKUGlKgyrhIl8
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Stub the RPMh clock controller on SM6350.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b322537f070a740bf1f80531006036..5863ec72abefefb3c62152805260238b7045e81a 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -52,6 +52,7 @@ static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
+	{ .compatible = "qcom,sm6350-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },

-- 
2.51.0

