Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE3CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 13:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9B68006D;
	Thu, 23 Oct 2025 15:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dwlvLn5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9126780422; Thu, 23 Oct 2025 15:35:07 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DFFE8003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 15:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-427091cd4fdso531032f8f.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761226501; x=1761831301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=StDWmdqyglAEym66hZx4U8xsvx0skEWhJwmg5Tqa1HE=;
 b=dwlvLn5/vtD60OI3Sy9eHc0uw7NSsfHZ4rU1tKR+GjYltX7wA5Vg1RZD8LmiDnnYq6
 wowqfII3QSx5LykL2dRY6oi46wgmeEAy+SPJ0wnzon213Kp34ZEAtAq6C5MOP0UiAtSr
 4Ji8W34cc4tW8ZYOb4+JXYzbe4ADec7J70YnjDkzJ5EfIvc8uzgjweqiziviBUERi/dN
 VdvVUH5ul/hnm9xXW23DSFBSMdy6xGpFP0pp6b22zjeD0g63bR1leEbTPr0wtXFZhE0/
 aHVeBvMUFqFyuu/ITf0fS2i4cTC1tF97EVpJre+UDTN2jxu0V4ROZfoCpD32/Gf5NBNh
 sUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761226501; x=1761831301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StDWmdqyglAEym66hZx4U8xsvx0skEWhJwmg5Tqa1HE=;
 b=b3/mY9UguScO9+1jAIfOFck17kKxjkL5Zo8FmTTOuP5pRCfPLkdrKN8RqG7ug1c5Md
 9mgsrhLHus9TGFF3GLuYBZV2DQmG5OeTRjtuxFnfnwCwpHV5zAfkUOQjIPeb9J5DmbvN
 bBQfz7RAzrKQOTQzFfslLB8n5SyzaM5Mai4Gn2wYjSWT+u0fxjYEAMY78f5M9/H7yVcE
 TR4zjJ2KB3SmF96v4PHkcoJNQhrB7lc6c3JE/admrA8phBe9Lt0/HA+oIHXVqdH5mt+j
 myZndc3K2PHopvrvMpF+493bwpCsoPGR47gSlRWyfgLYTOmLgj6Y6E3jx2juEweVZR5O
 rS8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+3Ism0+anED2J6W3VrbYRJ6ga0eu6j+SoDMLmJ7wLsZxd6iHpz0ozubqwE885gSvpanB5hA=@lists.denx.de
X-Gm-Message-State: AOJu0YwxyGsGcDrvVmQH37YX5JlxQ/CERWcAM/g4U38dHZ6FuBJTWq7g
 x5Gi/aeNTFqFKa/5h+4QISdjrwRG8stW6lZudqf5GxoxJ14Ecl2dP5Lt+2UeLJjHINwXorfoHN9
 99pIC
X-Gm-Gg: ASbGncsMTa4p9aukVjh3qR58GpPCdbLT8bQ5WoUd9ICsrjCzbu6fLplB/KQQEdKTBic
 y4DN5XNYQoiTD7kKkmickjUs7I+zRmq+7Cp7/kIrFnmrMIrvRL8AEb02vCCxmD2u5ruhdBgK2X5
 6HCrupowyT1rPHJzvTsyXVggeeXqiEzTRaA4yr4VfAbi+UiUeWi77mBje+VTSocElrMehr+9fTj
 M4ZejfPT/wn6V/0xfRyOyEeKUcZhlKJxlWMgN+dWL6u7HqcUUH8gdQNBT+/+okKxgoNZcyF6F3B
 qcXUzVYtzpfwZvxUBdjrHTMBVdo7SdpPJbwCwDAOxk6/0UR/526b/pmPWGkPCnXjYaYbM/E2JeI
 lCXk2VIMUdjYvX3VN9/IpQUfki0bthD3XQZiO5CbkULQ53LeYv6zrylTZGMbuNraTjd/7CZNGpD
 cwU+Hsh0HKEp4UcvJUR+js+9TQ1elrUQiVdtoAMQv1c/Nc157j4wKSt1casB9zG50=
