Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FF0CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8599F848E2;
	Thu, 28 May 2026 19:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UelcM0do";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81674848D7; Thu, 28 May 2026 19:11:48 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA70C84878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de44ed7a11so11675188a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988304; x=1780593104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=UelcM0doafQJoshkE+KwJoZNldZQsefFVDFJ6WSpK4gjaXVMROLxUKfUPA404FKA1T
 3WULG9OX5763x1hjVms3uuQbGvBujK8Wd/w7mmoXUDAFcnTZ9oXCVG1fvOmwhZ9WcLLZ
 uFTk5j5ynHkgNZYsiy0C4fh2+laE9EQXpkdSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988304; x=1780593104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=BgJfEBnS13BGnpZsfzh4Iw4GB7p3OSetp3NMyPZjvO0Qq93tWxfLOc8RJppH/4y1Hv
 Qgu1Y2QZWYjIfR3DFztmGcQdtXkcD6yupW/+xqDhOoOKVx806VQObZ68Dg06y8CRokQD
 1u5VLG1AOcxPjxa3TVWrkFo6XQRnFbKzAObD9kpydSilby46nvOOH3PB9zS3qiT3V0Bf
 PO4rW4rifYBCRcgE/mnS/LBsJWwqYVlAxqaH95V1Sb1CwJZhJ4NLKzljfJfP+QOYF1AV
 2GpJmAItsKogIvepWs+fLoAZkAW1bblzpe/kA6AoV38g+txcWbiTxAtqHRPKnIJZp9O2
 WwQw==
X-Gm-Message-State: AOJu0YxhV0aaOWVZa5Yetz15UI+ViXo8ZFxokfb1P9YmBkuoHMaLDWza
 NDp89X/W7OZWGkrGapZE3o8aF5nQ158hH75uqEazbBm2PVm0JVZ48v3ssuZ0Ynypf9ZwSII+rSB
 Y2huswiU2zTY=
X-Gm-Gg: Acq92OEma+bbqC4lezTdliaaa7zVMdlek3xGalOKnRWdZjnDsOxot2F/TRb833Ao0Jx
 j7HzOdxHX+NZVhGYtu5n2mfePlDnaJDV80vgtpj22ug+QBLB/cbjh1YMcifZ/Ar+QGTPgLr5Whk
 CG4neRLjww72Eiy+CZdpW4bOqAYLejb6tOw+x+/odgI/IpCxbeZHpZrPZHl9+LU/IOjHwq0bUSO
 Kuf6FeXXHOnftJwgrNZFIE1ooff+DpjzqzwZimr/vALJGUTabqIpPVBWYYhje5w2XEZICqoCyQ3
 IUilm3t9gN3q++17pJZicrJe/7uG1QAVpPoKkApbf7mvDO0x9a+ECd3Hexxd32/XbHOkETH2qxk
 9LpWpBfAOmCPV8M0tDra1jzNuLNMk8wIeMD6l4gNit8UEHpOHc0Fy24n7EjphiIITRNxd8KAkmW
 LaFX5QaFSjR2SKLImVuxiznXowfs4u
X-Received: by 2002:a05:6830:6d17:b0:7d7:ef0a:1ce9 with SMTP id
 46e09a7af769-7e5fef5ab3bmr18413217a34.14.1779988304609; 
 Thu, 28 May 2026 10:11:44 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 21/22] vbe: Add a bootmeth driver for abrec
Date: Thu, 28 May 2026 11:10:28 -0600
Message-ID: <20260528171043.910264-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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
2.43.0

