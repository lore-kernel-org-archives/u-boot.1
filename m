Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4223C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 18:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C2340AED;
	Wed,  9 Sep 2026 18:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBB8VMx99aaT; Wed,  9 Sep 2026 18:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5672840A82
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788979324;
	b=fPXvI2FaWRbBenS+zMngMeuLTVlrdlTtyjFms714td0DLMeuBKOaVJ33VkXCRSJ6ATrj
	 KqlUXqLDJ2DFotXhFTNppwGG5rcGRahP/wVIZltz2b+j3RA5ea99D+hyw2OMAaw/ox1Tm
	 /uklYB59qa+W+7rTfAAp9W9f5gNaxR2OFhnUgtLm8UO/V51/jEchkAcOtq7ftJYUMJYuj
	 0wu9QK2B60wkgvoGBTs1ej7P4pOr0mTW3DhWE5BnjqfP107tY6K/NuLgAOl42AIp01wB1
	 vHOjMZifh3hy9ZNcRs92mawszBYQZt3h2QX1AhAFetCv5eZKqwpyOds38lIUAJpLPdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788979324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fL7BmjWWnSQRjzZQJO2unWpgYThmd/zhqMLIRvpEtF8=;
	b=MrVUlC9BCPdBbVnmJDfjG3/5OCOWTalaqpld0uqC9omjGTc2KVxxOgBwS+3VZM1qbqYV
	 f2djXR5Kit+spvW+TQgq1/eGUMv7CMj2ujkgx/7VmQ2CbPRJFmmtZW9moeh26zy4t3sjD
	 gfEzsKnAklPBUcSjAoiu4POrseZ+QdgbWjo4Ub+rgF580MlHkIY73/1cBKI0oSUdhpK50
	 d1bOqxwQH7JVGrn9Q0XYmVtkTqU7txPoUOGFT/Zb2IqSy62p67WqjTO4MC118Xx3vPgdf
	 U7YLXnQm4vKx+Nd3UyOOyt/Mv6myQiwmU5XF/wWMBiFp386x28+OE7oRV1tFBJb9T9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788979324;
	bh=fL7BmjWWnSQRjzZQJO2unWpgYThmd/zhqMLIRvpEtF8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wYQ/4JjzHIf9BWRDMkfSVCoILlbMHJMVeHJ9/nA0dQu87N4LjvHhZATUfRW+aY1mI
	 lE/ooERskfI+/y6XlNLRIL0IfWqbvTXoyIr6CJZbJLMJtY6aHm+i/EiGNrN/booda8
	 N3ufeyo5/DkiUEiVOvBwXCQuQjSaF1hGbInI/5UcnbAUzecK1PmVKIf8gjzaDFxmp2
	 2OWG5nSvcS6MSVEy2JmVK9Xe0sEWXz/XaLkGdLFWEZfLr75ZcLCkNVKhZvGE+2/LT9
	 IEyeAc8AmWqDTkkYLSx0Zkj6uDSeC+EObAj35WB3PcVvY7zJQEp6s4QVqVLxKu8VSw
	 yIDtViSJ+R6yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5672840A82;
	Wed,  9 Sep 2026 18:42:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D874D755
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B814D40210
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NjDiA_Ixf2fN for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 15:21:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5277D401EE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788967302;
 b=Uglx2hKwePZ0ZnPKRnI8/NzFALmSfh0wKblrLL8M0ctH49DaySX09iHzbDa0JXsSpMF3
 Aa3O3dlUdAzvbwGT4nqXnhDsdoGYKJTJ3aHhKZ61kJHpBC/TRw/nA3D0nXd7Xy5zSAtUG
 LQ8mrpMTj4OZi0GN3DZmX4sFxpBWfnEqu93VN9OBT3VUPXkKNX1WKcBrd9DG22W72AUnK
 dd7xqPMtcMnpOls0RBc9eU2SC+9iSIf1w0p39eFJtoTiMUJWmkR+1CFhFPBSFw/KeFxCT
 BIhmfdLie6CDM5Vept1ZqMj/+wNZEtq3+8VALdjrbXfGupGtxuXE6YLlixuw9kg1aLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788967302;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=fL7BmjWWnSQRjzZQJO2unWpgYThmd/zhqMLIRvpEtF8=;
 b=E3RwL9YKmJcktWfeijoO+i+cgdhjJ4WH42+tA8QspZv/ZL7OSdOr+vJnVvlKzxORLHfh
 o5EhYOojbPSCBPooiba7KG+w0qyFwDvFtJOLU/iFUjyr8jqs8d47g9zqHZsSF8AmqVmAH
 e0Qeq3AojYeyHWRAhB/+XwliW7HmAYiXpF1K++S7AYMwHkb8oqe3MfJ2PGMM0fD3ZJvgM
 dr/SJ3DCkBYHSnVFGz48PqHkwnzbGxZ5HUJp0wzK/+hA2+73fHUiTQKzIM4z3LBYu/kld
 QvrEyzMBMj7lFI5svDcpHb3/z4bWwTyf3jAPR0zYRiNm44GJj4F4TEIlNJnPEAoISFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BbnYes1c; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BbnYes1c
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5277D401EE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:21:41 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso44237915e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788967300; x=1789572100;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fL7BmjWWnSQRjzZQJO2unWpgYThmd/zhqMLIRvpEtF8=;
 b=BbnYes1cUzwnHQebfStq7MRzID5AZVi5tTYZognHRWQH9posKz6/5QrD9Lc0vbgI8U
 7xjPq0qBBtz26mIkNQDJoeSmoKuyzMvInfcaAQlK6SyDMXRFotpufKY+ifZCb9k3Erk7
 xQJa+2dBSoKaxtdliut2o2ZUJRphIjpSG4rrvUtwmnn+vXaQhilJshuQLh0/U1CCaGGZ
 XDg9PV50F6Yt+m1x7ytpOFtUQKY+6paOoYWHd4rXRQDfvHL/Z+2/g+gt8HpsjAciACHn
 91FhsN5HStVWR1LbjtENC4Vdmfmbeve81iYi0itKXtAYqvLvoUbU2Q09y28n5Dtjypmt
 SbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788967300; x=1789572100;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fL7BmjWWnSQRjzZQJO2unWpgYThmd/zhqMLIRvpEtF8=;
 b=TGJXdQzSCOBfp85BbUroykRkhiywdB0hJiLNIzBNbdV9kUSFHeTRewPn4Of8TCMng0
 l3JMCgApTylLckwLurSyvF5FefZGnI4jx8TSAJplpLVdsso7jV0XUtH6lu+xaCu+8ecm
 A2hc0VlF2NYNgnpOu5/AKM5cvVbE+ViBSqukwONI6kW78HgAsrmPXUpRrinmBT2/w7cA
 tmS3E0alkU3Bepk9oEhpWZyh8ypSj9jCuOfGKY9phQYnXPfg1b/kHicYORkYiMsJrAqt
 cvL4pRiK4rCpzqwlrBlFbuEUYmKTSNQTh6/PPEagzeMMqUor3Z/E5v+cSOFcnm6oOQce
 GiRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+aI3c9dO8q0h+v6fmD0naktnyabEVzh5kgcDrWLE90xahqios1aV09qU5LhgAFJUVt+UpHhY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l9HCy4RHjkkrnZlxdmXaMnH7Tu8HFkDWsHazzDGgrzlylG/2nV
 LmyzJ+rDZ9xbszki2x34eMQNi7dBYapZ7GzwHLoEqc7Mv2HCotDDK2Zg
