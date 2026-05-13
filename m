Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706F7CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DB084674;
	Wed, 13 May 2026 02:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="kDaXcXr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD9F838BB; Wed, 13 May 2026 02:26:42 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F3583CD3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso8354183eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631999; x=1779236799;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPjsiJLT4Sww08GBQGnZv/CuD/el0wl0xVFOp+/qBLI=;
 b=kDaXcXr3y3/QdKQNsMTDx63RmSOgg6w/cHpZuTleG2P8IN5Vn+7C0akwIg9v630Plz
 AcA2armcirS0RNgSnTRohUUridkhmhrg5I0GGpvob590WqQGI6M1JAPmnEeeNTq2YCWI
 IOz2hlvUfmdJSBtLZaHYHCUZ7nN4KtG/ouNVhsrqMaob0FcBcSXwzQj+mJEb13EDkcjv
 rJkWhB11Tfb0wU2C8OlteupW3lS70QIbk92OoxkIlOpVqze/LJ0R6i4WAjK1FFg2z2ba
 VgHRRPaCXKXlOTYbsUJ47EfJ5z2z939kgzym8HUZf7pzciqsDO5Tmtali1LP3gsHVQZl
 ebtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631999; x=1779236799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPjsiJLT4Sww08GBQGnZv/CuD/el0wl0xVFOp+/qBLI=;
 b=RqqlsnZzS4vm3E1jKjI9sd2M0voZngx1LsX/ilq0cKRP2JPVVJX6haK1+pUNxWJcAQ
 5D8oPLLC87YZXo4VgwFIVfX4h/Ox95ro31aaYD9b5YRz9j98N52ewI4xsebAv2UxReNA
 SD4uv4ykL7rXkl5umNGR9LUFUjjFudOoYrpjMvUF6lzqbyev1pPJE1OWYH0lZfLsgPzk
 MgrrA+8GmUUY4X9jTMUnfKsP5vEQmNtG+LEFJIFomOGQaOoFZzecMnTxaVa+UzkofQ7f
 82tEoMGCvCMujWBEu4iuTNovu38+aJQrvTyCwB2dA+N4/klfVyV+g1vQKvjYRiLwh+vD
 av/Q==
X-Gm-Message-State: AOJu0YzSNMz6DuMxy0bDM3b3E0rk6sF4iqMbhkYQzdXqlAhEAvDzHYCw
 Cu2lTnN0rwU2Qmj4CtFrb4yE9QBzjauR74o/x/RtAj1oIy5yJHVecGP6wU2MUFut2dccGMDpfC/
 knbXA+oc=
X-Gm-Gg: Acq92OF4sAgZJCXS9MefHVCXjY51EbrjG8fMEzkGE5tq5qUSgGvTZbjr9ErMkMqR3Aj
 0iEl3qYuoIcRFsfcEOgAMy1L7dcoqNZ0izv2A9j1calDHFmWcdwbJSodMdG5nBwQvNpdQVo3GyJ
 3jr620mSWm2LbQ6mHQwwzn7s9Qf7Y5rUylnjyATeriunnk9GT/zsn9P8DO5EzBQbTfxzjm4/zcU
 Q7Q2boIBqgM5pC14w1GyOa6bLd9VnzzwgYB0fc5z2COBqqMSBZxWwWn9Ovn/ONsx3flKMgNx0S1
 1pNBM6+dvsValMXFwRrnQAF8WRlzCvDKUY6p20LeT4BxALNmUsdkUdTqCy4eFGxkyydiLDzyUaA
 AmZGtUcTv7/yTpq7XXvBuhPVeNDf/D9SB55LzZLZfu3JkQe3b47uP7kRsg7y0w/q3JOtNN25DCC
 TBZiqU9izjq4g3L+Ny1RFYETW2MLXYcms4tYV9/rui/F9+4mJqWt+tri0iFIL6JLNoyQWiCxBZd
 IXs85VFrXG7GJrPerqRTAlE3BoxmnsZ
X-Received: by 2002:a05:7300:7244:b0:2de:c5ca:c1e8 with SMTP id
 5a478bee46e88-301541af891mr268693eec.4.1778631999164; 
 Tue, 12 May 2026 17:26:39 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:38 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v4 06/14] sandbox: dts: add TPM SPI emulator node
Date: Tue, 12 May 2026 17:26:10 -0700
Message-ID: <20260513002625.76915-6-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:53 +0200
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

From: Aidan <aidan@wolfssl.com>

Add a "sandbox,tpm-spi" slave on the existing sandbox SPI bus and
a matching "sandbox,tpm-spi-emul" emulator node, so the sandbox
unit-test target can exercise SPI-attached TPM code paths without
real hardware.

The slave device sits on CS 1 (CS 0 is the SPI-NOR flash emulator
that other sandbox tests use), and the slave's sandbox,emul
phandle points at the emulator node added at the root of the
sandbox device tree.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 arch/sandbox/dts/sandbox.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 02b03894eaf..2fdd7f0e942 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -286,6 +286,17 @@
 			spi-max-frequency = <40000000>;
 			sandbox,filename = "spi.bin";
 		};
+
+		tpm_spi: tpm@1 {
+			reg = <1>;
+			compatible = "sandbox,tpm-spi";
+			spi-max-frequency = <10000000>;
+			sandbox,emul = <&tpm_spi_emul>;
+		};
+	};
+
+	tpm_spi_emul: tpm-spi-emul {
+		compatible = "sandbox,tpm-spi-emul";
 	};
 
 	spl-test {
-- 
2.49.0

