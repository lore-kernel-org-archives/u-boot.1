Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47855C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A674788C13;
	Fri, 23 Aug 2024 22:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FHpJx9wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E436488C4A; Fri, 23 Aug 2024 22:48:49 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC41688BB8
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d31d16d39so8666975ab.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446124; x=1725050924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3NGysIURVfwegCzeA/xdhxgn3RIbBvvtjgVsniddSU=;
 b=FHpJx9wPIIgCM1a3ckM1Y3bXNu8e3pvhbJA1noRKKfPoX2raINT+jRx9HLe2wOVuRE
 DkKV2dGziGMMMUsmOev9HH7IFoyk8l9pHo5zCt/6zEtaQ9rvAgcwrAM0pJUOmfS44NXr
 UDy5b7W8w2GXbq9+V7osaBcuRqlsTlLHoV3iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446124; x=1725050924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3NGysIURVfwegCzeA/xdhxgn3RIbBvvtjgVsniddSU=;
 b=dMdfowJhZG6NlJ8D64WTNT0y5A9nEkorsAL0IO11UPxdyVcVicGWQLJVXNzplJRh90
 JV9vo2vrYscNh1HR8AeK0y0MnHpwhX13VKQ0yj9hJTLgcH+2I8S6CzPhaIXFzZbMjn60
 TQxR3OkEcBSfGilHJtGwlVGMbgnd5xMQDAfOuzln1FT6dtZhfGeBuNwrVaAXJX+qbiS/
 3oK6TfRgtxz+F6K33w+SMmHPJOlsnwDmYbZAfPw/myHmjACzS9lN7Lpk4nbY3a9MCHcp
 oFs4us6Gh+PcfEM/5BRgAPHuKMd8oLq+pm75mdSFeqYkyp8HQf+mM482qI+kh9P2CnLD
 VdQw==
X-Gm-Message-State: AOJu0YzLG8H6YqOlYjrGcyVrCtn+Fh4WatV+cHy7XWKflokeKBpuGQYB
 82/ZnTPCdgN/VIavOmJZfAtxE6B3L8toY3FXiU/DD3da21rS3AskWj6gLF1W5BHOpDH9CnR14ak
 =
X-Google-Smtp-Source: AGHT+IFLdOZU8Uf7KUWrCBrjcHGYislw7x1q6fWdDSNpF3mec46iR/P1dJ8ApenEqRibgxz6r0uL6Q==
X-Received: by 2002:a05:6e02:1b08:b0:39b:2aec:6729 with SMTP id
 e9e14a558f8ab-39e3c9848d4mr41415855ab.12.1724446124624; 
 Fri, 23 Aug 2024 13:48:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 7/8] env: Provide a work-around for unquoting fdtfile
Date: Fri, 23 Aug 2024 14:48:23 -0600
Message-Id: <20240823204824.443631-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

Some boards use a CONFIG option to specify the value of this variable.
This is normally handled by efi_get_distro_fdt_name() but in the case
of sunxi this does not work, since 'soc' is sunxi, but the files are
in the allwinner directory.

Provide a work-around for this particular case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile                  |  1 +
 doc/usage/environment.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 9a52cc8d0b4..2452a916244 100644
--- a/Makefile
+++ b/Makefile
@@ -1844,6 +1844,7 @@ quiet_cmd_gen_envp = ENVP    $@
 		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
+			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f2..eaebf61742a 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -87,6 +87,18 @@ settings. For example::
 
    #include <env/ti/mmc.env>
 
+Quotes are not supressed, for example::
+
+    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
+
+For this particular issue you can use DEFAULT_DEVICE_TREE instead::
+
+    fdtfile=DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile=sun7i-a20-pcduino3.dtb
+
+There is no general way to remove quotes.
+
 If CONFIG_ENV_SOURCE_FILE is empty and the default filename is not present, then
 the old-style C environment is used instead. See below.
 
-- 
2.34.1

