Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BF1C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E092587C7D;
	Fri,  2 Feb 2024 14:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GvYf9K70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B393C87C78; Fri,  2 Feb 2024 14:06:37 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7487387CE3
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d8dc0172d7so13712385ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879193; x=1707483993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZyRiozEVbTqo9oMcq8lbIwXjVNaeje4ktcNZtXFrQE=;
 b=GvYf9K70H+qTbcWIP121nwgMiEIvBcrPpk2xZYhr8pCVItPNQV/oCg6twTvVSD08r1
 j4ygAz5UDkHKPpOTvmDraSQgyzQYtZq4T8RbIVe3vqsbzRfzMm9syD2D8NZLn0JN+opl
 eNWhjWI5zzE1TER2+Vf4WStZKnouICk0KwA9Rsqb+9HVmJ46z9dzaSdZ263pcZVL9xUH
 LU2QaDUvYSJdC10M1W0Jbq8pDDdl4gu7g5gcC+mkNg712N1rE/JkEVCeMaBJhfrgMhLh
 26SBLQTbCv96p1mN4NyGJd9GR9d8Yp8lwCpc7SCEhAprEbZAKfB9PYTM2iTdtuADTlpP
 Ilmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879193; x=1707483993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZyRiozEVbTqo9oMcq8lbIwXjVNaeje4ktcNZtXFrQE=;
 b=u5lS7olEeXshAxzmbBxqceXdvBxTAQU5C6VvUL9lZB0GO4YYVZcGP334FfvkrhD4tp
 0js9R9BLxKqTsYaIIOX3W/QuFRHBsQM6bvsy/L9vNfLPb7YcmtwCNZP8W6Wi0MTwirRE
 qop+ANgLpcBuv8c6U7pa2DjbF1nQKeQRbJf6WZVl08sXX/a7EgXv5UB0RqYYH6xUNMzQ
 UTx133WZDej8mxqCyFEq9sjbmapIzbJAqWGHZjHKevIWIplkUTH4I4DLEA+u/6g6JdTz
 nVISxfIHbEOC9A40OV3CrC0is9poM8cBAAJRxGrCJmjIHb3LBVe0XD9UPQE++u7RlT+F
 Qj/w==
X-Gm-Message-State: AOJu0YzKQ95kRL5LPI5K3Bxr8hnJn0qA619qcIRhKboNXeTqZNMVhXkR
 F5BWTudUm2pZ30K1KwVPxwOdg0cJbZ4tvyqhJNA7UWvCyYUU+X3Cjm29Af0r75NN69EFFLGLvl7
 sBZQ=
X-Google-Smtp-Source: AGHT+IFDpffcil8J9/ZtT9GVdE/vF7HfGZrRnrcfg150z1qhn3zODJq3F0l6axgXbVsRA7/qj3vNIA==
X-Received: by 2002:a17:903:192:b0:1d9:46a4:117d with SMTP id
 z18-20020a170903019200b001d946a4117dmr8192321plg.30.1706879193494; 
 Fri, 02 Feb 2024 05:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXi0fm+FqzHl3LFcHTWX0TP7Z2vJCxh+u4cCKtgSOWuVDpQz+vsMKvCc+YzitlbQG3YiTwivsje1lVqfpURyyPbVrXXPkmIkIcP9aLu30OHpHyRceBOOCtDc/83UdJU0CqDKzlv7LwF1VvEP637OIMJUvAW3yV540Fz112nrgmRWJFZfuuOMsvQt0kSYFCmizOgdi9bM1pis2VSTLjCcRrvIn4+xiOxE10avcikXu6cth7hTiaxetAB0U3GI9V3ZLvfUiK4aEkAswJtlWakDY1w2PCuyDWaEFfC9wgW8IW8Ebr0IJvHTTYc/G6zZLTte48o3UpiDfnub1Jzah1t3N9grwbJr7YHAnuBTNfJAnRzQF9QC2i4a3JnSjbdBaOUyqTRB0Al4JE3pnJrXnJ2DHH1A1d6+5jamUKiAQFrEw9n62MB8en9TeQrIjJvOnlMXu3K+olu1+4kRDX8bgmFxLW0nwOR6zoXNE5oJ3NECHCGJWgkB4CMe9pll7BR2VGaTe7RGmWV+BSLhblyowByEcLtZ1Zk+aKIhtqIpfQC3ZCLhy9HJizWuDeVeJ5/ED2iUEz3bpLDvf0ELlut39aFNcTCHcgVNc/uE4y6aLg68BrhBFRZf+Y6TVUIgLwo5bG76Lv+9iP9d7ZkybokpcdTOwHmAx898etUxgXCE02PmdB+d3h+cHcEBJWoOD0WUWcZ0NEuMdyYNacsJ5KZEU1TflfHA1/lVfJoKTNt3NYemdKpWqUPyY+WjnQbwtrR7XfKL0hsYOdG+c+j7C2koRs5xmqZS3DT1TzuRM7zQT5SeaF4Ygksa6ZG9E+HwHJBCaDuzwa1w9vtq8muctlgo83LR0eq2hVysrgsdrbzPk23Nvjf0cgUI57MA/sPTpRlEk9f9yL7G4d0IjW3wjglDOHPYsRQxKeOS94bws/G
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:06:33 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 04/11] Makefile: Allow upstream DT subtree to provide DT
 includes
Date: Fri,  2 Feb 2024 18:35:27 +0530
Message-Id: <20240202130534.1051438-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
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

Changes in v5:
- None

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c7e5e0384af3..996a43c8624a 100644
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
index fe2a0aadc417..fbcaf335f9aa 100644
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

