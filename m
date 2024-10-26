Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD627D10BFA
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 14:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2F588EFD;
	Sat, 26 Oct 2024 16:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="km67rbZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A910C88F70; Sat, 26 Oct 2024 16:10:12 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DE988D13
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 16:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b154f71885so246357185a.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729951802; x=1730556602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bPRonHYAoKj12gUcnyYM4VwaIknItDn+GrTpaLQSGj4=;
 b=km67rbZ/5sdj/glIKV76NZWkc/gNw8tgd712AQHK64PRA8oHKd3KKOnt59y0kpXjxW
 nTfVBTESI4EDy+zDPQDoRQC1CQncl9Zf8uUeQuxStDKkE1QcO5MrRAVrddCKGd58RpiT
 l1ixQfxlFOWtCrr/Qnomweyziyxo0Dx9d+e7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729951802; x=1730556602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPRonHYAoKj12gUcnyYM4VwaIknItDn+GrTpaLQSGj4=;
 b=S0i9Vsxsu+xop7v5gSKrK2SRr/YqWrHZMooAphKwKzad4PKdYjIB1AbgMm/MzuccGP
 6p3IePlQo3MKEpF+4wQ9XPgk1wmgw1Q7COqfondeVHulChZ6fJ9JyhBaaX569+x3Tswv
 C19SS0o/eCulKHXzHpCxPMICqUK8ktME7MIXWiRahdA/fAF+2NN/opOVjffQGE5McEjS
 hUYJHaPyQQCOFqCMgJYLhf4xksKEFVA/BvJWE1a0EmvvvPoWFuL4iObwCQxm75j/OxLo
 6/GjFJR+fZO1pTdLno0dRD55bjjsvDcRnNdJ3TIs0ZYJHf55jddrI9CcfQWlktQX2syR
 gExw==
X-Gm-Message-State: AOJu0Yxa/jE5QVhWbGP8SwTMRsuweeBwczmEq0mDfNomzLWlWLykVa5b
 Tkq7lsPlEDcpquh/NPwJehNfllkVFur95A7HPZ63nalATxbaL3FwQagFchPKVR9Z7ibqEIYP+D6
 vb14=
X-Google-Smtp-Source: AGHT+IEKkGuYhM3cL+18OhBebg2qR/fSdpqqRiZUqLtE41tYbmMsCVfsPSQrJNRXpelKqnY81NNWgg==
X-Received: by 2002:a05:620a:46a1:b0:7b1:4e01:547c with SMTP id
 af79cd13be357-7b193efdec0mr428980485a.27.1729951802547; 
 Sat, 26 Oct 2024 07:10:02 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d2940f7sm155100085a.37.2024.10.26.07.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 07:10:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCHv2] Kconfig: Remove TARGET_TRICORDER references
Date: Sat, 26 Oct 2024 08:09:59 -0600
Message-ID: <20241026140959.1692717-1-trini@konsulko.com>
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

These were missed when removing the rest of the tricorder platform.

Fixes: d137604c20a4 ("arm: Remove tricorder board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Drop unrelated boot/Kconfig change noticed by Maciej W. Rozycki
---
 Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index a7b2b6db7425..eb55f2511d95 100644
--- a/Kconfig
+++ b/Kconfig
@@ -599,7 +599,6 @@ config SYS_HAS_SRAM
 	bool
 	default y if TARGET_PIC32MZDASK
 	default y if TARGET_DEVKIT8000
-	default y if TARGET_TRICORDER
 	help
 	  Enable this to allow support for the on board SRAM.
 	  SRAM base address is controlled by CONFIG_SYS_SRAM_BASE.
@@ -609,14 +608,12 @@ config SYS_SRAM_BASE
 	hex
 	default 0x80000000 if TARGET_PIC32MZDASK
 	default 0x40200000 if TARGET_DEVKIT8000
-	default 0x40200000 if TARGET_TRICORDER
 	default 0x0
 
 config SYS_SRAM_SIZE
 	hex
 	default 0x00080000 if TARGET_PIC32MZDASK
 	default 0x10000 if TARGET_DEVKIT8000
-	default 0x10000 if TARGET_TRICORDER
 	default 0x0
 
 config SYS_MONITOR_LEN
-- 
2.43.0

