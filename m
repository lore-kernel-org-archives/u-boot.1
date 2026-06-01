Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB379CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE028496A;
	Mon,  1 Jun 2026 14:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SN/P2jXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D12847C3; Mon,  1 Jun 2026 10:13:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432B984862
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D72974465C;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6109C2BCB8;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301572;
 bh=nev4UkvLB0/iVpaAiKxs441aVlCidPc2Pv9pJu5uJDY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SN/P2jXfYKJKY7OOXeT9lQKwSzFQfrYB5gBZVaY+0pI9i/Cl0T3bgCzrUZJ2HEbZL
 YRF5b0mZAJ4kKzRrl83HYFS0VcpoAukCPVmRaWYQnJ2VQd/CUH5OUlDZyv9vmrOBIx
 tUQ6e1RRBAJIjUovl08NOFm9cZdwuYkPgOo8NMzIMR2Q9FD1YzGuJQ+SgdSRg6vpq9
 DyrohMZLiWuc23UptoeQMPfKkZvzG1GNvvwUdj/zwS/p8TqtvFuG5vdGzGWIA2DZzg
 vTA7+gr1SwSE64kp0LrNWqBcx35VGSnWIxB/+o0e9nzccKGt6L6W93XyLY3VQWaB8+
 ABB229AU88V3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ADF30CD5BD1;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:51 +1000
Subject: [PATCH RESEND 10/16] pinctrl: qcom: configurable GPIO
 offset/stride
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-10-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=2547;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=6bPzR204m6EqF0qblxuJserSk3E5YIYcDCv48l6t78E=;
 b=2ocu89xIu6mXSy4gfcnBJi+ui2u9sF9ai0pClDff+dMGP0/me3Oe6QVYtMD3mwfjIuR0dQDsj
 CM103NGau3dDTmu4zWDPY0tyjkQ6ZxMLr6vjFa8Kgi9InJbAnc10gAM
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

The infra currently assumes that each GPIO register block is 0x1000
wide. This is not the case on older TLMM versions.

For example, the GPIOs on MSM8960's TLMM hav an *offset* of 0x1000,
and each register block is only 0x10 wide.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/include/mach/gpio.h | 12 ++++++++----
 drivers/gpio/msm_gpio.c                      |  2 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c          |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index 11e8104baf2..49bf480c903 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -27,16 +27,20 @@ struct msm_special_pin_data {
 struct msm_pin_data {
 	int pin_count;
 	const unsigned int *pin_offsets;
+	u32 gpio_base;
+	/* defaults to 0x1000 */
+	u32 gpio_stride;
 	unsigned int special_pins_start;
 	const struct msm_special_pin_data *special_pins_data;
 };
 
-static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
+static inline u32 qcom_pin_offset(const struct msm_pin_data *pindata, unsigned int selector)
 {
-	u32 out = (selector * 0x1000);
+	u32 stride = pindata->gpio_stride ? pindata->gpio_stride : 0x1000;
+	u32 out = pindata->gpio_base + selector * stride;
 
-	if (offs)
-		return out + offs[selector];
+	if (pindata->pin_offsets)
+		return out + pindata->pin_offsets[selector];
 
 	return out;
 }
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7de332c66ae..a24d0f03398 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -29,7 +29,7 @@ struct msm_gpio_bank {
 };
 
 #define GPIO_CONFIG_REG(dev, x) \
-	(qcom_pin_offset(((struct msm_gpio_bank *)dev_get_priv(dev))->pin_data->pin_offsets, x))
+	(qcom_pin_offset(((struct msm_gpio_bank *)dev_get_priv(dev))->pin_data, x))
 
 #define GPIO_IN_OUT_REG(dev, x) \
 	(GPIO_CONFIG_REG(dev, x) + 0x4)
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index c95db56bc47..82817c2316f 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -30,7 +30,7 @@ struct msm_pinctrl_priv {
 };
 
 #define GPIO_CONFIG_REG(priv, x) \
-	(qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
+	(qcom_pin_offset(&(priv)->data->pin_data, x))
 
 #define GPIO_IN_OUT_REG(priv, x) \
 	(GPIO_CONFIG_REG(priv, x) + 0x4)

-- 
2.54.0


