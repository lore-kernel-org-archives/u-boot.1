Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA578C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C2788C54;
	Sat, 20 Jul 2024 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IoiLjHd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1ED288B74; Sat, 20 Jul 2024 12:50:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9960788BC7
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36799fb93baso1330299f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472608; x=1722077408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gw7kuHbxZwNmX0M9gamX9MhxBoZGDe+BGOXmM/TUk8=;
 b=IoiLjHd5BUKKqOGQpdCzyfcWfGZRr/tKhKr1XW4tLH8mdmQp9Zn++HO0mgL+dq5eew
 tZ2UC4cfooDXE2B9knGVEHoI65PYZu86qvXcNA8j2xDoaeQQS4qG70cUyYvpG1jwlwhs
 ZrfkYT1u4qn2PlFkPrEnunmvGZd6as9br1SEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472608; x=1722077408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gw7kuHbxZwNmX0M9gamX9MhxBoZGDe+BGOXmM/TUk8=;
 b=u4pmgWNN634WfogM9zCV9JIcGPnkle7g9tF+YOZznGXXItiCJPWwBubvHZDOiaEkPG
 VY/k7eyWzcSf5nzNO9dajZLiJ8tTMqhy3N61YX6FECDY7Erc7+SHzp+6Kpjvi1Xe7UoD
 XxZ1nLx+vDqEUpp5sMqaONJd66OEllqFjvTwzEeRosB2ahAP05Em1Jg+lCnxLQo1/YmE
 4RhwD3MV8QpBOSdH08G2mGXx+iu/fWlkDKdY7QBb86OzcUBUOQsCKu0zqucZxdhkmSU9
 FytQh7UPvX3ckjjRevdmaLcRhahsyPjOPtI/bY7h/6O02gt+7PHPC7UNEaCtx24vOhAh
 H8+g==
X-Gm-Message-State: AOJu0YyNJXfaDBx+25S6Mus7lyH0jGlwJgId4P75zJKqLYbgPVmaDE+E
 zvis46uReqmF6+t8idjb1c1ALrJDVc4eZr1BgFWsV9DevruR03sQwNf+L5yAmWodgOzjLDh6VjY
 =
X-Google-Smtp-Source: AGHT+IEBnCHWtrOmQUiCwxqorUO7jlApcMURAAKXmI1mM2UFt7biQguTRfgry93/t6hTNbwDJxR03Q==
X-Received: by 2002:adf:f4d0:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-369bae643a3mr698122f8f.24.1721472607865; 
 Sat, 20 Jul 2024 03:50:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/20] binman: Correct comment in blob_dtb GetFdtEtype()
Date: Sat, 20 Jul 2024 11:49:38 +0100
Message-Id: <20240720104950.2730773-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

The filenames are a bit confused. Fix them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/blob_dtb.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob_dtb.py
index d543de9f759..1471ded2211 100644
--- a/tools/binman/etype/blob_dtb.py
+++ b/tools/binman/etype/blob_dtb.py
@@ -57,7 +57,9 @@ class Entry_blob_dtb(Entry_blob):
     def GetFdtEtype(self):
         """Get the entry type of this device tree
 
-        This can be 'u-boot-dtb', 'u-boot-spl-dtb' or 'u-boot-tpl-dtb'
+        This can be 'u-boot-dtb', 'u-boot-spl-dtb', 'u-boot-tpl-dtb' or
+        'u-boot-vpl-dtb'
+
         Returns:
             Entry type if any, e.g. 'u-boot-dtb'
         """
-- 
2.34.1

