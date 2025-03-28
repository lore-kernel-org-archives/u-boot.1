Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4CC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617F98209C;
	Fri, 28 Mar 2025 16:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z1l4usad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E91809A5; Fri, 28 Mar 2025 16:36:43 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBE8820E2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85df99da233so181495639f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176199; x=1743780999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=Z1l4usadoSo79bcYfWrj80as+gR5Ep8c7WDsd+ehrsJUBT3oHorTwTSIR9TlddjWkx
 UETDm5Tqrwdvckt5m3DqG52FpeZQcaAaVj15YwTIjZJrl4V7seqzZXOGWuOnzufjWyNO
 dykVG4OpbeufkSCMBkiokDZQEEgw4SHhqcWVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176199; x=1743780999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=RUyqwV1DWZomCt2fUnmy4WD61xKz/TobU8TRoVS6MZHYDNlXllz0R7FoWXSHEstv/6
 vWkaiBDMrmYHzG1CcVxWh0I76N6bdaDz+mg9MLebwrk9zkOiGTJ7z7EkMIAWoizp7OOo
 ZGeZSrrx5r9IB+SU3CT9aHnpfGhhbXpx0BAAFi4viD5tyAc/Fo5WrOI3tNL3tqhWKqBI
 P7u7j4hySXZEkaVjW3DHFaAR1IRoOFRIDkKFG+uBJE0rqQKDpEXKBIsy5JNiH5neyftn
 4qjS2D5sDG6QOPwKjVOPWyRemt+kt+9B+NYLA3pxePH/hRGGiJ9tEDM9H84E8UtJZ0+x
 3Ozg==
X-Gm-Message-State: AOJu0YwXV3frsJ3761lwh5tAdHtJryBhq5LRWasQEcZ5alkLy7RbsGkm
 5KNMCS1w6neUZA9Wgxwk84PC2/QK7DB6bPe1jZANYNZ49LTXmPthLCJ89qs+J/LLfZr6Vz4J+B8
 =
X-Gm-Gg: ASbGncvFi6xMyxem8rOwBohzzPQ35hGfRqVRQUjLwf7RgoyoPpTyXUBtLwU2JTDKs2o
 h2foRFwRzk5RPzBZfq3ERUnE+Vonj2eJHN9faJtJXBVkYTIxlem2HEkyBcIlah4HDXO/Vi+axMJ
 7QfGTiD15sJ2zaoU1piG8q89kQMFVY4AVaFoFR48hKiPBCqG8kgiPms3mlQWr5RXToBDeGmCS2N
 kGV3gZ6gTexPDQCVQ0LUqZaKmxe5eTZLDeBXtNETqy5STFoPVOqY+ZPp50rVCa2VVVaDYaGhkYQ
 RGLDw2ksUxQv08biAj96eTBKC+61XYw56Xep9vE4i95vQlDPt7imLMje/5cTFBd79LCa9YcVafB
 OAaYeGw==
X-Google-Smtp-Source: AGHT+IHq9UUxSdJbTR5Zuq6GvtJgqSK0OdTtaIUooswGMbx4/ytCJB9O4issa3lh+dxhUuE/FpGLpg==
X-Received: by 2002:a05:6602:6cc1:b0:85b:4484:181a with SMTP id
 ca18e2360f4ac-85e821434c3mr787587739f.11.1743176199137; 
 Fri, 28 Mar 2025 08:36:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 27/31] vbe: Add a bootmeth driver for abrec
Date: Fri, 28 Mar 2025 09:35:07 -0600
Message-ID: <20250328153522.3555472-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

