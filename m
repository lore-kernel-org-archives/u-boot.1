Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D5C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1695283FF5;
	Fri, 11 Apr 2025 14:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B88i5KJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312E983FE1; Fri, 11 Apr 2025 14:47:54 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228C783FDE
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so20639215e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375671; x=1744980471; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iRspixiP2BDoFtLSQctJ1k/6YWK73JbmOlYJPwbeZMc=;
 b=B88i5KJkuWp0M2mSw59XTZb8YfQrgTyQg4P5wfkMNPW0rXDPSUTERjjVolZI4dm4OE
 NlEnDWB67hRyMLZCzNZwEzW6MfcvZ4/D85CCar/1PxUOATTxQfM88C86e+iM3F14UQ9a
 FAyxeTX+uKaX/+SZ0ZxJNpuJTyuOL2aBMg6Sk/HYs0q8twWyd0aAKj2S8FD0FwklgCG3
 bCzLh0sZH2e6QxWdiwVVvHreoUKYTxel7ivATu5DMXbm83XIA4xBQ9xynVHhVrBmA4s9
 lIjthZEkyYsoJd+uJaCyPaXbPf6jervu8rQjoVbdL4ynD+1apR1R1HQoNbzIXnlcgoyG
 FDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375671; x=1744980471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRspixiP2BDoFtLSQctJ1k/6YWK73JbmOlYJPwbeZMc=;
 b=gueCeqbHkFZbMS4/ievMk/WKgY30RHgsejNmw1nWtItpeZuBeHi2lqLCvhVUzrR8VM
 vOMBOihz1suuIPPxeOcj8hjWdKtFYtfdYpq1SpHRd0twhntD1iWotFxbw2POcSS5MCPQ
 CbOwCd+4KbaPdzVGN78/wSVmpQGT8Egv+qKhjYe7dZGzyMUsRfIi9C9zU3AfABclldF+
 f1ZUlQ6BWIY5RHs3vu6UwyBUxaBxIF12yAqJZTsyiHbs444/GWogrhumc0Th7ohA4oTS
 nIKenYNKCmtO8HhAgBwhBfa6GhXgDX2GwGEM4r1u0OYTO2pI0dwVhwjcyaa6IL8a0ffT
 RYww==
X-Gm-Message-State: AOJu0YzGDbqpFa2boQuFsVXJvTMFiEs3NihcuCz1rvAd2iQJAqjlurYH
 FJ7doGvsfYEnDcPvGCkGESaTPFChc8C8Vwwfxw2QMcJ0gVTym4iZ7h/FtTWF+vc=
X-Gm-Gg: ASbGncs+CE4MLuoFAr7HxOP5TBLrxCht8veZ5pZd+uwHyNOWyOy29/j3tgXxgh3V2+K
 Zf9geafZN7HdhVza4Q6CZN99x3bGIhow4BsCUsg+zb6jYKVRbyv4ubfYyRkEnlcGhJk/BMLK/e4
 rFHISXrovt27Goaa6UX9Uwe5+lLSO1SnOPho5MP3xYJmFGkc8aiIgicv87a5DzEbW9mzsss6IYL
 56JtsHrWr4nkmAzZak8TnU4VmZL1LZtOwvhXn0yPhiKx9OGgzCemKE3mSuEvvf+5Z2PWqjkxddX
 AQg8dHStb7NTVtxRsQcmXotSsokQ8izdJYa8P8gmzvrlj73YHzQEY6v23Sp5tzBpH0Vf0aXdW/3
 MPx5tvOv+b2O2IMjniA==
X-Google-Smtp-Source: AGHT+IE9YciekaYxROyn9PEx6mt8DcK7JnrjYQEY5BSkCFekpnX2VFNNLYW8HYaoDPzQAwMLAGc0EA==
X-Received: by 2002:a05:600c:6a87:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-43f3b055a75mr13869015e9.5.1744375671521; 
 Fri, 11 Apr 2025 05:47:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:38 +0200
