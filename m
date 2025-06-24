Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3597C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E082982E5A;
	Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dU+CF+XK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A75782DA1; Tue, 24 Jun 2025 10:45:38 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD6382E17
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so32895655e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754735; x=1751359535; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IjCS40oS0ezICPajPLdeP1YkT+Nk9xrcq0exOOjFkrE=;
 b=dU+CF+XKSLB+keJGsgFD99sqnwtAomvehrjsmNGJ4ckykaG6fuMnqM04LhCMAJefvE
 FeiJudtUdyakw5VoH8fgpBW2NanyKyPrJe6ixQ6l9ZB8vuTSk+PSwtBfriyHlcmzSllR
 38r6jGqwszYTqAwxw129BGko59h+jhsOd487TS5QacONkr71nr+p5WcKmvcPkxmUDQqD
 QhPoiRMihrb2NOzwfaqLkZNHjYTxmutafl5D3bWnj65+owrTGopvX0LXM2Uq9w0WAVSv
 9C9CfpvDyLmLzVSJEosBTYmUVHk5RnDe1UjXz2rdE2a4fqNXrkmoYoSErmUWNlE7xROj
 RbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754735; x=1751359535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjCS40oS0ezICPajPLdeP1YkT+Nk9xrcq0exOOjFkrE=;
 b=GX5IVvcqR1lzait8W7GfMiLoQdu6FsEg6kIVQqIguQ6I3jjm4ghzfl94hCjP0SLffj
 SrrV7mw7uZeNBmjkmDLE+51ORQRu6jfKo3AHQKjS3Rfv1SaK74UfRS6X8MSO2uDnLm55
 bHw80RHbg9RU1moGwOJNiEeDhumcwqfcY4pwIw8/7U1mxMqdf9CMN7w4QApu9Ypzpeh2
 qQbHgLI3/35qsV3l55UEg3dOr/5qn06sK8q4t9FnBD0Tk81zIYxOFBr5LOUU8sFwLsuR
 7xpjFmZ5eAx0epUQAfLYVFu5TUgG8Bn2Pk7MpZLbWuMpqa9VSCRfK7ELUOqm5BuRJ3WV
 Ijng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFfZR0nkzsJgfjMzX7V5iHO9BekR7ZZvEysKjv2OE5eT2QzsxySjLcVKNyaDmGwmJqBiFswyk=@lists.denx.de
X-Gm-Message-State: AOJu0YzLTUKGmUjB7MgHUoVfCnxntoiwtzqmgotv+XAxqriHwFEDdTgy
 HGwBQDGiC/4aO03GKVKMSXfXcECM3enP+tgfJqbLwUeJaHvCfQ3b40zA0dp+BV9at8w=
X-Gm-Gg: ASbGncsO4K7lN07d2UVhg9I9sP9yfdrpENy6EztIvHX66fGulbFt7/NURf+tv6K3IRx
 GhdwzSyIOpp3O4U4FuiYgxzpvHKxyq6PNyPkZS/D9XUfHMYVNmGFab75cRd5jy14CbBqZgV2Jao
 keas2jCCpv+XiqTN7s/o8glwBqkB+6BrZknnk2efD/igfjBEe0tFQ/UdFVMwleCoS+GpLpbQjRU
 RUv7rLA7X2BStYjyqFDbsXA67CA+r2VwwJp76NXD0WYOoQlASJocxnq30JOCAhlWCbmcnQm++aF
 M65wHa69HaDuGGA6s3HISd2pAhlhiSBHQsDrY2aGQNqnGRF3h5C2a5GuXzeAR+rLug0vHAsllic
 =
X-Google-Smtp-Source: AGHT+IEFcguPmWROT+fJTnGLkP5AWBZe2Ai0P1Z/Mbdz8FCAR2R9lX3AKDuHhtNrVyM/TTKxDoC1ZA==
X-Received: by 2002:a05:6000:2481:b0:3a4:f70d:8673 with SMTP id
 ffacd0b85a97d-3a6d12e2c2amr13311021f8f.25.1750754734977; 
 Tue, 24 Jun 2025 01:45:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:34 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:17 +0200
Subject: [PATCH 04/10] arm64: dts: qcom: msm8916-motorola: Use UART1
 console pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-4-d96c97ae41d1@linaro.org>
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

The Motorola MSM8916-based smartphones all use UART1 with 2 pins (TX, RX)
as debug UART console, so make use of the new &blsp_uart1_console_default
template. This applies the needed bias-pull-up to avoid garbage input,
bootph-all for U-Boot and avoids having to override the UART pins.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250422-msm8916-console-pinctrl-v2-4-f345b7a53c91@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: fe848d64cc6516cd56f38d23cfb544a68231a6e8 ]

(cherry picked from commit f7626223fbef2ae0435cbb72e15e21277f23a180)
---
 dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi b/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
index 48134e5ff524fd5708db7b9c3a567ec3f751868c..4e202e7ed7db1921f347ca8b4a01ccec593a8d8e 100644
--- a/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
+++ b/dts/upstream/src/arm64/qcom/msm8916-motorola-common.dtsi
@@ -69,8 +69,8 @@
 };
 
 &blsp_uart1 {
-	pinctrl-0 = <&blsp_uart1_default>;
-	pinctrl-1 = <&blsp_uart1_sleep>;
+	pinctrl-0 = <&blsp_uart1_console_default>;
+	pinctrl-1 = <&blsp_uart1_console_sleep>;
 	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
@@ -132,14 +132,6 @@
 	status = "okay";
 };
 
-/* CTS/RTX are not used */
-&blsp_uart1_default {
-	pins = "gpio0", "gpio1";
-};
-&blsp_uart1_sleep {
-	pins = "gpio0", "gpio1";
-};
-
 &tlmm {
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";

-- 
2.49.0

