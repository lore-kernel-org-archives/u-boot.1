Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E130CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C46740928;
	Fri, 16 Oct 2026 04:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcZkkcJVk5jk; Fri, 16 Oct 2026 04:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 545494092B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792123353;
	b=kN+3qRxbuIWeK3hLgzab9lEA7mZo0bYzABcdUh1goWPfJYkYwuIYwxSt/Th0/Qg1kM2N
	 8hcgO37f2Us1c1hhqaiZbWRgCLjPVHGzRd1a3LUOBEuNp9Xpa8n6qroZzNEIKis61wRi9
	 dE6vbyx9zW7yaioNuKuIgSzb+cJHIYJl1Fshdyz34m5iMEmsKfsdca74KdZD6Q65+Lf7T
	 AfukdD3VLw7VGYPzLSQLE/k6GuJKZwWzEKmxipNgnWHMbzwVFQ9Ix7t0qe9K5SDuKzT6G
	 RqAy5kxO5BXYuEj+lCKPcxXN8dCp64txO+vN37GIjj3l0q0YUaCmWE5Nd+9z6+DIvGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792123353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zz7rxZbOLMhN29MdY/s3DJClFqL+PdtSaPh/mHkHdhE=;
	b=NS3NCdKX5YSi/sM0fBUXEUoU75HNu5LHgjUoHZJbyMTHLT0gu80UwTz/3TEw7xZjk4P+
	 0vcqaIYwM1R9LCFyzHpZ5QbjPFe52D60H27equRJZTWDBlJ5kWUogCT7Go3V2eRzdqjb7
	 WJOPvGF2hPbmG+aUCEPEKT8PRCph6z9MV4/isp9HTaNZjUbu5lnmo6iF3ZzZgCxhxNR5S
	 AicK6rZ6d0b7A2NOf7MqsYV9jjmp3CFvkUqrZQTptXmHkmJJg93eElD7bi+inNSf2QaKH
	 AxgEq6tZJZWvrAQUTodYj5z2naPxr6WB3X0yl4Vi98BuRFLXzZbSc/jwUo82oXT5hGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792123353;
	bh=zz7rxZbOLMhN29MdY/s3DJClFqL+PdtSaPh/mHkHdhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CleN6q2sWAnuHdDN5iZ5Qci9WJ6jxAk6LhE46WHAQaOGh6xSG0UxjSor3K/VvE281
	 JJn+HstR+qPus0lj9P+niGDl3SaSbiWgF5kkWgOPzA8V5s7H5PuieM+HPh74AcVWq+
	 i2SCjltCQm2dS0qoAry2Qa6eUNTcCrkadpNaBjWgOG8i5qisLcMxBilhiSRr/W6FGM
	 KBNvW5NS5q+wktdpvzWyvAX7J/ZTQKK/s1giuALi+v/tIQy4l7JZuPapy5GnwGU61m
	 fPLMuBV0YPxRdjJ+gyJGdCqPD2l1wgbY2n68ux3+XO9ouN2ERaQSbsWK6pOPsQUt97
	 RXq0pJ9suKtzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 545494092B;
	Fri, 16 Oct 2026 04:02:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABC3C105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D64181233
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVM9alHS80dj for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0FB38121F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792123351;
 b=gkqzrwBnC9hcY3KWM+aq6AoKwTwF5gv0geeGrId4Oz9MBrX329FIREwct+dx9GS51grs
 mX2fqUJnEgLTtkDvciGOgUN/LQF2r0wKXh9d4uK6Xe2KXC5EEt29Avf0WJ07Bev2HmZI6
 MiJx4B6W8Bkff/iVBb2YbvnoHbBsZ5PmsRAkxu+LtXp+FbHZQkdvYz6EBDxHqtr4GdCw7
 fH6oCnx1x3i3BCHNG8M1uhr7aepbSZ97xa3K+CG2cy1cXbd8FDPdwJ2dWbQ//0JfRPalI
 FGxa4kAdnGfjb29EZcZnEGMDCzjb1jI39CymLzK5gcoIsMY5QQOfgO9S+ldAPYLhcSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792123351;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zz7rxZbOLMhN29MdY/s3DJClFqL+PdtSaPh/mHkHdhE=;
 b=hIwYLMaks40S6TPd6AvXUfxSCORSUonML4mRe7tnEgFCxJqbGImxq6/c+FS8QrXJ1I/+
 f70khu6aZGG7AxzntR0dBTq8BuMbs+Gb7ZI6prcELlN3uvGHVu9hrkfugEa+9Y+mXaVAI
 mt27RfjqZPDBlbNWyXvpKjDYm1e9YXmq+C+mTpy+q+wDq9W9jxiD2KYlooWYm8XCxfF6a
 FO/1/D8YNgIsS/4W0Z7Nxa6Ldi+AoIWRtq2p5WofH6EDO0OeaYtr77OrDJ/Z9Clkwl2WN
 nXOikbQFx+NWxMBINm6dFKFElgSp9jPzfkhB90ZH/XfTrXPui7h9kcpDl6vY0GfsoHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KcwRQ1lK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KcwRQ1lK
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0FB38121F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:30 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-88c72646f03so1283830b3a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123350; x=1792728150;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zz7rxZbOLMhN29MdY/s3DJClFqL+PdtSaPh/mHkHdhE=;
 b=KcwRQ1lK/RWsm+mS538ecHw8993bQE743cLNBnf03P9lzAwrVAB1kJdmc+BweRG+c0
 ZbYcfPF3aQ4eQD7Nvd9i6tvCrDMVdmVUK42RalGle1RBpHfw3b9QN80bAbjp4qnLAjex
 90d4QSM6ybu86unjRXoaVIu8XQdCzjso+9jIuabsjDepiibym+5XefcsQr00Q8DDaw2L
 vrtkNUJRUOK87ZJqexVZbpJIkja9U3sQsYkS6wTznMuD04tEoxSGeUxuD4Xf54sc4npw
 gLwVhkI5Yp89w1TO3aEaQ7yu2WH5NoKB8WU0aZ0RzX+YoEdO7210DaObLoj0A5SjBWv/
 oQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123350; x=1792728150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zz7rxZbOLMhN29MdY/s3DJClFqL+PdtSaPh/mHkHdhE=;
 b=ahRH4tupYezRGUrHA5KAzQ84n19geq3C/7iOgKtZjQQKYbWw2z1jzBAnUXuWi1qu1t
 N2ru3axguxxCSTka6lUvXVs+oXWTw/96/vMj+JFe1kws2lRxbp0MRSco2ccJk7AeQQH1
 S7OyFyUe9ZVMR1jWsqbyIhrppTHSQKgMINdi5kT36EI41/pFjqP+vPZO+NRifBlGpYqx
 q2+rR6pmYxW4g3lkdUAO/RFLuRz2s5KTkQF70IUFs6VWyzX0ekuyX4Uzz+stykd5iTCa
 VmSI7q1r6nOnk4T+rw7M0vtTjeCD6Za4x6tMdvPRuEkjqXYN+PbA36kwmA+Ux2bEOaQv
 ozBw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuWLN8Dbgrdeq5gqjwElOhliIvDyBOFb49qPYn8yXRLSQaOtn3V4kFmwGuiyP1lCi2ZY4b3fo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKWAX9OuSHDKB5IKyuw2cSEDa+jfT0V98IS8y1JT9ZWv7uM/ByH
 wIa2gq9hBLk/RWKI7Dyn5B79a3ZWsftNJ4JloXR4D2j4jxu2HIsTU0Sb
