Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F4EE0208
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 17:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C1C892E4;
	Wed, 11 Sep 2024 19:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="LJqc2TyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5363D892E8; Wed, 11 Sep 2024 19:13:26 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2038F892E2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id CF69E240EA6;
 Wed, 11 Sep 2024 19:13:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 3C52E240569;
 Wed, 11 Sep 2024 19:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1726074799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDQHv9GZYvwneo6jCUnebM3zSIAaVMUSBe5mB2/wqkk=;
 b=LJqc2TyT53Hb9DOFupTOgooFpYWYxYYWuhNsAvREehZTrhfopu6irr3+rrP1wwcXZ57pbV
 401P3gqsqvrKDd5E0EYHydZSjcsh78ElA8MJo6Zn53F3q4g6LBjcLagnLvQrJ1q77r+/7j
 qAQ51pGkOW5/eqO21vcSfW0ppm2eB5KjVdF7u9s++83rmL+h9+iPO8+4ME0XPYfk/ioumW
 5nV0Z7dQx7G8DXUpwa7pYkLQ6Jwz38oW2a1vIcyXplgHFVojyQEjVR9WNyXlaj9Vq61rxT
 g8uGUERU7kJLGBikXghgEuRVXSzYdXH+Tf6LTl5Mwuy5Ul4A0iRhZ44HQV+3jQ==
Received: from p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id E9A89240564;
 Wed, 11 Sep 2024 19:13:18 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Wed, 11 Sep 2024 19:13:11 +0200
Subject: [PATCH v3 3/3] config: qcom: add sm8150 to qcom_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-sm8150-patches-v3-3-d9164b71316f@devpi.de>
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
In-Reply-To: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=zpg4akY+c9meAnEGhsluxX9K6WTfVGcLpYqVktc+XZU=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm4c+tAIofZiBHCmrYiKbpb8gZzXvwJmS2zR6fm
 iR5IMU3Fh6JAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZuHPrQAKCRAStku8QtBB
 AyoAD/wJX9l78qLvPP/OQLSUiNrIZ9qcGwDa/ZKix752ToqdivN0q/MmTBPWSjDAzBDoZvD8kP+
 IVvOwt00Js2pTgZx2MXz1Ak0QKoqM3GoFoLZR8nG8Koh+XGAFAKeCtayWiOFpuj4PJrvUMwYUIR
 6Ds1uScj5pFeplQxrwjRCnblK+5sZjLFIabWFhncO0f33NOL1brGEu++xx4GetCXYoQWYF4fJra
 ebZR5cxNyhzAO+6xVrDkqg6ia3bUEs79Nx5RC6tZDnkDhfl1nbQvNyTODrolkLFwM/F3L/w9obD
 qmEA4aqZETbZPzH+sWAyJMMx9mocHlCPI1y1/qwpFJddll5i99Jw7Y9SPwomAA1OcjSm/kIM7GC
 F/zUypwJEQSE9DgCd55qFMEa/jTjkYD0DN9w6Bcq3p6PmJ4AZtct/WXtRSNKslbYuyidfmr1Tw0
 sPmno9+Zo6B3twbR7EtjzpoBaqYSMtmOgrw9uNR6R0RZOpnGA0ZkmcLSk0mqmprC8O96YuvBp47
 0Ct1PxPkmSmWRwxMwLGuvLPf7ksOg8gD3AG/Uc+dqBwpCrvQhtYIWxPCn37kiiBV51IWEK6fzUQ
 4AXx4vgO73edKzrVnVVUOfDGZLm/3USbpkXKQ19wyWFznkOmX1wnhrLT2N+zhw+XHw5Nz/cJaLk
 p423nPRsMjF3XEQ==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: cc5867
X-Rspamd-UID: 96dbaf
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

Enable clk and pinctrl for sm8150

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 2a2253f766..e7ed03ff0f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -48,6 +48,7 @@ CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
@@ -86,6 +87,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
 CONFIG_PINCTRL_QCOM_SM8650=y

-- 
2.46.0

