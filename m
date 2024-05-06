Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9364BC25B10
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 21:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60F987E49;
	Mon,  6 May 2024 23:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SXipx1Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BFF87F07; Mon,  6 May 2024 23:22:37 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2471D87E30
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 23:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78ef9ce897bso189912685a.0
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715030553; x=1715635353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq4qsrAn0iVMBBc/um10DB867WrMyDubHRYlgfvm6HY=;
 b=SXipx1TvMoj81qzoO7Y6gIk4PgMPMfVE9rJtw7XS+A+MknYlo6GPY8q2XsMPkCUnKt
 i94gKtqz4MzY4CcJs3aWrJtubBNnqm5JmA5ZpYHgIXn6d7zE5ZP8HPZdGK4CDSVECPHd
 tJ/+A91gk9jx2IyzPjaW59Q5B+QuMb7ZA2k50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715030553; x=1715635353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dq4qsrAn0iVMBBc/um10DB867WrMyDubHRYlgfvm6HY=;
 b=IUfP1uuj+VkeimaVPZquleCRBlle8MPW0r8VHuYcVWM2UhpF/Ec8FLvFtXlfoNwUBb
 DmgzPsLAUO/pIgRlY0Zh1JALIGcI89mFo2wsabXEGKhFLjhzkxucCThHdtkzPTqrsAYy
 hGXzfpvjBtsQUqffRQEQjdSUS2zJcVI8ZAgDwpRZ/o0+JjOFSZe2OBSH1Q+DNV+NMGWY
 CXmEORaHjPkqqWSHo6Gk34enDnok7/yS3oGRlX6ZgF12TIQPEdUYanllb1m1ZWGXPoLG
 oaEAY0Zxaxoc3kHBH+oG0pbPdyqeGgULGW2jitIAEKRyYTxv137VNj46i3IBkkWzEEuj
 JXKw==
X-Gm-Message-State: AOJu0Yz9WskLUcIXRcZ8kPJ7rlk69vBdgBVZJm8peUyHtm+/LMkTzwsm
 v+qY74gPTAlZx9lUXYpdf5GLBNizAwBMOX7ulF6pgjnR3cNy20zkSMTnj0IcRj3nYNok/6bBBML
 dLDg=
X-Google-Smtp-Source: AGHT+IFgOvgqlkvMh8Zcc01P7xqQivO5QJyz132RDaaPCg+FvhScdzi/Z9WsfT7J6ZPxPC7pRbijGg==
X-Received: by 2002:a05:620a:2909:b0:792:94da:2029 with SMTP id
 m9-20020a05620a290900b0079294da2029mr5666218qkp.24.1715030553370; 
 Mon, 06 May 2024 14:22:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a05620a101100b0079299e0be9fsm1288114qkj.15.2024.05.06.14.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 14:22:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc/sphinx: Bump Jinja2 to 3.1.4
Date: Mon,  6 May 2024 15:22:30 -0600
Message-Id: <20240506212230.2948754-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

While we unlikely to have an issue with CVE-2024-22195, it is simple
enough to bump our version of Jinja2 to receive the fix, do so.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 5b4df36804b5..426f41e1a028 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -5,7 +5,7 @@ charset-normalizer==3.3.2
 docutils==0.20.1
 idna==3.7
 imagesize==1.4.1
-Jinja2==3.1.3
+Jinja2==3.1.4
 MarkupSafe==2.1.3
 packaging==23.2
 Pygments==2.17.2
-- 
2.34.1

