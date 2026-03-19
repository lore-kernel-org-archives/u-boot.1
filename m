Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CF31091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E7B84197;
	Fri, 20 Mar 2026 00:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="csiQklC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0AF83F8A; Thu, 19 Mar 2026 21:57:40 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DFD83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so1723102f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953858; x=1774558658; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IPZTkPmihzuAvcfZWVkcBaG4BgUinpIqzcMgHogzs9Y=;
 b=csiQklC8SYFw5YWCseyxukQ9+KjqurUB5TfT/hKKBsFFKamXELP98AsEDUBfM2uFAU
 MLQnNBRzLKkdcPm3aPkxvyN4zEq85652Zrq44RbZO2fahJxPUkv/nlUE6X2NM98tuoOq
 J237rKUn/epfdHDmJKC9T6dSwg3qHyzMu5QRcO2LsxPWI7kUKg3+gp2CIwiO5LT9SfUo
 VF8tnD1LI5vffDlNVBKz9W05zRr0Eh4gLSIuoTDQiaxCMZUWSNZOn4HRVwGmKtTY+btP
 ZE1y3mhhCg5Fcxnmbl88ILSav9CJ9i4lTQBxzlbsj2pC2Kz1NQqPREvpDHR3tiHTiDnt
 Z+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953858; x=1774558658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IPZTkPmihzuAvcfZWVkcBaG4BgUinpIqzcMgHogzs9Y=;
 b=IyPydsx5iepWWrfeAWExwa/cq30dP8uTJvefKTMbXfS1kbailh/RCV1VoZ4yZfbILB
 Fwx+ppX0SP1je5d32vwt/3WEShZUiecYuSPFRuJQwRsuDpcEQKvz928PogHHCAavZz/2
 EER3uPXuNS9aVGL47gHBDJ2HClqdUjjyrM+QIgDlExsMrp7wQGL9iV6n0TTClbTprPWG
 ThI/+ND1LIAMYih0D25qHtoPVVCIDeAl+TdgQ1+nkmV3WoBw0LTUGuLJa8RhnFGrwui8
 iIE4tN4Rh65yzU6iZk9wX/mCtPyuSaIV7e9o5/p3BzbgYr0wX7eSpG5Jd9t8qcBcEkQK
 gIjw==
X-Gm-Message-State: AOJu0YzniZH2b4oQO4g4f1QwME7r4g2DLVR9ym3YuHaTYRrrIg8vaqRU
 x+n3oBUkCl41hzdBEMO79CQI3og1fD764JRqM7UznxrQHW+0XdGRnZlQqcjhK8FRaNY=
X-Gm-Gg: ATEYQzz4wY8r88GcsbiN7yRuNfIVc6tx7Ioy9JrfcMRP6KwefIFbmr95ln+n6A6HZs3
 WlOp3YYu3vCUdrQRN3T0rWUyDqhmrgh/Qgh5D26ay1u4YAifG1SYkKrRJbd3mKbBie7CYvSxedd
 YRR3HERgYuMbdh6XTHo1xXqCeXIusIMwJx/Og9F3xAMWFCMFLpBEcvSYnuRtvPcss1KYnEOYW/Y
 qVVDXUlO3H0NgJqbcQoAMU8d8NX35MsdnyOneuNMXhHcVASI/c5rQujpzNluLff6E4yz23xT4Ur
 9k33rIpcqSy2S3D/Brkmel/UoTw/znwbVMkCB8d/UInpyRoTReGT4P6jRbBNpqD20SRyVG5icfY
 8JzbvgnDlsenRXqnmiLaVOTxZqEiLUWUfb+FRcM62jxJsYaglwsvddzuy/mzPkWe28phY4bxyQz
 3XsV/LYfn3ESyokcXD+uWwKSiRkGTgDV6+EsFHtpnHqo7t494Bvgv6XkvCMZNt4hUwJHA=
X-Received: by 2002:a05:6000:2409:b0:439:c078:9a57 with SMTP id
 ffacd0b85a97d-43b6428769cmr1505763f8f.25.1773953858002; 
 Thu, 19 Mar 2026 13:57:38 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:33 +0100
Subject: [PATCH RFC 11/40] devres: add devm_krealloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-11-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=0b2jzjydfkPAun+KPQliO692FtVj2RfqfyBqbUj4Fxw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXwen+ZN4K7YuPvskmBOs37ptUcvOZ87um/WobB9D
 D/CfdxbO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBElvow/JUT0tG7f3+lYNfT
 nq4auRUfO174lGbeSDpwKevBWaXCzYkM/7SMeGs37pq5cRN37IXe+423/6XmfAz/t9Tkpp2aUu6
 PqfUA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

Loosely based on the Linux version, this makes it possible to krealloc()
devm managed memory. Currently it depends on tracking the allocation
size in struct devres even when DEBUG_DEVRES is disabled, but it's a
relatively small tradeoff for the additional functionality.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/core/devres.c | 83 ++++++++++++++++++++++++++++++++++++++++++++-------
 include/dm/devres.h   | 10 +++++++
 2 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/core/devres.c b/drivers/core/devres.c
index 8df08b91021c..88f7c832f43e 100644
--- a/drivers/core/devres.c
+++ b/drivers/core/devres.c
@@ -45,18 +45,17 @@ struct devres {
 	dr_release_t			release;
 	enum devres_phase		phase;
 #ifdef CONFIG_DEBUG_DEVRES
 	const char			*name;
-	size_t				size;
 #endif
+	size_t				size;
 	unsigned long long		data[];
 };
 
 #ifdef CONFIG_DEBUG_DEVRES
