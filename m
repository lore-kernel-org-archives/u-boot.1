Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B08C79FA1
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5520D80D89;
	Wed,  9 Sep 2026 00:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smnx7w192ZKF; Wed,  9 Sep 2026 00:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD22180D7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912212;
	b=RL1ieufJqDDNUEUgdHp8X4KFND99QyXQatoYkogulOU8gvKkMjJ5SVcs85oS2U4Vq2YP
	 IXZFUXDvYfoF7+GUhgGYdYc+6b1ToVag7BipbSuB6tWwKcxm87ijN0ZymJLFcsZjGyf9X
	 X2Fic/s4OKyh7SzC3lvLkJ9jP10axcV5ICPEBLEbpYoxVflQOcjc8jVN1r9ELA1oVNwfz
	 SOUFv2EOSJXYHsPA93m/gGfRaSj+wmwXcMDWs+nF9tcLkJ3Ne0aa4Tmctdkn8OTjYfxZJ
	 bIadIzRFOp9Xxt2hf3Qjrxgv7VK9blTdG34jkg6LvLLDzuVnKW1qIAiI1WPvYnnTOKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+z5Oacd2jcxywxshmbr1HZOUW1y0aNoVNv5SfYJ9F4I=;
	b=mbfZt1+KE3G45YpZxeDvUOZoWrjkeqBtvst1XeDrPRnOmOmLV3wsh8xronDraQnliBH/
	 T939NULA1VLZtDybuWAQfV1c1XHjzGiAKHT9NeLug/9Wudq3wI8JKbkt7DLFbB2oPkdov
	 CGvEruOITIWCy7tAUgh46vx9z6yvJc3VTwvM2MEcm46H9Kt21FeLQcv9a2mgR1GHrJs6f
	 vcCwqnot+Kh7K3TesYt/7R4LpWigJnRnW3+frWLJMwsWkrF0zRP1DjFOHF/8xbSyZCRjA
	 tnXidFRGLl2SdzAkgOe1trfi5u2b1a/y2J01sZNkkBGkXcAwMxK5eZusddhCOIy/+3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912212;
	bh=+z5Oacd2jcxywxshmbr1HZOUW1y0aNoVNv5SfYJ9F4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yT9aEtXSG2S1h9+iT99ZagvJWy5GBwWfFkon/gduBuDf8S2Cy9e16oGpLx1fRVFva
	 fTpbz+BsMxnryzJKU7cEK1B6ujiUgaDA/Xk3B2wL90fHh1zEkcP2ckoyBollhv/fsu
	 Rp7WXRpDcf6XMwfF/TjCeBqCJfxPCkHxhZX3qWwGzrNTiWqn7LnFfezhX5Kgiw6Olm
	 ArGcmTyDx056zf0P5SrF5XdurSfFKDNQ2J8VXfTUrtMBYbiTJb1dZ3n+SQQBS1B+Eh
	 AA09uIhtE8SRCT6BaFVTEJZw4tf4aqrZhhilGuquv3BQuri6EdQ+zDkQvClLUJpBHe
	 omMXLVY+858nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD22180D7F;
	Wed,  9 Sep 2026 00:03:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D27BD769
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C44F740670
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyTdZLfyoLgq for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC7A340661
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912208;
 b=tWP3BcTcl7meuIhFdhwbD3G2zlalkVvMDJ7M7LacQjZqxZMVAVqBZrK49FHxDynE/9XN
 dI/3vBkucP1sCHOufrjohyqjM2k8ERvI4ERr/qUior0unZKJI2bvsXqbLVioGPXk99S4g
 4UpDI6fCmK2owzZ/9KHQKNpk3zgqiWdnwgpz/Syf4V6+RA+aFDCNw6gFNEvQYA3uR3ZLN
 FP2wMk+zE9swRXWHYiFtGfd6+myLCJRz7nKijjjm/uJ7Lt9havtDimQpo9TuOOdDSZZ0c
 FFl7lCGbKcoV4aTcCyNchq37+ufxrz3tLuMJMuX2ve2vpOKhoV1RaP4B/Z364UtzURQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912208;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+z5Oacd2jcxywxshmbr1HZOUW1y0aNoVNv5SfYJ9F4I=;
 b=O+VS+lG4z/c0vurFJaP32krwWyqUaIhJw436bGBVy/uYyHw3dONOHURgEPl9/9AGZ3VA
 AX8LCvF3V4jpiwdVocthUDzgwdZUUsWXFYdzgwXX3S4S7XNYahZ8WPW+XPX/axTmdqFmf
 dGIQew60EeJi3tIZvZA6QdlZAKRGlZe/sYGP8N8mygt91wHaAqA20SYi10vWBrZg7w6z5
 ggDapUIeFz4n3PBno4x0Qh/ejZSG8YJqMoYdDVb2neO7zkzhx/C71cvJn8th/HAdbp6qd
 kZ20lqOu+vFUIlfNlk7XbLllzfPtnC80l8kJPfcCZWKZ0XVRPrR7PK+kQ8PlVBtYRew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fXsVVCc8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fXsVVCc8
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC7A340661
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:27 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7f0167e59a3so3844735a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912206; x=1789517006;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+z5Oacd2jcxywxshmbr1HZOUW1y0aNoVNv5SfYJ9F4I=;
 b=fXsVVCc89xH2HwHC+x+b7mm1cGH3sBeFmqqvw67H6CpW7hVPURUkCf97ZS7aEB9cHq
 JfC0rbMfsthzzlVRioZYUI/uKjFyOUm/zj+E99CjswOjXOvOSI/o3FywCtFxG9iRpeJD
 WTWwHm36DeaV27TYtf4GLVt59l0KCPZYLrMVqwW4UvuvUmUzmxL3INhsq+KlbEkJuskv
 0agJS1wM/lPGMaR+BA07nU/p2ywkHBxmOzZiO5iNqIp+y9cu2c/tsiakYc5yq+y6g7f8
 TVuKSfbAxkOMVkmgOvInPdgejQptzcHn8h/VepW+p/IggRgOT6wC3j3SWuGjYHF81TyO
 Buaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912206; x=1789517006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+z5Oacd2jcxywxshmbr1HZOUW1y0aNoVNv5SfYJ9F4I=;
 b=rkiiVo0qrtmWcp7PHfT4+POE+3WPQVhL2yiwwSdLombZjoovjENknDhIuWlFRa0WAG
 lCm5Cq9vi/TjIjAjKOVRUH6OMVWDkhm0Cn8E8qodTIpyLK/KWAIsBUiGQNDx2Nb582Ig
 DQSFjnie6ztitIDakjsxtGn45/7ktzxZxxlqR7SgYVihaBJ4C05yNb1hxQb9k7kpmRgK
 Me14DJmtCKb+0JCChc/kXJ10OG9Jpccq/8uGdHcw166J3VZjbanNwwaRgnPG9YWTsEnk
 uWJLMspstDVPDjbibVONRclCLLfiO+IJ/IgY829i3HgiGBDsLgbAed33hS0ZaklLHFc9
 LTfg==
