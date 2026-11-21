Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4642606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i3SFg1Oo;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TyvTNQ5+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DE4F60E85;
	Sat, 21 Nov 2026 13:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vx7_nfcmoCWt; Sat, 21 Nov 2026 13:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5ED7D60780
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266872;
	b=NuGYaV8Xn39hnD4St/0ixYc+3nvZzYzWawjXx3t2EhJ4wLbJeoWzt5Aq5v8s02O2JPdQ
	 17GD9o/Fa6j1PHxeTiwqyMD7wkOQSL4wIdc+W6yoyUF+YchVvSWOssIVsseyj1mZBlQRa
	 3lDi4ZPuov6Isn/1bAhozoYjgAWLDZ1DA48KNpi041FzcTN1VHk7VFN4hhap39gvyEFtK
	 6wMfeX+ZLXM7R5QdK02a0R4pHKS1/TZJL1wOP/3aUDTnPCDleBPRus7vNbjsiIiH1famI
	 K29DzfzSFMDAvde7HgATLwNGZ5K+L3EhsYPR+3ENxpqoTukYXoV7DNI8DlRKum2b/Uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FZt3OBKqyhaURn2+iEzGKI0r7zv0YTuaUMP7kFdTmho=;
	b=rvWHMI2BGGB5aooelmgRNZFRpVVNXpzj82aidJjUuIHylQpxzKs+Rnu7t95jWUfZHPtX
	 voXG37F5c9E/JWUqPHMlCEZe2YzJUMJ4IQOaNRzZF/GIqYEhePPtT20JJnzJIy5ji8qwA
	 W7LWOPEyw/0prAZfQJfcznccuY0hF0Eb1LTLbU5yndWv9H4fQmQNt1iWgXesBKK5lUS1z
	 kidjGADUewq7Li396PRZVyE4r4Vnv6CN+0c4nXO9HLZ3bwFlp4xXxRGvbu4oWabRIyhYm
	 ytaE7gSQ/Q15FyGGoYOB/iA3X7oHAGK9pL34MJlm4oQB1TePjlCMrNc43IkeSZoO9mw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266872;
	bh=FZt3OBKqyhaURn2+iEzGKI0r7zv0YTuaUMP7kFdTmho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i3SFg1Oo2DVi5qhwGDgd6zXLYtDeourBH/0p8412LHPR2lqEMzbNJXu75uQUvvPsD
	 sktmEDAcVm8I1jHynCmy2p27dY0pwu6LncP3gsjU5l2JY9iLBP+/BblBjiiBo0HQvL
	 bob3N4Ul4xj0fKvhsczDtfrP5NLiRiCHwA/9ltNO+RPoTx5Kv1UzLVTsSekR6OPFRU
	 jaJPyfCraYyNlJ2/BfeHzSHF4zuRpegzr7JT+U2EurnIVBFn4oHOvlW9N/GnYaxDJ9
	 8wYGcWvGUvRwQMhjzfJceHwS5xiYWhuo1XW0+u0vkxusvoAk9JDXND7dxZSPTeWeqy
	 pSy83Nc0LUGBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED7D60780;
	Sat, 21 Nov 2026 13:14:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA5F3465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7B8B405AC
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYXBFruWM6Ir for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CB3E4059A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=TyvTNQ5+
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CB3E4059A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:40 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c505994e5f5so29055766b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262079; x=1795866879;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZt3OBKqyhaURn2+iEzGKI0r7zv0YTuaUMP7kFdTmho=;
 b=TyvTNQ5+T0+5K/YQHk25J9rE0y/AT0kteCJTHhrJuczM2rn8gJlobozGh9Vojv4LMl
 CiUf49uZA+UNAcbxFUO/f3ChQ9RTt3Zu55qs2RUwfJ2lRKbQ9L0pHkKLcBuUipfaYRK4
 upUwyi2qStIK8L0+0XlW8E+geyB/hbZ3AsiVSrOXlZBrwvjYdaxHt61arFhIyGF6pUnc
 O+QEUJK7bkYi7GVrBhRl4sJyOIoT+XWhJTYtRPMLYEZpczwUHH34lxW06fR9qgE4PL1g
 0JBjkTyRB3Do7AgXLHweKL2T+PBrA44sV7x37nxNLmYDTXYd7z0Db7+Jb7ROULibQisa
 lV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262079; x=1795866879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FZt3OBKqyhaURn2+iEzGKI0r7zv0YTuaUMP7kFdTmho=;
 b=TWpRxmtRtwUDw/4kq8FaOEfDB2eskdWaC3P5v3cg+xxugQ0/ld5P9yocGuRoBvP/DC
 /n3q3b3MpBKlQHwfWbGQ2m/84Uuc1VEuNDnfk1a8bXKUpPuFBMqy14VsqY+dVtvJhapx
 HvLrftR/HEzHZUjVxZkTzDfg+Tmj+aBjrTmQgvzPcg+fR9WOOmV4fBxWpAM8h5CwFvQd
 MCBC4Leqnm1N9+EcuI/ld+B3x1BLySqAzo1Zm9FtXTvOPRiXJa57h3jg3fGbTlAk/mCb
 eGwpQOeanLcfXDliT3vkzRFzDqsnHXA+j16FZ0Vsa4y2MGMPlv9UVdUTzoT1Sq0dLd+a
 tTJQ==
