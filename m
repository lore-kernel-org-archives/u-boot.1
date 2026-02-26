Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB81FD8FC4
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210F683E96;
	Thu, 26 Feb 2026 16:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="ITXIneG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF0383E83; Thu, 26 Feb 2026 14:52:09 +0100 (CET)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10C283D1A
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 14:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:143b:0:640:90e9:0])
 by forward103b.mail.yandex.net (Yandex) with ESMTPS id CF1FCC00A9;
 Thu, 26 Feb 2026 16:52:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3qiDTO1GNa60-jpsMc6gs; 
 Thu, 26 Feb 2026 16:52:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1772113925; bh=QmS3cHW94w+N97PgbaluOhRFla+krYR6TZTizlKPoDY=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=ITXIneG1Uq8G/OXBqAVMaF2HSOiy8gcTMsRA1v9CTkFFc8eH5+De0Td7zWED9KBJv
 VxfoXjUgXPfY3t9EViPBW3IIjuh4zfVdoc6nN6/A279wu46+AvxY8LWxU5XxFqCOTy
 g3Mw6fj8vIMgck8UAtdKJtsvbFzy+oRijGGIER3Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Thu, 26 Feb 2026 16:52:02 +0300
Subject: [PATCH RFC] binman: Make FDT size hint configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-fdt_size_hint-v1-1-5a731a5f8d6d@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMz3bSUkvjizKrU+IzMvBJdC0tjU1NzY9PkFEMzJaCegqLUtMwKsHn
 RSkFuzkqxtbUAhzW+XWQAAAA=
X-Change-ID: 20260226-fdt_size_hint-89355735cd16
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
 Moteen Shah <m-shah@ti.com>, Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113924; l=6798;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=uSbMb5+9b+ZFCUmWcEfZ0/Hk7FiYlg0vuNm+tDossBo=;
 b=4pqPsRGXNEaXb4f58oMWwMUNvNHdd6E+RG9pVrxY0QBpLd0gBqgFkv8Tnn/YmfjQBdF8MFrX2
 OG1KwsQ0RxfDrpcIRW717wbKjWmV08kjRYgc6H6HdJ8KOHYqAEOHr3r
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Approved-At: Thu, 26 Feb 2026 16:12:15 +0100
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

The hardcoded 64KB FDT increment size causes excessive reallocations
when building FIT images with large artifacts (e.g., 250+ MB rootfs):

```
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    16118  297.130    0.018  305.189    0.019 libfdt.py:947(resize)
      870    9.876    0.011   15.211    0.017 fdt.py:56(BytesToValue)
    16118    8.024    0.000    8.024    0.000 {built-in method _libfdt.fdt_resize}
```

Add support for configurable increment size via --fdt-inc-size option,
with recommended value at least equal to total binary artifacts size
to minimize resize operations and reduce build time.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
I think it might be usefull for some cases even if total blob size isn't
too large.

P.S. My Python is pretty rough, so I'd be grateful for any feedback 
or error spotting.
---
 tools/binman/cmdline.py       |  3 +++
 tools/binman/control.py       |  8 ++++++--
 tools/binman/entry.py         | 18 ++++++++++++++++++
 tools/binman/etype/fit.py     |  2 +-
 tools/binman/etype/section.py | 10 ++++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
