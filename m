Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88486E9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA37E83D5D;
	Thu, 19 Feb 2026 18:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CPrEMdil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5010683CEE; Thu, 19 Feb 2026 18:51:59 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6198583D77
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so16758965e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523516; x=1772128316;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqS8BMujc7huCljGLyRgy1F5r4IDy3eVdPIRG1EUWAw=;
 b=CPrEMdilrS32x1MNtL7Nvnh0AHeQXfJyW4RI+zKWihoWemjCYl0W7proDB1hGbq4JE
 jLooQXQCEm7Ls6OrYnJV9Abnb+Asj42bWpx5Mw0LicmoEt8BkoDpqS3UHco2DM4tUJxD
 kitQZyAbnJL2zzADQez7bfknMyfQ4iRTIAdrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523516; x=1772128316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqS8BMujc7huCljGLyRgy1F5r4IDy3eVdPIRG1EUWAw=;
 b=ilSYTcpipKLOoAxuuuJ/kyrAz1UUnL+UBpfTFJn2DoJB418/MJlFLsYykJT2R70X9l
 dEa7eTOXWhPBLaFlitSTYJT+yl9iCpV1ciQCA1EoR1pVdu5Cd6pEyjV95ixWUPf9rsdU
 lXIDLborrRENzi+W6tC6eIfeOXek+HQgLxwv8slYpzb7CVfFnFS1D1aKD2nqD1+Sm5bu
 I7MrjK0benT0SY2sMrkKJ/IBgUjGhAY1JRCKkLB9wlCs+lhxyYhU13mwTere2w9b/JyN
 gQjEQDhNRxpIvxW3zuWK1jPuR6zrguYY7ew4KVAqo8+WYv5X2Z3PK5MUYjfx6O+WFcXj
 U7ug==
X-Gm-Message-State: AOJu0Yxl4GDyixnKYwOZnE3Myu2w//rZdSQITWOMSKlU4RzA+Tooj3YI
 ii5DavNDrjogFm7o66J29XDfbd2aSZ7HeEYdc5KkzoevRc1KARd+w3YFPks+XHRAi7GkYiMOsHr
 s2Gij
X-Gm-Gg: AZuq6aL3GuHDEyzXyE9eFxiJxQ766MluQRFp1uOt1wXf+znAVp0LM/suEQU8ffRkx4L
 9ucJdH3PmB6lJHw84Ld0kTl+9Ov9aQBu4U5g6jCD6Ed+vdCmB8AqE+xavzOUkffE66l8igjIIUv
 l0CFVQTaHl/finDR/T1EMvfrYqTVwPxhdzcv5/gOgd3FUIbnAWV1yeiM+DSreuJpqWDCGL1Blj0
 r0DvsBCKj6YYBvoDZwRNc8F3cYL3snUGsYnUL32F74mE+ZGe7UgBQgrzONnpdMUD6EEDEvci+oN
 GUvuv/2sP+QfyXugVDIm0EzwfqvJQk1S1wcWiO34D0M464z+nIyNHSXcLUQrolOEw4uz1lv+4N5
 C9oM16/HgOLFMCbJQEeU3sj12y+aRw/2jWFHxZOKhWkRkCpvEKZBaTX5j4LvVBDDWPeMedK08wH
 8Z5ss6NELT2Pkd16rAQEpHmFjeg5mc7ph4U2FXd1UzHQEURUDrPDoriTmBmfeJY+nTU5/1CCeHI
 WoNvtrv1IU3RG1ktPUEGv1+VYubXq2N0nk4ctqLfXQEc2GwNRrpfdCJSYAdO5vO/rzVPC0drKlm
 QduIO1CZ2RrDZJgLDnD2xuGeclr7HgGz/Qk=
X-Received: by 2002:a05:600d:6413:20b0:483:78e7:ce15 with SMTP id
 5b1f17b1804b1-483a00aa4cdmr33790975e9.13.1771523516638; 
 Thu, 19 Feb 2026 09:51:56 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] test: spi: add sandbox_spi_get_wordlen interface
Date: Thu, 19 Feb 2026 18:51:14 +0100
Message-ID: <20260219175130.2839234-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

Add the sandbox_spi_get_wordlen() public interface to retrieve the
internal word length state of the sandbox SPI device.

This is intended for use in sandbox SPI test cases to verify that
the word length is correctly propagated from the SPI uclass to
the driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/sandbox/include/asm/test.h | 8 ++++++++
 drivers/spi/sandbox_spi.c       | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0e8d19ce2325..0438790028b9 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -243,6 +243,14 @@ uint sandbox_spi_get_speed(struct udevice *dev);
  */
 uint sandbox_spi_get_mode(struct udevice *dev);
 
+/**
+ * sandbox_spi_get_wordlen() - Get current wordlen setting of a sandbox spi slave
+ *
+ * @dev: Device to check
+ * Return: current wordlen
+ */
+uint sandbox_spi_get_wordlen(struct udevice *dev);
+
 /**
  * sandbox_get_pch_spi_protect() - Get the PCI SPI protection status
  *
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 8eed56140f6a..b035a60ef43a 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -63,6 +63,14 @@ uint sandbox_spi_get_mode(struct udevice *dev)
 	return priv->mode;
 }
 
+uint sandbox_spi_get_wordlen(struct udevice *slave)
+{
+	struct udevice *bus = slave->parent;
+	struct sandbox_spi_priv *priv = dev_get_priv(bus);
+
+	return priv->wordlen;
+}
+
 static int sandbox_spi_set_wordlen(struct udevice *slave, unsigned int wordlen)
 {
 	struct udevice *bus = slave->parent;
-- 
2.43.0

