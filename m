Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC21D149C7
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 16:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CF188B55;
	Fri, 25 Oct 2024 18:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JXksK69+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256B288CF1; Fri, 25 Oct 2024 18:47:56 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE8B8857C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 18:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so21621385e9.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729874871; x=1730479671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z04G+ueuvLD6LWTSoWfYaSGpb2aq7pDtz1lWoNGITaQ=;
 b=JXksK69+xrZ70FO/ZSXDTmmlEv1/r9hAHGkI8KhQxeVsspCuJcPt6QumigvXDGUuZR
 zYnj9RsC+jrKpRhVN57egbTDJNxlygLYoWUw4HzPaXClwX9dDzgTrOJfITmf5rciKdQn
 7kG6sFriOiQ/RE7j5Mpc39ylMzxpBKhZVP8D9dUgUZxwD2h/hBA+PKE5e2/iEbPL0z86
 bHxS2r7QfmzZ/jDTNnNcgW8FSX6CmoluchrpWrAKq81vydcHmmtnDobgXf7dlPn57C0+
 9soPj+nWr8KwFEHIRBki9JrXCve+rulBmuxNl7xIkHZ8ire/YF5OB0LlT9cy9tbuyqaj
 BGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729874871; x=1730479671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z04G+ueuvLD6LWTSoWfYaSGpb2aq7pDtz1lWoNGITaQ=;
 b=b/6+ZEpu9jX9elvgHkpqul7BrcWV+DGBXfWn3YqS1RETqsBM4uW0ooAVRPLTRbbjlw
 y5jwzvU4RZK3qNlCoAwvcbuaJFqh/MD6msEm52N9WadN/K2/Zc18rsFUYa+VYMc7dncX
 wc7AgDvBd09rDlJtGZwOJlQmAHNi2HOD1iajkOpelfcZBt+wDfGPJxi4SAj1mD9NOpqA
 lARZn+g6vzluuoR0jJcZqtzhvJhMz6mMKEQFiBZQVtm78wZJHQ121prDjbDuV4zU+Agd
 DKEbaOOtjLtfOFIGO4i4XV/OnsvmO+5C2qxmP+IsB1Wtk9d27RxLDGtgXreoAKNMewXP
 FVJg==
X-Gm-Message-State: AOJu0Yz7Xj329NaAOOHZ6usG1kQJ+4fcNjsXvVIjROq4IhDXpe5206ws
 yBQ/h/RGaT9kCPZEwNVT1jxqASL96Q/OR/DOuI7gbjg8Eg1X8vyozfIE5BywCxfijeAgCQF7FKt
 gcuk=
X-Google-Smtp-Source: AGHT+IEejwxEakveO5S4lvhkvv9co/rwkBbUrgfAH8L+0X3PfduAO34TUG0MiY0LA+ehjl1+ShinoQ==
X-Received: by 2002:a05:600c:5011:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4318c6e0175mr50194175e9.6.1729874870707; 
 Fri, 25 Oct 2024 09:47:50 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:ee89:e818:eaa4:afa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b56facasm52678875e9.33.2024.10.25.09.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:47:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: efi_loader: Fix dependency for http test
Date: Fri, 25 Oct 2024 17:47:32 +0100
Message-Id: <20241025164732.73121-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
of BOOTEFI_HELLO_COMPILE but the dependency for
test_efi_helloworld_net_http was not updated and so is now incorrect
preventing the test from ever running. Fix it.

Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/py/tests/test_efi_loader.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 707b2c9e79..33434935fe 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -182,7 +182,7 @@ def test_efi_helloworld_net_tftp(u_boot_console):
     do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
 
 @pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('bootefi_hello_compile')
 @pytest.mark.buildconfigspec('cmd_wget')
 def test_efi_helloworld_net_http(u_boot_console):
     """Run the helloworld.efi binary via HTTP.
-- 
2.39.5

