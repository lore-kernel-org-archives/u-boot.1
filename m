Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13156CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65EE1845D2;
	Fri, 10 Oct 2025 16:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XpeZSX5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AD2845D0; Fri, 10 Oct 2025 16:45:54 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6096384258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4db385e046dso21249811cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107551; x=1760712351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EF3N9fdRB9QHWwnBhz3LLNBBEfymrl/ff2lvAf5eics=;
 b=XpeZSX5kf3sqGEeYtuZhFBeZ76v7VsNpYbXTkSOYcBVX2989jZ9Br6s7rHS8/XBmFH
 LL52obh4i/1Z34F3MYXdus8UOh9uw6/ZwQNsBIREQJTneRyh97IvYIsq/uId75srNUl/
 BcCFYnUUJ1SkqQBrqdIP+GsRCqhUkoRlmX9D5ieZH68ByQjqSxGoZjFq1PCJUAOSKVe7
 NIVb2WyC70gBtSHnT3Z0X/S6TS2PxcX26OvpnfH3gxwl5eLTmp3oUeMWERn4PEBGkD1v
 T8zCqq+ESB5qT6kLoyQ2W9ZCGW3Qu+zCSzn6yMU9HRQlayfqlzaLOivaSJNNnztd6rkd
 0/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107551; x=1760712351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EF3N9fdRB9QHWwnBhz3LLNBBEfymrl/ff2lvAf5eics=;
 b=bWu+46M/DjtAwMJK4n0+rILfMzrMXBltDXrVz4XUs/OPI+uJbNEOiEsg6TEnyF/ZO+
 3Y3F9GBFJyNpfOGxVGpYh3GLBbzCBP66M5I1r4HoJ1YuyHMa0jGeqZydRzXsfLeCTNxB
 pMMZivkAdeegSE/gpY7/OkjHjH4om0qQ9KaaxVRfnYwRCgv18m/fCoipm9/VO1spCCLl
 cfUOvkVrBNNk6/i4zgb2Z8aRtSIJ9uFz5Sg2xXaAV0wqs19tK2hxs/1juIqYMkfnFRnI
 Os20mAJRf9wpiKWpGpSUXThRlBqxfiN5D4ay5Z2HSPCxMoflA7QP/X7a7hdhCjLrWVcq
 xB7Q==
X-Gm-Message-State: AOJu0YwbQtITouG9Lq21+cWn0VDuwa6LkOf71DXxcRIfKxrqZDiM2Twz
 od1VjcJRg5ZNN9SOwVHCaJbEDiHfL3YAfeOVjmuu15IaYTExuKeg/9XzLcL9m/+ipLVR3iQfc5i
 qOS53
X-Gm-Gg: ASbGncs4g0+Xb9KFSNplj7Pu4EzC+xjzZAi95wERLEyA5hMxf5sW5F8yzTfASgiIw1C
 eky3Wo4qJmK2SNvaRrR9+w5NpSQyRBzWjgKaMH12cyHwUgjaA41C9FHBKSw3VAg5HALhnNcFGWv
 1uOtC7Az7SwU9epuB+ZFTwqMt3iLYRIcFuRjoSgFmWlwk7PovZ0Xwhxz00TfH7Lh62GOT9PA99B
 s1cqmnC7R0bX7rp3tUeWhUh2cM56oILptmcYUiTwMFUdfj+SzV2DzpwVeZXzeYiM6VVhUsYD+ZF
 a1R1b1J4lkIc67NRf5PEF5YuVQzXIuSTD6eF1aUMirJZn4PgzprT6QV3cRj9i8Tn1ShCmQ6M/dr
 s4pbYyvdsk6pGQzdudqUZ7qxSwJAXTKq83WXbwNHOmFqGMV466T5ztm3zVqkFmONVmJJshkflH8
 gNAVQ=
X-Google-Smtp-Source: AGHT+IG5Z6uPJfoWMvvYStXkLEdmpdVDQvLkvgiKoorUDySiDzeiwaznjBRDS13c89MjDzu+EjlNyg==
X-Received: by 2002:ac8:5d05:0:b0:4de:9f9a:b8e1 with SMTP id
 d75a77b69052e-4e6eacd1632mr158359961cf.18.1760107550852; 
 Fri, 10 Oct 2025 07:45:50 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:45:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 3/6] configs: select CMD_BLOBLIST for Firmware Handoff
 testing
Date: Fri, 10 Oct 2025 07:45:07 -0700
Message-Id: <20251010144517.3573014-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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

