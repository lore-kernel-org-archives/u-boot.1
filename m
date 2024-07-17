Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C968EC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE90888A45;
	Wed, 17 Jul 2024 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAQvQMP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E49C88A1B; Wed, 17 Jul 2024 10:31:26 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A012188A4D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367b0cc6c65so3979590f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205084; x=1721809884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/t2LLmrRDVYwsPPJo12IUuLLmTSRtyQgtXqZA4KIV1w=;
 b=mAQvQMP1rYyozt/g+P4yCTk1D7xnSD63vrNW7+Mls214P7gtZTw00IqbPVWmpsh5Wu
 bBkgcYgfoMT+9+Fs3L7uZol8vEHOfhG9keDHi/0cpfurgzXoqwDYWhqvk/J+o/Aa+32s
 c1Fe3G3q8A71rMHjUzLQfe19H9ufvbeeyEJjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205084; x=1721809884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/t2LLmrRDVYwsPPJo12IUuLLmTSRtyQgtXqZA4KIV1w=;
 b=FCoNpU4nBU+SjXCtfa780vdI1DOL1b8qlw77UW3fll6hYxVbakVGZ03ld3I8SP4Kgu
 iP8UKB6QvSNkoy4pNyazRR48mzzVxZhWk2E8DU0d0MP63gKvnpt6ZDBJmA55BEzhsys4
 CDbDpT/L0OFHx3xpur8IhPMqkn5d487Uy990VrzaSYoaJVZEZ6gXSLVzxDDeX858lmZe
 3tlxWwkxBAezoQCDH028V5mkdQ4Y30kI01pvPQW1w683Vy2eGD6ZOPqpBy+ZIVTSBCUU
 TfkEKT4XJj82gG5UdsFehsDTUZtzAGntr5bEge17zGnS0E6A1BJwzmFQyQbCNXWPclNu
 7hig==
X-Gm-Message-State: AOJu0YyUSVi8xrCheAWZbHm4py3fB5NVA/lJ4RF3tETRVvZfrDNMnSIs
 S6Y+jDEQ/r9Fyys4YueYIbdhu8VfYJFypQ2lnmNph47kM3lWP2/g+U/akKBHktEcMhTeJ20nwM4
 =
X-Google-Smtp-Source: AGHT+IGzTmduParEllhJiB+iB4YnqB6uBK5WpfvTKWC6xUb2tAuuSFkMoMDhXv9/tM0u+LDgsD0GBQ==
X-Received: by 2002:a5d:5919:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-368317768ccmr668851f8f.55.1721205083972; 
 Wed, 17 Jul 2024 01:31:23 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 12/14] doc: Add a link to VBE from the bootstd docs
Date: Wed, 17 Jul 2024 09:31:02 +0100
Message-Id: <20240717083104.1963431-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index e4924b55ae7..4a55b7da00a 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -416,7 +416,7 @@ Bootmeth drivers are provided for booting from various media:
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

