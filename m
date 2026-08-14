Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB36C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E654C8130C;
	Fri, 14 Aug 2026 18:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxo0kL_dTt_K; Fri, 14 Aug 2026 18:29:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFF9B80EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732142;
	bh=r62TeOAXiPlMybwek5M5Qsnohak5ZDeyI8oaKirp5Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvFTM3yAIINFDdiI90EX9+8BOJf6thMuxaPcUXax7oCIvCO4exkEuKjo3l9X4Usfr
	 3rAva0Mhu6hP2Zck7cHnhTOoSCHsbrwU7PZCTwJpL4oeRTJweA4rhKRo7Hzn/+dcax
	 BjPHk9Q44Ph0hGac8isHBHKzxYhcZigtSH7jHAIw67RIrlAnenvrpNufMsubPN+j8f
	 TWTkgAJ9ijsZtEZo29QuK0/FzOpTbAG6v0/PamwDff9YNNCPVoS5Ks7DyhGppTS+pL
	 hqKlcZ+YOJYFRReOErmTZt+QsuJIo/3SLgYTc7OrPKOA1ZsABx0tux+8E2cLZOTDl5
	 sw180MHxxvtfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFF9B80EF2;
	Fri, 14 Aug 2026 18:29:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A988F194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EBA380EF2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjbRDtvk3LyJ for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:28:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 49CAB80CF8
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49CAB80CF8
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AyS69gL4
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49CAB80CF8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:58 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-92e99ef0902so76121385a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732137; x=1787336937;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r62TeOAXiPlMybwek5M5Qsnohak5ZDeyI8oaKirp5Cs=;
 b=AyS69gL4U9H2XU7y2r/fApITJN6e/hNGvkd7Horkh4phOFXj6DACQhybHuxEdY1I0S
 8rUMYkeUyDrhkAaJOAekofw80w2WMpRkiGvZMpxLuQoVeX26d1laE8zg/S6SN35iEzAf
 yZ8tc81EI1uU8Pgo9Z+pj7dMHvX5Od5o02lVMi6M+H+UUFlCB8WIZcsn4VUcE2kv+nrr
 F0nFoF8r23+G9hpPxmUhpzXItPpsY18aAGNudZ0FHlxIS+psT+EOT0fwXTX35kW7MsIM
 8zwcPNBDLMZTxZuPY9Umx2lcV7TAEpIz7tKcvmjcSzmZLIfzD3JUVfO7Xbb74JPerD/i
 ShpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732137; x=1787336937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r62TeOAXiPlMybwek5M5Qsnohak5ZDeyI8oaKirp5Cs=;
 b=mrb6fE7pHET0V1NR+dtixcVrxGVI753Hk8rRjKMUT7cGMq8+4Qs+I5nBX1NF7N4Y9J
 wbExRZLRx5YC1YOqxPXk9NvfjARg/9NZxYsjEpPWFQjI7zhKzwk9AmlOP6YtuKzLjQz7
 tJDYW/VWlCTQygXunP99Uo8eTyvnIxSVPeupuU7P4k63nOOoZElkTjZJTndMG9PRpX8R
 iaMwNFgeYkOkUsk3KcvhVC33GXJHLW+jw/qaXp3JS5inj9yFBwdsGntkCT7Zm/ybNSAH
 lsZAkX9KjJ4oCTriGL9rYj9zcfqV0Eks7K88Fj5OxPdxWMqNgvQSaBgcsfI2hy3ZOWXB
 jC0A==
X-Gm-Message-State: AOJu0Yz5Bsa9jUzBHYb28XexDKPY8Jj7OjoLB5W2vdZngHdBy3ltiGRP
 3Epa1vnBWLhFlYWZ8pfOz8/9OI4A/PfcvAs8cRLYfxhBKeCJxOqBtKNq9Tx69pe+9w4=
X-Gm-Gg: AR+sD12j8M+tYiCCgjXuqDR6cSXiPK9gvWrRl4k9VDu7NWSiWWgNC4u9aSXf0wASBxd
 obBpzt1RYN6/NSyUv6dYLH7PmlrmCuvItCTDlNh3poqavqVryVLvga9qoFahKjIEJ7PI0kFA6as
 RNdy2OKX8h47tJ4fP8KRxIOFHCnCofZUEfUxYI8C7YChE4Et6msa0nWOQ6T9+E2LSaq+5jQLe5y
 8MjlRwFj1uWy4pALIKnbyGsqlrcrNHaOgzsSCpz505584slD2nzvPmdMtNnvP2fUX5C0o8TT1ys
 sVWsWOpDmOfx26gBo6XVH9qBugAc6sKbWPghZCl4DlcBMvTvD4w798gxnj1wyvKS2UTKEiLRt07
 EZi/GF6sa6V8I/BtFxu6oAxyR0hTdyyilynvjODnTmnp/Md6BFgNd312t3f9HUTmoCNETvR1CoM
 /OOnJsQEtIIOxn+KN/vPYnHrA72iSCp3/fxPXvfM+9J1kc5BqzP5LukoE1LLF3rYAVFNb+lRHCi
 e6yRr+Z6Y2cxi/IIt2pajbnxdLLBusChCmESPP/7q0sClG58AF5KTF2
