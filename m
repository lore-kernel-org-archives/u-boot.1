Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xqDslGm8;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=fBdRPPta
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D4BF81287;
	Thu, 22 Oct 2026 01:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhyCPDuC0HRN; Thu, 22 Oct 2026 01:38:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AA5981257
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792633097;
	b=QiKYozhPSLQ5j8TjJv6LioIdNMGtMzsixRwr39NVKTYOTFAIZsA4kvmr2dbS6kTyZvj5
	 wSZ4eMbXH4jYvvAB6sJPyiQ1SIDrrcaCw1QTFh0DYB9K/UoWeeOEKs1b33k2IgGLBpjrC
	 OwWyEiMZxK4O/AJz2I3EPtn6Kzfb2jgGUfoo5dvzJtKPuqqpatho0dbO8oX2WdnUwtrQK
	 NTQR/27n6LIbR2zqa1CMuJBp8gZ/4CLEJee093vQZaiJ6hHmNMDzQ8Ur6qRQ6bxZ5T90A
	 Ane/ceUoSUV8vxoghJRTJ8ZHBm6fHrtxWeXaOlvVzxaTXagWvyW3vSLKw9JTjvoxa2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792633097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XJXUjnPH+atSd9r48ddTxXxgbC0iKdGY5dJ+zNzys/4=;
	b=gXW0VWTpeWPqgyOuuHBkiClCVrEN2IQwSAGU1TSYx9+IWBWNREgsQRfY//UNg4SxieJe
	 9glJoKwWhkkBZf/dclITV2Zm6LndVeoPATcxQ+Gz+Yq+MF+0AjM3fQsDBmPZLgqOQrCD8
	 TAFsQpVvuMWm/cu7EUCNJ08lBRPXOFpkJDxlVUKj5ctfy1P0Q9s9n1YqaR5owq5XeSSwS
	 I6Y7JDnr8uwbA3MGaPVBuCm1cv4uR4iDPQY/QfvueIUUndlKYvbvSBt8A+8N1SXwuuxIz
	 Oza2zbJtClwfDPdhUDBSwi1jqqRSyC6IVGecD0sw9u2z/zkSHkYg5YskCQMlJxhuF4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792633097;
	bh=XJXUjnPH+atSd9r48ddTxXxgbC0iKdGY5dJ+zNzys/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqDslGm8hTz9IohTxH60Jr/cB4PjShxeFytA7UFO+MV3T7OG41Oqu7k7VKHYGv1v6
	 luO7vT/K/l2RIwXLkNpXJsAcDyfNs0ZrGAwxXIVZPkbgS9nW96ufpHRqzXLb30qvLG
	 yaC1Z8t4a68zm7KU88f19twoeqAFdkrrs0biO753kfOxUw6ge1pw1CXMo63xp3DaV4
	 WOKXSx94QC9VxLl6l5gsetjZN9woCcVZZ1lE2u4E22QzDx2UBlqPbr/6jzAeNLkqhG
	 6Y/5BTv2Af804CDnJtBF4N/gZ4qV3ml1p7t3Q0rSdI+wlDiduR4uBBgfvnlrn4NEl6
	 gLypolOI6Pvcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA5981257;
	Thu, 22 Oct 2026 01:38:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15AAF371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07E7960EA8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIaRk3bypxZG for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CAD4660EA5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792633093;
 b=dZUOj609vOrFPvLNE8syhebdpnNCv9F7bvwPTVOAfRcnOP35/A7XMpoKQfkJf9dc3GO7
 /0K5fiPCm2HzGH6IGQWFZO/G4M0j/5MkdpyUEdEA5jBFr1qnZ2XIN8TOiMzhUpBEBSiSE
 jJUTkRuj+n/umgEdNu9wGP4X92mUpz0uj7HBdeTXvngo9tKimFgrAGQdp+x/7Yk1l/u1P
 0pNPAtGGKh+6WzOwY23PxSLGRqta3FFeMp3lQ94ZhzrJqwHASDxAaCj4B9h34feCzknkA
 IuumkkOt0/hOSH9NM8kkSAXBKBGhRVlfHpaFjkftPChI51ccnMuNqFoV4DdEqsyGlaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792633093;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=XJXUjnPH+atSd9r48ddTxXxgbC0iKdGY5dJ+zNzys/4=;
 b=DmjNpkgD59msgOM+eGmpABGM/O/eJZpekfNYvP42nmwXEjviUOogt1945KTJObKKFLAI
 9HpwK+Dz1Apo9sx0bSrG6gLY/jndo673Mpfc83Urku3mywGSjDE059D8bpFLKHDAmj7hi
 JXjy499lHCyewCZPEUdouG++/m8lrkegfToRm5+5h/nR/MenTCY+Vp0nXmiTduj6/mqQt
 JCaQDRw0Hp8rQ/7O3m38/pVyqSGkwP9ryNDWEntLi9UjljMfNjA7E385wwz7/O8g3d7Fk
 eqwH8UX5YeIsry2ZLxFChYvUMeNaekSIjtaKL6+OU8ZFNXawJ1E0xAMeTLPK4t2d2VQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=fBdRPPta; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=fBdRPPta
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAD4660EA5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:37:52 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-679a2297c55so1295164d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792633071; x=1793237871;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJXUjnPH+atSd9r48ddTxXxgbC0iKdGY5dJ+zNzys/4=;
 b=fBdRPPtaaUmJHhqQoaiQdhyi12rz16YCVdrO8OibDq2NGlFNJrYT0WD4Uo0ECkSu8T
 7rsbtk1gi5nOBMXycb0TCK/OLpkwZYd1nsdWejuxWmds5qpcxO2g4OHH5CXN4iGidgTB
 4R8Obfjd6HP7BUyJ62h8F+iEjWKvMgaVa9Jcx404Z/qxgJwU+oSlwLvc7YCzPDmy1vMP
 x6d8Fy93mkjq4QzQ4XTZCumLMbUY5zaTFdizCrVTZGpxIbBf6dLOVF2lMgBBYe89pN9t
 7E7MtaeTrQjx0Rv+cfcBj6rS9x8qB/02ClZPxaEcDMJ13eqLzomUfoj0QykSQk8T3oIj
 TAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792633071; x=1793237871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XJXUjnPH+atSd9r48ddTxXxgbC0iKdGY5dJ+zNzys/4=;
 b=BdoaSy2+eofyKceKiwVoICcS3afxu0EaZlTHwjt6xCH/hmosN30uGDo+Ea3BLk7+TW
 RItIkrUcBAYaME9kBdiOl9CIGrCyHWX7XhAf94Og2un/qHdD0bFgo6oijUQhm3g826os
 pYI2srLdqA0fPgVpvMwlzcai6rgJ52/rpYkzzL1EhgRjNwkn/bQv3gn6PjRpugUA68Z2
 7sPgF9xUG4t2W9k6WOqYUmmqVN+4Je7Bj7drEexkpFkr4vZCQPfcC7G8nDAkr4p79kwg
 +vXhn9MXXM5MrHfMt1rWLn14+ZV7CdG5HIsQet1kLBqXx/6ANsIZjmixQttoO/m0WEHK
 gauQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLkjSi9EE629i4E/5HM8+us+dLjMrwSyAMEzg4omXnZzSK1+WGo26pk+UPLH46CLD3grK4vkk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLDB0IqfWGLFTV5Oy4Oc8bqQ5uIkS4YpORJmBj+wgiqpShRhg5u
 Mk4zwB9JSdKweQ4iXueRJRhB+kEzVOsjdQJgAOnwv1ETLWr/cMCQ2tebERjypvquDfs=
