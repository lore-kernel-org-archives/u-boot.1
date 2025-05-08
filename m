Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83F0C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 18:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F140882977;
	Thu,  8 May 2025 20:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KttmvP8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B01828C2; Thu,  8 May 2025 20:29:55 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABC48269F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 20:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30aa8a259e0so1329571a91.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746728992; x=1747333792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6he52Z48dId4MNa9CL18CL0VVi/W0xglJmfzIuj8l4=;
 b=KttmvP8lBYuJF1hlLVonpRgT6cYUJCEsqRFPY1XQM+u7X6L2JA54FvmD3yjTJ0fgEl
 yy/3H4ncCdHCUOhcc4NTJ8TaK6Xz+niyFprvjTD+hf4/pdqzBXB7iq/smpVhLtqmcsFx
 cbeFr9xg55zqLFEArAWs6Zm3vTGw4Np7oVhGkoozyH7DVVB3ugi9xZUzwb/B6XBsl3mB
 8VcGsTvDTga12sgBjD5D9f9emZRuTsZ1H3PZno148n+IkWUjcWkFiwJUEJXmPHbTcf/a
 Ffv6mwAWOLbnrKAym6O4pk8JXgsIhOO7wp2GBh9/suK6DBfleQTN5OIf8Hs58IexmRiE
 Z04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746728992; x=1747333792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6he52Z48dId4MNa9CL18CL0VVi/W0xglJmfzIuj8l4=;
 b=tJz6FxcwmLhqoYtDD/DhXAveuLxTGMDx8vw14EM/D351T8bbh7zwzGog5RKABVNDZa
 Bue5ZdHLTHKu7MkGgK6Xf1e1WGenR155lRFEkrOYW6bc13XgAzDXiJgRrIhePFUoQ+Bb
 fF67a5XqEiACvbnH3QY3JI8TYxSZxTHlyIF1au/wkBjKNzXMY+LTvc6ggGKOAe6jX8rY
 JZq/g6ZS4SgDbcnkpIP2BQ8672uQvOHJU6WdwjoLImFQj6hWZaOO74iIZKsSF7GdDPAq
 CQnknK86rEaRhJgDlAghb9tKZjoVMOBjeaUQDIOOdgG5rJ5Gz4r3i6iqcGHaPYHno8FZ
 pxFA==
X-Gm-Message-State: AOJu0YxFjlUbfGukuL+LCoLScxrBFyACyR6tRw+l9aLmftpyjyTtX5dn
 7+6bqUvxPVGdQFNw63Nn5q/0dkIXYsmHAWtSt6C3aZ/SPSH2bfzqTdG3pr2aHuo=
X-Gm-Gg: ASbGncsKf8aYG4Q73ldQSd6o3FVdi+hXDdXN4h3TxRj7akL4QVI8CX9wzbfufF7bcrS
 VBq8UMAHov76ryyw/l7VLY2ycMpDhZo+IAeDuBksrEYY5yYiU7FzLYTkEeH8gX76H9IE69oyrBb
 uPrpWpCazlgpWyNVlBuoqnUuNFHzUBktOPe+F0qgqeTgX1lKUEIw4Summs//71LSdC1Vm4M23HR
 ICXVYaEQ+uOSRPY2Vdxk5KqKNmgR5H8KeIXAsXJ+GksDviv3SdhWST/f2Xm+LjBF9eBuD78Cv0s
 +oQvnubMuBkpewkDf5WrAJQZyoO/YLMzWibaG2vXUxo2p1yX7sk+
X-Google-Smtp-Source: AGHT+IEg7yLPYRJHygBsRs8y/pj+6bZ8HR3/nIrY8f7PAN+p12Z2dXGKzx06eAqq8QqcJmbVf26Pjw==
X-Received: by 2002:a17:90b:1b4a:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-30c3d6442c9mr609663a91.23.1746728991625; 
 Thu, 08 May 2025 11:29:51 -0700 (PDT)
Received: from adriano.. ([186.175.203.217]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d56981sm2495031a91.28.2025.05.08.11.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 11:29:51 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/3] scripts/Makefile.lib: add PLATFORM_LIBS to efi linking
Date: Thu,  8 May 2025 14:30:32 -0400
Message-ID: <20250508183034.3439777-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250508183034.3439777-1-adriano.cordova@canonical.com>
References: <20250508183034.3439777-1-adriano.cordova@canonical.com>
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

Link .efi applications using libgcc

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

changes in v2:
    - Address the root of the problem. In v1 I was modifying
      printx in initrddump.efi not to generate __lshrdi3 instructions,
      but a better fix is to provide those instructions with libgcc

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 83fd5ff6c31..3a86cf375c3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -497,7 +497,7 @@ KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
 KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
 quiet_cmd_efi_ld = LD      $@
 cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
-		-shared -Bsymbolic -s $^ -o $@
+		-shared -Bsymbolic -s $^ $(PLATFORM_LIBS) -o $@
 
 EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
 
-- 
2.48.1

