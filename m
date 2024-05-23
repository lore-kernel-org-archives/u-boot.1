Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B88C25B7A
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B98988605;
	Thu, 23 May 2024 19:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="b89fG0Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F83885F6; Thu, 23 May 2024 19:38:26 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3210688600
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5785160dbf3so34791a12.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716485903; x=1717090703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rH7qBtaqEEVrxgidUEr4FPz2oPog26F0SBCKMpJUfao=;
 b=b89fG0Eidy40C72cVtRatN/tQ+34eDtKcVrrcYzmhgb1F9TIoFE3yXXM1oNsI0qbZS
 ZR5sdpN8tpdzJV6U5jFgeHcJvF/GHqKoePW3MhoJ6Oa9JJZuKf+7hGiW7FG0AY435Vof
 UEtQcAn95xWb1lo0YZFnpku3VGSzk/smy4qVJbJckMLT7N2wX3Hixh+xWzGG1GW+Kfq9
 BRZMHMKynx1tmmqA4o2rzI3X7YDrYYDhtXiepAb0rZTeT729VsZ3BCBzrgfRbl0UxuKd
 EKrWwzjl9dQtX7ZrJOztTDrgK/dgLCDREIaAJ+HKUIh0RpmwBEega8M0XH2QwehVHhGo
 V85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716485903; x=1717090703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH7qBtaqEEVrxgidUEr4FPz2oPog26F0SBCKMpJUfao=;
 b=dUz3FQ2a6XTcFkaFbkfms5q8N9AR4/wHl+k3Qo6SUCBkJdPPr7OcGEdFnEv+1ZKCdz
 GtYuBg0zL/dkr27GyYL9iTO6Imh8+WZeJALo8BDbP74JlQp45JrsIrzWnFnLet2yFDSN
 0YdeJShEmjXCBuAZQs+z5Ylx0oGtBw2ZYB5qu4qCCTaOBEo5o87dQIdk4jmI+gsHEDqH
 xkpY5j0rRWNf98Ig20hB3HJmGUVKI/uSSaYwZKHEp1iZwjl/c8CFVeBbee7+m/Bawl5H
 LhhzYrcgvYRkRURgQdYDjbPi9F2pL7i/k0CozCVOpirebDBWmZVn/2JlKXNOEe7VG9Xg
 VoPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6U64k33PwiMqy9LZEylftEIaEexKx1Yh8HCLVJwIPxg0cKft8CX5jlvL6yM3E1jIAPCVi9zBmrUrRBmaqHYbG2/M7Ew==
X-Gm-Message-State: AOJu0YzdKzRd6UowTrPR/gaGMjOtQL/GWFGTs1pW1tQans0y3CZFHoLf
 //wMmNf+Wy2jCdcHneLE4dTlz8asxy7CplC3CVx4MS3AvdbtZ5qRe5N8E1VPmEw=
X-Google-Smtp-Source: AGHT+IGfIZZkzafZXTLctIBAj17KBWc7H1FeGmfLwNFGK2zJ30ZG49ukLizIns7a5m38n0/VkOohnQ==
X-Received: by 2002:a50:d702:0:b0:572:719f:b430 with SMTP id
 4fb4d7f45d1cf-57832bedaa8mr4786072a12.32.1716485903380; 
 Thu, 23 May 2024 10:38:23 -0700 (PDT)
Received: from fedora.. ([188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574f5a5b029sm12430366a12.7.2024.05.23.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:38:22 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/5] clock: qcom: ipq4019: add missing networking resets
Date: Thu, 23 May 2024 19:37:27 +0200
Message-ID: <20240523173815.63628-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523173815.63628-1-robert.marko@sartura.hr>
References: <20240523173815.63628-1-robert.marko@sartura.hr>
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

IPQ4019 has more networking related resets that will be required for future
wired networking support, so lets add them.

This syncs the driver with Linux.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index e416c9cdb0..2773bbc2d4 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -205,6 +205,12 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
 	[GCC_TCSR_BCR] = {0x22000, 0},
 	[GCC_MPM_BCR] = {0x24000, 0},
 	[GCC_SPDM_BCR] = {0x25000, 0},
+	[ESS_MAC1_ARES] = {0x1200C, 0},
+	[ESS_MAC2_ARES] = {0x1200C, 1},
+	[ESS_MAC3_ARES] = {0x1200C, 2},
+	[ESS_MAC4_ARES] = {0x1200C, 3},
+	[ESS_MAC5_ARES] = {0x1200C, 4},
+	[ESS_PSGMII_ARES] = {0x1200C, 5},
 };
 
 static struct msm_clk_data ipq4019_clk_data = {
-- 
2.45.1

