Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B5CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3C0834D4;
	Sun, 14 Sep 2025 15:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="WGDv0b7m";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="w5A6BghQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B82481E13; Sun, 14 Sep 2025 11:49:00 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565B880B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 11:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842981; bh=iYy69PPBRg3Bpe2NIwkllDA
 T1ZgQcmRAudom4WGBfh4=; b=WGDv0b7mkGuuMUZ/6qWAUQb1Ughl21wKwfjZ0pJ0juq6edi9iQ
 NWuLoz9dKmhwbV36QXCbmRbTt7bCIeq/HSaJBBoERRqWtsKjGQo+BiCvnXifnvXmbUj1tJ5FvZW
 6Me9Q+K0oU3Qi/tOGxwbs5HXKpnkt6x+em/dH+q7AADTET+8B4auGEHXJJwA6F7kzEJ5tQCT1xo
 MgcRYdFV3jmQivummbzGm6itW1UBISzq+600hhHG98r040pjvLUiXv4dv5382cwlay/Ha73bWj2
 C6rP46042kO6BzEGyPbQgQRka9YrNI+2Fvg70nM9DEQ2st48sxRfLzAB94jtEE20o/w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842981; bh=iYy69PPBRg3Bpe2NIwkllDA
 T1ZgQcmRAudom4WGBfh4=; b=w5A6BghQRkiR6bM95X6+wE98+HAsa3DBFcUhH3qXcRTD26EF7o
 LUiSLvMiSl4yge9aPp/Iqj9hh+N7aa4PYzCQ==;
From: David Wronek <david.wronek@mainlining.org>
Date: Sun, 14 Sep 2025 11:42:35 +0200
Subject: [PATCH 4/5] qcom_defconfig: enable pinctrl for sdm670
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-sdm670-v1-4-a344024062ab@mainlining.org>
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
In-Reply-To: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757842979; l=670;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=ve94gICE0hdgknEQ2iHk458wcwoN/zbU7O303aQuRow=;
 b=GOMQy/C3b3xGsfm/1QNZ4F7z9dC6c2cHV4mBdmsB5MLy2Q8uh2tsUacv5C56IwzK9UPGdhobm
 HFcXEkGLLefCYFs70lj6pWI2rm+/8I6EolJ9dBIylRHqXv+alB900Yt
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Enable the SDM670 pinctrl driver.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..06e48e525e670f9304177879744f0a466ed79c9c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -110,6 +110,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
+CONFIG_PINCTRL_QCOM_SDM670=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8150=y

-- 
2.51.0

