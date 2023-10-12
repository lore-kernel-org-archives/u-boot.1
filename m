Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BF1CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 05:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFA986E0E;
	Thu, 12 Oct 2023 07:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CGt41Tck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA0886E0B; Thu, 12 Oct 2023 07:33:37 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADF786E13
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-694f3444f94so457327b3a.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697088811; x=1697693611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=USp9ZiaqlqmZ7QzOzuM58XasadBRx+KZKC/rPBPErZ4=;
 b=CGt41TcketPyZ8lg7DFTMTASeQ7slqO0ce76vuNcZvMWKEAskHo9YW0skCAAmCXxwx
 tUO5TMCJdTnFgGCkgmPSKAiNLQsfQksKG2TFlizKr9xK6KkT42MlwtX0NL28iIUfCOX1
 Csq/Dl5+OXMH7JnQEXgsFsA0CdNC0brrafYorbvCUwYW2bzfD8i1NrfjyU9jEepr9ePk
 YRHUu4DkS7cY8DUJ6veojHIfgk4mbs9il2I3FqKYE5+5ltdlItcvdSTP7ZjrzEk6SLmD
 jDVyAkRW7ZXPxLfC4j4TqTYrcVlTOqn4cPyg5qaZzAy4FqdveYJ/kazQ9knasd/WOZws
 7mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697088811; x=1697693611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=USp9ZiaqlqmZ7QzOzuM58XasadBRx+KZKC/rPBPErZ4=;
 b=Dgp+pAiBmkKBR0fxZg6PAM5VwsB3caEbyU+CNdkmH5q2GJko7bFxyrVNqQv8W8QfGd
 mWJYRgg5PSgK1NoP9DyImdJLYYcpRKMdJVYtoYhk3QujAnA1cIRPY024EGZlfeHC5TMC
 6CV+A47XW42ce75L4xMlaG9LvurqT8dKm/TshF9RxbTz9V2kkUtw8ZZBaLiD14N63z10
 ed4KTWh3xaO1abOcGdu9ZiRfc4vnUNQpTMKvl8APBHJJG6My7t6loRzN6MXf3jpREBhH
 cNLJ3Wh6JiHY4npUNfdoSw7uqKLhVhOkxiUxU3BNNui1hfCKKZ3Og1WmdjQ2vW49D8J5
 PM5g==
X-Gm-Message-State: AOJu0YwoEp4kjP3tEofcvMVrfQ+Y9D6+8AwjnhoHUH0ppeofWFrVN1wy
 Dogd4VH1vtERAjjNrBQxuKOEoUKW1DANTyLGGyk=
X-Google-Smtp-Source: AGHT+IFRFIBkRcTQ9dZrs/ieKMe7L7ou7KLHgAuBYUg4jz+oWe8548DaLTfld+/++G/5N9nb19I5Rw==
X-Received: by 2002:a05:6a00:1687:b0:68a:5395:7aa5 with SMTP id
 k7-20020a056a00168700b0068a53957aa5mr26057553pfc.17.1697088810913; 
 Wed, 11 Oct 2023 22:33:30 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 n26-20020aa7905a000000b0068fc48fcaa8sm11040294pfo.155.2023.10.11.22.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 22:33:30 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] efi_loader: use well-known guid for auto-created boot option
Date: Thu, 12 Oct 2023 14:31:59 +0900
Message-Id: <20231012053200.2337061-1-masahisa.kojima@linaro.org>
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

The boot option automatically created by efibootmgr is identified
by the special guid appended in the optional data of boot option.
The same mechanism is implemented in the EDK II reference
implementation, it uses the different guid from the one currently
U-Boot uses.
The guid indicating auto-created boot option is not defined in the
UEFI specification, but some userspace tools such as 'efivar' package
are aware of the guid used in EDK II as auto-created boot option.

So let's use the same guid as EDK II reference implementation.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index c4207edc91..106006127b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -149,8 +149,8 @@ static inline efi_status_t efi_launch_capsules(void)
 
 /* GUID for the auto generated boot menu entry */
 #define EFICONFIG_AUTO_GENERATED_ENTRY_GUID \
-	EFI_GUID(0x38c1acc1, 0x9fc0, 0x41f0, \
-		 0xb9, 0x01, 0xfa, 0x74, 0xd6, 0xd6, 0xe4, 0xde)
+	EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
+		 0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
 
 /* Use internal device tree when starting UEFI application */
 #define EFI_FDT_USE_INTERNAL NULL
-- 
2.34.1

