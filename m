Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A008D116E0
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 23:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D16284262;
	Thu, 27 Nov 2025 00:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iXIykod1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F6484299; Thu, 27 Nov 2025 00:50:05 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152FE84262
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 00:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6e815310aso232302a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764201001; x=1764805801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ppnk2rK/JY9FkUpJZTZswHbzDNxPT+6JBuDLPdGCnsg=;
 b=iXIykod1cn9mUlF53bwT/SzzMKZ7+Cj+6ZW4dSvE35CR3yz055iVofD7LMExKdvP1g
 ytmnKhiymvzEWOWHNnacvg+EF/nk1REcgNazrZI1vSHjv4NLXH1u7ZWWMZI1VvR2Y6+g
 zo0j79yz1rws0uCVOwlnwg4+7BGQSVfESZhEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764201001; x=1764805801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppnk2rK/JY9FkUpJZTZswHbzDNxPT+6JBuDLPdGCnsg=;
 b=Gpn0n3WScnid/ydIe+QaEWUBRxifZb0uT/OEn879m5PfGAB32eVsJfQ+ftJA9N1j+Y
 yNNJlfbnrQx1vO2t77kl/pexcHsb7OFyhN7W93l10BEy2oAxzX6H74z12VOKsK5oBlbt
 DzvEttgJrW81s6ghnatnkXsICcwDHuu4ZF4F3lv2UQJWf8AzTcdZ+MuK1KC/b1TZjBXx
 EaLYkPv/hQBgemPJbpGu4IkJOPfpdlPRQFYp6ne66Rk4XIaAwW5y1119bR7sfdcI5tR7
 kZVHJPw3GJYMyPMRL+fyxPLPMW44dQdYePVCYB/Rvtb6S87874gU4j84TXqDN6xB7Co6
 SL9A==
X-Gm-Message-State: AOJu0Yz7V9igwo6bCUpYy3dwT+FDybT/BOm07HANCEyI9Sa23FrBmWfh
 Nx1qmxm22nyPrTMZ01nOtzevtVFkEmNyhFBq2drTMHym1o5sqD7aiovV6CAIyGihrJOZQK8FqlX
 SL28kbIE=
X-Gm-Gg: ASbGncsyIppefEVrHt6btdIZoksvQkhUYqWxgys6j6/fKpbL6IrbWPbS+mM/72/Waqq
 HwO5cfZXb2vGsS8zOpZl6DmDhQDLD+XXjSEmMSlEUmY3n2hMO0P/GxTgjdswihouzQvHF0+hLEm
 J+C3fpG5qS7tQBAncJ++LcdXTswz0lFwMx59Mq8L+SeEsls5DyoHO7pj80L0DyVBTDc9t1cO/Ls
 QZIvxkmDGpG/+pNAUeA8T66Q7InDTRyZZm/cvUmwL9LPRnp5amjriDR1CbD58URXwnxIGD5SJh+
 MhlmaPDQZcYS1E/4O2KU8d6l5cI+sqNwF4mWPxBTLv+d25xZMeexrJX3smv5FJ1h+omigD7D6HC
 dyDBCtKmeuFl/sFgzrRcR8M67Fw5zPqSiiyhyInC/TFKRWLeiLKKlVLNyuGUB90P4ribCPbsjHX
 2/XN4nZkMpwS3x6iJ0sIFSBMhrqWty9Wf1myZyda4HY/N0P/prI34j
X-Google-Smtp-Source: AGHT+IGdWtjHkr0y61GTlpoxXgBervaDPh5eWy9BQT0wWcTzEGCEa0OiPGgZNNyLBFk3AodpsRodMw==
X-Received: by 2002:a05:6830:4118:b0:7c7:568d:cba with SMTP id
 46e09a7af769-7c79895e802mr11195345a34.0.1764201001558; 
 Wed, 26 Nov 2025 15:50:01 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7d73sm44993a34.3.2025.11.26.15.50.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 15:50:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [for-next PATCH 1/2] Azure: Rework world build to directly use the
 container
Date: Wed, 26 Nov 2025 17:49:58 -0600
Message-ID: <20251126234959.3909571-1-trini@konsulko.com>
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

While we had problems historically using buildman inside of a container
when invoked directly via Azure, rather than calling docker in our
script, that is no longer the case. We can make the job a bit easier to
understand by running it more normally. The challenge here is that our
container normally runs with an unprivileged user that we have populated
tools for and Azure creates and uses a new unprivileged user. Copy what
we need over to the new user.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 0c7c38ba7300..8774af5393e3 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -613,6 +613,9 @@ stages:
     displayName: 'Build the World'
     pool:
       vmImage: $(ubuntu_vm)
+    container:
+      image: $(ci_runner_image)
+      options: $(container_option)
     strategy:
       # We split the world up in to 10 jobs as we can have at most 10
       # parallel jobs going on the free tier of Azure.
@@ -639,18 +642,15 @@ stages:
           BUILDMAN: $(everything_but_arm_and_powerpc)
     steps:
       - script: |
-          cat << EOF > build.sh
           set -ex
-          cd ${WORK_DIR}
-          # make environment variables available as tests are running inside a container
-          export BUILDMAN="${BUILDMAN}"
-          git config --global --add safe.directory ${WORK_DIR}
+          # Copy things from /home/uboot to the Azure container user
+          sudo cp -a /home/uboot/.buildman /home/uboot/.cache ~
+          sudo chown -R 1001 ~/.cache ~/.buildman
+          # Setup venv, perform build
           python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt
-          EOF
-          cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
               ret=0;
               tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
@@ -659,6 +659,3 @@ stages:
                   exit $ret;
               fi;
           fi
-          EOF
-          cat build.sh
-          docker run -v $PWD:$(work_dir) $(ci_runner_image) /bin/bash $(work_dir)/build.sh
-- 
2.43.0

