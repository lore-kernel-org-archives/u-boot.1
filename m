Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE98109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B71683FAF;
	Wed, 25 Mar 2026 17:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HoHFEnRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E7783FA7; Wed, 25 Mar 2026 17:55:41 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2968D83DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4670676ba03so3896b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457736; x=1775062536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yWK6QnTYyx0w4CUHe2N6NQim35RSGM+xbaUhc0YDpw=;
 b=HoHFEnRUOfJPtswzwxQOnzqJYiEMNCiO619WC7Gr4p+AK6mzSoZknPrzHuE19z4CR/
 Q1gywAngCvmP+yDGJy/gssxoPh92ns/wJ/5uifK+vQIRxgvZwbTU+P9XEnsAzVfAe+Yc
 wKPMKvbtaltIFsh9zvOTBcNXQ9pyRxA/4XHJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457736; x=1775062536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3yWK6QnTYyx0w4CUHe2N6NQim35RSGM+xbaUhc0YDpw=;
 b=JNBVm48PCTYnuUeIVYidTeMaW2WDSW5SWJA9Ks9FeVpsjPXahQiFKzGQTduB1QbRO+
 w/3cLgkoS0tx2/eldP0DpdYnNMaCPjyTumKrPO2D1LYfXPMcsLJRQ0CTDCYysdBGUTRk
 EqZYpA48UQ1nJyTxGEZOgeKS6GsA93zRJz5ilyC8UOAuJQghIghGeQ9DQjDa+G7QkpTj
 j93Y5Ni6J55GhwNPZxjhex2v73hfHhdiz7t++DMCdK3nf19EDoAlc49o26vfbcSZOJS7
 fmqJNrMKPPxayzrSCfgf+3W0xpJmn9ElSA8ER6wDIZr+15+Gj7MyvbfVoFE3vuC2K8XF
 ZhFw==
X-Gm-Message-State: AOJu0YzgBwTnRD0/jwEbN7faXyvKtjGWnPyGIMyguIeZIwLVezdruZ6B
 hH+PO4tn1ZuCaM0jXrbf8wTMBfkoOx8sLuQG43Vj9dPsZO+bjgF+NkC1aClbmugowenNWzfAz2k
 6KVoZuw==
X-Gm-Gg: ATEYQzzUnvu5S5sUX1Q2MpnckSkalGrRkJHV/s8gZ1hQqKC8zz8LE26VKA3P9U3QYhi
 BQE0udH/Log5LUqcZbIGB2lVvbuMWe0famPMbe8DJtysI3j5QfaGsskYUAZHsLo8GG6pKTyEDEy
 kwXiTT7GpFMAPvOBGMYNHJ6ighDxovnEhgIB2Ea+OnovgVw7373ol50Wqm91Snw5IiEZNMNjBZZ
 S5dq9KmCbnXbIf+hwkH05m5bCsgUzYiySje1+S/whBp+YUQ/1TZhnniFecsEqrVfPTIxyga/AYA
 7z/Hmz5S1eoVtx7K2JFLRtI7KhMEmRilF8YIhvK6akgkhsfSXA4nOM//S+l9GHnGcYvWOfx9SWE
 8HYtbt5YUmeZESW5kowHKaV+lQ42F+UPZlHEO4eB1eem+bvAFnrWaBWpMFcVEWDpxVH8QBxQkXn
 0NHhb1FDzCpRd5PzT2SQ==
X-Received: by 2002:a05:6808:5245:b0:466:f57b:2aca with SMTP id
 5614622812f47-46a5c78457amr1934271b6e.50.1774457735995; 
 Wed, 25 Mar 2026 09:55:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 03/13] boot: Tidy up setting of the OS arch on host builds
Date: Wed, 25 Mar 2026 10:54:12 -0600
Message-ID: <20260325165431.1027591-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This field is not present in host builds. Create an inline function to
handle this complexity, so we can drop the #ifdef in the C file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 10 ++--------
 include/image.h  |  7 +++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index f8772f64cb3..5680cc8b496 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2193,7 +2193,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	size_t size;
 	int type_ok, os_ok;
 	ulong load, load_end, data, len;
-	uint8_t os, comp;
+	uint8_t os, comp, os_arch;
 	const char *prop_name;
 
 	fit = map_sysmem(addr, 0);
@@ -2218,14 +2218,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 	}
 
-#ifndef USE_HOSTCC
-	{
-	uint8_t os_arch;
-
 	fit_image_get_arch(fit, noffset, &os_arch);
-	images->os.arch = os_arch;
-	}
-#endif
+	images_set_arch(images, os_arch);
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
 	type_ok = fit_image_check_type(fit, noffset, image_type) ||
diff --git a/include/image.h b/include/image.h
index 34efac6056d..5e11dc92559 100644
--- a/include/image.h
+++ b/include/image.h
@@ -418,6 +418,13 @@ struct bootm_headers {
 
 extern struct bootm_headers images;
 
+static inline void images_set_arch(struct bootm_headers *images, int os_arch)
+{
+#ifndef USE_HOSTCC
+	images->os.arch = os_arch;
+#endif
+}
+
 /*
  * Some systems (for example LWMON) have very short watchdog periods;
  * we must make sure to split long operations like memmove() or
-- 
2.43.0

