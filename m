Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108BE95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D59D86F91;
	Sun,  8 Oct 2023 01:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AjnfOJgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE0086F04; Sun,  8 Oct 2023 01:14:58 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6FD86F14
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-352a1a0348fso13403305ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720402; x=1697325202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fWqYwC2ttubNGbxdtaZWKOcqhecCNc3AZkSP7ylyv0=;
 b=AjnfOJgMm7qatIP4E/OyZ4U15BMZ+Qr+H9G/lBumlRaBq94m/YW3AEEN9jhyS6cbge
 eRggLQvrOTsEr/p+WM8fUoTJ3Q4UEWFsD2bDqx713xQoZKQT0vMUfjsFu7EGzJLTzAZW
 p/nHHL5SbK9iSAPtGStXVmsa52oKRoNHwyCvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720402; x=1697325202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fWqYwC2ttubNGbxdtaZWKOcqhecCNc3AZkSP7ylyv0=;
 b=b7GjEMGmRr3VqXvoYj6Ny7ahUWUUshRdmfiDzMywb41Hw0DMppgK+1A55GkPIfX9My
 9eR2SyXUbiyK8Lp5WK4DjLSEIld3asqbbS1dmpLy3GmsoQKXMOfJHHbmoVfO6ULpgNlj
 OaqBXDbXSt1lSNoIMWkqA2iq+EQpZy+YIbz1qig9OdiMDaQoCQDU6NQhH8AN2mjdUJJ3
 MI2NZlvLWnrjsTlVP+TmtCv+ZeExYAgGiyeNfiRH2i3cqwpNAUrU+liL2lcQ3ZozoeLt
 47mPhlF+s0UCk/i8wtD2EZ++EIwZkdnOTrU2tf6jNSHh0S5V4bj4duJMMRs2HT576Wc+
 zz/g==
X-Gm-Message-State: AOJu0YyTlRBqySvibLoEH/tGfcKhibZgBZheYXvt1CnKrXvdinYwZPTE
 mo8Em5RJUzZQSt/WItOo4JpiioBEDHVXvP0T6yw=
X-Google-Smtp-Source: AGHT+IEax7CyQCyDBC9TfmTupyYJK6s210SMCVo6lRAYy1XO443NsBrGH89hXZKS8q5w3JCppv83/A==
X-Received: by 2002:a05:6e02:1061:b0:34f:d9db:66c4 with SMTP id
 q1-20020a056e02106100b0034fd9db66c4mr10788704ilj.30.1696720402123; 
 Sat, 07 Oct 2023 16:13:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/27] efi: Depend on CMDLINE for efi_loader
Date: Sat,  7 Oct 2023 17:12:41 -0600
Message-ID: <20231007231255.277623-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

This features currently requires the command line, so make this
explicit. Future work could adjust this, but it needs effort within
the booting support first, like the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 621ed5e5b0fb..2aef9336034e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -12,6 +12,7 @@ config EFI_LOADER
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on BLK
 	depends on !EFI_APP
+	depends on CMDLINE
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
-- 
2.42.0.609.gbb76f46606-goog

