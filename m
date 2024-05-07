Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE3C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1371883AA;
	Tue,  7 May 2024 20:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fyRU6Tuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3095A883C3; Tue,  7 May 2024 20:01:45 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2538839D
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a04bb4f6d5so22121136d6.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104902; x=1715709702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IX822gL5mtLKrxcJrGoMxMIjUdgO51mL5aFKDNorxZk=;
 b=fyRU6TuoOwPfs5KrC6zve+4hwqgdSpln3geUEHRRK3kAIGW1cRwYZZhLiZeZZnzf/t
 wTTePdxk1O/nnq+3NrknvqPhnzN2hzHa5x4bMtxPovDuOi6ZnUSvkbOWyX9vtpn+A5FA
 6aePP1kohl+Wo9H95AasQarI9SrTXLRCuD8PCCov+cg693M2hRZaq85mlcYMpZs4ss+s
 tJwpYqBXBwJDrZWsfHgao9+SEd/+pqyd5ApQMA72ffrXsbUPmWY2Wm19ngSlr86QP+xe
 x6LhrWadA9CJ+Od5zQn3MHlrK4UGqWAtHWu2qfJxbHs42g+i8/PQfqutzA3BYyFrYNOz
 jm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104902; x=1715709702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IX822gL5mtLKrxcJrGoMxMIjUdgO51mL5aFKDNorxZk=;
 b=dk/uA4XdwToO81k7wjq9SKncxFS2QDIpR+qy1lpF2aK1+LGpyqfYaTENmfuq1t48Iu
 G6kbwgW6LSvtR66gX+qKu0XI0DdGDKOjDtYCB40jdnPAcnZ/1WS8lrKsP5nTpWE2VJaW
 ajucpGA59EFFNddC7rM0D7RkjCYeFrh0aOdYTxoF5Z1NkOpQIe4clU5ZI77VQWQBow7P
 /hZV11Dnr096NLkWykgWYgoAanGZ8la1hsmVz4BvXw15UoPlinOecwY9WbEfZSf297Jb
 XwkQLSe6Dn/RHIP13JrVgkwcqNjSqDZPq+6AFH9DAnwjhDSLDfuB8aHbAdfijUtLAcQp
 OiTA==
X-Gm-Message-State: AOJu0YyYd8k9OvayPJSfA/mOobrPczgm9IOByEkpWFLJlGqO4EsRV2fa
 PzXMFLOONNey6ED9ZBpNmaRe6xwLnCYJM/qK7wxY3YXkGNFJuIOXCWFc982TT8rPMnCnCb65XJe
 f
X-Google-Smtp-Source: AGHT+IHbw1FbczLTClWO4CONKx7O9YB13h/vFCE3X7S+zkm9+4A8UvtjYDwzjJpbjtyoPeDM641dGQ==
X-Received: by 2002:a05:6214:1c0a:b0:6a0:cfde:b8d with SMTP id
 6a1803df08f44-6a1514533cfmr6311296d6.25.1715104901704; 
 Tue, 07 May 2024 11:01:41 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:01:41 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 23/28] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Tue,  7 May 2024 10:51:05 -0700
Message-Id: <20240507175132.1456512-24-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Adapt mscode_parser to build with MbedTLS

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.

 include/crypto/mscode.h | 4 ++++
 lib/crypto/Makefile     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 551058b96e6..c214fc87e40 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -9,6 +9,10 @@
 #ifndef __UBOOT__
 #include <crypto/hash_info.h>
 #endif
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#include <external/mbedtls/include/mbedtls/oid.h>
+#endif
 
 struct pefile_context {
 #ifndef __UBOOT__
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index c3fe9c9d2c0..e3232019df2 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -62,6 +62,7 @@ $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
 endif
 obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # Signed PE binary-wrapped key handling
 #
@@ -73,3 +74,4 @@ mscode-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+endif
-- 
2.25.1

