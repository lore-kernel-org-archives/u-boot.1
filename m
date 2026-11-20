Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81371606A32C
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bivY7rWU;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nEnvxS2v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BC3A817AA;
	Fri, 20 Nov 2026 13:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gLlxtM4P78Ty; Fri, 20 Nov 2026 13:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F8108176D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180909;
	b=BWTIhvQ6uMgkFEnn7DHCkUHURh70ImWJbSfMgVWLZ4v9xYMOkYBj9fxZnlxdOuvsV7/0
	 5pYlKkyDPmOgt8Blzuux0g4U09G6A5vRQsQRtxhV9BLMUgH87LDojsnJvFUMWjX36KwqX
	 LN1tGarJaSpQhr5782s0auZcF0zquO75eqa4ID8FrT1MXhF1Iy4+LdiNVe+dm0oWjnqzR
	 GwsvqEWvQ6vD9oguViItjRsFt8oGkvT+5s6EhNIiudiKCPxHP7SaAq1Ct9cflkxq2PFxx
	 tzd05D9RKRgucn2pyaPjT8Wkrr7UfzIiGN3ugTfPcHR6tSGfvoP8KOHiuQG/yGROWsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MsIlpqtTPK690TuRUbPpLl4/YKehdxLtCM78xwPeKtQ=;
	b=lmQS880I4NDegslcG2lDXHgL8M+1QG7HzuEtz6VDa2I0X1N/bf90gbWjSuv+ORwE/QEw
	 V6sShwXR9WopMIhXZC9aApqQUEDEw8c1mHOVcZxx4fR6FdxKuxulM9hANcpWhnjGHE5v/
	 l8lcB1p2T386sIhDC6a7lRv0ksCcx6bsFJ8dS77NR9WgcbQPhXvF6xajmI55oT59u+KbR
	 1KBv8YZvxngdrgC/dFiQbWY2qd3cKyteF/OoeENIe6BYfWCHde85pcQ+KKE5qJ9NzD55l
	 atb//RBf/66G4YrcOFaAorrqxxNYTm37YN4ZmPqvgzbpK8YwvBLvG13jwCs3kxsCzfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180909;
	bh=MsIlpqtTPK690TuRUbPpLl4/YKehdxLtCM78xwPeKtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bivY7rWUywHuKHDO/uIEr0FFc9YrnxmvuWwq1W5xBOZqthyF94rSr74h8ShFGbRLs
	 9Pu9LuJEsqStUwXd5ZDRd8LkXnpDRBaPsBlCFtRvHUPBfAVm5xAnWpfjVcllBbS8AP
	 uIUPlmvGvvjrvLz9+H9wftfasHGIZHiy9td3H5RNQiJ1Ao60TzA7pyNU0UqVDHGVLD
	 SBlgJptPIc69A/Y9GiTrw+8zC97NKqzCZM59WYJbwuElpRUUiA58NaeAG6E9blmbga
	 crJTQarCRRwy9OdGqi6GIh3DOK8rF7ALb1UXLNOefE30t+6/rP1sSTFJeUEY6BwERz
	 /fU5Dr2jgLR6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F8108176D;
	Fri, 20 Nov 2026 13:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AC3515D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5145660755
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INUtqMTD53mx for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 13:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB3C36069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=nEnvxS2v
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB3C36069A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:42 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D00393FCF8
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795180300;
 bh=MsIlpqtTPK690TuRUbPpLl4/YKehdxLtCM78xwPeKtQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nEnvxS2v8Xwbvp4BYNXOvaeL/DU1Hw4h4Jz0lWO5JZ1TBdc0EGH9GuHVN1vCQgM/K
 ZyEopw1WpuwMS1ybKyF0kEAxhSaW5NCGe5VVZiOK0Lo0XkgYWyV4ucJUkJ0/2lbDLT
 Vn574p5iAGma1ghyM4CPXyM6GfUzgVePS/76Qjtbj3iuoRjUsyVlVkbIfd9ohOCuVl
 hGqEgXHyGUuKBLCJ2N/j/pP3HVWh30/UQNNJlq+ESEiN8Y7S40gF223NEozDGGCH4z
 0W0NEUJ1YelZTwR6wRcIj1BDp75DyqsVj29L5J4Q2egXoLjz/7gSxYwt05CmO0bfqF
 it6k0P2KPpktFnUgiP9oOuHeLBlD7WSM2oyb3oIuC/cCNTHJcGFeGjw1fShHNAc6oz
 ZJ3L0UxmEy66pw9ck2/iq3ptv6da74SHcxpt+WNB2qI3btOq6ZeJkGviYgylKznDDt
 MUrEUF3wb/VRnqkGdZrOpxHZR4vUmblLRa3JwZPlGRsW7wFCiyLLbnX4AuxKiCzTsm
 hMzjemqLe4JZa7+AtY3a2yfzrowxx90L5hp9rrPjaNYJEhYFkW6MXT0N5rUFQo/oI6
 Y+Wg0adVVMr9G3zm+/cHVpzNdS80aDYnye0vk4ZJwby2VSQbg04o4QcSfbQLY0989V
 0BcSSl9tMk6mGgdf5ySWzg1Q=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b191f8a9b3so1403958a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795180299; x=1795785099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MsIlpqtTPK690TuRUbPpLl4/YKehdxLtCM78xwPeKtQ=;
 b=BrcmpfcaN5KhfIG3z9nOkfUQZsYcEn+dgC3AIegZ1O8yXCxDP1JcWYxMHUqzzX6F1h
 mKLSogl6NhqXSBwoFQP2HEyhY6lbKHzdW58XEBTQhiZj8hGcaA40bMLg/vI5pOfKzOFl
 u7PDvAB1OCduGS42fphrNAxObge47zuhOJh1jsqr5+oQIIv+4kCDoL+R5J7ca5psZXYU
 KlCJeLD35YIFUVbPXxhzR45UTBq0EvklwmpiEVlGa/JbIq2vfC/YSSnDxambp0bgf7Po
 +Pm9zqAGwbVe6K1LVVLhK/Z+MtlyZNCCIxvVpCfHY/AX4Y8e6bBdRO3ZzFUapPeeTNxO
 iVog==
