Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71882C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C5F888C1;
	Sat, 13 Jul 2024 15:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rsl+U/dq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tACxDS2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664A88887A; Sat, 13 Jul 2024 15:21:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DB2888B7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WLpyQ51gGz9scS;
 Sat, 13 Jul 2024 15:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmkGkkwK+aT71o/23aS64JWWuO7bBoOwxANq7i+kI1k=;
 b=rsl+U/dq6KEcsqdc4Dz+Gcl3QoV+hO+t66+erHgaoUh43Y+upuSQdLXNjnVoU4pDBL3ocI
 U9CfSYnprrtgJNJsRW3XNBSbKFa5gi23yaCeg5YsD/lEU+Vc80fV68e2irUViotAyAs1Vv
 5/7SKVOU3QiWbzLXid4oJF9pIQWN9iZK6kUvM0MpPQqgSRYK+XNsgdnyBZqtLvI2YdSTTs
 h1fmbyhzgd2xKnXS/zJvzlCW1fuigWDIWwKXsSJDNGQnRuUGLu27wrzEJOkkGzekZ97kLJ
 i/Mkg98SMi/tRQi0wDttBLq/z1uL1vIyWV2Rr+MhImtrUczOS75jtqGCq1EeJg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmkGkkwK+aT71o/23aS64JWWuO7bBoOwxANq7i+kI1k=;
 b=tACxDS2zlXuV8zhiaMoMr468YJORU2LxbzyS27GpynrNkGOhf8MQawgb6WqGKqCb4rETN/
 HBRuONifrMNL1m9Vsjsb7War6wYuLM70Lv5hfVoaK3AvaE6Re4w1FptKZLKKBMJWN5wCOm
 8oy4lVlk2FfGPUqIZq65+FkT7IrM4TlQhiB8zn8ABz9xdPMUlsPVTS1ICthcEBlBiezt2P
 GWVa+BLZHewbZ402yjO/sgWtauuRX3kcFw3Jsd9ai2gHwAwasM96sEg1qFzQRnxmT9s+a8
 fMmW/yzxvN/nFTdO2gHB6eXn3XMkVub8GB/h8MIDVAbfyhXx6ddhcJLWkRXlCg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/45] common: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:17 +0200
