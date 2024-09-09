Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C24AEDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08BF88BFA;
	Tue, 10 Sep 2024 05:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="rZGEOUWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A4288E14; Mon,  9 Sep 2024 17:53:22 +0200 (CEST)
Received: from smtp9.goneo.de (smtp9.goneo.de [IPv6:2001:1640:5::9:6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC1388DC6
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 17:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp9.goneo.de (Postfix) with ESMTPS id D821C240446;
 Mon,  9 Sep 2024 17:53:18 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 4AFE6240591;
 Mon,  9 Sep 2024 17:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1725897197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hUEQs2gh2CqPsZaA33gkx3NpE7grftmJ/vP8hgZj3DM=;
 b=rZGEOUWdHVRTUK+ZbUc2lAobKG/RU/XJ12fDpW17aWdvNN2Q/jToXFtBkGt8+XxBPTk8DW
 SrjLzWZFXHNdYPnA0SSGvc0HdI6DD03VUj+NST1yiTcgWOLJdiqwP5MKuteIBqpQUviRmf
 oQV22XaaJa8ZTJ+ALD8rBhfGhuRHI8PEtdOFw60OKyBtS92QnbW9Z1i8zAtfGR9peIucmz
 eWn7wfe/wOzD2aA1Rhu0A4KHuf9Q9EXvMbdfYMqxRihU4nMF/iyzqhkYWGLnH2XqkJW3q3
 npSGwaexsTbFRKKyftycrOTVDHVurny3GUKcrQJO6ChSs+whxqqd6WSLRLfbig==
Received: from thinkarch.lan
 (p200300cbef069810000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::76d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id C9D4B240564;
 Mon,  9 Sep 2024 17:53:16 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
To: u-boot@lists.denx.de
Cc: Julius Lehmann <lehmanju@devpi.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-qcom@groups.io
Subject: [PATCH 0/3] Support for Qualcomm sm8150 SoC
Date: Mon,  9 Sep 2024 17:53:09 +0200
Message-ID: <20240909155315.307026-1-lehmanju@devpi.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 84522b
X-Rspamd-UID: 4efb3e
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


This series picks up the work from Volodymyr Babchuk ([v2] Add support for Qualcomm SA8155-ADP board). clk and pinctrl drivers are adjusted to work similarly to existing qcom drivers. I could only test this using android boot chainloading.

This is my first patch ever using mailing lists, so hopefully nothing is missing.


Julius Lehmann (3):
  clk: qcom: add driver for SM8150 SoC
  pinctrl: qcom: add driver for SM8150 SoC
  config: qcom: add sm8150 to qcom_defconfig

 configs/qcom_defconfig                |   2 +
 drivers/clk/qcom/Kconfig              |   9 +
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-sm8150.c       | 298 ++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig          |   8 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 119 ++++++++++
 7 files changed, 438 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sm8150.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c

-- 
2.45.2

