Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A8CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 02:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1808F8469F;
	Wed, 13 May 2026 04:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727E083EEF; Wed, 13 May 2026 04:09:41 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8018469F
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wMz2L-000000008IE-0dsY; Wed, 13 May 2026 02:09:25 +0000
Date: Wed, 13 May 2026 03:09:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v4 4/8] tools: mkimage: add dm-verity Merkle-tree generation
Message-ID: <ded45a7963eb0c355a16fd9c64a1b583070b406d.1778637233.git.daniel@makrotopia.org>
References: <cover.1778637233.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778637233.git.daniel@makrotopia.org>
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
num-data-blocks, and hash-start-block.  Because --no-superblock is
used, hash-start-block equals num-data-blocks with no off-by-one.

The image data property is replaced with the expanded content (original
data followed directly by the hash tree) so that subsequent hash and
signature subnodes operate on the complete image.

fit_image_add_verification_data() is restructured into two passes:
dm-verity first (may grow data), then hashes and signatures.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: no changes
v3: extend the block-count overflow check to also cover hash_start_block
    (matters when hash-block-size < data-block-size)
v2:
 * use existing hex2bin() instead of open-coding it
 * fix stale comment still mentioning the verity superblock
 * add power-of-two check for data-block-size and hash-block-size
 * don't ignore return value of fdt_delprop()

 tools/fit_image.c  | 116 ++++++++++++++-
 tools/image-host.c | 349 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 455 insertions(+), 10 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 1dbc14c63e4..95942336820 100644
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
+	 * signature*, and dm-verity.  Since the interesting nodes are
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
@@ -470,6 +486,67 @@ static int fit_write_images(struct image_tool_params *params, char *fdt)
 	return 0;
 }
 
+/**
+ * fit_copy_image_data() - copy image data, using verity temp file if present
+ * @fdt:		FIT blob
+ * @node:		image node offset
+ * @buf:		destination buffer
+ * @buf_ptr:	write offset within @buf
+ * @data:		embedded image data (used when no verity temp file exists)
+ * @lenp:		in/out: on entry, length of @data; on exit, bytes written
+ *
+ * When fit_image_process_verity() has run, a temp-file path is stored in
+ * the dm-verity subnode.  Read that file (original data + hash tree) into
+ * @buf instead of copying the embedded data property.
+ *
+ * Return: 0 on success, -EIO on error
+ */
+static int fit_copy_image_data(void *fdt, int node, void *buf,
+			       int buf_ptr, const void *data, int *lenp)
+{
+	const char *vfile;
+	char vfile_buf[256];
+	struct stat vst;
+	int vfd, ret;
+	int vn;
+
+	vn = fdt_subnode_offset(fdt, node, FIT_VERITY_NODENAME);
+	vfile = NULL;
+	if (vn >= 0)
+		vfile = fdt_getprop(fdt, vn, "verity-data-file", NULL);
+	if (!vfile) {
+		memcpy(buf + buf_ptr, data, *lenp);
+		return 0;
+	}
+
+	/* Copy path -- FDT shifts after delprop */
+	snprintf(vfile_buf, sizeof(vfile_buf), "%s", vfile);
+	ret = fdt_delprop(fdt, vn, "verity-data-file");
+	if (ret) {
+		fprintf(stderr, "Can't remove verity-data-file property: %s\n",
+			fdt_strerror(ret));
+		return -EPERM;
+	}
+
+	if (stat(vfile_buf, &vst)) {
+		fprintf(stderr, "Can't stat verity data: %s\n",
+			strerror(errno));
+		return -EIO;
+	}
+	vfd = open(vfile_buf, O_RDONLY);
+	if (vfd < 0 || read(vfd, buf + buf_ptr, vst.st_size) != vst.st_size) {
+		fprintf(stderr, "Can't read verity data: %s\n",
+			strerror(errno));
+		if (vfd >= 0)
+			close(vfd);
+		return -EIO;
+	}
+	close(vfd);
+	*lenp = vst.st_size;
+	unlink(vfile_buf);
+	return 0;
+}
+
 /**
  * fit_write_configs() - Write out a list of configurations to the FIT
  *
@@ -653,6 +730,11 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	int node;
 	int align_size = 0;
 	int len = 0;
+	int verity_extra = 0;
+	int orig_len;
+	int vn;
+	const char *vf;
+	struct stat vst;
 
 	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
 	if (fd < 0)
@@ -686,11 +768,30 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		align_size += 4;
 	}
 
+	/*
+	 * When dm-verity is active the external data for an image is
+	 * larger than the embedded data property (original + hash tree).
+	 * Walk images once more to account for the difference.
+	 */
+	fdt_for_each_subnode(node, fdt, images) {
+		vn = fdt_subnode_offset(fdt, node, FIT_VERITY_NODENAME);
+		orig_len = 0;
+
+		if (vn < 0)
+			continue;
+		vf = fdt_getprop(fdt, vn, "verity-data-file", NULL);
+		if (!vf)
+			continue;
+		fdt_getprop(fdt, node, FIT_DATA_PROP, &orig_len);
+		if (!stat(vf, &vst) && vst.st_size > orig_len)
+			verity_extra += vst.st_size - orig_len;
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
@@ -721,7 +822,10 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
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
index 8b550af0dc1..b35c2a2e528 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -12,8 +12,11 @@
 #include <bootm.h>
 #include <fdt_region.h>
 #include <image.h>
+#include <hexdump.h>
 #include <version.h>
 
+#include <sys/stat.h>
+
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
 #include <openssl/evp.h>
@@ -626,6 +629,310 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 		image_noffset, cipher_node_offset, data, size, cmdname);
 }
 
