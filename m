Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AE8E9D812
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E2484106;
	Sun,  5 Apr 2026 22:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RjVxB8x5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F068394E; Sun,  5 Apr 2026 16:51:19 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38758341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 16:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d9923eec5so1883962a91.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775400676; x=1776005476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtY0kRtvh+ItU3j+CvUqIj0izxvC0PRyWOWX5Qyivl8=;
 b=RjVxB8x56VVQx5n5xB66WtBTxRclINKki+vdUzj/ua4Pg7PfKUlm9YymwytMl7DLyk
 +Cg2BNfbPXf6rophPxKrDDkkInYP0H/IpiJF44WTC+i30GLw3PxJe1ApA1RahP68NpLs
 UkexLFxxrh6ejZhGli0yYBhjc62V4YfsoCddxKpQ26YHPQHQvDBRXZR5iBP2696aXhBc
 SKCuJxrD86KDR2t+mNLyMTFZoBq4DlUB8//Mh5S1/nHeUzCKqVRb9ZRc886MkUjMJf55
 oZl4vIjr0C2YSbMWkwqSPFapxIcRhGrL5UQRNM/bff8c/NM9ISDdNXSo6oEelbALm8/F
 6WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775400676; x=1776005476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtY0kRtvh+ItU3j+CvUqIj0izxvC0PRyWOWX5Qyivl8=;
 b=PBo8d/D8R1LeQeZh28/48mib4Xj0sO6v6vIAUDfU9+QzevGXTSaqki3JFXiAcgoMM+
 DN0hDXSOdA1eEZIgdNYmbUYScSZeA6ix909yjd9x6O7td7hnlcfP1183Uz+4HiMDw6mA
 0g7uTvadiCwQil7YoftGzezNxP++kzHnqTWv5y7xLd8sJxUhYUOeYxsA3O2S4vXc8hWF
 sxntPlNkIJtyoEFoRMl0tuhGQAMWvg01rEgyzrscsNb58XgmdeOidSRoVYZ5vOzpi5A6
 FvZlTmo8Orb6FfiI9GB61Rb61dPET+MWymtYx0L8B47M0dA/PVTdqe4iYIv9URFzR8Tg
 uvUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlXQIyRoRY5fzWlUJyCjcYSDMXCRw232d+CwamYyhQ6VOnJFhj7ARL48aEMNVfGpJZB7pFs1M=@lists.denx.de
X-Gm-Message-State: AOJu0YwqcTp0t79cDELg7gRi7LjQsfI3VqC4yYFAUWgTCLh6+5M715Gy
 isSDveAvDot5KTWD8fO/wGLtw7q2LnPZl8tW8sVJSQK9lD8rJLwhZJM2
X-Gm-Gg: AeBDietETyrpUtbxlnZ81urX+MwGtn7jemAFoErNzboakxjqM5lc8DU46+F9EqdpkEt
 eMM35nEK0j24MCO3srCkM8kj7VtAxya3UtC3L2N3NF3SZJ7IfOZpmjyLboNtdMqWQaV6BtwtxFP
 L/UadTC4zMn29FuB7mkzSgKq8xpTRPouAIU3oJjvQL2YydRLF1mblMsDUhRkiE49CyKP6y2eNR+
 FB6v2M0R9c+Brx81X1F8oNvA3uKIng19OiTXVVXzyWZA/N1Mwq7dzVFMZdhw4eDlj/U1q5ujf0n
 YuRnhEvNaIQAniM9t71B0nO0+9p2DAOGLLiNgFmFLegFnLRPvCCnCNdZkNeceP94G7uiZITansy
 ofFD2r24+2ye9X5At0g1pXtiRX4NXt4F4t3TTs2ydOL8GtJS9Bi1mupDYExbLtHQydvd5o1XDL8
 4Wixf7O/Wo0Ih3ryJHxwM5QAJD8zpDSlRQXtEOeuVtCzW+35ODHIrCIkfFpVDTy/lTAcEXtvUH0
 JWqTbyomkvYRq29RjTT5Q==
X-Received: by 2002:a17:90b:2e07:b0:35b:e566:15a6 with SMTP id
 98e67ed59e1d1-35de6a099e9mr8367466a91.28.1775400676197; 
 Sun, 05 Apr 2026 07:51:16 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe959358sm15333261a91.13.2026.04.05.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:51:15 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v3 4/4] sandbox: dts: add PHY common props test nodes
Date: Sun,  5 Apr 2026 22:49:44 +0800
Message-Id: <20260405144944.41074-5-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260405144944.41074-1-lucienzx159@gmail.com>
References: <20260405144944.41074-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:12 +0200
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

Add device tree test nodes to arch/sandbox/dts/test.dts for the PHY
common properties unit tests.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 arch/sandbox/dts/test.dts | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ac92ebf1afd..0887de4333b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -16,6 +16,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/sandbox-pinmux.h>
 #include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "sandbox";
@@ -502,6 +503,65 @@
 		phy-names = "phy1";
 	};
 
+	/* PHY common props test nodes */
+	phy_common_props_missing: phy-common-props-missing {
+		/* empty: no rx-polarity or tx-polarity properties */
+	};
+
+	phy_common_props_more_values: phy-common-props-more-values {
+		/* 3 values but only 2 names => count mismatch */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		rx-polarity-names = "sgmii", "2500base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		tx-polarity-names = "sgmii", "2500base-x";
+	};
+
+	phy_common_props_single: phy-common-props-single {
+		/* 1 value, no names array => value applies to all modes */
+		rx-polarity = <PHY_POL_INVERT>;
+		tx-polarity = <PHY_POL_INVERT>;
+	};
+
+	phy_common_props_more_names: phy-common-props-more-names {
+		/* 2 values but 3 names => count mismatch */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_find_by_name: phy-common-props-find-by-name {
+		/* valid 3-element arrays, lookup by mode name */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_AUTO>;
+		rx-polarity-names = "sgmii", "2500base-x", "usb-ss";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		tx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_no_default: phy-common-props-no-default {
+		/* name not in array, no "default" entry => -EINVAL */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "2500base-x", "1000base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_with_default: phy-common-props-with-default {
+		/* name not in array, but "default" entry exists */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "2500base-x", "default";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "2500base-x", "default";
+	};
+
+	phy_common_props_unsupported: phy-common-props-unsupported {
+		/* PHY_POL_AUTO is not supported for manual-only modes */
+		rx-polarity = <PHY_POL_AUTO>;
+		rx-polarity-names = "sgmii";
+		tx-polarity = <PHY_POL_AUTO>;
+		tx-polarity-names = "sgmii";
+	};
+
 	some-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1

