Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54ACCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4AF883ED;
	Thu,  4 Apr 2024 10:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fEUkwKHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C33883EB; Thu,  4 Apr 2024 10:14:12 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6546883C6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d85d0c61c7so323991fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218449; x=1712823249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2xJmeqV7J9yDPWcWLWnQojhOFW5Vl2ZjST8ffro7Ow=;
 b=fEUkwKHA81F+ID0RqOCmHMmVIkFCELp5Qa6ZPeqZH3cazI23W1CUQ1guQwfj8Pe88R
 lYmeVhrTCo5m+IAG9lUka4LN5inTqurlLObnJsVHOe3z9lCA6IaZOQnrETJGcD9mpcZq
 Te9GTJQbaUsG3lpPvw2nYJ3MonIBIpHsTVDEdYnhLU6oHb/w0oUHknoEIlSeURbTRN7r
 ECaLtJf2Z2/YmcrAmqeUz2tll2QSSl0HZzFk/D3on0er82uot0/PeCdhYVgFeimofr9v
 fkniaiQDbWVzYTRPU8CBQYi3H2hen5DJAt2ENf8aeJJVWDBSIv41vZ4ytVb9jrEp3rKP
 acUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218449; x=1712823249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2xJmeqV7J9yDPWcWLWnQojhOFW5Vl2ZjST8ffro7Ow=;
 b=VPJJUHipoES6cPuJq5dXa8zos4PKfsmzM3UQ9sTx4bJiQv734VFKLCIwJStabHo7/t
 mxAIJ1HCzHKGT/tMHt2yXdUzQ/ENYMsjbFs4g1VHoxO41UjbO765jZIhcXjHlRyZchXx
 cKVad73FO1ERiG2SAXjV2EymrtvGWEGXya+iCvkxOK1lO3k3Ns8aKnKooLZM0CNSMeA7
 ZG1NpPharTmqV/Xv5Bae33gyfPIuQXj8Mjt43NERv0/brRt8dRz7QJzDe/OoLjl5HFCi
 AYvFmzM/lDWJQsQp5t2IiWKJZW6dOiglAllOMpZ6+Hn9t9dzwdwHNUaj/47PkjCyXSyl
 bQVQ==
X-Gm-Message-State: AOJu0YzhFbkgiDNhKwRFRKB074LrcHIr/t7BBnMQXGx9d3hXYLUdz+jS
 5stDnS5aysfnoteGOcuPv7v6dYNdHnbwXaYQSz3GKJq0x86p3Mj7YS5hoFNp0GYZtA==
X-Google-Smtp-Source: AGHT+IGjLjOi2YlzQnYQiFtSetmsaUUVuF8VcY2EFIY0dJSs+VgabSZVLB84uS+u+QVDoRU4NCV0ZQ==
X-Received: by 2002:a2e:98cb:0:b0:2d8:270f:6a0a with SMTP id
 s11-20020a2e98cb000000b002d8270f6a0amr1274274ljj.4.1712218448744; 
 Thu, 04 Apr 2024 01:14:08 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05651c140100b002d69b9a6513sm2172564lje.48.2024.04.04.01.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:14:07 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/5] cmd: optee_rpmb: build cmd for sandbox
Date: Thu,  4 Apr 2024 10:13:50 +0200
Message-Id: <20240404081352.3224643-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

Support CMD_OPTEE_RPMB for SANDBOX configurations.
Test:

$ ./u-boot -d arch/sandbox/dts/test.dtb
...
=> optee_rpmb write_pvalue test_variable test_value
Wrote 11 bytes
=> optee_rpmb read_pvalue test_variable 11
Read 11 bytes, value = test_value

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v2)

Changes in v2:
- Applied R-b and T-b tags

 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 61e280fb1a4..227d66a7eea 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1394,7 +1394,9 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on SUPPORT_EMMC_RPMB && OPTEE
+	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	default y if SANDBOX_TEE
+	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
 	  in the Replay Protection Memory Block partition in eMMC by
-- 
2.34.1

