Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395FAC5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 064E78149C;
	Thu, 13 Aug 2026 20:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RNDJTGt3aIR; Thu, 13 Aug 2026 20:17:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A75981488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652275;
	bh=mE+LfUwTJbR5Np/MCDaekYb+tUW9OZvgFXvT61B6FeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMWrD08dAuknLkhBRwAAcNBe85xedV3cGChZ4OM1zHcePLnrmb27R+9s+dtty/jIZ
	 acMP8A/A5QjE1KkezYel1zoPor9NIG5HJhkCtsOWSHrDFCPHq6BeSlD69SyETplgfz
	 8g+8lkXrpRJ7B/IOccoG5uoSdh1xNxrarCQso7IVGi7z78ZLSJPlZQd3Bi/sGsWB8A
	 YYzbWZmKNTQ5W+mFLwGP4dqLBFYTLL0ZQhrVovyMLXasgr6+BUlCk1DT24NrZzIkUr
	 pyjokKwsAn+lH8zqZYEBUhSu6Y3PFOz7Zgc9Yf/IOmQA1Baz050H76V/NFRvidDHH6
	 Pm2Kiqeugmn2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A75981488;
	Thu, 13 Aug 2026 20:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC633DF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A277C40147
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewaD57486TjM for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 40F5140106
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40F5140106
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ef32Q5Kx
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40F5140106
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:26 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6aca0f482e5so265727eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651165; x=1787255965;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mE+LfUwTJbR5Np/MCDaekYb+tUW9OZvgFXvT61B6FeI=;
 b=Ef32Q5KxqVnMq+T0yUAnJtMnJc3hbEAkTr8nsKG9vEfRYd4GPuc+HVw3pyXSsaHfYS
 0Zj3ez7426XgAi0MzsjWqSu7/CBkSLy+YDEYRI5+EbeE/7MLNDK0xGHbvK+NvxNWhq2N
 QLfONhG+dDQWR3wxks+2NXmV4bg+ZyujcvNBMxPNQu6ZrLCfq97/VMcjp7aDhuZEAXL5
 xW1z3eBoUrON6MehpSv3gc7L9ib7wVFo0ebU/j/0IveG63dyJkwkUKRVX12B2dNboOUA
 EUV+3e2Ym8TaLwR0lzZ0ToojP36a5y2dwAIVo0fWRI3zIKZrqnnovHxVxWIIyJjl3IX1
 ZEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651165; x=1787255965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mE+LfUwTJbR5Np/MCDaekYb+tUW9OZvgFXvT61B6FeI=;
 b=rWmKGKzXyDt/Jd2e2rv+XOeWyT+jtsAPmR7VfMK7742QQpw/biC5fTs0E20gBPFASD
 KqtE4XQKb5YpuY4SFs+KcKFfpK78kfQDVsgr5tI8ECzYR3XQXgOFpJ/VLK68g58A4N8H
 3l+Qgc/kZfs5UqjzcYliUD2u+HfLMtt10gRLZk8CId88owb9mXQR9rGDABwJ3GhP//rx
 79M8zsbplacPkBODBZOp/3KV8LtaeeeTRAYUaCbPMRbG5VTwTU2pcJsymzV5UzKeK4JW
 Jb6bFdWEwksbnQjCW18OeFcpNDqSiGBTrv+8agAyaQgdmqSqE8T201gjdsfnhC1NhS93
 +r6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZQzMd+YzFIkmoNH+XTvk5swKat1zI/fJ9zGArI+qE2NKJUti/JGgKMEHzWxBZrJiNXvAPwO4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwxkQ90PObV7uXjDVUnbgmwVW3MS5udHawGGme3IyVjg9kKRH/C
 E6K0hJw8GP5QP4dyW7qg+OyTX7U2kJNJbUVCCNBu8XMBa7sNl2ANo1np