X-Gm-Gg: AYBFou1JLu7OvMa0xZ1MixbO6FC5qVXUWI7JILs+0tXs4L48ywKkYoj3RRL10maxfIq
 aRAGw8geB67zZCQINhprYoRi/vxxdFvcz4tn8rj0SxbUE3r/97SXo4mEYslhVQZnlrTsz4zUOSp
 V85z2yt4LU39xbr7JZxwK4RLwapK31z/nNfY2H0L/9ymw4f2/BkbSkG12cdwPngdprHMftmUA0R
 tvbT5iZ792s/cHN59pjnRgl+PYtYeiLSywoyJnyyg/dm5beO6e7NiLB1J2bmwpr9f8ufobx8gn8
 2qgpLRvstS9Dus1kYuB6ovK2taL6b2tTH5i27u6fTZrCQMORwiEsUH0cXHO7j2ZJg86wYPGO41H
 t3D0dmsaNk9UKIP5e9pCpqANXmxm3YxvMIUPeAROBOe3jGzyoC5m5zJux701fQCe2DSdBEbAwNh
 YjyoKbiXmCkT+EO3PcaEbiEclTlWrsmcgiUbRjtNwkSDkJwg/smv42rVKmQTzbwVbUiCl9KZHYV
 XsW6wJ3Ldlp3IYKEv2myxK81YGr8jmsBVSLOoFNnukCLZuKZk7scNgL2+3QlaPPPeo9hfhMolM0
 mAz/pAK4WmpuXpBPO/m9bMvbYaqXlqSMm7c=