Message-ID: <20240713132021.57650-26-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b3cbe29218f4bf2f4fb
X-MBO-RS-META: hxh9pg9ygeejg6si41t7bh6hfywi5grt
X-Rspamd-Queue-Id: 4WLpyQ51gGz9scS
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 common/bootstage.c         |  1 -
 common/cli_hush.c          |  4 --
 common/cli_hush_upstream.c | 26 ------------
 common/dlmalloc.c          | 84 --------------------------------------
 common/edid.c              |  1 -
 common/kallsyms.c          |  1 -
 common/kgdb.c              |  1 -
 common/menu.c              |  1 -
 common/update.c            |  1 -
 common/usb.c               |  8 ----
 common/usb_hub.c           |  1 -
 common/usb_storage.c       |  4 --
 common/xyzModem.c          |  2 -
 13 files changed, 135 deletions(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index fb6befcbc4a..df83eb684c0 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011, Google Inc. All rights reserved.
  */
 
-
 /*
  * This module records the progress of boot and arbitrary commands, and
  * permits accurate timestamping of each.
diff --git a/common/cli_hush.c b/common/cli_hush.c
index 96a98209b9d..a6a8edce1f4 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -732,7 +732,6 @@ static int builtin_jobs(struct child_prog *child)
 	return EXIT_SUCCESS;
 }
 
-
 /* built-in 'pwd' handler */
 static int builtin_pwd(struct child_prog *dummy)
 {
@@ -784,7 +783,6 @@ static int builtin_set(struct child_prog *child)
 		return EXIT_SUCCESS;
 }
 
-
 /* Built-in 'shift' handler */
 static int builtin_shift(struct child_prog *child)
 {
@@ -1732,7 +1730,6 @@ static int run_pipe_real(struct pipe *pi)
 			pseudo_exec(child);
 		}
 
-
 		/* put our child in the process group whose leader is the
 		   first process in this pipe */
 		if (pi->pgrp < 0) {
@@ -3409,7 +3406,6 @@ int hush_main(int argc, char * const *argv)
 
 	last_return_code=EXIT_SUCCESS;
 
-
 	if (argv[0] && argv[0][0] == '-') {
 		debug_printf("\nsourcing /etc/profile\n");
 		if ((input = fopen("/etc/profile", "r")) != NULL) {
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index ca40bbb2cd8..7874b399d14 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -392,7 +392,6 @@
 #define BASH_TEST2         (ENABLE_HUSH_BASH_COMPAT && ENABLE_HUSH_TEST)
 #define BASH_READ_D        ENABLE_HUSH_BASH_COMPAT
 
-
 /* Build knobs */
 #define LEAK_HUNTING 0
 #define BUILD_AS_NOMMU 0
@@ -413,7 +412,6 @@
  */
 #define ENABLE_HUSH_DOLLAR_OPS 1
 
-
 #if BUILD_AS_NOMMU
 # undef BB_MMU
 # undef USE_FOR_NOMMU
@@ -519,7 +517,6 @@ typedef struct nommu_save_t {
 } nommu_save_t;
 #endif
 
-
 enum {
 	RES_NONE  = 0,
 #if ENABLE_HUSH_IF
@@ -829,7 +826,6 @@ struct function {
 };
 #endif
 
-
 /* set -/+o OPT support. (TODO: make it optional)
  * bash supports the following opts:
  * allexport       off
@@ -1118,7 +1114,6 @@ struct globals *ptr_to_globals;
 } while (0)
 #endif /* !__U_BOOT__ */
 
-
 #ifndef __U_BOOT__
 /* Function prototypes for builtins */
 static int builtin_cd(char **argv) FAST_FUNC;
@@ -1416,7 +1411,6 @@ static void debug_print_strings(const char *prefix, char **vv)
 # define debug_print_strings(prefix, vv) ((void)0)
 #endif
 
-
 /* Leak hunting. Use hush_leaktool.sh for post-processing.
  */
 #if LEAK_HUNTING
@@ -1449,7 +1443,6 @@ static void xxfree(void *ptr)
 # define free(p)        xxfree(p)
 #endif
 
-
 /* Syntax and runtime errors. They always abort scripts.
  * In interactive use they usually discard unparsed and/or unexecuted commands
  * and return to the prompt.
@@ -1689,7 +1682,6 @@ static int xdup_CLOEXEC_and_close(int fd, int avoid_fd)
 	return newfd;
 }
 
-
 /* Manipulating HFILEs */
 static HFILE *hfopen(const char *name)
 {
@@ -1882,7 +1874,6 @@ static void restore_G_args(save_arg_t *sv, char **argv)
 }
 #endif /* !__U_BOOT__ */
 
-
 #ifndef __U_BOOT__
 /* Basic theory of signal handling in shell
  * ========================================
@@ -2331,7 +2322,6 @@ static int check_and_run_traps(void)
 	return last_sig;
 }
 
-
 static const char *get_cwd(int force)
 {
 	if (force || G.cwd == NULL) {
@@ -2653,7 +2643,6 @@ static int unset_local_var(const char *name)
 }
 #endif
 
-
 #ifndef __U_BOOT__
 /*
  * Helpers for "var1=val1 var2=val2 cmd" feature
@@ -2728,7 +2717,6 @@ static void set_vars_and_save_old(char **strings)
 	free(strings);
 }
 
-
 /*
  * Unicode helper
  */
@@ -3236,7 +3224,6 @@ static void setup_string_in_str(struct in_str *i, const char *s)
 	i->p = s;
 }
 
-
 /*
  * o_string support
  */
@@ -3997,7 +3984,6 @@ static void free_pipe_list(struct pipe *pi)
 	}
 }
 
-
 /*** Parsing routines ***/
 
 #ifndef debug_print_tree
@@ -4648,7 +4634,6 @@ static int done_word(struct parse_context *ctx)
 	return 0;
 }
 
-
 #ifndef __U_BOOT__
 /* Peek ahead in the input to find out if we have a "&n" construct,
  * as in "2>&1", that represents duplicating a file descriptor.
@@ -4958,7 +4943,6 @@ static int fetch_heredocs(o_string *as_string, struct pipe *pi, int heredoc_cnt,
 	return heredoc_cnt;
 }
 
-
 static int run_list(struct pipe *pi);
 #if BB_MMU
 #define parse_stream(pstring, heredoc_cnt_ptr, input, end_trigger) \
@@ -5175,7 +5159,6 @@ static int add_till_double_quote(o_string *dest, struct in_str *input)
 	}
 }
 
-
 /* Process `cmd` - copy contents until "`" is seen. Complicated by
  * \` quoting.
  * "Within the backquoted style of command substitution, backslash
@@ -6477,7 +6460,6 @@ static struct pipe *parse_stream(char **pstring,
 	}
 }
 
-
 /*** Execution routines ***/
 
 /* Expansion can recurse, need forward decls: */
@@ -7778,7 +7760,6 @@ static char **expand_assignments(char **argv, int count)
 	return p;
 }
 
