Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32966CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2689C888B2;
	Fri,  4 Oct 2024 06:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jdteHBGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767C588D7F; Fri,  4 Oct 2024 00:04:23 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B2888E65
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4581e0ed0f2so20845041cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993060; x=1728597860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8InG811eKkOPHB8uyl0AASUpYOZA2KGrZ9I8lcvdh8o=;
 b=jdteHBGbW1W/b4mqUC/WnoBJKjC3TXVUZ8P3MmnxDv6/RBVXn3EtW8bCgVVKzZbbp6
 GwxRWWVX5zyibA7Ob3/1YCIQbfIXab8N5uM9RRbjC/eeTLaKXgJSeV71kkXzeEWbn+Mu
 P5lZsNoXyl6adHG8a3KaAwbhmqH6ioxiD2CyUabsOR2vWWD7KfamBTR54u+3WUh5ea60
 A0fv0Q3mRcn2RBW5kmV5GzQ7T7qjxlihqXEEWCQ2ny9eZ3QHpxcoGY8fmNu5OtcMn5Ks
 WZMpu69fBfms47GtYtg1/B+xw7W2MEL6H3OQXPGZPe7ucvDj7BVuWQksKyNN9PqoParj
 MacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993060; x=1728597860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8InG811eKkOPHB8uyl0AASUpYOZA2KGrZ9I8lcvdh8o=;
 b=RTOrCZJ9ZH9QrIAyRFPmTPb4dK/+UV3CdWmIIzXeXkaBuiv6CB6FJm3Iqy2Iwiri37
 VEDDAaFa2xsoaH5fyJp0bKa9tijA9Acesca7wgYXZeyAc/feXYN5h5RRrmh+4vxuhD7S
 jfOlynWXmTfxWgTwdP6OeV+oitPNlP32BSyEz8tjK8TbNbakXkzqHHS9kLXmoGAO66Pv
 kq9NOMr8A2ePVLBTSascOSO7KbdWjBCUZjRsKnRVDcY6Q72qKYk7gSn35w5T4vFB66ch
 F2tXLHbFvwusy5EfJDWD74RIZk4iUUrvM0CD2J1IMYzE8py0JQnHFMEKkG+2tOZvWfM8
 ix0A==
X-Gm-Message-State: AOJu0YzxbX/nj0kmnCVX4z/FeT0ZE70FXb+n0RXI17j5DX8s7sFnwhYk
 9Z9Wvs45zBqCGZceVdWDDF5ZgAWppalGK/7eGuDj8u7+1wUrFUju1wgwZwIXZ475Pjs09k0OG0n
 9
X-Google-Smtp-Source: AGHT+IGl4HHRKXPY+bjzKiBawtmZQmxQYCgHstWuEIuuDLfctQMaVQ1ym/xo95uq1dU8WEFUFnceEA==
X-Received: by 2002:ac8:6881:0:b0:45d:8e3c:288 with SMTP id
 d75a77b69052e-45d8e3c02e7mr57619251cf.28.1727993060075; 
 Thu, 03 Oct 2024 15:04:20 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:04:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 24/27] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Thu,  3 Oct 2024 14:50:37 -0700
Message-Id: <20241003215112.3103601-25-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

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

