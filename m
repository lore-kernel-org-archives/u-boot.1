Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8121E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6349186F5D;
	Sun,  8 Oct 2023 01:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ibBi7uzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AC286EDF; Sun,  8 Oct 2023 01:13:54 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995D786EE8
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3514cddf90bso13351525ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720390; x=1697325190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v87TWASGNP2wMarCMkVkcxW+dmqGfpJkUrgfaIaeDY=;
 b=ibBi7uzogloKccnMQtxi9gxSaFv6W0beOYuHmq1el/C3okVOw8A0JI0KMWjGhGn0mY
 5KcpNdo13CKHnYAkpMdXlwkUHlxPrCeY34DvWgKv0crFh7Zc5jovNMutnWOwSW/hZuEw
 +gGLFrx8eWcQt2aIGiDfylaGXZQWUf2CQIy1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720390; x=1697325190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8v87TWASGNP2wMarCMkVkcxW+dmqGfpJkUrgfaIaeDY=;
 b=qMdmFmdfcQMQeH2kEbYd6bzRNlEcUQssoEIF0o2OwrPS85KG08GOq949PhU3QFCkJS
 SWfVQpwuLZLpdRM7rz00xcROs5vHa0F8zbxBd+kBPr8LZyeNhdSik0BuENPIh5nMIG2W
 VuNrfFe0yesESAacyFDJx75/lqWZJtBJTz1YPg6c76X3SHcLgUjMnV6YGQR/wIwh+k6f
 l+1/91jNBiIBPq8/9ieYNkuVyrXrhmn7zuiwKjKg3/LyJeMQx3ICfKPfYGoHtT5ygY1n
 gIMJTNDGdtKRKsXeuX4GK3TYg+f3M/TOQMHgorTq/46pC1ZCpxgQBJdZ1Oei1dVT5ZzK
 Akfg==
X-Gm-Message-State: AOJu0Yz5Qi75p7GcOqRTRYFmqbN2IkpF8qMHlnowbuR+abvlowfpK9Su
 9vE5g5WzUxMI2Rbv9gunLcsXPkWRbwrR4mPhLV4=
X-Google-Smtp-Source: AGHT+IGPI/LekKCc/0vJ5TKkFUCH6FGhnqOjCRLaedidRSI+6ySl+Nyn+cLQXBqKZ7kVHzrCnljuGQ==
X-Received: by 2002:a05:6e02:152e:b0:351:4b68:ec3a with SMTP id
 i14-20020a056e02152e00b003514b68ec3amr14700507ilu.9.1696720390012; 
 Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/27] test: Make UNIT_TEST depend on CMDLINE
Date: Sat,  7 Oct 2023 17:12:26 -0600
Message-ID: <20231007231255.277623-8-sjg@chromium.org>
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

Many tests make some use of the command line, so require it for all test
code.

This could be teased apart, perhaps with a test flag indicating that ut
uses the command line. Leave that for later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 830245b6f9a9..2b4036704f91 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -2,6 +2,7 @@ menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
+	depends on CMDLINE
 	help
 	  Select this to compile in unit tests for various parts of
 	  U-Boot. Test suites will be subcommands of the "ut" command.
-- 
2.42.0.609.gbb76f46606-goog

