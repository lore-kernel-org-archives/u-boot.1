Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB0C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 08:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84978806D8;
	Fri,  9 May 2025 10:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mYti25ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AFB8210D; Fri,  9 May 2025 10:48:46 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336E88059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 10:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fbfdf7d353so2426419a12.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746780523; x=1747385323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QfQ1a4M1KVIw2CBwf7u747pnSGqTK3IwJyxpzizwiWQ=;
 b=mYti25ax4I7pjs/n/aSNLjnKGCX1aiMsfcGalJ/kV61rwYaiESyBn2JJtoiNL9vpm4
 F2Nt06HJzw/vsH0qCUDYkKPG2y74Z+rpaElyva3knaW45lGSF/6eETcNoXZbvOxmm36D
 Cxc4nI8DY2uONZGgsHEie69yvOIU33ZwZy0YO3D6R2ttwBNKPFZplofIrkrjRUTKLAwe
 H3i01/HZWWpv7BYCjdQaADw+QTGRY1sg4nE0I7TNg9Y5vrx9nOzozcOIj7DbII18oT07
 PDTnwHHxg9IanPDRMQF4X2FTOObwQfyC77YTUOe0xy6p6AzbTwb+xTyBuQRMlP83034a
 bPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746780523; x=1747385323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfQ1a4M1KVIw2CBwf7u747pnSGqTK3IwJyxpzizwiWQ=;
 b=BiLULAakSVnFe/aunx0sV6RRRYNqYJBamjO01JLzwYdzuRoMMcZ7CVxtlvR/MRN1T6
 lMEqGxYwnRPd5f5+sy1bMt5tSlYmaFCsOtkKVVlhXtlbyyOb8P/c9+spKb1K2iBbqgnG
 AUcNuZWTfM8tl2+Qd9ULBHGOejHrt5njUncUQQkpRNbHzdDFk0KFuijjYYKKzNeiAZPZ
 2lUA+GvuQQ6L7tZ1tQR2giLVdVj99CqxtNg0u89TJl6kDenAm97AtnleScqfTQFyPCFL
 59pjP1NxGwjlU3prMZXuu/FfhaV1phzsSEKy/9YZbDtYzZckHox5ya1bmvMbg6ySz1tZ
 fAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7sbeZjW+d7Vjzn82eVOEM1QRrYidCaaRlTqlSVxH13fjdVt55Ak6RKn8TRHNuAnh+LKi6J2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxHB+4KKdF3UlAsZB9vWmcvrmQnDqrTtmhupRIZMVyTh3huJSb4
 fFE51Ohr/3jKh7DLagHztP2KUL0tMxgu3xxv0ucmpnwrrRRIvLrAASLVtJqH+0UclmxAOU+Ajmb
 r
X-Gm-Gg: ASbGncsgqRtH0uloXIKZ23OKm+llBBc332xsQd9ymMuivI41kpbQgWCp4NMarZWXLZb
 papFwmCtQ1+th/Npe6AoM1DkvCbURGuw5z8YLDQ+SEaw2qWYuvw3nElCeqjEb2v555ZJgy5yQjK
 9dfCmhI8g95Bfi17dUthUhQmHGIWJhOByQ0g4Za2jmA0Uj4BJz1evIWTvDWEhHGF+kZnorbk6Rb
 6kdhxwrxJvZ96wjOuq9KVAJDM60TkzI4ZDWBo48ItGKhMyVlLn5j4v/rKGXr2vpMHRWuybO6Jzp
 AkWiJUC4A7ngcO0wIzDjI8Ai8SugXGaCaQYZXu0m30xUSvstlxHCiH8DzwOxJ+jM
X-Google-Smtp-Source: AGHT+IGTnaOWzSN47m327vxoqK75dqWlqcc4YRjKShvtJSjbHfXzRyRLHD5Azr0xPGYpiEEMh6nY8Q==
X-Received: by 2002:a05:6402:84a:b0:5fc:9759:3958 with SMTP id
 4fb4d7f45d1cf-5fca07a0129mr2000336a12.20.1746780523470; 
 Fri, 09 May 2025 01:48:43 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d700e92sm1060038a12.55.2025.05.09.01.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 01:48:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Subject: [PATCH] kbuild: de-duplicate fixdep usage
Date: Fri,  9 May 2025 11:48:28 +0300
Message-ID: <20250509084828.645814-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

