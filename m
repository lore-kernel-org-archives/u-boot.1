Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC712D3C932
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0EC88F50;
	Tue, 22 Oct 2024 14:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OdhhVer6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8347989056; Tue, 22 Oct 2024 14:00:51 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8889888EEB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so7141003a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598445; x=1730203245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=OdhhVer6L1EBiDHJail+7JSXulrgRvWumgOPPV//d8u56ci9xQjiQDCAocgI/DlOWn
 e38M7JO1S4sKs/t2f72AKJ3ho4jBWo6/9g+7NFLhVKmFL1pyWUN4oigVrbJlnBf8zGtP
 0O5PN2zipoJFBirFA9vMpLeFsAdsR40WWyPeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598445; x=1730203245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=pPzYbMxj3Z/c42Tcr84P/TK6bJcEGpgnhZ/16M37URnzmMU1GXcMWd2l6tYajzU8qG
 QmiwPY/qcU08io5MSKKbSO8Lucdm0eWsksIKl3c6FLjivLuCeuFiV6m3YBNTlmxeY/GT
 K0j1scXgvnJjvrzkvSOrr8RuRkhPF0ngw3QPRzjLj7MxXezMqBZBSq7GpoQiAX78BqrI
 VmUcQO4/CUByKbmSg+r3Sl7AomZrCxviTweNV0iUGPGDvqK0jZz7lxITzEQjASdedvcS
 R3eibr0GduBGMe7wX2YGWhzpq5KqalXMQi9JRwZ1sAHdRMVbgEwobL6LzieDI/p3LqIW
 WmwQ==
X-Gm-Message-State: AOJu0YwVLigyeb/Y1yh9cuFsmb1O6N3Ndw06lRwfE/rnePO8UPYmJKM8
 z9855wx1UdnDtSIbRKedmtZlFpR+A5j0hkzL1OnMMkZUaBjw8reKNHhfLtTg6H5RzJBuPOgYS91
 esGEw
X-Google-Smtp-Source: AGHT+IFgCJEfSCdFld9/ToLFrcMUkEKqxMbAYe4e5LXwC8aZKaVS9zw9oWRnR2YBUy3ImMH1zaUs/g==
X-Received: by 2002:a05:6402:2741:b0:5c9:5ac1:df6c with SMTP id
 4fb4d7f45d1cf-5cb7fd9676emr1696080a12.33.1729598445378; 
 Tue, 22 Oct 2024 05:00:45 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v8 6/8] sandbox: virtio: Disable the sandbox virtio blk device
Date: Tue, 22 Oct 2024 14:00:27 +0200
Message-ID: <20241022120032.196311-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022120032.196311-1-sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
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

