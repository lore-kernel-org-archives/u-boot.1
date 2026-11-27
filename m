Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9A606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NOAaFjAj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eVYLar2w
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 527DB40A5C;
	Fri, 27 Nov 2026 10:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Wtny7qn1dvM; Fri, 27 Nov 2026 10:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8543840A8D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775522;
	b=FPaNHWA553/OJvUIi6HISDJMq8Dq3/U6W+XNrfZfh5prtFz8RjU1A04r5dJIHTxqNTnn
	 rPd02LJQ4AAop2QzCdCLFpljpXxFt2kbwtyvzoNiPG7kaqdFsg0GYGlS2l8AWhzsOzRZM
	 B3oY6ufWOzRNDJVFUb78UOjqoE/Dqc0LDoPFTTHdDKfU7M7qAj6L/yzpQBQHmhkwsjReu
	 inbTi06YqP+k+F7lXdXM9rtp1xjYgQLAXq74hsH7C6nzXu7UMxDCx4rN4DqCc6NySl46u
	 tT8hzerwSLfW08EEXM46Oy31FudzlEUtBCbgfLavIam7NlmS7MqRrK4KEFP36cYeGsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mOaJRmgUC92N71In9KZlKzcYRVj37lyvuXUvmc2qhQQ=;
	b=KkUhGjf3JwcG4wPkRrBuJmsewWiYouzlTsltUV/qZY+j/RavcQhPgBVWZPaW9jKObaar
	 wKnaAuqULrqSfvso8epIFKJHCRSo5ycdaz8Q2pptWla6xFbfsCV6MK2ei0mqsdQIFuLjF
	 NM+EyZGW4IQ/UPFeGc5Ann0o0prxouVwHz2iGS42gwUgsgLfVdmqMcmFJ49Y+KhF5xHH6
	 El+rcs4JIoUWhrA1aaJmRlFlCCuPoWu88fiHgWplGd28PBDU1BNk6/x6UajrlFkrCvg7p
	 +gSnXmnX2QxESOkOIWgtUJ/jOlyjssuxa1Fq699/QJC3oBY+kkOmY1q9hgl8XlDbR4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775522;
	bh=mOaJRmgUC92N71In9KZlKzcYRVj37lyvuXUvmc2qhQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NOAaFjAjVK6Ud/RnFzsBtnfIGuGajZOtYaPMY0cCEBIs6P0KLRMRDyk5jY/Wb/bCZ
	 lYYqvKye/hi/dj3u8+X//YOBk9pFU9deUL3TjfEPOzAySm0hIpBHNzN2JjYrtQlLSF
	 NXWa73rowlOR3EAvnf28hiIg9tOIt4u66f2kgpQjJ2lMcgWjtw2ol9nj94U8MXFb+K
	 35rAVOq4RDb0KsKZucRur/XQGF0yAd5W87ONuw19Mg3M9GaJq58jDYB9WuGat63Grx
	 7iZdt7S2WRayBFNkEQjKIRygQEjGLU+s0dKXV0JqT5YYBWsE4qdH1+8OnpDaERCoZZ
	 fpLqpGMrNPwyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8543840A8D;
	Fri, 27 Nov 2026 10:32:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 12AD8266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04A2F60AB4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j2H1U58QeNwz for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5438E60AAA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=eVYLar2w
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5438E60AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:00 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-385d8a00598so11833935eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775519; x=1796380319;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mOaJRmgUC92N71In9KZlKzcYRVj37lyvuXUvmc2qhQQ=;
 b=eVYLar2wyiYm7/lqdP/nXbiSlTzVEFq3WvkJUR3950vAYZVEUZgL3WkmoaqTGZEENG
 q5/r3tvHFn10b/xOEuL+2jdSHXVxeEvDuGnurItNoohQbttqPPSqKZRdnSXIQcrocsul
 /mdnwz0C0FihEsaXFRBabgqjBpPYuAGxipEQWCY92OU+ic4NRlfZ4hWUX/TX70u0OwtY
 FyS91vBiIROUN9ES5gBXe/29jtCKqGQIEfx7HHTUU4AYAhipSNTtBV5PBw3T5fktASbX
 hYjvxf/+Wd5U+u1B4VCvv79GZkYtCAYZH/ylbxvORriVDB8TVm4Bl+cIY7DGZnj8ar7Y
 qakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775519; x=1796380319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mOaJRmgUC92N71In9KZlKzcYRVj37lyvuXUvmc2qhQQ=;
 b=yl5XR362r9H2etRMG1RSHvz1lZUgxk8E0Ue/2+/k35nWevCxvE4N/hOl8t3PTgq6Hy
 nTpaAOTewhMxp8yQb+j/MxA8UX3rjj6DgxpTaBeBreyM/CMJMFFqXHjB+N4cFEOCZyeK
 i1GNPYtR0+gaQu/FNdHaFkoOycLA0Bj2bZmTzCeXWVg5Rn1SjQUVVqrkiW+Vb6ybvfWF
 aR2b8cDvOi3a6hiVAvROEzvfYcXUjUfzMyYYt9Xp9HSAp8avruRmw82J+BPlpQLSP94k
 ZicgBXGkRi1JTZdyDnAmwKtegJtB/KRMC99Uy0SNcf7z9ooRR2a+F8/17qjZl/BZSsnu
 ftYA==