-
 static void switch_off_special_sigs(unsigned mask)
 {
 	unsigned sig = 0;
@@ -8297,7 +8278,6 @@ static int process_command_subs(o_string *dest, const char *s)
 }
 #endif /* ENABLE_HUSH_TICK */
 
-
 static void setup_heredoc(struct redir_struct *redir)
 {
 	struct fd_pair pair;
@@ -9006,7 +8986,6 @@ static int run_function(const struct function *funcp, char **argv)
 }
 #endif /* ENABLE_HUSH_FUNCTIONS */
 
-
 #ifndef __U_BOOT__
 #if BB_MMU
 #define exec_builtin(to_free, x, argv) \
@@ -9042,7 +9021,6 @@ static void exec_builtin(char ***to_free,
 }
 #endif /* !__U_BOOT__ */
 
-
 #ifndef __U_BOOT__
 static void execvp_or_die(char **argv) NORETURN;
 static void execvp_or_die(char **argv)
@@ -10839,7 +10817,6 @@ static int run_and_free_list(struct pipe *pi)
 	return rcode;
 }
 
-
 #ifndef __U_BOOT__
 static void install_sighandlers(unsigned mask)
 {
@@ -11524,8 +11501,6 @@ int hush_main(int argc, char **argv)
 	hush_exit(G.last_exitcode);
 }
 
-
-
 /*
  * Built-ins
  */
@@ -13004,7 +12979,6 @@ static int FAST_FUNC builtin_memleak(char **argv UNUSED_PARAM)
 	if (l < (unsigned long)p) l = (unsigned long)p;
 	free(p);
 
