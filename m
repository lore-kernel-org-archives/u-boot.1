Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C51C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47EC8205A;
	Mon,  2 Jun 2025 18:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="msHvIwwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B551B828F8; Mon,  2 Jun 2025 18:11:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F86829E4
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so4211146f8f.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880667; x=1749485467; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CIvraxDESJYPfl/cBWPKkUEIkEHq063mcgz79rXVZrM=;
 b=msHvIwwZwr9QLuRB0xqYD+Yu2sjlEMBSVoBEFebs9fXhDEYLbt8Z7vhG3n2dX+NMbV
 10brfvYo7hCOsmENLltwsMfsEeMxm9rzMsSXUlY1rhDbg+zgG95Bb9fr8ugd5DP1md8l
 DneRsqFqxKOjOlUX5uLZS8LLAehatVM+inK3VLVRY8mmLmK5qIrMK88ycV1xyO4iiqgK
 nDWHktfgJV/2AHdHz0EDYS5pLIRBTrAdh3uLceOHDwoIFMZfxNmwBCBGFVdNQtFdir9Z
 u8NpEjT36VW0VFe3BBp/Gxswr8Plmq3SVDqhuBtU6d6kwxjdQ/d2uKTvZ8wN1kvM6Fso
 OCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880667; x=1749485467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIvraxDESJYPfl/cBWPKkUEIkEHq063mcgz79rXVZrM=;
 b=LaCs7ECrEQw3+LbSvhiWDJkM9My667U8UhGfjas3vX+jWUYmze3uYf0CiA/BoDT/As
 AMazk71hm96c06NMWk+0uBHSMQQLm1NvuCyPbuCZcJFNMduW8HRsmmx2PvzP0oI60uyE
 OaFf1hnGhno11udPMOtBFuk/jbsecpJOzrbwfwkXjRLtVjEICbqx4UCxOamB07SFvwUD
 uU2DGxXCF1on8rnLC7u3OseeNt2N+S6hS7pocc0dXEhEyM+9pIMC91zwagYs4T1wePIw
 V5E+cZsKfPsPX6Nmje2D6KRqt8rq1uN6/yXCSAzu+JjpEtJww7OXD8nLtzrXlsDTn7xW
 2q9w==
X-Gm-Message-State: AOJu0Yzk6sillxX68mQBXLpw4HpUktKjxuMSE1OUNxO1DM0Yu9mnicGe
 G+4fONYGjTCjaR/18ynRG/pfUwQyi3bLErJDxUweGhS21kc6d/1NQEBd8E5D5t1SdE8=
X-Gm-Gg: ASbGncvRicGQnMbXiPj7nam3uAJgiGEPnuELNlwd1GGGxvwssdESrQb9WgFjG2t79Zx
 TlEv/e0sX7Wu/7n2+Ts2feeqgVOC3dAM7carRRccQ3XFyiP98RCo+YRkrM88hmEH6dmavQgxQg1
 7pXhmn3E1O5EraGz1QC4cVtK/ltoVQwW9v4uzG/btb9ld03oq18AkSxJLhkjXHpCTp99CItBjCV
 npqap030ViJ5GEmJSM46au0inxYakKlUJU2CYN0sLURqEfutSYgzq/SJrsU3iRu4/cXtZnjynk2
 IPA7Gd9k+wfYY/X3dsCClF5RO6IuPn6w7zfKG8uGaYoQvpYpYtIMFqFY7UbO6OH6qjLXIwVVu4c
 SjQ==
X-Google-Smtp-Source: AGHT+IFw+VAQ7mUMz5oWaSmdpfEnVv8RnzTBcPk1AtT1HfdmYGtxPu3vgQsP1Bo3EjmMdPg72VBzdA==
X-Received: by 2002:a05:6000:2512:b0:3a4:e841:ee6f with SMTP id
 ffacd0b85a97d-3a4fe17b248mr7182834f8f.24.1748880667043; 
 Mon, 02 Jun 2025 09:11:07 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:06 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:56 +0200
Subject: [PATCH v2 5/7] configs: qualcomm: use fragments for debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-5-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SWqKxUIKWnCnowlynSX21OjBq2T3z//usaZR/9DmWy0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0SlUveTFOYubktV97eXlUq97l+kjPfLrE/L
 yoY7URu95mJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEgAKCRAFgzErGV9k
 tmaED/95BohXJEqreIw/JA3f6Mli9erHRo1tvnkpceRAGnp6UNv5EDbN0mewa5NGuruy3T5ztTk
 5Cby4fUeR1JxVuCCnS8zryWbRw9hzP5wkeSftWPT9+fk3FOrVYXFIID07YjwbFvngE1uiRT5vA+
 TXmaQzcA0lO+zduJQSbhc6IFMeUuh3psKePcntV90N/dTaHaevIfYsEhO1YFti3w8OfSBI3L8RJ
 Pie+KuS8Fkjd7MIoQxvhJy3u32pO4fQHP0NIfWQI9xA6jGorKkNvVvtkfQ1ojlCcZxiWAnx2yvE
 EXhKaQuk7qDdW+tqoi/qVuyZA/7Ai2JYG9FmUYFVK825KLELqKu20+Vm4uzaPfG6asVPCFnSZ5A
 hxia9VbydVKHxBqnGbB310emAj1l2zdPLvfMKveRUcF4skiqFooDb21zvkySVutgF2TgaomUk6P
 0PnBPkWD7gXHG2nk34RarXXFXbjBWdNOD7P+dsP6byyxQWTkEDTUey/+vBuWxao8N4m4C7hrZGy
 5KAeimcUC0y/TqYHFN34liunYrG6E9KOu9xdC0ovyFfILAsgWhdJFhZaKZ+BZUHp+PBaUeIsfWD
 AJNILmxFgIi4vxrbv0qMNXZamtx0bzNu5Zg1guTEKFye/63BYZoN5jKOlGNBeqw14LnGg6d4Kj4
 zfLX8cCUEIQWmyQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

The QCM6490 and QCS9100 targets always enable debug UART, but this is
not really optimal for typical users.

Move these debug UART options to config fragments so that they aren't
enabled by default.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 board/qualcomm/debug-qcm6490.config | 5 +++++
 board/qualcomm/debug-qcs9100.config | 5 +++++
 configs/qcm6490_defconfig           | 6 ------
 configs/qcs9100_defconfig           | 6 ------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/board/qualcomm/debug-qcm6490.config b/board/qualcomm/debug-qcm6490.config
new file mode 100644
index 0000000000000000000000000000000000000000..9ea54758794ef9d2f698cb4026da44be2360147a
--- /dev/null
+++ b/board/qualcomm/debug-qcm6490.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/board/qualcomm/debug-qcs9100.config b/board/qualcomm/debug-qcs9100.config
new file mode 100644
index 0000000000000000000000000000000000000000..8ca042b440d100e9583ff9504f1b0e67a491dfcf
--- /dev/null
+++ b/board/qualcomm/debug-qcs9100.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xA8C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index ba26924da161b1c4b5378955185f314b05cb1006..22afa7be1a944e5e0d712ef8aed21ea2b7fa2fa1 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,14 +7,8 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0x994000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d2539803143c8b770b6b28e8dc52b1d5846..4ceeba63ec12cebbc2124eb256a255450500152f 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,14 +4,8 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0xA8C000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 

-- 
2.49.0