X-Received: by 2002:a05:690e:4889:10b0:679:ab08:5285 with SMTP id
 956f58d0204a3-67a0e536136mr1437817d50.82.1792633071339; 
 Wed, 21 Oct 2026 18:37:51 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:81a7:5305:ca4c:d0be])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a0e53a353sm1933502d50.18.2026.10.21.18.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:37:51 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 21 Oct 2026 20:37:14 -0500
Subject: [PATCH v2 1/2] mtd: spi-nor-ids: Add variant of mt25qu256a chip
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-spi_fixes-v2-1-78af1e8c8c3e@oss.tenstorrent.com>
References: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
In-Reply-To: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current mt25qu256a entry has a JEDEC ID with an extended device ID
byte of 0x44. A variant of this chip this (model mt25qu256aba1ew9), has
an extended device ID byte of 0x40. The current JEDEC ID parsing code
incorrectly detects this as an n25q256ax1, which results in 4 byte
read/write opcodes not being used for this chip even though it supports
it.

According to Page 34 in the datasheet (linked below), the differences in
the JEDEC ID (Bit 3 in the Extended Device ID Data) correspond to
whether Pin 1 functions as a Hold or Reset pin. This shouldn't affect
any functionality in U-Boot's communication with the chip.

Document this chip and it's JEDEC ID so that U-Boot uses 4 byte opcodes
for this chip.

Link: https://www.mouser.com/catalog/specsheets/micron%20technology_mict-s-a0001400588-1.pdf
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
The differences in the functionality of Pin 1 (Hold/Reset) also reflect
in the model number of the flash chip, as per Page 2 of the datasheet.
The existing entry in U-Boot (0x44, Pin 1 reset), should have a model
number mt25qu256aba3xxx, whereas the chip I'm trying to document (0x40,
Pin 1 hold) should have a model number mt25qu256aba1xxx. I didn't want
to change the name of the existing entry in U-Boot, so I've left it as
is.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..ed43104bf53 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -416,6 +416,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("mt25ql256a",    0x20ba19, 0x104400, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
 	{ INFO("n25q256a",    0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_FSR) },
 	{ INFO6("mt25qu256a",  0x20bb19, 0x104400, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
+	{ INFO6("mt25qu256aba1",  0x20bb19, 0x104000, 64 * 1024,  512,
+	  SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
 	{ INFO("n25q256ax1",  0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ | USE_FSR) },
 	{ INFO("mt25qu128ab", 0x20bb18, 0, 64 * 1024,  256, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ INFO6("mt25qu512a",  0x20bb20, 0x104400, 64 * 1024, 1024,

-- 
2.43.0

