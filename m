Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68524CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEFB848D6;
	Sat, 16 May 2026 03:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04FC84812; Sat, 16 May 2026 01:38:31 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DCC68480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO26d-000000004iB-2QSv; Fri, 15 May 2026 23:38:11 +0000
Date: Sat, 16 May 2026 00:38:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 4/8] tools: mkimage: add dm-verity Merkle-tree generation
Message-ID: <10af28b276e51a3297862a518efb282c5ff82a2a.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

When mkimage encounters a dm-verity subnode inside a component image
node it now automatically invokes veritysetup(8) with --no-superblock
to generate the Merkle hash tree, screen-scrapes the Root hash and Salt
from the tool output, and writes the computed properties back into the
FIT blob.

The user only needs to specify algorithm, data-block-size, and
hash-block-size in the ITS; mkimage fills in digest, salt,
num-data-blocks, and hash-start-block. Because --no-superblock is
used, hash-start-block equals num-data-blocks with no off-by-one.

The image data property is replaced with the expanded content (original
data followed directly by the hash tree) so that subsequent hash and
signature subnodes operate on the complete image.

fit_image_add_verification_data() is restructured into two passes:
dm-verity first (may grow data), then hashes and signatures.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5:
 * drop the unused image_noffset parameter from
   fit_image_process_verity()
 * replace popen() and the valid_algos[] allowlist with
   fork()/execvp(); shell-injection vector gone, allowlist drift gone
 * drop the verity-data-file FDT property; cache the expanded buffer
   in memory keyed by image name, expose fit_verity_get_expanded()
   so fit_extract_data() consumes the buffer directly; the temporary
   file is unlinked immediately after read-back, eliminating the
   tmpfile-leak surface
 * use unsigned int for data-block-size / hash-block-size on the
   host side too (consistency with v3 runtime change)
v4: no changes
v3: extend the block-count overflow check to also cover hash_start_block
    (matters when hash-block-size < data-block-size)
v2:
 * use existing hex2bin() instead of open-coding it
 * fix stale comment still mentioning the verity superblock
 * add power-of-two check for data-block-size and hash-block-size
 * don't ignore return value of fdt_delprop()
---
 include/image.h    |  18 ++
 tools/fit_image.c  |  91 +++++++++-
 tools/image-host.c | 414 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 514 insertions(+), 9 deletions(-)

diff --git a/include/image.h b/include/image.h
index fe2361a667e..15275579268 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1427,6 +1427,24 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 			      const char *cmdname, const char *algo_name,
 			      struct image_summary *summary);
 
