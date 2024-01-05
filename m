Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A9C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C404C8749F;
	Fri,  5 Jan 2024 20:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VpRaXTyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2288749F; Fri,  5 Jan 2024 20:43:52 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE77487250
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-427e69f70afso6689921cf.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704483825; x=1705088625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0klHV00BQoEN+MT/qHO36dqeu6DNRSGZPtbHnOZj7hs=;
 b=VpRaXTywFot5t+XolnRUZQqlPuJzzQGZYdpcP8Dn7Bwzmogi5nFRTYTIXP2em+P9oS
 lpszqIN7FR7UpEmE/VG4cbLhe7MbjJDJ4s0o3ojaDw0X0IWt6hOjtW5zJKCXPJUt7M6h
 e1m4qVJjYbBJ9SWIbAdtynpzxJEZnyR6FhPdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704483825; x=1705088625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0klHV00BQoEN+MT/qHO36dqeu6DNRSGZPtbHnOZj7hs=;
 b=t9MGwLYiKbn2rn9fHC0aVllRPL7K5Vajogwkj8MuCPHbvFeZbR4elFeqUxIyCIZASI
 a/9LKG9pG2NrHRJYvrXSZ4KbM9sZnx7BXhBldpfQ+GgZOJRZzDuFnhncMJX+DLk7SVyZ
 2iIkSxgQ+UmtQx7y7bFzJMEIUJURLmEQ2CIVRvFj7DgDQsMSnd2P5oDtwvd3tnc5+eG7
 mq6i206QbWbVURK+mBBZqCQOIELmF0EhsCXlIfwr1PSxXXHTIUaYu+BxyXFpuxLuzdQD
 8nTFoiVuphGO6giNVaHtlPFp6rLdfU38S2yEHMYCGxXsQKLE7CGFoPAgIj0xz9QXYjS1
 e2Uw==
X-Gm-Message-State: AOJu0YyTj1/7WM1kpmnNMPEh8Fuv25Hnwlc7zg2kbFDcDUb3PYwSj39Q
 ZlEjKaEeJobHqIhgDmI+mtkQOkDNVl/W7rSZhgXzf8V8Z3c=
X-Google-Smtp-Source: AGHT+IEI6PZcNs+T3HYWKb6/R/p2PlQ5hbkBXw/7hzBxB+4RRmoCx8FPdrtoPN92ICBiYJmbOy5Czw==
X-Received: by 2002:a05:622a:5586:b0:429:74cd:6c1d with SMTP id
 fk6-20020a05622a558600b0042974cd6c1dmr3296405qtb.62.1704483825037; 
 Fri, 05 Jan 2024 11:43:45 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 ex27-20020a05622a519b00b004282dea946fsm994858qtb.69.2024.01.05.11.43.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 11:43:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test.py: Update pycryptodomex to address CVE-2023-52323
Date: Fri,  5 Jan 2024 14:43:43 -0500
Message-Id: <20240105194343.1832287-1-trini@konsulko.com>
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

The version of pycryptodomex that we use is vulnerable to this CVE.
While not likely an issue for us, let us upgrade to be on the safe side.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index f7e76bdb9181..07348b61596f 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -12,7 +12,7 @@ packaging==21.3
 pbr==5.4.3
 pluggy==0.13.0
 py==1.10.0
-pycryptodomex==3.9.8
+pycryptodomex==3.19.1
 pyelftools==0.27
 pygit2==1.9.2
 pyparsing==3.0.7
-- 
2.34.1

