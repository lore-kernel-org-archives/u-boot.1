Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B1C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EB1C40DD8;
	Thu, 24 Sep 2026 08:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6v6mpk22-nA; Thu, 24 Sep 2026 08:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B01440DDC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240356;
	b=Wa5aboMm0sbqGNtVDiE8BYBLPJ/pPmWjVIvuQUi9tMLNe92fR5LEG7jyR4V8Shj0sDTL
	 jaC3It36uRcHnKF+beRBBI+jy3Lym1MKQvNthieDzGx++OhfHym+FLnkpEHuDLwZcF/tO
	 advGnq4kSsO1HmwOzaPYqMPYf/NRJsb+Prh3nzUz2ZA2Hl8hkmD0VGYn6bAeUD+dMl2DP
	 ZwIfGOVId5y2GP2zecEjRdtgb6UiUnFXotyk+UJ9aIpO9rZAMi2WdQmObjIkC4L9CHXs2
	 WdPpC+L9P53+Q2GTKW3rzVs9dAHv/J/v3ZQZMZh86e1ftQ+1KdU1ImU8e4w76VqBlcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240356;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d50LOUd8ZQjI5p5SPLPNYwir+T37U1+YFe5fG1UofkM=;
	b=rKEwMB7pVEevAww1mtXA356IACJmXgdU2TJEro5jPSYprfmrm4ZVpLnXNRrR16DVrPhD
	 I8uwoEturKxsq9m2uCT8rtetnuUMJAeDI2dj/n9Nfvi0bEElpciH/0Y5KYADjzpn/4OFF
	 ZIFQjkl0zdZZ38p3/rwuL71nOWqXI3Cl6U5JAO+PwyKWFyXvrT70M1t7X0B0tlCltXi3g
	 I3m3AJSd2dzIhbjxkbkZK9u8C8sn2o1lBIeoDh1adAi4HxaMoztHK8s+N8tueuZkvNh0W
	 qF+b8glSj9Q5e4Om86kv17bOcPNH7pb8zGgq/ShkXnq1Fx5B5OOkflk16A0zArqTYTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240356;
	bh=d50LOUd8ZQjI5p5SPLPNYwir+T37U1+YFe5fG1UofkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xyTbLZeYF+BDMYFQzU3/4Ro6btSoaljj4zc3YR2tP/K1XF/y+uuZc79W0mUQol1Ie
	 p7Yof5Nmn/DuTpnBAnWOQwDfUwC35pBxAJebcn9fLDKsgCa1+hjeiZfoeLm9ie1mx4
	 nTxj55s8pg+QiqiqOha79eHDT901t56ZNS2fNGh0IUOlksJCuKeA6qgH+E74ONQf4r
	 y0FEiyo8L7yTAt6Eszqm5dX85izI6CRaK3vgyNWstMpm/mAlXKekh7KelNOeVG4Ppy
	 rSUlHZfJOC8iGo5iyi1Kpd6dnw/59wWwjM9Vy4hNQ+F/FAqcit3YD2MZwftz9d34Oe
	 ZMhiO9eTbs/jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B01440DDC;
	Thu, 24 Sep 2026 08:59:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE4812F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB0EC8199D
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCBIr6T6yb2T for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:55:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 50DC0819BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790229332;
 b=Ru18GcPIbWWLeYhYXp2fRszss7pexDDYzcUNychyf5zeyaJHGB80UgCERLzwgNJlWa6n
 XO426kms8tIOuDfDLmLFXmm6pWhW9Vrn2P6ZonQQX9XG9E1nYmyQfNN9rFRlSpvBCOzCO
 RN71sboZF8+VfcBlUsLZ/b+ds7xDouRgMEbWLZTroHoLNSmVEYYF9FJqmJuJQCXVg/2KC
 GHMl947Fwcqr7TlVqFgTjj7kDOeuPEpXjXrZ9CXTJECCaWDfBrXhZnx/d/0Wo9JH8+dun
 jtITa3bzRbLb8BR+yHPKi0TL9GXFn3nmddRxBtd4V1/hv/2C76qEHoRcv+s3yPaTgBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790229332;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=d50LOUd8ZQjI5p5SPLPNYwir+T37U1+YFe5fG1UofkM=;
 b=aq98LYicImf0Ly2h0vpdpZwBqWAfpQrp2pLlT2yydNtDc/IaFoj0Q0LFINlGA8lNH2dI
 a7iyemkbSk2viGc/dpTlfypoXdcfjgQ12jblQSuweUCqdMF0GlacfVjI8Tk3r8anXXCGX
 oTLgMU+4IhHhqPsIJlSaZFDhKXwmHDXPUOwbRqvDLJatc5YF9lwH2ceM9HqJJGllzWaZR
 2StTI0tKAc8G5ICffhlfgDhxRWxg2CdsSzo7CJqhTcwrRUNHxx13Y7Jy6BSpPhZ3gYj2C
 leU/KtJkKKZt351ANrkD67jCE4uVp2juMzqB8cil2PkxmayZfqPsQsYMSmmcKLio4vQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="paKBBzN/"; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=paKBBzN/
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50DC0819BE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:31 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 702953F5E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790229330;
 bh=d50LOUd8ZQjI5p5SPLPNYwir+T37U1+YFe5fG1UofkM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=paKBBzN/h1plyTAoBSmrpdUtyoFPIYnLPOl8wAKyHqoq1j9RAbO3Rgk44EBd2YGlF
 QGNKPeEcQYKdnpELW0+pNfhopuYnAFkZFchnXDFm0jCkkb5GtiM4xQEg5UmCumVw38
 cJkNHE0lMuRZ9HZ1g4+9CVsqvFoNZxsXaN8hna5iEpvF9s0iOiM0qogi3POK+LhBcW
 LAJxi8ZS1QcXecGZ3Tnvis1xUzHYUPDDFW4W6C5EA1pFr37CYHEulr3nIPZigYQJdq
 IHBv2fv56bVQNJnPDC7Yi8vx8bPjk2InZgl0ImQ2ZWaOC3Pbp+1mUdNcX4+b7Tc2SX
 xpAUrbYupvVHAJwLOGYqMSlBqwJnyve98DrvQi6I3QLUtbH3mImQNKkLeojtwBzqiB
 jbYnyqODeSOB1uFC5cuGHGUdIq2Kv7sdMHox+XQ9DIEL5/XT2n2z4n/MelQYG5JZ06
 wIu+YUyUU9S+LKqnusfrevu6VhU8IKxGQLhyZgOfpqwXKuJlTb+D4f53P4+zggOJTY
 a9gHndeE6TyGq7qAyxJC1CoeszgCRvCaTH7ujm08DIOUP1UtxpbWMSDrXw5AIZaSyD
 uZSJ1f/05wOAjEIkvJe92fSc5WmCMYrBttUXyFrdXkPctS1IPlXiT4zutCM5e1PjzD
 CZaHHWSPLCkIngFVhkeIe3MI=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so1940304a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790229329; x=1790834129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d50LOUd8ZQjI5p5SPLPNYwir+T37U1+YFe5fG1UofkM=;
 b=Ux/rm+QLTjQDhjA+LQ8wC0/7vUHDqkTOL7eTmeMUgF77higO/sUX3hNCwfK+uFXwiM
 y039GyL6FiJCdxkB0VhtntB6WzAHzVu1kgZcLNFlFvVPRQhtLkK0ykZpVXaTxDWlAJot
 sUL+8cDo6WCJYeh1y6KoPslFwWDQx97+itUf43hnre6w8AYOhiX0tUiqF3ScRdhTgq86
 Y7XYTuWB5qLWDhL/RQjlW9yjD+mJa432scBPaqHJa+RVfumQvSVId8sbL0vYlF+rAeBb
 BmwVvLizBsH4EnxcDAaRXOUkJeTfAaNIIJP8Pll04kbKxX6Uyo0pxxTVeIXQVsFF641G
 HFEA==
