Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F7C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5F288B37;
	Thu, 29 Aug 2024 00:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UerPBTBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1EE886E5; Thu, 29 Aug 2024 00:09:13 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B8E88706
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d2ac2a9d9so24057805ab.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882944; x=1725487744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=UerPBTBpUJ8X0tWZbBtwlyr/Bw+eFDbnQ0201Xy+bwaOckOOATBqO9xsh1VgPMKrBh
 h79EZMQmsM5T9Yq+n1+NbQyc954Er3UbscElz7u7FqvaEL9B/SPpybA8RUGGMOs/p3sE
 OrV8DkHnr4E9arPtwGGQ0tDY/io4wcDMFpTSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882944; x=1725487744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=aFE4p1WlvOC2qYXir0dVm1qTwQN3PY5eojzzHK6y8zyCM7bJsxbgjGUdWQKY3z6eQ/
 S6tSPxAqMy0LwSxNuK/S21YexjpLfelt0hAZyoakWHuCtH76uuFGMTghPOGw3sDT7zQ1
 cn1f26G3Bzm2EpBLFOZvq7dbi2xcbtJBBfIPi1r7pYpYWJTxNPoe8b7dKmLNrMnTvWwY
 BpUqhz30MK2NmRiiID/G3SGz2aCQtoskAcj0GfjUifqVOJR//h7mRhuO08w7pCWBvx6T
 GA5Ouh6KGxUbHdzEh3CB84b2AW/g4HB8R9QtYPmlYwEtJa2WbAjlJ/JDvXMb8TckVQB5
 gMBg==
X-Gm-Message-State: AOJu0YwkWiYKBtmicgmLvdenRAVRRDx9sNyv1aagkx+pZVAp2pPk9Yvl
 DZGVGMUJXFBeNBCKgyUceMNRViCEftoaRqEKdwSoJFoEhe3L0UqBow0KyHqrUhrqk2ckfkg0DFA
 =
X-Google-Smtp-Source: AGHT+IEfyp53Vq3t0GiwcLoid2cQ7vkGNZRWrkbBrlYBQhzVYguIhOKxec6/24CLxLUbBt8awZLvVw==
X-Received: by 2002:a92:cda8:0:b0:39b:393e:28ca with SMTP id
 e9e14a558f8ab-39f3792a731mr12528035ab.12.1724882943983; 
 Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 18/20] test: Add a section for closing the connection
Date: Wed, 28 Aug 2024 16:08:44 -0600
Message-Id: <20240828220846.1205813-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index f610fa9a6f8..b279d95dea0 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.34.1