X-Gm-Message-State: APuU4Z9jGtxqr4r3BesTcnUrTZuq3EtlyoLyJZWxhT/t3utK2v6ZdrmD
 +6FbHu0Tb3aHj0TqkhgfkcwD2mAIImTH7qeckjsbotnfKGKdRz2jn0RPq6va2NsljsPdACKGObt
 5tWEcLnxWgYlohnXNR85GFI1JXo0ir73TBqcjBEDV5F410pyIBtXxeKbvV7JfRs4Mhq8p5L7Cz4
 nl4sY7ODk7q+J/KfzTWWZP
X-Gm-Gg: AZFdTZePbhwVhaoOpDkOSN3EE3Vf+P0rkQ8Qu4jeopNOBkNyPcMRcnflzgKnFWCB7c9
 8cuGVpNjSPx/w5JM1rBa0lGdooGZspb6N2hPD1PSsRhqmxcUy04mckTqu+n3jjBTXmMcVXn8wod
 L8lOiYxHOWWYx+jpyT5vW1Xbu4efMlk0qM9yWCPC+BtaINrL8lzHQAFLGMYBb/ipZipWXiGrD3u
 Oa+Ut8OBmkFztG1NIS6Aw/uyoZk2XSbLgfM2Odc6cho8InzWtxnvBXCdR1B34/q7PKFm7nREH0z
 1T0xew9bFKOu4pQC4ogvC0+YBT3/nJP9MJ7nl3OT9sB3syfBhj2cw/yNnI5B7HuMxjRloep74e7
 +fUmzdPMvAApn2eXKUndYMFFMrC4Gh/DHwD4vRqbSgKLOg0Qnq8UrG1BYFnucT9jrmFgO5SV/z/
 EOxHTdV0BSgr3CNNtfP3Z7nKh4uqDJ9SRuRTRvO7kmPX0=
X-Received: by 2002:a17:90b:1802:b0:3b4:e19:e127 with SMTP id
 98e67ed59e1d1-3b41cb5009emr2738358a91.63.1795180299099; 
 Fri, 20 Nov 2026 05:11:39 -0800 (PST)
X-Received: by 2002:a17:90b:1802:b0:3b4:e19:e127 with SMTP id
 98e67ed59e1d1-3b41cb5009emr2738342a91.63.1795180298635; 
 Fri, 20 Nov 2026 05:11:38 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d028a54sm1191896a12.18.2026.11.20.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 05:11:37 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 2/2] test: boot: imagemap: check the data-size bound on a
 direct read
Date: Fri, 20 Nov 2026 13:11:08 +0000
Message-ID: <20261120131113.1044702-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120131113.1044702-1-aristo.chen@canonical.com>
References: <20261115143134.25791-1-aristo.chen@canonical.com>
 <20261120131113.1044702-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build a FIT with an external-data ramdisk that has a load address and
load it through the imagemap storage path with verification on.

The first test declares a data-size of 1 GiB, far more than the free
memory at the load address, and confirms that fit_image_load() returns
-EFBIG. It counts how often the mock reader is entered and asserts that
this is zero, so the oversized image is rejected before any read reaches
the device rather than after a failed transfer. Without the preceding
bound the read is attempted and fails with -EIO.

