Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C1C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D04C60616;
	Mon, 27 Jul 2026 07:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVFgEtxI7UAu; Mon, 27 Jul 2026 07:00:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70C5A605F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135626;
	bh=SXpir7Cr9NoDVsE3q4ctioL2rtU7/QdSownGE38Upjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XHcZDQ3+SL4NuVcOKnhzyGQlkk5S6XGbbwnVgk2em/iiBT27FB1aVT/5q9Tl4cavg
	 W4NvzhmkSistjwnsXnTTe+VUJ8O0Q9ZBB6veluSriaGGTSYKk9sNiaSYbS+Xfa0wjL
	 cJlG2juovn4oPbkww5x0giJPz8EssTeqvJNqaPWc9177RV8RP4u7SNWk4UjWuSfu/9
	 yx49Yxmgo6lVi63ogUqdRIvUtNEwVc6K3FneyD2U6PX9+nW/Mf30nIcXztzR/2n9CL
	 fxolJSFazXwG0YO8w0WIjHYjYihVyth35yQ7CtZU0LP/SDck2qG4Sm6ywH7LbBaec1
	 5a6rzyE/bkwfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70C5A605F5;
	Mon, 27 Jul 2026 07:00:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1541769
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 075BC605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KOUZ34uKaMg for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:00:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 64B12605E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64B12605E5
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64B12605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:24 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1798012a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135623; x=1785740423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXpir7Cr9NoDVsE3q4ctioL2rtU7/QdSownGE38Upjc=;
 b=NAU3Y7/L3zXSqsuHOZwyHy5jhIfdlEN/nQvAQA7bZENPCue8KliMHoMEamFU2Q14Cl
 0nECWkeEzBK+ZqyIxNAgpX73Cl7ShrtyAg8Iru5tPvHo/slSO63CxLxjIpPzjjJCtY9G
 mKsA2SNyOcc4cSh/Uk4CqG0TJdpil/EIvrO/Tpkxv4U/jTTiHRbxJUF7HHuzLROU48b3
 MSD0A50wAc4BFQe0Qzm4QCFi8WkPNyM7pYLjkzMOxyz0025r2pfrpMK53NPTfDrOJ9rU
 6QVAmFQRRx1v7OEy97jLtjYu5B/+sx4Z8I6MrjfhMwhOwNM2XvLhbZt6IBqyWe5zaeH5
 1OzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMY+SmrWlO6dTwBBiC74juttNaMXosJwdrUDYnM7CKSs5y1Vq+pNvY6rWe4LxfjTCGqmT8T98=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx2ED+kUnNasvtojeX07A7lmU9OReWolBASRXKDSDU1/+go2Mss
 qlT1bim82eiSQvAKEuhjZEuvnGvpoEFi4Q68Okp4R3EfuBXwWgTrKkwfcKMCg/Z4hyk=
X-Gm-Gg: AR+sD13f+z27NUmTqFZEpd+iuzirLU58u4Azx9aCvELtIIiZfACFGqxkJoABnwf4y0X
 76jToW/HLgtrJOPOQjJrceZfHY8jGw8O2Baw4Oj9+iQkULw4/n1JDpcLk+39AgAFwkrx5S7igcE
 fFaTaxoNtTyZ1XjCptI3PRX3TPiF0wmIjhNCGnLeuFv0OaGKmAxdk4IFgcSRkHqQyYDaNXIzxG0
 I4hcyXif8KFEV8kODR51cs3XK5eYILT5Neb9BFvMvVIKk6vOCo+mXc0dBVF4ndp6iOjRqE1sMu9
 20mkKR/uCahlPfuxz4U7xSCkzVM/qmHaUjzSFi/W3fzwUPd532aTfrOCwxPwfLi34iFb6ZHzaHB
 UwRwtwcvEeGlphRtz4JQqBeobNcnkXquEc5qch6DcM3QgFmrmrPTQE8mL20WBROa1Qb5V69AEVn
 uMebJLN45OBurhFslhsG6CcWR9ZjllU7N3EGDjORn8sHP/GvktZRBkxlVOu89+4wi2cbDpJh2RY
 m7H1/KVQIBHgxGsNs5XKaip5PbHJdxTvqGbSRFfi3IZqfaPerTTwg==
X-Received: by 2002:a17:90b:3b8d:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-38f294e9587mr7103245a91.13.1785135623578; 
 Mon, 27 Jul 2026 00:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.27.00.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:00:22 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:12 +0800
Subject: [PATCH v6 10/11] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-10-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135623; x=1785740423;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXpir7Cr9NoDVsE3q4ctioL2rtU7/QdSownGE38Upjc=;
 b=Jm0aOx78NWHHH6r2vqlZPrZY8TWwiSaiLIrE3IkG/78aqSAy4v/KD7wiXfR8LXULhp
 F2QsCq+pqK3Me/wzf9TH2IBMZPIUMAKciV4DBZn0LisN7CeMRSUBVCaMRH/HNR3ffbR1
 hxLZc9cDbtLucYKTviB5vo1JTbq43eXMTvPPaFkdyqQ1cyvcGBUagF2D17uapviGBDYQ
 zXRj9LfNB2FFpHW1l7JbkKKm1ihS2S+WwUKvOIQH22iFewsotrZ78aR3VlcX7xtFUxeL
 SNYzQuWzjADW14JYo3f0Ixf+ioPBIxxUqyTS5nxWI4Uqy1VE2FZtuJpswV6j0yT4uISM
 qSJg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Jm0aOx78
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

Enable environment variable support on the eMMC storage device for
both SPL and U-Boot stages.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index c0ee3a29f23..7caba18ddcd 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -14,7 +14,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_ADDR=0xc00000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x31000
@@ -48,6 +48,10 @@ CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x60000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
@@ -111,5 +115,6 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

