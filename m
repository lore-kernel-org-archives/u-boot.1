Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730DDC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E6F8880E;
	Tue, 23 Jul 2024 01:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l33Lo61x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vi9P4eQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87080886CC; Tue, 23 Jul 2024 01:30:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7741B886F0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc2J178fz9sn9;
 Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721691000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6sHBeGTAw/cYl6Smtwlv2BP7tgudKAlFK2nmGC9dkM=;
 b=l33Lo61xwhE/dYZsfv8z//9twGpVKtqRZIywXkJTVSmJbk9hv9qwet2IHi4PaSVYKwJhQk
 PSV8Ou9xTs2D95VwPMVOSv+P/JVA8IhAsjoGN/Hha+m0Shju/V4rYAlVtozimtU3zTgZ8J
 +RRbXuJQXbtJlf7W7amijQIn8irg9KwbCANM2ZqS4/SrKzCMkjaYRPmDDKD5CWrfAqLZE+
 iMQh7CJERAboUjLUhavsFsRAZiwjFBCRZJFg4vh7AGCosshGhMAJ+3H3+DX5dHNFha4prc
 7b3SWrAvuxwGQZApw5ZZ4YS8Rdr5rqGhms/xdXcE6GJFiSz3zMdXUr7hckWOtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6sHBeGTAw/cYl6Smtwlv2BP7tgudKAlFK2nmGC9dkM=;
 b=Vi9P4eQpSSTX+6YI3fqrliK48DR8V+yPTi4NZklX2InL3AJTnd2+WIoTQiOtAKdNfKv/x0
 wUuqJFed7ELODyhxV1S6udpi2jPo2cqVLPigj0PCLkpn1vMN5q2jCGIPHI6URuXc2zPptl
 JaBWlkLqXZzNRo9CoGLe1i0gzrgVKfW8z1r1QbIKX5lHco8vBt4RGHUAk5f76U9VrneyWh
 ObT80UzsGgmOmSnRYqSZQsKUEiJlU2yeSBdygli5975eZLZj1tj78xIf/ASP8QMCPRRPhA
 UiFZgMCqK6tIKR6zbLNAtqqd/0MtRuyFEbY2cwND1aAc8M5PVcU1Lf8mj37xyw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/15] include: valgrind: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:32 +0200
Message-ID: <20240722232910.91249-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 573e42a8e4f9186fc46
X-MBO-RS-META: zok898ph8i1c17oxxdizxfeuwhomp3bm
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/valgrind/memcheck.h |  6 ------
 include/valgrind/valgrind.h | 15 ---------------
 2 files changed, 21 deletions(-)

diff --git a/include/valgrind/memcheck.h b/include/valgrind/memcheck.h
index 501cb14ed8a..4e5127a1a22 100644
--- a/include/valgrind/memcheck.h
+++ b/include/valgrind/memcheck.h
@@ -9,7 +9,6 @@
 #ifndef __MEMCHECK_H
 #define __MEMCHECK_H
 
-
 /* This file is for inclusion into client (your!) code.
 
    You can use these macros to manipulate and query memory permissions
@@ -53,8 +52,6 @@ typedef
          = VG_USERREQ_TOOL_BASE('M','C') + 256
    } Vg_MemCheckClientRequest;
 
-
-
 /* Client-code macros to manipulate the state of memory. */
 
 /* Mark memory at _qzz_addr as unaddressable for _qzz_len bytes. */
@@ -102,7 +99,6 @@ typedef
                             VG_USERREQ__DISCARD,                 \
                             0, (_qzz_blkindex), 0, 0, 0)
 
-
 /* Client-code macros to check the state of memory. */
 
 /* Check that memory at _qzz_addr is addressable for _qzz_len bytes.
@@ -133,7 +129,6 @@ typedef
       (volatile unsigned char *)&(__lvalue),                     \
                       (unsigned long)(sizeof (__lvalue)))
 
-
 /* Do a full memory leak check (like --leak-check=full) mid-execution. */
 #define VALGRIND_DO_LEAK_CHECK                                   \
     VALGRIND_DO_CLIENT_REQUEST_STMT(VG_USERREQ__DO_LEAK_CHECK,   \
@@ -202,7 +197,6 @@ typedef
     suppressed = _qzz_suppressed;                                        \
    }
 
-
 /* Get the validity data for addresses [zza..zza+zznbytes-1] and copy it
    into the provided zzvbits array.  Return values:
       0   if not running on valgrind
diff --git a/include/valgrind/valgrind.h b/include/valgrind/valgrind.h
index 5d4fa5f43b4..6114c4a0e10 100644
--- a/include/valgrind/valgrind.h
+++ b/include/valgrind/valgrind.h
@@ -24,7 +24,6 @@
 #ifndef __VALGRIND_H
 #define __VALGRIND_H
 
-
 /* ------------------------------------------------------------------ */
 /* VERSION NUMBER OF VALGRIND                                         */
 /* ------------------------------------------------------------------ */
