Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551DEC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78BA680F56;
	Sun,  9 Feb 2025 22:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I2S7GXJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D239380F10; Sun,  9 Feb 2025 22:16:47 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A669807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d15bacddbdso6638465ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135803; x=1739740603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUCvx4zs2rwpIuRnNIdm2N4ZOI7l9W2OiWHMOKL/Anw=;
 b=I2S7GXJWNIY1DgnQM8Z7fcs3LnCxeDLJCJ/ClVc6w/LcwYsMXwvW2vcFwith/nTIL3
 EJeuOq+ZsMxMxGgTUabduzDZrLtkzXUbvqcypgOGu8LphkWzWU/oVt426rtTyfqLuG0o
 lvDy3SJ5T+qNBaeAe0g76fDszKBBrRma8e86U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135803; x=1739740603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUCvx4zs2rwpIuRnNIdm2N4ZOI7l9W2OiWHMOKL/Anw=;
 b=p4P6kn+0xfFYtdlk/65Hq08lWKKW8iNwMprVzodbtYHyBbD+P6NNSLiO7IqtI6IP5p
 FK88v6RrLgp/qzFtTWwnLrbi62YxEvJ3FO7zT/TwePnzxiCjowm2TP87PGKVOHuWqW7M
 CQRq6lF53jYuLwOxVWruCh+pA27kCX3qwU9WZSoNkk6F98RX2++bmMgLVowXT1jw+jRI
 iwETWHCFQC3VH2zKRjFEzaezLtU2z2P4TgpOG6upu9ErN6iImdVC6QozJQ+unsmYGda6
 ISLcVDipJkH8xTXQEdAkTwVULbt2pGe/1CaWLO5lDx3gu3Wl5SAT2O1zN4TQGpgEBWFp
 3D0g==
X-Gm-Message-State: AOJu0YzcMa22Zv5/aHX/YVXSCL9NILKZxbbVXFLmZCcvcTcvWcj/RbXJ
 /8OO6pVbWh0A/MhVJv3/iLB8i+1NbU3tIN9eabegal+ClAHNIsWbkRxiyrBYD4aMhlUl7N6+9BQ
 =
X-Gm-Gg: ASbGncsoQ+LoJ9Kvg5XkF+yYIqlYShjgiKdEvkxUg5Vl2QujJHsnBSiNjL8PW0vT5yx
 76NhE9v1WtVl6NKvwO0W6VrFkReyk75UbV9yxzuO6Q7mln3pt6omvzGdm5MmtSebq8H3Bfswh+l
 qkL+HALpcEL2109GFmv5lIqlw/C2owDI+mtIDZKaVIUWV8c9iHaD4DZmf/eu+pMn7kvEMiiFiy5
 1HIfi5J5urhpl5rhfLK+6hpG75uXV6MPl0Ks2Z4mteCROXPspbALOzVl5EEeJ/8MpO0wLef4eZR
 yJtldhmCac/nmWPw0ZS5hDW+em+IIjt9mkF3bIDC3IjkN9znlyLY
X-Google-Smtp-Source: AGHT+IGeT9774h5hw7bSGj3sRluJq2Xtc0ilNJq1w+KdGOwIzlYED882VVLeC4WkWxKGLUVDuLSxww==
X-Received: by 2002:a05:6e02:1c8c:b0:3cf:bb11:a3a4 with SMTP id
 e9e14a558f8ab-3d13df2bd00mr75227175ab.15.1739135803514; 
 Sun, 09 Feb 2025 13:16:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 31/35] vbe: Add a bootmeth driver for abrec
Date: Sun,  9 Feb 2025 14:14:52 -0700
Message-ID: <20250209211502.2299245-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