X-Gm-Gg: AYBFou2m89EIcfFuADNctUKnzkct1WpxJXmZk0m4oOUSqN/wzGvWNEzNumHnwMIulTn
 u/QiiR7gVsjXgjz68bsZq+lvDaF0Pf+aQa95YL+hKWppBIcLm889/fYN0tmLnVeHrs/YEFU8TLv
 XD6WIcXwJmioKmN2ZOJ5komq+LQZPp8Ie/OReWajHCaAwpMcPWtgMzJvwL6jk0J6IT4NFRBvlIi
 lzQQ5wAgxH0roYVbebiZlgaYtRKkFzGZyx/OHMkVoznKyQN4qCWSMRqJCa4EKKeqaXE0qnvEHTK
 aXW0cB9G1Q4JgVAY1tbLhGcMyxp6qJ4ehSfhcUIHN9QPD6BTNRvs4VDfuPpwy1ReNBt/0j1xOsR
 SPPDLqVkhlgpels7TKYaErC09ESdUcUcY2u29FkhK8QVGSL8mPZcj1Q8cmgeWYGGLEihBRvruxA
 KGyvYig21keHF32No8KhY+GABQvos9tx0gUFwh2udxTgrZw+wwJkxDxnGaKFKSWiB4ojG8kSi8E
 sgVQhVsB99DtVjRSa2lRvXLEhSq4qa2H1gnVSsxPOveTYW7TyZo3y+LIeFXTdMrbCHzDzS8KmyQ
 2MYn0P6pMrkM78VH