-
 # if 0  /* debug */
 	{
 		struct mallinfo mi = mallinfo();
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 9549c59f358..62e8557daa7 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -53,7 +53,6 @@ static inline void MALLOC_COPY(void *dest, const void *src, size_t sz) { memcpy(
   Thanks to Martin Fong and others for supplying this.
 */
 
-
 #ifdef WIN32
 
 #define AlignPage(add) (((add) + (malloc_getpagesize-1)) & \
@@ -155,7 +154,6 @@ void* findRegion (void* start_address, unsigned long size)
 
 }
 
-
 void* wsbrk (long size)
 {
 	void* tmp;
@@ -236,13 +234,10 @@ gAllocatedSize))
 
 #endif
 
-
-
 /*
   Type declarations
 */
 
-
 struct malloc_chunk
 {
   INTERNAL_SIZE_T prev_size; /* Size of previous chunk (if free). */
@@ -270,7 +265,6 @@ typedef struct malloc_chunk* mchunkptr;
 
     An allocated chunk looks like this:
 
-
     chunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 	    |             Size of previous chunk, if allocated            | |
 	    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
@@ -284,7 +278,6 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 	    |             Size of chunk                                     |
 	    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
-
     Where "chunk" is the front of the chunk for the purpose of most of
     the malloc code, but "mem" is the pointer that is returned to the
     user.  "Nextchunk" is the beginning of the next contiguous chunk.
@@ -401,14 +394,10 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
 #define aligned_OK(m)    (((unsigned long)((m)) & (MALLOC_ALIGN_MASK)) == 0)
 
-
-
-
 /*
   Physical chunk operations
 */
 
-
 /* size field is or'ed with PREV_INUSE when previous adjacent chunk in use */
 
 #define PREV_INUSE 0x1
@@ -421,7 +410,6 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
 #define SIZE_BITS (PREV_INUSE|IS_MMAPPED)
 
-
 /* Ptr to next physical malloc_chunk. */
 
 #define next_chunk(p) ((mchunkptr)( ((char*)(p)) + ((p)->size & ~PREV_INUSE) ))
@@ -431,14 +419,10 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 #define prev_chunk(p)\
    ((mchunkptr)( ((char*)(p)) - ((p)->prev_size) ))
 
-
 /* Treat space at ptr + offset as a chunk */
 
 #define chunk_at_offset(p, s)  ((mchunkptr)(((char*)(p)) + (s)))
 
-
-
-
 /*
   Dealing with use bits
 */
@@ -475,9 +459,6 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 #define clear_inuse_bit_at_offset(p, s)\
  (((mchunkptr)(((char*)(p)) + (s)))->size &= ~(PREV_INUSE))
 
-
-
-
 /*
   Dealing with size fields
 */
@@ -498,10 +479,6 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
 #define set_foot(p, s)   (((mchunkptr)((char*)(p) + (s)))->prev_size = (s))
 
-
-
-
-
 /*
    Bins
 
@@ -555,7 +532,6 @@ typedef struct malloc_chunk* mbinptr;
 #define top            (av_[2])          /* The topmost chunk */
 #define last_remainder (bin_at(1))       /* remainder from last split */
 
-
 /*
    Because top initially points to its own bin with initial
    zero size, thus forcing extension on the first malloc request,
@@ -671,8 +647,6 @@ void mem_malloc_init(ulong start, ulong size)
 
 #define is_small_request(nb) (nb < MAX_SMALLBIN_SIZE - SMALLBIN_WIDTH)
 
-
-
 /*
     To help compensate for the large number of bins, a one-level index
     structure is used for bin-by-bin searching.  `binblocks' is a
@@ -694,10 +668,6 @@ void mem_malloc_init(ulong start, ulong size)
 #define mark_binblock(ii)   (binblocks_w = (mbinptr)(binblocks_r | idx2binblock(ii)))
 #define clear_binblock(ii)  (binblocks_w = (mbinptr)(binblocks_r & ~(idx2binblock(ii))))
 
-
-
-
-
 /*  Other static bookkeeping data */
 
 /* variables holding tunable values */
@@ -770,7 +740,6 @@ static void malloc_init(void)
 
 #ifdef DEBUG
 
-
 /*
   These routines make a number of assertions about the states
   of data structures that should be true at all times. If any
@@ -799,7 +768,6 @@ static void do_check_chunk(p) mchunkptr p;
 
 }
 
-
 #if __STD_C
 static void do_check_free_chunk(mchunkptr p)
 #else
@@ -885,13 +853,11 @@ static void do_check_malloced_chunk(p, s) mchunkptr p; INTERNAL_SIZE_T s;
   /* ... and alignment */
   assert(aligned_OK(chunk2mem(p)));
 
-
   /* ... and was allocated at front of an available chunk */
   assert(prev_inuse(p));
 
 }
 
-
 #define check_free_chunk(P)  do_check_free_chunk(P)
 #define check_inuse_chunk(P) do_check_inuse_chunk(P)
 #define check_chunk(P) do_check_chunk(P)
@@ -903,13 +869,10 @@ static void do_check_malloced_chunk(p, s) mchunkptr p; INTERNAL_SIZE_T s;
 #define check_malloced_chunk(P,N)
 #endif
 
-
-
 /*
   Macro-based internal utilities
 */
 
-
 /*
   Linking chunks in bin lists.
   Call these only with variables, not arbitrary expressions, as arguments.
@@ -920,7 +883,6 @@ static void do_check_malloced_chunk(p, s) mchunkptr p; INTERNAL_SIZE_T s;
   putting it ahead of others of same size.
 */
 
-
 #define frontlink(P, S, IDX, BK, FD)                                          \
 {                                                                             \
   if (S < MAX_SMALLBIN_SIZE)                                                  \
@@ -950,7 +912,6 @@ static void do_check_malloced_chunk(p, s) mchunkptr p; INTERNAL_SIZE_T s;
   }                                                                           \
 }
 
