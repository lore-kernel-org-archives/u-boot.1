Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F7C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D48E40B3C;
	Thu,  3 Sep 2026 22:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIrI9ymY7XvA; Thu,  3 Sep 2026 22:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEFAC40B51
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473603;
	b=JmBZK7PmfVCaomd3Gsf7Rk8U1FIDu+Jwkt7uyMWvjU7etA4WcDynYsewYmQBk7m+22nN
	 cyI7OthNUbHaDzu4ee1DRpoxtRW9hBsYRjng7Jad9/5i1oTkNauho1Wbg4ybfghnTxAk6
	 e68Qav0+EEipenBeMsF2cLpI6GcEWBfdKUTaGbRtfbGweSN1rS4KWtzWbVTDgzdj7iD3x
	 PC7AcK2lDqeHBP8BOa6tGf8C3si0FSqAdoMOopTjT3BUwaDz9quMtY47x1t1RLbYGM153
	 OD5FpvXISLFlIVEvchMhljHggd3xEVwoYfemVWYH8WGLBqbam3MEWLbIjtUbHF+vWJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h9vMEVPUQbw6Ps4MnIIVxk1Or8KXVJf7H9nqnhFWjoU=;
	b=F4R1wSyPze5M0RAv46dLLjt0+ZVucv9rcj78XZDv3os+3nH5c/NkMtzklj1iDgqQSlY/
	 ZOVK9nPj0XuWqQJ3XwIwTXJlzFVj3KA32rP2ymGRyZtVw+yQacxh0VvBB9wENQL3QUTgR
	 /221a/Q+imC2lu/08nxWjDzUjUCPI/b6B12q6P3+FZkGcrZd87R/Y1LaYKtfWymxGfqcf
	 CHpjMv4zeu8tsgeIGYIpiUbUPVymC8I5Y3fD4dhtjGnMJPwiLsiQVxeg5h5OhQL8m7Ym6
	 J3uUXA45x7DX0rx3VoNN9X7mEnPorLHpP9B7q0krDkvxFXUzuueyZc/Cy6G/DKlRvdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473602;
	bh=h9vMEVPUQbw6Ps4MnIIVxk1Or8KXVJf7H9nqnhFWjoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ri5iFJjpV7RwNkeKYzsYa1wtG0Du7jB/eyoA4W4y8N6niCzMnRKbZpFZL+hq1njOC
	 tuqORysncp0ueaX1WdNfCNzwx2qo4Fqipoa1f30SrWhLHhnv89vyeGq/XweZ5MPfk9
	 ygda2LG7QJK5xbzldpNHc2VPRs936HBZ8H+RO4wJyg6oVx00NlqtuP3ScHdGBA0UCa
	 5Kzlx54++6dnmBg/HyFznUqMNikUqQ2XrSfiJ4jfn4KueTeXE2xW5yltzy1dlFpFJL
	 mKKL5Q6YiEzr7C1M5o5RhAvhFiJHcg2iComUzU7dk0vM3jbSS9+boU8boQPMnEOZyn
	 lbdgdXK+tDdyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEFAC40B51;
	Thu,  3 Sep 2026 22:13:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93D2D265
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 858F040462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jrYwRiVc8D5S for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C0B4440329
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471478;
 b=c/rh0pNIChRq6FmWd0mljbUToubO/gJ92hvEIe/lH7s48K/izZoxVBwNv2qSYKYTaXIx
 yk5M0KgxfNgus9gc13ptEhYB+7vxThz6e1AzjQXSOPhuGT/C+uZHJ2j5U3rAXLdH18Tls
 7Ou/kwBytnVjJglqW8K8IttWqi7eMzs8ivpj261az3LOSysS3v0xp3VDMXRvV/pBFc4q1
 Ovu6AoR8bKr8r+WJkPvCHFverMaHnbBo8om8hT+7gRjeT/MpiRPZj+L9aZBeZvxwEkNHw
 U2RVxlI2PjzDci53J8OCo0O8XYyw+MB5arV4lficbnkR6VeYK+Q4j4GnAOhBusoRz4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471478;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=h9vMEVPUQbw6Ps4MnIIVxk1Or8KXVJf7H9nqnhFWjoU=;
 b=EQeYMh1kR1F0DPVIwNMQeFcIxOXgmynCILgof0KZXcJlVEpKKSFM/Tuyuh9f4Yq6OgiO
 gtY65Alox4oDXZaz1WEgm1vvqkpbFsdE24jcQ1b9EYHsOP+urv7P69vGxPA0msncChnG1
 3TdGxFiMxIaYUruuvmagoHgbaDthZyKLb/9/D50Bl5g7PDcbmZtHVhWPOv1WYTi97zZiq
 Zj6kgyq8lwxoLp1F5NVJAaZa8/Xd3Y7aHzvj4GSia3FJUoY/eqtD4N6WtmbiEiJQriwxW
 XwfG8F7GD0oak4+tCVu/Ig/DWbkeBkfhYhUrU49W+RbHsaFZpspdigc8HMzLTrOmf9Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gbuo6uki; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gbuo6uki
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0B4440329
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:57 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-465cfc7e33dso128173fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471476; x=1789076276;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h9vMEVPUQbw6Ps4MnIIVxk1Or8KXVJf7H9nqnhFWjoU=;
 b=Gbuo6ukicRxR5KO09o+NZqJnj06ceIzXRNH3ylrLTds9v9EpoFh45/YJf2KG8B9AX2
 6pYZY+Z2DNUHQ2q4kbjSysqoQ4Wjf6R7OASlStwQK4bhX/PM60ew1+u+iXi0CM7mdouS
 K1O4SvwKUGWzNlg2QRP6HKroRJ6mQxpJG7ovznFMd9/EXc85V+v1Dlo7dj3L0dbj8g/n
 gyT5D9Ukeu1PcLIEUln4t1yQpUUnHqKXcVhKG80UU/GqrPTvGmvRGzqtl1IL9o/fKfrT
 UYAcoBuIDHySkQGlge3SNiDpDZNVAwghv7Xt7OgaTEfsf8PJa3bu55ExFshD7u73C7CH
 t4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471476; x=1789076276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h9vMEVPUQbw6Ps4MnIIVxk1Or8KXVJf7H9nqnhFWjoU=;
 b=Diy4pNCY0vDaiQAxMGIMeyoDkbEtUtk3siflj0h3BJ0HWAcsGNxReKKJ3rZQq1I/5B
 X8xUJi7ga8Ls5bCADNU3gcgmDKbWaMJYyqGSEinOPgS4XlL6HJzTUKsGMB7tflieqwYi
 VC0EsstjRBpshpOSEizLBEtZJdmf8RzvPxofw16i6ALmg7FqzrtJN84uN1S1ct3L7I24
 84YEF6jLjbjdFXQ+dnw43OC3R6B2dwaFDvZ7RVWoWzx96lLFPNsZFB9C6wC+USnK2DA1
 iKI8R6L18HV2hYNXkTRU6R6b52iZvcNSWk5NVazNen2PKD/CGO5j+S9Nd0tUx4WcTEWI
 zpsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcUHSR/+4f/fKXnQaC8fvEWkG+GM0K7i55RVLXNNuUJBCFfBvqhf/FoyChzk+kTEuOfHI0YD0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ml6VXnhG7JoYwD5PtFjRG9txDzJGcu36OdJzs125+ZIpmM+fDq
 W+sAihKP4dwZ8/jYBSqGdSjTQ+UHmeOYG9H69mQQqJWHTkMggZ0PeukVek6qGrvEEH4=
