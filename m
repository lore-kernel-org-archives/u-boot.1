Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7B606D803
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I93Zt+Cf;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LF5LXZiy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61063606F1;
	Tue,  3 Nov 2026 04:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pufFqDthrt0J; Tue,  3 Nov 2026 04:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 478A4606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793680842;
	b=qVuKdhak27bD7SYuKp2u/+2n0ZlBxM5248Vz9Us/j+ouTe2JTupOy4zJBep13AlYx6No
	 9S14GHqJRH4F0wnRwipeshnNDZvagavkXZMDTWKKeOF3lILPrxFgZbHTYISDft2QihqYA
	 DyBF4g5jMSs30MkkenbwMXpbay0dYIj6wPtAyn5BOAQ6oFWG3ADaT0/atmjnwpUnP9Khz
	 RZuLp8UQEmqku5f6Ithn6Jpiv+r+IlI9804KzPiWsr7QAgTf6wxcmp09evr6Vo378Vz9X
	 0qppFhYRz7mVTel0OnbjiYFNVNWBMLnQ0wL2zjLrquukw5kcrN1+wLVMsBrq/l1dB+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793680842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CTDjppimiNO+UePyGRZKr9N4T79d1ksB32Hlhq3GgQ0=;
	b=juDVRZenf7mhwWcyAy8RRB+7ImKGXxlslzm7NetflWmgjJpNNY2SyTGgjZK6agjTf3ys
	 8E7ydiLJycg20J+V9ko3gtcNi38xqwRMjvJnrKpDn0sS4qLiLEsJ+RQrrwpHMXAGw3N1A
	 zEEymx/6xIkCH5J3BgDBDPc0113manDwkeWRDCmhW0Gm9w05ke7HRv6dh9F7Q8hrGE+aB
	 KSlfmE96NR26uOqmwn++zwBHNafLBzE5RlL3y2suv+hD+ewuXKkqjzawv9PV2q+3YG244
	 m8YYJosnXTj7RKA79q5lv5BCFSJeMTO5aMJZaohQGqNcsfZuDQmCEbOTHvDUy9ELhBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793680842;
	bh=CTDjppimiNO+UePyGRZKr9N4T79d1ksB32Hlhq3GgQ0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I93Zt+Cf1wV2272AHA2mulAW2Tpb5bpyR9fMZzjd1nlirvLO3DOOcLOE6FQCHVKSy
	 5Gyorv7zUN+FouV52JC8ZbKL/H3xoezDKyVnypfaLXWZIFqQgSzTZJURA7jzsjjwwG
	 HF8D6A+5fnIuIVLK0kdjJ95xbBN5wEqawd62NoYCO90S7aqHYBl7v7Xio6mPS+KMKk
	 aMsCoHshHGTUKWuXdcPXYRn8rWZgDYyGrvOY32NoDv8GiQ82m6wAhDsFsdfQ6f3pJl
	 sorvc2fWSPt46HXTbzJyx6dIDd0drHFz+fgSjBlvMoi+jjNhkDFToHnFd4BY1Q4z93
	 jn/9PeNExwY2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 478A4606A8;
	Tue,  3 Nov 2026 04:40:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F46E235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10D9A80DA9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvHXYWqNZhx4 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 04:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FFC880D7C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793680840;
 b=ruiFMhQ+yG/LcRb0Po7QXnPcT/Gd1q4PBPqbPLBiwzHkteAHnAapbBgeHUcbZ9WU7Hbw
 /AmBc9lBzf74PGCRho5ANhySZLBbl6kvUFcrT6RLkdqJScmc+PMqXJvwVfSCFMnsogOBH
 0bPGNkzo+KqqNyA5Pi8POg3lrQRo5UHgafj0Ov+CLlqA12FBLYnRCp0Z+5iexKOffL5d5
 IygcLO7LKaWKTB2paNtegovKf0IvDUGMy9eQP2ep8x4KQXNpYpAsSYuhsGuq3EBdx+ROU
 2LUTGjrrxi7rZIIeOEEG//+1DUf5puVC7jEiVuUbuqHDoI48EYxczPM57zATFxf5Upg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793680840;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=CTDjppimiNO+UePyGRZKr9N4T79d1ksB32Hlhq3GgQ0=;
 b=CbglngiNRuyyG9to2/rR+P1sdM7i3CslO51kDylVKlANNtRfwawiP/YYJFQz4vEdd4yR
 VARbdEtC141giCjyonHL2ghW/kbJVkolySSYgAj0QLZF4/C1zrZpVM6EiND3L44WYg9AN
 3Vt6p8BxCMDVl/tzpsgkKwBeqw9BTetpFaRLKuEUZjXG2vxJa3aOaBsiLUIITgoiZVOQv
 vJoWtKBB2V2eq0E9lHqg6XiLNhw8zC+u3POTbLgfJ5DPjb13AdKvz4x2p1xzm3o3pygtq
 XQZ4zSSj3RJzjv+2bTlT2CZpicNac2OMNfvlOridtnMJn6aIp/oe465aRT+rAf9Xmdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LF5LXZiy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LF5LXZiy
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FFC880D7C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:40:39 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-843ea301d60so2688696a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 20:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793680838; x=1794285638;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CTDjppimiNO+UePyGRZKr9N4T79d1ksB32Hlhq3GgQ0=;
 b=LF5LXZiysU+Y4HFbz50o3T48vmF9Z+ySU8LPyvzALmT4CGkI5L0SkRo8yqNdtf2XJ6
 mt7d7S3ueI0xtbIxGs3zQhK8+UisrYDHJHuDZUamSNCSs6/yu5tVHuoZyesfwwjrmGON
 5E4y5ohGH98a3kO6aiaGa4tdPAToSKQ6GBKG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793680838; x=1794285638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CTDjppimiNO+UePyGRZKr9N4T79d1ksB32Hlhq3GgQ0=;
 b=A7+619Fth6kujR+8liwmpxvP/eQ+KSySZqJodW+TYr5zeCuq+adkJ1GF7Zr6UtN2En
 UgEhvcuNYQAVMVUHrsmTk4xD3EW07ZEoUx5IoWf956Nlk8/VJqPBCEVnF4rP3BfVK0gu
 1azzh3851Fb+N2ynCCXiLZO0tX52lslaxljuP93U0lExgTJVC3oGlUYOZVkYhjEtJDbG
 LPI+kPGjXqFgWfp76CLwJCG7C8gIhywRhl0vA3wn+NNo0Wcy6lbAD2Oq6prrc4vDFu1l
 /b5rjJuS5fLUnbRjEcPp8BBeJdi+8Cp/M8POOvLI1pnu3Y15BmSB14tpXTLrQg47p6Zx
 AtDw==
