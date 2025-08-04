Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8B9C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5950483FDB;
	Mon,  4 Aug 2025 18:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZVNEkO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B1283FC4; Mon,  4 Aug 2025 18:57:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8F583FCB
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458ba079338so16055365e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326623; x=1754931423; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mv94tYHStvsiYXfBmU5cAgGBhVmgB138jlZqPi83W+Q=;
 b=FZVNEkO28VqXWTgAIy8Nx4G/6RFc/u2xc8xwYACdU8xjU/vxvZIr/l7LApOXr+oPmi
 ChKeUYeWXL/mZG7MzqsjYLicZhmWMjBIcIsdfqLbi1ryUu6D1BCZAo/0UB2aRJus38S0
 kdN+y3vZgGEuz4Ai2sqFzqIsmTmuuaxEg0SByv56nblkxNq54LMnuO0jJ8a6af/aWF01
 AcvlEgvqF7V9qC4ei/IzCZQVDgK/QfKl6Z2gZaDt4M48jJGVr7pgCJgjPW4Hx2k2DgIn
 68pncYkVoJPDJioMNFfd/FEjO4uu8YGdeR9GHrNMnSvXQqYjcmIapUSwKMOffUGkFjOl
 IeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326623; x=1754931423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mv94tYHStvsiYXfBmU5cAgGBhVmgB138jlZqPi83W+Q=;
 b=Lpj1FUwJGMWlkgnXSmzy4QIibCA7zbu907kx3zuwJ2osPJ0h/hnG+vYm++7InyBJ0n
 zpBUnGPK67zlgGtIIqsA8QZov+Rvev4dIFGAkhaiAHUUbDaqSLp+xfHeEk2vcsv3wyUS
 4irYwTB5mHPeB+hF7IzDK8vvh3wxD+47BXvSWVDqUaP09JchRKvnnE324PuSMYl6VrXM
 osTe6fFlYYljnN2jUFnTXxA+vLG/HS2RQ85hq9v7bh7kP++K+KvZNOFhUaA35zkjfoRN
 uzzScckwikQhBvXE7gfSyHJgxTstWQ+EOFR35G/qtpdeQl9emiGsXTaVorGE9XPQwQDS
 LxDg==
X-Gm-Message-State: AOJu0Yw46pkHvcoEoxs+gyFPDyWy9akW+vVZe7ImLiQtXdcU9rIEGVSZ
 Xt1SMIWTsyVT4iQdDWJwRUez3ZzHZj/Ty3NMUurwwDy1I9XO83H6s7AcRE5vO+4FvOoZrZIimwc
 Nf+fO
X-Gm-Gg: ASbGnctQ1ojUxmUZNjKsojcwlWCiUX2tJXNFvM7wQw6ZRy0mlIBU5SLHYnP3mMBK2HB
 iPpRZFVJKbrY1+BYnSuMPEWnS8cGoRReYgetvWeZeQ9E1vKlbsEXpD8vFTv32kCUjNX4PE1z41O
 ANQoj0QDbpf3s6AXZrzKI9UtbrSbYPXMnJm5/sa4wgVxg1yTAtEuJwS+vsqbU3mDDdrEQT//Wvz
 TO9b+Awfet8pwMld0f+j26zxgFVCDTxqv7sU14N70Wb3jP5HabwjiWtRjL4pQB2a3JONR1849Gr
 zK19EtNN9thL9OlMZx5T0gdjxmECy1wXqb3CDxfWePBwELTOqAX0PuMIzy8CnMpZroy+Ggz2/ho
 jzG95EWRxtVHwOQYPMVV7bZI6GwEPa9nuS1Cr21wvBLwygTUNsb8=
X-Google-Smtp-Source: AGHT+IGUThGv6uw1PQRMRff0O9E16/x51qlBH5AKLtm5zQ7GQ8l/3y4SJBLEROhEytiRxH7pT1BpIw==
X-Received: by 2002:a05:600c:4511:b0:458:bade:72c5 with SMTP id
 5b1f17b1804b1-459e0cb883dmr3275985e9.8.1754326622614; 
 Mon, 04 Aug 2025 09:57:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:57:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:56:59 +0100
Subject: [PATCH 5/5] net: fsl-mc: Incorrect variable used in error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fsl_enetc-v1-5-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In mc_fixup_dpc_mac_addr noff is assigned the return value from
fdt_add_subnode so that is the variable that should be passed to
fdt_strerror and returned when negative.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fsl-mc/mc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index aad852f8151..c8ed702f50a 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -366,8 +366,8 @@ static int mc_fixup_dpc_mac_addr(void *blob, int dpmac_id,
 		noff = fdt_add_subnode(blob, nodeoffset, mac_name);
 		if (noff < 0) {
 			printf("fdt_add_subnode: err=%s\n",
-			       fdt_strerror(err));
-			return err;
+			       fdt_strerror(noff));
+			return noff;
 		}
 
 		/* add default property of fixed link */

-- 
2.39.5

