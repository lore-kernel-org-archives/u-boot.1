Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A58C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA57C82D88;
	Tue, 24 Jun 2025 10:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LAGwCs+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3D182E26; Tue, 24 Jun 2025 10:45:35 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C71182C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so3971900f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754733; x=1751359533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNwIo763QDIjbAUp1EggIynx2zGTwsBzmOaEWfru47Q=;
 b=LAGwCs+Fk+r5Iyew9Loea1+bovIwmBfO940ShTW3Gkzt8k6xSoQDTT/br8Y52ucfgJ
 P198uS8gKd3i284swDmgfBDI5xjuObULRt7I3aTBTGKsqeQ6/vKNKZm6Bhyi6nOmZD7E
 ClgRGxvQGlQM605aH7cdqrfOlm6LS4whFFT7TLOTd3XoX78zay5+XDLoO7k2GmeWX35w
 hCTQIMlFN4hCFYQfCDJ1LZQaCIAQgixTesRoIsS11qDAHvUfykxVTdLwa14QwJmFwvcW
 +9Z1sduJvjzZGubQGoQD2d6kwLUl+9HfWI5H6KSCK7N79rNyazeRRk8IuogMG+GwxBeG
 fF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754733; x=1751359533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNwIo763QDIjbAUp1EggIynx2zGTwsBzmOaEWfru47Q=;
 b=S+eSPKiT6PXVK6gdHlbe3h2RfD1MalB7miRbPO2W2m11EnUfZ+F+9anXlki+NYVUZc
 BuiR56y7rzqsCi7O+yoe3jLnSpPt1H7YZOOgF6iCc52euUnr//8SIhChaq9VWfES47gQ
 qojJ5hJe4YM5WLcj49WdVqYDNdPmBdBrC+9rPmUXjr3ECM7U+qBemicszl67yynUZppO
 ZancgBVu9lspjruOII45g+02nOrXbb6XnuvZnjXwQALVRiw1ijuvg7y5PauYjxLN4K7/
 p53E28xIQHPlGDOLbsXnIcTQmGb2hu3SYMT05fgut40Mm5YFBL+xN9HXFo7vlgrvIslP
 x43g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkj3KEBW9OBVecbe9ZWhRYu470dnJEqbfAhfIer9jDoO8rHdflUiTFk7/CzItAJXPBHOTX7Lg=@lists.denx.de
X-Gm-Message-State: AOJu0YwpxN6Cme8+Mfw8/fHCT3q7oqRs2xWDxyGUEW9+QypmCbhGoDaQ
 9PZS/uTALtZAAI0LfUxrHv4uwSRmfCtFqyfpUT0N1oRHUGOLKV8rwPA2xe/z4asaeNA=
X-Gm-Gg: ASbGncvYqxrUXnghZNQilwSlIeqzvvPIboLjgxUkA3/y955XFG3BCpppPCxt5Iq351t
 ghYxo9zp4JC5W/ZNduP6cWISO1Nvwmo81hGULkYRROyWOAurzNHkrjMkK/297djP5i0NHTB5BR+
 ZltESy1946KGjTwI3S1MQ16O2S2vTMFBEPgH1z6zmw/KPr0JRrv63UWLI7u8N2Pdk72gjg9tfuB
 SXaMr1CE4+Dhm57dyWp9SR2dY7gmiRXa2m7m3VgweUWEAO8v3i/rXYEK13dKsRDSdEeP/H/A0qg
 LL5i3RcUA9M6ZkhEBj07r6dUg9idlx8QyA9LWFwczLHdiehZ28/ad6wkMF38koT0Ui1vL93HbRk
 =
X-Google-Smtp-Source: AGHT+IGMC3aVaIhNDLB116WvM98sJRu9gY2pMyX9E0cBx6CcFeVDiB9/yAgBBM6mkHZ1zbGCGSLC3Q==
X-Received: by 2002:a5d:5e8a:0:b0:3a5:7991:fd3 with SMTP id
 ffacd0b85a97d-3a6e71cc128mr2261854f8f.11.1750754732511; 
 Tue, 24 Jun 2025 01:45:32 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:32 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:14 +0200
Subject: [PATCH 01/10] arm64: dts: qcom: msm8916/39: Move UART pinctrl to
 board files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-1-d96c97ae41d1@linaro.org>
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

In preparation of adding a new console UART specific pinctrl template, move
the pinctrl reference to the board DT part. This forces people porting new
boards to consider what exactly they need for their board.

No functional change for the boards upstream.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250422-msm8916-console-pinctrl-v2-1-f345b7a53c91@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 8d88f6c9c5e774420673a37510b22015b1edd569 ]

