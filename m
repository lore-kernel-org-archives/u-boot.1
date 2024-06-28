Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859AC3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD24A88549;
	Fri, 28 Jun 2024 11:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KIqHQHxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1761788549; Fri, 28 Jun 2024 11:54:53 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DBF88254
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso3177745e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719568490; x=1720173290; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6gKy8SF9XDvpg221szVN3rP9v4GgKb6Iy9Ed8wpcG7A=;
 b=KIqHQHxv3Og46LwkSe1axjtHSynbuO/osHds8dkpoXUCckFvvHTcjBkdGIrqCeh/1N
 3IHJy4z7kP3KT35cT+myxs4xm9rLNiPFRZ7dYS6Vsm9H7m7J4DgRKxfneLP/FOS96y4x
 5ZUojEdvgKrr193/JJ7FjGGAXJXDiDrY8Q6THlYe0ijlrvFUsT75bVFjPnF0PLjcKFjK
 GnkSxrio8z7W3lu4qyjj2QIQwIpKyFdA9M5NsQCAukpjM2euV+1Y4nJLgbP/Th/1rloZ
 w6bpCpj89XDFyxkozf+C1WxRYKI5aCED99mpE5HH9WbMeBeGk4pq2tqEe5GdhdrgPbw6
 0oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719568490; x=1720173290;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gKy8SF9XDvpg221szVN3rP9v4GgKb6Iy9Ed8wpcG7A=;
 b=uUOUKNHSrTA8bK61G6e4+Qjhwn3vBJkXbC/a9O9RPrRKFdf+L/n7UuRAutsOjU21Qd
 NUldbM03kNmgLzGC29ZH3rKiSiocoR1W9PA161QSHkd/77kd/Hhjfd4XY6aPCyO3TYxv
 nXN5mkROGIY1SpKKgDHmbiaH6s72YaX8ZjmWrpPmyZRz7NXNtdsb+kYEy5T+U1KPehhu
 IuUvx+/TjCciwUSViPcSwnlQa5JERT7vHzPOH6Czvs1Px6/OjMGbnIPGHvahfBbQvsg/
 9r7BXXfghiKIH7G1IGjqoo0wjxKFZA+M0Jgj2h0YyznUv5/v97oTRn6+HvuL1P/6ArYc
 1N9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGn0ITt1WfJ/pJ2d6fpT6hUKfQVCQP7QjEiRA57iaYuEsTNAX7LOiiKwqNrQolrgsGF6tnE99cuzYv7YCdWdLw0h7C0Q==
X-Gm-Message-State: AOJu0Yyali2fNiBAwnd1OIaWlJZQih03/TtgfKImCCgNPvLIMpd6+A5i
 VfqZbSvQkdbkpHabAuj5wUyBAmvlqGSGdQuzrSfrZme2d9dB3yzBVVe9SntCN2A=
X-Google-Smtp-Source: AGHT+IGKRriRnjtUA6mvVQ153rDGlqnCXy5Bb8gZrciszxDFgFupYSsQGH60ZbIxbSvvyOo1/hVGng==
X-Received: by 2002:a5d:5f8e:0:b0:366:ebf5:c6cc with SMTP id
 ffacd0b85a97d-366ebf5c746mr12913359f8f.50.1719568489999; 
 Fri, 28 Jun 2024 02:54:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1055b9sm1717759f8f.95.2024.06.28.02.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 02:54:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 28 Jun 2024 11:54:47 +0200
