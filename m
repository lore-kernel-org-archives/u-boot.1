Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F2AC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 11:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0527760AD9;
	Thu, 13 Aug 2026 11:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZCP84VedOVQw; Thu, 13 Aug 2026 11:45:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11D546085B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786621500;
	bh=ihl+Nk+2XEOzroa2rxeSc9Q/2lN1joFPQYbd0S1sKCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iyZ1rl+lXWvmcGKWfRfCG0oXaCby1dHSncsFb1CzW6+X8T5kCJRWHmdbz5PkvmEJ7
	 2/ruTCMFXe7ZGJvPLAz/v/k5h8MU5olGSxWfo8T7o9yzuZox//8WprtPe13O4i1ahq
	 m8prtWNhDqUd5wp86Z9F2oSbASStnG3NFORiQAuXnINJydBlcX8kA4DuujJodQoyzx
	 OJGEUTS5FMntVeO4O45Oy6/ft2PJcB/hgPLAUsecYFzgjCOljO6kS6bxvGr18qneGG
	 MKCS6W0L8SRbQ9ohtOE5T4ypvJL/fAYdwgmlLXDP3wUtnFyLiXy2JqH1/ka8zUS4Mg
	 ORpe7kspz0zvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D546085B;
	Thu, 13 Aug 2026 11:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A774B744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DADE401A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDwul5clScC6 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 11:44:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EECD2400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EECD2400AC
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EECD2400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:44:57 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbeeaac53a9so1509664a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 04:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786621497; x=1787226297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ihl+Nk+2XEOzroa2rxeSc9Q/2lN1joFPQYbd0S1sKCY=;
 b=AcINMYzACJpffDL0lFgPb1xNgqfhNjEOQm+k3Bwa8CJ/z1v6D2xFYvKSbSVmL1Rj2i
 zV8goMkHoGMPPuWU2EB6NvGGgi7PEM/UwKNlXeBnTJjGx1kURr3FveT5NmHCQhPIJvee
 QTg0huBKjB4LMdjonDnrw1aNaGJw/LxyvP07wYVUzZloba9qTZ+fW+ifccsik9YumRCn
 VPKBvF9CDpR1lFcJoxqzSLR5/Oi6FFB00AcuAcNS9tvlkAHtmH0lAXTyWvSdnqcBARBo
 uyloYGS5Y2I4X1V4qV95NMMHYP5yZtyp+t9yfB+3F0H40OznyrhqFlmk/clu4L8EUsfm
 rsXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZWG1CFxMEqapZL8NI5D8TQw7xld3ka7juat5rbzmMA67+edUKmyj/n7d5pcMqLrr4At5IXro=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyR02nI9ZmJ1iG/VfmA1Cfu/7TT1kKvXRIu90ytSRNIe5N12U3p
 utDc8GyvzlsCuf61jXWG9Jp73Hyb0y+XVAzJlHjT8JPiEW99n0j7rWiJ
X-Gm-Gg: AR+sD12DzzEnl3kVtG/pRX90vV0ervCEpV+djVChP2+2cQdqOGqdiJGuqdxuCsPHlX1
 zVL+1CLSSpZbUf1DGkvSHt7WlFeBmUx3nN5x/449t/iRHHZDl8ZI7kQB3WixjbSa5SKcZRcDnnG
 huBVotkpMiBC8aZBjBFamwVaJemm6+upkU1gcfeeUVGGynZj81FXictl0+1XrcONM1tNKd61WDV
 yGaISRNU+nZhtyZ4nyoapv1mItV2y2OijrGpJKPLeWNXus1m95uokKt3Ma/+Fubh3WuXPCyANvN
 VnhEJ8lyQ3xKF05adfRf04gnrwPY4GOPXaWF9/JE0pnXGU/lf560A+iIM5ajzpGTU77kE+4D3bO
 f4kxISQRY5/O+2+/IXc2NHBexlALVO3sgnA7MdpioDlPpNt3h3UJISRwjUuVKQ/7lchcGghMlqn
 xTf6GUA96M/O/EpmSvGfLGVVsnBgEvmbrCMWHXvwCfbPCzOAXPFdZNYn09R+LwJrA3Rls1OQxXs
 Xoh7z5HG/JbfBXdHYzJ7/B8EOA3KMQXUUcVUQ==
X-Received: by 2002:a05:6a20:2587:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3cc553c24ddmr6133750637.31.1786621497190; 
 Thu, 13 Aug 2026 04:44:57 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721aceasm918764a12.25.2026.08.13.04.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:44:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 2/4] rockchip: rk3399: Remove ROC-PC regulator overrides
Date: Thu, 13 Aug 2026 08:44:43 -0300
Message-ID: <20260813114445.51640-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813114445.51640-1-festevam@gmail.com>
References: <20260813114445.51640-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786621497; x=1787226297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ihl+Nk+2XEOzroa2rxeSc9Q/2lN1joFPQYbd0S1sKCY=;
 b=hM6zo7cWdkWWQ0KEj5YQNK8g57tILD4hQDf++G8IsJ5iUxYPJ/mgxS9Uo6Tm4hHrgv
 3h4kNeuwshTwc8lPorgXvlq301OolPXxaHrGodFChV+rcyVkcr1yxqqp+odQ7lW5M+FD
 YiI8F0Fey+QtUDUk76l3jk5H/FfBrFXPZ0jDkOZMz/l3tZPj2N2UzZxJs6XZt3CM3SO8
 6K8f3l4+bQX+Z3whxdpxdcDKUpjiJqTE4oIQDu8/13CzCJgWJEpfJ/xB01yJ+U2V2MeO
 Tga95aF5J05nKhXTha7DCYxtG884P2hbtt7as0KNohdtJwf6uDQM7v7GB/O4adovgZDy
 TJfA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hM6zo7cW
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
Changes since v4:
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

