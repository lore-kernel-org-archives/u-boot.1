Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C4606A32E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aryU1gJ6;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bzxniZN2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D782740666;
	Mon, 26 Oct 2026 12:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqUNdNpbIGQa; Mon, 26 Oct 2026 12:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8C8540580
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017141;
	b=RyYWYBmNsHc+1FTTHx55EEEpbgGkgDtnDoGb2ymgC7MmDqcopUA1CBKfI2ZQKP0frdrP
	 5TjF+WQAAZl/hOyZ0A2W49/Pa5du2CqKOsCGYoZRcxrowod4o3yGyXQdjFzHrQo3zWCpo
	 7R9jlsVw35Tt1W4VoajPcKb12Ufi1hikoW5dGJskDIjwADE+hKI8JtX48UEKUj9WSueN1
	 3vX0A3R3DiUg7NjgO2LR3EdHVcqc2nLLeWSp0nNEe4v1Vn9OD/Z+s/10Ze6k9TJZFGLxv
	 ubxhTHXceQmXpcf0hvVHaeD6e9YFV+59WQTEmrod9ZQ5tcrpbE/hAW+eq77UwFYIeJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=E8vrkaHMuVfp7AtQKUXrpTOpsnUpPAULVgTzWQifi8I=;
	b=d1fYmP28SH7DDRzLCKWbUfmz1LRI/q34PnwcrL0/WRSQdWmblK8mVCBs18niXt56vG+h
	 2fDeXszTNOFLgZoam7ReibZjxJAWUYCqk6LCAdLd4sQGnGUAgbhwVvgD0KS5Rh1iFVU9j
	 u/PG5+pFD3xc39hiylxLi3SCz8cIYQcULv0wiXAo0kabuZTjRfdAttZF5hHmDqvyc+nDQ
	 IMWhh4bu0iccFqxwmr+iYM6bZMLkFPm9oCwTWiS7IUp1JBaPhINij0dwvvkifXhJ4juXf
	 spogss2yMYEXkAa43lrmJYTKcw9ebAUS/LgtZ5xakt5yQA6JE25SporaL5s3xrQ27tg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017141;
	bh=E8vrkaHMuVfp7AtQKUXrpTOpsnUpPAULVgTzWQifi8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aryU1gJ6Z7QDfqrHac4pAgFInKSC3fMQsqthvTVqV57ZSePNzCqKbfg5yUKbUEdtt
	 wQU/5Fmg//WMYzH3wdbnmhZHwVJH5rL/F7wyWJRoSWzrn3ZjT/WA5/lwVsHqNc7EHc
	 oy6jAbBWCzrjE50KbM8Yy+pW1WMAMtuHhkNoWUYsSIxlmUVWRu2WU8QTBnm58PHIZm
	 HJqkMbd0DG3mgwx5m5TERvDnCaD24BdOIl5FzfbKPGDQh9atD5ZW1Aa4LbNt9BPa39
	 OAbddktH6314m29t8SV5gVDmombFXdpclVOphGm0bRkzS3ml2ONRWfzwh0MrBZYzIH
	 jwd22Qfwx415w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8C8540580;
	Mon, 26 Oct 2026 12:19:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60734356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4647E60604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIYgr1Z0v5tS for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31A85605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017137;
 b=LoUHub6tEvlgXzJcx9Vv3x8k2JV3H+fgyiVRPJnP+gQD8kO2c8r79/25NIuuv6nqr0zn
 Zke7jtIgFNpCIXA1ebODxMJaxkEn15jlvagS/J6fUmicn7N9f5uFkFgIoS0HkyLuGPYzH
 EXmCK54cidlUo+Jc0uBHciSqCACtkiU/hDvU0C6GTn/I8b1lkmo3wbbJDFtEOmnthhAfC
 ijIFJcorGr9tOSIQr/bjhfmfa7LYIgM7WEaZVfAXIQWn/35ld15SQ17ync0vIdozjuykq
 C5l53fXLnHFx9TpYAcfnubONUVFbHeN3Sppufj4sXtzBLN2mm3Rr1VuQhAoETH8Fllg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017137;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=E8vrkaHMuVfp7AtQKUXrpTOpsnUpPAULVgTzWQifi8I=;
 b=cd5Jyu4JvGXwcfY+g1YvjoqGnurunxeR+AdZWQMx/b5sF4Rl15/1mApfljhQyTzDPaUL
 ZXPXNNkRzKfCoH1a6gF9lwM+tq7ZnAuuaY+TYO6zEswNizHjlBvY/bafz+G6SgV9afNsQ
 IwaED5nG+cQ1Oe7j7h9ecPbnEikJD41XOoZtenpPJwKE4RgFZnJxt9kumA40luLHwV/JX
 xauQwLAfegYWerR3C8El7cqzBcunLkPFrJDOZLhTdXVPlpCk1m4JbYY12IDlzRbhjGhcl
 510D2lDp/gnP4q25HJDXB6lteY9av8Gty8crI9+rC8x1NQ7dYMvoa5FiSsUBHjm9KoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bzxniZN2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bzxniZN2
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31A85605D2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:56 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso4447992a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017135; x=1793621935;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8vrkaHMuVfp7AtQKUXrpTOpsnUpPAULVgTzWQifi8I=;
 b=bzxniZN23IxxKkJz1sginGP40wKLVgnN9NvyJzazXqmjcQHbxhWNvXRF5EPR8ac8mH
 IeX6VxK4LC7ZY8c1CkgBmLhMAjiLgjYfZcYAn5UL1HmajxlrJegQIo2s8ZHOGhoHA43b
 unyHhvg32LQlzTnJ0BwMaNkXbohSFOwTiwtb+5IFZREIEw5Zm0fj5tKCfoCjxfdHGNcC
 vo5AfYLDdRz6RVl2Gtf0xun9kYuviQW5uO3bV759+eNiHoC/cpW3Z0i90SMs4Y8AI06p
 FkkHk9/dA/6GrUIP2PLTwD0XFV7d8UBYxp15P8YrIhHVoxAE96T/fUWrGil0Pndw7vIE
 HsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017135; x=1793621935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E8vrkaHMuVfp7AtQKUXrpTOpsnUpPAULVgTzWQifi8I=;
 b=yQA4VdUx3Y0PU03J6LfG+zmX+0mfzBGZduBnTHTHNkikxaOJj5iFofIb9OymR668tL
 vTsn2OE6R8LWy1BK3LVjJro2ShfsFSkhbl7kFapN3n60k2T79qWUthnk3REoarZOLn0O
 jV7qgmsJoodfjtfNq5oxI8WvcH/bNzG0Vv3qok9vItpemrnZ/lcQmgL3JqsE9hZsCnXV
 kGRGXAGAenRM8bXle53vf2ZZZQDKRMm57+3ayFR7NFqIwXMJslf984VQc0+t2Qn0gAhy
 7Ygr78CgK/LPlCwJMJCaAK0ylHk/nyTj5GoQ0sI0Arer4T4TbAjsif1myp6pEMXQ2mro
 dj0w==
