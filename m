Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F6CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B5F84B77;
	Fri, 10 Jul 2026 17:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWz+7JoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C54384B7A; Fri, 10 Jul 2026 17:23:07 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0368884B72
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-92e99ef0902so52781185a.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696984; x=1784301784; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0yMYoBC0c7/XDpUlxpZRrYoNxRTR/FRTO3u69FVh+zg=;
 b=eWz+7JoP/B/ceqToA2ptfA9HmpZYPVMFwS7pB/AZKRaqPi+PDpjDXSaCiDmddmWn0b
 oODX9VEhqeiq9wRqnJrXvFETuUcb8xXk12gTXOXMgpJ1DivnkPNEp2mmSSglHS9x9rm9
 H2hRXo2fpGiAbzUN0X4EI1CH2J21DCfMoDISCSbZs4ZrhKKVcOySHr+Osw2V5nY+IGI3
 SXHfTssEblx/gRlQ8zNN4HOy2MCtSYUzwbpK9jxmVJNnPQ8uBxsK6PJqfmNOBPzVdkPs
 ui4LCz7WaniEFLseOfWwRnDmF3noHXDVRgtwFA7OL9zH1Vnx9In1yxX1frL1vLRjbjg0
 ezbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696984; x=1784301784;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0yMYoBC0c7/XDpUlxpZRrYoNxRTR/FRTO3u69FVh+zg=;
 b=BWMB+UpSNzp1JXhvHTuvKNAAVUewiqAETYkSsIXU2TLaT/HiWhHcia0XerUG3L0KX2
 k5GMXBVfI3DveXLCRhXKy/H/HT0sWHBeREEqN/ujQiPPPgFZaPrSaFHaL1Bm1X9Yn06b
 elXafizbna8FOdno68i5vRpY5jbxRHoDaoEA9iuTHisBz7H/zMQrgSNGLLflMeq/oHtm
 wk2bTam/sDVtQDLcFtjqaIiuUdX983rry4ZALGrFDa6ERAQYrxpIMHUm8dRRyBYvRZE6
 ETypWqZr2aF9K9hfPGljB7lYJ2NIZ8W2L035Ss/85M4OstOo30lEx0Tudo/czbZsW/CG
 kSWg==
X-Gm-Message-State: AOJu0Ywsd9bI02fzcvCrICE5Yaq3GTmVDsLraSsvUYXrxxtBKHwsZrKi
 lgNN9Y1cXKSS1jd6JpeGva5c+wSb3QwXIAqv165BuJiQlTdJ+82Fli+qdBv2RQ==
X-Gm-Gg: AfdE7ckJq5fjgo3cGOfQhjwCRejAsS/yUfaFyzAAmwzqukzSRkD5va+DgWm/BCBTj3C
 31VgefzAYt3/THuQFIiElpYbCNG/JeYvaR7dTg02G12LLJxEMiLV6R3hgmRmSfWvKLR4+2yNxjA
 lWcL86l5EWo8DICZPEEmoA4xIIeEsSQ+DcYlEtSMHmUSY79p9c0IKctpP9ljTBJvoeu6yi28Lpy
 A9PFPLQvPI9N7DEdSO8WOd2zKKgIsE2BGJS/iNHSMuFrbAl+TV0oY0P61+oHb1B8XZQCZS7HVPL
 8prZvG88Pk0a2tsI6kEukALj18QgTUArEHZ9bdkHWDmaj5paOt/TdpZ7MCodc7bXrFHUPdBRm/u
 Cx3thrJDwOv5OLbj6eIOWKKocHY/hq45o5hueUwalto/I/9596Z8mFnwC6AASbZ37Ho96wm/jrq
 4EEbp/L8jiJw==
X-Received: by 2002:a05:620a:ac14:b0:92e:ef09:f8f2 with SMTP id
 af79cd13be357-92eef0a1b5emr130513385a.66.1783696983691; 
 Fri, 10 Jul 2026 08:23:03 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b86276sm218390285a.11.2026.07.10.08.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:23:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:52:59 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: pstore: bound path formatting with snprintf to avoid
 stack overflow
Message-ID: <clk4uaks6k2ljuzyobu4e7m5dwxgsdgtia5jfvhmargg2x4qfe@3f2jmjmsknns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

pstore_save() writes four different filenames into a fixed 256-byte
stack buffer 'path' using sprintf() with "%s" fed from argv[3] (the
user-supplied mount directory). The U-Boot command line buffer
(CONFIG_SYS_CBSIZE) is typically 1024 or 2048 bytes, so a directory
path in argv[3] can easily exceed 240 characters and overflow 'path',
corrupting the surrounding stack frame including the return address.

Replace the four sprintf(path, ...) call sites with snprintf() using
sizeof(path) as the bound. The neighbouring sprintf() calls into the
'addr' and 'length' buffers are left as-is; they write fixed-width
numeric conversions whose maximum length is bounded by the size of
ulong/u32 in hex and cannot overflow those buffers.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/pstore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 9795eea2dbc..f2c0034abbe 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -413,8 +413,8 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 
 		sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(buffer + header_len));
 		sprintf(length, "0x%X", size - header_len);
-		sprintf(path, "%s/dmesg-ramoops-%u%s", argv[3], index,
-			compressed ? ".enc.z" : "");
+		snprintf(path, sizeof(path), "%s/dmesg-ramoops-%u%s", argv[3],
+			 index, compressed ? ".enc.z" : "");
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 		index++;
 	}
@@ -426,7 +426,7 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 				 buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
-		sprintf(path, "%s/console-ramoops-0", argv[3]);
+		snprintf(path, sizeof(path), "%s/console-ramoops-0", argv[3]);
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 	}
 	ptr += pstore_console_size;
@@ -438,7 +438,7 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 	size = pstore_get_buffer(0, ptr, pstore_ftrace_size, buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
-		sprintf(path, "%s/ftrace-ramoops-0", argv[3]);
+		snprintf(path, sizeof(path), "%s/ftrace-ramoops-0", argv[3]);
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 	}
 	ptr += pstore_ftrace_size;
@@ -448,7 +448,7 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 				 buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
-		sprintf(path, "%s/pmsg-ramoops-0", argv[3]);
+		snprintf(path, sizeof(path), "%s/pmsg-ramoops-0", argv[3]);
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 	}
 
-- 
2.43.0

