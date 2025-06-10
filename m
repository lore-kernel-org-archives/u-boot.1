Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30F0C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB8A82B0E;
	Tue, 10 Jun 2025 18:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o4Y3HmFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAAF82BAA; Tue, 10 Jun 2025 18:23:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D9D82B26
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso1945584f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749572617; x=1750177417; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r+IdeR6GLAIHYPBKSdW9Lp2+cp5wn8ymi4rAJjw2YbM=;
 b=o4Y3HmFsyGtd0/TzGUcTIcvJZyYeFC3Hzxag/ofReO17KKf+12MwhfwY49O5+TJjLW
 S+fLJjS/RRRTLo/XKmE9u6Vek27NU9PNSerXG6DEAbjuP7Rg9ZjicbqK2nurfxSx4aPf
 T0UPea8JstUiCrPSPtabswbVqqg8XKAonLFUYnvErK7wfWEv85+edgh4DuQamgtGi+eY
 T5RM1MCHtfr4TGLPqazM5f3jDP+QcJ/vJBUFmOjjsc5Rdhxk8jxYoA5VsXasH5BHfc2p
 HgembaiRhSIZy5DMmQ8c0mztSTQgk0hn1uUPBW81MaoTDrPVatkNwskOFNsrTQqkmXip
 FjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749572617; x=1750177417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+IdeR6GLAIHYPBKSdW9Lp2+cp5wn8ymi4rAJjw2YbM=;
 b=uAmEnOdHuDyiuEeIek7jd8Ltl1coi1AJwIDQSkdyFW4k5LBSZtJY1CjbGMOdcPAv4v
 zV9IWrzXh+G/mHgG0FWt2MYWvrc1YEJvzXxdM1GLpD9CwqIJHQ4/IxOXGStp9XGm47y0
 ZoszENvLrVcGGK/Y6O16Izxty00/LDVI78nvDTC0AInO3UFCVqVJuT+jeUUOOxolZ+5g
 ZBmtsPzRRZx8ZJHWHBnVb3zwGrxzg5JvYvSCHVvsE/0H0tTwzrA2G4COoyDhAnPbVYlO
 FFnYepxX+njUM1FxW3uQkmAonmOkKUxOC29Vn1XXYGT4X15/reCM0o4OSa0u3a3bxErz
 ZDcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2qYPDrtNc9Xlow1j36Y3aP8VYCQj/9eZTU12nuJK+sWVFi4tqBM9KWqYU6vHk/PKz/y8aFvs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw6JtmOXkowLa0D4h4TA13Hmcv0QPteJRFmEpwpC9+YqLHQBCr
 AyaXy5KYdiBMbpEc4vtB1dAV97cAzNod8ZjKkvvaeH6vRE0NIAowW4NjfyufX+gdezE=
X-Gm-Gg: ASbGncs/tM47zS+oCBeagTm/Yf+K6li7QNgJzOW1OBCqw7IadOKsgMxBi5OaxiwzAOG
 TdX+Qns6nx89QYUVZY4nj4A+A0H2RS0AHjKOJWQX2ePyGA1JHKTwfVXmCCpmicbaPeOD88FjoYM
 D1BEziAWPFb1EAbRaazuQRSScTG6umHmFiGQOPNh+rLFIgp9DrhzcXIMGIKSE6EHOxlsMXDhAkz
 CE3O43p7Ds4z09x45wZAMIfZa4n8Nq5G9x70Tkrp4qldTsjOo/XItg8PWb1k3HYTWs7D88MU2hk
 aQug4KA53AQPBibNOYExXFhCz4pc6nWyjFL87EqHBg+9jCYN6AIYR1oDSaK7FZqcEnPeZw==