X-Gm-Gg: AR+sD13154gIIN24ztx3o4fpWHuK6aORnzwVqrUI589kyHGbjDhjZksW6/ST54pWxlY
 AtZz349PTrf5v6PGXWgtV/vd/RZkc2szwDkQsVMuHaXvqqZp/V5iiFun6U3pqfh9GiR2lFqKb3d
 rrVqgexFqArI9IDVd7qTZPUjL2Fo+KvflcyJQbvY3aBP2TdkBNKW7wIa965DZjCx1nV8p82VKQM
 LWHIrnxJPL0FWwTh4uWkJggnPkRLD1Ma3to8BtQJgcb+ZZDF0osDO2gBag6jRUDF4BqGnSbi1Dn
 LYLqrDqg6t933RjPeyC1CeyXilMMII7uf7ZWYNc3+ofbvhNshPJ5qYhDeIvEieHMJGMx+dkA9bc
 LayymweGr2bHZCqtoA6Pth8Cr937SZvQrUAssAxBBAaFb7XIDmNew5Az6+eZXy6iv0K32WZ5tby
 0v63E9OcAreWYOpflQT2u2ftpQajG7X6tZDq/HUe6D/6JUJ9w6VNsU8Gu5Qprpiwk9bWqYOrgRv
 kr5sKsJndyUqnvUseBupUTxKUQNNfD6iFewFGZqlEtX5jJlw4nXxKARHCI//O7xtejQ+vguNfYK
 6Gk0HvzARTCte0tqujZ15UiouaDMCveqJrCNkfGpWsNG1Rebbe7II5PK97iLHcT5vTiSEZiyPDj
 o9iu0dLofLtSljGap
X-Received: by 2002:a05:6820:618:b0:6b0:b196:99b4 with SMTP id
 006d021491bc7-6b0d6971607mr761231eaf.36.1786651164990; 
 Thu, 13 Aug 2026 12:59:24 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:59:01 -0600
Subject: [PATCH v7 08/15] crypto: aes: add software-key provider dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-8-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Generic callers which supply an AES key need a provider-owned slot policy,
since hardware may reserve or preload particular key slots. Selecting only
UCLASS_AES device zero also prevents a later provider from handling an
operation unsupported by the first device.

Add a callback through which each provider exposes a slot for
software-provided keys. Add a CBC decrypt helper which probes providers in
order, continuing only when a provider explicitly reports an unsupported
operation and preserving hard probe, setup and decrypt failures.

Use slot zero for the software provider and avoid Tegra's preloaded SBK
slot. Add sandbox coverage for provider fallback and hard-error
propagation.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 drivers/crypto/aes/aes-sw.c      |   6 ++
 drivers/crypto/aes/aes-uclass.c  |  73 +++++++++++++++++++
 drivers/crypto/tegra/tegra_aes.c |   7 ++
 include/uboot_aes.h              |  66 +++++++++++++++--
 test/dm/aes.c                    | 149 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index 4ec9484c608..cd5c10cd2d5 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -50,6 +50,11 @@ static int sw_aes_ops_available_key_slots(struct udevice *dev)
 	return SW_KEY_SLOTS;
 }
 
+static int sw_aes_ops_get_software_key_slot(struct udevice *dev)
+{
+	return 0;
+}
+
 static int sw_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
@@ -164,6 +169,7 @@ static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 
 static const struct aes_ops aes_ops_sw = {
 	.available_key_slots = sw_aes_ops_available_key_slots,
+	.get_software_key_slot = sw_aes_ops_get_software_key_slot,
 	.select_key_slot = sw_aes_ops_select_key_slot,
 	.set_key_for_key_slot = sw_aes_ops_set_key_for_key_slot,
 	.aes_ecb_encrypt = sw_aes_ops_aes_ecb_encrypt,
diff --git a/drivers/crypto/aes/aes-uclass.c b/drivers/crypto/aes/aes-uclass.c
index 5bdd3d736c4..ec1ea075367 100644
--- a/drivers/crypto/aes/aes-uclass.c
+++ b/drivers/crypto/aes/aes-uclass.c
@@ -23,6 +23,21 @@ int dm_aes_get_available_key_slots(struct udevice *dev)
 	return ops->available_key_slots(dev);
 }
 
