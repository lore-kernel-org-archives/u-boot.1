Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F93D0D172
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF1A83A2D;
	Wed,  7 Jan 2026 21:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qp57833v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72CC3840A9; Wed,  7 Jan 2026 21:28:21 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3050D83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+david.ixit.cz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BF765600AD;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8870FC2BC87;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767817697;
 bh=bmmZzua/duFCTuBjCY1gFaXOCBC198ejRbdmlKcmZKQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Qp57833v42EwV7NZOt5UHGwyxo46v2mEheyLc9pzVyhLCzPPLhW5s8N1L9D+YmZlr
 kvL/BUm3wMmjqHefTBFvK6qt2bbTKo5JCUur8lRLHuVm4RQ2fkxB4iisXZIRJdRMS7
 IRWouw8RNQLDe0dB/4P7z+ikie69wvhW8GO+HTJLMoaAItUWSKQPHTxqvydjx9Bqew
 t21OM2u/N2vjDzAcTAknTj+/sFUMLnq/sVwmbo3mt0l98c+gLfhZJ5dxPlyPLoiIAP
 1CNvxBwymtCAYXkf8UeRXJ20IyaXySdqRA7k39IbrD9LDIinusQ8R/6U4AY7uzhV/v
 INLfJy+wTYliw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 817E7D0D173;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 07 Jan 2026 21:28:16 +0100
Subject: [PATCH v3 2/2] configs: Add google-pixel fragment config for Pixel
 3, 3 XL, 5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pixel-config-v3-2-02a25e3fdcfa@ixit.cz>
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
In-Reply-To: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=h+Nc04IrcZG+c2wA/6MKW+Am3zzHGmDuKQCDq3RHC7o=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpXsHgAKzTizvWemARKtvkORLcddhSm0O/drIFU
 vG+EdEi3OOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaV7B4AAKCRBgAj/E00kg
 coNtD/9FawEBToqkb+y+9El/UCdcE6VxYQM+2Xd9RRC9SnduuhSSlaJbOr7fOuyhcpTpJ9m61ju
 b0GU1siqHDNfZCE7Smcq2Tyr4I0ZTiEb+DM/oniyHjNI/Rg9ZqgCNENuNvgjSz0MKuDnfyRfYdq
 BaPcmp+ZnbXogqaTqBcnhEUkC7DJ4xj/LjPeMoZABMdj/PV9cytgrxsAeD8SBgO8Yszs35DfFSX
 6iEK5z/3Iw7kp6xxW5pmF9r/UwrLv6DGSiR6TSyI8zVW/ybD4V9ohb54Y8P1e2cbKrLHr5682mE
 Kn7heA4FqtJ1RQdkuAgDe+IJnuRHXA7KTBDi5IR2fOQL+s16ap5HwYNCV8LoaQW21X+ehvj9S6P
 +bWr9qV/absE605KLAX5LLhcT6SIBnc6wsLc5nKP9wp9CrReT7uzZk2CtSgJxxD0vf/rzaoDwWz
 91gbrezK3W4/IWPsyxkcf+iQwJIFg3Z55sNo6Wrk7AIJV1qh63rRGvQHqwoQdDI/NN2aLtsp0rs
 Z/80ovoxxKUcWP4KU4ZII0zGtHl2DT1m7K5Ln/C55tpYLJ49GAid9loKNcb4mdcnq/3OGWUMw5L
 b/vhzovFLJzcQ/d8d/R8dwVRXfEzA22T4/CMrlqhb8hGa6lKS8U/GhgssJIJnsqCL/MaZ8KgGZr
 CMeGTRhMG7LLBew==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: David Heidelberg <david@ixit.cz>

Introduce a fragment config for the Pixel 3, Pixel 3 XL, Pixel 5.

On these devices, U-Boot is chainloaded via fastboot. However, due to
additional requirements added by google, the image header must have
a specific value for the text offset.
This is solved by setting CONFIG_TEXT_OFFSET to 0x80000 in U-Boot.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 board/qualcomm/google-pixel.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/google-pixel.config b/board/qualcomm/google-pixel.config
new file mode 100644
index 00000000000..999d4e45268
--- /dev/null
+++ b/board/qualcomm/google-pixel.config
@@ -0,0 +1,5 @@
+# Enables chainloading of U-Boot on Google Pixel phones using
+# newer bootloaders (Android Q/R)
+# Use for following devices: Pixel 3 (blueline), Pixel 3 XL (crosshatch),
+# Pixel 5 (redfin)...
+CONFIG_TEXT_BASE=0x80080000

-- 
2.51.0


