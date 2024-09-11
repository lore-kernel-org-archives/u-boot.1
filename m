Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946C6EE021C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 08:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716FF89229;
	Wed, 11 Sep 2024 10:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="Df6bTpJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC0389223; Wed, 11 Sep 2024 10:42:37 +0200 (CEST)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5201189227
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 285B5240E47;
 Wed, 11 Sep 2024 10:42:33 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 88B6E240594;
 Wed, 11 Sep 2024 10:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1726044151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKHAe7BXbQ3YkPkOaekntq3bzb4mAdQvjokXgMtPZF8=;
 b=Df6bTpJ+D6GIl+hT0sv6Ejq+3CXsKOvyIBJV1ld++kNW4S/kpxxai06u5RnJml2X2wopD1
 jYGoBzZu9JQ2GEaAZoVewTJbMgIZ84ztPhPwC0Js+uZfoDP7vCqJV+Oju9ooWmTE9Ko3a1
 lpq4MsosCfRdNguK8mkLQ/QlBwSpDHwgwMFE1PpI6DvHc2TYKDLWEEBvJI+4NOuuBxmyhD
 MKlpNqeIjMv1KSQTMiJXEyidcJUnXOaVXpdfDJ2bZ6bSInW6HV2WopXZISKOyrQ4VZJoxX
 /wHfx1MX4F416MnDcfkZkLo3v5hkMB8NPK0efmR584LJLVQ/KetyoGFvtaQqmw==
Received: from p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 46423240569;
 Wed, 11 Sep 2024 10:42:31 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Wed, 11 Sep 2024 10:42:02 +0200
Subject: [PATCH v2 3/3] config: qcom: add sm8150 to qcom_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-sm8150-patches-v2-3-0a32c6b6db1a@devpi.de>
References: <20240911-sm8150-patches-v2-0-0a32c6b6db1a@devpi.de>
In-Reply-To: <20240911-sm8150-patches-v2-0-0a32c6b6db1a@devpi.de>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=oNBbcWNgDCJphgdn/npwgHreKpSBl6wPVj3pKZatVFw=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm4Vf2UMVVQ8oenU69d5CliH65x0szFdgkGO7Jf
 7P1qIKd3ZWJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZuFX9gAKCRAStku8QtBB
 A+NID/45x3tW7JEVlV26a3AvbSOYtnWhq5KpKQv4bib+MvuUOm5vH4rRtM1VPe+nlVVzklQfSzW
 nH+S72BshK8/FoMbkl/cVfVtGBDkj9s/Lh++Y3Cl8JbgC7Jb7IBG5Ie6cmLxA1ZT6K12u9YKlno
 2nRmf7cq93CBRPjAbmTer9y8uy4GRA2u7TJzNHiw/6V6xsbYIm3ikUBEhr268PpZt8RoJzqFPk4
 Fp8IH8JfyZgNDnHnxIHG0bFlofxZKdttD1rSYyUb8k/WIgWF2zljDVG7xyZOPD5lkE0Fq7TfVig
 cT7Oh00hcCgsaqrSQGTAA37zH5+CkOWoWlPxQyZIIQQ6Log2PYfL+bGGJdkzYqR7nwpKyb+UG0t
 NXmNqXdUn/JjT7+Xe0YwXahMYKh62uh493gJo+7YSMhwVJx2SN9pdAPuG3ATEus4qHslGqmyQq3
 vCadYW2BPKIxZ/7bkj7VGJGVP1TdMkRq/TXh8a0vHAG9bLuuLH31p3BPquVNY17+Hr4huP7QiJ6
 uKHCUPjx1xNSw2BpaiF32YylLoKs69OrUHklbN2y5eb6oAlfX8/vFRn/Tbq/qJHr60JpiWQXaGo
 vbiSEg9otxDesj839qggHkMQWzpelJLTf7ILkK849r7ClmnM0oWctHj2xSqdDZk2JNM/d/HbktU
 s02dIUcbYC0d5gQ==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: db97d2
X-Rspamd-UID: d63510
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
index 2a2253f766..5b46f43b11 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_SM8150=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
@@ -89,6 +90,7 @@ CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
 CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y

-- 
2.46.0

