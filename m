Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD40606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kYKwK6Uq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCqtWVXt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B666A80E20;
	Mon,  2 Nov 2026 07:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9qFanf26tI4; Mon,  2 Nov 2026 07:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C836480E24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793603054;
	b=E0mYLnjJgyOMR3Y805T2Vein79T70E8IgdpNkHAJ4Mz/BzCx41DNY/WO5DN2GEWHvHCu
	 +w64ouGnhYWCsFr0VxDgmwRRYsdfVRo3cowb8fZQlDYjV6ak+gX7yuuflyCuHFPYDfsdD
	 g7+iO3ELkMp9uuP9ow8FWUgYq0IaMMZoYltyit3pbZ2hYq3kTc73QSRYcYr0WM7Cypll1
	 VYaQHlW6YwZR9Vk53LGIqAIz2IGdcabEvHgTNpXe2xbn16LE8IqTuocDI/LY2CMVpwke1
	 VhZ5H1R4LHgIFnp4TI1kqbJxp0x0a3HgJx8gtF9K5B6PLm2UzF1945jgTJzjQya3Qgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793603054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tOx5/rEkpcKHPCwyknJVWDqT6YP/7lP9YME4UQgC3TM=;
	b=ncqz54WXyN8QVBdUe7M2FLXsM+5By5dGo9pitjsnpxhBAOC02/l62THNWhaXu53YBD1y
	 B6k7BMLst7x0ykqn0gAgNwFcgIl4Wf6yIQAP/nJRTDFFCjDUStcSwERTlRR3GTymqvA0D
	 OD3q3haYFZqLl89RgShBUvZ/zEm/Sur6l28mGldVEYFkglMZhCxFLHFuXdpPhXXvs9qph
	 qGM2fwNamqDgYVGA3U+U7FLZ3SpWq3Kd4hGvK1yRen+8kM6q4njD8VlohVA3oHdnHMs27
	 VaZ76gtPW/km+NYlVHdZv/K0sdwwA0wDYuzaZ6YyE/pyrmNYMcQdTk+X+dnZrhzZjeQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793603053;
	bh=tOx5/rEkpcKHPCwyknJVWDqT6YP/7lP9YME4UQgC3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kYKwK6Uqd1ZGRbBMcvu2HItUI1mtvgJkZPpyTP2LcbYFutPdxqLkP66a2Q84CbS8s
	 5R7jxP1X+CmPnm8bvSPo4rmZ2m1tC80hmZIzlANMFUugcDlsP7/dHtSUXQkQfuNp6u
	 97TuW5XMXh+WJA4jzdlS7G3Mi9g9y0ELYFAPHOB7HS6Ez1UygnhgllK6b8W+XV3sUs
	 2dChKX/tvp1H7V2EEXDvOEXpTnc+yxLcCeUdNJIYRvod9a/WqKLiAu0dkeDc0y8fyn
	 ygOOHl5iWJc9wdgZkW4bB7dQ1WzJeTM4IS1BSQFUWRVEYzaGqB4yJ8e8RnPOA6sS2c
	 X/YIuj9Jhwsvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C836480E24;
	Mon,  2 Nov 2026 07:04:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AFB9435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 786646073E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsOHfcszHBmq for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 535F5605F8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793603051;
 b=LP9JMHJXBjOUmFOO88dnjuUbLqnIo9se1XPkiIqaTa6b9W56EmE0OP9u6CtCNf1tE3h4
 yjML8IucKH0zbyDWFp/bzetDBkSkt3a3VlehJpmx2tLyuYcU1W0BdcIDQ2FAQZ8BcCGB4
 tmg4aLuQj2r7ZaJdBV/ef8UakKlB/H1jlXOzL5apUyn+60fs8Qop5/BF7NUaTFh5vMG5I
 n7N5kjfX03ZIGw/crYMXoq8ZG6an2PYV1QpiohpGtXySDOQ6kK6c4oz7zxIEBCG9F7tJk
 /GeVAUuuER72bJsja3aJ/xhCWZCd2MJT02iWZEuRbBYV1nYYID28Bf5iklx7A4Mfe5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603051;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=tOx5/rEkpcKHPCwyknJVWDqT6YP/7lP9YME4UQgC3TM=;
 b=VL4tcftXaQpiJelmUJi8/WaxG6nx7kKQ+kqGlPssnwOtv42NP0l+ey0vLL54f9t6pWqI
 RCLaBA5DvnLdElZnDlryDSEkEWAs2FGoAldJsa/SKa4dHURW7GOhP+/eIo9AA3OOfwM4N
 q2emx+mnvgy/HE0T2b0lVwf9W/fKjV3QQw2fWGbNMJOMUiKjOuedAkEGClq0f84rVJ+Ag
 syz5rmb42PeLQfYlRXwrp+cdefj9zCV/WSLemCY4OX1b7AzfVj0hf/La6qD/o6z7L56Iv
 7Ei4hVeH32T9uUNcctrSmZvcbAkqpKTvXb/Cs/X0YosgFDwj1MM4aMqQoLTueMWaBzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iCqtWVXt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iCqtWVXt
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 535F5605F8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:10 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1274918f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603049; x=1794207849;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tOx5/rEkpcKHPCwyknJVWDqT6YP/7lP9YME4UQgC3TM=;
 b=iCqtWVXtyMLWYSCuvojIMZbSOFjXi3VLD34ylPJ3CSEptrPVW4xzSqlh/5ZJm8z1EM
 GQQxs7nEy0zw4ikbFnyCl0LPmPtJy/roDp43fTKYDNbG6YeMD+dmaRTc93Meyw2FWv23
 ta59b0PVIeYEbOhwjp53dQxcC2JSrI5sKozcx6dVQ4iy+XFhiSDrna79UAF/AjfMOJfS
 OIi0+gvRaB8Bm/QAZPnbkvfAWuxhwc1ITaRLpr1eE2bo4pao1lLB9fRnANXhG9WhBtlX
 W5kaYIlOPiDbuUNmMjb5gw5q1MlAXaMxPgEOLs+kBH5AxctcVldXDtIzHsqHCTWePxfU
 uPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603049; x=1794207849;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tOx5/rEkpcKHPCwyknJVWDqT6YP/7lP9YME4UQgC3TM=;
 b=KCCcKoGPxEGcif6dHWieMT3DGRJFJwAHFuF70GHJGGEm1Yb2YeaU+i714ZvTNpNSgo
 7fZN/wI6EW0/QKHdzTE0FL1x9L2a1tGwxrTLbq8eiKlJlbwy+wfSV3X/X39y66TZgKZq
 IwodV/GXTpG+Vp95Z2J8seYuY0IjRL1Qc0zQfhkUbyiJ7BiQSKNAle7goCKJAAl9aPMk
 C+QpRMRtT1la64agK8unP6DOTcTJFRL2r+1wm7OU6cuNNFsHN0mFSTsT08IqJH3vOb7+
 vaCCbB+lFE9f7OKj43jeyFfZsvWwVhiP+MHxE60BHnCphuLeA4bV6VdVlbvHj3HByRSs
 bYtw==
