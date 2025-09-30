Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE64CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 11:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F074983045;
	Tue, 30 Sep 2025 13:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="JqieNa1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F32832AD; Tue, 30 Sep 2025 13:08:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65CF828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 13:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3e25a4bfd5so435492666b.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759230526; x=1759835326; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=faA/P2pAoFbSxuLsFKoVz1wR15SohTpKdSQpC8qiNiM=;
 b=JqieNa1++aLxi4GIu5yJ1sCsF5OEy+lNdjd6kSpGmcKZpfsd8Nt1P7mmMWtBdCWobO
 EuBQeC351sD3ovifQ6gf5NLz/d9rtZ9lQlxOHV8nhQ2YLCr/jn5UpDwcg9df2umVoEvy
 dIYLQaE5s1vWe1f6TZfxQapSHnzWJjA0U/4P8FRoNXFj2C07u5w3yFdKAh3emHkVhkq1
 IYdV543+ziACdnavcSNK6NZRbZ5PTjKoad9OJsF6j4H9dwBMlhPMsA9VJLkweXWjhxDq
 3oeb6/m9fNmKTikVe4EXdHlNSlRfTOkh7/9Sc8Z6JhNQF6+FJJL52VEv5fgjwcOLHPAz
 Eb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759230526; x=1759835326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=faA/P2pAoFbSxuLsFKoVz1wR15SohTpKdSQpC8qiNiM=;
 b=AVb5FhsELdWs2a6VZzz5VW+XDD2GdUi/l/TC39dx0+6Ba1J7EMjJofIVvTkD5q6Y7X
 v3c6HLSDqe4ABIJFPz/OZTf7hxvfpHrVImRAjdhfPPTH3VPjl2zM54YxRRbAtC8wbkIx
 ACl2L4hiOOlhUOsoKC6KBkk0/XN+gEHAc7EN+zjJNb6jSFvU0bjnuxnBza6Zd5fdLm16
 p6jSrTkRx71GF7G/oHzB8yRyjuMWouAucUP+kNGAHdIXAmZcng+L9N8M2JYkpWjMCZRh
 odyfqa+c4UeMC4B7c/M+CdsIesZXxq48qm9sB4uCTty97N6k7RkFKVaH18qku0AoZwuS
 wOrA==
X-Gm-Message-State: AOJu0YwYIynTvv2V+O/zGufPA9dem5ep55F3wI1bhSNcH26Ih4KRmNl2
 MkBBTCAWqVs1Faorb1eJS3n8fATvj76QUNH1aOQTcP61WGyhZqvSI3zugjiIHg==
X-Gm-Gg: ASbGncs7GK/TfwlyLSZNlXeDuzv6qhTdi9wIUpAFhSoDuV5B/seMuXJHatFfDP3Zeqr
 chKSvBW+DpU2dKX4h17CDOelco82YgA/IeVu0CwNoAxRKlMN6G0wqnsLnGQMRf9WYJ7pDLzrH4Y
 jDoTZKl+cxYKAH3KOE8y9lVY9MFR+5JvI/w86xo9y4YNYpzbLo1x8ryphW7uBpZKriRNRrOPw1L
 ApYeqfjsS7ksQa0uRWA+znHqwy5q5liBRoNOG9P1ryo/sBtueiKVoFRBikB5JE5J/4IkoD/BVAI
 JNn2l9T5kGTuVLikzMSwXTV28YFr3L0KABiQ0IItYKUUSNCWy/2sGo517fSl42UfTRCeosWRhqi
 XNiHqfnLb5cIfjuyNc/SM53UGY8tMrW6BHRcPsVUnDISR45chbJRGwtej/NaOQWUdiegSv+VQZE
 Ek/PvxHf4/AH17ZN3sWCxiWcf00vNPAzO1viCinZath2HQkr9w
X-Google-Smtp-Source: AGHT+IHBPBmHECK4sesOaPJyDIADNfFm8pQ0MhsvEUDTXYn8/CJnpwfZKu4eeDjcfpCpLKAD4TfzDQ==
X-Received: by 2002:a17:907:608c:b0:b3c:3c8e:1886 with SMTP id
 a640c23a62f3a-b3c3c8e23c5mr1141623266b.4.1759230525531; 
 Tue, 30 Sep 2025 04:08:45 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f753csm1123101766b.55.2025.09.30.04.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 04:08:45 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] doc: develop: fix grammar and syntax
Date: Tue, 30 Sep 2025 13:08:39 +0200
Message-Id: <20250930110839.3470553-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 doc/develop/devicetree/control.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 8811e1d5c23..c25b98683f8 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -79,7 +79,7 @@ regularly synced with the Linux kernel and hence no need for manual devicetree
 sync. You may find that the `dts/upstream/` already has a suitable devicetree
 file for your board. Look in `dts/upstream/src/<arch>/<vendor>`.
 
-If not you might find other boards with suitable files that you can
+If not, you might find other boards with suitable files that you can
 modify to your needs. Look in the board directories for files with a
 .dts extension.
 
@@ -98,7 +98,7 @@ Linux kernel release. To sync the `dts/upstream/` subtree, run::
 
     ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
 
-If required it is also possible to cherry-pick fixes from the
+If required, it is also possible to cherry-pick fixes from the
 devicetree-rebasing repository prior to next sync, usage::
 
     ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
@@ -192,7 +192,7 @@ With `dts/upstream` Git subtree, it is ensured that devicetree files in U-Boot
 are an exact copy of those in Linux kernel available under
 `dts/upstream/src/<arch>/<vendor>`.
 
-U-Boot is of course a very different project from Linux, e.g. it operates under
+U-Boot is, of course, a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
 full clock driver with Common Clock Format (CCF) to find the input clock to the
 UART, U-Boot typically wants to output a banner as early as possible before too
@@ -212,7 +212,7 @@ order::
    <CONFIG_SYS_VENDOR>-u-boot.dtsi
    u-boot.dtsi
 
-Only one of these is selected but of course you can #include another one within
+Only one of these is selected, but, of course, you can #include another one within
 that file, to create a hierarchy of shared files.
 
 
@@ -309,8 +309,8 @@ Limitations
 Devicetrees can help reduce the complexity of supporting variants of boards
 which use the same SOC / CPU.
 
-However U-Boot is designed to build for a single architecture type and CPU
-type. So for example it is not possible to build a single ARM binary
+However, U-Boot is designed to build for a single architecture type and CPU
+type. So, for example, it is not possible to build a single ARM binary
 which runs on your AT91 and OMAP boards, relying on an fdt to configure
 the various features. This is because you must select one of
 the CPU families within arch/arm/cpu/arm926ejs (omap or at91) at build
@@ -328,7 +328,7 @@ files are pulled in, and the fdt controls *how* those files work.
 History
 -------
 
-U-Boot configuration was previous done using CONFIG options in the board
+U-Boot configuration was previously done using CONFIG options in the board
 config file. This eventually got out of hand with nearly 10,000 options.
 
 U-Boot adopted devicetrees around the same time as Linux and early boards
-- 
2.34.1

