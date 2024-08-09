Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52941C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC8088B8D;
	Fri,  9 Aug 2024 02:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ARsy6zkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAA788BBD; Fri,  9 Aug 2024 02:48:56 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AA4888E4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso132630166b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164533; x=1723769333; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zLolcdfhpnv2Sr4+jU2o0ZvxpFWa2r7z1o+vmKY3kNM=;
 b=ARsy6zkPbTZdXdo6STL6wGnhKGAB8UzOUpaMiULwWRhqOhtXxTI0y3m0wAbg285EqR
 w3swIlMrSeNa1aVS7q395tm49S2fKYuuqTR699RqtvhCXo083YXXqSOmFSWRGnr/F4x1
 blY8BJGoU+trgxBCYKs/vaeIFuFq2j6Cm7ChmglIXu4c0ckq9vJ0f1odjmTzLO/0rz4f
 LT5p1By0BblqmTH4CmwD31Wp8SjeMkXMjU+WLVk1u4Z4ESw+w98mfl2+uHgpbYh80dyg
 sbgiO/PyTxuiwfS6+kEhSvqA2uf1N9Vs99Jmp8+fkiyS7Y7EbQcTiP9ST4WRHchfDkdH
 zr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164533; x=1723769333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLolcdfhpnv2Sr4+jU2o0ZvxpFWa2r7z1o+vmKY3kNM=;
 b=Cc4N+IrbSqrp/khwen3wsx/LQMBzPKj98qob8oY4PizIa6to++61jSvB/vN/8TRvmm
 OrKWxm9H3B0Pn4SQ9QCW5dfOrhyA44OrYaV2o/N0/TkwzqY3Ol0sOiFXH8NaW5AanRFk
 4ObGQ0Ky4wiYgSNzzjzAQIzxp/3RMAZPOMIe2aL/uiAMQV4+FWTYndv8S1fPPq78IWrS
 GjPg5j7zdBd9m2KYl5cnNdNKfR/Kr0dlsk1ygjVH/E5swKY7ie/DOW3ZelEfD3GnJi/d
 Q0vKxeVBaP9y+RuCaze0miOPGrShicLRdqHpEJ+yn2RLTY1S4yuYH6zbrEQbyiJIrzgj
 mSwQ==
X-Gm-Message-State: AOJu0YxuAY7+NJqFr2moQK9g0uixi8EoOUgSSqy9qj81JWBDVxKZSCE+
 BPOK7kf4fC0ar+KFqZ2LIbCjnDdabnMCyjkzgJ7dLnqM2Bt71QB4KurOZ2uDXVtIsdm5TDOziVB
 x
X-Google-Smtp-Source: AGHT+IErpTJH079oWNojfhMFqyXBdWotPiKYcUW7Oy62qS7kd12x+bcVuIN+sbR3T01c0lXuy79b+w==
X-Received: by 2002:a17:906:7309:b0:a7a:a212:be48 with SMTP id
 a640c23a62f3a-a8090eb4695mr253262466b.56.1723164533154; 
 Thu, 08 Aug 2024 17:48:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:46 +0200
Subject: [PATCH 3/7] dts: qcs6490-rb3gen2-u-boot: USB host mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-3-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HTbXxsrMd17GClJdrUxqmv1t42K8cKHfbuWdCzpCB0M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdwnEjec3t3LI1dtrNsf/bUwYFwQJo1xwokL
 HYePacwZJSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVncAAKCRAFgzErGV9k
 tuB/D/0dbLtAsAFTjuohGNQEWl+scj5Z8noyV1+OTl7y8m2Vmel35e5eU7DkUhfzW4cIFcre7Ax
 tHF/FgdLxbnxbWLBj1TVjje7ABcfrQamrh8lbcGgsaqUw30wdN8Z99+ElJcc/fH3XK1YqLc7oUJ
 KDLURyJYoUWwbj7lOPClpdcWop/m5v7R7DU2gu9U6qASUe+0vu/iWDksG6gfAvkLbmIWb/VNhLU
 t4AWEqN4IHtDVYOHNj+yyRoM/edg8op4BSXkvG4xfTpUyONxcLsYekfTmuo11Ux1YaLBx4gWYSy
 kTCC7w/GA+TdS5XV1fFMHcTnBAa84wh4+I6igJspiqbPdtZywXb2QhUV3kSelP9KUlmJRhSuYJJ
 PIQj1MwEReNCwE+h6xAnErKV/K4SIeFSYaVjeoUYpEatws8ObfADfOvuPJAk2YVIp/4l/oyjqSZ
 pdpOenjc2L7JtQXW4uS3Ww+/ddZhT3Pb/WmOWwkVLeJ+51yfwqK3FkZD3xqU1AHLcma9ZFa1Dvt
 4nPYbzrlN/iJUTtKA1NraLBkLW4ASZXEvrHAdCxqPeeDdwgvQXBGWO1TPoQnHjoNfzvX4AFRTLK
 kovno8l/RpjVsctqTf3ITzDSyBbAwgJ7EQZMyphT+lZh4z4tDWXoirSerYNi+9W76vTIhbgxIoK
 mzzDm9S14aWV1/g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Adjust DTS so USB runs in host mode. The type-c port is the only
supported port (since the others need PCIe). Booting from USB is
possible with a powered type-c dock.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7c..fbe72595f5ac 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -16,8 +16,13 @@
 		      <1 0x00000000 1 0x00000000>;
 	};
 };
 
+&usb_1_dwc3 {
+	dr_mode = "host";
+	/delete-property/ usb-role-switch;
+};
+
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
 // RAM Entry 3 : Base 0x0100000000  Size 0x0100000000

-- 
2.46.0

