Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C0DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3220680FE2;
	Wed, 26 Feb 2025 21:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SD231Sw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09B180FF2; Wed, 26 Feb 2025 21:31:25 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FE481110
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e660740061so2755516d6.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601881; x=1741206681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0BTSyP9gp0DMqN8PhtjTGiWIGmpiysmcXFMlNqBBhy8=;
 b=SD231Sw2cUto/KP++pDWYbCrS4xSEcnIGZEyc0BoJqNrWoaLQTHpmpasjJDBjjskmX
 MXgy1QgXF6oCn4FTsyLo7n6ZHN3s86Y8u3Ws6tBSB9XDKrLi1e7YGmLbnIcoELRDZAqH
 XRtjNuaLT26XNOgNEDM6TZMP9QrzAk3TrboXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601881; x=1741206681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BTSyP9gp0DMqN8PhtjTGiWIGmpiysmcXFMlNqBBhy8=;
 b=VrkG6nonXvjE3YHVHTPn3KpVCSFvzEWAEqkPQMUnHcFVbrnU09byz/Qz9Mt3qFxdJ7
 p8Ccg3EvC63OtugL2Y2KXmcPSRrGCt5EECi3M0UUs0Obv8tcNyvRMy6zPZ1+XeT+Tkqe
 d4Tfd54PNvWSALo5LaoPNwz5oRAX5HHAiCo8RYWQS7c7zHtrgjQdFNEMJFJ4qyvesh0T
 Jc4rWQVvRH1JMLIe+9RhR1TtHfYu/hSayK+fisPQ2HLY1L+nLYKfPaVWPOYlkvwZyqqv
 mzPgajDhAeReFqS5PYHaw4+fVg0pZMci8GNlBoElh4Q8yqxWcdh1YuJSZFvZppUX4mQE
 uQsA==
X-Gm-Message-State: AOJu0Yz+dQXBks+aIhOSj6elpEdAEMreyilLep9qP4+89EJv5V+Fw7xx
 YDRhYHmQ6OB+oLb6Rsi6HWRLvC/nL/dqEIs1x0SZGgZIpyGkvBlEDt2+t5/zykcllcfgn7eTIKm
 I
X-Gm-Gg: ASbGnct6HV+deB/YPiJyp4JLLpSFV3dfqzipyFOtA4ivS/IqKATjN7bQB/HPDu4wFlN
 CLYbjw3+UUDiKF9pB/6HslFQ9y6/Rk89iEanN5iMYKEs7DEjlFkxsUSTC/dCzsPLGW0WfJDvMu6
 ubgYg2pa0E9r5XpW9gmc914W4LHvETowZPG0l85zFE8UurQ4tI83ouco4Vc70vzoJskctrdsYDE
 jZsQT2KLMfT0Xnf7ok8txzAzfPaEZtCT9vKBkwWOCzM00iJ3c+U9RK3uqGYbieHueUtBgc/g9AY
 876bKIQmtB7+gxyuAoLQr/LAwG4=
X-Google-Smtp-Source: AGHT+IFk2rekfVGHInYwWbz0yKdfqQBfkf4LpB4K6C7bjeP4CgBIVidvvWqxA42c1Gu+/dZLY/rWPw==
X-Received: by 2002:a05:6214:19ec:b0:6e6:61a5:aa4c with SMTP id
 6a1803df08f44-6e8868fd68amr74598676d6.31.1740601881452; 
 Wed, 26 Feb 2025 12:31:21 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fee9b8asm900685a.16.2025.02.26.12.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>,
	Stefan Roese <sr@denx.de>
Subject: [PATCH] cmd: mvebu/bubt: Correct usage of IS_ENABLED() macro
Date: Wed, 26 Feb 2025 14:31:18 -0600
Message-ID: <20250226203118.3831940-1-trini@konsulko.com>
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

This file was using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Stefan Roese <sr@denx.de>

This does change how some platforms are built.
---
 cmd/mvebu/bubt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index 5e4ffc40d729..6b7d9ee061d5 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -931,7 +931,7 @@ static int check_image_header(void)
 	size = le32_to_cpu(hdr->blocksize);
 
 	if (hdr->blockid == 0x78) { /* SATA id */
-		struct blk_desc *blk_dev = IS_ENABLED(BLK) ? blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0) : NULL;
+		struct blk_desc *blk_dev = IS_ENABLED(CONFIG_BLK) ? blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0) : NULL;
 		unsigned long blksz = blk_dev ? blk_dev->blksz : 512;
 		offset *= blksz;
 	}
-- 
2.43.0

