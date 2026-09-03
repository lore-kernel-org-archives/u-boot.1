Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7801C79F89
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFC2240B0E;
	Thu,  3 Sep 2026 13:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUQuHkO7j1ui; Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2A58F40B11
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788443063;
	b=OP9MjuCH/xlghGsS3RUbsfsSagWYB+SXbyP9NXTkRA2o9IlacdwelRLcEAETN/CZVQ9K
	 OG8KUVNuH10vcLBT1jVIxEXDS6puTQxBBGa1qmVN4Eqr3gE52i3jhp/HT8sgu6hGhfKoI
	 fz1guRxyrSdfiGdFm2KpJd9VqXqBRUSUGzYavVw175ca9e6c1MSKGAUFt9gMOOubo0Oh+
	 x42qlw+LIFMFMketpmeDZQMledOgRXJUvdvs7xcWBNPH6F9xqEDDqzm13v+2El1q3GL2M
	 BM4fBofdI8MrHgQNDLPghW0B8cNVsfhd5fqTMDMjO29RHwAwx/kz8LsbpFR3e//shKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788443063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m9CyYYtVFKA2uOpjTdyS1DbrQpm9uvu7kATEGz19XfQ=;
	b=gkVHH9oZFHcDilET1Dyetvh24Rm+pIrJd+albK536Iq+Z8QcqHbWu/twEhTKQEgg4mFf
	 bZ5IpwBj4F/KXyCHMpSFVmVNavEvJgTQPy4PdfiuCfvmoHfk0GhuYgO+QYomY8HTICxmR
	 rLo7ZnjZpTlt53aQMufyPr2mMXeQ5y/5Bv0/PIOjBjx4oX5LNeHfBaK7Xf2b4jXS21dyd
	 5oJEMqmfCUNj5YHcoItaUt0Aa+JJ6F46MABkWsO+ZdBgJRUwow02gighsoGb20mFbUjxY
	 OFmRHjZVCCu4l52sUjsuId7HNthVqzbG2+sZjIkv9re4onCxxrkTIDjPmSvO7Q0MTDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iSaEdMjd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788443063;
	bh=m9CyYYtVFKA2uOpjTdyS1DbrQpm9uvu7kATEGz19XfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUyEyTvswRXqBvZtwRzBt62MBU0oPkfCyjkrv5gzgMY1g7fc1OKX0bKJu4bI8Lnrh
	 C1seRQ4d+WkSEDLRVMsC1y9WCebD2vFw2oK+b+PQjhhQuw2hEGWlrmMkppjA+KB6zw
	 fCQLMf8OnGAxzaC1tN2m1L0lSKdviUSBuCXz2X4v6eA4PvyMsIJQy1IYqecBleHoTn
	 Z7GPXST0L6FTBiFzS9EzOogPiyRvmjFq5cyKtPlJibdxQOBm0Z6FAQCNVPgWe6gKXR
	 HpL6qIYilHq6fk1pUgo53WTnmPm/CPwonn4JkcbDjCRP1ypcfAy0WQNY/WLawsZSlL
	 /xIOa1dMEOxcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A58F40B11;
	Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D1D322F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26D0940AE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_X_A6l7Ph6r for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DAD8B40AED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788443058;
 b=E8u6IirWOhydxp6a+jp4hWO2P7PlIyCaMGWw8qFxPaHU7q0JXKDvcovaFgpIXc9clJBk
 RR0a8QTOCBYVn/xsfE97AgYnutepps3kWGgPjtkhmmpY9a5BTfs6PZrOYcXmeeWBszXml
 8dOsQkREBhUhyaLVVlGO4YRovneXP23hclzUB46fguq+s6YQkikggDDIAS4NBhX01hAz3
 BxQqVApsa7+E1VMCcA2lPoCoiVGB8LEjoV1m4qWUlyGhemgoeLcvYS/7a9m0F5Cv7ujE+
 +MkQar+tR4vC0rSqep61koxOJ0kVy8ikHYqWQijM/hL5/6MCvSawQGES2ppN2VrTVAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788443058;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=m9CyYYtVFKA2uOpjTdyS1DbrQpm9uvu7kATEGz19XfQ=;
 b=blVZdS4d7U/dfQ+6L5FIVXSdEn83mey7YwNKkAvXXynC6WfyMqMo3OcCKq9jiamLJ97n
 5tn71zIpQD1Gv1zhFaVhD4v6eQ/FKO8kTdjzQZF8WSBxfp4birOF48ZlvNfgkDcRhKecb
 sIHHvLIMEcw0tdz1Ukj9kcWEmpOGblJpZVTrqY17gqAkzO9NKxClF92LqPYTBtBp7mKwG
 NnRfHdduRAosVVXRqNoJ0wO7hMUuKk+crhKs6I5hm35pp/v0ggxao5hPoNOr/YREkuRQb
 ribJn0mj5i4kTE+l314Ve1u5hTBbfpQF2XDyv4pgM++nSQNEjxN5jPJoCHOrO1b+MIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iSaEdMjd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iSaEdMjd
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAD8B40AED
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1730439f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443055; x=1789047855;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9CyYYtVFKA2uOpjTdyS1DbrQpm9uvu7kATEGz19XfQ=;
 b=iSaEdMjdBAyQN/XGUolubcvpgWWuvsin1X7fYG4RePu16NQwS8dC0YLLTpmqQ59lWo
 QR9Kf8aUHWpgoXZ252+yVPeySX2CftO5rrrGe50m/MKKJQzXEslRNSXplCv3EY5cnbuP
 S9WNmJJ4Zl7F2zGVGNx2GeFLqyzeN2qQp36P5nkFrmjFfxQ1FHHcDEVUrMwVBzC3XMe+
 RbQU6O5wFG34S1wxR+QWx0634JebimYq3JCuXTN/HwbhmRNGXTWFyTKlYZ2qgy4fGzib
 V826fE3LpOzAIRRhp1tKSLKbpxeQNbvPpav+LX2B7F3SCimrD8saeEuwGv9rX11tDypP
 HB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443055; x=1789047855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9CyYYtVFKA2uOpjTdyS1DbrQpm9uvu7kATEGz19XfQ=;
 b=YSuJgaLuAlPSnWo2MZexvkqmoYWYdzATGvCGtfRFDU2aubmdIluzMp/0XjqtGJrf+X
 xBtgXL5XsQJTS3tzJc5jlBbTpjwlFTKN25n9gdPjUMSbr9BS8kniIo164WgQNscrBKNG
 hXn/qgxPsFudFr7VsH1lEW83W1IjW16ryuYexy9KhUgLJNBF11dEbwR+Fxklp9ELEFjn
 UHdNZ37wjTf7/icPtvp9XvEi6uTrzYdPn8VycMzxAxPABet9nst0IUENFi99UbkIJPxd
 GL86s1B2NyeIyKn50KobhlGAA9D+XSDqnrRluqRwoCGIm+L7vdzFz9WHOczL+zF6CFPy
 6zpw==
