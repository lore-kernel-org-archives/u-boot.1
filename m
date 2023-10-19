Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA383CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C95487483;
	Thu, 19 Oct 2023 17:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tD0pu8uA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815A28743E; Thu, 19 Oct 2023 17:01:32 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C6B8743F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a8ee23f043so690287b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727687; x=1698332487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eXLlsoYApHoieHKD3N+QSEaG6l/MZ3Vt+BjQAeba0wk=;
 b=tD0pu8uAsB8wRxnoztN1OlVtmvM2YIvBOKQkTzQLfoq42uQ4M7c5q3umLSXF5ks2Wh
 Qmpd9iF4L4El812gNnAt6pHSzqEn41PGlHU+1DNeE6tLmMyDBO03id3yoNCx2hiBYC0U
 ZqR3xd+xZZ50aIG4PVgLS2r4LSFQBekgLDfPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727687; x=1698332487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXLlsoYApHoieHKD3N+QSEaG6l/MZ3Vt+BjQAeba0wk=;
 b=oNJnYjmwR6TEwZzOODfWGY9dRpIWn2OKPBR2SY2SgD7BkZxcbPlgW6kEOrxBTx1+GN
 1oJFqDvvfVdypJb88FpDg9Nfk0tBx3nYeij6D3RIoe8SSKY2OHf0Ok7DeEnJVzjcmHM7
 SQGCCN2i9ui4PuRI6QHoMYIfkeWJ8k26Qyt8Z5S/+xhKYfNKjXsLn+BqipVfgFk7C2ts
 urx9PWPCO4OEfCY7ci7fqoZJrxfT3SBWJw4ePe6AyG++4+INHU0PAFdWJlpZThp/Huj1
 BI/9Pdyq7rXIHKGuKfSHyQtOq9dmlMHUT+6qithZp5aJc3bLhO3aizBLrAKWE/Tk4xqP
 9NgA==
X-Gm-Message-State: AOJu0YwBHNePyWaGYgkGWoH3h7+t0qVFiKSFMOUh187+Rio47epf5Ai2
 jM9I1fYb6k5zwRpw/okOto1WvpGXtOT8BszayaTrOg==
X-Google-Smtp-Source: AGHT+IHHb5lvxYqzrhna46o/rO1CUfycRIoICwrFzh/buij5MYkic/PSc3kDfHl1BNcN/f+6E+51Iw==
X-Received: by 2002:a0d:db07:0:b0:5a7:b516:6eab with SMTP id
 d7-20020a0ddb07000000b005a7b5166eabmr2539726ywe.15.1697727687418; 
 Thu, 19 Oct 2023 08:01:27 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 18/24] bootmeth_script: Depend on CMDLINE
Date: Thu, 19 Oct 2023 11:00:59 -0400
Message-Id: <20231019150105.714407-18-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

As this particular bootmeth requires the command line and assorted
commands to function, make sure we have CMDLINE enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7c92e0974c5f..40a04f43ee3d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -543,7 +543,7 @@ config BOOTMETH_VBE
 
 config BOOTMETH_DISTRO
 	bool  # Options needed to boot any distro
-	select BOOTMETH_SCRIPT  # E.g. Armbian uses scripts
+	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
 	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
 	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
 	select BOOTMETH_EFILOADER if CMD_BOOTEFI # E.g. Ubuntu uses this
@@ -671,6 +671,7 @@ config BOOTMETH_SANDBOX
 config BOOTMETH_SCRIPT
 	bool "Bootdev support for U-Boot scripts"
 	default y if BOOTSTD_FULL
+	depends on CMDLINE
 	select HUSH_PARSER
 	help
 	  Enables support for booting a distro via a U-Boot script. This makes
-- 
2.34.1

