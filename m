Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCFCCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A457807B1;
	Mon,  6 Oct 2025 00:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SMqiG+BU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63456835A2; Mon,  6 Oct 2025 00:12:40 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E890F835A2
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so48296255e9.2
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702357; x=1760307157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u5WPfaaecXVwbqfyF/D4yHyZqGNtcdXEVnlUXQVZHO0=;
 b=SMqiG+BUspWbTl+LCrqSv83GqJrNApkWsaVs/C8F71RvbHOIPeg8SoYRiwizx1HL+/
 F2NkpdRaZah3LIFM1JjBeGrUWAqd+YaWetikJdMeVI61m9vTeSnG1XPtEbRzQ5vVEozy
 +NLsA1/NvUQ/hruHe0Nsx9QFZmd3ZF1saRn+LljJCdGgmp+ExgKLOyqzEybOx7iZx1F0
 sZuBXH3sD3YQWa+Cw79+1goBsjlFnAN7P+RJEu3+25UzedebN2saSv5muHYCuLq+bPAp
 D4QBQI1cS4Z4PGYomi5CEVEZFnxWf2gpYMA1JDCcXfgWakZeCdSGk8xG4CWnWLlGmtgv
 ciNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702357; x=1760307157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5WPfaaecXVwbqfyF/D4yHyZqGNtcdXEVnlUXQVZHO0=;
 b=n/rRTcFaB0FyvPVzdjhWznjBrb4b8AFhGBE8GippiXhcrdhsH5AJKqdbjV4jaSAaTY
 gMrTnOmZTCg7JZR0PA/21RXsWv8RTPUdBmCbgw/CDwLwNRAvem5gUJdrwhlB4JjhfEe2
 B1B0aCEn6y9VpdZKbusITpOd+w1/E/8wEaviTCwHR3VN3yCyJg8PGWYRN2pHar40VaOE
 kLgmPeqz2mQDtPktnCjQBevzpW9zTHyh+n+09PginS8zwlT8CUAqRHv9RbSQcQwDs3EZ
 YM8CDMkRZ0hBwyyypzWUM8Jn3ylzR3/ljeZSXiKt2aVfTmrxuv+gVE7arBCHPDyJ71sN
 SJEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPjNimZPxp3f0xoMR/Kvid+19kTT4WyiTpard1FkOQ9vr2CylfU+XQopu2qUP2RoI0qTVTIQU=@lists.denx.de
X-Gm-Message-State: AOJu0YyM8aRruVR3naKNXn21xT4agKIA+Y6/LR9UBVt/HF+hE98i22Eq
 e53zqxKoxWjUygKjGjHKjRhxZ5P6jWJRE0kvwUNBj/6O7SEs9Bl+GY85
X-Gm-Gg: ASbGncvirsQ8/LtKEJ4DRRkvcyQ19wFOyS65fufarqYj5QPJBwuTkTI0mhdCygiMVX1
 LnVL2rutG4HVZBcl8dOgMvahljSNLg+BcOw2El069F1f8Mbhc/dKV5mqzQ3G448xsussN8UymKW
 b+HR+oqtY3ycuyZvQbMI2ugJCsZ8tgK9sRSnVA8kylFeCDDWQWNeHFuwTQFDcBK9cTd6MpoJrWe
 5Ot0ygXyLrsSG06SRnS9k9X363s8/P7O8V4WkIZ1idQmm2Y+cb1gY+OmrfQK6zWs4mFJZnAHwvA
 JOLz0EQun81/71Foz/Cw9W+rsTAkI7tYa+n3trGTqoJdKG+E5+LBHCcOz+8DBvAvnPWnArI3Dnu
 +OBTPh4b7opeKBESD64vuxtXsJ78amIcwifJ4+pH2hO1qTEr8avxfrQ==
X-Google-Smtp-Source: AGHT+IFpMlpxfzuAIvIaNGu5iDEHjMNkXYw5fmdd4r7BffBNd0J6isW9O0EcDsMax28mF+0OL2dDaA==
X-Received: by 2002:a05:600c:4e01:b0:46e:4340:adf7 with SMTP id
 5b1f17b1804b1-46e7797621emr52817585e9.8.1759702357000; 
 Sun, 05 Oct 2025 15:12:37 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:36 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Garrett Giordano <ggiordano@phytec.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 2/7] doc: make pdfdocs: Update the description with the
 needed steps
Date: Sun,  5 Oct 2025 23:10:09 +0100
Message-ID: <20251005221057.255029-3-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

It is not clear that before "make pdfdocs" it is also necessary to
install "doc/sphinx/requirements.txt".

If I don't install "doc/sphinx/requirements.txt", this is what I get
with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
  SPHINX  latexdocs --> file:///home/uboot/u-boot/doc/output/latex
  PARSE   include/linker_lists.h
Running Sphinx v4.3.2
Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
loading translations [en]... done

Extension error:
Could not import extension sphinx-prompt (exception: No module named 'sphinx-prompt')
make[1]: *** [doc/Makefile:84: latexdocs] Error 2
make: *** [Makefile:2687: pdfdocs] Error 2

A "t" was also missing in "documenation". This commit also fixes that.
NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 81548390d78..f977781184d 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -68,8 +68,22 @@ The *infodocs* target builds both a texinfo and an info file:
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
2.34.1

