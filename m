Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80CBCA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93BB78123C;
	Thu,  8 Oct 2026 08:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWf52nb5Oewh; Thu,  8 Oct 2026 08:38:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 494D9811FA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448681;
	b=SJPHN+gu2S1UgYg8zyvpBhsZ3JqZayPJRjvS6KbvdOcRtlMhZio/lz6YkoPMUHm118Y8
	 N1cVwNgbsWAtiLmMHhsoSq5aHHXuG7qtQsitydxj8Cf/Tx58XrdfwV9g9HXnxOTGZ9gmf
	 gfcf9OTw1oGwkkMWcXp9nZ+TMDkAkvCxEw7jPTIDt3tJmqrSSlt/IXo+HLA0ZgXt8Kc7L
	 6RjqNc7Is4jbNS16zI1zM+nRqUjiWjFWAraBcbnEKjw7lO6tT8mOvAa67DVwT5WWHshyg
	 rBjxjsGF4Mw9he+js1I6qLipkJ2jOaVuTKfuQ6fJ/Ilk9RSsPC5nkn0DyTWfxwqbx+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448681;
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
	bh=+NKpcryDLvl1qirOO9f0SD+OhWTn1yJSkKeVmq9Msho=;
	b=mq9nGzfNd6UhFgrvD7cIV/UdnHSlDXJxZ6iVDfzwMy52kRx9ZsxsaWoDWma2iWVfSlLd
	 b+DtXu85Tkla0BYC7UJKwhfxw3DMMIS7NW2PwOwGzU2MCUbtfJcwn26urJPCepeIxRr9I
	 7aLQw39wEy3IjdR1WZmNSXhxosMbD1pu+s8pbuyi5pJUu1L9ELxIoISaZrl4dkyWyiZvb
	 tJ+JgE0wpKxCFSuQxNIvnaYOPJhOmXWCJwszzYj75bl54FO+/NzK99GrMD7H6fxv8LOsV
	 laBy2VDjf3iEvqWMx2IwYeva1Bx41MZ8H+XLocz9FaUssmfSUVJxVwDWzZDwtg849Kg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448681;
	bh=+NKpcryDLvl1qirOO9f0SD+OhWTn1yJSkKeVmq9Msho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rEp9k8+wmU8D0qgdO9JzZupULBYl0B0Tk0cbFP03abLTUl7hM7SHiF6/2KfS8/JB+
	 sLYmVqZ0JsAj7tq2iTO9DdvgGxWOawLfCptJ1ZEqW4SLEsIWJLXJ/8+sp8fm7BZ7qz
	 ItfkwlvMMGcwwTSRd4WnduSdme6z3/z8smrQ3ZjwK5bZ+rtmpAbF1+ypBWABZAviGx
	 FXTbRl94hCUfznrjPd5/+HSiB9s2ih2cjVDzws9XOKH8IBeoPeIgtvFxj0rffJKHgo
	 E5dguCS32wt5OGTgk7rOhySo0u5u0qrVqqnwcsEO9Q0tDVX9WLLmYsxGy1BzubJ/At
	 4qkssKBWRGQ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 494D9811FA;
	Thu,  8 Oct 2026 08:38:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2343D338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14E6A40737
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62-ghe-1Sw1i for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25B7D406EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791448356;
 b=BmP6vZ95rM0GM1NC2nUTNpXa3oaydRq5CfsSzozwXz6O3+AlWbjjRO3Oavxxe/OzGWGt
 vAkfV9dILtE5VO5A+zkT2jAAfZoW9ml1bJiJbZZu1Tqqe/DD63WRvRIItxICuDLoM/5zN
 iqz0nWUYXzmUBy/Zl+b1tDlvA1aJj7szJrYGaBe3Bcs6BBh890DRwY0r0l+ODrqegfS2Z
 V33HriI3Ekv7WW0k1u/kUpnWoY4QQpP5sf6Md/g9HIefOOdMeh3W6fLfJhpqKR94oW3Z0
 EMzmHunYU023ypp9BmJ/jgQeVWIt8EXa2acLbZBbfCOC3f86ALkDkqswqSCfUkRoT+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791448356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=+NKpcryDLvl1qirOO9f0SD+OhWTn1yJSkKeVmq9Msho=;
 b=gCd2ty5zR8ykpx2Ie3buqFPgquUOgZfDSw/F0oGWyioaXJkRV91biI8AFNpXmMWQjdmf
 rT7rBGt/WBhH2409gGsmjyWuvu2kM7c99gOPxcsH6ztCqinRb1ZVYSbm89SmNbFcBQ9LW
 iZl2roqEZiMUhrm/RasMHWrkUhRwxCAda9+GQGu+16jE6xY3coVPMhkda/zoOtysSWZwa
 ZIywZnUuGmzdfafQXTcTAM996QtniwtGa4GF/kl+QBZCOLvbZmZ5gQeWjZj7fYQ8fyE0i
 WwQ7opZolFZk1GxBZdTAoS48SsEWr9EDLiR1mgUtrN7tWLKFbBBV7HmVEFaKc9x9PAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lUfEcHoX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=kilicyasirahmet@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lUfEcHoX
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25B7D406EE
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so17360095e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791448353; x=1792053153;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+NKpcryDLvl1qirOO9f0SD+OhWTn1yJSkKeVmq9Msho=;
 b=lUfEcHoXugjnkN//LLX3Xeewwh0R8H98vhkdROJvI3vIBceNpr9TQ1brBfTF2UGsqL
 IPAppRoRSodIsPKp1xB+ApDSwrgk6KDK32nYDpkmfImlknG+o7HlKL9lESHSsL3tJC0h
 Mr7sHF8En4nO98n+Nu2ia42O2RJgV4b8kVM1vuAs3dPISHBopc5zEgi20XjmMUgsI1Xn
 DKPP8vprbkgNrJObU/GXOIZYIaBrufq6DrEAth2CtZybWQNuOhL6ebbVDhcji0PfsSOG
 jAP7bvyIHNE1PkOmH6VYLTvcUFKPSA9zLIs44SphsHlmQ7h+ITaQuvXb++CIe/qdFJ9o
 29KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791448353; x=1792053153;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NKpcryDLvl1qirOO9f0SD+OhWTn1yJSkKeVmq9Msho=;
 b=FViu6p+Zl0VnNV/i/OMmS7m4L3PoyT4WqS4VBp94mtXEpXg11Vh6WMg1e8HYEDuYvj
 GtfaqnM4KvExHY1ojXj1WeevP6hp6aCyp8RIbR9U5O3+waXhuEn1bkmRDJldst4uVv6y
 OAlJmgmlBvTEOc9GcLcJM8PzJlLcgf0+LqIz4P3EPD1ZuNLfd8OI+dFR46yg1puAnbWK
 PsIeDPTcDbRafnlf/rGy+5g+UlPFWiCHp2zuBQ7VHZ/07biFXv6r7Ar7IqtAPAS8oMcK
 0i/zGy9cG3ttAqmVXC1l5UJgKdjfrr/0mp7zARQMaZQXXjg2ytgEjXiLtta8lLxQ4kpf
 zawg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycu0q6OMqlJY+vFOAopWlQ24vuNhbfG+p0VUwzbCUIZViVPy3e3ZfZG7RqLaQQc/RKe9kvluA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nAgz89IpZvY0lsAg6Ew7uVgt+l5NJJavhnZxYhz+NdmjherfdQ
 V/kKTJqKW+5Ze4pZQSlX5sxZstEv6eklijlGz+SZh81K37PRDXfUIVYc
