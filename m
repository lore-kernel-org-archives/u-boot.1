Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BF3C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 11:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 941B040B8B;
	Fri, 18 Sep 2026 11:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Sgn4EbXBDlJ; Fri, 18 Sep 2026 11:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9859040B70
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789731885;
	b=kq/yPPSmBRl9V6+9wPKMO+UlTu5tFUUYouyor2Olk+6faSmrastqm/fKJ24uiW1pzq7N
	 UVF5MpvGa/D0XZrdeRbwagLdh3EJAXhpWKpr5JmCq73knwIgMn69Sy1bSficbMhpnh2gJ
	 1zkI2xgJ1CWDUgrwSPa4d43uNc/6CPXkMZCqETdNNywRRYMhUnW7TnMuvmLGuUOxVrouT
	 fUhttyVPfFzqqz9UIeBHEZPLx8CZEMtjPWxBDW7AK/IP8vf4JMxS+S17DqTUY6Y5+zbD6
	 FJCopaq5Rd6/YXGNCRVPixqEvQLk0xSnumuU2hjKtDPrP27bEGB8OHn7NjExUQmwltg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789731885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gshPwPu6JfuGJX4aleAzBclT1rNrOjmz+/S+4I77nMU=;
	b=T4tfwTjajTjjgMVkxH+KwUTuAz2/mSTUa8ep67vGgPavGjBlsylEjAjwFziAedT9AF3K
	 s3OtmMGxfA2SulF8UXzpwYcN/sHjYi4YDPS6q1zzFSUSTiy1z9R11ZER7qHN7ANJ2jxhG
	 Tei9//rWrTmiwQ+DgTJqntn2tdQSQOAh8O+TmdcThNoydbFQfmis6IuhCQe/cbF3IVvFS
	 DlxYFCALHwsg+Oh0Svi+HCwHHJuns15JWWA0G3Ca31xZy/gmjBh+grdZbxuvpU6m/htyz
	 aSSiJqgR/c7Dbt07HrgRE9adz0rOEb36aHweKNbmrt03NoKl4CEmxIeRHSYhDbAy5eg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789731885;
	bh=gshPwPu6JfuGJX4aleAzBclT1rNrOjmz+/S+4I77nMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVvjwqLOkgR+mLRUce3THF3UbI9ne40jLujmiUvYhwWMMe+U1TU0M2gbXhL9+pAGl
	 2hQmAwdTpnTY/RRc4jrgjQQJnJTQS1r11bP+c9e+8hGamgI+Y/uYJArohf8i8Mv5be
	 wiVpc3wBSPDWDYfS7k8LOfSRZeAGZtE7BZV2xFnXAXjRiWdfR1Df1cldoGfp/HqtZ4
	 KpQw1qpOkV+mOt65QZuj5xyuBYnmgATUMrjbPaueCgLc7volUsLRy/5phG1Y6J/xQ4
	 AbyiHN/wjFRw4AH3o3n92qTQj+jTQX0+e3ZicbbzfH8P2YdJ5mSbF/wkng5QLbInhv
	 SPwdJTCYdahpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9859040B70;
	Fri, 18 Sep 2026 11:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD7B342D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9387740049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqP9j01fzUit for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:44:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6639940048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789731882;
 b=tCQ6boeemWtFgLqa30pvj69fO3CMLZi9hwhDWEqwvdt0w6hXZVgmDgIiOnvxzbiAhxdN
 nAV459oteZskLGdlWtH8x6eOH0a8azpkLnluNe+AwmR5l2trwOHyV0RGipOPKHWdZCKVl
 QI9tQ+y0ncnEe2zmTvYFDAl5xCmdaKrf1PhOozGDl4KnGbcPVnoXZCwVKSykvsJfWpV7S
 ivxyhswh3aYaSwePrIPrWeFIzEKGQsr1zscPbXjpdXAZyyW4FJfKUYF6FIJ9Un1bZ5efs
 dpktgt+YYZoJtZAJf/KnJ9LNJWFePFttoHLpWbJ77WEDoB9NCNxtS+1XCLohCMurkZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789731882;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=gshPwPu6JfuGJX4aleAzBclT1rNrOjmz+/S+4I77nMU=;
 b=CXSS+ygx0OmPBGywKROoVldFRKQIEigmF7wBdZ8Df0UGFzi+7LYsRN9l9+K8WmqreNGd
 KURewneLmyKW0sjboifVUVN1/CErQb1pry/BKqlPrYZYOsKEs36STumZ8kk3QxBkjMUe1
 IIJoirAJRxQHYNp1eS5IzZj0oP67Ct7IOsWmYzu3HdmJA0AfOV0hx/x1J+GLgBxM7wN0q
 agPnkCikuSR/rqv5BWvJCAzfPDCaVJAG6wSmFxag93tgDzgfJ2YUo//VvV82vHKERM77A
 ri4bzKk3oZFAkTv2DkREpLJSn91OexNAa3XjJZr/+RTmy35xb5IQlthntPnMvMNEiwg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=YPAxASzA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=YPAxASzA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6639940048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:41 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso6099315e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789731880; x=1790336680;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gshPwPu6JfuGJX4aleAzBclT1rNrOjmz+/S+4I77nMU=;
 b=YPAxASzAa2kzu8fBT7Tznh/FzXTdDMpeN1dShJMLs0ioB0dZvyCbyKQLfeCSMkylVa
 KCbgd3UWHg1jJX/zv1JdDMyqHlhl6wXIaYorZkeICM1yIezUozqSElwJkPEOs8tZZgwH
 YJDJr9wMf1DE/5uhn3OD31+2EykThS7EQhCsYNP1K2sEu01hpGgkiIzGH4LnKop8I9dH
 A0RA7YtMaosKOsRTSXGjho1Hg8nLjtk+NJEaUQrwFyQ8diMSXjHBWE5j874lWVvkYGwI
 l3D4UunTyfgXI5T/7+v3TjH+0bP6SeeLZzKm33FYCgppDXb+Lr89Qh9FRjLoUwOHcDrY
 qDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731880; x=1790336680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gshPwPu6JfuGJX4aleAzBclT1rNrOjmz+/S+4I77nMU=;
 b=1MK0pmTVsOtLNtUfR9DPdTu6CjCs+raJYogoSJRlWMyV831a9oKreh5c/uvqpRBuOu
 eU1a4qvHlvjqBF7rdhdnSNAhZURC7U3ZEJ2jBOAGWLD7Mk+Z0KJLUhqQpZsAGLjMwh1x
 N96m9E/nQfvoSZ0+Wb9JsIaX8Vql/62d252yNkdogNDOFAdgjJbvdBUjz/ipxXq0Xpnp
 pYIam0cyGIPp13z2z+kqAmjprcvw6uJdgMjMfX21i95hdBr+ShEKcRo3zYKfSZ3+/aUO
 WKP7KAmm1Fr4kDteXu/Jy3+M+r+L7SJDMdVfPbKj+fC930ssMPxJjiEVts1ccob/2SWK
 /JMQ==
