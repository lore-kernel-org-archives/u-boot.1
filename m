Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE9CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D10B8384C;
	Fri,  3 Oct 2025 14:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="HXw7PTjt";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="84uTY0eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E66836B4; Fri,  3 Oct 2025 12:10:36 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18128366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485672; bh=wM8w6FpF2mBTh07RcsP1t9/
 bX+QNYXqnTd38zrncF6w=; b=HXw7PTjtRFT4Gq7gawrdQyQAYOSIWE/L53RT3OIi3ZRg05Jip8
 2QZoByLywIpaEIpTNhdsr/flwaQEmbzMi1pAxwIn6sv02Jgz02QV5h1sS+fgBBw8VU1+JS+U9Lk
 0LEYeKrKNrDXc7B+fqHUwiyVJ5tLV+KRgLOIrairs4CNvFNRFacYQ4tVJWMKwDtlCklGkk/MBsA
 U9YhQkVBTiAl9qsmhz0x+eSgyuiijTGBsRl/ZQjZSUByO8m+7AoXQ0ZLuFmMfYHjOCJiYIH/c87
 CqYwZlb2/Xf/fyoyFwTF05GQCBpNBzc6Ik2toXeKUOsxRZ0pLmdTdb9itKXl7AGG5cw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485672; bh=wM8w6FpF2mBTh07RcsP1t9/
 bX+QNYXqnTd38zrncF6w=; b=84uTY0egcbgocHhKUg0cHrMejYRbHhvetF4bV1ZLOBsfyvJEPg
 7oS1kzL4YmONBnoKYHQ8Egx0P4ILw60lWlCg==;
From: David Wronek <david.wronek@mainlining.org>
Date: Fri, 03 Oct 2025 12:01:12 +0200
Subject: [PATCH v2 4/5] qcom_defconfig: enable pinctrl for sdm670
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-sdm670-v2-4-52c0fa481286@mainlining.org>
References: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
In-Reply-To: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
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
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=669;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=uJnjw2x5yKv/IEdnQpoy8HUAvT4P0O0bjRPs1SH2zRw=;
 b=YVBpGZN9OTW7e0pYtMk8KcekrHAHpfflQScJegcEkrS1AzmeCZat6QjgshuO8XI4P2wCCLHnJ
 VePicwHUwPpDiORASrYFqc7w/VvTc4Y1RhROERcGS9B1pqbwdZI6ct5
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e77..06e48e525e6 100644
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

