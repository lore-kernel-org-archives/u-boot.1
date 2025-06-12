Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC714C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D03982CA8;
	Thu, 12 Jun 2025 16:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e3nHYfPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513B982C84; Thu, 12 Jun 2025 16:16:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B0082C79
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so7855895e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737804; x=1750342604; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=e3nHYfPtBkz0f+/M1xXE9ii9ZwilsQlkH0RbfUq/fV4I4gYY4SiVFG0Cpgkfufut8X
 /lMiBTOt0osSvJMrMuVPbJXP0AhHSiIoChvM4x5Fl4h09o+JBZd8JWVM+yg/pQBkKMja
 xv5xahuAVuQOYAWFs48TyXTfc4cYSt/3xrEkWpNUmB2ZLsOvXBwlhjOB9+RMdWJudkUw
 xHy3rxbQhzP0njNMeMSxbHpR9FxXBT4rIhiU+CZyOV4MITZ1qFREOYNhyqI0fvYJQrwn
 /zptAguyS4kLVxm0jcXzllSKT0BbI6xI3p9uyJroV3fW+BC6TglzOh+vS4iC5GcpLnc/
 tlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737804; x=1750342604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=XjeB92B5RYuwOjWmmP09yLPPul5+Mi9rZCARTocQwFS/myMqwLAP3xmQ4oQcWS/boZ
 q1AF0XbVMj7gYxdW7/wUFzW5dcXSZ6ULaJgjTyg3lljTnhsP4v7vzEGATJRbdLGD2mGg
 SF/qisnyhExK/T1yxex3pRuRk4iCu4yA+DX6r8HEkFuH4hjOXTgWd6w9VaA20jfozY9b
 8hMhoit8Pft61nAB5KNT3Ha1lwhZ0mWtzNx0H2lMjkahuNjkf96fuwFsURbcbeU54us/
 0HlWmJLMptLkCjt3j0J061eX6oLFbaiftMcDTBjsJdQ3isqd0kVNVQ/+xZGbFVcHNkpV
 D/og==
X-Gm-Message-State: AOJu0YyGg1KE3/HfYgj09IyXublMOnOWocism0gLB0kLxdwpEppnYrFy
 nASQ9Jzyh5AgCWPS0NgVt91l1v6yTT4rUZZR4kXwpEwyiTVsSQuszi/gu+P7EbxtDBQ0YFA8stf
 dWLTO
X-Gm-Gg: ASbGncv0huGvUiH10Ar0oTpt+kUskfGBTuKgd2UrZtNeeXkXMSo9o4Dtpv1226YAZiT
 Tu4K76I6oqp8BFdWfma5b5YlcblvK8kPTZduWGkmwbBKSXvRyOCEQymujdwoXfhHsWk6iETZWns
 4VZBSsC9TIAbQ5IPeLmBM86O41jsEKwf332STwZd0r8UhEQAidvKB0TVVGIqb9kmBxMb+NjP8/y
 TXecycfTUbdKFFAfFyrN3ySeywH6jBi+FSUa8WriH6HoWpSbd9hKtbO02UVW5ALqMch3u7/8Orm
 zUQn2NaJV+Wt/YzZykWUPr3HnO5Dw1Hv/FZSK5uq0M8yI/XuarGMTI+BdL9yZ1nLYR5rRDGp
X-Google-Smtp-Source: AGHT+IElHNir8KZdsAXJCgUu8VMk7vzoG7udT49WVxB3/pcbN1tHSPakBrZcsVNGSX63nY/n2fBRgg==
X-Received: by 2002:a05:600c:b8a:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-4532492b480mr77613545e9.31.1749737803802; 
 Thu, 12 Jun 2025 07:16:43 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:42 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:38 +0200
Subject: [PATCH v3 2/7] binman: support building binman dtb when
 OF_UPSTREAM is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-2-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFGiGDgTi5ycoKS5s7h0aBPsj33znGO5XiZB
 DmET337dV2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRgAKCRAFgzErGV9k
 tnoaEACIBkAqy3mL/fO7pK8Poy6n+LsusM8QcntHjxCKaAMWNebM7mJWi42g09GytRupaEPYfJw
 ivQ5QWmatTDyUZm3/ywj8CvnDLV4Hwdyj5iy1nL4jmAuEwglO1XB8YC+8oOUPA6gNIUtCK2gEOX
 oJBmVeVfXRN+kCRA+c7ni8xL7V6GEI1vKCkdQlCcgRoApkCL/Rjso3Uxvx0WC+QAHA6WWklmNxF
 WamndZstN8NRDP7WSJzLOREHBhcXgXXAS7k1dvgZenFvZor28DhzjkcAt6sd4BI+M/1yVNR2fC/
 FOkVtfcnxsALhzYdIiLuxKns3MV/d5EpG38f/I/pH97gGR+V2KvWJjihUNXMOQGGHwoz+txpKCC
 hG3wWIqi6JmgyhGT/S3o7e/XqZw2SuBmIvEYh/iyYARjV2491cq0nGi4fxLMCUovacD/OoNCHhz
 CgmRev9WTiWlEVrhNo8TQI0CGSDQ5F/1Mwg5WyogmXgmKhxBv40psv9ldjd0IwiqAPW6paf++bg
 kub8PyB5rydQbu0GmTfcNHjSCT9k2il/n4n4Z7Vs2rlLIeWjEi8doyI1ES7i8dKY0JZyjqhQJ3y
 QHkXW3YudKx7A0EsRJ6jrRf9uvervEUcSYcM/xoZebwzx+uKX4jnp3PCkUoGuL7wqx6Fi+TnjHF
 yqDGIY6WNuNijSQ==
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

