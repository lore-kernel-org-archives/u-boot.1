Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFB8D0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BABF8909E;
	Sat, 26 Oct 2024 18:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSKPQh1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF24889021; Sat, 26 Oct 2024 17:52:51 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C0F88EA8
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c94c0bf354so428525a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957965; x=1730562765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCNNSdwcSUSGT02aTPF7tX1DBp0VSxyDY7Bf1Jmcumk=;
 b=YSKPQh1nC0jwwh351ac+Q+xOppjuR2bCXJMiYiY5DdwZ+grTsF93dq6aAcbSZNRr7E
 WVDD9kA+icy44VmR34yE3rwf48o0TXBsqAMoI6sjHjEN2bLIplxXW/Rm10TKkIBsEhMI
 ce80yQ7+GnKusqKb1thepqaFkcWDOssj305ABvIEIMrxSO7DVzncJ9+orjErATa2KrdS
 AK0J5e6x9dJETaEHwtCF+ZC7sjtWcnZSFUM+OlML/gnwbmuoMOTOiTjS/jWYHqoR0iJw
 e2YHWyN/tYkFy3G3NhXEg7IuooCPqO3QVnJLBir5V+1cefOFg2KvT4ujje1TQ7TlVMnZ
 1FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957965; x=1730562765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCNNSdwcSUSGT02aTPF7tX1DBp0VSxyDY7Bf1Jmcumk=;
 b=oJQMZwJSZMGutZAkpABaiyXH4Oi2bAx4aQgQUlJadir+FIl1cBNBMePUfUjVHPikjm
 lrmZnFnkYCkmsHxqEgRJ1C05zvoHd1t1CNqmhtr3O9c0DUfKNOy/1FJUWKm9vhkLQDQ9
 Ct7iqXMV9A+/GEu3Pjm/oqj1Srv27k6D7T7lzVpaO+tdgl8rY+60Jp5U99dS1O7zDif1
 n8Ut+F0LZXYB50Ie04rnnRytIaDLn/NA6XEuELWy5lrbLwrYglRdR9cbIGUcrZU2A56z
 VB0U37Zbx55NTNBXKBJSlwm64YZ8TG2rJArH2K4oEFPw2/Bd2nN4BSXbnCd52VWINexw
 PRbg==
X-Gm-Message-State: AOJu0Yx9X901ZCeSFHUc3JO9aUXhxk7uPXJOd1zaSFcTdp/47P31PjO6
 TgHIPjrguS5DIKZoHkfXDIZ/OSOmHaXxG3H0aM0tXfakThg9H6CSEbdfeQ==
X-Google-Smtp-Source: AGHT+IEtQbcrlkDd1AzNxzjXFhTtMbZvz0XPpWVxcSUFV9qsrvqPda6m69OtYnId6koQC6MD5/xK7Q==
X-Received: by 2002:a05:6402:3546:b0:5c5:bebb:5409 with SMTP id
 4fb4d7f45d1cf-5cbbf88efbemr978569a12.3.1729957965149; 
 Sat, 26 Oct 2024 08:52:45 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:44 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 09/11] ARM: socfpga: update function call to modern API
Date: Sat, 26 Oct 2024 15:52:18 +0000
Message-Id: <20241026155220.26300-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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

Remove arguments in the function call. The call's argument list differs
from its definition, which breaks compilation. The removed arguments are
obtained from device-tree declaration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/misc_arria10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index c442af0288..1e20f77773 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -214,8 +214,6 @@ int qspi_flash_software_reset(void)
 	/* Get the flash info */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
 
 	if (ret) {
-- 
2.25.1

