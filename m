Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE69C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6750940766;
	Wed, 22 Jul 2026 01:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ik9-BlPDv2wS; Wed, 22 Jul 2026 01:37:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BC8640417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784684226;
	bh=ytjuK5N1aJczaidNrCFVLcxa5O/8eux6RtQFenSjd8U=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pODXlt94GXxCh8UEXJz3i23itvjDAtXj+M7c8Gfy81q3bhk5m41j/IOOiGFDukbLP
	 dj7ncyIwYfSa8KCj84dvN+cqZMxNxVRCjh7SP9AcC5yKZwvbPKcdqrnGzGr/o7/Ot+
	 8A2Serl5Xe9zBRnzxXhrzM0R+WgaUbSVOJV0dR4LsxDhIg+BAhD44c+sWR6H/CWLIS
	 Nb+113utZBnxPA61PrnH+AhzFiYnNrD79rh93Jo84Qwsk1lHq8ZqGGqOnx0HgH/M8w
	 JSCC4g2Hi6G6Hh+2Y6JajRhuyaIAzfWhF502SBKGRRkhq2uTtDnoJUP3yqnTnStb+9
	 A0nBE9ZWa4gVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BC8640417;
	Wed, 22 Jul 2026 01:37:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1913E42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3571400A8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufXyRpZKHAlc for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:37:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D680C4007C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D680C4007C
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D680C4007C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:03 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81dfdbd86d1so79374527b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 18:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784684222; x=1785289022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ytjuK5N1aJczaidNrCFVLcxa5O/8eux6RtQFenSjd8U=;
 b=bjRXPGQV2GK1Wur7X/wXeuhqc/iM97fJ8B862wmoyRqhzVMEidrvDWrkw3Vesju2+B
 I7UjgCEki41AMvG5QV8hf0GqU68SxFQ4A0lniYIHfXanDq8mgalRUNcv/AM7Sw7tUwDQ
 n/Fg9RtLW6xn9nwI+W6mdsw6GPi8s6bcH0N0Ok9pa8IlXqBiQcQSZ3m5V9TGVKjThEu3
 ePRzIyMj6kdKP+35RG/s+VviTneRVyLD0kihIOTB2yf2mUTCfrgQoGEyWePY+oOHiDRU
 RVCEoYnCNbAPZ5VyeYx76lki3cat3n9xmOWFMtX6a9vDpx3WlTsbgWg5WQwg1rDILJaA
 fV+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4Ze8Sl5DSv5P+97jq8fGsXL4wOlo7bIE4DQ2wUHjAZdUYHa11tZvsgS0imC2k/afe2Ba2swI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz+difyBXOuAY5cojWyNVhmV3T+atdo67hXjPPle8okUYe4RU4a
 TTL2kQeLXf6dJWT+pSP4BrbXFBuUZavhgnbhy4PHlBBrC1ua1V61RlpZ0Mt4Ig==
X-Gm-Gg: AR+sD11zuwKoARnhECtlohB/utF+evF1QKb2BZvoEUtPbUlc6P78GRwv98crN4FilB9
 qKNsWkoHgcZ4QKofoDUyDNGe9dWde7iMc6cIo5aPeDP/dPsWmhJ51hugU2ZdcrcC555H7YbhDv8
 B+gdTRIEjxxaQ8aTbTZo5qGcdFQpyR3P1SAhXWOClseQeFJa9GY/O0oor/nAvwSTxLNYjgAd8nc
 Bwx84cFFWi9GfrgYcHKpKvz34uZVxtqJDsnhk8wcNz+9mhObxvsavJ/rquB7F6dT5o9WXPBrLKn
 cPJ1W07/q1aQ4ZTJIeEcCbTQ6DmRn7PeL4bKZyMAikh6oYt0me7PqEYLb5SOhV+wz/1KPDCYokk
 uISlBQTpFlFDwMTH94gEMiWGe98Mg8I4AYygILyue3GtjpdeUGK92t1K+is2cXi3kdGjzgZFY7F
 bC5J5SRIt1MS0d/7mT/ypb+JOOIjrKtuLYpc13/OAe5YqW1EU=
X-Received: by 2002:a05:690c:3a0:b0:80d:e322:5426 with SMTP id
 00721157ae682-81ef25d6533mr72890617b3.40.1784684222563; 
 Tue, 21 Jul 2026 18:37:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:1ad1:7a2c:313f:6408])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33ee52a0sm6372937b3.36.2026.07.21.18.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:37:02 -0700 (PDT)
To: u-boot@0leil.net
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 2/5] rockchip: rk3399: Remove ROC-PC regulator overrides
Date: Tue, 21 Jul 2026 22:36:39 -0300
Message-ID: <20260722013642.1011666-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722013642.1011666-1-festevam@gmail.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784684222; x=1785289022;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytjuK5N1aJczaidNrCFVLcxa5O/8eux6RtQFenSjd8U=;
 b=mcXaV/9i9sQQ1flCRHxdBEdyHYCmKNwn4woHL+6CD+wXY0W1o+O8A1hVGkCnzl0aqs
 Utr7jxjcaMW57nEcABozoe6p/f8mEazGkQ02eRK1LzeGU2YTgPYhUXzRLWqcHFHfQyoa
 CQT7RiXPYC/rnd2iLCzrDWPj87cXMrRYygQkk6rXkJKW9AbUaAGecOuqYUPbeR27Gy2B
 mCKbOoNdH7PSJL0KPWn1KM7lZ/rkhkBaKdL0bV4LF6GVriAcYSdZQsUgJIRMvyE4ZH5u
 TSOCNH6JkuSt326SPI8Gyy+lkTrJJeLDTeMHphvfiyPCkBqKtCw0Lb8tWyz+p1KOIMHm
 XzzQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mcXaV/9i
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The upstream devicetree already describes dc_12v as the output of the
MP8859 regulator and drives the USB hub reset through the vcc5v0_host
regulator pinctrl state.

Remove the legacy fixed-regulator overrides and rely on the upstream
regulator descriptions.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Newly introduced.

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index 883d399a06a3..a85e9549c83e 100644
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

