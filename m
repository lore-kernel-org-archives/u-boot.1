Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9DC3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620AA82CD2;
	Tue, 20 May 2025 07:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGyOUATu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F94C82CD2; Tue, 20 May 2025 07:22:40 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4731D82BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso31081365e9.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718556; x=1748323356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krho0D7xdJC/s/CO/gGJ1CCxpElCy2ScmFM5rXKZo/c=;
 b=wGyOUATugje04ChXXfLQIyxlGjXiwRpym9WdmbgAftYJWwch4NXfoGAhREHYZYF0Vc
 T9lKGnTRPnqmYpYND6MAA6FFIBPLW9UQMlF6lnz5GEHOaTxesq1XMZp8eYlD6FJwiI1U
 UpMiixb5basPDXaTMSEyZ08dH3AedLrdu/JnIPipakVsOFQwvPt2CyKtMHz8EYgKqAbf
 An6STfOwJPYkcGZnRYTQ/zqzeWGbr96BeF0tND3EuODMrDEAXm/EN5/QRzmrzpOXWyyT
 Nlyzvh3i/0dAWMn8l2hHCivMvZe5S/ntW9o+BFZ8WinBvBa5xF9C0klvC+G6NYSNcqsr
 v/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718556; x=1748323356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krho0D7xdJC/s/CO/gGJ1CCxpElCy2ScmFM5rXKZo/c=;
 b=tqnt9OBkEFPB/wwTVq/7CBZaqV9lV95KOt0otTasY4BFLK29Wyl0BP08nQAhyJfchd
 Uhp6Qr6hoOwqyx2jiN0Y6e9hZoKk6yiSqShKwNXtweUEdODsf19y1g965MCLW0nWlbuT
 rm7Bygx6AOWFiMGPxh+AeWc7hsUxeRZq0uDDLvRnABkFjb09+lRC1KJ9RK42mnaeQJMu
 DkIfzWSY9ZQZZkrHvagZEW5QMb1Q1T6aAb+3KQDXjtzmgqdSuTOZIb8wi0oyMKRL68vb
 Nqs7L5ztjB1EOQ48rST3IX7ZiFy3rk8V6Ypx04U+2hI/IORuyMZ79PY9ZviglTUw/KBm
 jzqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeVzBn7kPnmdniVAci1fv44bYHb/nRJ1AF0iUEf3WwpkIL12a7OqgVtoj9Zd7g73Ofqa98QEM=@lists.denx.de
X-Gm-Message-State: AOJu0YxMX+wY47vHHO5lZAdtVVm5NXRiflTiCwqQCRZM06MRDp/+BidJ
 zvCmFvI5CSImZxY/JSkXMrHBadnpf8SvAYWFkyGW5tP9y5PH2X7MpUSEJuf6zLA4NHQ=
X-Gm-Gg: ASbGncuObXwAHdu6mwJRS5F80GPerFsDn5wSjiGDTjMDyGY3vIxDfwl453I6r0/bt5K
 vzxOcEf3kjQexpwdto5m7aObejMt6+eXzCanXFVdKshl6NCWy0hrWOLqvxgHLRVXSDXAt3aDOWc
 b7BTYa9+flBIrkydzLWM4E3TvSB3GNWKEhSy/HLafoJGCLYEVJAaL0qAypgludsAeORocBjQmn3
 AXsTpONUeMBRmSPcMB2FBY+icg58UX0uEhGHT0GaCWhtvUW0k7T6Yb2rrAr+O3PArG5FlkxqybL
 ujhb01gJJiNkCN9TyyQk4XkVvYBUKvgtEF70v0vXewLFWYCKjWLsdcZl9qbs7NQQZPQngLd/sa8
 =
X-Google-Smtp-Source: AGHT+IGtjatjgKKS4+NFlAR+rP6G9WMeqQIE4nbp/u955UPg9H2mBePaNuSFLlmgefH17KE2tSCgOw==
X-Received: by 2002:a05:600c:528b:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-442fefee1b8mr123261515e9.9.1747718555839; 
 Mon, 19 May 2025 22:22:35 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:35 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 15/24] kbuild: remove trailing semicolon from cmd_* passed to
 if_changed_rule
Date: Tue, 20 May 2025 08:21:26 +0300
Message-ID: <20250520052153.307194-16-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit e5d289100d3a ("kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 59ff37a53208..80caddde09ab 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -94,10 +94,10 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 # Linus' kernel sanity checking tool
 ifeq ($(KBUILD_CHECKSRC),1)
   quiet_cmd_checksrc       = CHECK   $<
-        cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+        cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 else ifeq ($(KBUILD_CHECKSRC),2)
   quiet_cmd_force_checksrc = CHECK   $<
-        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif
 
 # Do section mismatch analysis for each module/built-in.o
@@ -231,7 +231,7 @@ cmd_record_mcount =						\
 	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
-	fi;
+	fi
 endif # -record-mcount
 endif
 
-- 
2.49.0

