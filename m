Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200A8CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854DD84884;
	Fri, 12 Jun 2026 19:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CuIy/3lE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6786839A8; Fri, 12 Jun 2026 17:05:07 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142308484C
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 17:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=erich.e.hoover@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-69de16f5f79so538211eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781276700; x=1781881500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AhJsl+bo5KxEua5QBUh7LeiRgdF4kwABN0oAUfNe0uA=;
 b=CuIy/3lEVvx3HndjeykahyBpMz7Z7Oc2VzdqYifVzU6qSpZXKmaUrpaZDNPkGktmzB
 iTIyQhKMUjeqfolgU4PXtYNNUhuksgobsFvvtJySmvw/b7AnDOqTPWUmLRDMEPv3TIQ/
 Dd92aKXe5NN4c6G+3zCpYX7Z9KSSJxqKnyf1d+cgmaL5Lf5C2U+6CPozHWtIbz7I7B0v
 78fkKbRWgm0iQVueVVn6au3n5CxBg0pWdjLzPMFtzinll3FP65BKmGUSECrVcZE9P6Hd
 kuhCywgoeAkDe2rRCJ7F9AJ0efzr4HZ8ArWrWUZRkKCyhNNDk+oyKTsjSJgGyu2z2Dau
 qHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781276700; x=1781881500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhJsl+bo5KxEua5QBUh7LeiRgdF4kwABN0oAUfNe0uA=;
 b=GjUNsXQTKMY88VjYUOAJfGoceHwxkgQ+0wRbbVs4t8fBS8VevsC1iWugyUlzD2aclA
 fLZGtYQ5HzPTMCb5s+CkREmSZFUw6LSR3U+grTCf82AH8Gceh4ByCzBa2ltj3ugYnobl
 de2rZr0QTJbanOXNQTn+dqZ08js47JAsKYEzCvD2Wb/B/7+R52N7pPdBOGHectDW8LQi
 th3WHjAZzI6/aB2T7Hr0lISkQlzhnVZWS6twa/pPnWUw+oln4GKWGBBbfRcVnwv9wOVy
 sqypMa/WWjHGwVfexzbcGS3tpXSBxGhvJEJ6VFgcyky6+Td9zi0V5V5zgU17B9oTyOJN
 4MZg==
X-Gm-Message-State: AOJu0Yz7siB0Gl5GqIyUWKcVuYHM/LQAV51sb7ca+qxm1mN67VZXwhq1
 S4YymZ8DFJ9yLkyEjzpqPiM42kalLy7OaGFrkPYAxJJHdKv4tE1NaHd02+eVfw==
X-Gm-Gg: Acq92OE+Fplat/NER2JZQVCV9vr8NwMnZ+x5o1LUeGtXQCzYntpQ+WimoTZvVKgYcT2
 XxPJ6825QOrY7JVoauUYH21z3o/HHJsfLu9N16RTZ63fKmqCZZZM+D2Sb0JaS87ngcJoKG1A8OP
 NcBpo94QX2PZ3cyemB8pUK6O5XTCu72PCQF7XfqkyL0w09nOxRN5E4616sN8WPAzm1qoga5jgni
 QX+W+jEfAMN2jZNbzPnzLI0PBcZrBclwKj2l6J7kT7kFOpYzb3kNhTjt1aIpbta/IfkpZGLfTnZ
 rG+ixri4/ETgT/ft9RsGxDosJ3BIPJbieU8nmjHNZWXbZ2nbwvkcyQhA6J+f9qbagqwoYnkR13B
 Z5t02r0cWCNgiOkzbKXD0n39hsqs8obzW0mvZ89MsAYlKWFVgm0i/IuFavkWjlqjKwcmN+NHBtx
 kign1lCZc2MbEkezN2XomYtrBJWlR1ag==
X-Received: by 2002:a05:6820:2108:b0:69e:6a89:f482 with SMTP id
 006d021491bc7-69edc62869dmr2045937eaf.21.1781276700454; 
 Fri, 12 Jun 2026 08:05:00 -0700 (PDT)
Received: from af-fff5r54.. ([50.169.220.58]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed836b505sm1877277eaf.1.2026.06.12.08.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 08:05:00 -0700 (PDT)
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
To: u-boot@lists.denx.de,
	Michal Simek <michal.simek@xilinx.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 "Erich E. Hoover" <erich.e.hoover@gmail.com>
Subject: [PATCH v3] mkimage: allow zynqmpbif to use a register initialization
 file
Date: Fri, 12 Jun 2026 09:04:54 -0600
Message-ID: <20260612150454.2194375-1-erich.e.hoover@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

The ZynqMP Boot Image Format allows specifying the register
initialization file with the "[init]" attribute.  Since this
feature is already supported by the "zynqmpimage" backend, this
commit leverages that existing capability to add support for the
"[init]" attribute in the zynqmpbif backend:
https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init

This currently uses the same register initialization file format as
zynqmpimage (ASCII text hex values with each line composed of a pair
of register address and value), for example:
===
0xff003248 0x12345678
===
It is not, yet, compatible with the format used by bootgen:
https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/Initialization-Pairs-and-INT-File-Attribute

Use this feature, with other zynqmpbif options, like so:
===
image : {
     [init] reginit.int
     [bootloader] fsbl.elf
     [pmufw_image] pmufw.elf
     [destination_cpu=a53-0, exception_level=el-3] bl31.elf
     [destination_cpu=a53-0, exception_level=el-2, load=0x08000000,
startup=0x08000000] u-boot.bin
}
===

Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
---
 tools/zynqmpbif.c   | 12 ++++++++++++
 tools/zynqmpimage.c |  4 ++--
 tools/zynqmpimage.h |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1a52..50d76b03476 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line, struct bif_entry *bf)
 }
 
 static const struct bif_flags bif_flags[] = {
+	{ "init", BIF_FLAG_INIT },
 	{ "fsbl_config", BIF_FLAG_FSBL_CONFIG },
 	{ "trustzone", BIF_FLAG_TZ },
 	{ "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
@@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf, const char *data, size_t len)
 	return 0;
 }
 
+static int bif_add_reginit(struct bif_entry *init)
+{
+	/* User can pass in text file with init list */
+	if (strlen(init->filename))
+		zynqmpimage_parse_initparams(bif_output.header, init->filename);
+
+	return 0;
+}
+
 static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
 {
 	size_t parthdr_offset = 0;
@@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
 
 	if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
 		return bif_add_pmufw(bf, data, len);
+	else if (bf->flags & (1ULL << BIF_FLAG_INIT))
+		return bif_add_reginit(bf);
 
 	r = bif_add_blob(data, len, &bf->offset);
 	if (r)
diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index 4db9877127e..eb79c0696cc 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -400,8 +400,8 @@ static void zynqmpimage_pmufw(struct zynqmp_header *zynqhdr,
 	fclose(fpmu);
 }
 
-static void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
-	const char *filename)
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+				  const char *filename)
 {
 	FILE *fp;
 	struct zynqmp_reginit reginit;
diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
index 7c47dc0763b..867fc5294a3 100644
--- a/tools/zynqmpimage.h
+++ b/tools/zynqmpimage.h
@@ -142,6 +142,8 @@ struct zynqmp_header {
 
 void zynqmpimage_default_header(struct zynqmp_header *ptr);
 void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params);
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+				  const char *filename);
 
 static inline struct image_header_table *
 zynqmp_get_iht(const struct zynqmp_header *zynqhdr)
-- 
2.43.0

