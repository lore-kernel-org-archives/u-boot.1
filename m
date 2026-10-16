Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE2CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64D8A409CB;
	Fri, 16 Oct 2026 08:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTe3mQ5iHfxo; Fri, 16 Oct 2026 08:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AACFC409D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139839;
	b=sO5iev7V4w/WeJq5jgGGSN3g8FQ2IjGAmPA6ARDZ1D1BjvolGneRkIPKf2gEcZE5VwRf
	 4FlAwMHjgPxyxFe7tfWl1MAK5eqGQKPwV96MJ+jFvQRpBaznaN9iOz0hyuCfBW072GIhb
	 6eOmHVsjKFBZULywHJisbvVjGailczM6CBKBSnk4h1Y1rk8Rl2wOXIwws744nE10MxwSM
	 3f2Z4esZkvX0PI9dAMRY0yVZCWKN0dqf+eoiMnv3yjADuXDTNcCs07yTPEuFjwpAkjiqB
	 Rj5ZEymtOnBkN2Khppi28s/eq/q1pSm2xAQ/RmdpiLp3pFVfLyJNJrX8cGjwfxFz5IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XeB5ggHR1cKKjmhh4qrAknQUDWyhGfG/HzqbpUtrDkE=;
	b=Qztzqgp5Gwwmth8mgT4scVGQKRLG38SNh/9VTi6AQMJtfAhap31eYbTf1HI8UTsezd1p
	 3TQUiAzkkq7Wrzc1j3h81RVkfiBNGhBTsjFku9po+khgEKChuo3knQDeqybVJkDreVZSl
	 VgY7O84bEsbn0MPs5n/btXAfMLb5GE6iH+4zUUVU4v9mrVN2xEwDrcqx+ZRHmlvXoQ31I
	 evBb2OUdP9X6iqUA/8ZXIMwtJeIeLvS1DSUeeuxbVkUFAmq87uxPcTzM+6+qtPrZhKTI0
	 l2yfeEgI9SnO/eem+WLUDJmaK4y7NJpPvmSSogsDxvkmVw8nq1ow4JZ6b5OARoozvFQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139839;
	bh=XeB5ggHR1cKKjmhh4qrAknQUDWyhGfG/HzqbpUtrDkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3uNtTfgGMPpLQYiODZO3SKMGVesMywrsXUa99rfNuY3D4fKvFhlqDddo7SgIw7bY
	 GCbQ5MtwwSA0Gehi15Wcs1heJ3pgqPirIyJRCm2Wqg6E0xw6pLNLSgbtBl7YSiZnXM
	 vZP/GteSw3/Mdg3JM7/bK53ljTGfawp7ADCBD7nsdGt0IgI45x65KfJWrxNcZJejY/
	 jVsVfWshKnrZQun1NodKivy8vLwQf2AqQuqdcwQRMM5zh9dII+WfrcjJRGHyMF14NN
	 0F82vDnH1trL70SS69H1prUMpoVHU1uIYqx/D9iYWNIVKiI6poo1EmYHToZ+yOpXGV
	 YPkrxO4S+6AxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AACFC409D0;
	Fri, 16 Oct 2026 08:37:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AD981AB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0EF760A83
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2A5B9D60_-3T for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9439D60A72
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139834;
 b=PuZz8DPHRaptbcoCVOYHOe9NY24PJBfKXrZES0xs1cppFxfPVwTuaXRtkTHEqBLENvbu
 uysHA06pYiVFXoz8mvY3bUTxBdL87j5dY9V85XoT3u0ZQuJgXzCK/SAgEoSFw39Sl7syv
 Dd6iyc/A2LoUiOECAMecYe5KoNG3PUp4WYDdm/BIo4HBqOWyXYcmYzEm//1GIsD1gvS49
 ANDnN+fzPU12fIEH0EBfBUu2HFMnvsDkyaOMhZyHVSRaECGE2JKdn6ai/0Ooar/l9iviq
 2HVi6loz4hecZnG3RyrajO0RwvfeMfbetpL1/Mh8ZYh8artLBWqk32yJwBAZd21bgqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=XeB5ggHR1cKKjmhh4qrAknQUDWyhGfG/HzqbpUtrDkE=;
 b=O1MRVZUlRf9QOZ98h+sO8kxZ2xxD6UM0h1WiNuo9QZcIgWkOnXJEE8EZe+pnupZLzi4v
 osP1aZMjM9hmwjlc/H/OmX6It0Dq8qWmhO65iS7gGXp4nNKQHDBglb0QGZbGr+t6ermhz
 3IZ//yZ9ZlqYttd/LsZmS+15RkPj12carbMrLjgt5bKEe00w4/6I9TLgdOMI0f+ekfvtK
 BZAI0vFfNQDZmewemN03NnHjS/9tSmAy1cOpNLRB8Nsxg46wo3NcnopvroADAHMJWzmRx
 BNku/h2Tu0oec+/KPuvWGdOl/UiiXcCn8D56292gNCTL79s6dM1Fp/JxJSaTiU66H2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TD9wr4Dm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TD9wr4Dm
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9439D60A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:13 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48dfdd431dcso233404f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139831; x=1792744631;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XeB5ggHR1cKKjmhh4qrAknQUDWyhGfG/HzqbpUtrDkE=;
 b=TD9wr4Dmy3EKyNKDf9LCvT60UX2lgLe05G2Mh23dhLA+ss6EikyxW1wnoHHuSsu526
 t8ed0f6WrsFc4oqQ9XZZg9xeLkdaOugGgqr+8FBVA38EE5qSfzhlGUwLrd5ZRM3jX3ko
 WwlJjwzkneO+ZJWzaFvg1wEaMsEHbzr2a4KhdqA0YgBCpIcFQ0UTfM4522+GgyfME7Ws
 KZgibn3xctGza99xGN5Y3jC8VGjKd3qfSqmUcvfa34Gr42pwHwvLYGgBjYgEkNDmu8I2
 KIQjoSFddzwshM9KyPASQy4drmPLeeLvXw6SjJCqsBvURx+YF4brXfeGX5xexUzOUyHL
 8AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139831; x=1792744631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XeB5ggHR1cKKjmhh4qrAknQUDWyhGfG/HzqbpUtrDkE=;
 b=0uYjyCiSOYB9CDNxi8CkXpjquPsUeU+TJxO30UZ8Mi+i0WFFY3rWFcBExLk5E4TZiW
 KorJRFOYXGLvq4Ve347dc61S/Q9ojmdOHNMhTiCycw62yI4gU8GcILManbPGJXVbKlie
 grXknp9UuotpktYkGVaOLdM93nobguYU5aRfa50QveDFzKHj5TPfqVnWzwU3Ia0GT67b
 M0WUcOhPIkLiuG0HOfnl8fPj3uuKSqBMoUpn/+mdKuxPURxPTV7SByL6gKeCjt6QRIt3
 hwUoB8ywIfRvpUikiazvYLm8ZUUo1iH7+YePsAvvqnBai7tBiwTpjseWvqMd0q7I2qo2
 SbBQ==
