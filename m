Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F185DC3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C924F884FD;
	Wed, 26 Jun 2024 18:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kG3EsuP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1888850A; Wed, 26 Jun 2024 18:00:10 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED20884C8
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so51048795e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417606; x=1720022406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=kG3EsuP2GSiFUYkAx3raqhRfcittKP/C6B4lz/KRX3odCymPRbbLPNLY3B/9TG3bWR
 eNPn6e9NlF6wrxjdS5aETgpJG6ugYutxiCeYpDSsX6zvpEm7zd45oPWpe43zMzrT+w8x
 V3VK1RhxJFqvbPDzWFk/L25irm8ubL6tiPqTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417606; x=1720022406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=KMNpnuQAYK3mM34nlPe3wGUKom3ZB2/YngUBGqv6V82HYpGZCens2y6xzpdciqEkE6
 z7m8lbbUrVeW9twfxriksLrdnuCSc11Q9GCHry69DHlKzcq0sXTZqEbOxzQOtn0Kl7UB
 mBta9cSnvB93sccKTWX+upwGEY1G3ooJUjJStO/zvB/MdTzeHP/Y5/JR3/lUyhsrni7M
 OlgW9eCThMq4u1wFHoGyKDaTZgzx8pdqixZ/X6hg+2xCDVtoGqnDEHZ8LyFs4ZTMQi0D
 kdXwsena6+KKAYso1fysa0Ngf6arao1ui+/l/8h7WYxSGuIMU7j3vhY5WMSq8xhVgIW/
 fapQ==
X-Gm-Message-State: AOJu0Yx2xTcv1KqYEOzgfKK+dons8nDPBeux8PZDi8LSDnNMcIl8AjHf
 QEb2Cdg1jNCbv5cyeIJTy5F11+NTUgPH5Kk02VvVpF7P59rV9+AuzbhQZVSpCuJ+O11bealKGsL
 ryw==
X-Google-Smtp-Source: AGHT+IE5RcRE9V0YQegnKvt9Sa2L93PQj89jgckDCRPjtMX2nXi0HU7UJe54n61nx6HXNEiXUq0GAg==
X-Received: by 2002:a05:600c:4893:b0:424:a5b4:1bc0 with SMTP id
 5b1f17b1804b1-424a5b41caamr33146445e9.19.1719417605616; 
 Wed, 26 Jun 2024 09:00:05 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v5 02/16] binman: Collect the version number for mkeficapsule
Date: Wed, 26 Jun 2024 16:59:31 +0100
Message-Id: <20240626155945.278640-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

Now that this tool has a version number, collect it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/btool/mkeficapsule.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index ef1da638df1..f7e5a886849 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -33,7 +33,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
     commandline, or through a config file.
     """
     def __init__(self, name):
-        super().__init__(name, 'mkeficapsule tool for generating capsules')
+        super().__init__(name, 'mkeficapsule tool for generating capsules',
+                         r'mkeficapsule version (.*)')
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-- 
2.34.1

