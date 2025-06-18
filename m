Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61ABC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79E282EA2;
	Wed, 18 Jun 2025 17:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LZfOXHMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7898E82E9F; Wed, 18 Jun 2025 17:00:09 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A00182CBB
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 17:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6fad79433bbso73894986d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258805; x=1750863605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY6XfOYlobG1yHS0Nl/CsSJUbyxmgb73FNJOs+DJ67E=;
 b=LZfOXHMifvvEBbUbyBunI4kS9LUZAbbYB8jb4jAK6xeBYZvx/Wxb1f3j3dCMSusGQy
 tPJZ6nnFuqLZJhkZUjkODqpXZl292D6YCpO1vPNUanVuorIhbpDG0LlS7x07TIW70MZm
 ToSY/OYLKTKvgjqhnojmzj8a8f5tnpVxkGHHfIzHrZdi7EWvK8qWzVpu1zMeqVTEGQq1
 73qJPEE9YvfrwvLfPGuXqFiVkWy2mhBRAHVRebUFDw8pEv0Nw4h8JVtJ+dSDck2FGM5c
 zNzkWZnJLHuDCgi8hhwEletBXIYeFhWLGow46R0obNk5c0j7Pb/2oR9e1WAJTVdWH3Kj
 8tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258805; x=1750863605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY6XfOYlobG1yHS0Nl/CsSJUbyxmgb73FNJOs+DJ67E=;
 b=vTsdP6eAIXw3HyYLUzJrfoGnamdEjBCsnOcUkrZ7ipyJL8wwLQbBrPP3ViTnzDgU6d
 qZg/sli02Bf9LwqC/4aZUyY+L0Quc1rcVkuPj5cUvJSS6kX7wqMwD6/R601C37I3PFb0
 LjtYhl7Kd1pO6I0214eP4cnu5nWXzh6gmO0+a6828erMPxQdeQKRn+mpI6Qg2pBSqhlK
 13ucxLczEf3to0jUbvMes50l/UKX4XpvsfZlNGrfAwA1jat6x9gGotDUJ50P+bQkMl/C
 ZRrPdskzKac2oqkk5ai5kEQHdYtQjZ9tzL7gZcu4kYiHwbno7UIvKBitB7vkOzkv5AfC
 I+Iw==
X-Gm-Message-State: AOJu0YwGtZr/KPBf5sNvee4VAYsE+evggylscX4ECXJrtrzfm+CuAo7q
 vmJpkl1XIsNcfK9LqjTeDwlVAaWLv/jNaH5qdFqjtFIDvYNWvI4ozIyifR7UsQLafEC2adhoaQ1
 kpCS5
X-Gm-Gg: ASbGncuUTiJW7S7BqBllRUPcMmaVJlQBqaBnxM2Yb4D6XiS2pSLnfyABY6JqAhE8IVn
 bs+qySW4a8zUJfR1JsHek25MV830/veKhPXOQ0R72eCu9S25IaqyyChAHm3MkzzBzU8t7/iEx5F
 uxw7ox/eT+2pyvU/8T9r9IYxNamVxcOqvS7F49SPLivHu134DNhz9d4qcS2EzqPfhaTyTjWmOmT
 tmApLozYmI3/u7XhQqCivIyM5enpjaW9XrVSICP/L+7ve3hRUcE61PUNwXO2YoauUWMtsCQgUgD
 egaqBBMbsDXVIshh994+nIYoSw2St7c2E965DN2T3f3iii3MuA5Ia6J9xtMaGaA4kbktf+e02Kk
 W91Iig9QTPsfuRSw/Dd/OmObI9ynii5Lkr/G27iFJVLelRUk=
X-Google-Smtp-Source: AGHT+IHa79Af+BiVzVWy9EcUtC3ZuL/0Mg5KA5hrEn4YBGLv+hX/Ii+uX90gCyDZpSMh49j4EZnyQw==
X-Received: by 2002:a05:6214:da9:b0:6fa:a724:8769 with SMTP id
 6a1803df08f44-6fb477a62c1mr282976646d6.35.1750258804659; 
 Wed, 18 Jun 2025 08:00:04 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.08.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 08:00:04 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
Date: Wed, 18 Jun 2025 07:59:28 -0700
Message-Id: <20250618145930.2652304-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

During FDT setup, apply all existing DT overlays from the bloblist
to the base FDT if bloblist is being used for handoff from previous
boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/fdtdec.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..3a218d8c94a 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1687,6 +1687,60 @@ void fdtdec_setup_embed(void)
 	gd->fdt_src = FDTSRC_EMBED;
 }
 
+static int fdtdec_apply_dto_from_blob(void **blob)
+{
+	int ret;
+	struct fdt_header *live_fdt;
+	size_t new_fdt_size, blob_size;
+	int expand_by;
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
+	    !CONFIG_IS_ENABLED(BLOBLIST))
+		return -EPERM;
+
+	live_fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	ret = fdt_check_header(live_fdt);
+	if (ret)
+		return ret;
+
+	ret = fdt_check_header(*blob);
+	if (ret)
+		return ret;
+
+	blob_size = fdt_totalsize(*blob);
+
+	/* Expand the FDT for spare spaces to apply the overlay */
+	new_fdt_size = fdt_totalsize(live_fdt) + blob_size + 0x400;
+	ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
+	if (ret)
+		return ret;
+
+	/* The blob is shifted if it was following the FDT */
+	if (*blob > (void *)live_fdt)
+		*blob += expand_by;
+
+	ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
+	if (ret)
+		return ret;
+
+	ret = fdt_overlay_apply_verbose(live_fdt, *blob);
+	if (ret)
+		return ret;
+
+	/* Shrink the excessive spaces */
+	fdt_pack(live_fdt);
+	new_fdt_size = fdt_totalsize(live_fdt);
+	ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
+	if (ret)
+		return ret;
+
+	/* The blob is shifted if it was following the FDT */
+	if (*blob > (void *)live_fdt)
+		*blob += expand_by;
+
+	return ret;
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1708,6 +1762,8 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
+						     fdtdec_apply_dto_from_blob);
 				goto setup_fdt;
 			} else {
 				log_debug("No FDT found in bloblist\n");
-- 
2.25.1

