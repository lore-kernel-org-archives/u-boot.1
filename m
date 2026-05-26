Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06771CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F1284843;
	Tue, 26 May 2026 14:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="ehKaY0CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E60983FF5; Tue, 26 May 2026 12:53:07 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEBE80433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5102582e23eso81962321cf.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779792784; x=1780397584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pPoiI+2TsNqPlwqNJHcLLDDdAE0QHPodt9hfHSkVsI=;
 b=ehKaY0CMh93rvxh0zqqX7MGrQfItGVLzkhmTES5ZLbg5n+1HiXNL+ZyrMggzW1I85r
 2Eyqvku9qFJd73h565XQE5TJF6PB+Q8an+t9C6APDYPoT1NTlsZ//MYBvZwFopZzaa9j
 5JcBrMFjqR7GAaxnm5np7goWLAdvI9O0o5Rfy7HmL4AZbyR0pMMkOnRD8Z7htMDoDb7v
 oO1R6dhZGaxcB7nWoCs+FpotjE+rytGvHwioPw0zIRWv45+ND6AmFOfG2rlXA9zYhrXE
 aN0CPsPsMT4UXdHPI2tq+Q+Kn+XXkH5gw3hCcSWH2+ErGIzOIo2nxD3lmsruzjeVkHUN
 DWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792784; x=1780397584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pPoiI+2TsNqPlwqNJHcLLDDdAE0QHPodt9hfHSkVsI=;
 b=X4qL0sMlcR9Dfw0C8Hb0y/j6DR3rL5cEjNnHmk0hAx9goIgLuPgVxLwr/9HOyHHHFs
 aPVL7atRlVvcTNnV74MikSM+Bpp94TFDZeAgTiNpHRvLlENMX7NwVSGiQGeIh9o0UNmE
 uwZDoES33NMRjYVVamkI1nVUUJvl/VASG6i8wxmkofRQ84rOXGTdJMkEU5pea/FV4VqU
 JeyeI+82baROhRiXa7x4M0cYjANbX4emlxmzZ/oW90S5ooXxOwQj2x6ZL4sokRNdCSkz
 45w49OB1j+77Xo3OJLKApyu1qzZP1qIgnikwhyvSy2m5deCCkYDg1RwGab9AdHLl/UYb
 DS5w==
X-Gm-Message-State: AOJu0YwYrN3baF+XN18Bv4bOnvt8N14WO3nO9WEJp6uEp+Nk2PX0mgVD
 LSQ7pZdiIi1q+EG1cUKQ0tgmdxWR23W8rtpMyeh/ST+A0O20l0ZVtNbE87AaZakVDo3vTtljc6r
 N8j6v8rE=
X-Gm-Gg: Acq92OGZiawK7/OZ0EwBrUzJZDqaeA3SC9khGwRmfrfjK3eN30FWhWTe5AcspgOnWV3
 o6naZyCphMwCKJTKHPqq6txPCWQRRwNHwt1uEdy+zfu9fSgvXHvAR622l4dIzRCIfbv1OuCE6PS
 yF3PLjwmiqztS1ywN+Lc45XYPCjWaeFf4CKOPQhKJ91DzoleHozxzggTbxsEATdSsWto9eL4m0z
 p8twKk9gajrzWTAh+HUCa7h5Mrxoi2SlTf0HfWfuui8VYLb9txaRDaWSaOxSbNroWZVuullfxdN
 uj8JCU6JRFIVnMKmi84hTV7rTUVlh6/2rU8j6s4FvnDDvD+sBhd4ZCzbUJp0ZUOp342EkBAvuUu
 9vk+VtY1L6cDAur6LaiwYtz5MyPCTMLuRe3tai5OXba5/KbYrDvT6+uIc4gCts7Ewe4bmb+fDUp
 UVkOuuSeI6cpJjdweZ0vKjAL//vIrENoPZXl8jWklysf1D/Q==
X-Received: by 2002:a05:622a:386:b0:50b:38c1:c6a with SMTP id
 d75a77b69052e-516d4332155mr265865301cf.19.1779792783730; 
 Tue, 26 May 2026 03:53:03 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc5ecedf2sm487545366b.37.2026.05.26.03.53.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 03:53:02 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH v2] image-fit-sig: Validate hashed-strings region size
Date: Tue, 26 May 2026 11:53:00 +0100
Message-ID: <20260526105300.44523-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-2-anton@binarly.io>
References: <20260522123024.6292-2-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

fit_config_check_sig() reads the hashed-strings property and uses
its size value without validation when building the region list for
signature verification. A crafted FIT image can specify an arbitrary
size, causing the hash calculation to read beyond the end of the FIT
image.

Validate that the declared strings region fits within the FIT
before adding it to the region list.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit-sig.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..bdfb5e3eb7c 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -512,8 +512,18 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		 * The strings region offset must be a static 0x0.
 		 * This is set in tool/image-host.c
 		 */
-		fdt_regions[count].offset = fdt_off_dt_strings(fit);
-		fdt_regions[count].size = fdt32_to_cpu(strings[1]);
+		int offset = fdt_off_dt_strings(fit);
+		int size = fdt32_to_cpu(strings[1]);
+		/*
+		 * The offset should be already validated by fdt_check_header();
+		 * validate the size here.
+		 */
+		if (size < 0 || size > fdt_totalsize(fit) - offset) {
+			*err_msgp = "Strings region is out of bounds";
+			return -1;
+		}
+		fdt_regions[count].offset = offset;
+		fdt_regions[count].size = size;
 		count++;
 	}
 
-- 
2.53.0

