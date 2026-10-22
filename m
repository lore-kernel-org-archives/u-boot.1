Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F090606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fTIkdpak;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=H/IEIS1+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CFBA60821;
	Thu, 22 Oct 2026 16:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJb9lttHTE9U; Thu, 22 Oct 2026 16:20:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89291608CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686036;
	b=Q3c9TZ3bspWcyjuPhOxxefwcX6tDP2mFi8DoNDQhTmCgMd2a1C6uOqLRBr8gqXhfSUa6
	 Rs7PafzgRUxCWuo63MaO3uTLwB5IHQxTW7ZmYgpG6ZqcflLvrXavYyZRQcV9YW3Rn6RvQ
	 +RGgXYqZoVXYYxyV8cjaYJtz5BNvcCHVlid2sDcUPHCc93Yb+4SpQPp5rleLIIaWChyVA
	 pblW98vyTq9nGj9zysCx5TgD/+wPgZrGj0lBCmD9Yel76cbP4Va7QT6188tY9wBHd5vmS
	 pv6VjSddeFdgQvCnjrbuMEzEQBfviAn/+fOTggAZOuPk9WTKEfVDOZVtlkUraCtcgDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5CvMlaQOzbhENammGQDoprXO0VoCUTY1nzBaJo7Acgg=;
	b=V2gtvHnBiZWUxn6448glS7Ch48vvNxD5qGxQHOIBkDKRZmRpiDkXKnfJU3C1rpiBoTsA
	 op5g1Bmjko59jwD4ShUZM9wjeHZ6AUtcz0U9H4kbF1SMDdGrb/XidB0fGUQXmvWaKgY3E
	 dORxO2Gxx+r07eH4sh8Q9yYqsW6R54SwUylXwfn9qovTSIq2+8GrruhX9vaqs9WMMMmjp
	 CiYMMqqhnLnNR4A1yhQtcs6L+b27c95H5MlwSbYfPRywAl+oe/HIER1yTqnZ1JFntpHe9
	 t67bPGzfr73diUzDKsE06X87F0O8LhbBNXwdXHRIa5oQNk2obte09yCBvDJ5eCMrZ5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686035;
	bh=5CvMlaQOzbhENammGQDoprXO0VoCUTY1nzBaJo7Acgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTIkdpak+JmGH0myAVTh54X8U1chytuZnSMPUzdxUkZgt1IJ/op/4rwFlsYCL924A
	 gt2W3O40kjAUoxuQrQsfiRoI1qlO96rO6GlGYLu0T0jcjGByL55q1nFAx/cvRsS5ET
	 qiOJ8wUq6qjHP4w2pIHCqlED7PseJ9acafP7os550LjeYI73LQ4zC0i+0lhwWDgvtA
	 3l0Cs03AHGFVwJt+yBh/tYhBRDvwgNFuMNxDZo40rg0a7Tg1Q3ty4QVTWpZqIq4rAn
	 kUF8zAcLYXklkdEpn20ap319yaJJeFgo2pvtw/H5rRoo7jeAB/T3w+6Rm+Ondufbtt
	 3H91fINTnjLYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89291608CC;
	Thu, 22 Oct 2026 16:20:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1B83769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C785F4068C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mjq_AIdh6CUE for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B30A140674
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686030;
 b=clBct0Z9dHa+M7r/d89GrUMU0bj+X7ufxqRM8/H76CS7WpM9AAQog0PgxFAJDQLH/+Z2
 stJnc9hRnvrxPMafkqkiXQrsWMCk51Z0qzlBoKMaQUIFi4Ut8B6gl6N6z6k5oI444pb/F
 UbNXJLoSVfhYnTwymbP0tWcNBsn8duZMbhibLikiDm9fyi8v/NonwwVZbBbGm6oykZtli
 BXgDmoKyXhTqYFGtdIywZURr3b7vXi7xOK7/NPZPA19aFNR78Tbh5ICB62feoQb2lR1Xl
 E376hzOTwTNGRXitwHmAIAd1bwM0ciUGjwFCU6qYSaR2+JH8Wy74GSKACD7nW9GLvGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686030;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=5CvMlaQOzbhENammGQDoprXO0VoCUTY1nzBaJo7Acgg=;
 b=Oi2Q4H4TyL+x4t4jvDnqRfTQ0SPSylcle6MzzY/nK8PxOwSAQK1OyhNDtGi9+1wMInvm
 OYcVr+U5w+nSs/qFy1/thDGWMSUCwBeiMWxqTJb8a8cjlkK2gIZiVsjJU929T/LFYMCwd
 w42oOzPnvCgGt4/3P3EY7rihCmZDUIlEfzVpb1xe2UaCMHWO0Kgxq5HA/6aoQwlh9pNHC
 2DKONtAwqDE0IxL9eKKrKBEfj0OSBOE2UgvnKQK2ydpgSeLYUQLMwSMUEVY20AemL5hIQ
 9g8h5VrlpHp2tV19CuC0E3Jxxeo3AstqvYn/46B3S1FAaAkKxdeDOoqbwiSY+YqDoww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="H/IEIS1+"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=H/IEIS1+
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B30A140674
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:29 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1458794f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686027; x=1793290827;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5CvMlaQOzbhENammGQDoprXO0VoCUTY1nzBaJo7Acgg=;
 b=H/IEIS1+f1U7Ala7gTKZ299j5v0p5d6Qsd1hnSe+//p6FMWzg3QdmZZE4Pw3j52x6Z
 inHNIGbtdLzaBw7aA09plEfOdLunx9b2I+ZH8gerovDzLF8clihvPSJYC8UP/0yQ/yAp
 iewcEqsYXYW+LbzVIGx/Zr0A1ZsE5IMTbG6KrejvXlkKCKHJDWaN6jkEhNjsbnqz/U3H
 mliL0xFu+EMhmi65qO/O2dXsQENp6Aa3rkvu/T/53iTtLWcGlUcMfW7eyiQRtoGKWZFZ
 57V+TO0XUmWh9OKQ6BwtgjPx8eDGig7ODWotlw2q78Ak6y0+vzxahkauwgnoOjYCU+wV
 qtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686027; x=1793290827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5CvMlaQOzbhENammGQDoprXO0VoCUTY1nzBaJo7Acgg=;
 b=Oa8NjqhbF9/Hyu2x3sD1dIRLY4kwe9+zZxxjGyI0mct8Yis8uS8/jn6XOKQTE45jgZ
 qJu2E+TmAPLBLK44zC+b0y/xe+nb2JvNkAIw4Q2oRD5uJJnqF0Bu60fcj9PlVkcWYuma
 viQYK4PL3zV58OJTz+mUJ6A/9XleOa5BmDZEWvWk8RwHtd82W2jEkpiv9i3ypT7tNlrf
 ZS+LnOOfg7XiYCGoA3D4RpHkrwShpeSAwjnx+XPRHhItzYrgej16pKjiVJDGtQ7vPZ1j
 0sbCudo0pTaRu1MTWh2EaMp6OvhOi2F41aZS9CE+f+fF/PljXy3q+Acg1Zow5dqWK/aS
 CyxA==