Subject: [PATCH] firmware: psci: register PSCI power domains to stub driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-topic-sm8x50-psci-power-domain-v1-1-4608830f194a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGaIfmYC/x3NQQqDMBBA0avIrDsQh7ZGr1JchGSsszAJGdGAe
 PeGLt/m/wuUi7DC1F1Q+BCVFBv6Rwd+dfHLKKEZyNDTvMninrJ41M3Wl8GsXjCnkwuGtDmJSEM
 Io3HDQqOFFsmFF6n/wWe+7x/395+kcAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MdxUZm7q75Tt4aJsXi/XUio+Zbt/pPyO7/PcSpQ6q8A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmfohowkjLtf1Y5I5781TBFaVh+Qn73sEYKnamtI+E
 nIPU8W2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZn6IaAAKCRB33NvayMhJ0U9bD/
 9RRpYrbzhOQ21kG9sIJ3PE9uojlxnyBEnjUOX8qHALyRYua7az5KOudqglSfw0jmklx23w+yMS8wnp
 eXQEE/iHN5u1czrQlgM3m4WBaymyIFJilJ4KQc5qvGNc8obmwXwYqUPnZjcWOnEav/z4edoyzSc8E5
 MAUOpncF2LXUhRLRyVdTv9O3qxoqUe4xL6i2UjYzFupzhGkZN2imHLFTAV3HjeJHhDS93NglyaZcjp
 0jhQwCfhH5abaMushQkmU/Ikgv4+2EpeLUiN2hElNRY0zDpgV3eU2bjPMPQ4R7Z+MTTyXBq7JrMREh
 d/9F6j9Cci6WxdyF19pMFddKBgnoKH9YWN9myZrwe6UfJc2nMjg4f8NsMVxyjz5OgoGGrirB5YKJFn
 FCelkf79RlSW0epec69EuBnoSQaEjxbVZyy4XsvN56r1FScUBcKVPAecQROByaL452CVZuMaPvwP6m
 kM1Z48lOuc7y7i+DI3KznE4qmIIqfieKqbCd0CE3UVJbKMwwleDXyhPe6dR7dDiOoOK+8SWZGlQR/g
 VNJh2LQoYsfYcm3Zbv/zwig64LKj//wj4M423DGEXlrQmWKQm0ySM/zH3E0W66jZT0N9nrRzIfwVAk
 ocKSVz4Pg15lrP/QOFclbZ9vMj9YhpddI0fid3YVvIgx4pIxAlxRAlmTFL4A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

On some SoCs, like Qualcomm SoCs, the PSCI cluster power domain
is used by system-wide firmware interfaces to make sure none
of the CPUs are suspended before submitting requests.

While on U-boot we only use the first core and we never
suspend it, the Device Tree still references it and blocks
those nodes to be probed.

Simply bind the PSCI power-domain subnoded to a stub power
domain driver in order to solve the runtime dependencies.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/firmware/psci.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03544d76ed4..fc72bc17274 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -23,6 +23,7 @@
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
+#include <power-domain-uclass.h>
 
 #define DRIVER_NAME "psci"
 
@@ -172,6 +173,10 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
 
 static int psci_bind(struct udevice *dev)
 {
+#if IS_ENABLED(CONFIG_POWER_DOMAIN)
+	ofnode node;
+#endif
+
 	/* No SYSTEM_RESET support for PSCI 0.1 */
 	if (device_is_compatible(dev, "arm,psci-0.2") ||
 	    device_is_compatible(dev, "arm,psci-1.0")) {
@@ -188,6 +193,16 @@ static int psci_bind(struct udevice *dev)
 	if (IS_ENABLED(CONFIG_ARM_SMCCC_FEATURES) && device_is_compatible(dev, "arm,psci-1.0"))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
+	/* Bind power-domain subnodes */
+#if IS_ENABLED(CONFIG_POWER_DOMAIN)
+	dev_for_each_subnode(node, dev) {
+		if (device_bind_driver_to_node(dev, "psci_power_domain",
+					       ofnode_get_name(node),
+					       node, NULL))
+			pr_warn("failed to bind %s\n", ofnode_get_name(node));
+	}
+#endif
+
 	return 0;
 }
 
@@ -324,3 +339,29 @@ U_BOOT_DRIVER(psci) = {
 #endif
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+#if IS_ENABLED(CONFIG_POWER_DOMAIN)
+/* Accept #power-domain-cells == 0 */
+static int psci_power_domain_xlate(struct power_domain *power_domain,
+				   struct ofnode_phandle_args *args)
+{
+	return args->args_count == 0 ? 0 : -EINVAL;
+}
+
+static const struct power_domain_ops psci_power_ops = {
+	.of_xlate = psci_power_domain_xlate,
+};
+
+static int psci_power_domain_probe(struct udevice *dev)
+{
+	return 0;
+}
+
+U_BOOT_DRIVER(psci_power_domain) = {
+	.name = "psci_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &psci_power_ops,
+	.probe = psci_power_domain_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+#endif

---
base-commit: 9e9f78f7aa0124ef0e622532043acf87e84008dc
change-id: 20240628-topic-sm8x50-psci-power-domain-27dd90a7f298

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

