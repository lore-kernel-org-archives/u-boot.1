Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9CBCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CF6D60D7F;
	Fri,  2 Oct 2026 16:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJz6j1ic73mD; Fri,  2 Oct 2026 16:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 46E4E60D70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959653;
	b=lC/CiA8GIVq8imO0wLyQpZNra5+lfhq5DBpBpRkx2IjFYSs8OTusd9MqoyTqghVU2wit
	 DaCz5gxMPv8pzs1tKaZgADNVa/oYmL5kP/cv/PYpDOD7zHsTX/fSzIohyTBXI+gtRkBhR
	 oTMDTf/XLBDxPxY/5HPXl6h7n8YRCGyPB+X6rPnUHszB/X969vD54t2/qcT3XNDmlLo8J
	 RIY6ub+y12Lr/fjl3lzRnyc8ayNARO+TeDl6y2UtRgScZ0rFS/Q74Ll1KnhJUkmD9t/Ax
	 qQ8tW6dC7iBQX4R6ZaobDv4rVp1tqUHbA7JDVgYL9K59vG5/AGMX1NuA62genBNT9Bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0EPJY7pUcP1pyFcu80nVLOa4o+dlR4ta+WBY+MOWNAU=;
	b=PgljUNo2G/BhSXcX7keXyO+rzMwhSerX1IXVsDEbs3+pTy95LZ0UVvjPOEzFoItj5fYT
	 J6Th7hBdUeB1wDIhHTPOPebMhIb1+NV0Ir0gcLsw4bjCECe5r1TJuYHpBBQZ3d/ilUY+y
	 BOsQ/CN+5LEfzl8dpLZn+WZXEBRwtPThRzP1PxjqQKgPF4shgN7jOVi7iOsB8jC/ck0YA
	 1fyfm6lhaLW3sBYK7MfAYmJ/Mz4G2m16hzOB0C0IW7xxkIpuYzC7mxVdmQJSsbup+9z+I
	 yxaAb9Xgu9dZSiCGvXrv1bSClz07pAHegTEkc/lybazA6gNrBe7JgtAgG30tyYVrLGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NSOXeob1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959653;
	bh=0EPJY7pUcP1pyFcu80nVLOa4o+dlR4ta+WBY+MOWNAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVlBO3ojaqhG4C5lvtTxBToGoaQQAAH6S3SDgRFGIeWrwoNLjJ9JhZ9QD7GiPEdiY
	 WPgydHaZr7zfkSInBS92IuOhJC4sHv09VnVBazJdimeRNJyeShQUXyepGFd8I8MsqD
	 /jMZkhGljsvPkb+1snDWcbYjKfIWknr33suXm5fLxhWiqu1SgOrQi40m+I/TvT0/ju
	 iD81PoYTKgmbv8jgcsUfWwTCiWcsWcNtLrZHY8V6AuShSWIFLxF2RaeevDHdW3eP5y
	 0uKm7Znm7Edb9+GiNtcogukdS9xzLu+b5W6SG0VjlVHUp11F3CK9erCCZ/+aZwZPYO
	 GQJnbuIQ8rAwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46E4E60D70;
	Fri,  2 Oct 2026 16:47:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8FB5282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAA9F60BBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aG3OPNTLPXSF for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0E91760BBB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946852;
 b=DAJ8u6ssVvt6fjLOq7gITo9sukexiHjb1uT0+XzDNMD9Zd9Ke4WbXpP+NJQH6/2paimr
 Ro61pBYzNxf0CJ1vW31sqLXNqXGa5S1IA+VEJqhrtls6F0cgSYlpr+0xjnHI1L0xczy0d
 vheo1KAd2zdHRT6Xa33zHzKohw4BdM0pzq3VQ1bkSNVQzeZNdPM4Lm/Zce/Lsk4qVPhVR
 QB9T4JWGE2xrBs2DHSh1O3t6vRO1L3nCU3gPRz0DvqzpYSBIHgb7MdL1xGYMk0//Y6P6/
 VLmi1sQ429EZ8qrRfjRuvGvjpOuC+I1lFjlIs9s/MP+T+UPacO+7YfaICWdnXjAtowg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946852;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=0EPJY7pUcP1pyFcu80nVLOa4o+dlR4ta+WBY+MOWNAU=;
 b=ZHiqnBSgEHE8cLdzEbJT5VGWg9CsWd+mNPXJrFy+07Ad0wu9tSxyaVPwUQXdwj609wFi
 5LS8IvkAtOGOOn1bzaQI/OXeHCRegum6xylBOoJUS5DFYVbkj0Bb1smSDR+P/7Kypr633
 4IlcV/f9fsZBRIri3sjwiArKyUVi3m9BSfnliEA4wM8CuXesseyGJbcDZLQoeK6KKQm9c
 HcBM1ZIgMbqWj5/qALSdoRqxhPz25O07tNeKRFCGk5wTDl8LwKm241NAjf2hqeX3S1vhR
 4OIX7ow+kr4g+mLT0kO1kzbsEJBQbbuO8JcvoKOFDgckyUKEYG7Fl01jjW7q/VH6zgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=NSOXeob1; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=NSOXeob1
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E91760BBB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0D11B4E41113;
 Fri,  2 Oct 2026 13:14:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D26C0603DC;
 Fri,  2 Oct 2026 13:14:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7240110328213; 
 Fri,  2 Oct 2026 15:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0EPJY7pUcP1pyFcu80nVLOa4o+dlR4ta+WBY+MOWNAU=;
 b=NSOXeob1Uytv1ZVFJc7bhi5JIpzqBXawS+Yy9qukILQseAZcW48ZrN2JtnVIIzgHSs00Kn
 NlsdT8abUMqjqjgTUMkJ3muRaVvWR7715KDz5qgqo4IweedsVI5B7XAeVCwBhZKhJO2JQs
 WbOrfkS6KADUy4wCzdTORvhWjqX71eGQ9QaMeOLo1ebE3gWCNej4xuPkcV5eLe/qBeXEcS
 7l0BK3b60Ye/BFenv16EqISi5/S1kB7lQkh2VPO7SBbbQ2ISIAMHh0dnpqg/iGMXw0GPx2
 aui4n9PwWmbGYiVSXF5iLlSe9hNsjOt64QJrB2yzuYIKvZ5Lx1jZ/8H92HpDbw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:22 +0200
Subject: [PATCH 04/10] nvmxip: Make NVM XIP devices available in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-4-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

Add the SPL variant of the NVMXIP option and build the driver when it
is enabled for the current phase. This allows the SPL to use the block
devices emulated on top of a directly mapped non-volatile memory (XIP)
to read data, such as the next stage image or a firmware, from the
memory-mapped flash.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 common/spl/Kconfig   | 8 ++++++++
 drivers/mtd/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..1c0628b2350 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1605,6 +1605,14 @@ config SYS_SPI_ARGS_SIZE
 	hex "Falcon mode: size of args payload in SPI flash"
 	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT_ARGS
 
+config SPL_NVMXIP
+	bool "NVM XIP devices support"
+	select SPL_BLK
+	help
+	  This option allows the emulation of a block storage device
+	  on top of a direct access non volatile memory XIP flash devices.
+	  This support provides the read operation.
+
 config SPL_THERMAL
 	bool "Driver support for thermal devices"
 	help
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..7ccc5da6d19 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -38,5 +38,6 @@ obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
 obj-$(CONFIG_SPL_UBI) += ubispl/
+obj-$(CONFIG_$(PHASE_)NVMXIP) += nvmxip/
 
 endif

-- 
2.55.0

