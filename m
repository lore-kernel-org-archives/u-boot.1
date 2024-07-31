Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37AEC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EEEB88AC1;
	Wed, 31 Jul 2024 19:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YZJDaLN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953E888AC2; Wed, 31 Jul 2024 19:35:08 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7E68841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a1e31bc183so190575785a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447305; x=1723052105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5Ji7Y3hg96eTr/5N8nEqvWN0Enm/l8CGJ8/109TZX4=;
 b=YZJDaLN/E1qqE6BajA8AMWlyXFm12KsT9qDtszCYlplP9w+X4o3YIrY4WjQ37f41Vr
 RmxYawdfoQ+zIcwL27YDZToPqs0M5aYDc6nMGJNKVr7pjGDQpVUCeNJfp0EYtuA6PHR7
 tcN2aG7EaH0IYuO4dswmaxj4e9t8N636343Ts6vQybZXT0YyQRkcUwvdIZlPABGxP2+8
 W3IgmzII+zp8zjmcCnZ2HAYUCQrxQX2m82RKfPZ7lzof54w0QnH52swGKCizwPB+JClJ
 qxeUjWnzK8toupYUdAphflT4DasTyOTlHqQJ6uWkWmw1tqAt65TgbdTgxtLUwXCt3ldK
 VGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447305; x=1723052105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5Ji7Y3hg96eTr/5N8nEqvWN0Enm/l8CGJ8/109TZX4=;
 b=nA7Ef1qZsXIV0flJ/wg8sEj4iKCuOmdZtJlR5HCZR4IJiYhuYOokbkeyFkFKjrl8ZC
 /H0UGXIZwirV7/j8OI4wJp0NzUyvin9+WUAN5Z4tQc5pFuYGQuDzpKy9h/aWPO7q1qK8
 eckUMhqBwul0OecVnAySqQ4IIcSxH/j9iySmsDPZgksRheQVLFBkKninKW7uS7et1IyX
 gA3UQO/YEsD7e9oPrTkGJY8UfYN6oIG0caO2qin4VamGfsYpwpTp9JFoXRS/V82NjDWr
 96lpigqchaft2DeYTBM4FwN5B9y3Pn6873tAocK5/fFGBFztmUj9QDLoYjeLlYYCpVF8
 02mg==
X-Gm-Message-State: AOJu0YwSfYjff9k/Mby9HGvnRPWlZXU9ykIwVhr3Y16t+tKdetoiEM4w
 wcjIPPaAKALPIMZSn6cEy+EiWWZAW2qKL4jQM62nfty5Hq/m742vwm/TmfVTuWGt6HjalR/EqpR
 GeRQ=
X-Google-Smtp-Source: AGHT+IHvgg6cB3tvnlNxNXokoyWfvY1nh4AFVUqPWMg0eDTUXbQxS05OlxoUAAUKMsHs40+DNRaeFA==
X-Received: by 2002:a05:620a:40c4:b0:79d:7e72:c7cf with SMTP id
 af79cd13be357-7a1e53196d9mr2048703485a.70.1722447304890; 
 Wed, 31 Jul 2024 10:35:04 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:35:04 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v5 24/27] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Wed, 31 Jul 2024 10:25:34 -0700
Message-Id: <20240731172556.1348487-25-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- None.

 lib/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 3caa45dc2a8..72b413d85a9 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
 #
 # RSA public key parser
 #
-obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += rsa_public_key.o
+obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_LEGACY) += rsa_public_key.o
 rsa_public_key-y := \
 	rsapubkey.asn1.o \
 	rsa_helper.o
-- 
2.25.1

