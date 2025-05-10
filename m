Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BE0C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2394082B39;
	Sat, 10 May 2025 13:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XM+Bdifn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA258091A; Sat, 10 May 2025 13:06:31 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA4D582B26
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad221e3e5a2so215641466b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875189; x=1747479989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLV0pIOUOJMSmK+JBhL/4WYdSLSEjNNGO9TlrAYdEQE=;
 b=XM+BdifnmJ8CO1rZKUJUfj+e6qgvt2DctaZCEdH36Cy+EucaA/BND9eHm9+YtxZ8Qr
 JmGvRCUfOQnFGplb/h7/sLCRvXo9qJO0OGMO8AnA//IcFNlxZZ1+UNb2lrIooBbB02Vh
 FNf/ogY9e6sy0Pcn9l77F7ZnkLI+p/TQ4Wx3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875189; x=1747479989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLV0pIOUOJMSmK+JBhL/4WYdSLSEjNNGO9TlrAYdEQE=;
 b=r3j45bd+/3tt4pkT/J4ADLUvW5qjq/i7egwrLN7BYZf1Pe/MvsaWIZEXqQQfcExkSu
 /Mkd7KZX3TWvAbS4ckPmHDF187+9wO95N4AMEd2np37BL3ustu4K09zxOXd3LYu/lkKj
 AgmjnivIRLJ6A6ualTJoJF1GFBZn/zTduTLX3LUjmusznMfTXuQuBNzFO8vIOtGLXIda
 MMKTGahWBQEPkIfNaXcB9l4URFD35ktjo1+fv1bJpk8rAoMZbf/AKqFCPjiufuFcc7Kc
 MIWAji+EY7f6mnbPMAsYfNFDlt349+cEVFsIw2SW1wDPJhRrbEZsrWbKnxcQPOr4Xjd/
 kfUw==
X-Gm-Message-State: AOJu0YwM+gSJ6GRLmCAb99PuHBaBtt//tcBk6CEkR1bF6tuSkWkSUllH
 hmsX1GWNpTLrkAYP7hA0KDSG4SxnZeHpU8IKVV7bCWsewje2N5IqVr6dZTK1xt5dKY95IUHoH98
 JvpGO12K4Rn4N
X-Gm-Gg: ASbGncujaeODYPG8aEaOshbknuxmDN6dMGyd6quB/QkHX+zqs8uDWY2fnY0pjW00cG8
 aO3yFISkJ6xsZh9LuOPQagJW1NqNq4l/RD2RjjViUsHCsScZ6qifVwbx9snsVh14LswMRBWi4C/
 qx6WFpo6OT6Y9QHC0leMOF6RM0DTPJm1+K+HxDwy8z6hqSKp3xtXQ28OaQ99UEFOmM0L1HpMbD1
 kRiYRstfYEdwSiWQOPMgZaYudYdiGn3JQzAbhwACIZCGVy4rnnZ9WFWm5ID5xcIWfS2bcoRPQLS
 o1XbDsADedaszxOdhX6XivrY0y0eUyD5EmvHTkGcTkmifvfL9TCip0AyGg==
X-Google-Smtp-Source: AGHT+IFMb86KsD6rWzn5xVEKunwDK/9hI7ox/OkLqvsM0a8HAy8+GSLhroxx3V6VfkSafn1LQjFAqA==
X-Received: by 2002:a17:907:6a13:b0:ad2:13a8:472d with SMTP id
 a640c23a62f3a-ad218f48664mr723548866b.20.1746875188614; 
 Sat, 10 May 2025 04:06:28 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/25] patman: Implement the upstream subcommand