X-Gm-Gg: AYBFou2i+Zi3FFSf+BafKUzXMfsoqXcfeYWWDoNO8luXGIaBBYmw0TRbpx8CJR6gWxz
 bSG6b1u/HTr3O2TP8iZRd9yq81svWc0zn1TJ1Pu9YSFYZkKRVmOznomy6/hYH4nGj/a84ijmtWQ
 fYxzwmkhlREh1EHR8oFEWFAbiJLwGt9GdRPr5f2Scv7C6tjpsoMBOvdwSiiBAt7AvtGFOeMXReS
 Fq2O7guV58JtkDIvUnaNGBfqGh5vNDA6C1PAZY/ka+n8UMujLs6jOBobrUsBivKwf43sdLILQBj
 xTbpEjrWf5my5ke5Vzu7Sn/iQQul6WpbaUard9NtKwt54H118fb9BYUDtMJ0D+NOF0oNBAJodXv
 nyH3Z50E7QiRCfT3wrEirNVxHKBMiIY4z/Q3ikL9q9h+jIX1bVUHf/J3gn5ygllPN6SkKSGIYA7
 a066YfcFrWPEPklIUNk/EcC02Mgt8AGl9DUum2sVUIX0RXKDrDpevfhzapUFkxSPc+lzT4s/oCn
 ppigA==