+/**
+ * fit_image_process_verity() - Run veritysetup and fill dm-verity properties
+ *
+ * Extracts the embedded image data to a temporary file, runs
+ * ``veritysetup format`` to generate the Merkle hash tree (appended to the
+ * same file), parses Root hash / Salt from its stdout, and writes the
+ * computed properties (digest, salt, num-data-blocks, hash-start-block)
+ * back into the FIT dm-verity subnode.
+ *
+ * The expanded data (original data + hash tree) is returned
+ * through @expanded_data / @expanded_size so that hash and signature
+ * subnodes can be computed over the complete image.  The FIT ``data``
+ * property is intentionally NOT replaced -- the expanded content is kept in
+ * a temporary file whose path is stored in the ``verity-data-file``
+ * property; ``fit_extract_data()`` picks it up later.
+ *
+ * @fit:		FIT blob (read-write)
+ * @image_name:		image unit name (for diagnostics)
+ * @image_noffset:	image node offset (parent of dm-verity)
+ * @verity_noffset:	dm-verity subnode offset
+ * @data:		embedded image data
+ * @data_size:		size of @data in bytes
+ * @expanded_data:	output -- malloc'd buffer with expanded content
+ * @expanded_size:	output -- size of @expanded_data
+ * Return: 0 on success, -ve on error (-ENOSPC when the FIT blob is full)
+ */
+static int fit_image_process_verity(void *fit, const char *image_name,
+				    int image_noffset, int verity_noffset,
+				    const void *data, size_t data_size,
+				    void **expanded_data, size_t *expanded_size)
+{
+	const char *algo_prop;
+	char algo[64];
+	const fdt32_t *val;
+	int data_block_size, hash_block_size;
+	uint32_t num_data_blocks;
+	size_t hash_offset;
+	uint32_t hash_start_block;
+	char tmpfile[] = "/tmp/mkimage-verity-XXXXXX";
+	char cmd[512];
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
+	/*
+	 * Validate algo against a known-good list before interpolating it
+	 * into the shell command passed to popen().  An unchecked value
+	 * could allow command injection when mkimage processes a crafted
+	 * .its file (e.g. algo = "sha256; rm -rf /").
+	 *
+	 * List derived from the veritysetup(8) man page (cryptsetup 2.x).
+	 */
+	{
+		static const char * const valid_algos[] = {
+			"sha1", "sha224", "sha256", "sha384", "sha512",
+			"ripemd160", "whirlpool",
+			"sha3-224", "sha3-256", "sha3-384", "sha3-512",
+			"stribog256", "stribog512",
+			"sm3",
+			/* blake2b/blake2s with explicit digest sizes */
+			"blake2b-160", "blake2b-256", "blake2b-384",
+			"blake2b-512",
+			"blake2s-128", "blake2s-160", "blake2s-224",
+			"blake2s-256",
+			NULL
+		};
+		int i;
+
+		for (i = 0; valid_algos[i]; i++)
+			if (!strcmp(algo, valid_algos[i]))
+				break;
+		if (!valid_algos[i]) {
+			fprintf(stderr,
+				"Unsupported dm-verity hash algorithm '%s' in '%s'\n",
+				algo, image_name);
+			return -EINVAL;
+		}
+	}
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
+	snprintf(cmd, sizeof(cmd),
+		 "veritysetup format \"%s\" \"%s\" --no-superblock --hash=%s --data-block-size=%d --hash-block-size=%d --hash-offset=%zu 2>&1",
+		 tmpfile, tmpfile, algo, data_block_size, hash_block_size,
+		 hash_offset);
+
+	fp = popen(cmd, "r");
+	if (!fp) {
+		fprintf(stderr, "Can't run veritysetup: %s\n",
+			strerror(errno));
+		ret = -EIO;
+		goto err_unlink;
+	}
+
+	/* parse key: value lines from veritysetup stdout */
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
+
+	ret = pclose(fp);
+	if (ret) {
+		fprintf(stderr, "veritysetup failed (exit %d) for '%s'\n",
+			WEXITSTATUS(ret), image_name);
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
+	 * Stash the temp-file path so that fit_extract_data() can use
+	 * the expanded content for the external-data section.
+	 */
+	ret = fdt_setprop_string(fit, verity_noffset,
+				 "verity-data-file", tmpfile);
+	if (ret) {
+		ret = (ret == -FDT_ERR_NOSPACE) ? -ENOSPC : -EIO;
+		goto err_free;
+	}
+
+	*expanded_data = expanded;
+	*expanded_size = st.st_size;
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
@@ -652,6 +959,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
  *
  * For signature details, please see doc/usage/fit/signature.rst
  *
+ * For dm-verity details, please see doc/usage/fit/dm-verity.rst
+ *
  * @keydir	Directory containing *.key and *.crt files (or NULL)
  * @keydest	FDT Blob to write public keys into (NULL if none)
  * @fit:	Pointer to the FIT format image header
@@ -667,9 +976,12 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 		const char *cmdname, const char* algo_name)
 {
 	const char *image_name;
+	const char *node_name;
 	const void *data;
 	size_t size;
+	void *verity_data = NULL;
 	int noffset;
+	int ret;
 
 	/* Get image data and data length */
 	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
@@ -679,13 +991,39 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 
 	image_name = fit_get_name(fit, image_noffset, NULL);
 
-	/* Process all hash subnodes of the component image node */
+	/*
+	 * Pass 1 -- dm-verity: run veritysetup to produce the Merkle
+	 * hash tree and fill in computed metadata.  The expanded
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
+						       image_noffset,
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
@@ -704,10 +1042,13 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 				comment, require_keys, engine_id, cmdname,
 				algo_name);
 		}
-		if (ret < 0)
+		if (ret < 0) {
+			free(verity_data);
 			return ret;
+		}
 	}
 
+	free(verity_data);
 	return 0;
 }
 
-- 
2.54.0
