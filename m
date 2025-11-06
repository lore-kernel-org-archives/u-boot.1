Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AADCCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 15:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F9E83BC7;
	Thu,  6 Nov 2025 16:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHpAQ6O2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B577483BBE; Thu,  6 Nov 2025 16:30:24 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA4883BA1
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 16:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-294fc62d7f4so10689545ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762443021; x=1763047821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQUuIlxFEPNWWkDT3Y2K5wwFxQce7lBM+nnMHJMjQr4=;
 b=kHpAQ6O2oFwYpIhNJh0n9RjXoFDNSEPuMAIyS+VuvPFc84mednkO/xjFlgNngQVcZO
 g5FruOjGjwf0VkSI7F3K0Q1tvgORCUqlWW1LHytm/eYjjL+duVuvpLUYAXyCXOFqTHl6
 PSLHyt+GmFY56cy01GttHLtsdK7wADXJUtOQEg5KxEJsHxsXgANtFPmT6VWZKhcSNCak
 dKaiEsSIbv2YSVv+cNLOchciLaDe5e7Mh3JSrN+M7SnbzGs8qdhCWLKdcuYpKYdi0Pck
 h25hTS6L0e9+Zo5qR2tnAup2b0krSAoQE+NvO2gmsoTw7XrDQOGLPIW/G+9yZInFH1U7
 i9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443021; x=1763047821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQUuIlxFEPNWWkDT3Y2K5wwFxQce7lBM+nnMHJMjQr4=;
 b=F+raSGMnAxi63+T8lU4wxB1cxf03lj6gjjrMHMv4menzGGCgWk6OClTw9EC4WNaMeH
 4nHXB56LdyOCGme8wBdpqPSkXh1RVv5i0s2ckHjHncb0XoOsNQfjipOKvIMRttKI5uqq
 hpBnaRAsgHD6bILj3wXUJCiO4IZ56KNLLsmfvlZmDZ/AIyi9tUe5Neq+jdI6EPtDtwSh
 IWakLnLdbViuvax76tDcv1vzP+KLzazGqyWxeOjtxEUdndZd5+OjvhO35tQX1l3/IIND
 ho01b/5NuhCCa44ypzCYPF21pCS3BFZWf4Jq1lve1dMZJo3Q2+V82C03W6h/UHNO+Tza
 Vipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/h7dmdT6sgmXaxSSntpsrnuKE3BV24dwNDwQrPOxDtm9f4HJFEYNdQXwzBVYDyNOrxukGZ3o=@lists.denx.de
X-Gm-Message-State: AOJu0YxC6IQ6QuLIX9N4tQhcOv1VfknSa/s1MFj0DaD2TJiXPGyAIFLf
 4+ESC9wJBG+/pupugpjfizoXg01u29O5reP2J9kQUuX/ifj2fzNRaIAC
X-Gm-Gg: ASbGnctOWVaZA+RZMBc2gLTboU+R6J4GT9oI3wGSx6hqucSTxMCUNvYW6QSijwgLFdA
 1EuVxyFqKct2N6dAjDMP2WqcAiXTx9JkDBRNs1ixP8UBNMul3ls//5Ezu/usIbD4PC1fxS+OtiB
 5El00NAzwvVcpghPR0hgluEQR23CSGvJUmWKohkmKyRHhta0WsmWE70vmqqaxPCHAYWkAXbJD1B
 YfO7oiKbazkUcmdrlpq4zRzB2OiKCCIIwthDS4XIT1EGhf+3N8RR7lDwl7DGRGFtyUWBguW7hWe
 RUzSWFm+QEQ6yLM7BZXluChsmChthD0YMfGd6GJxU7vEotZx23mfR8JP1z4zop2IPvmfKWGahmp
 duD7oIgkD0pyVlABT+zYSSEG36hlpptqnUBQjA9KPDTw4MtuhCxx8nei7gHI0fSDq042viDIDlp
 8STkvbkw==
X-Google-Smtp-Source: AGHT+IGstILxV2/pl63lCY+USulxy7Ht7nHfpxUwV9oyqn+TGTttEyt4IHM0ADoJNBdhf92MnqPTtg==
X-Received: by 2002:a17:902:e84e:b0:295:e9af:8e4f with SMTP id
 d9443c01a7336-2962ae97813mr116044615ad.52.1762443020985; 
 Thu, 06 Nov 2025 07:30:20 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650967e11sm33024855ad.8.2025.11.06.07.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:30:20 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
Date: Thu,  6 Nov 2025 23:30:09 +0800
Message-Id: <20251106153009.887102-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106153009.887102-1-bmeng.cn@gmail.com>
References: <20251106153009.887102-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The QEMU ARM SBSA virtual platform is 64-bit, so rename its defconfig
to include 'arm64' for clarity.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 board/emulation/qemu-arm/MAINTAINERS                           | 2 +-
 configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} | 0
 doc/develop/driver-model/virtio.rst                            | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)

diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index b2b1fce75cf..fea9e97f868 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
 F:	configs/qemu-arm*
-F:	configs/qemu-arm-sbsa_defconfig
+F:	configs/qemu-arm64-sbsa_defconfig
diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm64-sbsa_defconfig
similarity index 100%
rename from configs/qemu-arm-sbsa_defconfig
rename to configs/qemu-arm64-sbsa_defconfig
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 8750228693b..df07a0658b2 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -34,7 +34,7 @@ The following QEMU targets are supported.
 
   - qemu-arm_defconfig
   - qemu-arm64_defconfig
-  - qemu-arm-sbsa_defconfig
+  - qemu-arm64-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
   - qemu-x86_defconfig
-- 
2.34.1

