Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168ECAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1623835AA;
	Mon,  6 Oct 2025 00:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4gbbUGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E46835D0; Mon,  6 Oct 2025 00:12:46 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65870835A2
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so23909645e9.2
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702364; x=1760307164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ubx1mkfeoD0Q7jxBtQjDfgcpcTOQuaFa/K0W4Eg1EA0=;
 b=U4gbbUGiTbYDMoCgbmy9YVQZB79ECYVA9wVJ9MvqnSW1x7mbPiRQ8/TZlp5XvaNFDX
 zZrNIVX9VQcJPoUx5/HXfQJco0xqiu2HC6cEcFV7zZ4R5KEBeidEGgTgeIuxyGZhrxfO
 TgrtINCZeBRPD23c9Ei0Ylv1l+9ayO7pA1Ma9cA8IkM1OxZ6JtvcppkuZH90NcXnAMzK
 C9pRjrrzcf47UouVHLXctRHvjsie7PTUPrBbEI1e59dFwirASDktbk6Woe0o52YF1Xrd
 JEyzrWjND8A4dC8SwYNcWryQkMxAqrr/p33wvHyY6zb17pUM9eqO19NLH7P6IqVuIaFc
 nVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702364; x=1760307164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubx1mkfeoD0Q7jxBtQjDfgcpcTOQuaFa/K0W4Eg1EA0=;
 b=dqwpDAvxzedkPTC/X2ie0My4h5DocgcHPLUXUBwMuJ3b1YAAhcNqhDRT6J/aazzeoH
 d0vhxPx812QqCVc5dRCvQimpfBQL4KZG/irEy5Gqce/xKyHb/c5FzhcWXr73eqEgHhZb
 TYHhSydJe/UE5WWXWzWHHQhj2s3iH2dVDFpcFTTPu/gYnvpn4ufP9JgJViMFhEBorERH
 3UUHO9C+z0S/Cp0/Umy0YCcdahIWuxkSiiwCKf8BEqoKw66OFKaYG/m1wFoQnqcsXekq
 vAPzyh1HEpzkFPnRyl9IqTKqxNUDT7cFWbFaLqCqpAihv8A8IHRM3wZIYzUX4NRkpYwU
 AadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlXWJtpULWV4uHzTacBalZEvC54UzieljL4Vlzln+mg/qSgsVFFKE1PL3VscghdtdTULzRWtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/qPpDG2eLGvKaG0zQO35M38aLTOgqgqZC+Xq2EGXyB58riN0M
 ZL+qcqd+63pmdNpE93WeCMRtrcKK3i6EHJDUjF6HkagxZgGssuPVaAP9
X-Gm-Gg: ASbGncvRKdDOc+JFe+n0IT5K/0FsqX1TbHmUmrGETy3ttbpdBO4d8tQKjPYlBk7SY7v
 ph8phaowej0IQ5s7yjf06vpRjeUggXuaIxmSlmKCQxiGfqT3Evlk80nGBlow6UuNHad+M0ECxFj
 Y2jZiSb3aF24BamS039vE6uTCO7hb8eFveu4d1VPh/FjxQV8fGJWixSL9g+HMuxcHCEG7rAfOTn
 Xo8BSKfsSQxN3Zc1M8O0l0Dmli5rLOnn6OT58Waeqnjy5TDzkGcubFbGXiVLc8009/rXFFKWonx
 Ox1sUn86d/2WN8i/uhTtzyBPa9w3hzIpflkG5lyYoog6hLV68+Lgue6Atl94HnNUnqHJy4+DqNd
 LyX7dTMFALmlsNcvV9aYWhnfIglI2IRe0jiPCu3J0AX1LDceMwPK4Pw==
X-Google-Smtp-Source: AGHT+IGIyKX33FRhG6SJlAz8XQCN19jDuivVToRKRKG0+Vqy5GgWt0HtZDs5oUyjHQe+3tmy1IlArA==
X-Received: by 2002:a05:600c:3556:b0:46e:1fa1:3288 with SMTP id
 5b1f17b1804b1-46e79b682b4mr31619215e9.34.1759702363657; 
 Sun, 05 Oct 2025 15:12:43 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:43 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 3/7] doc: make pdfdocs: Add pip install -r
 test/py/requirements.txt to the list of needed steps
Date: Sun,  5 Oct 2025 23:10:10 +0100
Message-ID: <20251005221057.255029-4-adrianocarvalho.pt@gmail.com>
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

As requested, I added this step to all doc targets.

If I don't do this, this is what I get with
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
[...]
WARNING: autodoc: failed to import module 'test_bind'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_bootmenu'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_bootstage'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_button'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_efi_loader'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_net'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_net_boot'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
[...]
build finished with problems, 7 warnings (with warnings treated as errors).
make[1]: *** [doc/Makefile:84: latexdocs] Error 1
make: *** [Makefile:2687: pdfdocs] Error 2

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index f977781184d..483bdc42227 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -35,6 +35,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install -r test/py/requirements.txt
     # Build the documentation
     make htmldocs
     # Deactivate the Python environment
@@ -58,6 +59,7 @@ The *infodocs* target builds both a texinfo and an info file:
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install -r test/py/requirements.txt
     # Build the documentation
     make infodocs
     # Deactivate the Python environment
@@ -78,6 +80,7 @@ The *pdfdocs* target is meant to be used to build PDF documentation:
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install -r test/py/requirements.txt
     # Build the documentation
     make pdfdocs
     # Deactivate the Python environment
@@ -95,6 +98,7 @@ We can use texi2pdf instead:
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install -r test/py/requirements.txt
     # Build the documentation
     make texinfodocs
     # Deactivate the Python environment
@@ -115,6 +119,7 @@ To build only the texinfo documentation the *texinfodocs* target is used:
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install -r test/py/requirements.txt
     # Build the documentation
     make texinfodocs
     # Deactivate the Python environment
-- 
2.34.1

