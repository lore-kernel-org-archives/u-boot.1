Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414D606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j08KNp3k;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOWEg/vd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A17B6086A;
	Tue, 24 Nov 2026 13:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thYtudXRq3P6; Tue, 24 Nov 2026 13:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D07360841
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526588;
	b=sMzAjieKzMqCbIYqU5MU3yOwxuNT1d/Ef+P3x4UVj6kIhHBDegf2PcIAKcnS+93zNeUp
	 /seiW7ArOrWKk+BrWSeHT+7CRd1BUDIoW8H1+vmW5Ki1fO2rhu4S/GS5Ny+6SAde9T1tn
	 r3e0ifW9Ppw7QIra2Xnn9pYb1elGEeb8KKcNeaCGEqFjjmtYuB/LOENaVFNYOPAFO2BiT
	 oOW7zFQPJe4O+9qN6YlJwdJ/NQQq4Or8RmjOxFw/8Ri7LGWcRZxOHWbQLi7UrnloWmWyZ
	 N6keCwC5xAZYhGhN/AbMobk5hkX2PNMgeeRVbwYnp3ncWvqngMRCNJlV2d3uhMltvJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Y7Pg8HRXM6H65VKyXQXYPAxU9NOOFSd7GtBX0Zpxds=;
	b=CAewOOOQNdI/+rqqZAKTqrf0wYqNnrBCgF+fE14SfoiVoGbR1hfHwl6JXvU7cM5WeRsY
	 Q6Y8Uo47+2nXdXryBVrUkVDcRFs06KfGNf35nAI1PdL/0BIZAoAITx0e97DnDI3bSM+x2
	 9RxFPSrjruPUgNsuTxconPBt4XztHSBzxVoaUQVl8ngLlW3Ww+qFpbufbW/1MJBaJYkeu
	 NK+3BPhZlhRk+gSeXX7kSFnoguLz0OY5YmymfYO1/QO+xj+FHqnLax6VZrnT7y8lceLDN
	 D1hXcTAqdsIDbGhezHJl4LqDdAt79TNVs1YyfKdGreM03HTuXew5UKZMV6EDPu7qcfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526588;
	bh=9Y7Pg8HRXM6H65VKyXQXYPAxU9NOOFSd7GtBX0Zpxds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j08KNp3kcNb/ddItGiIDxMMnXJo189qeK+zf5NCPBTNtwz964pvulyO2aWVaJyXrp
	 SNCR+cxpDaaiv8qelFNgt1Ay9ccpZLwb607i69pLm9gd0ApEZEwaDdgbjCLDLeDITt
	 3bT+x4CjOTJpSplyhwv0aBQcA7GWqbvW1gVX/v3IacDNMecqw6DVk630XXNed+zM8o
	 lUytQrWNUbqaDy4h5ZzE2dP/Z0bn5XYKVYaodi4DjkZZ1zTWNoOuFdje7Q7LcSvhgS
	 5fUlJWK5kpTeIJhrL9oMEIhqe14W3Dm97cLZcXwPoegJH881aia111bwFwjW6mCVWj
	 nvfpMOpvqMLXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D07360841;
	Tue, 24 Nov 2026 13:23:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39FAFFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C34A80D6E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ThCk16VVTJ3 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25DCC80E3A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bOWEg/vd
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25DCC80E3A
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:46:39 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so1906328b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795520799; x=1796125599;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Y7Pg8HRXM6H65VKyXQXYPAxU9NOOFSd7GtBX0Zpxds=;
 b=bOWEg/vdH0rWs2QkIjo9PefTsvvFw5vrmBQVYbowExUmEf4FKNFwt2EGoqvmNgHTqk
 O4ZCSeiMn7q3KdG+yhCjME2HGPQ69e5dJBkbQ1tS1UQA3+FspDPKdyQ0oCRHmo9fzrt/
 mT9gQVbD1LLY1PjKvRwizPXVvUwUZY/xQ6N7KFclSNNXfFN9TgNydGYKBVut5OCjp3lu
 BluDKi3VoWFqiBgea5Kq8v85tVaRTLF0OSgSnfbuUBlHBfANl+0hN8/oKc6p8Q/avCPJ
 Ghs/QY8A6vUHuXE4GaQNCjOBgi3SaYQuOp+loeH8UuBo1LmRnu4kh1eSZ6TM+Ya2/o1j
 QXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520799; x=1796125599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Y7Pg8HRXM6H65VKyXQXYPAxU9NOOFSd7GtBX0Zpxds=;
 b=KTZOW0hdVpuxB26hxsYIZ1GHhxOsrRz5Tn1ulArZN5eVZ7fA+R54SlRU5rO04Sk4SI
 sHW1+J7P6e5wpL5n8opVuvjUo8Tvz36FaWr4HAo5akMMgGMRyRcJSiV+l7wXGkdeLvVC
 D0B1u+wa6WhTiQZ9rJBtdcaeuUjOy5IHfIWmjO8k/5KjwWXYVLpYg7OuRvXexpYWq+Uq
 zBp+s6fIB+K06U871P5t5mM2nFKyZ+HyVnvooWqk2TuV4KD1nHvBW7uSb0+gsDPhfvJe
 am5cFLm3qO6YnhGwex3q9oA8s9/6zBSikQs7qNMy/5NvFQ+IJNsFOOqzygs/f4nEoHZb
 d9hQ==
