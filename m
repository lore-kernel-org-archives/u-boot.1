Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A0C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD08082BF3;
	Tue, 20 May 2025 07:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gF2vhB0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CBB82BF2; Tue, 20 May 2025 07:22:04 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050F782BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so1447286f8f.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718522; x=1748323322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfQ1a4M1KVIw2CBwf7u747pnSGqTK3IwJyxpzizwiWQ=;
 b=gF2vhB0dhR1LtY0o05iYkUdnBfuHGL2IS0/nEKhNZ1bx8rCMCUI+I4743UW+c+ZFvb
 ffsiouFQjQneE6duMa4auhkdZcSDnURdotTPcepFHlD4GfvU3k00vcYNzOPa4xaaiuv6
 xO/lxc2gR9jykD73ZCRJ6FUtLJdX4APZoQW0m31Vad1OGJWhkClGxyr9HrIyCBrwOZus
 cdxh1KucxgCjnhKxNgqboXUjCUZKNPCcQpgM0bxN8iZS7uVSycy4BjH67TZRSZ/02iqF
 hWfoUneUXD3ScCMqryW9nZDYuLtgz/VWHYfHOK3UxUdgXPl5hUI+TFsyJxnzVqsTG3Mc
 klEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718522; x=1748323322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfQ1a4M1KVIw2CBwf7u747pnSGqTK3IwJyxpzizwiWQ=;
 b=G/Jc/wwyOfUdxJTIQWkuiRzJgmIOZnv01+T2QYjEwITV2G3Q5JtCyaoavayc0ZYdan
 mLUlHZQPjSIEq18sdYl3KXO84h6ir1OH3dBkWh0Yw1t+Yma9qPT+iyh9+ZwcrP6Z11cp
 3SWUMAXAU3QKNu94CNTqNQ2pDUplGubVbbEqmi5G3Fsr2nGAwvYA+1Efm1xCS6gdnN5k
 oqUGiB7WNq21fsie+naszayu68ZDhb0+Kmj+q8Ta9bi56aXyfcWIIFxGAJyhoRH0trBQ
 nSXucCelT90d9eBKEhCLFz7g62AO1AoDCKlpmatI8lSh+v6r2lR9A75ZretZUQ7ZEzZR
 cF8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGzGTcNaD0F8nPfMI5f7Ad6ecMzmZMXtg176ARxyniTpGnbH6jTQcrTFrLJ67yTV3dpZAn+vM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzpmg6dAOEnO50M9hLBMUHpqb+1j3BJP0gUGw1A5kkI40nA7zbO
 XRyKRZLeIh1h7zCguQ/2NQ9tdklkEjeuR2i9zUAoiNWAQZLIFcDTHhAV4oOMfa6FqhA=
X-Gm-Gg: ASbGncvUuMXeUXHOnv5UzxJ/ChjbgObfok2lHxzt4fEA+opIxf/wQkRaRp6mSeeEqKa
 C77EVvHI9Vfzv8AMrb8adg/VE2ThX+W10yvMAdHzt/MomokI0G5E+wUyJQnsUJWnSBpAYYCyMoR
 04r8gZTZoWzGkwIjyUSRyM8AiqZyuSDIuhPaFfuppV6xhX/ehQcu50R69oNjjIWAA/C2eWviQNW
 7qh1eujXxyO3zpczApVWs+0p+7jHPOul8xlSN+FV3cwRl0WPqOOpQEquZAL1zHCIJNeWV1D32bZ
 W4HgzplHhdsvIRMtBFTzBvUJ8NZ11o9jVq4BFO9ziCTCrR5/knYiKF1nB7cKCDOnkrvyLnN5pzI
 =
X-Google-Smtp-Source: AGHT+IEozoOT2sWtdECjDEPhTv5AC9gKE3Q06qEgFwuLmm1oPf2KR4AUkF31Q4BzoJvhiTWHAFpG2g==
X-Received: by 2002:a5d:64c7:0:b0:3a3:6481:1ca4 with SMTP id
 ffacd0b85a97d-3a364812b25mr10748158f8f.43.1747718522485; 
 Mon, 19 May 2025 22:22:02 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:02 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 01/24] kbuild: de-duplicate fixdep usage
Date: Tue, 20 May 2025 08:21:12 +0300
Message-ID: <20250520052153.307194-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backported from the linux kernel
commit e4aca4595005 ("kbuild: de-duplicate fixdep usage")

A lot of the kernels kbuild depend on that patch. Backport it and pull in
the 'rule_as_o_S'a rule as well. This might end up being unused but it
doesn't break anything and makes diffing the files easier.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Kbuild.include |  5 ++++-
 scripts/Makefile.build | 17 ++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 054dd157485c..7468223d3233 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -266,10 +266,13 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
 	@set -e;                                                             \
+	$(cmd_and_fixdep), @:)
+
+cmd_and_fixdep =						             \
 	$(echo-cmd) $(cmd_$(1));                                             \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
 	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd, @:)
+	mv -f $(dot-target).tmp $(dot-target).cmd;
 
 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 90aed148c44b..10f31a57a0f9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -241,14 +241,17 @@ endif
 
 define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
-	$(call echo-cmd,cc_o_c) $(cmd_cc_o_c);				  \
+	$(call cmd_and_fixdep,cc_o_c)					  \
 	$(cmd_modversions)						  \
-	$(call echo-cmd,record_mcount)					  \
-	$(cmd_record_mcount)						  \
-	scripts/basic/fixdep $(depfile) $@ '$(call make-cmd,cc_o_c)' >    \
-	                                              $(dot-target).tmp;  \
-	rm -f $(depfile);						  \
-	mv -f $(dot-target).tmp $(dot-target).cmd
+	$(cmd_objtool)							  \
+	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
+endef
+
+define rule_as_o_S
+	$(call cmd_and_fixdep,as_o_S)
+	$(call cmd,gen_ksymdeps)
+	$(call cmd,objtool)
+	$(call cmd,modversions_S)
 endef
 
 # Built-in and composite module parts
-- 
2.49.0

