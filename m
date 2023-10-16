Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF4FCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65EF86EEC;
	Tue, 17 Oct 2023 00:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6qL9VZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693EE86ED1; Tue, 17 Oct 2023 00:30:12 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274F886EE3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77784edc2edso666785a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495384; x=1698100184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FNOnZKz8AHOE8ZOW2A8GIydjkGTqr1MK9I6Xc5nxKs=;
 b=n6qL9VZWFsLEEaz27nxv83Y2oypv2Amv3+9l9WO1ZPDo+h4aL0H0DnMQO7b5kPRou2
 lHVpXrSPqkbSDwX31LbQGyDPzRDVsWCdiSUl1BCTPgYbFavrj9xwC3m2v9sd55hPniDG
 cfson5+KMUlNeCXLmFouxZqY1qyWkhfi5duoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495384; x=1698100184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FNOnZKz8AHOE8ZOW2A8GIydjkGTqr1MK9I6Xc5nxKs=;
 b=sRTKzQcUQi6L8M+Xon9e6PH1ippnYCzzva86PUwsdceBlsSZCElbgPMmUofRM2ptsr
 CmiyR+Gsa2ny9B4CP94vjpAPIjS8ngAx+VYL4Iz+NzHlULN8RmThy2MAylg0a85dEoMC
 2YKkkhNNTbTmZn+Q7n3eEKlF+LtgbBgZx4rDLFqpPYElspjk4VQVGXIH2P3CAvG9jYuD
 qDxA22gRdV46iUu6cxpdBVcotuHoINKaNzlJUt3zOD+iAc5N4zD2EzvC5PfLUo0SO5NF
 vAfJ/ibg5iWwDRCjwcBiAD8yf69FPZcUhrPSZ7agAaoHdfVc4XT8eYkEClaIQkd2ONQw
 XdkA==
X-Gm-Message-State: AOJu0YybQIGUFr9+aMbi4BjdHF736gkcN+1GR5WVitWbeaYy9emz2rZ1
 ZUkGkM+17HBJV5r4ijrM0CLPBelFqX6zhwGn3zbULA==
X-Google-Smtp-Source: AGHT+IHI61ozuQnDjmOKsmh+hXKRACcin0u8SoJn8/ZTlfn5+jSi2W8ney3YdIzU+P8fZxiy1Kzv3A==
X-Received: by 2002:a05:6214:401:b0:66d:1e8f:bb8b with SMTP id
 z1-20020a056214040100b0066d1e8fbb8bmr882342qvx.32.1697495384769; 
 Mon, 16 Oct 2023 15:29:44 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/32] test: Make UNIT_TEST depend on CMDLINE
Date: Mon, 16 Oct 2023 16:27:56 -0600
Message-ID: <20231016222835.596572-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

This could be teased apart, perhaps with a test flag indicating that it
uses the command line. Leave that for later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Fix 'ut' typo

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
2.42.0.655.g421f12c284-goog

