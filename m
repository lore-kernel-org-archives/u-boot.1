Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57588CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4528409D8;
	Fri, 16 Oct 2026 08:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y80GmOe5V0Tx; Fri, 16 Oct 2026 08:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0B6C409CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139835;
	b=IX3DXBE1y5PCtNKmbTqOPc4rhooOql47OAAsyIV/t9qN/I0nc9UDxJdFlhKuzQjxXvge
	 59z/F2shuvoNm04R2C0z1zFFqk5yLwhSVuGqFp3lauXblJ4KtQCjWDGQGQe6O9EQeDeuk
	 sya4Hdmnou1+1BVHFsHCKLJsk9B48jTOH3IO1OzIxpT+E8syyshnN5ApsX5dBSuiOVI+W
	 q0BM8qnpLeg1pAczsMjSAzIkAqZeJ/ZJWEKzdpzgLajnttM9tvqYlv6IsXvGNw8fH0n1r
	 RnLuOru5FZtd+O84um7MnMNcSMCqpwBcGTi8xtwDVTzZ6pSW5++e8O9/DI3DOB1eaVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/UUOz9KQrAvT9Ms9ruUp+hLj77k9Yr4sRxHmF8cYVTo=;
	b=VoZUxZOZYCFtFrQ4/LNszlGes14U2U5HrjnTk9//SGXRZEHhLJWZdv+pTZ8khCa3Bo56
	 13iZxtQQeb/s2aUp3PcR3j0wdKQfie6rUceybvvkqGRZLuO1o51r/BI9Q9a1Oc2c1kLZ3
	 vz9qludhif9P37YaYb9pscfTzWttjIm0I9ShsnNxoDbKlkoERzcXZO6XhL+Cc6/JJSkoo
	 7scRnOk88MRytGmbtXXR0Wxlu3UYN6Eino6c/Ae7ff+IEqqLM3OgW+kI1see6u1k5ewh+
	 8195+C5XaJF7G8c+F6yB4IdkYtLHmDvF8ETWZC3XgAgkpKqimTl9yMNgxSRpWNCAlHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139835;
	bh=/UUOz9KQrAvT9Ms9ruUp+hLj77k9Yr4sRxHmF8cYVTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tus+O311Py1VSjBFJm438/W10TQRTKoe4hk5h0vPVYjGj6wooj5gi1nnj9PYn47cQ
	 SD57bLffepmJp5YsH4scQhMSXziseg7rh+pb2XVTqOTBHzjVzsDmbPcr6lolczAOo4
	 eSMfkklxLAF0nodC6Z1lYiCXuiHxQ05O1cYZafqiRfnx0hblODUAI5QrOhm1TvENXc
	 zfX3Dab6JMqcjCShPB/DGsXmqm94TnIFvlCbVtOBZbBYle8KAZY3fk1Vn2Re9Xa67H
	 j79lO/V9I+24aArzyq1MS3QjsFNqriNQ4Fg7f6Chjqo7F5GSGDYfz3wv+t8pQVAOkq
	 mMNoHgSIaCylQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B6C409CE;
	Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1665279D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFFC5813F2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L4jdkhpPKXXv for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6060B81287
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139833;
 b=YzXICK6kptXOaxke57+bzO17HFh5078lSi/WTarVdUFrVYuUsZhE7+xYxD0DpUpbNfy7
 Cz0aLTlKky7kHG4vm6k0jMhsc2fTUE0kbbNiIBH5FzMOEtqQvb03tmgBsvFXBZWrou5vw
 fGVfAXKhpP/HTAlvo6fi3O19jl3zYEKTTmKbpKhTWpboIQUImMm+/deobr9JXaxmKm+b9
 6lzGwN76Nh2BPWt8MCp+HUv6Lm+rlBcjE1YegdbQ7Ee/KXe4oo2J4LDjdfEfGgWXerJN7
 ZWJ60kJCynFBOk8e3IM5FhfyVu+rtdJTbn7ZKtB5HwMrwsmrM8CuwJyNFFHWi0BRYhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139833;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=/UUOz9KQrAvT9Ms9ruUp+hLj77k9Yr4sRxHmF8cYVTo=;
 b=CioUnLr+t+HXQwOWlHDio0nC58/ysxQm5oI5yasfg7NXYCHQ4JSDqqZ+SVWaVZn7e2Py
 gRIObV9ROOLTAV87JBO3O0oNOlmSqKayFeqM7zGRcTGARtEJmze+mChlLrFHMIbIOryNY
 NDmMNSAOUsrWol+/ynFsvB+bpk3kYdrKy245jLAhk5F9BcXlr633tQTNAihFB3s3YdRfW
 FLnaICcDNdp19cTgN3v6aTJw6sbnooieQlze3rv2ItOj4rAhGI8JXAab0mWjud5RV9aRD
 km9CKUZPDlL59N2ln6pkqh4cBMRe+ZxdarVuv2jL36qyP32I8Kbz7XgiCcdaitutQpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IH7HzF8V; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IH7HzF8V
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6060B81287
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:11 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so26043395e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139830; x=1792744630;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UUOz9KQrAvT9Ms9ruUp+hLj77k9Yr4sRxHmF8cYVTo=;
 b=IH7HzF8VxLKkdhTmEsN6jdYXwFwXeg48kLTo67EvE8xeNr/2oLrCSlNUqCvfHD+G+u
 m5VS60Enidet/rozOEZBDh76dhRFvS3XgYdVE72bnzYKDSxyMfQ8fF3Dk3Etc0WexoMH
 FbjQq5F9230Rnr9NEtEbcBTs/X4B9rg7rLFlJht7HNGkyLF4YCsKtYwIAdbw0KmS/mTO
 Avnm8X+A1Oms6/uOXjaJ9JIUBw47rEuxlJbT7tN2xEZkvxEeBefdMVGKYCsqTY3jd/tY
 DekqWkq2fSQLaGlPxVJC0Ea/+mmiXDFWnSHDmdzgcaHSBMNyry7xIPJKuAibsMcmi4uj
 xrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139830; x=1792744630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/UUOz9KQrAvT9Ms9ruUp+hLj77k9Yr4sRxHmF8cYVTo=;
 b=hQwSc35hl+nPz1W5L/o6YuGeytiF30FULJqe9YqdQpOopJJG2M34BlHgQkOzWHx948
 iC1s5RF9iGYPLe5bOOP8DXg3nxHtBVZyjTIcXtDz9IrWfCzONF521PuwqruJlQDQq61m
 CB8nU41NPLb2bBxS8nZ9RRWPkPJlRQkL93DW0bdhYwgwhJEg+YThtlh993k3/NdtjG+L
 aypgy7BZWWhZYkDJSUYfcy1Th3kV3FSEHGqPDykGLBoEnQNTCmvSSFqZ2cxR1ZnN6V6T
 vU48oMukvAFjxtXYghPRLFqCB0eN8gzbOlgZJZiYtvyK8suJyBhiE3zLirQjt1cENfRm
 aisw==
