Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1215FD3A667
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 09:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45BC889204;
	Wed, 30 Oct 2024 10:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E728C8918E; Wed, 30 Oct 2024 06:05:13 +0100 (CET)
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F44288EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=f_l_k@t-online.de
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout11.t-online.de (Postfix) with SMTP id DACC394B
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:05:11 +0100 (CET)
Received: from intel-corei7-64.fritz.box ([84.154.173.244]) by
 fwd78.t-online.de with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1t60tL-05ALyb0; Wed, 30 Oct 2024 06:05:11 +0100
From: Markus Volk <f_l_k@t-online.de>
To: u-boot@lists.denx.de
Subject: [PATCH] scripts/dtc/pylibfdt/libfdt.i_shipped: Use SWIG_AppendOutput
Date: Wed, 30 Oct 2024 06:07:16 +0100
Message-ID: <20241030050716.854676-1-f_l_k@t-online.de>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1730264711-2B7FC5C8-F9184AF4/0/0 CLEAN NORMAL
X-TOI-MSGID: 26a16b9a-b5e1-4c87-b3d0-c8d3c0a89a11
X-Mailman-Approved-At: Wed, 30 Oct 2024 10:00:23 +0100
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

Swig has changed language specific AppendOutput functions. The helper
macro SWIG_AppendOutput remains unchanged. Use that instead
of SWIG_Python_AppendOutput, which would require an extra parameter
since swig 4.3.0.

/home/flk/poky/build-test/tmp/work/qemux86_64-poky-linux/u-boot/2024.10/git/arch/x86/cpu/u-boot-64.lds
| scripts/dtc/pylibfdt/libfdt_wrap.c: In function ‘_wrap_fdt_next_node’:
| scripts/dtc/pylibfdt/libfdt_wrap.c:5581:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
|  5581 |     resultobj = SWIG_Python_AppendOutput(resultobj, val);
|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Markus Volk <f_l_k@t-online.de>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 56cc5d48f4..e4659489a9 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
 			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
 		buff = PyByteArray_FromStringAndSize(
 			(const char *)($1 + 1), fdt32_to_cpu($1->len));
-		resultobj = SWIG_Python_AppendOutput(resultobj, buff);
+		resultobj = SWIG_AppendOutput(resultobj, buff);
 	}
 }
 
@@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
 
 %typemap(argout) int *depth {
         PyObject *val = Py_BuildValue("i", *arg$argnum);
-        resultobj = SWIG_Python_AppendOutput(resultobj, val);
+        resultobj = SWIG_AppendOutput(resultobj, val);
 }
 
 %apply int *depth { int *depth };
@@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
            if (PyTuple_GET_SIZE(resultobj) == 0)
               resultobj = val;
            else
-              resultobj = SWIG_Python_AppendOutput(resultobj, val);
+              resultobj = SWIG_AppendOutput(resultobj, val);
         }
 }
 
-- 
2.47.0

