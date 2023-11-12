Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E01C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B839087750;
	Sun, 12 Nov 2023 04:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wt9gd/Sh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F069A87036; Sun, 12 Nov 2023 04:50:42 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C0B86F63
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a6acc8e222so134694239f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761026; x=1700365826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IP2epu95ZAhGHKIWxpewHOswK/WAlT9+U8j9z3Mj5lg=;
 b=Wt9gd/Sh7tVWGZx2FDYC3HU9X6dhE39aQDMMayUoIOs025Ea0QQG+uxZU2KoM27suZ
 iYjSbyXWpzzyxqzNqDgnYB1NOtFDvbQgsv7GnJv0EtEfY5Ea/poZLP5L3j9weD9sDbR2
 cMcBgjbINyQ7I4Ugd55V477lnVKz9ecvaMAoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761026; x=1700365826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IP2epu95ZAhGHKIWxpewHOswK/WAlT9+U8j9z3Mj5lg=;
 b=F94T1FQU1rceYdht/6qGosuGHk+w6sQVUfsaUjDZDsPx3xN9X5QmeeuSSxUHjf3jBG
 s/K3zL8yw9olEaaHu8R7Pw7ThN9BWWkJA+BRDBhygcrW0YoT+c28LvIgEonlQzx8CrhZ
 9Db7r4tD1Dbuvv9Y6yTqnUiS0yKglrZCh04u3aXfpJY94ejIOxBe0MnzKlANv4kqPZWw
 lDloSiaCjnvFrktQliZ3JGvXnX9oMKoYjFHapmt+zuvOKhNkgfDLS6fOvGRDpQfJrr0h
 5UE/o9lf6YGLTR1WHy4PwIBvo1OBp+aLRVOToV71dwUAG6oFwAVA9Yhp9AFCRNAgOWbY
 rZfg==
X-Gm-Message-State: AOJu0YxW9VT33CWV8E7kIvfMIvUSBTo0jfCxZAsLNTZz8w4RlA0y6Kq1
 VszFdZNCGhgsD4yschMn1H6y9m94RAOr/NCipb8Gvw==
X-Google-Smtp-Source: AGHT+IH+xnn6+GyM7HBO6AnmHauqsBiuXdKLwP94WWf+om5NAArCr4FsobvliEpEviZy4+xoBj1O1Q==
X-Received: by 2002:a05:6e02:1808:b0:359:4f85:b230 with SMTP id
 a8-20020a056e02180800b003594f85b230mr6114232ilv.18.1699761025972; 
 Sat, 11 Nov 2023 19:50:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 3/5] bootm: Allow omitting the load address
Date: Sat, 11 Nov 2023 20:49:55 -0700
Message-ID: <20231111204954.v2.3.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112035001.103897-1-sjg@chromium.org>
References: <20231112035001.103897-1-sjg@chromium.org>
MIME-Version: 1.0
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

The kernel_noload image type indicates that no loading is to be done by
U-Boot. This works well when the image is uncompressed.

When the image is compressed, loading is of course required. The load
address in the FIT is used for loading.

However a FIT built from Linux v6.6 supports about 990 boards. Each has
a different memory arrangement, so no one load address is suitable.
Therefore the 'load' address in the kernel node is not useful.

It would be better in this case to be able to omit the load address and
have U-Boot choose something suitable. The kernel_addr_r environment
variable seems to be a more reliable final address for the kernel. Use
that as a backup when the load address is missing.

Similarly, use the load address as the entry address when the latter is
omitted.

Update the FIT documentation accordingly.

Note that mkimage still requires each image in a FIT to have a load
address, at least for now.

Another option would be to create a new Kconfig for this, or to use a
region of memory known to be free, e.g. calculated from the DRAM banks.
But in any case we should try to avoid conflicting with the
kernel_addr_r variable. So the approach in this patch seems reasonable
to me.

It might perhaps be useful to introduce an 'entry-offset' property
which allows the entry to be set as an offset from the load address,
whether that is explicit or calculated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Allow omitting the load address rather than messing with kernel_noload

 boot/bootm.c                         | 20 ++++++++++++++------
 doc/usage/fit/source_file_format.rst |  7 ++++++-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..aef9fad8ca13 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -177,10 +177,17 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 		images.os.end = fit_get_end(images.fit_hdr_os);
 
 		if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
-				       &images.os.load)) {
-			puts("Can't get image load address!\n");
-			bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
-			return 1;
+				&images.os.load)) {
+			ulong load;
+
+			load = env_get_hex("kernel_addr_r", -1UL);
+			if (load == -1UL) {
+				puts("Can't get image load address!\n");
+				bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
+				return 1;
+			}
+			printf("Using kernel load address %lx\n", load);
+			images.os.load = load;
 		}
 		break;
 #endif
@@ -230,8 +237,9 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = fit_image_get_entry(images.fit_hdr_os,
 					  images.fit_noffset_os, &images.ep);
 		if (ret) {
-			puts("Can't get entry point property!\n");
-			return 1;
+			printf("Can't get entry point property, using load address %lx\n",
+			       images.os.load);
+			images.ep = images.os.load;
 		}
 #endif
 	} else if (!ep_found) {
diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index b2b1e42bd730..f92738a9480a 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -234,6 +234,10 @@ type
     zynqmpimage           Xilinx ZynqMP Boot Image }
     ====================  ==================
 
+    The kernel_noload type indicates that the image is a kernel but that it
+    does not need to be loaded and can be executed in-place from the FIT. This
+    type cannot be used if compression is not "none".
+
 compression
     Compression used by included data. If no compression is used, the
     compression property should be set to "none". If the data is compressed but
@@ -353,7 +357,8 @@ entry
 load
     load address, address size is determined by '#address-cells'
     property of the root node.
-    Mandatory for types: "firmware", and "kernel".
+    This is normally mandatory for types: "firmware", and "kernel". However if
+    it omitted the bootloader may chose a suitable address.
 
 compatible
     compatible method for loading image.
-- 
2.42.0.869.gea05f2083d-goog

