Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C6CC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2404B88DB7;
	Wed, 21 Aug 2024 15:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D8cipZN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF84288B3C; Wed, 21 Aug 2024 15:41:58 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC82A88AC0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f136e23229so67636651fa.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247716; x=1724852516; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BtQqdiFk/5BGUCz4O21vl/84vcKElfs3QSU/TjahAhA=;
 b=D8cipZN8vnM60gNnxvkm4MeJi0YUs2ejIG0MSF/WWYvpmyESE3mh38i9CQho0bxU6i
 iX63Dsb/6xtE1YF26oNdy6430/ePndpn9VXSnZ4+c+0j1Er/qSEXlX7/BzwYSxhKFXP2
 /F6RsyF3R5s2HPndcU3OSppiLYNDSZZFa5XBwBVgNsjEoAOmVBZspDGJXberoFWSw1Xd
 jvCW7H8KY4DgeuHAJAF1udHYqYfpDTGmijGk1cl6yddFZ4BX5AHEetjJMm6/Sfs0rYEE
 D0REEYmHiwa1dm8mN6J+XMp2tgzg/8RPlQ5p4k9lcZlrCuZ7TnFF+HgnR7TLnMaOY5WI
 DeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247716; x=1724852516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtQqdiFk/5BGUCz4O21vl/84vcKElfs3QSU/TjahAhA=;
 b=P16tCzEGlwXh2HUe2zkd2EwD+lVsUJ2nv3xZT1gSdJfgv9uFCy5uHQOHx+GfyeFiFB
 ZTZeGSznoCm+BqR4Rw1gx+Pw4M5rk38MOzZj6eb1PVfM7DKBk1C0g3ddxLBWvXwGky/P
 /PMojneROHfJG+HpIjemGUIP4Cnbl+J0M1VqM1cJazIQocK+IpbqphhjI7IDKfPwZz0O
 Cxn70edXPpLuZvBwbSJEk5zEyh+2b0oiyPP8VwzVfimOrP0nSJ/TkZiKVgEAVBmiRq1c
 hpW2xFrDixDe+Ioa2hCXcbsIoDf8EyCdmxWVIiA8h4xsXfXpSbgDCAgBz0wi9Uw3Jy/h
 LRZg==
X-Gm-Message-State: AOJu0Yz5oP45hJMUwyK8DU9sBL6vYfuGjHAeVLt3bxXXNCuBLvCzIx7F
 gF97feq0wgpXLIEQ7uqwcBXQ46wbHQs8IEvoNGTarDCXSFeggfCqEC7oDzM4U48=
X-Google-Smtp-Source: AGHT+IFRfsXmk97RBDrPRNGuRiWGpZ4udOpM/gdavhIAP7Vw5jIX1oJ1BZ6+tqyctFDutWKn/+6X5g==
X-Received: by 2002:ac2:4e09:0:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-5334855d512mr1561479e87.24.1724247715821; 
 Wed, 21 Aug 2024 06:41:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:47 +0200
Subject: [PATCH v2 2/7] dts: qcs6490-rb3gen2-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-2-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6djNLXRIVPQZZW1FVYvOn/tPtr3vGLbnTcN
 EIiqQUfY2uJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunQAKCRAFgzErGV9k
 tnN7D/0d90bQBLWvZQ8d0lHinZ/3zwe3FEdaLK31OGRD7VJd7Q8ckuOxOF/eO8TLmksQovgvrTY
 68llyxkNZe/nnmY9UX+DJ+i5pzqINuLlGRqANukMePwwJxJZilb6dRXB9sR+hSBHC+YTyfY67xk
 78ILyZhMmZqmi/ya6lBqxLieP+CnHq1V9n07s3jljhE1oSp4NucQzFXpv48MGEpOt/sIyjtzQ5w
 aw7r1Wsay9w+xmNly+kBT+05q5dp/CTnqMp1koKGG/fWWkSZUgo5yODYeRAiieb7ZQ5JaVmxJkf
 G3K0BPkFJ+kaPyU6Mbe0d573tY+oZsWDWEBFP/diduz8lw27tIDOmpTIyT8lMsu1vL7dcj38NsS
 50a7smXimMWcKwJsEQV32Tw0QYv4kfJyqjxXVj6kJ+DWL1bm15LZ6fZpXy3tbTHzJvWRr2Lx/AZ
 mWXbylc+uUx4tQkb+7+OhSN376NPfWUNlGHMdHSfQHgzcFuGbMmf9v58sPXa7ZKb3UFkKk2MAzA
 8kiDEMgp/6k55lHxdc4ndxK/vXTKxiU59H2k+okeAQ2iMnA39r/M7yOe6a8vyXDyeuCmJHncNAX
 /Uy4yr757EQpUKygo3DjdfRcZQ/h5hQ2TFiWm3BlU87k8MlQl5JEGwxqpkM+9JXFjRwiGcR2ZSO
 fOkmL+X6FXNHw3A==
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

