Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA52C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 18:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8239340B83;
	Fri,  4 Sep 2026 18:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XN7eL09drJD8; Fri,  4 Sep 2026 18:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FF2D40B6C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788548038;
	b=s6REe3hjPpp2XoRRRAlsDLX256BhlLc6lfr8HIm09380BSEHWt/E1hYfLx1KpTrjo4YC
	 6Ea+7otD5QVR7nz5Kc+Rdgs2l2RBtqSXPvEv8sx/8NZByCs7z4KG4+QDEdkZv6O8XjAo3
	 7XkZbXSfZO1s8ZQsxFmDUpRajZeGuSvRDn7hTgqtCivlso8kwK4u0qHBA3Od+CheAV6vY
	 /ER+SdAAiy/if62Rn0hnlwb9mkzouPX38H4RbzkGw3nG/a/ADsHC7hg+Dn+CC/xuUOLgJ
	 8FAF+HX6wSNDCjtWeYTe0C3pzytnmrK1fG+ELzM62+YHhpvpiYNsFGaONpjVAgnV4dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788548038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7aVI7wyVl68gEoM0Tkv7/4P513vHJ9WBy9Bv47U1Dwk=;
	b=k+4Bxb48sjCnHoXmGV/Hb70h4sx92hb4HgDP4vh5HDWhgA08IOOVAE8LCAR67NgeBrxH
	 qq1V9/rHEN4cJkptK3FiEa+q3hu79J696G9hfHPiZO48dvu7UFv4vkVZNe4t/ChMq6Pwi
	 6T/tvK0PHM80KWJN25GoaK29hb9yeBTw/4JQiWTI7WAJEX5mI8wyf9mcLEfd3xao8H+lM
	 sMp4oDiIR2P124oUJFjohbZsKb4X5c5bNSteQdEDVFHqKtg0gQO8FsZwfjHHzTeeWUM5g
	 nJJPKrS/goe6NE+Z+Eh/ip+16JE5sclFKVndwL9CHIsRDESKc5ObyhkBV781Oo1QX0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788548038;
	bh=7aVI7wyVl68gEoM0Tkv7/4P513vHJ9WBy9Bv47U1Dwk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Urnc61C0GZpO7xAhuu18cFiFfGCuWh1Ef6Ny2NVn7SSfSOZcVnYNBUfq3Uxeu9gbS
	 NUYYjLqH9tR3ARR7nllLo+hK1Lbp9vSDKcqDrGudJ3/FCyfvxzEkpD3x4ZGNOd2TY8
	 /5rCTLsm4OBoKfFPqNWW6D89lAQd8fmfQPYpDdpYDadjwD6ktfbB11g6OvZj3fSDB+
	 oWSWTjcUeI5LpE0Sr+b4Zyj2mtZXCkKkyLI0tHxN5KK+H5HrYP2iM6ZTp5fbSkttCH
	 29O845S3PiLrY6T4uIXs9zezJ3dXYioKNdJO86AdRglfqNxrOIzMMPDN4UU6hhBROD
	 hHaechrlSd+FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FF2D40B6C;
	Fri,  4 Sep 2026 18:53:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06AED29B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 18:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBD746078B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 18:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QcjGSjMVR2Kl for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 18:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3872D60633
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788548036;
 b=TyKMIhHWE+tzeEmzxOYcRY9Vaa7UuWHjaK5J4EWINrw8hH4uvyHuOywScA3IaOCxHNvv
 RVYfBZlzJ+og5RnqX8cw5Y3hpyEqOQL48fnRiAgaiyDkDCa71uOu8FTy/jcH0xHVkaNIN
 Y4NyE7CVeByQDSD/j+3YrmJhGDAc0vUe/8PqhZxZXj8uhlnRvbHrfEQnHst9ComIOypM/
 0VOoXMoPNspK4Pw1SQgjEKdmIq8FBZhkrzi8wNykMk/UZ52PaAZoN1QJVWDj40MMZRh4O
 LCmueg1T4yNu0z8L/6LynswCUHgp8p3gU9MnK9VZKrVZ3Jvv/OLyk+9lJqVVi2oK8FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788548036;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=7aVI7wyVl68gEoM0Tkv7/4P513vHJ9WBy9Bv47U1Dwk=;
 b=eEKJz+1osrdjSEFzbwnb1rAYkH7ZN2nkPo7kq3WXiv2TdR0/4fAMR2mzlWUZtSzyOcSl
 av1yuNFqAvSTsH67F+DlAjelQX7UlUJPvWzwJAACgPxn/YcIkhNaMTWgw9BmjR9Wb2Mun
 kDAq+6UmjxlVh8pb/5xQ/PTQ5kv3ZZsklgcXHhM2UMjhfBMvsIdV1KPYaCK4VZgpKQlJ2
 PY/K4g9aETOAI8lAKIzdrGrtsHJwm0fMeu3jshFfIpLdhZLoIUVFG4PsLLqL6/JSTkfnp
 bEOgeOdq6vnb9UxBPA1Q6XmyA1A17Mj6Ne9oclEOSC6v8SQBVnbsPyvazD8ZiHZoPEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jNNfSjeU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jNNfSjeU
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3872D60633
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 18:53:55 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a483a552efso684835b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788548035; x=1789152835;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7aVI7wyVl68gEoM0Tkv7/4P513vHJ9WBy9Bv47U1Dwk=;
 b=jNNfSjeU5cVH07znQBS/lj2PGzGfBGzt5+txeDXgU/52uVXWPeaWkYx9dwww+Zhqwu
 TdIjIuLOmSYTfx9rOmyrJHYBsmyEz2y1TS+qATp3GIUo542uCoO5le7kxVvYjqW48Njs
 1CMdJKlEK1+hvLpz/14ulvxe3We+HSlnx0Xss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788548035; x=1789152835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7aVI7wyVl68gEoM0Tkv7/4P513vHJ9WBy9Bv47U1Dwk=;
 b=aFeIi7Ehk/XxLM/WGMOanWIe22VaSXTubR4an8sYs7zA8aUEWjVJjka8CwNhMHSYpr
 GCPXV77QqcROObOK2ZUX5KW21J/Lm0yAGIlb8hY+dtw3n/+zs19tcTODljE/1BmVc6Rf
 gIABrqW4PHM8pZgF4WNrCKod6eTU3w8wF2Y1mkS5p49zN9ItZxzuzbQWktpVhDNX2jYN
 j+VX9huBjvAyTOeAB5GK9CJ83y087NZWM4pmU2lf9FdogZoqNAHZ1btu92LT1LFVoz4b
 QyHiwnuzpyNj879QgFX1/2rn3wRoLo1g6kgQ5Gx7AbwTG4PEVVt8J9fkVwdacYNqafhn
 iW0A==
