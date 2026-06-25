Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB83CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4B2849F3;
	Thu, 25 Jun 2026 19:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VTxkZ4kR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCCB8495B; Thu, 25 Jun 2026 15:14:51 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B001984949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c0be5e548a4so428415566b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1782393289; x=1782998089; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+VLT5jCUBfYyIQWwUL5uqnbVeF4zIDcgm9K2nuf2oM0=;
 b=VTxkZ4kRGuZfe9Gq0e9KAv72QfP/WJnDM4VtE2I1Vr2GaWQGEUel8FDdQhAbVyDbe9
 hn7HNP19qcIxE+rQG/iTP44UXEW5yjSQZaiDHhNsxqXnxTgFH2pk5mNAj0GwWkZf9VKZ
 noKZE6K2rG8bL9XUDi7wWdD8LyOtXov0L4YKfUA3t/Kb5j0pnQ3koiPPbs2XZOCCQKbY
 H/Wesrl5lJ/ZdrCLyrwKJ492z05SbTFulk5tK8Ej8POyT+M4t7TdwUnblKs+zDkvhz/M
 k0IaLURajplFbjGLopuep61iUzT909EFJuGXcwLBRFEtQX49PzVaVlS3sk1b1Xz2RHF8
 7Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393289; x=1782998089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+VLT5jCUBfYyIQWwUL5uqnbVeF4zIDcgm9K2nuf2oM0=;
 b=OZZFM0gTMuBk5sDSmEAMfWB6z35fxWM3GT/qbYlvKM9o8CUYxbC1bmLXtd0eScYrpj
 K+L4yvDHXFqCNHiBiInvXY74E5wPk/Heo+rbDuKFaEUgKolJXPx1yGPOgd1Kd1C7Fs8i
 2H8wLUYk4cXUB1PdOUi2ahukU9v4JHllFqho8Tzb0rd+gr2lf/QTGLE1SaJymOzwRnsV
 IrCd+n9QvPfPnBwPypEzQijxkO36fC/Tr0gg8ZlrBlVj5sOiM9DusKvWC/C7XZnC+9eQ
 5TDKW0BOe3DBIxMIBiL7IyFYRT9HwOn/1iACdFsAN1RkAxWHmgEWQCTy1Fq72ONRS4w+
 d0HA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk5sh7N2LIb7yZEm85zC8QvB1OItT0wGAp0RRxNTl28QDyW0tdaVzcroLDkG4AzTwqRfqzqhA=@lists.denx.de
X-Gm-Message-State: AOJu0YzxuwC/u9eNEUzr1WQtm3s2c9iaibz7QvevEPG5Z1bFUVCJseWe
 GfVrujmkNKXX2zG8qy/ZxCdDGnAMwxqBD46CpkkpIlOb+U7XaI6k/tTRf6KuV2/ifEI=
X-Gm-Gg: AfdE7cnkH2gna5FKLKRAD+JpwYZA7mMbVpLzGJvr5OSbz9F5SHNBuvX3+z3GS4X+g1P
 JKx2fyZB5ZrWdxx6IW2CXOpBeNUo0ur0m2EmVuXwzu7uGRZ433y8kJF+Gj6v9dTLDTN7l0yQzSL
 Wl62RarB+Tli7MnFEC5JYUCpyh45d+gOmx9er88CL3GzjUdn+HY5TOD6OQzNi4046x876iVt5QD
 X4QPzqi4dj4PJ7u45tK9Dvjvz5SvJQxtZO/3K4J+KmzcTn1OSLaC7KpQTTX7HEKlInDRKKMUqyi
 ulcWt1RP6z7FJ7i27lFbGsc+0I0pxt6JJn6xscTnBj4S4BOyuRVOMDose2/PizTEXyLO12Z/6hM
 EL/6sdFi/C44/ZqS9GpBhHDPRlDcf6VyoEjZuhlkdqg9QtgZqYEoMVTa+xUC89QYxDoBUIU+4Iv
 iDrCxdB/9HjzKsDPupLyfiiPe/1Q==
X-Received: by 2002:a17:906:6206:b0:c10:f00e:d983 with SMTP id
 a640c23a62f3a-c1205dd401emr169607366b.13.1782393289201; 
 Thu, 25 Jun 2026 06:14:49 -0700 (PDT)
Received: from [172.16.168.121] ([195.76.196.164])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbe05fa8sm180365066b.38.2026.06.25.06.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:14:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 25 Jun 2026 15:14:38 +0200
Subject: [PATCH 1/2] clk/qcom: milos: Add remaining UFS clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-milos-ufs-fix-v1-1-b0923dabc35f@fairphone.com>
References: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
In-Reply-To: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782393284; l=1140;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=s462Hz50SXTqbAa1m6SsyqN8AuSdJ4yYchi3+VF43T8=;
 b=fdjHgZrQITTNRevVnP339oOICLTb+uew9hp48Jckmg2+jTtyRSh7fBX1d1WwR0n/2abxlwWZz
 EzjW9YwARaYAyUmSwimFk+58bkLQpWQ0VAARbfoIHooMr6cIxDAKGO4
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:25 +0200
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

With a recent change to the UFS driver, now all clocks need to be
available. Add them.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-milos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
index afe59108559..571cd134f1c 100644
--- a/drivers/clk/qcom/clock-milos.c
+++ b/drivers/clk/qcom/clock-milos.c
@@ -98,6 +98,13 @@ static const struct gate_clk milos_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
 	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
 	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x77018, BIT(0)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77024, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77068, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x7702c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770cc, BIT(0)),
 };
 
 static int milos_enable(struct clk *clk)

-- 
2.54.0

