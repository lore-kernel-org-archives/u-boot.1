Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D530CD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05782848D7;
	Wed, 17 Jun 2026 09:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K7DCDL5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783E2848D7; Wed, 17 Jun 2026 09:49:25 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3B7838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso44414045e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682563; x=1782287363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLCrQgINikFHlv53cw8h4SGgxjIPu//GFy6f4KbGqeE=;
 b=K7DCDL5ENUE6itpw8Aiut5EOTNSpmZCJXEahOe7aMXCFOI7m3D5kZ5IhgUzIE8xNBD
 bcLKFv2fXvdtwkg2TOanYTTfQXgK2tvLn5kf4zULgSBnOmvOhPhBo7/nbF332FZWMhVI
 G7/1wVu9GrE4E/lRedMomSQGzdvSE6DovHjIBK9OREy32ZftiAp09odMp6dQXI9yzTzg
 ZXdmepyhhOwfJxdcPh0uKuCXUoxK8kPTF/DnPt+iLftjsS9w3uRYDLau7rJNk3XiBRaI
 +OvcOIan48wjeVOompIaPpCId4t/NdNxswHy/cKZ2MUXKk8cUlReMksMrYHLBuNpT8jR
 bVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682563; x=1782287363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLCrQgINikFHlv53cw8h4SGgxjIPu//GFy6f4KbGqeE=;
 b=LSieXtgrT5dM44ehg78wL9IxY0btpWAJocnvqRV17tSAH/q2xI6pKjYQyTo73GALC3
 4BkgsILfk8SoPbj01Jdsfv/3soAY9NEAl1KjTPoUDTIXUY3Tmb89Yk9x0UE7KQvr9Xqc
 htCoWV1WaV4klaCfKW1qCW+k3jAn6ZfYRAaogK40MQtWQCqmN5J0Z4nA7dAkJHmYGcY+
 lkg6+j7swGstJzWNvjvgrwTjkFFtg8WUcTyhA/m3snZUYBx/Tv3DnZkW3IEVON8qlCpc
 u6Z55cXmLyRGGh4LvQOPBwuL+/XULK9tdiqfQDfCoUfosVRVX6W5nVy6d3cCZDUa3vom
 BVDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qJ4r2d2iFNiL2giZHB21kyg7cEEr6yjzNNLvAhP4Grmrnt/UIX30ZYdnNlnMZTkqd6eDdY+A=@lists.denx.de
X-Gm-Message-State: AOJu0Yze++A5mn77ftIYLQQUBMT4aKQNNlOPiqO7a+2Wxs5qaILTUA3j
 lRIXzVaPGbKTjnvrxwV/SL13YNx+eJDKPSQHXDjiHrqcVlZsMsMVAA04bEwoUmfRbWA=
X-Gm-Gg: Acq92OExTP11KYSre9ek/RzAO75Mf9+qpfMDay6uyYeFTdkJbNvnKMr7IBr03+aibFw
 2KhQNOYW1lw+XAbQFAQkkHydCjUFns1OJ1ASke18Vk80Efc9C4n7Htl2i5gfHgTq4vvOcfLmvpi
 ecSnAPVLHeIu0W0NRJmWChU4i+s/d/jqZQHJwaOu/ggQSVVrOH0ZTzNPBqZX91Y8CMS9trhov2U
 pl1f3iQVBAQwJqY/8ypG/xDBqaDmjfzKxXcSDvSr5wACjmV0TV2IVXYdfNJnEBn3I82rzmCZQt0
 qen9qlwVA+Kko29RkvKCST8c8Ml+iBT7XXHbbKF5PszfFqCLJMhcXbtNN4+vQgnoB6WMkGjTDZl
 q7yizhecjSI3mLW5S6MmqKT3IPjAOsSjuUw7dz0p+PCzOOKu90QWoei6tOIVH4HZ5kqKXQqf7sY
 y4nT5f7vbNDwIOsrkzBe8pwtCVZvJpWhGq+3X19qFhR4lgOBDWVfeiz8wPKlrbjpn2Yx3b1LmfD
 G6rd9L4kD2SH4BCAnPCAvtRQbpHQqxzjPwV9ieDWusc4XsVNPKNlQ7q0nYyCVPq6FIThc5Hqcc8
 PMEmJFs0v0dtLTR9lahvUPMnBYxVfvsNUjFDy+m32xnQwzehMpOBsR7+7VJ6nv6b6hkkLo5nOlr
 fjqKk668I4L6Od38zrW4qlJmMOSgN+YhBCyEBwshexIzg9tebHZS0lbmQM2f3vusqZeI757bn/K
 FsUBu46RpXSF9MzWO7frK8kyB0+XyOswq2jzHjdRdigIqZDELsLQkPFjNhDV1AD2peyo9c0Yh1I
 zNke6i0+vrhxWBDMbyfdpd5T2CT
X-Received: by 2002:a05:600c:818f:b0:490:b28d:a6f9 with SMTP id
 5b1f17b1804b1-492333ba217mr50788995e9.8.1781682562994; 
 Wed, 17 Jun 2026 00:49:22 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v7 2/7] common: move ram_base calculation to independent
 INITCALL()
Date: Wed, 17 Jun 2026 10:48:20 +0300
Message-ID: <20260617074846.84362-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Currently, ram_base is calculated within setup_dest_addr().
However, upcoming patches that enable U-Boot relocation to the highest
DRAM bank require ram_base to be initialized earlier.

The default dram_init_banksize() definition relies on ram_base
to calculate the start of the first bank. But following patches
will move that function to execute immediately before setup_dest_addr().

So let's split the ram_base initialization in its own INITCALL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index a3abec352716..e169ed930911 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,14 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }
 
+static int setup_ram_base(void)
+{
+#ifdef CFG_SYS_SDRAM_BASE
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+#endif
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	int ret;
@@ -349,9 +357,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -977,6 +982,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.43.0

