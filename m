Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9D1C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D16183020;
	Tue, 12 Aug 2025 19:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBzzc/bI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB0A8307F; Tue, 12 Aug 2025 19:59:14 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C2F82AFC
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7430e1fffe1so4165128a34.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755021551; x=1755626351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cumotT2JZ4zmWl2jnEiFSqSMv5qA/qDohHZI/foM5as=;
 b=oBzzc/bIb7NLvzmPnEf2KCXiAktRddn/WN2JIRsLziWomtoxlO0fnJJ0XKhjapZo53
 6owJea+nMbgwI0Nr43W4Yx/yzwW3cXxLds4KPHkCo3biUCxFUQ0JvQ1Io4v/4EMQY+mb
 pH9+JnkmE6KUZA8eQ6ftsIUKUV74DlRvP0NVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755021551; x=1755626351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cumotT2JZ4zmWl2jnEiFSqSMv5qA/qDohHZI/foM5as=;
 b=lKJR0/uqUfj4PlP6aKvPksyLN5eracFQvx91H2zMQQ2CNYPtXmWfC+nadd3vIuNUvf
 c6SwwDIH1d+c1UL0vhQyIZ8QrxWvUr2U3HJnd22gWxBnC2hEAVOpSdIjYYTYowS6C7+w
 duJn/bvnPbxPSRUMGVCvdbOjYtaRLzAzwYjydB2WkZ+nXCwhyc+2X4CHPtZN9aRm4GhE
 NJNtv/6ITD2J8mLyubCXDtOdJjkLKb826QO2G0IN1evntYh84w7PA8KLfhZ+ZaJwq4Ji
 S7Bp15pJVHvd65uRY0wIYRUnPnBNGlAaSlD1dCKYNTOqidQrqWOW/PMOb8IofdFHiZdK
 L45w==
X-Gm-Message-State: AOJu0YyhwybrgHwrbvwRvVQzHpOkoM75lhzeYuXgOSve4AEWYtL5/ktA
 LHy43vc/QtUw92b3nHbiGd9F9bNlknjr7FgECAOk9BlXp2139G6k7G3DeVTRExye1r4WuIkde1N
 Wz/7rHjE=
X-Gm-Gg: ASbGncs3vUWO4UKM++LPD3AgqMyWmEN67zJya52FH9Xs7bOnoNHav5hi8/Vb7lfB7yW
 4vF8hqQipdsS3816wpUJCjXtHrcrD8MyhLZ7EWg8La2YXgUQnLX/3hqYjtoBI6MdBToMj/sJfdn
 CUN+jrdrzehWJrNXFxeghb33LBSkkSrHBG7pQp/lqL4zC9WOl+4j9coN1d3ieoWpTN00xhbzbg+
 gZeA0WMo6vlgGqh6IxyRARJWvQ6zqHKobZLWweCKM4RMy0PSUgtIV8f4XQ2/MGjW3aWWVw6pr9o
 qaTAGGHVFBwsXoTh6/ly6+T+twNZceg3jUk4+04ABOvNOEZhQDw80o5bW8YqrEd8UW3tOL6Oil+
 epsOmkHUJnr134Lz5Ba1QfUIQ6cljMZMP+gSKui9cBLduu9dZPLWZUy0DY0o=
X-Google-Smtp-Source: AGHT+IEgz8vaDrQywy9C+za/X8+Ilnpq5c27j9vdCsYjLA97ATM7tv29D5DxNnHwjqeR4EtGNSVdmw==
X-Received: by 2002:a05:6830:4101:b0:743:152a:114c with SMTP id
 46e09a7af769-743754a8108mr174904a34.13.1755021550662; 
 Tue, 12 Aug 2025 10:59:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f87a162sm353684a34.17.2025.08.12.10.59.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:59:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] sandbox: Improve dummy local_irq_save implementation
Date: Tue, 12 Aug 2025 11:59:07 -0600
Message-ID: <20250812175908.3057051-1-trini@konsulko.com>
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

Normally, local_save_flags is used as part of the local_irq_* macros, so
remove that as it's unused. Make local_irq_save do something to the
passed variable so that it won't trigger unused variable warnings later.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/system.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/system.h b/arch/sandbox/include/asm/system.h
index 7933b6292e21..73f34683b275 100644
--- a/arch/sandbox/include/asm/system.h
+++ b/arch/sandbox/include/asm/system.h
@@ -7,10 +7,9 @@
 #define __ASM_SANDBOX_SYSTEM_H
 
 /* Define this as nops for sandbox architecture */
-#define local_irq_save(x)
+#define local_irq_save(x)	do { (x) = 0; } while (0)
 #define local_irq_enable()
 #define local_irq_disable()
-#define local_save_flags(x)
 #define local_irq_restore(x)
 
 #endif
-- 
2.43.0