-
 /* take a chunk off a list */
 
 #define unlink(P, BK, FD)                                                     \
@@ -974,10 +935,6 @@ static void do_check_malloced_chunk(p, s) mchunkptr p; INTERNAL_SIZE_T s;
 #define clear_last_remainder \
   (last_remainder->fd = last_remainder->bk = last_remainder)
 
-
-
-
-
 /* Routines dealing with mmap(). */
 
 #if HAVE_MMAP
@@ -1219,12 +1176,8 @@ static void malloc_extend_top(nb) INTERNAL_SIZE_T nb;
   assert(((unsigned long)((char*)top + top_size) & (pagesz - 1)) == 0);
 }
 
-
-
-
 /* Main public routines */
 
-
 /*
   Malloc Algorthim:
 
@@ -1275,7 +1228,6 @@ static void malloc_extend_top(nb) INTERNAL_SIZE_T nb;
 	 contiguous memory. Thus, it should be safe to intersperse
 	 mallocs with other sbrk calls.
 
-
       All allocations are made from the the `lowest' part of any found
       chunk. (The implementation invariant is that prev_inuse is
       always true of any allocated chunk; i.e., that each allocated
@@ -1514,7 +1466,6 @@ Void_t* mALLOc_impl(bytes) size_t bytes;
     }
   }
 
-
   /* Try to use top chunk */
 
   /* Require that there be a remainder, ensuring top always exists  */
@@ -1545,9 +1496,6 @@ Void_t* mALLOc_impl(bytes) size_t bytes;
 
 }
 
-
-
-
 /*
 
   free() algorithm :
@@ -1569,7 +1517,6 @@ Void_t* mALLOc_impl(bytes) size_t bytes;
 
 */
 
-
 STATIC_IF_MCHECK
 #if __STD_C
 void fREe_impl(Void_t* mem)
@@ -1665,17 +1612,12 @@ void fREe_impl(mem) Void_t* mem;
       unlink(next, bck, fwd);
   }
 
-
   set_head(p, sz | PREV_INUSE);
   set_foot(p, sz);
   if (!islr)
     frontlink(p, sz, idx, bck, fwd);
 }
 
-
-
-
-
 /*
 
   Realloc algorithm:
@@ -1708,10 +1650,8 @@ void fREe_impl(mem) Void_t* mem;
     and allowing it would also allow too many other incorrect
     usages of realloc to be sensible.
 
-
 */
 
-
 STATIC_IF_MCHECK
 #if __STD_C
 Void_t* rEALLOc_impl(Void_t* oldmem, size_t bytes)
@@ -1762,7 +1702,6 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
   newp    = oldp    = mem2chunk(oldmem);
   newsize = oldsize = chunksize(oldp);
 
-
   nb = request2size(bytes);
 
 #if HAVE_MMAP
@@ -1910,7 +1849,6 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
     VALGRIND_MAKE_MEM_DEFINED(oldmem, bytes);
   }
 
-
  split:  /* split off extra room in old or expanded chunk */
 
   if (newsize - nb >= MINSIZE) /* split off remainder */
@@ -1934,9 +1872,6 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
   return chunk2mem(newp);
 }
 
-
-
-
 /*
 
   memalign algorithm:
@@ -1955,7 +1890,6 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
 
 */
 
-
 STATIC_IF_MCHECK
 #if __STD_C
 Void_t* mEMALIGn_impl(size_t alignment, size_t bytes)
@@ -2104,9 +2038,6 @@ Void_t* mEMALIGn_impl(alignment, bytes) size_t alignment; size_t bytes;
 
 }
 
