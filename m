Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28867C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20B588C3B;
	Sat, 20 Jul 2024 12:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BqbtEjf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19CD488C4C; Sat, 20 Jul 2024 12:50:16 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4CA88C5C
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso1146369f8f.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472613; x=1722077413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGlndvNdXTPPCzUblruPH+mmuy4964apolJHvBGlvu4=;
 b=BqbtEjf9uXwT4OQTGt6afdRxBqm3yvWa/lQqIj0L0Eb8VqXK5cetjrA8DHWpU2Fa7F
 bqtKTlZQqpUCCZf6EGBL8A1NpB65AHhvH3g3ADShbvZU7LTO8vJeXWbNGYrjOeXr48t2
 umSTm5VtAgUgESq8zqxfi5BlPb0ezDZ6/3X7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472613; x=1722077413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGlndvNdXTPPCzUblruPH+mmuy4964apolJHvBGlvu4=;
 b=D9zasJqYmC6g26IA7uMviP+qqmZZay0GQCR4IO/D1HO5GSjXcseVvD/uFMTukIXou1
 wuPiY81oUdwkIfKunXa8rdDzIy/CLpJdGkk5PDEty35OupubmsoyWAbrmuywPDfVPme2
 j7d7B9nFjX1PLrvr2Rv6GYumO6VJtRGaJ9RomZdShm2EBp6K0REoPlBJ0GaWxqA1umnw
 ITmJsvK1iv2vqeMOLjzpuz452PGdECJlZSmCOz763CyoYOEvoxGcoRoEqFvX0dW8AH36
 2TPsBpBcjhZGsTpxJ92EQfjx+iTrb6wXb44tjX1Ru4x440LWjqF7rk9wIcTeezpHZ0oj
 dHIA==
X-Gm-Message-State: AOJu0YwSKgrE0/6aTGYoFh2lSbO+rKIyWbiESF0iHjB3mfX4S0wzp1gl
 W78D2boUF3efK4Iszg3ydiNJ6FHKgjDhT/mMPbpfGKoIhPv2UrvqsEHM6a7Y96ZvUt74fM+uvWs
 =
X-Google-Smtp-Source: AGHT+IEtupzedx2JeR/8RvKZSjcgNBhfjWFGERRUKIEWyvrCxD9B3crYlMS8iAYBr7MurfaBvQQbEA==
X-Received: by 2002:adf:f709:0:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-369bae70456mr759321f8f.48.1721472613128; 
 Sat, 20 Jul 2024 03:50:13 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/20] binman: Allow entry types to override FDT contents
Date: Sat, 20 Jul 2024 11:49:44 +0100
Message-Id: <20240720104950.2730773-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

At present the contents of an FDT (for each phase) are fixed,
determined by the build and provided to Binman as input files.

Provide a means for entry types to provide their own FDT, so that it can
be processed, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py          | 12 ++++++++++++
 tools/binman/etype/blob_dtb.py |  4 ++--
 tools/binman/image.py          |  4 ++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 752c584c9a3..494b1b1278d 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -1386,3 +1386,15 @@ features to produce new behaviours.
 
     def UpdateSignatures(self, privatekey_fname, algo, input_fname):
         self.Raise('Updating signatures is not supported with this entry type')
+
+    def FdtContents(self, fdt_etype):
+        """Get the contents of an FDT for a particular phase
+
+        Args:
+            fdt_etype (str): Filename of the phase of the FDT to return, e.g.
+                'u-boot-tpl-dtb'
+
+        Returns:
+            bytes: Contents of requested FDT
+        """
+        return self.section.FdtContents(fdt_etype)
diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob_dtb.py
index 1471ded2211..b234323d7cf 100644
--- a/tools/binman/etype/blob_dtb.py
+++ b/tools/binman/etype/blob_dtb.py
@@ -41,12 +41,12 @@ class Entry_blob_dtb(Entry_blob):
     def ObtainContents(self, fake_size=0):
         """Get the device-tree from the list held by the 'state' module"""
         self._filename = self.GetDefaultFilename()
-        self._pathname, _ = state.GetFdtContents(self.GetFdtEtype())
+        self._pathname, _ = self.FdtContents(self.GetFdtEtype())
         return super().ReadBlobContents()
 
     def ProcessContents(self):
         """Re-read the DTB contents so that we get any calculated properties"""
-        _, indata = state.GetFdtContents(self.GetFdtEtype())
+        _, indata = self.FdtContents(self.GetFdtEtype())
 
         if self.compress == 'zstd' and self.prepend != 'length':
             self.Raise('The zstd compression requires a length header')
diff --git a/tools/binman/image.py b/tools/binman/image.py
index 97443d3c0a7..c1be5cc23a2 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -425,3 +425,7 @@ class Image(section.Entry_section):
         super().AddBintools(bintools)
         self.bintools = bintools
         return bintools
+
+    def FdtContents(self, fdt_etype):
+        """This base-class implementation simply calls the state function"""
+        return state.GetFdtContents(fdt_etype)
-- 
2.34.1