X-Google-Smtp-Source: AGHT+IFU6lso2xTOf2/6xbES4Lk39iA9WdYbPHAPAP+5i0peGuL9GHAXTqheXW55xlS0Vm9h2Dbkqg==
X-Received: by 2002:a05:6000:4202:b0:426:d5a0:bdd2 with SMTP id
 ffacd0b85a97d-42704c5f7bbmr14107720f8f.0.1761226501496; 
 Thu, 23 Oct 2025 06:35:01 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3da2c.dip0.t-ipconnect.de.
 [79.195.218.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4298bd78c69sm2247191f8f.4.2025.10.23.06.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:35:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Casey Connolly <kcxt@postmarketos.org>,
 u-boot@lists.denx.de
Subject: [PATCH] binman: fix mkmbn integration and tests
Date: Thu, 23 Oct 2025 15:34:41 +0200
Message-ID: <20251023133453.3683388-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

From: Caleb Connolly <casey.connolly@linaro.org>

Add the missing cryptography requirement to binman so that mkmbn
will work correctly, fix a pylint error, and adjust mkmbn to properly
integrate into binman rather than writing the output file directly.

For now skip testing u_boot_mbn since it has some weird requirements due
to how mkmbn works and can't be easily integrated into binman.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/binman/btool/mkmbn.py      | 9 ++-------
 tools/binman/etype/u_boot_mbn.py | 5 +++--
 tools/binman/main.py             | 4 +++-
 tools/binman/requirements.txt    | 1 +
 tools/qcom/mkmbn/elf.py          | 6 +++---
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
index 232e2b442a16..c1439977833e 100644
--- a/tools/binman/btool/mkmbn.py
+++ b/tools/binman/btool/mkmbn.py
@@ -12,18 +12,13 @@ class Bintoolmkmbn(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'Generate MBN (signed ELF) image for U-Boot')
 
     # pylint: disable=R0913
-    def run(self, infile: str) -> CommandResult:
+    def run(self, infile: str, outfile:  str) -> CommandResult:
         """Run mkmbn.py
         """
-        args = [infile]
+        args = ['-o', outfile, infile]
         return self.run_cmd_result(*args, raise_on_error=False)
 
 
-    def get_path(self):
-        path = super().get_path()
-        return path
-
-
     def fetch(self, _method):
         return True
diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/u_boot_mbn.py
index e470b31fa318..6268397fd122 100644
--- a/tools/binman/etype/u_boot_mbn.py
+++ b/tools/binman/etype/u_boot_mbn.py
@@ -31,10 +31,11 @@ class Entry_u_boot_mbn(Entry_blob):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
 
     def ObtainContents(self):
-        self._pathname = tools.get_input_filename('u-boot.bin')
-        res = self.mkmbn.run(self._pathname)
+        pathname = tools.get_input_filename('u-boot.bin')
+        self._pathname = tools.get_output_filename('u-boot.mbn')
+        res = self.mkmbn.run(pathname, self._pathname)
         if res is None:
             self.Raise('mkmbn not found or failed!')
         # Exit code 61 (ENODATA) indicates that an MBN file can't be built
         # for this board. This is non-fatal since it may not be required.
diff --git a/tools/binman/main.py b/tools/binman/main.py
index fa5ad79ca0e8..bfd6e990d2e4 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -102,9 +102,11 @@ def RunTestCoverage(toolpath, build_dir, args):
              'tools/u_boot_pylib/*'],
             build_dir, all_set, extra_args or None, args=args,
             allow_failures=['tools/binman/btool/cst.py',
                             'tools/binman/etype/nxp_imx8mcst.py',
-                            'tools/binman/etype/nxp_imx8mimage.py'])
+                            'tools/binman/etype/nxp_imx8mimage.py',
+                            'tools/binman/etype/u_boot_mbn.py',
+                            'tools/binman/btool/mkmbn.py'])
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
 
diff --git a/tools/binman/requirements.txt b/tools/binman/requirements.txt
index 7db72e888e3e..51b8ecd73478 100644
--- a/tools/binman/requirements.txt
+++ b/tools/binman/requirements.txt
@@ -3,4 +3,5 @@ importlib_resources==6.5.2
 jsonschema==4.23.0
 pycryptodomex==3.21.0
 pyelftools==0.31
 yamllint==1.35.1
+cryptography==46.0.3 # for mkmbn
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index 86f12d1f4e5d..7737adc6a4e2 100644
--- a/tools/qcom/mkmbn/elf.py
+++ b/tools/qcom/mkmbn/elf.py
@@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
 class Elf:
 	ehdr: Ehdr
 	phdrs: List[Phdr]
 
-	def __init__(self):
-		self.ehdr = Ehdr()
-		self.phdrs: List[Phdr] = []
+	def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] | None = None):
+		self.ehdr = ehdr or Ehdr()
+		self.phdrs: List[Phdr] = phdrs or []
 
 	def total_header_size(self):
 		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
 
-- 
2.51.0

