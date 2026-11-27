Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DA606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AtieAeXr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNcivsf+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EA45409C1;
	Fri, 27 Nov 2026 10:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NilpZrhBh-7S; Fri, 27 Nov 2026 10:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E028B409E9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775515;
	b=FH+tCu4zHwojGaCGNSpBSvs8gqhonMCeGafaBpHRNIQ31Nrh8kC0ypV5AfH6aVWjDnLD
	 hIYTi9epcMN2QOFEP3X/Zffb3bLjL1OfsGNNsE5YykcJknUF3NPZoPW0eNtx3VMS1T20M
	 OuWyLrrM9M25DD+v4VdWvQ0eC1gMK+6YBraMJRsG1rdEPHBM3q/itGPBkI/jQT9m85S9G
	 G/LPhirf4KPlVHNrIL+ypuhCNGzoPOjI/0xupOzLEKF7uzm15zX1PZRkXGh8x2e54VL0X
	 8+UB3WcZX3zelEpQvBMX01yUum5ZQ88FLgbZVOs2HTnWEAgynijwYNUyps6eoCzmm6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f2tIG2cVjSt5Vb2jMYmqq1aJtLZM7etG1tuv3h/8pg8=;
	b=ZvdKczzJLGRccFHQxzRCP9maUb5c9hKsyvVBQEyQ5p5y2Fjq5AoiYOKbQhuvOr3O9lLt
	 oc+D2NHOFBuWGydLjTT2uUk1Uat5FTg80NSLelRmJe/w9YFdMyZUua2rKxbNOnRg5K79N
	 JgEpQiSuOae23kL9e+huy6ur2Qpt5Zh3T/fhhqHIuvaByfWoZ+8Hm+5irv20yqRNMyjPk
	 bMNA2JUG3zyD5e59MepKyJD4sCi81BxgLvU4TqUNLg+F++z0gHFEyRMv2MBg1WNZN8EqR
	 7JGcvScx6+0jQ97oTwxGIH4lSW87PHRk1Orz+iZAMLNrSCNaAUFZPt7IfROEQQi+NhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775515;
	bh=f2tIG2cVjSt5Vb2jMYmqq1aJtLZM7etG1tuv3h/8pg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtieAeXrepAVseVhEIxCRkLLLIrav83NFeuPpw1ewmp0ATid1RgaEe9ReLdERb316
	 csj+8zmT5/t8EUOntfDCz2gH7fZJTOV1nKjva9Noj+uKpKNctJRvqop/t2DPftNBc0
	 RmID7PZHXp2Wr4UBWY9XMKQ5mYLKMn7LuEeaIeiN11gKwv/wE+mFoNJfTL6gFVUuUk
	 3Gya5CKEzXhbbpLAiJkYG8A1E0x11M8hvy9oNccQvfCAKqbbEc6+Brwv5sYEyawkVF
	 P1MQwQNIzn/jSOtflyFw1XYRys4IHp8w2GxXiK2FY4fC/N/GuZ1CKzQZsfK36Ighw9
	 II14oyaecfjPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E028B409E9;
	Fri, 27 Nov 2026 10:31:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C212D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7995981247
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62qr_ME8AW_R for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9ACC81222
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UNcivsf+
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9ACC81222
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:53 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-380c28f9e35so8815673eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775513; x=1796380313;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f2tIG2cVjSt5Vb2jMYmqq1aJtLZM7etG1tuv3h/8pg8=;
 b=UNcivsf+C5UYdH/sWznMf+OuciC18haHAAOxbIrB39e40DmLZqjDOqh4ayvzOnxI1k
 vgBbz7GRvcpTjZy25GXKzItoC2kzqF/cJ2MIMm2RjrFoWO6pj1eaihfTsXOKh4Oa6bEo
 NKyEl4NK6gPtVxANtdB9L3Z1OzEEs6PmMlM0kyWhMW1d3M6XMFDf2J74+ZzUY/aZwNXo
 1Ls9iCux/H/3th9JiviFk6mkS2dk9mWJxrJXZBnLgC+WsJUpfO6MxYURQTwCYKEftC41
 nv59pIHL6WXe5El+cycPXFq6YyQsx4bHHAOu03a5GXBBDq5S3C2kiCTlwEKw+yH6/nsD
 uU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775513; x=1796380313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f2tIG2cVjSt5Vb2jMYmqq1aJtLZM7etG1tuv3h/8pg8=;
 b=RfvhFvM/wm1DawO2u5l1AiGQVwFzDx9ZaEFwgpHn0lpX6qqYQyCrnIS+QhWi+5qTYU
 fDzGyLgCssPgwYPkd8i00e+3Ivmam8Rp+BWjmbUuURY5O/Srv52mzXHj5tS2sSN0nvhh
 VY48PAccj4pW7EE5J/av7SA4tvbRi3HhFUxU0gmiN42zxOJQ0KaP6YR+eV8KoHz73GbM
 pMknhu4sppTHXFeqPfeEZtnkhcL1P+w017ndwLXuLjoZgxV/cdXPdhYz91Hnm685TrAn
 iGjUS1jUTauUJsr1Kr53CMLMpfg3hgaVxotoZA8LGQ2lbZHnIRbWAZ1alYsiwqAPU6bG
 ss6w==