X-Gm-Message-State: AFq9FYLLL6PTEaC/m6u4mZIQpzvoZqzqJ3pEOETu7iGEMzeO9QkgR9V4
 i0uKNYiU/9myImsTJnl1dbma0YOk9B6suFxbI6ZTuH7KqJror0080qEk5kwfVn7wA8PX0wCodvR
 mCNZm+8VxXkAC
X-Gm-Gg: AYBFou0+6+vUaDXu9wKF71b9Hkz6hjy4FKDVewpoufV9hcMNMUETsnKRPVVNhR161B7
 BgINJB0p/7Iej1E/l0MLxzOWZB6bgerldHAZ5GUG6aj90E4tuTfve6F+6JN+PWtsE5V10NH7QX/
 E7nocKoNaMXP77F617H0KDEzSteJgeXYUfP6ymENbrSjEKH+1Mr35tvizKyhNX6FOEDf6Yuza9y
 UD0FhBcv6PFibnF4vsd0EHuLGhrK4Ce1tbgqsLqSkQB8q7XSFGrB4eyDX+3ixyHaG1ikK4mRQQq
 K4ypTz7DezaXASaNaKk72JHXBhzKqSB8bFmIxM4KNlkfog5IYtOYRJBW/3R7JLiFuMBPeakinTd
 okymZFzwvMstHstsj0wxW9F06yj/z+RNigTidxf8BkV1qk+1l9IACnTQg7ycIMnyZNUKxR93OIb
 5Hm+cPRf+PwiMePelYaWiacfHKjQFBNoYaVQTCvyMWZqbliv4b7xOpUgXG8b9PG9DjHjSKY0jFY
 YXcWMWDYrR1ZjtAGIEwtoMl3zNDwSpZpyN0BGy8g38kfNZhhSj97yxVCSeK8yGN2Bf16q7NnbjH
 0J6L0hn8LAdDZ1quRtYFKJXnUF5H7j4ZPf6NE70bmyXqgZDtHwA918PSejqPklOkHn9NwgEx6l5
 ClHo0zmwKipMRmSIl+qawfy3ej+z3njUPxNU4RJxt/+9Fo6Et0qUqZmrfdg1Vw+gMtbFBW9V9+W
 mE5t4RpmGKyqm+3EaUvkUqjlAw+bhhOQEv5BKMqtdWIJaO2tfiMlOcZZs=
