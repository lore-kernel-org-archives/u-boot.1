Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A0C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797BD8362C;
	Tue, 22 Jul 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d1Zlc+l/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894C78359F; Tue, 22 Jul 2025 17:35:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781AB833DB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so42455e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198509; x=1753803309; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eLe2fLkvRFhxNeiCZe7zeBsyVTw8GCDak6b+S8qjPSQ=;
 b=d1Zlc+l/wx25zxqLrvj7i6ZecpifwR42rTcldCOIRgIX/2o9X1ZUIHQWiS4OQOD17j
 K+XITHPj7crajYXHeB/jQ2z6B+KA19xkH4d6v8uun8e1QgdLWbOqCyqF6utEIR6cBYZS
 Ne1ilmro76H35+LU5A6RXyHU1Lyit5aSvbNa2V6B6hOhhQChq7dyca2rmZtOpYTe1Ndx
 h1YICAgmiBw+9S9VJ1lqbhbsCadzsn+4LR1u0EWqRiOzq6YLSpgF8qQYa8Kn09cQAvok
 EtCsBTYcPZHcDD3T0lzyhqMPcAvSeW8LVPP4dA12vTVkBau29QjSuc8EZOsPhSxaB3Ug
 Zc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198509; x=1753803309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLe2fLkvRFhxNeiCZe7zeBsyVTw8GCDak6b+S8qjPSQ=;
 b=b9ESzvxW8hkNA7meOgoWia/iwWK8/DiZkyXtyUfE+javNNP5cTGnOb0iWA5f0ulF9H
 QqAiG/C3v7PvH+/+y/xb0s4aSYJd4AXDj8sB9StjfbapPZX3zuVdSI1aV8BJim5Mm7e5
 VjLz+QFiirgGeiIGUCXz9lsLLDupMje6Jn7eCPr7kn5BFd6KiJXzqdVjLWWoSiWimW7D
 hjnGSHufcagGDQ6zFld7/0Pp/ziK+i9ezrsR9L+WIw8rxA4E1iD5JE6vZtlkJVwLtGof
 ipHwiLTbNIJJYhH/5PUqDb86bxxRfYn2Bf33rvE9gqqhEjQpQMqkhHd7vk09Oj7kn+zr
 QvQQ==
X-Gm-Message-State: AOJu0YzQaRtmPR+MVjplwr7+PxBxmf4Aqsbs+XaiIsmYosBVmZhtxX5F
 qFiOTf/Yrr+xHcLUmUhDnMIf88j83tegaupqgJK9aQbzJA1Bizf7NOJQQFdw4L+eCbAUr+zwkEQ
 0131Y
X-Gm-Gg: ASbGncsAPgADJb9+HbuL0HiIlZQypwWlOrlkqfzy/SIHVntja+GJ4AbnH47EYJrrt0Z
 dQ5ZRzG+5/Q5M+77+rIZx+0rIDhiI78RJGCiipwqe9gAoZlcAhQoM9lAPsyleCLzliR9omcl2NO
 2quLD1fQ6RDNRuD7hMfLi75VnxgHprpKiVMNJdzEO9uD3DIkwbuGV82/p4y2RAmw2y43uxzTgV4
 lny4ZJUL9JiBuINFoiwFROH/JMD02tFbZFM2LbBQq1baSRdhMpSDmzix8C2i5Z7VX6upSr0n/nM
 y7cPf/tEZwb93crJ4lDY93Jw1fhSF/XMyvvZ2wDoba1mrpKBA1Sv1R8naZJROOHB6xRXrKrtsrf
 LQ9w9IqbdrOMRoY5ykALzRqtRHsuGn5OFT6hD+AOgU03FUHvCKpuBJcCdJofXz1o72A==
X-Google-Smtp-Source: AGHT+IFu1584WY4Vd4137u+mVIeMtDHBbbYb1oIIcXQVFCWGhhwZA4VaxxBMoldB5fLZIrH3a4p77w==
X-Received: by 2002:a05:6000:420a:b0:3b6:18c0:8b6d with SMTP id
 ffacd0b85a97d-3b7634fa6bamr2839777f8f.28.1753198508869; 
 Tue, 22 Jul 2025 08:35:08 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:08 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:52 +0200
Subject: [PATCH v5 2/8] binman: support building binman dtb when
 OF_UPSTREAM is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fgp3QTIiXUnnwls86SVOD3GTWPGdaBR4NlYYUfgS8uw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69Sv4N3JdaLikYdT5pappYYLXolLvcFGtBccjX/Fnv
 L5kqvuxo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExkaiDD/+QHz93llvzeO9Fi
 VQX7+v8dnBmsc+eevb0nJj/CYo/dfleG/w5Js2z7szhTDh46WtCT+ipa/lzq60//RLmYM7YZ585
 g2gIA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

From: Casey Connolly <casey.connolly@linaro.org>

Since binman DTB files are not upstream they are kept in the U-Boot dts
dirs, this means they will not be built when building with OF_UPSTREAM
enabled. Resolve this by adding a rule to build the binman DTB if both
conditions are met.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 dts/Makefile | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/dts/Makefile b/dts/Makefile
index 86bf8dc21560..c620d84ccb13 100644
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
+	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+endif
+endif
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
 $(obj)/dt-spl.dtb.o: $(obj)/dt-spl.dtb.S FORCE

-- 
2.50.1

