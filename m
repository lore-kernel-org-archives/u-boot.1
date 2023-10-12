Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE8CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BF786E96;
	Thu, 12 Oct 2023 08:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FgzY/Zc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D16186CE8; Thu, 12 Oct 2023 08:56:54 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7709286E5D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5855333fbadso461247a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 23:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697093783; x=1697698583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4O78+epTmBEwoLqDoiRC47bimhIMWPl00lgZY2qyrk=;
 b=FgzY/Zc7k2u8Lt2EzmjGr4KwoVjfmPTAp1ZaZPjq8EhNS0c6We8Rzf3Jy9C9bCkd06
 OhiERBpz+8tQYNoyEhB98wsk5UxYRGG9+PMlK+CXCG6bhNksC7I4aC+TVKYizJ9Qw5qy
 CKaBg9hUgEY1sN5pIp8IAGvpduPLtj+0aw4+mDwfna0bHiRM8v+RZ6haXHsNNT2mkAkM
 l9d/fWjX/9XOdTuadkfq+9qnZV4VdiwB6m0WEOUz/AcBEE4n91UgYsuSmF88+SjLe9zC
 jAFHpgExwjEQEekMFnP6zhFkB/7swrYn7/1Qj5IjARSpBjvR1Elawb825Uy/enpIM4zd
 MAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093783; x=1697698583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4O78+epTmBEwoLqDoiRC47bimhIMWPl00lgZY2qyrk=;
 b=QdSMdNHADpo0OO7b4meOS/S454JaS4qJHuZ4qAhfg7JsXTBt/zhcsGGZLkR5OiIncF
 ZerBY7ndK560PhpVV6h2wD7PQJmMCvOqqBDmnp7HoAHMrbEJ3FzpjpE+hEPOyPyW5rQZ
 951xz+F62pFWGtvR3vVOPXp7JeGwu9ZyxWu5i9XSzWsmvDSZI5bjERsT4l8GyNc62Mym
 vqs+8bdw7WTvCGaP7sP9s00K+ZxPKpwCKCWIUoaSPbNwRO+PUo3jYDTAAaainYuuTBNQ
 al1BBLFPepu9384DC/NIpCYwVNch2ojhyrCRMoTqrpLPi21olDE6q0OtBCl998qasoaT
 aDig==
X-Gm-Message-State: AOJu0YzByXYRuqh9LKzs8CMbPNl2IEfIHMWhOaMErOtlAcw/ED6qGUbY
 0OflMk0DRvpHFj2i3oHsohABgmlQ3y4=
X-Google-Smtp-Source: AGHT+IFhL/KFA14W827tCyrv4V/eEky2bT3raN+PNTp5pawUHQxR55u5K8E9GrCA6DKishUYnt7gTQ==
X-Received: by 2002:a05:6a21:3d88:b0:171:a3e8:8c05 with SMTP id
 bj8-20020a056a213d8800b00171a3e88c05mr6631116pzc.53.1697093783568; 
 Wed, 11 Oct 2023 23:56:23 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170902c65300b001bc68602e54sm1096977pls.142.2023.10.11.23.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:56:23 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 4/4] configs: nuvoton: npcm8xx: disable
 CONFIG_SPI_FLASH_USE_4K_SECTORS
Date: Thu, 12 Oct 2023 14:53:23 +0800
Message-Id: <20231012065323.2709121-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
References: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
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

disable this config to improve flash program time

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
---
 configs/arbel_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 8c32b4b20d..6cfb5a7d32 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -58,6 +58,7 @@ CONFIG_MMC_SDHCI_NPCM=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.34.1

