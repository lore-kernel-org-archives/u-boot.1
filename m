Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357D606A330
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C6XW0blf;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wnio/dz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83FD4405D6;
	Mon, 16 Nov 2026 16:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MrjQCQ_JpA1Y; Mon, 16 Nov 2026 16:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF97E4064C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846646;
	b=oBrUZICtHJH6zDUZGiTUQGov0zC3FlKX/GxjZWTmmulT7GGQwH/yweUST5FgmKtBQ9Jr
	 XL8dr802OdqgeWQSBRzcQsZGriNETyRmKkidDD4X/NddiJ2DkCQbNbtOEcN1eDvAK/9xA
	 SK85S5ErmcfkmjAMQuVgCQu4gAhOnicrRAIhA4OA+96Hq6Dm8ShPqvT2H0O95hoEDwEsO
	 kEPndWLY81walRrp2Z4n5JSA38ouhTDvG8vzSNzqWiHqomzowUYojGUvgz6bl4f9PhAyi
	 d0aRuQoanH5ZFezjiDCBLj7fIA3asg+fMYuGPVaN8rfwVGH+6/ecs244Pu3zzfcPX1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=shJoh4HkZtF3Pf38eErWSmpEtedRqbsPkzen/c9eNYM=;
	b=OTdQhtPtgVMadgTUbOUaovgmWB0jOOcefA91bF8JjTyes/ak0tEMn0BWUBYj4LTbB9bz
	 VjGk88So9d+fOJZF/Nd8avce87MwbNV8s7JBTBxIn1iW15oRXAtHsmauIe98jbC/w22ju
	 oIe1YvTTn8o3ZR0xEPA3VhdmIwUy/Hr1QJR0UowDjhrN5XXBiuSmRrarzChTSqJ9yKaLR
	 qQw2UpqWqSuBPBU5NRXPsLDyRv0I5CZgNxVhKvSyGh8L/ROQ/LwfxCXgHzjlO6xRDxpFN
	 Hc2gAluomN2IhSz4kCAJ4kHP3eJKx6Vh9XvCUc2Ki+NKNu57Rs6hnmzabYY5UCOpy+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846646;
	bh=shJoh4HkZtF3Pf38eErWSmpEtedRqbsPkzen/c9eNYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6XW0blfaBqQkKHcFUDfY2c4z1h1zLdfHXaC8CvksAzEp/Gyk0C5+a4UU59mySzU9
	 PsQZGjBhFTUv8NWuQ4caLEMeXyAIN7TKNdr5F5GogfFmpyogGvM9d6AucVCp3XGhj8
	 4truc42sUMwRsHjKVmiCZbai8uaBGejJ8Cd0l1FV6t1+LSJIhS0mYuoMOHyhGtjlYQ
	 25MfjNBwHc7DPMlD4G4RYpQjg6PgcuXSJvLKomx0vYqMTNtXevU4/OIWf78IE5n9Fx
	 y60RTTnbd6NMb9gn9fIHVlBM1KYv452dSfk5Sx8LG/SmIA69HPjzSMmbAG0ImkGEuf
	 FdbOBhu8jThDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF97E4064C;
	Mon, 16 Nov 2026 16:30:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 950A74DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B30B80E48
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSSBp-gfMs4v for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BFE580F0C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=angelo.compagnucci@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0wnio/dz
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BFE580F0C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:45 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24247765e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794843463; x=1795448263;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=shJoh4HkZtF3Pf38eErWSmpEtedRqbsPkzen/c9eNYM=;
 b=0wnio/dz8Fkbvaetn/FmmjMpjcc/6g+A9XOLTa7efds0V5xeZm7RaLykTTSTaFKNjp
 FZKI5XO4xkel7spuI11/PMYoOBIOFakZDBZmzUAwpalpvwLprSZ/xMcMhcO98Xs0Ctdg
 B3SFi0OucAeHtD8Z3HR6EY8hsI2Hk6sPo2AS8KgYydY6rtL5vb13rj9bN70C9ZMZls3D
 cxRrb5wJ2VJHWKYhBlR+GaWKImBi1Z/jplUEmvvkNYvZuM23yMvVAmZlt+ybgyHBnocf
 9dz3BddGLJYEKELcFZ4Ane1FwR4P3HhHIgeSQqDcUc08p+b3BsPDJQ6oqFjFzvJ1OXby
 3Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794843463; x=1795448263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=shJoh4HkZtF3Pf38eErWSmpEtedRqbsPkzen/c9eNYM=;
 b=2gdBkG/fjfVz4okBXiYrcYBBjQhPnEgiGwy7OajlOxB2NhZ0+Xi/9A16+TEoyPPsmE
 JdVY7M1/WymyU4Ux7UavFF5N4vKohGnN3cxqpODwa9KvvEeiNSYfcnWPa/7xEEO8QKhD
 eh6tBuQsIUqSQAp4L+o90bYnNfPSQEXd8jWkgsmc/BbcXEG4OQQ+uICISTJO4MdzwjIZ
 C+jqsO8XUssOP6+NYnebvVRkG16x8dNzBgx7Dhk8RRgTJ7hFKrVfJGL2n6QVKSlr0wqz
 +K5OpfuDBcKug7w9JdbCvFwYlgRl39DncjTUCvPjgWnh8XZ5qobaxdzKXMslD5w4hRLT
 rShw==
