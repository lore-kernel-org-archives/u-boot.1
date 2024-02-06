Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992C4C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 03:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A0687613;
	Tue,  6 Feb 2024 04:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="jA2Xdzon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09358751F; Tue,  6 Feb 2024 04:56:21 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0AC38751F
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 04:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707191778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TMbGk7Hlpwk3FVIFr9lZXcWn5OGRx6jpnH2neM2IYPo=;
 b=jA2XdzonLL8ISJYCdpfrCCVokfbe466UZB+gazdyjRTv+if/PQN01bFcVdXIVDueYe/Udi
 Bt9FuCDDszKvhmuL5uCRuGhU8YZY7uZriD2c/dN1mbo8Dl4PNuk59IU0OoU6B1eyUYsb2L
 mj8gdBDmao+9+iMZWFqLff6CJnOZsAUa9PLai9GRAP28SCEh9vC+z/OZRtqGE2enyfSxC2
 aNKE3migzgaEjltGMJMtYEsbj7FEy6WfMlq853pukc2tUNB51QCXn+xb+DSkdmJiSXPZ4e
 T55thQnPVFlIcAzK/85DeHL9lfLcsMYH49DAB0ZrgUvYPSmRJxYymPGogelw2Q==
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	trini@konsulko.com,
	martin@geanix.com
Subject: [PATCH] scripts: dtc-version: Don't show error messages
Date: Tue,  6 Feb 2024 04:56:16 +0100
Message-Id: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Prevent the error messages produced by which(1), such as the one quoted
below, from being visible in the build outputs.

    which: no dtc in (./scripts/dtc)

This makes the build outputs look a tiny bit cleaner.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 scripts/dtc-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
index 53ff868bcdce..6d3d7b68fdfa 100755
--- a/scripts/dtc-version.sh
+++ b/scripts/dtc-version.sh
@@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
 	exit 1
 fi
 
-if ! which $dtc >/dev/null ; then
+if ! which $dtc >/dev/null 2>/dev/null ; then
 	echo "Error: Cannot find dtc: $dtc"
 	exit 1
 fi
