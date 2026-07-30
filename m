Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B1C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCF3240D39;
	Thu, 30 Jul 2026 18:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZmawMvIofP2; Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF0AD40D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436886;
	bh=ICDvOYP9gh7GOQ+auoaZDpAsIzsirKtadKSA+jMf9gA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0FOoshtawyuW81U9uHmW+tf3TI90nNcDDUp7OP+O1KINAitvtnSzsMPjJUHKpKkh+
	 xv+7fbGhCvi1m9iQeuOe2S7gn9J4JABM6YVZukgd71hY//iuONrWZshuGKnPY1GRi1
	 v3R/gF2xPPGoUpo43E/B1t6zjswx6pgG1bskCoAWG7g30FCYYrSGdhuakgwQMJLaRC
	 ONx4rvG0JQUcM2LsiSx2hrWckm6AWY0KfddpZZSnyjlWmGIZbpnv0O7tOgjYKpTTs3
	 2T6UR8novfm08DozgQFU+YYh9aJgRZn1OWohJwHLcCtWxdI1U7P/KMOVaMYHpiSCPb
	 MVtLT4fj9yMag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF0AD40D29;
	Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3295352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A22BE40D00
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nBfAf3-Lfv8f for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E34F40CE3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E34F40CE3
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E34F40CE3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:22 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so25135e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436880; x=1786041680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICDvOYP9gh7GOQ+auoaZDpAsIzsirKtadKSA+jMf9gA=;
 b=N11pDBVtPutqHc/4JaS1THhvLf3u3CTcabiVAZIUPPV053c982da+eXUHtdjFd6nZT
 Z9bFDLf8srpIJSZDIgtI2OZ6eEojJIMoBinBMO1r3ES7dxz2rk7DT8I0MTbmQUmL5C2q
 SXJNbrhwynDXJiqXkXorlsq94eBsb2OgW2odxed3gou2bxHQYiQ4tQnZnlsv4InOG0cY
 mwtQD5Gory8vOi6n9uoa/lPgStXWZqHlVYOvRiuGTiIILKd5RBC02bfQoKlkNcSoDMON
 ESB2XVmtKzpGrT6yREyN7+/0p4eaAxO1v+Q/kv6nnCO2UbXgl/MYSquYT6RS+7+n82t4
 MScQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZN/bf7qEE13Wa5i6gW/Z4GF1DlkXxs5oBD/l1+aqVLDFtqfO7tZcfJNptSZUQLBr0zSjYzgM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yywz9LEMDk7yBaknFQegWJ5VL1zIHXNIvOsoL8ahZ0Vh3S0PRg2
 ZsRzBCc+5imTrDmi8fG7XKMYqNFdGPm/Vogr7s1oJZTlIZu4rUL6JDqNMxvh7SkIC60AOnci0sQ
 u+werRj18Tg==
X-Gm-Gg: AR+sD10dIn7pWX0b9LjxpSN5wD/Q4XOooB5sq057UCfzYPg9akiPufidgF4xE0+q6Vj
 kupTLegq5G8B2rGeCemT/x0R/vupitdYPA76DIkHxC2BYViJLY3c60xClvL1Z33r/mN6Z9ANeyK
 a+RdvyAHC2Xe8GszPJf5zW160xJIALc/quFD4FVi7myOd8ix5ODDA9Wy2i/Na56UEmjQzbUF6wI
 bKYl8gkavCkxuWEYNkGEEII60LPd7Cke2456wX9YZ8fOBCJNHsj6gW0+DyUcWXEqX/DF6S2nXZ2
 25UIkiPG+pUCxvxDNM49u9gtCJm/WxjYJ+476fEHePr6jPPD2XV+Tbw7OBrGubutPHY+noCEnhE
 Msdb3hGHt63T3BAGqrA3IqfCdrbidRcKPEt0VT7wNHtcV3m1yfC12WTz2sYWXN0mbqJcLhwmCVE
 gIXp8IhxIG/ZuIv2dX/cqcrKB2hhigSgq9tsUl/xk4UDhTIXIO49uqEt4MNwudv7n9f2lrSYOWs
 zwZOR5v+GG5dMqFNu5aB32qEnuyjU0hQzeuji/Wow==