X-Gm-Message-State: AFq9FYJxcpJKvHBLHjamrA+FHZWNZQY3LAKtBVfgHxPaMzpW6dEznYfj
 NR2W7YvozK0o4wzkLp+27NA6XkMqH+8YYOsL56zAzsbsfFTIiD4JRK6cxf6g2ua4AUE=
X-Gm-Gg: AYBFou3m8Y9vc1VOG6S0Jq70yQShOHuU86STTb1qgVu3BoRU3SyvHuEvZtkRkg38dZz
 5X8yGcGEjYwx0lA1ztcsdiegTsqWq3sJpfrl0BnjEOeYkHc5Cu65nt7Yfimw5tckAwBzsNosufe
 GH9sdzwaU78f/LaaRPUUlUi5ktYe9j7R0PuZBSXASNVmbZvQSy5i3KUIpyyOvFMOGyfhlS9IvNb
 5UVtdYwaacpwciNx0QI/pnlrvHbBf89ay4RfsseYjsR0FCig81FHDd4mBgQwgrRULIwOzwvRTsy
 CAc1w4JOn7lCAOGlBDsrCFvjXDVjTnkuA9AQm+KlWPy/VyYgZu6wY187JIgpyIO0Ca5olOp8G1x
 PNq4hK/DHvDGvGs5eU5dujoFtMQeWGH4+LOHSuwsGXxjkwqg0AhG6XulW1RYInLJk4rg17UzK7g
 0p1/BuGIwMKvsXtAGUZNaEtcRCvvDhuIaNZhhd9ttvhoqmYsbO1Mp6mBeQurXmRx8xl3EN2qLKM
 7tBVve74EWJr1EN1M85V4Kv3sC5zxu61yGtHvI1+CfYts2NLh+fkljiwf/nGngDDYN9xrNc5k/E
 9FIdwuZfsW7RpyTLD8xyeoR/1OhSzgiTA1J8RRdORG7omNgs6Q/zjINTetJH/JUHNq0ZsGos
