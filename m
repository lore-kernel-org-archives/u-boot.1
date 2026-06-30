Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BB5C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC6684A67;
	Tue, 30 Jun 2026 15:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/qGLK8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC9F84A77; Tue, 30 Jun 2026 15:32:50 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0472784A52
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6986f5f9ff9so200942a12.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826368; x=1783431168; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mbHx5gijNAQ1phsLKVHW/DRbhCIqiHFuO8ka5ZvgXtY=;
 b=g/qGLK8W7kOyvs68stsJRtX+EP4wiQTxA8pE3WXazq9KqyVCREEQXaEWic3H3+/MIh
 X+vrNlQYTcofOrMsVU1nAJFFuGL35U6EbUBFFFM4chwTnnrxYreiC9nKTIMDcKtjQkse
 KEfPav748owkTQKekRFUXE3txzUaDhUoC3DBu+fwSe0XI2/rrxTbyFmv/IyDfPqkkrp2
 +dcK0lT33DlUwkxAWnVnT2yR/O1V6P0S+rkbWW0XSxNcz+9Nl2BVXQ6DkbyKtORNbelc
 ymJGsNutSoz1ZYVspKXqGaM+o6FcYn03JaiRP1lrZ0dlfMoWeQiJtGCiDLwkuResYDFN
 Vc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826368; x=1783431168;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mbHx5gijNAQ1phsLKVHW/DRbhCIqiHFuO8ka5ZvgXtY=;
 b=jxxsQclUH341vqp7QdYhybeCOiuFiVJojh74q/PbfrS/mCQyjGPFB8YqA7eOf3axVt
 9QabevqwwWhzOTummuOu/PuDhdJusb/ujBijwVE42HXKfCdGg/+PFMmXswAVs93bvFV9
 iepT2e/aEM7emEYjBkRgGQNFUIaMxQb5map+/NKpQ+3uhymf6xfDOyE7ZA8byZisGraP
 MJ6hmtG4kgZN4zJ76wvH+kJoF1APvO30V7b1elxjdlXAPl0Ive2lIZZpJdQEq6JnykCF
 63Y42/Z181dYQLUtYK3Z9rn/bZ09hiwOVdDQnd6qz0maD57WWKLORvYRR2OyNBNmzxK/
 lLQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/juNKgJLPYbcOWWvYxF85rFLjrIpiKq25U+wcSbdqnajKHo+1Rd63gtE2oiD+Vf5icM5W//0=@lists.denx.de
X-Gm-Message-State: AOJu0YzUzCB2OiqaA4XQgefo/yhvhJ5vQ5Tv9HVSrx3zT4qJojNKP4qE
 zu/ODdvOCHvNhBtzdxFB3aqjOqW/mpSFlG5fXCmv79AO8JtAT3s+89WA
X-Gm-Gg: AfdE7cnB/nfDQTI8VX3yfzEnaeDMrtgkiounvVAMZ3BLbfjAuQ+YLmAzL4y46Fgepdu
 7qpNS7PW5AkAfQqC/1DXjFW+qBF/F/b9Nc8s9Hn+rQUXzhaK14P8QgqaozPMEclYXekfx8JSaqn
 4vmJJ41qew+uLEGGq/1OoRl4ARAa3gsf5awG5j2W3fNF29G6zaMdjurpGsVgaKSn3HzCMfzHy0i
 GD2vpXsg25CTF547sP2tQ1ucByj8WFTNmEAt6ZazZTA1y+SPNcnUAZfq0bzXRYutBuKsMM6NqKn
 HQX3+E1DwS+8+f4eiEVMFP7y8Bl8txcEMxvAmcXHuVkgDAysVrQGrhgfHUGNd7AXd1qWqpnebFR
 8cQ4PuX2BSkiySRyUwkumIoqBUTWlG0sVF12DbGLl98EIuchJ3fkeD27BT6CMC07ThoEN0jCN7a
 jUt2mfwZ1GnQ2MCWZ9NntVpx7JELH7zK06w4iKBGEG6I4TdJYWu0Q=
X-Received: by 2002:a05:6402:2746:b0:697:deb8:761a with SMTP id
 4fb4d7f45d1cf-69879e40233mr1055161a12.6.1782826368110; 
 Tue, 30 Jun 2026 06:32:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1289176ee2sm128165566b.58.2026.06.30.06.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 06:32:47 -0700 (PDT)
Message-ID: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Date: Tue, 30 Jun 2026 15:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix oobfree length
 calculation
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The oobfree[0].length calculation depends on the
rknand->metadata_size value, but this is calculated
after the function rk_nfc_ecc_init is called. Move this
calculation to a location before it's value is required.

Fixes: 1b3fcb3c0456 ("mtd: nand: raw: rockchip_nfc: add layout structure")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index f730e15d0410..ea8e67d1a23e 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -861,6 +861,15 @@ static int rk_nfc_ecc_init(struct rk_nfc *nfc, struct nand_chip *chip)
 	ecc->steps = mtd->writesize / ecc->size;
 	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * chip->ecc.size), 8);
 
+	rknand->metadata_size = NFC_SYS_DATA_SIZE * ecc->steps;
+
+	if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
+		dev_err(nfc->dev,
+			"driver needs at least %d bytes of meta data\n",
+			NFC_SYS_DATA_SIZE + 2);
+		return -EIO;
+	}
+
 	if (ecc->bytes * ecc->steps > mtd->oobsize - rknand->metadata_size)
 		return -EINVAL;
 
@@ -974,15 +983,6 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
 	ret = ofnode_read_u32(node, "rockchip,boot-ecc-strength", &tmp);
 	rknand->boot_ecc = ret ? ecc->strength : tmp;
 
-	rknand->metadata_size = NFC_SYS_DATA_SIZE * ecc->steps;
-
-	if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
-		dev_err(dev,
-			"driver needs at least %d bytes of meta data\n",
-			NFC_SYS_DATA_SIZE + 2);
-		return -EIO;
-	}
-
 	if (!nfc->page_buf) {
 		nfc->page_buf = kzalloc(NFC_MAX_PAGE_SIZE, GFP_KERNEL);
 		if (!nfc->page_buf) {
-- 
2.39.5

