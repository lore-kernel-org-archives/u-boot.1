Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E8606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s//R5obN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=d1CCFMfv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D203D80C11;
	Mon, 26 Oct 2026 12:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIOzhRIoR6w3; Mon, 26 Oct 2026 12:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 494AF80A91
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017139;
	b=aRIlqOaVjP5bzmw4Mow9HXivsnBfHUlctdanwwYdKNw/sx4TpSJ89HCzYngHrsuxV2gj
	 mAPGHDVmUe/heD6XtonpHWElD3408vBCSiYGtZY/tFRhyT9tWgqvJKHwdHXF61NvSYa7F
	 3FvZSjJta/9xQu5/vDeDQMukNFaShEluLFbFXdnvA5JsMmRtaqforPP4MMPVXakiT3YR2
	 eajFZmjAqNrU3xUIJLZc63cY+xXv0NMQFF9Vb2FPjRRsy2ZEiD3uoeoIw0gwgF07Zh/5O
	 mB7Z0Oo3lUyUYzB93RUnIJoQotArky1Oe5Xsy6JwNAwW9LdalDYgzqr2BwqvyudcI0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
	b=qL/s2dajkd1Oyw5ENeo/mmH+TIOB6zwnbPDgLL/NbjYTYrJr1iDu5WNd8tWNNuxF/5yE
	 y95oxSwff58PK3sS3KzQrfUzkGBLHLsTusQXV4WLFfFLK6bmF+AtiNN3LIu57K+0CyeoL
	 mRcpO+XyzA98uP6R4aewYhoVntswAXj6ElGuUTuVxkcIxiNjqZ6LzZ6J5MIvkoI/+whbh
	 rESrGFYP0/OhW77rUqnN0UNXvxBe1d6hqgytJY0Udi6hpLJxMFEimNZisT8ekYaH0Jt+C
	 bDc/Eplb12J5fCcpo9gJcI18JdR9BI2GBAwS9ApzBa7BiRmfb4sgPKZZvNQ4bWMIEJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017139;
	bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s//R5obNvg5/j1Pzr0vbaYIXZ4GA8Kcj6mpfUEh39cTo7pAHTIdo+frB09Emi7V7m
	 fRNIGmGbVv7lB1EuQgKQkEfItFL0dO0jFG8Yg6lciJbOZk7fE32kyHWi3CkHqlIJe9
	 VsH2Ne7pdy5UElTFrdO/t5mQuvMBXCvdZbVcsVfOd6F742tZhgOyKVRGFe3u+BACfK
	 8LHdprc1Nhf9JJtrclnOU+RoTMOfsmB13is3zPmPsLwRdq+Fxc8xQPS6JTmwevBGmK
	 6TT8xxETyLJQ3lg0k7f7N4Hecu1e8Ujx7pQt5ICaqlnW7GMztUM+hyCywxOrDDvPL9
	 cNnJCeO1fBN0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 494AF80A91;
	Mon, 26 Oct 2026 12:18:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCC9143
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE85D40072
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTZUgmZnYntX for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E79A40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017136;
 b=DNOGEukY9eSh3YOOForywIGqgcvP0fB2RcYStotm768MSECiiQxQvrVjhcrXBK9gXhsN
 +c138ZPjGXXDGxloeleF7P/P7SSyTsdJEAgVMy9SNSJb1RFLwWD8saTFzXp5WuR1y7TSz
 vg2JlT8/MwM5HlaCfiXv+1KPJtdEny4GM45+ESZbrE+gDugkLz7H+rHXaphd+m6xEYnL3
 ctCtRcZKQLQQwM/+9zWmKA0x25xnE1Xz+RchTz02Bad23AIKhGHSG1wZGXpBN4dKN4jul
 QZt7peintSwmdBERUBydJ8TeUiruL5KULpE/bSDkfG64gGsnfWGW/Ypk/nfUsDvovZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017136;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=cvR4fm+VVHH/wz4BRFGnTPNAijAxeVIyJMYj3GGt+bzjpiJUEL6dGSXal9vDPY7GNalj
 2Z22uBKY29zgKM3HaM5ZOwfxqPZ/I+1YIhUJHP9OAfpoPCxVgufRHMzwp+7Cml+vf51Tt
 MuIoz8BzPamMtz7SdPxQu1e9jkmIfi3pxAIjVsig9Ud/rW/8u2t+9+zU312GDKpJjmLUU
 xmize7qQJtPeoTEmv1WQQnlPrA3q+0Pkg47pGbUaamGsTTOi6JoPyvZR87Fmu18MJc+Ms
 xkYZp/0w4K4/ZsIPlTYsCyRpmRkHG2aRWusB8SBeEkUZHmJFp5XYG/xdpB/5kmLN/qQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=d1CCFMfv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=d1CCFMfv
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E79A40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:54 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso4106416a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017133; x=1793621933;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=d1CCFMfvZKxoqIV5o5RD1ZwFfBZgQdTVfLQxDzf/MtI8/C9eb1BDWjfYU6lIDUaAIf
 vnC9gsbhhBwAw/oe2VH0f2VdyZhoyeyHT/bNJQ2VwhpVgid/Po/tqntnuDbyOybvG0ZL
 sR5igJ3F10GrvyVyfiA3nQ9HXB51E0xHcioC1UjWfelyeBv65YTLJdkpO/ktYQgAaHNK
 SrAKWzxiJcZ1UAcoEkQ0U3M7fFthpiJ8OecqoxeCO9Nf41oClPmvH8EUwhBrfNvK0VlG
 0eCbjL4BJ0tXToyYSErwa56qsUWDB7EdT8BqD7MhBB3bhR3LMNnhdvYKPRwb4yfyDCM3
 mXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017133; x=1793621933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=CH/fqDo8bYe96cM6YdD4vjft0Xj2S2nPD39ugcf4EUUpd4igrPtM5XsRSyawPmcDZr
 1cdf2YfcGoQ27j3Mu0cvFyvmAjPEMIsezAyZf0zOW+hEO/2YyR1SJYNPFImMb/GWVqv3
 Esx9xP+KJspHXUROfSCj7M/ma+HB4o/Be2sS2yPVkaPMeAiWkbadAiu3ut50dNPHU1Zf
 D1SbasxAd71oT0QqJgwLralPJwUevgkTBbKSz5KR20iIIqxCcmW8BgiHYQEuQqKimqrG
 F8k3XwouXIgAhqdNGIgwGG/wEm1XnlQSD2LX81eOmOLlqhtSTLL3BGmJDVV6xc8odFyg
 UkKw==