X-Gm-Message-State: AFuF++lG+8cif/jzq6u6rL/lYfvWH6jdnjisNDqwciPJlqNZabth5E3v
 4FZoVcb1PCyp93aGq5SH+Zrdo6fzFWgOJ+AgE6O2FCMfo2jZYfaWYlzfuojaQAfmI22Icw6sYlv
 gs91icqm9mP9DLuqQcAOFaZcgdaOxvU+JHF5LxnyRDsyr+0285H7jKHhn0G98QF2GrIwLTjDK3G
 52oWDsbn4TgA2omqc5Ag==
X-Gm-Gg: AYBFou2SgSOpIwJPpCdttdl0575uv1UOX0HQf8uuyr2yQebKfic91rxGQdUSjV/0sqO
 LCgqyldHgsF3PloD9sQOX/0GLRg5ebNrXBxfvvnR7WwxR6OQ0QO7hsGblRancJa3/vYxtGw7P++
 sYCAgbS27Fo5TkJxm/UgGnVcw+g+72nI9O/dafGqeS8gmLZ3CUU+2qJ5I+hB0b3NFsLe4+WYGxZ
 WXUFYKFwEUbTIH80DGXWqVWi1i2rbo/k8vqR3lucz2NOHVYs3gphrEmtplF5hjhrqtjSHR6yTUY
 iLMMe/8Rsa18rW65pH+uJ0Pkk5ErpPmj2kJt5SIl3n+G+E30nIqvCOHsbCYJikBzU8/r68C4zJK
 wmYfd8uKs+olyk/Iu3sUad6BAbFtN84bazeq62zix8LGq8fls5VzRdvfvrGhoxSAd9tnJ0g==
