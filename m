Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E6FFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAD083693;
	Mon, 27 Apr 2026 12:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRHnjF3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7342684178; Mon, 27 Apr 2026 12:08:52 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B20A80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38ccde812ecso98278371fa.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284529; x=1777889329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOVOfOQIbVfM7hlfoBdXKZYK6qEJROqtwbm2aVGMDs0=;
 b=mRHnjF3u/NDbsdj06IB5JbLXLlJ3VbJ5WEUxEmSYTaJf56/rzC2h5RHSbx4zj6t4ER
 Gx8LJ+C1wxMZ4F6UNnBU7gfHxe8gT1QRut9CHboE/k64Eg2vfPGaNhOPwwXK7jfkvz3T
 IICHIqenn5isX+w/ydB40PPk83fedawM2+1zTZMF/KxmbJOeSKJvaWQ374a1hDvaAs/q
 ZhNUAbp4KgBCVc1k/17M42qPeNQNebXLXVGlSh1e+Nk4o/qJQRPKKI5FxmcZyW5SxPRG
 Mv2zW0xAefrzUWDScOvL1iS+eHitpw0V5TbR42HtCLiIw1+0OHdFfuevW1TfNnUcJ/6/
 rULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284529; x=1777889329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOVOfOQIbVfM7hlfoBdXKZYK6qEJROqtwbm2aVGMDs0=;
 b=pe9kxCYTckS5F3O4gEJJBaQ9CjTf3MKy9KKgq/f3+qtM6V9mpn9ApKjFFW66BUYIAo
 YLp9ZSD4m8RTSu3HeCU4tPukSIwJC7vtdQAFC3W3u88kcVlZI5A86iqpY748gyWKTvK3
 ZXB8OkgwuvtNHUDcArqxT0fa+hZpiJK1AxMh0KtitlVwccHBd7AVARUYKCEazm/T/HnI
 d3coAZV9qFlOm9yG4aD7LGfBF4f4o7E2jy2tIaiLvjs5V8N8GtlEUajOPGu5Cl15wq9L
 cbmcS6Lq9SmYvo7s9q2ymUNjYObkVNOumKCz+0ho13NKVlIxFQuxuCerJE0eCrqwgEqy
 BuPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MsPzfg+HE33+ynBNEYIxQnWLIIoX0afE+ElurckK3I8exElifGX5YZNCiPTsFsYG/fSqOuN4=@lists.denx.de
X-Gm-Message-State: AOJu0YzlV/LlaEH28jUVTSrEdiSYOKfqRO5M93GsAmXlS6+XuUW7sfmi
 iqc8LmJZfKo2xny1Aktx73i93Bbaeqed9038hMci6YCjeRSyWXvvDigEyEH2FlffwqE=
X-Gm-Gg: AeBDies6Dauo22+fpFS+86xP3gx76YfZBQDLy7u/27AL1XpLnPUvOZk4ZZ2OCpdJwMA
 AqcJHaMrohCz4FAbpvPWcS7Qskp6uuF23jJl4idgF6LIAUFpfEZdaoFV+G3eYBlYDYpRL+/UE6e
 rpmHwZdCyLC+Uav4XzSW9olybTUZGQshyfO33yk134maP2Zqzt7esxo+n2U6NK0wW5B6mtnFzyN
 /SCe7CvRkRZSoxfCp9GF/t+RQUZYQhEiHyPGZ0YC9qQcZMRo+oafAHRSjC/kdVSbUQbCcXD8CTA
 nAEi+fFQUfHSLLeY6dlYs//bdsnQEpO8/3fhSSXDzvXXwMVm6c6vmAuAzyZLNo8W+Q2hDEd7BoJ
 GWGVZgL7cY7tN3PUgoqY0r6aM0Fpq+MgTrl1OZ89Qkydu2Q6c4fhxYCKjqHGglliPChwKTg0E55
 U80B5IsRMQiCbRU6Ls288xD8kqwmBcNb1ZO4eE/NXYi5zv9goEi8QGO+QieChfvHuW3/Xj/yI9s
 +ZMFjNP7JqBtbdUZsYhKac62cIGplF85prG1lppUX5uawZ310E+KCHm7rnqHcxvZxmPX42VQXi2
 b4SHTo/37ob19aQNCRGibPxp3EbxCc27ZW0LPu5mY422vsJ9Rw+qloHbNnnWZktIITMFIBRfNjB
 lYZdS0if+FiZOXQBFXWMvEkcwomc9ySijVEoiCWaN9vWxIvhsmXC6HfNXJAnm/GSoh2yjOPc0vm
 IoMxJpNHF+za8JzjE0djogfQvs9d/RkuYv3Xt1ik6jhe0A7bpYJkVlpjxfCzJ9l1YnLpLjczNVX
 mPAkFL+++wbMsOmndy24JuJdOGzenTGHtVcb7052hLo/YQ=
X-Received: by 2002:a2e:a58d:0:b0:38b:f0f0:e39b with SMTP id
 38308e7fff4ca-38ec94f600cmr142691981fa.10.1777284529192; 
 Mon, 27 Apr 2026 03:08:49 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:48 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/6] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
Date: Mon, 27 Apr 2026 13:08:23 +0300
Message-ID: <20260427100832.581887-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
address in the last DRAM bank, to be assigned into gd->ram_top in order to
relocate U-Boot to the actual end of all DRAM. This makes use of iterator
function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/fdtdec.h | 16 ++++++++++++++++
 lib/fdtdec.c     | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index 46eaa0da63c6..c43e78de4147 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -973,6 +973,22 @@ int fdtdec_setup_mem_size_base(void);
  */
 int fdtdec_setup_mem_size_base_lowest(void);
 
+/**
+ * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
+ * available in any memory bank
+ *
+ * Decode the /memory 'reg' property to determine the highest end of the memory
+ * bank and populate the global data ram_top with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for topmost
+ * DRAM address.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_mem_ram_top(void);
+
 /**
  * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 01be5edf7484..288966936606 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1184,6 +1184,24 @@ int fdtdec_setup_mem_size_base_lowest(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
+static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
+{
+	if ((res->end + 1) > gd->ram_top)
+		gd->ram_top = res->end + 1;
+}
+
+int fdtdec_setup_mem_ram_top(void)
+{
+	phys_addr_t old_top = gd->ram_top;
+	int ret;
+
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
+	if (ret)
+		gd->ram_top = old_top;
+
+	return ret;
+}
+
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 {
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
-- 
2.53.0