X-Gm-Message-State: AFuF++mG84P9FCY6Hq0ObFhhuwAG/krF8hZcBtR2LBHt8R/+mhBbHGfM
 FEzPdTfe/yJ3PJMO+PVCTQLcxXNa8qfUHzGbCrMKa0wh4kuwTVIJXFSMqaMeqck6XbSFh006CMj
 umtUU
X-Gm-Gg: AYBFou0chWu0/zb2buphY778f6qYcDsi6I7VQTZ9BymZ3Qj5D9QVE1O9ECaqZkVayUH
 OpknrCJVVbhDrL1dIb9W3qZ96vCg/sbAnQBAVt8lL1sLkYeUj6pp2s6VtONL8h/zjWuGv3I9Y6x
 ulkv+tM3npFtp5VK1ZEGFw2oVxa0atnyBg6UE3CJXM9XCQsxV7gFbR0798Bg8RtgAkvKsEICvzF
 3OiGN6YgC1i8ZSXAOAG5vYcfw+hMqelbX6P8Wo98r4359PlcK2VKMh81/7rPH+gPjP7Mrkh+ssE
 pkp0hual/s2nrO4sltXZJV7fF4BiNr8yn/G8KItTNDzIEM6LixOIMFTraqV5SFuoOJEH7dDD3+q
 UcwHYYoPlSGla9qfFwlbPaUyl+H+cWCgFGBNUfQpBpaGclQqu5DPmdX7BOUGDh9D8nFJJMnMxzE
 ehs5oShvFyl3I1B2CtKkVFbAxzx1+Dgzyfbd3Ikh8qDblaZPMcAkybg+2jwANC4i161w==
