Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10799CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052188393F;
	Wed,  8 Oct 2025 11:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r7iAh7IH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1542C8393D; Wed,  8 Oct 2025 11:23:41 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC7283A36
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so3779887f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759915419; x=1760520219; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L4c3aBVas5y3bamKFMI4eG9pvEzF8tHS19Oto8Y4Q70=;
 b=r7iAh7IHZ+Qr94zeh4zhZj3MxkcUxI0d9eA0uFxlDV0auoxCrFF75Y9vAemFSIddK6
 BlCoT15aXi1dS/KUc99djZFZWPyNqA9ENV9UkA+9CLv2frYPBfXvVI3Iy9ONLFL+CTN0
 PzR4+DqVZ7GxF3t10btKoXoxaxU63L1cuNUsjzBeNOUcfcoKvPXPlCvij/TZKy9/F1mn
 UzjMupZscyrTUNCNB8C5LWXXYsSB7k5PB7szm3sSJy4kYQ/kspiG1y1HkVgmoADb7+Em
 jcR7QWdSqWWtrkU9fc4wpRkxZPSjdy5Go2J+Yiu9UIbCECCjuC01KkaN8Rt1tYHjoyL8
 Mq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759915419; x=1760520219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4c3aBVas5y3bamKFMI4eG9pvEzF8tHS19Oto8Y4Q70=;
 b=Rk0lGTDiy06Cfn+p9DGb2GPFDtMOpqcjHm55hwrAYAEg06THhGyET2fZf4kLYUNz6n
 TkIXS4oS1Y++xV8AtkQHGYBcI7R+lRP2gHnLLwlyM82gxE81kUChV/gsMPYxTPDP4eAQ
 Lw77WsdffzrYm6f9MtqfxFiLnOT42rJ5a/1TpHgJewvSzIag1c8X/LTbAgV8wmNhBHzR
 9+z9yrt/OshRoElFJRCDoFQl3HlwgX4lUbRBWzD/i8Jyb6KXExqKMc173naVWfKEGSFb
 FakwduwHHN9xUmZp2xtS59yamrhJ5r+Kq0aRbi0ym0uX86OXn9lFS6fgXo6y4I3479TY
 ZXBg==
X-Gm-Message-State: AOJu0YwIoSYaJRXXz4Usk6tR3ZtqKColfj2x5prxxcv7rxowyQpZcfqh
 d40Y6uTpY7oCAmi0WoB3z6Zk7DFpAPV9ihzicO7Whnp79rB3TS9LFzaJwAn8gDCaGG4=
X-Gm-Gg: ASbGncuqWYxrjk/vS9iPIol1vNqrhyfe2q5G6F76sTtsMdlOVy9kNpWrt6c+X1nqkL7
 J/sucxxb05QwDF5nrxRBjjOtrWWMa/3O4/H1OBYUd3XAogmwR2AvzYQ7+Y7t6U8Zbc9wu/dEhc/
 P5B84sSZ1vXslQEt3Nn1X1u1+QgOaHitii97txOtdNp7sXAe6k3cLHJuPH8+yjtMmMaL9XsRxC3
 TTk2Q4xBjtwdlGNNer4moSgGE4DmECvyAPcYFgdsqSnWrgR1QWy/vS+DSKtNnUOaz3VK+NWviaa
 2Z3D5l6KohD9WnQEkQfvGapOJWG4IdWuT31xoF3ihK0S5c3v3e3asurW9n5ft/PAgEzMZVIxcO4
 LNs61Omu0bnSCGoYb/tlOR/IW52CFNiWc1aXjpFy5CcRuasu0p1AGPY5rfcVdRQsjVnOu5rwhaA
 SFfUA=
X-Google-Smtp-Source: AGHT+IGZZL0owrPdLFseFjGTSza5B5zg5iUJC+T3T1NmqELeXGWnknge2RID9MZzXUvIK7a+XKfvrg==
X-Received: by 2002:a5d:5f94:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-4266e7bf005mr1726326f8f.20.1759915418637; 
 Wed, 08 Oct 2025 02:23:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:5f9f:be0f:fb04:8dc4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28864715f8f.34.2025.10.08.02.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 02:23:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 08 Oct 2025 10:23:35 +0100
Subject: [PATCH v3 1/3] ti_sci: Prevent memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ti_sci-v3-1-5866bf84adc6@linaro.org>
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

temp is assigned the pointer returned by malloc which is used without a
NULL check and then never freed. Add a NULL check and ensure temp is
freed on all return paths.

This issue was found by Smatch.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8013afef304dfb70ab14150ddc49d43ebebb5902..2042d88583766213e9d74dd17289cfd3562f0acb 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3083,7 +3083,10 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		dev_err(dev, "%s resource type ids not available\n", of_prop);
 		return ERR_PTR(sets);
 	}
-	temp = malloc(sets);
+	temp = devm_kmalloc(dev, sets, GFP_KERNEL);
+	if (!temp)
+		return ERR_PTR(-ENOMEM);
+
 	sets /= sizeof(u32);
 	res->sets = sets;
 
@@ -3123,6 +3126,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 			return ERR_PTR(-ENOMEM);
 	}
 
+	devm_kfree(dev, temp);
 	if (valid_set)
 		return res;
 

-- 
2.47.3

