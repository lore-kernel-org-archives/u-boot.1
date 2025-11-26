Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E39BD111BD
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 23:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134D484284;
	Thu, 27 Nov 2025 00:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rLEtz2Yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8734B84284; Thu, 27 Nov 2025 00:50:07 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F9C84284
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 00:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75178c05fso110562a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764201003; x=1764805803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rT1MkjG7hS+ATp3ghRcb/46jaVY+w+lhBuj5Oj6alaE=;
 b=rLEtz2YgdH5s8+Uo92CoHe48jDPyRWf8wFLfvNGmoprCweXGgwar0yo5xWL+fOLgUW
 /VPnBw2NwCnTpp00Fhqfa+zggGUEsn3Wk4k4g3re7wX2WB0YD+YJ4Y3gtDOMfdh5VuSz
 iXt56bubfUaoPnJdpU+WThRCsh4JVM6JGrsSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764201003; x=1764805803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rT1MkjG7hS+ATp3ghRcb/46jaVY+w+lhBuj5Oj6alaE=;
 b=KjRzhMcAyo/DWoy5B8J4ke2H3YhNkxbjgS/b8egfFsBaWPu7p7hqt/vjq+wmi49CTp
 qduPIFCqwj0k7KfvR/HnLp4zooAWWph51ynsElWVRClqlgCcwzH7pdEsL2bKygBh3NrN
 3C1RBB5YpSD7dGzqsgUiTWnGkSFAh8jkAQc357zlGB1U+FxooprBH+reCcL3Y9qU/Tki
 MF4DNnVCE54z+JGv3K2Y40015RkkQMkwEoiH390VgKEuyufcGkpbT5mnSiq7AP15ZShC
 o6DLD/elRhbH+HFvVMMdJDA51h1vfZMHSfNYJSDlNbX2lCFTtlDcU/dFZIFnzPfUhpRR
 G2Eg==
X-Gm-Message-State: AOJu0Yypq68dR2ZswkEfi0NAuNr99nQTJXSzDWl4ObwUpPdKbBZv/lmA
 /S5O4RvJACjjhlwhBK9vZIGdTka5IFUdgdQf4paYciE3ixG79iwSPm90LTfCZ3ZAAUNfaoj3DkN
 /Lo5b3GY=
X-Gm-Gg: ASbGnctM2kX8Lj6HJGK93XKIeQzBKgS2vwfruzdCZ/9PLLbf6oYswOe2N32iOr6oJw8
 7Q/cRVWeHav7k+67/LLEVjJkPa57AFFpGbquLOP3klMUPDhYWvji4VFJlBJKDPCakQyySNBYt8q
 F7o6xtdBYWNO4bE/i+zcv5Vytragy620FJ57v5jrSDcoiOXZqA4uBScdA5LWY/c5DQDHY1GMh7v
 qsy/XidP1o0unfFpQeEEPkj1VH1mtUVKp7ScjPehphtW7A7NOWy7vP8ymYUJmHOydRMGQ1d33iD
 RAJ5NdmbbU53JdOA6Pkfz4RlFGUFGFJQr7UVXhdG7syphft88vsCB4ZzP0bFMy5iMUtK/lDhQoE
 COiwpsNZ8PsYGh532t4wmG+SyMQN+nyLXB8cEn6dCPDeVz1q608mKE+5kcU6uTBC4QMeVyNZbOr
 QT4yXSO7rRKiV6cJdRPB67nAPRoMDEKfzxRRk2u95Wdkawqw/HOEur
X-Google-Smtp-Source: AGHT+IFU6Maza/kisDWcQs8HIyJrPauwPdnKaQggKMk9GEI09HmaytitPSYcu5R6uGXkz6ecHYxa8Q==
X-Received: by 2002:a05:6830:6d95:b0:7c7:da3:ed22 with SMTP id
 46e09a7af769-7c798cbca75mr10345193a34.32.1764201002476; 
 Wed, 26 Nov 2025 15:50:02 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7d73sm44993a34.3.2025.11.26.15.50.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 15:50:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [for-next PATCH 2/2] Azure: Rework binman testsuite job to directly
 use the container
Date: Wed, 26 Nov 2025 17:49:59 -0600
Message-ID: <20251126234959.3909571-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126234959.3909571-1-trini@konsulko.com>
References: <20251126234959.3909571-1-trini@konsulko.com>
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

Similar to the changes made for the world build job, rework the binman
testsuite job as well. There's no functional changes, but makes our CI
clearer to others familiar with Azure pipelines.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 8774af5393e3..c2500c3c58db 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -126,13 +126,17 @@ stages:
     displayName: 'Run binman, buildman, dtoc, Kconfig and patman testsuites'
     pool:
       vmImage: $(ubuntu_vm)
+    container:
+      image: $(ci_runner_image)
+      options: $(container_option)
     steps:
       - script: |
-          cat << "EOF" > build.sh
-          cd $(work_dir)
+          # Copy things from /home/uboot to the Azure container user
+          sudo cp -a /home/uboot/.buildman /home/uboot/.cache ~
+          sudo chown -R 1001 ~/.cache ~/.buildman
+          # Configure git
           git config --global user.name "Azure Pipelines"
           git config --global user.email bmeng.cn@gmail.com
-          git config --global --add safe.directory $(work_dir)
           export USER=azure
           python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
@@ -155,11 +159,6 @@ stages:
           ./tools/dtoc/dtoc -t
           ./tools/patman/patman test
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
-          EOF
-          cat build.sh
-          # We cannot use "container" like other jobs above, as buildman
-          # seems to hang forever with pre-configured "container" environment
-          docker run -v $PWD:$(work_dir) $(ci_runner_image) /bin/bash $(work_dir)/build.sh
 
   - job: pylint
     displayName: Check for any pylint regressions
-- 
2.43.0

