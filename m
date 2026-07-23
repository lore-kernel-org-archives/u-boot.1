Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F45C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60FA760A5E;
	Thu, 23 Jul 2026 15:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jDxaYFDoa4e; Thu, 23 Jul 2026 15:23:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEBAA608F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784820185;
	bh=qeil3AKGO8uYeiVsbctaSbEUu2pFAlbySyfIGBcZyu4=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F08ZM72ekVwkMk+b3V/84nPH80z4RFWTlVtdyJVWS+SKYuAHA8dOnvMrTXKw3jMM6
	 h1J9EfQwm0wfsYbzE4QN8Y05pbBOD++4RYbaHLoPQBAtLNyAvtKEt258CNLcHxHgAT
	 NMF0rXnvy/15JoE6cRYr2uA9rHrvD5hfDew254QqlovXdqAK/vqkGR2qpD++WSRtgW
	 qEGsJ1kbj4SUUBEmTv1KbXhAjIYBrvO0TVg+g5yJmg086/5M0C4Yw1hKtGsYwUD9zD
	 PBHhf1UerdECPwIPaBN4sWCtC7YJl7ciJvdZCu+4Al7sjTOvV8OHLtl66XmzZO/9SD
	 cgpU+xtJcszTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEBAA608F7;
	Thu, 23 Jul 2026 15:23:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B709E707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8EDC4020F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiBryUWLFYcB for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:23:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B570F4008D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B570F4008D
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B570F4008D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:23:03 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69848c9462aso171587a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784820181; x=1785424981;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeil3AKGO8uYeiVsbctaSbEUu2pFAlbySyfIGBcZyu4=;
 b=H+O94I7x7XJa/IxoExjYPw7LBJcuHRRajVYBlCsxSM+d4zjWMyUb7LI2AxdLrKOUZX
 c2RHQaCZd16RACvUFx1uArrDt8bPAnhsR+fIl59mDBVUqfQu0I1w5xMpTpYAB83/kGpA
 3tt+hCLHYoKnIBOVy8V2IUa/nEVRdovesm0l/0YbWHElH9/MSsDwUzTEEsLAkwNou7vp
 /LDBcIaUq6o0mAp71t6u5lql9bB8fyIjXOsIfAUJ2F9V7TvrpQu/LPY90xM2daOVGr+F
 kwL8TgRx534ot/w1kldZ5rw0x+SlaH7Jfi3N1sylpB7KX19w58/jsfcb5e7Pb9U1+uXd
 l/Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpg8+Ef3HZ00uQ7PhZoQD1yh7Q41J5rC6bThWm6QFzF+P/ORUMbwad3d9/tsWF03ciTYGvdtEs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz5GGyCB8oxspYEJV0znbfcgpOvKgh9B5gpc/zpLTN9YR+iPbiD
 Bzv2DM+xBuYdXvP5HFx7EiQGPjqHW8zvAO6GnDzoRUdACXv2TujRw62Q
X-Gm-Gg: AR+sD137+Vm4Sz7DC7p9tnkOwaX1pyx24bFpwWXP+VCDvje4XxF8gCQVchfQs6yy4cN
 R17dR5V+48RygKb0G7gAYiuz5U0ybTZlxzGio4jvye9x0X0OjElayBIf2+XWsiF93fPKIQf81rg
 dFAmgnisgJMp7t01WTnfJil2cnEQ4EM4HDMg+oMiYB9u+OVQqYUuj0AnMYtdVqJpgtbOh1WevFJ
 GP/rOPShNnBc5YT6cp0Zp7ltRiMknnlikSS5nGAvEWIu7tSBOXqt26fn/Y9tOOAl0VsHTpetXiS
 nedgYsro+M1Lg2dq02l4MgEgjCVy50DaU25O6694zB6dprq9T6sooCBgjGrhx5uMg4ZwqDxAPXQ
 u01U1puHeC2kYyb3d4WjgIaq9Pp0d0lgaSyBYkkq7DhTIvOVqFlM/ZQjfLHR3cXeTxGJj1TjDQk
 gCeb5tgoGwyNlFLX77Kaj42ofXA2y14O6gQEFsSz7C
X-Received: by 2002:a05:6402:d0e:b0:698:ad80:a9c4 with SMTP id
 4fb4d7f45d1cf-69f8de039e7mr8153a12.8.1784820181038; 
 Thu, 23 Jul 2026 08:23:01 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c4196ed98sm196492866b.30.2026.07.23.08.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 08:23:00 -0700 (PDT)
Message-ID: <5690db1e-4de5-44bc-a9c0-58ad23662753@gmail.com>
Date: Thu, 23 Jul 2026 17:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784820181; x=1785424981;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qeil3AKGO8uYeiVsbctaSbEUu2pFAlbySyfIGBcZyu4=;
 b=p4m0+/sN4vbbF13RkRC/OOrapN0qq/IK1sHkiQUnR+giRSk8rJfsmGWnjlFW/dPKWc
 UZZBlRyAIoxIySUyyFvvOGnc0s4KOjAVRhM+E1IlaNbZkhmznU1JqedBugFkybgbXM0w
 azhgfXlDBTp9dZui+Eb4Zmo65cF3C291x4hniUJtFn5gahn3PhGPvLKxndFvA6k7uWjj
 qasyHf4++1qlhnhY+uP2Or8NGUYssEPaAICzjJuQkvTw6cICJqoEs1wrPrNhjjBMLgIS
 L9QzqHwHxXI9HMBN68HY/WqZwCdtqF9DgB+2mIhvXxcwOcwPlqQKWMuaepBmHG6RglTF
 N2dA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=p4m0+/sN
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

A Rockchip NAND Flash Controller (NFC) supports multiple
flash devices. The SoC boot ROM only checks for NAND chip 0
and with reduced ECC strength. Currently only the read page
functions have this condition check added in the U-Boot
driver.

In single- and multi-chip nodes with rockchip,boot-blks and
rockchip,boot-ecc-strength set, the chips that aren't chip 0
will thus have an ECC mismatch when writing and reading.

Fix by adding the same condition to all read and write page
functions by dropping the existing 'selected_bank == 0' check
and use the NAND_IS_BOOT_MEDIUM option that was introduced to
U-Boot more recently than this driver to behave
identically to the Linux driver.

NAND_IS_BOOT_MEDIUM is automatically set when nand-is-boot-medium
property is set in the Device Tree, which is a requirement for
rockchip,boot-blks and rockchip,boot-ecc-strength and will thus
apply to all chips in single- and multi-chips nodes, regardless
of the CS.

Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Tested-by: Hüseyin BIYIK <boogiepop@gmx.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changed V4: (Quentin)
reword

Changed V3: (Quentin)
reorder the condition
remove redundant sentence
providing the use case and misbehavior

Changed V2: (Simon)
fix typos
reword
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index ea8e67d1a23e..d23a651f3692 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -440,7 +440,8 @@ static int rk_nfc_write_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -560,7 +561,8 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *mtd,
 	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks)) {
+	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
@@ -624,8 +626,8 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
-	    nfc->selected_bank == 0 &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -700,8 +702,8 @@ static int rk_nfc_read_page_hwecc(struct mtd_info *mtd,
 	 * are used by the boot ROM.
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks) &&
-	    nfc->selected_bank == 0) {
+	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
-- 
2.39.5

