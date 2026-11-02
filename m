Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE5606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O5SxiSTj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zU6sHOJ/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DA1B60681;
	Mon,  2 Nov 2026 05:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8r__k71rAqo; Mon,  2 Nov 2026 05:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9D806064A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793597556;
	b=Y5mJKxa243YSlzmQW1uiYDL6vOJu95RB5fmeQ5WowHinQcZy+tRsmc70NKCOdFcHOGFq
	 cEWaOvoLWkZ/gAvZZKHWFWVVjvHv9w4dQu02QzJczt+wco09Flii7HyByF98ieN7Cj1DG
	 32RAJKo5TNGhv4bL6x9y/5Qd/E0Hb4wEN4OuX6vKw7xYqOY1Cl9X9kS+rZOhhPub30b7D
	 GaNpV7NFOieVKxbxPyizsNslWOlArrnzLJyx59X2zLnyToRjo1sx/+TZvD2Xwdzyf8mcN
	 sgc5EF1qFcqKmPm7kos4H40a6vAuEYeruGYhDMMrja3a5KmwxEYLG/tKWeiopXkRtMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793597556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vUbt2KD551hOrpeY/iszAoyzHV48bBmTd8rmRBZPkAM=;
	b=DY8G/7f7gBx+Q7WK4QM/SttiFjz3xiudaQtUIiIhxIbwZirZhK4aRbtunWPsSu7DPhSS
	 P6zvaxVnKz6KbRPXV+j9gMb7C16snvnT2rYx49umBrvGdbP46MYmFnaFIK8pNM1dFyCyT
	 mDUx1aQHqA7Iw6v67ruMOENo0iB7xHgxLcA897VouEWWiDS7oSc/NpNpYaA0ie8OHLwrh
	 HXe1eWdlDgFy5ylbQ7A4u5qk5nc6A/fCwIhrd8CW8aI7/KFF1vjotjJ5u+O/5MAGEQRBv
	 dzHJ/YArrE3yQ76hNp4FH53dKqzoOay//Xt4kbiIydM7fp10AA3NrxxY5MCcROuHuYw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zU6sHOJ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793597555;
	bh=vUbt2KD551hOrpeY/iszAoyzHV48bBmTd8rmRBZPkAM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O5SxiSTjXeU10LnRZr9TIdkhPurI5qgQanHXz8LzL24RQaYFhO8KNMf4xIdC9T7iU
	 maOCgguVWhL7ReP6cOF1GfdLQ85lPZXrB5XEMrmaZ85peQqzxG/Eqyc7wnkLoMJT+E
	 Nq8GFY7pnimhibLEBcgi6TRSv3R0/Bqb2Pf2IXNo41xmVCs2miQO6LMI87HWI+5Sx7
	 C9zFLX1nLf9rQRccIA5lPTCJAqI1oms7QjgLkeY3SIEQz846paE5/jGBc9672xenAq
	 /sq2ugTROhWvD2tt6y7ZllT4QesmxHPXvZ3EW/TQEY6nqkGgH/sEK05h0ybNUoJLQ7
	 ZDC9naO7YdGzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9D806064A;
	Mon,  2 Nov 2026 05:32:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23FAC435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 151FD60627
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXVZDwwXkkNo for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F91860600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793590195;
 b=Sl9DuHn2WxfJOmUzPCVCEAWbR9H5ZrSPTXrSuelR1/tmAaBBkZf+1A9jTZLY5uP8U9lB
 iQPQ6aUBY3yJ4qPGKq6hv5wKmDWuOYm2N24kW+XYsPTsLATGMmZQDxqjLH4VM9RkSlwo4
 qH4AGwZoaRJfswrz7+XkFPWK+g2NGe1tL6bHgO54o1OJtfgqJOhlxIB9MKH5OfutGMbh2
 EyLCpIl9z9uFVVuxuUw8Zlb6Df4SjMVx4dTjeJAK2Vit3gEzuN3FV4yJ3gXRt+AwsglLe
 Mk4vHprFx6y5WnF2a7ttmgtemuPWVrVgLg5yY0HxPhzoHget28v2xJtNJTxgripJXSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793590195;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=vUbt2KD551hOrpeY/iszAoyzHV48bBmTd8rmRBZPkAM=;
 b=Dw8ddI0sbvF9E/lVmM2tox+kgkmm4wiAkmokrd1a0ZsWauBtjLDkBHI3JsVynv8QnQFL
 f+AdXH3j9yhSfOBCyE32tT1fHNCxHPtKSj7G0R2oj4DAygJ4Q25GSLTE/XHq3uws5xYiU
 +CvtI5JQmv8/nWhPmIsHh2IFBHlstXMG/C7X91Fm13yUExaqgfUd39xFTMTfgmy+0VMt1
 wR8OKCHq5AssawUDQwQDpbUZDtLz1Zpl0lSUInhR6QWJzhbuByH/2kYUI6WiNdi8iz/xy
 3hEG2k4edN3Xxn/Sjs3G4EojLGGqR2kxoxxuT7yR3NgHOvwal87406crq74swOq2uDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="zU6sHOJ/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zU6sHOJ/
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F91860600
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:29:54 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-533778ab0bdso38346521cf.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793590193; x=1794194993;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vUbt2KD551hOrpeY/iszAoyzHV48bBmTd8rmRBZPkAM=;
 b=zU6sHOJ/uqEd2JfoZrPdg7WmdrAotSuqfLz2S4aqI1uWalRAlKKzMIAoyZVqH+DTKf
 vNmeTyb291oQFR+1YOk1bh2ATGrJz10cJsDX3reDn7WjETpae7njVx6iiS/TaRn4tpnP
 44WW9LmDpzzLNGuxUy+IQEEAV3ad5Ci3IkcQF6Ukxcg7fobUjfgqMXCGjCV9Rc4y6nWd
 gTxKODApQA6Brm1a3sRMcZvjt+fJRpuYt6PHXdAzlEmnLOtW/o0CiVmu4hCWJUx1ku+o
 K63+l2VqDYlTK0MbS0B3AMziPyjlSVdS+RTTJrpbhFUKhM3qFh/GhzprO8cZ21Pq6U8k
 WAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793590193; x=1794194993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUbt2KD551hOrpeY/iszAoyzHV48bBmTd8rmRBZPkAM=;
 b=2N+GU1Yx9HXLKaNCHd0ACkkGfe+QQoUhwohCId1BRrdt9vVlr8/5m51eiltohPvFsr
 Kwrmd6IoZ8kTDmM+I4gl59erwUit+ZgVvh/BPWHaoRzx2w1BDuztub9HtMEOMm1vGKAk
 xm33QG7sAbIKRc/iliwuA0aOUD468IDZiAW0Bi9z9a85ZT7iJKd7kwd/PflvCvHZQW2R
 SmpmTdgkCbmo41aV3g2gpTBp7jKxjZ+Ck80edhfI8EWHIsdMhrBjodNL7FB/b2QNnF/D
 3eRnZkK5AcX/5+1ux/VMEDeQ1bH5GUJB0P+DCIgZNDKN7ApqZV6xDPHLaYoW7Z6ED/IR
 1F0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIVWlPKhd8VyGfgeauM3Lhwp3GQxMER1+zjhOd3OzxaV8vXvBZGedziSQdLUrjRSLLrmEn+q4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8lO/NgXSBkqsasZ6a2pRIwk5Re0yllgpBOPm0rJboPBc1K7qIS
 pocspJKTKAlBoubcDKAP6re1lJxxpqBOG5pvry4kkLqNqH82DTedDyok