X-Received: by 2002:a05:6830:640e:b0:844:d703:a2a8 with SMTP id
 46e09a7af769-85d36561053mr8678342a34.16.1793680838486; 
 Mon, 02 Nov 2026 20:40:38 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b875sm11099674a34.5.2026.11.02.20.40.37
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 20:40:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] lzma: Update LZMA SDK code from 25.01 to 26.05
Date: Mon,  2 Nov 2026 22:40:36 -0600
Message-ID: <20261103044036.618125-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to keep future maintenance at a minimum, as it has been around
a year since the last time we updated the LZMA code, update it again.
This brings us in line with the 26.05 release and there are few changes
here which have an impact on us.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zC.txt    |  4 ++--
 lib/lzma/7zTypes.h  |  7 +++++--
 lib/lzma/Compiler.h | 43 ++++++++++++++++++++++++++++++++++++++++++-
 lib/lzma/LzmaDec.c  | 18 +++++++++++-------
 lib/lzma/Precomp.h  | 14 +++++++-------
 5 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/lib/lzma/7zC.txt b/lib/lzma/7zC.txt
index 10d3f4792f16..5bfcdfc9000b 100644
--- a/lib/lzma/7zC.txt
+++ b/lib/lzma/7zC.txt
@@ -165,8 +165,8 @@ Memory usage for archive Decompressing:
      - Memory for LZMA decompressing structures
   - Main pool:
      - Memory for decompressed solid block
-     - Memory for temprorary buffers, if BCJ2 fileter is used. Usually these
-       temprorary buffers can be about 15% of solid block size.
+     - Memory for temporary buffers, if BCJ2 filter is used. Usually these
+       temporary buffers can be about 15% of solid block size.
 
 
 7z Decoder doesn't allocate memory for compressed blocks.
diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 89f40f2a66e6..44b5c0076952 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* 7zTypes.h -- Basic types
-2024-01-24 : Igor Pavlov : Public domain */
+: Igor Pavlov : Public domain */
 
 #ifndef ZIP7_7Z_TYPES_H
 #define ZIP7_7Z_TYPES_H
@@ -46,8 +46,9 @@ EXTERN_C_BEGIN
 typedef int SRes;
 
 #ifdef _MSC_VER
+  #define MY_ALIGN_IN_STRUCT(n) __declspec(align(n))
   #if _MSC_VER > 1200
-    #define MY_ALIGN(n) __declspec(align(n))
+    #define MY_ALIGN(n) MY_ALIGN_IN_STRUCT(n)
   #else
     #define MY_ALIGN(n)
   #endif
@@ -58,6 +59,7 @@ typedef int SRes;
   #define MY_ALIGN(n) alignas(n)
   */
   #define MY_ALIGN(n) __attribute__ ((aligned(n)))
+  #define MY_ALIGN_IN_STRUCT(n) MY_ALIGN(n)
 #endif
 
 #ifdef _WIN32
