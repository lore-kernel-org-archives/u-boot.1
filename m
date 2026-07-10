Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E02C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C83C84B87;
	Fri, 10 Jul 2026 20:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2Bkkik1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE31684B32; Fri, 10 Jul 2026 16:33:22 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A9D84B07
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso7930275e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783694000; x=1784298800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CLKJzHBlzA747OJAH9RyLXo1yEeI62/A7gtcnDty/2Q=;
 b=q2Bkkik1ip19z3bzm0YGhsjhF2xfrD23/33ZRIDjg5e+e+ctNTph7CQHSX+i3vKABl
 zs+uMJJiXDgIPjhejyiXTNm0f56UQoSrxuL00eJQpF+cKbI4lpja+2LTRn5iNikB8OX5
 kZ+F194GcD8GdlxneoOiGl0M0sIBcMwtuH87vOGu8Z0mpQuRR8+ZfS9tOR45sQEM5pHb
 xo83iCSpsQx1Hab8PE9+M8CoZUadtuNZcRMLTaOXqJN6OHSrYJJzRvQOQpislNPZ5ekc
 YaFfuri64RMoR6vMZlk5e1P7ck7cem7RlcclCpe6HOnuv8XfI4uv0cYVDk86TWjBI40s
 YH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694000; x=1784298800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CLKJzHBlzA747OJAH9RyLXo1yEeI62/A7gtcnDty/2Q=;
 b=tTK0+C9iWe81NRp0qyfzd1itpjv4dsPp/tnEHvSrGROtfBR13k54gF+6WZew9TsPKq
 cMQgDPB1bl4APzTZEpbw2wD2Wc2Zldao3K1UH9tMw33Eppb8xtVDTWRBJRfe+VFGstVr
 9oER27a5JAYHsnmZkFVivUveHEbuDjfVixGuz7FaEF/EVQhLPt51DA3Ii8OvpcAnqNNb
 vuOG+5bpUV/fI8IaCYH9mjHrp30l3EqIRlmgnKpZIA9tHQIcsojliPPNaTM8T/xpW45q
 anAK65KM0WshzdDA/wHfS7IUkCf7fenp27h5hMQJoMn1qfIRhSct0Mp5XJcOlmL2NbVP
 PiMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgpX4XSV7H+tQa+NzLIQHgTbXF4GAL9KrseIgMLYwe8liZ4H36XImKftUrwU2ebmwfwBj7/6I=@lists.denx.de
X-Gm-Message-State: AOJu0YwMfaH5DzLxbPuTx4Hirs8fIqjphxf6sdjpsW2PXmntrCGb6So9
 NHs2xKmoH0mNQTLs9zwl38HWPWPeq9LIwL/A86y3ACLXwbyTk6H0l/Kzqwsf5dko
X-Gm-Gg: AfdE7cmJBzyyrHyrJAYJMg5/4E5ZrY/Oj56Tqy/1BJNyP5L5UF/RiDpO/pq7BZXGp1t
 CL2bMM2GypZDqppeJ4evqos74Ovz3B35WaiOWEi7V6ufxMDzkS1Z0zswdO+zp26EhmwLo/SeATO
 Pc+ePr2ClShwkfZsZNUmuXojCz3DvnqYcNT7O1pKDqO5CgYsSVLbKd0a8kt+WRwZfDiUopE7zJo
 O+QrzpYsLSJOTWdSROCkXu/KIfaSYR8v8CD6WjbcksTW0AAM7SGMoQeYoxbZEeAPV8fYNHzt823
 gSPM9y8LY/Nqzg/TiKXaBXaqo4rMmg5O0M3pvVI24i6CAII/vRV4dSW4RUcsML+Lvxoov9C3tmJ
 oavhJprkKtK/ptwl4lS1iKi/On3pOxvgh10IOfj1F/kGZpLfL9fEOKm+G/sUK37K33UO+4QA+aH
 fIP4q7g/7pHk0GGHw=
X-Received: by 2002:a05:600c:1d1e:b0:492:7084:32af with SMTP id
 5b1f17b1804b1-493e68bf03amr121900305e9.23.1783694000085; 
 Fri, 10 Jul 2026 07:33:20 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:19 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 5/7] toradex: tdx-cfg-block: Add verdin imx8mm 0239 pid4
Date: Fri, 10 Jul 2026 15:33:03 +0100
Message-ID: <20260710143258.285091-14-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the new 0239 PID4 to config block handling:

- 0239 Verdin iMX8M Mini Quad 2GB WB IT

Update the board-specific variant selection to use the Wi-Fi variant
for the new WB SKU.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c        | 1 +
 board/toradex/common/tdx-cfg-block.h        | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 8b4698e92e1f..cdeb2e4b4de7 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -198,6 +198,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 4GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 	{ VERDIN_IMX8MPQ_4GB_IT_64G,             "Verdin iMX8M Plus Quad 4GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
+	{ VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,      "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 4bf4f2e68437..3b32fbb06109 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -161,6 +161,7 @@ enum {
 	VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G,
 	VERDIN_IMX8MPQ_4GB_IT_64G,
 	VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,
+	VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,
 };
 
 enum {
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index b56f5bf30a83..4e308084968e 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -83,7 +83,8 @@ static void select_dt_from_module_version(void)
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMDL_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_4G_WIFI_BT_ET) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WB_IT_64G);
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WB_IT_64G) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G);
 	}
 
 	switch (get_pcb_revision()) {
-- 
2.54.0