Subject: [PATCH v2 1/8] event: signal when livetree has been built
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3586;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PZwj/X0GyacoeT72dcXb1eQFSusHm6QwZ7CGU+yq/pM=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q9zi/4h+H1gvr0P8pvmLeSCNYsBKj14WW5cX
 VEwDaBjY8aJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPcwAKCRAFgzErGV9k
 tktVD/9pnwl1Bv4+PaxC6Dm/Ga2yNaKMHsLxGj1/kooU4xnTbMTLgAg/splW7GIOZMYz239ya/E
 KA5UYtE7UvdUlMnyapcVR4WxrD70iftMAdKE5Evpl0dmFaQsDny21FW9QuO7lmstHsWrCiaYWkg
 Mo8DlV/6ubdzo2RR8eBR3k78slF/HMSLFXdnk/3r6eeJYORQJDp7Tjgc10Gl4NDqOesAJipXylE
 C+BVIoOnr0dnbgiZyscxUW/01/aoTec+NvWDkKRpzT5+c14ThQnn3SEw7R4wDgzfibRT5E8v1dl
 1LhfFc5kO8rOI0uY+GHI1c8f0zBpx3745D2VTBRPQTjupkY/EN0ajllzNCd7q/s/QohFEyiFK4W
 tvOy3yhYxUWg4H17GyIefE0IkyFgyGOXAv1rQpoPoAsQVpAY9iLOYZXTIQPPfCqoQfKkpoez44+
 Iec2zENMGnrQ3X9PUhe+wXI1eg9XvYvUYDgsLokn7vyCng/9KiX/YsZoUbJb+71z+p+8nmCiPee
 r89qADMss/GjoAPsPQXamja/I3/i78ZbTZFbPGEnuItYvKwyuL7Uph4G/FA8qsQRXRdMZ4NG8rz
 lnOIO2PqR61N7bRovYh3+ivgrz6pP7U5k0x2ir8t6ctM6VJo0aZugg7l1k+FDhELNEXSW4BNZGx
 xB+wXI3jhyQZ9zA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

OF_LIVE offers a variety of benefits, one of them being that the live
tree can be modified without caring about the underlying FDT. This is
particularly valuable for working around U-Boot limitations like lacking
USB superspeed support on Qualcomm platforms, no runtime OTG, or
peripherals like the sdcard being broken (and displaying potentially
worrying error messages).

Add an event to signal when the live tree has been built so that we can
apply fixups to it directly before devices are bound.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/event.c  |  3 +++
 include/event.h | 18 ++++++++++++++++++
 lib/of_live.c   | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/common/event.c b/common/event.c
index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
--- a/common/event.c
+++ b/common/event.c
@@ -47,8 +47,11 @@ const char *const type_name[] = {
 	"ft_fixup",
 
 	/* main loop events */
 	"main_loop",
+
+	/* livetree has been built */
+	"of_live_init",
 };
 
 _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
 #endif
diff --git a/include/event.h b/include/event.h
index 75141a192a48b0931667632f41be8ff4d6139f7c..1d267f1d10547642d381fa287ab4981a2bf03543 100644
--- a/include/event.h
+++ b/include/event.h
@@ -152,8 +152,17 @@ enum event_t {
 	 * A non-zero return value causes the boot to fail.
 	 */
 	EVT_MAIN_LOOP,
 
+	/**
+	 * @EVT_OF_LIVE_BUILT:
+	 * This event is triggered immediately after the live device tree has been
+	 * built. This allows for machine specific fixups to be done to the live tree
+	 * (like disabling known-unsupported devices) before it is used. This
+	 * event is only available if OF_LIVE is enabled and is only used after relocation.
+	 */
+	EVT_OF_LIVE_BUILT,
+
 	/**
 	 * @EVT_COUNT:
 	 * This constants holds the maximum event number + 1 and is used when
 	 * looping over all event classes.
@@ -202,8 +211,17 @@ union event_data {
 	struct event_ft_fixup {
 		oftree tree;
 		struct bootm_headers *images;
 	} ft_fixup;
+
+	/**
+	 * struct event_of_live_built - livetree has been built
+	 *
+	 * @root: The root node of the live device tree
+	 */
+	struct event_of_live_built {
+		struct device_node *root;
+	} of_live_built;
 };
 
 /**
  * struct event - an event that can be sent and received
diff --git a/lib/of_live.c b/lib/of_live.c
index 90b9459ede313e492e28c8556c730f3bd8aaa9df..c1620616513c2e32448b4a6d156a9162d97c76b7 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -10,8 +10,9 @@
 
 #define LOG_CATEGORY	LOGC_DT
 
 #include <abuf.h>
+#include <event.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <of_live.h>
 #include <malloc.h>
@@ -320,8 +321,9 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes)
 
 int of_live_build(const void *fdt_blob, struct device_node **rootp)
 {
 	int ret;
+	union event_data evt;
 
 	debug("%s: start\n", __func__);
 	ret = unflatten_device_tree(fdt_blob, rootp);
 	if (ret) {
@@ -334,8 +336,17 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
 		return ret;
 	}
 	debug("%s: stop\n", __func__);
 
+	if (CONFIG_IS_ENABLED(EVENT)) {
+		evt.of_live_built.root = *rootp;
+		ret = event_notify(EVT_OF_LIVE_BUILT, &evt, sizeof(evt));
+		if (ret) {
+			log_debug("Failed to notify livetree build event: err=%d\n", ret);
+			return ret;
+		}
+	}
+
 	return ret;
 }
 
 void of_live_free(struct device_node *root)

-- 
2.49.0