X-Received: by 2002:a05:6402:11cb:b0:6aa:f0e:a168 with SMTP id
 4fb4d7f45d1cf-6b442ffda20mr7642263a12.21.1793017134268; 
 Mon, 26 Oct 2026 05:18:54 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:18:53 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 26 Oct 2026 13:18:21 +0100
Subject: [PATCH v3 2/5] boot: fit: reject configurations with missing or
 invalid overlays
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-2-6c5d86c3007f@baylibre.com>
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

An overlay listed in a FIT configuration is part of the requested
devicetree, not an optional addition. Currently, a failed load or hash
check can be ignored and boot continues with that overlay missing.
For signed configurations, this also means using a combination that
was not signed.

Reject the devicetree if any listed overlay cannot be loaded or
verified. A missing image must be treated as an error too, rather
than falling back to the default configuration's base devicetree.

This also affects bootm, even when fdt fit is disabled. Boards which
previously booted despite a broken overlay will now stop at the error.

Add a bootm regression test covering a valid overlay, a corrupted
overlay hash and a missing overlay image.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c          | 12 +++++-----
 test/py/tests/test_fit.py | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

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
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 0edf875a9e1..3113209d911 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -397,6 +397,66 @@ class TestFitImage:
         self.check_not_equal(params, 'ramdisk', 'ramdisk_out',
                              'Ramdisk loaded but should not be')
 
+    @pytest.mark.buildconfigspec('cmd_bootm')
+    @pytest.mark.buildconfigspec('cmd_fdt')
+    @pytest.mark.buildconfigspec('of_libfdt_overlay')
+    @pytest.mark.requiredtool('fdtput')
+    @pytest.mark.parametrize('overlay_state', ['valid', 'bad-hash', 'missing'])
+    def test_fit_overlay_load(self, ubman, fsetup, overlay_state):
+        """bootm must not skip a listed overlay that fails to load or verify"""
+        overlay_dts = '''
+/dts-v1/;
+/plugin/;
+
+&{/} {
+        test-overlay = "applied";
+};
+'''
+        overlay_image = '''
+                overlay-1 {
+                        data = /incbin/("%(overlay)s");
+                        type = "flat_dt";
+                        arch = "sandbox";
+                        compression = "none";
+                        hash-1 {
+                                algo = "sha256";
+                        };
+                };
+'''
+        params = dict(fsetup, overlay=fit_util.make_dtb(
+            ubman, overlay_dts, 'bootm-overlay'))
+        its = BASE_ITS.replace('        images {',
+                               '        images {' + overlay_image)
+        its = its.replace('fdt = "fdt-1";', 'fdt = "fdt-1", "overlay-1";')
+        fit = fit_util.make_fit(ubman, params['mkimage'], its, params,
+                                basename=f'bootm-overlay-{overlay_state}.fit')
+        if overlay_state == 'bad-hash':
+            utils.run_and_log(ubman, [
+                'fdtput', '-t', 'x', fit, '/images/overlay-1/hash-1',
+                'value', *(['0'] * 8)])
+        elif overlay_state == 'missing':
+            utils.run_and_log(ubman, ['fdtput', '-r', fit, '/images/overlay-1'])
+
+        try:
+            ubman.run_command('setenv verify yes')
+            output = ubman.run_command(
+                f'host load hostfs 0 {params["fit_addr"]:x} {fit}')
+            assert 'bytes read' in output
+            output = ubman.run_command(
+                f'bootm start {params["fit_addr"]:x}#conf-1; echo rc=$?')
+            if overlay_state == 'valid':
+                assert output.rstrip().endswith('rc=0'), output
+                assert 'test-overlay = "applied"' in ubman.run_command(
+                    'fdt print / test-overlay')
+            else:
+                assert output.rstrip().endswith('rc=1'), output
+                assert 'load of overlay-1 failed' in output
+                assert 'Booting using the fdt blob' not in output
+                if overlay_state == 'bad-hash':
+                    assert 'Bad hash value' in output
+        finally:
+            ubman.restart_uboot()
+
     def test_fit_kernel_fdt_ramdisk_load(self, ubman, fsetup):
         """Test loading a FIT image with kernel, FDT, and ramdisk"""
         cmds, params, _ = self.prepare(

-- 
2.56.0

