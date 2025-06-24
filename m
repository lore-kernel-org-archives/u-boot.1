Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79968C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADE082C4C;
	Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ox+IBkye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B697082E26; Tue, 24 Jun 2025 10:45:36 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065A682D21
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so101119f8f.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754733; x=1751359533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ruyje9Z50hiLtnyI/h7AcxDzbxO3BCT/rueeXnvTMAA=;
 b=Ox+IBkyeBCdZdGVxMb2ASr52Y33g+nS2qzMBMYIfhBudcZ6hEux7XRtA7JKB2+QRfg
 qskiE0UvpHb2mHJGI7M44v/bL5PNokgXfFDOw/BaVSb82XAJVVh9xHvUiegkBU62BQCk
 LKAPpVF9kz60JJFH9NGx8981eo4cK3QMooC0HAMe7Mp60G4jC4NOrju1MAXA1RFNuX6V
 4G9PDUFR7+NtiVZSNDH32iYNnl0Dg2HQtQUaWzMvaMm1shotqGCG/+WJ/8WOeyW3p3ma
 5U82uiW+Fk+8WYDOHVK/JwCewNwa50y0Aoi29QPv2FdGE1ToFhU4tAuEDJs88i+cEAX1
 lvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754733; x=1751359533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruyje9Z50hiLtnyI/h7AcxDzbxO3BCT/rueeXnvTMAA=;
 b=keyd7Na0Dh6or22uV2BgzphoSLnIVM105HsDf9VR22O/HNcmaNOeghJtop+0dDmgxG
 C1kkp1k/wA4cJqoWZhiFSa+hGbD/zwZwyqm2opNk5bEVMgdV3tjrEEofLxmCnCJKTbqQ
 8StypmqazlX5hl0kI0GL2z/48+vVzvqh5K2nOCaB82e1qd2Xr0ifLpnI2gQH6wvJBcJq
 lfHgWXWCbZXKKGUGS1jmHOUqZ8yRYTWj1JZHvBuQsNXxC2onJBaYoCe1kiWifAbBOcph
 SQ8EDVqwtRqFxdDrcRXNZsXNeOJhXiK9A1q0xQS7HW9lm8sNOCLYiUPpOVLTahppSp9S
 6YjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX61gjzxw0/Z6nlpOWC67IRazhj/27Gv9W16IzpUZi+0OlBT0yzZU3pMqzWGKRO51QCZjEZz6U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx93zm4orOp0Hp6jUo3k+IX3zkxsZ4VeG6A5MpU3/IisNeZGUQd
 SY4IuyJzeUuKqqCe2/o7+gA/NTXUC2MQEuJrHh70hbCzbDZ2swf0/EC5HFp8ivu1S44=
X-Gm-Gg: ASbGncuUFTMXMuT2fjMhGke1lvR0YQdk3rOdzIhStbU9wPlhm1R4mZFuegZy+FgrilI
 fxEvDqZZuseWtmwZCy50LdGsAWSYtxVxLTEymZZgU4l/N0KURqFTL1w3nxhtm8FTOV7LzH4PKEQ
 acAVbevBUvsfpevoMSnwAPXMb34nzI6ZDX/GYPD8eswu3HTPsiSsZ1sruuU+v929Ub9PINkzQSM
 hm/4fRTj1/ab/957hZBtNQrZkqFaOY6L1D4wMeYrqTwtdSpXDUYzh3SWkqn1XiaZujKV4IcyCmC
 /Z3yxxSN0WjYbPECU/HYtmvRhzCBxeIaU32LYSnZF1p9eSK1dd1y1HsydAzFeog5Zyes3zdjdv5
 a3l04GMpDdQ==
X-Google-Smtp-Source: AGHT+IHEqYBylMCrdM3PxgLEWQn8PaWOp4ux03PhCjMnBvKLX6TQIk9ovQbQ0yV22Fd+i4E01/iFZA==
X-Received: by 2002:a05:6000:2f87:b0:3a3:7bad:29cb with SMTP id
 ffacd0b85a97d-3a6d12eb068mr12883401f8f.52.1750754733375; 
 Tue, 24 Jun 2025 01:45:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:32 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:15 +0200
Subject: [PATCH 02/10] arm64: dts: qcom: msm8916/39: Introduce new UART
 console pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-2-d96c97ae41d1@linaro.org>
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

At the moment, msm8916/39.dtsi have two inconsistent UART pinctrl templates
that are used by all the boards:

 - &blsp_uart1_default configures all 4 pins (TX, RX, CTS, RTS), some
   boards then limit this to just RX and TX
 - &blsp_uart2_default only configures 2 pins (TX, RX), even though UART2
   also supports CTS/RTS

