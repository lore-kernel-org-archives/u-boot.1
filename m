Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DEDC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9847F88953;
	Sun, 18 Aug 2024 22:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P6Ah/A1S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QwmZTdl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B44788955; Sun, 18 Aug 2024 22:04:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F62388440
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 22:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wn6BL16vgz9sd7;
 Sun, 18 Aug 2024 22:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Squ7wLqzHieoRCaYdh3vheQkGjY2dKHQvMSzcaXJv8=;
 b=P6Ah/A1S9rphu1O129Qksm8xNhgrIKe5lhz6fq2O9djPepAL2HVdZvh6Xe95jODkjUyi0e
 XazB36Skmr5BQzmmFY8/jbUaARkZiFTLRf9acwQTgz/kvihb+32YV2wl4OqKy5arYa3N8K
 fBmqGQSXWSH1H7fQCmd+QDWGmnyviHy8YZ+1HrJf2avkO6Y5MSQ3P4TuJmZHJnniwwPQMG
 iTgLi+AX9dMS4m0SNELaknHD04jK9avxB293RY+kkzKPoB7UAGAYT7CEbaxpMdgcyPJkgD
 kYRU6YjTJ4qhE6y34VPaOT/+xsEzl9lLxNTQLE8vq0k3PajKPuloNmhWBIxHOQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Squ7wLqzHieoRCaYdh3vheQkGjY2dKHQvMSzcaXJv8=;
 b=QwmZTdl3komNMaa/uTa7iiwHBTWgxg2v4mi9bcDOtATRP/Jr+kfTEzsQFBDkTXSbi4qDUW
 DGiZj8wCUeU1VEqiy3cwrb+rp30bTFxYbfGv4pCP0V+dLVf1OsNhtSQ1u7Q92vlX9we9+g
 gtI5zLnMHaNn5rQtgZnYrEtl36TA4Hk5PsQZheGC6NFi/M/ppwUFr2lOppAZsvov1kXxpv
 4By/RDx8FNa09q9K2w62o4AuyZpKF4QWxW+DbO+mTQoPYdO4Jy5hgf6p+GatLW1ZUZgM8f
 X4sRRSz6+Hz1QsRHBytcy7+Pt2nhuZqasyFfL//2H1H1VrTvbnRCT0kCxMI3Hw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] treewide: Scrub trailing space
Date: Sun, 18 Aug 2024 22:03:20 +0200
Message-ID: <20240818200356.89000-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11eb4591a7bcb84b42f
X-MBO-RS-META: qn7w39b7npqr7zxb4t9padtdxq1aoged
X-Rspamd-Queue-Id: 4Wn6BL16vgz9sd7
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

Remove all trailing space from the code base. No functional change.
Implemented using the following one-liner:
$ find . -name \*.c -o -name \*.h -exec sed -i 's@[ \t]\+$@@' {} \;

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/btrfs/conv-funcs.h       |  2 +-
 fs/ubifs/ubifs.h            |  2 +-
 include/linux/rbtree.h      |  4 ++--
 include/linux/zstd_errors.h |  2 +-
 include/valgrind/memcheck.h |  8 +++----
 include/valgrind/valgrind.h | 46 +++++++++++++++++------------------
 lib/dhry/dhry.h             | 48 ++++++++++++++++++-------------------
 7 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/conv-funcs.h b/fs/btrfs/conv-funcs.h