X-Gm-Message-State: APuU4Z8VM8i2jX6IJwWD7EwJ6jW5YMFvbzbztCfv8JBthHZ2QjhXjmeu
 ZPW28RTPCelzfZOxGlV0fGSviLCQ07eGL1rKhwJFZxlJi+5aVPMLRU+J5NPDVHJXCBY=
X-Gm-Gg: AYBFou3oicKPDWNESJQ+zx3KyqMDJhC9sMap4fKHnzK2mou1k/Mz1MQ0U9LTCkn3van
 +BJGOy0hL8b78RieNre7GcDbNQOeYiKpF7XQl0N+ArN6TgWG8OixCDDA9TMNmZ1wNOejg+tlPlq
 Ql9ow1xWh4/gwoXyRhoYayWk7ykg3g2fEr7Hh46RJhBkM6uDKhL3oZuZJnCxn91Y0KdFvKNjJav
 nxe1sWHdN5oFLSW7e2zYjdH/o3YjNeMYa6OVdgfxaKAwR03a82iolGWKwBAyFHVO8U6WMEbHMnh
 fQ3xPUlJwV//nFQmeoeiVaCP/IHBKRFuYBSvvId0q27hpg2MpPXtKWMchin7h33mcVqEWpEdROj
 4NP83SPDsyxVb8FxJhvLUIJ62l+6z+h1wakKhqX0vhG2Y3iA0grHEb3ysOy9DDYnWilW/2JSfub
 856IltYnoJLox/1MIRLEe5QTdzvAn49pj1p7JBWNh1VPWhavVfpARHtHXrLqjimquwejRJ+E/0+
 WJdwGmL54vwReQ/bMrOKiIkMJSYsfVG5bXLaZook2mhqwV0UFa4OT/KlUI/cZ0uhwIA2NGSNXGZ
 2Iz83jhHBCacj2vYh93lxr6zp1yOGaA=
X-Received: by 2002:a05:6000:46d3:b0:48e:5d8a:d1fc with SMTP id
 ffacd0b85a97d-48e6e2f8170mr12970222f8f.31.1793603048726; 
 Sun, 01 Nov 2026 23:04:08 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723fcsm18797194f8f.14.2026.11.01.23.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 23:04:08 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 4/4] x86: zimage: Bound the kernel version string to the image
Date: Mon, 02 Nov 2026 07:04:06 +0000
Message-ID: <46c92c78-32fb-4f14-8466-c6dddedbfc36@gmail.com>
In-Reply-To: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
References: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

