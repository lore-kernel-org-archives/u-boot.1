Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC49C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1341183831;
	Mon, 26 May 2025 12:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aeSr0ct0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30411837F5; Mon, 26 May 2025 12:16:43 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079D683816
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3db7b3de375so16906585ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254599; x=1748859399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=aeSr0ct0Jw5+M1KXJZu3rtuNm3691CbVsW8IrH1MJub3yOyQkUFFpkE7BV2cq8Wnmr
 AWlg76ee+Ju80JlAYk8aPMt2lMQ8Bq1w/U/JvBmxEauCBnxQlWXhy23REKy9ng5Gt4Qn
 7lfLMXiqtCmNGbpwP/9sWUsUXa4OstmIGXsB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254599; x=1748859399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD2FX0rwsAIxw7dI4ctaYmAh4uTNzU4pHBJS91so7mw=;
 b=SBuGe0EV1i4M8NHqNi4RcY7L42Qn6XFWGxJIP1hx2zklh+biALERcNhmC2MYZtNzjz
 /j20k3UmQHQHyfZVXcUA2h9iiWZkPAsSKQWOIbRaaOJ4Cx0C3g4sGo+D8vk1xc6H2ZmO
 cQhx5+sp70Cpp9N3ed+w7WwAbwyHVzmpxn3sTXT2gh2hYli45AJEkAN5WItaJbqjh9tz
 UWkXsLFWrCJFXQgLK7UAI+hyQAO5HYg/7uwlHKzQyJTgqrii1moP5GWZvJxyuDHTong+
 5JkTx8WqVMopGWbsIEvaEtEZoF0ZLrkJQTNzxn//EXxd1LuKkm15B+u2eOdWqHXc5GqY
 5S0w==
X-Gm-Message-State: AOJu0Ywq4b7NlmiFAKVv1f3Jpvu4/kEQ+ptNo/n9lUJatmWPBM+/zfRr
 e3B+CKQ4iLr5uhUNz2zFSAM1TZ3nkAcUlEdQB8bGkTBfOt7u6ek9et4md2KBMnWMwmEU/ilJXKp
 6PyagLjSU
X-Gm-Gg: ASbGnctn0ku8bZy41v92SkctwAjYcANiP5LnXTTeWs6CG/mNpyrq80HhfnMy2XS3QQb
 x4wjQQe/BDdm5Q8j9W7XUfl5nM7uFKzZWVuAU/vO9TaDiWRSHJ5QCupLcUYcktc482d84koTYRY
 /T5qwNmMeFs6iqF7M5XN1QORRNcPSMdPy640krR44cGiV0D36CcZvJNkNS0KlL9XrzJqgG0g2bd
 fRs1TsVfyd2S9qJ2dBp8mpSnAdRaDXPxNkpVeMJB+R+sdUn8dsKvediV3QmU76CjI8P9dXvZQcD
 OG/xdmKo19VLNFVYnrVdk3qHpNPv1XAHcZRoDW4u5IlHanIHYWVrCyRb7MOuNPycArstkZ3ZfVL
 qGSQxRmSJNO8X
X-Google-Smtp-Source: AGHT+IEKtzNqXqSDxq2KqTEH/NVMtMghjp55miYY2ZVys1udI0GVtKirUETsXjCcQ1VtPu0z9cocJA==
X-Received: by 2002:a05:6e02:2185:b0:3db:6fb2:4b95 with SMTP id
 e9e14a558f8ab-3dc9b723cf4mr89509075ab.18.1748254599210; 
 Mon, 26 May 2025 03:16:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 21/25] vbe: Add a bootmeth driver for abrec
Date: Mon, 26 May 2025 04:15:07 -0600
Message-ID: <20250526101541.3254628-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

