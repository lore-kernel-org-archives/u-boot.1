Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEFCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 06:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E4E838BB;
	Wed, 13 May 2026 08:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dBdfhnLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B9783E36; Wed, 13 May 2026 08:52:19 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975AF836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 08:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso55419435e9.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655136; x=1779259936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V94kQ+nP9xkQOWqI+6ZwVI3VjOaRi9dpE0inqzgo8q4=;
 b=dBdfhnLzFyvL6q8posC0qw0Wku1fHeXtvpz+k2pVvkBfOzIjEYmykHpthfgAg6wYaq
 6W2xtOUCsqiJLpig6KoeeOFJ1bs3Bs3adrDyJqcF2Gd1tI31VvaXBNH2V0mPpudjAh5f
 szqF76u3asOmmF2k4qt2No2J/SRCgzjBkmRHhUqnq3LmFvmOuz9tvTMXo6rErqa73jA8
 1HrPuhtT12VKBuNzMr6OVCLs3d/hR1yLSRqo45oq3OnxpL/WToziZTrw1OYbC4zgBNGc
 NBG6oO8Tz7QW0QdIlt4w86JBMGGYcMDvJi+x81jXCCWn8MuxJSetia6mZtPuwA4Q4J1O
 oABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655136; x=1779259936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V94kQ+nP9xkQOWqI+6ZwVI3VjOaRi9dpE0inqzgo8q4=;
 b=gtYGUUIl3ydq0raY28mCbCKZollxfPndr2gEqoyLvscQPmhRy5RA0LCXBbbJjbEt0I
 gMjdKMtwk+cWBJewS22kOQGZuGFtD3WIQ570ss37l+W3J2oC9LTkwN17t/FgfRTkKBBL
 DNQx1ai3QF5wzNW9Ub16Ld+zEpZ3mh0Qn4eX3hkvQKJ9ZMy+r1Rxz9E9g5Kg7Xhe8SL8
 7wL6PjQcVMPVAJbfURFjpFcSW1RqABHLYTuqKHVFNPMLyVKfDFd5U+FykebPxzcoA2AK
 WutgXhIwLKcBSHOCSlOP3WjTp4rwq8dvGvDsbnGfWgN88cb3N2hGDPP/d6mB3IX2q33h
 khjA==
X-Gm-Message-State: AOJu0YwJNE07cud4PS76vMMDiI753z5nHeYFrqvKRCDiF8Th1LNqvaXS
 gE6C3JWt1pIinC+ay85EgtPYgGtOO6VpktHUSWgjlyrwC4+M5z8zhxWE/HYQtC+IrE95FfcgtOg
 JoSV1
X-Gm-Gg: Acq92OGoDtqdaz+iFe1jstY2pgjwGlwrurIPZtNwPtp9Yo0hfWOdrCPJUBZn//gh5VO
 siwvi15crIXdoZ+KjgFQzzr2Mplop7sPA9fWUfpnaiRUrNjGTna7tx0PES739NIztnwaX7IITAD
 tDzY78Jlxf5jYw8lOdixjBp/HUKie8vlCLmhmQwHUQBX3/2kHMxltISwrBJkHB8mdiAUtcTac9f
 HP1vkDLzD4E3CTkq2Elrdeht5jPHDvPk5zYD4XNzERM7gXp44giXI0/S4qPQGQAAKa9rslit8No
 52wrrrBI5c5WXsV652WXG7l+aDM/rpqbWz0Mx0+QTeoZ3vf5BeeY/tNhYDJnet39HAWcm3X8ZKF
 xEtO1RiKUdHj1GVjdMI7L2oX8hFcdmBBYV7gS3t1cxtaPkCnHE5yUuQCQXBUuWM3uN73uInIjGs
 4nYcN0tYE3CVLf9qXVW9APiYTsTHOZX6zbE02amJZayoyVufilXAv93jdw3+ktoSCWklh8ExvRX
 KXaksNd6jsFPNhZ7C/A8sKmR6u3r70vKghF1uwPzS37UAgcVHJc02uQtxG2WPdovGdwhgCxWFjK
 tznmMFnBCQi1t7DVJ0mSCltKI1Esb+2XcGoN86ldtn8y7SnKgkj3H9vN1DyJZtkWkV9Sm0NOfFz
 vr/HXZeZV+UPqov/TNZwBfeR6HE3RFffStNdwEB07Ob9eED3+AaZzqamPt77Y48lHZ26sWA/E6a
 YxyBd/AyZNe73xv7wWpgprR7ZcqRwjY2zf2StEgUqhXpN087Ekbjk55t3Fk9VsOvQc/0U1hv1Zl
 geISeU/TuHiwqwDKLzMsn2HrQ==
X-Received: by 2002:a05:6000:2203:b0:44b:8fb6:9a2e with SMTP id
 ffacd0b85a97d-45c592291a5mr2843182f8f.20.1778655135994; 
 Tue, 12 May 2026 23:52:15 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491e94c0fsm40251829f8f.32.2026.05.12.23.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 23:52:15 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	kory.maincent@bootlin.com
Subject: Pull request for ab-master-12052026
Date: Wed, 13 May 2026 09:52:06 +0300
Message-ID: <20260513065206.1158795-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

This is a quiet cycle and I've been waiting for more patches before sending a PR.
Just a fix from Kory on one of the tools.

The following changes since commit 5732bd0f457b4c671e46574d64d4acb099c0f0a5:

  Prepare v2026.07-rc2 (2026-05-11 16:05:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/ab-master-12052026

for you to fetch changes up to d5ea30b233e8162898d44da2c20dfc88e27d23db:

  tools: fwumdata: Fix use-after-free in parse_config() (2026-05-12 09:31:51 +0300)

  The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30075
  seems happy. Please pull
/Ilias

----------------------------------------------------------------
A single UAF fix from Kory for out fwumdata tool

----------------------------------------------------------------
Kory Maincent (1):
      tools: fwumdata: Fix use-after-free in parse_config()

 tools/fwumdata_src/fwumdata.c | 1 +
 1 file changed, 1 insertion(+)
