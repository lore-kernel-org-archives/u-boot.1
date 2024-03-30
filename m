Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821F6C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 00:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D19B8825E;
	Sat, 30 Mar 2024 01:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BaFAXfwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5798825E; Sat, 30 Mar 2024 01:55:57 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B582881C3
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 01:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2297d0d6013so1476232fac.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711760154; x=1712364954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8cTb0qgxRZXJmhvq1zNW7PHq30MfDxlNlGol2F0Xrc=;
 b=BaFAXfwugmSyrv3rxOYB4B0BKnICO2khurOKfYNKDpQHMxVMHS0XUGogRnJdoK4C4T
 gTf35uNuEvVL3ktXqfVvqLnr4nx+pFfnrBvsAatzpeuoXTPnfT2zkwiVbjziM9r8y/qP
 zZBg6FrAsqDHjEgDQ6kTuUW6k63Hf9D4hB9681khK9koLYm5sCmYj5BPJzOwoqK3jsFb
 +I0ZN1oORK9BZqKDcOE+0MVmLB+Tu1BrUwBSdjDyOLHwEpdwsqJl5DIB161WJKvG8xVv
 ObbsZpaJKvTDbZ1Xj2C4PLXsf2wckhw1z5ciXL3ce63DBhOdXRt1YyLat4ivLaHq5Jmu
 ovMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711760154; x=1712364954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8cTb0qgxRZXJmhvq1zNW7PHq30MfDxlNlGol2F0Xrc=;
 b=MEcJ5HNVev3onpoxPiZtpeEHPCYJoSEGS0Rs198iQOWaPduCSOBuozVkP5Tb+sQ6gg
 wjSS1FSMfyK9VU62pmXe723Q7epXFLrbWXHvNl0uAEtgfJ4ug8H/YNwfVlnPtGN8AXM/
 rglfT2ZOeImau2xYsa46LPaW+sW0q6S0rrJNBpGo12vqr0sNFs3HbQ/aKRnmlq+WKThC
 7C4WkpsJ1gZ1HwUYMJEEmAuVgALSd6PwHUauRbO6UugzHriRNxd/92keFHLQRmHRPIEZ
 zj1i6f+KuV7xt74pL109zEdUptMB0eN9qsvdfvpfNvBXMKogJoKYMkwVYkigAaLfkjMq
 pZ4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh6uIdMdI8SJ7ROlrnIpGMaGtWQGguf2BHKzGMxLJSIQKvxCdMdroPFTXoA1NXDF+BjZzpSSVoG/uFRnZy9PPw/vuYYw==
X-Gm-Message-State: AOJu0YzrGMo3ADsrarLktrJOI1yvxdpgDQTsAoW1BFMObFyTAnrxpjs0
 79weOjcRhK4jXi7yi5XgWiEjV6BLgYvuZwe17vC4Fw7n2KA3RauRaDrsUkgISNA=
X-Google-Smtp-Source: AGHT+IHWuSjpXy5iNKA9hc7iiP7zPLnc3U3mF0qdwJIeK5fI72ew3612R8XqXQ8I/ZM+nr2EIW2MMw==
X-Received: by 2002:a05:6870:2427:b0:22a:4345:5731 with SMTP id
 n39-20020a056870242700b0022a43455731mr3732755oap.29.1711760153961; 
 Fri, 29 Mar 2024 17:55:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 py21-20020a056871e41500b0022aa4f1b1casm1250158oac.39.2024.03.29.17.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 17:55:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: David Virag <virag.david003@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH] fdt: Fix fdt_pack_reg() on 64-bit platforms
Date: Fri, 29 Mar 2024 19:55:53 -0500
Message-Id: <20240330005553.30869-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

When "memory" node is being processed in fdt_pack_reg() on ARM64
platforms, an unaligned bus access might happen, which leads to
"synchronous abort" CPU exception. Consider next dts example:

    / {
        #address-cells = <2>;
        #size-cells = <1>;

        memory@80000000 {
            device_type = "memory";
            reg = <0x0 0x80000000 0x3ab00000>,
                  <0x0 0xc0000000 0x40000000>,
                  <0x8 0x80000000 0x80000000>;
        };
    };

After fdt_pack_reg() reads the first addr/size entry from such memory
node, the "p" pointer becomes 12 bytes shifted from its original value
(8 bytes for two address cells + 4 bytes for one size cell). So now it's
not 64-bit aligned, and an attempt to do 64-bit bus access to that
address will cause an abort like this:

    "Synchronous Abort" handler, esr 0x96000021, far 0xba235efc

This issue was originally reported by David Virag [1] who observed it
happening on Samsung Exynos7885 SoC (ARM64), and later the same issue
was observed on Samsung Exynos850 (ARM64).

Fix the issue by using put_unaligned_be64() helper, which takes care of
possible unaligned 64-bit accesses. That solution was proposed by Simon
Glass in the original thread [1].

[1] https://lists.denx.de/pipermail/u-boot/2023-July/522074.html

Fixes: 739a01ed8e02 ("fdt_support: fix an endian bug of fdt_fixup_memory_banks")
Suggested-by: Simon Glass <sjg@google.com>
Reported-by: David Virag <virag.david003@gmail.com>
Closes: https://lists.denx.de/pipermail/u-boot/2023-July/522074.html
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/fdt_support.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 090d82ee80a5..9844c70be806 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -17,6 +17,7 @@
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <asm/global_data.h>
+#include <asm/unaligned.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 #include <exports.h>
@@ -421,13 +422,13 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
 
 	for (i = 0; i < n; i++) {
 		if (address_cells == 2)
-			*(fdt64_t *)p = cpu_to_fdt64(address[i]);
+			put_unaligned_be64(address[i], p);
 		else
 			*(fdt32_t *)p = cpu_to_fdt32(address[i]);
 		p += 4 * address_cells;
 
 		if (size_cells == 2)
-			*(fdt64_t *)p = cpu_to_fdt64(size[i]);
+			put_unaligned_be64(size[i], p);
 		else
 			*(fdt32_t *)p = cpu_to_fdt32(size[i]);
 		p += 4 * size_cells;
-- 
2.39.2