X-Gm-Gg: AYBFou3tmBEHM3zx3LED/sxpdimTwhtTDMvilqVWHwf08W/T1VhDnBHwHAJQcHIbv8W
 He3ywajG6mhD2PX6crRckVBBNa0QEtCKWwD4F2ErHF/EWWX9htGdrg/2VxXTQjhn3ZhgjpDJarB
 kdT2gHRLBXY3EjhWouQUhRe13vruc2GhV7wy6bi3hnyL78qGjjRC/GgSHoJv+Ge1J9rAflSA8MP
 T35tGI4S1RArXWhLH5q5dcuF8T+Vuz1mVhbs+awq25k+WnjlJy5Ww8qeQ6fgGwq9tAi2ARNgbKJ
 0UpcC+zt/FelazCxnhPz+TfSm5/41rGZhuao6g/aJ0Qtqo6a5sHvO1sp4NUpBVQ3VJavzm2LoL5
 N3PrIn/hAmG5PjKNK7tE/7OqXRPOS1Utf/FkRcTSJ6aozBSW3Lol7zEAF3dK0a7H92hbYDZwgxy
 xISD8r/Pv3A+AhhwfMbuGkhKICXPBY5vQKOoyyDgbZcjwZtpimYI2hMaWiuv/AUsWYkQ==
