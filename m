Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6A9CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF038812C;
	Tue,  2 Apr 2024 13:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0085988130; Tue,  2 Apr 2024 13:29:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A615688123
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D81C01007;
 Tue,  2 Apr 2024 04:29:58 -0700 (PDT)
Received: from localhost.localdomain (X72Y076X74.nice.arm.com [10.34.129.30])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 401FF3F766; Tue,  2 Apr 2024 04:29:26 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH] trace: use dynamic string buffer in make_flamegraph()
Date: Tue,  2 Apr 2024 13:29:16 +0200
Message-ID: <20240402112916.1613819-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The str[] buffer declared in make_flamegraph() is used to hold strings
representing the full call-stacks recorded in traces. The size of this
buffer is currently 500 characters and this works well for the documented
examples.

However, it is possible to exhaust this buffer when processing traces
captured when running the UEFI shell on aarch64 sandbox for example.
Indeed, the maximum length needed for such traces can reach 780 characters.

As it is difficult to evaluate the maximum size that would ever be needed
for all the possible traces, let's use a dynamically allocated `abuf'
instead, which we reallocate when needed.

This fixes the following error:

  String too short (500 chars)

While at it, fix a few typos in strings and comments.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
---


Hi,

This can be verified using the `test_trace.py' pytest as a starting point.

Configure with `sandbox_defconfig' plus the following options:

  CONFIG_TRACE=y
  CONFIG_TRACE_BUFFER_SIZE=0x02000000
  CONFIG_TRACE_EARLY=y
  CONFIG_TRACE_EARLY_SIZE=0x01000000

Build with:

  make FTRACE=1 NO_LTO=1

Run the test with:

  ./test/py/test.py --bd sandbox --build-dir . -k trace -s

Note that no reallocation happens during the test as the initial size of
500 characters is never exhausted; reduce the size manually if you want to
force re-allocation.

Also, make sure to delete /tmp/test_trace between tests.

Best regards,
Vincent Stehlé


 tools/proftool.c | 58 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index fca45e4a5af..c2e38099354 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -290,7 +290,7 @@ static void usage(void)
 		"Options:\n"
 		"   -c <cfg>\tSpecify config file\n"
 		"   -f <subtype>\tSpecify output subtype\n"
-		"   -m <map>\tSpecify Systen.map file\n"
+		"   -m <map>\tSpecify System.map file\n"
 		"   -o <fname>\tSpecify output file\n"
 		"   -t <fname>\tSpecify trace data file (from U-Boot 'trace calls')\n"
 		"   -v <0-4>\tSpecify verbosity\n"
@@ -306,7 +306,7 @@ static void usage(void)
 }
 
 /**
- * h_cmp_offset - bsearch() function to compare two functions bny their offset
+ * h_cmp_offset - bsearch() function to compare two functions by their offset
  *
  * @v1: Pointer to first function (struct func_info)
  * @v2: Pointer to second function (struct func_info)
@@ -431,7 +431,7 @@ static struct func_info *find_func_by_offset(uint offset)
 static struct func_info *find_caller_by_offset(uint offset)
 {
 	int low;	/* least function that could be a match */
-	int high;	/* greated function that could be a match */
+	int high;	/* greatest function that could be a match */
 	struct func_info key;
 
 	low = 0;
@@ -1352,7 +1352,7 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 		}
 
 		if (!(func->flags & FUNCF_TRACE)) {
-			debug("Funcion '%s' is excluded from trace\n",
+			debug("Function '%s' is excluded from trace\n",
 			      func->name);
 			skip_count++;
 			continue;
@@ -1781,7 +1781,8 @@ static int make_flame_tree(enum out_format_t out_format,
  *
  * This works by maintaining a string shared across all recursive calls. The
  * function name for this node is added to the existing string, to make up the
- * full call-stack description. For example, on entry, @str might contain:
+ * full call-stack description. For example, on entry, @str_buf->data might
+ * contain:
  *
  *    "initf_bootstage;bootstage_mark_name"
  *                                        ^ @base
@@ -1795,18 +1796,18 @@ static int make_flame_tree(enum out_format_t out_format,
  * @fout: Output file
  * @out_format: Output format to use
  * @node: Node to output (pass the whole tree at first)
- * @str: String to use to build the output line (e.g. 500 charas long)
- * @maxlen: Maximum length of string
+ * @str_buf: String buffer to use to build the output line
  * @base: Current base position in the string
  * @treep: Returns the resulting flamegraph tree
  * Returns 0 if OK, -1 on error
  */
 static int output_tree(FILE *fout, enum out_format_t out_format,
-		       const struct flame_node *node, char *str, int maxlen,
+		       const struct flame_node *node, struct abuf *str_buf,
 		       int base)
 {
 	const struct flame_node *child;
 	int pos;
+	char *str = abuf_data(str_buf);
 
 	if (node->count) {
 		if (out_format == OUT_FMT_FLAMEGRAPH_CALLS) {
@@ -1832,18 +1833,29 @@ static int output_tree(FILE *fout, enum out_format_t out_format,
 	if (pos)
 		str[pos++] = ';';
 	list_for_each_entry(child, &node->child_head, sibling_node) {
-		int len;
+		int len, needed;
 
 		len = strlen(child->func->name);
-		if (pos + len + 1 >= maxlen) {
-			fprintf(stderr, "String too short (%d chars)\n",
-				maxlen);
-			return -1;
+		needed = pos + len + 1;
+		if (needed > abuf_size(str_buf)) {
+			/*
+			 * We need to re-allocate the string buffer; increase
+			 * its size by multiples of 500 characters.
+			 */
+			needed = 500 * ((needed / 500) + 1);
+			if (!abuf_realloc(str_buf, needed))
+				return -1;
+			str = abuf_data(str_buf);
+			memset(str + pos, 0, abuf_size(str_buf) - pos);
 		}
 		strcpy(str + pos, child->func->name);
-		if (output_tree(fout, out_format, child, str, maxlen,
-				pos + len))
+		if (output_tree(fout, out_format, child, str_buf, pos + len))
 			return -1;
+		/*
+		 * Update our pointer as the string buffer might have been
+		 * re-allocated.
+		 */
+		str = abuf_data(str_buf);
 	}
 
 	return 0;
@@ -1859,16 +1871,24 @@ static int output_tree(FILE *fout, enum out_format_t out_format,
 static int make_flamegraph(FILE *fout, enum out_format_t out_format)
 {
 	struct flame_node *tree;
-	char str[500];
+	struct abuf str_buf;
+	char *str;
+	int ret = 0;
 
 	if (make_flame_tree(out_format, &tree))
 		return -1;
 
-	*str = '\0';
-	if (output_tree(fout, out_format, tree, str, sizeof(str), 0))
+	abuf_init(&str_buf);
+	if (!abuf_realloc(&str_buf, 500))
 		return -1;
 
-	return 0;
+	str = abuf_data(&str_buf);
+	memset(str, 0, abuf_size(&str_buf));
+	if (output_tree(fout, out_format, tree, &str_buf, 0))
+		ret = -1;
+
+	abuf_uninit(&str_buf);
+	return ret;
 }
 
 /**
-- 
2.43.0

