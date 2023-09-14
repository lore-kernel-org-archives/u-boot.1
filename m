Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B6EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2378870A8;
	Thu, 14 Sep 2023 18:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CpKl5Ohv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2DC870AE; Thu, 14 Sep 2023 18:56:53 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20298709C
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792975085b2so39420339f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710610; x=1695315410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wG5xRic7D9V5KsHN3p/X8V7YYaCFw3+AKPjccZjBT5w=;
 b=CpKl5OhvSWSoZ3u+sRY2Smhp/oKcR3mQ8v9cI9uQD+W1lsQtkzFKFv4LGDP+aK6Kk5
 weOoErQZPEqdBgJeGa8EgiIOWO6Wi6BxUYOoKylctTuS2smQZ00uCGbq4U38qH+N8fpT
 G1BsWDZUdXAeA8kp8ygj0AfDOjuNmuOXJNCvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710610; x=1695315410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wG5xRic7D9V5KsHN3p/X8V7YYaCFw3+AKPjccZjBT5w=;
 b=oAuIK321DsHfVHqIDzPwaZmLU5rMf5Ex18dWnbZrJwG2h8p/r0t7CrtlWQdHzhiqYP
 WHwu8HN/HhL6/KL2SszUENwBcFo4WaIB8aI4HxGKuwWJexD4zcBiVWQL6LoxlmIk2vQH
 bA9jVTtKpGvO87DnJKrmytgrk7K9GG6nuzHx5mfFhT+Ka7WHbjd5l3WNVjW7LPdn3yd7
 6U3aND5quiAnhQg1nthhZMdd+UTGhqpdRfCqwvmSCnKJxdBd4v1u/KU1x3Yj7NptLcli
 XICBPlCuvUagPAZHyeKwvOWm/aVqKprV9msrVU+E8f0xDxvEJAbiogVvQ7kiBIVuLH/h
 zZ6g==
X-Gm-Message-State: AOJu0YxngC+zlnGAe1sgxHSdLrSRMMZqPA5yJA0xxCTcvnFmqtHpFAXN
 h0zDMP8Rpf1xBoUl0hH88fO8+9//Eq2eTwh2BmM=
X-Google-Smtp-Source: AGHT+IHi7P7/puKTprD2byquMMYVjUi6LtpnnVp4km7Eogf9BkB2y+akrCo7/cPjlqp5salpgJ/TfA==
X-Received: by 2002:a05:6602:2753:b0:785:d4f5:2225 with SMTP id
 b19-20020a056602275300b00785d4f52225mr6886226ioe.19.1694710610308; 
 Thu, 14 Sep 2023 09:56:50 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 19/21] boot: Join FDT_FIXUP_PARTITIONS with related options
Date: Thu, 14 Sep 2023 10:55:57 -0600
Message-ID: <20230914165615.1058529-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 8 ++++++++
 lib/Kconfig  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2dd05e2e166..a1592a74e62 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1475,6 +1475,14 @@ config OF_STDOUT_VIA_ALIAS
 	  incorrect when used with device tree as this option does not
 	  exist / should not be used.
 
+config FDT_FIXUP_PARTITIONS
+	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
+	depends on CMD_MTDPARTS
+	help
+	  Allow overwriting defined partitions in the device tree blob
+	  using partition info defined in the 'mtdparts' environment
+	  variable.
+
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index bfab2f3165a..eb2b1016182 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -953,15 +953,6 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
-config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on OF_LIBFDT
-	depends on CMD_MTDPARTS
-	help
-	  Allow overwriting defined partitions in the device tree blob
-	  using partition info defined in the 'mtdparts' environment
-	  variable.
-
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
-- 
2.42.0.459.ge4e396fd5e-goog

