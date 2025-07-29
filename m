Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BEFC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F9D82BCD;
	Tue, 29 Jul 2025 17:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hsvdA5zs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068B881E14; Tue, 29 Jul 2025 17:50:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8EC82EB8
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso59614045e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804215; x=1754409015; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=hsvdA5zsQ8jB7bOpO2XZCvfkjSq1Gli/6RL+UtUOTM4qMzSVhR+Rh58OgECtsD6GkX
 fmfkD4FsnqAzCubtMIOOEW2wW0lgvYfyys98D4574c5lWE1xcFAq0F5RXwg4QdiagrPM
 weKD5nXg42Ct+OQ5G8LIQ160j8lXgOGZ5dqgMRyZ0L3mt2Gvn8oa3paNAbdvT/52GBUK
 8fUr/80yGJjme2tWmDfpSC3rv/ho02FIMNQcVN4Kp+bn1cGTfxhN/ZgjjN6Op/xub4FY
 enQxCxrQLRaSTm0n6bbgj1lYtOaFFl1saRIAHyADWU2ZxCwS3mFFylKmIxPITTK8HvUo
 oQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804215; x=1754409015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=PQS/9W6JPJ+YYQZrjkyFXuS0T3xyBvFtnkyipo0Bj+BLXR26bN37t8GLY3m6xnuPyE
 PehHh7VUvjXVB8YKxeevrCkjRkq1HPU2MDsvn/HldlxfEKpMY9jxLY538+rUoNoE0Ejo
 N7KZnL0JfEP8ROVizpPtsqwsCTaVblmDy1+/szNn68ToAvZFHL9voGfcizBDPH8qJJO4
 nLemxUa1T0C3u7QfT9okYP7oSXaMhS1loL5tbJDhaZpTi6lQ5ZaGeNKf/ZPC2E893UO0
 iCkknhMsITP0zyenWhW3PykZOUpuh5DKIV6U407b72hYzhzYHFctRJq3bAawm4E1rYb4
 vDXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ZCif+FC1d/ytA5zE134ryXwWX3oR0rFY4S61xkAQzJjX4BEuOZLWc7ZTArGh7UgZssayesQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6JyZZ9jKZ0BzLMrOKDqzGmFz+r36D2LAT/tIcWwVEePHdEYfw
 lH+Ltgt7njh0JJ9LngUU69vY4yd7Sho68/5foeZXIXRLwlY2ZTx3mTOtCBKMmiQRbMA=
X-Gm-Gg: ASbGnctshpnfnasc/vx5LgrEGiYd+imUJZyzsQcOGHRkFwkk7wUUv4ofvJrhxjFzYWP
 NZGD7naDW87G9ljyCcjyaYzzY7EjVKnXz9V0Y1xwmwB4QC2sRo7pqxJOHQkJK3tVrBdIoLxv8pj
 eaRkXcfR5cyAm7T8K8oH8ZfVuIDMIdxHr0JuqHMD4nGJbw1tJvsRKNPQBMq4d/ViuZdeaze6PmC
 HTB/EOZqnjVZKoXGMA99gPI3C9lejWLqpD3QE+532w/5MEJ4+wqKuIxqrli7XQNXlxJQ/pdAkjv
 ifOP87JIzVxpoxhl7cr171GC9x9p5ijptcKKrO31niBnSpSQFXGMMv8kInnWzwOnCZq+gQQHf0v
 gfJJif5hq2lBx0Dy/Hpx5qj/+etVfi603FwuXL9npqh7PZhUS1tmfyUGmHRKXu3UVaLGt9q0kHe
 X+azBPpBaoUg==
X-Google-Smtp-Source: AGHT+IEBbdg/NvbCkaUjwD5Fjq8G2Lux4+IgHqGH7de6dJd0Y/03EIhOlfS68RQpn+rHing8kISz5A==
X-Received: by 2002:a05:600c:1da2:b0:456:1ac8:cace with SMTP id
 5b1f17b1804b1-45892b9e27emr3651755e9.12.1753804215269; 
 Tue, 29 Jul 2025 08:50:15 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:00 +0200
Subject: [PATCH v3 02/10] arm64: initialize the frame pointer register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-2-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=994;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=vzLGLPqeum6SV1jaUPioF2BciGorBkrir+9VBG2Aj4g=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2qB2h+fX/SdtpVGIQCYGUymL9++VtFwnfAk
 /NGkDY9EImJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 tki3D/95J1fdSvzgSkF32YWkW/HFdagBiCsYp+ya5wyJNiEcaEGOzqutZ2/5Cvl2smg408PmL92
 HmR+BobZTGiOlGhoRvgK/15yttzzHjV5sO8oeBUwzSc/KLjQlupNkMcsy5TFWrylVrBrm6k/zAN
 PajMQDEiu+e6Q4LeH5w0GXigBM97aRNToqiTRlYJkEtMDrSVegNZgiWicMiE+yrOBBov/ddMcAN
 iwigAjji1Ynp9QxbkEPpz6Cl4fdzLZN4wzxt5JIpXZJY5vPEKdj4BBsTINwmsNN2UwEySQMXqXx
 oOu4lbYH6UFVbR6YXThExQ9rc1VebGwIVFZUmS9KfvxgOEtTUUI94rNJ55mXz1mIDvf9otzRF+O
 aSE26IdQWJJkl1ErDmlpajbocChxgUBMB72BU0XhGSYenu/8VapwS1ZZ+KNnfWQaoRQxP9uzdvO
 NQi+z4Kr7zhpyf204c1DgFBVy0SZU1vnxdpLaJxWHO+AVRzs5Cls/e9CwQ1UrOgs0PlHuNna1z/
 Yamull9qk/FGoq+IJlwqihWGHQuy7P0FcIsWvGA657SsTMoU7YSDNlmWO4gnFN/XSdpXAaEwyzt
 +JvOJLKpuy5Muj6mi73omuVXRwODcuddRm8InKkQV9ZjnihIbKr6SZuPwo44oLU5BMGH2p+QmXg
 GP1AEjn19PKmO1A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

U-Boot may be compiled with frame pointers depending on defaults built into
compilers are via explicitly passing -fno-omit-frame-pointer.

To stop walking frames it is necessary that the initial value of the frame
pointer register is 0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/crt0_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index f3f279f2c39cd27cc30801805999092d582cef52..3ff0577e9c87076e7fc6626fde3703fe952f07c8 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -167,8 +167,9 @@ clear_loop:
 
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov	x0, x18				/* gd_t */
 	ldr	x1, [x18, #GD_RELOCADDR]	/* dest_addr */
+	mov	x29, 0				/* frame pointer */
 	b	board_init_r			/* PC relative jump */
 
 	/* NOTREACHED - board_init_r() does not return */
 #endif

-- 
2.50.0

