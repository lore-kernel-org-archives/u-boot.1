Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C195BEE021A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 08:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420D7891ED;
	Wed, 11 Sep 2024 10:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="lzqAr5LH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11069891ED; Wed, 11 Sep 2024 10:42:36 +0200 (CEST)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4588921B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 6A004240ABF;
 Wed, 11 Sep 2024 10:42:32 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 92B52240563;
 Wed, 11 Sep 2024 10:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1726044150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gviti9z8XMD2LqWqG98eY0fr8s6XF731q6g1wZWR93c=;
 b=lzqAr5LHtml1kGu3kAiA+MEbLhhhR5F5EMLyb4lmwSPmEJDkDp28btGKWTDA5LY90IlAud
 0CZTkjJDwyJLRNPzRsJaITYW73o+5WBuWtlYQo1R+UwhkWp7WAEwgTwaa0wUaNcRo3VADu
 A9RpHAekVGwIFTwvbDBW7Qb3wMBfcrR/NskKqLnmpXyqmR0sj42oXwe9Ws+OzJcShN1/Qj
 75XFImCOGPa+5IYhlZTwB//k078d3dyrfxqR17vReRjZ/oC1jtpJBO6zu7N0c1cmbv3Ran
 kJMWCr210QLr+fMQEjNsGlAf/xICMQQWLv+idFIxDreuD2UdOPY+pRim1kiaYQ==
Received: from p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 2D4FC240562;
 Wed, 11 Sep 2024 10:42:30 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Subject: [PATCH v2 0/3] Support for Qualcomm sm8150 SoC
Date: Wed, 11 Sep 2024 10:41:59 +0200
Message-Id: <20240911-sm8150-patches-v2-0-0a32c6b6db1a@devpi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdX4WYC/y3MQQ6CMBCF4auQWVvSFkbElfcwLJp2tGMEmhaJh
 vTuVuLyf8n7NkgUmRKcqw0irZx4nkroQwXWm+lOgl1p0FK3sldSpPGkUIpgFuspCcTeWt126Mh
 BOYVIN37v4HUo7Tktc/zs/qp+658qGGKjsG5kJ/VRKPEkP5rp8bo4WgPXjmDIOX8B15CZ8aIAA
 AA=
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Julius Lehmann <lehmanju@devpi.de>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=niHKyAulf/RjMKsqeT7gnKRJFuw5VM1iuwpdE2XN+T8=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm4Vf2CRHGM24VAYeJK+ZWjAuL7iKSI2ZErF0Cz
 hAqlIt4fB+JAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZuFX9gAKCRAStku8QtBB
 AwPlD/9U487nOV80q79YnWg9pioHduacS6W/0aniAEyVn3ZJKoFfEQKE6miEHj1SDn7s2n3+QkU
 WRI8OB4dwBOj1ylqO7z0JkymzW5WzKdNAWKph84xOWeV5pgZSCRhzM0/ikcDXldSz44qASJItL0
 koOOj8YJJTeeanXmVKj+ePFW+2Wl0gD/C93qwDGx1xvIFiN+2LH1EMw+kq5UIceGhN+j3qunRiS
 AqwJ2Yo8dytrF9CG0JBn5+2kUEPZUdRzDlejBNLY4nuHADIQoewzDj+9O6GleKE8bqvc2PerKPu
 UiR2wcZife/0BKenrFpVXZlMkArCKCT5PqZFISkjlFBWSB1f3Kl1WH3CYFt082r8NiP11vx78bh
 22XCBhR7jB9iEsCyKopuOSp24ppQwez9tijk79cbJDBnw2rPAkROj1GSUoSTDTUJll7x4pR5tWK
 ZLJYwDUdmw5495ux/V8O2gwuuc3pB2DMmDIU2DLGWvV49w6CwWNaw0rljvvWheD+8/wJhu8WRPX
 9fz1EkYhwV+woEeBoDGNBJ1SnkwR/IOZZSHrVIkbHLTtbpBq9RVms/lVL/kXvusSakIs91YdYKh
 EHuqp1zP2vow78MOdds7k42aMe0rtQV4mw2JZIpYjvFL5YE0Cn+CJmkCZXAgnV89nUBRwZsjO+B
 zdwwRdzhc8uta6A==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: 1648b9
X-Rspamd-UID: 270284
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

This series picks up the work from Volodymyr Babchuk (https://lore.kernel.org/u-boot/20240306005230.2638972-1-volodymyr_babchuk@epam.com). clk and pinctrl drivers are adjusted to work similarly to existing qcom drivers. I could only test this using android boot chainloading.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
Changes in v2:
- fix: clk: qcom: sm8150 command registers for phy_aux_clk (usb)
- refactor: pinctrl: qcom: sm8150 use special_pin_start and special_pins_data
- Link to v1: https://lore.kernel.org/r/20240909155315.307026-1-lehmanju@devpi.de

---
Julius Lehmann (3):
      clk: qcom: add driver for SM8150 SoC
      pinctrl: qcom: add driver for SM8150 SoC
      config: qcom: add sm8150 to qcom_defconfig

 configs/qcom_defconfig                |   2 +
 drivers/clk/qcom/Kconfig              |   9 +
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-sm8150.c       | 300 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig          |   8 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 156 ++++++++++++++++++
 7 files changed, 477 insertions(+)
---
base-commit: 78d898eec080b02059c8dc09318b8761044fea85
change-id: 20240910-sm8150-patches-559cc2475ded

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

