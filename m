Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044F60A2606
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w99uNtFm;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=pGf70Zw7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB5C08168F;
	Fri, 20 Nov 2026 13:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d74piuIEwdfb; Fri, 20 Nov 2026 13:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2D15816A2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180908;
	b=qbKNAvCCa0m4R+/mavGl0ipDrk5bg3HEygbQvKgJl8rUg2gY8Ui/1w3oKfHPwGZVqoZq
	 u+AlDOAmKzYpZZQYyWisdCaGZEtpFZjkEvw4X7qpMiruT3Px8twqKScnDBcgN1NzrSIai
	 AHjPbVBiBrYse5xG6+R3H/87EQjkrjF5F7bLW1iyBpi78ScEg9MqaCmgeOXNXajliAzTV
	 3LXGrqS6Wr4F/QkPyDoT+V7pHk1du8MWRBE2kxUlcQ5MDzDwcN3FoKfvtZgpfDK/FwoFK
	 OTdmpLXCpTSc8aS6Q+ZY6Q0BH+R0+gqZPXvmQiQG4ik/+AWGdRzYyrDXtOhkj0wKGvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tJmh9a8B9Yj9WLXkdLPZ21nNs2vD8Qs4VaJER5efxWw=;
	b=MnCla+ZUtlApA4Ph1Xf5SVrnmP2JnK6rbDfT5gHdl41iiSeLJa/Uuwk+R8rcWwB/EK0w
	 9ev/Qt81jzChHFeugHh0S5jlCkJKKlVWGcsPrmolqTiDHZ/DmNphGUwE0gc2hRyuQJYi2
	 +lL2ywFfHnHdhP5pEg33a/308P4o9a90YHI3JkjhB4beUJ6k9RElmXcFdI7NiJytK+KZI
	 WsyEBDMBz720JXjdunM8eWQuaQbYuJbouyzZDKFYPfDdgbOHgZPUjlGHZjehcSKAvYd6C
	 D3gTE8bC6X8gZMlhAKS/WidyT9QYlUZkVrbYRl+4stCcg6J9cd05as9G70AwZcbCl/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=pGf70Zw7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180908;
	bh=tJmh9a8B9Yj9WLXkdLPZ21nNs2vD8Qs4VaJER5efxWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w99uNtFm4oQzwRX1U2umrdJ/6POCEWnF/1K2as+MCCJyQkYnpY92FrTyx6wnpg8Ls
	 oVG9Ps8elEzfcuQ3ZZT4epAkwKw79wVbukoXH0PEGFtZnvQZ07OD79ZzuqO9n2e1iY
	 x8xuGd0C+ijol8mI6y0bcxg+yEv5RH7kWv+567hYAZY/eoxgQTzbJRweM+bp28E/se
	 UYhbCbS3nmNIlr5TAOET6BMnJtE5GfKSNzAsuktRrHYb421DnfEsCds3ij4TCh12LU
	 gqijDSmAwuA612eVSE/6LcECbB0IXCF8lNp3nRzCbvHwSiGpFnKoW02anhOknqx7Vp
	 JTzYbgUYcxaRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2D15816A2;
	Fri, 20 Nov 2026 13:21:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B6911C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D2128167E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPloh9TEOmQQ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 13:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3D178165D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=pGf70Zw7
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3D178165D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:40 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F4263F67F
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795180297;
 bh=tJmh9a8B9Yj9WLXkdLPZ21nNs2vD8Qs4VaJER5efxWw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pGf70Zw7KD1MmzhQLc/X3RwXRjbhdrURbsXA4k+HzHewkggRQWo4fpc8w4DuG3Jn2
 xQO20idkrf2AqdeBdlxVF2y+/a62FxjO8Q1rdE6Y9EchCNcaT95GR+jvPY8gkZHbzR
 1lfq4CUvwYKH+iHMKNCXNwGKkU4vKw1yV2l9xQeBjFvT+RM2Bmdd1Hz1CITlNLVM5S
 4ao8fRTFx/CHOvnS3Pcd+y+492ugQo1M1WLGWDDNhAJtKr3txa9Kbjewn0gBs2XqDi
 aibpDPlS9d8qJsvv83OH3K+o9EYSaAzIJkdp68RSie7D9ZBbrjOb/k+ut1O8/Z2Ar0
 BAComG0a1ktTt+IcY1REkBYCm8RNzgE80lBr8fvLGxCNslreB4dSgA0+GM+k5NbvH7
 oMlZNOVL143auEjfjyqEl8Rby5P8wWhE6k1KozWim07aU3yFk+gjIQdCHlk9vsMLFn
 4zXpu5RQ/i+bS/iPuaSvgW46HFmRgA56xE6VjFjf8+K6FQ7yBa4AL+9dLqy1pfsbMb
 OL1IjZ4J8pGVgbJ6x3GCle+Cq5OS9PougV7b7FuNJI4JIubQbFpvWZ5Qbj6mGG+FFr
 JfSij1CjvtcTm7Mvp0lGClfLFCXNTq0JeXRHMc5ktv6MCeGYiinfxZcQlsFlnTazLL
 fTyhnafPNzg193Tfw/9cvssU=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cde02b50dd6so1329557a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795180296; x=1795785096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJmh9a8B9Yj9WLXkdLPZ21nNs2vD8Qs4VaJER5efxWw=;
 b=QxDEvpiXrQLG5RLoVMJRISh0xcaV6awSsWbINOo5PdkwVzIElD1KVMwVC+rQnkV4FQ
 RDQW9pdjyNvmfeZLTqSpAZmDHwZjT9pm9f1iqBAo9/ZhMHyzZ7WMbMFaRyqd4HIWLFNu
 i/DaHWBlvheWkVznGjv3UpUq9TyrwcZO/u+Rei0AGdk92WKg+yqmQ1PgE/E81aHdD+qJ
 ceJuFmxyOsPk5WWMBF+lKWOz51TdVUg1tKTFRxAU2Z/yqDTs3o/LyiC4VsxPalpw30s/
 JpYEQpzXlV7Pd5KfRVnveFaNqefj1FvjK/O3efN58BuXqQVEhWMMmInHFaq1jV9MGGSg
 doSA==
