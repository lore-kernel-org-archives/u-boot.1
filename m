Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DFAC87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B24E833C0;
	Mon, 11 Aug 2025 07:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UerLp8L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438CB8329B; Mon, 11 Aug 2025 01:38:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D0583278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so23356465e9.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869097; x=1755473897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6+ZK8yxpAWiwpAgdnq7MASwusxx1CJx5y1fT/ePcII=;
 b=UerLp8L12iBZ+Sl5wIqh/tSOLaI4NtAYNiO+cis58HrldA0vcaG0p1Ptq8rBtuAOoq
 xECNQbcoaLz4+jR8ZE6++HYD3vftmhNyAR06V8nCVF5xbN51bxrX4AhkqS8OK8spcIyt
 BcNmnQlFnWd4PjB/eEYQV0bTAj8M2nQd0d1dJ5lx/E2u1uD5hq5x+CwMCa0zW93zAM1K
 5gQARP59iJQFychZG2eMsbDKi/BFIO9+nCXe6QQXvmmyvyMwcGSgdoF6YFaQRlX1T/VE
 4kAJmezTl8inTeDcwKkn+HN3m936zsf4IqOVEuYrlLaFFdFF8drjtGnyyKDyxGo0skVW
 lzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869097; x=1755473897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6+ZK8yxpAWiwpAgdnq7MASwusxx1CJx5y1fT/ePcII=;
 b=X/Uo1RPSOAuVwpXBCvlGqbkjyUaY6RtEdeqzmfqB8fEG+hNW4meb+estzhHUZJJ3qm
 AuRKcPGY3hpyYnZZ1iYbTOI9dThAyakPvhk1ge9f0672d+qRIQWobFYy4nzYp4h4dQad
 UK0RWJaLtzLNEN7y4BvsJGaEWQ3WLeKmafOPnuh1VC8hD1AJX9CPWidmWc0eD1rUfV5o
 rKo6zBB+fmCvtYs724v6X7qKoma9azKY5A6PZcx17OxUtRJlMHCZrOC90NYRkzoaWh3i
 4Rqi8HVvP1dQIzbYKPsl0CPdcJoMdsUqNnazQHgWgLBCgrjR4NxiZ8r/Dfpo8aEcLp2x
 f8AA==
X-Gm-Message-State: AOJu0Yw+PmUXSVbAwsa7f0yhCnnMZ0gCdwjOBu+tvOV9SWffKx7UW05q
 woOYIsBbuhTbB9kayQbTQ+O5ttc8spSsoVaKaiTbzQsdoFYon59kIV3aXXZMKA==
X-Gm-Gg: ASbGnct6fQRhF8iTYoR/+MRvU/huaZmQVl47eB+XU+89ebstYu2iLeidVLS9TBGng1s
 sjmoBLxfGtqEucoGOzcXPxegGdtUkjsu1y6x3cjHmpX8X+b8Csm7lZIZRKoQ1oeX/hw2saYTIee
 O2ZWOkdNKVHr+shQ1fwvGfHIK7Bbk90oy/u48Ioacv8BrDKcbpOY7rmThE4rXsyQ0wujfD5/SCa
 4+Rs2cHjCR4OmEh0rvugEQRMCFWthmRgwMcNbfbDU8vh/qAvczAUs01U/JuoUhqMWl7+6dejFVX
 04q6HpK0kzpcS/lBMMbotMQ07M2tdPF9J939ZJUli401PLVNKC/WpnEO22inrAH7JicaGoae6ae
 t7+G3ESHAKjAjsQRf9SWcoHtDHhcuFg==
X-Google-Smtp-Source: AGHT+IHA+j+gXc0ypr7QLHN8hZAda14G2W3bOzmnFE7ZgarOLroB9p49wvxSCPC81a05K5j/TETk4g==
X-Received: by 2002:a05:600c:3b02:b0:456:475b:7af6 with SMTP id
 5b1f17b1804b1-459f4ea1fa8mr80961955e9.7.1754869097229; 
 Sun, 10 Aug 2025 16:38:17 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:17 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 02/10] doc: Fix typos and improve wording in
 doc/build/tools.rst
Date: Mon, 11 Aug 2025 00:37:33 +0100
Message-ID: <20250810233742.51902-3-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/tools.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/build/tools.rst b/doc/build/tools.rst
index 5bfa05b2325..495e6deb365 100644
--- a/doc/build/tools.rst
+++ b/doc/build/tools.rst
@@ -8,7 +8,7 @@ Building tools for Linux
 ------------------------
 
 To allow distributions to distribute all possible tools in a generic way,
-avoiding the need of specific tools building for each machine, a tools only
+avoiding the need of specific building tools for each machine, a tools-only
 defconfig file is provided.
 
 Using this, we can build the tools by doing::
@@ -30,8 +30,8 @@ installed all required packages below in order to build these host tools::
    * diffutils (3.7)
    * openssl-devel (1.1.1.d)
 
-Note the version numbers in these parentheses above are the package versions
-at the time being when writing this document. The MSYS2 installer tested is
+Note that the version numbers in parentheses above are the package versions at
+the time of writing this document. The MSYS2 installer tested is
 http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20190524.exe.
 
 There are 3 MSYS subsystems installed: MSYS2, MinGW32 and MinGW64. Each
@@ -50,7 +50,7 @@ Launch the MSYS2 shell of the MSYS2 environment, and do the following::
 Building without Python
 -----------------------
 
-The tools-only builds bytes pylibfdt by default. To disable this, use the
+The tools-only builds pylibfdt by default. To disable this, use the
 NO_PYTHON variable::
 
    NO_PYTHON=1 make tools-only_defconfig tools-only
-- 
2.48.1

