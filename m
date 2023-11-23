Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3137FC61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5630A87600;
	Thu, 23 Nov 2023 14:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MfJqqqUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBD687650; Thu, 23 Nov 2023 14:09:41 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DDE875BE
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-547e7de7b6fso1705913a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1700744978; x=1701349778;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wvkzb/DCwAAAjuaCpVTB6kwtyJQ6jBqnXfhXHnQ/kKk=;
 b=MfJqqqUf6oKadxanaolSQdHILxqgkeAVrHlG4K5+5AqADKZ5vOYRh+10qPEKV7qn/t
 i8eMgTn03Ew6M7LEzoDXrZnzoRkQKG5FsmeP9L3CJLGEApoHj8KwjWsEMFFwxB2pEyZL
 TVERBJpQd3OWE6ukOTlEPQdJDZBmFgvV9HmTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700744978; x=1701349778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvkzb/DCwAAAjuaCpVTB6kwtyJQ6jBqnXfhXHnQ/kKk=;
 b=MWbBM5tWUD3HlO/gP+e4yNQQs+u+/PZCxW9jaDq2HPiB8FuswQhY/pXNhQbrxoxM7n
 SNqTHxCBXeL1To+nmmReUSYe2pbTcMkJr/RQfNUQnQDrYCiwAhGQInaQsBSlkNxOy1Qa
 /t4Q2kr4ljT0KvNRf+TJMNr0vt1KQHFkug/87uC1jJ+z6C2PDB9LddbdQNAuN++z15rB
 fQnGRaAEWPiLSID153PMqk7LV14wooDujk4ukRtJYnOF2iTL8a9+Bi+54MLiiS55kgcz
 LjB3q6n5Pwd0bxnjCaLioJ5BkugYwhOo/z/wsZ1EOeQIKTjZ6YGHA7xpYo79GMg6CT38
 JSlQ==
X-Gm-Message-State: AOJu0YxAP04lgpv5KXiBGZO0DD8UuqNey3btpZ1r3bi9Zcl5FkV70Mrp
 XxrCDN8DxJSdm0kAC2y542KXrGEhUCnJv0VfroXBUA==
X-Google-Smtp-Source: AGHT+IGik+3QrSedKWKRU0NnF+9Ca6OG0Yg7bzwDIiGuZk1OKUwatsUInlefZuu431DyaTnb1epeQg==
X-Received: by 2002:a50:9f87:0:b0:548:5ac3:5d91 with SMTP id
 c7-20020a509f87000000b005485ac35d91mr2738811edf.11.1700744977877; 
 Thu, 23 Nov 2023 05:09:37 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:a27e:f878:7504:438])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a50ee87000000b00543597cd190sm643482edr.47.2023.11.23.05.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 05:09:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] binman: doc: fix typo
Date: Thu, 23 Nov 2023 14:08:20 +0100
Message-ID: <20231123130829.237593-1-dario.binacchi@amarulasolutions.com>
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

s/use set/set/

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 tools/binman/binman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 020988d955f0..230e055667f3 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2060,7 +2060,7 @@ don't have access to the blobs.
 If the blobs are in a different directory, you can specify this with the `-I`
 option.
 
-For U-Boot, you can use set the BINMAN_INDIRS environment variable to provide a
+For U-Boot, you can set the BINMAN_INDIRS environment variable to provide a
 space-separated list of directories to search for binary blobs::
 
    BINMAN_INDIRS="odroid-c4/fip/g12a \
-- 
2.42.0

