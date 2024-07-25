Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03356C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39AD87F19;
	Thu, 25 Jul 2024 15:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lLXDxpGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B4D86463; Thu, 25 Jul 2024 15:58:50 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9DA881C1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-397a363cb13so2280765ab.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915927; x=1722520727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3gC+cF2ojHKK3dpQ6bgsm0EIiUiHvAP8CfmDt7wcho=;
 b=lLXDxpGwSidrpcuda0ZnZkO5ARybc5Tm7J3FEiAqJoB0tbr4D3a6E/OdL1GkVxWrEl
 kdcqrtjwzpnnPGysYVWvzG9DInQt/JZ0Ecxm5BxJja/NJSZnQVSzfk0UrI2GIIIwUPhU
 RfiemDoEqK+nO8VZ62QetWHaernVPNJqgxrZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915927; x=1722520727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3gC+cF2ojHKK3dpQ6bgsm0EIiUiHvAP8CfmDt7wcho=;
 b=MYQgTBG/b5zMurcbBwXWY+PbbYAanv3t9PcaMdtSSX/nOcDmNvMPBmpcmqwEnc3kUu
 jP8017mU6eSmaeeTf8CmIYQeLWb0k/uXiixvzvIWVNtnhDL6miZt//PjfXBPq+fKIdTp
 vj7Fia4/WyYJSKF9dpZ/Uq2LT8Wf9XOf7hD1LrVUp4z8oPVnefBz6cQ+yQm7guLyPJwV
 3z8cBcl/hoosVnzjw4YpjJwjr059Zi8iS0khYY3nyBMZNJaKL8FimiKxR47nk4PAruoE
 Mc7cqjUCLDh0+yrjEJ24FL76OOgLusJo6hgJMrMeuGQd4G+P08ZWvuV+WzOpnuv93LWu
 FGjA==
X-Gm-Message-State: AOJu0YzNduyUJGkEW4TaTNTYYV0vGcPpgoSfYF8l2BTch7ljY49BLEJe
 DUL3xB8kkjRkAl+uUayWUID/hf+MmQp0/U/9tB3R+NMFzvk32TrjE1QoYa6UvhKLfErI+jSFySU
 =
X-Google-Smtp-Source: AGHT+IEZ5AMYrJ/yA4xkLmlnVHWu1IP9A6yH+UUx5sQ7Ia9lz2mh/l4vhsieU9sQks293k/sb/6PKw==
X-Received: by 2002:a05:6e02:184b:b0:382:834f:2b9e with SMTP id
 e9e14a558f8ab-39a23f5b94fmr29040745ab.11.1721915927274; 
 Thu, 25 Jul 2024 06:58:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 6/6] efi: Show the location of the bounce buffer
Date: Thu, 25 Jul 2024 07:56:29 -0600
Message-Id: <20240725135629.3505072-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
lx2162aqds_tfa_SECURE_BOOT and the like) use it.

This feature uses EFI page allocation to create a 64MB buffer 'in space'
without any knowledge of where boards intend to load their images. This
may result in image corruption or other problems.

For example, if the feature is enabled on qemu_arm64 it puts the EFI
bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
1088MB. The kernel is probably smaller than 27MB but the buffer does
overlap the ramdisk.

The solution is probably to use BOUNCE_BUFFER instead, with the EFI
version being dropped. For now, show the address of the EFI bounce
buffer so people have a better chance to detect the problem.

Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
that the feature may be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 07c8fca68cc..53e5e429d2e 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -211,6 +211,14 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 		return -1;
 	}
 
+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
+	/*
+	 * Add a warning about this buffer, since it may conflict with other
+	 * things
+	 */
+	printf("EFI bounce buffer at %p\n", efi_bounce_buffer);
+#endif
+
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.34.1