X-Gm-Message-State: APuU4Z8q5w+IFijlp2LBmnfVfH0r7XD9oOFcNCYVayaP1lHFgxhlTtNp
 tak9tOHqOEgHgapxqVJy3enNFowfQWuCR3eBqVJ5g31hEyA14hU34Nj9h0Zlu93i
X-Gm-Gg: AYBFou3ftM9JT+lo+AI0sUtj1yA1Fvsj2iICnN0+Gy9W7SmkPA5zDkHoelhXZGIqeCD
 gDRDjqbkWeXN972weXFkgC0eizBpXZNOFLjrzMQrzBCFT1/TrcxnTUvEYhukQ12GMbK+d6FFgij
 VlI7dV+RB8m+wBsUunNNRV4ZRVb9PniP7RBx2Gn19gZKsQzLAdiL/iXhEsr+kkciw/ERqh8tvT9
 VtnvRT+iZUZK5kfNGRjbORv/eIALAdhriHj1nI7mxSojYa0MvA0Z7doeqHXIdClxWxmitBOXrr1
 Wi/Fd37JkhdYV467FJ8XBMiuv1IakYMvN/BT5EovaavVTwj+B8kn2uiAbpXvU4qcQjeK74jCdmF
 oKY5z8IvrqkbA9Vjz5UgXVZlb7eom0kw7MUBkmlVccmljYlfq4yWbfo234lBMA2tx91rLcYaT6k
 zTPsdNxNOexlIORCMTBDYCfXvLp4ntxb3vmuFvY1cdjeMkO1ATPxpNnK2yOWLaKSZLqCq/bFtpI
 8BfmdJF8FFh1KHD1u/xejjXhUagi9IoInfc0SRzoQH9eY0RVoj+q3xhGrs9pje0dfa/7OZJzHLI
 m/n03daJjY22bkBw06W6jHesdCPw/D9Dijhfhl8xFZ+VgfCJeVsG
X-Received: by 2002:a05:600c:1993:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb659cb9e8mr148531145e9.12.1794843463501; 
 Mon, 16 Nov 2026 07:37:43 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm296939855e9.6.2026.11.16.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:37:43 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 1/2] mtd: spinand: gigadevice: add support for GD5F4GM7UExxG
Date: Mon, 16 Nov 2026 16:37:38 +0100
Message-ID: <20261116153739.3958623-2-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116153739.3958623-1-angelo.compagnucci@gmail.com>
References: <20261116153739.3958623-1-angelo.compagnucci@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:30:39 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the GigaDevice GD5F4GM7UExxG. It is a 4Gbit 3.3V SPI NAND with
4096 byte pages and 256 byte OOB.

The ECC status works like on the GD5F4GM8. With ECC enabled, only the
first 128 OOB bytes are free. The other 128 hold the ECC parity, like
on the GD5F4GQ4xC. The Quad IO read needs two dummy bytes, like on the
GD5F1GQ5.

The same change was sent to Linux.

Tested on an STM32MP133 board.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 32fbe11e..cce7c73d 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -487,6 +487,16 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgq4xc_oob_256_ops,
+				     gd5fxgq4uexxg_ecc_get_status)),
 	SPINAND_INFO("GD5F4GM8UExxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x95),
 		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
-- 
2.53.0

