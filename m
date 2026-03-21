Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90C81094478
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 13:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA8483FDB;
	Sat, 21 Mar 2026 14:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wv4BKi8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1246883FC5; Sat, 21 Mar 2026 14:46:41 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7CC80050
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 14:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-466ec4c6852so1652553b6e.3
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774100796; x=1774705596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYkPzO7CeNDfZ9cb+U3ccVB+dr3R1GF3+I5i1GIMsB0=;
 b=Wv4BKi8S2+muIuBClGvSyfhMnW9X8zNaLJtLpuIQ0Ztep+udgndVnWXvs9Xa78rB3z
 oxGQqxCwxRACecPg0TTo56yMJbd3JXag2xYJpmuERfppBweQrUV9RgGFsvE4QSojhdOo
 lRpouEitEaCHbTinb5+xS8n68jXc0QnVUfYzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774100796; x=1774705596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uYkPzO7CeNDfZ9cb+U3ccVB+dr3R1GF3+I5i1GIMsB0=;
 b=Wl1rKORuYPL50owWiPUf/rmtla+8wW+V6fjlsFdy0ZA7X0PBH2yjrDBGxuPaKYGyC5
 KMR9SA2buDW09Cj7OR2WmsRix2HwTJ2rnT7cSu0MAtAJqTJtdrbybfduqiEWLHNiOEQ0
 JUk1r69lUlsUoPETkYFP+qNBT+4mXqSFCdOZe7AfytAdN40r+bfxljMaThhRan9GJEAV
 Epli5h23z2TAphFzk0xeVfPk3CANGq/LQ2LdlkiQodEaCnz6DDGIywGGBHVQCxXNqmht
 LGp8Fb1JZtkp62QGjym4mfZpcLv8Y24n2KI9nnYQBsix3KWSiSyz2zApi54lU28lqQKY
 vVhA==
X-Gm-Message-State: AOJu0Yz8rIPtosD+mUPWB9A3nxou0hJgK/mrpW4RZRZfms+R2r//IH8M
 3fcLaMq980OMycMVaXHUGx2PhNy9Eq28RNds9F0DBJCMG/Fq0ZpClvjcl7RLGVvPHiRl0Wn/JbO
 MajhAYA==
X-Gm-Gg: ATEYQzzw1iDOGKrix+q3jiQ/g81QtsyDdkVMiCSOPBPbkq9bYsh0TnA5VSyAQqIIW3+
 esElPaa5ApdvheyDiZva1iEeMfJ6l9JV4WcpyYC/k/DfwRuywqk6MJpEF3SsW4BhKjNeJ631Ekm
 Qd4ScpZAv0hpdGRPU8qeQzwkltcvlrdGjqIxl0gEyvwiDBHuQtYtZR5SIKSRVa54UxmPrwHjzNr
 p4QvRJzVsCkQBLGLBO5AFx6vsd1X5DhcUAx7kDL9WDQikKjG5Ok6cmDTOSOxL7byuRnOXkEyavf
 tnQo3kuoL9cpw8KyA0OMZIumpr99rlOVEDsay9NkuXfjwUVbyZlhGgA9uMis0xKkILsQpsaq4hc
 SclSE9g5OSjNfc3ufADqfHI/Cjx1meRt5MqbiQ1OYesajM9mF995j9agLQxaDYQhajce0ZNOLQi
 1Za6kEWqDa1XHKCrdFOA==
X-Received: by 2002:a05:6808:6702:b0:467:697:7bc1 with SMTP id
 5614622812f47-467e5fad136mr3084816b6e.55.1774100796386; 
 Sat, 21 Mar 2026 06:46:36 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm4947257fac.3.2026.03.21.06.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:46:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent padding
Date: Sat, 21 Mar 2026 07:46:23 -0600
Message-ID: <20260321134626.516665-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321134626.516665-1-sjg@chromium.org>
References: <20260321134626.516665-1-sjg@chromium.org>
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
requirement (e.g., 32 bytes), padding gets inserted before the end
marker. This causes the byte span (end - start) to not be an exact
multiple of the struct size.

The compiler optimises pointer subtraction (end - start) using
magic-number multiplication for division. This optimisation only produces
correct results when the byte span is an exact multiple of the struct
size. With padding, the result is garbage (e.g., -858993444 instead of
15).

By using __aligned(1), the end marker is placed immediately after the
last entry with no padding, ensuring (end - start) equals exactly
(n * sizeof) where n is the number of entries. This makes
ll_entry_count() and direct pointer arithmetic work correctly.

Fixes: 0b2fa98aa5e5 ("linker_lists: Fix alignment issue")
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 include/linker_lists.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 0f4a2d686e2..6a018f175ca 100644
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