X-Gm-Message-State: AFq9FYKYsvYpFiXHTAHiz7rS4WYYmApDz+k2SyZ+jF0+4c14hSwse/S6
 candzk0yua7Bwomqp0gaEJWapSRDCamyALBNVWioywDCRb5J0szTSP4QPP1dpxz+Y+Y=
X-Gm-Gg: AYBFou3coWNoEXtWc9r9AlWSHXW9PwhuNLuR2pRCocFItk2ZhrJEYgBevqUfj5IT8ry
 Y4WLy45gVvYgNwnHAAX1xny/+/infBWdrJh2n6YF8pYZKOnlmSMQwtggp/lGfR0lGTEG61jUsBV
 TTCfgC20urCtBwxFu/31u28X6q3ZS2XaqXL1OwdbsqoeVZA7jDxCETG7IPWtJhZ7roGVRqAI+Lc
 PjLKV1BsEfLXptdf2pVZY8KiTwfXqhP5poOx5CfBO37VEbEMtbPuDIQ/jG03iyoBKop22lzf61M
 q1N8KKrAyQOmnZL7sltkPAt3b9Wn8Nzx6pgtidCMhrgFnxpn2U9HcrkNl5To0ChdofFIQun9SEs
 5Str3pH/itexT5xS+Inw3t0q9AFIKu84NI34uuTD+tE8fH3kgkaXMceCSDwx12xIns/xtOZS8ZF
 2PRZNG9Ltl5Zj+A15fjbSYxuvU0s1iF7UWY6S7prYzEAyEO3W8yIj5Qy9ilK7GuqwwCdKtJjBRR
 tymZ2efpEMKAUiAGTYajdExvSmUzKPXAV1Qgjj9K8Hl0m7vqZvNziVyUsW/W3wQ6sv+XK28DrwL
 OFM9XLBdNjzUZydxJkMdLD+BQVSz
X-Received: by 2002:a05:600c:638e:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a1fdd26654mr113815935e9.26.1792686027480; 
 Thu, 22 Oct 2026 09:20:27 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:27 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 18:20:13 +0200
Subject: [PATCH v2 3/5] boot: fit: let callers choose where to place the
 devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-3-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
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