X-Received: by 2002:a05:6000:400b:b0:47f:81a9:3f36 with SMTP id
 ffacd0b85a97d-47fc81c5eeemr6044095f8f.18.1785436880469; 
 Thu, 30 Jul 2026 11:41:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 22:40:40 +0400
Subject: [PATCH 3/5] lib: div64: inline __iter_div_u64_rem() into its only user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-math64-resync-v1-3-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=alchark@flipper.net;
 h=from:subject:message-id; bh=UEJZEHzDP8Gf+sg/L21kQmlaL+aSZFgrcJ7wu+UVo8M=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlzzraEXxX87hyeLGW3aEnAu3l14+UXLmhJzqfbc+nL
 ZLTOwL8OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqjyWMDD/U+Vu+B2rNehpua5k8e4FAn+APdh2BtNcsGufFo3vLtBgZ+i5c3PP
 77WHLjX8lzD0aW058FryxQVXz/73nkz49rU86xwoA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436880; x=1786041680;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ICDvOYP9gh7GOQ+auoaZDpAsIzsirKtadKSA+jMf9gA=;
 b=ccKoo6qt6sw4Hxd0bJglSexPa9fjRtYw5j7+NwXWzFpShMmhfNYVas5pmMzl58iCGA
 n8+zEXs3IPruFtXA3ltmLFckIeYjIqQnRnrIxKFjfFBWJfGGno4VfNgLoNWQ8NOy0c7t
 6uZ8jFPooGV3yPnk+PxCzpakdMUhbzbgrRTqKufOFS6I7J8GoBiTKaAaMbKmLvPX115L
 I4zxRWblo1TD5XkLiXeJywDzelqmBc+gqLivILJ/O3ENG5mxkIvZjVgSBov5saNNqOmJ
 oBPcMFqO2AvhQQQ1GoWE8uFnU30jAgBF/0yllObrzYZQoW9VmC4xKyEoWLKuNQ93+9tV
 FGSg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=ccKoo6qt
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

__iter_div_u64_rem() is only split out in Linux for its vDSO header, which
has no use in U-Boot. Inline the body of the helper directly into its only
user, which is the iter_div_u64_rem() wrapper in this same file, and drop
the static inline, so that a subsequent resync of include/linux/math64.h
against Linux does not have to carry an exception for it.

include/vdso/math64.h is deliberately not created: its only other resident,
mul_u64_u32_add_u64_shr(), has no U-Boot user.

No functional change: the generated code is identical, verified by
comparing objdump -d of lib/div64.o before and after for
evb-rk3288-rk808_defconfig. The compiler was already inlining the sole
call.

iter_div_u64_rem() itself has no in-tree callers either, but it is
upstream API and is left in place.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/linux/math64.h | 19 -------------------
 lib/div64.c            | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 70a7ee3ff1d3..eb560e3183a9 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -118,25 +118,6 @@ static inline s64 div_s64(s64 dividend, s32 divisor)
 
 u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder);
 
-static __always_inline u32
-__iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
-{
-	u32 ret = 0;
-
-	while (dividend >= divisor) {
-		/* The following asm() prevents the compiler from
-		   optimising this loop into a modulo operation.  */
-		asm("" : "+rm"(dividend));
-
-		dividend -= divisor;
-		ret++;
-	}
-
-	*remainder = dividend;
-
-	return ret;
-}
-
 #ifndef mul_u32_u32
 /*
  * Many a GCC version messes this up and generates a 64x64 mult :-(
diff --git a/lib/div64.c b/lib/div64.c
index f5624279086a..9db7499fcd34 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -192,6 +192,21 @@ EXPORT_SYMBOL(div64_s64);
  */
 u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 {
-	return __iter_div_u64_rem(dividend, divisor, remainder);
+	u32 ret = 0;
+
+	while (dividend >= divisor) {
+		/*
+		 * The following asm() prevents the compiler from
+		 * optimising this loop into a modulo operation.
+		 */
+		asm("" : "+rm"(dividend));
+
+		dividend -= divisor;
+		ret++;
+	}
+
+	*remainder = dividend;
+
+	return ret;
 }
 EXPORT_SYMBOL(iter_div_u64_rem);

-- 
2.54.0

