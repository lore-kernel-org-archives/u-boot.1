Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A1CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F041409F2;
	Fri, 16 Oct 2026 08:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoUXXPDAcJAJ; Fri, 16 Oct 2026 08:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A218409F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139842;
	b=JnpfKF4mTB6lyUw0K90GD7QHCImV1OedzQai9/Zc3lpGTRWMWO2wlfwM3VwWsOfavf8W
	 w/CipEqN5LaIgkVHy2Y7R/8uJNy8P7nxmZjNOgHX6baUAd6KnP+wUZIc7K1LopAWJX9aP
	 ggBiodoX5wXHcYMjZhSZ+dqsmRdw78Lp7iJRZ/1alOmyg64bhR2/8OU00Pz0iX/TV2+MM
	 J0pnBY9ZRwR+tv0ZyNWXLXtLwXBZlNF9E53v/Kh/eO7dirm4ucB+q611sYA8WyA9RF7mA
	 RTCSxGFcyZzBN1IO5QHMmVZU72vit1teymaDtUA+tzySVukL48iWP7Ke4+ymBhS1QDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PAoDcCx7PUAyYtVBFO4wSYBy8zGiJhIS+tu6GcA4AnI=;
	b=q0ifWSj1z78BCJrAm4N3JBGzqg8uH6X8G4nURmWPQzpuCgwKY6suIbgkq4jswNej0uQK
	 Uk9OLX9aMFvJ/W9O7MxaVpHM2eaXKSG3xfs/znyZMbRRPgVHpuM7VjrjHO/dhcTkt3eup
	 92VcQ5JhoyEAXk6VUoSNdlV9K0QCzJvtATtDhsXAsr2gjwEJ8A48gEvV0tVO0r7BvOpVX
	 JfAOwUi1vnTM4XRc/lrfXS7xBLXBwMqoMRiISXYNymzCV/qci8TJa5aVG1yCfzGVVgLoT
	 Vz1ckrW/eqseArvA+oTv5iWjChYiQ2UjCOGl1Ydcl5wwnOXXG/bZ370YYIPbyHOcfGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139842;
	bh=PAoDcCx7PUAyYtVBFO4wSYBy8zGiJhIS+tu6GcA4AnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L32ESLq9P/UYnIAZ/dV7DwjX5x6WAJUamipZfHQekAdE4xNPIyATjXwkwfymXRjhO
	 IuA7a2/xrDJ4yOBmkhySvGCco0FtM8sXsdMtyaIOCICi10L7sPs6yKSJxFWXYSzGi1
	 KIJ2fUic/M1mfSH53Qu7lQBR1tyWX2s1WKYz++h1keUGTI6ZjBUWBp7TEk5yvbQAp7
	 RdXndR4wKXbd0c8kYrdTzOGmUd8Ck/nt6XRju01Va7XICpTIatKWIgsROCMQOlaLwA
	 mwvpp3TZr+WMA3tOUK7/hxbuJKFSPy0PmWn8d+tAmfwOcou4aoQL7r8IpneATuak7Q
	 N7DMIQhlEyG7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A218409F5;
	Fri, 16 Oct 2026 08:37:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDD1879D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF67460A83
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eiQbLjGX65bn for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A933460A73
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139835;
 b=r4xUNKzONuK1vX+4BsEYWwMsDYWa4IV5ImP7mavmppCHl3gg/cdYd3WTmJWu8y+hF1CK
 nnDzi/p2q5fY1kBrxJXxTF7LOrqhZFdFEPm2EYmhiM88RwXx9Y5BkbeXrSjLnzkfSX1tQ
 iEmWZTE5VLGUV/yXNbGWgvQ4WEVl/DhdbyLvB5DT+GCfSs6/9kkHx5EYCUkvH1PkDLpc5
 r8OEkjtzw8QJVqTD3cZwGH/rZgeXONK7BbDyF3bjJXc5ZYyU1+lFzdHmZAmm5/IK/4L8/
 qrakJaMz+aoUZmJyiBl6UXXy4Kbqjiem4M8s+BxvlhIqRSWR5hOGvJzfFK6/IXAP7Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139835;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=PAoDcCx7PUAyYtVBFO4wSYBy8zGiJhIS+tu6GcA4AnI=;
 b=sKElJG81vHSrD0cxJHT7pxHVo0T2IQmOMuKr1Uhuz50+BuPJGbAvaivgbcHd9DG9DJXE
 dd8PUyv6SfjtQRLk4Szi8ZulrpuFXza6fokKI2/llkxo7+GlbDocV+r1a8d0kEFJcIxDS
 0xRWyDsG5m7o0yXLFGF6Pbwz32Y7eC4iSHgyV+5yEFsp96GmylZoM+JeWCsqpAZJt9WCf
 DEKF4tledcR8WeDTtl501boxYUN+IwYyj3ioTmF4Un3+9oSfHQK3IiQ44JMdtoDpreOx+
 s/Viqdb3v9nlRkn8euGbYOlhWVc2tPHEacdTdBiZXM/AteV+p/LdFa8VSLONWQfK1Xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dnsFJall; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dnsFJall
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A933460A73
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so983994f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139832; x=1792744632;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAoDcCx7PUAyYtVBFO4wSYBy8zGiJhIS+tu6GcA4AnI=;
 b=dnsFJallfD2nyXuZfzCAzZSAlsMONYJL5NLujuGVSniXWsiaB4WX1jLuqLzgRuQPj2
 TjfTNGXI4/681XN3BiNeG0P2YfmC4dJ+F6xDuaM7yX/t853qfCV/cpOEPBTMDvmoVGfl
 /3WzDahldCPnYF/Goc/ioBYrDTwMAJu4+fJrjI2pCR3FGEuZR20qMEPbUqqORlmLDCA9
 FutcoN/7lNtqlfa+yGPgmUc22W/4Uy6S4sQ7shDt4whdTYHV3Y768XVodMysi0tdmn8L
 LJcX6A1ryx9Z0LazTzfrEb3U4g9bEKXFUouEHXPr6hZtr2jR5jyuzSe7qZFiAyB5hw4t
 Q1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139832; x=1792744632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PAoDcCx7PUAyYtVBFO4wSYBy8zGiJhIS+tu6GcA4AnI=;
 b=tnQYYf2KSQ2yRCl16D4d8oWpJ/V/z3flbkqbqO7dgDnVfN6o08UdmiXQuOKusWUUVR
 QZAIKN2dv6YMD8eO17CPQ3c6oUhPKRYd/liKxj2Ul2jgG5DAry+v8cpuN7jfRhJzHjN2
 ni7EMTEORrjf+CKAQYr3tIpdnO4fTyaIrLTBB3UD/JZm3VeWV1GVxV2bRHRNNWZ9vdgH
 PvoxW6pnQRnjI/zMbNG5Uraz7qwC1q4nX6wMz7Ryv/4Q+NzDM0BevJUH5Szj0/3iC2Qp
 TL3JBn1chMawqESEHbdKhhzf1JUvugtPsbwrYPwy2TbrNUDTsdrPCCqm1mcajZQHbrLa
 BPLw==
