Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D6C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B2882CBB;
	Wed, 11 Jun 2025 22:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bKgWKNS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B8582D21; Wed, 11 Jun 2025 22:25:24 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A7282CE7
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4508287895dso9010345e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673521; x=1750278321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NazrwjVIXY0tpunC+kHC+JzNkeztpVpyuL3jYJej9RQ=;
 b=bKgWKNS9FLj6uOBHn1SmKC8gH7IPPCoqSZsyCqWcI7vOhxMQzW2E0q+n/PNftoaatW
 li6Lnp6xk+yTBjWEuhit8Mwd/CWy2wLLUTjZ1KP5IBP+FgZ52Ug6b6+jNL//Sf0qr5DX
 Fty/AG2q9QiYjLUjXxvp33bjDEef+pjdZLGHbBfs3a0Hq1l5dULBi4+7xADJUbpd+2dY
 LqZo/Ly+5GGR8tyxmHXBAtC0v7Iua4YvbDl6Dy9vjmHm8NYfmgr14oGsLRuhFqV45lqS
 AWZkHCGP4R5O/T9dw3eKKaxkCYzdB6GLty3Mm01sdfauX/nV9dh3SuH3R3Ca0NH1+FJv
 mFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673521; x=1750278321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NazrwjVIXY0tpunC+kHC+JzNkeztpVpyuL3jYJej9RQ=;
 b=QjaDJAQWJlQU+MEMmGqi1R+vvFEn3mbxtZxf94JfvJwgg00kmWgP3DFf5Jew/vGzWA
 0SwiXqocAYN9vOP+AADdFl1rHPmM+zAN9BEGK/ySIpOqr0zN/0q/d+/ZgQgPkDyF2JrD
 QyIvm5oJ4Q1w3tMhPIEptc8Y2ru1epLdJ7+w0VHzWQrHINwQ7bZ8RWr+Z45lEgGyCHwA
 0hfpB6WJxKvEFi7saHRfZCO+wSOi1XLSeoztW/RK5n1It70Mpyfo2ygFbjRHZIdeIwH8
 9Q4JLXFa3LA0nU8q37oaLSDltVlbnKn+27DQ3mA3Uyg61pKyu6hhN+jGXvLxg9STAze1
 v/nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCy0Ajyrp+VCTLvD1OHZnFWHVaCRmLnNA6qnODUjWlkiMEQazivjkibVDbuZHt7wgBNquLMg0=@lists.denx.de
X-Gm-Message-State: AOJu0YxJcxnBApg8daWJSIp9hq5nSA1NVk0+lw/sYRQnblYYDL6WbGzO
 qpvgPS5/6WBwEIdkqD3Ltla+oBiedVAFqLzRQXTEoOhbIKYrrqIIvoo/pAvRmVMd7P4=
X-Gm-Gg: ASbGncvEW1bhuGzCXdn/Q0UKvE9G4e+sJimuJUB6Inq4O5XF1gvJL5j2bBae1CvWhKa
 qvJO54vyOmSiCD1pfcHOqbnMYVdsrm0kuk10SgyMqZdQb/igV6JYVGDcGZXszzQm7ufcR3jue/U
 0x1kR4Hek5v35DuvYYqYPNJ7XnfBq/RL3aKA6nuLgLJ5cPO36InvBRUvtZBvV3tG50RePeenbhW
 2j2IqGmNrafwyMBtaV0FHCHkwXlEAe7AEZNo9Pu0OdvA9RQX3KrhdlwVG6HYQoU7XWMFrkiCTC3
 OCGVSFf3pEFmsdBmYaUKZffwlnA4C6OpCZ+Mg2PO1ALmgEoUf5cuFClsXyZmZYuNh6zd1H+txsF
 +iCuvzmKEgqLDx5gzBqVgM1aql/EstbZypgMNNdQn
X-Google-Smtp-Source: AGHT+IHt7USnRP9JI7XzbZneYrLvHMCgAXWkQyTs6CVAGYzXKVdkz4/46WfHzxsQmtCYzrTcDmBvHQ==
X-Received: by 2002:a5d:64c8:0:b0:3a5:298a:3214 with SMTP id
 ffacd0b85a97d-3a5608a0302mr569132f8f.13.1749673521354; 
 Wed, 11 Jun 2025 13:25:21 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:20 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 12/13] kbuild: make 'archprepare' depend on 'scripts'
Date: Wed, 11 Jun 2025 23:24:39 +0300
Message-ID: <20250611202449.2317279-13-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 059bc9fc375e ("kbuild: make 'archprepare' depend on 'scripts'")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index a31e89d77490..af8129ccc884 100644
--- a/Makefile
+++ b/Makefile
@@ -1922,7 +1922,7 @@ $(sort $(u-boot-init) $(u-boot-main)): $(u-boot-dirs) ;
 # Error messages still appears in the original language
 
 PHONY += $(u-boot-dirs)
-$(u-boot-dirs): prepare scripts
+$(u-boot-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@
 
 tools: prepare
@@ -1979,7 +1979,7 @@ prepare1: $(defaultenv_h)
 envtools: $(defaultenv_h)
 endif
 
-archprepare: prepare1 scripts_basic
+archprepare: prepare1 scripts
 
 prepare0: archprepare FORCE
 	$(Q)$(MAKE) $(build)=.
@@ -2486,31 +2486,31 @@ else
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
-%.s: %.c prepare scripts FORCE
+%.s: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare scripts FORCE
+%.i: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare scripts FORCE
+%.o: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare scripts FORCE
+%.lst: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare scripts FORCE
+%.s: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare scripts FORCE
+%.o: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare scripts FORCE
+%.symtypes: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
-/: prepare scripts FORCE
+/: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-%/: prepare scripts FORCE
+%/: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-%.ko: prepare scripts FORCE
+%.ko: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
-- 
2.49.0

