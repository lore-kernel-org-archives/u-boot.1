Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537C4C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC73C409A8;
	Thu, 23 Jul 2026 13:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eiTeHN8ZZBhQ; Thu, 23 Jul 2026 13:22:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26C7E40993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812975;
	bh=RkvU53FgHRAgh5Ie8ZCSqIwXh3/VB2j571DFDa7XzhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g78yR6EUW1cpbFVrupD537jwVijxrpVFppG6kxU/by5mIp6jSnn765X4+Cnhe9Mx2
	 PqUWDf/9n3uUr+7o6phQv5Z+Cpkf1a1EMhoSKpUKcXH0L1nvjErQ9Bc5DjEn61ybJs
	 hmnkx0zMeJuMesja9w5Xk2mFmTRyUOhxZIEjOwErFPSVqWKRyClyTTU1SYfXoXTpeW
	 HKd83HasO4ffdpCCJd80fcGUFIGF5lXs1OIqneLdPMM1m99+uPcbF2vT/qT0IIy+GF
	 5fGnPsG/07DSgn6x0529RNIzngkn4onun9DdUf5Ef1WAYL87MAtUO88Cy7W3X/Hfm2
	 GXKN6ZSO+u9bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26C7E40993;
	Thu, 23 Jul 2026 13:22:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ED1E96C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E878140806
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iysVsDnP91gw for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B636840800
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B636840800
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B636840800
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:06 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1677c91969so48426766b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 02:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784798824; x=1785403624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RkvU53FgHRAgh5Ie8ZCSqIwXh3/VB2j571DFDa7XzhU=;
 b=cWlFUaL6zBxy5YUi0VuqRwaLrNbvsQVlUEYleBZKYmybsZjmgTbb9mc1P/53hd3XWj
 vz49ymUz/uWx5rlyPta8tBBfNGslGBPR0exxFwWnC+h9o1MXNtNPOgvIfkiD6fYeTDi3
 rXfkhOK8aloKcwhV6MLHdJUVOcJe6/BbED+sMAmRjlQExHgfllOS8gLwRkmuecjNrYps
 d/bbHLUWeOjZyFj/zo9lE4NO/SuWSsodxF2FbRrA6cggE2ff/kfEa221B6iwuodmmQcF
 R18k065IwW8lLQwxoIIfuZzeOYWqEMMyWzpd5YMpGNPWe0vYrWYRYjX4LhNW76+kOiB4
 /Hbg==
X-Gm-Message-State: AOJu0Yx5wYOXr1qI8DjdYAvEu5OfoiCro3qBg5eUX0vS4EXBZvWlBpoB
 hD2Isj/+4qKSrxbsBBViFYpkYzAo0A0UoTs1OGXPz8XXbPVRTx1LV1XFyAcAd7s8VKk=
X-Gm-Gg: AR+sD11XZBJ8fU8QoDPRc9AUza2aiWKcYqBrZxE394cXd1G4hMNEV17t3akfqsBgNal
 9WPE5OvCqB8jHSCpz/GsyukyBPE69QpvFdgj9gzut8n2YGgwJf445BCKTFa9cRzHiBNRqTvzA+L
 f5uLdsL/+DyvsP/+VpuSJuDhECf5SR9X/PWS0rwm6mbWFv+l2V5hhW7VeKuppnl3nvWflvicN7c
 I6ZUdB4Xvqb/LnhSFoTz51sYzlOxapOIvGl2DHbeXqybtaHoweUJFDKcXPwW6HoXDoeS+CaJlXy
 WwOHIRtXFOODrh6rRrL5K4Fp3c3g5/cm8LztjoVcW56I7FW1PsOEEOCvajJHuq6STDCyJ8Suri2
 3Wl00uTMA6eYIN9oWfJjLooma+/tV/t3/FsBPOAy9LHx7NZIOvEhxHQpaEbKsCnwPIIH1Uzvzm7
 NXVOwJhS851NcVfsw3xYolJuH0PK3L28PhmBPIvu7WWz5tw9vWy0f0CZaFnMWa3eOqUl0=
