Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAD7FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E5F88DB6;
	Sat, 14 Sep 2024 03:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IR/x6Rj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF9188706; Fri, 13 Sep 2024 18:07:45 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F19887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c34c2a7dc7so12686576d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243662; x=1726848462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoTAVipAo0mEXI3MQXkkxuCRKhffTcbZJ93dFF3lkhw=;
 b=IR/x6Rj43bptq+a4QQYCgwVbxFDVcHpk66aS7l+hgSyNerq8+3DX1oxQlZbkxeRg3q
 Y50EBDrJhpgoZBq8tszQ5yXQReMIqBF/qzDG9NhB0Cjs+tsEbEs2fI72X4IaHANVGcr4
 05MkkFcwy+6TliaYZpez7lVMb1GgQhqiZ20k70YNaSrDykn6b/OidUsgJ2Wk3TKev/SC
 GFebfZQejxVra2usdMbwK/6EV6iXuWBV44L51UzjQibE8E3GSB+jMEEzEZxsypkoEXpA
 TkVm4zp8fPwkb/R08Oxpq9Hay5iD+n+tYwJYMtz0lbecfsRR2Rq0EXUQ0gUU/XVHt8rA
 43og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243662; x=1726848462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoTAVipAo0mEXI3MQXkkxuCRKhffTcbZJ93dFF3lkhw=;
 b=ROOslUSUEgqjJcIdnnMly37bCjdLSiCwBuo/+WhOToNRsn7L3MZpKbkJTJhB7/AO75
 b3TOpmI9+Tt/h4vYvtqVRJKSKK6M799t3yosPZv3TjHJrXOXPN5ac6I/xhIkP4qOxBel
 0zMcREqQihxk8mi6MBXAB112iBXm/i2z3aqkjfwWO4ulpeyzL4PJ0lf4ltNuap1VVTZb
 iW9Pxqa8Xn3x1iXj/XTu4/Jzr43tjUdXtsrKFd5i5WAhHAiBzhMsE493IOKkyAbZpwfA
 VIfQQqUmBD+1cfi8WQ9jl/IHCdWO3eXlMfz2randNw0Rc6tQ0xcuIVTuR342fwLwHl+B
 kDkA==
X-Gm-Message-State: AOJu0YwvADNtTqBEtwT5B3o5JHkpj4aAafWBMCN4BrP9WhB4mABLH0gG
 gWQvx3dzyUrVycl9uiekYl0WCRcTJGZ3/B7tyHIshveSEC1q1Y0zcHi5Ryc1tm3sYq5puVnb1HS
 R
X-Google-Smtp-Source: AGHT+IGOJCZ/0cR5vS/Vs40lK1S8TNQg96uXrmVbML+wsuWHMmU1MEZuHF8r3MjQgmsbUqIMubvu6g==
X-Received: by 2002:a05:6214:5347:b0:6c5:60bd:2c8b with SMTP id
 6a1803df08f44-6c5735a1681mr98057186d6.49.1726243661668; 
 Fri, 13 Sep 2024 09:07:41 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:07:40 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 07/27] mbedtls: Enable smaller implementation for SHA256/512
Date: Fri, 13 Sep 2024 09:03:24 -0700
Message-Id: <20240913160408.2199558-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Smaller implementation for SHA256 and SHA512 helps to reduce the
ROM footprint though it has a certain impact on performance.
As a trade-off, enable it as a default config when MbedTLS is
enabled can reduce the target size significantly with acceptable
performace loss.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v6
- Initial patch
Changes in v7
- Fixed the config dependencies.

 lib/mbedtls/Kconfig              | 24 ++++++++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 12f8c965f5a..7ee1139568b 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -155,6 +155,18 @@ config SHA256_MBEDTLS
 	  This option enables support of hashing using SHA256 algorithm
 	  with MbedTLS crypto library.
 
+if SHA256_MBEDTLS
+
+config SHA256_SMALLER
+	bool "Enable SHA256 smaller implementation with MbedTLS crypto library"
+	depends on SHA256_MBEDTLS
+	default y if SHA256_MBEDTLS
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  smaller implementation with MbedTLS crypto library.
+
+endif
+
 config SHA512_MBEDTLS
 	bool "Enable SHA512 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA512
@@ -163,6 +175,18 @@ config SHA512_MBEDTLS
 	  This option enables support of hashing using SHA512 algorithm
 	  with MbedTLS crypto library.
 
+if SHA512_MBEDTLS
+
+config SHA512_SMALLER
+	bool "Enable SHA512 smaller implementation with MbedTLS crypto library"
+	depends on SHA512_MBEDTLS
+	default y if SHA512_MBEDTLS
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  smaller implementation with MbedTLS crypto library.
+
+endif
+
 config SHA384_MBEDTLS
 	bool "Enable SHA384 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA384
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index be619f5b838..47918e3f4a6 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -26,6 +26,9 @@
 #if CONFIG_IS_ENABLED(SHA256)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA256_C
+#if CONFIG_IS_ENABLED(SHA256_SMALLER)
+#define MBEDTLS_SHA256_SMALLER
+#endif
 #endif
 
 #if CONFIG_IS_ENABLED(SHA384)
@@ -36,6 +39,9 @@
 #if CONFIG_IS_ENABLED(SHA512)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA512_C
+#if CONFIG_IS_ENABLED(SHA512_SMALLER)
+#define MBEDTLS_SHA512_SMALLER
+#endif
 #endif
 
 #endif /* #if defined CONFIG_MBEDTLS_LIB_CRYPTO */
-- 
2.25.1