index 9632ec115e5..3ff09050af7 100644
--- a/tools/binman/cmdline.py
+++ b/tools/binman/cmdline.py
@@ -136,6 +136,9 @@ controlled by a description in the board device tree.'''
             help="Don't use 'expanded' versions of entries where available; "
                  "normally 'u-boot' becomes 'u-boot-expanded', for example")
     _AddPreserve(build_parser)
+    build_parser.add_argument('-s', '--fdt-inc-size', type=int, default=65536,
+            help="FDT expansion increment size in bytes. Larger values reduce "
+                 "reallocations for big binaries at the cost of more RAM")
     build_parser.add_argument('-u', '--update-fdt', action='store_true',
         default=False, help='Update the binman node with offset/size info')
     build_parser.add_argument('--update-fdt-in-elf', type=str,
diff --git a/tools/binman/control.py b/tools/binman/control.py
index 816f7c1eba2..be48619e925 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -745,7 +745,8 @@ def CheckForProblems(image):
 
 def ProcessImage(image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,
-                 allow_fake_blobs=False):
+                 allow_fake_blobs=False,
+                 fdt_inc_size=65536):
     """Perform all steps for this image, including checking and # writing it.
 
     This means that errors found with a later image will be reported after
@@ -762,6 +763,7 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
             of the entries), False to raise an exception
         allow_missing: Allow blob_ext objects to be missing
         allow_fake_blobs: Allow blob_ext objects to be faked with dummy files
+        fdt_inc_size: Set size hint for device tree generation
 
     Returns:
         True if one or more external blobs are missing or faked,
@@ -770,6 +772,7 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
     if get_contents:
         image.SetAllowMissing(allow_missing)
         image.SetAllowFakeBlob(allow_fake_blobs)
+        image.SetFdtIncSize(fdt_inc_size)
         image.GetEntryContents()
     image.GetEntryOffsets()
 
@@ -945,7 +948,8 @@ def Binman(args):
             for image in images.values():
                 invalid |= ProcessImage(image, args.update_fdt, args.map,
                                        allow_missing=args.allow_missing,
-                                       allow_fake_blobs=args.fake_ext_blobs)
+                                       allow_fake_blobs=args.fake_ext_blobs,
+                                       fdt_inc_size=args.fdt_inc_size)
 
             # Write the updated FDTs to our output files
             for dtb_item in state.GetAllFdts():
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index ce7ef28e94b..d74f34372fd 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -147,6 +147,7 @@ class Entry(object):
         self.external = False
         self.allow_missing = False
         self.allow_fake = False
+        self.fdt_inc_size = 65536
         self.bintools = {}
         self.missing_bintools = []
         self.update_hash = True
@@ -1109,6 +1110,15 @@ features to produce new behaviours.
         """
         self.allow_fake = allow_fake
 
+    def SetFdtIncSize(self, fdt_inc_size):
+        """Set size hint for device tree
+
+        Args:
+            fdt_inc_size: Hint size
+        """
+        # This is meaningless for anything other than sections
+        pass
+
     def CheckMissing(self, missing_list):
         """Check if the entry has missing external blobs
 
@@ -1174,6 +1184,14 @@ features to produce new behaviours.
         """
         return self.allow_missing
 
+    def GetFdtIncSize(self):
+        """Get size hint for device tree
+
+        Returns:
+            fdt_inc_size: Hint size
+        """
+        return self.fdt_inc_size
+
     def record_missing_bintool(self, bintool):
         """Record a missing bintool that was needed to produce this entry
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..c393a74514f 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -1039,7 +1039,7 @@ class Entry_fit(Entry_section):
         # Build a new tree with all nodes and properties starting from the
         # entry node
         fsw = libfdt.FdtSw()
-        fsw.INC_SIZE = 65536
+        fsw.INC_SIZE = self.GetFdtIncSize()
         fsw.finish_reservemap()
         to_remove = []
         loadables = []
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 6a26d687056..a8a12f948a7 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -920,6 +920,16 @@ class Entry_section(Entry):
         for entry in self.GetEntries().values():
             entry.SetAllowMissing(allow_missing)
 
+    def SetFdtIncSize(self, fdt_inc_size):
+        """Set size hint for device tree
+
+        Args:
+            fdt_inc_size: Hint size
+        """
+        self.fdt_inc_size = fdt_inc_size
+        for entry in self.GetEntries().values():
+            entry.SetFdtIncSize(fdt_inc_size)
+
     def SetAllowFakeBlob(self, allow_fake):
         """Set whether a section allows to create a fake blob
 

---
base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
change-id: 20260226-fdt_size_hint-89355735cd16

Best regards,
-- 
Nikita Shubin