X-Gm-Gg: AYBFou2r+CFiIgXa7drz6K2D33GEZ5waCF/BVnFXbVe0U4oxmI3/2bQbZeUXAiEMP1V
 jxf+XTVaJZHn6aeCELiTR2Rxkw5n84aRSx3U6bNpcTWhrEbceFB+hMl0aOzlBKg0wEkZVabmChU
 AjOthYK6vnAiy128iTwC4X3mlSF0Qw4PDAu4ZVWBqf4RovIVacPugfiyCzYRBuh3Bs+b+bVURMY
 478fZDECD1PL0coUi5mZrxGZHLbfF3jKKWs+K3K9/wnZ/tmMaKcdJhVBEMYXac8srkx/9i0ZFJD
 zkeOwTfxQXbG9uoNKJSXpYEECts5K5r3amBhArSkRcMRtiZHgxRlsDzN7cX8vhu4iBN4ysbve53
 v2ROTboSRlfY87iZ/ZfMyjRCLSnnvC8sawPXlVzGaSTfJytZi0r9TYvftKyKISWb4wDfZUdrPMI
 hY8BNxyWXMg8IePvKkmVRF0FhqpENk6tb+pkb4jKw8C2OfRroUTrrI+3TWGgeSCizbRQmAWzLcw
 qFcxBoer7GC5rEtpYoBES3GdHXa5P9T19g4D5EwZdCJPAxINCFG2tc6z1/iY6o2f4Q901pbvz2k
 BcraAKMG6nA25SixPUU9ju6JnAs2CPu9Rn2KrrtTxXwj59lfSpfV
X-Received: by 2002:a05:622a:58cf:b0:536:8d0d:2d96 with SMTP id
 d75a77b69052e-542b639cb31mr145370191cf.13.1793590193500; 
 Sun, 01 Nov 2026 19:29:53 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54313234047sm74305371cf.28.2026.11.01.19.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:29:53 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] mtd: spi-nor: Don't let clean_bar() overwrite read/write
 errors
Date: Sun,  1 Nov 2026 22:29:45 -0500
Message-ID: <20261102032950.305343-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 05:32:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With SPI_FLASH_BAR enabled, spi_nor_read() and spi_nor_write() call
clean_bar() at their common exit label and assign its return value to
ret. This is also done on the error paths, so an error from
nor->read(), nor->write() or spi_nor_wait_till_ready() is replaced by
the result of clean_bar(), which is 0 when the bank register is already
0 or was reset successfully. The caller then gets 0 back for a read or
write that did not complete.

Only use the result of clean_bar() when no earlier error occurred, as
was done for spi_nor_erase() in commit a9d9d412e00e ("mtd: spi-nor-core:
Don't overwrite return value if it is non-zero").

Fixes: 8c927809ea96 ("mtd: spi: spi-nor-core: Add back U-Boot specific features")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Tested on sandbox with SPI_FLASH_BAR=y and the emulated m25p16, using
gdb to make spi_nor_read_data() and spi_nor_write_data() return -EIO
after the probe. Without this patch 'sf read' and 'sf write' print OK;
with it they print ERROR -5. 'ut dm spi_flash' and
'ut dm spi_flash_func' pass, and a normal erase/write/read/compare
still works. Not tested on hardware.

 drivers/mtd/spi/spi-nor-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..759f511fa20 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1677,7 +1677,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 read_err:
 #if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
-	ret = clean_bar(nor);
+	if (ret)
+		clean_bar(nor);
+	else
+		ret = clean_bar(nor);
 #endif
 	return ret;
 }
@@ -2105,7 +2108,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 write_err:
 #if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
-	ret = clean_bar(nor);
+	if (ret)
+		clean_bar(nor);
+	else
+		ret = clean_bar(nor);
 #endif
 	return ret;
 }
-- 
2.43.0

