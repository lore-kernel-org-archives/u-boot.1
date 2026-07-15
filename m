Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D750C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D8484A4C;
	Wed, 15 Jul 2026 14:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="XkqahKnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C7184AC5; Wed, 15 Jul 2026 14:27:36 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B663984A3A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso9833677a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784118454; x=1784723254; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z3bdJbawqurv6AbVMxCsX9G/URUY3kSP4y9ygcXWBHc=;
 b=XkqahKnBZ5V9UGNrSrRW6sOot8blySfg0AqoAXXMm+ji1o5YzNESWeXxkxNM2gYEEg
 HW36iNtD4DLWal4e2b4iUh4EyUEGcOpmcd0FOURbBRyf3wNqjqmXOI1y8VxKYIsyuu8h
 X9K2QhznfWokZSjy0eW1DfT86TLnNX0eYFiS7RfKBbDPzrVH9/m8z6Vo03lC39lE+b3q
 hO2wfZ1waZK3CeNN0IXzBGqyhLNNAhX8NXnz+6R3KViE4tBhdSHEESTKZHW0G+/+O1lQ
 hGknHlSOP4cVqbFAOcg8STpwKMkAlH31xFQfEfPsqt8gIUseZERXKEOvBy+/LcPvQypk
 C+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118454; x=1784723254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z3bdJbawqurv6AbVMxCsX9G/URUY3kSP4y9ygcXWBHc=;
 b=HUajrL6sgNe5peaCAnZYadPU48wkcuKmS3W5xYUJGQI7sDxPdiLjnsEt89absVEpWs
 fwZIKg/9QQ2sc7NIKOVxmV/nhFGsQQvhKF1bAop9ExKBViSlPpbN26R74nx+iptnc0je
 Q2AF1AMe8U+/IskZRxp2WZwyGI/fRehUuI9SEWigbgT3MlhmkXKfJ6y8XZ7pRu6CNb8I
 V8FwEdDE1pmTeqtNqU8SN5JsVDxDlza4IIjqK6T6nqpSGQBMU3anDskq5akmbe/O1Boi
 Qtc2/8wxWLDPvTBPnE5DYrmYtqvaaohaPAIgan8Lt3jInXJXrxacYQ4a1MRW8UcYe4bl
 8Byw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrNWeeus27JjwKPM5U73OLcsAQuY1MWhhvPEXj5rSPFTJtPZ56MKsi71iO0a6R9l1CUiUbsPE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp1fblSSDwAM2ToQNU7q8TI5nfvcZQBVji1dnNIxrtFTqCCZ9A
 ahCWzkbnIma5v45wj2PI17fXbqil5cMic6eKVRyzdg9dpvF5SHASIS7YgZt02nC/rv0=
X-Gm-Gg: AfdE7cl2rztC5jQhbWs83ITptgym6ckrJG0lRhZaqnbUK/CCyWIEyXs7+9vkJROZrYA
 XlbULRzrwHuP80ITgJW4uH8VZgCLQMtD+QNjJB188sGT8Nucdt5uBB7+GRrF4Xmzu35s5keipQQ
 6nsGYZnaAKTKUbjAD8qC/XWyCJaW45hiRbXZP5aBn1w63B0gZo3emNYLzuL0BL8NP4DErx54o5y
 +wEK9I6fWAv4wx+ylbxH3C6fQVWpHK4IoSp7x0togQz4ZLw9f161BAKlaBIbLNa/DnxJTh3g+UV
 rqdfHHVKxLwrAj8glq5/NgfFInj/O9iJFvf5sOvIzQCNJqL7CMJoz67c+6xXgGIHWeNfV/lsDpm
 +nirwAYsBIjr5GD6CdCEu+couPpDWwNsSz5/Frk0fhe7+oI/NMeZpvh8w/ARN8kXUw3TA7fxlXh
 9pwOoBnXJNg5HlSuao3bVi8rhKc4//ZrHyvkmjTDrzs4KE4W1Esf00DRkcRKiSfLk8D84=
X-Received: by 2002:a17:907:3d50:b0:c16:63c:a749 with SMTP id
 a640c23a62f3a-c16616654acmr464561966b.18.1784118454174; 
 Wed, 15 Jul 2026 05:27:34 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm15062266b.44.2026.07.15.05.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:27:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 14:27:03 +0200
Subject: [PATCH v2 1/4] clk/qcom: Print more details about stuck GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-gdsc-flags-v2-1-27704470a24c@fairphone.com>
References: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
In-Reply-To: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ajit Singh <blfizzyy@gmail.com>, Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118453; l=831;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=4xgXUDHpUY8FF+7Dj/KO33UP/TwZlPUAHYM6c5aHTfM=;
 b=YxNMKpnZ4DBuY7B61ItNrOC3wle4mEr+Abw4jWhONlaDylIPDBYdIxLLgkzubvQQ7Nt/DuCvL
 W/UYgvFgHnBBgMB3PUGQGS5GD/ONB9jsqWukEKxZOU2Mf/kNUFnkbXN
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 14:38:59 +0200
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

From: Alexey Minnekhanov <alexeymin@minlexx.ru>

Clearly say whether it's stuck during power on or power off.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..557f30d54d4 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -542,8 +542,8 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 					 GDSC_STATUS_POLL_TIMEOUT_US);
 
 	if (ret == -ETIMEDOUT)
-		printf("WARNING: GDSC %lu is stuck during power on/off\n",
-		       pwr->id);
+		printf("WARNING: GDSC %lu is stuck during power o%s\n",
+		       pwr->id, on ? "n" : "ff");
 	return ret;
 }
 

-- 
2.55.0

