Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3383FCCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E4A834E5;
	Wed, 15 Oct 2025 16:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ri5wmopH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058A8835B3; Wed, 15 Oct 2025 16:19:31 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A47800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-79a7d439efbso83341856d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537967; x=1761142767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lxtZXY89GySioy3H/3ldsP9HKf6lezyGcvz7eueqC0=;
 b=ri5wmopHpLoVQiCA9r1Bo7tAKFYIkajzEhxFjq0WFzfxUGnUbgid53hNqJjuCBoySW
 RD96XzXqdk/CuT5ZLJHb7UG8o713c+NwArOtnmX/8VM626CrVMajNaZTnzIz9NcAmdDK
 5HtSnzXZw3x6suRFmqo5H/ROIxehCrydzT3vucbikcNOGUMBaFSSwVG8Fyv6sNVnVJyU
 bogibEbKF/dceQyCQputjErJCDIDaSWMTrR0iMxKzzRjkVwpMu6GNIKpaYylnleRGkUw
 H+SObXZZj4Zbn1LggmeHZxYWRNbwGS/6dHt6QtaOwDu6/QiriUFV1kzTVOd3YUoo5s4X
 lYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537967; x=1761142767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lxtZXY89GySioy3H/3ldsP9HKf6lezyGcvz7eueqC0=;
 b=Esr/rgpnhm9G/9w5XFKM+1n3O7yHQCYndxttUryMfeLB3Z0PAvM6AJo3q7eqrpq1Yv
 5K3+5FFeT7TzTy856hq+dac7yOeC3YHCEw2m0E2DTIt9r5ZA6b3YvlYLiVEX5KrWkama
 a21B8TU+umxJcFF4ua7J6ZCzlJgMfmCJGGe36PeMTMLOcvfzXANcWs7gYQq+Par2U5GO
 dGPOo6r8LiGPeEfAamDemqgU2N5UqZy9LWf2HD/ogTSALjs/4PptCGK2Ma/apmzXDPkR
 6i6jTKUPIrPB/U+AI3xNVHTV5EfSkZDWfKQUvhMKkb+xFHIFUZNQnwQ5OEFiJpSTcyoX
 NCCQ==
X-Gm-Message-State: AOJu0Yx7Eds6puDQmr5vn7Nu+YgAYc6E37yQPu5lDbGSPxHlxVY1KyWm
 gKofveMVlYIQLbBzLBCwNeSzJDEcVEz6m4HEkh2Bz0XG4LWXwXX4HounMNqGhMZPOZOO9ANEGIa
 beP/v
X-Gm-Gg: ASbGncvUVKEht22cJnlvJSd17JKik7un1JnY1bS3GmymkJCqqXjViZTetrezvRGew+8
 MYlYnRtnBsQSUIFVpSulRtkj0CGMKhc46QDtt+5InWv2M/8ZoMwPb8OKkGVvLAGrrsbmajst0La
 06Hwrx4TS0oj9Th8L4nMCd401jj3q/KUqD1ItvG/JQkmYZAV22mWo9mk1rCeehiVnWGLR297K5e
 /mdSuODtavEoPPjeiE48OlL/AmWGjVlf7i2PjhSbH6aTqtxOL8cUUb+c9r41jtk50mBqT2row6G
 PrJ9M0RRnSUrIPU81gzvIzgBOVujnzcTOb125gcGC8a5G8x9oaQ1kcmGlQvgPlzUWCdXXM5T9vo
 tl9/edMx6DtkgdDG94NnQvUu0NU9q7jNSguygkhnnsy1bqN3nfZB98zvgYq1/79haMn+9/p+tWW
 wlmgntcXyt2v0Cgg==
X-Google-Smtp-Source: AGHT+IGWCPpZD+Y3WUcxW8EUQQex8VgdCtcVjgxf2L52O5PGD8etf7lZGyB0P2e14GNFNVuBApf9SQ==
X-Received: by 2002:a05:6214:d06:b0:796:b86f:3eae with SMTP id
 6a1803df08f44-87b2efb937bmr400283186d6.36.1760537967106; 
 Wed, 15 Oct 2025 07:19:27 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:26 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 3/6] configs: select CMD_BLOBLIST for Firmware Handoff
 testing
Date: Wed, 15 Oct 2025 07:18:47 -0700
Message-Id: <20251015141856.4168612-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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

Firmware Handoff tests will leverage the same board type 'qemu_arm64'
with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
in qemu_arm64_defconfig for running the test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 358bb1aeeb9..0a43abf8fbf 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_BLOBLIST=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-- 
2.25.1