X-Received: by 2002:a05:6820:2906:b0:6a3:8738:4106 with SMTP id
 006d021491bc7-6b6fdbbfe7fmr18162664eaf.26.1788912206209; 
 Tue, 08 Sep 2026 17:03:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Sep 2026 19:02:32 -0500
Subject: [PATCH 3/5] splash: use u32 for the raw storage offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-splash-doc-and-scsi-v1-3-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=x4e8lGPPisIRdZjjR+VNCGbd+PKobLgr6rtD03ubeGc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKIsWAulOISxC8niDGw1VOs5//1vyIfQfrE7w
 dvUj7xm1rKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiLBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASwUH/0fAltXxHsIj7K5tRycJx/+8+ghljCVctsVmx2f
 sFoM3du1hnsTJqch5cLbZCtTsZ8QFqg09wrW3PrDJbEalahb1I3oLs1QaCJYu05+NdUrnqMIAXC
 2sd3+A1mG70ehcqta7dUrJUk4K2Hm0NGoBYkhcLVfeyUl42BscnLIEceqvjIR/mbHTtAxv3EF4h
 LiCvPA/c8jiqfCzZW95+lSH+1w+fvHJQ+1+PEaXnBYaZ23zNcz42jYHF798kt03230FqBbzZyW2
 NZdin6d5D7sEnFf1Yok9Ub0oLZ7yMdcvfl6WbBHy8Hjy0whndCH+qDqYYu5XAafCcJAUhq+73Ex
 voEo=
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

struct splash_location declares offset as u32 and spi_flash_read() takes
a u32 offset, but splash_sf_read_raw() and splash_nand_read_raw() take
it as int.

Take the offset as u32 in both helpers so that the whole path agrees on
the type.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/splash_source.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/splash_source.c b/common/splash_source.c
index a5ed7431b8e..162fadc60d1 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -26,7 +26,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #ifdef CONFIG_SPI_FLASH
 static struct spi_flash *sf;
-static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
+static int splash_sf_read_raw(ulong bmp_load_addr, u32 offset, size_t read_size)
 {
 	if (!sf) {
 		sf = spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
@@ -40,7 +40,7 @@ static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 	return spi_flash_read(sf, offset, read_size, (void *)(uintptr_t)bmp_load_addr);
 }
 #else
-static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
+static int splash_sf_read_raw(ulong bmp_load_addr, u32 offset, size_t read_size)
 {
 	debug("%s: sf support not available\n", __func__);
 	return -ENOSYS;
@@ -48,7 +48,7 @@ static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 #endif
 
 #ifdef CONFIG_CMD_NAND
-static int splash_nand_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
+static int splash_nand_read_raw(ulong bmp_load_addr, u32 offset, size_t read_size)
 {
 	struct mtd_info *mtd = get_nand_dev_by_index(nand_curr_device);
 	return nand_read_skip_bad(mtd, offset,
@@ -57,7 +57,7 @@ static int splash_nand_read_raw(ulong bmp_load_addr, int offset, size_t read_siz
 				  (u_char *)bmp_load_addr);
 }
 #else
-static int splash_nand_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
+static int splash_nand_read_raw(ulong bmp_load_addr, u32 offset, size_t read_size)
 {
 	debug("%s: nand support not available\n", __func__);
 	return -ENOSYS;

-- 
2.43.0

