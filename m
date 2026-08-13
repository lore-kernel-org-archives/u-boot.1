Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CCBC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EE5B810FF;
	Thu, 13 Aug 2026 17:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CSLyqvt6afuO; Thu, 13 Aug 2026 17:03:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E05B8110C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640580;
	bh=0Wrq2y1g1VVe6QnG4XJn2OOAXu8NzcS+cj3wd1vEe40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZyNHuLSsKGy/Zm/myocOOc4nzlojtY7G23X8xlEGCtHPiNIN1PZh6qEYhLcro6OeG
	 9DSUUgh5RIS6vfj8A8NPyqEdKaulY5iYldgDEUWY9+D+WmqD7635z5HBmAUqJza6Lv
	 oJoZlcnHKw/ICRRlJB8u338pZP9WfhOn8o8btXtHEBJxJIad2wAxU9wsZlRYCt23lf
	 C+gPWdPUMKiZkE3K6DR+u51tRS/QEhMObanMBRK2AixuLBryKut8Xy3RJwfd/WAMDc
	 QWHr+opXjyNjuCDPFz07/bKMLvTss/u++8IBpJBVvSshwWhJiMsXxCvIvkmlZwLX9l
	 FpWLs1Y82xmTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E05B8110C;
	Thu, 13 Aug 2026 17:03:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C8223A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E6D5607F5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyiCeFWNextg for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:02:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7043D6070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7043D6070C
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7043D6070C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:58 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso70074a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640578; x=1787245378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Wrq2y1g1VVe6QnG4XJn2OOAXu8NzcS+cj3wd1vEe40=;
 b=DUW80jNtf2GwO75EOY95bLpUJLtFAJ9lqFge8QOpObzil+Gp3PF01cXhhy3Kef6cIY
 kJdY0lb4vM5bqDSHfuRCCAUHvASXPQjFN4KwBhMZsfU9GutuivAjNSMevx77Gvn53S0c
 aE4zheFtQC0S2HMKZjW4rCn/Jn+FgVKEpJ9Cwlayp6XT7F9AZt0t9dqJVBkGMgOuUDIp
 jWZ2klsmnX65/yHHQEmvsDxsrKf4Yl+lugjx5s9jMnYatudpwQm5CvezlFZIAmjosYk2
 WXA//2xT1KZfpLfsborL5IOKkySC147Y90rr+wZV94Jx5lOR46oGKUb65tAC4+gQFvkO
 WMOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFN2oLbCbs+Pl7QnhDhFN5NHuje25G0qAC4wnFLIqhkl5qd2ULPlauQpM9ESLhuLbZ3d3UYus=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw/pLZOH7thJqaflr9oIfa8VrpdGylXak9FP0awpj/Y5HHXw+9D
 CApQUI6+SQWIJ7i1s6vi4Zdys9f6cqbC23pJOMbt95RTVmmYEdrH+NzNLv/oBg==
X-Gm-Gg: AR+sD11STdawqkNaOM9SrDzT7LBj98CrhaBVrPCwby1ntbPu5XSfgI65jdfA7IECqmR
 ZhpPAkkNuTySFIe/ZP83RyJebuc9VzW7ipCubhHfe17Ebgd5o7goJPJH0xqwMtKo/gkvUtNmHOu
 8NxZOflghuxds5392F8+m1aPcupltf2DTQ5UBpiwHf4NL7HHJ8zCOEzX/ATcWezACv87FRtb2Oo
 ywG2g0GUYRQP2S+7gKSpnm7fh0xbYyH3Ky2zKUKZimKGV4KQbXVDTeO20WtCKdcwumEHlqX4SQ+
 ueyXWxELMk4PYNS5kuYaa/H16QKTRGjPn7zt3YZhasuOwHDU0uqrC9WVb5BSBBU4G8UQGlNrZ2e
 7neNdixwT1Zmdz9ZwofAtcMk6VJdrEzzDW2Z8glWnAbKRzqcQNgd/R0+/eaXni5A7JM/yX83cmQ
 6mLs9uyKWsMHMYEGYvJXoPq7d4HVwTmUphu9pzTaA14udV2TnBD+k5sZEDIbagMtJCTz4D+F+hy
 asjFWXKAv5cgxp/PBkwdficyhRBQyrxwBWFuw==
X-Received: by 2002:a17:90b:3f84:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-3931e25e97amr8669114a91.17.1786640577503; 
 Thu, 13 Aug 2026 10:02:57 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889d914sm92391c88.13.2026.08.13.10.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:02:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v6 2/4] rockchip: rk3399: Remove ROC-PC regulator overrides
Date: Thu, 13 Aug 2026 14:02:44 -0300
Message-ID: <20260813170246.110899-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170246.110899-1-festevam@gmail.com>
References: <20260813170246.110899-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786640578; x=1787245378;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Wrq2y1g1VVe6QnG4XJn2OOAXu8NzcS+cj3wd1vEe40=;
 b=Q48/F1nPIEnZFEtGq4YjkLYpvUUJFBJ5OJMKWzox6zGOr1SLBNBnQlXirOmz+SlInG
 TrDCigAQpig4YcTGqgB5HiIsnyph1iQsoAqkyF6MzOh8ZgNKUCIBgz2WPFJEWOvrPqyq
 i88jojrIV0GJKZkb+8wi7zXjwlp/qGXcYXhn6SiPZ9ax0lKtjyHyp0u1s/43j1KR4ul1
 eiA466uO1CBxutDysAISfkp1mp2VKRNhWqe0u+LF45yvofXO2Z38WP/8GEGQ7wWHXwAr
 jqag/mleR1HreTlkk5zybTTINWBPaZ0qAM6YBctLMHDCPxUQTY6NLEhr/yZAC4YhvGyh
 P8/Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Q48/F1nP
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The upstream devicetree already describes dc_12v as the output of the
MP8859 regulator and drives the USB hub reset through the vcc5v0_host
regulator pinctrl state.

Remove the legacy fixed-regulator overrides and rely on the upstream
regulator descriptions.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes since v5:
- None.

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index 883d399a06a..a85e9549c83 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -10,30 +10,6 @@
 	config {
 		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
 	};
-
-	vcc_hub_en: vcc_hub_en-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hub_rst>;
-		regulator-name = "vcc_hub_en";
-		regulator-always-on;
-	};
-};
-
-/*
- * should be placed inside mp8859, but not until mp8859 has
- * its own dt-binding.
- */
-&dc_12v {
-	compatible = "regulator-fixed";
-	regulator-name = "dc_12v";
-	regulator-always-on;
-	regulator-boot-on;
-	regulator-min-microvolt = <12000000>;
-	regulator-max-microvolt = <12000000>;
-	vin-supply = <&vcc_vbus_typec0>;
 };
 
 &gpio4 {
-- 
2.43.0

