Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6053BC88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24675605DA;
	Mon, 14 Sep 2026 20:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc6oAvVEC_9V; Mon, 14 Sep 2026 20:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 71147605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789419135;
	b=CRN/qT8Sv46DzLkxpCjQ7QG5+e28Ou3AAxfC4KixJAUbOwuGMDFUxQkC3+jvxMlwD5Lb
	 mLhP1tzo0X0wEEMIeMxiM7a2YWizSsDfXNtUkysEezdqWu90uU5tnKnWP5usQfuYs1qQi
	 R+DQRyYtk+sAEYhgFwlBVwy8G+62MrP/hbiBXq6Kr82PO1IGKnfrg+doSnxqKRP0tr89u
	 ikc/w3BmAAsJFG7NVqswXh2YAhmi+95LShg2WWRgBp6IYMAd8aa5dE4ANBclWfwWTe3jS
	 vwgz1QcEH3g+0un7CV/lX1LABL/LwREt8sF1CAdzwGvwKTPXz2YrEBQ8LF6YZanZ1cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789419135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AHZ4s98QnWr4aOd1vlvkj8i62xmaMlRiHY+fmQefuew=;
	b=GPa495c0Z2hX5C08wHIKutpCFvcUw/pOSAYelqpanDnxVadpc35II/HKxY4+PvQUT9An
	 SzDbpLfsGkug4WDLWelFDCjpU7UfwqPjUsQ5JEUx75gRVqn7ORK3GwCbWUnrxMrWJZEOe
	 89vu2CmZqq7DMXgrmo0UafBiWBqj3Qd84pGNefS3PVcEvcWpgvS7yKViASlEOeM/FIWwo
	 tMQG3ieiMMq1sE+gU7GdolnwkeyhmAgA6mGdWLV6Cgfp8QyEMKZ24wNhliYjHI6f5yd4s
	 YAuaDODHS8Q4cv5KL2WAwu5tXS/5ce6MO9JFH7ZasRMY+Z8FIaJXC+qcnUt3a5Kd8fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789419135;
	bh=AHZ4s98QnWr4aOd1vlvkj8i62xmaMlRiHY+fmQefuew=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hOtt0GVb1mbpCouzcD14YEDG5/pH2/iuz0DC0lbKtsVcSfoHNAkxEJeGxbYOtGCt5
	 de4ZpNcKdecFPNyzKicsprY0zqt6MtEfx91zeuDIXtWwN+CcUtn7TPawkopDXaloSI
	 XG7ahwAUe+gke/X3qJUO3wP8voGqofG6FArJpZ3wVZrk+oqNnUV/P2VgChFeRdHYLB
	 AVlpkAqM0oclZUL4RMVEC2aCi9dJ6XobYcCfWQAmciVsdL/ZJgdu9LbWx+6B+RPEw/
	 Cu1ZNy9/7BjSJnJeUVAGHX81B3rGCi9JuYiACR36g+hSvLU2m3lO9r5ESgzqyWpcna
	 sPySDwb2V3S4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71147605FC;
	Mon, 14 Sep 2026 20:52:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C955B362
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB5AA404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPReQshUQsx3 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12A8A404C0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419133;
 b=LEQAcSjarpklbFDR0hgGFE53z8l6oYA3D2oLwFaPz+pHdmwoSMXNCBE12k09xOkAEkEI
 hr21wZWF+MERZ55T5Tewku/eZTV3wPz52b1jNQXRqqpBwk3VJiXFAGsa3QF04nThCljB2
 0lekPc9mRBIV8XCChtA8ktQrE5kUw1kngse8qkatLlbTlzTCFqThQBa9nlzOcrY4umWBJ
 ChK3Hb60+duX+amNTw0tFDfAQfnUVduari4Kw9EzllmwsS53WG38em3J+Azn8xqtZ4iCh
 Kn9nM/wSLIu1qV4/VCMPz8+teTachpzLTm0CU5YNEdGiqgUSkAqRG74tGoIo5DbjmGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419133;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=AHZ4s98QnWr4aOd1vlvkj8i62xmaMlRiHY+fmQefuew=;
 b=Aai9xp5tg3q4iLLKbini77vArKayPgzI9jBELMx5T2vZbJY8naQFB5X1EKALgSvwTOCC
 RWnpw5ujy1a4W6qMvWgajXNho9Sp83tW1MnmHR0OxAZOjdrwrL4l+wUBYXtImNLXGI81b
 S4fIfznqhh7sHWbYzRwVr+j8SiIrscVCQCFK1aTpEAlcYRQM4E+UgJRxeK32FeV8Qw9XM
 oJjvVQAsC9Slo3q+I6aeibjUTzdi/2doZ9omkpImHhILOIzX40diVeo13DM5jZDobXKOI
 rdQqa9OTy84y7w8+p4ngppSDXUFz8jkRQ876ZFcB5Ba2KscwUEycHn04aYdyknU3pEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qQY7ND9D; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qQY7ND9D
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12A8A404C0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:52:12 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43da99easo25016327b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789419131; x=1790023931;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AHZ4s98QnWr4aOd1vlvkj8i62xmaMlRiHY+fmQefuew=;
 b=qQY7ND9DaaZON/2qrkRz3DOYPLSS3/dVUXsuYE0TW5eGDCK/N6RpqrmefvIX0sv7qD
 RSFt3nt0SnGt7QmrH5+oHCtNECNEFA8o/xn1V7NZv5f7clC44BUipY/BRzNoIuIB+YwL
 rjT2LyaQszjnkjlaME9nDPQ/KY9zWBNecg5GDTA3uK49zJ9VZaWXB4bmCkXSwyILexYO
 LGYW3TNcv2DQ3lAckiOrSGM73wfeWjLKYCf25wTWUzHkkHFGgENYiNkxancamTDIJt+A
 MhcvebToWD1ayXiLBggNEbYeUPjiAb3RBmiexHyrfGuX0UOHElPpGg6YcYg1knyVtnPV
 JH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419131; x=1790023931;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AHZ4s98QnWr4aOd1vlvkj8i62xmaMlRiHY+fmQefuew=;
 b=uAHLjtx2VPQ1e7SjU5y3SOE7tlUp4eY2YeQWpTuqEXSJHIOPp8NydMbkrTFzHp/zeX
 U7QqeikXNw2s96xedgnnHADc+9WkHtz0aHAJwbnLqia3X0qz40oYA03f96mlxd344+j8
 MEVbH4/uQeszhJhwDrV09X5WOdQ7eQFQY9cwnEku0XmeyWXhQy+UcLnphqqCfjp+PMJY
 TydUQKgqe3y5JeeRui5vdkk04aODHvZyEyOkwQxtiJsk6pGUjdM95a48WU+cR+OM49OJ
 +dKh5g2NgwBdVxI8TRZFpURAWn7AubVeUAmpJ+Xb6Nr+nkTeLmjUxKtpzDjNJIoksRjU
 yZuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPb89L61LUwaJ0KGc5r+0fzgPVSbIS8SGCURzCPrHKE7xA0jPXAEdNZuXXrHHtCwCrBbfJE/w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nx5H5HRCLqEocnXIZXP35uNkSQ43AgQBzyzPhXKmReMAMelJ+s
 GEUDNz01kaH86STWqc8Lb1nCnWSjNGwuzrQp9RHm84w3EbuSl9eqMsAG
