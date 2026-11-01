Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD99606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBOtpgoq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PlV7ftYN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 792C5606C9;
	Sun,  1 Nov 2026 21:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lh0CvOm_bu97; Sun,  1 Nov 2026 21:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F99D6061B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793567171;
	b=Ew42G8EF5/P8+ffxUGzqaUGBAvf1Bnk50pd7CySp/pUmwDYcovU5Ink/1Sn4VrMs810f
	 gw81xEi/q1SEYWqFz41vJBHnYvt/lsyG3ipiDIvqN+IQzhN8HtC24gDCyUlM1OjFaOQ6o
	 d2soWD9djHySTeJwEtgsaftXU9j6cHnhnI6+OUvcLPWgmaLJwLaRcwMzmd5wegkj5L35L
	 yOXVPoVjM+HdQRnzYGTHOS7Bb0npjEDsHNvupS3tecxb0kLzC98ujlGsLR4Ji3HNu3c7D
	 LFAJbuWLL7aDZwDuPBN5Imuj63hAwVQHZNEZ1ay4rWT0v0ukMbbNZmEjZR4DzD+Q2Dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UYWtA0zEn0i7f2WdV2OUA61VeQMhTh8dm2JRYOjyqDU=;
	b=Tn56ibGucYu8Zjqk8TvWJXOpFcwNxsRlQ/cELrzRvz5ADKYViwg9OsPqeKNbsPa3wfZe
	 zaq8RTLrhyQL4763R73z4ca8JPKxDEJRcnJj+6URrUqbMi9DVZo5TvhfHmTupKUXSOVV0
	 qIWDwEDbv2NnMG5cd19g7AQnwqS2IQuMpGFVC7kdgJF5/hVbYBB+o1e8EwzDQTXvmxudL
	 JvxsC0bMTRDkfafEJwx2+CEIu1deUq47E9hNbtnj+9SMQJBGcikzjOgWnlMyiz0pL/ly3
	 FPa2+HYKMNOw2kvddML2JdLIo551GTlFpKU6T9twt8Bz+Strf9n4pRBPt2NoTi1kF1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567171;
	bh=UYWtA0zEn0i7f2WdV2OUA61VeQMhTh8dm2JRYOjyqDU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kBOtpgoqyKXPltpRuo3lZ+4ZRUQDsi+c2VhUaf/0knw55vNU6/46q8Wpa1i7w0ERJ
	 KZ3VkkymZoKHwKvZOCHBV20JUtglALR1QxbFzjKgMB2byKlYPn4IHj7cKGk0Ypo294
	 QCwLKN6VJ8quc80Pe8mQveLsSWYhlyTdthVprQbuJ6BSeV1uiOHFmIgcJbykeqfBDb
	 RlIYQwcTalU2eCAJg29l/m+J/p9Wx27c7C5pq+hBlhsad5eZeZx8miQIy5bcLzopz3
	 5qxHPg12p4UeCmxraQJbEcI2n0kZaG+6QBGHiWjlxuROM0kXyRp0p6jMfjJPkLZbfe
	 3LYQu8zqvsxMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F99D6061B;
	Sun,  1 Nov 2026 21:06:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BBE73A7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D36F400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLla6ccpGnNo for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 13:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A96B4004D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793538806;
 b=DshdsfxKqcFINLebNX1kDxPiZ9bJb7djU9XbRsW9iPamwwMt2swjBQP4CpQ9zsPfauIa
 aDp9jjO0WUQGSKHofY0J745/UywivQuX391/fg9f7dOXe/eh0s6x2WU2GAGqXNqGYK3oO
 cKCxkRbuzgMsurKepT74MPLn9UlDgAXn+6nwqa/m3251TiTkSYrwA+9sIEh/MU1UCLVHj
 VVKqtYHx7ACv6GFtFXkzLaHf6vQSH9DtB1uoHemOjNftoZyta+nx/S4yNHNTOZj62TUaq
 V2TXxHiD/2wgmS+ZF5kyG7HgjT3HDN32HAzN5sT10G6cSLOloW+31T6Bnvlf39rd59g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793538806;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=UYWtA0zEn0i7f2WdV2OUA61VeQMhTh8dm2JRYOjyqDU=;
 b=E8qHALMMK5rj+VnafhdbMNsfnfGs7eWRXE3WQN1iZv1t2A8D4HHBb3Cck+eIesmsoybF
 2itUFo6e3xGeba0x9SO6+A0urwCvVCnGL2mCCHQ1nMLUDnjpMR2p8eiCCJN9Mf/v2pLGt
 b4Yu9xLhnTjomFNWIwzt6a75vfmfcDoFQ/rlKxlpnwRuVeBZUEICwLrBAvNkLA3z/KPZ7
 By79O2FCZjUzcs9RycAGY04vhY8UhhsB+fjCM6mVSiejJr+pbLypB5iFUeR+9tH6H//X5
 C9x5oN+duk1uESV9jCk5vjA5l+LYfiNShzVOBxo7I7xEBjQ/KsQXGdqTxnX04iDNRYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PlV7ftYN; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PlV7ftYN
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A96B4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:13:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55369849AA; Sun,  1 Nov 2026 14:13:23 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42058480A
 for <u-boot@lists.denx.de>; Sun,  1 Nov 2026 14:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso827872b3a.0
 for <u-boot@lists.denx.de>; Sun, 01 Nov 2026 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793538793; x=1794143593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UYWtA0zEn0i7f2WdV2OUA61VeQMhTh8dm2JRYOjyqDU=;
 b=PlV7ftYN2JZ9+qXJSt6fixAL1HgzBSWCmRkBHU4kzEu/8Ph6TBdx89D8P1BPHCDK5P
 cUcoTMnbxMenouAbFs9UsBU/TW91GjT66NeUAz1QuM11H1uZG7xWMKCpAGHcx7uO84bc
 CvFhYx13PxiETn5YeyrkGrGsdjQAhYpsoGj5intpONNxSDRKIk1pd6FiSIrL4undvBET
 flvJHmUUxPuhKZYzdfd1mr/ZHp32AoqQpNhF1TANUmySjMr/wcAHbMSmO0infxYPF5xG
 UY5M1XdYm+NPW6nj4UB7/xBINKrS1a7LaEZ+0C4U/zRlOvGsM+4jSuClJ3LnQpoaI1+C
 68bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793538793; x=1794143593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UYWtA0zEn0i7f2WdV2OUA61VeQMhTh8dm2JRYOjyqDU=;
 b=ZMGUsMVxuUmiUl9HgEAlrOFl/QwTbxlYU0hQ7850koVJYzfBU/1ulB11ylRyEyTYJh
 DWnjmndk7QzQAHOtD5DxJ7GfvLFCPTDlsKGEsYt0dhc32dknO209gI1zDSlTTSO/58uk
 J/QAZnhPK3vS52C0LMUUZM/7KF2wZ4xbrSbfT7KYf1d3g0b8DlOEClrYj6GmRmwmzOV7
 Sijp+RDxdc7jac4Mz074f9ISSENozaAwpgz5TjYs1DwET1H/J2r9rGmIqN9cnngqsJ4a
 S4co2fSp4jj8RU28zBnanCI0d7Wn+XaWVcOgKp0WXb7hXXCRyw5SRx1HeS8XZC/95Fqj
 2/NA==