X-Received: by 2002:a05:620a:2949:b0:936:2fa5:387a with SMTP id
 af79cd13be357-936d23c3deamr815686985a.43.1786732136722; 
 Fri, 14 Aug 2026 11:28:56 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24564asm336071185a.40.2026.08.14.11.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:28:56 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:28:51 -0400
Subject: [PATCH v2 3/3] spi: cadence_qspi: Use APB write protection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-spi-v2-3-973d5fa092f2@linaro.org>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732131; l=4719;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=bs/kNzTyR0YoSHtMroS7BMYaL4dPs4c0lvI+zuts/H8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFK9aeV1nIH3zqZU1iqvCz3XJ56h4Kyw99bTWsQYs7/e74juIB3+EZVWBnRJz4euIyWWpXa+Nl5
 XkVDdb4gQmQo=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add an option to make use of hardware write protection in the QSPI
controller. This helps prevent flash corruption due to stray writes.
No stray writes have been observed, this is defensive code.

When enabled, the controller is configured to block writes to flash. Due
to known errata [1] the full 32-bit address range is protected, even
though the flash occupies only a portion.

The protection gets temporarily lifted while intentionally writing
to flash, for example using "sf write" command.

[1] https://www.renesas.com/en/document/tcu/qspi-contoller-issue

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- patch was split from the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org/
- combine the enable()/disable() into a single function
- move the IS_ENABLED() check inside the function
- reword the commit message
- considering to drop this feature, since Linux disables it
---
 drivers/spi/Kconfig            | 11 +++++++++++
 drivers/spi/cadence_qspi.h     |  6 ++++++
 drivers/spi/cadence_qspi_apb.c | 23 +++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..19f8d48507b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -168,6 +168,17 @@ config CADENCE_QSPI
 	  used to access the SPI NOR flash on platforms embedding this
 	  Cadence IP core.
 
+config CADENCE_QSPI_WRITE_PROTECT
+	bool "Cadence QSPI write protection"
+	depends on CADENCE_QSPI
+	help
+	  Enable hardware write protection in the QSPI controller. Helps avoid
+	  flash corruption due to stray writes. The direct access region is kept
+	  locked by default, and only gets unlocked during "sf write".
+
+	  This is similar to SYS_FLASH_PROTECTION however blocking is done by
+	  the controller, rather than by the flash device.
+
 config HAS_CQSPI_REF_CLK
 	bool "Cadence QSPI static reference clock"
 	depends on CADENCE_QSPI
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1e9081c2d17..6b3ed46977a 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -119,6 +119,12 @@
 #define CQSPI_REG_IRQSTATUS                     0x40
 #define CQSPI_REG_IRQMASK                       0x44
 
+#define CQSPI_REG_LOWER_WRITE_PROTECT           0x50
+#define CQSPI_REG_UPPER_WRITE_PROTECT           0x54
+
+#define CQSPI_REG_WRITE_PROTECT_CTRL            0x58
+#define CQSPI_REG_WRPROT_ENABLE                 BIT(1)
+
 #define CQSPI_REG_INDIRECTRD                    0x60
 #define CQSPI_REG_INDIRECTRD_START              BIT(0)
 #define CQSPI_REG_INDIRECTRD_CANCEL             BIT(1)
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0d4bc685f5d..fc4649916ad 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -325,6 +325,15 @@ void cadence_qspi_apb_delay(void *reg_base,
 	cadence_qspi_apb_controller_enable(reg_base);
 }
 
+static void cadence_qspi_apb_write_protect(void *reg_base, bool enable)
+{
+	if (!IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
+		return;
+
+	writel(enable ? CQSPI_REG_WRPROT_ENABLE : 0,
+	       reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
+}
+
 void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 {
 	unsigned reg;
@@ -346,6 +355,18 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
+	if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT)) {
+		/*
+		 * Enable AHB write protection, to reduce the chance of corrupting
+		 * flash memory due to a stray write within the DAC region.
+		 * Protect the entire address range, regardless of the flash size.
+		 * During "sf write" the protection will be temporarily disabled.
+		 */
+		writel(0, priv->regbase + CQSPI_REG_LOWER_WRITE_PROTECT);
+		writel(~0, priv->regbase + CQSPI_REG_UPPER_WRITE_PROTECT);
+		cadence_qspi_apb_write_protect(priv->regbase, true);
+	}
+
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
@@ -955,7 +976,9 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	 */
 	cadence_qspi_apb_enable_linear_mode(true);
 	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
+		cadence_qspi_apb_write_protect(priv->regbase, false);
 		memcpy_toio(priv->ahbbase + to, buf, len);
+		cadence_qspi_apb_write_protect(priv->regbase, true);
 		if (!cadence_qspi_wait_idle(priv->regbase))
 			return -EIO;
 		return 0;

-- 
2.55.0

