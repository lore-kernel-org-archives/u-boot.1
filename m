Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D28C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2522E828A2;
	Mon,  2 Jun 2025 18:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ui5edZzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBF682045; Mon,  2 Jun 2025 18:11:05 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D7B82045
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cea01b9cso18650185e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880663; x=1749485463; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=Ui5edZzkA1dORpaXApo6e1QFKioRKAVywJY6dvhINi1d/d+RdtkkshbfCXu92NsgUu
 aMGru0XehMEnpEtvRrtfXOMZF9Svg31J6jOppZHsikm2EwLfNPnB9tE56jXFxukcrx3F
 MSyhy8GQ+Lbm4IznUxAzU9mT/sgM+HEXmZ1AZUlidKY/+Wu8DVbnwcGXKCE7gL1ugLh/
 qBvbdDBH+DNgA5H7ejVhCPgjYSmKZf3JQXJEKLsXZkr7xcD4icraU/AB/kDWBu8zMl6I
 xXmcP5COxzpZorUy+DjmThHJLIfuWt8Yt61SkEBgfXtxJqOB/DDG9R/6wmNhamES+T1u
 BbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880663; x=1749485463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=h/b0y61WYqZLizDTgbyyhtn5Qs1KD9RY7KrR2nCq0gJWbss758a4yMOjgCSwXnFtQt
 0Ao8LsaC32GZ3xddw7ixnqNyWtmTjNurJuqMOaJ6vmujgwufd4CKqTVgWwu8LBCPaSoU
 hZZJo6+pWSODoVigoGF5xShIsIJ6zYIgl5QFVJqamoTsqWQa0uT2I63eFM8bLq3aHZ2s
 zRlLjzUXizafh5Z8yZu0It6ih7eMhPYrN6rNQQ+su3m85N+fbgS4bN5KDhfv/O92j106
 ZL3ZtCcp6Wjqld+QzbXtxAio2lQ9rhQjlAeF437sc+DYgge8D7jYsStYWXVDbLw9L7P9
 LxgA==
X-Gm-Message-State: AOJu0YwwDt7l3Jk/0VETEOlhAp/+f7u1GZcpOUQG7tbQiKqLUJL9JRJ7
 0yvxzE+sTXabnDE25dupnL5fy5oo3ilwp8gd1j8XwtNrJzVMb9my8B/AnVxKsenJZX4=
X-Gm-Gg: ASbGnctPnwdXRpOUSRVnNyDcGkdbLCZTuiQCXdmH6c+tb2uSNMem+RgsYyWkegyiwN4
 kWbvidDuR3iulSq2YtQqKZKPKgAlGOUrIPwxcGIud/FuvXm5LivNC+ZbEqHWl/FkcdWJnVuUz76
 fBv70vofwCA1mrkEGB6nrItUP3gQG8F4VViiGdZJxhAiVkF8uCns3Ce2PNFDiKWzCpkddqjDnq6
 ORUjAGQMP/cYBgDeNJyrxyt0+ywXE1fmX9CN+/PHJtb2BUJExuSPlWfkAfY5TD6nUrHMd3i9yeg
 JFvDEIJ9qUwblhm/E0/ciqzGGtKDOpBdKOcQprFWFr0oSVioBd6o3rHUmsHHk0u4BL0cXlOT8Gh
 /pw==
X-Google-Smtp-Source: AGHT+IHbile2RoOfBxujyO9PIRjIohG05rOAcnLrDR468daTwS7iwWCMSchG8snvbYoyzdoOFEEHBg==
X-Received: by 2002:a05:6000:4023:b0:3a4:e7d3:bd9c with SMTP id
 ffacd0b85a97d-3a4f89a76a3mr10471632f8f.17.1748880662852; 
 Mon, 02 Jun 2025 09:11:02 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:02 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:53 +0200
