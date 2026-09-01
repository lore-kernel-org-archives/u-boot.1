Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D79DC624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61D31607C4;
	Tue,  1 Sep 2026 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BHsbPPS2_jFE; Tue,  1 Sep 2026 14:39:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273549;
	bh=plF9f6nKG+qtNsQ/cwLLKqXGqJQE80ql4VkhraSca8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f1ayPI0F0C9Uk80Sp7LgNLpsIN25Gdyf8MWM9HDK/BvBz6rptns/j0uKq+e+68D9P
	 V4Hi5cjql+ROqC5OXq2sN1fGsMzdeXjgPu42A49tFbIfDip5PFx//6r0zaUnRfdjES
	 R3EPalrh2CO2TjTH0Zqn25c7UWsBdwtVJxtDAQhZLqZzm7X54eoqFiE1wB5XpbqNTY
	 LaAe0O1BZGGkBfOp/43PbV3aIcVouKKUVITx8hbou13UX5eyVqsq06n++bFJlH52++
	 ysZ01so6R27VsjZ9aqrv2kH3cvXms+/ehgaCqP9iUb/hzaOI77Us+S7+7pziF+WSve
	 IhJmVrDTLphMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C48FE60790;
	Tue,  1 Sep 2026 14:39:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D7BF279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 737A24073B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDBzjFfwGMhb for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o83grcw5
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1525B40755
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:00 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so3892517f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273539; x=1788878339;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=plF9f6nKG+qtNsQ/cwLLKqXGqJQE80ql4VkhraSca8o=;
 b=o83grcw588caXFarWUC1uNNKffFmAtYcqFyAOLD9e8G5hCRMbvj/aRS2Fdj68b/P2d
 ErI0EqCJY1y9/z84BwYfCDoPkb012OuQ4PuWETPNUVXeo6eDV4Y+Sjadl+heOJ/H83CE
 BM+rH9PSn8TqDXv0IcoDkRMFSONVNX/W/wN3N6Wzxr7HXl87rtX9A3HfQsGpfVayNhxs
 5KzhmQVHbzYYqrBeoOQlO4+f8wuOWfk6SaTMgmFKr8MqYXIhAICACckvRRXDuL/HaiZz
 k0GR513yYiA45XRTJ9xUM2Lkwxt4ANu5v59j85G94/6bzCzyiYLYPrtI7OsM47YhfJ+9
 anaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273539; x=1788878339;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=plF9f6nKG+qtNsQ/cwLLKqXGqJQE80ql4VkhraSca8o=;
 b=fgh9ZPxROJc1XzfYpgvkSn4YgxgKUnN2m2MxJ2zDbULWp62yPgSGm1d+bezMcw4c2h
 LUDPPvatU7veml/ZLI25qOxpqY9c6bqZfSjC6LFXB5f9T4WJQTsmX0vM6C/oOPE47NLs
 g2zVunT/upI4DaCOsdNIHGJfXNZamCCr8rrXzB3tlkILNai/i3w9wmN/NkK/635ky8tT
 Hi13YeoOX/y9BLC1Z/jT2zXO3zR7iLU88gAcnMKdcJOrE1TRMutS8jq9dKPPOBS8CaUk
 edFv6WJ5FRh99wE9hZayYFgyAZrYkyUpmBz7Ec41HNFOzIEBmbhrxgXqMg02uz9Gqu2L
 NpIQ==
X-Gm-Message-State: AFuF++lcXlJ/oMzqhWzQhF6pj9kLFxmiQIiSilkJoc7YrIWWwi7K8zEu
 wJ+LkuGU+/RduSYENpVJf6RH5jfRzvra0qMVZ7pCYKLYBYnkvwwd5HPHQkBy+wBLvE4=
X-Gm-Gg: AR+sD12EgHm40VB3ylm2avrNd6EyY/FvXyaGYMlKOgTpQKYbEfmxy9E7OuMuxFePLSv
 P3TEQV8RahO/4+3CfcR1lF/qAZNv/V7EcSOCUOCRpUeIOlDaMellLeoc9xdlYaN2/ciA6r+V1Bz
 OxT1BxJ3ScCXY+06JtXRSmfr5HZl1mPYA3Oapa2J6R1UnCDHcTMGL0zd7ue6BAj2cKF8WoyTh6a
 PjY7ZtxMJYZmeIbz9fdflYAhWJ9Cp9zhF2izuLZXkvN7h8WNKGe44CXu6AmhfCs3bd3RsSFPggX
 efmKjXR/oFobro2/QEoZidb1/k5ZrlACNjCetvFHdDX1KqfQVPi/axCeOqtMu3ek5A5BcKuyaLm
 w2oKAKV+wKICODIAMQxA6fqdNkfTe8hroZmrVQGaoTAmqfbDElsaACKXxl5WonDp0COTR6CPe1c
 PyCe33ToWjKQuvfZUQXtjV9NeGfvpXXApbBTEyjaThfHD4CTVal6iFB1ttWw3V7X40oBwtDm85c
 YVzJNu7Y6UhDSBAewPIdvEgtrhMZ0lQgs8GPD7azFNRL7KBE0Rb22iBfOijFVkjdtWtjDpLR9WB
 n/YEtbtjZ+8DaxTpraIuSOxpAQgrntU7ox217X5fXdt0
X-Received: by 2002:a05:600c:3584:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49cdada30e1mr158441165e9.2.1788273538756; 
 Tue, 01 Sep 2026 07:38:58 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:58 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:59 +0200
Subject: [PATCH v3 13/14] arm: dts: mt8390: add hdmi override node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-13-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
interface attached to the vdosys1 display data path.

Add the U-Boot specific bits to mt8390-genio-common-u-boot.dtsi:
- a "memory-region" phandle on the hdmi node pointing at the framebuffer
  reserved-memory region;
- aliases for the pipeline resources that have no upstream alias (the
  vdosys1 syscon and the larb2/larb3 SMI larbs), which the video driver
  resolves directly since U-Boot has no DRM framework to walk the graph.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index a4db2186e2e..be1543d1499 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -19,3 +19,8 @@
 		};
 	};
 };
+
+&hdmi {
+	/* U-Boot specific: the framebuffer lives in this reserved region */
+	memory-region = <&framebuffer>;
+};

-- 
2.55.0