X-Gm-Message-State: APuU4Z9zrdbqbKgFiDCEApp2TTB7/zZwTT6u4UszHJUouWFrfNo8pbKG
 x6c0bYkeJXKvf/f/P5ZmQUu48Fc37MWCWusVlzyPeeTqVMRIK/Gv1AWErdEqlkZnRo3HBGWllDS
 hn2LK/7xNvaQ6BrvPXvSfXC6Pyzo5M9BW/LXf34U1DmIs7C4D09FtbwwbOysANcsUci901UVUZD
 loKiKr837oiHf1DwB7lGYk
X-Gm-Gg: AZFdTZdh2pN1odeeSDy1WtzetgDQ0LudDS3gyLtjc2ht3U9m3JS+njnR0GduhazDTxg
 KXRCfw1hsliI8QJIwJ0rLt5xhRhVo3bPsXuTiCS4NLcXf8rrcfnBT5ZkVlDjn6KVMPKOguWrd8u
 hm2+Ez+KyLC93uTxZXrGms8bqMablQ/PpJFkvD+J6J7GxA+Z1HD8JjGCDTGkKygudcrbZ/RZ1O6
 0fuwyULqWExcBitN1Jgr1pW0/lg3eS26BckHH2sxVh8OAjVlceVzI9yCGeLknod5FaHYQwOqAw6
 YyN/TzTXOVyomjUrMOWt1Yo/L9OdeNjc6xrI0oCwQKumJN0pFVmFzgqwWY5kcBHGfr3fUF2/Uy5
 KjJPxr0LKIaebnfBH2mEbJe4x9c9YnZmZxdr+ogk0W8M6Z7ykb9Bg1iGHqMqzLEMUQrxQVATGpZ
 AD7LbL4LnY5TXr3pm2Xck8l/gXGjoykd0RWRDXw0+Zqfc=
X-Received: by 2002:a17:90b:5350:b0:3a7:d9bc:d204 with SMTP id
 98e67ed59e1d1-3b40a5a481cmr3373919a91.17.1795180295916; 
 Fri, 20 Nov 2026 05:11:35 -0800 (PST)
