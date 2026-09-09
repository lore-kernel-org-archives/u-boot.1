Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B87C79F82
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA09180D9E;
	Wed,  9 Sep 2026 00:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fqJFOSwG4go; Wed,  9 Sep 2026 00:03:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF74180851
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912215;
	b=JxzsQxgrTgCVBuLz94xCEPJwseSyC68hhxaSBRQ1KozzRzetcCCvt5HXKN+aVPCs4YEr
	 aPkHrkRVOn4e/GBa//dMRDjsooQREkR1iu5bezHU2SJW1V6F+8SEMnR6tmFCIa9Gg76aF
	 Xr2NMh4Ilu+hT796437NCUk7/8eBiqFV0zjwx3/TXzvk/h4Cs/fdiSb6FUokAARO5iIvA
	 c0pJ34D9FXVlGFxX889YiBxFuFE98YMTasVPfTowZwCGgzAtBdI/f9kKpUIUwkmkTVfy5
	 WZEpSTxasJvl8+j4lPbJdH71+hLsYPor81xOzySP6gatub+tyRPamADTuMOIgk9V3CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t9yPdyJR5bxMFKrvYnKt7r/PDDxK93wkjIIGetiEUpA=;
	b=O8i+S3qIFPWgPlWsZX0fzjPZqLn+z0BTAst1r+k2s5WEgNst6JxEKe3evvAmMaRG6xz0
	 fFvDLA1CDcNStG5AjhREzkskWRl0u/PWL760/SAGPpnkLQfFtr9ZJRAigoctfINoYHOiS
	 slWAYM12GPO1Kip3srejxuE96olAKXx+tACOgBmBfSiXhNCNJnk0+8K+UiwPMz13yg62h
	 altkWt4wZaxsPxXR+1+dSurNR42sUhqs3vlpCKtrmd5H+7Prtzjh1T3c1x2Ta2/fSn7Du
	 Yi2UVw3eSR5nNf8yQw4sk0WRdd+R7euGn7APRF9grcQciVrdPYXlZAYpBFQff0r9Hag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=D5VaKZLY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912215;
	bh=t9yPdyJR5bxMFKrvYnKt7r/PDDxK93wkjIIGetiEUpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8O3uKz/YR8R+Ls1iz1lHA/yZcedHxNT2coVgENlInlGZsUFu5jOyA6btsf198ygz
	 e1uypFf2MHiDojA8VWnKJvh0dXL0XrM48vXgLQlVQdbkV+Sutp8vPS/1t1Z1wzyhmF
	 gnAliT+N/eV/V1nmVpycYSwlNF9O67jct2WZ0Vmb4VvLAaF5nGdp2tR5OdbNtmRAZy
	 9KsOLIszxMv7Z8K23MMJnJ46bm4hYrp2VWByC0IhaUQ22DzdIMvzdePdxi5EhwI6Ck
	 u0dNEZjFXa21S8fpxlZGRsaWAPkVDCPfNakjjGYb9Ugd/goUwnHp7x+OZ9IclbEj6j
	 uH8+HTWdNf2kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF74180851;
	Wed,  9 Sep 2026 00:03:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07EE7701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6BD180D87
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwGi47QGvAdw for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D33DF80D6A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912211;
 b=Kn/0U951/6MPD960YFkZOcnX1t6etF6H9IpTaMVUoSpkuK3dIhXjQpQPvpGQqa5gWT8m
 lVy86fSEutxKeXqoehKO8UzJBCyolP2a3abYxnS4uI6CByFjCaW/o6QxZkjSGTRkoNpcT
 4LN4EgLd3Fo4rZ5P+6vanIjLVKATJWgJdwklG+ofm0wc8EvEYlWpkce33hM4wKnKV71lA
 ucq3YT74B8BPkkzWwsjP3b9D62RUjUPxYsgiK7qkBsfcW3ovRYEfy9Cyzn/MGdkXI1qOH
 yBL8itDZ0a3GDd1YbFTCEdRCNa9HWkFyQY1GMGpkk7XwaiKc9yb8GD0VMvBjSztjK1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=t9yPdyJR5bxMFKrvYnKt7r/PDDxK93wkjIIGetiEUpA=;
 b=Xvgpso02ZSK52Ev5oBZpnjtcVagfkLsi9eSUvFiN86BrhMU1qqiqM8nAqGmslaarxd3n
 vGZYHXuOcfjSbMVisDsXO2iA+L75VQC57DoSy7klSEmOLg3DKvvBbrNcA4Xb1PmA1xbOF
 SwNWCap9TeF9D6NfJ3Uw24+eqBHqsHakZlNuoAgguD9flTk3dP2jVbeQcHBeYSwLYrck8
 prbIVAb4P2bePAlAZKL6nsrpCsLnEm0u8UeZvbb6bAVwKfqgoqCyitOkLVBzLH6P5AxJ3
 mv/IuMAFuAzy0ZOCm9bNa8ZdchD668MVcoqBvWRWmWPSgKb6AGg52o8yanra9FpQbMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D5VaKZLY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D5VaKZLY
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D33DF80D6A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:30 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae716867so288651eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912209; x=1789517009;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t9yPdyJR5bxMFKrvYnKt7r/PDDxK93wkjIIGetiEUpA=;
 b=D5VaKZLY20IHTNtbvc/QGAfISw72uvuH6+WVc4fwjcYqAd6M0nv6OVVxl5Mml4oGy8
 aBYPr3cNaYxWRhkVLxmLVdipoailKX3xFSySPpuH/5uLyWZX7eV3MtDNQVAN17CHySrL
 JaoT1Ucui+Iqq6h29K3n12hZQn0pR14myyA1qpy17+/CvH49W9115fOLd8vv6n/VW0FJ
 yv0coqioOzucCJhoGM8ND0iFPdHQvrTwLmJe7H7TinZrtjkS91+6pj5x5nzkfu6i8rk+
 wjS9cNy/eCgsajDs5odI/lKh8MWUXJsjNZH/Icii2WVInAlqLtawpVYTbvoukNT59Z3B
 wVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912209; x=1789517009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t9yPdyJR5bxMFKrvYnKt7r/PDDxK93wkjIIGetiEUpA=;
 b=E633h4cPC5cgYzbhmw6QHTQCVKwaJDxVkYIzMaTDPpgqdxBDaCOfu21Yr9Gm+jHSMG
 ucxT/cnGINumH5gt65vX8i8/9LLXeNpLimqV6CHS4oGYv+ImXG8jztxUX4SFN1CTUKhv
 XbV9BRhZijP0Hx3HkJmvSDjQWO5wWAvZ1zILCPBKP2pxcPTvWcBKBXwUaC3e0SVjCZe6
 3rHuJnHtoVuFDpunbkAtuKgl04JIjYh9uUDClSWbjCk21+5+wyd5ByVhtSRLvOYqaw29
 5RKH89pdp/8IRTMxYCyNpYI3Rb/2gakEVxp//VCWldJIg3/mH+NXqfb3FS7WnNy4+flI
 +pVA==
