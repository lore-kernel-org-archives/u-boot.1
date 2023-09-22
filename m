Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D67CE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 21:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F370786A38;
	Fri, 22 Sep 2023 23:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZsHwxTX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C32E86A1D; Fri, 22 Sep 2023 23:38:28 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2AD86529
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 23:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-351208d0d6cso2847995ab.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695418705; x=1696023505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cddcroFMiaszMxMYmABwsCYxPZflbbtcSUEfr/rBwKg=;
 b=ZsHwxTX0XI7z0s70ZXrZKpApnemYXH+/3t3dsfYpfB4KCV3hcvgZeIGD1JPeCwN+L8
 prP2LGMhrIZFLCiz9BSI9bry4wU+BfExzJxhZA7U1lIY/RvSGALj74EjYRq23x6DlCBM
 ubXEn0X56tWHj4j/pzkykPATJtiaw79A0KQxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695418705; x=1696023505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cddcroFMiaszMxMYmABwsCYxPZflbbtcSUEfr/rBwKg=;
 b=CSqswegQ+e7xoHsY7JeqhQorsIVNo3+5H4h90G13N/hf8kswA+br0AKLdJdXBe2nem
 wIQu3/9K3QHf9aNV/qd+N5q8J4MmH3ZjsRDzPY1R3L4bM4hXmHQrRn/nRa1w2A3jF8SA
 aeWJcvEbCp443rB8dVs58KFHlJOkklv50LnETXOIx09S4CN6kzZbcHlK5YlMlscYk+lQ
 estYghmb73BZcDHCxrQgyuS+XlDpzqUxPZ1jXszTcMuP66kzsafB2UiIZcHiIfIaugOE
 yR0ybmW+x/qKyxS57bGLDI9khdKGtogbjd067r3INwIHUBvhJhV7Jg+h1V2HqrzgyZfQ
 lZJw==
X-Gm-Message-State: AOJu0YzLFmGTDhK/VeJfya1jzM6ENfrHCE+BG5gtaCQb6pkwF5bq5j+i
 MonMRdOaH60d+bI0sR6X+O165oyn2HFCflWCk6U=
X-Google-Smtp-Source: AGHT+IH5Nv9wpcfC0n/KCgyIoe15mZ+ANpy38j1RLyuDB3VwrylQYUutTTkq1TtEtFOH2zJuiXn8ng==
X-Received: by 2002:a05:6e02:160a:b0:349:8a8b:70ca with SMTP id
 t10-20020a056e02160a00b003498a8b70camr1020244ilu.14.1695418704869; 
 Fri, 22 Sep 2023 14:38:24 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a02bb18000000b0042b09bde126sm1221477jan.165.2023.09.22.14.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:38:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 0/4] Resolve issues with booting distros on x86
Date: Fri, 22 Sep 2023 15:38:12 -0600
Message-ID: <20230922213819.1886094-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This little series reprises the EFI-video fix, fixes a USB problem and
enables a boot script for coreboot.

With these changes it is possible to boot a Linux distro automatically
with U-Boot on x86, including when U-Boot is the second-stage
bootloader.

Changes in v2:
- Rebase to -next
- Add some more comments to the header file
- Add fixes tag
- Add new patch to add a return code to bootflow menu
- Add new patch to add a coreboot boot script
- Add new patch to avoid unbinding devices in use by bootflows

Simon Glass (4):
  efi: Correct handling of frame buffer
  bootstd: Add a return code to bootflow menu
  x86: coreboot: Add a boot script
  usb: Avoid unbinding devices in use by bootflows

 boot/bootm.c                  |  2 +-
 cmd/bootflow.c                |  6 +++---
 common/usb.c                  |  7 ++++++-
 configs/coreboot64_defconfig  |  1 +
 configs/coreboot_defconfig    |  1 +
 drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
 include/usb.h                 | 15 ++++++++++++++-
 include/video.h               |  9 ++++++---
 lib/efi_loader/efi_gop.c      | 12 +++++++-----
 9 files changed, 51 insertions(+), 16 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

