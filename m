Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A99C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBB188B31;
	Thu, 15 Aug 2024 22:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/ztCCT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A49688A82; Thu, 15 Aug 2024 22:25:48 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5E788B39
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so88009139f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753543; x=1724358343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=e/ztCCT9gnmV7kBqWCD+Q6xqjqt7CDkOD76TEdDbk9VWtdNp+4lzr9PGPvg4VmeE03
 U66NLrrISbm2xyW2i5kp0g5WYMfQ1fc3p+FnoV2xU0s54iff2EZo3BBFEtVToPXdKahm
 S1YxUla5lyR0+wyTBwjqGsVzqCDKnbp6CHSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753543; x=1724358343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=UKkkGGhXSiVyHlUMG7auf2qC9D2DiFT9A/nU+wDeOBz66dJ0JCLdCSqTU877iIHlMQ
 JyzCm8h/EqW/Y1T598STOfoi3g4sq3lF5E/PGY8537AMbRXmKOaFmNlpJEt4AL3PTl6j
 KnkZzRW5iz70pho2H5oSBhj339cyIuuY174CqjH7hLdYVQVJiHo+LlLZSZwLQ1Gz+y0K
 H/3eTeFgS2LBsnwgO6cd5JuFiu4Wpy6kt16+VpKqZ7lywaaXY3+gywwrQZOADX2gHJcA
 te8QxTa08kZ8R7VrnVWx7Jehk2/H+GQ6Ave0lje3Q8bcVdsudHwQp2QsSZWDqV86iNav
 aHlA==
X-Gm-Message-State: AOJu0Yz5gtUhbPzCUueRjr3KAg21ZFDt6D/VCfp6hWhmFT0H1pJIoXYq
 xnG1gYQrRIkpPaRLYFpbXtkAlouUWkuzkT1fI10efkEv1uvK1EBJbAcay+yJJ1tHUa5IgLIGUWt
 jIQ==
X-Google-Smtp-Source: AGHT+IHV/BQ/V3jkdlR+dBSw1padovx0nEsiDgFBg4IALGY2BGvLIrtZklVFamCmkUo/vEnABzAMSg==
X-Received: by 2002:a05:6e02:1521:b0:39b:968:85c4 with SMTP id
 e9e14a558f8ab-39d26d7a911mr12915695ab.26.1723753542651; 
 Thu, 15 Aug 2024 13:25:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/24] nvmxip: Drop the message on probe
Date: Thu, 15 Aug 2024 14:25:12 -0600
Message-Id: <20240815202535.767869-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

We should not need to announce this device. Drop the message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 254f04e0b99..58e8c3fb74b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -47,7 +47,8 @@ int nvmxip_probe(struct udevice *udev)
 		return ret;
 	}
 
-	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
+	log_debug("[%s]: the block device %s ready for use\n", udev->name,
+		  bdev_name);
 
 	return 0;
 }
-- 
2.34.1