X-Received: by 2002:a17:90b:5350:b0:3a7:d9bc:d204 with SMTP id
 98e67ed59e1d1-3b40a5a481cmr3373905a91.17.1795180295404; 
 Fri, 20 Nov 2026 05:11:35 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d028a54sm1191896a12.18.2026.11.20.05.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 05:11:34 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/2] boot: fit: bound the external data size on the
 imagemap storage path
Date: Fri, 20 Nov 2026 13:11:07 +0000
Message-ID: <20261120131113.1044702-2-aristo.chen@canonical.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fit_image_load_storage() loads an external-data sub-image by reading it
from the storage device with a transfer sized from the FIT data-size
property. That property is listed in exc_prop[] in boot/image-fit-sig.c,
so it is excluded from the configuration signature and stays under the
control of anyone able to modify the boot medium even when FIT_SIGNATURE
is enabled. The read happens before fit_image_select() checks the image
hash, and for an uncompressed image with a load address it goes straight
to that address, so an inflated data-size overruns the destination
before the corruption can be detected.

The other branch is not changed. There imagemap_map() reads into a
buffer that it allocates from LMB at the requested size. Its size
arithmetic can wrap for a data-size close to 4 GiB when ulong or
phys_size_t is 32 bits wide; that needs a fix in imagemap_map() itself
and is not part of this patch.

Before the direct read, reject an image whose data-size is larger than
the memory that lmb_get_free_size() reports as free at the load address,
and print a message that gives both. Within the limits of that helper,
which are listed below, this keeps the read away from U-Boot itself,
from reserved memory and from the buffers imagemap_map() has allocated.
It does not limit how large an image may be.

This is partial hardening, not a complete fix. Free memory behind the
real payload can still be written before the hash check rejects the
image, and the destination of a direct read is not reserved in LMB, so
a sub-image that was read directly is not protected from a later one.

lmb_get_free_size() has three limits that are left as they are:

- It stops at every used region and returns 0 from inside one. That
  includes the LMB_NONE regions that the load commands, tftp, wget,
  "sf read" and bootm leave behind, so a valid image is refused when
  the load address of a sub-image is still recorded as used after an
  earlier load in the same session. tftp and wget stopped using the
  helper for that reason, in commit af45c84871e4 ("tftp: rework the
  logic to validate the load address") and commit 51ebd514ec78 ("wget:
  rework the logic to validate the load address").
- With more than one RAM bank, the size it returns can run across the
  hole to the next bank.
- With a 32-bit phys_addr_t, it does not see a reservation that ends at
  4 GiB from an address inside that reservation.

Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
Addresses-Coverity-ID: CID 661899: Insecure data handling (TAINTED_SCALAR)
Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
v2: bound only the direct read, by the free memory that LMB reports at
the load address, as suggested by Daniel. The CONFIG_SYS_BOOTM_LEN
ceiling and the Kconfig change are gone. Commit message rewritten; it
now lists the limits of lmb_get_free_size().

 boot/image-fit.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 75d0f3f72d8..bb4bbdb04c8 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2309,6 +2309,23 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
 	    !fit_image_get_load(fit, noffset, &img_load)) {
+		/*
+		 * data-size is excluded from the configuration signature (it
+		 * is in exc_prop[] in boot/image-fit-sig.c), so it stays
+		 * attacker controlled even after fit_config_verify() succeeds,
+		 * and this read goes to the load address before
+		 * fit_image_select() checks the hash.  Keep it within the
+		 * memory that LMB reports as free at that address.
+		 *
+		 * This is not a tight bound: free memory behind the real
+		 * payload can still be written before the hash check rejects
+		 * the image.
+		 */
+		if (data_sz > lmb_get_free_size(img_load)) {
+			printf("FIT external data (%u bytes) does not fit at 0x%08lx\n",
+			       data_sz, img_load);
+			return -EFBIG;
+		}
 		dst = map_sysmem(img_load, data_sz);
 
 		mapped = imagemap_map_to(imagemap, data_off, data_sz,
-- 
2.43.0

