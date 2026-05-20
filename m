Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4DECD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF48A848BC;
	Wed, 20 May 2026 02:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9KlwmH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0717848BB; Wed, 20 May 2026 02:12:44 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A72848AA
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-41576c5c01cso3041199fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779235959; x=1779840759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ck+FVhpVOyk6+Z2FUhxYv+lgZGIG2IxZ9+N7tf2C0uw=;
 b=p9KlwmH+b4HQ4wW12RsZoLaGEbPNdDGqpWy3EycL3zh/t+7t10Wuri3eHb0/o9tW8J
 c1M+Vi5vzLE4G2EKVGdUN6wGSPmuFh7J/O45ZMzu1Qt6sG4CJnPvzyIx22pGs3MWsFPO
 4IU+xCGwO1TI4QavzwPLmOUN8SkT4VEzCFG5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779235959; x=1779840759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ck+FVhpVOyk6+Z2FUhxYv+lgZGIG2IxZ9+N7tf2C0uw=;
 b=eG4jt2W3XR6dHl4tjGjptQxa3XL6qXY/orhkGvfEb8a8z0wBRUQYOQ3duSVAPdR+pD
 g5wZrzjnh0ILwSyNt0TKKUKKf44n4xIhHDRnT1d5WmqFyFbmU/HKiwutfcClGmlLHLA+
 6l+D6oybMeNxvi56WuDQXblEo7VX5BcWHk/FlAbq1gXwiO511c0xv6Jh+Iq/wpCzdQok
 4ktEmQo6R23jHIQ8Lc1itsrmlmNPmNFapt/zkI8aziTECT6RdmKgzKJG7x4Lmsmbw76d
 EfFqtTlcucP5CDR23yvr0B7hvtU7+hxEBq1xwW3RJu36oD5qn4fLHXRIFtyIPf1yTEaw
 NXgQ==
X-Gm-Message-State: AOJu0Yy6jZad8WKC+CI63leB9d0uvPfiYvKh/1NfIlxq59UdttLbC+sg
 2D+jz7CMQwTrMXyCvNkgT3Ec0eD/fMC8tQq6nxOQGy0KzfaWg6cVCTcC+thPJEiT/w54hZPt+s5
 yWqdhp5wOZ4qK
X-Gm-Gg: Acq92OGRsTvEhzJDcgCjoXdxk54W+sOn2Zw1CSDvdY5XqDos1CL0QEYHzYHO+H05bRs
 bw87IzkD0UHf/tQVqUsuCPyDYFCLYvcM7+gzcH/RnW1P0TlskpIubrZwjLL/jcrgaGei2TwfNjE
 JDrz+DrG76tkzeZL6NKac9E9PgO2q8Zep2DhKrz3I7wESsYbYl5pzth9egYIusJr2UifmEY4jZw
 h+SutRS1ApELusBRlXnl9kr503EAV2PlzootRmmMXcqWm8NDKg7T8fw2pvlqRjx1cOdwIBcixs4
 WYc8GFITPE6mWZPi4jP/xugHNNtOcLOrS5+aSp8KTNtLELS8XTzXFJ5HxPg6pC5kmIVuX50aA78
 j8rMn4rPaQcKPgrxyMaCyE5wUc7nNVVbo5M0nqh7mzUE1gaOQE3G+EmJeYnea59sFuNz2D+JEP5
 mVyZAsnAzpg/ao26huCYbAONKmlqNtColTixWrqMH6mHTaB4z41sVoPRfW530vvQL/ovgcPBx0x
 DnxNF/FD0sOoTTKJ9I3YPKUyjBx9wiUg8bTNUlCxvJDBjgYIPVWYdAklzHZqhU6KYq8AHlykqQ=
X-Received: by 2002:a05:6870:9693:b0:42f:beec:92ed with SMTP id
 586e51a60fabf-43a2d9a23edmr12738736fac.10.1779235959637; 
 Tue, 19 May 2026 17:12:39 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94fce014sm8859863fac.7.2026.05.19.17.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:12:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] linker_lists: Do not set "unused" attribute
Date: Tue, 19 May 2026 18:09:53 -0600
Message-ID: <20260520001234.1555120-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520001234.1555120-1-trini@konsulko.com>
References: <20260520001234.1555120-1-trini@konsulko.com>
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

Whenever we declare something to be in a linker list, we want it to be
included. This is why all of our linker scripts have a line similar to:
	KEEP(*(SORT(__u_boot_list*)));
to ensure that any linker list found in any of the archives we are
linking together makes it to the final object. Remove the places where
we set an attribute saying that it is unused, or maybe_unused.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 4425fcb67852..a8b7e2c9f2bb 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -69,7 +69,6 @@
  */
 #define ll_entry_declare(_type, _name, _list)				\
 	_type _u_boot_list_2_##_list##_2_##_name __aligned(4)		\
-			__attribute__((unused))				\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /**
@@ -92,7 +91,6 @@
  */
 #define ll_entry_declare_list(_type, _name, _list)			\
 	_type _u_boot_list_2_##_list##_2_##_name[] __aligned(4)		\
-			__attribute__((unused))				\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /*
@@ -125,7 +123,6 @@
 #define ll_entry_start(_type, _list)					\
 ({									\
 	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__attribute__((unused))					\
 		__section("__u_boot_list_2_"#_list"_1");			\
 	_type * tmp = (_type *)&start;					\
 	asm("":"+r"(tmp));						\
@@ -167,7 +164,7 @@
  */
 #define ll_entry_end(_type, _list)					\
 ({									\
-	static char end[0] __aligned(1) __attribute__((unused))		\
+	static char end[0] __aligned(1)					\
 		__section("__u_boot_list_2_"#_list"_3");			\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
@@ -251,7 +248,7 @@
  */
 #define ll_start_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__maybe_unused __section("__u_boot_list_2_" #_list "_1")
+		__section("__u_boot_list_2_" #_list "_1")
 
 /*
  * ll_end_decl uses __aligned(1) to avoid padding before the end marker.
@@ -259,7 +256,7 @@
  */
 #define ll_end_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(1)				\
-		__maybe_unused __section("__u_boot_list_2_" #_list "_3")
+		__section("__u_boot_list_2_" #_list "_3")
 
 /**
  * ll_entry_get() - Retrieve entry from linker-generated array by name
-- 
2.43.0

