Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5278BC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 16:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50B58056A;
	Sun, 16 Feb 2025 17:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbDrzQPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E78807E1; Sun, 16 Feb 2025 17:29:09 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858E4801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 17:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso7347066a91.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739723346; x=1740328146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7BvnnEtlGfieXjQBZfX0OBAJMemac8NLgw/Ft1Uw4fY=;
 b=RbDrzQPG26RFx74zjbK0jjfW026sBGkm/ueNQ3zwbmPx7mfjJWH8IEuFDI0nFz951b
 qhqP1P94wQI3xFOOZvNAdy9CJUZpWyjVKlFuDcKwf02V/O1R4P4J4mglNxnVa+pVQHza
 2SxXs87Vl3wSG9afQFs3a7trqj0wmRmp4fY5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739723346; x=1740328146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BvnnEtlGfieXjQBZfX0OBAJMemac8NLgw/Ft1Uw4fY=;
 b=R62ZFVgKOCanlP5MaiE0A+ocSB2gZj3qQQoagdvHkxdTGLTH/AMHwdFLqUOfU+H5r7
 TxLePtgJ5YD7wsuto4HCO3sx/HVhfJlp+QPN5kt377DvYLsxFV6zARiuOZW+yTL6QsRl
 plzedcZyT4TojR9PmlYOvzNEz571JQ37ETIAM0NilU4MvzDNi8SZAslKlXAHWXhol6zc
 J4uQJ7Z4jlWhO2CXlOvxmCPdzHRqvKmW8mLStqjHekdsoY8caOgTRm6vBsZz39So6dEW
 QbjOEolhnCPny5cUheUxyROzCPQzMvRhtPndNWf4MkuiRNLDcPUslLOtYF1Vw1zqK3iB
 Ghmw==
X-Gm-Message-State: AOJu0YwNWJDaUJK8uj84tj71kzf49g6n8nJif1IHeeqidlm6m6PwIeSL
 sXA2lyM/yKSAsi4CWOYoii0fWQvvwJWpRndfN5enCZvTghS14y2ZlXF6X3Pmi3ouxdXKrZo3spi
 P
X-Gm-Gg: ASbGnctBWo9mkWHsHZ9H8q1rMK2HmK5yMZHN16FT2UcN+7jo0NOmioOpUmfdmqxSWK0
 5BIjVNaUUVfm3GXM7oga/MkwMAUA2QEdf2G4cEiNmjRhp4GcNZIhgcxE2DQChGJXQersHlpmhLh
 KlSdVDbkyDnJ2fXXoP94b05HJnkhGd6o0McTpungeHVs9TkehchYdon2IbMVrb45Be5S7YRVX2k
 yIxvH/3xrbYsDQSbbYz4JtRTzyDPGQ6Px4SLDfiNeiCoYh76l8RCmYaNkjqcpCcBkjiPqR6lSf5
 B/oGmwKHPKHDlK+5
X-Google-Smtp-Source: AGHT+IGAtZutrdJ3BRaiPeEp9lOpHxxBkhmfqo3J0cxTkKRH6iXoIg1ulyV0PeYCegICv1ptDgRGtg==
X-Received: by 2002:a17:90b:1651:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-2fc40f0f08amr11511239a91.14.1739723346095; 
 Sun, 16 Feb 2025 08:29:06 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm57212565ad.64.2025.02.16.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 08:29:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] Gitlab: Add missing symlink for qemu_arm64_lwip boardenv file
Date: Sun, 16 Feb 2025 10:29:03 -0600
Message-ID: <20250216162903.211980-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When adding the symlink for the conf file so qemu_arm64_lwip uses
qemu_arm64 configuration information, the symlink for the boardenv file
was missed in Gitlab (but not Azure). Add that in now.

Fixes: fd10d156db3f ("CI: add qemu_arm64_lwip to the test matrix")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
I'll take this through my tree once reviewed, no need for a PR for just
this.

Cc: Jerome Forissier <jerome.forissier@linaro.org>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 920f61eaa099..46226eb2fc1e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -40,6 +40,7 @@ stages:
     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
     # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
     - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
     - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
-- 
2.43.0