X-Gm-Message-State: AFq9FYKH6eVk0HKo5SuutdYcm0nwEMULRPRe/Ue2tna8McOnCT7KaYqf
 pdiF3ebxSf3xPqNv1NL0sTLTIN6JNicqodZYrcjzaf9IJrkjkPIx01phQK+A3sxQG+V9PQ2pkCf
 NfSY4
X-Gm-Gg: AYBFou3WYq2rZvqQTYhGSPrO5TjY1oxyHpIT3hD47WdZgdGXvDoGA18f10C3HTzZbns
 OO7YAFaluD7gvYbgQMGzrl88gm78iT4EJE+aeHLNpTCleMDvyLvDeUOEFZnbYYsfpA5dtWafS+Y
 nFqoLYHZ4yqUukJxYF8NcWTCu0DHQEW9Mxd/cAMYScI7C/87YAgsplsOe6yjoCyAV49UMopqOXD
 y3/MkTwklb8ZWPMlVhEzs91wDkD+xJ3ru0bFssiiyTr0zwMQLM7FByffZclBlVMWYMu5+yas5rY
 lexQNdkU5TaRJg2bbi24Q7XryrEmnfJ9zKjoGBbh+GJfo8gKNv5Mj3ZOIQzg81RQx5jPJeMSasp
 9DtHKvOJeW67lTuOzC+gXLUAMyAK1eeZmvVX0K0TjsUTm3nv5vAvUJiVAx082d6xKWPyGJW3Eaj
 pljVuYzmwg12BoEC0hnPaDjurOBqyZO8J7pc6SEmLVAe5UiKSas5RrMRs175S0XS6Mpryvo+Maw
 LkGqC35Fk5+7xfZ941c/wHIxF2XlJNq2sJI8QhwUbNQ8i81UE7PGlCMT8ivKhuVwxwgDaReGmqz
 JRFosGzQJaKkTWE=
