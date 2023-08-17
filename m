Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0556FC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE1386A18;
	Thu, 17 Aug 2023 03:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YjPpNOAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E2086A63; Thu, 17 Aug 2023 03:52:07 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21716847D3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso6045361a34.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237123; x=1692841923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXsKEJWKna3JYuP44jmUfm5U65HShjxlwRay5c1RPfI=;
 b=YjPpNOAyvwJojN5R6IiPZhRuVczrycJ+k2j2FMhhuifdSijKgUp6cB2YicVes4yssz
 NI7rIRJrw8G4VntUHsUoJeF75qoEVTcMvj3hM9T/ow2swpkzEOlT2GA4keB176Z3Fcxt
 kOEYFRecOddiKt5lLjFid64eZJv3x6kAtwpB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237123; x=1692841923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXsKEJWKna3JYuP44jmUfm5U65HShjxlwRay5c1RPfI=;
 b=leENljSTNNZvd2oBvDZ2uzn9enWto762+3T+Oey7wWm8kiLanLeDhjNWE9ID4gZY1I
 Htvpz0Wp1n3maO1LJVS7SjnQP4B0NHgmFkCAJVeyu7N5gglsx7BvVQTkjyoa0Ot9tMaA
 ZadSV4dVpmnzFyHFNS08n61qlmtWkMifx4cGddLinMvecyMvoxgSSkRxeJM3ElkPACm9
 9ImLFnI7SPHhHbOYSRaZ2W2NZzoih6slXJxcZxKZ6k7BxwLnbFB+I3kdmQtVjQ5su4Xg
 PRTPGj3oIPL/rVOL/mr9J+sZwIAyX87PenfCvMHoFzADD/BJkiLcVc0zLrm+pt2/0sfB
 36mg==
X-Gm-Message-State: AOJu0YxMinrKm1FCvblE2pdiNZmjFTG+blqW1SrH0myfbVUPlAUCsH70
 kR3Yws9O7hNqYm3gyFiVwpy/y/WafzPl9p3VmWk=
X-Google-Smtp-Source: AGHT+IFBDINMnkT1c3MzRxVlwDRKDVI8ZRVlrgMJFnByvDfKI5Dx3Cj5G8Pn2ZEpRXN1fvV7bDQ0CQ==
X-Received: by 2002:a05:6830:1498:b0:6b9:e3b0:1433 with SMTP id
 s24-20020a056830149800b006b9e3b01433mr3442383otq.37.1692237123711; 
 Wed, 16 Aug 2023 18:52:03 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/9] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
Date: Wed, 16 Aug 2023 19:51:40 -0600
Message-ID: <20230817015149.774847-6-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

The debug UART on modern machines uses a 32-bit wide transfer. Without
this, setting debug output causes a hang or no output. It is not obvious
(when enabling CONFIG_DEBUG_UART) that this is needed.

Enable 32-bit access to avoid this trap.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 9f228420cfa9..2e80b5af92ef 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -52,6 +52,7 @@ CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 77214f1b4c06..ae44705a1d51 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -60,6 +60,7 @@ CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
-- 
2.41.0.694.ge786442a9b-goog

