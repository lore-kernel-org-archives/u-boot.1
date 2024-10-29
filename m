Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A99BD3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192E6891C7;
	Tue, 29 Oct 2024 20:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FD5jb2R4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C04C891D6; Tue, 29 Oct 2024 20:22:46 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4528919E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c935d99dc5so6659659a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229763; x=1730834563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=FD5jb2R4mRZA7QGpJvZ8/iVdgG+pOB4/dfmiWGNEHO+qa78clBlm2Qj2RKbyrojJ7e
 Q1K8NFav68N4Em4yrLvsX0oyQQ+WSafZpYwewpMJeZ08L/XEV48/bIQiyzf6OVsq+lJ9
 MmQV6p85oh1IiGqej8Mxkn4pWc08+rsgKx+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229763; x=1730834563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=Z1unirOWAufmmzhnqcebQCpH/KtUCtF+5Thj5bdUN44mqjhB2YsrV9Vyncx8SwK72h
 l0F1wk/ZlLDH0jbDj1Yz7n0LndUOGpAmDFMQuTFW4Whl58h6dRTXUBY5JxEw7SCsCuqy
 V8xs3I30fZPmszDjkMVPZu1O5CJeEZWUpT3fRKAGkhvx0m71b7WIChdKHjk7GqT5oczS
 tDkIedPojwLrvojb9K40WoPi0/9chPpsV5HEnYKKtKozlE8iFjW3A8wevXKKqu47AWvR
 5wuKoDDwvwBoOoJTN9OkLYC5tkC/bvH7rZoUqJ39dx4BFgFocjwRjWorQ103UalBt3zX
 lR4w==
X-Gm-Message-State: AOJu0Yww8lQORVOoJ2F0lbjvBfBzGB5UfayE/lYgtsdpp1r3rUrD0BBx
 z47jBHeIU8vqBG8wqUcOveSaixSjh1UYOH0tdLj7WjkL9KtR/o1dIAvEVHyRPydq+2F75D5/bkE
 AM5f1
X-Google-Smtp-Source: AGHT+IG3AWaKA3/oQ8McOlVZ1iy3KxZNJ0JI8wl+Btxv08P2GGNZCOh4O1gPTukUeVdvyXRuRah8dw==
X-Received: by 2002:a05:6402:2711:b0:5c3:d2bc:2f64 with SMTP id
 4fb4d7f45d1cf-5cbbfac3a40mr8995006a12.35.1730229763121; 
 Tue, 29 Oct 2024 12:22:43 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v9 09/11] sandbox: virtio: Disable the sandbox virtio blk
 device
Date: Tue, 29 Oct 2024 20:22:17 +0100
Message-ID: <20241029192222.362445-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Issue: https://source.denx.de/u-boot/u-boot/-/issues/37
---

(no changes since v6)

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