X-Gm-Message-State: APuU4Z/KMqC1cs618c4b+65hIbWiR1dmQqJeJWvIZg+MROzma9sItASs
 wiHMAQlpGu/tz4ZviRvmSiMYGuc4mZXXsjpjmakmNBEIL0biOND9A44j3Q7ddFN0mAY=
X-Gm-Gg: AZFdTZdX3Bl4+gYak+T1cyOmixTIDvqlk4FWfUXUMYSt4PJWQNXinb8WquG1Fvd1510
 ruAQZMMq6XP0DGQGC/IUmXi7widu0NVU5C0+LZVs1bb7Coq4v2h1aQIp2kC/vX/Gu5wr3M7GgP7
 3Mja95KT8dD9/SIGpXFRAhEc5W+SL+2z69qZiIBYGgRCtVVFmOS2Er+/bM585QSn5CVjBt58s9+
 TBfuuLuRPK6W18hV0V2JIg8wvGCsSp0vpE8Z3sV8JdMi0KIv8YZQZF2mjiL4le5tpCJmMu8SFql
 Nmt0PPFae5UVg0ep3kNN9+x9e5Tp2+8FND5z2iusxTHw9Bt6GAdF8VMjZF7cWs9g8OpHG0Iba7G
 f7zWkw7wwp6LbtnSGiolD8QaNpg41T4pDjY+035o9ZtYZghTFZcO45mWQwtbb9T1ZtByuNX6bdc
 0oosdy2afb/l8H5VhhEVRNSbEen3Nfg4ajQXralgb8yLPHWxD4JKmGR3mJjauR2LPk39GG05YVy
 0WJChpLcrZUqi6QNLmAVnhYhXMgEB3JLIp/lPUCyizsd2gkhIkeHg05ROGNFNfEuuYGGcKrSioy
 lFKYJ5dQgJPL26NvlL6zqzUP7BVqvFg=
X-Received: by 2002:a17:903:3b88:b0:2ef:e0a1:1015 with SMTP id
 d9443c01a7336-2f03f1fe25cmr128532835ad.27.1795520799028; 
 Tue, 24 Nov 2026 03:46:39 -0800 (PST)
Received: from Sun ([117.89.123.184]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f120282sm67075685ad.59.2026.11.24.03.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:46:38 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: takahiro.kuwano@infineon.com, Jacky_guo@xmcwh.com, vigneshr@ti.com,
 hs@nabladev.com, Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Date: Tue, 24 Nov 2026 19:46:28 +0800
Message-ID: <20261124114629.369-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
In-Reply-To: <20261101131239.1566-1-ssunkkan@gmail.com>
References: <20261101131239.1566-1-ssunkkan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
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

Add support for XMC XM25QU01D SPI NOR flash.

Link: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf
Signed-off-by: Ssunk <ssunkkan@gmail.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---

Notes (patch-v2):
    Changes in v2:
    - Use the Link: tag instead of Datasheet:.
    - Add Reviewed-by from Heiko Schocher.
    
    Quad mode, including 4-byte Quad Page Program (34h), has been
    tested successfully on hardware. The updated datasheet provided
    by XMC confirms support for command 34h and will be made
    available on their website in a future update.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index fce22300b61..7332949eefc 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -684,6 +684,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU01D", 0x204121, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.55.0.windows.4

