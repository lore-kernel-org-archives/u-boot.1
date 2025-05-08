Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38530C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD5C829C7;
	Thu,  8 May 2025 09:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eWVldh5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4770829E7; Thu,  8 May 2025 09:29:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94938297E
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so533947f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689366; x=1747294166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXT7I5uMblJTZQoL6uQRWHB9zYVGaE0P5CMvWDEZ9mM=;
 b=eWVldh5r674qd7C9ljmc9S+rr50kipnItzaX6ZJxkSWmJ9FzRUy1X8wFRTnZwfTeDE
 n6gkG0HAv6O1UUuKyzg+EYJxjZt7pSMCCqVTj5wPPefcMvfd5wAxrIs2cSgPkVc6TJQO
 z2as65YQe0GbFEXkL7P4B97MLg6ZxE4ovO5Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689366; x=1747294166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXT7I5uMblJTZQoL6uQRWHB9zYVGaE0P5CMvWDEZ9mM=;
 b=XujGP0ygS9eSXnWd71bWH7lI9DifnWoHSlXzsoqfKhND6lKWTznU9Zdb3ZntLrvDAN
 UCaC22GeMNVhBOu2Yz4qUeqs4Em5+cOTkMg/GbJaoylbkk2V7HHF1xrKbLK0+Bc4dpfV
 9F4tg7LqOAhJgo0KkMdIanyDMTf1W756OxrCpaHREIuKzriY1ueLNjZsyKWNnTDTGr5N
 d4GTNfRFSlWSJWd4P8v1PNlOHV4PPbm3Mk41gAQmBJDaDmNHGkC4lzKFXPQE8uUC38ED
 4y4hnM7c++1O/pysD9nioopiQugxhqjtHzRV0PSPbBUB/ibJ92csi4Opgi0+6hz9201m
 dgNw==
X-Gm-Message-State: AOJu0YzW5HmabOn0AyGgQfYZ26FxfAg95/Hr+9mMtVGydRhUWnDdE+8H
 1YxuC1qRqdtSvcWG5Hwi5bXTpKyzd/g2w87IrLg45eE/Yn09u8G51bFEKX0094xFt+Nttkwg0oR
 oyBulnLPY8A==
X-Gm-Gg: ASbGncvOVGdAMIahck/ZPptXKPy6ksXsfoJdtP720QXXDdEm8+MSg3Jc2y/czKQInL6
 sImj4BS2LPH3J6bCQxc1IfAITrUN/LAMz70zk059vFL/g73b3AGt6s57yji7kXhSXdpL1xBX497
 dNYbmnJCedLS7v98FFE4ywiYjrYbScMv4YO3/7C5+9mCa1bBdtWB39NAQbit61CXjfZ0D/aht5+
 V8a5CU1H74ANK5Jz0xXLUeckY5hrZApgGyiujiHOURja/OSflauoJI8AGs5noHMuXoqEJPxII7o
 ifSx3S2ALTGD+EUsIikAgSa6FkExfJ4P553wjuJLFAYxxFYc
X-Google-Smtp-Source: AGHT+IFelS+/jFlT9eCGi5BX0MvuwRHEJRI/OYiLbe8huSO5Eg02kF454BDCyOKfHJeoU31UwVRtoA==
X-Received: by 2002:a5d:584c:0:b0:3a0:b569:9564 with SMTP id
 ffacd0b85a97d-3a0ba095145mr1224417f8f.8.1746689366493; 
 Thu, 08 May 2025 00:29:26 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/20] patman: Correct use of str in code
Date: Thu,  8 May 2025 09:28:31 +0200
Message-ID: <20250508072907.207175-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Since str() is a reserved function we should not use it as a variable.
Fix this in the send module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/send.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/patman/send.py b/tools/patman/send.py
index 7989fe32f92..009ea6bab5f 100644
--- a/tools/patman/send.py
+++ b/tools/patman/send.py
@@ -144,9 +144,9 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
                  start)
 
     if not count:
-        str = 'No commits found to process - please use -c flag, or run:\n' \
+        msg = 'No commits found to process - please use -c flag, or run:\n' \
               '  git branch --set-upstream-to remote/branch'
-        sys.exit(col.build(col.RED, str))
+        sys.exit(col.build(col.RED, msg))
 
     # Read the metadata from the commits
     to_do = count - end
-- 
2.43.0