X-Gm-Message-State: AFq9FYK08jU4g1Y2ZU9OBVBbPcjJLhhH/aA4ZuD4ups5dfnstpXW4aNF
 HXpl1B56WlJyT4igZ2IpxutQwSOteD5AyQfiPE1S3aZcXf8zT4uyKwp+nJd1NkDMNok=
X-Gm-Gg: AYBFou2EAT8kj6DPvGN4cLqzTFsd8C7p/EFmL+pGKg9hlsdqhaRsKaho06NakAFmd9R
 HMcoggV4MJvbvi3aU0Uwkb2rUdElWAID+TASB9myeQPxiqAXsdAO7uIY9OOzZnEQ+SKC6A1ocL0
 ybbFLj+8mew8taNI7hDhjzJm+Z0DN8qpceQT64+lXrHEO06B9k+tY3RKpsqi6vlJi4qS7aPpIjY
 f4p2M6ezzoTRzau++cSRT8doA2MuDlAqnI7dk21++0L3X5Re478sx1LTLTlpe1NpTBrybP7WF2K
 5Tkz5jGIgbzvbGSllU2IJMaS397gQJXJzLBrLolqDQICBgxSchyCmZPylH4O9zB6X9gc7Ai4H45
 2n5LDdMB7lGIWvV21pghSm2BnMLzCvaUuSkCWpAxttbeHx2RMrgi5/qYtsxeXO9u2X2AIgZSAQL
 0xb+2pjGYYEl00y5knbVZTHIL/6JisZQinh+Ohw3zQxgwUTzEe+fKK0in3NgInPOkc/r3KkT7/V
 f+2DfiriMO68ch/+3q8HYv0F9/PQ0KEkwt1WpPAroiss5ujhl1wl6/ZRGSmCFUfpH6eKAvTQPEW
 GPQ+1FvyBfs/IRs=
X-Received: by 2002:a05:6000:2087:b0:48c:6008:fa33 with SMTP id
 ffacd0b85a97d-48dfae82d4amr6084590f8f.24.1792139831034; 
 Fri, 16 Oct 2026 01:37:11 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:10 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 16 Oct 2026 10:37:00 +0200
Subject: [PATCH 2/5] boot: fit: reject configurations with missing or
 invalid overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-2-f6286ef82364@baylibre.com>
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

An overlay listed in a FIT configuration is part of the requested
devicetree, not an optional addition. Currently, a failed load or hash
check can be ignored and boot continues with that overlay missing.
For signed configurations, this also means using a combination that
was not signed.

Reject the devicetree if any listed overlay cannot be loaded or
verified. A missing image must be treated as an error too, rather
than falling back to the default configuration's base devicetree.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 4f4e7b4e06a..83e731402d6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2675,7 +2675,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	void *ovcopy = NULL;
 	void *base_buf = NULL;
 	ulong base_buf_size = 0;
-	int i, err, noffset, ov_noffset;
+	int i, err, ov_noffset;
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
@@ -2752,9 +2752,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
 		if (i < count) {
-			noffset = fit_conf_get_prop_node_index(fit, cfg_noffset,
-							       FIT_FDT_PROP, i);
-			uname = fit_get_name(fit, noffset, NULL);
+			uname = fdt_stringlist_get(fit, cfg_noffset,
+						   FIT_FDT_PROP, i, NULL);
 			uconfig = NULL;
 		} else {
 			if (!next_config)
@@ -2786,8 +2785,9 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			BOOTSTAGE_ID_FIT_FDT_START,
 			FIT_LOAD_IGNORED, &ovload, &ovlen);
 		if (ov_noffset < 0) {
-			printf("load of %s failed\n", uname);
-			continue;
+			printf("load of %s failed\n", uname ? uname : uconfig);
+			fdt_noffset = ov_noffset;
+			goto out;
 		}
 		debug("%s loaded at 0x%08lx len=0x%08lx\n",
 				uname, ovload, ovlen);

-- 
2.56.0

