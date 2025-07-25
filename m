Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE99C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3D483993;
	Fri, 25 Jul 2025 17:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E4szYwih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91448839B5; Fri, 25 Jul 2025 17:18:27 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3538398B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-302effd5978so1110842fac.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753456703; x=1754061503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M0fVnaA0RMfzeh8sePmf/f+dbgiGwMFy9UbMKdfGvcA=;
 b=E4szYwihxxCp/HT6Xhzt+f46a8UO76w5YJLF/X5fnGSwd8Mwyfb/p0kno89z/dwKZb
 KWmkl8L41iy5Z5quzayObIpQz5HHnjyiKyw0eJeuoa4ixCdFccAYITnsSSpiqEpQfMnk
 8tfTFpaCvsprSsorwcz3SB0IJ81JBBDs4QE00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753456703; x=1754061503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0fVnaA0RMfzeh8sePmf/f+dbgiGwMFy9UbMKdfGvcA=;
 b=GxnWcnl2qf+ItijMzvAq3EHMSxiYdDoEvDkyV8quKzamjZbGwd6DGo2zNVRa+NjYLq
 Nwx5iAkw0T+6fBsErPsi0qLIFK6SNh8u3sQIHKO5XovyyQKeB3PaUweMJ7RBkEBiltv5
 LEUzyLD0iF/hGzn9uGwCelFVPipZXmE9qd791h82sa5ssDWYeH3YEB+rHl7roQr2ufeX
 9kpnoUGntYe0G5hr9drakJZrtSCr4Z+D3LFRB0z3It5MjylOaD1jypxY4VP/+6uLsdhs
 I7jo+wgzpV10Zx/lR2DLPjMhIyYxB3r4MtM16dw3uBkYFcuGspQyZsuxeV1fU8vBZyp5
 AYDQ==
X-Gm-Message-State: AOJu0YxL7otBlzQKDx1DNmio/M5K0UAUHVIBIblVHWd94dpbQqZJtCD/
 z3Ljs5yqLdF33F+1xKDHUyRTAshSTNAJsmYEUFK4t+dys/ZOjX8aJOHTN+KyXikDeCfJdkMi5WY
 IKxnwK5g=
X-Gm-Gg: ASbGnct4VBSksH/fkt0NfPeYQ8r8/jzgwsCnXykcwKaL0eyHCi27VYreZcnQRkU4qZr
 JTAv8N9MzEJufsbasftpX4Jvy7JwMoGmk/B5CIUOmRQA06y64rVzlsZsn3USJXjdHtsJ13tGKio
 /WZ1xbyWwuS/VUa5/tJIJoTOzgMa+IQOcuXAKqj3Gt78aQBW2/F1y+XPXGxfFW3AdeMxdpYqa8q
 JQgQ2xk58q0PjhHp/hNWMUmOHFSKyRc6D0cEOkxy5uk1jeqnt+kM31dQTOVyzZTHonG2h/y1sMm
 YCui4VkO3HkV+QKCEqDC22E4KP8mcp+NmDX7gUNqbTea+gabK4U2Cn1BtygB15TZUUTElBzeYxb
 lNVMSo4iv07g+3ONMNEq6jlQfhFEeU4SDJx/IISeACzXkMORL4hsfdWH/5rA=
X-Google-Smtp-Source: AGHT+IGkZhfMvIYXgye5eAZAO459xf1uvN1/RhmGARmMK8F8ZZtDUTsJGvZd0iP3qIm9bPFQF7vabg==
X-Received: by 2002:a05:6870:f20c:b0:2e4:4617:f6e1 with SMTP id
 586e51a60fabf-30701f50a97mr1613811fac.2.1753456703586; 
 Fri, 25 Jul 2025 08:18:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f7b0e7sm1113696fac.40.2025.07.25.08.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:18:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH] pylibfdt: setup.py: Drop license_files
Date: Fri, 25 Jul 2025 09:18:21 -0600
Message-ID: <20250725151821.2067853-1-trini@konsulko.com>
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

On more recent versions of setuptools the warning about not being able
to find the files specified in license_files has re-appeared. This is
because as best I can tell, it can't and won't look in $(srctree) but
rather only subdirectories of scripts/dtc/pylibfdt. Since we already
provide both SPDX tags and a license field with the SPDX contents, let
us just drop license_files as it's not mandatory.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Bryan Brattlof <bb@ti.com>
---
 scripts/dtc/pylibfdt/setup.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
index 0f7485de9b50..fb2106be0f07 100755
--- a/scripts/dtc/pylibfdt/setup.py
+++ b/scripts/dtc/pylibfdt/setup.py
@@ -158,7 +158,6 @@ setup(
     long_description_content_type="text/plain",
     url="https://git.kernel.org/pub/scm/utils/dtc/dtc.git",
     license="GPL-2.0-or-later OR BSD-2-Clause",
-    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2-clause.txt"],
 
     classifiers=[
         "Programming Language :: Python :: 3",
-- 
2.43.0