@@ -532,6 +534,7 @@ struct ISzAlloc
 #define Z7_DECLARE_HANDLE(name)  struct name##_dummy{int unused;}; typedef struct name##_dummy *name;
 
 #define Z7_memset_0_ARRAY(a)  memset((a), 0, sizeof(a))
+#define Z7_memset_0_VAR(a)  memset(&(a), 0, sizeof(a))
 
 #ifndef Z7_ARRAY_SIZE
 #define Z7_ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index b1d682e19aa4..0be04f9cc3e3 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -55,6 +55,12 @@
 #pragma GCC diagnostic ignored "-Wexcess-padding"
 #endif
 
+#if defined(Z7_APPLE_CLANG_VERSION) && __clang_major__ >= 21
+// warning: function MyAlloc might be an allocator wrapper
+// clang in xcode: clang 21.0.0
+#pragma GCC diagnostic ignored "-Wallocator-wrappers"
+#endif
+
 #if __clang_major__ >= 16
 #pragma GCC diagnostic ignored "-Wunsafe-buffer-usage"
 #endif
@@ -71,9 +77,14 @@
   #pragma GCC diagnostic ignored "-Wreserved-identifier"
 #endif
 
+#if __clang_major__ >= 22
+// for "StdAfx.h" and "Precomp.h"
+#pragma GCC diagnostic ignored "-Wshadow-header"
+#endif
+
 #endif // __clang__
 
-#if defined(_WIN32) && defined(__clang__) && __clang_major__ >= 16
+#if defined(__clang__) && __clang_major__ >= 16
 // #pragma GCC diagnostic ignored "-Wcast-function-type-strict"
 #define Z7_DIAGNOSTIC_IGNORE_CAST_FUNCTION \
   _Pragma("GCC diagnostic ignored \"-Wcast-function-type-strict\"")
@@ -114,6 +125,36 @@ typedef void (*Z7_void_Function)(void);
 #pragma warning(disable : 4464) // relative include path contains '..'
 #endif
 
+// #define Z7_ANALYZE_MODE
+#if defined(Z7_ANALYZE_MODE) // && defined(Z7_MSC_VER_ORIGINAL)
+// for -analyze switch:
+#if _MSC_VER >= 1900
+#pragma warning(disable : 6001) // Using uninitialized memory 'ps'.
+#pragma warning(disable : 6031) // Return value ignored: 'CoInitialize'
+#pragma warning(disable : 6553) // The annotation for function 'RegOpenKeyExW' on _Param_(3) does not apply to a value type.
+#pragma warning(disable : 28159) // Random.cpp(21) : Consider using 'GetTickCount64' instead of 'GetTickCount'
+#pragma warning(disable : 28160) // ProcessUtils.h(92) : Error annotation: Passing MEM_RELEASE and a non-zero dwSize parameter to VirtualFree is not allowed. This results in the failure of this call
+#pragma warning(disable : 28251) // Inconsistent annotation for 'WinMain': this instance has no annotations. See c:\program files (x86)\windows kits\10\include\10.0.26100.0\um\winbase.h(1062).
+#pragma warning(disable : 28286) // um\consoleapi.h(236) : For function 'ReadConsoleW', error near the end of 'SAL_readableTo(byteCount(*__formal(3,lpNumberOfCharsRead) * sizeof(TCHAR%)))'.
+#pragma warning(disable : 28301) // No annotations for first declaration of 'PNTSTATUS'. See c:\program files (x86)\windows kits\10\include\10.0.26100.0\shared\bcrypt.h(40).
+#endif
+#if _MSC_VER >= 1600
+#pragma warning(disable : 6011) // Dereferencing NULL pointer 'p->IsDirs'
+#pragma warning(disable : 6255) // `_alloca` indicates failure by raising a stack overflow exception.  Consider using _malloca instead.
+#pragma warning(disable : 6258) // Using TerminateThread does not allow proper thread clean up.
+// #pragma warning(disable : 6262) // SfxSetup.c : Function uses '32808' bytes of stack.
+#pragma warning(disable : 6320) // Threads.c : Exception-filter expression is the constant EXCEPTION_EXECUTE_HANDLER. This might mask exceptions that were not intended to be handled.
+#pragma warning(disable : 6385) // createcoder.cpp : Invalid data: accessing 'struct CCodecInfo const * * g_Codecs', the readable size is '256' bytes, but '4194244' bytes might be read: Lines: 338, 339, 340, 342, 344
+#pragma warning(disable : 6387) // MyString.cpp : 's' could be '0':  this does not adhere to the specification for the function 'wmemcpy'
+#endif
+#if _MSC_VER == 1600
+#pragma warning(disable : 6200) // compressdialog.cpp : Index '31' is out of valid index range '0' to '9' for non-stack buffer 'g_Levels'
+#pragma warning(disable : 6204) // Possible buffer overrun in call to 'memset': use of unchecked parameter 'size'
+#pragma warning(disable : 6309) // Argument '1' is null: this does not adhere to function specification of 'GetProcAddress'
+#pragma warning(disable : 6386) // myvector.h : Buffer overrun: accessing 'argument 1', the writable size is 'newCapacity*4' bytes, but '8' bytes might be written
+#endif
+#endif // Z7_ANALYZE_MODE
+
 // == 1200 : -O1 : for __forceinline
 // >= 1900 : -O1 : for printf
 #pragma warning(disable : 4710) // function not inlined
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index f509afcf31fd..323a3c8d9492 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LZMA-SDK-9.22
 /* LzmaDec.c -- LZMA Decoder
-2023-04-07 : Igor Pavlov : Public domain */
+: Igor Pavlov : Public domain */
 
 #include "Precomp.h"
 
