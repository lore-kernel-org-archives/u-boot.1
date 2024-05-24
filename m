Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731ACC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB93C88283;
	Fri, 24 May 2024 13:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="EZG4325n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672718830C; Fri, 24 May 2024 13:57:09 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1458827A
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kristian.amlie@northern.tech
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e8a8ff4083so28989071fa.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1716551826; x=1717156626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c7sakWDb6krQFg7SBLwSqzRR6tLdHrIrhG4PS/CwqrE=;
 b=EZG4325nsolj0dCwVSGCXdVPMbYvbSCPNvxTorlLY7+D/nLh9lhHgYX/kcmGT2vagh
 pWeaAJU6BY43ns1alSmtIJQdAuPCyLOPPNIQhJDzlAQZkxBC+QAS5gcNbAHll8JwTPCD
 EXHQ8sDAwRf14B8DzQSsKC0Cu/mDjrbiPuBTOAPblNr486f03mvpGsj15hM7DfFxBsXj
 NdlFuHWrAdNTUImOxGa3g5v9O/neAn+pqdADhYKwEbHF5Ro3fjIXGsRS/27CAIRA/8m9
 TfPiIJOub0+a95rk9xaEVNyVR+lsJIfE52fsQmJeDIFXVVcT/TqJykv3je2qfQIspeGn
 bYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716551826; x=1717156626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7sakWDb6krQFg7SBLwSqzRR6tLdHrIrhG4PS/CwqrE=;
 b=i7TnAAzZ4fMkc8L8Io6QW5fneSQKvSwUQNJ+Jy+zplTrzLOEi6vpBdc+AuEW0zsoBF
 1j3U6jhwT0a1vOoWPr3isrpiHyfYDP7qIMakvmTzDsNgs4Oqpl9BBGeMAmspbJkCkyf7
 dQNSyN3bh5qka7GIiExTLtSruSyUiNClaWTe/gKNNewZSORk+uFlG/Jlust9kTx02jg1
 5+ZTHGCQ9LpY+wYvDu7yBkj9DMzWALd16WUqw5kdWNOI9oCnZAE9bKZuQp7/JhSi2xgN
 gTB2CgTPkYcFyBqDtEQh8XEnOZlKHgLD5wsekaDB464V2dRgMoZ0HaKnygrfnF1Ygp6P
 7q6g==
X-Gm-Message-State: AOJu0YwgmPWxMF0Y53ZjVniM/nk20KnwsMYMa08Npp+9KvCC000GbCuz
 1KA9eR1gs+xs6csXx4wjPQmTYbBVbwZd4mMlzuUMWYllUVvFQYmOxbR2JTU5AE5NPw2lV/wKs0t
 S2M4c+I8mQfcXKN7OF5ZJbz3dbrro3kFG4UzpPypnEydd8n1LVR7qeA==
X-Google-Smtp-Source: AGHT+IFIkFdq9pTeXmlH0XLVIoM6ifjCEL5h8/2iR782KEAkySsM2E7rvicm/zNk5SuVuox9UZjr4g==
X-Received: by 2002:a2e:2205:0:b0:2e9:58d9:6d8 with SMTP id
 38308e7fff4ca-2e958d90769mr8353101fa.7.1716551826488; 
 Fri, 24 May 2024 04:57:06 -0700 (PDT)
Received: from kristian-Mender-T460s.forskningsparken.no
 ([2a02:d140:c013:1837:18dd:629f:7a9d:453a])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-2e95bcd8e73sm1728231fa.45.2024.05.24.04.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 04:57:06 -0700 (PDT)
From: Kristian Amlie <kristian.amlie@northern.tech>
To: u-boot@lists.denx.de
Subject: [PATCH 1/1] Update maintainer for Versatile Express.
Date: Fri, 24 May 2024 13:57:05 +0200
Message-Id: <20240524115705.2816843-1-kristian.amlie@northern.tech>
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

Signed-off-by: Kristian Amlie <kristian.amlie@northern.tech>
---
 board/armltd/vexpress/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/armltd/vexpress/MAINTAINERS b/board/armltd/vexpress/MAINTAINERS
index 2b3e4916a5..7a54c6b560 100644
--- a/board/armltd/vexpress/MAINTAINERS
+++ b/board/armltd/vexpress/MAINTAINERS
@@ -1,5 +1,5 @@
 VERSATILE EXPRESS BOARDS
-M:	Kristian Amlie <kristian.amlie@northern.tech>
+M:	Josef Holzmayr <josef.holzmayr@northern.tech>
 S:	Maintained
 F:	board/armltd/vexpress/
 F:	include/configs/vexpress_ca9x4.h
-- 
2.34.1