Subject: [PATCH v2 2/7] binman: support building binman dtb when
 OF_UPSTREAM is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-2-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=zpH4J/5un2orgNb3aWeipGM6L8Q2h9Oh8TvyEo7hNVI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0RawoNRGHXse1yJ0urfpRsrqc9JYHhIg/7j
 iwWcxT4lreJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEQAKCRAFgzErGV9k
 tpyFD/43mSgmrEzMLWtnSi3JA97M/zK0qd1nlsnu/bd/UQCgCR5HFXosMKCm7OLzgzjRZZNmbCZ
 kTXd05+2Nf0PLMs4BK3fbIkB0/hkMO9o74m+2E8qSqM8zUodNDMDftT3DPKZrlOTMNJQTcRDamA
 NcidrUG3CNxjrRrAkUzR68Sli52y6yKcqJaNOKj9+yQ4bV5YwyQu81nBXOxkC9spSg/Uzqr6kuf
 uiTaoGnf884l8pRCjaaMOFEKenEh2IIq1zHydseicyvFP82e6SwXW9tTRCJBf4kpUfMAXvWN6pl
 BxYckuye8eybrZwEjWdvWgY2/44Qeb+0oGno8I3jowmwtsawjx7royscgmci6vNTRTomr1GDvey
 hua8Ea/sR2R+SbkZEH1W4lTTzTAW1sOg+B2Qw6aIBbV9/AptzATfAzMRv/Xn5Uwi3bc/InF/fVP
 O/NydabSEMy4Mma7KrbNP+17YsFZ4qZ6HmHTukYMlJXb3qxRsam4cyU/ftF3E3IGf7ZPjWpPBWE
 /9ta5H6Oz5+whSqHNS66bJ/g1MNf70stj3GqNawC1syaQ/d/mm3NlDIOmP5kHERijg6raw/DvVl
 yPnNFtLtxDTu5XOrBADhWlREklHIdblihYnhX8qAMjBpEDHCvl+bpxJ/sZsYcE5VunZQefjybe6
 /KdsGbR4i4l/5FA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Since binman DTB files are not upstream they are kept in the U-Boot dts
dirs, this means they will not be built when building with OF_UPSTREAM
enabled. Resolve this by adding a rule to build the binman DTB if both
conditions are met.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 dts/Makefile | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/dts/Makefile b/dts/Makefile
index 86bf8dc215603c3c02930e9c642d7dc06ce715fc..c20d0fb7cca9d117030a882be783a8e855e10749 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -25,8 +25,15 @@ local_dtbos := local-dtbos
 else
 local_dtbos :=
 endif
 
+binman_dtb := $(subst ",,$(CONFIG_BINMAN_DTB))
+ifneq ($(binman_dtb),)
+binman_dtb_target := binman-dtb
+else
+binman_dtb_target :=
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
 DTB := $(dt_dir)/$(DEVICE_TREE).dtb
@@ -45,9 +52,9 @@ $(obj)/dt.dtb: $(DTB) FORCE
 endif
 
 targets += dt.dtb
 
-$(DTB): arch-dtbs $(local_dtbos)
+$(DTB): arch-dtbs $(local_dtbos) $(binman_dtb_target)
 	$(Q)test -e $@ || (						\
 	echo >&2;							\
 	echo >&2 "Device Tree Source ($@) is not correctly specified.";	\
 	echo >&2 "Please define 'CONFIG_DEFAULT_DEVICE_TREE'";		\
@@ -64,8 +71,18 @@ PHONY += local-dtbos
 local-dtbos:
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbos
 endif
 
+# If CONFIG_BINMAN_DTB is set and CONFIG_OF_UPSTREAM is set then
+# ensure we build the binman DTB as well
+ifneq ($(binman_dtb),)
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+PHONY += binman-dtb
+binman-dtb:
+	$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+endif
+endif
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
 $(obj)/dt-spl.dtb.o: $(obj)/dt-spl.dtb.S FORCE

-- 
2.49.0