-
-
-
 /*
     valloc just invokes memalign with alignment argument equal
     to the page size of the system (or as near to this as can
@@ -2127,7 +2058,6 @@ Void_t* vALLOc(bytes) size_t bytes;
   that will accommodate request
 */
 
-
 #if __STD_C
 Void_t* pvALLOc(size_t bytes)
 #else
@@ -2156,7 +2086,6 @@ Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
 
   INTERNAL_SIZE_T sz = n * elem_size;
 
-
   /* check if expand_top called, in which case don't need to clear */
 #if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 #if MORECORE_CLEARS
@@ -2182,7 +2111,6 @@ Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
 
     /* Two optional cases in which clearing not necessary */
 
-
 #if HAVE_MMAP
     if (chunk_is_mmapped(p)) return mem;
 #endif
@@ -2223,7 +2151,6 @@ void cfree(mem) Void_t *mem;
 }
 #endif
 
-
 #ifdef MCHECK_HEAP_PROTECTION
  #include "mcheck_core.inc.h"
  #if !__STD_C
@@ -2308,7 +2235,6 @@ enum mcheck_status mprobe(void *__ptr) { return mcheck_mprobe(__ptr); }
 // mcheck API }
 #endif
 
-
 /*
 
     Malloc_trim gives memory back to the system (via negative
@@ -2388,8 +2314,6 @@ int malloc_trim(pad) size_t pad;
   }
 }
 
-
-
 /*
   malloc_usable_size:
 
@@ -2423,9 +2347,6 @@ size_t malloc_usable_size(mem) Void_t* mem;
   }
 }
 
-
-
-
 /* Utility to update current_mallinfo for malloc_stats and mallinfo() */
 
 #ifdef DEBUG
@@ -2468,8 +2389,6 @@ static void malloc_update_mallinfo(void)
 }
 #endif	/* DEBUG */
 
-
-
 /*
 
   malloc_stats:
@@ -2514,9 +2433,6 @@ struct mallinfo mALLINFo(void)
 }
 #endif	/* DEBUG */
 
-
-
-
 /*
   mallopt:
 
diff --git a/common/edid.c b/common/edid.c
index 865ba9daa78..48a737690db 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -268,7 +268,6 @@ int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
 					panel_bits_per_colourp, NULL, NULL);
 }
 
-
 /**
  * Snip the tailing whitespace/return of a string.
  *
diff --git a/common/kallsyms.c b/common/kallsyms.c
index 49b3897078a..91594414099 100644
--- a/common/kallsyms.c
+++ b/common/kallsyms.c
@@ -5,7 +5,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-
 /* We need the weak marking as this symbol is provided specially */
 extern const char system_map[] __attribute__((weak));
 
diff --git a/common/kgdb.c b/common/kgdb.c
index 01a09f17628..ed2798bea24 100644
--- a/common/kgdb.c
+++ b/common/kgdb.c
@@ -446,7 +446,6 @@ handle_exception (struct pt_regs *regs)
 			}
 			break;
 
-
 		case 'k':    /* kill the program, actually return to monitor */
 			kd.extype = KGDBEXIT_KILL;
 			*regs = entry_regs;
diff --git a/common/menu.c b/common/menu.c
index e48424995b6..8cc9bf06d9c 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -398,7 +398,6 @@ struct menu *menu_create(char *title, int timeout, int prompt,
 	} else
 		m->title = NULL;
 
-
 	INIT_LIST_HEAD(&m->items);
 
 	return m;
diff --git a/common/update.c b/common/update.c
index eb0b60a2ce4..6801b49479d 100644
--- a/common/update.c
+++ b/common/update.c
@@ -254,7 +254,6 @@ int update_tftp(ulong addr, char *interface, char *devstring)
 	else
 		addr = CONFIG_UPDATE_LOAD_ADDR;
 
-
 	if (update_load(filename, CONFIG_UPDATE_TFTP_MSEC_MAX,
 					CONFIG_UPDATE_TFTP_CNT_MAX, addr)) {
 		printf("Can't load update file, aborting auto-update\n");
diff --git a/common/usb.c b/common/usb.c
index f5b21c883f3..7a8435296c6 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -190,7 +190,6 @@ int usb_disable_asynch(int disable)
 }
 #endif /* !CONFIG_IS_ENABLED(DM_USB) */
 
