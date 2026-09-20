Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A303CC982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B522240DE9;
	Sun, 20 Sep 2026 15:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ria7oGTBG92c; Sun, 20 Sep 2026 15:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D684740AE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919344;
	b=W6aN/cDmiCYn8HZdv5TV1KsmFC6ZxS7xd+gIOIO1K2poU1Dvdz0o5MnGgZLK0sWZ5ij/
	 1rLy3zkzlYz03AS/YKP4DCa1mUVp8XOCu0QBxr4dCGVEFqMHpLYyS+oDKFJrZrRxqW8kb
	 McSltCzHUFZK3cnTZNQiyr3LextzviAnyhb7GFSI2yj+auHoM7t0gfMQPQZWnOr7BceHz
	 UTtuBuUxJPgmcT17cpJKNdLuUu6gMvqET1G+m5VgyhrOtTbydzN7fUs35NmanCKTUURmt
	 jw7XE7TyYDqrCzdZ75ByUuUsWwHHrDuqYkJWj5GFBgX+IEn/884jTJhe8zxEveJ0/4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FSfMUIr/us5ag6rTPTT5kP6Xf8mdPvTdnBJJYMqlMSg=;
	b=MMvY54tWmXFHmLumv+YAIXLJuxumG+jSyNfTXp1wnnSjd8nF6IlyovJHGNaGnqR9CNYx
	 xjAoGCHo+/2dCVsCIFXly6COWiJgczvqyxU5teAMypRTHz0Mh4kkRlGA+t2UZ22CO54vQ
	 v3byvddwF1VaflcTs78vlkshtqY72/JImLypGPAiXlQPCzpLjiAIVeLL4iD2qjs9UjQM1
	 z/WiKXFqfkSJEikalooLgGhTPPhL/hcgPObAuE+pXavsmHqmUiac73ZNaWhyWJGK0fIMm
	 M3EX0osmy0hbHlWnt72B+Ior2SczxwQvyJAJwJ1mnjna2vmQl/N9hKHqa4o8qcujcfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919344;
	bh=FSfMUIr/us5ag6rTPTT5kP6Xf8mdPvTdnBJJYMqlMSg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xJRRZt9KovqoTzql1OJoHLywCOk9LfXtHqnskCWwoacYRSh/dIA3InMhkFDDswyKq
	 shZW2NyHdRu20G9Pp4eM3vDjthrsE09H0BHhwL69mTRoXz8M64ieZfujzEBT9wvvt3
	 AzbPJnmKAN4o7aBg81/Hd37aC1OSENNg415NmM99XZkKaeIjvwBtAoDtTlvT0gbRfp
	 jRpUnkfPbvKgZ3wroB4A0CcHrUyl54OCJcNN7oxPaR/Mdfl3nA9FbL91uw2avnqSd+
	 r77VApkuJXkjueMA9wHIwnBTetGd7/tkajH4ZfhPSXpd9slEnHRHWzFy5KXra7AQDe
	 u5WXqkZphx8RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D684740AE0;
	Sun, 20 Sep 2026 15:49:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3FED24D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5DC24002B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNmMJEUi4PDp for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CC51E40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789917321;
 b=JnAPQ0PIaYzjh/vp5tBtSlDqCUCXR07eOeYB6ez/OjXVyrwp8xDeGLlp8/9NJG6A74WT
 EmbDJLJK66EKcmO1tA43sb5qmpnpHY7K4ZoyZbzH2+06MhW+4v9aeplNc8B1KPDczQd8C
 SDWwkRR/hJ81QfHsLo4Jz6dQgtl/wSE2e55iZ899yuMS0Tb2POIAG0OX7HOuMEBRmLni0
 Fo4VUCbx4Yf6clZHXkm5paiKuF/A98/jOsiTFgKS8N8Evqa/HEuKNd2ZQB9Pk53kM2rK/
 MFfxEyZBKPpmH2ibkmpT966Q90hYppBEHZstc7xA3IZCBxCzjcwojgVLzsmQitgoxeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789917321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=FSfMUIr/us5ag6rTPTT5kP6Xf8mdPvTdnBJJYMqlMSg=;
 b=QiebMmiCe5xenfogrBomH48v9lop1oPxFT30Lw5PfW1hNpcvTZJ68fetPth8mW7Rc8gR
 NXKNGtymCg7n089i9dHjjwkeKMkohd5PPP9xJW6T5Kus21Ez7kGWq1gQBWqaK68TYukSj
 V9FnafYe7A0UW9BqJrgvmWzqia4gRzMviGY/4esnHQNhc4M0FqKUAPnThE1mj8MhdLeoP
 D9HEygwkB9IBqZzW2bjbBI0ecHc8++X2tht1gFb8oZuhveIea4Ic/vgUSlJqvEs8njr20
 g/Gc7zjScJzmEsA3Riu9kFl2Y4xxgl16HQ1ZZIEUEL6j0KpgQm2jMKFCp0qZKv4hJCA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=inMPGHxB; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=inMPGHxB
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC51E40022
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:19 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso15853605e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1789917318; x=1790522118; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FSfMUIr/us5ag6rTPTT5kP6Xf8mdPvTdnBJJYMqlMSg=;
 b=inMPGHxBSM4L2phkS9zTLALNCGHFB7oQZBg5fpmcXzRAF2nLs4krAy9Aw+hs+QxXd9
 5Rvq8npCoPkQzmW8pECGP+pXJtkq38ulHYSRK0hEe/eGlb16AZfJZlMvTyOL5RQtuRpy
 UBJjg5ZfV6dMj3Obmv4NOs7jqN28IUh6B4R6Sx/0fF4uiVlNo4zGn18TwA8MXtcNtMYc
 IqStn8Y9bziqkG+UefRjLWK/zz41/DuWUiCs+euv1OUR+Sbqgaem6HM2Hs9nvoyFp9pn
 7Oy61pxZdi5TZs/UuTGFY8JHg1LCuEfZHH1RUiRh941dYO0lE+4HnNQ6m3QLtG2l4IkY
 yMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789917318; x=1790522118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSfMUIr/us5ag6rTPTT5kP6Xf8mdPvTdnBJJYMqlMSg=;
 b=jk+Fp3vybo7COwGn6KTcHCFXt0qFRBQNXAsz1P1xGFellkfHgAyJDIfee6/J2JZNtO
 ZhyfF6gDPV31qhKuzsOORHCD3u/XfNNNlR4UelKG+MtcGfjP+OQJeEo+V6O5DfMOjC3s
 TFm8ZRIjjg/ilJT4GAWF2rom8Sn3bv3emcMFORZ2oiBQq90OKnGAIlZtbXWb/RU9AAIB
 ZCfMAa+H8xIQ66/mgFh/C99wvvkvi/yH8YOmk1cDXNBAiaMRcj28a1JIIgiqAec9GOdw
 Ndy5OEys4vnsSgAeASKebt9D3igjCghwG+HhQwBED6ZLmsfmy9VqI9ezXKUtVyq470q6
 dlpA==