X-Gm-Message-State: APuU4Z99rpCSBa8nFfTawYnFZ3KroRUYl162h9ffiDTE2vidux3v/k/X
 UXVz44M3+agaBR5lmNCsgaCUGin7VQxPOUqGPgeLKLU4R6YcmB6BeIig1ZhBJQ==
X-Gm-Gg: AZFdTZfcJNf62+E9TtaTivbPEilhhkex4qfel418DHha0ypZ4165plhxZZRNWZZinYO
 Dl+USfY5oChKwGIth/mKkqVjw/GxphRZ02q6m6pRC2KSHI3hVQYyGrZ7FhcCpHrt8lZLm1SEdha
 utUWeKzJaTcuFDU0tG71d5CXdtyOWDmeCsWDQCm27mf2kW/IVMAu0bD8k/oOaO6BOhUzxANVUr+
 gosNcyaMSqeFjclA0/wM6VHRUqJyh6AhnMq8nR6UOE8fRESZxMMLvkt7lP1NZTGfRx9/iVs0w+V
 NAavIiqGdtG3IQrvrkYoMFh1NeaCBpnYpcPJaV3LmWiXjB5WLBCNCTDBmqOQRIfW6eGRAxLKsib
 5xNCvLvDUahYvM3djAhY6sFSCCWExWgyxjjDGcB1tsqwUp5mclSKJhHN97XPtjviWJTwEJgHL8j
 hPGfqvrKPe+E8wPba6B0UQUr83Q0OeF8y8+fQTLZj/BiVY/ZoPlkbmeVFiMczCMzZJeswLKbwmj
 mTOEWJdu1oc+gWNGUX9xist3DMY9LMtkIDeNFe6SPK/hhfSUoJk8Gu0dSI096Jt2dcYekVyCWx7
 gvJr06gBgRTjPaTXKkw9SUQ4cpUY
X-Received: by 2002:a05:7300:50fa:b0:383:9f52:e54d with SMTP id
 5a478bee46e88-3856ff52e83mr25654468eec.8.1795775512564; 
 Fri, 27 Nov 2026 02:31:52 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:51 -0800 (PST)
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
Subject: [PATCH v3 07/13] mmc: spacemit_sdhci: Improve voltage switching
 diagnostics
Date: Fri, 27 Nov 2026 10:30:06 +0000
Message-ID: <20261127103030.4647-8-linux.amoon@gmail.com>
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

Improve error reporting when setting or enabling the VQMMC
regulator fails.

Refactor voltage handling to determine the target signal voltage
before updating the regulator, and report failures when the
SDHCI voltage-switch bit does not reflect the requested state.

Keep the SDHCI host-control voltage-bit handling specific to SD
devices, while allowing the VQMMC regulator to be configured
for other MMC device types.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index fdedb9a301a..45acab38b4b 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -226,11 +226,18 @@ static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
 		return 0;
 
 	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
-	if (ret)
+	if (ret) {
+		log_err("%s: failed to set VQMMC to %d uV: %d\n",
+			mmc->dev->name, voltage, ret);
 		return ret;
+	}
+
 	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
-	if (ret)
+	if (ret) {
+		log_err("%s: failed to enable VQMMC: %d\n",
+			mmc->dev->name, ret);
 		return ret;
+	}
 #endif
 	return 0;
 }
@@ -239,44 +246,54 @@ static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
 {
 	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
 		struct mmc *mmc = host->mmc;
+		bool to_180, ok;
+		int voltage_uv, ret;
 		u32 ctrl;
 
-		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
 		switch (mmc->signal_voltage) {
 		case MMC_SIGNAL_VOLTAGE_330:
-		case MMC_SIGNAL_VOLTAGE_180: {
-			bool to_180 = mmc->signal_voltage ==
-				      MMC_SIGNAL_VOLTAGE_180;
-			bool ok;
-			int voltage_mv = to_180 ? 1800000 : 3300000;
-
-			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
-				return;
-			if (!IS_SD(mmc))
-				return;
-			if (to_180)
-				ctrl |= SDHCI_CTRL_VDD_180;
-			else
-				ctrl &= ~SDHCI_CTRL_VDD_180;
-			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-
-			mdelay(5);
-
-			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
-			if (ok)
-				return;
-
-			log_err("%d.%dV regulator output not stable\n",
-				voltage_mv / 1000000,
-				(voltage_mv / 100000) % 10);
+			to_180 = false;
+			voltage_uv = 3300000;
+			break;
+		case MMC_SIGNAL_VOLTAGE_180:
+			to_180 = true;
+			voltage_uv = 1800000;
 			break;
-		}
 		default:
 			/* No signal voltage switch required */
 			return;
 		}
+
+		ret = spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_uv);
+		if (ret) {
+			log_err("%s: VQMMC switch to %d uV failed: %d\n",
+				mmc->dev->name, voltage_uv, ret);
+			return;
+		}
+
+		/*
+		 * Non-SD devices may not use the SD Host Control 2
+		 * voltage-switch bit. Keep their handling separate.
+		 */
+		if (!IS_SD(mmc))
+			return;
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (to_180)
+			ctrl |= SDHCI_CTRL_VDD_180;
+		else
+			ctrl &= ~SDHCI_CTRL_VDD_180;
+
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		mdelay(5);
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
+		if (!ok) {
+			log_err("%s: SDHCI voltage bit did not switch to %d uV\n",
+				mmc->dev->name, voltage_uv);
+		}
 	}
 }
 
-- 
2.56.1

