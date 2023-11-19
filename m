Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806E9C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5117869CA;
	Sun, 19 Nov 2023 16:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jhpjj2bo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134328709F; Sun, 19 Nov 2023 16:18:25 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6A1869CA
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so151231739f.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700407092; x=1701011892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0NQ04ndN6cWKjU49TOPtrv6NQ/SXg1v4zYRvaPe2f5c=;
 b=jhpjj2boD/IIlWT8CEx4in8JIvNwqhOETrIoAYNlWTkelDWLhtCHW4hJWe9vZ1dwqO
 IVfsxNIuFGe/1E8SaN5FFjPBZ1bwyyUhzeomVVa70GE+8nTUeyMAu83C/13A7aKW69Aj
 WEat7OLVWSUJ70mE8lowAwJHN2UwuPwLc0yqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700407092; x=1701011892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0NQ04ndN6cWKjU49TOPtrv6NQ/SXg1v4zYRvaPe2f5c=;
 b=wzIrfpJw9wk9RctLMFAhW+NEfxiMcDtbXTtFIsIc4cSTJ0BWN7PjThPb80bi9WJV2V
 LQMhuqLdS/lCpSKg1oYPrkbXX8AO5k3wsLMnemNgce5leJMy89ePLJm9Tj25sLK7x7Nl
 nE65S9PnB5yP+tfR+rm4YYX7YetVO3RjvLhnWIPD43hwYAnW/KoSfisPUZu3lcJq4+UP
 BZkpfK1110KPEoANV4YCVlwLGUBgeIEaq3olQJEIP1VMhaK7PcXUAlWzQp01SYdoz+sA
 kaV0RTq5rpezpYGo9PM6MOwiObsNe4xBEhttVkurpWhL2p6iB2Q2wQj3pr/AZ67YYo8e
 +TdA==
X-Gm-Message-State: AOJu0YwzkHGaEIcCfJYSdzZLo/wHce+W/aFs2Va/rsoTdp6GEg2JfLOc
 tF9o4hoxwFdpf7vc8atuw6iThV4wZWPj8rO+k1VwwA==
X-Google-Smtp-Source: AGHT+IHGZVa7l+FOzzT3jJ+l4cqyciBfRFl40sd7sR1d880UD8EHBXoUTizdStnqYRVHxjZi+P2U/Q==
X-Received: by 2002:a6b:c813:0:b0:7ab:b09c:d996 with SMTP id
 y19-20020a6bc813000000b007abb09cd996mr6575455iof.14.1700407092542; 
 Sun, 19 Nov 2023 07:18:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 fh4-20020a056638628400b00458318fd302sm1524264jab.89.2023.11.19.07.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:18:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v2] sandbox: Fix VPL instructions
Date: Sun, 19 Nov 2023 08:18:07 -0700
Message-ID: <20231119151809.637002-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

Fix the devicetree used with sandbox. This is needed because the
default (full) devicetree must be used by all phases of boot, with
sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Assume a build in the source directory
- Add a trace of it running
- Add explicit build instructions

 doc/arch/sandbox/sandbox.rst | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 23902dee89e7..5f8db126657f 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -424,15 +424,59 @@ space. See existing code for examples.
 VPL (Verifying Program Loader)
 ------------------------------
 
-Sandbox provides an example build of vpl called `sandbox_vpl`. This can be run
-using::
+Sandbox provides an example build of vpl called `sandbox_vpl`. To build it:
 
-   /path/to/sandbox_vpl/tpl/u-boot-tpl -D
+.. code-block:: bash
+
+   make sandbox_vpl_defconfig all
+
+This can be run using:
+
+.. code-block:: bash
+
+   ./tpl/u-boot-tpl -d u-boot.dtb
 
 It starts up TPL (first-stage init), then VPL, then runs SPL and finally U-Boot
 proper, following the normal flow for a verified boot. At present, no
 verification is actually implemented.
 
+Here is an example trace::
+
+   U-Boot TPL 2024.01-rc2-00129 (Nov 19 2023 - 08:10:12 -0700)
+   Trying to boot from sandbox_image
+   Trying to boot from sandbox_file
+
+   U-Boot VPL 2024.01-rc2-00129 (Nov 19 2023 - 08:10:12 -0700)
+   Trying to boot from vbe_simple
+   Trying to boot from sandbox_image
+   Trying to boot from sandbox_file
+
+   U-Boot SPL 2024.01-rc2-00129 (Nov 19 2023 - 08:10:12 -0700)
+   Trying to boot from vbe_simple
+   Trying to boot from sandbox_image
+   Trying to boot from sandbox_file
+
+
+   U-Boot 2024.01-rc2-00129 (Nov 19 2023 - 08:10:12 -0700)
+
+   Reset Status: COLD
+   Model: sandbox
+   DRAM:  256 MiB
+   using memory 0x1b576000-0x1f578000 for malloc()
+
+   Warning: host_lo MAC addresses don't match:
+   Address in ROM is		96:cd:ef:82:78:51
+   Address in environment is	02:00:11:22:33:44
+   Core:  103 devices, 51 uclasses, devicetree: board
+   MMC:
+   Loading Environment from nowhere... OK
+   In:    serial,cros-ec-keyb,usbkbd
+   Out:   serial,vidconsole
+   Err:   serial,vidconsole
+   Model: sandbox
+   Net:   eth0: host_lo, eth1: host_enp14s0, eth2: host_eth6, eth3: host_wlp15s0, eth4: host_virbr0, eth5: host_docker0, eth6: eth@10002000
+   Hit any key to stop autoboot:  1
+
 
 Debugging the init sequence
 ---------------------------
-- 
2.43.0.rc0.421.g78406f8d94-goog