X-Received: by 2002:a05:600c:3b9f:b0:4a0:2644:80db with SMTP id
 5b1f17b1804b1-4a180664e4fmr85171585e9.35.1791448353061; 
 Thu, 08 Oct 2026 01:32:33 -0700 (PDT)
Received: from [10.40.144.67] ([193.140.87.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a3f55sm56309575e9.2.2026.10.08.01.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 01:32:32 -0700 (PDT)
From: Yasir Kilic <kilicyasirahmet@gmail.com>
Date: Thu, 08 Oct 2026 11:29:56 +0300
Subject: [PATCH 2/2] spi_flash: add support for Everspin MR25H40 SPI MRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-everspin_mr24h40_mram_support-v1-2-d8f14da1a997@gmail.com>
References: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
In-Reply-To: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ssunk <ssunkkan@gmail.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Yasir Kilic <kilicyasirahmet@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448202; l=2641;
 i=kilicyasirahmet@gmail.com; s=20261008; h=from:subject:message-id;
 bh=2UH0ei3gnH2asU6XKRSClLrwfA185vYRihdLZP3hB18=;
 b=HcWH/aNmTXKD3GaLFlL5Vl/dfdVb4TQB2qtYe6zZxY1dDvbcMeDvslw+XlsHB3E4GxulpL1UD
 TJEbBg+oidiDTV0rROKdEDb1FNqM9izYqmpcoZQo4hH1mMeDkdzRQjb
X-Developer-Key: i=kilicyasirahmet@gmail.com; a=ed25519;
 pk=FRG0XaJZhIxdUTCOJsdfP9Dy66fwq4axSdMGQ0leLqQ=
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

Since this component doesn't support read id command, matching
is done by comparing the name of the component to the dts compatible
string. It also doesn't support erase command too so it depends on
the previous commit too.

Signed-off-by: Yasir Kilic <kilicyasirahmet@gmail.com>
---
 drivers/mtd/spi/Kconfig        |  6 ++++++
 drivers/mtd/spi/spi-nor-core.c | 10 +++++++++-
 drivers/mtd/spi/spi-nor-ids.c  |  4 ++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index 4ff58380b59..4f35856846a 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -304,4 +304,10 @@ config SPI_FRAM_FUJITSU
 	  Add support for the Fujitsu MB85RS256TY FRAM chip. It's treated the same
 	  as SPI NOR flash at the moment.
 
+config SPI_MRAM_EVERSPIN
+	bool "Everspin SPI MRAM support"
+	help
+	  Add support for the Everspin MR25H40 MRAM chip. It's treated the same
+	  as SPI NOR flash at the moment.
+
 endmenu # menu "SPI Flash Support"
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..f8588f9f9f5 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1570,12 +1570,20 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	// some devices like spi mrams do not support jedec read id
+	const char *compat = NULL;
+
+	tmp = dev_read_string_index(nor->dev, "compatible", 0, &compat);
+	if (!tmp)
+		dev_dbg(nor->dev, "compatible string is %s\n", compat);
+
 	info = spi_nor_ids;
 	for (; info->name; info++) {
 		if (info->id_len) {
 			if (!memcmp(info->id, id, info->id_len))
 				return info;
-		}
+			if (!strcmp(info->name, compat))
+				return info;
 	}
 
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %02x, %02x, %02x\n",
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..1e1b86c89ad 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -357,6 +357,10 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25uw6445g",    0xc28137, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25uw6345g",    0xc28437, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 #endif
+#ifdef CONFIG_SPI_MRAM_EVERSPIN		/* EVERSPIN */
+	/* Everspin */
+	{ INFO("everspin,mr25h40", 0, 0, 512 * 1024, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+#endif
 #ifdef CONFIG_SPI_FLASH_PUYA
 	/* Puya Semiconductor (Shanghai) Co., Ltd */
 	{ INFO

-- 
2.43.0