X-Received: by 2002:a05:6000:402a:b0:48d:f99d:a0d2 with SMTP id
 ffacd0b85a97d-48df99da712mr5332533f8f.15.1792139832272; 
 Fri, 16 Oct 2026 01:37:12 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 16 Oct 2026 10:37:01 +0200
Subject: [PATCH 3/5] boot: fit: let callers choose where to place the
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-3-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

If a FIT specifies a load address, the loader writes the base
devicetree there before processing overlays. A caller which wants
to prepare the tree at an address of its own cannot prevent this
early write, even if an overlay later fails.

Allow callers to prepare the devicetree without writing to addresses
specified by the FIT. Alignment and decompression still take place,
so the result is ready to use. Keep the existing bootm behavior.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c | 3 ++-
 boot/image-fit.c | 8 +++++---
 include/image.h  | 7 ++++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index e65114ff835..9678bf9c9b6 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len,
+							       arch, FIT_LOAD_OPTIONAL,
+							       &load, &len,
 							       NULL);
 
 				if (fdt_noffset < 0)
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 83e731402d6..c3d7b59bd06 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2221,6 +2221,7 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	fit_image_get_comp(fit, noffset, &img_comp);
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
+	    load_op != FIT_LOAD_PREPARE &&
 	    !fit_image_get_load(fit, noffset, &img_load)) {
 		void *dst = map_sysmem(img_load, data_sz);
 
@@ -2445,7 +2446,7 @@ static int fit_image_load_alloc(struct bootm_headers *images, ulong addr,
 
 	data = map_to_sysmem(buf);
 	load = data;
-	if (load_op == FIT_LOAD_IGNORED) {
+	if (load_op == FIT_LOAD_IGNORED || load_op == FIT_LOAD_PREPARE) {
 		log_debug("load_op: not loading\n");
 		/* Don't load */
 	} else if (fit_image_get_load(fit, noffset, &load)) {
@@ -2658,7 +2659,8 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
+		     int arch, enum fit_load_op load_op, ulong *datap,
+		     ulong *lenp, bool *ownedp)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2697,7 +2699,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	fdt_noffset = fit_image_load_alloc(images, addr, &fit_uname,
 					   &fit_uname_config, arch, IH_TYPE_FLATDT,
 					   BOOTSTAGE_ID_FIT_FDT_START,
-					   FIT_LOAD_OPTIONAL, &load, &len,
+					   load_op, &load, &len,
 					   &load_owned);
 
 	if (fdt_noffset < 0)
diff --git a/include/image.h b/include/image.h
index 4ef5344c718..7c67f2a5d7a 100644
--- a/include/image.h
+++ b/include/image.h
@@ -608,6 +608,7 @@ enum fit_load_op {
 	FIT_LOAD_OPTIONAL,	/* Can be provided, but optional */
 	FIT_LOAD_OPTIONAL_NON_ZERO,	/* Optional, a value of 0 is ignored */
 	FIT_LOAD_REQUIRED,	/* Must be provided */
+	FIT_LOAD_PREPARE,	/* Ignore load address, but align/decompress */
 };
 
 int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_start,
@@ -719,6 +720,9 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  *			name (e.g. "conf-1") or NULL to use the default. On
  *			exit points to the selected configuration name.
  * @param arch		Expected architecture (IH_ARCH_...)
+ * @param load_op	How to handle the base image's load address;
+ *			FIT_LOAD_PREPARE ignores it but still aligns/decompresses
+ *			the image as needed
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
  * @param ownedp	Returns true if the loaded image is separately allocated
@@ -729,7 +733,8 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
+		     int arch, enum fit_load_op load_op, ulong *datap,
+		     ulong *lenp, bool *ownedp);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.56.0