The second test makes sure that the bound does not get in the way of a
valid image: a ramdisk whose data-size matches its payload is still read
straight to its load address. The bound refuses a load address inside a
used LMB region, so the test takes an address that LMB reports as free.

The tests need the FIT loader, which IMAGEMAP does not depend on, so
they are skipped when FIT is disabled.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
v2: add imagemap_test_fit_direct_read(), which checks that a valid
ramdisk with a load address is still read straight to it. The comments
of imagemap_test_fit_oversize_datasz() no longer refer to
CONFIG_SYS_BOOTM_LEN; the test itself is unchanged. New subject, was
"test: boot: imagemap: reject an oversized data-size".

 test/boot/imagemap.c | 205 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index 2c6f23fb4f0..8546794ecfc 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -7,6 +7,8 @@
 
 #include <dm.h>
 #include <blk.h>
+#include <bootstage.h>
+#include <image.h>
 #include <imagemap.h>
 #include <mtd.h>
 #include <part.h>
@@ -21,6 +23,7 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
+#include <linux/libfdt.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -35,6 +38,7 @@
  *
  * @image:	pointer to synthetic image data in RAM
  * @image_size:	size of the synthetic image
+ * @attempts:	number of times .read() was entered, including rejected ones
  * @read_count:	number of times .read() was called
  * @last_off:	offset from the most recent .read() call
  * @last_size:	size from the most recent .read() call
