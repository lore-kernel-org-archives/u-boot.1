Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A2FD3763
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D02383F0A;
	Wed, 25 Feb 2026 14:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TonbOGuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DF683DEA; Wed, 25 Feb 2026 10:07:01 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFB482A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flaviu.nistor@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so4777000f8f.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772010418; x=1772615218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xbAqXyssEZe/z/4xijeYmINAffL0uZI4/UFugWRBCp4=;
 b=TonbOGuLVql1JzR8xs9WwaJXLBh4/VuTEKE97GLHIBTHFqeC6ikKQS9LJv6LQkH5rj
 8MMDZmoUEjEFsA/rAQlqreO2peTqUljUr61Hugpjuai4snxJfzrXpusofeH6zJuoBBhz
 b1FZGBldJxTHrDewE9SUJ/EAOss8GUtrTqNIWLmQKVthhesXLapcjUkXmgMC2yWeHfqh
 13gzvcw4aanWFl54b+5xFSRku3M0KB6QK5Ken3tnrxaUfTL7uaPi3sGZqHC+x/OJp29n
 6l+NhPu8eOP4jOZkZTOq9KwsOzTgRq/MbU6WyA41y4QcXoacsCa+YJgeOKzfw0+K3j2Q
 qE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772010418; x=1772615218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbAqXyssEZe/z/4xijeYmINAffL0uZI4/UFugWRBCp4=;
 b=BR8cS3EQgxucP5sE8yQ9Kesv4nRBw9eLCTnOyC3vtYjhdfKZbhSlHtIDgmMFM9U881
 C1wg9cV3nW/bRcrNfxuFOQcVJtEgS2W2Xi7sbhw67NU7CR6sXtAKctXbuLPiO6bab7/H
 Ifj56vdztsJYKcVZFcF7MTGY3KiA8Ap1P/B3xPI9xKFv9U90K6eZt2Zy8rK1ygC4FvJl
 OkLiHp6ctpL2RJZfruptl0jOuekg5L4WOQ8Dxqf6Nf73PfggkFeEzIIqxt68p70dk5mO
 V/dLBL63cO2CNCBjKBTRyThDYDysVnx6rwTcsEkJ8GLj7OW3Eroe86ZX720eAX+hjAiO
 SJvw==
X-Gm-Message-State: AOJu0YxmPMDR5/TVJbefVsqojY0PEDbSaBwuuWJO55eflZVj86M7JExM
 KSEYim3aAcFF5lIWGSNW6jq4W8Rp3Q4S5Mtr8mlSDFSllvQ5iQlZnZtnTHV67w==
X-Gm-Gg: ATEYQzxOf39teId00oBg3Xpi3X/+7i3FD/zFKOEveQ2bFlIJCCHMcTk/HhsMjAWDaoX
 DXvvpMpYyh3TfzpKkBClVpIITyWuQI3jJtnphfqu2PF6R2rm23sKPz9juO/SRtXZanyom6h4l6K
 CSkdeIWK6VeNvcqAc4L6OYZVb4zG2nG2Hh4CTueoDK1A15HrEi4SFhpHFUxKDZ+rerZY/ORFfQY
 ySMnxPJ6pSL9xvg8JqBPoDnnoGqSHwxxhqK3zsuioe+8s8tZme4N0Ag1KpFU6oqGBou3XnrdmHt
 LY2ik5I4sBOuI1DzNbVNOBPaSOJbUlsDIepaNpKgrQGhgVWQ4snH9WpcpjhbvUX7MPRa2Vml6dB
 VHrLQgjeFeJvE8rsBcaPxcqDdCa2K5PYMYahiTfGEExK2F555UZ3N27zmX6eLGeQFoCwRVVNHte
 lFJpKxGtn4s0oFGZ17uXfxlodUL0ALI6uyOMyJiU+xhqvD+f3sKp3Q3qalVxDl0N3cuwdPlSgjX
 7E=
X-Received: by 2002:a05:6000:2689:b0:436:19f6:31b0 with SMTP id
 ffacd0b85a97d-4398fa72a2emr2704870f8f.4.1772010417570; 
 Wed, 25 Feb 2026 01:06:57 -0800 (PST)
Received: from flaviu-Aspire-E5-572G.. ([93.122.249.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398d568772sm6023237f8f.0.2026.02.25.01.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:06:56 -0800 (PST)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jeffrey Yu <jeyu@issi.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add gd25lx128j chip
Date: Wed, 25 Feb 2026 11:06:51 +0200
Message-ID: <20260225090651.25912-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:17 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add gd25lx128j GIGADEVICE chip to spi-nor id table.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3bcb0d7b7ba..b79cbcb2858 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -202,6 +202,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lt02g", 0xc8661C, 0, 64 * 1024, 4096,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd25lx128j", 0xc86818, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
 	{
 		INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
 		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
-- 
2.43.0

