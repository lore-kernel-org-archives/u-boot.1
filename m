Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF88FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B1C8414E;
	Wed, 25 Feb 2026 17:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mb4zcPke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26B58410C; Wed, 25 Feb 2026 17:21:29 +0100 (CET)
Received: from mail-wm1-x32f.google.com (unknown [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA2584154
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso52656425e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036341; x=1772641141;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwYALHZDBEirWjUwGBe95A54XbbI8IIK1ONmtW4T1Qs=;
 b=mb4zcPkeJJhqyjL0n3y74rJU/RBgPmSg8X5432HIS7pwL/a0SZhS/kU9fIqiC6/Ble
 qacfI679CsMQYNfOsSv5fEjbLFW5JvmrQ9Ncpd7TUrhWIyn2daNTXvKfYGD1X9pPFrLd
 IBJW8l/V2fuSQIqKUaeLsZpl/zgCtzyZj4sIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036341; x=1772641141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gwYALHZDBEirWjUwGBe95A54XbbI8IIK1ONmtW4T1Qs=;
 b=h5FoUNnW9TxFwzFlFqYp/gvfe9peK/eckymHHoFLzM6tOC6/jY7Qx+1T+WBKf9GPw8
 fFXNxTIdACicFDvoDOWGDvPZ52cF7jfZzLcusHs+Pg+JG5buvkgdc/bidZBqApdxySuS
 IuKSbqqROaPELPAflvC8NoMKSNUsBwgimMBuGfdU1AcP9j/rFABakUx+9I7ZtvJFqdDx
 KLIlSh97qSk+uI0j1RBz25U6Qd/Ho9Oju0nkhgC+tGa2631f6piPRw5chiDvWCiQtSZj
 4BTAQNn/wjVr4q5U3kfxCoB920kKnl+95eW+hCBcKFMDVG8rwAs5mhkLsEuLWbNMtIuG
 KtLg==
X-Gm-Message-State: AOJu0YyAqZpRHoWiku4u07OaaZMvjltMFkmA8OGX4q1bHwiiRFggh0Rr
 zTSVHtRnAVIvxk3k+3WY/5K16aj80PATu6SymPExS/Eg9QX2hpr0aDF/epq+KnyKcJjy0kAVh7T
 bUFs6
X-Gm-Gg: ATEYQzwozqWWPWeTN152O28vAUnpaXw0X5iF2gSIe8WAdpJ0JX3d/TljIPW39tBhz3D
 imwSZc48qhT4i5JrCzbLcmSoyEdpu6/13gI9/ydx6JxUF2f7LREGC1tWUmBQ3cbDvWT83nmypXX
 moy5LOY8MZoW5lgTGtGHjhpycFz45cSHtMQkQHPeM7he9w4bKNwVlaPccNL/t64QyBeysKB8ttq
 BNbyLHkGs9L9H5A2oIrIt1q7BU/pyYF9x2Vb19MD0C0/WvfmLHOnFfPe+5Bki9BH90d0O/14mwL
 HgTojSXL3XTr9QaGsWIh2otVAU4LuW5WsU7it1xjRx2iOhrC0Kny0IbirzxvqkB/UbJwxOdPHum
 vHTJedSL3hxTuYBQSNav91bFGuM1KK2Daks91tdwiD6oqAFLoCrUYppB1owxBc9rC4YCfXrNzN1
 USDtI3hKEQFjjQdO6lMzpnmT7baeUJ48S8n+HWwHopk69KCBMi8crsOhHxzZRCFOKbhFr8mpKk/
 23ud6Rnc7pgL7D8oy1/WVvQHlCbZMMah3WTE9lEDK6GFhIh
X-Received: by 2002:a05:600c:4f95:b0:483:8e43:6def with SMTP id
 5b1f17b1804b1-483a95e5a97mr250975375e9.28.1772036340869; 
 Wed, 25 Feb 2026 08:19:00 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <simon.glass@canonical.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/9] test: spi: add sandbox_spi_get_wordlen interface
Date: Wed, 25 Feb 2026 17:16:54 +0100
Message-ID: <20260225161851.2475274-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add Reviewed-by tag of Simon Glass
- Get from struct spi_slave data.

 arch/sandbox/include/asm/test.h | 8 ++++++++
 drivers/spi/sandbox_spi.c       | 7 +++++++
 2 files changed, 15 insertions(+)

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
index 7c237ac8d371..3ee97d67f4a0 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -61,6 +61,13 @@ uint sandbox_spi_get_mode(struct udevice *dev)
 	return priv->mode;
 }
 
+uint sandbox_spi_get_wordlen(struct udevice *dev)
+{
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+
+	return slave->wordlen;
+}
+
 static int sandbox_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
 {
 	struct spi_slave *slave = dev_get_parent_priv(dev);
-- 
2.43.0

