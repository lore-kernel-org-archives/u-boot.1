Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AA5C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C31869B6;
	Wed, 25 Oct 2023 00:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nvhkgPHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0818689A; Wed, 25 Oct 2023 00:15:48 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63674868D1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5FB853F722; 
 Tue, 24 Oct 2023 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698185742;
 bh=rGjIFaIPXWxYq2E1gdQc5eToAsombONbjHq+EuNy6vY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=nvhkgPHi+ln0F8RSriz8/+XptnvHl8CnQdtha8eVPEPW7CDb3XNv98rFhrIaud8AZ
 15o2R0b4CLDMffFr5DX5Z0SjghvwVn0h/wAldPwEQu88ciNIWvH1YL37h50Z9Uf6nB
 cllhnPiwAiJMUls2kqNSCUzyG+wujceYrLWUc8eH0uCvQA3pUv2x3uiRqko0o8moVB
 q8bnfiNhu5uO/qo5MUK2XcyigGLGe0muenq7OuREWKvVLvFoKl/jotDB+t7+V+q5KF
 sq07Zosh3C+mL2IAaTQeSvt9NjzXS4p7nuiDluxQcMxvYGN0P/W14zUPtQ6QJHWusW
 pxT+lt44aC8uw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] CI: use OpenSBI 1.3.1 for testing
Date: Wed, 25 Oct 2023 00:15:43 +0200
Message-Id: <20231024221543.11422-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Use the most recent upstream release of OpenSBI for CI testing.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .azure-pipelines.yml | 8 ++++----
 .gitlab-ci.yml       | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 6f91553e86..d3ecb7c802 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -203,12 +203,12 @@ stages:
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
           grub-mkimage --prefix=\"\" -o ~/grub_x64.efi -O x86_64-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
           if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
-              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
+              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
+              export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
           fi
           if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
-              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
+              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
+              export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6decdfdee3..27065a7ce7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -32,12 +32,12 @@ stages:
     - grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
     - grub-mkimage --prefix="" -o ~/grub_x64.efi -O x86_64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
     - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
-        wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-        export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
+        wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
+        export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
       fi
     - if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
-        wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-        export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
+        wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
+        export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
 
   after_script:
-- 
2.40.1