X-Gm-Message-State: AFq9FYLzhLVKYgnAQAwnLdyjTg3pVXN0NiREuaIrv6HB/LuYmvvW56hG
 /NZ1IG/Y2jyWtM3qMhbLLJdUcbImcZPPQe4XySvgWdDaH/2AmnDmFBnbD5JqO/joqeE=
X-Gm-Gg: AYBFou2wWH+6+bkNfhoV7vfXMaXPUqy5ZXg5RKYomRsZk60oP24jHfECSh21tJuAVwj
 nJY9Q7su2BNnQiRCt6hV4ovcYAPKVtG6V/8438HNNWeBgl5TDNoVVOGqBKHcrA21jxWOkq6mZ2u
 20dpFwrsJHg8MVMHpZ9b5qg52nlE/VOxkTnrsS94C8j5LBamsR5FzJcnc0oB68KNYrd/hvXvz/9
 BCHfx4FjpJTNJXbEEtnjO/3lpmLsiW4fR9SiAS8qAvKGf/XnUxQEW0MzsJY0Rpad/4xDHqvJ02f
 Yep8IjVzUnKMhK5ea39nGisMeIqoWEb2jFQYmtQe9o8gLIEg/jQ1Boi5ouvaOoa0gwUW/9U4lf0
 2OkqgHxEgU4mEYIXWipOwHxGv5bbnfpR6PD5IIX48OHN/TRkqsB5hVDbLlI9tuQ3huD36zsgD7j
 4z8ccWOtwYaIVvPflY9iZNfN/slbpnAVpBnK1ADwKs6XPviB+5/olgo4vYrCI8vdpZFM7Ndok3P
 ywSqQOY6jJ8GsGJyJBy1oReOS7/ZnoO4TqceK58x73Dged3bLJ2ModYvZPJ/odl8sRSGpe5I1nu
 hCSnKHOD24KlisY=
