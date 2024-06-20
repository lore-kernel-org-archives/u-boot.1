Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D167C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461978859B;
	Fri, 21 Jun 2024 01:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hn+tf34G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA808834D; Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FDE287D1A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so47046439f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924803; x=1719529603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAZMgiVxwFgtbJU8wOG/tKdJ9lPjPSo6ap+M0/rqlWE=;
 b=Hn+tf34GgW+zw14j5i+eUmYodeeewjCntjLiPdjsmjVuOp0MdM6FzsIwBPe/+z/Khi
 YZXqCqNJl+WMGkGRhdJaYz66UeV1FJKRXBNJEPTMeASHn3KHWIm1qSgVG9Y7I3ftYlap
 OvzFNJnXcklKOUVST+3N3BRpeqgLkVvzpObqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924803; x=1719529603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAZMgiVxwFgtbJU8wOG/tKdJ9lPjPSo6ap+M0/rqlWE=;
 b=rBTC0Rr2PFolVL42OhbXWoL8FJkzn1ZuTPKhVt1uwa8xdi1D1qIfR+GsSJNcn3Ryiv
 MdZX9BvKmrPyQOxP00rIdYn3POMznhxlfkT3Wd0aPMjLxrXw1D+IKi+k/Bzyes2ei77K
 O0SAbJFlcbD8hFEwtHX7a97hfnkS+qN8SVCcCEy3VeG82ZAwTd9SgVD12euVOzsuhniu
 +oZdQouL8uo8stOQRD+SNUpTKz4KBPIijy62/TQWtpdN+WcqWM2lRkBDltzPmno7syTR
 h29E6L7N0nAkLGh1zMHAY4DF/JH++5obGq1Aq5DJ/+rmhoP6simD7thfzDAOo8V6XeZL
 aYlQ==
X-Gm-Message-State: AOJu0YzVS5Z4ve+mzY9lwSzTiYHC+HOFnSyW4M6XiJ5ysF/AcBmsf8W9
 QFOsfYwClxXJRophuu4xt/WZ02aiiVD61I3O+PT/rg65lxzd7gBgUrBQKpWPwZb40mCLRkFw04B
 BJg==
X-Google-Smtp-Source: AGHT+IHae8mIXWFJac1AwyoQtAsySjb5F1NF/7U/qMlKZ/+CmnJOD/kfz8bEIj3/bzxxIwxwBwJCdg==
X-Received: by 2002:a05:6602:14cf:b0:7eb:708a:3272 with SMTP id
 ca18e2360f4ac-7f13ee0c250mr796304039f.3.1718924803734; 
 Thu, 20 Jun 2024 16:06:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 07/18] binman: Keep the efi_capsule input file
Date: Thu, 20 Jun 2024 17:06:14 -0600
Message-Id: <20240620230625.1797397-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

There is no need to remove input files. It makes it harder to diagnose
failures. Keep the payload file.

There is no test for this condition, but one could be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: b617611b27a ("binman: capsule: Add support for generating...")
---

(no changes since v1)

 tools/binman/etype/efi_capsule.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 47da5da324b..03e55cbc4d9 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
                                                  self.fw_version,
                                                  self.oem_flags)
         if ret is not None:
-            os.remove(payload)
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.34.1