X-Google-Smtp-Source: AGHT+IFvZoIa+mtOSjbU/nr6cLS2agQAp7A+NSObCwg8mfg9wmIVeENTcPi1xBI6IHSamOICjSAFIQ==
X-Received: by 2002:a05:6000:402b:b0:3a4:dd02:f724 with SMTP id
 ffacd0b85a97d-3a5522be153mr2887109f8f.43.1749572616819; 
 Tue, 10 Jun 2025 09:23:36 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324364c9sm12962890f8f.51.2025.06.10.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:23:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:23:33 +0200
Subject: [PATCH 1/3] dts/upstream: write fdtfile path to /chosen/fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=S/wgBlDNkR6/IcAkPzXD1L5Z0tiq4M7jxzWpS7qhZ8o=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSFwGvK+xUXpZfCyerqwyFiPbw6gPIMAuFSOZl
 VeXd5RpjcOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhcBgAKCRAFgzErGV9k
 toi3D/4yg0ixtJGjY5vb9Pdwiz6mA8HKwYkEiF4hRcspQ+IVuF0FnzcTo0eN8veLr9SQiE0AuGm
 A4iCS5mICjxNnG540XqaWkIHzRVR4mVmB5tSU1MDHeX4c/43lcBgGIScr4EUKHmjgVIjSBpegCT
 ssdQlcV/PusFeqFmFA9E3QL2Y9LWPbvXCsH6NS0m8UG8TIunk/GzxzZ1lt7m2+5Je0Rh+RzutOj
 agdTMBKv0OSakLUhdJwUb2TVvB16WSU/xCJQW9T4ccxvy5eYE2+KBwoAUi0mkuWGVuA/RO4JOrP
 Rq70EC+/uyxTVLWGKBRFApHN8Xafkf0mH8AAnxbJ6GOh7dnxNThhLbEUbv8OHJwIoTbPjNFHfsV
 goPubyDnLN15200ykL/AOnfUHPQk8Ws5p2Dje5wEmZXte5+oa/7l+Wdc+Td9uVMr+0faHh821rF
 CYsm1p3MTT91RMYLoenVhmoUhFRaDEDXNX6THSuY+xNpUA5hto0DLDlPrOGPWZQEvC7Jz4sNSI7
 nv+n2AZcbZvpwBoZsjFCzQM01KercUQOU4unSeb1s6NzPGEXNxcqxk0R0vHR+NMBlr9TCmsWAdT
 MmVnjACJQ85iLk5uA3wUdhJV/A9x/fROE7aUIC/+JfrQPrXCGUu6ytOrl5QvLot4iaDIrF/gZpY
 lrJ69hXhrsFCjlw==
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

Since we're using the upstream file structure, we know at build time
the path to each DTB that we build. These same paths are used relative
to some (maybe version specific) dtb directory on the boot partition
or ESP.

By recording this path at build time and embedding it into the
devicetree, we can set the fdtfile environment variable with 100%
certainty that it is correct.

Devicetree file names are already treated as stable kernel API upstream,
since they are used by OS loaders extensively.

Embedding the path into the devicetree itself just simplifies the
process and allows U-Boot or the OS loader to select a devicetree of a
different version for the specific board that U-Boot is running on.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 scripts/Makefile.lib | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e89a4a51b74ddccfd9f0a6463cdeded12eaa5235..1f95bda0597c14d2ee785eb8058d607a6c819a56 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -360,16 +360,31 @@ $(obj)/%.dtbo.S: $(obj)/%.dtbo
 ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
 DTC_FLAGS += -@
 endif
 
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+# Embed the upstream path to the DTB into it as /chosen/fdtfile. This property is used
+# at runtime to set the fdtfile variable
+dt_extra_snippet = / { chosen { fdtfile = "$(subst $(dt_dir)/,,$@)"; }; };
+else
+dt_extra_snippet =
+endif
+
 quiet_cmd_dtc = DTC     $@
 # Modified for U-Boot
 # Bring in any U-Boot-specific include at the end of the file
 # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
+	[[ -z "$(dt_extra_snippet)" ]] || echo '$(dt_extra_snippet)' >> $(pre-tmp); \
 	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \

-- 
2.49.0