X-Received: by 2002:a05:600c:83c4:b0:4a1:7367:5395 with SMTP id
 5b1f17b1804b1-4a18e446f4amr430171545e9.2.1792139829587; 
 Fri, 16 Oct 2026 01:37:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 16 Oct 2026 10:36:59 +0200
Subject: [PATCH 1/5] boot: fit: tell callers when a devicetree buffer must
 be freed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-1-f6286ef82364@baylibre.com>
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

The FIT devicetree loader can return either data inside the FIT or a
newly allocated buffer. Callers which only need a temporary result
cannot tell whether it is safe to free.

Report when the returned buffer must be freed. This lets the new
fdt fit command copy the result to its chosen address without leaking
memory or freeing part of the original FIT. Also release temporary
allocations when they are no longer needed, including on error.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c |  3 ++-
 boot/image-fit.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-----------
 include/image.h  |  5 ++++-
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 956a3d97c42..e65114ff835 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len);
+							       arch, &load, &len,
+							       NULL);
 
 				if (fdt_noffset < 0)
 					return -ENOENT;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 60e47db5fb0..4f4e7b4e06a 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2242,10 +2242,13 @@ static inline int fit_image_load_storage(struct bootm_headers *images,
 }
 #endif
 
-int fit_image_load(struct bootm_headers *images, ulong addr,
-		   const char **fit_unamep, const char **fit_uname_configp,
-		   int arch, int ph_type, int bootstage_id,
-		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+/* Track load-time copies without changing the public fit_image_load() API. */
+static int fit_image_load_alloc(struct bootm_headers *images, ulong addr,
+				const char **fit_unamep,
+				const char **fit_uname_configp,
+				int arch, int ph_type, int bootstage_id,
+				enum fit_load_op load_op, ulong *datap,
+				ulong *lenp, bool *ownedp)
 {
 	int image_type = image_ph_type(ph_type);
 	int cfg_noffset, noffset;
@@ -2255,6 +2258,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const void *fit;
 	void *buf;
 	void *loadbuf;
+	bool load_owned = false;
 	size_t size;
 	int type_ok, os_ok;
 	ulong load, load_end, data, len;
@@ -2262,6 +2266,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *prop_name;
 	int ret;
 
+	if (ownedp)
+		*ownedp = false;
 	fit = map_sysmem(addr, 0);
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
 	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
@@ -2487,6 +2493,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		log_debug("decompressing image\n");
 		if (load == data) {
 			loadbuf = aligned_alloc(8, max_decomp_len);
+			if (!loadbuf)
+				return -ENOMEM;
+			load_owned = true;
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2494,13 +2503,17 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		if (image_decomp(comp, load, data, image_type,
 				loadbuf, buf, len, max_decomp_len, &load_end)) {
 			printf("Error decompressing %s\n", prop_name);
-
+			if (load_owned)
+				free(loadbuf);
 			return -ENOEXEC;
 		}
 		len = load_end - load;
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 		   (load & 7)) {
 		loadbuf = aligned_alloc(8, len);
+		if (!loadbuf)
+			return -ENOMEM;
+		load_owned = true;
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
 	} else if (load != data) {
@@ -2517,6 +2530,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 	    fdt_check_header(loadbuf)) {
 		puts("Subimage data is not a FDT\n");
+		if (load_owned)
+			free(loadbuf);
 		return -ENOEXEC;
 	}
 
@@ -2526,6 +2541,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	*datap = load;
 	*lenp = len;
+	if (ownedp)
+		*ownedp = load_owned;
 	if (fit_unamep)
 		*fit_unamep = (char *)fit_uname;
 	if (fit_uname_configp)
@@ -2535,6 +2552,16 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	return noffset;
 }
 
+int fit_image_load(struct bootm_headers *images, ulong addr,
+		   const char **fit_unamep, const char **fit_uname_configp,
+		   int arch, int ph_type, int bootstage_id,
+		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+{
+	return fit_image_load_alloc(images, addr, fit_unamep, fit_uname_configp,
+				    arch, ph_type, bootstage_id, load_op, datap,
+				    lenp, NULL);
+}
+
 int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 		       ulong *setup_start, ulong *setup_len)
 {
@@ -2631,7 +2658,7 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2639,7 +2666,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	const char *fit_uname_config = NULL;
 	char *fit_uname_config_copy = NULL;
 	char *next_config = NULL;
-	ulong load, len;
+	ulong load = 0, len = 0;
+	bool load_owned = false;
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
 	ulong ovload, ovlen, ovcopylen, need;
 	const char *uconfig;
@@ -2651,6 +2679,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	if (ownedp)
+		*ownedp = false;
 
 	if (fit_uname_configp && *fit_uname_configp) {
 		fit_uname_config_copy = strdup(*fit_uname_configp);
@@ -2664,11 +2694,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			fit_uname_config = fit_uname_config_copy;
 	}
 
-	fdt_noffset = fit_image_load(images,
-		addr, &fit_uname, &fit_uname_config,
-		arch, IH_TYPE_FLATDT,
-		BOOTSTAGE_ID_FIT_FDT_START,
-		FIT_LOAD_OPTIONAL, &load, &len);
+	fdt_noffset = fit_image_load_alloc(images, addr, &fit_uname,
+					   &fit_uname_config, arch, IH_TYPE_FLATDT,
+					   BOOTSTAGE_ID_FIT_FDT_START,
+					   FIT_LOAD_OPTIONAL, &load, &len,
+					   &load_owned);
 
 	if (fdt_noffset < 0)
 		goto out;
@@ -2699,6 +2729,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
 					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
 					   &base_buf_size);
+	if (load_owned) {
+		free(map_sysmem(load, len));
+		load_owned = false;
+	}
 	if (err < 0) {
 		if (err != -ENOMEM)
 			printf("Required FDT copy for applying DTOs failed: %s\n",
@@ -2809,9 +2843,17 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 out:
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	if (fdt_noffset >= 0 && base_buf)
+	if (fdt_noffset >= 0 && base_buf) {
 		load = map_to_sysmem(base_buf);
+		load_owned = true;
+	}
 #endif
+	if (fdt_noffset < 0 && load_owned) {
+		free(map_sysmem(load, len));
+		load_owned = false;
+	}
+	if (ownedp)
+		*ownedp = load_owned;
 	if (datap)
 		*datap = load;
 	if (lenp)
diff --git a/include/image.h b/include/image.h
index d991b4c2bc3..4ef5344c718 100644
--- a/include/image.h
+++ b/include/image.h
@@ -721,12 +721,15 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param ownedp	Returns true if the loaded image is separately allocated
+ *			and must be freed by the caller; may be NULL if the caller
+ *			does not need this information
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.56.0

