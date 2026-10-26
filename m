Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC149606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sNPtjkSh;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NrjTz/6J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF03940580;
	Mon, 26 Oct 2026 12:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rGBhPihPfDyG; Mon, 26 Oct 2026 12:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 01ADE40685
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017143;
	b=nGGp2oF5wXyVzKAnDrR01cbaNDCFnevw7prJGPZeJoGRBEKp+VL0dJ1dSjCY+68AN6+v
	 Iw9aCiq8uLK33x6afVxe+jlNIe04BgZYN0C6GEZKRd9/svoA12NC77FvY12Sf9D0i+0Oe
	 KNqyKYcDP/qP22MKpupnnuCUrLYHc5KFpN84Ca5TFvyjhT0CCSjdrhdOoqLmb9jD8hIDs
	 j7jlbd5leioFYt7d+22bA7DgE7N+fII5Okma9cmccMWnqfJngJ5/jM1mGqx9t7j4yFoDm
	 Un+DyYUPKoyjNlms2fnlofuh8jscHIfwM45ZKk1Wn4gdTwfPJuy4W2y2g6JYBVdy8DQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c40YX3LeSaHUlVTvZLw+r7Srf2aYmeZsG5ip7nAWMtE=;
	b=VmHLiJzSqRN1KWtK5G2omKei1WRaiQtx7nldKXfN8LLsnDMor5AtmB9l0sUJJufPOz26
	 LPnNfkpNd72tkp2Dl6d77vBkKCf/RgWP6WBuZ+h4R2o/AIEyreBsBQQ3mOlNlInzj/S5u
	 1dY1lslZQv4WRYqObtoiNtqwsfi/ynY2Nci38aUvktxnNymsLN6gee07Cgy0+2F1HxiGv
	 5qPBcxz9KKzozWYXPIvnbWnJy6mDRdEY7Fjc4mmUF6Ri7kJhuc6aKPJRJRGazvTe7yvkw
	 u6E6Y7VfSWzgndEu3N9NYXJBmGtZclcWoRaXskGlOSBkxYEyblDGo3S1Vi7TV1QdVVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017143;
	bh=c40YX3LeSaHUlVTvZLw+r7Srf2aYmeZsG5ip7nAWMtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sNPtjkSh7As+zI3XD+wVpOJiEtQAxXOe4qwjdAbXC7FC0L5hlsoyQJkPxxU0GiiGn
	 72tjZMhN4XIbparnaM1SA/Gig+sJBBkFs1U5tlIjej1gc2BhWx70us92hr6bKLILQj
	 Suzb3l4a0yQ418BfrobzXYanwXp0pG+QJMEswlv+s9mYdTnxXy1guyC7+uV2ag7+ta
	 Z1Hgqa5ewfynFg9yKFmyrIb+EG8ml6IsHkECJA9v0wx5Ab3DmtLxCEp+pHn7RsRx7+
	 neDzzgMbpWCB1sKC69A4KaHmL68La2drxjXKuaYT2N5MfESlz/HNEflKKw7ov4S+CY
	 FfTZ6c8v4MfnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01ADE40685;
	Mon, 26 Oct 2026 12:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F58A356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3122540062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNbRiYZVimGI for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 184C340060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017141;
 b=eSMaNn6sg42fgYoQXha1EMw8oN+sUIeZU+TtVWkLl4+XajmXk8bfMF4QhM2UmU77RcOj
 OTtCJIPaIj23HPkh7Ravpu+h9DqQoikCRFElu/0U9zb1rKwlpGWgZdB+/ZVErdMXhfwW7
 ZWTEpt71KTvMj031cBETvgSLG7THVsJra7p5tzrN7ojnvg4hXyjgZpn+1wPmruHprIc/t
 An9PgwUCV7bK4kGm38FD2pHpuTWRs9QH5lRDbWyhSZIidzOS78+m+OmFgR3eIAzSE6KQQ
 U2uF9xUTIf0OmTVAHYEwt6dKn7vUKo4IiCkjv7WFuRl5zeciLUW8zuGdYXfqBqyMBLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017141;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=c40YX3LeSaHUlVTvZLw+r7Srf2aYmeZsG5ip7nAWMtE=;
 b=TI5TbJ3oZV1DsOz2vn5ERAmH84KFRCZwURMQ38abAgoNQHfg6ydK2pox4DX3kUVckmCo
 tQw/tkNTQqXrONVZ4GQSSzDE/qb+MK6fApTU+N4NX5dAXXIS8Qas5PQwmz9hY6Sbd39/b
 koZLIZQm0pxswa5M95NL0PuVke6jC9BsZ6BIkMjlQAsSv9egzCtMsxeAiywaoSxp1J8f8
 9xgeSrxKvWsyARZlN6BwoGVl9TjYl4ir9WsED53YOJXiDEtvXFmtxR9z/ovgXYrhv8Jm3
 0y/YHucdvrzrvokauDPOCdv5qov+vLAsMEqs0ga6aNhwvTD6q+6aKH2E56STOQcwTiw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="NrjTz/6J"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NrjTz/6J
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 184C340060
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:00 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so608937866b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017139; x=1793621939;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c40YX3LeSaHUlVTvZLw+r7Srf2aYmeZsG5ip7nAWMtE=;
 b=NrjTz/6JggL3fOPdORwd5nTcqmjLXe4jz24ChKYS/lEYpuUn/KeQLjknB3Y7lLtt6/
 MqwYiINE8gz9/js4y1fIz70T2BKcW8RHrnbOFT5YR62hS9eUnByBFNjN3WkL71ZHKeC+
 rjltE+YkZR8IgmY+tL5gQ4bk9Lm1Vc/EHWmP2l36yDuOkujCiO3CSizA9nPQd/N+pD3s
 cTAXNnfp4FLG/yEJFcZvPmwz9Pe6uwpdZ+kyye57lg2BXY+QkRjmekmDqcE57O4DVmt7
 zdxE1Og3YPN9mp3eEb8Bm3nrehtxPC1p+oH6UcxgGbGvvnH5z7hdQdtSNA3thiIsOOM6
 xXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017139; x=1793621939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c40YX3LeSaHUlVTvZLw+r7Srf2aYmeZsG5ip7nAWMtE=;
 b=MHIRQGITJcoIE5Q0Ou4+QY0/jW/tqpWQr7a4+/K0rJkhPj7BH0rCIu2ZMDqVgDAXXj
 9X92trI19EPoIdnd7XikBgIbZ2hv1mhK0kgkpggG/12xAeCjzTU5nW3UkAghOFOa+Xi+
 fNs7ESHQjaDwFqloujeKc6I8gVfVvsEjbs40s/hy4fl8/qNdRb+DLbmT9fmGqtTtFI9b
 AqT5spBETj6liQ/anY05t+88VToeIKJ4AJHXeJNWNKsmEbPZ5B2qBcJvDFgnbox1qZk1
 YN+9EEU1HtATZ4DVN6LNn48hEU9pezfohp6jIP3MQhEJsncK2OsPR2LiaNXlRs1aEuQ6
 cVoA==