X-Received: by 2002:a17:906:5850:b0:c15:cccd:336b with SMTP id
 a640c23a62f3a-c1c50b923cfmr83347766b.31.1784798824485; 
 Thu, 23 Jul 2026 02:27:04 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32af244asm206455266b.27.2026.07.23.02.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:27:04 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Date: Thu, 23 Jul 2026 11:26:50 +0200
Subject: [PATCH 1/2] fs/squashfs: fix integer overflow in directory table
 allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sqfs-oob-fix-v1-1-4fb6d9a49e8a@byteray.co.uk>
References: <20260723-sqfs-oob-fix-v1-0-4fb6d9a49e8a@byteray.co.uk>
In-Reply-To: <20260723-sqfs-oob-fix-v1-0-4fb6d9a49e8a@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784798824; x=1785403624;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RkvU53FgHRAgh5Ie8ZCSqIwXh3/VB2j571DFDa7XzhU=;
 b=KJ7aWkpDZD26H6E/lCqIURcZAFXn1P62KRrSxbga/TFnLPcKAIkhrqsL4KPXOlOKKK
 1C/ZM+NueFByw597qMbHeoWX632/W8B7Z+4sLOLePQz65VNWfY5vqE53riVzBmuMuTQf
 R4rgC6Kbf1mDIrp61wMYWt3DCjT0VH5srQWcuK7YZVI+3900VpCDmGjHRIMZr481JkV8
 +RjkyM2VIULYmSlMongFi5UTo2vBEYFZGTyH0oz5pep8o2LHIVazqGxdJtD0g7gtIZ2J
 0Drz4nzzRQtxJXawdG+dt4/a16SRnkWkRpfkDJt+nvRRBmwwLjjvVhSjR1R37khZ/lX5
 JPVg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=KJ7aWkpD
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

sqfs_read_directory_table() allocates the directory table with
malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE). metablks_count is an
int and SQFS_METADATA_BLOCK_SIZE is 8192, so the multiply is evaluated in
int and wraps for metablks_count >= 2^19. metablks_count comes from the
attacker-controlled superblock (sqfs_count_metablks() grows it by one per
2-byte metadata header), so a crafted image under-allocates the buffer
while the fill loop still writes metablks_count metadata blocks into it,
a heap out-of-bounds write. It is reached by listing or reading the image
(sqfsls / sqfsload). The position list allocation on the next line has the
same unchecked-multiply shape.

Size both allocations with __builtin_mul_overflow() and reject the image
on overflow, as the disk-read buffers earlier in the same function already
do. Set the error return when either allocation fails so the caller does
not proceed with a NULL directory table.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 fs/squashfs/sqfs.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0768fc4a7b2..3aadcdd36ec 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -852,13 +852,28 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 	if (metablks_count < 1)
 		goto out;
 
-	*dir_table = malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE);
-	if (!*dir_table)
+	if (__builtin_mul_overflow(metablks_count, SQFS_METADATA_BLOCK_SIZE,
+				   &buf_size)) {
+		metablks_count = -1;
+		goto out;
+	}
+
+	*dir_table = malloc(buf_size);
+	if (!*dir_table) {
+		metablks_count = -1;
+		goto out;
+	}
+
+	if (__builtin_mul_overflow(metablks_count, sizeof(u32), &buf_size)) {
+		metablks_count = -1;
 		goto out;
+	}
 
-	*pos_list = malloc(metablks_count * sizeof(u32));
-	if (!*pos_list)
+	*pos_list = malloc(buf_size);
+	if (!*pos_list) {
+		metablks_count = -1;
 		goto out;
+	}
 
 	ret = sqfs_get_metablk_pos(*pos_list, dtb, table_offset,
 				   metablks_count);

-- 
2.43.0

