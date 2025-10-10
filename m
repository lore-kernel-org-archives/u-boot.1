Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29DFCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD64843C0;
	Fri, 10 Oct 2025 16:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C57nJVba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02F78445C; Fri, 10 Oct 2025 16:46:09 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E18D84258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-87a092251eeso32865436d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107566; x=1760712366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+LGmx3DAIwfpmLQe8jK7ffHnfYARHF7agHv8mNy5xY=;
 b=C57nJVbaBlA01cBcI8bmbn/g9HBWzfCPD56GhBJt3P94o73Fd/seDPQdMUQ0TyJmeo
 YzXDnNe1BL4zdlB+65+kNdZgFy2SFFde06oxb4AFvE5J0LWio1jy5B1hCIgwWvqmFepz
 dD1thGUaNpVOiaQr16JzlLdE1fzS9l506NPpI4o5FF76arzsjEvjXB/ecQ0xfMypxdBo
 3T3dZ4zegNGyZXyiNiLfhMnyDwuf4zNZbQBo64wvJV/5mOpyiJTk70SNPUc8s7o11W6Q
 k0RLkczTVt08whJoTbNq1glbwjzF55ELV43jK7ZAdDAmpQ0fsSy+lzP/i1f4neOOf0cI
 xo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107566; x=1760712366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+LGmx3DAIwfpmLQe8jK7ffHnfYARHF7agHv8mNy5xY=;
 b=Le5Ab9RE3jLbROnzj6WyB8BaQfw4t9/ZWm+GAHax5juRAB2k76oZFlMCEAyZG500/W
 +2GH3casNInY8rlIg9GUTMNnssc1Mv+qPuJBhDhaveFPmc5IUQVXGvBoK0YGo4pLCzn9
 jalEonruD1wMJOX6Fn2qXS350SOpjyyBaMv03zmUBSK6MbHjMJfv01LooEpA5FOZgj8u
 iO4p6b3xqOYJMz2x3FNZDBzrHqAwdcBS+p71nHMA18tZgryiTsCZ+eF/DWk76hUtyGFe
 ccLDyfHcNNog7tPJcC+HQdzQB0NgsfCBb+Gj1iNayfvA2ahEgjd1MamDOVoyq3Qrm8iX
 EIKg==
X-Gm-Message-State: AOJu0YwuiOI9xjaFHEwL/UqaERFEjkG2tO69e00YdCTTjW9T0/p1g3cg
 0ymLefU6zNlaZ3AkHMcYkV15zqYuALxCRydH49mP1WtTWyI7fFynt2Q3RMy7eBqh+slMFoX2c8t
 O01gN
X-Gm-Gg: ASbGncvibrW247YXlMalyEMJ3b4pAGCsMcPMj4iHZ5I2m66VXlO2o1nGLO9m2TE1KDA
 DqsBRrHeZac+O6onNIZPzUKhPnJgLMhWOEwlNp65CBOsL5btLV6H0xFSvwFsuX+KAouF0bsdpVh
 W3HWZbh4x1uStuZMeVfjKRnQxtpCX5pNdeiWo++y3m6/xkoLruW/WA1hrEUqbvEwLs39Fyj9ftL
 iT4g9nxEEzUQBiAeNeYdBapBqEAwG9VJK7MTGLBLMlnxcHWfItTHKlPH6a2I6Rk5Vhk99vEmDrw
 i4fXZcVJ+W3Fv3TLmhVIzEs4OF3BsMCrUyqX3e4Yp+UtoqJFaxwUaruJPBekA5cT3c3RnNScgZa
 KArBoAbwCLA21RlQr8w02vmoBoNdZH/SdzruyNU7xJRwm3JxGmoPhic8b8IMTRCGCGX3cEFnNb0
 swPGI=
X-Google-Smtp-Source: AGHT+IGTncWukOr45kL+hCHkT+rFK4AoZMtAg5Hh5YWpKCO+X6kv1wCg+kyBc5WtOAIxrQ5fqsf1Cg==
X-Received: by 2002:a05:6214:5018:b0:7e6:7392:f7df with SMTP id
 6a1803df08f44-87b3a784170mr152432566d6.6.1760107565504; 
 Fri, 10 Oct 2025 07:46:05 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:46:04 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 5/6] ci: rename conf.qemu_arm64_na to conf.qemu_arm64
Date: Fri, 10 Oct 2025 07:45:09 -0700
Message-Id: <20251010144517.3573014-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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

The test-hooks config file has been renamed by [1], thus update the
name where it is used by the script.

[1] https://lore.kernel.org/u-boot/20251003191918.767698-2-raymond.mao@linaro.org/

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3:
- Initial patch.

 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1382e4f6475..4bf4d9e763b 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -254,7 +254,7 @@ stages:
           git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 224485a2e64..5ae02176167 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,7 +39,7 @@ stages:
     - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
     # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-- 
2.25.1

