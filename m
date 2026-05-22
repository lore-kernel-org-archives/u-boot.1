Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACEDCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED6E846FD;
	Fri, 22 May 2026 15:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="VhzaJP/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500DD846A7; Fri, 22 May 2026 14:30:51 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E061A841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-95f9d6a3a04so5099304241.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453047; x=1780057847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5U+kZicOrkprFU5EVwxfGw8Uac2Zl4ibePWhG20sFJQ=;
 b=VhzaJP/KVttqM4kT2XsHwwa81sYPzhV/1P7WJxaQgUgBWCFPusap3sXktPgr19us3K
 wE/hmA9rewZRyzFObcE8dSk0mUX+xegJYaIOfpRcPdpZsfEhU9QYvPG/aTPTvi7ymwM/
 HX+RNucNVGanmBVcmIgSBPhdAVUgT/0GK/RVYBlwp+eLERcmg8EYZ22KPMZ2JMLI9dxl
 fXgw00EgRFy1v+b8QACS9P5gWPBGJb/rN5ItivGUsNyreXch+tOP27cNKfDOsVY9iVf2
 clSZnRVBDNPE9UASwaPNIub/i1m6NkEgKVFj+fRtvWOar4V0pMmYvgjkxYmP7yALphtn
 zrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453047; x=1780057847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U+kZicOrkprFU5EVwxfGw8Uac2Zl4ibePWhG20sFJQ=;
 b=mTBW1SWUbxtC2mIKYlOvoUJCcIeBMGl+hnUGJFtk4J0DhuFoPpciAjQA8KxxfWmqDp
 qHETffPCB7v2YncdtsmhbhirlG99JbjqZiXs6H2Q+w6swBE1x1DnzoHY/XQZtfkxYIu5
 93WCx0ZUA35jGUmhw91nC2t0qXJF/A+lJr4PyVHfhfMuZCdBG+1XVZ71BNMDzUMr1Wsy
 1qDmncgb9cCvdmyj+rGpDa140jFQBtwCLcwIMLWsGL8tXBkf0D9ic2efqfIjVZ5RutO1
 Gz7baYSmOAeoTOrEqQ3MwjP3a3zqKGW7jndru8l4p1R1xrFpFs3PskRxf3XbKuDwbOKt
 lvtg==
X-Gm-Message-State: AOJu0YzhRsa9BfNPiXqneNYVdJD5NBiagSmAMPB1C2YvpcR8UAh/rMAt
 5+d77OgF3MuIKx/Zj+2KLKKwMGLaijYvh9o3OAEmFV0SoG1bPYBzho6OKQfsYOP83zi7DDgeKPI
 ZhrqM
X-Gm-Gg: Acq92OHQIN2CxqIUdsIaDvTV88A9tS6Zx38OCU+XeR1fcXN2xzOFuXilR6W39VaFwXS
 87w2InGQGTnsZXPuC2qpEp/lApWGnLDxlBjs9t6j8UByYYJVksku/LW7Yt8eI2SSsrpkHZMQUHu
 2/TNokEoXl3a7Q10pJN551oNlseeZ8O1Uxbw0sBCF6rFV38Ntyx24Z5D6tKRtaezfcnY7MDqBye
 zeZ2cTu7Fj13RatyD70+RG11rkwH2j5kMy3foYclicJqsX0S18k+qJOlfAxkd662dT75VEwOuZm
 tj75CiLjUDfo8xHyACESPQWPAk5PIm0hvSVvYC1yQe9nGUvngG3dHSvGDANOFdrvp9gWNelmxYp
 TiB/Z+DtyxjYNumUA6M663S3l5m1EvMRy1hiKb0+hRBJ2JvirY57sjgb4KQHsSAYyVWafq/0pFM
 TWmN5E08zw5dR9CaXVNKRQiZcdhoSin/T618W8o52qAH3jo74lydSOlHE0
X-Received: by 2002:a05:6102:b07:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-67c7cee1428mr1600633137.10.1779453047528; 
 Fri, 22 May 2026 05:30:47 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm4016553f8f.36.2026.05.22.05.30.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 05:30:46 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH] fdt: Check return value and len of fdt_get_name() calls
Date: Fri, 22 May 2026 13:30:20 +0100
Message-ID: <20260522123024.6292-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

fdt_get_name() in scripts/dtc/libfdt/fdt_ro.c can return a null
pointer. This happens when the fdt_ro_probe_() or
fdt_check_node_offset_() check fails, as well as when the
'!can_assume(LATEST) && fdt_version(fdt) < 0x10' condition is true
and the FDT node name doesn't contain the '/' character:

	const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
	{
		const struct fdt_node_header *nh = fdt_offset_ptr_(fdt, nodeoffset);
		const char *nameptr;
		int err;

		if (((err = fdt_ro_probe_(fdt)) < 0)
			|| ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0))
				goto fail;

		nameptr = nh->name;

		if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
			/*
			* For old FDT versions, match the naming conventions of V16:
			* give only the leaf name (after all /). The actual tree
			* contents are loosely checked.
			*/
			const char *leaf;
			leaf = strrchr(nameptr, '/');
			if (leaf == NULL) {
				err = -FDT_ERR_BADSTRUCTURE;
				goto fail;
			}
			nameptr = leaf+1;
		}

		if (len)
			*len = strlen(nameptr);

		return nameptr;

	fail:
		if (len)
			*len = err;
		return NULL;
	}

