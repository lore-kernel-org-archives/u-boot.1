Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D98FC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E8187B8C;
	Fri, 26 Jan 2024 13:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U45gvdoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11073862DA; Fri, 26 Jan 2024 08:53:23 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4FCD862DA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-290449c30d4so31263a91.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706255599; x=1706860399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1AdZnUKsDHNb9ZXt8ZZMmA1adutidBal3qNKttGZLpw=;
 b=U45gvdoWaAFBHvIuXFIw7ug0gTzpukuET2sHabEtsvdtonj/6PlziAGrVGK7Y3CGjz
 jT5KcKv6mk6DRR0eUZpxUjGXRqrSHwReF479tmqlwdc/yaWizC0Kqg9E9CF7FFlNpO/B
 I10Ick9l8vJs42f2yxCaTBUAx66h9+YvEvcWwGQPwmmhSyFqqNFKYSBX6Oq9A7ALu21j
 O1+DneUzfIy12X7gUX0jbc8CpuzEIZJJXCw72HFWlm9TC3waymSYkJEEVM6HlV6Iv42X
 8fYbVTBbLtiU0Qnx2AM2BIfJ8ez/u/u4kz3zx+QgBiIl2CWs9sPdyDJqI+LO3+5R2gl5
 5Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706255599; x=1706860399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AdZnUKsDHNb9ZXt8ZZMmA1adutidBal3qNKttGZLpw=;
 b=KwNQO9e48Cu1+b8TUH7BF5SHwuiS3FoMk6seFlFvhVUVV0zaoq+RlbvinCczyD1Jte
 QugJ2DObupz8YfcJPU/idJqxPg8s6B9ERymbncegoBHFF4FPdGc1QNGSkeJS1qQ1k5Z5
 mEHjaAoG6vOBLVAB3Q8F9vX0ED4Vl/qTjSnW3GFrVIj6USSnRtqY5kai4mmdb50hW75D
 MqGf9k0rs3cpL8Tm9rRuHndnYFpAPHY2uNc/7s5oUl9xgrnC6bB61ZfECOhiC2Znt8yP
 1RNcynL2OzH1I/8sTZ47GLKULyYHgxdzLSGadLGrln3N31WNFar9lBfo9XuILIP8+oty
 FYJw==
X-Gm-Message-State: AOJu0YyrjQyz8afkrSuHfjPCu9CZ/UDBermVN/36ikc2bETp40kUhKCw
 6JocwigQaUpJzTsONXnQgEAAWxBzKI3LyBQzb64/e15E+7h5u4ql3VIUGC6la0s=
X-Google-Smtp-Source: AGHT+IEJd3B9r/DVkLSlRE5t7gCuJ+mxf64sJTCJe2m/5SYWnBjCPw+Cx7lcGfiT1PAf5syGJX/+GA==
X-Received: by 2002:a17:90a:498c:b0:28d:b5de:91e with SMTP id
 d12-20020a17090a498c00b0028db5de091emr1048681pjh.32.1706255598588; 
 Thu, 25 Jan 2024 23:53:18 -0800 (PST)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 x5-20020a17090a388500b00290f8afd8acsm688761pjb.47.2024.01.25.23.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 23:53:18 -0800 (PST)
From: Wei Ming Chen <jj251510319013@gmail.com>
To: u-boot@lists.denx.de
Cc: Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] doc: uefi: remove ".py" suffix for pytest.py command
Date: Fri, 26 Jan 2024 15:52:19 +0800
Message-Id: <20240126075219.1521605-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

the file pytest.py does not exist

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 doc/develop/uefi/uefi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index c739242b6a..0389b269c0 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -193,7 +193,7 @@ on the sandbox
 .. code-block:: bash
 
     cd <U-Boot source directory>
-    pytest.py test/py/tests/test_efi_secboot/test_signed.py --bd sandbox
+    pytest test/py/tests/test_efi_secboot/test_signed.py --bd sandbox
 
 UEFI binaries may be signed by Microsoft using the following certificates:
 
-- 
2.34.1