+#ifdef USE_HOSTCC
+/**
+ * fit_verity_get_expanded() - look up the cached dm-verity expanded buffer
+ *
+ * After mkimage has run veritysetup on a FILESYSTEM image, the original
+ * data concatenated with the Merkle hash tree is cached in memory keyed
+ * by image name. fit_extract_data() retrieves it to write the external
+ * data section without having to re-read a temporary file from disk.
+ *
+ * @name:	image unit name (FDT node name under /images)
+ * @data:	output -- pointer to cached buffer (do NOT free; lifetime
+ *		ends when mkimage exits)
+ * @size:	output -- size of @data in bytes
+ * Return: 0 if a cache entry exists for @name, -ENOENT otherwise
+ */
+int fit_verity_get_expanded(const char *name, const void **data, size_t *size);
+#endif /* USE_HOSTCC */
+
 /**
  * fit_image_verify_with_data() - Verify an image with given data
  *
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 1dbc14c63e4..6af55fa0355 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -40,10 +40,10 @@ static int fit_estimate_hash_sig_size(struct image_tool_params *params, const ch
 		return -EIO;
 
 	/*
-	 * Walk the FIT image, looking for nodes named hash* and
-	 * signature*. Since the interesting nodes are subnodes of an
-	 * image or configuration node, we are only interested in
-	 * those at depth exactly 3.
+	 * Walk the FIT image, looking for nodes named hash*,
+	 * signature*, and dm-verity. Since the interesting nodes are
+	 * subnodes of an image or configuration node, we are only
+	 * interested in those at depth exactly 3.
 	 *
 	 * The estimate for a hash node is based on a sha512 digest
 	 * being 64 bytes, with another 64 bytes added to account for
@@ -55,6 +55,10 @@ static int fit_estimate_hash_sig_size(struct image_tool_params *params, const ch
 	 * account for fdt overhead and the various other properties
 	 * (hashed-nodes etc.) that will also be filled in.
 	 *
+	 * For a dm-verity node the small metadata properties (digest,
+	 * salt, two u32s and a temp-file path) are written into the
+	 * FDT by fit_image_process_verity().
+	 *
 	 * One could try to be more precise in the estimates by
 	 * looking at the "algo" property and, in the case of
 	 * configuration signatures, the sign-images property. Also,
@@ -76,6 +80,18 @@ static int fit_estimate_hash_sig_size(struct image_tool_params *params, const ch
 
 		if (signing && !strncmp(name, FIT_SIG_NODENAME, strlen(FIT_SIG_NODENAME)))
 			estimate += 1024;
+
+		if (!strcmp(name, FIT_VERITY_NODENAME)) {
+			if (!params->external_data) {
+				fprintf(stderr,
+					"%s: dm-verity requires external data (-E)\n",
+					params->cmdname);
+				munmap(fdt, sbuf.st_size);
+				close(fd);
+				return -EINVAL;
+			}
+			estimate += 256;
+		}
 	}
 
 	munmap(fdt, sbuf.st_size);
@@ -470,6 +486,41 @@ static int fit_write_images(struct image_tool_params *params, char *fdt)
 	return 0;
 }
 
+/**
+ * fit_copy_image_data() - copy image data, using cached verity expansion
+ * @fdt:		FIT blob
+ * @node:		image node offset
+ * @buf:		destination buffer
+ * @buf_ptr:	write offset within @buf
+ * @data:		embedded image data (used when no dm-verity expansion exists)
+ * @lenp:		in/out: on entry, length of @data; on exit, bytes written
+ *
+ * When fit_image_process_verity() has run, the expanded image data
+ * (original + hash tree) is cached in memory. Look it up by image name
+ * and copy from the cached buffer rather than the embedded ``data``
+ * property; fall back to @data otherwise.
+ *
+ * Return: 0 on success
+ */
+static int fit_copy_image_data(void *fdt, int node, void *buf,
+			       int buf_ptr, const void *data, int *lenp)
+{
+	const char *image_name = fdt_get_name(fdt, node, NULL);
+	const void *vdata;
+	size_t vsize;
+
+	if (image_name &&
+	    !fit_verity_get_expanded(image_name, &vdata, &vsize)) {
+		memcpy(buf + buf_ptr, vdata, vsize);
+		*lenp = vsize;
+		return 0;
+	}
+
+	memcpy(buf + buf_ptr, data, *lenp);
+
+	return 0;
+}
+
 /**
  * fit_write_configs() - Write out a list of configurations to the FIT
  *
@@ -653,6 +704,8 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	int node;
 	int align_size = 0;
 	int len = 0;
+	int verity_extra = 0;
+	int orig_len;
 
 	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
 	if (fd < 0)
@@ -686,11 +739,34 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		align_size += 4;
 	}
 
+	/*
+	 * When dm-verity is active the external data for an image is
+	 * larger than the embedded data property (original + hash tree).
+	 * Walk images once more and consult the in-memory cache for the
+	 * actual expanded size.
+	 */
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *image_name;
+		const void *vdata;
+		size_t vsize;
+
+		orig_len = 0;
+		if (fdt_subnode_offset(fdt, node, FIT_VERITY_NODENAME) < 0)
+			continue;
+		image_name = fdt_get_name(fdt, node, NULL);
+		if (!image_name ||
+		    fit_verity_get_expanded(image_name, &vdata, &vsize))
+			continue;
+		fdt_getprop(fdt, node, FIT_DATA_PROP, &orig_len);
+		if ((int)vsize > orig_len)
+			verity_extra += (int)vsize - orig_len;
+	}
+
 	/*
 	 * Allocate space to hold the image data we will extract,
 	 * extral space allocate for image alignment to prevent overflow.
 	 */
