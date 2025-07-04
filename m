Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA762C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8676F82F30;
	Fri,  4 Jul 2025 23:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DNoRRyDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255F482063; Fri,  4 Jul 2025 23:46:12 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0930982F30
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so1362188fac.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665569; x=1752270369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=os/Nx3+Pzwm1vG3KNoimEXEuqwa49hKB2VsLtJG1H1M=;
 b=DNoRRyDl0TObokVneZTHuZjTVk/w/sLuSTYGLr66ZDif/9BtGUY1qcmA8mtxfDG3FY
 mGtzQDxQnowguvwvy4k7+UQ4xOEEcC8An2LkfZpkRlcKQ8f1aJTuzIzw+S0BaOh1lC8o
 ygm0mBXa8fMWo08zeKvTRKSPJ10xCFkz+ld7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665569; x=1752270369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=os/Nx3+Pzwm1vG3KNoimEXEuqwa49hKB2VsLtJG1H1M=;
 b=NtzvGK2xWzzKIUjBEfmWwBBauYoHUF8OEMWc8SnPdaHcYi9o4RkGyxDjrqg60NuNGx
 zFQ27Omm+n/ZhgLuJ6qSLOaShEYAloL6RwKh233i+oXSZtvreEy3sYSFZ8Sufm3n4U0T
 GHkCEA2NGnB6xMG94GTpOVizFXxqAwFRy23rTQasKDH7S1LV0qDciqqsiiB94kB2EGed
 YDAb3e4esWrc0SeiiBPojUJxhlsvSz6OKh/vM8oOLnhVqo7tbHA9QJaH76mqMtrHqZiH
 BNwLFo3sVLnvT1xgbGInn5QI1PnYrW9n4/IFvIe3QCnULEyCPTVCEVOAmL6j6Vz8koK0
 RP0w==
X-Gm-Message-State: AOJu0YwQtyaEcDICMKDRWotQ/aYnnBiO9Ad4DmfPp0hh59xM7ZPurIHZ
 URYBbIoZyXqrBCTZ3g1tTxrzp2F6PaQARVRSY/Le8tBGIDtvH5J96fyD6Q5pzYhcBAitpfheow9
 yL73I+ew=
X-Gm-Gg: ASbGncs79ykXNr94aJMrhRfWeqRsY8S3oDvPUNQ8St61JaLw+SqYzzfkMfYgKmnU1Ra
 bq50crSV7R4UsF4z2kVXRm4DXu/2gxFPk/3jfQQ0rXY6ew7A9Dh3k0k8WIqMe6aKWfGuMlZA2H9
 ID/fHl/A/SAjNAr2lQntg0oPq2bfECkrw0f7pW7uwDTkdKYuhR8Q+5fL9PimyHRND6yimFYsMom
 AFnNy78a/ifkA97Xd6pWmynsvg5KrB25kDGlUqH7bgzK0TwY7Jy876iGrg7hJy9rhbrXj4XHUFB
 91/LOpKh1rTS8n4NwTlKgai3mrO97OA/Pgj3gIbvqVvyP/nuYaOa8ds1to5sESGWwVvelHjqydR
 WqHAsHDhkxJjiadF4o3MA9Do=
X-Google-Smtp-Source: AGHT+IFMOGIfwgaWFgnzq90a9c9/oSNhmP+gb4gc5Gxi5d+XIChrsLOdiWHh8pcra9Ru9hZgQ6F9NA==
X-Received: by 2002:a05:6871:887:b0:2ef:2af4:dfcb with SMTP id
 586e51a60fabf-2f796cd7322mr2750504fac.28.1751665568714; 
 Fri, 04 Jul 2025 14:46:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f9628d8sm519483a34.60.2025.07.04.14.46.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:46:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] Kconfig: Add COMPILE_TEST option
Date: Fri,  4 Jul 2025 15:46:05 -0600
Message-ID: <20250704214606.3418898-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Take the COMPILE_TEST option from the Linux Kernel v6.15 and since the
wording there is OK for us too, use it verbatim. Also update the default
for WERROR to be COMPILE_TEST which again matches the Linux Kernel.

This is the first big step needed to allow for "allyesconfig" to be
possible as it then lets us then disable things that aren't valid for a
compile only test.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index 05b7f410fa59..3571f5214e67 100644
--- a/Kconfig
+++ b/Kconfig
@@ -27,8 +27,22 @@ config DEPRECATED
 	  code that relies on deprecated features that will be removed and
 	  the conversion deadline has passed.
 
+config COMPILE_TEST
+	bool "Compile also drivers which will not load"
+	help
+	  Some drivers can be compiled on a different platform than they are
+	  intended to be run on. Despite they cannot be loaded there (or even
+	  when they load they cannot be used due to missing HW support),
+	  developers still, opposing to distributors, might want to build such
+	  drivers to compile-test them.
+
+	  If you are a developer and want to build everything available, say Y
+	  here. If you are a user/distributor, say N here to exclude useless
+	  drivers to be distributed.
+
 config WERROR
 	bool "Compile U-Boot with warnings as errors"
+	default COMPILE_TEST
 	help
 	  A U-Boot build should not cause any compiler warnings, and this
 	  enables the '-Werror' flag to enforce that rule.
-- 
2.43.0