Date: Sat, 10 May 2025 13:05:16 +0200
Message-ID: <20250510110535.1453745-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Add a command to allow managing the upstream tree. This is very basic
so far, only allowing setting the name and URL. Further work may allow
checking whether series apply cleaning on the upstream tree, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 38 ++++++++++++++++++++++++++++++++++++++
 tools/patman/control.py | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 10ed1b17d21..924f0ad4e42 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -25,6 +25,7 @@ ALIASES = {
     'series': ['s', 'ser'],
     'status': ['st'],
     'patchwork': ['pw'],
+    'upstream': ['us'],
 
     # Series aliases
     'archive': ['ar'],
@@ -372,6 +373,41 @@ def add_status_subparser(subparsers):
     return status
 
 
+def add_upstream_subparser(subparsers):
+    """Add the 'status' subparser
+
+    Args:
+        subparsers (argparse action): Subparser parent
+
+    Return:
+        ArgumentParser: status subparser
+    """
+    upstream = subparsers.add_parser('upstream', aliases=ALIASES['upstream'],
+                                     help='Manage upstream destinations')
+    upstream.defaults_cmds = [
+        ['add', 'us', 'http://fred'],
+        ['delete', 'us'],
+    ]
+    upstream_subparsers = upstream.add_subparsers(dest='subcmd')
+    uadd = upstream_subparsers.add_parser('add')
+    uadd.add_argument('remote_name',
+                      help="Git remote name used for this upstream, e.g. 'us'")
+    uadd.add_argument(
+        'url', help='URL to use for this upstream, e.g. '
+                    "'https://gitlab.denx.de/u-boot/u-boot.git'")
+    udel = upstream_subparsers.add_parser('delete')
+    udel.add_argument(
+        'remote_name',
+        help="Git remote name used for this upstream, e.g. 'us'")
+    upstream_subparsers.add_parser('list')
+    udef = upstream_subparsers.add_parser('default')
+    udef.add_argument('-u', '--unset', action='store_true',
+                      help='Unset the default upstream')
+    udef.add_argument('remote_name', nargs='?',
+                      help="Git remote name used for this upstream, e.g. 'us'")
+    return upstream
+
+
 def setup_parser():
     """Set up command-line parser
 
@@ -413,6 +449,7 @@ def setup_parser():
     patchwork = add_patchwork_subparser(subparsers)
     series = add_series_subparser(subparsers)
     add_status_subparser(subparsers)
+    upstream = add_upstream_subparser(subparsers)
 
     # Only add the 'test' action if the test data files are available.
     if HAS_TESTS:
@@ -424,6 +461,7 @@ def setup_parser():
         'main': parser,
         'series': series,
         'patchwork': patchwork,
+        'upstream': upstream,
         }
     return parsers
 
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 7467506dcbc..3e09b16e87b 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -218,6 +218,37 @@ def do_series(args, test_db=None, pwork=None, cser=None):
         cser.close_database()
 
 
+def upstream(args, test_db=None):
+    """Process an 'upstream' subcommand
+
+    Args:
+        args (Namespace): Arguments to process
+        test_db (str or None): Directory containing the test database, None to
+            use the normal one
+    """
+    cser = cseries.Cseries(test_db)
+    try:
+        cser.open_database()
+        if args.subcmd == 'add':
+            cser.upstream_add(args.remote_name, args.url)
+        elif args.subcmd == 'default':
+            if args.unset:
+                cser.upstream_set_default(None)
+            elif args.remote_name:
+                cser.upstream_set_default(args.remote_name)
+            else:
+                result = cser.upstream_get_default()
+                print(result if result else 'unset')
+        elif args.subcmd == 'delete':
+            cser.upstream_delete(args.remote_name)
+        elif args.subcmd == 'list':
+            cser.upstream_list()
+        else:
+            raise ValueError(f"Unknown upstream subcommand '{args.subcmd}'")
+    finally:
+        cser.close_database()
+
+
 def patchwork(args, test_db=None, pwork=None):
     """Process a 'patchwork' subcommand
     Args:
@@ -288,6 +319,8 @@ def do_patman(args, test_db=None, pwork=None, cser=None):
                              args.patchwork_url)
         elif args.cmd == 'series':
             do_series(args, test_db, pwork, cser)
+        elif args.cmd == 'upstream':
+            upstream(args, test_db)
         elif args.cmd == 'patchwork':
             patchwork(args, test_db, pwork)
     except Exception as exc:
-- 
2.43.0