X-Gm-Message-State: AFuF++nAVHvdK1+Y1/4O6Uzx1HhcDVUCdx/tZFKjX9pXmgePkFDImUN8
 n57A5Nh6nLoS6Qjc7mFUEgCW3ydcoIiEXQMPNJysalckkfSJJ7IAtzFBUnROFKBVeMA=
X-Gm-Gg: AYBFou21uVMfS0XIRimrTm6P6Eq/wbwtPMNHirf5YahxVvWqrbBs1n4Du8TIRnKQSoP
 UkYKXee/eRUs5Z5359FzrDaXp2LzPNHvCBJGdvEP41yat725PW4yjOU7UOYhGty+0YmgKVfavOm
 n8V3V1PhtTxLkxDypTHq2HE7/G7EIepGOO/7MjorKF4Js0+iPx86Vyz4sIZmUFcQXB+9ak8Gup4
 3XoZUkz5FglnI3G/7GGMocvNLDGeI/TyfFwyGmoB+LEsZy5lVrsBBZkwdHaFylkTneGqWRiUS86
 CHjo1K2+X5KaG/DaTqTfio9yi6YdipIX7iawuY4jpPs5NQPeXM3bssSFBLm3v6ZH4KjH0AhpRjq
 qed6U2wqylv38WdJvq7CO0iU/VVTm9dwecDHL2LB+I0ZUHMTq2no137/G7NoLPbwG+BK9tDo2HT
 oS9/4EyI3CLDAJLj8QOXqkNKb5Ozft1++gmae2NRU7O07WgsToRNnAuKe8tA==
X-Received: by 2002:a5d:5f88:0:b0:484:3f25:426b with SMTP id
 ffacd0b85a97d-48488f00bb4mr21962406f8f.6.1788443054936; 
 Thu, 03 Sep 2026 06:44:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed30c0sm14332165f8f.24.2026.09.03.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:14 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 03 Sep 2026 15:43:14 +0200
Subject: [PATCH 3/4] configs: am43xx: Switch to upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-3-47e1c63d188c@baylibre.com>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
In-Reply-To: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17244; i=msp@baylibre.com;
 h=from:subject:message-id; bh=EV5OkKGqZTBYKgFpihUoBV/uR1LuXlRLGl/p+JQXYMM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyZlXNyZ5uahm+emmogkvVbMFLmpcyfp8UfG+dZnjrmc
 rKjuCG7o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZydRfDf2cG/qiKmncMF9aH
 +xUFLLp+SkrZWPPcPdbPd8ofrXZ/UsTwV95k6Yf4NfvcZ9YX6N9bpzvdYEXD8iUL5v+Wruvl2X6
 UgxkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Switch to OF_UPSTREAM using the upstream devicetrees instead of the
