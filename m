Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4BBCD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 13:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BCB84843;
	Sat, 23 May 2026 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E8zCCxS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23877847B0; Sat, 23 May 2026 12:26:07 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F8783E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 12:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+federico.izzo.pro@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CB5086020A;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68BEFC2BCB4;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779531962;
 bh=UGizBJzAX+AViqLU7jMsIR/oOO6fQU0HyiC5Xx8GsKc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=E8zCCxS9qFZpaoQHCeEonwJiCNoj2z8gX/nqO2u+jcB8LzrCn0Ti9e0wk6GBxp1YM
 IS2FNez6CkuGGBmSzKWm2s5xLbNpa3f518qdda6340408Aod1ktEt68/0z+wHhpU7M
 wYaPM4x1wx8I3+wjQuRii3jmL3xkoyZWQcieloxCjDcKlKHCJAZ6r/gevKjZXYrhvy
 lH7on6lDk/kfgXE7Uw8WSlSYZmph56UYFPPAe7uA+x0S7Mll8MX0qwDKtMiapI1wSm
 kiR6eQIZHX4BMyjAY3nr7x4hvL9AeAaAIYGHoK+Hg0ni+OX2WkVN8kJjxhjfgdFGcJ
 D/kUuQ2miw60A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 542D1CD5BB1;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
From: Federico Amedeo Izzo via B4 Relay <devnull+federico.izzo.pro@kernel.org>
Date: Sat, 23 May 2026 12:25:51 +0200
Subject: [PATCH v3 1/2] regulator: qcom-rpmh-regulator: fix regulator mode
 mismatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-qcom-ufs-regulator-support-v3-1-1be2a80a2577@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779531961; l=1222;
 i=federico@izzo.pro; s=20251017; h=from:subject:message-id;
 bh=mMP8o/Jp8TjuIhb6AjVw+YfOd0lr+gWRIANKnyT1Oz0=;
 b=gIZUkAKMz6ZTMy516CiaQPLAG9R8/I8NbK7GAp4I2EFiGHFRJpQYZbd3jJ+7UOwIrChwHOb95
 vaUchT4kDDFBGidPyXQuvl0lqIubHKER4VKycbreQF6DLDYPvscjE+G
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

From: Federico Amedeo Izzo <federico@izzo.pro>

Fix issue where regulator mode could not be set to the
"regulator-initial-mode" value from dts.

priv->mode was initialized to "regulator-initial-mode", but this could
differ from the actual regulator mode.
In this case rpmh_regulator_vrm_set_mode() would return early, thinking
that the mode is already correct.

Setting an invalid mode on probe solves the issue.

Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 4d65aae1690..06c3c14c46e 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -882,8 +882,7 @@ static int rpmh_regulator_probe(struct udevice *dev)
 	priv->hw_data = init_data->hw_data;
 	priv->enabled = -EINVAL;
 	priv->uv = -ENOTRECOVERABLE;
-	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
-		priv->mode = -EINVAL;
+	priv->mode = -EINVAL;
 
 	plat_data->mode = priv->hw_data->pmic_mode_map;
 	plat_data->mode_count = priv->hw_data->n_modes;

-- 
2.54.0