X-Gm-Gg: AYBFou0AnwuIEHDk6FJfm0WIQbvh7fQrhERm86YxSUsSJkjx8AF8XIPzRmxTAospOyC
 Bob74/Is5McBhGbi6tzTs/p1JtIWTjKaMw4568sdTIiuEHekl//rAg8eHOdqmM+ptlE9W5ENk6T
 EtSggCFhmQrhDbYutzDARCAR9rIL0PG6UNWSbeoesvh+soTLKKr1H3zzCuYweXIMCyAPsfVWTGK
 Y+C0pIHsETNwJABXtmbi/Fs9Zfi1qTZotG7G+U7cA5RYmgwXSeSS8tczPk215XMGnQlnXtdeTl3
 bKmuR5FuLOsrCwug/yTosZfp3LRul36GbFtn5L2nL0Gzrx/6BEU6jg/jbjeqA/566TGbyeVZ02Q
 pkOqYFP2uBlYY0gFh2H04HlOcWwJBaR65iRsRKtVwF9AFCvMN/HAnBphHtuc6eZIxO2FGJ+x0KL
 0IJCftBTVa+Fx2f7Ua+JmCzshrcACaHgmb4D/V7gCHq4DlBnmU6rCNZ9O13l3R1Ao/2jGyiR0I+
 RfXq2Ve68+B68SzgGK2KD+fZmHyMc/m+7OucorMxZK/wZG16Mebii8lpWgqw5LQYFgB7Ef6gw==