X-Gm-Message-State: APuU4Z9dqWAqAlLl5mIeWaLRtt2LCGFGEHYdxkDSO/FFW6CKZRBZ/28X
 GXd/aUL8mCxSUyjchDYJSoslM8tSIUENFXayYWTLZ7Zl+7Cnbxizs9mvuEOETQ==
X-Gm-Gg: AZFdTZfZ2olAnpb2c00LCJrEtnZbhOCbNwGWsPxz6R444QbDcCy8Wclxdm3aS2Z+q0S
 6D4493jv6k2YvbEQX9pJLykwWs76vOrXp8xF5kvS8cfLJo49RiZLXus8ko94RRNoCEzaqRfq6Mc
 Ci4mX/aB+8xcpEAD0Sxki2ohhLDMDjs5eV1Bhv4wxLvx8rd+sk83wE6PwCsq8SY2c+xWjmukF2L
 amc3GRko4XmzmlGvbwxwO7GtP/1xpTDd7CRKS+3LdIK2DeXF7ejzhFSLba9enV1conwP3nJf0r+
 BY9cmMg7DcesZBixTmxj3M5RxuYjEu+dQRt8Gq14ywgjgWTNBL/GuMvfO25DqMllEGzI8uY31/Z
 jJ48C5i8dTPVB8sXRkNZw8w4ZExPjJDLaUl8KO7wbTNqqBEDS7Poooli5CDbIhpng6SAjbQC4Gu
 mBHpuNDv0bKoxRzz4ZD333mMn5wr1NxpnO9uwflckD7zSf0ltiFx2eX8Q0OPF/QtmygiGkKK59G
 2KuuUiE09buy/J3b7TgXo/M4HuHCvsbfa5FrakdTRDszZ6Tm3zmtvMQx4OqzIUuTNfael1M4jXK
 YtIpfCtxV1xHk+3opRuY3d41DyJN
X-Received: by 2002:a05:7300:d941:b0:385:4b9:18e9 with SMTP id
 5a478bee46e88-3856f94f874mr25363749eec.18.1795775518954; 
 Fri, 27 Nov 2026 02:31:58 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:58 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v3 08/13] mmc: spacemit_sdhci: Select pinctrl state based on
 signal voltage
Date: Fri, 27 Nov 2026 10:30:07 +0000
Message-ID: <20261127103030.4647-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The default and UHS pinctrl states describe the electrical
configuration of the SD interface for 3.3V and 1.8V operation,
respectively.

Selecting the pinctrl state based on the timing mode may apply
an incorrect pin configuration during voltage switching and
does not account for UHS DDR50 mode.

Introduce a helper to select the appropriate pinctrl state based
on the requested signal voltage immediately after configuring
the controller voltage.

Check whether the requested pinctrl state is available before
attempting to select it, as not all SDHCI instances provide
pinctrl states and these properties may be absent in SPL.

Use the phase-specific PINCTRL configuration and report errors
when pinctrl state selection fails.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 65 +++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 45acab38b4b..132bec8d1c1 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -341,12 +341,62 @@ static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
 	return 0;
 }
 
+static bool spacemit_sdhci_has_pinctrl_state(struct udevice *dev,
+					     const char *state_name)
+{
+	char propname[20];
+	int state;
+
+	state = dev_read_stringlist_search(dev, "pinctrl-names",
+					   state_name);
+	if (state < 0)
+		return false;
+
+	snprintf(propname, sizeof(propname), "pinctrl-%d", state);
+
+	return !!dev_read_prop(dev, propname, NULL);
+}
+
+static void spacemit_sdhci_set_pinctrl_state(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	const char *state;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(PINCTRL))
+		return;
+
+	switch (mmc->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		state = "default";
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		state = "uhs";
+		break;
+	default:
+		return;
+	}
+
+	if (!spacemit_sdhci_has_pinctrl_state(dev, state))
+		return;
+
+	ret = pinctrl_select_state(dev, state);
+	if (ret)
+		log_err("%s: failed to select pinctrl state '%s': %d\n",
+			dev->name, state, ret);
+	else
+		log_debug("%s: selected pinctrl state '%s'\n",
+			  dev->name, state);
+}
+
 static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
 	u32 reg;
 
 	spacemit_sdhci_set_voltage(host);
+	spacemit_sdhci_set_pinctrl_state(host);
 
 	if (spacemit_sdhci_is_voltage_switch_cmd(host))
 		spacemit_sdhci_set_clk_gate(host, 0);
@@ -368,21 +418,6 @@ static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 	}
 	sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
 
-	/* Set pinctrl state based on selected timing mode */
-	if (IS_ENABLED(CONFIG_PINCTRL)) {
-		switch (mmc->selected_mode) {
-		case UHS_SDR12:
-		case UHS_SDR25:
-		case UHS_SDR50:
-		case UHS_SDR104:
-			pinctrl_select_state(mmc->dev, "uhs");
-			break;
-		default:
-			pinctrl_select_state(mmc->dev, "default");
-			break;
-		}
-	}
-
 	if (mmc->selected_mode == MMC_HS_200 ||
 	    mmc->selected_mode == MMC_HS_400 ||
 	    mmc->selected_mode == MMC_HS_400_ES) {
-- 
2.56.1

