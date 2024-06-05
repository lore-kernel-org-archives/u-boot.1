Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B6AC25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 01:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B005388268;
	Wed,  5 Jun 2024 03:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W2U85X6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6610287D43; Wed,  5 Jun 2024 03:37:48 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5010787A09
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 03:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-250af9b3a13so155333fac.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717551465; x=1718156265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N+n7n2LppipklnNtfnfDMvj3Vna4NKfGf1b425z/xUw=;
 b=W2U85X6e5AFkGiIgll2kFp6xslgVeWz929NqMg2I358nf3CdidDK+nRYNOHnbLT/iT
 OWbtJRuPerfUIdXwqit8GrLUzvZmhYJcsnAuuYxC0z9O6Bct3sVtyaKY0pJPocifbNzM
 ozEhe8ZYXHww0oOrw8OCAiVv9df8haYbfgB7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717551465; x=1718156265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+n7n2LppipklnNtfnfDMvj3Vna4NKfGf1b425z/xUw=;
 b=B9r0gVk4jJKKfYGBnfJtSzJP7Y2CXBxok1qdE/VF9sg/FXDGdFPIWucw0potKcyLry
 YAFOM/nFUTHlPzfRidA+t64jAnEaJw59Z8WbNsyUe8zW4TeQ0xWerLzu8KED+ywqnqJ4
 ZhgPb1zRnc/Bv6sliDLsBxC5NmSqtDWtjY2ng0DkZ5lLlGK2nXQ++4QizyB0RKyW2aR3
 n+JmvcJYrCA+IxxNLy2ALvbnHJxViAbHz49HD4xexRXqbb75rdeKvP6KlQBJ07foZCHJ
 cs8a4oyvodgu6JOn32EIp7DiDMyrav3z03nI59N4OkEZhoh0VhJNTXrNeIpGSzxABLiB
 cKHQ==
X-Gm-Message-State: AOJu0Yxo5oDxpqnpoqmpnlRxSEScBg52rK7fwrgEhjHHsnybP6gxgVRS
 RUkuCgcV9Tcc46hoK2KkUOq3gRybVMP3xYwjk93huraE7CZKl7z/Msp243QUYDJpdtUf1Ugheq1
 1n5E=
X-Google-Smtp-Source: AGHT+IF5FDVmjnrbq3VB+Dnx8pNIh45GXucg6M/RAbHbhmsxJBJSWAr6Y1zV7xi+5QL6bUk2+nylzg==
X-Received: by 2002:a05:6870:8a23:b0:22a:3226:b10a with SMTP id
 586e51a60fabf-250ffb4b591mr1754908fac.17.1717551464690; 
 Tue, 04 Jun 2024 18:37:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2508522515asm3660485fac.43.2024.06.04.18.37.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:37:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] spl: nvme: Make this depend on SPL_BLK
Date: Tue,  4 Jun 2024 19:37:41 -0600
Message-Id: <20240605013742.576403-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013742.576403-1-trini@konsulko.com>
References: <20240605013742.576403-1-trini@konsulko.com>
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

As this is an SPL related driver, and in SPL enabling SPL_BLK is
optional, make this depend on the correct symbol.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc12..80c80d9904fd 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1293,7 +1293,7 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
 
 config SPL_NVME
 	bool "NVM Express device support"
-	depends on BLK
+	depends on SPL_BLK
 	select FS_LOADER
 	select SPL_BLK_FS
 	help
-- 
2.34.1

