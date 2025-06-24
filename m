Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04C1C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B34282E40;
	Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5OYKjOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD17682DA1; Tue, 24 Jun 2025 10:45:37 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0400882C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so46415895e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754734; x=1751359534; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u7NHRIN7hVjmjvMcTMYpZarErm30xQdmCJ421wgZVyA=;
 b=Y5OYKjOir7oA4ngAitxmSlUCJsuKeseRa4yM+EyjU3QdIPSeLi8o1nMyZRf4I37Uot
 rLdyopMDQ+f/sWtO3QlxCOuFgphu/R8jDy7JLIrYrSWN7R1nOMhdfm7ivO1xVxh/fEwa
 0F84g471qjLIQtv9JC9WwDnbMi8n25SH7m4P0wb4PC5g8nK3GXPlq8GylCjySvF+ihLw
 HjoDLIT1xv0QsRqI7fneTza1zDupuQMKiMBPoc9z3GFBg9iidpxrYAUSVfoz3YVLxSYc
 CayEDFoYpx5Kzs4GqDgZDDaO0vr5SBpd1H0NrqzVVlNkdDDXq/9lszxUVFQYKrcyZnjG
 BazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754734; x=1751359534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7NHRIN7hVjmjvMcTMYpZarErm30xQdmCJ421wgZVyA=;
 b=GgJ5UvwWKzWXNGySmSyqnTlcg+IzjGKf+WKrIBml3K24EbSaaTFVg6Vxh1k1TEtIAm
 VfFYNnOGyDCaGqKVAmcXSpev5FMyr23W/QkSrdFBApT3RdFcI1pXKf0rbg4DZeSNAig8
 IAbZ4/hazw4ASjxXb/sWQVQ3j/a8562QHK6ISt6giH6djLpl5N41Q05tiXgkmDERUKBM
 CcoRmnyD3pbzuzUb7D0p6ZqmEHixTJLZk8pK3pSFFO/3cJIkUXV39ZNyh2KF/H/bYWWq
 /i/0O75W+j6aQxEDzsmyIuTF46leO46rP9LsFtMlXxZSRwGmV8IAtlmOMjtpHK3xJ0XE
 8dKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcZ0uWaRNkDY7dm6rpDrgLmYukne82WLZyhHElE/EveT27eJlMvEHcQ+taqURzQwCrGkFvywA=@lists.denx.de
X-Gm-Message-State: AOJu0YxpsehVaRnj2bBpPErtwz6F7OAPq9dbtTpiZoiRi8FL54tOiGt+
 oXFn4Bg9mvMScT8M8oWAHfcIEmytrPZ7qWLvp/4cd9M7NepPSSnHsi7Hf4qfFN+mf0c=
X-Gm-Gg: ASbGncsMbOMU6gmNmbW/jWJhDSlSqdrJxrRPUO+DlHOFNEfsaqqXjQkkizJABYKpCkI
 bLXdaldrhI7QWsrAcy+xMuD6pQotsgR1HOUjPOy7D8x6iOW6HI1oFN569wxDAuC81rqSztDPyQD
 08TXjzMjEsZjOpPnoH35omSv+t3z5jmx8d5kNjDZeWnMeVD1ty1kAeNPBcQRD01KIFJ5A7p+Iq+
 pGeRFRQOONJIY6+6crHG7ZJYpN8228s2ee0eGEFSZDiRBtp18wAsHReHaNNzY97XfLwm71UtHOw
 FiAsrFSeSZmlRRN+46+vs5LtISCz1y2KaQh7LosRa3zo8i7BViTX5ZSaKzGSpbm3C5RRdc3SDPc
 =
X-Google-Smtp-Source: AGHT+IGLjrH1LmdcvDkuuZLQkkWIfYkOH0FY+ZXRRGBjXV94RFPvST84yRkNv5KK/G7//0qKkGr/jQ==
X-Received: by 2002:a05:6000:4109:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3a6d13071ddmr10630172f8f.30.1750754734194; 
 Tue, 24 Jun 2025 01:45:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:33 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:16 +0200
Subject: [PATCH 03/10] arm64: dts: qcom: msm8919/39: Use UART2 console
 pinctrl where appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-3-d96c97ae41d1@linaro.org>
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

Convert the majority of MSM8916/39-based boards, which use UART2 with 2
pins (TX, RX) for the debug UART console. This adds the needed bias-pull-up
and bootph-all properties to avoid garbage input when UART is disconnected.

apq8016-schneider-hmibsc.dts does not use UART2 as a debug console, so it's
left as-is in this commit.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250422-msm8916-console-pinctrl-v2-3-f345b7a53c91@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 2b8d22ef1687768e4b572d01cd2432eb86340dd1 ]

(cherry picked from commit bc047fb23c7e7c04c1d381a1618a33eb75a88596)
---
 dts/upstream/src/arm64/qcom/apq8016-sbc.dts                     | 4 ++--
 dts/upstream/src/arm64/qcom/apq8039-t2.dts                      | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts             | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts         | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts               | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts           | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts               | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts                  | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts                 | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts         | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts         | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-mtp.dts                     | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi   | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi     | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi      | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts       | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi                    | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi       | 4 ++--
 dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts        | 4 ++--
 dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts             | 4 ++--
 dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts         | 4 ++--
 dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts              | 4 ++--
 dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi       | 4 ++--
 24 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/dts/upstream/src/arm64/qcom/apq8016-sbc.dts b/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