X-Received: by 2002:a05:600c:5493:b0:49b:8f18:714a with SMTP id
 5b1f17b1804b1-49cf824a6c5mr373976485e9.12.1788967299647; 
 Wed, 09 Sep 2026 08:21:39 -0700 (PDT)
Received: from [192.168.0.233]
 (2a02-8388-e6ca-5780-e161-768d-5c97-84d0.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:e161:768d:5c97:84d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm667227495e9.9.2026.09.09.08.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:21:39 -0700 (PDT)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
Date: Wed, 09 Sep 2026 17:21:12 +0200
Subject: [PATCH v2] mmc: cv1800b_sdhci: configure SDHCI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-milkv-duo-sdhci-configure-v2-1-be146dd85187@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZiCEVJX3sOwGNoBRoGSFhoN4
 e4CXsDlS95/f4HAXjjALVnAc5QgbtggOyVgWhoaRrEbQ6ayXGlVYC/dK6KdHQbbGkHjhlqa2TM
 S6UIrU1ysqmDbj55reR/tR/njMFdPNtMe3I1WwuT85ziP6e798xNTTDFXeXXVTFSTujc9SXc2r
 odyXdcvt70tCtQAAAA=
X-Change-ID: 20260907-milkv-duo-sdhci-configure-aa9790c73d0b
To: Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788967298; l=2734;
 i=andrey.lalaev@gmail.com; s=20260901; h=from:subject:message-id;
 bh=jnbwofT9BEv6KGVRma6L/kq8dhwyDX1kaEcqKl5MDmo=;
 b=g9NecqRPFAeNuEbMUTkI1O+DvxzuJS7Q07uIHv896+DIm9jqJ1IlJDfqGfR90fcOiPC1swwQZ
 XmtslvZhAwaCvyt1RRYNDF45zTe/qCnRnt+g1j1vYVzkpb6ZP3GJHFb
X-Developer-Key: i=andrey.lalaev@gmail.com; a=ed25519;
 pk=YHk+K3q98GV/1CigmrEAQ+Vc0o+GlFWt3j94jvrEh6o=
X-Mailman-Approved-At: Wed, 09 Sep 2026 18:42:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some samples of the Milk-V Duo and Duo 256M have issues with SD card
communication. As a result, the SD card is not detected, or the correct
mode is not selected.

Configure SDHCI PHY in the same way as in downstream, to ensure
that the PHY is initialized properly.

Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
---
Changes in v2:
- rename cv1800b_deferred_probe() -> cv1800b_configure_phy()
- call the function from probe() instead of relying on deferred_probe
- Link to v1: https://patch.msgid.link/20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com
---
 drivers/mmc/cv1800b_sdhci.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f3..440421813e35 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -8,11 +8,17 @@
 #include <sdhci.h>
 #include <linux/delay.h>
 
+#define CV18XX_SDHCI_MSHC_CTRL  0x200
+#define CV18XX_SDHCI_PHY_CONFIG 0x24c
 #define SDHCI_PHY_TX_RX_DLY  0x240
 #define MMC_MAX_CLOCK        375000000
 #define TUNE_MAX_PHCODE      128
 
 #define PHY_TX_SRC_INVERT  BIT(8)
+#define PHY_RX_SRC_INVERT  BIT(24)
+
+#define CV18XX_LATANCY_1T BIT(1)
+#define CV18XX_PHY_TX_BPS BIT(0)
 
 struct cv1800b_sdhci_plat {
 	struct mmc_config cfg;
@@ -64,6 +70,24 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif
 
+static int cv1800b_configure_phy(struct sdhci_host *host)
+{
+	u32 val;
+
+	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
+	val |= CV18XX_LATANCY_1T;
+	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
+
+	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
+	val |= CV18XX_PHY_TX_BPS;
+	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
+
+	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
+	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
+
+	return 0;
+}
+
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
@@ -105,7 +129,11 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	return sdhci_probe(dev);
+	ret = sdhci_probe(dev);
+	if (ret)
+		return ret;
+
+	return cv1800b_configure_phy(host);
 }
 
 static const struct udevice_id cv1800b_sdhci_match[] = {

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
change-id: 20260907-milkv-duo-sdhci-configure-aa9790c73d0b

Best regards,
--  
Andrei Lalaev <andrey.lalaev@gmail.com>