@@ -42,7 +41,6 @@
 #define __VALGRIND_MAJOR__    3
 #define __VALGRIND_MINOR__    16
 
-
 #include <stdarg.h>
 
 /* Nb: this file might be included in a file compiled with -ansi.  So
@@ -77,7 +75,6 @@
 #undef PLAT_x86_solaris
 #undef PLAT_amd64_solaris
 
-
 #if defined(__APPLE__) && defined(__i386__)
 #  define PLAT_x86_darwin 1
 #elif defined(__APPLE__) && defined(__x86_64__)
@@ -126,7 +123,6 @@
 #  endif
 #endif
 
-
 /* ------------------------------------------------------------------ */
 /* ARCHITECTURE SPECIFICS for SPECIAL INSTRUCTIONS.  There is nothing */
 /* in here of use to end-users -- skip to the next section.           */
@@ -928,7 +924,6 @@ typedef
                     );                                           \
  } while (0)
 
-
 #endif /* PLAT_mips32_linux */
 
 /* ------------------------- mips64-linux ---------------- */
@@ -1073,7 +1068,6 @@ typedef
 
 #endif /* CONFIG_VALGRIND */
 
-
 /* ------------------------------------------------------------------ */
 /* PLATFORM SPECIFICS for FUNCTION WRAPPING.  This is all very        */
 /* ugly.  It's the least-worst tradeoff I can think of.               */
@@ -5168,7 +5162,6 @@ typedef
       lval = (__typeof__(lval)) _res;                            \
    } while (0)
 
-
 #endif /* PLAT_s390x_linux */
 
 /* ------------------------- mips32-linux ----------------------- */
@@ -6197,7 +6190,6 @@ typedef
       lval = (__typeof__(lval)) (long)_res;                       \
    } while (0)
 
-
 #define CALL_FN_W_WWW(lval, orig, arg1,arg2,arg3)                 \
    do {                                                           \
       volatile OrigFn        _orig = (orig);                      \
@@ -6657,7 +6649,6 @@ typedef
 #  define __extension__ /* */
 #endif
 
-
 /* Returns the number of Valgrinds this code is running under.  That
    is, 0 if running natively, 1 if running under Valgrind, 2 if
    running under Valgrind which is running under another Valgrind,
@@ -6667,7 +6658,6 @@ typedef
                                     VG_USERREQ__RUNNING_ON_VALGRIND,  \
                                     0, 0, 0, 0, 0)                    \
 
-
 /* Discard translation of code in the range [_qzz_addr .. _qzz_addr +
    _qzz_len - 1].  Useful if you are debugging a JITter or some such,
    since it provides a way to make sure valgrind will retranslate the
@@ -6680,7 +6670,6 @@ typedef
    VALGRIND_DO_CLIENT_REQUEST_STMT(VG_USERREQ__INNER_THREADS,           \
                                    _qzz_addr, 0, 0, 0, 0)
 
-
 /* These requests are for getting Valgrind itself to print something.
    Possibly with a backtrace.  This is a really ugly hack.  The return value
    is the number of characters printed, excluding the "**<pid>** " part at the
@@ -6766,7 +6755,6 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
 #endif /* CONFIG_VALGRIND */
 }
 
-
 /* These requests allow control to move from the simulated CPU to the
    real CPU, calling an arbitrary function.
    
@@ -6815,7 +6803,6 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
                                     _qyy_arg1, _qyy_arg2,               \
                                     _qyy_arg3, 0)
 
-
 /* Counts the number of errors that have been recorded by a tool.  Nb:
    the tool must record the errors with VG_(maybe_record_error)() or
    VG_(unique_error)() for them to be counted. */
@@ -7079,7 +7066,6 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
    VALGRIND_DO_CLIENT_REQUEST_EXPR(0, VG_USERREQ__GDB_MONITOR_COMMAND, \
                                    command, 0, 0, 0, 0)
 
-
 /* Change the value of a dynamic command line option.
    Note that unknown or not dynamically changeable options
    will cause a warning message to be output.  */
@@ -7087,7 +7073,6 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
    VALGRIND_DO_CLIENT_REQUEST_STMT(VG_USERREQ__CLO_CHANGE, \
                                    option, 0, 0, 0, 0)
 
-
 #undef PLAT_x86_darwin
 #undef PLAT_amd64_darwin
 #undef PLAT_x86_win32
-- 
2.43.0

