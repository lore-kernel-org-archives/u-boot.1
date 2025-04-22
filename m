Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C1C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C684381273;
	Tue, 22 Apr 2025 14:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XywVUidR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536E18129F; Tue, 22 Apr 2025 05:08:39 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F2F81273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3847613b3a.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745291315; x=1745896115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=38QpkJ7tn3REqUn+narOmp9cLcOrI4xaUa9xwc6E5HY=;
 b=XywVUidRhS4rDIH+ybO44BKrKLX8lUQ7WwHiIHWuj3cuw01e9rzwgG7vYgHjOdIOIA
 iVEfuBj/J84vwCQViapOtaqg1gppYkQFqvHF2GqdTAL6kfAawwf11q12fsCL/P5K0nJL
 TYZ0lTtBaisqa/B8RbUyjEhAi7dFGb+dPv446DnFIiCkgUepuJt6GVGw6naVbRtuBWHt
 zJoPdrmNJQzq9cmLK4SL0udNEYV8nIjNOwJQzveuTUaEp1dYFjUdeXDgJENpZdzVKrb4
 yNJpUnTg7ODTqOxFLMDUcn+aSmY2J90vXXPdYrYSA6xJNFvOinJnUjOMjYF8aq8WHYHF
 clbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745291315; x=1745896115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38QpkJ7tn3REqUn+narOmp9cLcOrI4xaUa9xwc6E5HY=;
 b=oO0f+VskfU9mfU9kc+ApvKIJbLRHNtkQp4oNJrENMEm5dUwPB0uyXcd9Ff4q7DcPTg
 psCqQMmWNFnnRxgA35pEY2upS7KOcfAUgLzS2E9Arijw5QJ1bwpDbsI0gv6nnXpg78a1
 0i+x8TKYOMyau96x7HaI0Qg9Zh5L9hXiDIgIYWHmC+VssD0kScHIAihytP0a30KjuJ8L
 MMV3w0O9nCRrglPYfYwOH7LiahhqZJJ7JS42Un16YGYFW4b/bNJd992SdVLEf7UrNxEy
 Vd3zFEqK5Uh8Olg96dPNA/JdKIWNN735Z/0pJhv1VeqiBmiadbYC8Y3KVU7fvqGFkeKV
 n5aQ==
X-Gm-Message-State: AOJu0YzsT+knfN4EucKreGmt2cBlgsrg0I7x5BnpD2WH3L3HTtJdidIF
 i2qFflEe9fmx9GMGalGaFHwVP/lPhVb0/Jm8SIF3Clp/yEyHODDthpyOmA==
X-Gm-Gg: ASbGncufhQovDeVUSbM7DiwaUz0mq47DrMxIhZpWT+w+5lHqM8QOuYCs55a7MdvMAU7
 iig4BNsbjUKQtHaURFNulwsrTzVjosz1Pryl9/oiSQMS6YI/W7zK1mcUvHNS59WyH19eL1/WeNh
 zlfhVpxXRnjrG99GjwB+BKxDFpH6dXYLiN+3eI8epA4PeG4FDFQz9fcs5G3q5ed5YBHS1jgKfwn
 42p1/gbv278gpufkeMBUu6P19h7JnvHSLIc84IefUbZnGRQR5ZyU7StYYpDoFbEO/GG1PAHsXyt
 MDFn+W7DTcYJjIevj6zhCxmd4shnzut8fOy6dxsTB6q/rrh2vR/HMwlY5EtDbzBJhM27I56rIYX
 /qzo6KxEDb3RPoSz1pyKhjQ==
X-Google-Smtp-Source: AGHT+IF+xUlKnG+bJWWSO91Q4AyiOTpKUQLLvaYLWJqxc41rwr/YfEm6sjVy1LB5bY3xdwJUmOqj/Q==
X-Received: by 2002:a05:6a00:21c5:b0:736:5e28:cfba with SMTP id
 d2e1a72fcca58-73dc156a8d7mr18953417b3a.18.1745291315120; 
 Mon, 21 Apr 2025 20:08:35 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaad42fsm7409138b3a.121.2025.04.21.20.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 20:08:34 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com, casey.connolly@linaro.org
Subject: [PATCH] doc: arch: arm64: fix typos
Date: Tue, 22 Apr 2025 11:07:06 +0800
Message-Id: <20250422030706.30210-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Apr 2025 14:35:50 +0200
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

Fix typo from "recommened" to "recommended"

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/arch/arm64.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/arch/arm64.rst b/doc/arch/arm64.rst
index 19662be6fc6..d72200ffdb9 100644
--- a/doc/arch/arm64.rst
+++ b/doc/arch/arm64.rst
@@ -14,11 +14,11 @@ Notes
 -----
 
 1. U-Boot can run at any exception level it is entered in, it is
-   recommened to enter it in EL3 if U-Boot takes some responsibilities of a
+   recommended to enter it in EL3 if U-Boot takes some responsibilities of a
    classical firmware (like initial hardware setup, CPU errata workarounds
    or SMP bringup). U-Boot can be entered in EL2 when its main purpose is
    that of a boot loader. It can drop to lower exception levels before
-   entering the OS. For ARMv8-R it is recommened to enter at S-EL1, as for this
+   entering the OS. For ARMv8-R it is recommended to enter at S-EL1, as for this
    architecture there is no S-EL3.
 
 2. U-Boot for arm64 is compiled with AArch64-gcc. AArch64-gcc
-- 
2.34.1