X-Received: by 2002:a17:90b:55c3:b0:39e:3559:12df with SMTP id
 98e67ed59e1d1-3a098b98d43mr1207479a91.1.1790229328684; 
 Wed, 23 Sep 2026 22:55:28 -0700 (PDT)
X-Received: by 2002:a17:90b:55c3:b0:39e:3559:12df with SMTP id
 98e67ed59e1d1-3a098b98d43mr1207465a91.1.1790229328332; 
 Wed, 23 Sep 2026 22:55:28 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09733f48fsm2825829a91.11.2026.09.23.22.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:55:27 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anton Ivanov <anton@binarly.io>
Subject: [PATCH v2 3/4] boot: fit: use constants for FIT property names
Date: Thu, 24 Sep 2026 05:54:51 +0000
Message-ID: <20260924055459.125648-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924055459.125648-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Commit 634dcda25924 ("boot/fit: use constants for property strings")
switched boot/common_fit.c and boot/image-fit.c to the property name
constants in include/image.h, but a few literals are left in boot/:

- fdt_offset() in boot_fit.c reads "data-offset" and "data-size" from
  the FDT image node; use FIT_DATA_OFFSET_PROP and FIT_DATA_SIZE_PROP.
- boot_get_fpga() reads the "compatible" property of the FPGA image
  node. Commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
  for conf's compatible prop") added FIT_COMPAT_PROP and noted that FPGA
  image nodes carry the same property; use it there too.
- fit_image_load_storage() looks up the dm-verity subnode by a literal
  name; use FIT_VERITY_NODENAME like the rest of the dm-verity code.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: no code changes, collected Reviewed-by

 boot/boot_fit.c    | 4 ++--
 boot/image-board.c | 3 ++-
 boot/image-fit.c   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/boot/boot_fit.c b/boot/boot_fit.c
index 4dcaf95c6ae..aa867fe823f 100644
--- a/boot/boot_fit.c
+++ b/boot/boot_fit.c
@@ -41,12 +41,12 @@ static int fdt_offset(const void *fit)
 		return -EINVAL;
 	}
 
-	fdt_offset = fdt_getprop_u32(fit, fdt_node, "data-offset");
+	fdt_offset = fdt_getprop_u32(fit, fdt_node, FIT_DATA_OFFSET_PROP);
 
 	if (fdt_offset == FDT_ERROR)
 		return -ENOENT;
 
-	fdt_len = fdt_getprop_u32(fit, fdt_node, "data-size");
+	fdt_len = fdt_getprop_u32(fit, fdt_node, FIT_DATA_SIZE_PROP);
 
 	if (fdt_len < 0)
 		return fdt_len;
diff --git a/boot/image-board.c b/boot/image-board.c
index 67938fdd200..7602f5bfaaa 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -685,7 +685,8 @@ int boot_get_fpga(struct bootm_headers *images)
 		}
 
 		conf_noffset = fit_image_get_node(buf, uname);
-		compatible = fdt_getprop(buf, conf_noffset, "compatible", NULL);
+		compatible = fdt_getprop(buf, conf_noffset, FIT_COMPAT_PROP,
+					 NULL);
 		if (!compatible) {
 			printf("'fpga' image without 'compatible' property\n");
 		} else {
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 60e47db5fb0..e173108033b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2196,7 +2196,8 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 
 		if (!fit_image_get_type(fit, noffset, &img_type) &&
 		    img_type == IH_TYPE_FILESYSTEM &&
-		    fdt_subnode_offset(fit, noffset, "dm-verity") >= 0) {
+		    fdt_subnode_offset(fit, noffset,
+				       FIT_VERITY_NODENAME) >= 0) {
 			fit_image_print(fit, noffset, "   ");
 			*datap = 0;
 			*lenp = 0;
-- 
2.43.0

