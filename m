Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C2CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 13:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA5586ED0;
	Fri, 13 Oct 2023 15:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b8uFisXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3267B86EDB; Fri, 13 Oct 2023 15:26:47 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6980986E04
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4180f5c51f8so17018771cf.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697203600; x=1697808400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=usQv9VlAYWiGiEo8bZaUfjM7CgNxus3QcD5Zml6/3V4=;
 b=b8uFisXmTTjQeHkphagB+znBG++toIaTAkEu5xVaLP4BSDaoUXZ1KQ5hl62CgoBKTn
 koL79N+e6gYwJDnxKFXZez1Raplflj+u5QbH2Aoe5fiVe6uF1z7x78VgBuo01tyWoWUi
 mpg5vqNrVtz7aSQ1l27u6JrfStX4U0OVkUf2zMKSxkx6b72sa5Jpm53iiBvGc/fXeUFT
 K9QmQOvBPCVyV2HiNO5GKp/fYpJoPb71WdLTYqxUhsShb6wIAqpzx49UkZLfAKEFMwFW
 iI95xTRncinNKPGY14JJorFqVMZmp4nQl+42haVr569DAxwcDc0DNxDws/G6oHoJWbuJ
 LGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203600; x=1697808400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=usQv9VlAYWiGiEo8bZaUfjM7CgNxus3QcD5Zml6/3V4=;
 b=H2k9oVQIML4XxqxkW9d8k5yXSkojbBb/4hVOajYQObpPvzwoV50zr1P52g9vx8Hr5P
 JuFmN2uGOkLsMiQgy8jxQuWNB1RfQplyNkDn7snPYtScalNzXvE3V9D87ozZblR7UgIE
 jD12H05xlmilx+bwwLu3GVg/7dTumqsLkdVCX/5/7BXAx+2eGhdH3LoB7mur37V5Tv8X
 3PJrw+Df08Om/1g8+9P+08FKQ4ZI+P2mz0Tp7y5MOqQqV6wHgGgwObKnlf4uIpGEVbvW
 +KAF7pkPLM9vyQAi24UI/u9mACXhNEJ0nueGb4AUYXk+LDY0RlhXxm60QWzHe1yKiVTh
 WJtw==
X-Gm-Message-State: AOJu0YxdMS/bu7uSJMFgSEQIRTC/Pe0CFuHfanctGHZmmFIayYEA//W6
 Hb+mu2RLjaGpcU0iIceYN2M=
X-Google-Smtp-Source: AGHT+IE7gKn1nVDDShs+YmXX3mDRVSrL8BmirKfnoUj/RHgBr8Bl1r6o0qhFuXgol7YtlxGjpHj0Jg==
X-Received: by 2002:a05:622a:287:b0:40f:dc70:fdda with SMTP id
 z7-20020a05622a028700b0040fdc70fddamr155230qtw.25.1697203600105; 
 Fri, 13 Oct 2023 06:26:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 z10-20020ac87caa000000b00419cce4a5ffsm593646qtv.82.2023.10.13.06.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 06:26:39 -0700 (PDT)
From: John Clark <inindev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: John Clark <inindev@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] .gitignore: ignore misc include, simple-bin,
 and tools/generated build artifacts
Date: Fri, 13 Oct 2023 13:26:16 +0000
Message-ID: <20231013132630.43018-1-inindev@gmail.com>
X-Mailer: git-send-email 2.42.0
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

make rock5b-rk3588_defconfig
make
git status

before
~~~~~~~
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	include/autoconf.mk
	include/autoconf.mk.dep
	include/config.h
	mkimage-in-simple-bin-spi.mkimage-rockchip-tpl
	mkimage-in-simple-bin-spi.mkimage-u-boot-spl
	mkimage-in-simple-bin.mkimage-rockchip-tpl
	mkimage-in-simple-bin.mkimage-u-boot-spl
	simple-bin-spi.map
	simple-bin.fit.fit
	simple-bin.fit.itb
	simple-bin.map
	tools/generated/

after
~~~~~~~
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean

Signed-off-by: John Clark <inindev@gmail.com>

---

 .gitignore | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 84051b7bfd..a1a79e92fe 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,8 +44,10 @@ fit-dtb.blob*
 /MLO*
 /SPL*
 /System.map
-/u-boot*
 /boards.cfg
+/mkimage-in-simple-bin*
+/simple-bin*
+/u-boot*
 /*.log
 
 #
@@ -59,12 +61,15 @@ fit-dtb.blob*
 # Generated files
 #
 /spl/
+/tools/generated/
 /tpl/
 /defconfig
 
 #
 # Generated include files
 #
+/include/autoconf.mk*
+/include/config.h
 /include/config/
 /include/generated/
 
-- 
2.42.0

