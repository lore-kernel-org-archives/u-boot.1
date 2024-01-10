Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB4AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A7F87ABA;
	Wed, 10 Jan 2024 11:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="STtAJNGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D7787A7F; Wed, 10 Jan 2024 11:36:46 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0F187AD5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9cb95ddd1so1751819b3a.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704883000; x=1705487800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jjrQStR8mg01rea7SGpxXhx6+KLoAYg0dAdhNzxz5w=;
 b=STtAJNGbzkPG6dvBd8bG0jLVDKkFwODzB0Y0qxwcQjeveytbNy8WMYrlke4pVvdH1i
 zT23NJuXhvuMQjWMFdnU365QQSJhH+qAp1s7uDMSITx8/SQP7yhzaDUL4X9FxFq8bieR
 /ZJzfCYZgvovJJpNoqZhMoaduNyjfdOiWpQcEQ+htmx/Xu4Dj31fj0ohQAFtBkw+je22
 DcY25Wgn3AZOqnrrOr29jYTJBKAq9JiOH/GVTajUFBF7HsacUuRZYM10S8THb9iMETLa
 qNnKM42wLOr3mrO06wqhhpbv6poIzlzRg/iX2qBBCicAbY3CnF3feStTseXUGNpqmaU6
 tp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704883000; x=1705487800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jjrQStR8mg01rea7SGpxXhx6+KLoAYg0dAdhNzxz5w=;
 b=LqK/ytJXWN0nHlKZcU0AWJf4tKnYd4DNsqxKQcp2wDmN+0xuZPyAuLGMGYIGmJAlLG
 87kHyOSst5xmqSc3pAo7sTJ82sefyDZrxS+4QJcqIcuGXMi3SmB7i35Rs7vMOCMn5pPh
 zdPDzM42GdC2ARkhTIA2zQIqcI+xGGGS81VlVTd6d7+XvfYURR7t8OHf5hrh9btW+kqY
 sEgiuh01tpO+0KOOzdgT0iv4yskI7HlFBVXtz8Fv7KDE0gthGTDXSNEJZyw79zdsTod4
 Ny3fVXVDfiWrvo77GVE9479It5rbVgQFotTFyWpJ04X9Xzbyhg7Q+vB47qDDFaiFOlCw
 OPFw==
X-Gm-Message-State: AOJu0YyljVPz1/2as2MiDr3C7triSd6mNkwHS5nESNS5DRheoVCxgB46
 GgIV3ys6qBpBvimHVEG3Mh4zg+qGKODY3kQkdbwcFDhWWcM=
X-Google-Smtp-Source: AGHT+IFw0b4WpWns2ugIjhso7Di59KjpROnkAbXw5gptrKmYqPMluvHhA46Hz6yGGD7hCRf79adAIw==
X-Received: by 2002:a17:902:7841:b0:1d4:ebbc:227f with SMTP id
 e1-20020a170902784100b001d4ebbc227fmr438033pln.134.1704883000645; 
 Wed, 10 Jan 2024 02:36:40 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:36:40 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 04/11] Makefile: Allow upstream DT subtree to provide DT
 includes
Date: Wed, 10 Jan 2024 16:05:40 +0530
Message-Id: <20240110103547.719757-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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

Allow platforms to reuse DT headers and dtsi includes directly form
upstream DT subtree which will be frequently synced with Linux kernel.
This will further allow us to drop corresponding DT includes copy from
U-Boot tree.

Also, since the DT includes from upstream DT subtree are done after DT
includes from U-Boot tree, so it shouldn't cause any conflicts.

Tested-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 69cffb16ee2..d4e65ffe49f 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,8 @@ UBOOTINCLUDE    := \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
-	-include $(srctree)/include/linux/kconfig.h
+	-include $(srctree)/include/linux/kconfig.h \
+	-I$(srctree)/dts/upstream/include
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fe2a0aadc41..fbcaf335f9a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,12 +189,17 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 
 # Modified for U-Boot
+upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
+	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
+	$(if (CONFIG_ARM64), \
+		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
 		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
+		 $(upstream_dtsi_include)                                \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__
 
-- 
2.34.1

