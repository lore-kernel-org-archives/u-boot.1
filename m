Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77314CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72658496E;
	Fri, 26 Jun 2026 05:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KByKRTzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEA784981; Fri, 26 Jun 2026 05:48:09 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709728495E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-139aaba3522so373534c88.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782445685; x=1783050485; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/YPHJ16eqCQ10fRPiNbm2rM4x8/rj4Kt7TdPg1v/hJI=;
 b=KByKRTzNE76DY4RYvGkc5bKoRximEgUruLoVk4G79ohDKpN0gkFeIGgTf9O5TSdNvi
 3DRbVWVKiTVcZQe5vBAQ4c3d2GfmecliVHC45HXwGDgIUsOE/T11gJRCdV8MwSRu0+7p
 XdhdT/fIsrGbSlF/CAuUQ7cB6kmaAAmyw8LfjYfPfSH/bxc3JrO3sGLGZuagcsZYPdNE
 dinmVrfHXDw/D8ud5Vl9iFq/nA47CXQI6qiVczqbDXWAdvINR1LARUhSin/lz2DnmL0h
 HzxsV8g1zRr4PRhNRopsnNX3jBLGvQwPARZQQlCnxSHr/IL2JY6T0cuJWCZlexaiSCLy
 y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782445685; x=1783050485;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/YPHJ16eqCQ10fRPiNbm2rM4x8/rj4Kt7TdPg1v/hJI=;
 b=Lq6+oMvgtKzo+3hoH7p4oJ+2p31puMw6MA4JiN1LKdfVwB6NUGPpp77r1038e03DaY
 SXm7jQ8WOYuTr3sGNjbG1Lad8ETwfyt3rKC4EwONORRnlEoaqvEU/cFWMF7BZbVGp7FP
 4G/n1Dx07O2B1me/93H5n1FU/Zp+5ZcwOnIWaFLtgNfapju00RlbauvHk5S1HWWXkNF1
 C6dzlFpWGSiNAWgxQd10eefwIjD1wrz/IhXVZHfdf5pJNGkipDKhFEGt8u9HJkH4NBP6
 kmUWxtuQSr+yEiPk8ov25gow0P4AFGzujAvEYhQmcheqPqp2FR6N3lcJW0j1CWts6IpY
 dYBA==
X-Gm-Message-State: AOJu0YzalqW1owLToizsr/7oSjljZrXkEDZuZ6m4juZBdSKbvL8bq6qT
 fYhdKOrLn+w0RzJUrMjU6z4xlPUr/7s3wNfaJN2fzNCfZAI4TriUa3qsUrRPrBmI
X-Gm-Gg: AfdE7cke5+xZemv37K3WMFgP25hrg7GDaWqkiKquk4H6iahnVRNwACm9gFYdA2eV9dk
 YKRcqyyBrlI83T7CtGMk7p89EejyThl0dXHRIxCtDiyFmjxzpig3s17A02roO+9BozrLwTCoQWM
 Jqpa0R5+dUm6zUh+Re5MhkFyY9BlwTU15UCUg8CBvrHlKP/EtCfwgCXTBWtTS+/MIppIRLVujCV
 BGdEJKCig2QPxBS8TOflZ7CjRR+zd9KX5fiXKXo5PKYDeoNFbGNR/36l4I6Q0g5MYrbPZFWvA/9
 mw1EJO/LAaDJZzLf0D1ofMEBcbMhszNm8rxkhWIqby4sJtL37ryi4Oa/EI4oQzamxctyxEenmla
 0p5pAVepkkQ2R8cOMj14irJ7DeGOGVG/W8fWBY4msdZOPliUMWwEo7zbOEuekCt5rVQu489n6ZM
 cPLuuv7AJ/WOFSOQ==
X-Received: by 2002:a05:7022:1281:b0:139:b0a7:9df2 with SMTP id
 a92af1059eb24-139c3c1f6d4mr13684266c88.7.1782445684633; 
 Thu, 25 Jun 2026 20:48:04 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d91006afsm15823507c88.12.2026.06.25.20.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:48:04 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:18:02 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: ini: avoid NULL deref when loadaddr/filesize env vars
 are unset
Message-ID: <tuv7mfxrzuciqveqccoy6gl77szlhfnz6nr5wohjmcmevjlxpm@3l6l3zj6rxxl>
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

When the user runs "ini <section>" without explicit address or size
arguments, do_ini() falls back to env_get("loadaddr") and
env_get("filesize") and passes the results straight to hextoul().
env_get() returns NULL for an undefined variable and hextoul() does
not tolerate a NULL pointer, so on a board without these variables
set the command dereferences NULL.

Fetch the strings into locals first, reject the NULL case with
CMD_RET_USAGE, and only then convert to numeric values.

Fixes: c167cc02033 ("Add a new "ini" command")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/ini.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/cmd/ini.c b/cmd/ini.c
index 96399017691..3fe86209c32 100644
--- a/cmd/ini.c
+++ b/cmd/ini.c
@@ -229,6 +229,7 @@ static int ini_handler(void *user, char *section, char *name, char *value)
 static int do_ini(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	const char *section;
+	const char *addr_str, *size_str;
 	char *file_address;
 	size_t file_size;
 
@@ -236,10 +237,16 @@ static int do_ini(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_USAGE;
 
 	section = argv[1];
-	file_address = (char *)hextoul(argc < 3 ? env_get("loadaddr") : argv[2],
-					NULL);
-	file_size = (size_t)hextoul(argc < 4 ? env_get("filesize") : argv[3],
-				     NULL);
+	addr_str = argc < 3 ? env_get("loadaddr") : argv[2];
+	size_str = argc < 4 ? env_get("filesize") : argv[3];
+
+	if (!addr_str || !size_str) {
+		printf("ini: loadaddr/filesize not set\n");
+		return CMD_RET_USAGE;
+	}
+
+	file_address = (char *)hextoul(addr_str, NULL);
+	file_size = (size_t)hextoul(size_str, NULL);
 
 	return ini_parse(file_address, file_size, ini_handler, (void *)section);
 }
-- 
2.43.0

