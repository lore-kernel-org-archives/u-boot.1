Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2675BCCA472
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 12:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3458409B;
	Tue,  7 Oct 2025 14:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I+GzTWxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC9183FFE; Tue,  7 Oct 2025 14:04:22 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE1A83918
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 14:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso40321795e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838659; x=1760443459; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n0fblgGKdEYLOGfpRIV8oY/h3Ymg6BBOVf5QD7oqncY=;
 b=I+GzTWxx1OOl4vZXo98N5yP78jCNaNcDVV8+STMO02cRfBd4teLHQewAoL8mIPzIH7
 y9bh1VwwPTcrfvFhSELDLttT4qZARXGkhKrQdxtWpIeV+F9nv459lwBMe+yAEnVZT+LQ
 TLmcixT+WwvAFMKyzYWN2TuJXZDf55uTu5w61vZmx/56bAd9qZypoh5lXPjc1KmCM/XA
 ZqX5RnPZFD3hEEJ6wWqpb6+3N9lLGw/QtB2LgStD57lI4Ouhf3uTkfH5wOLrvMmsKUYV
 Wppyv1IhYmiq0eK5Mn1KV0Ab4yhZbiWJeagJ/8EK3VLYPZdS9p1Bw02EQ7AOQJQpUBry
 qazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838659; x=1760443459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0fblgGKdEYLOGfpRIV8oY/h3Ymg6BBOVf5QD7oqncY=;
 b=YvK5u6kbSd9cBsFtGFS8oAyys+LeIUf749Dq5Q35dKZnvRBhDoa9Ja1s9P8BmDH6Un
 HyWKNAaQFaWV2MVPZFR/ThrIyPMh+CdHVr+PjSJfKA2BaDK2NfQE8zGR/hOOg3DuuNFN
 fAv2OK8TsZqrKpvFg4Yz9lpg1xPKbceopjSbJ74HCR4w03Ab+fsfp4hQqNoKCWNHKYXx
 gKzkJMn8AXq1C0S6xO2wIsTLd2DY4HLSFeBIm3F15P71ZIwPl8CjeSTJ6Fy0IefQCffI
 1adkrG0jAVfb7giFN1cDpgD7lVIBs54udgbCrujeSMVftbYL2wNjHZ6kVAB5NCxc78FG
 1IHA==
X-Gm-Message-State: AOJu0YxryG+seGjjAxx5Oq0zhWOyn9aPY5qKNR2KdPnnf0zHlzSSN/5e
 Ytnk+Z7bcxaNeP3ySQo5LyEJwzvZQwgiMAFC+RlF0LYN878++oGDGTTJrQkEYtdCL70=
X-Gm-Gg: ASbGnctdbwyeWjmhqBi1A+FPPfAfdCNb3a6emo/+UQPWMBhXtP0+i44ZAdO5StEDqhH
 HcQtY+lsjqGfU7d20MhTBERZaiED/mLqzhRy2KKhpg+S8VF0IcOu1mrWKfnRt1F6c8o02ZDLiTN
 V1Wd6+AW4VUVYsywD0/m/Dqs0lrCZC1hv0t/uKz2rdIQpbYuSSlSI5gjHA02O1EKX+h2BSYUfmN
 b/EifJqBxsefH61zGjp/DVB1z/zFBXFezoKBtlXi4GpiSljZsJdhCQXv1Xm61pEkvOjP4EPmZ15
 GSZPQoSePGfnqbkjCcNIP3+NpKlQzFQnV01MuPeUj8+Sc74RaEv49jkjlCq617bDlCoMjD+V+Ks
 8MFias0CedkSxlOQNIx0inKjpexPIvH3iSOYynx5fI/BL8kg33N9Bf2nr0A80INyGUtS26XcCBv
 iRA7GJpaH3bwc=
X-Google-Smtp-Source: AGHT+IFlbB3+bCK/pUPVwzC4xAoCY6NnOYhQq+iyAxSU2jTr1GLyDAKKFnY2PQ9ldYU+Eb2loC22vQ==
X-Received: by 2002:a05:600c:3b12:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-46e7110efbemr109383105e9.15.1759838659437; 
 Tue, 07 Oct 2025 05:04:19 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:c90:3de5:5f6:3a69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm25109402f8f.17.2025.10.07.05.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:04:19 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 07 Oct 2025 13:04:18 +0100
Subject: [PATCH v2 3/3] ti_sci: Pointer is never assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ti_sci-v2-3-7561d7ea07b2@linaro.org>
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

The pointer resp is declared but never assigned a value but is then
dereferenced. Fix this by assigning the pointer to the message buffer.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index afe1ae13834d236015a3d5e4d8d4f9955ba8c822..91edbc7898132bc10fcf4bd6a71c1e7aebd5147d 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1365,6 +1365,8 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
 	if (ret)
 		return ret;
 
+	resp = (struct ti_sci_msg_resp_get_clock_parent *)xfer->tx_message.buf;
+
 	*parent_id = resp->parent_id;
 
 	return ret;

-- 
2.47.3