-
 /*-------------------------------------------------------------------
  * Message wrappers.
  *
@@ -293,7 +292,6 @@ int usb_bulk_msg(struct usb_device *dev, unsigned int pipe,
 		return -EIO;
 }
 
-
 /*-------------------------------------------------------------------
  * Max Packet stuff
  */
@@ -559,7 +557,6 @@ int usb_clear_halt(struct usb_device *dev, int pipe)
 	return 0;
 }
 
-
 /**********************************************************************
  * get_descriptor type
  */
@@ -768,7 +765,6 @@ static int usb_get_string(struct usb_device *dev, unsigned short langid,
 	return result;
 }
 
-
 static void usb_try_string_workarounds(unsigned char *buf, int *length)
 {
 	int newlength, oldlength = *length;
@@ -783,7 +779,6 @@ static void usb_try_string_workarounds(unsigned char *buf, int *length)
 	}
 }
 
-
 static int usb_string_sub(struct usb_device *dev, unsigned int langid,
 		unsigned int index, unsigned char *buf)
 {
@@ -818,7 +813,6 @@ static int usb_string_sub(struct usb_device *dev, unsigned int langid,
 	return rc;
 }
 
-
 /********************************************************************
  * usb_string:
  * Get string index and translate it to ascii.
@@ -874,7 +868,6 @@ int usb_string(struct usb_device *dev, int index, char *buf, size_t size)
 	return err;
 }
 
-
 /********************************************************************
  * USB device handling:
  * the USB device are static allocated [USB_MAX_DEVICE].
@@ -1388,5 +1381,4 @@ void usb_find_usb2_hub_address_port(struct usb_device *udev,
 }
 #endif
 
-
 /* EOF */
diff --git a/common/usb_hub.c b/common/usb_hub.c
index 807f490bb60..6a4bcec00bc 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -162,7 +162,6 @@ int usb_get_port_status(struct usb_device *dev, int port, void *data)
 	return ret;
 }
 
-
 static void usb_hub_power_on(struct usb_hub_device *hub)
 {
 	int i;
diff --git a/common/usb_storage.c b/common/usb_storage.c
index a79ed2e23a4..ac331f1c1b0 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -31,7 +31,6 @@
  * only been tested with USB memory sticks.
  */
 
-
 #include <blk.h>
 #include <bootdev.h>
 #include <command.h>
@@ -352,7 +351,6 @@ static int usb_stor_irq(struct usb_device *dev)
 	return 0;
 }
 
-
 #ifdef	DEBUG
 
 static void usb_show_srb(struct scsi_cmd *pccb)
@@ -664,7 +662,6 @@ static int usb_stor_CB_comdat(struct scsi_cmd *srb, struct us_data *us)
 	return result;
 }
 
-
 static int usb_stor_CBI_get_status(struct scsi_cmd *srb, struct us_data *us)
 {
 	int timeout;
@@ -1116,7 +1113,6 @@ static int usb_write_10(struct scsi_cmd *srb, struct us_data *ss,
 	return ss->transport(srb, ss);
 }
 
-
 #ifdef CONFIG_USB_BIN_FIXUP
 /*
  * Some USB storage devices queried for SCSI identification data respond with
diff --git a/common/xyzModem.c b/common/xyzModem.c
index 9feb240de28..09f74a1f0c7 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -62,7 +62,6 @@ static struct
 #define xyzModem_MAX_RETRIES_WITH_CRC    10
 #define xyzModem_CAN_COUNT                3	/* Wait for 3 CAN before quitting */
 
-
 typedef int cyg_int32;
 static int
 CYGACC_COMM_IF_GETC_TIMEOUT (char chan, char *c)
@@ -177,7 +176,6 @@ parse_num (char *s, unsigned long *val, char **es, char *delim)
   return true;
 }
 
-
 #if defined(DEBUG) && !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 /*
  * Note: this debug setup works by storing the strings in a fixed buffer
-- 
2.43.0

