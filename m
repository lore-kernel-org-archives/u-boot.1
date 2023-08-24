Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4EAC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041C786548;
	Thu, 24 Aug 2023 05:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mTg0ho5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E57886556; Thu, 24 Aug 2023 05:03:28 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B092E8647E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34cc0ad6f61so6523265ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846204; x=1693451004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjddVvdFs77/pMsPCKo1oYdAEWNyT7TeY47NjxkEpGs=;
 b=mTg0ho5cAPfSd+2dcysj9AduAsQAeaE631/qOa/c1J9tw35lF9+FyCTDyZrmIFhYsU
 QtjniPT3iWewwTMOEPoWwzE2w3CmaB3xailV2Fk8z0pQamchqiINYShIGHWsRFGcBLEX
 hGW1UU6zpcqap9feBVDy93P4Dw9kl/ULTR5w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846204; x=1693451004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjddVvdFs77/pMsPCKo1oYdAEWNyT7TeY47NjxkEpGs=;
 b=LDhrRpxHc8WiHdMotQ2FGEzchb2bgVwxuihh0wAMx8izyJwxqXxbBkHDWZKLF8q4S5
 QgXwr0Cp6DWc75S1YIO8VCaucCn+4hnLMY7tRlIAAm+uGsPUX7j6YJqlcK4ovawCQOsg
 +UJseekDM2WbvQK0xaDjwZ4sf2hkeSj1SYtJJv7qGFCM4dVecdAl7E34rKisZTVJPeWY
 1fRP6rs6HQQER2B0JsJ78ilh25XCQnj7KOtcnjIdrzqJrApMgkG30A9/rqN8i6Ggkr9g
 lpJDCFCKKtmFsuiZoguc9JmwCom7us5iFdOuAi+GUBGxu/5rnnHNU3sFqs+dd7EBZuc9
 mUeA==
X-Gm-Message-State: AOJu0YzBsGL/Tr/SRlyyCrNAfCxvN8sRyuwO0ZBvxcY26zKbuFVgFzlp
 CYCt+T/6WkU1JbxdEcwc3zHJW0yHOuvpUUOojaU=
X-Google-Smtp-Source: AGHT+IEcTYjja6uE5WTOCWbOv1jyV5/v7GT8ssNMJISIp+kzwz2n4LJWwAs6BUgHUrsbXWM3DinOKg==
X-Received: by 2002:a05:6e02:2142:b0:349:3896:d931 with SMTP id
 d2-20020a056e02214200b003493896d931mr5165601ilv.18.1692846204283; 
 Wed, 23 Aug 2023 20:03:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Walle <michael@walle.cc>
Subject: [PATCH 5/6] kontron_sl28: Use u-boot-update.bin instead of
 u-boot.update
Date: Wed, 23 Aug 2023 21:02:58 -0600
Message-ID: <20230824030304.1555547-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
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

A '.update' extension is not allowed anymore, so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi | 2 +-
 doc/board/kontron/sl28.rst                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
index 83750ab001b2..aacf181e2dd0 100644
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
@@ -64,7 +64,7 @@
 
 &binman {
 	u-boot-update {
-		filename = "u-boot.update";
+		filename = "u-boot-update.bin";
 
 		fit {
 			description = "FIT update image";
diff --git a/doc/board/kontron/sl28.rst b/doc/board/kontron/sl28.rst
index 44435d90c624..2cb8ec62be42 100644
--- a/doc/board/kontron/sl28.rst
+++ b/doc/board/kontron/sl28.rst
@@ -39,12 +39,12 @@ Update image
 ------------
 
 After the build finished, there will be an update image called
-u-boot.update. This can either be used in the DFU mode (which isn't
+u-boot-update.bin. This can either be used in the DFU mode (which isn't
 supported yet) or encapsulated in an EFI UpdateCapsule.
 
 To build the capsule use the following command
 
- $ tools/mkeficapsule -f u-boot.update -i 1 UpdateUboot
+ $ tools/mkeficapsule -f u-boot-update.bin -i 1 UpdateUboot
 
 Afterward you can copy this file to your ESP into the /EFI/UpdateCapsule/
 folder. On the next EFI boot this will automatically update your
-- 
2.42.0.rc1.204.g551eb34607-goog

