Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4F5C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 12:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 480CB6070D;
	Tue,  8 Sep 2026 12:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6TSUqC8eo6b; Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 541CB606DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788871490;
	b=GrLGkkUYRjCdpnynoovEtkOWHrDe4KA40s2K2HYvJHABiweMBvYCyELdrzJYlFxTjXFa
	 JWn1EzXafTx1aQd885tC4ioFzE9XRga/D29xU0LTsDK4t+tj8NJsAsfXDI/4WClWRpVqO
	 2NWjkzhuxJ9xltrWRTQzzYWJMfQAWQh+HxIOdbE7gxZAg/YNH3fO1JP1jPIefqrcA74vb
	 GvZhNdE/CyNfW9mCa5yoy8rXDTb75Hn3yI15Icv0lSwu0rY1Buu06qRALEL4+RveVhYwn
	 PLPhWQJ+9lP6JAtxt/nB0p+vrlkk8Po67OlKrTaA0B21S1mTvaBs2Idwi3eomqMKrAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788871490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3FkvIgy4HO/JXzDurPHGdhC8SWYwquOacE+CjOxDprI=;
	b=l8uOsYe1QwkQ26kCKIwnGqR7H623l6bdbhHU14fcSLQ+pmZG701ihWZsSubKn5BRVN7E
	 cPeX4qpf8G7YhWbAuhsvoo/+0M0AtWbRx1a47CTi8JjURlZkAPjK8c+cEb+buQ83xo+6r
	 ByrDLwdTP8G/T5QzUqART5gBVu0A+ly5WUGGtakYa6RBivtvCHOv7NLqReHxn3TiqHuOc
	 fyy8eFitHacor9GfOQhKkLjErPq3lEqrXbrl6BWNtTVevuLzuRFcVgjN+cCN2nBwkzJja
	 eTAki81Ygh7HuYbIZx6Ejy9SetPEYz8K/JOvGwaInrL94jz1VA6H/3gFtkuqae8fslQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788871490;
	bh=3FkvIgy4HO/JXzDurPHGdhC8SWYwquOacE+CjOxDprI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sl9pae20+74FfidhB5AtLMX27Rg1JxZaYRLaEdXHaNMaNc3ZKRZGB+o5l6G281v/X
	 lgciCtblIyPQMJVfoZepC4WV5SQIC583StCdRieJ3RCSMGDqp9uontloCEfuUVCjPL
	 RxabLTpDB2jaXpQYXIxXG6xfcP7Bjmy3PHXUvMSM6hjyVF1rZguoKf6Fg+nbVGChI/
	 eGKc5bPlAJX55zxS5wKIofzIMmRTA9NRPVdQlEFYevqMCUjiw8lpukT9sNqYyudxEF
	 97THJ8mXqPAblgOd+x2AlHJzNx05r7JKgjuRIjzL3uXm6FcWq29Pou8TLN501g857H
	 V89uJfEVsouKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 541CB606DF;
	Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1B80D5F
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3C8D809E9
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDay921EpzOy for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4221E80883
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788871486;
 b=aziVZMK9NPVMWHA8jCUcmxARYAXCNQn6VupoANAxopOl9c7KXJBRla573rJ21QsEqGzK
 dWlOMhg0vaKysJMP3OsplRf6sdfzY9xsstnPbD5h94TZnfQ4+NsmLyI5D1aO1DCXjRH7u
 NEcSFA7eNpQcsoojcbwkCLe3/8wUslDcbkrAWyXGrdOs1HepjBUw0fQFdmDD/y/hDNZvt
 FiBk3ubExHPF7lnt/lV9PNo46Mn0QjN4LL3WLnbMEt2X+RPAeprSBDWREOlxVsdJPph+y
 OjgnWt9T2kCzjGd/eRlQnSYRZQTuiP2RrzQ/AJKwzxUUnMet31Z60YB1TyKd6XwkUOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788871486;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=3FkvIgy4HO/JXzDurPHGdhC8SWYwquOacE+CjOxDprI=;
 b=EUKO/FMB4tblaHtUaOxk5pj21p3//fTjJ79tEQqOTJ54Ak0XIQ7Q3QiQIux3/mGz5c14
 TZ+8/HZGWplken4R0vB6NRbkCMaoVIjDgDF79kf7p+uhAKNyDwHFUxmBOCa2U3+WgDiAM
 0AK5cfeDgsetggqx+2p1zoBil60lVhVkyLUM9HbXfYtj0sKKKr84GAJbyncWSJDBI3uWa
 jnxlUFTggd8MlLdyUsj9+XjBOt2MZobrFuS/4Yep7v5LgRoY1ZXelp2A7B10sDzmup1Tg
 c9F6doZhe7rBBSO3/BfjQAYcWZuy5ClvoNbR6+q7qnaSMTDRcW5ItajShFG5DWlh4yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=KRQQJwrK; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=KRQQJwrK
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4221E80883
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=3FkvIgy4HO/JXzDurPHGdhC8SWYwquOacE+CjOxDprI=; b=KRQQJwrK2GHspHuKEztZ0tHdde
 eNPkrhbPmiNXuezXLCF7JV572bavC7dleQIfxxM+yyQaOeUYyRBBMVSfc1o7AArsmkezCbnIUM30i
 QDe4/2AhAcj4XBcAm/yF6roYm8W2Vah39yARm+OfvHadoKX6vZag5XKnOxVXe90tlBOeNhXp7/l0g
 72cOItxsyf1LUq2AsnjB3uKzSVR3BJxcGvR8BtNW7Hyre4n/ra0foHziohhZdwAkZ7ACV7o1yhlZs
 5xV+7cL1YOMAcTEXNVp2Je+Ve63MQBgD0wlyOPTg87MZduCTDcgLNJrqmPSY97l7NLPaMyTI/zs0V
 Va1+C8Lg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBr-000Bun-0a; Tue, 08 Sep 2026 14:44:43 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBq-0006vC-2u; Tue, 08 Sep 2026 14:44:42 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org,
	u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] configs: tqma6: rename TQMA6_SPI_UBOOT_SIZE to
 TQMA6_SPI_UBOOT_MAX_SIZE
