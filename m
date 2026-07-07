Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16791C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E618497A;
	Tue,  7 Jul 2026 13:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GY97gTop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C58849A4; Tue,  7 Jul 2026 13:36:09 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79ECE84979
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-448b89f700fso2087710fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424166; x=1784028966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1y2TBFVx7enAA4VRkNr6EzkMFpVCnwU5iGD4Gr/jtu0=;
 b=GY97gTop/IYhheBkE/axg2shzsbRVV47JXMY3qPcCYEOHqrLGv7OM4p3nQl+ssDyIF
 jLimeuu4hcuNwNzWalb4SKF9bLlZDzFAmd/eRhfc+R0hrYY3jBHC/73TKPE8TXLkF/l8
 oW7ERD6f91GMEU2iHy+vjgJk1NauN87lf7Wv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424166; x=1784028966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1y2TBFVx7enAA4VRkNr6EzkMFpVCnwU5iGD4Gr/jtu0=;
 b=mwWVEEtx67Kt9dgFgHiKvacROCnUo8B4UirY+d105ywsfnVr4WuKgVeuYf7f9d+qp0
 IIJO3ZYRRCSau+RJxBMnQx91IW7fpinJhVNmonM1VyebhRSPKhPTOCNTGSQp8noEPEcc
 iTWefDC4ULcDoAVxuliEA6+jB5afMOARgWd4TXnBUb48LTo4mWQsuFF5zhTM2V/hIF2U
 9i9hXIB18+0zSHUMrlq+T/pnqfP6JuccRvR+vHvRikUrEkl1AWb8Yyl8QtlcXrlhhge5
 f/CbFoCz4OK5MxxRzskyOUnlPPAsbTuEEBWEE6QFA7ufRL7DcRAEUZaRrg7TpTn/vj24
 5XNg==
X-Gm-Message-State: AOJu0Yyh0Ee3/9q5pICRmHCRpr7cjG1rSMtwJ0FwA+G1/1E2guDkX48u
 bx7nid8sFV1jxmpbTZm5mX7Gn1n+GEMj8zJVuinx9C0d1awFOMIl5PC+wd7wYcqljDaAmKLhcJY
 /UhwdDg==
X-Gm-Gg: AfdE7cmaKprT5hD4IzBWMlc25OKRKSME8uON6QcCF7RaRZ2cVEY7bvwnLFxkfjq7r/+
 RYe75JY7OVtgKr3FO74NSH51M+1ODPRPahdwhdC3XXN/lJI4L4VoK4gbY7dW4VHKy2doR1ZoGiY
 rWXhfhnFhye1becYmQ7KWkinNq0xxBzIggQREsojUkQCVTU3akEz0T5GiVj/w6O+1ridHmIR/7a
 AIKyoWda5fKXBJXb9AziGUb7JMAtJJoxd8esIqlQVtJZlpiOvIOZZsH/nbUjOhbF3uOnj96EUQV
 Ljuwelc4mEuVGqHIcHJtKoH5nX4af+7xcPeFQdriYmphPrvv8srLhopfsnUjwXYagJYJ3D4KN3u
 lmPbwVugXtwch3GYW+dQKs9c+wQuGkz5PtOAGcIpzTzIsNi4EGMWHX2ICLFNB3BQGTVi7+8k3dv
 50UqMRfbk=
X-Received: by 2002:a05:6870:8125:b0:447:534c:8a85 with SMTP id
 586e51a60fabf-451061f6faemr3146184fac.18.1783424166124; 
 Tue, 07 Jul 2026 04:36:06 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] qconfig: Add a way to select defconfigs without stdin
Date: Tue,  7 Jul 2026 05:35:03 -0600
Message-ID: <20260707113538.3382145-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

Sometimes it is useful to process just one or two defconfigs and it is
convenient to do this just by listing them in the arguments. Add a -D
option for this.

Update the docs to avoid mentioning boards which have been removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

 doc/develop/qconfig.rst |  7 +++++--
 tools/qconfig.py        | 23 +++++++++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..3b995355967 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -62,10 +62,13 @@ or::
 
    grep -l X86 configs/* | ./tools/qconfig.py -s -d -
 
+or::
+
+   ./tools/qconfig.py -s -D $(grep -l X86 configs/*)
+
 To process CONFIG_CMD_FPGAD only for a subset of configs based on path match::
 
-   ls configs/{hrcon*,iocon*,strider*} | \
-       ./tools/qconfig.py -C CONFIG_CMD_FPGAD -d -
+   ./tools/qconfig.py -C CONFIG_CMD_FPGAD -D configs/{amd_versal2,am68_sk}*
 
 
 Finding boards with particular CONFIG combinations
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 5b85f9d22c3..9d59568dfbc 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -125,23 +125,26 @@ def get_matched_defconfig(line):
         pattern = os.path.join('configs', line)
     return glob.glob(pattern) + glob.glob(pattern + '_defconfig')
 
-def get_matched_defconfigs(defconfigs_file):
-    """Get all the defconfig files that match the patterns in a file.
+def get_matched_defconfigs(defconfigs_in):
+    """Get all the defconfig files that match the patterns given.
 
     Args:
-        defconfigs_file (str): File containing a list of defconfigs to process,
-            or '-' to read the list from stdin
+        defconfigs_in (str or list of str): File containing a list of
+            defconfigs to process, or '-' to read the list from stdin, or a
+            list of defconfig names
 
     Returns:
         list of str: A list of paths to defconfig files, with no duplicates
     """
     defconfigs = []
     with ExitStack() as stack:
-        if defconfigs_file == '-':
+        if isinstance(defconfigs_in, list):
+            inf = defconfigs_in
+        elif defconfigs_in == '-':
             inf = sys.stdin
-            defconfigs_file = 'stdin'
+            defconfigs_in = 'stdin'
         else:
-            inf = stack.enter_context(open(defconfigs_file, encoding='utf-8'))
+            inf = stack.enter_context(open(defconfigs_in, encoding='utf-8'))
         for i, line in enumerate(inf):
             line = line.strip()
             if not line:
@@ -150,7 +153,7 @@ def get_matched_defconfigs(defconfigs_file):
                 line = line.split(' ')[0]  # handle 'git log' input
             matched = get_matched_defconfig(line)
             if not matched:
-                print(f"warning: {defconfigs_file}:{i + 1}: no defconfig matched '{line}'",
+                print(f"warning: {defconfigs_in}:{i + 1}: no defconfig matched '{line}'",
                       file=sys.stderr)
 
             defconfigs += matched
@@ -738,6 +741,8 @@ def move_config(args):
 
     if args.defconfigs:
         defconfigs = get_matched_defconfigs(args.defconfigs)
+    elif args.defconfiglist:
+        defconfigs = get_matched_defconfigs(args.defconfiglist)
     else:
         defconfigs = get_all_defconfigs()
 
@@ -1530,6 +1535,8 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='a file containing a list of defconfigs to move, '
                       "one per line (for example 'snow_defconfig') "
                       "or '-' to read from stdin")
+    parser.add_argument('-D', '--defconfiglist', type=str, nargs='*',
+                        help='list of defconfigs to move')
     parser.add_argument('-e', '--exit-on-error', action='store_true',
                       default=False,
                       help='exit immediately on any error')
-- 
2.43.0

