Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D0C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 23:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B4B833ED;
	Thu, 29 May 2025 01:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhyK7kji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C2083339; Thu, 29 May 2025 01:30:58 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8587C8338C
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 01:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c47631b4cso228856a34.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748475055; x=1749079855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YHeWu2jXHazUIwAm8gcidDqVwIhqppaR2bqB7ntMn4=;
 b=BhyK7kji5SCOQGrgsBLDeqfhqa1pbsx3beY/TzVwwInC3usi7LJvwTb/vB57jfsPYQ
 JDMmVRoeXmJsxMChG6S0RZZKRI4Iw6tv0hJm36FEPmKc+YyC6wBTDGwNd9ctKg+dNMG9
 2vhaEZCDPCINDeHgHAMCxpzIbvnrxrT5x6YlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748475055; x=1749079855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YHeWu2jXHazUIwAm8gcidDqVwIhqppaR2bqB7ntMn4=;
 b=CelrVruGLfIaavwE84sjSVoEaZxFCe7MdBTHW9peR6K/KcQUEKev+pSIKaXF5do1yp
 14x7RRQPYBjMn2UqHniYMfksmqooRi/USa64WVXAn2JXuJd/Mvu9YplItTC8NINnd9kf
 2V3VEPEQX+prNRS0kYV8+YRc1VQZvKbfZM0Aj0rJ407VOKPod13ICoLj2bE/hZRVx5jl
 US5AIVK+coq+1eEJ3IIHIpt+Uv3lXFjgPHgLTz/0kC0eHM5+EMKitWxKFyEgvKF94pxb
 SdyYmKYoAyMJvDnuOmEI9SS2CfJrp36P2xG76ds8fuZJbmYu6KMxqVj9MN4qrRfn4emq
 GecQ==
X-Gm-Message-State: AOJu0YxDuz08WZhyPlQ4cPhMNqVyhnvNTwc2cUgMVrVGqVncbUOA07R5
 2PyhELmeMtNLoxwqEwUWtS4rBc9/7vooXr4EQvHePViuV4GS4aQKuYa7Q72SMGyYQILxDrn8880
 4rjUvk6I=
X-Gm-Gg: ASbGncuaKoNEk/Xz0H5T/M7XhjhxnBTZ+yIBIyrfOD4IeTbNPqwc9qQPMfM2KUGY2JG
 +MJ+NdjHZAJXGWXT+1KazKZKgGQCqisHWyPMMZaYvQZUsv5sqrLEsQLr/2lmWaC1/zs21qEHO+J
 tptpp0DSL6v/bkc4q1+XukdaZouMpiYtHjv8zl8Dq+799xqoQcu7K3Q8u9PQeVBthGK+9qjm2Yo
 Wm+jld+6TqI4znn5c1p6TIza/TGsvCgHTXINhjJPZKmuPB0YysjsoXBAg8NQL1td2ROrJ7ofMTR
 8SFXElj1deklXkTiacuCUW67pnYr+FbtR45XcfkAE3fhMayMPETLonhK7H2nAnRcjxKByhXAP9C
 3+ZYBP/He9VQm4DM=
X-Google-Smtp-Source: AGHT+IFaEL4xbRiUONg3DEIzV+vr98fXzO6j/0Na7+jQisC6mou+d6y2VIYe+G4JHxsTJ2GQN8tO2g==
X-Received: by 2002:a05:6830:dc2:b0:72a:1e1a:e578 with SMTP id
 46e09a7af769-7355d150dcdmr10694348a34.19.1748475055288; 
 Wed, 28 May 2025 16:30:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9bc741sm58239a34.44.2025.05.28.16.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 16:30:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH 1/7] scripts/Makefile.lib: Rework upstream_dtsi_include to use
 find
Date: Wed, 28 May 2025 17:27:04 -0600
Message-ID: <20250528233050.3820722-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528233050.3820722-1-trini@konsulko.com>
References: <20250528233050.3820722-1-trini@konsulko.com>
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

A problem with the logic in upstream_dtsi_include currently is that it
does not list directories such as dts/upstream/src/arm/nxp/imx and so
will not findi "imx6ul-pinfunc.h" for example as it is normally and
correctly included without vendor sub-paths.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This becomes a problem if we remove identical header files from
arch/arm/dts for example and only always use the upstream one.

Cc: Sumit Garg <sumit.garg@kernel.org>
---
 scripts/Makefile.lib | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e89a4a51b74d..ac14e4f9dfb2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -205,8 +205,10 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 # Modified for U-Boot
 upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
 	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
+	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*/*))) \
 	$(if (CONFIG_ARM64), \
-		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*)))))
+		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*))) \
+		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
-- 
2.43.0