X-Received: by 2002:a05:6870:1434:b0:456:c9f7:787c with SMTP id
 586e51a60fabf-475535f57dcmr1858952fac.17.1788471476305; 
 Thu, 03 Sep 2026 14:37:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:49 -0500
Subject: [PATCH 05/14] net: hifemac_mdio: check dev_remap_addr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-5-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8OhQGmL0/ALas4idLRhc4cwL36GBsw+C2KROK0RKI7E=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehXB+m4Vj3mVP1+i0+2q4+pBS1kBx7BB1UpB
 dkTY6V6sxuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoVxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtIcH+wXP0WXbKUY2TajOnnobeQeGWL8rCo4RLEoiYU4
 v0P2CC+8H7tXD0tfMqGlQTryjALrqO9MKQJ+mXZFH2PFV7mIM7dFq7tt7F+kfA1heNemBmZ37vh
 KDEXNQrc+LEp85SufmXVnrj3XNy5TarUqVvk7u+LrerPXvILiSidfGCXslTr2wwk61US1atwqSl
 wDRyCbB1cYLe74QdUM127avlHiWqTBZEe9EfTpArwD93zVT/dKXVySlYKWP3AvJXIKNNO+b1QGv
 L7QMgAApTTYbZmhXOXAqUkMoDgrWFUs2icHBCuELC48xS7VZKMZ6roHfKwfny+Z0fKG0Cgoijwn
 Ucls=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_remap_addr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Add <errno.h>, since this is the first error code used directly
in this file.

Fixes: 6b5c8d98e204 ("net: add hifemac_mdio MDIO bus driver for HiSilicon platform")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/hifemac_mdio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hifemac_mdio.c b/drivers/net/hifemac_mdio.c
index 0b59d060917..6d30ad2031c 100644
--- a/drivers/net/hifemac_mdio.c
+++ b/drivers/net/hifemac_mdio.c
@@ -7,6 +7,7 @@
 
 #include <dm.h>
 #include <clk.h>
+#include <errno.h>
 #include <miiphy.h>
 #include <dm/device_compat.h>
 #include <linux/io.h>
@@ -70,13 +71,11 @@ static int hisi_femac_mdio_write(struct udevice *dev, int addr, int devad, int r
 static int hisi_femac_mdio_of_to_plat(struct udevice *dev)
 {
 	struct hisi_femac_mdio_data *data = dev_get_priv(dev);
-	int ret;
 
 	data->membase = dev_remap_addr(dev);
-	if (IS_ERR(data->membase)) {
-		ret = PTR_ERR(data->membase);
-		dev_err(dev, "Failed to remap base addr %d\n", ret);
-		return log_msg_ret("mdio", ret);
+	if (!data->membase) {
+		dev_err(dev, "Failed to remap base addr\n");
+		return log_msg_ret("mdio", -EINVAL);
 	}
 
 	// clk is optional

-- 
2.43.0

