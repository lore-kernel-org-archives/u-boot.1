Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D5ECD5BBF
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300D684894;
	Sat, 23 May 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kI71gLas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D871483E81; Sat, 23 May 2026 12:26:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EB8846FD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 12:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+federico.izzo.pro@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88BFD40558;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F7B5C2BCB0;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779531962;
 bh=BNeNAsIEjtakdZGKY2bfmyt0EsEyor0COka868FsyO8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=kI71gLascZv8KHYQuM2zQH4mqpav8m56YkxDQY4NSZRlBL7z4LYuvdKH/ayFuTaGI
 yc/VLdwqjsNjC6IktjkfhFwh40gWqwaCJAGgQGfPXInCPhZbcVgk/cNVv5PwMZmlsF
 RE3t+VlhWf0vGQl/39540hg3+tgh6wAKCPT5UuxKz2KgRqjAJ5EOEhS0hnY4uqj/X9
 WbP4Max/krmZZN5GNdIR0m9au4Wec5zk8Pg3Sy1buH1xHHaBresWhCuZq8WraEfMEX
 4YhNSDMZ4a9hZhFoQf2VnBgveV93b9L0zAU5XRqZUVQepe1ZmS+/JA5f7ED18fi8nF
 usz/r2qyW9JZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 460AACD5BBF;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
From: Federico Amedeo Izzo via B4 Relay <devnull+federico.izzo.pro@kernel.org>
Subject: [PATCH v3 0/2] Add regulator support to qcom-ufs driver
Date: Sat, 23 May 2026 12:25:50 +0200
Message-Id: <20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PSw7CMAwE0KugrDGi6YeKFfdAXaSx2wYBCU4T8
 VHvTloWiB3Lkaw345fwxIa82K9egikab+w1hXy9EnpQ157AYMpCbmW1LWUGN20vEDoPTH04q9E
 y+OCc5RGKqiJVKUy3SiTAMXXmvuDH5pN9aE+kx1mcLzpO2Dgwqd8SdAEUIqB3DnoNyCYSQ8wgg
 zrPd7Koa426O5jn024c2xkbjE9rHssrUc6lf62OMqGYk66lohJb/UWbaZreAI8SSCIBAAA=
X-Change-ID: 20260521-qcom-ufs-regulator-support-466ea6ad202a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779531961; l=2012;
 i=federico@izzo.pro; s=20251017; h=from:subject:message-id;
 bh=BNeNAsIEjtakdZGKY2bfmyt0EsEyor0COka868FsyO8=;
 b=6eX9ICsNI+Hre8MSZtguERN9xpFukKkSB+RgkhVAlSrZ3HdpcxBBIm9m3JX9APpNh+ZywD1rR
 dA0o1YLv1F9ClilcbhVs+ZxvNAfCtsXXkzuywD8JuxBqZtil0nXilOX
X-Developer-Key: i=federico@izzo.pro; a=ed25519;
 pk=XfmNfpH48k8jLbId5NKrp0yoKoFb/uLjr97qIxBImBw=
X-Endpoint-Received: by B4 Relay for federico@izzo.pro/20251017 with
 auth_id=544
X-Original-From: Federico Amedeo Izzo <federico@izzo.pro>
X-Mailman-Approved-At: Sat, 23 May 2026 15:58:45 +0200
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
Reply-To: federico@izzo.pro
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series enables UFS support on SC7280 devices with UFS3.1.
SC7280 devices with UFS2.2 were already working.

The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
devices, and enabled on UFS2.2 devices that worked fine without
regulator support.

Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
---
Changes in v3:
- Fix bug causing HPM mode not being applied. Removed LPM/HPM hack
- Read regulator mode from dts property instead of hardcoding it
- Link to v2: https://patch.msgid.link/20260521-qcom-ufs-regulator-support-v2-1-d3ec82ae5dbc@izzo.pro

Changes in v2:
- Add vccq2-supply for UFS2.2 devices without internal eLDO regulator
- Fix wrong topic
- Link to v1: https://patch.msgid.link/20260521-dpu-add-dspp-gc-driver-v1-1-83372488cdcf@izzo.pro

To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Federico Amedeo Izzo <federico@izzo.pro>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>

---
Federico Amedeo Izzo (2):
      regulator: qcom-rpmh-regulator: fix regulator mode mismatch
      ufs: qcom: add ufs host regulator support

 drivers/power/regulator/qcom-rpmh-regulator.c |  3 +--
 drivers/ufs/ufs-qcom.c                        | 33 +++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.h                        |  4 ++++
 3 files changed, 38 insertions(+), 2 deletions(-)
---
base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
change-id: 20260521-qcom-ufs-regulator-support-466ea6ad202a

Best regards,
--  
Federico Amedeo Izzo <federico@izzo.pro>


