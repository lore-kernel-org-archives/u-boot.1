Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BA6C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7C181782;
	Wed, 12 Mar 2025 18:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eicut/uZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB83818C7; Wed, 12 Mar 2025 18:59:29 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A156281760
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so24710066b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802365; x=1742407165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mmpXkuxTxA9W1bh+7adA/bmqvDEGxtiUBVPjt/Hq9Y=;
 b=eicut/uZnSZ0O6MyVG7iwEaob+M+iChKpEllfE3Z5HqIv8SYHGNpbsLQRDCmM6vI91
 mc+gh4NWiQwmSZZ58jJEzk4KS5UgHb1y/4Zlxch6NtBEAfk6p9CJxWu1Nr+iVRymlwHn
 fqZoMPd62u9K8HGeJcfjZspz8q7/nO5ffprYj+ndWJyhvpmJh4RJ8dD30f9tLdcR/Lp/
 VuwedzqwRaifeAEwEyqcWYN6weWjtAGJGQfdbYKBHRV1eomPux1C1TT7THMmHPc9gbGB
 m+7OoxZDBknHHMGGt2EoYqIRA6Qnmyzut36WpdqaxPgsG0SDkvhg8o7c8LQh+N3e45LN
 glDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802365; x=1742407165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mmpXkuxTxA9W1bh+7adA/bmqvDEGxtiUBVPjt/Hq9Y=;
 b=gcybXvteBtw/HK7xH+UuQxUNmumLzhkHQdE9ZFRgXUfJVuVywXjIfjHIe2QCTcf/qG
 3cvr7gUiOgIfRPBU59dJudnfrfZQzyRknbOhxwFMndxyi0d/3L+voWYxnUgLHdV5dVhB
 O8sPHbsRe4LIyqXm/QDvyjuDth2BUS5/zjLVv8dkQ1ObIgK5Jo5TUIAFaO8s2vh0JNEq
 2CozLLNfTbZRBOZwblPKjSrg1rPyRqFWEQVMTVXyoyZVMJtVF5qUqf1tSgDOP84NF3oc
 VFA/LJYjEALXODIJVwwARIxiuQy7FIlC+0mjHEYa32LmqR4MH2nd/rhD7yHcCPiP7JEV
 9uYg==
X-Gm-Message-State: AOJu0YzQBKkW6K0BuyvtMUeino1XptP2CQo/sFDuCXJ7Alc29Mr4V36b
 75tONZMq+YxwCMocNzJzHKLouj7mgtfkrYZ4xnZ3qFSxiBE20JsU
X-Gm-Gg: ASbGncuFfV9bm7AoJJoxel1Z/pXuq5Vsoj7vQ4qqZ0HrQMikA80fltx00JC/l/EkGC2
 TqTF46KvQJgM9bx5txjF5nXE3GFuv1VPEA64FrsTkHqKnL8Ig020tarwHWVLL7izcI9ByaZ17zP
 FWXSiUxTYrae/kFOzLj+I/0Nu1TGuDMIRy6cmvR+IKT46y5fCv9Np9VxeFGZJ2CUA7wuBfLPQj+
 DV7+fvauGtvsjnQaYGFI436ib6E7NBRD9Zcqs4iLgOysxsBQ6Pp5JcQ+l1QS6X/g8CwNBx02kPF
 NQdr/8UnbipOrjyi5rENsdUvRKqrYFW29AzuOVizLblrc+A=
X-Google-Smtp-Source: AGHT+IHgCxCmXdHi2yw85jIacuvj4FBfl6CPbuRU/9qmgEGTAZbP5H0krXvKke0t+Nq2amh6l+nGzQ==
X-Received: by 2002:a17:906:33d2:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac2622f3eb1mr1927312566b.22.1741802364877; 
 Wed, 12 Mar 2025 10:59:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/10] video: tegra20: dc: convert to use of_graph
Date: Wed, 12 Mar 2025 19:58:51 +0200
Message-ID: <20250312175857.120313-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Use OF graph as a main bridge/panel source, preserving
backwards compatibility with phandle implementation.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 6b8275ef9fa..775043bb1fe 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <clk.h>
 #include <dm.h>
+#include <dm/ofnode_graph.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <panel.h>
@@ -443,6 +444,18 @@ static int tegra_lcd_configure_rgb(struct udevice *dev, ofnode rgb)
 	ofnode remote;
 	int ret;
 
+	/* DC can have only 1 port */
+	remote = ofnode_graph_get_remote_node(rgb, -1, -1);
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PANEL, remote, &priv->panel);
+	if (!ret)
+		return 0;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &priv->bridge);
+	if (!ret)
+		return 0;
+
+	/* Try legacy method if graph did not work */
 	remote = ofnode_parse_phandle(rgb, "nvidia,panel", 0);
 	if (!ofnode_valid(remote))
 		return -EINVAL;
-- 
2.43.0

