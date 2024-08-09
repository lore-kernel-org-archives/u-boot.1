Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A87C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6403C88BB4;
	Fri,  9 Aug 2024 02:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DK4iJ8sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4990388B9F; Fri,  9 Aug 2024 02:48:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA62188B86
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so2076153e87.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164532; x=1723769332; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BtQqdiFk/5BGUCz4O21vl/84vcKElfs3QSU/TjahAhA=;
 b=DK4iJ8sGuWu86oTFT+XXVXNCfRsgfrSW2XiZ21HCUOvWJfcj0lTq7bUqNP73tAWlcM
 3rLruAi6Ld2KhuRGr3FxBfMmXS5PI/vxB/26zbFfuu4wIbBtWG3k3e+p1V3N0L9+G8PF
 89hcll3kcWu5DO9oIr6pWBeY4vAQvllhI1YmlWPmGm6S2XoOtEe81pILhrxwk3H63PiX
 x5u1PJBr8wn0QrsNh1myZU1+L5APKCQQ0murKnkZWLWNLFyc6uYA3YLH+aDprRTOGLCh
 5ChjwwrlSHQNKYSdvUXbJQTdUIDpVyLxDZKkE9b74nte1dO//7Wr8Eu5mX5ZhpYIblaB
 BF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164532; x=1723769332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtQqdiFk/5BGUCz4O21vl/84vcKElfs3QSU/TjahAhA=;
 b=mxZAhGosrL8hpIzGwyIHjWhkHSasgsBJCjK8rFRRymaUP1l8RL3RNQ1TLnHTpsvh4R
 YZdl6KXgwEb5nQGSUSW8Ur0AcrDBzwhnuRzVXt0oAkWyvpEyxthiVLYa5XTh1qUT+huP
 GEAigZtMnw2LRqzddUV4Jqpd/syXtP6MZhAeDGA0ZWMHvNXnRQvsEzjekue10eMH0MQf
 Tuq1ux0KjAeetqwPASCoL+a5U8p0jcW24cqUaSnjTvQU+hW/+gzFL3NUwircpi2ojMMt
 m599UNlZ6khAZ8sSOpybiYfal5EUFIn+X2fMDBhfGRdq2eQQsX61zkwOiBt7R4Zecr4x
 IE0w==
X-Gm-Message-State: AOJu0YyvKsdloqxIeNFVw3ZSffGu6qCzKASdArn3nnzeVCGtBJYp6zt3
 zayidjX6uwaTQ3JxjCe32yyc0HzLsFAzHYQg5LbXwlDDiIou/+P1Z+X2ZRHoRKk=
X-Google-Smtp-Source: AGHT+IEOlpOSzemsOLg0X0Q1N7JGK7CtLOiPky3QZ23clXAZP40SQ/eZrZzhrYpRS7l5eei5ZDV1OQ==
X-Received: by 2002:a05:6512:2353:b0:52c:e030:144e with SMTP id
 2adb3069b0e04-530e588783cmr2268436e87.47.1723164531951; 
 Thu, 08 Aug 2024 17:48:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:45 +0200
Subject: [PATCH 2/7] dts: qcs6490-rb3gen2-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-2-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WycUvGIX1Vb2Dt9TSRhlFTIc8lgmewYYBQWg2kxs6NI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdv5mZF1qW50sMpKm69eeflmucOdePyCEc/C
 i/v6J/hbOOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVnbwAKCRAFgzErGV9k
 tj1pEACLUG59UQ55775yXhgTtJr5jYWFd7pYecXFyzGdVmlVAB+uitwbIR0PACI7Ye/f+pzcIFm
 l3ghvE198uzg1oHWFB94RnTa7xnW9rgEmNsSG2UDq7eE48WQZUlgVn2tf24dOk3Fe7NRFKjzVsH
 /8Q64aA9UJY8ZzSsdTLTRuwRGNW5SISJQ111HIdUKEvMaiRc5nO1zq8qz642tRlTx6mOl9knavM
 oeD6sTRfOTlFX6gU6DFmMZMs/wOjflD4D0dw4lZikri6F/1fj2HnbrQI0QdXipLtUXKSgRMtt/s
 nrgUsyHXpuM4cJGRYHwoyxqJUMYd3p5iQr1AI9i8vzBXilyZPx4Z5nFxxLVFbzmaWWtQkjTa/Wc
 tcdYgtA1xKlR6LiD3OsRUVWIEZxxMq8g9G7fC6Ibley/V6IK9cjohY7l6rmrLM5yzVXlhU/cfc6
 kKH56mRbLcyxWB814+i0MgM+I6BqM1sVyXfwTvLdqy82J7rbFSH8lDvfUTXD4K3qCwqo3xOi/hu
 BTdAy+DV2zNtnSgIa9ZW90SEuIAtPQc4GwdiccKggvEn85rLhUCYjBOq1p+1SLgF8FHp8lHaPNm
 nBXdJYmZRdUyN9EMUwl6Itnf1AIPoIlBmKeEuCmt85TTQArD/vX8ZmUzVZ2z1TEo2lyU9dEqg7T
 CSO9WsntFkebP2w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

For running U-Boot as primary bootloader we must define the memory
layout statically.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
new file mode 100644
index 000000000000..c3ec4a317f7c
--- /dev/null
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024 Linaro Ltd.
+ */
+/ {
+	/* When running as the primary bootloader there is no prior
+	 * stage to populate the memory layout for us. We *should*
+	 * have two nodes here, but ABL does NOT like that.
+	 * sooo we're stuck with this.
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x3A800000>,
+		      <0 0xC0000000 0 0x01800000>,
+		      <0 0xC3400000 0 0x3CC00000>,
+		      <1 0x00000000 1 0x00000000>;
+	};
+};
+
+// RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
+// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
+// RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
+// RAM Entry 3 : Base 0x0100000000  Size 0x0100000000

-- 
2.46.0

