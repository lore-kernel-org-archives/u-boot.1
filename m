Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B1EE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0886C869AB;
	Sun, 20 Aug 2023 19:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fewT7h96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAACC86A0F; Sun, 20 Aug 2023 19:31:34 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EC286993
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58a24ac48eeso29642787b3.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692552690; x=1693157490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cin58rdSQJH9+2oCnYjLknoE+GVEDsYcvnuVQr+jyg0=;
 b=fewT7h966g7Z3JIeHh47mkO99ORuUDV+2nkDE9+TB0PSNRX3bbTjl9Ty89x1MBQcJE
 1KcaO9zSraU9uadeZcg6ylUjhYEaEKJqvnrz5bOHFY45BsYAfdFWOAWY1oNShzv5lfp/
 gDU+8Lwj/KyLcwL5ueHt3+6ZIqZe5EzXv/HOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692552690; x=1693157490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cin58rdSQJH9+2oCnYjLknoE+GVEDsYcvnuVQr+jyg0=;
 b=b76krwoicZYTiID/oLEjyWQeqtjgUemYdCeqUKJHvPInqA2ByP+G/CWwbJ2gfBIIxw
 VAbya7AahlE6jqEJ32a4QKsQllzB8ZC6ZZZ80vAdrqbZkk8vWTJysRMnKNpdrQ/eOiRE
 roQ8jOtebExAHNspHPLl3IofbZKrX6VQGV+z/rLi4Ox3a6I/EmZOOHW1fCzL3DOzZe/G
 waz+V328dHht3QpykaIfs2xKEeN2KECy6Vyg17xh9A5/N4RYqPJzeX5CjBNKlaWeh/ct
 08Azi3nTC4+KTLCnQ6ZY97ke58MUXGYhihP3CRDgfxU8xqHXhZivy5cZEAORorTJr/Aa
 yUGQ==
X-Gm-Message-State: AOJu0YylHa/XJ2WA1lJj2chBAO/Dxp0aTwXCOIO3hLnSG2nH2Ye+7uuy
 Ldn2drBayARmrMVDx3X3nmV/NoiVBxG/RAHj+JvenQ==
X-Google-Smtp-Source: AGHT+IF9PFGHG6hyzLmZeWyBJaXPu+U4F/80t/3XzPGQWUR61HHoPOuQJ0/rK/QlXaUzcaofKgMnLQ==
X-Received: by 2002:a0d:df47:0:b0:577:a46:26e5 with SMTP id
 i68-20020a0ddf47000000b005770a4626e5mr5369628ywe.31.1692552690254; 
 Sun, 20 Aug 2023 10:31:30 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 i194-20020a816dcb000000b0057042405e2csm1800683ywc.71.2023.08.20.10.31.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:31:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/4] Azure: Set the timeout for jobs to the maximum
Date: Sun, 20 Aug 2023 13:31:26 -0400
Message-Id: <20230820173129.781985-1-trini@konsulko.com>
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

As per current Azure Pipelines documentation we qualify for 3600 minutes
per job, if specified, as the timeout. The default unspecified timeout
is 60 minutes. Rework things to specify 0 as the timeout (and so maximum
allowed) so that we don't have failures due to running slightly past 60
minutes total.

Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml#timeouts
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 61d4bf8c8e5f..fc3188a806f4 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -468,6 +468,7 @@ stages:
 - stage: world_build
   jobs:
   - job: build_the_world
+    timeoutInMinutes: 0 # Use the maximum allowed
     displayName: 'Build the World'
     pool:
       vmImage: $(ubuntu_vm)
-- 
2.34.1