X-Received: by 2002:a05:6a21:1f8d:b0:3dd:f9ff:f5a with SMTP id
 adf61e73a8af0-3e1d04134cdmr7700055637.9.1792123349682; 
 Thu, 15 Oct 2026 21:02:29 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654a249f3sm437294a12.27.2026.10.15.21.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:02:29 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/4] arm: Add Google Tensor SoC architecture support
Date: Fri, 16 Oct 2026 04:02:13 +0000
Message-ID: <20261016040216.3636305-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261016040216.3636305-1-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The first four Google Tensor SoCs were offshoots of Samsung Exynos
SoCs. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
Google Tensor SoCs are of Google's own design. Add ARCH_GOOGLE and
the mach-google directory to support this SoC family.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  6 ++++++
 arch/arm/Kconfig             | 21 +++++++++++++++++++++
 arch/arm/mach-google/Kconfig |  7 +++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-google/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c36..36b4c7f0246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -356,6 +356,12 @@ F:	arch/arm/cpu/arm1136/mx*/
 F:	arch/arm/cpu/arm926ejs/mx*/
 F:	arch/arm/include/asm/arch-mx*/
 
+ARM GOOGLE TENSOR SOC SUPPORT
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	arch/arm/mach-google/
+K:	[gG]oogle.?[tT]ensor
+
 ARM HISILICON
 M:	Peter Griffin <peter.griffin@linaro.org>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..e49438fde41 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2252,6 +2252,25 @@ config ARCH_GXP
 	select OF_CONTROL
 	imply CMD_DM
 
+config ARCH_GOOGLE
+	bool "Google-Designed SoC family"
+	select ARM64
+	select DM
+	select DM_SERIAL
+	select OF_CONTROL
+	select OF_UPSTREAM
+	select POSITION_INDEPENDENT
+	select SYSRESET
+	select SYSRESET_PSCI
+	select SYS_NS16550
+	select SYS_NS16550_MEM32
+	imply CMD_DM
+	help
+	  This enables support for Google Tensor SoCs starting at the
+	  Google Tensor G5 (Laguna) found in Pixel 10 and later phones.
+	  Tensor G1 to G4 are offshoots of the Exynos family and are
+	  enabled via ARCH_EXYNOS.
+
 endchoice
 
 config SUPPORT_PASSING_ATAGS
@@ -2356,6 +2375,8 @@ source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
 
+source "arch/arm/mach-google/Kconfig"
+
 source "arch/arm/mach-hpe/gxp/Kconfig"
 
 source "arch/arm/mach-highbank/Kconfig"
diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
new file mode 100644
index 00000000000..a9e605ebb82
--- /dev/null
+++ b/arch/arm/mach-google/Kconfig
@@ -0,0 +1,7 @@
+
+if ARCH_GOOGLE
+
+config SYS_VENDOR
+	default "google"
+
+endif
-- 
2.56.0.212.g129ede20d9-goog

