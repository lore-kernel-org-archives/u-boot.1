Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1DC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EAE483020;
	Tue, 26 Aug 2025 00:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bM6hjVCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B38D83102; Tue, 26 Aug 2025 00:46:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571CF828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c854b644c1so1455616f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161973; x=1756766773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4+Mfa09Y9LgtrQmHXdCX0kBgQRvxw4ottnPb8WKERQ=;
 b=bM6hjVCYuMisWUlMGFDROgGgnCP4GwgtjVEBNY3/Vjj0QJEoXO1ZjcDNdlH8TY9bYf
 gISr6oIZFRNctdp2A7DakOVZfGtFUZ9cnir06Fs2gkhqUPakUUbBJkqqOiBVWhIN95Ij
 HPHyaoC9mw2+T9DQlxBS6RYxNx16Pt9q1ElHexEHVUAoREWdtiyfHPcyH/tZoUNEFS+s
 lnM2VsdMaTtYY+IchlUO2fXOZ9/ujpRlOYZbGOkt3iyFriMpesgxrs5tKhlQJseHvzTO
 9OB0KSeZ0iyHeWTSdpnTIs755l6n4FeFgi3ou/KJIwmdrUdichPTnJhAn65S807B1IUW
 iynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161973; x=1756766773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4+Mfa09Y9LgtrQmHXdCX0kBgQRvxw4ottnPb8WKERQ=;
 b=mPhpwnsdFEkIz75/213OdoL10+kMpSaOOz5eGNp5F6BWPRx13Wz4+dzIwL79b3lS07
 ox6zEtO505yzUI3ZE6Nwx9tvYTG+NY6SDxDRa0d9AUT/B2VYKP2YY/vhLC8iXksSPtzY
 jpMF2YTKBUbv5vanfXT9ClKklrf15AMsAlN9lKx7gctbDA2j/UPe61YBaitlTVwLou9a
 1r6rjRBwusVKn0crKiS0XyRfQGbAkuAGVxfsiOx6CsYK0E5G3l2mvVFwD3Z1hiX84ol3
 u+kLqjC+R2vhFP1LE5Y458idr57nASzoAfSMkAJLbJ+jHWN87BS78A2lri3vhuOq/+mD
 SEoA==
X-Gm-Message-State: AOJu0YxDqvHMLdgmOI621yzYZuhRqr4Z97Py1RK9wim42YiTTMTKwWGt
 pH9Tiz/ai1WNsENJVVjG4s3B/98I6VpZsgXnBvTfdnTH664AFmJyA23lo20XJOf6yoE=
X-Gm-Gg: ASbGncuK627VnXeClfjZeGICHZg+AbZJLe9Yq6R3+DCmHsAjgqdhiA7J+dxkQwt5ewJ
 Q56ZrNMhgZZISeM5gmSwThyBtSw2f4V+sUlnDYz5Qwwmp6jrzS51mS7Oo5m0jVOulTxptaqVJAo
 KbyYaackoL4TAZpLKVMeAgy9Bcxit50Jw5Dhk3KmejUQ4qdvnSyZ3GQpx9u5NnNpv5gv63u7XeC
 NUkEuGpHSnX+CFefbjHMXyj7WZmrjPtJqWeXEiEi1Mjx0WyW1NOh4opWiymVTmp74Pt0+PE8H9h
 ljHFvT5zOLcV770bbXtDwuotTHOKpI3lxeFCiHC5tNY15sPJpOk9S64rixrO5HRFNqFPDR8QhRd
 /x5gpwK66JtuYWjIts5pTS5OQlcwD
X-Google-Smtp-Source: AGHT+IGjBgKMaTglEiGmine9fWzoskfzyhhRRJmMtehNA8Y5C9B9SwlR1xpg79R+begTJ/eeGw03PQ==
X-Received: by 2002:a05:6000:2313:b0:3cb:3ca5:8721 with SMTP id
 ffacd0b85a97d-3cb3ca58b8amr242407f8f.32.1756161973400; 
 Mon, 25 Aug 2025 15:46:13 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:13 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 2/7] doc: make pdfdocs: Update the description with the needed
 steps
Date: Mon, 25 Aug 2025 23:44:45 +0100
Message-ID: <20250825224459.682403-3-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
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

It is not clear that before "make pdfdocs" it is also necessary to install "doc/sphinx/requirements.txt".
If I don't install "doc/sphinx/requirements.txt", this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
  SPHINX  latexdocs --> file:///home/uboot/u-boot/doc/output/latex
  PARSE   include/linker_lists.h
Running Sphinx v4.3.2
Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
loading translations [en]... done

Extension error:
Could not import extension sphinx-prompt (exception: No module named 'sphinx-prompt')
make[1]: *** [doc/Makefile:84: latexdocs] Error 2
make: *** [Makefile:2686: pdfdocs] Error 2

A "t" was also missing in "documenation". This commit fixes that also.
NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 68d7e11c572..2540f3973d2 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -65,8 +65,22 @@ The *infodocs* target builds both a texinfo and an info file:
 PDF documentation
 -----------------
 
-The *pdfdocs* target is meant to be used to build PDF documenation.
-As v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
+The *pdfdocs* target is meant to be used to build PDF documentation:
+
+.. code-block:: bash
+
+    # Create Python environment 'myenv'
+    python3 -m venv myenv
+    # Activate the Python environment
+    . myenv/bin/activate
+    # Install build requirements
+    python3 -m pip install -r doc/sphinx/requirements.txt
+    # Build the documentation
+    make pdfdocs
+    # Deactivate the Python environment
+    deactivate
+
+However, as of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
 
 We can use texi2pdf instead:
 
-- 
2.48.1

