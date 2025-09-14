Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BBECAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0841E83423;
	Sun, 14 Sep 2025 15:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="ZYiffMkg";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="2neJpPVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E55582A9E; Sun, 14 Sep 2025 11:47:39 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A6E580B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 11:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1757842979; bh=YobRv+uGLAO/PZWfW2oWSLd
 c1EikiKgnzAQEI7M075E=; b=ZYiffMkg8w4+/jEOdKrEqdEJyxim1lCPWoW1Kd9z69r8Kpg5Sb
 BXYb7vuSE0MzbkBO4yVWai0JvN3BiQEW+UXOx8CBknjZyF47Qwf38cUVQp/0JKwdeG0613UR9d6
 09uOjdNrMGhH137SjXX0QPBXKKiFdcKggp/3A01d4IpCckXFej4MuZ2QrkeKu0bJ0Yjwrh6a0ng
 A9tO6jgD/A5wmesM62wvuoL7cJpdUWYZcbB+DpevL2R0CpFOyx39X/9unaWOsFS50nQ/sSOFJzk
 8dp3CguGOEw1rx3hRQ1sv9WPl12sb5Cv3nl52pX4fHV8EK2SqBGGt/Zxn8NFxHqnS6g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1757842979; bh=YobRv+uGLAO/PZWfW2oWSLd
 c1EikiKgnzAQEI7M075E=; b=2neJpPVrooS262Lr/KRkyvsfhbmk1228BFWOaTEp+SuenZaQeE
 9bdL2qM1T1xfilt6LvLvLN/sLGYjy63kEoCw==;
From: David Wronek <david.wronek@mainlining.org>
Subject: [PATCH 0/5] Add initial support for Qualcomm SDM670
Date: Sun, 14 Sep 2025 11:42:31 +0200
Message-Id: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAeOxmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MT3eKUXDNzA93UlFSTJCOzlGRzIwMloOKCotS0zAqwQdGxtbUAFC0
 sf1gAAAA=
X-Change-ID: 20250914-sdm670-ede4b26dc720
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757842979; l=1015;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=50tFDfGd3kF04L3HC50IT1wsSLOUY/JVT8mjr7l0QiY=;
 b=gLjnzL3msLI04A90FIhNid84TSp3AytwsD9rSCL0qRFSyRJCFzYPC8XRgSh4+7gTkLzF67BOI
 P/IpKiH43tPCma8eDOh2eGIegiKpJAshxdh4fvb6krt1OKP704cn9D7
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

This patch series adds support for the Qualcomm SDM670 SoC, used in
various Android devices like the Google Pixel 3a.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
David Wronek (5):
      clk/stub: add sdm670 rpmh clock
      clk/qcom: sdm845: add support for sdm670
      pinctrl: qcom: add sdm670 pinctrl driver
      qcom_defconfig: enable pinctrl for sdm670
      gpio: qcom_spmi: add pm660l

 configs/qcom_defconfig                |   1 +
 drivers/clk/clk-stub.c                |   1 +
 drivers/clk/qcom/clock-sdm845.c       | 127 +++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c         |   1 +
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c | 252 ++++++++++++++++++++++++++++++++++
 7 files changed, 390 insertions(+)
---
base-commit: 210702ae6ce820713773549c4e102b37f09d7cc5
change-id: 20250914-sdm670-ede4b26dc720

Best regards,
-- 
David Wronek <david.wronek@mainlining.org>

