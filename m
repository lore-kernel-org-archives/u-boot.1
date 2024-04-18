Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECABC04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCF988693;
	Thu, 18 Apr 2024 21:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jYC9hxnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384E58863A; Thu, 18 Apr 2024 21:00:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3270E88693
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 332CF618B9;
 Thu, 18 Apr 2024 19:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1F15C116B1;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713466829;
 bh=RIMrzIgyJNsKDdkG30ykeJxK7kmqXZzvJXb9obb7yIc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=jYC9hxnDWZaTpAzTSi18lBfVPhWwN7h7umZv/zdwWf0558KGgV/+sU73fT+DI4dKW
 Eodng640LyfDJxABxxJ6WDFcAxHM6mju0MlEbkIHd95hc96pv8kLKbsL7lsduq4hKa
 4KKAjXvV5rtovcvcg31A44m1CAAvuT9pijR170JnJaMtejXJ3ZC3zFguKrB/BBP383
 6eP8fMOiCHR2muaoxoXxnhvNi7Eowtv6lQy/jKe+kTY5UQGtobecmkiU/+qDZZjD1x
 qeowGT8yevrxu+Eoe4cv38bzg23sJlhQNtBKqk9e0NUiBdy+V7jOmTJjMNL+aLZMJG
 Gt3f19KXAinFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C02B0C05023;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 18 Apr 2024 21:00:26 +0200
Subject: [PATCH v2 2/5] configs: apple: Use "vidconsole,serial" as
 stdout/stderr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-apple_config-v2-2-7e5c6b9a9db3@jannau.net>
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
In-Reply-To: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=j@jannau.net;
 h=from:subject:message-id;
 bh=pYGw3Rvsr83Yc8ZaQ99xyUt7JbaiOW2b/6U7j6EjC9k=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjTF3NN9cRuTa14bdceZaN24ns2/uiDgYl3kvf/l1bt/S
 Su1mWzuKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMBHTZoZ/Wl/vbTHY+N97ktKW
 A49nJcXWXhU3inaeXSO1OWfnxnlM/Az/HVcyff0xST79Y8lHowUrmWoc9RaJ1zPJPJ2n1Vrxw1G
 EBwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

The display size querying in efi_console relies on this order. The
display should be the primary output device and should be used to
display more than 80x25 chars.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/configs/apple.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/apple.h b/include/configs/apple.h
index 0576bc04c9..a70440b3ad 100644
--- a/include/configs/apple.h
+++ b/include/configs/apple.h
@@ -6,8 +6,8 @@
 /* Environment */
 #define ENV_DEVICE_SETTINGS \
 	"stdin=serial,usbkbd,spikbd\0" \
-	"stdout=serial,vidconsole\0" \
-	"stderr=serial,vidconsole\0"
+	"stdout=vidconsole,serial\0" \
+	"stderr=vidconsole,serial\0"
 
 #if IS_ENABLED(CONFIG_CMD_NVME)
 	#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)

-- 
2.44.0


