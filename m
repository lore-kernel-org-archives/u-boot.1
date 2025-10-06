Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6193ECCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E169783D9C;
	Mon,  6 Oct 2025 17:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uz+MGDRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8AF83DCA; Mon,  6 Oct 2025 17:20:04 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDC983DB3
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so39963465e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759764002; x=1760368802; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s+WtYixaxMs2fvH12g+axiH5oEE4IkeOt3ftfs9ELz8=;
 b=Uz+MGDRuQQpK2/KFCfY7PTJypur97Pi6hqda3+0XIMPb35lOv+LiF1iUYHLuhTsdhu
 ahmiUInIrxbAJhTGN9MUlRMF0YvLidmC2NZJoLjSGarYRsx3HBkAVDVQKcGE4Mhdwl81
 gb5zCXz0iQgL8tzarAaWoDp71suehiSjWyEwirKgObiiREwrb7ZQ0rbiIofpoIUDYXdd
 mNv60RhwP54fIC/cdRS9sE/CoSIpNtXlLeAdVN/RlHXmLVElyyBiJtxP2jMddxS4vgbw
 W/qlo3nizRLux/+OVLJz7JFUyZTfQ81x5Ns2lOKmOkSyA2dEQkynGIk4pq4KzI1+6o4y
 gcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764002; x=1760368802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+WtYixaxMs2fvH12g+axiH5oEE4IkeOt3ftfs9ELz8=;
 b=Bdx8N1SCr9UWedmXU9SJCdoR7LA5Mmz5DNQBoFqMRT89YOChU5MmxbbvOQYGDf1Pej
 le5SbETTauov1PAZcOQj1H7WcSXejsS7UffcNe1coKyS5rFlB9DjyC7HtUbJuEKWFj3w
 pwfuXbnSIY82LAUGL5M3x1VTDTEv/JxINEuyZTc+to6Fw0VnCik/a/DmTk2C+r/T47rm
 RBEKkaOkU6Vm3zi35VKKb++UX20CflzIH01FivQu0UY14qeveE6khEsEaP30IOX0Ocpz
 AiGN1vPbR/UHxMZ3NTMy2fNx3ilEOHNhPxGc+aKGwkMZtxfb4Ap60Wr4LZcMEe53V0vb
 Z6Bw==
X-Gm-Message-State: AOJu0YzIFqDwnGNDYj2khKL3wnpqeWUFLCrVhqNVDpuK2legMG83qHbj
 FhDPndFWwhUZVmTmRJ+TpyKzhUaqrIZfWV7auDXuXQJ2SRDWaMZxGSJ0n3dE7TYVZFA=
X-Gm-Gg: ASbGncuyttZTm0Natjj9SvpZVtuPvEqnpLP+HOyX8MdyruE7CCieIMYNJD9z8jeEaOx
 u29eLSIAI/W9/v6UeZcAIzp75dahAQ71mzTe3HrVRx96PkaMgP3+mBOECUigIkDKsAlGk8Np4qQ
 adh2sq4r4mayZbpLy7tTYwvmzMFHNgPdNqCzdphwKoyVGNTLhCDnWreeLJ/WDwCWwbX5z0FXSjX
 /wRXv2ieuYCvVW1OQvNz4RjD64ubAbaO52JCi/3lsR4XG1hfZMfdWMnapCxIHY2Fpewlqa6hvU8
 e2rGPnEyKgV99bbw1E9lZNrljodzkil22LGqszQORCUtcmM/WYfO1yaA7qtC60Off4gz2BMC8AN
 Fe5XwHjL8q+DzjH67FgRZ28LaBDLy68nvjHa3EA9TIJXGW49TJLOKRebLFp/uwuzKzhor/b8laD
 VU7UmLI79xQTUu
X-Google-Smtp-Source: AGHT+IFI2cylgkXZuegph9jraKguiBgECBCxXhcBwTcgvkKa/K8aPHgoJ7Pj+UuN3QjHEA5c/ReniQ==
X-Received: by 2002:a05:600c:1389:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46e711002b0mr96774435e9.7.1759764001739; 
 Mon, 06 Oct 2025 08:20:01 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm21304971f8f.26.2025.10.06.08.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:20:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 16:20:00 +0100
Subject: [PATCH 2/3] ti_sci: Provide error code on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-ti_sci-v1-2-9cef92e1022d@linaro.org>
References: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
In-Reply-To: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
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
index f262da188f675b95ae217df418dc6df0364b4425..bd8a8f6c6b35e9038f5fb9927927d5b664ae5a3a 100644
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

