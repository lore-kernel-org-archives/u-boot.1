Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838D2CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 12:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1885B8407D;
	Tue,  7 Oct 2025 14:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uzGURprL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82338402F; Tue,  7 Oct 2025 14:04:21 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 435E383FFE
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 14:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so62034565e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838659; x=1760443459; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cevzmtzBeDZpi7J3h0bJwIOdCEY7mXBlGO6LZDt7gjs=;
 b=uzGURprLzDx/4naa0o+Mu8LfIBm+Me/AvBrwiTrMIWi/Req1jq2NncfQxy8igu2qF0
 rbpcO//B1qy6tO7FCZutaWH7O0/JRMLXTEaet7V1yubXXm+fATCtB7kNS2IoIUKI3ZXj
 lpd55iJ0qadZP0TvxOrHacUeHJUJsSoTHgnjfd6ezqY1svVCkEIcn/6DziFfCUqdW9lE
 AAvQYwDZXW05to4faUk1GvzGeJVV4K74rsgYprBh2ruvxhfbrm0hdKTdunlqZdFV+0Dy
 fkP1YvZ38ubPrfPeOoZv1FSZTuudYZX/6dmI8hT+Gmc572h4Sx0MpHZ4W4XwQ1rQlYS2
 AX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838659; x=1760443459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cevzmtzBeDZpi7J3h0bJwIOdCEY7mXBlGO6LZDt7gjs=;
 b=p/dZkFxxtfPavfQLtV23EdIkYgWhUCOmODPhRh/cvtfwLLJ+C55wc64va74skKuVn+
 jPIf/Vrs5uVdc7cywyvRixKbi/Qu/gBZ3k4FeG4jv7RStVrTi0SrJ5hpNRXJGPBxdJ0m
 RNQJXERb+d1TsksasBqfqy0Z6mO6sZNdbVpM9ydHo+SfxBU8S+N5/3XcZYOJb8XIHe+G
 0EygrPBh0BcLx+gnrhkJlM3FMPb5v7Y7ZJDgvK8xf58yfnpY9MzDmjDY1YUVQOLTH9Ju
 AdWFeiEIXkmYW6FWXpsbr+YYDg4526eBm06pb6Xb7A1F2N5Qt9OdEv2umRFk3R3tGp+b
 lF8Q==
X-Gm-Message-State: AOJu0YyNRETAD0qNcWAg6MQui4N8lhY87FnEoTrFtkNHxEpeZubdPoAe
 vWvC1DwDg5Gg2GkwwIYfRnbrP+cb90H7VyARPcqyc8364km+q5uob0PYL7hGDUwc6u0=
X-Gm-Gg: ASbGncscedyiBLlxroZQLN2e9j7E9e/HydWbI5HmvWniNw8Gc9peNehm6bdE5Bh8NDg
 T6uiexyxDn7Tv/uhjiV5d1y2hCjdkeRrEGvcvWVQ9QoYNbdvEG3PyUynZOGE+hO6nW0G9ouBGm6
 CNm8+MEgGKmFJDmdOYRx6YvnXaorCz2upvJh1fGIkSUn4eh00wpQytSgJDGakkS8/GCCVphG8SB
 rGnM7/i9GylW8WWbX9gkfBsya06WK7wqgtpDvgZ4OydbyJKK35MQiv6AdxVc5LFDYdTlYd+cUbw
 i4EgydyTPM8Zi2+a/Yf0rwSOh7VdMMEcK5zqW44niDBojOY/GAG7Pt+zOef+bH6l/zR53AymHEg
 1T0jIMBAjGpohnQo4yNDKhntSF3D0zVfV4uFl2JdPxilXTGtNlsvDpZfVAsVexuFDHSHyLd2J+m
 L47+I1AOkKDbQ=
X-Google-Smtp-Source: AGHT+IElTq7posW6jZ9gYhRxIx7M9UnJWsruqb0prePRsTBi9qenBK7hSgGwRalGdowTKIbAz1n1Zg==
X-Received: by 2002:a05:600c:354a:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-46e7114e9admr106119665e9.29.1759838658624; 
 Tue, 07 Oct 2025 05:04:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:c90:3de5:5f6:3a69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm25109402f8f.17.2025.10.07.05.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:04:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 07 Oct 2025 13:04:17 +0100
Subject: [PATCH v2 2/3] ti_sci: Provide error code on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ti_sci-v2-2-7561d7ea07b2@linaro.org>
References: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
In-Reply-To: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
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

In ti_sci_get_response the check for message sequence will return ret
on a fail but ret will be 0 at that point. Instead return -EINVAL.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2042d88583766213e9d74dd17289cfd3562f0acb..afe1ae13834d236015a3d5e4d8d4f9955ba8c822 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -193,7 +193,7 @@ static int ti_sci_get_response(struct ti_sci_info *info,
 	if (hdr->seq != info->seq) {
 		dev_dbg(info->dev, "%s: Message for %d is not expected\n",
 			__func__, hdr->seq);
-		return ret;
+		return -EINVAL;
 	}
 
 	if (msg->len > info->desc->max_msg_size) {

-- 
2.47.3

