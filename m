Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D28C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52F98311B;
	Tue, 29 Jul 2025 18:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gHnceN6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724D982B07; Tue, 29 Jul 2025 18:07:42 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7692A82B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so675344f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805260; x=1754410060; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=gHnceN6cElBvBSb9ZdO9hxdee8uiJiTgL38dX1niAyi9bcSrgwP8CcTXRNJ0MRSnpj
 eX9o/8S7bjYPbJ+BxIJCWhaa0ZJfTanppx0T6F00BJLgspthE7PYCGNQMVEuCVbJLQda
 PqxnjeDRySZBftc+M6DWnzO9NSUsaCs7NbGZem732FhEGmpApvtJasmEqymOgYQT3qnC
 OoetEv0qvbijozj6Mhw81diNwGUjd2ZocWC+wAPc5Hn8BsinprxTwU2gGpJeHKYU8TU4
 rxcdNQt7seJcHRvsVAf/F2TBK4NqyzkDe2Mej6cvNi600q559bZB8xfVESdBzCU+yuNz
 Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805260; x=1754410060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=Q2WuEP/gjD8gRu2bo7pMN5816EGlqVTgbY/EHr1Cpc5ftQ0OaEU46n+T3hTm1Z8Hmq
 Yq4wku4MvRehQ8sSok67Zf2PI7ig2HHseg+mz6trIa5M+JPKljMe1Yx7htv7wy3rAuQ1
 WAki8gMeh+FRir80BzLgVNtm5bJWKsLR7MMF2N2EYv3Vp6PGwdCgOXl0UgyT/oMxKyZo
 7bvs8acWeD5ckLnEHiQxtTxMNlMxMXCKjPOSnqf5HddxCeZHcjiume2IJzZWEbCPI+lc
 jZGnZh7x/m3FDTgnHpd/l+GVYFX7AlfrQik0m9CQhJJPbJvTZJ3bhdac3Lc6c70wvCLZ
 VOUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwVBOf/A8TZ+4ToBbTRsbclldM8wm7PL4yFE9WeMav19zF3djnZeg2iAtzxOv+b4s2k+eSYB8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+u771SNU84xgNriNBmr2WAnjM9fN0G84gLwNYXUwFmqg5/iCo
 RuIy4cGIZNyEkz7T3GzluQKAcSBCPRIOf49zKeueWZjyWJVcbhEQkA9OSV5gxFgAF5M=
X-Gm-Gg: ASbGncvLt8JohdS/xVQjLJgJb59/ON/2RU9hqttK/LIm4+NXktai1CTdVDk2LaifxHc
 6KncO8ZM9crm5kS1MkCblKmWtXAF6t9k66FpGyLvCPZWEyAKS7w2hMNajhZtJjwyRBeetxJlv/B
 ShNqt+jY8hGCi4ul14X4hVFRV6MOecxjCiSvvi8xQNgy1sYtICc5MgTTe+5ENgQ2ip9pcK1CQwm
 +wT2NwvV7msZu3wKzNFDWCBPdUhgU3U2FwmMVxAhEv3LhqXkbFfWWyKtuH3NFmKwY1a7Y6nQpcm
 Lf36jfLZqC+CQP33fPSAImoUYA+KCfXIpaivdw+JVYVU/DHWTyMpwghsjfPG0M7l8yzVwRyz5Qp
 8Rx6aL+vkSmFu2av0nLczQ8swzAgz0HvG8nrs9e8zpgACN5nEunss7fnc7yX7QIT0W/76EiaIwa
 wJeul7C/97aQ==
X-Google-Smtp-Source: AGHT+IGYk4eTMMg4PE5exKWUlEkMIqKVExWBh4tvWmCSnTX/szIkIzLFjXF/r5A0kUcKuKZ6jk8uHg==
X-Received: by 2002:a05:6000:2c04:b0:3b7:7d96:e24a with SMTP id
 ffacd0b85a97d-3b79501ed3cmr169251f8f.35.1753805259854; 
 Tue, 29 Jul 2025 09:07:39 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:39 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:23 +0200
Subject: [PATCH v5 02/10] arm64: initialize the frame pointer register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-2-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=994;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=vzLGLPqeum6SV1jaUPioF2BciGorBkrir+9VBG2Aj4g=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHBd+Sj5JnCHz60XZysmKfwnH8DYcm1xCI6D
 sKnrYgctSeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwQAKCRAFgzErGV9k
 tq1ID/9FzzmOINL4JgsL999dN/BCR4njmbUonRawGzsULE13Bd62jKo9Q0IZDsOEkClj2V00gIx
 WLgW5WhnAYOTGRXCPAvTLkGs86lIWj/+3MllAHfN5Jr/lgSfUgGvV8LMnOWscKuRpsRaDaTk2BR
 1uJI188gxJs0F7rkglvztp1/mkBykDh/ExlgMamJF8lAcEWXEsenmWsEHWNItkN4EO0+cHeg25J
 r5TRZrwg6CX8GNZywbem5ILfwRWZBFhQk82Yj7bk06WiwWTVr78Q9C8qq8jC5NiFvNQD/IP+yE/
 ZAzabDb82ztFDtfgk4eszVuf9tavwC5BFMEMu/mLTwiX++t904E4xrxb2Fk03T0kqijdSlYkz7F
 yhwD4/njdToEQXLqqSjX64AGpsGlDLBjpKcnpxZQNHrV5OLG5yKpoywLrJA16y2zzmNRd3Mp8yQ
 /1eFhioTDisuY1OdHT3bluO1VCBNVQV3/4AdQJiCiJynkYOAvddLDD7XngOPx2KahyhmLXowUD4
 L23ZKaLY31oCjVpROLprI2RmK+YX/w5iPpbCB4LVRUUEQQ746ptIXRgUPQhVVzc1kOt9m1929of
 jX9AeEcTAyGjhWjVQLN7tv6cXm22WJ1ixY2ft3kQ3mxrKoSCo6T4qqHuDI9Jr0U8q9xLv1Bpqwj
 reQOZFt88xryKnQ==
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