It's difficult to define a generic pinctrl template for all UART use cases,
since they are quite different in practice. The main use case for most of
the 40+ MSM8916/39-based boards upstream is the UART debug console. The
current generic template is lacking some properties to work properly:

 - bias-pull-up for RX: Generally, UART is push-pull and does not need pull
   up/down. Both sides drive TX, so RX should never be floating. This is
   why the current pinctrl in msm8916/39.dtsi uses bias-disable. However,
   this assumes that UART is always connected. For the debug console this
   will be rarely the case on mobile devices, only during debugging
   sessions. The rest of the time, the RX pin is floating.

   This has never caused massive problems, but it's obvious now that this
   needs fixing:

    (1) In U-Boot, we have been fighting with problems with autoboot for
        years. Most of the time, there is a single \0 byte ("break event")
        read during boot, which interrupts the autoboot process. I tried to
        work around that by inserting some random delay [1], but it turned
        out this is also not working reliably on all boards.

        What happens is: Since RX is floating, it switches randomly between
        high or low. A long low state is interpreted as "break event" (\0).

    (2) In postmarketOS, we used to have the "magic SysRq key" enabled by
        default for the serial console. We had to disable this at some
        point, because there was a small number of users who were reporting
        sysrq spam in the kernel log, possibly even crashes/panics
        triggered by sysrq.

        What likely happened is: SysRq is triggered by sending a "break
        event", like in (1). With enough luck, you could even trigger any
        of the SysRq actions if the RX pin switches between high and low
        (e.g. because of noise introduced by the LTE radio close by).

   We can fix this using bias-pull-up, but this may be unneeded,
   unexpected, or even unwanted for other UART use cases.

 - bootph-all: U-Boot needs to know which pinctrl to apply during early
   boot stages, so we should specify "bootph-all" for the console UART
   pinctrl. Without bootph-all, the bias-pull-up won't be applied early
   enough in U-Boot to avoid the problem with autoboot in point (1) above.
   It doesn't make sense to specify this for the other UART instances.
   bootph-all is a generic property documented in dt-schema bootph.yaml.

Define these two additional properties only for the debug UART console, by
defining a new pinctrl template specifically for that. In the following
commits, boards will be converted to use these where appropriate.

[1]: https://source.denx.de/u-boot/u-boot/-/commit/ad7e967738a9c639e07cf50b83ffccdf9a8537b0

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250422-msm8916-console-pinctrl-v2-2-f345b7a53c91@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 5c0c8b7a315ff63e01e9a608f78dea16daa57aed ]

(cherry picked from commit 82a1d0626f3012fc8027480cfceb9cebadbda434)
---
 dts/upstream/src/arm64/qcom/msm8916.dtsi | 45 +++++++++++++++++++++++++++++++-
 dts/upstream/src/arm64/qcom/msm8939.dtsi | 45 +++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/qcom/msm8916.dtsi b/dts/upstream/src/arm64/qcom/msm8916.dtsi
index 17161673bc6c2a603caf4bee529b04e6d5867767..343345799ffadaf033bef0fe30dede4d2963248a 100644
--- a/dts/upstream/src/arm64/qcom/msm8916.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916.dtsi
@@ -1246,6 +1246,31 @@
 				bias-pull-down;
 			};
 
+			blsp_uart1_console_default: blsp-uart1-console-default-state {
+				tx-pins {
+					pins = "gpio0";
+					function = "blsp_uart1";
+					drive-strength = <16>;
+					bias-disable;
+					bootph-all;
+				};
+
+				rx-pins {
+					pins = "gpio1";
+					function = "blsp_uart1";
+					drive-strength = <16>;
+					bias-pull-up;
+					bootph-all;
+				};
+			};
+
+			blsp_uart1_console_sleep: blsp-uart1-console-sleep-state {
+				pins = "gpio0", "gpio1";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			blsp_uart2_default: blsp-uart2-default-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
@@ -1253,7 +1278,25 @@
 				bias-disable;
 			};
 
-			blsp_uart2_sleep: blsp-uart2-sleep-state {
+			blsp_uart2_console_default: blsp-uart2-console-default-state {
+				tx-pins {
+					pins = "gpio4";
+					function = "blsp_uart2";
+					drive-strength = <16>;
+					bias-disable;
+					bootph-all;
+				};
+
+				rx-pins {
+					pins = "gpio5";
+					function = "blsp_uart2";
+					drive-strength = <16>;
+					bias-pull-up;
+					bootph-all;
+				};
+			};
+
+			blsp_uart2_sleep: blsp_uart2_console_sleep: blsp-uart2-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "gpio";
 				drive-strength = <2>;
diff --git a/dts/upstream/src/arm64/qcom/msm8939.dtsi b/dts/upstream/src/arm64/qcom/msm8939.dtsi
index d021d1dc10b6fe904786eae5e20103be9dc7a215..9def688c5f0a4689918286ff9dbabbc169fe280c 100644
--- a/dts/upstream/src/arm64/qcom/msm8939.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8939.dtsi
@@ -910,6 +910,31 @@
 				bias-pull-down;
 			};
 
+			blsp_uart1_console_default: blsp-uart1-console-default-state {
+				tx-pins {
+					pins = "gpio0";
+					function = "blsp_uart1";
+					drive-strength = <16>;
+					bias-disable;
+					bootph-all;
+				};
+
+				rx-pins {
+					pins = "gpio1";
+					function = "blsp_uart1";
+					drive-strength = <16>;
+					bias-pull-up;
+					bootph-all;
+				};
+			};
+
+			blsp_uart1_console_sleep: blsp-uart1-console-sleep-state {
+				pins = "gpio0", "gpio1";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			blsp_uart2_default: blsp-uart2-default-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
@@ -917,7 +942,25 @@
 				bias-disable;
 			};
 
-			blsp_uart2_sleep: blsp-uart2-sleep-state {
+			blsp_uart2_console_default: blsp-uart2-console-default-state {
+				tx-pins {
+					pins = "gpio4";
+					function = "blsp_uart2";
+					drive-strength = <16>;
+					bias-disable;
+					bootph-all;
+				};
+
+				rx-pins {
+					pins = "gpio5";
+					function = "blsp_uart2";
+					drive-strength = <16>;
+					bias-pull-up;
+					bootph-all;
+				};
+			};
+
+			blsp_uart2_sleep: blsp_uart2_console_sleep: blsp-uart2-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "gpio";
 				drive-strength = <2>;

-- 
2.49.0