X-Gm-Message-State: AFq9FYIjC81kO6KRmRGfXIbUWQQMSBktjY/2HxkXuSLM50K4ioBSC9PG
 40+KLorMNl9yW2aEAPtTNJW9i+JEQhJqQmKxizmEY/TIvEFQUV5jqNWfyV5W2h3poBw=
X-Gm-Gg: AYBFou3SHvfEwWM6EvDvjxTc0hFsMesGYZsWXJRGlS/BPqgtmmVTyo/YBNZGdjIWmoj
 hzZFfmijVzSMe/ZpkRty2jvK7ftTcu60G9dCBJjZ2VIJGzLcgEv7eJCrdPf9cgVhQvWYXpur6N3
 tXBd8VYnxd4xXXg4iHqQHyyPriv6WMTTRuNiN8BdZ0VzPmh3PEjUWUvR47KoXpZF4b7aI9R9ZXN
 oulwRnAWfmsKAP6tLW8JOPTYXkw1ukwkm0WhCIk9qJlouIgHCYD5KKJeZ33+ls83OZYjc6cVGDB
 DNePdXjXOgiOpqKv4PlOx7dudTOZZYTCFQuFQvBCH68kRi8o/jNdWE+yO4LLEELse2yITyg5SaE
 tjgewOeF4QgHuKwqkVTzi5crvubO75BvV3K3nfsrmyeVcXumMRB/LsxiVZAfbsEOcRLJJLHp001
 xDL58iQGrzhgWDx0jdcR6K7a8K87SqOE9itK3m+NG1fqeQVOX/O6mYiKitrm5DFR7yxpoP3ej0k
 nFY6hACgZT5r7lv3U+YuhC7jhd6wQsE95RgZxPFYFosoq5A6FONAJoIscF3G/2jaCX6bKyjwqMT
 q4p0ZL9kWIETsAG3J3ziamoZtYaWtjiNuX3pG2TwkvcOlxPhdbrbFYaW92TZv/e7efUdYlcK
X-Received: by 2002:a05:6402:15c9:b0:6b1:e474:e0e2 with SMTP id
 4fb4d7f45d1cf-6b4430019d3mr5147079a12.43.1793017132752; 
 Mon, 26 Oct 2026 05:18:52 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:18:52 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 26 Oct 2026 13:18:20 +0100
Subject: [PATCH v3 1/5] boot: fit: tell callers when a devicetree buffer
 must be freed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-1-6c5d86c3007f@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIT devicetree loader can return either data inside the FIT or a
newly allocated buffer. Callers which only need a temporary result
cannot tell whether it is safe to free.

Report when the returned buffer must be freed. This lets the new
fdt fit command copy the result to its chosen address without leaking
memory or freeing part of the original FIT. Also release temporary
allocations when they are no longer needed, including on error.

Reviewed-by: Simon Glass <sjg@chromium.org>
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

