Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB82EC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4859182D83;
	Wed, 18 Jun 2025 16:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="33z55qbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C77A82DA1; Wed, 18 Jun 2025 16:25:34 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D54A82CF4
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-adeaa4f3d07so1379864466b.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256730; x=1750861530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgjMdz44eaVnOCXw9SIogMT3O5m1UBOPf1WzefN3V3U=;
 b=33z55qbQ+/GBKMRt4pCi6Pa2YMYc94cdj7N71VguCCQ3ZVRBA+UNHUm2H2EzldwiC7
 gQVV6v04CekWmS1FqCjNifiDKsWgMUOXXfcWEgw6x+oVEbbJHbdWo0aCBkj1rZ48Ux04
 jfk9NFR4qs0bR/REhH0CLqcqhC+dwcYdeggmLvwaAdaCIL+jFF41IqokyGWlR1w1IM5J
 odQ007GbmmjwF/XHv5PLXv1zeJThtgr8F5Ls2jAW0FE68NwvbP6t4Q5HCoEyLNxijbtL
 bID3xpz+y7iHlAln7NCi6xEUirELuqxCXKEOcN1vp+6ZX/kK8iCcgaYI8FmQCXKyH+vJ
 2R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256730; x=1750861530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgjMdz44eaVnOCXw9SIogMT3O5m1UBOPf1WzefN3V3U=;
 b=feTSdD47U+KmJg/iKOkda/MYkVrgVxOJZx+o9J770D/PlneoovrpKlCnoTnK/d8Wsf
 ABa7C+PNxvnNMr25izXvAVsQJ76c4OgkbKOYOCO0DU3FdNgD3yeH4olu6x9lm/kLDYZs
 fUFhncVybiwR1uScy8zuYh1mrBATgMk3QcY/3iBsB2tEnS8z5jPXLqE/O+RNO430qrOs
 f4Kee6KWhXYKcQnGCbsCe/QfVgXdWVhxYbd5N+iURDjrWqJt5cHYZKp75KUXjyi7XMdA
 9bKa3nYvDlP/IfUi+eGmzLR7CxP8Vn3OYQURUF9qLgLKz52BSq17wz0OTH9xIzQl0rIM
 gSzA==
X-Gm-Message-State: AOJu0Ywl1p4DPT6iP6oVPMpzhjoYK6a1rp+XZdz6dP0+9da4CIuVXdZ6
 bxgKgStI1CWTpe3gpeFkZVmGhYmoGSGu0624WJ0tu6gK621WC2+cd3icdBt8ALjBjlk=
X-Gm-Gg: ASbGncvTiH82MqFwTu7Wzj+x0NEXkoxZpsxMmJ1Dy+mhYG/l26dxeKSaEj7A+zsuMaW
 PqHxx1T91VPzPNrWUzmena7aSRhONZu4v8J0jmDMawczDEfe59CUPEjjF3TooyFTL6g/lh7dLHo
 tb3REkg89XU/7N5fwqIKB4fELVLpRBmUhFhPNSFPpzCfM0umXgadNBDkN6BChzd4E/KygkCpMaq
 APxLUc5OkrvIFrd8Msr9ra1x7ym6ZjUDlz///UW9Oh5ktZexROXldBlJzNP6rli5cUH6EATbk4y
 83UJt7ZBYuc0wFdjM+8iL1Q8fQ28apQVb9ZnAzFxR4pNAaCtW1R/M4/Mrohm28F9I5WAAPrl3Dq
 bNPxHiZYdViIRafHfQIucDjjDC1cfI63B
X-Google-Smtp-Source: AGHT+IFWXrxjljKEFU9xPNq3P+G4JH4UiMtFVMuzGjoOmFSe45MpumYlX43ZYijEq/xHgRCNW1Nj4g==
X-Received: by 2002:a17:907:d806:b0:ae0:1fdf:ea60 with SMTP id
 a640c23a62f3a-ae01fdfed00mr268985366b.25.1750256729960; 
 Wed, 18 Jun 2025 07:25:29 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:29 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:18 +0200
Subject: [PATCH 2/8] clk/stub: add sm6350-rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-2-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=778;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=SbbQSbzsn5LTAByx2tF/MOVKhiJWTyqLDlQjeiCZx2c=;
 b=hTQ/eET3xCnJmdj3jRC/QFJ207TpLr7dH1t4Qi4PxeG7jJDkdADFGXhPwCfqfN+0pQppUN+Rm
 v6UraUV0NdlA0s/E104BbpIFg1Ym9hvmmve3VWlNXKbxZuaJlHh7QLo
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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
2.50.0