(cherry picked from commit 9671fb87cd7a78c52ec50cc30ac63e73f2c4ec5a)
---
 dts/upstream/src/arm64/qcom/apq8016-sbc.dts                     | 6 ++++++
 dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts        | 6 ++++++
 dts/upstream/src/arm64/qcom/apq8039-t2.dts                      | 6 ++++++
 dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts             | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts         | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts               | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts           | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts               | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts                  | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts                 | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts         | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts         | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi        | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-mtp.dts                     | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi   | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi     | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi      | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts       | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi                    | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi       | 3 +++
 dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts        | 3 +++
 dts/upstream/src/arm64/qcom/msm8916.dtsi                        | 6 ------
 dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts             | 3 +++
 dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts         | 3 +++
 dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts              | 3 +++
 dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi       | 3 +++
 dts/upstream/src/arm64/qcom/msm8939.dtsi                        | 6 ------
 28 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/dts/upstream/src/arm64/qcom/apq8016-sbc.dts b/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
index aba08424aa38439952f959f79a9ded2201de1f7c..6175b1b9d7c6e82ef8ed3b6198b4b8cef81514d8 100644
--- a/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
+++ b/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
@@ -222,11 +222,17 @@
 &blsp_uart1 {
 	status = "okay";
 	label = "LS-UART0";
+	pinctrl-0 = <&blsp_uart1_default>;
+	pinctrl-1 = <&blsp_uart1_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &blsp_uart2 {
 	status = "okay";
 	label = "LS-UART1";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &camss {
diff --git a/dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts b/dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts
index 75c6137e5a11dd5c738681d676dfc9b014efb34c..7a03893530c7b89705f5544491c14edd7120acdc 100644
--- a/dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts
+++ b/dts/upstream/src/arm64/qcom/apq8016-schneider-hmibsc.dts
@@ -190,11 +190,17 @@
 };
 
 &blsp_uart1 {
+	pinctrl-0 = <&blsp_uart1_default>;
+	pinctrl-1 = <&blsp_uart1_sleep>;
+	pinctrl-names = "default", "sleep";
 	label = "UART0";
 	status = "okay";
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	label = "UART1";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/apq8039-t2.dts b/dts/upstream/src/arm64/qcom/apq8039-t2.dts
index 4f82bb668616f942d65f59a6f418cf38f404df32..f656eca59ee23a6d19450b4d3fee7a661b002709 100644
--- a/dts/upstream/src/arm64/qcom/apq8039-t2.dts
+++ b/dts/upstream/src/arm64/qcom/apq8039-t2.dts
@@ -116,6 +116,9 @@
 };
 
 &blsp_uart1 {
+	pinctrl-0 = <&blsp_uart1_default>;
+	pinctrl-1 = <&blsp_uart1_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
@@ -128,6 +131,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts b/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
index b4ce14a79370bc16b7d8fe144e56f4bb27e01534..9b82468ace3edfe8d808492b83e7753d3314e7af 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
@@ -133,6 +133,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts b/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
index 3459145516a12ae8e054e24b3ed9b73f9d79905a..1c2f8e8f9b263b024cc7c239447e7158262b0c1c 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
@@ -214,6 +214,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mpss_mem {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts b/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
index 77618c7374dfe29cf5660e0834aa2b0fa6f3d67c..f7a9ee0dba09eef83e9b4149856cdefa0ae3fd4b 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
@@ -130,6 +130,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mpss_mem {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts b/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
index f7be7e3718209b9ca96afb13ea1aca05e1388225..e5ca1ca0d9976a0d36af5359e705ca7b2070122b 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
@@ -131,6 +131,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts b/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
index bf7fc89dd106f670e7cda270c7284a6a3d7d052d..f75e60b5d1b3b40673cb0639a3f8d0056d037a02 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
@@ -214,6 +214,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &lpass {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts b/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
index a823a1c4020894edf845130e72803b48dbd24ac8..7c49b4cb27cb5a9914b38865596eb27541f390fd 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
@@ -59,6 +59,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts b/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
index 07345e694f6f46bbf71ed3c551b2a80d5f352d2c..6e55d37f588c9b829bb594ff156cda6cb8b6caf2 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
@@ -112,6 +112,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
index 7f0c2c1b8a94b2c4d79e5e0b2b7188f4e2b2d281..4576178cc9b0936a7356b9852fc003fe949ed903 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
@@ -254,6 +254,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &pm8916_bms {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
index 2cc54eaf72027a213f9d779c57fa22386bda934a..e0dacdf552452a36cbdb041b37d68eb4d661e6c8 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
@@ -178,6 +178,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mpss_mem {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
index 6a27d0ecd2ad23b462191a5a328a49a76ab13b42..48134e5ff524fd5708db7b9c3a567ec3f751868c 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
@@ -69,6 +69,9 @@
 };
 
 &blsp_uart1 {
+	pinctrl-0 = <&blsp_uart1_default>;
+	pinctrl-1 = <&blsp_uart1_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-mtp.dts b/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
index c11a845e91bb5029e89905ec7dee3b07646dd4cb..c115142df364e99a4f566775d4d1679e6a8920e2 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
@@ -23,5 +23,8 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
index e6355e5e2177df9e3beba6b2d96a15fb069ce57a..58a548d220a485e9a92c012c1529e3fe838d6c9f 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
@@ -302,6 +302,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &gpu {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
index 7a7e99b015d9bf9686d2b41f7efb76a093c1730d..4290ae7782d659eb0d2594825717ffaf4c84076b 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -304,6 +304,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
index fbd2caf405d5f686a40a59ff7e0bfc78f164e03c..30e34574999c52f7ea99c9bd7af41101e5d4d4d0 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
@@ -116,6 +116,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
index 5ca2ada266f495e4584a5143a8cce6f1f1c4ad78..d4af7856f5f3a70160774d1637e39e19d163725d 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
@@ -135,6 +135,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mpss_mem {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts b/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
index caad1dead2e03c30dd6eb09b457439a9b0446126..45c3b3387b52030a6475ae0da2a2c89ea98ca6c1 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
@@ -319,6 +319,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &gpu {
diff --git a/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi b/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
index c77ed04bb6c36dbc0cb7c0b09f50d1f18aafa4c9..2bfe56da8f6c624ed97d8a5750d12c59c039c874 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
@@ -72,6 +72,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
index 1a7c347dc3f08409f7db3b246c04687c666bba32..f5caac42bbad106f86448c217aa1472a32fbeaa6 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
@@ -93,6 +93,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
index 510b3b3c4e3c4223c64bcfa563e0e080d033d7b7..10d0974334abf0e501ec97e2de487f40c1507f82 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
@@ -169,6 +169,9 @@
 
 &blsp_uart2 {
 	status = "okay";
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mpss_mem {
diff --git a/dts/upstream/src/arm64/qcom/msm8916.dtsi b/dts/upstream/src/arm64/qcom/msm8916.dtsi
index 8f35c9af18782aa1da7089988692e6588c4b7c5d..17161673bc6c2a603caf4bee529b04e6d5867767 100644
--- a/dts/upstream/src/arm64/qcom/msm8916.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916.dtsi
@@ -2158,9 +2158,6 @@
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp_uart1_default>;
-			pinctrl-1 = <&blsp_uart1_sleep>;
 			status = "disabled";
 		};
 
@@ -2172,9 +2169,6 @@
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp_uart2_default>;
-			pinctrl-1 = <&blsp_uart2_sleep>;
 			status = "disabled";
 		};
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts b/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
index 3cec51891aed95968f7b5cb099ae2107691635fb..9f647027d082864ccaa240f7118f20a8d19f6a4a 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
@@ -126,6 +126,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts b/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
index b845da4fa23e612f04cf8a8f15b8892e396a8c41..f59647b5b7dfdd7bf630f9d180bb56a10a3ea0a3 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
@@ -243,6 +243,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts b/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
index ceba6e73b2112687d16ee595003c80ea1a93143a..3d9cbe7fdad8808968190d7a744bab29eeb0e827 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
@@ -373,6 +373,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi b/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
index 800e0747a2f79f6ef9a7d86d56c1a2006207b1c7..cbefe34327ba7b04ea57032c68dd69642e6d1685 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
@@ -126,6 +126,9 @@
 };
 
 &blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_default>;
+	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939.dtsi b/dts/upstream/src/arm64/qcom/msm8939.dtsi
index 7cd5660de1b33def5b9dc8a0d02583c3eaffb17f..d021d1dc10b6fe904786eae5e20103be9dc7a215 100644
--- a/dts/upstream/src/arm64/qcom/msm8939.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8939.dtsi
@@ -1761,9 +1761,6 @@
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&blsp_uart1_default>;
-			pinctrl-1 = <&blsp_uart1_sleep>;
-			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};
 
@@ -1775,9 +1772,6 @@
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&blsp_uart2_default>;
-			pinctrl-1 = <&blsp_uart2_sleep>;
-			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};
 

-- 
2.49.0

