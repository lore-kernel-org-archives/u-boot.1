Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421E9C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0023888CF;
	Mon, 15 Jul 2024 12:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0xf2xeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487C2888D1; Mon, 15 Jul 2024 12:14:11 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CF988868
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4267300145eso31505215e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038448; x=1721643248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trXyguYW8OaZPtGKFMuCr24qOeIajIsGpPIWd+3OpI4=;
 b=a0xf2xeC6yC2TecLU6X/ng0BkAsG5Xmlho6mGtymtIz7S/9C10tyPDHk/N0LDGMmsp
 9JFirltmlQTvIpv+bc84AT7XY6BkF+AMKUN/YOJdXxth86tFTYvwOtRCmSXmneMlmTMM
 +6XcFPHaXlLA8dfrUmb1kBBV2K9w/tALjDf90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038448; x=1721643248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trXyguYW8OaZPtGKFMuCr24qOeIajIsGpPIWd+3OpI4=;
 b=iwBnCkzyLwKULqDnlxMQd194YxhSyDsTXJVx0/f4pCmih0WNQ7+/LRSzQ1qIMLlu/h
 dyt5kQ9+zc2aXQrqkqyLQpawXd87fYEmBiij53D/Aw0fvVZHTkd1Mdio27MhSdk13TSO
 7NKxjKwgUZCyJP9tPVEYwew3AWYLZrR9q7RjeC32HtzlDWSOiny0Ra8gys1L05ASDHAG
 Q3ceC2uXKtjYyYspx4t1JO4G76HFl7VZt9eVIdm/IaxJIl0MDnJn3lwRV+6QG1nyEeZX
 lHWgi++jSbHBDBdVmYPTi8x09+RhlllDzoEl1U4T1/80ppFP9idEMdVxzkSuCJkNXv2f
 6K6Q==
X-Gm-Message-State: AOJu0YyMcmH039UBV5WJPbg1WNzmTuBepD/ANsvUVDQ/0sRoXz1gAnLD
 +Lx9MP6dZYPipjilhaU3Owvork5/Dt6SyJvOfUvnkl3HfQ2Pt31X5vFPe17kBC01zC1fUdru0oA
 =
X-Google-Smtp-Source: AGHT+IHrv/JQncAeDI1Es6s+VGsr3TCGuiztvSfox7ZxUjw4QgfHa0EiZfdaw35GJ6VFGa3lQdMkEQ==
X-Received: by 2002:a05:600c:2d84:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-426707db6d5mr155522145e9.22.1721038448329; 
 Mon, 15 Jul 2024 03:14:08 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 11/13] doc: Add a link to VBE from the bootstd docs
Date: Mon, 15 Jul 2024 11:13:52 +0100
Message-Id: <20240715101354.97895-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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

Link to this page to make it easier to find the VBE docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 7d31d5e6427..0d7454246f6 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -416,7 +416,7 @@ Bootmeth drivers are provided for:
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - EFI boot using bootefi from disk
-   - VBE
+   - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
-- 
2.34.1

