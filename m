Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A2C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DBF833D1;
	Tue, 22 Jul 2025 16:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="C/PJhI73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FCD83881; Tue, 22 Jul 2025 15:54:44 +0200 (CEST)
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net
 [188.40.0.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB592833D1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 15:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=risingedge.co.za
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin.swartz@risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
 :content-type; bh=AHGjnGxittYlKWcySGXqNE6hleDq33iIdtpujNuu5bU=; b=C/PJhI73n59
 1FoX5hSbQU7NIWNgHB+q8BcYFuWSHSq56eVVviXKmOr9HpuY2lgqPx2Wj6kQ9BtPo6vfgF7A9Pq/r
 esfE4LWW0xzY+Vv1DiDm4A7WQ6mIgFsbcGL1NeWTpR8ltGrdzFt3sRsdOyIYtUxSVEo12AxOG6xxd
 V8W+jZpX/ZOnEN9L5exM4+ySwp0ANOxQgZbC1mwAS+Ibtl/kDjTdi7a7RBxA/BsQWhg8Smg4X9Y+h
 pkWwMh32MzRxH44NRXDZlVEuxZKNncoB9y5pNx0YogR7oGl9sIV4gUPDRooc0b34ucG+GIejYdW6f
 DBKvno1lt/+uJVhytbzAV1w==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
 by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1ueDRz-005eCA-40; Tue, 22 Jul 2025 15:54:39 +0200
Received: from [41.144.2.53] (helo=localhost.localdomain)
 by www31.flk1.host-h.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1ueDRy-00000003RSp-03VW; Tue, 22 Jul 2025 15:54:34 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: u-boot@lists.denx.de
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
 Paul Burton <paulburton@kernel.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] tools: mips-relocs: replace format string introducers
Date: Tue, 22 Jul 2025 15:57:17 +0200
Message-Id: <20250722135717.23574-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net;
 auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00815358190188)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXbVQ2y89Ej31Jsoe2sMHdZx0M9cpFLZz8W
 iYPQUqIJJSu2SmbhJN1U9FKs8X3+Nt0Io1idSgCc/506nnISAkPANvJkKIxakGlbxi+ggiqZlxxH
 xN7wu8yGEPLNcyeaFTimWd0gHzicRkeLzaY2iWlQBMmyNbDn7R5kilAhwr3KtFb3AgNUGvQRnUF+
 Lycvfx+SVUSshQka8VpEeqGYZUq9BEKUHUh+o23T17Z8FzSSbYhSnw9YyoGHx/ukuag1WKBLWDaO
 GAC1PCRtpOZuVuRfKVFCXTS2zVmMeFsPQMyMp5ya4EnB7foI3WDAWEIqQR42kI22V3+6/8VpCe4k
 l4rBoCO4qTTFh+YfFhnsJKW+4WQB2ErbcicDbPONrkjWuIPYD7NLT3TvBNLPf1+s3ESe+GGIqRjk
 Mz2jvqlQOSgIbcgz0HNfKMPpYLUBoJLBZM473FsBbmn1SsxaWqlk2435fDC4fySc02qaglFpLg1X
 2hblwT4t6Zt+MG3QQNSJA0JSgc4/bCH0+M5hjXWELwokuc0ynZ2y/sQQydN8uz69TTUfYhypUdmn
 v7T0wUDBJSZEfT4JaFpc+VVXp0OmaZnMdG1PtdRqD7Jd8GbKOOuRMLqj3OyESjjTvtbrvZR7kARZ
 vd1k7AMVUvw4r/dmrv4vMEE6KEyh19rc7LZU5nlp00E9AF8MLLwL1tNRRLIRoqE82PoTcvBu1/AJ
 6a2PD752aNKDJcKrHGHNyX4iKswOKTkP1LZlYL4u6bminU1Aio1ak3irkd3hmTMQJN8cbabtNuKE
 jcETInYvy2arHHrALAeYUOp7A73HI6oJg7w/VocgiHcPu5TYEjs5rlUq+VlOjd12v0hRQV2TuWFK
 PYIZhUZZ5IHkEERSMjYwbPKoHDuE6PQyPXsTcrHl0btzNF5EM31bDVNg++RcGyQTFe0r7osqOIT6
 KKW6hPfrpT3PQJH6TTqG8F7sfMNZeKCgZgXUXPWlFdaGOH191uXjgjQN/Tw3RfSuIOnwkxaJgF6h
 VufGMxPH3hYpjFr4+tMVw5gJHYzR/YCt8xmd39Nt8Zogu0M6Oo8fr3pIQE+Tur0xNxB7xCyE861z
 MUJxzRYaKbk/UiYB5xQclnoueWR07uWqpRsNbqNDT4Kf8NfG1XHwpAgoggaqweLzJh6Y5sesEwwc
 t+ub+t+wV7HXoVlJngQwgg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net
