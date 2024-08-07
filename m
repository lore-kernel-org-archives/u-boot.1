Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDCAC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0438288A8F;
	Thu,  8 Aug 2024 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMtsBikx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED32788A8F; Thu,  8 Aug 2024 00:48:13 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD13B888A4
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81fd520fe0dso13740239f.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070890; x=1723675690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GwW1MgVRdL18P+oBb6d+34N8TCGNjWnMhBQoRtZ77Q=;
 b=dMtsBikxx4bZ7RWVDyIGJayyZic55iZevZAC/5HG2oWJmhJjDZVcdXgo/AW9tggjzr
 kBV9LGb0ts0V1qzSwGBL81C0SkmwQpCLPLB8NSux2FI0CIJRqbkH8yEAdHT0cX3IO/Cr
 FCtPZAzTex05BfB6rrThGIuMFrV2nJ65jgGoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070890; x=1723675690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GwW1MgVRdL18P+oBb6d+34N8TCGNjWnMhBQoRtZ77Q=;
 b=Il/1mln40SETmR/QpCiasEI0t/+KDiM+He+ZQuXHuMiupLAXGHVzn//zNlb1JaE9JW
 pMo7LdztOZBAOLeOS+euyf1PCm3hPYe48sW19w18XqpRjnWdfk3Je8vu5N6634dSt+Nv
 xVm1uR1mU5FxTdmqheVRI55nV9OP67vo53pBSmWc333PdLtZ4q261vhDqq/RTHaC3aah
 zKair+WU+siId8aganRXIpLm2MYqfSYvr93rOTRtD9ubrDuKQP9hf7bPj1PwIRwJpRj2
 6RPbLqt6zAjpvD8mUXfdQpPR3e0z69Tq0gDJOyoZ+Bfn63v5Vw8LuXih/0a+QXB/G04g
 kRtg==
X-Gm-Message-State: AOJu0YxQEZp9KRJ1QVRZkEwK6jAsNccezsxBv01kCGnzi7gWiuuCwKZ1
 XdAqeaMBjopRK/51QQ+dSq0sPxBGgKo2jbUC+MYVxzEZJfbvcQAl5hUT97TO26bspwUMZqXHIgk
 =
X-Google-Smtp-Source: AGHT+IEeYlrY1fCyjVjZETAYKZE53M33GPLdTtLc+fkpDJVzX3saHOv1HPUWtCmP4c3iyuObHpGuzA==
X-Received: by 2002:a05:6e02:148f:b0:375:ae6b:9d92 with SMTP id
 e9e14a558f8ab-39b5eca8b00mr855705ab.12.1723070890351; 
 Wed, 07 Aug 2024 15:48:10 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/21] sandbox: Add ELF file to VPL u-boot.img
Date: Wed,  7 Aug 2024 16:47:25 -0600
Message-Id: <20240807224739.3858517-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

At present sandbox builds package up u-boot.bin in the .img file. This
cannot actually be executed, since it is not an ELF file.

For sandbox_vpl we want to be able to run the full boot flow.

Adjust the build rule for sandbox_vpl to package the ELF file and
thereby allow full testing of the sandbox transition from SPL to U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2861b4d1402..b35a472d9be 100644
--- a/Makefile
+++ b/Makefile
@@ -1473,8 +1473,10 @@ u-boot.bin.lzma: u-boot.bin FORCE
 u-boot-lzma.img: u-boot.bin.lzma FORCE
 	$(call if_changed,mkimage)
 
+fit_image := $(if $(CONFIG_SANDBOX_VPL),u-boot,u-boot-nodtb.bin)
+
 u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
-		$(if $(CONFIG_SPL_LOAD_FIT),u-boot-nodtb.bin \
+		$(if $(CONFIG_SPL_LOAD_FIT),$(fit_image) \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-- 
2.34.1