X-Gm-Message-State: AFq9FYIHb3CvRBAdahgYfepFiUuJf/+YB1e1iEnzyJRxfTnhSwfbV7ZR
 jz2IsrGpzFAAviUKel5SrSbVvpYMDVGn9fzDGHNnlQXoJ9hq67Sun3PUb+f7YtgHEzU=
X-Gm-Gg: AYBFou23pbLOlIUkMAxuLAdlkF5/ws2aqzlfzvcCGk00Ypm7MvCBOqEuzXpI0qXekJU
 a0Gd0R/O67BTpV/q5R8ZtAAbMb02lC/cSuAgbPXlgatyw9BsFM4eEfUt9hSR0p6T0JBYlxYOs5U
 5VQei3sKNmGFPIv+WZHYw1gEGyOU0cmpmxks9Zp7jD1g9nK7t9ZAp+NfyHLVKi6xqPEria1rLWt
 NENmJmdUzGs93dSUqIRhaFy1pMIzPcut/VaQE4cGy8YaWBYK2q8eGECk7JUJc08g0nyY/8gdiyW
 4lgc3+Gg0MpPBeBtOdmBMS4MAJyaJXhEhfBSk27CIVWrDL2eiIGhMhblUpJAAHWfxGKavgCaJmT
 pEa+hkXDjIpyiegVmB+A1rTZDZwTJK+SGBh7M0PYibQktTce+TXapKL7KbzvapQobSDEdC8jNFe
 bNTOTqxsEbEIPKoB5AKCdei0A+h7ARrNWhlyeGSjnfxCTtM9JtlTvMRd+B+rsjdNEuo+RV4gHHp
 ntGyh2L1L/HkhZZZakneZ1nvexatLfYYd6fqjeqff5vzY/K5sOTfuJEy0Y5+KfM/XAxZk7jm4ws
 EV0iH4dFi3dbU0DkH9PbNZV9bYGe5YGTUQwjlFPzI7By9389FbIeqMPNUy/Z/SVmKfuhJgjJ
X-Received: by 2002:a17:907:7293:b0:c46:9711:e30e with SMTP id
 a640c23a62f3a-c46bde23f75mr772874066b.29.1793017138696; 
 Mon, 26 Oct 2026 05:18:58 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:18:56 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 26 Oct 2026 13:18:22 +0100
Subject: [PATCH v3 3/5] boot: fit: let callers choose where to place the
 devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-3-6c5d86c3007f@baylibre.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
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
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a FIT specifies a load address, the loader writes the base
devicetree there before processing overlays. A caller which wants
to prepare the tree at an address of its own cannot prevent this
early write, even if an overlay later fails.

Allow callers to prepare the devicetree without writing to addresses
specified by the FIT. Alignment and decompression still take place,
so the result is ready to use. Keep the existing bootm behavior.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c | 3 ++-
 boot/image-fit.c | 8 +++++---
 include/image.h  | 8 +++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

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
index 4ef5344c718..882a772a727 100644
--- a/include/image.h
+++ b/include/image.h
@@ -608,6 +608,7 @@ enum fit_load_op {
 	FIT_LOAD_OPTIONAL,	/* Can be provided, but optional */
 	FIT_LOAD_OPTIONAL_NON_ZERO,	/* Optional, a value of 0 is ignored */
 	FIT_LOAD_REQUIRED,	/* Must be provided */
+	FIT_LOAD_PREPARE,	/* Ignore load address, but align/decompress */
 };
 
 int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_start,
@@ -719,6 +720,10 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  *			name (e.g. "conf-1") or NULL to use the default. On
  *			exit points to the selected configuration name.
  * @param arch		Expected architecture (IH_ARCH_...)
+ * @param load_op	Load-address policy for the base image only; see
+ *			enum fit_load_op. FIT_LOAD_PREPARE ignores the address but
+ *			still aligns/decompresses as needed. Overlays always use
+ *			FIT_LOAD_IGNORED.
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
  * @param ownedp	Returns true if the loaded image is separately allocated
@@ -729,7 +734,8 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
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

