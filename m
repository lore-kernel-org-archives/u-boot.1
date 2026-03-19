Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373CD1091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430E584006;
	Thu, 19 Mar 2026 22:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RmYtgKjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012AB84008; Thu, 19 Mar 2026 22:36:38 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24E983BC8
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7d50516e9so887407a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956192; x=1774560992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LWCI1Kds40oirghFAPDOuEj2brwQVpAsrKvT7MXF8M=;
 b=RmYtgKjgsendlhiiGn2frBU4iPKsrjazHG1FDAAvcZDGUVjVCNVFD6u3PzTvQo42oj
 XP598beCIwl0NK8vxiPc3rfrONwHuENooVhyOcbHiJMaWI3AsekVA3jdZjFOWamAUIR6
 n6y76HtcAmEmMkDhTuWvEiYYmzi6cGwpo362g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956192; x=1774560992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+LWCI1Kds40oirghFAPDOuEj2brwQVpAsrKvT7MXF8M=;
 b=WmTR8XvtQaFbRqB4/2r+rtprMK31I/DsieMRzxg8K+nhT4eKpQGz3LJMp0mrpGmK/T
 oAkugN9e78GmE6PbmacR40hb10+k8a5NfSPFVDFdQ5Z/GkOqCpcAc5gUOSBJK1W0TuxF
 fSYUtxmTPzju9by6XpYsZQ+LCvsZlj6MaFHyhU9mxxQMZKVjhrxtwvermI+imvphlmdb
 65UIUz7hPhPU/j33BpWB3qw0hOg6tPdvHhcrxo5OImmucAW5UQSa9E2QPDZAIW8CQSpT
 0Wrnxbn1fgPqDJ+zoNHXhHdmik8zPDX4aFO6x2E0vqKkXAJqb2dExTKNLkEfD6ujyTq2
 fG4A==
X-Gm-Message-State: AOJu0YzH9eNieHKMH/SbiCyj/qtcZk6NEzGqQQICM04FhXzfN7n2Aqfy
 VEgzg38vwCL9qVt4LUJiTCdAQ3PoUxqzpQ5x6z1VR9REzYbmjf8/ImlFCLLjDG0hCpWQpQlC/C1
 9Ozc4OQ==
X-Gm-Gg: ATEYQzyP21WwTah67//dkeiwwgBrkh8PxyWaRPDQYSL3zSgM1fJTt5Y3g5FLFR6Y+z6
 vny40i1cmULtc37OldkSzORprOaENigNfl1ZY/F9Iev9ck1eeCqOsW09NM50fIGy57+Xxv3plil
 auNsFCoxaqIsHk4LHCr+v9EzV1GFATb3kv4Zf9pu+gepHr1ICkl0pu923V517GxkDfCitK0AO5r
 zQpqSp0SwcG5sl7k7ip6+BJX6GNFvRdcwAsYmwxP6zzOVyLg86lQde8Q5Srl0q+cuEAQgoS4LOC
 hDY7R/YrtHBqH9EHgo3PrjZdZsQQfs9A6Mmc8HnIFNWnAI5OKi8377+QamPBrqFYKWvMV1EcfCD
 ejpzSIRYz3r8r5obE/+0FNPayxT8o/opNs69YQEszLyoL4OawCtOzi+7Ymwm9ZKMmoYseqOmMxw
 5Xo8l3hmfTTPJ51km7Pg==
X-Received: by 2002:a05:6830:81c9:b0:7d7:cc49:9ad6 with SMTP id
 46e09a7af769-7d7eaf765afmr490863a34.22.1773956191924; 
 Thu, 19 Mar 2026 14:36:31 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 02/15] linker_lists: Fix end-marker alignment to prevent
 padding
Date: Thu, 19 Mar 2026 15:35:32 -0600
Message-ID: <20260319213551.267031-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Change the alignment of end markers in ll_entry_end() and ll_end_decl()
from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
to __aligned(1).

The linker places zero-size end markers at aligned boundaries based on
what follows them. When the next list's start marker has a high alignment
requirement (e.g., 32 bytes), padding gets inserted before the end marker.
This causes the byte span (end - start) to not be an exact multiple of
the struct size.

The compiler optimizes pointer subtraction (end - start) using magic-number
multiplication for division. This optimization only produces correct results
when the byte span is an exact multiple of the struct size. With padding,
the result is garbage (e.g., -858993444 instead of 15).

By using __aligned(1), the end marker is placed immediately after the last
entry with no padding, ensuring (end - start) equals exactly n * sizeof
where n is the number of entries. This makes ll_entry_count() and direct
pointer arithmetic work correctly.

Fixes: 0b2fa98aa5e5 ("linker_lists: Fix alignment issue")
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/linker_lists.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 2bc5326f681..470dcfc621a 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -145,6 +145,20 @@
  * Since this macro defines an array end symbol, its leftmost index
  * must be 2 and its rightmost index must be 3.
  *
+ * The end symbol uses __aligned(1) to ensure it is placed immediately after
+ * the last entry without any padding. This is critical for ll_entry_count()
+ * to work correctly.
+ *
+ * If the end marker had a higher alignment (e.g., 4 or 32 bytes), the linker
+ * might insert padding between the last entry and the end marker to satisfy
+ * alignment requirements of the following section. This would cause pointer
+ * subtraction (end - start) to produce incorrect results because the compiler
+ * optimizes pointer division using magic-number multiplication, which only
+ * works correctly when the byte span is an exact multiple of the struct size.
+ *
+ * With __aligned(1), the end marker is placed at exactly (start + n * sizeof)
+ * where n is the number of entries, ensuring correct pointer arithmetic.
+ *
  * Example:
  *
  * ::
@@ -153,7 +167,7 @@
  */
 #define ll_entry_end(_type, _list)					\
 ({									\
-	static char end[0] __aligned(4) __attribute__((unused))		\
+	static char end[0] __aligned(1) __attribute__((unused))		\
 		__section("__u_boot_list_2_"#_list"_3");			\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
@@ -239,8 +253,12 @@
 	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
 		__maybe_unused __section("__u_boot_list_2_" #_list "_1")
 
+/*
+ * ll_end_decl uses __aligned(1) to avoid padding before the end marker.
+ * See the comment for ll_entry_end() for a full explanation.
+ */
 #define ll_end_decl(_sym, _type, _list)					\
-	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+	static _type _sym[0] __aligned(1)				\
 		__maybe_unused __section("__u_boot_list_2_" #_list "_3")
 
 /**
-- 
2.43.0

