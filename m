Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA1CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2AAE88F0A;
	Fri, 27 Sep 2024 00:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bw4o1Kz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9158688F0A; Fri, 27 Sep 2024 00:04:24 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6D088E5F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-4581e7f31eeso10188351cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388260; x=1727993060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOyIrXevk5tg14qicOznbHVO6DiV1YBkAm3RYuB4GkU=;
 b=bw4o1Kz8J/142yS1Cwy7+oOypOchD+UvbfEFe6mIEFuQL6Zdbi+JTB0kR+Nk4OhNRA
 4ruBXaK2KD4v9wRmRyUEH02Hf3dC8/7FjLJkagBhKWDtGl6ZUVQaHbLmS0bJ5pbiqrOC
 XJcNgtzjwQ+UmHOPS/JTklr0FXsOxT7LF56mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388260; x=1727993060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOyIrXevk5tg14qicOznbHVO6DiV1YBkAm3RYuB4GkU=;
 b=Wz9bXXinW8kT/3vWHdvNoUOrnpESH6+Xo0K8cBsbEsIsqbrbE5N3YkswK0KcAhkr5X
 fZ6D3xvsbbVdw/DLt/wP7MVfzyeDU0voQXVq+hfwlLhCSZUgw3KNqw81jBbFIUQY9Kbj
 aBJzXL7OpdXKhYDAN4nim8aPNnV17DXmaOVcr5LWIySB2+jrT0dOaSKo29gybIok7nFg
 GwuFV/ayDT/Fo9fV2ktRobNESuXCMbTtgxac5z3ZXvLOOb1PHhfXfqC1pZhYafKdc+nd
 FH/0knYDShvm4C6d9dKp3RmmWg15rTUM4KB42dCBMagYG/U2M+LwRUd7kBIpRpN41F8a
 AAmA==
X-Gm-Message-State: AOJu0YxUDSTN7QOSFj9xPuA4SsMmoVsP9ZcVcbyd2fV8r0a/RK+sw4Fs
 A3BMkxdCCyvR2Td+77LwpEKjr3T4lpxTHafCUz8jbPe698ZUCvtTksF0BjeA5yXr8kbcg2d239a
 OkJawtooUjA==
X-Google-Smtp-Source: AGHT+IEWj73tY6A5vy3WEukQhSFAoIHfMv12CiPYEl6uckhSfgPpIIWfiPdxAddQ05Y9GOxbtwjDDA==
X-Received: by 2002:a05:622a:10e:b0:458:4c86:4564 with SMTP id
 d75a77b69052e-45c9f2a387cmr13772401cf.37.1727388260530; 
 Thu, 26 Sep 2024 15:04:20 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f2e02c8sm2540211cf.44.2024.09.26.15.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:04:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 10/12] sandbox: virtio: Disable the sandbox virtio blk
 device
Date: Fri, 27 Sep 2024 00:02:21 +0200
Message-ID: <20240926220226.1265965-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926220226.1265965-9-sjg@chromium.org>
References: <20240926220226.1265965-9-sjg@chromium.org>
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

This is not implemented so cannot actually be used to read blocks.
Disable it until it is implemented, to avoid causing a hang with EFI,
which probes every available BLK device.

Signed-off-by: Simon Glass <sjg@chromium.org>
Issue: https://source.denx.de/u-boot/u-boot/-/issues/37
---

Changes in v6:
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device

 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..c39efb4d0a2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -212,7 +212,8 @@ config SANDBOX
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_SANDBOX
-	imply VIRTIO_BLK
+	# Re-enable this when fully implemented
+	# imply VIRTIO_BLK
 	imply VIRTIO_NET
 	imply DM_SOUND
 	imply PCI_SANDBOX_EP
-- 
2.43.0

