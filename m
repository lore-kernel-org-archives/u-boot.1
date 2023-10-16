Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265B8CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBE686F35;
	Tue, 17 Oct 2023 00:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nL9nJYvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1687A86F22; Tue, 17 Oct 2023 00:31:42 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDBC86EF4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7741c5bac51so290546285a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495461; x=1698100261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivQCS3hYBf29z+30SM1ZCTKidB0mSP2Un7blu4ka7Ww=;
 b=nL9nJYvChOZPZrliuxZFJN53FGMUPl8yXr52AsmmCOYXL+qmLWLU0+E5BuXR03N4o8
 o0SVVwJVqcM55JVl3u+UEOZ0YcR7/Zs7GkkOhKgQjigQ6OdtCClPWuxA66WUtnEq8Lha
 n7RrgLDCWUxtW5Ah57HGzPK7JN2Hp76ipKjCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495461; x=1698100261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivQCS3hYBf29z+30SM1ZCTKidB0mSP2Un7blu4ka7Ww=;
 b=EhEUgO4WB9xMHJzJAfrtVSDOEWOxJNAWN2NDn0164I2EIuPGZZ2SxD5eLhwjtVvszp
 AFcrkxnPX6c96PdxyuqNrgtZLsAdOctX0tgeKUwfHQYLAd2ZwCqpcL4muy9gQmivp1T1
 mlJ8CPx0zq+/tO4VT4azIZYDP4X36QBbTBQ0RufF2nV6pSOkE56xPRPGMX7fKITMWkYv
 3A15jCarHwFoh/CHhBc68JPw6rWFqe+Iu4RP3liBeLMzEf+rTVLVEbsWm1gDGwzCraLh
 sw9IJBfwj4t4jNAqt6mcsgCseI4kkg5Pc/9c1oWNwBeYmQs/LoLNjzoBoSvjW7LbdnEU
 J2iw==
X-Gm-Message-State: AOJu0YysiRfmK4h6jYQLRo0CoOSPZMbOv0Unz4slP4OGl8han2VWilNd
 t6wAgaABSOXCLXVMRSceAMp3+hE9ibJXOlv8fKRG6w==
X-Google-Smtp-Source: AGHT+IG+PJd2ibMSkDFSkKiZqUW6d2a0ld8oWhVu6s5D/pmKWlybqTzIxEsxHxsqdG9RRBHeqxDwpQ==
X-Received: by 2002:a05:620a:44c4:b0:76c:e7b7:1d9d with SMTP id
 y4-20020a05620a44c400b0076ce7b71d9dmr612007qkp.27.1697495461248; 
 Mon, 16 Oct 2023 15:31:01 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v3 15/32] fdt: Move working_fdt into fdt_support
Date: Mon, 16 Oct 2023 16:28:06 -0600
Message-ID: <20231016222835.596572-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

This can be accessed even when commands are not enabled. Move it into
the fdt_support.c file, which is where most of the FDT helpers are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/fdt_support.c | 5 +++++
 cmd/fdt.c          | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 5e49078f8c35..6ae7b8e20f65 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -23,6 +23,11 @@
 #include <fdtdec.h>
 #include <version.h>
 
+/*
+ * The working_fdt points to our working flattened device tree.
+ */
+struct fdt_header *working_fdt;
+
 /**
  * fdt_getprop_u32_default_node - Return a node's property or a default
  *
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 331564c13be9..86e847a41826 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -31,11 +31,6 @@ static int fdt_parse_prop(char *const*newval, int count, char *data, int *len);
 static int fdt_print(const char *pathp, char *prop, int depth);
 static int is_printable_string(const void *data, int len);
 
-/*
- * The working_fdt points to our working flattened device tree.
- */
-struct fdt_header *working_fdt;
-
 static void set_working_fdt_addr_quiet(ulong addr)
 {
 	void *buf;
-- 
2.42.0.655.g421f12c284-goog