X-Gm-Gg: AYBFou3V46UjunnYSZ5MLji7p0ObYbfQ3X2YxuTHpKqTBJCJhDLZ023GooSyg9y26pr
 ID99tGWSTbGQ1g11aEZR9cR1n+eAjR768mc3MhN+TdPnXCwU0238lO3ouwIzrjnMuDBjL2rER0U
 ue7HayH6ZpsiFRMDJ6w491QiJqfHj9V/o84Ds/gFLrSTeWnmEJWMYvSxfa/9Lq1+ZMir589olyl
 eSAsa457oo/Za656sCD7O0L5GBjfhupA49NqKrlk6AefAcZJG+j2fTv4NLtr/oZOwJuEtB7/lw9
 bR1TKG2O+9pvRlebAxG1A7IiRC2qOmIGfs/sX4loIN9H5umGKfqmHj1VCAKNTUrqgcQcZKzjGkS
 pouOYh+hLfQMUWgrgROwOZ5Ai6bT20VjK99O1zMVNPC0cYHQMtlUkHfC8/xntC4bzytxxWWddqg
 VnhxqdS5A5DOP/x9TfSSjVlK9fHol8E4oca+NEOGFSk3tolPPMujawNlnNpW4R2ByQUoHdv3Glq
 zNzTlDYqYD3bpaZAKRburJFGQY5XX09KBDgkt4CWbN41xd4AMCx3CP4kExz672ERRgxE2Vo