zimage_get_kernel_version() finds the version string at an offset of up
to 64KB from the kernel base, taken from the kernel_version field of the
setup header, and then scans it up to its nul terminator. It works out a
256-byte limit for the scan but never checks it, and it does not know how
much of the image is there to read.

This matters for the ChromiumOS bootmeth, which reads the kernel setup
data from disk into a buffer of bootloader_size + 8KB bytes and passes a
kernel base 24KB into that buffer. With a bootloader of less than 16KB,
the kernel base is already past the end of the buffer, and the header
fields come from the disk.

Pass zimage_get_kernel_version() the number of bytes it may read at the
kernel base, and stop the scan at the 256-byte limit. The zboot code
passes the size of the setup code, which holds the string according to
the boot protocol, and the ChromiumOS bootmeth passes what is left of its
buffer.

A version string longer than 255 characters is no longer shown; Linux's
are around 100.

Fixes: 7c79eddbec32 ("x86: zimage: Sanity-check the kernel version before printing it")
Fixes: f861b1ee70aa ("bootstd: cros: Add a function to read info from partition")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 arch/x86/lib/zimage.c | 27 ++++++++++++++++++---------
 boot/bootmeth_cros.c  |  7 ++++++-
 include/bootm.h       |  6 ++++--
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a5f2231aa52..53c8e0429e4 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -145,11 +145,12 @@ static int setup_device_tree(struct setup_header *hdr, const void *fdt_blob)
 }
 
 const char *zimage_get_kernel_version(struct boot_params *params,
-				      void *kernel_base)
+				      void *kernel_base, ulong size)
 {
 	struct setup_header *hdr = &params->hdr;
-	int bootproto;
 	const char *s, *end;
+	ulong offset;
+	int bootproto;
 
 	bootproto = get_boot_protocol(hdr, false);
 	log_debug("bootproto %x, hdr->setup_sects %x\n", bootproto,
@@ -157,16 +158,23 @@ const char *zimage_get_kernel_version(struct boot_params *params,
 	if (bootproto < 0x0200 || hdr->setup_sects < 15)
 		return NULL;
 
-	/* sanity-check the kernel version in case it is missing */
+	/* the offset comes from the image, so check it is within @size */
+	offset = hdr->kernel_version + 0x200;
 	log_debug("hdr->kernel_version %x, str at %p\n", hdr->kernel_version,
-		  kernel_base + hdr->kernel_version + 0x200);
-	for (s = kernel_base + hdr->kernel_version + 0x200, end = s + 0x100; *s;
-	     s++) {
+		  kernel_base + offset);
+	if (offset >= size)
+		return NULL;
+
+	/* sanity-check the kernel version in case it is missing */
+	end = kernel_base + min(size, offset + 0x100);
+	for (s = kernel_base + offset; s < end && *s; s++) {
 		if (!isprint(*s))
 			return NULL;
 	}
+	if (s == end)
+		return NULL;
 
-	return kernel_base + hdr->kernel_version + 0x200;
+	return kernel_base + offset;
 }
 
 struct boot_params *load_zimage(char *image, unsigned long kernel_size,
@@ -206,7 +214,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 	log_debug("Using boot protocol version %x.%02x\n",
 		  (bootproto & 0xff00) >> 8, bootproto & 0xff);
 
-	version = zimage_get_kernel_version(params, image);
+	version = zimage_get_kernel_version(params, image, setup_size);
 	if (version)
 		printf("Linux kernel version %s\n", version);
 	else
@@ -577,7 +585,8 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)state.bzimage_addr,
+					    (hdr->setup_sects + 1) * 512);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 805680f71ad..006f30c0bb4 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -225,9 +225,14 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 
 #ifdef CONFIG_X86
 	const char *version;
+	ulong kern_size = 0;
 
+	/* The kernel base may lie beyond the end of the buffer */
+	if (size > before_base + X86_KERNEL_OFFSET)
+		kern_size = size - before_base - X86_KERNEL_OFFSET;
 	version = zimage_get_kernel_version(map_sysmem(setup, 0),
-					    map_sysmem(kern_base, 0));
+					    map_sysmem(kern_base, 0),
+					    kern_size);
 	log_debug("version %s\n", version);
 	if (version)
 		bflow->name = strdup(version);
diff --git a/include/bootm.h b/include/bootm.h
index d1aac3d44df..5b202cf2d97 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -299,10 +299,12 @@ int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
  *
  * @params: boot_params pointer
  * @kernel_base: base address of kernel
- * Return: Kernel version as a NUL-terminated string
+ * @size: Number of bytes at @kernel_base which may be read
+ * Return: Kernel version as a NUL-terminated string, or NULL if there is no
+ *	valid version string within @size bytes of @kernel_base
  */
 const char *zimage_get_kernel_version(struct boot_params *params,
-				      void *kernel_base);
+				      void *kernel_base, ulong size);
 
 /**
  * zimage_dump() - Dump the metadata of a zimage