The fdt_get_name() function is used in fdt_find_regions() in
boot/fdt_region.c:

	int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
				char * const exc_prop[], int exc_prop_count,
				struct fdt_region region[], int max_regions,
				char *path, int path_len, int add_string_tab)
	{
		int stack[FDT_MAX_DEPTH] = { 0 };
		char *end;
		int nextoffset = 0;
		uint32_t tag;
		int count = 0;
		int start = -1;
		int depth = -1;
		int want = 0;
		int base = fdt_off_dt_struct(fdt);
		bool expect_end = false;

		end = path;
		*end = '\0';
		do {
			const struct fdt_property *prop;
			const char *name;
			const char *str;
			int include = 0;
			int stop_at = 0;
			int offset;
			int len;

			offset = nextoffset;
			tag = fdt_next_tag(fdt, offset, &nextoffset);
			stop_at = nextoffset;

			/* If we see two root nodes, something is wrong */
			if (expect_end && tag != FDT_END)
				return -FDT_ERR_BADLAYOUT;

			switch (tag) {
			case FDT_PROP:
				include = want >= 2;
				stop_at = offset;
				prop = fdt_get_property_by_offset(fdt, offset, NULL);
				str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
				if (!str)
					return -FDT_ERR_BADSTRUCTURE;
				if (str_in_list(str, exc_prop, exc_prop_count))
					include = 0;
				break;

			case FDT_NOP:
				include = want >= 2;
				stop_at = offset;
				break;

			case FDT_BEGIN_NODE:
				depth++;
				if (depth == FDT_MAX_DEPTH)
					return -FDT_ERR_BADSTRUCTURE;
				name = fdt_get_name(fdt, offset, &len);

				/* The root node must have an empty name */
				if (!depth && *name)
					return -FDT_ERR_BADLAYOUT;
				if (end - path + 2 + len >= path_len)
					return -FDT_ERR_NOSPACE;
				if (end != path + 1)
					*end++ = '/';
				strcpy(end, name);
				end += len;
				stack[depth] = want;
				if (want == 1)
					stop_at = offset;
				if (str_in_list(path, inc, inc_count))
					want = 2;
				else if (want)
					want--;
				else
					stop_at = offset;
				include = want;
				break;
			...

There is no check that the value returned by fdt_get_name() is not
null, which leads to a null pointer dereference (at *name and
strcpy(end, name)) and a potential stack overflow of the 'end'
buffer. However, if the strcpy call succeeds, the subsequent
'end += len' decreases the 'end' pointer, since 'len' is set to the
negative error code returned by fdt_get_name(). As a result, the next
iteration of the loop writes data to a stack location before the
start of the 'path' buffer, which can be used to overwrite the
return address of fdt_find_regions() and achieve code execution in
the context of the bootloader. This attack is possible when the page
at address 0x0 is mapped, which is common for embedded devices, so
the strcpy() call doesn't fail.

The same lack of validation exists in fdt_next_region() in
boot/fdt_region.c, fdt_check_full() in scripts/dtc/libfdt/fdt_ro.c,
and display_fdt_by_regions() in tools/fdtgrep.c.

Fix: Validate both the returned pointer and the length before use.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
 boot/fdt_region.c           | 4 ++++
 scripts/dtc/libfdt/fdt_ro.c | 2 ++
 tools/fdtgrep.c             | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..95706b872f4 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -86,6 +86,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			if (depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name || len < 0)
+				return -FDT_ERR_BADSTRUCTURE;
 
 			/* The root node must have an empty name */
 			if (!depth && *name)
@@ -553,6 +555,8 @@ int fdt_next_region(const void *fdt,
 			if (p.depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name || len < 0)
+				return -FDT_ERR_BADSTRUCTURE;
 			if (p.end - path + 2 + len >= path_len)
 				return -FDT_ERR_NOSPACE;
 
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 3e7e26b4398..82f90eb46f6 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -940,6 +940,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
 				int len;
 
 				name = fdt_get_name(fdt, offset, &len);
+				if (!name || len < 0)
+					return -FDT_ERR_BADSTRUCTURE;
 				if (*name || len)
 					return -FDT_ERR_BADLAYOUT;
 			}
diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b4c041070f5..ab8ee939e97 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -355,6 +355,8 @@ static int display_fdt_by_regions(struct display_info *disp, const void *blob,
 
 		case FDT_BEGIN_NODE:
 			name = fdt_get_name(blob, offset, &len);
+			if (!name || len < 0)
+				return -FDT_ERR_BADSTRUCTURE;
 			fprintf(f, "%*s%s {", depth++ * shift, "",
 				*name ? name : "/");
 			break;
-- 
2.53.0

