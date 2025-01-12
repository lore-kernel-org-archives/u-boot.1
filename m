Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3074E7719C
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 03:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E17580602;
	Sun, 12 Jan 2025 04:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DT3+LLiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D1AA8066C; Sun, 12 Jan 2025 04:42:21 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8DA801BE
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 04:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e1158fe3eso1795685a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 19:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736653338; x=1737258138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CVzJn1pvV3iidfWSp3Dfec/PldMJk5u6eX97PcXybY=;
 b=DT3+LLiBCFnxQWqlGdDeCGYOK1hw4wmzWz3TLzAZgRUKVpeRhj2kKf7glAopWmzwnc
 B7i/QFXFDA0eLT2UZTxXk6JzuU5GxuJkEAysPSBf4Ti7Y9S8T0o6n08WszOaX2vjH9Qw
 MYl/LWAJO4cRa7inc1lAgu/bCyLPndNiXWCg8OufnXjULSvtHyZLiKvYMALq3gotm0/D
 PkJQrbGoqQ0nrFuNb7FMlDc4/PssdEkw+BUthQuVvXVRcsMLCnFXSXF0yDe3/0Z/na++
 y3ExGKNMSw+wCg1GsJrQ1NQbljF5+J5f7X7PnKU729W2Lm2fLRa0vRFx2h8IP/JoeUf6
 ePlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736653338; x=1737258138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CVzJn1pvV3iidfWSp3Dfec/PldMJk5u6eX97PcXybY=;
 b=ATmaebc6FFy6+Ihc3GMqy2v0tfse4Xa21SDiY6p6+fWtVLBW8CLo4i90Dw78cUw975
 xJtS1/56Xt1kyijMDEcUgeFL3+3KdBqpRKiAAmMQh9p/23naICx2X54Rw2XzLIF8lS48
 LQ6cwDsR8IQt0tuAMI92UDjoyRnG6lftr6Fe+gHJQAfTInwwXO8QQqXnC2IT/dQm2EBj
 r07kWmxjGNgTwDpctCTzDcBlhIMfasnqaTtdmILfUy4TW2Zrg/Q1+v24OvEjLjU3Bb0V
 3WqxNbNWvAZrsdsNeOoxB8v1GWW+dtf99nlsR5bgK/0Bw88hWxi8aGR+5WAUpgfEgfEe
 wfZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI0D+NXuCsxvOOiNRb0e9m+sRIcwzZpRPKPhLjpAoxprEtUmi3LWqmdzgd5PCVUawe1Bfw9Fw=@lists.denx.de
X-Gm-Message-State: AOJu0YyOe8+cTqGmfXNJHspDjUTyFmtOC2T7PejpJ1I3RGCezFccvyTO
 H9rB5i8pN1/X6Bc6OHsUIm8h0U4VSyLgdO5gBIW1XrXx5l004JLsSeGAYDfvGlc=
X-Gm-Gg: ASbGncsLYsnB5hNTVRmB+HuFO2mwEU0xmebdPcpMJMosuSaE6onchYrfl8/B4GNI71g
 jvzgiG0tEVenkjSIKRL2LTwyR75EsAz2FlQkMWGYxpSZ+Qbymy9Xt2jNewVYR9b3b/2uDpXwjxK
 Ua4I0c/G5DzJidWkxMgj+PBTqOsq/p7AYGp7NidTF5lnnW/akP5VcwUb9pofmqkIlomOrSwNyu5
 YrgrjZqT+0jgG88B00rwaW2pbInd/LumjXut0cS10WmWaxPDy9gOu5pqa61BlI0ufk=
X-Google-Smtp-Source: AGHT+IGufmQ0h89YKbrvZ3ONxd4G79Vk6lE15k1U1qVNLS471bOQth/mKhowghi2Aar6qPLT7M4i5Q==
X-Received: by 2002:a05:6830:2aa1:b0:71e:b43:e061 with SMTP id
 46e09a7af769-721e2cce5fcmr11951180a34.0.1736653337724; 
 Sat, 11 Jan 2025 19:42:17 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231862a2easm2307870a34.67.2025.01.11.19.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 19:42:17 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] bootstd: Fix incorrect struct name in
 bootmeth_setup_iter_order()
Date: Sat, 11 Jan 2025 21:42:13 -0600
Message-Id: <20250112034213.13153-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250112034213.13153-1-semen.protsenko@linaro.org>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
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

There is no such thing as struct bootmeth, it's probably a typo. This
issue doesn't affect the execution as it's a pointer, and pointer sizes
are the same for all data types. But it can be confusing, so make it
struct udevice, as it should be.

Fixes: a950d31abe98 ("bootstd: Add the bootmeth uclass and helpers")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/bootmeth-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 049389403191..2496e8c1d8a8 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -139,7 +139,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 			goto err_order;
 		}
 		memcpy(order, std->bootmeth_order,
-		       count * sizeof(struct bootmeth *));
+		       count * sizeof(struct udevice *));
 
 		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
 			for (i = 0; i < count; i++) {
-- 
2.39.5