@@ -42,6 +46,7 @@
 struct mock_priv {
 	const void *image;
 	size_t image_size;
+	int attempts;
 	int read_count;
 	loff_t last_off;
 	ulong last_size;
@@ -52,6 +57,8 @@ static ulong mock_reader(struct spl_load_info *info, ulong sector,
 {
 	struct mock_priv *p = info->priv;
 
+	p->attempts++;
+
 	if (sector + count > p->image_size)
 		return 0;
 
@@ -611,6 +618,204 @@ static int imagemap_test_blocklen(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_blocklen, UTF_DM);
 
+/*
+ * build_fit_ext_datasz() - build a FIT with one external-data ramdisk image
+ *
+ * The ramdisk uses external data (data-offset 0, so the payload starts at the
+ * aligned end of the FDT) and declares @data_size for it. No hash is needed:
+ * the read under test happens before any verification.
+ *
+ * @buf:	output buffer for the FIT
+ * @bufsz:	size of @buf
+ * @load:	sub-image load address
+ * @data_size:	the data-size property value
+ * Return: 0 on success, negative FDT error otherwise
+ */
+static int build_fit_ext_datasz(void *buf, size_t bufsz, u32 load,
+				u32 data_size)
+{
+	int images, img, confs, conf, ret;
+	fdt32_t v;
+
+	ret = fdt_create_empty_tree(buf, bufsz);
+	if (ret)
+		return ret;
+
+	/* fit_check_format() requires description and timestamp. */
+	ret = fdt_setprop_string(buf, 0, FIT_DESC_PROP, "data-size bound");
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(0);
+	ret = fdt_setprop(buf, 0, FIT_TIMESTAMP_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	images = fdt_add_subnode(buf, 0, "images");
+	if (images < 0)
+		return images;
+	img = fdt_add_subnode(buf, images, "ramdisk");
+	if (img < 0)
+		return img;
+	ret = fdt_setprop_string(buf, img, FIT_TYPE_PROP, "ramdisk");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_ARCH_PROP, "sandbox");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_OS_PROP, "linux");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_COMP_PROP, "none");
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(load);
+	ret = fdt_setprop(buf, img, FIT_LOAD_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(0);
+	ret = fdt_setprop(buf, img, FIT_DATA_OFFSET_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(data_size);
+	ret = fdt_setprop(buf, img, FIT_DATA_SIZE_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	confs = fdt_add_subnode(buf, 0, "configurations");
+	if (confs < 0)
+		return confs;
+	ret = fdt_setprop_string(buf, confs, FIT_DEFAULT_PROP, "conf-1");
+	if (ret)
+		return ret;
+	conf = fdt_add_subnode(buf, confs, "conf-1");
+	if (conf < 0)
+		return conf;
+	ret = fdt_setprop_string(buf, conf, FIT_RAMDISK_PROP, "ramdisk");
+	if (ret)
+		return ret;
+
+	return fdt_pack(buf);
+}
+
+/*
+ * A FIT's data-size is not covered by the configuration signature, so it is
+ * untrusted input. On the imagemap storage path an uncompressed image with a
+ * load address is read to that address before fit_image_select() verifies it,
+ * so fit_image_load() must reject a data-size that does not fit in the free
+ * memory there rather than read that many bytes off the device.
+ */
+static int imagemap_test_fit_oversize_datasz(struct unit_test_state *uts)
+{
+	struct udevice *dev, *saved_im;
+	u8 fitbuf[1024];
+	ulong load = 0x02000000, data = 0, len = 0;
+	int saved_verify, ret, attempts;
+
+	/* fit_image_load() is only built with FIT, which IMAGEMAP does not need */
+	if (!CONFIG_IS_ENABLED(FIT))
+		return -EAGAIN;
+
+	/* data-size far beyond the free memory at the load address. */
+	ut_assertok(build_fit_ext_datasz(fitbuf, sizeof(fitbuf), load,
+					 0x40000000));
+	ut_assertok(create_mock_loader(fitbuf, sizeof(fitbuf), &dev));
+
+	saved_im = bootm_imagemap(&images);
+	saved_verify = images.verify;
+	bootm_set_imagemap(&images, dev);
+	images.verify = 1;
+	ret = fit_image_load(&images, map_to_sysmem(fitbuf), NULL, NULL,
+			     IH_ARCH_SANDBOX, IH_TYPE_RAMDISK,
+			     BOOTSTAGE_ID_FIT_RD_START,
+			     FIT_LOAD_OPTIONAL_NON_ZERO, &data, &len);
+	bootm_set_imagemap(&images, saved_im);
+	images.verify = saved_verify;
+
+	attempts = get_mock_priv(dev)->attempts;
+	imagemap_cleanup(dev);
+
+	/* Rejected before the device read, not after a hash failure. */
+	ut_asserteq(-EFBIG, ret);
+	/* and the reject happened before any read reached the device. */
+	ut_asserteq(0, attempts);
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_fit_oversize_datasz, UTF_DM);
+
+/*
+ * The bound on the direct read must not get in the way of a valid image: an
+ * uncompressed ramdisk with a load address is still read straight to it.
+ */
+static int imagemap_test_fit_direct_read(struct unit_test_state *uts)
+{
+	struct udevice *dev, *saved_im;
+	struct imagemap_priv *priv;
+	const struct imagemap_region *r;
+	u8 fitbuf[1024];
+	const int size = 64;
+	phys_addr_t load;
+	ulong data = 0, len = 0;
+	int saved_verify, ret, read_count;
+	bool direct;
+	void *dst;
+	u32 off;
+
+	/* fit_image_load() is only built with FIT, which IMAGEMAP does not need */
+	if (!CONFIG_IS_ENABLED(FIT))
+		return -EAGAIN;
+
+	/*
+	 * A load address inside a used LMB region is refused, so take one
+	 * that LMB reports as free.
+	 */
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ANY, ARCH_DMA_MINALIGN, &load,
+				  size, LMB_NONE));
+	ut_assertok(lmb_free(load, size, LMB_NONE));
+	dst = map_sysmem(load, size);
+	memset(dst, 0xff, size);
+
+	ut_assertok(build_fit_ext_datasz(fitbuf, sizeof(fitbuf), load, size));
+
+	/* data-offset is 0, so the payload follows the FDT */
+	off = ALIGN(fdt_totalsize(fitbuf), 4);
+	ut_assert(off + size <= sizeof(fitbuf));
+	for (int i = 0; i < size; i++)
+		fitbuf[off + i] = i;
+
+	ut_assertok(create_mock_loader(fitbuf, sizeof(fitbuf), &dev));
+
+	saved_im = bootm_imagemap(&images);
+	saved_verify = images.verify;
+	bootm_set_imagemap(&images, dev);
+	images.verify = 1;
+	ret = fit_image_load(&images, map_to_sysmem(fitbuf), NULL, NULL,
+			     IH_ARCH_SANDBOX, IH_TYPE_RAMDISK,
+			     BOOTSTAGE_ID_FIT_RD_START,
+			     FIT_LOAD_OPTIONAL_NON_ZERO, &data, &len);
+	bootm_set_imagemap(&images, saved_im);
+	images.verify = saved_verify;
+
+	/* A direct read is recorded at the load address, without scratch RAM */
+	priv = dev_get_uclass_priv(dev);
+	r = alist_get(&priv->regions, 0, struct imagemap_region);
+	direct = priv->regions.count == 1 && r->ram == dst && !r->lmb_reserved;
+	read_count = get_mock_priv(dev)->read_count;
+	imagemap_cleanup(dev);
+
+	ut_assert(ret >= 0);
+	ut_asserteq(load, data);
+	ut_asserteq(size, len);
+	ut_asserteq(1, read_count);
+	ut_assert(direct);
+	ut_asserteq_mem(fitbuf + off, dst, size);
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_fit_direct_read, UTF_DM);
+
 #if CONFIG_IS_ENABLED(MTD_BLOCK)
 /*
  * End-to-end: read a known pattern back from a bare (non-NAND) MTD
-- 
2.43.0