X-Gm-Message-State: AFq9FYLvqJdSJfWaiCFKDeybDy4QWxTXJw2O19YXPVFlsCxOxD2UUdda
 PXOGe0pRQiDGby/bfWMihsy+xqAbO8VE2AsBO4UJKH/JtcEGAUPdyfT1oa6vvQ==
X-Gm-Gg: AYBFou0BvSpFSzu5u4mcJsodezdwM0yfMitMEOscz3QJ29T1VJa6DIgo9nioSZNplAo
 kn8uncaNN7CxnNFNANQxPxvpYuNd4qKAFQLFm1FWNaWLY+Xqi2vjaC+orNZ666aEkcLiBsAV0vo
 uyseG+JMmSyhXwSTw2s8Tww/O7LNHvCt+oTh+5134EQLDB7X/TwnJNb9v4JxQctZqnVf/ZK5CBh
 M300H6Vrk8lJiV/qwYvy/kJ2teTa+5eaScqoy7EJX/ic8PFy1FK9Kp0Rn7Q4+PMasBXadDyxKYF
 mGOrPcT9Epdo5RBapr8GKE+K79erlKh/6dQXStWO4yGfyOxEQ8a5l2qBZaAzmUyzX4N2xwWMSzQ
 q1G6QM3Ts5dIOLqqNm7tSTWarQWM78gUW/M2uKmrVYBOGoewOSn7lLEbknbKC6ZN0nHQcqOyJKI
 EsND/Okr63Nj87fpxuJNNlNqa1siim5ZRYcFdvChaaTZOe3gAeJppO16K4T7SpLaqgXXOVMdqw+
 9mH/bSfk6d2esqpQUBJ/KU6Cn+yRQR2m+LsxHU/A+F9q9Sh3w3F8PUrc25FPGeBzM3h6mcvFN0F
 z7ki/rB5t93cOWP1qQ1qls8=
X-Received: by 2002:a05:6a21:6e96:b0:3e0:c2fd:511b with SMTP id
 adf61e73a8af0-3e928d1076emr6286644637.32.1793538793081; 
 Sun, 01 Nov 2026 05:13:13 -0800 (PST)
Received: from Sun ([240e:3a1:d62:a100:dc2a:f688:abbc:3040])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85cb1bfdsm6460143a91.0.2026.11.01.05.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 05:13:11 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, Jacky_guo@xmcwh.com,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Date: Sun,  1 Nov 2026 21:12:39 +0800
Message-ID: <20261101131239.1566-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 01 Nov 2026 21:06:10 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for XMC XM25QU01D SPI NOR flash.

Datasheet: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b370e78262..b42d7af967 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -677,6 +677,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU01D", 0x204121, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.55.0.windows.4

