Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C51CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 17:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437748006D;
	Thu, 23 Oct 2025 19:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fofX2uMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B2580422; Thu, 23 Oct 2025 19:41:08 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBF28003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 19:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c2878bdf27so713432a34.2
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761241262; x=1761846062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb9FVIwLVOyyS5eNnmsGOQS5ugjzlgbz5gZi8U3qo18=;
 b=fofX2uMnkNJrFhHcLaMQCd/udXkbdylb6Xk73Ct/v5Or3ZOY0fbMxI9hRW2H0cWz4H
 Jle0aLLU2Gs1WCJ2he4qS5MGxd4O5l4OYdu7RNl2O562NNirjAqBxlzIsUUoNyjLvY/M
 //uo2eNyiUWTIHP/NEki+FDBaTJXL+z3SXi9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761241262; x=1761846062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pb9FVIwLVOyyS5eNnmsGOQS5ugjzlgbz5gZi8U3qo18=;
 b=gIzaCIUXIDjTI+BAIx8Zcy1HmOe6dlSMQQ902zqqJowqJP+NVZCNoRh5l3YafczA7V
 T2pW3qHCv/f2l6naK2sqSky10SGSAZLpPJ04o9U0IJve59+HxyZIWmm5df73AvISHhE0
 R52v5Subf4SpncuB96CrD5Jl7hDjnybp/RC9PUt/jzMETlPk/F26yAGT2b9A+yLTEM6Y
 XXBP6rUEKYyJPlmdSxP6/wHDiOGqa1/HwSAcuZNP+zVa+3GiQYFsfPCOTHJJkIN+Bgbx
 /8QHDz9rNbAbQWNvjKsTeIXAiBB9JtzCnogq7/lLFunH7VlmOQcZwT3IWUp0c3EpMrsn
 GUFA==
X-Gm-Message-State: AOJu0YyVGwZCnbRj8v/JpnLzDM/UA0MCVCGSUWCktAc6S0GCsXGjfvgz
 n3kkIP15rb+dFfVEI601tojmBkiimsqIcJ9G4f/U54wG6fC47pSQN3L9A0wZ9uwe9Te689nhyYl
 lT18iXDPYUrXu
X-Gm-Gg: ASbGncsTD6x4a90qV9dFcRIBYU5BeNRz6LVkaGIn/CaX1f54EuxzTEZVU122x4Lp48u
 SSTXy8PP+thzr+7e1+hU9R2O7kqUOAzW4PrU7AezJqTl0emDMps8o42KDZDq/eBPsZVEtUaBzyO
 vZP/QKLdGUTHhiB6vuHWW2H7mIHxVbKgrRm9fbwdmdepOEyn81SxGlVznPBwdtiasIemqs7MSyu
 Ri4Nt2nzyCTAN9/d8RmfSSKnUEeuqKziqtEG31kZc+LbIC07DtdllrznXa/gH255P0jCR3lstw7
 5Qra4KMTds/VUi7GiPngIDWeAiLYYDNZnmlIS5d9/3pb3OspHcJxFNdkAFWDYJl1Bo3X+b+FYO4
 AJIFP+AXOQgZX77QmrMY1XFcttHb9CeDi702A7TbLke4PhoGHbOEtsv9ZedwfB+oBHte99P1ipt
 DnfhIjOxOGmZ905eQ1DgDF+vqL+V5qPHCntaKliDpY0g==
X-Google-Smtp-Source: AGHT+IG5NhI1GflESq7i5AgPSc+9YUNSekhpNaRcE3ljAoipgeBHeyjRRA0IRoyEvg9jOkhbeNSqIw==
X-Received: by 2002:a05:6830:611b:b0:758:71cd:897f with SMTP id
 46e09a7af769-7c27c92ca7dmr11940690a34.7.1761241262575; 
 Thu, 23 Oct 2025 10:41:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51118aa6dsm774359a34.12.2025.10.23.10.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 10:41:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH] python: Add a top-level requirements.txt file
Date: Thu, 23 Oct 2025 11:40:59 -0600
Message-ID: <20251023174059.1962529-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A frequently reported problem is that someone misses a required python
package when doing a specific task within U-Boot. This is in turn
because each of our requirements.txt files only lists their direct
dependencies. It is not always clear that another tool has its own
requirements and thus something else fails. Solve this by having a top
level requirements.txt file for the project which in turn installs all
of our other project requirements.txt files.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>

As Kory is the most recent person to hit this, cc'ing them. I think this
is the right path forward and if agreed, I'll update documentation in a
follow-up.
---
 requirements.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 requirements.txt

diff --git a/requirements.txt b/requirements.txt
new file mode 100644
index 000000000000..0fd08b9da17b
--- /dev/null
+++ b/requirements.txt
@@ -0,0 +1,8 @@
+# For ease of use, this is all requirements files for all portions
+# of U-Boot
+-r doc/sphinx/requirements.txt
+-r tools/u_boot_pylib/requirements.txt
+-r tools/buildman/requirements.txt
+-r tools/binman/requirements.txt
+-r tools/patman/requirements.txt
+-r test/py/requirements.txt
-- 
2.43.0

