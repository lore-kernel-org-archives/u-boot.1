Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B332FEEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C276B86951;
	Fri, 15 Sep 2023 02:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jPh6b/Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4459869F6; Fri, 15 Sep 2023 02:23:01 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7D086886
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79a7dc97aa2so57249139f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737378; x=1695342178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uup56YIDY9ZE1lqhpEMh4JZWrIEFuly//oTm0tE+70A=;
 b=jPh6b/QmnkizL0Sv0yIBhsxBymqJx6Y9Jl0yxKFi0zMNhI8betZfxHuL4HHORhEmaj
 MscGqIacsT0gOqF3G4+G34WV7Ux8b6Lq5klPODCXp/UnGhNb2ulYxLjccazHpAGaWPwO
 CrqexSipy5y0ZAndIUghpzBqoGJpnS02VJklg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737378; x=1695342178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uup56YIDY9ZE1lqhpEMh4JZWrIEFuly//oTm0tE+70A=;
 b=MCA9l8xOznPLY+0IIHJn+jsbIZ8YqYem9xBtO2fLOUNOpfjSVIPp9bQd/0ZqhAg9Uw
 EeiSgxtslQ+olp6Y7SbmzBd0uJNr/j44av9lgh1Se1JQ2TQ/qPZwFNN2KObCPPRMwACR
 0KWHsper+K16HF0Fb2dyh+Vl5+mD44Ld/bZui4QTGr6RFI1n/IeGG97H4WGl+mLeIp4h
 9AxwsNC95cjyHfashPadSO30mN1k2uVH/cmnyCeQFqinqT9eT1qXcCSK8C1TSx6X/PdT
 xUFOiP4t5Zd7zBSc6Yv3vevh/nWfzbxmrqAJQryDsgdwUGRAcnWNe5qmek8drf/BfPQj
 XiiA==
X-Gm-Message-State: AOJu0Yzv1XVdo7q/JIyZhL8jlvpmUXUwN/FebKscmzqwkpGQfXuICVmb
 iwFC1xj0NDsJ/5gha6yGd9d5x0GtWzI0eTrAoEg=
X-Google-Smtp-Source: AGHT+IGvbTUcXH5JK1A91P3s6yy10+MC/vYnrcxjNcw5eS0lwGqwIKJ6aDKbHnyism8hzpnkoBs3xg==
X-Received: by 2002:a5d:8484:0:b0:791:2194:10a3 with SMTP id
 t4-20020a5d8484000000b00791219410a3mr19272iom.14.1694737378352; 
 Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/27] moveconfig: Correct list-comprehension warnings
Date: Thu, 14 Sep 2023 18:22:16 -0600
Message-ID: <20230915002236.798760-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Correct some pylint warnings about needing to use list comprehension.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 1dff89159312..d46433c6d8f5 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1422,12 +1422,12 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options present in Makefiles but not Kconfig (SPL):')
     not_found = check_not_found(all_uses, MODE_SPL)
     show_uses(not_found)
-    spl_not_found |= set([is_not_proper(key) or key for key in not_found.keys()])
+    spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
     print('\nCONFIG options used as Proper in Makefiles but without a non-SPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= set([key for key in not_found.keys()])
+    proper_not_found |= {not_found.keys()}
 
     # Scan the source code
     all_uses, _ = scan_src_files(src_list)
@@ -1440,12 +1440,12 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options present in source but not Kconfig (SPL):')
     not_found = check_not_found(all_uses, MODE_SPL)
     show_uses(not_found)
-    spl_not_found |= set([is_not_proper(key) or key for key in not_found.keys()])
+    spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
     print('\nCONFIG options used as Proper in source but without a non-SPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= set([key for key in not_found.keys()])
+    proper_not_found |= {not_found.keys()}
 
     print('\nCONFIG options used as SPL but without an SPL_ variant:')
     for item in sorted(spl_not_found):
-- 
2.42.0.459.ge4e396fd5e-goog

