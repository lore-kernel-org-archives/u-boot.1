Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65021099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26262840CC;
	Fri, 20 Mar 2026 21:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YkLatEdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF3A8407E; Fri, 20 Mar 2026 21:53:42 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE1D8394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7b685faeeso578185a34.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040019; x=1774644819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YM5IbFEDmEckgieY8b8dVwwCK+olFRSwojiE5OY031Y=;
 b=YkLatEdXYjb/N1UMr+UdhtJ8aKkeoe1+ambnSeI4VEWBW7FzVCRJeqfPOfpMbHJg+6
 PLw/5LYke0s6dBm5zLDxt12ceDQueYfEmkUfcwrNmcAZmRvzYY0AYYvk8rpuWVbyol4/
 aQz2tq8pyfz/MS/FIhsV/DCltTDwcRn9J/ZjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040019; x=1774644819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YM5IbFEDmEckgieY8b8dVwwCK+olFRSwojiE5OY031Y=;
 b=pRWPBeknDuaonlqiSKbruVCq08heG8slWCe9h9yOUN7WZL4vIpQ5SfOxWujY8eQ5RG
 9+k+J5Zxo4FDhQLcrBv7tUkowTtu8BZoMQdT6TkFz3F9MW40VCN8ZNkmVprCZwxnh4pe
 dJNz4lX04cAOWmZO5Q6713elsAx5l4k31rfoe0S3h0U/+7AaBgIl3AHhToF9S42MT0Nb
 drdTR14+wND1KMBP/4q22ByiDFP/vZsi/fDp1oCVXWYjMbhocbjrnF46A0XT+8YpZAtD
 P70aCNIR1HMGxv1aNYx25lvegWOTSrqCMBaFijytkgKYmSXgRG0Oxo9JpBbp7OcfQO5c
 tWrA==
X-Gm-Message-State: AOJu0Yw8j0gTsju8JTJYzpuyBN8D+soMr+/d8Rqy2hUJeGDhqswgwG4w
 a1b6WeLcKUm3aRzL9AjoHF+Kd+8AabJlkmR84lVFEn8JifBASnyfSzTeA0+f1rVAHeD3bNuCbet
 AqxK4LLA=
X-Gm-Gg: ATEYQzwV435oo9t0R99Sigsnn69JOtcIIWq8FVZv7Ic7tr/UjNny9qkxCz0OhDx4VFE
 EKk2rw8AtEEnmgjcb3JJlEI9QNXgiSKJywQCHSZhtF3/3eGGtoxnOC0RwSxoPhwiTcziDPc1llk
 7eEBVDO4yNO6Uz4hYEETHY0i08Lw+IzfqvO7Fglpt1UuTs+EPjQEgVdZOQbu7P07LOueHlS6Ocl
 amZRn5UnyUr26oPEwA2mRY0aqyPwegaq8jJiz9FN4EfsNEgBrSg5BYyIEk2N+ba+j66Op6yBC4d
 SC+34bp0mZxtO8lQwMCxv3hMpVVF5tQjBaeJz/+WFXZrzrZCxK5vr9mpEaysjAxUqXTqdf8H2by
 A47Sdg5WN8uUS/WsYf1TDriipKq7kp//eqgGGEXfqeIahU/VZHPEVNLPcJNmdKyFkAdwMx7UodC
 hyiLVHu6Q8DAhZnTTPVbto4Nlsho7trnareUcDO0YJtwvvUlkU0Gi/HaPKFCxHCVdE5CSnXTWzW
 gjOjx80fpBprvnqNkAfjtwKhpmIJj5VF8l0A2NoMYrX2oxmR/4=
X-Received: by 2002:a05:6830:82e4:b0:7d7:5d0b:3207 with SMTP id
 46e09a7af769-7d7eaed3364mr2544684a34.6.1774040019118; 
 Fri, 20 Mar 2026 13:53:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac56278sm3637517a34.12.2026.03.20.13.53.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] env: Correct dependency for ENV_IS_IN_NAND
Date: Fri, 20 Mar 2026 14:53:37 -0600
Message-ID: <20260320205337.3788774-1-trini@konsulko.com>
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

In order to have ENV_IS_IN_NAND be valid we must have MTD_RAW_NAND
enabled as a minumum, express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/env/Kconfig b/env/Kconfig
index 2feff0b382eb..5979f7faa996 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -259,6 +259,7 @@ config ENV_IS_IN_MMC
 config ENV_IS_IN_NAND
 	bool "Environment in a NAND device"
 	depends on !CHAIN_OF_TRUST
+	depends on MTD_RAW_NAND
 	help
 	  Define this if you have a NAND device which you want to use for the
 	  environment.
-- 
2.43.0

