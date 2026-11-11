Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5A606A330
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kCfYWJuN;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CBybYBmF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08AB540AC7;
	Wed, 11 Nov 2026 10:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I2TMxIsob979; Wed, 11 Nov 2026 10:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DD5940AAE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392518;
	b=BFZkaoNTHtkzpkb5fx3MGIfcW98f1MC1yLGgbP0mB+RuE4HC177nNHm8g9fV7mOw0y+O
	 Mxr2y+GOnLKJ+jzUoPOgTgBI+DlaA34JFoIapWa6tOsx/81Wp///wROpLpvHLmR4rb8AY
	 jd7kHm46E5ofHsWqNdNhyKwjS8kPTCYgxP55Na7jrU1OnPkhyc3DXdBvKVkWDuk3aeYyf
	 IhLf7miqaH5wtz79qQ7pRDJkmNZXds1SZ6fahAydV2ihE0HQuAuuaskEdoPCAjvfjfQVe
	 95uQvD56IVaSmjYibPNLE7e9hmoK+YtWp/TUuZONX1aziKsXgi4RXjyuAHA/xhQUiTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
	b=AAC2lpf8oGQmWYTawIMP14c2ozFNLl69ZYy2w7pzKPm/odZVTrt8a7Ga8Cyq10PAK3yz
	 2xKuzh4PjdYF1+mdZBheLb8NE5VtO5zpqENRt83hOo5GRXtOy3Cj4BMlhJkpASSYuaZAs
	 i3gmvDJk2yvQpKTN2QYtP1vnxu6ZnNv4UUcNonmIPNZOWzhLN33lKYeRmZdZ79n7P9lw/
	 0XZm3FVuXGsjWVvyxvOim/Kr2Qpi0Ezs/DcNe2tOFsK7y+zrvI4+bQBWNPRBj0gg4LoMC
	 8fSV753SKsC3eR1hUxkwjUYrtqIKHIO3rygdwMrdvNYukFIKkrrsfNOHWKdf39ivfGw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CBybYBmF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392518;
	bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kCfYWJuNHkZhq8c0XSc7e38Pe3x5rpC+iJ2ASyEjIOGXZqeSBc5oOd1ShcHnFy63m
	 8Amfo4amNkV4lm8Lcov02+yZxiMRJ5sLjxcbx5SZOFsRQygl/8CSVxtHqzeGTmOtO4
	 m1ejBxJxLY+2NCMnETxfiuL+UXZxFph0C+dOytXegNayRjzyHnMPWHD/+ovr8IVBhJ
	 WBjmmprsxb4oF7gLRObYdP8ljJRHAcjWEhkEq5HheDkTo2+JGqJvHJG7J5OkfX2N/T
	 zRn4GiMMq+qo8prsvvZlMio53JZ+wdckAG7hgEsfYR1Kv9bn84vSKxlyfza5NaourL
	 BfojbOXZaFo5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DD5940AAE;
	Wed, 11 Nov 2026 10:21:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD643731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC9DF40A55
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMFZQv_n1NiD for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39A1A40920
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CBybYBmF
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39A1A40920
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:50 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1793049f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392509; x=1794997309;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
 b=CBybYBmFgnpBvY5bIPc49kpZRZTJyjLCMzA9jQm/KHaJi7p6Sy8xeERHwsB/27EGVz
 p5TFbsojbkgTet/E32fOBsRz/U74UxY0c/6izRQmAD7AwKFZIKSWCTGGAogj2eFDgL0p
 7/oxPMDUqxH2v1IuxBtAZLLed8I2WufGJcYKSfcx8CyUhmbeVWJkKrEgbCBFVTDCVo2Q
 YrKzCefspgoDzFAxaSQA+Ak9aAkBOj0p/5QLx+cFTFiMZkcfFVLFcusTORB9Ih96hGFE
 C3YkxDsx0qKLM1zwfQoZ0MeD5o81DJ6LxKdpKKUTK2M/yofmefoSZOvW3VP6yj+vdOx0
 2BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392509; x=1794997309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
 b=iVki8B11o59eshZHsyuw1NzYTCNR4YIBTM7rpe7KCj5jzpq9XqfL8NrIrNLtCJ7FeT
 qjNIfd7QyCPEwRy7kRN3QuV1XhaZD+VqXFpTM2xpKG+4B0XQbiSzzcZFkC6+1wfhQLV+
 3sO2VlolN7d5+PB0sjnUkKeelSUipGlbzI6d1OoGtl3v3NKJeMDD24945TUkvigPN2Q2
 i+RDudXo6QeqKdphz3zDJFAzS4o5wiSqlaiDpyMrIeHft+eqaIcnsf874Zqr0rrtaVhr
 wJPk5QYWZgHI8souad3G9FweYmEWMwtZFqZjKYEcxooxIDt+b/MnpabmluhZZfkKh18G
 VdGQ==
