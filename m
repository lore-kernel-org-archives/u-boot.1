Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F30C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7519583631;
	Fri, 18 Jul 2025 10:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lT5TKXVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB5383622; Fri, 18 Jul 2025 10:30:24 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70868835D8
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-553be4d2fbfso1940601e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752827422; x=1753432222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGWhLEnxMtMWPD8KNMcWWfxyqmTmsuAIPhFVm58Tgm0=;
 b=lT5TKXVTkGTwpmmMrnUhahLJ6iVeAfHiJUx0owKamI9LXH4XaHs4Cr77joVZev32nW
 XfUUTTv9cI+2XlEBl+bfaA+hleUvr4roF4YEdE4hcoqRYjDbE7XF/1Lrr+Io9r+J5Z1g
 Y91UWu6ET+Iw9o3OKxa7dIcoOQ7q1V7/UZIMDOezML6pdLu2pr4PPMpW2XU3u3QJdL1G
 tAfidW2WuRewGM9wsp1A5XrMiYY3flS2BQVM/pbJeFAtmTBSx3qR5G0G6ugvMu4xdtR/
 ZLHj6RJO0ssiRHxppM82aArjpE8EW8RXZBiOtZLy5NLuwlRveWlLDmhr8TjUGB4nvovq
 17eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752827422; x=1753432222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGWhLEnxMtMWPD8KNMcWWfxyqmTmsuAIPhFVm58Tgm0=;
 b=shGTrA+aZvJ9DTIii6I4NtkiyLkLVsCfhlcpDjxr0lTzNAVZMX54ibHmyrAmE8N3JY
 01EPDcv4m+gfeVF09NryfRMXlC0G7lO0pG/LGbEjYmDbdkbcIlah5JypQFkOOdx8dIrT
 ediAKqdJ+vORsT94vIc+Wev2sOE8L3ghmRe3BaD0QJ1VlYt9WksbiptLs9/WLk8erXld
 6/q8V0CilVLPLVesA2rWqaLToTkXdzrl8wZiqKtiQolXwyHlwxjV/e193wTqxSXYhsU/
 /sI6fCMtzepU3Qx+RG7eiadFpIQBe4A58tLlPZjX2WpCqTePXNkzg3G7NlBBPsuH1dRf
 OyXA==
X-Gm-Message-State: AOJu0YzHJWuLnZu2kcrXFjIy+N/cJpikX0flndGyX0ZAnIJZncHGtrZg
 uPslW58q7+FA/IOSyoBvdsMB9HvLEDZoirNpdjK/UaEXnXX0upxc/ySBJmjPKI6ugBXmlh/KniL
 hXQEf
X-Gm-Gg: ASbGncuLNOeRg2++ddgu7EtMC/xA9UqkhKZbBbB1qFq5NrPie9hAky8jiBiNJw7cbFH
 tUD3yR0NJF/Gpf52TGfJisQtlqb69A7uhHhrGhb6HLaXudS8Kda1H+ElO+L1LMu9wMr13ZLYk4H
 KtAiEv0GtHyLfIfwdhmNse55Ecv2gbNvTm3KQjOJ8XFchbHaVOSzhOBqRB2dx6KWi7YsHKXGrgt
 nUjZIegoGUQ0uR2/7KI1lxLwhIDWx5PsUY9Cb6Cg/iwPLhBR/et+JkMqH/oL9nBp4iCLxxvW3wt
 hWx8RkE59b5F+t3VIZygWxgYnl9hZfalE0ODbSZaB0z35bqBKERyMJJJ9Pz4LwI4Fgq4BAZGUzg
 XrPJOu1ux7KZyFAI0l41Aa2YsiqyIezLBrTDTizR8uLE06YKDlg==
X-Google-Smtp-Source: AGHT+IHrO9A8Piv2v58JPsoI3yCMVDg3pFYALwtWKrbt2DZxweNlumKxRI+LIo69dVMkGCNQpd33tw==
X-Received: by 2002:ac2:4f13:0:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-55a23f6a3demr2783753e87.41.1752827421575; 
 Fri, 18 Jul 2025 01:30:21 -0700 (PDT)
Received: from nuoska (85-76-141-8-nat.elisa-mobile.fi. [85.76.141.8])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55a31a9b996sm175524e87.14.2025.07.18.01.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 01:30:21 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v3 2/2] efi_loader Makefile: change apps from "always" to
 "targets"
Date: Fri, 18 Jul 2025 11:29:59 +0300
Message-ID: <20250718082959.416152-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250718082959.416152-1-mikko.rapeli@linaro.org>
References: <20250718082959.416152-1-mikko.rapeli@linaro.org>
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

Adding delay to link commands in scripts/Makefile.build

@@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
 #
 ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
-cmd_link_l_target = rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
+cmd_link_l_target = rm -f $@; echo "HACK delaying lib-target"; sleep 10; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)

 $(lib-target): $(lib-y) FORCE
        $(call if_changed,link_l_target)
(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
@@ -362,7 +362,7 @@ targets += $(lib-target)
 endif

 quiet_cmd_link_multi-y = AR      $@
-cmd_link_multi-y = rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)
+cmd_link_multi-y = rm -f $@; echo "HACK delaying cmd_link_multi-y"; sleep 10; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)

 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m = $(cmd_link_multi-y)

exposes a build failure:

make[3]: *** No rule to make target 'lib/efi_loader/helloworld.efi', needed by '__build'.  Stop.
make[3]: *** Waiting for unfinished jobs....

This if fixed by using normal targets for .efi apps. The rules
in scripts/Makefile.lib handle the dependencies correctly.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 lib/efi_loader/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index cf050e5385dd..e929c23b1cb1 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -96,5 +96,5 @@ $(foreach f,$(apps-y),\
 	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
 	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
 
-always += $(foreach f,$(apps-y),$(f).efi)
+targets += $(foreach f,$(apps-y),$(f).efi)
 targets += $(foreach f,$(apps-y),$(f).o)
-- 
2.43.0