X-Gm-Message-State: AFuF++lC5/Ld9yIgirF5z1b80KO+yv8fH47bzt2qx1nQK312O/CLXxp5
 jwx+cX+yjn2VAlKkjH0zrVt6vDimkhmkYKElmqEdCN3BHFl9oUB2JwiB5lspjmu6G5bcKcgjgji
 LqOjEYjxmnQ==
X-Gm-Gg: AYBFou3cqSD2RnFcUpARDtNkmuBkeB6dwgNHyWvrcXU8fO9Bc1qipTB7Med6xEZDkHH
 KE5BjLoBdKe8usRT7/FDxdx32h9DzQy1X4Gd+pT9NjVG8W7/g+VpRoyUKvZeDvjfQS0iSKfh0hH
 uhl56ysZF5oNrU0fDeFCRoylgy7Wi7+hcp9zoncsrXmWJz7nR59X76+tfh7sQcwtdo7+UMPpz7B
 BkjGORUt7sNyliRePkNbKDYcinD2K2TvlHiTYF8ZqPSDNs2so1RisDgRU9WMpfnE3rKhJ/697kn
 F6Ui5iHhh4MWJcyKovKgY/nU4mcv5xaWKwCr8hEUGQdBKpQxdExvnGb7Y2QVJOQ2qKmlGOeZ5os
 3WKXy7U9ytEPJtQqu76Td3531c03yvDz76SxWjGqPU+Kn2xmlkZ6Mkfiua1d8lQslvgoeqZNPth
 /nIZl6eEYBrJYKVP8OE/NYDdtPMrnzF2mHsWuCdGBAgc4X64G7lA==
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49fc5695861mr117414705e9.13.1789917317861; 
 Sun, 20 Sep 2026 08:15:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd3bd69b4sm11723105e9.8.2026.09.20.08.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:15:17 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, weijie.gao@mediatek.com, ryder.lee@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 ilias.apalodimas@linaro.org, Aleksei Sviridkin <f@lex.la>
Subject: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image header
Date: Sun, 20 Sep 2026 18:15:11 +0300
Message-ID: <20260920151512.401899-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:48:55 +0000
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

LINUX_KERNEL_IMAGE_HEADER has no prompt, so a board can only get the
header through a select in its platform Kconfig, and the text offset
base it needs has no prompt either, so a board cannot set it from its
defconfig.

The header is what a stock boot loader that only ever starts a kernel
image checks before it jumps, and a board whose stock loader cannot be
replaced has to be chainloaded through it. The Keenetic KN-1012, an
MT7981 router, is such a board: its loader accepts a kernel FIT and
nothing else, and U-Boot runs from it as that kernel. Getting the header
onto the binary took a platform Kconfig change for one board.

Give both symbols a prompt, so a board defconfig can enable the header
and set the offset base the loader expects. Platforms that select the
header are not affected, and the existing per-platform defaults for the
offset base stay in force.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 arch/arm/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b5103..cc40be0048 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -92,18 +92,19 @@ config SPL_USE_SEPARATE_FAULT_HANDLERS
 	  on them separately.
 
 config LINUX_KERNEL_IMAGE_HEADER
+	bool "Place a Linux kernel image header at the start of U-Boot"
 	depends on ARM64
-	bool
 	help
 	  Place a Linux kernel image header at the start of the U-Boot binary.
 	  The format of the header is described in the Linux kernel source at
 	  Documentation/arm64/booting.txt. This feature is useful since the
 	  image header reports the amount of memory (BSS and similar) that
-	  U-Boot needs to use, but which isn't part of the binary.
+	  U-Boot needs to use, but which isn't part of the binary. It also
+	  lets a boot loader that only starts kernel images chainload U-Boot.
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	hex "Base of the text offset in the Linux kernel image header"
 	depends on LINUX_KERNEL_IMAGE_HEADER
-	hex
 	help
 	  The value subtracted from CONFIG_TEXT_BASE to calculate the
 	  TEXT_OFFSET value written to the Linux kernel image header.
-- 
2.53.0