X-Gm-Message-State: APuU4Z9J2qYXWI6lO2EieeWLiN+0Rvz1AMGNmsXntRn3h3Dm/1oivfD/
 t27j+F8n4oR5dihHEJ4Q+Fcyib+ALGvWrytGWngSH4f9bsRMhQ/n1Y2H6iEQ30PFgtE=
X-Gm-Gg: AYBFou04/qTXLYf52s9xhzC5QNKf3BfNOJMSAjPAYLGzf6hSt9tmS5kdbx+Wxgnx3HE
 ZgL73RZwKuzTandCXZXsymW+c70b0msTN0UUfYZjaWUXx6yRtAq5Yjtw2xboU7NZto+S8LTqR0q
 opvDr0ZxHVpCV4H/KrVGznz8vGBNjrJlMswEEJXCG7UKhTh5idHnk4c4qryKYy6m4atc290i3NT
 3SXpwMnejkAK+lgf0ameh9hYsAlCNk3xG2OmjRR0VpQKCkBoo30l2PY/aXLzGEqzRmtEl3Aod8i
 oFi+vj9lMH3mQEgWb8TV499Ftf7OkQQt3G0h6F9bx6TGzAoUSbsW5PAXCKZghClRXJ8wKIO3avo
 arIA179E25ohmtJDoHZBQ0t7AhHIh9PaxomyeyRykVTLn9mU5G18sh7AF0tsd9Vpeh39T561d/4
 wwNErDRssB4L+i82GyfeGnlTI/6fjJEsRMqXhwz9PbCfGlvk1IqEMD+0nzUgiGodjRpzyYBcqPE
 cvU0Ii4Gn9RAr1Id4bES4nMmnzCNg1qZgEaD7ZeFsp2eyqPm0IzwMhtANTYHy5JKlpWCHzXgV9c
 6EpPCeORUOtlptreBFNckDu5wdROKX7nHNX78RI7+xaWqvkAD9SuuP8m+WjHZ64jJBbkKWDHRWP
 8QhtQI4sAv3n3cZ3KTo9p1+dB8scPF7P1f1PCvMrBMugKcw==
X-Received: by 2002:a05:6000:40c9:b0:491:8462:20b6 with SMTP id
 ffacd0b85a97d-499c83c0d12mr3090226f8f.38.1794392508777; 
 Wed, 11 Nov 2026 02:21:48 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:48 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:37 +0100
Subject: [PATCH 4/7] tee: optee: enumerate UFS RPMB services when consumers
 exist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-4-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RPMB-backed service discovery currently runs only with eMMC. With UFS
enabled, services advertised only by PTA_CMD_GET_DEVICES_RPMB are never
bound. Allow the query with either transport.

Skip enumeration when no service drivers are registered, so enabling
UFS support alone does not initialize storage unnecessarily.

Fixes: 3b39df3bc540 ("optee: implement the RPMB subsystem interface for UFS")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/tee/optee/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2abdfd99e5d..53806670b6a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -194,13 +194,17 @@ static int bind_service_drivers(struct udevice *dev)
 	int ret, ret2, ret3 = 0;
 	u32 tee_sess;
 
+	if (!ll_entry_count(struct optee_service, optee_service))
+		return 0;
+
 	ret = optee_open_enum_session(dev, &tee_sess);
 	if (ret)
 		return ret;
 
 	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
 	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
-	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB))
+	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB) ||
+	    CONFIG_IS_ENABLED(SUPPORT_UFS_RPMB))
 		ret3 = optee_bind_services(dev, tee_sess,
 					   PTA_CMD_GET_DEVICES_RPMB);
 

-- 
2.56.0

