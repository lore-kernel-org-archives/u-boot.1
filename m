Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634C6C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01603836D1;
	Sun, 25 May 2025 12:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U3xHn0H3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA5F836D1; Sun, 25 May 2025 12:48:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578DD83700
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso15654775e9.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170121; x=1748774921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EngnAuF1Qzjl4xSd9Gx0NsN/oPoxNW7bvbsjyu8VRNY=;
 b=U3xHn0H3BbEPU4u2UzSApYScUW1citZ9NzZoPzboNOoZs6knjHI9tK1D45vQEvaAl8
 y1qpBuXIe8TJnV8e98NMOcYXIy6to72/3XC/T/+7sNdEq6a1YKPRFee4gjN9dUKqrYPv
 J5fylq814n7YfuL+kGkbsdbOiu3XAYgE5BFqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170121; x=1748774921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EngnAuF1Qzjl4xSd9Gx0NsN/oPoxNW7bvbsjyu8VRNY=;
 b=ZXJVFuU3Mipa84gNOLB9fc0c5UT0UMKGv/RZECVTMkcwpD6p9bgf11pK2zg4qikWNi
 ujnl9+qGgbL8aCCYyOUwNhL8zHc269BJtWfwaKGfGlX/12VGtKpXCHvZKvBBlKSHnFy1
 GsgHFs42CoEFMuBfoHS3/Zn9bsjD7/KiymUEVsKnAY+9rOwTxHIsDO5Wza7AZJxmMWVx
 TuNSUsJvXPf1fgiq1nOI4oW5nitjJ/E5mdpYYRBODh7V2ytKjD9aXvmdTzphAGeqhgKu
 4QR3RbwwHh28pYFxw1e7wjfM1uAwlNgEenxoa/ArKjmykOHXx47WgMiElPHAxy3gOzeB
 QYsg==
X-Gm-Message-State: AOJu0Yx6brnUvmXi5dDDaJSgGVRO1b8Jl/hwx474RaPgwLT2MF20iA4k
 BXHs6tds4p1da2aDX2LoWhYUMBXxJISDexFWnkusJnsdqINQFfbMkMHNeXhvqS2ppYmkfW8wCiE
 TMkrp6jcJ
X-Gm-Gg: ASbGnctnxRhf0X78qTPObLmLNyGbN4Qh3o39719bJ9zLGYjOkC029ffBR79F+qE3bJV
 u5F/LfO97qEzaLVp15uQ9yGmJDqm7c3N0WPzzSvFQa9pmS2CrSaR0Mb7naoye9HbnGvAfcvvvXB
 joJRP/e2yR4OjxI4urVpKg8nJILiMfS9Oqcs+YZAIstH6DN58FGORKm0Q6Q2Cxejzs3cQnIf3p+
 qftsK7Y1qr704Slt2E2gk0shLF3nj99f0BI5YwX0jZxrKSpUgzXJpG597VVr7ABCHVDdbqvwfC6
 jQ/cHsq6fuN5NNWAxYhIcXUadG90eCb9/GpJRNq8jeRUpSVPTFzN5E3rSlL3FZYsCEVRdDA=
X-Google-Smtp-Source: AGHT+IH7WPZ/pMpW/IeteXz3g5B7y4WdapsxaWs53rx3n/JFrk+8yucYRtBo9tagc2TDA9G3UZ7bfw==
X-Received: by 2002:a05:600c:4f02:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-44c91dd11a6mr40766125e9.12.1748170121256; 
 Sun, 25 May 2025 03:48:41 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 21/25] vbe: Add a bootmeth driver for abrec
Date: Sun, 25 May 2025 11:47:57 +0100
Message-Id: <20250525104801.1440260-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a VBE-ABrec bootmeth so that the VBE state can be accessed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch with a bootmeth driver for abrec

 boot/vbe_abrec.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/boot/vbe_abrec.c b/boot/vbe_abrec.c
index 6d0f622262d..8593082fd79 100644
--- a/boot/vbe_abrec.c
+++ b/boot/vbe_abrec.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
+#include <bootmeth.h>
 #include <dm.h>
 #include <memalign.h>
 #include <mmc.h>
@@ -81,3 +82,101 @@ int abrec_read_state(struct udevice *dev, struct abrec_state *state)
 
 	return 0;
 }
+
+static int vbe_abrec_get_state_desc(struct udevice *dev, char *buf,
+				    int maxsize)
+{
+	struct abrec_state state;
+	int ret;
+
+	ret = abrec_read_state(dev, &state);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	if (maxsize < 30)
+		return -ENOSPC;
+	snprintf(buf, maxsize, "Version: %s\nVernum: %x/%x", state.fw_version,
+		 state.fw_vernum >> FWVER_KEY_SHIFT,
+		 state.fw_vernum & FWVER_FW_MASK);
+
+	return 0;
+}
+
+static int vbe_abrec_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	int ret;
+
+	if (CONFIG_IS_ENABLED(BOOTMETH_VBE_ABREC_FW)) {
+		if (vbe_phase() == VBE_PHASE_FIRMWARE) {
+			ret = abrec_read_bootflow_fw(dev, bflow);
+			if (ret)
+				return log_msg_ret("fw", ret);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int vbe_abrec_read_file(struct udevice *dev, struct bootflow *bflow,
+			       const char *file_path, ulong addr,
+			       enum bootflow_img_t type, ulong *sizep)
+{
+	int ret;
+
+	if (vbe_phase() == VBE_PHASE_OS) {
+		ret = bootmeth_common_read_file(dev, bflow, file_path, addr,
+						type, sizep);
+		if (ret)
+			return log_msg_ret("os", ret);
+	}
+
+	/* To be implemented */
+	return -EINVAL;
+}
+
+static struct bootmeth_ops bootmeth_vbe_abrec_ops = {
+	.get_state_desc	= vbe_abrec_get_state_desc,
+	.read_bootflow	= vbe_abrec_read_bootflow,
+	.read_file	= vbe_abrec_read_file,
+};
+
+static int bootmeth_vbe_abrec_probe(struct udevice *dev)
+{
+	struct abrec_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = abrec_read_priv(dev_ofnode(dev), priv);
+	if (ret)
+		return log_msg_ret("abp", ret);
+
+	return 0;
+}
+
+static int bootmeth_vbe_abrec_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = "VBE A/B/recovery";
+	plat->flags = BOOTMETHF_GLOBAL;
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(OF_REAL)
+static const struct udevice_id generic_simple_vbe_abrec_ids[] = {
+	{ .compatible = "fwupd,vbe-abrec" },
+	{ }
+};
+#endif
+
+U_BOOT_DRIVER(vbe_abrec) = {
+	.name	= "vbe_abrec",
+	.id	= UCLASS_BOOTMETH,
+	.of_match = of_match_ptr(generic_simple_vbe_abrec_ids),
+	.ops	= &bootmeth_vbe_abrec_ops,
+	.bind	= bootmeth_vbe_abrec_bind,
+	.probe	= bootmeth_vbe_abrec_probe,
+	.flags	= DM_FLAG_PRE_RELOC,
+	.priv_auto	= sizeof(struct abrec_priv),
+};
-- 
2.34.1

