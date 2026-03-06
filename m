Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDBFFCC050
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5525C840A6;
	Fri,  6 Mar 2026 19:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dIZFOIeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0BF8405A; Fri,  6 Mar 2026 19:14:25 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA95A8407E
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cbae8f69cbso963449385a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820861; x=1773425661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGAnfUsKR8lPd1LK2utdtOR/9UBG2+nSwlh/a4uPv9o=;
 b=dIZFOIeNdcFfzIrqygjKJs9vgbt88CWU2nIGwuLofuYgwUMFj2P1hvsbwheNZpCsB0
 iNOJkxRaiNIkvycXJ1FVhPguAphRYbLKra1UbaIiF0s2fqGFX2hv73ipjS3xPwL+2GSX
 Fi7uzA2ijRErUQYNdtbnUIYo15CyiZsfBTaMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820861; x=1773425661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGAnfUsKR8lPd1LK2utdtOR/9UBG2+nSwlh/a4uPv9o=;
 b=kOWyFimC+jgecaeKDS1VIdVXDCkod1P6I3xVBpknhp6sPnifDf7Ez8SZ14QFloinHV
 tyCCh0J8EzqmXDK9pxOPFJZOzA4icbxMtyGgGgJkT5tqkvmOt1oqsV0ZXhhHfln/Q5Gl
 /1k8k0USGbfrYAlUEtF7NNP1UQoeEavVU5mursNfv+szFi/Iaac9bxE8ll0FJGyElK7y
 L5sZv3MmqaGy1ligBOhRLivj+Miwb9QOgad0tKEninbjLFARfVqUYovz7tGNvVeyVmbx
 j6b6Vljh2ajBJhxXkLP934dQPPQ29MDIht6nV1gpfsDedKaj7AhhmdFEBI77BDWuKPsy
 ghyw==
X-Gm-Message-State: AOJu0YypRCaWUe17W7UiDbM142EG0BK7tVKx8S0sOL/yBfsdtG/MkMeH
 8UZltZbowcFVk6+e9kuKNcghLAYaxsNjQznjxskapKpSWB/X1ihihOxj0fm83mGt4OtIN0igrNd
 7f/4=
X-Gm-Gg: ATEYQzwKNY1PwqaQoCVGroljq7VB7l5HiYbiyfkIGxrGPub3k8wDqBQLgRO+AJtXFRn
 3IfDiE8YObzyhuljFHrleVNVCm3/Sc9HXcG3BW5sZCw6DyHzkdRBC7Zh5bKf5lf5uQOBI8C6dxD
 rsSUW9heODHIkUocIm7Qb7yjJLqN/J7lrHZu5+2NrBWb6TlYF0t5urZPbGPQ3YuYhmktG4tgAMj
 jlxTZkscHWmDFDukRsk+RzIBa2nRE9j0+PFuqYlbMUJg21ohgVGkj8invbuLKxDkDcm6eFf3OfO
 TxwTfCanzMlGIckyeCoc12dqTU50eRSrHXUoTMo6RdZ/DphtVvgEupIMhcoqZVG7yM1rCycBu15
 a65zdXTPYU7Zud4H/IKaKt4L0TSjpvtcVrVS52UsXU0naKOYp9HopQIJ4SWozNT9kh0HdGc+aUD
 EHpqmggseJRHxXPhSMkw==
X-Received: by 2002:a05:620a:4045:b0:8ca:2ba8:b98a with SMTP id
 af79cd13be357-8cd6dbc6339mr359801485a.11.1772820861184; 
 Fri, 06 Mar 2026 10:14:21 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 21/23] binman: Remove the coverage allow_failures list
Date: Fri,  6 Mar 2026 11:12:49 -0700
Message-ID: <20260306181304.2426352-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Now that iMX8 has full coverage the allow_failures list in
RunTestCoverage() is no longer needed.

Drop the list.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 tools/binman/main.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/binman/main.py b/tools/binman/main.py
index fa5ad79ca0e..a0c775fd629 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -95,15 +95,10 @@ def RunTestCoverage(toolpath, build_dir, args):
         for path in toolpath:
             extra_args += ' --toolpath %s' % path
 
-    # Some files unfortunately don't thave the required test coverage. This will
-    # eventually be fixed, but exclude them for now
     test_util.run_test_coverage('tools/binman/binman', None,
             ['*test*', '*main.py', 'tools/patman/*', 'tools/dtoc/*',
              'tools/u_boot_pylib/*'],
-            build_dir, all_set, extra_args or None, args=args,
-            allow_failures=['tools/binman/btool/cst.py',
-                            'tools/binman/etype/nxp_imx8mcst.py',
-                            'tools/binman/etype/nxp_imx8mimage.py'])
+            build_dir, all_set, extra_args or None, args=args)
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
-- 
2.43.0