-static void set_node_dbginfo(struct devres *dr, const char *name, size_t size)
+static void set_node_dbginfo(struct devres *dr, const char *name)
 {
 	dr->name = name;
-	dr->size = size;
 }
 
 static void devres_log(struct udevice *dev, struct devres *dr,
 		       const char *op)
@@ -64,9 +63,9 @@ static void devres_log(struct udevice *dev, struct devres *dr,
 	log_debug("%s: DEVRES %3s %p %s (%lu bytes)\n", dev->name, op, dr,
 		  dr->name, (unsigned long)dr->size);
 }
 #else /* CONFIG_DEBUG_DEVRES */
-#define set_node_dbginfo(dr, n, s)	do {} while (0)
+#define set_node_dbginfo(dr, n)	do {} while (0)
 #define devres_log(dev, dr, op)		do {} while (0)
 #endif
 
 #if CONFIG_DEBUG_DEVRES
@@ -84,9 +83,10 @@ void *_devres_alloc(dr_release_t release, size_t size, gfp_t gfp)
 		return NULL;
 
 	INIT_LIST_HEAD(&dr->entry);
 	dr->release = release;
-	set_node_dbginfo(dr, name, size);
+	dr->size = size;
+	set_node_dbginfo(dr, name);
 
 	return dr->data;
 }
 
@@ -99,23 +99,35 @@ void devres_free(void *res)
 		kfree(dr);
 	}
 }
 
-void devres_add(struct udevice *dev, void *res)
+static void devres_set_phase(struct udevice *dev, struct devres *dr)
 {
-	struct devres *dr = container_of(res, struct devres, data);
-
-	devres_log(dev, dr, "ADD");
-	assert_noisy(list_empty(&dr->entry));
 	if (dev_get_flags(dev) & DM_FLAG_PLATDATA_VALID)
 		dr->phase = DEVRES_PHASE_PROBE;
 	else if (dev_get_flags(dev) & DM_FLAG_BOUND)
 		dr->phase = DEVRES_PHASE_OFDATA;
 	else
 		dr->phase = DEVRES_PHASE_BIND;
+}
+
+void devres_add(struct udevice *dev, void *res)
+{
+	struct devres *dr = container_of(res, struct devres, data);
+
+	devres_log(dev, dr, "ADD");
+	assert_noisy(list_empty(&dr->entry));
+	devres_set_phase(dev, dr);
 	list_add_tail(&dr->entry, &dev->devres_head);
 }
 
+static void devres_replace(struct udevice *dev, struct devres *old, struct devres *new)
+{
+	devres_log(dev, old, "REPLACE");
+	devres_set_phase(dev, new);
+	list_replace(&old->entry, &new->entry);
+}
+
 void *devres_find(struct udevice *dev, dr_release_t release,
 		  dr_match_t match, void *match_data)
 {
 	struct devres *dr;
@@ -290,4 +302,55 @@ void devm_kfree(struct udevice *dev, void *p)
 
 	rc = devres_destroy(dev, devm_kmalloc_release, devm_kmalloc_match, p);
 	assert_noisy(!rc);
 }
+
+/**
+ * devm_krealloc - Resource-managed krealloc()
+ * @dev: Device to re-allocate memory for
+ * @ptr: Pointer to the memory chunk to re-allocate
+ * @new_size: New allocation size
+ * @gfp: Allocation gfp flags
+ *
+ * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
+ * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,
+ * it's the equivalent of devm_kmalloc(). If new_size is zero, it frees the
+ * previously allocated memory and returns ZERO_SIZE_PTR. This function doesn't
+ * change the order in which the release callback for the re-alloc'ed devres
+ * will be called (except when falling back to devm_kmalloc() or when freeing
+ * resources when new_size is zero). The contents of the memory are preserved
+ * up to the lesser of new and old sizes.
+ */
+void *devm_krealloc(struct udevice *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	struct devres *old_dr, *new_dr;
+
+	if (unlikely(!new_size)) {
+		devm_kfree(dev, ptr);
+		return NULL;
+	}
+
+	if (unlikely(!ptr))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	old_dr = devres_find(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (!old_dr) {
+		printf("Devres realloc failed, memory chunk not managed or managed by a different device\n");
+		return NULL;
+	}
+
+	/* No need to realloc to shrink */
+	if (old_dr->size < new_size)
+		return old_dr->data;
+
+	new_dr = _devres_alloc(devm_kmalloc_release, new_size, gfp);
+	if (!new_dr)
+		return NULL;
+
+	devres_replace(dev, old_dr, new_dr);
+	memcpy(new_dr->data, old_dr->data,
+	       old_dr->size);
+
+	devres_free(old_dr->data);
+
+	return new_dr->data;
+}
diff --git a/include/dm/devres.h b/include/dm/devres.h
index 406d18686f4d..13d7d0eec43a 100644
--- a/include/dm/devres.h
+++ b/include/dm/devres.h
@@ -194,8 +194,18 @@ static inline void *devm_kcalloc(struct udevice *dev,
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 
+void *devm_krealloc(struct udevice *dev, void *ptr, size_t new_size, gfp_t gfp);
+
+static inline void *devm_krealloc_array(struct udevice *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	if (new_size != 0 && new_n > SIZE_MAX / new_size)
+		return NULL;
+
+	return devm_krealloc(dev, p, new_n * new_size, flags);
+}
+
 /**
  * devm_kfree() - Resource-managed kfree
  * @dev: Device this memory belongs to
  * @ptr: Memory to free

-- 
2.51.0