X-Gm-Message-State: AFuF++mlhzmq9vMFUp7V1arMefPjZfeG1TdttK/LGhXXlwU/JVgz+lI1
 s+C+csocsu+CwTm+x+xR8RHXOY6z91EtKHTC+IvC+W14bzOQI79NgK4roBh1exAY2/o=
X-Gm-Gg: AYBFou2Ha31f0gfgN8B0dmnsZxCWd0Xutb/NQkQRdQFdxOQIIuVN0uLuZqXk2E50TYm
 TvGgIW70bAY/A4JE29N42dj74ld5rI7HSGERpsWUmHsruj0tZ0YlzFoV11bnK7i7VB9xZpA1NAb
 Xm5J3NsLZjiSNz4j4/GAwSEI4BAE0FF6juw509UyPk6MtEslFP8Kf4MDTl0jdPPozh1Nb01wgol
 n73plkq/xYatWcBrO5g+4iEIhkXGd338AX1t4tivaogRI2YhS/ukIPIVq4jMs06ZccbRZ++j3Us
 pJe4R/z6cUcnMkx7TjnziqFUPhId20nvh6iWQWJX2SS7tl2y8vNc8BgxCi45WGmxHXH8ohhmDtx
 JuXL+YfIJA0jKvujxBzVLmC/mNZJAr0zoqOwLsR8ANbx1E/VYGxq1RANXoJgFkAPAS0mvTFjg/D
 snAibAp6f4qk5l8zL3V6Ae6W3LDdrm9Wk07xJ3YUSfwHoeDcdc7+yiMNGNMxW0T2TeCOjDAO4g8
 3Fuq94JADfCEh7ZJLe1RvQ2/m4ZVmwijc2glutsPvKt24h0X91C
X-Received: by 2002:a05:600c:46cf:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49fc5687b6cmr32614495e9.2.1789731879604; 
 Fri, 18 Sep 2026 04:44:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d46399sm63549565e9.12.2026.09.18.04.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:44:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 15:44:34 +0400
Subject: [PATCH 1/2] lib: Let the decompressors use unaligned loads where
 they are safe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-unaligned-decomp-v1-1-59909db61470@flipper.net>
References: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
In-Reply-To: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Vincent Jardin <vjardin@free.fr>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6809; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1XNm78LYUcxKxQH2e21iIMqN1LO3s3DJJnyaSTv6txk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStVVGV040RKjxgOXuvoatpbs3D8iNfAxUlPwjk6ThNu
 PCaJcm0YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKmezMDwz6Lk5ESbih3qTX83nE5a9cC7W8ewbnrs/7Cqv+WKV0r3TmT4pxPdw1O
 wtyc1vuvV8vQPNqpiO/kN1PWnc7maBj/omKnABwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everything,
because when the MMU is off any unaligned access there faults. The
compiler then has to assemble every wide unaligned load out of single
bytes: one ldr becomes eight ldrb and seven orr/lsl.

This is especially painful for decompressors which refill their buffer
in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
mode Linux kernel in 1947ms built this way and 596ms without the flag,
and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads and
ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
6%.

