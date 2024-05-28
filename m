Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA57C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8B48852C;
	Tue, 28 May 2024 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I3/Vszt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 168F088578; Tue, 28 May 2024 16:18:13 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C18884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-794ab10d07aso36419485a.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905890; x=1717510690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8lEFZrxfeB3Ykqa16cfNu3YtuZ3QYMBcCmnl3dOm34=;
 b=I3/Vszt1jVcmrNlTSNBRAH0gRHc9NfbsS9jYy0ioYGZ5r2EHrGTuTRbD3IFpUMAGbd
 GEJ36ly5g+wuUUyard6fu12RqFFhIvDLOEnYfdUU76HwrBZHdTPKk0ASpMoFyNv43nSf
 Lg1CigJ9ewc3EYXw5ZQ/kD4WKwE91SwoGXFFu3/zez6mCb1omocUhepzjzVj6yi9kPBa
 Ip/x55DSaSf23jiqsDL7h0DFw0vOlF/DM3i/Gf0ZA/0M6nTWRSgaK9MxnnU/2YxQQyaT
 GDf7uiECjOr9pP22KBqV19740TCM8SpseOZn4rEuUxaZ/8ncSffsyxkbHh5sQqxcF5Sk
 ZWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905890; x=1717510690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8lEFZrxfeB3Ykqa16cfNu3YtuZ3QYMBcCmnl3dOm34=;
 b=a/WBP73J/gt0Nz+hvgE4zDSWUMuZaPcn1RH+OdwjUyTe78sFIYGCJVYefWdp9gEJ3q
 HNkZSQqP6F3z5yh4qBb0WpKrWSWSsz3wLr97onOu7v8iEk9kLWLi1Ytds4uoGwGDcEXW
 HR4dDMAwHvIz/83VzpqOkWdulJtIr/OGQdIJ5HtYKpZW/nmiQm0AMnirhB9iLPegpdPz
 JPvKeY91pYrVVkDdS0vt9cmUpzB/MWQsrHlmPNLeaygPV965BDQki1WexaRYGEG6sTEm
 W9mUE2Ct842PmECGX0C7bEHr1281IHgPqhwQUZIK7lFIe3uOzcDQKleew15UtzVnoW6E
 0ooA==
X-Gm-Message-State: AOJu0YyMHHg/gE1+6vDAWE5VBDSIxhgQ2PfaLh/FQRZJzjeQtebyFDYI
 52U3tFTpTVKHu5QGswp5/2aEZxmEUWco4oSuq+a/BA6CtzL0ykxJpjUTzVO4Vd/I/79lsgkcMwY
 b57U=
X-Google-Smtp-Source: AGHT+IEkTxDYJFO6dtibkS7bulq+/L0fgnEwTQviHcaITk73F4H58jRjnvt67Br+ZaFabQQL2cB/zA==
X-Received: by 2002:a05:620a:88f:b0:792:dd4c:a550 with SMTP id
 af79cd13be357-794ab1223e2mr1168098585a.71.1716905889673; 
 Tue, 28 May 2024 07:18:09 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:18:09 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 22/25] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Tue, 28 May 2024 07:09:33 -0700
Message-Id: <20240528140955.1960172-23-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for RSA helper,
here to adjust the makefile accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Update commit message.

 lib/crypto/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index e3232019df2..866a9a3f059 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -11,6 +11,7 @@ ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
 endif
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # RSA public key parser
 #
@@ -28,6 +29,7 @@ $(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h
 ifdef CONFIG_SPL_BUILD
 CFLAGS_rsa_helper.o += -I$(obj)
 endif
+endif
 
 ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
-- 
2.25.1