-	buf = calloc(1, fit_size + align_size);
+	buf = calloc(1, fit_size + align_size + verity_extra);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_munmap;
@@ -721,7 +797,10 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
 		if (!data)
 			continue;
-		memcpy(buf + buf_ptr, data, len);
+
+		ret = fit_copy_image_data(fdt, node, buf, buf_ptr, data, &len);
+		if (ret)
+			goto err_munmap;
 		debug("Extracting data size %x\n", len);
 
 		ret = fdt_delprop(fdt, node, FIT_DATA_PROP);
diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..4bed4c4d580 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -12,8 +12,12 @@
 #include <bootm.h>
 #include <fdt_region.h>
 #include <image.h>
+#include <hexdump.h>
 #include <version.h>
 
+#include <sys/stat.h>
+#include <sys/wait.h>
+
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
 #include <openssl/evp.h>
@@ -626,6 +630,376 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 		image_noffset, cipher_node_offset, data, size, cmdname);
 }
 
+/*
+ * In-memory cache of dm-verity expanded buffers (original data followed
+ * by the Merkle hash tree), keyed by image unit name. Populated by
+ * fit_image_process_verity() and consumed by fit_extract_data() /
+ * fit_copy_image_data() so that the expanded content never leaves the
+ * mkimage process address space.
+ */
+struct fit_verity_blob {
+	char *name;
+	void *data;
+	size_t size;
+	struct fit_verity_blob *next;
+};
+
+static struct fit_verity_blob *fit_verity_blobs;
+
+/* Stash a malloc'd expanded buffer; takes ownership of @data on success. */
+static int fit_verity_stash(const char *name, void *data, size_t size)
+{
+	struct fit_verity_blob *b;
+
+	b = calloc(1, sizeof(*b));
+	if (!b)
+		return -ENOMEM;
+	b->name = strdup(name);
+	if (!b->name) {
+		free(b);
+		return -ENOMEM;
+	}
+	b->data = data;
+	b->size = size;
+	b->next = fit_verity_blobs;
+	fit_verity_blobs = b;
+
+	return 0;
+}
+
+int fit_verity_get_expanded(const char *name, const void **data, size_t *size)
+{
+	struct fit_verity_blob *b;
+
+	for (b = fit_verity_blobs; b; b = b->next) {
+		if (!strcmp(b->name, name)) {
+			*data = b->data;
+			*size = b->size;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * fit_image_process_verity() - Run veritysetup and fill dm-verity properties
+ *
+ * Extracts the embedded image data to a temporary file, runs
+ * ``veritysetup format`` to generate the Merkle hash tree (appended to the
+ * same file), parses Root hash / Salt from its stdout, and writes the
+ * computed properties (digest, salt, num-data-blocks, hash-start-block)
+ * back into the FIT dm-verity subnode.
+ *
+ * The expanded data (original data + hash tree) is read back into a
+ * malloc'd buffer and stashed in an in-memory cache keyed by @image_name
+ * via fit_verity_stash(). The same buffer is returned through
+ * @expanded_data / @expanded_size so that hash and signature subnodes
+ * can be computed over the complete image; the returned pointer is a
+ * *view* of the cached buffer and must not be freed by the caller.
+ * fit_extract_data() later retrieves the same buffer via
+ * fit_verity_get_expanded() to write the external data section.
+ *
+ * @fit:		FIT blob (read-write)
+ * @image_name:		image unit name (for diagnostics)
+ * @verity_noffset:	dm-verity subnode offset
+ * @data:		embedded image data
+ * @data_size:		size of @data in bytes
+ * @expanded_data:	output -- malloc'd buffer with expanded content
+ * @expanded_size:	output -- size of @expanded_data
+ * Return: 0 on success, -ve on error (-ENOSPC when the FIT blob is full)
+ */
+static int fit_image_process_verity(void *fit, const char *image_name,
+				    int verity_noffset,
+				    const void *data, size_t data_size,
+				    void **expanded_data, size_t *expanded_size)
+{
+	const char *algo_prop;
+	char algo[64];
+	const fdt32_t *val;
+	unsigned int data_block_size, hash_block_size;
+	uint32_t num_data_blocks;
+	size_t hash_offset;
+	uint32_t hash_start_block;
+	char tmpfile[] = "/tmp/mkimage-verity-XXXXXX";
+	char dbs_arg[32], hbs_arg[32], algo_arg[80], hoff_arg[40];
+	int pipefd[2];
+	pid_t pid;
+	FILE *fp;
+	char line[256];
+	char *colon, *value, *end;
+	char root_hash_hex[256] = {0};
+	char salt_hex[256] = {0};
+	uint8_t digest_bin[FIT_MAX_HASH_LEN];
+	uint8_t salt_bin[FIT_MAX_HASH_LEN];
+	int digest_len = 0, salt_len = 0;
+	void *expanded = NULL;
+	struct stat st;
+	int fd, ret;
+
+	*expanded_data = NULL;
+	*expanded_size = 0;
+
+	algo_prop = fdt_getprop(fit, verity_noffset, FIT_VERITY_ALGO_PROP,
+				NULL);
+	if (!algo_prop) {
+		fprintf(stderr,
+			"Missing '%s' in dm-verity node of '%s'\n",
+			FIT_VERITY_ALGO_PROP, image_name);
+		return -EINVAL;
+	}
+	/* Local copy -- the FDT pointer goes stale after fdt_setprop(). */
+	snprintf(algo, sizeof(algo), "%s", algo_prop);
+
+	val = fdt_getprop(fit, verity_noffset, FIT_VERITY_DBS_PROP, NULL);
+	if (!val) {
+		fprintf(stderr,
+			"Missing '%s' in dm-verity node of '%s'\n",
+			FIT_VERITY_DBS_PROP, image_name);
+		return -EINVAL;
+	}
+	data_block_size = fdt32_to_cpu(*val);
+
+	val = fdt_getprop(fit, verity_noffset, FIT_VERITY_HBS_PROP, NULL);
+	if (!val) {
+		fprintf(stderr,
+			"Missing '%s' in dm-verity node of '%s'\n",
+			FIT_VERITY_HBS_PROP, image_name);
+		return -EINVAL;
+	}
+	hash_block_size = fdt32_to_cpu(*val);
+
+	if (data_block_size < 512 || (data_block_size & (data_block_size - 1)) ||
+	    hash_block_size < 512 || (hash_block_size & (hash_block_size - 1))) {
+		fprintf(stderr,
+			"Block sizes must be >= 512 and a power of two in dm-verity node of '%s'\n",
+			image_name);
+		return -EINVAL;
+	}
+
+	if (data_size % data_block_size) {
+		fprintf(stderr,
+			"Image '%s' size %zu not a multiple of data-block-size %d\n",
+			image_name, data_size, data_block_size);
+		return -EINVAL;
+	}
+
+	if (data_size / data_block_size > UINT32_MAX ||
+	    data_size / hash_block_size > UINT32_MAX) {
+		fprintf(stderr,
+			"Image '%s' too large for dm-verity (> 2^32 blocks)\n",
+			image_name);
+		return -EINVAL;
+	}
+	num_data_blocks = data_size / data_block_size;
+	hash_offset = data_size;
+
+	fd = mkstemp(tmpfile);
+	if (fd < 0) {
+		fprintf(stderr, "Can't create temp file: %s\n",
+			strerror(errno));
+		return -EIO;
+	}
+
+	if (write(fd, data, data_size) != (ssize_t)data_size) {
+		fprintf(stderr, "Can't write temp file: %s\n",
+			strerror(errno));
+		ret = -EIO;
+		goto err_unlink;
+	}
+	close(fd);
+	fd = -1;
+
+	/*
+	 * Invoke veritysetup via fork/execvp -- no shell, so each argument
+	 * goes verbatim to the binary and the algo string cannot inject
+	 * additional commands no matter how crafted the .its is.
+	 */
+	snprintf(algo_arg, sizeof(algo_arg), "--hash=%s", algo);
+	snprintf(dbs_arg, sizeof(dbs_arg), "--data-block-size=%u",
+		 data_block_size);
+	snprintf(hbs_arg, sizeof(hbs_arg), "--hash-block-size=%u",
+		 hash_block_size);
+	snprintf(hoff_arg, sizeof(hoff_arg), "--hash-offset=%zu", hash_offset);
+
+	if (pipe(pipefd) < 0) {
+		fprintf(stderr, "Can't create pipe: %s\n", strerror(errno));
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "Can't fork: %s\n", strerror(errno));
+		close(pipefd[0]);
+		close(pipefd[1]);
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	if (pid == 0) {
+		/* child: redirect stdout+stderr to pipe write-end, then exec */
+		char *argv[] = {
+			"veritysetup", "format", tmpfile, tmpfile,
+			"--no-superblock", algo_arg, dbs_arg, hbs_arg,
+			hoff_arg, NULL,
+		};
+
+		close(pipefd[0]);
+		if (dup2(pipefd[1], STDOUT_FILENO) < 0 ||
+		    dup2(pipefd[1], STDERR_FILENO) < 0)
+			_exit(127);
+		close(pipefd[1]);
+		execvp(argv[0], argv);
+		fprintf(stderr, "Can't exec veritysetup: %s\n",
+			strerror(errno));
+		_exit(127);
+	}
+
+	/* parent: parse key: value lines from veritysetup stdout */
+	close(pipefd[1]);
+	fp = fdopen(pipefd[0], "r");
+	if (!fp) {
+		fprintf(stderr, "Can't fdopen veritysetup pipe: %s\n",
+			strerror(errno));
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		colon = strchr(line, ':');
+		if (!colon)
+			continue;
+		value = colon + 1;
+		while (*value == ' ' || *value == '\t')
+			value++;
+		end = value + strlen(value) - 1;
+		while (end > value && (*end == '\n' || *end == '\r' ||
+				       *end == ' '))
+			*end-- = '\0';
+
+		if (!strncmp(line, "Root hash:", 10))
+			snprintf(root_hash_hex, sizeof(root_hash_hex),
+				 "%s", value);
+		else if (!strncmp(line, "Salt:", 5))
+			snprintf(salt_hex, sizeof(salt_hex), "%s", value);
+	}
+	fclose(fp);
+
+	if (waitpid(pid, &ret, 0) < 0 || !WIFEXITED(ret) ||
+	    WEXITSTATUS(ret) != 0) {
+		fprintf(stderr, "veritysetup failed for '%s'\n", image_name);
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	if (!root_hash_hex[0] || !salt_hex[0]) {
+		fprintf(stderr, "Failed to parse veritysetup output for '%s'\n",
+			image_name);
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	digest_len = strlen(root_hash_hex) / 2;
+	salt_len   = strlen(salt_hex) / 2;
+
+	if (digest_len > (int)sizeof(digest_bin) ||
+	    salt_len > (int)sizeof(salt_bin)) {
+		fprintf(stderr, "Hash/salt too long for '%s'\n", image_name);
+		ret = -EINVAL;
+		goto err_unlink;
+	}
+
+	if (hex2bin(digest_bin, root_hash_hex, digest_len) ||
+	    hex2bin(salt_bin, salt_hex, salt_len)) {
+		fprintf(stderr, "Invalid hex in veritysetup output for '%s'\n",
+			image_name);
+		ret = -EINVAL;
+		goto err_unlink;
+	}
+
+	if (stat(tmpfile, &st)) {
+		fprintf(stderr, "Can't stat temp file: %s\n",
+			strerror(errno));
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	expanded = malloc(st.st_size);
+	if (!expanded) {
+		ret = -ENOMEM;
+		goto err_unlink;
+	}
+
+	fd = open(tmpfile, O_RDONLY);
+	if (fd < 0 || read(fd, expanded, st.st_size) != st.st_size) {
+		fprintf(stderr, "Can't read back temp file: %s\n",
+			strerror(errno));
+		ret = -EIO;
+		goto err_free;
+	}
+	close(fd);
+	fd = -1;
+
+	/* Temp file is no longer needed -- expanded buffer lives in memory. */
+	unlink(tmpfile);
+
+	/* hash tree starts immediately after data (no superblock) */
+	hash_start_block = hash_offset / hash_block_size;
+
+	ret = fdt_setprop(fit, verity_noffset, FIT_VERITY_DIGEST_PROP,
+			  digest_bin, digest_len);
+	if (ret) {
+		ret = (ret == -FDT_ERR_NOSPACE) ? -ENOSPC : -EIO;
+		goto err_free;
+	}
+
+	ret = fdt_setprop(fit, verity_noffset, FIT_VERITY_SALT_PROP,
+			  salt_bin, salt_len);
+	if (ret) {
+		ret = (ret == -FDT_ERR_NOSPACE) ? -ENOSPC : -EIO;
+		goto err_free;
+	}
+
+	ret = fdt_setprop_u32(fit, verity_noffset, FIT_VERITY_NBLK_PROP,
+			      num_data_blocks);
+	if (ret) {
+		ret = (ret == -FDT_ERR_NOSPACE) ? -ENOSPC : -EIO;
+		goto err_free;
+	}
+
+	ret = fdt_setprop_u32(fit, verity_noffset, FIT_VERITY_HBLK_PROP,
+			      hash_start_block);
+	if (ret) {
+		ret = (ret == -FDT_ERR_NOSPACE) ? -ENOSPC : -EIO;
+		goto err_free;
+	}
+
+	/*
+	 * Stash the expanded buffer in the in-process cache; fit_extract_data()
+	 * looks it up via fit_verity_get_expanded() to populate the external
+	 * data section. On success the cache takes ownership of @expanded.
+	 */
+	ret = fit_verity_stash(image_name, expanded, st.st_size);
+	if (ret)
+		goto err_free;
+
+	*expanded_data = expanded;
+	*expanded_size = st.st_size;
+
+	return 0;
+
+err_free:
+	free(expanded);
+err_unlink:
+	if (fd >= 0)
+		close(fd);
+	unlink(tmpfile);
+	return ret;
+}
+
 /**
  * fit_image_add_verification_data() - calculate/set verig. data for image node
  *
@@ -652,6 +1026,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
  *
  * For signature details, please see doc/usage/fit/signature.rst
  *
+ * For dm-verity details, please see doc/usage/fit/dm-verity.rst
+ *
  * @keydir	Directory containing *.key and *.crt files (or NULL)
  * @keydest	FDT Blob to write public keys into (NULL if none)
  * @fit:	Pointer to the FIT format image header
@@ -667,9 +1043,16 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 		const char *cmdname, const char* algo_name)
 {
 	const char *image_name;
+	const char *node_name;
 	const void *data;
 	size_t size;
+	/*
+	 * View pointer into the dm-verity cache (owned by image-host.c).
+	 * Do not free; the cache lives until mkimage exits.
+	 */
+	void *verity_data = NULL;
 	int noffset;
+	int ret;
 
 	/* Get image data and data length */
 	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
@@ -679,13 +1062,38 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 
 	image_name = fit_get_name(fit, image_noffset, NULL);
 
-	/* Process all hash subnodes of the component image node */
+	/*
+	 * Pass 1 -- dm-verity: run veritysetup to produce the Merkle
+	 * hash tree and fill in computed metadata. The expanded
+	 * content (original data + hash tree) is returned in
+	 * verity_data so that pass 2 hashes the complete image.
+	 */
 	for (noffset = fdt_first_subnode(fit, image_noffset);
 	     noffset >= 0;
 	     noffset = fdt_next_subnode(fit, noffset)) {
-		const char *node_name;
-		int ret = 0;
+		if (!strcmp(fit_get_name(fit, noffset, NULL),
+			    FIT_VERITY_NODENAME)) {
+			ret = fit_image_process_verity(fit, image_name,
+						       noffset,
+						       data, size,
+						       &verity_data,
+						       &size);
+			if (ret)
+				return ret;
+			if (verity_data)
+				data = verity_data;
+			break;
+		}
+	}
 
+	/*
+	 * Pass 2 -- hashes and signatures: compute over the (possibly
+	 * expanded) image data.
+	 */
+	for (noffset = fdt_first_subnode(fit, image_noffset);
+	     noffset >= 0;
+	     noffset = fdt_next_subnode(fit, noffset)) {
+		ret = 0;
 		/*
 		 * Check subnode name, must be equal to "hash" or "signature".
 		 * Multiple hash nodes require unique unit node
-- 
2.54.0