Add SAFE_UNALIGNED_ACCESS for a platform to state that the MMU is on by
the time it unpacks an image, and let the decompression libraries drop
the flag when it is set. The arch exports the flag it added rather than
lib/ naming it, so this stays correct for anything else which adds one.

No functional change anywhere until the symbol is selected.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/Kconfig                 | 27 +++++++++++++++++++++++++++
 arch/arm/cpu/armv7/config.mk |  3 +++
 arch/arm/cpu/armv8/config.mk |  3 +++
 lib/Makefile                 |  3 +++
 lib/lzma/Makefile            |  8 ++++++++
 lib/lzo/Makefile             |  8 ++++++++
 lib/zlib/Makefile            |  8 ++++++++
 lib/zstd/Makefile            |  8 ++++++++
 8 files changed, 68 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138e..4bac67c388a7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,6 +27,33 @@ config SUPPORT_LITTLE_ENDIAN
 	bool
 	default y if !SUPPORT_BIG_ENDIAN
 
+config SAFE_UNALIGNED_ACCESS
+	bool
+	help
+	  Selected by platforms on which an unaligned access cannot fault by
+	  the time U-Boot proper loads and unpacks an image.
+
+	  ARM builds pass -mstrict-align (-mno-unaligned-access on ARMv7),
+	  because an unaligned access with MMU off there raises an alignment
+	  fault. The compiler then assembles every wide unaligned load out of
+	  single bytes, which costs a decompressor refilling a bit buffer in
+	  64-bit words up to four times its speed. Code which only ever runs
+	  with the MMU enabled can use this to opt back out of the flag.
+
+	  Select it only where that is guaranteed, and under the same
+	  condition the platform's own code tests before enabling caches, so
+	  that the two cannot drift apart.
+
+config SPL_SAFE_UNALIGNED_ACCESS
+	bool
+	depends on SPL
+	help
+	  The same for SPL, which on most platforms runs with the MMU off and
+	  must therefore leave this alone. See SAFE_UNALIGNED_ACCESS.
+
+	  There is deliberately no TPL or VPL variant: those phases run before
+	  DRAM is up, so the flag always stays.
+
 config SYS_CACHE_SHIFT_4
 	bool
 
diff --git a/arch/arm/cpu/armv7/config.mk b/arch/arm/cpu/armv7/config.mk
index 68036d6fbdaf..b8728207f18e 100644
--- a/arch/arm/cpu/armv7/config.mk
+++ b/arch/arm/cpu/armv7/config.mk
@@ -9,3 +9,6 @@
 # of our decision.
 PF_NO_UNALIGNED := $(call cc-option, -mno-unaligned-access,)
 PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
+# Code which only runs with the MMU on may drop this again; see
+# CONFIG_SAFE_UNALIGNED_ACCESS.
+export PF_NO_UNALIGNED
diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 4d74b2a533e0..554773c8d45b 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -6,6 +6,9 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
 
 PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
 PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
+# Code which only runs with the MMU on may drop this again; see
+# CONFIG_SAFE_UNALIGNED_ACCESS.
+export PF_NO_UNALIGNED
 
 EFI_LDS := elf_aarch64_efi.lds
 EFI_CRT0 := crt0_aarch64_efi.o
diff --git a/lib/Makefile b/lib/Makefile
index b7272c6f0cba..d8503d16cc6d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -93,6 +93,9 @@ obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
 obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
+ifdef CONFIG_$(PHASE_)SAFE_UNALIGNED_ACCESS
+CFLAGS_REMOVE_lz4_wrapper.o += $(PF_NO_UNALIGNED)
+endif
 
 obj-$(CONFIG_$(PHASE_)LIB_RATIONAL) += rational.o
 
diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
index 09380074b3df..769d44901f7b 100644
--- a/lib/lzma/Makefile
+++ b/lib/lzma/Makefile
@@ -10,3 +10,11 @@ ccflags-y += -DZ7_LZMA_PROB32
 ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -DZ7_LZMA_SIZE_OPT
 
 obj-y += LzmaDec.o LzmaTools.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)SAFE_UNALIGNED_ACCESS
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
index 45612a83dabc..7909e9a3585d 100644
--- a/lib/lzo/Makefile
+++ b/lib/lzo/Makefile
@@ -4,3 +4,11 @@
 # Stefan Roese, DENX Software Engineering, sr@denx.de.
 
 obj-y += lzo1x_decompress.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)SAFE_UNALIGNED_ACCESS
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/zlib/Makefile b/lib/zlib/Makefile
index 4a3e985a9494..6559c5cf7d2c 100644
--- a/lib/zlib/Makefile
+++ b/lib/zlib/Makefile
@@ -4,3 +4,11 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y += zlib.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)SAFE_UNALIGNED_ACCESS
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index c9a7dfe405b4..1194a1d86445 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -35,3 +35,11 @@ zstd_common-y := \
 		common/error_private.o \
 		common/fse_decompress.o \
 		common/zstd_common.o \
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)SAFE_UNALIGNED_ACCESS
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif

-- 
2.55.0