index 6175b1b9d7c6e82ef8ed3b6198b4b8cef81514d8..f12a5e2b1e8c2cce6e85b8444c97a7e0d7b7c58f 100644
--- a/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
+++ b/dts/upstream/src/arm64/qcom/apq8016-sbc.dts
@@ -230,8 +230,8 @@
 &blsp_uart2 {
 	status = "okay";
 	label = "LS-UART1";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/apq8039-t2.dts b/dts/upstream/src/arm64/qcom/apq8039-t2.dts
index f656eca59ee23a6d19450b4d3fee7a661b002709..4aa0ad19bc0f7fde6f5f3a93cdb6be19fb4f1f65 100644
--- a/dts/upstream/src/arm64/qcom/apq8039-t2.dts
+++ b/dts/upstream/src/arm64/qcom/apq8039-t2.dts
@@ -131,8 +131,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts b/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
index 9b82468ace3edfe8d808492b83e7753d3314e7af..3a6eba904641c65ee8e982774f4122ef9ddb3704 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-acer-a1-724.dts
@@ -133,8 +133,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts b/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
index 1c2f8e8f9b263b024cc7c239447e7158262b0c1c..2de8b6f9531b25f1ee745c5e298d1cab806f0391 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-alcatel-idol347.dts
@@ -214,8 +214,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts b/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
index f7a9ee0dba09eef83e9b4149856cdefa0ae3fd4b..29d61f8d5dc9c8099524ecbfdb80ab7afaa811c4 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts
@@ -130,8 +130,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts b/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
index e5ca1ca0d9976a0d36af5359e705ca7b2070122b..742a325245c5c09dcb6227ae262865b17ee5ef46 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-gplus-fl8005a.dts
@@ -131,8 +131,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts b/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
index f75e60b5d1b3b40673cb0639a3f8d0056d037a02..aa414b5d7ee47a0e20ca2341c9a3250503184a69 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts
@@ -214,8 +214,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts b/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
index 7c49b4cb27cb5a9914b38865596eb27541f390fd..22bc73b94344aff42f560304c99cbb7b8995fdfd 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts
@@ -59,8 +59,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts b/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
index 6e55d37f588c9b829bb594ff156cda6cb8b6caf2..c50374979939c26186e97d19047de77356a9c3c1 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts
@@ -112,8 +112,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
index 4576178cc9b0936a7356b9852fc003fe949ed903..eb449112a22684492e6b6f9705389d44f2cec379 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8150.dts
@@ -254,8 +254,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
index e0dacdf552452a36cbdb041b37d68eb4d661e6c8..887764dc55b21a5892510f822004b054eb65fa0a 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-longcheer-l8910.dts
@@ -178,8 +178,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-mtp.dts b/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
index c115142df364e99a4f566775d4d1679e6a8920e2..63d476523544babc9213e34e227870a447410eca 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-mtp.dts
@@ -23,8 +23,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
index 58a548d220a485e9a92c012c1529e3fe838d6c9f..6f75707b6f9b4707cbed7e12ab60fa888d6a1f06 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-a2015-common.dtsi
@@ -302,8 +302,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
index 4290ae7782d659eb0d2594825717ffaf4c84076b..fb790b02736acff017d12318de1c01100a33c808 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -304,8 +304,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
index 30e34574999c52f7ea99c9bd7af41101e5d4d4d0..ff9679d3f664cbb203ff42b4cf27468622cc5cf3 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-gt5-common.dtsi
@@ -116,8 +116,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
index d4af7856f5f3a70160774d1637e39e19d163725d..697f25d51d9d05087500231f4d9ad77fe81ea3b3 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-j5-common.dtsi
@@ -135,8 +135,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts b/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
index 45c3b3387b52030a6475ae0da2a2c89ea98ca6c1..71b5c98458ff475e101a0a40d3601b5ca144ec92 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-samsung-serranove.dts
@@ -319,8 +319,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi b/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
index 2bfe56da8f6c624ed97d8a5750d12c59c039c874..5719933fa8e01b0b90ef7477c0bf181af379a524 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi
@@ -72,8 +72,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
index f5caac42bbad106f86448c217aa1472a32fbeaa6..ebe85cd85ddf30b9905975318746403e0cecf7ee 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi
@@ -93,8 +93,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
index 10d0974334abf0e501ec97e2de487f40c1507f82..68c8856d4c2ed22370822eb295c0000fd80226f5 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
+++ b/dts/upstream/src/arm64/qcom/msm8916-wingtech-wt88047.dts
@@ -169,8 +169,8 @@
 
 &blsp_uart2 {
 	status = "okay";
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 };
 
diff --git a/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts b/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
index 9f647027d082864ccaa240f7118f20a8d19f6a4a..18381a66daef8642da27b3ea8c48964c1ccf121b 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-huawei-kiwi.dts
@@ -126,8 +126,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts b/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
index f59647b5b7dfdd7bf630f9d180bb56a10a3ea0a3..13422a19c26a15812657e92ab0b52d6f53f5c944 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-longcheer-l9100.dts
@@ -243,8 +243,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts b/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
index 3d9cbe7fdad8808968190d7a744bab29eeb0e827..07613080e79e9bfb21493a0b61c85bc172d5e3f6 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
+++ b/dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts
@@ -373,8 +373,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi b/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
index cbefe34327ba7b04ea57032c68dd69642e6d1685..a5187355f9fa09148b9f04970da6855a49cdd059 100644
--- a/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8939-wingtech-wt82918.dtsi
@@ -126,8 +126,8 @@
 };
 
 &blsp_uart2 {
-	pinctrl-0 = <&blsp_uart2_default>;
-	pinctrl-1 = <&blsp_uart2_sleep>;
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };

-- 
2.49.0

