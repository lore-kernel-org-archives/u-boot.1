Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B373C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3E282DFD;
	Wed, 18 Jun 2025 16:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="xexRcTPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4DD82CF4; Wed, 18 Jun 2025 16:25:34 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D0382D7C
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60179d8e65fso12703298a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256732; x=1750861532; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KiWBfDYIQWvu70VybT/CqQa3Na5mGQE52VecAznbfME=;
 b=xexRcTPYOul2eh4bBLYPwvOOcD9scl6UGDWK30Mozw9spvVY4AZ17i9xJhiDEJHDQe
 dDRNpl75lp8VV2jnr6XT8U78ZItPEm/0jzGesIabgFUMd19x/2PezSCSbXzBl4vv6nrK
 5QZIN/W5VyjQRqAiaMhDSwKKySUiNpsNWvMJ4Qxs5ZfY4IOSteaXNJluBHqMzUB5trHO
 M47EtvIUGza+Bse8gHlDyLJRwHvx//+R+ts28aF8P+WYEDS73GsuR1jWaBYGXwypAjz9
 x+Qz/00GVAIivox7OzJDIyvRmBseguPFEp5Z6atKCzBJQsG1hZ+ZVMoiZrgJq0dm7HQ/
 ZXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256732; x=1750861532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiWBfDYIQWvu70VybT/CqQa3Na5mGQE52VecAznbfME=;
 b=HBOR3dNWH/Zp+bBPUBu2EsHl+iDweqYzRYdQfDXLsPGLe4G4IOOyPKNRR1Lth+0OlE
 NKbzeyrLqC3ti5AwtUh9BgPsxjz7lDxuUVBdxLx6JjdmsSu+RLb4U9sfIYAmzf1flPB8
 p0/qWsy+p6eqqFPQTSfYadKThnYd/y3oQ/0eA2LWomY08T06vnEuc9SzZu6TjS61r987
 h4KZ7+DlH50bfrTpwIBSoDanrHl66tzrjvJNfmpGlZ8c89Kl4J0os6GUjpWppsHZxkqD
 997YSxQYfoq+aZuGRvRNBOrQZ+kAQhMGZaJxRSvuYBEXsGZ3E+SQdV9jaNK9Vg0sI0I4
 a87g==
X-Gm-Message-State: AOJu0YxPZ0A0DiGn1KWVRoWmejH7Ui8yUFjUaYF5ZigV6fZ+rHg+FbX4
 WPrS61+InzOTclitpHnJBdGx2UcZJj8F4X+dZ4X9+iF1HAEORFuHg/zx+PpBKbJaI8k=
X-Gm-Gg: ASbGncu/zV7BbG1APpqS70tASLyW/XH6yjg46crS9fRXpBDgvA68QFs75h/dI4ykOJl
 sdDcK4U7uCEZiJGYixyALhjSlJpUxDOploUGqvdhzMwfNRSxq37AF/5WNidsD7FkENMFUZ1IoZO
 n7lLab6H1UypwpsPvZulRUh2yUayWKX/nLa3ZcDnfj0+Fsjm4ScRZXKd1yBts2EUYFfmkHILwvV
 3cnx/vfYcCZVdkSv7qx1IH9Z+u8+do0JaSP2RNCdyZonMYX+n7GNC5mT/n5hQ//ufpQTIrW+kFe
 Je9NQQwQgd/Uedfhjjid6ZWmgbUnOTwJWY/PiICg1XrTI9XUqYDb293p4HkqHw456cOOEOf8eBD
 pnuzPcqA4wSGPXyKgi+36BrUBggaFXjbJ
X-Google-Smtp-Source: AGHT+IFsC2W2X/Bv/DNId5HaW7i2Bk/FAyDx4ZwYk03PZfZ9Fp2zH5cJqdrSiXixPf0sXPacCBSRdg==
X-Received: by 2002:a17:907:1c0c:b0:ade:1863:6ff2 with SMTP id
 a640c23a62f3a-adfad5c9158mr1671478866b.52.1750256731635; 
 Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:21 +0200
Subject: [PATCH 5/8] phy: qcom: Add SM6350 to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-5-3cc22aab7a7a@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=1115;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=0c6xTvH3h2RjXc3MsgPSgjZl0cV13cosFkgQhv1prAY=;
 b=f6J+ZFbfiODiOBxUPS7U7aj3mMpo060qzNsiwfufPAZSR7qWTw271Ln9CpjmoiDLacf7mf1/r
 PACvoRzI5bfAaMC1orKLWgo9JX5HdeWjqTdits7Xu6lsP2SnGNc+zH6
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

The UFS on SM6350 can reuse the SDM845 configuration, just like in
Linux.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 449b97677788132dd6b9eb654732896756a3ff47..b536517f93a3a41a05b20d811033fc62c05169ec 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1467,6 +1467,7 @@ static struct phy_ops qmp_ufs_ops = {
 static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },

-- 
2.50.0

