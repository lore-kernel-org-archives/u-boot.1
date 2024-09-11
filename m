Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F584EE0208
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 17:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982D7892CF;
	Wed, 11 Sep 2024 19:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="tPqcBBen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF0E892E6; Wed, 11 Sep 2024 19:13:22 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564CB892D3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 10E1D240897;
 Wed, 11 Sep 2024 19:13:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 3B489240560;
 Wed, 11 Sep 2024 19:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1726074798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FpgXVDhVbPADQxKnRq3foUO3W4z4Epbiv2PwcFXDaNI=;
 b=tPqcBBen27un6TSLl1WYvfQUvM5Gt1H43OqDKbFwTrcdBHDFfslVDatzHjUgrKhYFCDuFL
 AbHcyZJjjvZYhqj8stPDgdoBeoxnk3Ri2wh9oz0/jUJAk4DSGvJ9BIICrGsIqcHT5c4aHh
 TRxFeUWrGFJ6Fjjc39UU0hEV5r0bwF5jHfX9YvY1IT62SF/R22F65ebcc9OXXrBQ7Aw1z9
 70Z6VFQON93pt/6CTdu2UjoTxdiOpbYVYA63u/XzmC7dH41l/e4CerD4WvygOEAjc0sOKq
 e7/ZXOY3R2Vwpeunc8qNKgnYv3bM+uPACfjCt5kS59NXvPyjdlq3NTUwkQx5bw==
Received: from p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id BB9F92404BE;
 Wed, 11 Sep 2024 19:13:17 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Subject: [PATCH v3 0/3] Support for Qualcomm sm8150 SoC
Date: Wed, 11 Sep 2024 19:13:08 +0200
Message-Id: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTP4WYC/12Nyw6CMBBFf4V07ZBOS0Fc+R/GRWlHqZFHWmw0h
 H+3EBfE5bnJOXdmgbyjwE7ZzDxFF9zQJ5CHjJlW93cCZxMzwUXBa+QQuiMqDqOeTEsBlKqNEUW
 lLFmWpNHTzb234OWauHVhGvxn60dc118qxZSSqHLJKy5KQHhS2+n+8TpbiqPLLbE1EMVOQvz/j
 wI4cC2FKZvSNqh39rIsX8jaghPgAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Julius Lehmann <lehmanju@devpi.de>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=ZDDAnVHItBZnl4NEU5eoCUaTYwkN1ENPNHPNXVfW+hw=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm4c+t9VRfHms0+nslk0czaasNSEFjYv24xo6hA
 uKv5wMp/I6JAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZuHPrQAKCRAStku8QtBB
 AxdaD/99QG9is3aqiLUO2zmaW2ReJvdxM5HP5Q3J6XPa+PYYJXRufl1WvbyVfwlwFULP5w4e0th
 nqgNPnGjI/MdtFHa5pDESjCrkp+jMgXH6h3r/LZXrVelxW5NAStPF1o3nK5EdGX7xQFlM/PDP+L
 ssmynU4neK06OrnYqO9vjYrcBwtbo9mWsbQojsHXHNBgdpg9U/POgOo6W6gN/bRKV43Wm1Ua5lN
 S2r6pVKRi3P9Rk9H6DTmQiHdm51MtMP/ouvBWLmCAVslZm0GMrvWgMCUgkmLGAIOGFhFl8TSyWM
 8JX4IcnxGJj0M/JLEm0l1LGMR44RJm2nfkKIe/9p8ASbqUAnFdSA+wmFIbY7SkWIelcORIVsVCk
 WHj3t4ac/zoP4TzyU0HgE538fcWSqG63fIqImMyxx6i5rTGsl1sUs2AnCsabmWKKPMmLbMAO3DN
 Wo1KMexoRNSZo9kxw/Yw0qBbu91P/5Hs0Q/tZWPhVsQ9/hDLBOGsV9lMfFcXboD5vBqk40piR2U
 703AzGc/kY6pifLYY4IS9UdtZvkuhJjj+Gukr4mf93U0i8uF93Ogu+LNe2WWqakxbNKVImRWCS7
 u/GW6v2/q/8bjqip0SHXJeQxsEllTA0XaQ0p3pMNR4iULuNCMk8Ayz2dsapJ4PJ8+FzieyPpVuU
 3Ek4GxK5Bgvwexg==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: efd343
X-Rspamd-UID: c9de7d
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

Fixed wrong register values in sm8150_clks, alphabetic ordering and added GCC_SDCC2_APPS_CLK rate setting.

Thanks for all the help again!

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
Changes in v3:
- fix: config: alphabetic ordering in Kconfig and Makefile
- fix: clk: qcom: sm8150 if expression in clk_enable now correct
- add: clk: qcom: sm8150 initialize GCC_SDCC2_APPS_CLK (similar to other clock drivers)
- fix: clk: qcom: sm8150 GCC_UFS_* clock registers were wrong, copied correct ones over from Linux
- Link to v2: https://lore.kernel.org/r/20240911-sm8150-patches-v2-0-0a32c6b6db1a@devpi.de

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
 drivers/clk/qcom/clock-sm8150.c       | 319 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig          |   8 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 156 +++++++++++++++++
 7 files changed, 496 insertions(+)
---
base-commit: 78d898eec080b02059c8dc09318b8761044fea85
change-id: 20240910-sm8150-patches-559cc2475ded

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

