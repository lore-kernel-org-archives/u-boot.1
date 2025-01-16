Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E928C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8208022B;
	Thu, 16 Jan 2025 15:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FKFabRmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10668033D; Thu, 16 Jan 2025 15:06:31 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C7080214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A5343F689
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737036389;
 bh=LCzmVLCRrTIMST0mzHU6zicJkTmSCr2R8QMtWtZLSzY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FKFabRmZpsAIfv4KyiqN66gxZ3ZcYHY6QD5jzIAS+WCIE5+Zm2+cYrVFGzDrglu/j
 XzIMDiz9xJa6VneXAnKG5DnqsrwwERBfIlFLYHc0D5z+JOHt2r6Fw0L7cxFOMwmdzh
 zBG6wxZYj8on1afTKvLHuR5bj0a+1HhQ4w0g/xUYdrLoK5m0MecUMIZ4nipPIvrm64
 z3bjiks2FXR7AuNWPSAGcklljszbWLKykYRDDGrcmzgZTS08Uno3nSp5TnUY/e+SMo
 59ewGAHIR+UUspJWy2GwX7herybcEQkl4xAwxyYkxTLqUpu/IWR9XM7X+Qad8dPe8u
 bhPHxMCwr+XCQ==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d89a53fc46so1072542a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737036386; x=1737641186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LCzmVLCRrTIMST0mzHU6zicJkTmSCr2R8QMtWtZLSzY=;
 b=gopazsjF7oH/DNqdm82Ni9BvnMjJstbBtkcQnyEcY55KA3jvGsXOCeCkqIsRWw8ZtI
 83Va+tPaE66mr5HfQ7fL/8CsI1YozojS72AeMfso0MDDcM7SCuKjJmclk/gLtAo97gsV
 rpO2NVP4Gfrsioawi/nRtY6+tconoj602X7x9b2TkYTmOnK4v+FkMiYDXS2iGu7pmrpa
 wmC0P8cA9Flzd1RNRmNlEgO+AA4oIK0LPWVsqlEt5EuqaFERCRZc01c+io7KVPg1s9rm
 OwBmr8W2b5QJ5TdRxzApncZZKQQqmwTinUBkTTXb099+CwPJ97vlYhiELnNfGo1G/2R7
 35kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnJ2u8Bb0BFnWGN7fCzujBU9KRB1CFHjU3jyavTOQNlyzomtNl0GdzfHe4Q7M84msBd4GV+L4=@lists.denx.de
X-Gm-Message-State: AOJu0YwxJFc9wqfpCTwQDGpoj7vZti3Sp3nMgBx3xAx7+NprOjuwHY/l
 gQCdicUf+DPxA8UNhubygh0cF4js1m501FEceeoXKgquEuubNf13WhUC1zpnDbqMnsnF7ayC2uL
 oajkDUuHwyRoIR5cOK6VZZSoWGqvxL2lKMDlBCzGvYRPsD6Cm3UVbPFqqzNc0A0UVnBQ=
X-Gm-Gg: ASbGncuafuFPTDdFMSxtS3d2wD4c5a8XlfpFOhGR6uM0MCZWlHMEBELhsG8u8NC4vDq
 e+qa0IoeJNeDh2V0rFey2rXfk19PerkvUgDrJWsUgwqkN4F1XxiejFV/OynyrJTbIy3W/KpNcXV
 lhxOOuJ7nkDNT0B4WpHvmHmyi7yVVZYiozMOdokyH4oZEv2/WeKzRYV6whudpSpP1vZYdIDyyrj
 emWeiAwT/xoaccJdZDZ8G1IkVaZM+wNiqow2tr1MnPZGt9iB2NjhKgzAajU5LcxfJ2dpfOFbkJr
 0fXeZog89FYiOQ==
X-Received: by 2002:a05:6402:3225:b0:5d9:b8a:9e08 with SMTP id
 4fb4d7f45d1cf-5d972e1b768mr33084492a12.16.1737036386101; 
 Thu, 16 Jan 2025 06:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHItGM8qiflc3MRNyEsA5ZO23r9tFk41+bh8+U+Mijj+TuhDuKJadhq3KlQIz4J0shdTrlFXg==
X-Received: by 2002:a05:6402:3225:b0:5d9:b8a:9e08 with SMTP id
 4fb4d7f45d1cf-5d972e1b768mr33084410a12.16.1737036385525; 
 Thu, 16 Jan 2025 06:06:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c37csm9107652a12.6.2025.01.16.06.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:06:24 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Makefile: let clean remove capsule_in.capsule*.efi-capsule
Date: Thu, 16 Jan 2025 15:06:17 +0100
Message-ID: <20250116140617.248830-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Update the CLEAN_FILES list to remove capsule*.*.efi-capsule.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0500eb6e0a7..70d74e2e9a2 100644
--- a/Makefile
+++ b/Makefile
@@ -2218,7 +2218,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.47.1

