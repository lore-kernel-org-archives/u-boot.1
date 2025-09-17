Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E5CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CAE8373B;
	Wed, 17 Sep 2025 18:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="nSi+5yI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02B380C93; Wed, 17 Sep 2025 14:47:55 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B731A8354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b046fc9f359so1032622566b.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113273; x=1758718073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YT/VeL3ak/wpRbpxmoCdoLTx7jxJfhUoxPDmZ8eqwJc=;
 b=nSi+5yI3JB56RPuWa9UZqZuDKV+q1kywBueQ8kqGUUK+SoLmR+CBLfMeydnV9usVTt
 1Vb0QKTbVUW4F3wk2ACGlDIk7PCUgbyywD9fNtXUEAu6Lx+C3EPUEcXuXZqrnXzaIlbt
 96suRl5zc2uuc6YlC7Gom1OVrN4GFs8DwcSMDTlyKTT+FSKf1pcz/5kmNMMwkEMycra9
 6qsw/iiBPgzqfJcKWlPOfSghSmFc0Ci14V6YWClL5dOxRMdIfUvGygVPWEte9ADY4hMa
 +Uc9stMvmQYPe+9jFHZDomtrX+WeggkieCxxy3bXw9sHlvJkrlJTxAm62hhXBBb6BInC
 6e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113273; x=1758718073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YT/VeL3ak/wpRbpxmoCdoLTx7jxJfhUoxPDmZ8eqwJc=;
 b=Nr98+PDCIH4AfaE5k8bsUkS0fzns7h20d1GZzqvseC1BDMfM+lhP4cRn4+lrJ7stpS
 PEed5JL+o7yQVvEkzkwBvDRKEpNMQYndHdx8stAyEzhfdLqBq78UVHABMWGm+YkznZcp
 S4pkPBP+tZ/KfisYI46DZaRrND6NWjYpg6PGH2Zonk4An5UCs2JwTfOSkGFNmDViFpJK
 0lUKLqmLmjxoZdyA/q5+Y3QRH+HkA9qUuqDkCcslA7gW+r2rdLnBKvwuyzzYnv1qyS8T
 o0Kx/QW1cOr+QY9ctMrXFWbT+Xzaso3ptRp/wBgvGvlG6AbnB6fudpw1EM/NX3zEPJ+p
 bZpQ==
X-Gm-Message-State: AOJu0YxRn51Ugo2L0I7wNJMzGpUzXF0MeM19QxCnQR0vltVZF+zYRBD9
 5S2PVQpd+pYgbQFA47g1U4/U/UYHp+OJa63f6hSF3aj22vbB4eDVhs6gDKxbeHc7th8=
X-Gm-Gg: ASbGncvEnG8YpCydcp2EDJDqIIFK0VyRDjYItKzRtfKqF34vTkDraYgfWcxAJ4+P32I
 3OOnQwzM46K5q32xblZaMv4mrHRUsxxjeQOzGHXzfSmVw5WO5vZLev7Vcj7RUs2iP1oTXcbmB9Z
 KiacUl4YRYFXpqM0gCn3XGHmFhbSbUByuioEWNWkgoM7aMidNVTQswGSYZtzqlGhtv2Sw6RCeVw
 kp8jgls2eF0/ZBlZFpb0xJKBNnskFWiHAr2KL4TFWD8O8i5lGm0oAiNf8Y7JT0DLoPpME4TOVmq
 nOjlBdqim+A6nO1k7t1wwWyV4AYHYMcynQtXjjrweTUMJDQc+SaqpU0WLkCJBGjZJuqnNRBnnyn
 m5i96zHvUL/rt3nvXcucue2XZJCpDX0GFcbIr+co/cLO+Ptt/9sPcvKQRw4dJ+NmuGIwf4w==
X-Google-Smtp-Source: AGHT+IFMii+WLCYkCs3/XeEF8XTDAe9oyksQzXsxgpuC/HWfUUNQMYeIhEjur05iffheKz0tzJCn3w==
X-Received: by 2002:a17:907:86a1:b0:b04:a1ec:d06f with SMTP id
 a640c23a62f3a-b1bb1b9e3e7mr295124566b.25.1758113273223; 
 Wed, 17 Sep 2025 05:47:53 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:38 +0200
Subject: [PATCH v2 5/9] phy: qcom: Add SM6350 to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-5-13346fc2a2f6@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=1174;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WbUD6FIWOqsO0KJuMeSlHNmAw/vtn6GA5g6GU0oQDXE=;
 b=GvVhMcJ12CgX6SK7WsM3tW6d1FZ16je4IM6Fb4U8Cb2L5Ueg0VXlMWtS2WG4qWzlATClHXVTy
 Ne6hqwsCTKtCIE6X3p+px1oMtI6T/GcJyw5ByJm8xst8goqeTk1CUJF
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

The UFS on SM6350 can reuse the SDM845 configuration, just like in
Linux.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index f3c606847fb695c162ccee443e797182dae9cb55..1c790be2e483e1525d298a1ea29a8b5a9203acf2 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1593,6 +1593,7 @@ static struct phy_ops qmp_ufs_ops = {
 static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
 	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },

-- 
2.51.0

