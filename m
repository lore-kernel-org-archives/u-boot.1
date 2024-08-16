Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA2C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BF888A82;
	Fri, 16 Aug 2024 05:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FYFhbzPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F2A88AE8; Fri, 16 Aug 2024 05:49:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8733488AD4
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70942ebcc29so1129063a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780146; x=1724384946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBM0aTvT3Ha4DDzxhtiaNZknNFPOrNI1AXU/R+EOb8U=;
 b=FYFhbzPe+fgULHMwYsCvrLBHFyjO6VhexQcJ17P8Hh+Ppxq9tsgWCTVskbyZSv0Gqx
 sC6vGfs6UdMt+9/YUPPt0LRws3yM1w0QhTfKpdNN7UwPyxCaveqhQYAc0ampgJRz4gEJ
 toPJatqrkHT+Y0ekKajn2efnYqPRV0XnjR1hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780146; x=1724384946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBM0aTvT3Ha4DDzxhtiaNZknNFPOrNI1AXU/R+EOb8U=;
 b=iBwHHUso2mBnfkYvvpQbuW8ipNg6uf76FLysYAp/NC/bwhcGiK0gW4D/Eufz2pPmlY
 Ok7AHs6DlYQcKy13vph91Zb+tawzJGve+dNsQKh4gQ+w6oEY8zFNyxBSdjMqiC6RvtNV
 YdOp5KbNxUuZ+Hy3DKH8mA8XSpqaeis3bfG8EYQDU1DV6gl6ZDQx1EmFefjEAvnMuSx0
 kf9KOIdSDmhc9fKSE67xuItjKH7Qy1hNtaMxYqiHguHVs18OcjnbFAnv5EGxjkd1x++Z
 Jd2zzv/8gVzxb9BMiEsPiRge4i5Jkqj6YkIRy4DvIe033SpO0UBaqDEv0qRPA6tYMTlS
 C6SA==
X-Gm-Message-State: AOJu0Yx2RTdkGEsecwTdARbAIpea0v/gzGABL2XzSmurNRmXcATIIRw6
 kecpgdR662ntfqOEqKdfcrxXft+eSpyQj8BOkUieCAM0rYCBfVeoM1y90h6zZw4xjjOQPdFAkHQ
 zMWs=
X-Google-Smtp-Source: AGHT+IFzQR9LQuWTNnsgLxeScdyo2vCTx52iAg83n89AuvICgdS1MElzytN3kgrrhxXDZvN+51NjBg==
X-Received: by 2002:a05:6830:6088:b0:709:33b1:fc38 with SMTP id
 46e09a7af769-70cac8d59b7mr2168489a34.29.1723780146626; 
 Thu, 15 Aug 2024 20:49:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-236.totalplay.net. [189.203.97.236])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65af728sm550730a34.37.2024.08.15.20.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:49:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] test/overlay: Make this depend on SANDBOX
Date: Thu, 15 Aug 2024 21:49:03 -0600
Message-Id: <20240816034905.3541020-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

As the overlays are sandbox specific, mark the whole test as depending
on sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 test/overlay/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/overlay/Kconfig b/test/overlay/Kconfig
index a4f154415db2..881848968bb9 100644
--- a/test/overlay/Kconfig
+++ b/test/overlay/Kconfig
@@ -1,6 +1,6 @@
 config UT_OVERLAY
 	bool "Enable Device Tree Overlays Unit Tests"
-	depends on UNIT_TEST && OF_CONTROL
+	depends on UNIT_TEST && OF_CONTROL && SANDBOX
 	default y
 	select OF_LIBFDT_OVERLAY
 	help
-- 
2.34.1