X-Gm-Message-State: AFuF++mDiPl5nJKmJDGj9BJl3wk43/FUUsvd2c01q1NR35JOuv0D1gWt
 +pAsGFvf/ipPJVA90gRgmnKSTLkFS5TxRM23svtdsc2xCjBCt+NO/QdzRnoNZIOM5Ek=
X-Gm-Gg: AYBFou2D+ycsyxrizpkOtgG5LUUhb0WMJXfVuyBvVVAb2DNeyTUZlY93aTWAYpwPub4
 1o46boOUGmMY5bupN6SoctLphSfnTlg2lgviVHOKTYmk0Y9X9cnWJRaNnRLG2h6fKBx7PDB0CXw
 8XIC1v5vNU28DMI7WKBrNd+f8b18ueRVnYOwojd8FqDDn4GiirZb8GUyRwylsPSZw65/42cOrrW
 QDcrHDTJYytLhtsz3XWywrF2qrC5Ah82PnSK2FAd0S+fXHfYGFJ6KflkSiUeVEx4rf3eu29PCOH
 2TKVKM0HDcN95FnubwjjsL92Kw00U2nHjSZp4bVWzIqeRVXKQKx45IDEclSl3KFzWKyEhHyb34s
 xI1eEIGlsXrrqEHJVFXyFg3VOVn1psxsYofS33S7LdzcQM0Dor4pP6Clu7HeEjyXq1WeT9q17sb
 N35U5Jj020y7/Q9mtL2S0q0XuwZl0UXnn/8EaIQiAXH4Fsg7aQphVqHjIhYHUe+9m/eA==
