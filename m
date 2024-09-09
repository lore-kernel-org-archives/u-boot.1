Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1AEEDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6489588EF6;
	Tue, 10 Sep 2024 05:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="S+lgLX+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657BB88E02; Mon,  9 Sep 2024 17:53:25 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851C988DC6
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 17:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id B3E9A240CD5;
 Mon,  9 Sep 2024 17:53:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 21B152404BE;
 Mon,  9 Sep 2024 17:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1725897201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fnYuFxBp+6vPIHNtzktXAnNm5+3BkvdK61qieany3g=;
 b=S+lgLX+F530jfVY7EADZZiXiaLmpVBMmyYx7SgbF385I4iGCdUY8Vj/jIkrzg6tpMDV8fd
 i0QkJpuu1Na3d1aUSH0C0dSqUdYD6WqLHLMhx5Z55kSzQJxvJIyckOfkN9+yvyxFwNx2Gf
 bG+/F2ADl0rWsHgTo01koywNptSpT3ATOYdu71lIEsGuVjkppns/srXpoQRCpx021tf2oS
 BnOfDolqCCW7Jyuuzk3y5+gUO3Gx52CuySmgndQRnT3NWBW2Yz47ifAle5+0gUZy3cevpe
 EULxLSc1izdkCB+sd/0rbWlW8sZ2y+7lGDqB1hL9L+fVvhU7sUlnUc2nwFjXHw==
Received: from thinkarch.lan
 (p200300cbef069810000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::76d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id D92F02402D8;
 Mon,  9 Sep 2024 17:53:20 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
To: u-boot@lists.denx.de
Cc: Julius Lehmann <lehmanju@devpi.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 3/3] config: qcom: add sm8150 to qcom_defconfig
Date: Mon,  9 Sep 2024 17:53:12 +0200
Message-ID: <20240909155315.307026-4-lehmanju@devpi.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909155315.307026-1-lehmanju@devpi.de>
References: <20240909155315.307026-1-lehmanju@devpi.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: e0bb4e
X-Rspamd-UID: a3e4fa
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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

---

 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 419e969e5d..03587d2dc7 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -49,6 +49,7 @@ CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_SM8150=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
@@ -87,6 +88,7 @@ CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
 CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
-- 
2.45.2