+int dm_aes_get_software_key_slot(struct udevice *dev)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->get_software_key_slot)
+		return -ENOSYS;
+
+	return ops->get_software_key_slot(dev);
+}
+
 int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	const struct aes_ops *ops;
@@ -113,6 +128,64 @@ int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_ae
 	return ops->aes_cbc_decrypt(dev, iv, src, dst, num_aes_blocks);
 }
 
+static bool aes_op_unsupported(int ret)
+{
+	return ret == -ENOSYS || ret == -EOPNOTSUPP;
+}
+
+int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv, u8 *src,
+				u8 *dst, u32 num_aes_blocks)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_AES, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		u8 slot;
+
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = dm_aes_get_software_key_slot(dev);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret < 0)
+			return ret;
+		if (ret > U8_MAX)
+			return -ERANGE;
+		slot = ret;
+
+		ret = dm_aes_set_key_for_key_slot(dev, key_size, key, slot);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret)
+			return ret;
+
+		ret = dm_aes_select_key_slot(dev, key_size, slot);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret)
+			return ret;
+
+		ret = dm_aes_cbc_decrypt(dev, iv, src, dst, num_aes_blocks);
+		if (!ret)
+			return 0;
+		if (!aes_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 static void left_shift_vector(u8 *in, u8 *out, int size)
 {
 	int carry = 0;
diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegra_aes.c
index 55a4cec525b..348115ac5a7 100644
--- a/drivers/crypto/tegra/tegra_aes.c
+++ b/drivers/crypto/tegra/tegra_aes.c
@@ -321,6 +321,12 @@ static int tegra_aes_ops_available_key_slots(struct udevice *dev)
 	return 4; /* 4 slots in Tegra20 and Tegra30 */
 }
 
+static int tegra_aes_ops_get_software_key_slot(struct udevice *dev)
+{
+	/* Avoid SBK slot 0, which may hold a preloaded key. */
+	return TEGRA_AES_SLOT_SBK + 1;
+}
+
 static int tegra_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct tegra_aes_priv *priv = dev_get_priv(dev);
@@ -565,6 +571,7 @@ static int tegra_aes_probe(struct udevice *dev)
 
 static const struct aes_ops tegra_aes_ops = {
 	.available_key_slots = tegra_aes_ops_available_key_slots,
+	.get_software_key_slot = tegra_aes_ops_get_software_key_slot,
 	.select_key_slot = tegra_aes_ops_select_key_slot,
 	.set_key_for_key_slot = tegra_aes_ops_set_key_for_key_slot,
 	.aes_ecb_encrypt = tegra_aes_ops_aes_ecb_encrypt,
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index e463d5b0c42..0c1756cef38 100644
--- a/include/uboot_aes.h
+++ b/include/uboot_aes.h
@@ -128,11 +128,17 @@ struct udevice;
  * Note that some devices like Tegra AES engine may contain preloaded keys by bootrom,
  * thus in those cases the set_key_for_key_slot() may be skipped.
  *
- * Sequence for a series of AES CBC encryption, one decryption and a CMAC hash example
- * with 128bits key at slot 0 would be as follow:
+ * Generic callers which load a software-provided key should first ask the
+ * driver for a suitable software key slot. This lets hardware drivers avoid
+ * reserved or preloaded slots while keeping the slot policy local to the
+ * provider.
  *
- * set_key_for_key_slot(DEV, 128, KEY, 0);
- * select_key_slot(DEV, 128, 0);
+ * Sequence for a series of AES CBC encryption, one decryption and a CMAC hash
+ * example with a 128-bit software-provided key would be as follows:
+ *
+ * slot = get_software_key_slot(DEV);
+ * set_key_for_key_slot(DEV, 128, KEY, slot);
+ * select_key_slot(DEV, 128, slot);
  * aes_cbc_encrypt(DEV, IV1, SRC1, DST1, LEN1);
  * aes_cbc_encrypt(DEV, IV2, SRC2, DST2, LEN2);
  * aes_cbc_decrypt(DEV, IV3, SRC3, DST3, LEN3);
@@ -146,6 +152,16 @@ struct aes_ops {
 	 */
 	int (*available_key_slots)(struct udevice *dev);
 
+	/**
+	 * get_software_key_slot() - Get a slot for software-provided keys
+	 *
+	 * @dev			The AES udevice
+	 * @return		Key slot to use for a software-provided key,
+	 *			0 or positive on success, negative value on
+	 *			failure
+	 */
+	int (*get_software_key_slot)(struct udevice *dev);
+
 	/**
 	 * select_key_slot() - Selects the AES key slot to use for following operations
 	 *
@@ -210,6 +226,7 @@ struct aes_ops {
 	 * @iv			Initialization vector
 	 * @src			Source data of length 'num_aes_blocks' blocks
 	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 *			Must support dst == src for in-place decrypt
 	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
 	 * @return		0 on success, negative value on failure
 	 */
@@ -229,6 +246,15 @@ struct aes_ops {
  */
 int dm_aes_get_available_key_slots(struct udevice *dev);
 
+/**
+ * dm_aes_get_software_key_slot - Get a slot for software-provided keys
+ *
+ * @dev			The AES udevice
+ * Return:		Key slot to use for a software-provided key,
+ *			0 or positive on success, -ve on failure
+ */
+int dm_aes_get_software_key_slot(struct udevice *dev);
+
 /**
  * dm_aes_select_key_slot - Selects the AES key slot to use for following operations
  *
@@ -291,11 +317,31 @@ int dm_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_ae
  * @iv			Initialization vector
  * @src			Source data of length 'num_aes_blocks' blocks
  * @dst			Destination data of length 'num_aes_blocks' blocks
+ *			Must support dst == src for in-place decrypt
  * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
  * Return:		0 on success, negative value on failure
  */
 int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks);
 
+/**
+ * dm_aes_cbc_decrypt_with_key() - Decrypt using a software-provided key
+ *
+ * Probe AES providers in order and use the first one which accepts the key
+ * and CBC operation. Hard failures from an accepting provider are returned
+ * without trying another provider.
+ *
+ * @key_size: AES key size in bits
+ * @key: AES key
+ * @iv: Initialization vector
+ * @src: Ciphertext input
+ * @dst: Plaintext output, which may be the same buffer as @src
+ * @num_aes_blocks: Number of AES blocks to decrypt
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports the operation, or another error from a provider
+ */
+int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv, u8 *src,
+				u8 *dst, u32 num_aes_blocks);
+
 /**
  * dm_aes_cmac - Hashes the input data with AES-CMAC, putting the result into dst.
  * The key slot must be selected already.
@@ -316,6 +362,11 @@ static inline int dm_aes_get_available_key_slots(struct udevice *dev)
 	return -ENOSYS;
 }
 
+static inline int dm_aes_get_software_key_slot(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
 static inline int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	return -ENOSYS;
@@ -351,6 +402,13 @@ static inline int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 	return -ENOSYS;
 }
 
+static inline int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv,
+					      u8 *src, u8 *dst,
+					      u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
 static inline int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
 {
 	return -ENOSYS;
diff --git a/test/dm/aes.c b/test/dm/aes.c
index c58a5e257f5..1ec80291926 100644
--- a/test/dm/aes.c
+++ b/test/dm/aes.c
@@ -6,7 +6,10 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
 #include <dm/test.h>
+#include <dm/uclass-internal.h>
 #include <uboot_aes.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -164,3 +167,149 @@ static int dm_test_aes_key_sizes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_aes_key_sizes, UTF_SCAN_FDT);
+
+static int unsupported_calls;
+static int success_calls;
+static int hard_error_calls;
+
+static int aes_test_get_slot(struct udevice *dev)
+{
+	return 0;
+}
+
+static int aes_test_set_key(struct udevice *dev, u32 key_size, u8 *key,
+			    u8 slot)
+{
+	return 0;
+}
+
+static int aes_test_select_key(struct udevice *dev, u32 key_size, u8 slot)
+{
+	return 0;
+}
+
+static int aes_test_unsupported_slot(struct udevice *dev)
+{
+	unsupported_calls++;
+
+	return -ENOSYS;
+}
+
+static int aes_test_success_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				    u8 *dst, u32 num_aes_blocks)
+{
+	success_calls++;
+	memcpy(dst, src, num_aes_blocks * AES_BLOCK_LENGTH);
+
+	return 0;
+}
+
+static int aes_test_hard_error_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				       u8 *dst, u32 num_aes_blocks)
+{
+	hard_error_calls++;
+
+	return -EINVAL;
+}
+
+static const struct aes_ops aes_test_unsupported_ops = {
+	.get_software_key_slot = aes_test_unsupported_slot,
+};
+
+static const struct aes_ops aes_test_success_ops = {
+	.get_software_key_slot = aes_test_get_slot,
+	.set_key_for_key_slot = aes_test_set_key,
+	.select_key_slot = aes_test_select_key,
+	.aes_cbc_decrypt = aes_test_success_decrypt,
+};
+
+static const struct aes_ops aes_test_hard_error_ops = {
+	.get_software_key_slot = aes_test_get_slot,
+	.set_key_for_key_slot = aes_test_set_key,
+	.select_key_slot = aes_test_select_key,
+	.aes_cbc_decrypt = aes_test_hard_error_decrypt,
+};
+
+U_BOOT_DRIVER(aes_test_unsupported_drv) = {
+	.name = "aes_test_unsupported",
+	.id = UCLASS_AES,
+	.ops = &aes_test_unsupported_ops,
+};
+
+U_BOOT_DRIVER(aes_test_success_drv) = {
+	.name = "aes_test_success",
+	.id = UCLASS_AES,
+	.ops = &aes_test_success_ops,
+};
+
+U_BOOT_DRIVER(aes_test_hard_error_drv) = {
+	.name = "aes_test_hard_error",
+	.id = UCLASS_AES,
+	.ops = &aes_test_hard_error_ops,
+};
+
+static int aes_test_unbind_all(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (;;) {
+		ret = uclass_find_first_device(UCLASS_AES, &dev);
+		if (ret || !dev)
+			return ret;
+		if (device_active(dev)) {
+			ret = device_remove(dev, DM_REMOVE_NORMAL);
+			if (ret)
+				return ret;
+		}
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+}
+
+static int aes_test_bind(const struct driver *drv, const char *name)
+{
+	struct udevice *dev;
+
+	return device_bind(dm_root(), drv, name, 0, ofnode_null(), &dev);
+}
+
+static int dm_test_aes_provider_selection(struct unit_test_state *uts)
+{
+	u8 key[AES128_KEY_LENGTH] = { };
+	u8 iv[AES_BLOCK_LENGTH] = { };
+	u8 src[AES_BLOCK_LENGTH] = { 0x5a };
+	u8 dst[AES_BLOCK_LENGTH] = { };
+	int ret;
+
+	ut_assertok(aes_test_unbind_all());
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_unsupported_drv),
+				  "aes-unsupported"));
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_success_drv),
+				  "aes-success"));
+
+	unsupported_calls = 0;
+	success_calls = 0;
+	ut_assertok(dm_aes_cbc_decrypt_with_key(128, key, iv, src, dst, 1));
+	ut_asserteq(1, unsupported_calls);
+	ut_asserteq(1, success_calls);
+	ut_asserteq_mem(src, dst, sizeof(src));
+
+	ut_assertok(aes_test_unbind_all());
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_hard_error_drv),
+				  "aes-hard-error"));
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_success_drv),
+				  "aes-success"));
+
+	hard_error_calls = 0;
+	success_calls = 0;
+	ret = dm_aes_cbc_decrypt_with_key(128, key, iv, src, dst, 1);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_calls);
+	ut_asserteq(0, success_calls);
+
+	return 0;
+}
+
+DM_TEST(dm_test_aes_provider_selection, UTF_SCAN_FDT);

-- 
2.53.0

