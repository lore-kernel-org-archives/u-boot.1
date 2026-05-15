Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD4CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3B4846FA;
	Fri, 15 May 2026 16:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KOqu2HH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D914A846FC; Fri, 15 May 2026 16:59:48 +0200 (CEST)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 667E4846CC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-439b2aad735so2204490fac.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778857184; x=1779461984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ni5LFjChazqcS4fv15PFmUyW42Q22CywErD1XezhL3s=;
 b=KOqu2HH6V934Lt7QkySy5LdLs95oITYp9Dt42gTW/CJsigvLvJYZVIZVsyfhVtOG4y
 sLG4pva4g2QJ0MdqtaMll+2FcZ/4pIX5+69KSWEsaCsMm0ncM6mXbeA1H8vEi43QTIeo
 qpOseAD1S+UFN40YlX+nREUXDdjZTMnJTdtwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857184; x=1779461984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ni5LFjChazqcS4fv15PFmUyW42Q22CywErD1XezhL3s=;
 b=oTbo58/7zyK3nVIRiBFvqgfGFum1auWlG5YtX/o9G3amwAQ2WVj5/AocKp6yfxT8lo
 vU2MeTSd8OnYp1Rgnkbcz3PcR3vUpm+F3HcwIv1PjNKRav3BTatiNEHquL/JaTQ8YW8n
 SEi+tqbJwurJhTgHjQAzyGgxma+VDCSYbiZ1fWlOYDHsVdwhAwNYyvC5AG4jPvM1lHyi
 V8y6Dj/ohuy0/Oje6wI39zbNd+R68s7HCl3poMExXg3zS5BxUsUMaeN7O4E4Dj9KmANb
 TWqnRzIQ0KIaIqlCqwcS0PLFemEhLJ6o0aVdPxQvRUd9bfMEEKLD2IqT2jxQiGmoh3kx
 oCJw==
X-Gm-Message-State: AOJu0YzapfgCMRzTINnG4bcIgVceMm7wphSHvN/bVYfBbgUjoZc+9JXt
 pvlxaPZF67Q1Xxbc+O8SfOQOcDwK5M/oUo/FbC94bvK3UgsflxOUlaj94eso6eqIIzHoT0cEnCM
 zHAqdA1pVo81qFIM=
X-Gm-Gg: Acq92OHiufEKOK3o2SvDGO0Nl1TOPE1h6FuZNHWvkOAXTrN9Fg/l+KXTZzI/hPJY/8m
 drsFT7bGS5UfQQjgiOqeMc8vwSEMpozWo6r9g1pVC1fXbN9Kr2RHX5UVgBIFi/lBIXPKcGtikJL
 hvLXtFSoFb8j4w9QKHEqnehmvj91IM1ugj0yhVwg3d88NaWGxGQJEOq1ZWgrFfAvKt6kM1NKaeY
 vIClwLw2jsuPs3JI5xgsFUtTQu85/UoyxGL1xUgsIM9w+fVBtsLAwL67XX86FiUC6I0E+Xs3ciR
 4QrAXRb8h0BhEzmg3AJQkunGtfHL+8P76hV61O7fCXATJZMAgi7vvB5wa3SRf39fD+F5ed1Qjy8
 t4EcH9Ygtd4/ekqGSu96F9AYzY6vyMeNZtc9RxaYYHAQCnf+PdOKBm9c2dn/lx+U+a6Qx9QY7km
 hl8MkXlQZDHIGSquOXflptTMbqxWnPF9eaX02a4MEYQCNfmvYCZ2CTjh1e40YXAolMKmdBkblBp
 A+21jsGIfbNXJnHmCeZ51kjQtrjdJN1sutSQUWupSg2ipn3xx0RgcFaiFIPqud0g+ZHgUASB6Ck
 4pqWwv9L2w==
X-Received: by 2002:a05:6870:b3e1:b0:430:12f7:71cd with SMTP id
 586e51a60fabf-43a2dd74cb4mr2937288fac.23.1778857183928; 
 Fri, 15 May 2026 07:59:43 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc4dcb89sm4380002fac.12.2026.05.15.07.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:59:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eddie Kovsky <ekovsky@redhat.com>
Subject: [PATCH] Azure CI: Drop Windows host tools builds
Date: Fri, 15 May 2026 08:59:40 -0600
Message-ID: <20260515145942.133279-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In preparation for being able to support more recent OpenSSL versions,
we need to add support for the OpenSSL Provider API. This in turn isn't
something that MSYS has all of the required packages to support. Given a
lack of user feedback that these tools are still used in this manner,
remove Windows host tool builds from CI.

Link: https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.com/
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is intended for the next branch, and to allow for a more visible
part of the removal to be made now. This means v2026.07 will be the last
version to support MSYS for host tool builds.
---
 .azure-pipelines.yml | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4417ef4e5a50..b2a59bafa83d 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -1,5 +1,4 @@
 variables:
-  windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
   ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
@@ -44,33 +43,6 @@ variables:
 stages:
 - stage: testsuites
   jobs:
-  - job: tools_only_windows
-    displayName: 'Ensure host tools build for Windows'
-    pool:
-      vmImage: $(windows_vm)
-    steps:
-      - powershell: |
-          (New-Object Net.WebClient).DownloadFile("https://github.com/msys2/msys2-installer/releases/download/2021-06-04/msys2-base-x86_64-20210604.sfx.exe", "sfx.exe")
-        displayName: 'Install MSYS2'
-      - script: |
-          sfx.exe -y -o%CD:~0,2%\
-          %CD:~0,2%\msys64\usr\bin\bash -lc " "
-          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
-          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
-        displayName: 'Update MSYS2'
-      - script: |
-          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm --needed -Sy make gcc bison flex diffutils openssl-devel libgnutls-devel libutil-linux-devel"
-        displayName: 'Install Toolchain'
-      - script: |
-          echo make tools-only_defconfig tools-only > build-tools.sh
-          %CD:~0,2%\msys64\usr\bin\bash -lc "bash build-tools.sh"
-        displayName: 'Build Host Tools'
-        env:
-          # Tell MSYS2 we need a POSIX emulation layer
-          MSYSTEM: MSYS
-          # Tell MSYS2 not to ‘cd’ our startup directory to HOME
-          CHERE_INVOKING: yes
-
   - job: tools_only_macOS
     displayName: 'Ensure host tools build for macOS X'
     pool:
-- 
2.43.0