X-Received: by 2002:a05:6820:1849:b0:6aa:d97f:453b with SMTP id
 006d021491bc7-6bdccd5ead3mr2982278eaf.28.1788912209063; 
 Tue, 08 Sep 2026 17:03:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Sep 2026 19:02:33 -0500
Subject: [PATCH 4/5] splash: add a splashoffset environment variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-splash-doc-and-scsi-v1-4-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=JTOvuWngN9Ko1GIhmyzGqdN2tThfaGmOuS/WpvyewTY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKIyL6St0ZpWMNipEBtM3We1lAPaPXHEiDb+a
 oPqFN0avTmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiMhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0jUIAJTJRQI57ExjGmBIx57f7pNGHUug81YeO6zRQQk
 UceDbn4Rs9tF/mOW7xxfANj1rom1+7DUHYU35+Z3KrejO2jB5b0F4ZCWf5z5ZLd9hZduetfFv0s
 mWDb9BHq1QWS2MBhdIQyzC0x2At29kXfOd2CvVsDBeMOCjDCZYbjJplIyWdHm7tQO1rwCALvhqy
 8YNsIsX73btqnwRQD3vkLqWJPNzCZDuhDsqzY3SrEH1fS3aPqxfEKtu4bFWvPJxn7OZtx7lrorq
 qiUQH4uWlOTuOdbnl6mBXerEa87LmfR0CR0EXfIYwQMTCoMp0offRbFhpXpTd+WCZ8/9S4PrILp
 7qm8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

A splash location reads from the offset baked into the board's
splash_location table, so unlike the device and partition, which
splashdevpart already overrides, the offset cannot be changed at
runtime.

Add a splashoffset environment variable that overrides the offset field
of the selected location, given in hexadecimal.

Note that only the SPI flash and NAND backends read from the offset at
all. splash_mmc_read_raw() always starts at the beginning of the
partition, so splashoffset has no effect there.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/splash_source.c | 5 +++++
 doc/develop/splash.rst | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/common/splash_source.c b/common/splash_source.c
index 162fadc60d1..767e4a44f28 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -440,6 +440,7 @@ int splash_source_load(struct splash_location *locations, uint size)
 	struct splash_location *splash_location;
 	char *env_splashimage_value;
 	char *devpart;
+	char *env_splashoffset_value;
 	ulong bmp_load_addr;
 
 	env_splashimage_value = env_get("splashimage");
@@ -460,6 +461,10 @@ int splash_source_load(struct splash_location *locations, uint size)
 	if (devpart)
 		splash_location->devpart = devpart;
 
+	env_splashoffset_value = env_get("splashoffset");
+	if (env_splashoffset_value)
+		splash_location->offset = hextoul(env_splashoffset_value, NULL);
+
 	if (splash_location->flags == SPLASH_STORAGE_RAW)
 		return splash_load_raw(splash_location, bmp_load_addr);
 	else if (splash_location->flags == SPLASH_STORAGE_FS)
diff --git a/doc/develop/splash.rst b/doc/develop/splash.rst
index 994951dec4c..fe58dbf4418 100644
--- a/doc/develop/splash.rst
+++ b/doc/develop/splash.rst
@@ -73,6 +73,13 @@ conventions used by the load commands, e.g. ``0:1`` or ``0#splash``. When
 *splashdevpart* is not set, the ``devpart`` field of the board's splash location
 entry is used instead.
 
+Where the splash data starts in that storage -- the BMP itself for a raw
+location, or the FIT for a FIT location -- can be overridden with the
+environment variable *splashoffset*, given in hexadecimal. When *splashoffset*
+is not set, the ``offset`` field of the board's splash location entry is used
+instead. Only the SPI flash and NAND backends read from the offset at all; MMC
+always starts at the beginning of the partition selected by *splashdevpart*.
+
 The default weak splash_screen_prepare() passes the ``default_splash_locations``
 array, defined in ``common/splash.c``, to splash_source_load(). It provides the
 following *splashsource* names out of the box:

-- 
2.43.0