uboot ones. This change requires updates for u-boot.dtsi and defconfig
files.

*-u-boot.dtsi needs to be updated to reflect the new label names of the
upstream devicetrees.

The defconfigs need to support multiple new drivers/frameworks to have
the boot working.

The qspi variants have no SPL config options enabled as the boot ROM
executes uboot directly from the flash.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi           | 32 +++++++++++++++----------------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    |  8 ++++----
 configs/am43xx_evm_defconfig              | 22 +++++++++++++++++++--
 configs/am43xx_evm_qspiboot_defconfig     |  8 ++++++--
 configs/am43xx_evm_rtconly_defconfig      | 22 +++++++++++++++++++--
 configs/am43xx_evm_usbhost_boot_defconfig | 22 +++++++++++++++++++--
 configs/am43xx_hs_evm_defconfig           | 22 +++++++++++++++++++--
 configs/am43xx_hs_evm_qspi_defconfig      |  8 ++++++--
 configs/cm_t43_defconfig                  | 17 ++++++++++++++--
 9 files changed, 127 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 989249ca2878..24ab38920ec5 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -14,14 +14,6 @@
 	};
 };
 
-&am43xx_control_usb2phy1 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
-&am43xx_control_usb2phy2 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
 &ocp2scp0 {
 	compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp", "simple-bus";
 };
@@ -42,10 +34,6 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy1 {
-	bootph-pre-ram;
-};
-
 &ocp2scp0 {
 	bootph-pre-ram;
 };
@@ -62,10 +50,22 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy2 {
-	bootph-pre-ram;
-};
-
 &ocp2scp1 {
 	bootph-pre-ram;
 };
+
+&prm_wkup {
+	bootph-pre-ram;
+};
+
+&prm_per {
+	bootph-pre-ram;
+};
+
+&prcm_clocks {
+	compatible = "simple-bus";
+};
+
+&scm_clocks {
+	compatible = "simple-bus";
+};
diff --git a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
index 6393170ad22e..0574abeb7a2b 100644
--- a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
@@ -23,19 +23,19 @@
 	bootph-pre-ram;
 };
 
-&mac {
+&mac_sw {
 	bootph-pre-ram;
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	bootph-pre-ram;
 };
 
-&cpsw_emac0 {
+&cpsw_port1 {
 	bootph-pre-ram;
 };
 
-&phy_sel {
+&phy_gmii_sel {
 	bootph-pre-ram;
 };
 
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 741f8f85f801..8bcca44c69c4 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -32,6 +33,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -42,7 +44,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm ti/omap/am4372-generic"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -52,10 +55,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -75,8 +89,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 86d8389951be..b936a19ddcb0 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-sk-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-sk-evm"
 CONFIG_AM43XX=y
 CONFIG_ENV_OFFSET_REDUND=0x120000
 CONFIG_DISTRO_DEFAULTS=y
@@ -30,7 +30,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am4372-generic ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -42,6 +43,9 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 11310935e7e8..78c17385a08d 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_RTC_DDR_SUPPORT=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -29,6 +30,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -39,7 +41,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm ti/omap/am4372-generic"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -47,9 +50,20 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -65,8 +79,12 @@ CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index f2dfb79802f1..1d8ca3c01f8f 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -5,10 +5,11 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_TEXT_BASE=0x40300350
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -28,6 +29,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
@@ -47,7 +49,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm ti/omap/am4372-generic"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
@@ -59,9 +62,20 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -80,8 +94,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index fca9ea21a778..1857e1a2c271 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -7,7 +7,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -16,6 +16,7 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x403018e0
 CONFIG_SPL=y
 CONFIG_SYS_MEM_TOP_HIDE=0x4000000
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -33,6 +34,7 @@ CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NET_VCI_STRING="AM43xx U-Boot SPL"
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
@@ -40,7 +42,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm ti/omap/am4372-generic"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -50,10 +53,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -73,8 +87,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 6b754cdc0ec9..6eefc3884e1d 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am43x-epos-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am43x-epos-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -32,7 +32,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am4372-generic ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm ti/omap/am43x-epos-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -44,6 +45,9 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index ba898b119537..fe2988243d9e 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-cm-t43"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-cm-t43"
 CONFIG_AM43XX=y
 CONFIG_TARGET_CM_T43=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -23,6 +23,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="mmc dev 0; if mmc rescan; then if run loadbootscript; then run bootscript; fi; fi; mmc dev 1; if mmc rescan; then run emmcboot; fi;"
 CONFIG_SYS_PBSIZE=1050
@@ -41,7 +42,7 @@ CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_PROMPT="CM-T43 # "
@@ -63,6 +64,7 @@ CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -70,6 +72,15 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DM_I2C=y
 # CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
@@ -93,6 +104,8 @@ CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ATHEROS=y
 CONFIG_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_I2C=y
 CONFIG_DM_SERIAL=y

-- 
2.55.0