X-Gm-Message-State: APuU4Z+deQI5/oLl1uEjITcR4vIMq0ChU8tKnWuTxt7Ixg9taFqtP96W
 bxSS2xEKyWBZnZUCi0yAESIqE4L3rgVft7kSbtig8Iilr2VYRCigxt9TyHQTwA/0VajJfI1dvVu
 F5zSK
X-Gm-Gg: AZFdTZcrSUPSODFwOxgAnN8qxTHgck1HLG8bO/W8FOcGRuDj+oReaie9jDMI/JQvT+p
 clWvquVTdUx3Zxqx96GYNAOq3oGKtuWQa+Y5qLi0XWdr8A3IbXNzbT4lYg6cx3bknfp06Sbnjv+
 8c7hQs5OZi1C5omj0hM4WIlVzQ+P93dSAYnI3wOk7aOYM/5Hd4FJHugXiRrxp5GM1HCpTkw2GAO
 l537C1d/Xn5mWOihXzGmsnhH/06uXBvBooU8pFtkZVKOyQnOKz2LVShMBYjl615qPLgXxqa2pSy
 OtQeDc4gyBut76/p5Cy/C7/+a8WMjXr0LrxBoAbgWQmhdnqw8o9z98lE9sVhPAL4P6rcL/25hl/
 hyr1ro4Y5wUkwjmxoCgcak7eIfECwu4zXLSlb64DnltcwTg/ARac6L4OZVBHhSc+919EXo7fdtE
 4LqruOQk+cOpeWGiMv3C+rTXye299bXdgCiM1b6B0Be0+npwGdBP/WgW32gN7Rel0sg1wzJCThY
 nO7dlY2vdwVIQ02QS1BBq2UMbjrRZGBkNQi7iafKVKds4K2TruF6c0cg6TL8MB4RG1AkEmFx23H
 /6Ly9S8Nq2kz6GI6AJhuEC1hrcRHzd2LJAk55uH23B6nFuHlno1eVt2etE6BycHTkahhGlEcgMl
 4AHu3GwcruQ==
X-Received: by 2002:a17:907:8f03:b0:c51:26dd:3037 with SMTP id
 a640c23a62f3a-c513a1dd552mr414512766b.0.1795262075573; 
 Sat, 21 Nov 2026 03:54:35 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:35 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v12 10/31] usb: dwc3: core: bring back the U-Boot entry points
Date: Sat, 21 Nov 2026 12:53:14 +0100
Message-ID: <20261121115335.548142-11-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Linux core.c has no U-Boot entry points like dwc3_uboot_init() and
dwc3_init(). Copy them back unchanged from the core.c we had before
"usb: dwc3: restore to original v3.19-rc1 kernel import", with the
struct members and prototypes they use.

