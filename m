Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69620C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765C082A7B;
	Sat, 10 May 2025 13:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AloarmQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A9882A65; Sat, 10 May 2025 13:06:04 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862B482A0D
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad216a5a59cso259112566b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875161; x=1747479961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfP2D9V5JBRpHUWnPzc/M1LrYzz5KZEUEHtEF+UTxZM=;
 b=AloarmQ85sc2r/3oHHLNK2cVNS4dBgDB66s6hwUTuF3Ddo9B01cHMy6qSWMv3Y0+RO
 EKvMPwdo4jiyxG/3tkv48i/iMbohnNeaXrJShGy8N8opTdpC9/jFvfCnhK00xo0bA26R
 08JqE6KBy+g3Ohe/ICSa66hDyUrJynJsHVqHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875161; x=1747479961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfP2D9V5JBRpHUWnPzc/M1LrYzz5KZEUEHtEF+UTxZM=;
 b=nMMBO1bcEpf6l9hpL3o0hQlPn93t+0zQwZ4ckNRP92xLdg1f5JuU/COkcANoQKgHBS
 KAejPoUV99fZI80iTXk3Julwng2dvz9LMyIlIjhTaCDqt7v0e+UpsAsA3w4VDl6Qri97
 7lR5MHJTaZV/MR2yowPFdnONxnHAOBnBvADWVnrkEkhz9IeICx6omMErZknKJTQkCref
 VBpIawbplf1TB0B7PhXtiXzKKse4dYX8xvR9CT+eNUPsbjONyVNHukHyevd6pWj8JxXE
 +MHyARDXrS/ZxhmT/0gKSa1rdtpQY+tRfmHE9u0d0kQziuJOe81pIeYVHe+LO4QSMiqs
 F8ug==
X-Gm-Message-State: AOJu0YzbIettXqIPWox90UfZbbjejsPpKyZ3oP1eIknzGj2flzZDZdoJ
 MBlyyJSBzCV4mZh9Iv3wZGgalnbpgh2BO6uXq1XpPnspBXnMP7BL+S19CjdVnbCgw4yRwT+iVDH
 k3YkUXv1Wgw==
X-Gm-Gg: ASbGncuU1V9RIWPxQXPoABosA946ruZcgfLxnNdkR/v0ZuRXRD8jI956Z1PHd2Qjt7i
 k63a8VU6yBrhIsYF1QUiwkaXMwtpEI+n+iZu1E7VRORUpFDZfkSjbJx9fCdGNw0YZLrIONn+r1L
 yvgc2zUXKTCbD48imB6lY7XcJivw0IZ4p1Wa2L0PpofN/LKA+Yq6HQuz5MP5385GlN17XiuttBB
 yp3Qub3hXKDbJgYNbu01yskoNbOkU8J7ufo/gTBo28ynjpHZzytVngYlVVYJ+2EvhTPWeSRn0o5
 z8WChurbX3Wqfn3TRADtVl68UBJK8cDpFDydJFvcj/ZddOI=
X-Google-Smtp-Source: AGHT+IGpek9pTHLOjDSlWZdBKNt2WFf42w5eDG+E9SdRvi8o06yUJNfERzI0hx5rjPXsu2qm9E8HCw==
X-Received: by 2002:a17:907:986:b0:ad1:f895:fd50 with SMTP id
 a640c23a62f3a-ad2192b83cdmr691852466b.54.1746875161514; 
 Sat, 10 May 2025 04:06:01 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/25] patman: Avoid touching the system or local config
Date: Sat, 10 May 2025 13:05:01 +0200
Message-ID: <20250510110535.1453745-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Set the git variables to ensure that any local gitconfig is not used or
affected by the tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/test_common.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/patman/test_common.py b/tools/patman/test_common.py
index bc27b2d3cef..7da995dda22 100644
--- a/tools/patman/test_common.py
+++ b/tools/patman/test_common.py
@@ -109,6 +109,9 @@ class TestCommon:
         Returns:
             pygit2.Repository: repository
         """
+        os.environ['GIT_CONFIG_GLOBAL'] = '/dev/null'
+        os.environ['GIT_CONFIG_SYSTEM'] = '/dev/null'
+
         repo = pygit2.init_repository(self.gitdir)
         self.repo = repo
         new_tree = repo.TreeBuilder().write()
-- 
2.43.0

