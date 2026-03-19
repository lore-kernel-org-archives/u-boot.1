Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF74109024D
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3397683DC9;
	Thu, 19 Mar 2026 17:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EotRpa5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04F983F2E; Thu, 19 Mar 2026 17:33:41 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B36183DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so951307fac.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773938018; x=1774542818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OEsCIEJhYkPognfhteVhm1PxBfzi3lZe2FlVsUjueLo=;
 b=EotRpa5uF1Dh2wWVN9EonJlV6Z7OUXX4xI9os6ofBmE4/Peu7biHY3PbTPdV1YlVxl
 N+EJn2rd9Mi8TisFtv9FxZ3DH+Rk0mroefJHWgirrq1NZt+Qc7bup69cmhtp3hDH8kJV
 +hPKp9r/rOGLHQ9bfeBxJJQ3itpRF9Hnn8jdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938018; x=1774542818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEsCIEJhYkPognfhteVhm1PxBfzi3lZe2FlVsUjueLo=;
 b=qmIgI9YBf3uKZj2mJbub9hIpc6rBl8qPHk1Irz0xlLBja2sFeGHNJ06q5dRkeWjrot
 COm7OZP8A89wCgmGnRm2SV03DPqJ8/C9MTSF4x/j8dJ5IQX3AO43yyKW+3HKaVI2aY0v
 kuv/q4fkGlh5vmz2LVBlfn1hQWcsQr05cQHHhgBTuW511GfxNarkySOqwHhLDYgQ1LzU
 t5fo6mQx+JVEvMED+oFbNcb52XafXmXl47P3HeCmHG3rf9+0t3R7oV+6a0WQP3l1j+PH
 8+tY5OtZpi47brQlSXfdP8dH1UuZpsE/SJs1tbsZizHO80Dy1n2YaLCrhxPIDCuUwGVM
 LLrw==
X-Gm-Message-State: AOJu0YwFkosn/v+L2rnwPcjY/+cywf7tP/axcSzBqh5/SPCqQDLb3584
 F2c98DUpjqM2B8LANJ2V5dN3U0MXRyRXR/HHk5f3ACIBQhwR5B9XIzMEGEoukP6QyFCym0Sn8GG
 zall1
X-Gm-Gg: ATEYQzyDKBBjtoOPaWrvtIi93ts5hic/aweYSf+Dxflit2N7xjiD4huUjxmlXbAw1/u
 LoMxZuO7PVCC95SmLdRF4asLKBsPqJrwNqq1mfXxi2YVP6hMoBh+KXUVABO+LpbeVe6L3ziHjow
 nyCTnlhB4q3/S7ssRREhgGJgLuwJmHjvvRw1awk7OJrVKyF0zI1UoatwC2u2gctl6euSbm6tJqv
 CPgRonC3dyFjfmhi+QhGflpdCAX2DLbZkLY3aVMKzdoUc4FXLiwucm96VHQHkCF2pJt7OAjz48S
 CtVS1tsUXbcuom/eCJZXFrPqCdNAQlBHkbY/td/T7+me5Sh641A9vyCFJmdYILOWjASfGYcgx12
 IJ53CcP21eYUMFnaU+tuwozLolubOurlAFF8XrdCk4ll+pUn5roDroqpAcVbnwMZnlg14zv5h/D
 OCPIFokc0DuENptvQG2rzfnCMKlCRHKavr3XcX1+5EPW7DXF8ixHpWsKzXhhrPP0MykOeMEthXN
 GbsS0Fw++EYiRqD4di0nU07mP3pBIk41hMWrnMh6u0W0ljAnSE=
X-Received: by 2002:a05:6871:5213:b0:417:540b:682e with SMTP id
 586e51a60fabf-41bd403e366mr5029704fac.49.1773938018103; 
 Thu, 19 Mar 2026 09:33:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c30b0fsm5783854fac.10.2026.03.19.09.33.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:33:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] serial: pl011: Remove legacy serial driver options
Date: Thu, 19 Mar 2026 10:33:36 -0600
Message-ID: <20260319163336.1679890-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There are no longer any users of the legacy non-DM pl01x serial driver.
This lets us remove both CONFIG_PL011_SERIAL as well as
CONFIG_PL011_SERIAL_RLCR references. We still have SPL users of the
non-DM portions of the code.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/Kconfig                 | 8 +-------
 drivers/serial/Makefile                | 1 -
 drivers/serial/serial_pl01x_internal.h | 4 ----
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b84cb9ec781d..c86c883e0cbb 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -398,7 +398,7 @@ config DEBUG_UART_PL010
 
 config DEBUG_UART_PL011
 	bool "pl011"
-	depends on PL01X_SERIAL || PL011_SERIAL
+	depends on PL01X_SERIAL
 	help
 	  Select this to enable a debug UART using the pl01x driver with the
 	  PL011 UART type. You will need to provide parameters to make this
@@ -862,12 +862,6 @@ config INTEL_MID_SERIAL
 	  Select this to enable a UART for Intel MID platforms.
 	  This uses the ns16550 driver as a library.
 
-config PL011_SERIAL
-	bool "ARM PL011 driver"
-	depends on !DM_SERIAL
-	help
-	  Select this to enable a UART for platforms using PL011.
-
 config PL01X_SERIAL
 	bool "ARM PL010 and PL011 driver"
 	depends on DM_SERIAL
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index fe8d23be5123..66088b44eb68 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -10,7 +10,6 @@ obj-y += serial.o
 endif
 
 obj-$(CONFIG_PL01X_SERIAL) += serial_pl01x.o
-obj-$(CONFIG_PL011_SERIAL) += serial_pl01x.o
 obj-$(CONFIG_$(PHASE_)SYS_NS16550_SERIAL) += serial_ns16550.o
 
 obj-$(CONFIG_ALTERA_UART) += altera_uart.o
diff --git a/drivers/serial/serial_pl01x_internal.h b/drivers/serial/serial_pl01x_internal.h
index 7ae3ae509086..3c481b1e3d13 100644
--- a/drivers/serial/serial_pl01x_internal.h
+++ b/drivers/serial/serial_pl01x_internal.h
@@ -26,11 +26,7 @@ struct pl01x_regs {
 	u32	pl010_lcrl;	/* 0x10 Line control register, low byte */
 	u32	pl010_cr;	/* 0x14 Control register */
 	u32	fr;		/* 0x18 Flag register (Read only) */
-#ifdef CONFIG_PL011_SERIAL_RLCR
-	u32	pl011_rlcr;	/* 0x1c Receive line control register */
-#else
 	u32	reserved;
-#endif
 	u32	ilpr;		/* 0x20 IrDA low-power counter register */
 	u32	pl011_ibrd;	/* 0x24 Integer baud rate register */
 	u32	pl011_fbrd;	/* 0x28 Fractional baud rate register */
-- 
2.43.0