@@ -463,8 +463,10 @@ int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
       if (state >= kNumStates)
       {
         UInt32 distance;
-        prob = probs + PosSlot +
-            ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) << kNumPosSlotBits);
+        {
+          const unsigned temp = (len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) << kNumPosSlotBits;
+          prob = probs + PosSlot + temp;
+        }
         TREE_6_DECODE(prob, distance)
         if (distance >= kStartPosModelIndex)
         {
@@ -853,9 +855,10 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
       if (state < 4)
       {
         unsigned posSlot;
-        prob = probs + PosSlot +
-            ((len < kNumLenToPosStates - 1 ? len : kNumLenToPosStates - 1) <<
-            kNumPosSlotBits);
+        {
+          const unsigned temp = (len < kNumLenToPosStates - 1 ? len : kNumLenToPosStates - 1) << kNumPosSlotBits;
+          prob = probs + PosSlot + temp;
+        }
         TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot)
         if (posSlot >= kStartPosModelIndex)
         {
@@ -863,7 +866,8 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
 
           if (posSlot < kEndPosModelIndex)
           {
-            prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits);
+            const unsigned temp = (2 | (posSlot & 1)) << numDirectBits;
+            prob = probs + SpecPos + temp;
           }
           else
           {
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
index bcdf3d57b6c8..208d35be7b81 100644
--- a/lib/lzma/Precomp.h
+++ b/lib/lzma/Precomp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* Precomp.h -- precompilation file
-2024-01-25 : Igor Pavlov : Public domain */
+: Igor Pavlov : Public domain */
 
 #ifndef ZIP7_INC_PRECOMP_H
 #define ZIP7_INC_PRECOMP_H
@@ -41,18 +41,18 @@
 #endif
 */
 
+#ifndef Z7_LARGE_PAGES
+#if !defined(Z7_NO_LARGE_PAGES) && !defined(UNDER_CE)
+#define Z7_LARGE_PAGES 1
+#endif
+#endif
+
 #ifdef _WIN32
 /*
   this "Precomp.h" file must be included before <windows.h>,
   if we want to define _WIN32_WINNT before <windows.h>.
 */
 
-#ifndef Z7_LARGE_PAGES
-#ifndef Z7_NO_LARGE_PAGES
-#define Z7_LARGE_PAGES 1
-#endif
-#endif
-
 #ifndef Z7_LONG_PATH
 #ifndef Z7_NO_LONG_PATH
 #define Z7_LONG_PATH 1
-- 
2.43.0