X-Received: by 2002:a05:690c:c384:b0:882:1d1e:7d27 with SMTP id
 00721157ae682-88d200c0ce3mr11222417b3.23.1789419126754; 
 Mon, 14 Sep 2026 13:52:06 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8847db468fesm40613967b3.6.2026.09.14.13.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:52:06 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 14 Sep 2026 13:51:51 -0700
Subject: [PATCH] mtd: spi: update spi-nor protected property for some flash
 types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi_nor_protected-v1-1-80a925329712@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGZeqGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3eKCzPi8/KL4gqL8ktTkktQUXcNk80RTy8RkAzMTCyWgvoKi1LT
 MCrCZ0bEQfnFpUhZQMcggpdpaABhafnJ1AAAA
X-Change-ID: 20260914-spi_nor_protected-1c7a59ac0648
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Jeffrey Yu <jeyu@issi.com>, David Lechner <dlechner@baylibre.com>, 
 Tony Dinh <mibodhi@gmail.com>
X-Mailer: b4 0.16.0
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

Add protected property for SPI flash mx25l4005a, mx25l3205d, mx25l6405d,
and  m25p32.
This will enable spi_nor_init() to unlock these SPI flash automatically.

---
Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..5821ea07d22 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -309,11 +309,11 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
 	{ INFO("mx25l2005a",  0xc22012, 0, 64 * 1024,   4, SECT_4K) },
-	{ INFO("mx25l4005a",  0xc22013, 0, 64 * 1024,   8, SECT_4K) },
+	{ INFO("mx25l4005a",  0xc22013, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ INFO("mx25l8005",   0xc22014, 0, 64 * 1024,  16, 0) },
 	{ INFO("mx25l1606e",  0xc22015, 0, 64 * 1024,  32, SECT_4K) },
-	{ INFO("mx25l3205d",  0xc22016, 0, 64 * 1024,  64, SECT_4K) },
-	{ INFO("mx25l6405d",  0xc22017, 0, 64 * 1024, 128, SECT_4K) },
+	{ INFO("mx25l3205d",  0xc22016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ INFO("mx25l6405d",  0xc22017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ INFO("mx25u2033e",  0xc22532, 0, 64 * 1024,   4, SECT_4K) },
 	{ INFO("mx25u1635e",  0xc22535, 0, 64 * 1024,  32, SECT_4K) },
 	{ INFO("mx25u3235f",  0xc22536, 0, 4 * 1024,  1024, SECT_4K) },
@@ -529,7 +529,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("m25p40",  0x202013,  0,  64 * 1024,   8, 0) },
 	{ INFO("m25p80",  0x202014,  0,  64 * 1024,  16, 0) },
 	{ INFO("m25p16",  0x202015,  0,  64 * 1024,  32, 0) },
-	{ INFO("m25p32",  0x202016,  0,  64 * 1024,  64, 0) },
+	{ INFO("m25p32",  0x202016,  0,  64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ INFO("m25p64",  0x202017,  0,  64 * 1024, 128, 0) },
 	{ INFO("m25p128", 0x202018,  0, 256 * 1024,  64, 0) },
 	{ INFO("m25pe16", 0x208015,  0, 64 * 1024, 32, SECT_4K) },

---
base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
change-id: 20260914-spi_nor_protected-1c7a59ac0648

Best regards,
--  
Tony Dinh <mibodhi@gmail.com>