X-Gm-Message-State: AFuF++lY2rAqghspb/J3awxYAr/0PPuwfQj81glgId29TWmpfKBXsocC
 KynY9WdnjcDbTTnL4kJNWkhCzXG4CIq+xS+2+bQEW3isxZ0n7s/rnyXmBywU0cdYO7zFukTBq9B
 lHsGxwedz6AKP
X-Gm-Gg: AYBFou0sE5NxrS3tPFF2CMKimLNfEKmtZinGjFwc+Bd5uGAdgQT5iVHDqdV3ol2T6X6
 slQ9xNTb+g9onQ+PIpE3ZPIphxg2424AUzlzjhxc6tVGSbGkAhRNZJeT1oGDY7E1XUbyVmU7xAP
 nwciApMt4LkeP4T1UbEN1MhTVVIpCMvn2Xvn2Fa8XuwLrS3/PwIZxaRwtEuWXPycJTMOnL8TI4N
 vvwlm9JXHS6cDUWEcBmfUs8zV3wpteRan6ZEmt3E7s/rJGg71IZybBYagT0qlmvdnSXtoj7Y+6c
 He0f914fDHk2GnGAjNuC00R6uBWLmT5pahCfpHYH0UmkUBeYQXjZ6+Lqxf/lRhG/qDswUG6X9jy
 HHXxxC0RhzlQimQpguxcCzDWxw5PlD6+rT/NrgTCT7joWUwIY1pP1wXanNF/WjLldzbhAm4n7o+
 nMB0qDUSYcsUSW2lE8gKGGqrJuRCI4kKsilz4/rV19Z/tK4CUXpQHUSo2QVITjVV3sQmSSFiCPE
 RKtPoHJHJHw8KyIP6DxLDP7hn4/Bk8O5ZI50vO66CqeAKqwjHLmnJJlCufD5Iat1zRA77hVII+F
 91pmuWSYwxy/lU5TgQNmvijbd3RKj2pKnsU8EI5AGgXYePQ=
X-Received: by 2002:a05:6808:4f27:b0:4b3:7aeb:1b73 with SMTP id
 5614622812f47-4b9645205c9mr5702476b6e.2.1788548034675; 
 Fri, 04 Sep 2026 11:53:54 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b970d1ff95sm2762847b6e.6.2026.09.04.11.53.53
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:53:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] arm: am33xx: Default to enabling LTO
Date: Fri,  4 Sep 2026 12:53:52 -0600
Message-ID: <20260904185352.2953962-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These platforms now sometimes trip up the size limits on SPL, when
adding bug fixes or similar to the code. Enabling LTO gives us more size
back without sacrificing functionality. Run-time tested on a Beaglebone
Black.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 767ca904b610..8a246f962d18 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -101,6 +101,7 @@ config AM33XX
 	select ARM_CORTEX_A8_CVE_2017_5715
 	select DM_EVENT
 	select SPECIFY_CONSOLE_INDEX
+	imply LTO
 	imply NAND_OMAP_ELM
 	imply NAND_OMAP_GPMC
 	imply SKIP_LOWLEVEL_INIT
-- 
2.43.0

