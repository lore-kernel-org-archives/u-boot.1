Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB93E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB44C89484;
	Sat,  7 Dec 2024 18:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A57cb4jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2BD89484; Sat,  7 Dec 2024 18:26:32 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898AC88DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841a9c504d4so214359639f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592388; x=1734197188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKMRC+5hXVXk1eqUAuIDgrHfbsS/Aw47NS+Be8M+Tg0=;
 b=A57cb4jnscpG9VNlRoJCfChpsqoOT6y7fu2phpqJQIRkOikeV0uJmAPncUyuUsnbok
 vWpeXWkRK5nKSzWS0PRDj41JdmEZD3ZMSn3O52tICYD/3AGNLOeMEBmLasA1RIKfx0r1
 v0xDETsYJWKtM5/Qzt+n69/UAD5RPCcL7ElQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592388; x=1734197188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKMRC+5hXVXk1eqUAuIDgrHfbsS/Aw47NS+Be8M+Tg0=;
 b=vriEPtNIvRC3Co2nN56beKXtwfE46CBHahW7I15iPW90VJl2ACqFT9zFJjMi8Brhh4
 QIwpfsvbW89yzfrNxWbW+dhqf/KkJgXyYCvVqaH0+9Vq2p3D73zSi1EyF7JMrfqXdlwz
 eEAsgSkiGZExqA+dSVNef9+yS69PSd+nBslMZIQ2GXEqiSXtL2IJoWb/mJ58GlEjNHMX
 NYgMVhmVE96OL+UT6zij+40f1eWZ9j0gaFFP7pWSmX7saX2oix1muoGTqD52c6EKbCvW
 D7hwU9EyjKiMwWXvMIO62wM23ewNBDi9NnYfy18sLlTmYcz6NUHQVqi4S2C3PEOIzqbr
 VNzA==
X-Gm-Message-State: AOJu0YxOTA13uPWc0lH6Ix27m0SF8VMkoe24VYokFrCF1dxI1LdllQQQ
 US09ZMhH+hjfFFhu1yq2H22+07G00H6sbiXvTcPRiWZ/tXfdqttwfl/hLVIvP694Sn17EuiYh6U
 =
X-Gm-Gg: ASbGncvIWpNZP/NcNQfkCguuHGejiQJPATV4smZmZuSrYQBJanga0nSGtcmMIYCasvq
 j6STf7N/9Gdx1pGk+4uX/NJ9HJIxjpG/V8mNUC4Am63ghmargePBKjRgFWP0lmVCbTu+tCR1Xx5
 wB7hDXqYaHZRPAOftD69vu+VJYF78z5+KLIL18NPIWAFwNzekD8Ck48bq6aPgrBNdfuOqbRQBGV
 v+wLYrMWjdXAbpH0dQmp+RKvnDxe/7QG7hm8clqZO0L2DW9doXL2Gkt2AqBTmP3cvgysf9Uy9U8
 VUP0Cq2yp6s=
X-Google-Smtp-Source: AGHT+IFgLRif+UZPxj6iYEdIg8hEZ3BjoRmGB8nfm0AGifA1WchvJMU64TeXC06wpkRI8RO/r+JKTQ==
X-Received: by 2002:a05:6602:2c01:b0:843:f220:fc38 with SMTP id
 ca18e2360f4ac-8447e225cb7mr784943939f.7.1733592388458; 
 Sat, 07 Dec 2024 09:26:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/19] spl: Support a relocated stack in any XPL phase
Date: Sat,  7 Dec 2024 10:24:04 -0700
Message-Id: <20241207172412.1124558-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 91ee07f7079..702920bd2f7 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -896,7 +896,7 @@ __weak void spl_relocate_stack_check(void)
  */
 ulong spl_relocate_stack_gd(void)
 {
-#ifdef CONFIG_SPL_STACK_R
+#if CONFIG_IS_ENABLED(STACK_R)
 	gd_t *new_gd;
 	ulong ptr = CONFIG_SPL_STACK_R_ADDR;
 
-- 
2.34.1