Date: Tue,  8 Sep 2026 14:44:31 +0200
Message-ID: <20260908124434.894275-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28117/Tue Sep  8 08:26:31 2026)
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Clarify the intended use of the variable. While at it, increase the value to 0xf0000,
fitting inside the SPI bootloader partition of MTDPARTS_DEFAULT. This fixes the SPI
update script refusing to flash because the size limit is exceeded.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.env | 2 +-
 include/configs/tqma6.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/tq/tqma6/tqma6.env b/board/tq/tqma6/tqma6.env
index b1d7e5cbbcf..ee92bf0bd1d 100644
--- a/board/tq/tqma6/tqma6.env
+++ b/board/tq/tqma6/tqma6.env
@@ -29,7 +29,7 @@ uboot_mmc_start=TQMA6_MMC_UBOOT_SECTOR_START
 uboot_mmc_size=TQMA6_MMC_UBOOT_SECTOR_COUNT
 uboot_spi_sector_size=TQMA6_SPI_FLASH_SECTOR_SIZE
 uboot_spi_start=TQMA6_SPI_UBOOT_START
-uboot_spi_size=TQMA6_SPI_UBOOT_SIZE
+uboot_spi_size=TQMA6_SPI_UBOOT_MAX_SIZE
 
 #ifdef CONFIG_USB_FUNCTION_FASTBOOT
 
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 00610e76869..d41b5fe418f 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -36,6 +36,6 @@
 
 #define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
 #define TQMA6_SPI_UBOOT_START		0x400
-#define TQMA6_SPI_UBOOT_SIZE		0xc0000
+#define TQMA6_SPI_UBOOT_MAX_SIZE	0xf0000
 
 #endif /* __TQMA6_CONFIG_H */
-- 
2.43.0