A diff against that old core.c shows no change for them. What they need
for the resynced core comes in the next commit.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 420 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  11 ++
 2 files changed, 431 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4c930358af42..0684a461e7f9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -45,6 +45,8 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
+static LIST_HEAD(dwc3_list);
+
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
@@ -1325,6 +1327,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_core_stop(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
+}
+
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -1346,6 +1356,8 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
+#define DWC3_ALIGN_MASK		(16 - 1)
+
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
 {
@@ -1402,3 +1414,411 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 
 	return 0;
 }
+
+#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
+int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
+{
+	int ret;
+
+	ret = generic_phy_get_bulk(dev, phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_init_bulk(phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_power_on_bulk(phys);
+	if (ret)
+		generic_phy_exit_bulk(phys);
+
+	return ret;
+}
+
+int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
+{
+	int ret;
+
+	ret = generic_phy_power_off_bulk(phys);
+	ret |= generic_phy_exit_bulk(phys);
+	return ret;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DM_USB)
+void dwc3_of_parse(struct dwc3 *dwc)
+{
+	const u8 *tmp;
+	struct udevice *dev = dwc->dev;
+	u8 lpm_nyet_threshold;
+	u8 tx_de_emphasis;
+	u8 hird_threshold;
+	u32 val;
+	int i;
+
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
+
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
+
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
+
+	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
+
+	dwc->has_lpm_erratum = dev_read_bool(dev,
+				"snps,has-lpm-erratum");
+	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
+	if (tmp)
+		lpm_nyet_threshold = *tmp;
+
+	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
+				"snps,is-utmi-l1-suspend");
+	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
+	if (tmp)
+		hird_threshold = *tmp;
+
+	dwc->disable_scramble_quirk = dev_read_bool(dev,
+				"snps,disable_scramble_quirk");
+	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
+				"snps,u2exit_lfps_quirk");
+	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
+				"snps,u2ss_inp3_quirk");
+	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,req_p1p2p3_quirk");
+	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,del_p1p2p3_quirk");
+	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,del_phy_power_chg_quirk");
+	dwc->lfps_filter_quirk = dev_read_bool(dev,
+				"snps,lfps_filter_quirk");
+	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
+				"snps,rx_detect_poll_quirk");
+	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u3_susphy_quirk");
+	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u2_susphy_quirk");
+	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
+	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
+				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
+				"snps,dis_enblslpm_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
+				"snps,tx_de_emphasis_quirk");
+	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
+	if (tmp)
+		tx_de_emphasis = *tmp;
+
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	dwc->incrx_mode = INCRX_BURST_MODE;
+	dwc->incrx_size = 0;
+	for (i = 0; i < 8; i++) {
+		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
+				       i, &val))
+			break;
+
+		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		dwc->incrx_size = max(dwc->incrx_size, val);
+	}
+}
+
+int dwc3_init(struct dwc3 *dwc)
+{
+	int ret;
+	u32 reg;
+
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
+
+	ret = dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto core_fail;
+	}
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto event_fail;
+	}
+
+	if (dwc->revision >= DWC3_REVISION_250A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (dwc->revision >= DWC3_REVISION_290A)
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto mode_fail;
+
+	return 0;
+
+mode_fail:
+	dwc3_event_buffers_cleanup(dwc);
+
+event_fail:
+	dwc3_core_exit(dwc);
+
+core_fail:
+	dwc3_free_event_buffers(dwc);
+
+	return ret;
+}
+
+void dwc3_remove(struct dwc3 *dwc)
+{
+	dwc3_core_exit_mode(dwc);
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
+	dwc3_core_stop(dwc);
+	dwc3_core_exit(dwc);
+	kfree(dwc->mem);
+}
+#endif
+
+/**
+ * dwc3_uboot_init - dwc3 core uboot initialization code
+ * @dwc3_dev: struct dwc3_device containing initialization data
+ *
+ * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
+ * kernel driver). Pointer to dwc3_device should be passed containing
+ * base address and other initialization data. Returns '0' on success and
+ * a negative value on failure.
+ *
+ * Generally called from board_usb_init() implemented in board file.
+ */
+int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
+{
+	struct dwc3		*dwc;
+	struct device		*dev = NULL;
+	u8			lpm_nyet_threshold;
+	u8			tx_de_emphasis;
+	u8			hird_threshold;
+
+	int			ret;
+
+	void			*mem;
+
+	mem = devm_kzalloc((struct udevice *)dev,
+			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem = mem;
+
+	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
+					DWC3_GLOBALS_REGS_START);
+
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
+
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
+
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
+
+	dwc->maximum_speed = dwc3_dev->maximum_speed;
+	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
+	if (dwc3_dev->lpm_nyet_threshold)
+		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
+	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
+	if (dwc3_dev->hird_threshold)
+		hird_threshold = dwc3_dev->hird_threshold;
+
+	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->dr_mode = dwc3_dev->dr_mode;
+
+	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
+	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
+	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
+	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
+	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
+	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
+	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
+	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
+	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
+	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
+	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
+	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
+	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
+	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
+
+	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
+	if (dwc3_dev->tx_de_emphasis)
+		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
+
+	/* default to superspeed if no maximum_speed passed */
+	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
+
+	dwc->index = dwc3_dev->index;
+
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
+
+	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+		dwc->dr_mode = USB_DR_MODE_HOST;
+	else if (!IS_ENABLED(CONFIG_USB_HOST))
+		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
+
+	ret = dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto err0;
+	}
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err1;
+	}
+
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto err2;
+
+	list_add_tail(&dwc->list, &dwc3_list);
+
+	return 0;
+
+err2:
+	dwc3_event_buffers_cleanup(dwc);
+
+err1:
+	dwc3_core_exit(dwc);
+
+err0:
+	dwc3_free_event_buffers(dwc);
+
+	return ret;
+}
+
+/**
+ * dwc3_uboot_exit - dwc3 core uboot cleanup code
+ * @index: index of this controller
+ *
+ * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
+ * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
+ * should be passed and should match with the index passed in
+ * dwc3_device during init.
+ *
+ * Generally called from board file.
+ */
+void dwc3_uboot_exit(int index)
+{
+	struct dwc3 *dwc;
+
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->index != index)
+			continue;
+
+		dwc3_core_exit_mode(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		dwc3_free_event_buffers(dwc);
+		dwc3_core_exit(dwc);
+		list_del(&dwc->list);
+		kfree(dwc->mem);
+		break;
+	}
+}
+
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
+{
+	return 1;
+}
+
+/**
+ * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
+ * @dev: device of this controller
+ *
+ * Invokes dwc3 gadget interrupts.
+ *
+ * Generally called from board file.
+ */
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct dwc3 *dwc = NULL;
+
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
+
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->dev != dev)
+			continue;
+
+		dwc3_gadget_uboot_handle_interrupt(dwc);
+		break;
+	}
+
+	return 0;
+}
+#endif
+
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 036a1440c8e8..4c4d7bae2e5f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -418,6 +418,7 @@
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
+#define DWC3_GUCTL_HSTINAUTORETRY		BIT(14)
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
@@ -1232,6 +1233,8 @@ struct dwc3 {
 	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
+	u8			incrx_mode;
+	u32			incrx_size;
 	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1313,6 +1316,8 @@ struct dwc3 {
 
 	u8			num_eps;
 
+	void			*mem;
+
 	struct dwc3_hwparams	hwparams;
 	struct debugfs_regset32	*regset;
 
@@ -1398,6 +1403,9 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+
+	int			index;
+	struct list_head	list;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1564,6 +1572,9 @@ struct dwc3_gadget_ep_cmd_params {
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
+void dwc3_of_parse(struct dwc3 *dwc);
+int dwc3_init(struct dwc3 *dwc);
+void dwc3_remove(struct dwc3 *dwc);
 
 #define DWC3_IP_IS(_ip)							\
 	(dwc->ip == _ip##_IP)
-- 
2.53.0

