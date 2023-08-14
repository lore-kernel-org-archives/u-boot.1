Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8AC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6251869D0;
	Mon, 14 Aug 2023 23:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="idJ1wj3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3179686989; Mon, 14 Aug 2023 23:56:10 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1109D86987
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so30736075ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050166; x=1692654966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBAAKfCXb83iJYYZLvCr7BCJ7stDYRogqhwLTa5vleE=;
 b=idJ1wj3pPyJjbw6keAxPApDtftOD79lldrShq9EMu2/Egt2bJvX10oTa8oH3mmQt2B
 HtaA083PaSIBvE8XXlcqq8u/EJ4WETz5eky5+QbtQTLFywFuzWqD9Y0bTFbRZKITkrhi
 71D4xb4fYQ2n6zrChymmn6EPUSYoNs3qrkt/gLxIBmoHqwG94qMkZmt2su/KaoxltEEC
 RTdTcRt2B+bVno1rnQIPvuQWj+ZxNKhdW/ztO5PJqJkt0BYAgEy9x4997ksq6LGxzYRt
 ruaKb6n9AOCOO9PDxoyqLacz1V39CEivypgoFfm0iU0QaMWuM+HwASB3M5CbqPu4w9Tn
 Q8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050166; x=1692654966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBAAKfCXb83iJYYZLvCr7BCJ7stDYRogqhwLTa5vleE=;
 b=FW0apJhnkubaP/yYgMjMhJNwkJZX4rgIl0R/D6Np9kaR7G44jqQTCSFkQzPfzi0kQJ
 qRmRFIv/iDlC7mq6mdCfyrTJt1PdULU1kagArh7PBj6+XeuLRaPFbwq4pN71CDJaDHaH
 i/XTCyy1E5Pr2nw2iQKnbrVcTn4iFmJsnLB8kHw4l2hzVy/bngCecvkvVp+XjDJnMgD0
 uUy9djbjghZFSvxdWSyTIZuoN/bCB4JaFsUdi8ONCPAIhxFcbCxd6nLECZOgINAN0HKE
 PNVkwK0Vz4CNU6GY10xRJk0q+RxCjOON/Tv24ryfU62u8GdgU4mZtNYc1svVPNbg2JgJ
 jhRw==
X-Gm-Message-State: AOJu0YybGaKMKB+TlpXjQm4jU4flvYQlkRvRusnxljg87HTyhp0mQJ53
 3GbJGW7shJOAZNM7bdKy3yLrFr0k+PXgG3HYDiY=
X-Google-Smtp-Source: AGHT+IEbuzVATBV2nuePghQCafcSeGM2Ua18cY514VIb9RQP+Hm5/dbqUs8aLyb2EK8iPMv1L0zx+A==
X-Received: by 2002:a17:902:b492:b0:1bd:afd6:e808 with SMTP id
 y18-20020a170902b49200b001bdafd6e808mr8089008plr.26.1692050166173; 
 Mon, 14 Aug 2023 14:56:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:05 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 13/17] arm: dts: qcom: sdm845: Add 'reset' node
Date: Tue, 15 Aug 2023 03:24:53 +0530
Message-Id: <20230814215457.4075025-14-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add 'reset' controller node in Qualcomm SDM845 dtsi.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/dts/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 3b86b9328f..056a1674d5 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -26,6 +26,12 @@
 			#power-domain-cells = <1>;
 		};
 
+		reset: gcc-reset@100000 {
+			compatible = "qcom,gcc-reset-sdm845";
+			reg = <0x00100000 0x1f0000>;
+			#reset-cells = <1>;
+		};
+
 		gpio_north: gpio_north@3900000 {
 			#gpio-cells = <2>;
 			compatible = "qcom,sdm845-pinctrl";
-- 
2.38.1