X-Mailman-Approved-At: Tue, 22 Jul 2025 16:04:08 +0200
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

The statement that prints the ELF object type value assumes that "%lx"
(long unsigned int, hexadecimal) is suitable for printing a uint64_t
typed value. While this may seem to work for some machines, ie. amd64,
it isn't ideal on a 32-bit system, such as x86 where uint64_t is likely
to be equivalent to a long long unsigned int, as indicated by:

  ../tools/mips-relocs.c:275:34:
  warning: format '%lx' expects argument of type 'long unsigned int',
           but argument 2 has type 'uint64_t'
           {aka 'long long unsigned int'} [-Wformat=]
  275 |                 printf("type 0x%lx\n", ehdr_field(e_type));
      |                                ~~^
      |                                  |
      |                                  long unsigned int
      |                                %llx

As the ehdr_field function-like macro expands to a uint64_t value,
it is better to use the PRIx64 macro in place of "%lx" to ensure that
the correct format string introducer is specified for the actual type
hiding behind uint64_t.

A similar issue is also present in the report of .rel section overflow,
where "%lx" is used to print a few size_t typed values, and would be
better served by "%zx" instead.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
Fixes: 963014641117 ("MIPS: make size of relocation table fixed but configurable")
Fixes: 703ec9ddf965 ("MIPS: Stop building position independent code")
Cc: Paul Burton <paulburton@kernel.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
 tools/mips-relocs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/mips-relocs.c b/tools/mips-relocs.c
index 5db610f5c77..e9234a74f51 100644
--- a/tools/mips-relocs.c
+++ b/tools/mips-relocs.c
@@ -9,6 +9,7 @@
 #include <elf.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <limits.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -272,7 +273,7 @@ int main(int argc, char *argv[])
 
 	if (ehdr_field(e_type) != ET_EXEC) {
 		fprintf(stderr, "Input ELF is not an executable\n");
-		printf("type 0x%lx\n", ehdr_field(e_type));
+		printf("type 0x%" PRIx64 "\n", ehdr_field(e_type));
 		err = -EINVAL;
 		goto out_free_relocs;
 	}
@@ -394,9 +395,9 @@ int main(int argc, char *argv[])
 	rel_size = shdr_field(i_rel_shdr, sh_size);
 	rel_actual_size = buf - buf_start;
 	if (rel_actual_size > rel_size) {
-		fprintf(stderr, "Relocations overflow available space of 0x%lx (required 0x%lx)!\n",
+		fprintf(stderr, "Relocations overflow available space of 0x%zx (required 0x%zx)!\n",
 			rel_size, rel_actual_size);
-		fprintf(stderr, "Please adjust CONFIG_MIPS_RELOCATION_TABLE_SIZE to at least 0x%lx\n",
+		fprintf(stderr, "Please adjust CONFIG_MIPS_RELOCATION_TABLE_SIZE to at least 0x%zx\n",
 			(rel_actual_size + 0x100) & ~0xFF);
 		err = -ENOMEM;
 		goto out_free_relocs;
-- 

