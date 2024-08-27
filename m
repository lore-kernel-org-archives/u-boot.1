Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB0BC54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 17:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D6788A32;
	Tue, 27 Aug 2024 19:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="TtP6RxEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629B487FA7; Tue, 27 Aug 2024 19:38:14 +0200 (CEST)
Received: from mxe-2-566.seznam.cz (mxe-2-566.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:566])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CE488A27
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 19:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-5549df4ffc-zc8mb
 (smtpc-mxe-5549df4ffc-zc8mb [2a02:598:64:8a00::1000:566])
 id 116883c2ef9c316811e60dda; Tue, 27 Aug 2024 19:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724780290;
 bh=lIl5fSgmniNuyb+QIUtixaO3ZLxIBBhWwUIIgHlzlnE=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=TtP6RxEptC9H66EurhQ7q04qiY39hyzEdEnXC3afQC6NJfRxM5jBExqM3WIypLfUc
 8ToIOHDb4fXt+N99sVxUtNhfHvkqy53AuySqMJ7z/236cG26G/6rfZg+GeVeL/s90r
 PikKDkLbpnCGKpilWVtNHey6sAWJqXaNOHSVMj75bQ8adsvHbDUc+DlNci0eoLsjZw
 XLrLoiVxLGXbcwUOT7arUy830GlAdjlPnMixvLClfToPjpsNrYtJZpef4DTbKXIAqK
 O4MBacBxgJ5/s90SFqoFOlmDgYyKk0nOnwMMUPQcK7nccxkuufFqnZTHH17toFB/rG
 +Vq93p3lYrxCw==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Tue, 27 Aug 2024 19:38:09 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] lib: crypto: fix ASYMMETRIC_KEY_TYPE dependency 
Date: Tue, 27 Aug 2024 19:38:09 +0200 (CEST)
Message-Id: <GK.Za7R.19AhVTpFILn.1cpWy1@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Aug 2024 19:52:05 +0200
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

Fix the dependency to avoid a warning if RSA_VERIFY_WITH_PKEY is enabled.=


Fixes: b7463f198da6 ("Make ASYMMETRIC_KEY_TYPE depend on FIT_SIGNATURE")=

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 lib/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 6e0656a..742f6d9 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ASYMMETRIC_KEY_TYPE
 	bool "Asymmetric (public-key cryptographic) key Support"
-	depends on FIT_SIGNATURE
+	depends on FIT_SIGNATURE || RSA_VERIFY_WITH_PKEY
 	help
 	  This option provides support for a key type that holds the data for
 	  the asymmetric keys used for public key cryptographic operations such=

-- 
2.7.4
 