index 0a7af9dc873..abf87c6df2a 100644
--- a/fs/btrfs/conv-funcs.h
+++ b/fs/btrfs/conv-funcs.h
@@ -167,7 +167,7 @@ DEFINE_CONV(btrfs_super_block, bytenr, flags, magic, generation, root,
 	    __unused_leafsize, stripesize, sys_chunk_array_size,
 	    chunk_root_generation, compat_flags, compat_ro_flags,
 	    incompat_flags, csum_type, dev_item, cache_generation,
-	    uuid_tree_generation, super_roots[0], super_roots[1], 
+	    uuid_tree_generation, super_roots[0], super_roots[1],
 	    super_roots[2], super_roots[3])
 DEFINE_CONV(btrfs_item, key, offset, size)
 DEFINE_CONV(btrfs_key_ptr, key, blockptr, generation)
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index b4e761c3668..6a55584d550 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -389,7 +389,7 @@ struct super_block {
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 3809c3fb8ef..4b38d96ead9 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -2,7 +2,7 @@
 /*
   Red Black Trees
   (C) 1999  Andrea Arcangeli <andrea@suse.de>
-  
+
   linux/include/linux/rbtree.h
 
   To use rbtrees you'll have to implement your own insert and search cores.
@@ -59,7 +59,7 @@ extern struct rb_node *rb_first_postorder(const struct rb_root *);
 extern struct rb_node *rb_next_postorder(const struct rb_node *);
 
 /* Fast replacement of a single node without remove/rebalance/add/rebalance */
-extern void rb_replace_node(struct rb_node *victim, struct rb_node *new, 
+extern void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 			    struct rb_root *root);
 
 static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
diff --git a/include/linux/zstd_errors.h b/include/linux/zstd_errors.h
index edba6e1fab5..f4a05a76aec 100644
--- a/include/linux/zstd_errors.h
+++ b/include/linux/zstd_errors.h
@@ -15,7 +15,7 @@
 #include <linux/types.h>   /* size_t */
 
 /* =====   ZSTDERRORLIB_API : control library symbols visibility   ===== */
-#define ZSTDERRORLIB_VISIBILITY 
+#define ZSTDERRORLIB_VISIBILITY
 #define ZSTDERRORLIB_API ZSTDERRORLIB_VISIBILITY
 
 /*-*********************************************
diff --git a/include/valgrind/memcheck.h b/include/valgrind/memcheck.h
index 4e5127a1a22..e5bcb2bfa1e 100644
--- a/include/valgrind/memcheck.h
+++ b/include/valgrind/memcheck.h
@@ -19,12 +19,12 @@
 
 #include "valgrind.h"
 
-/* !! ABIWARNING !! ABIWARNING !! ABIWARNING !! ABIWARNING !! 
+/* !! ABIWARNING !! ABIWARNING !! ABIWARNING !! ABIWARNING !!
    This enum comprises an ABI exported by Valgrind to programs
    which use client requests.  DO NOT CHANGE THE ORDER OF THESE
    ENTRIES, NOR DELETE ANY -- add new ones at the end. */
 typedef
-   enum { 
+   enum {
       VG_USERREQ__MAKE_MEM_NOACCESS = VG_USERREQ_TOOL_BASE('M','C'),
       VG_USERREQ__MAKE_MEM_UNDEFINED,
       VG_USERREQ__MAKE_MEM_DEFINED,
@@ -48,7 +48,7 @@ typedef
       VG_USERREQ__DISABLE_ADDR_ERROR_REPORTING_IN_RANGE,
 
       /* This is just for memcheck's internal use - don't use it */
-      _VG_USERREQ__MEMCHECK_RECORD_OVERLAP_ERROR 
+      _VG_USERREQ__MEMCHECK_RECORD_OVERLAP_ERROR
          = VG_USERREQ_TOOL_BASE('M','C') + 256
    } Vg_MemCheckClientRequest;
 
@@ -59,7 +59,7 @@ typedef
     VALGRIND_DO_CLIENT_REQUEST_STMT(                             \
                             VG_USERREQ__MAKE_MEM_NOACCESS,       \
                             (_qzz_addr), (_qzz_len), 0, 0, 0)
-      
+
 /* Similarly, mark memory at _qzz_addr as addressable but undefined
    for _qzz_len bytes. */
 #define VALGRIND_MAKE_MEM_UNDEFINED(_qzz_addr,_qzz_len)          \
diff --git a/include/valgrind/valgrind.h b/include/valgrind/valgrind.h
index 6114c4a0e10..44fd87ec175 100644
--- a/include/valgrind/valgrind.h
+++ b/include/valgrind/valgrind.h
@@ -9,7 +9,7 @@
 
 /* This file is for inclusion into client (your!) code.
 
-   You can use these macros to manipulate and query Valgrind's 
+   You can use these macros to manipulate and query Valgrind's
    execution inside your own programs.
 
    The resulting executables will still run without Valgrind, just a
@@ -179,8 +179,8 @@
    this is executed not under Valgrind.  Args are passed in a memory
    block, and so there's no intrinsic limit to the number that could
    be passed, but it's currently five.
-   
-   The macro args are: 
+
+   The macro args are:
       _zzq_rlval    result lvalue
       _zzq_default  default value (result returned when running on real CPU)
       _zzq_request  request code
@@ -208,7 +208,7 @@
     ||  defined(PLAT_x86_solaris)
 
 typedef
-   struct { 
+   struct {
       unsigned int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -273,7 +273,7 @@ typedef
 #if defined(PLAT_x86_win32) && !defined(__GNUC__)
 
 typedef
-   struct { 
+   struct {
       unsigned int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -348,7 +348,7 @@ valgrind_do_client_request_expr(uintptr_t _zzq_default, uintptr_t _zzq_request,
     ||  (defined(PLAT_amd64_win64) && defined(__GNUC__))
 
 typedef
-   struct { 
+   struct {
       unsigned long int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -420,7 +420,7 @@ typedef
 #if defined(PLAT_ppc32_linux)
 
 typedef
-   struct { 
+   struct {
       unsigned int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -489,7 +489,7 @@ typedef
 #if defined(PLAT_ppc64be_linux)
 
 typedef
-   struct { 
+   struct {
       unsigned long int nraddr; /* where's the code? */
       unsigned long int r2;  /* what tocptr do we need? */
    }
@@ -645,7 +645,7 @@ typedef
 #if defined(PLAT_arm_linux)
 
 typedef
-   struct { 
+   struct {
       unsigned int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -713,7 +713,7 @@ typedef
 #if defined(PLAT_arm64_linux)
 
 typedef
-   struct { 
+   struct {
       unsigned long int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -859,7 +859,7 @@ typedef
 #if defined(PLAT_mips32_linux)
 
 typedef
-   struct { 
+   struct {
       unsigned int nraddr; /* where's the code? */
    }
    OrigFn;
@@ -873,7 +873,7 @@ typedef
                      "srl $0, $0, 29\n\t"       \
                      "srl $0, $0, 3\n\t"        \
                      "srl $0, $0, 19\n\t"
-                    
+
 #define VALGRIND_DO_CLIENT_REQUEST_EXPR(                          \
        _zzq_default, _zzq_request,                                \
        _zzq_arg1, _zzq_arg2, _zzq_arg3, _zzq_arg4, _zzq_arg5)     \
@@ -2191,7 +2191,7 @@ typedef
 #define VALGRIND_RESTORE_STACK             \
       "mr 1,28\n\t"
 
-/* These CALL_FN_ macros assume that on ppc32-linux, 
+/* These CALL_FN_ macros assume that on ppc32-linux,
    sizeof(unsigned long) == 4. */
 
 #define CALL_FN_W_v(lval, orig)                                   \
@@ -4716,7 +4716,7 @@ typedef
       "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7"
 #endif
 
-/* Nb: Although r11 is modified in the asm snippets below (inside 
+/* Nb: Although r11 is modified in the asm snippets below (inside
    VALGRIND_CFI_PROLOGUE) it is not listed in the clobber section, for
    two reasons:
    (1) r11 is restored in VALGRIND_CFI_EPILOGUE, so effectively it is not
@@ -5165,7 +5165,7 @@ typedef
 #endif /* PLAT_s390x_linux */
 
 /* ------------------------- mips32-linux ----------------------- */
- 
+
 #if defined(PLAT_mips32_linux)
 
 /* These regs are trashed by the hidden call. */
@@ -6558,7 +6558,7 @@ typedef
 #define VG_IS_TOOL_USERREQ(a, b, v) \
    (VG_USERREQ_TOOL_BASE(a,b) == ((v) & 0xffff0000))
 
-/* !! ABIWARNING !! ABIWARNING !! ABIWARNING !! ABIWARNING !! 
+/* !! ABIWARNING !! ABIWARNING !! ABIWARNING !! ABIWARNING !!
    This enum comprises an ABI exported by Valgrind to programs
    which use client requests.  DO NOT CHANGE THE NUMERIC VALUES OF THESE
    ENTRIES, NOR DELETE ANY -- add new ones at the end of the most
@@ -6708,7 +6708,7 @@ VALGRIND_PRINTF(const char *format, ...)
    _qzz_res = VALGRIND_DO_CLIENT_REQUEST_EXPR(0,
                               VG_USERREQ__PRINTF_VALIST_BY_REF,
                               (unsigned long)format,
-                              (unsigned long)&vargs, 
+                              (unsigned long)&vargs,
                               0, 0, 0);
 #endif
    va_end(vargs);
@@ -6747,7 +6747,7 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
    _qzz_res = VALGRIND_DO_CLIENT_REQUEST_EXPR(0,
                               VG_USERREQ__PRINTF_BACKTRACE_VALIST_BY_REF,
                               (unsigned long)format,
-                              (unsigned long)&vargs, 
+                              (unsigned long)&vargs,
                               0, 0, 0);
 #endif
    va_end(vargs);
@@ -6757,7 +6757,7 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
 
 /* These requests allow control to move from the simulated CPU to the
    real CPU, calling an arbitrary function.
-   
+
    Note that the current ThreadId is inserted as the first argument.
    So this call:
 
@@ -6842,7 +6842,7 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
    - It marks the block as being addressable and undefined (if 'is_zeroed' is
      not set), or addressable and defined (if 'is_zeroed' is set).  This
      controls how accesses to the block by the program are handled.
-   
+
    'addr' is the start of the usable block (ie. after any
    redzone), 'sizeB' is its size.  'rzB' is the redzone size if the allocator
    can apply redzones -- these are blocks of padding at the start and end of
@@ -6850,7 +6850,7 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
    Valgrind will spot block overruns.  `is_zeroed' indicates if the memory is
    zeroed (or filled with another predictable value), as is the case for
    calloc().
-   
+
    VALGRIND_MALLOCLIKE_BLOCK should be put immediately after the point where a
    heap block -- that will be used by the client program -- is allocated.
    It's best to put it at the outermost level of the allocator if possible;
@@ -6938,8 +6938,8 @@ VALGRIND_PRINTF_BACKTRACE(const char *format, ...)
 
 /* Create a memory pool with some flags specifying extended behaviour.
    When flags is zero, the behaviour is identical to VALGRIND_CREATE_MEMPOOL.
-   
-   The flag VALGRIND_MEMPOOL_METAPOOL specifies that the pieces of memory 
+
+   The flag VALGRIND_MEMPOOL_METAPOOL specifies that the pieces of memory
    associated with the pool using VALGRIND_MEMPOOL_ALLOC  will be used
    by the application as superblocks to dole out MALLOC_LIKE blocks using
    VALGRIND_MALLOCLIKE_BLOCK. In other words, a meta pool is a "2 levels"
diff --git a/lib/dhry/dhry.h b/lib/dhry/dhry.h
index bd95540eeb2..0d4ff332f51 100644
--- a/lib/dhry/dhry.h
+++ b/lib/dhry/dhry.h
@@ -9,7 +9,7 @@
 /*****************************************************************************
  *  The BYTE UNIX Benchmarks - Release 3
  *          Module: dhry.h   SID: 3.4 5/15/91 19:30:21
- *          
+ *
  *****************************************************************************
  * Bug reports, patches, comments, suggestions should be sent to:
  *
@@ -23,9 +23,9 @@
  *
  *                   "DHRYSTONE" Benchmark Program
  *                   -----------------------------
- *                                                                            
+ *
  *  Version:    C, Version 2.1
- *                                                                            
+ *
  *  File:       dhry.h (part 1 of 3)
  *
  *  Date:       May 25, 1988
@@ -53,12 +53,12 @@
  *
  *  Collection of Results:
  *              Reinhold Weicker (address see above) and
- *              
+ *
  *              Rick Richardson
  *              PC Research. Inc.
  *              94 Apple Orchard Drive
  *              Tinton Falls, NJ 07724
- *                      Phone:  (201) 834-1378 (9-17 EST)               
+ *                      Phone:  (201) 834-1378 (9-17 EST)
  *                      Usenet: ...!seismo!uunet!pcrat!rick
  *
  *      Please send results to Rick Richardson and/or Reinhold Weicker.
@@ -111,7 +111,7 @@
  *              version previously distributed by Reinhold Weicker.
  *
  *              At several places in the benchmark, code has been added,
- *              but within the measurement loop only in branches that 
+ *              but within the measurement loop only in branches that
  *              are not executed. The intention is that optimizing compilers
  *              should be prevented from moving code out of the measurement
  *              loop, or from removing code altogether. Since the statements
@@ -121,7 +121,7 @@
  *              still hold. Except for sophisticated optimizing compilers,
  *              execution times for this version should be the same as
  *              for previous versions.
- *              
+ *
  *              Since it has proven difficult to subtract the time for the
  *              measurement loop overhead in a correct way, the loop check
  *              has been made a part of the benchmark. This does have
@@ -171,7 +171,7 @@
  *              -DTIME
  *                      The "times" function of UNIX (returning process times)
  *                      or the "time" function (returning wallclock time)
- *                      is used for measurement. 
+ *                      is used for measurement.
  *                      For single user machines, "time ()" is adequate. For
  *                      multi-user machines where you cannot get single-user
  *                      access, use the "times ()" function. If you have
@@ -218,23 +218,23 @@
  *   different from the Ada version.]
  *
  *  The following program contains statements of a high level programming
- *  language (here: C) in a distribution considered representative:           
+ *  language (here: C) in a distribution considered representative:
  *
  *    assignments                  52 (51.0 %)
  *    control statements           33 (32.4 %)
  *    procedure, function calls    17 (16.7 %)
  *
  *  103 statements are dynamically executed. The program is balanced with
- *  respect to the three aspects:                                             
+ *  respect to the three aspects:
  *
  *    - statement type
  *    - operand type
  *    - operand locality
- *         operand global, local, parameter, or constant.                     
+ *         operand global, local, parameter, or constant.
  *
- *  The combination of these three aspects is balanced only approximately.    
+ *  The combination of these three aspects is balanced only approximately.
  *
- *  1. Statement Type:                                                        
+ *  1. Statement Type:
  *  -----------------             number
  *
  *     V1 = V2                     9
@@ -278,9 +278,9 @@
  *       library procedure    1
  *     X = F (...)
  *             function  call      6
- *       user function        5                                         
- *       library function     1                                               
- *                                --                                          
+ *       user function        5
+ *       library function     1
+ *                                --
  *                                17       17
  *                                        ---
  *                                        103
@@ -294,10 +294,10 @@
  *                          number    approximate
  *                                    percentage
  *
- *    Arithmetic             32          50.8                                 
+ *    Arithmetic             32          50.8
  *
- *       +                     21          33.3                              
- *       -                      7          11.1                              
+ *       +                     21          33.3
+ *       -                      7          11.1
  *       *                      3           4.8
  *       / (int div)            1           1.6
  *
@@ -315,7 +315,7 @@
  *       && (AND-THEN)          1            1.6
  *       |  (OR)                1            1.6
  *       !  (NOT)               2            3.2
- * 
+ *
  *                           --          -----
  *                           63          100.1
  *
@@ -335,10 +335,10 @@
  *                           242       100.0 %
  *
  *  When there is an access path leading to the final operand (e.g. a record
- *  component), only the final data type on the access path is counted.       
+ *  component), only the final data type on the access path is counted.
  *
  *
- *  4. Operand Locality:                                                      
+ *  4. Operand Locality:
  *  -------------------
  *                                number    approximate
  *                                          percentage
@@ -397,7 +397,7 @@
 
 /* General definitions: */
 
-#define Null 0 
+#define Null 0
                 /* Value of a Null pointer */
 #define true  1
 #define false 0
@@ -410,7 +410,7 @@ typedef char    Str_30 [31];
 typedef int     Arr_1_Dim [50];
 typedef int     Arr_2_Dim [50] [50];
 
-typedef struct record 
+typedef struct record
     {
     struct record *Ptr_Comp;
     Enumeration    Discr;
-- 
2.43.0

