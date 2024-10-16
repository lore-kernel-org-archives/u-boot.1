Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A23D1AD59
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A74588E17;
	Wed, 16 Oct 2024 15:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/L5K3qF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D5888C3D; Wed, 16 Oct 2024 14:36:21 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99A688AE8
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 14:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so11347155e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729082179; x=1729686979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TdKYgEQq686nBwCY64OksgwiqTNXu2Btpp7h6Q6HWds=;
 b=a/L5K3qF9m10dQGLQtKbJXOsOPHsMDuZFCpgIPhex+Epx/hPDCDK7jpJgTaoUeABAl
 RwrkSz2pboKscNPGGeT8NcrQJHadMUNSN2Ux0l3II1R2w/73toMCbzdkfJuHqRgnu1CJ
 7QVbqEzKsvwravgtUlDYaBfy/chNnB5UKRVeK4iNGeufM/VQgUj9PARTL0mxBat7aXbb
 omlpiNRSO4+4xpUvzhvLlsqmy76+yEjA7aDvZIDpeG4aVG01VoOC8CSii+XddlLfM1v/
 RdTPN4lRYjC+NLMIBf+/n/8WHpRZpQu9D7LIcM/gqhGCMOeWkfx/JwzUO1AUARxdkmoO
 EDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729082179; x=1729686979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdKYgEQq686nBwCY64OksgwiqTNXu2Btpp7h6Q6HWds=;
 b=ISIj+097aom2Sjy/Pyk6KHmSrL4yCWwE31kh4C0PPKUCLXToK5tF0RQ7WPdXZ0BP55
 I/ZFgd9wCxMRfs2b/IK2m/tICxNbfLTJl21BT3uiLxGOXhqsmRsQrmZ+DirmpVOqa4fo
 VQH3x1R6E+OjTN1EAy0hkAqJspitCEGjYQzl2K7lmHwFShJ2DpuYIcnM5qMpYJKRrWXH
 Lmsq/HPI2gax0Sa/HwpfyNz1rtNcZX4+i9qx2Y8gjl8LqYHlbYdIxLCmohOwFan3TMle
 HA2gvOgnJGnHdNx6IZmkDixFc4Fa5OJVO/0DSiVYeWaWETnD+OATVd0wFOZ0olG8bcDO
 xkVg==
X-Gm-Message-State: AOJu0YyM4Z045D3Jj6osf7azfCuYGVw8JRjgTOSPx5UNU2nYb0gTtv6o
 TaNi6t51PkcKSIO7ZPqri1G61AtcXb8hJmRbb2tbiCRrQ08s0EkLUTxCS58CFMusTwDR6WjaY/L
 imZg=
X-Google-Smtp-Source: AGHT+IHufwUcMxeXMZsUjlKZqtmQfDRu5CuRMsJz8jGM0esvymdlBFtzP4swRijEDGo83YJp+iB7bA==
X-Received: by 2002:a05:600c:1c13:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-43125617834mr146965415e9.35.1729082179018; 
 Wed, 16 Oct 2024 05:36:19 -0700 (PDT)
Received: from eugen-station.. ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314b32e3c9sm32015235e9.36.2024.10.16.05.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 05:36:18 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] .mailmap: update e-mail address for Eugen Hristev
Date: Wed, 16 Oct 2024 15:36:05 +0300
Message-ID: <20241016123605.97709-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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

Update e-mail address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 .mailmap       | 3 ++-
 doc/git-mailrc | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 952e1dac4b20..4d48349f0e9f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,7 +38,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Dirk Behme <dirk.behme@googlemail.com>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
-Eugen Hristev <eugen.hristev@collabora.com> <eugen.hristev@microchip.com>
+Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
+Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>
 Fabio Estevam <fabio.estevam@nxp.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
diff --git a/doc/git-mailrc b/doc/git-mailrc
index ca2f67a3b6e2..1177e42df2f5 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -22,7 +22,7 @@ alias apritzel       Andre Przywara <andre.przywara@arm.com>
 alias bmeng          Bin Meng <bmeng.cn@gmail.com>
 alias danielschwierzeck Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
 alias dinh           Dinh Nguyen <dinguyen@kernel.org>
-alias ehristev       Eugen Hristev <eugen.hristev@collabora.com>
+alias ehristev       Eugen Hristev <eugen.hristev@linaro.org>
 alias hs             Heiko Schocher <hs@denx.de>
 alias freenix        Peng Fan <peng.fan@nxp.com>
 alias iwamatsu       Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
-- 
2.43.0

