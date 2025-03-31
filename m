Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C269FC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9575E81E60;
	Mon, 31 Mar 2025 15:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RmnT6FVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3595A81F0B; Mon, 31 Mar 2025 15:34:48 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E335581E06
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so35618955e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428085; x=1744032885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmkLl3LlD14bPVhk0uNmxdbiqdTATV/zBax4zBNPYGM=;
 b=RmnT6FVvJuPU/WKUTjRrOVdwdDHVSlQ3A7JAZ8+agk834/FHsn+OAb718uwSwk4TJh
 GZqEejMPTBYMetBwDmIoimbC5Q+R2LNFpt9VLsgx3U0o2CVAU7KI1s7XFaCUq/Bnuw7U
 0WxbmYrEwci/OaDNVfW/KttZWPdMWlTX9Q4oK+H4UlQZ+di1QceJ4dHZ/srgYYo+bMQ9
 gew2jlXVrfAdQp+mf55/oWKgH+VMcYSfrxlYK3Oyh7nGy47srhx8XEWEMqQ8MC+PBOZk
 lILv/v0gxUiY1FntPQiXPbPfwkuz2AGBU0WNvCcbrOIzOqAgRDANn3OXVpLgR+s3theo
 z1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428085; x=1744032885;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmkLl3LlD14bPVhk0uNmxdbiqdTATV/zBax4zBNPYGM=;
 b=nc7BICnB9qZZoVz+cN8oKJq54PQU0daW5uAF2uS8KKy1GWp1AOtm+TxeNAPjFSPQHl
 TdY/trMr70CognZPDhZ6smlwZbchO42o6oVAUI21Zheg0tc9XskBO7AaRADD+x2lFS4X
 0lMSya8yxms36/dVV3+xZamiXk41wHcsxfwVteXv2dyzrEsiJfzFebQhDZ9UXjuuUz79
 rttULen2zgyNf2ytuBQA/VBYThnNW5Q+Jpogy0OE16KvEtZOh+eii7vrrZ/QtQgKopXm
 7tQGTUQXstAVVmS+A8hLeRYnia6HESEhRkXcodzAICLsuCmQSjDA5bZSeML8naIhaZmd
 uusg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINp9m9bs802aAn8mXz3sdo4s3CeiG2whAVs2++vF2Na3VA4pqk1ICEAfJvuHMIPD1kAzzbf8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzado8cqAqYNRiS7i7wDhCduvKCYcNnEx8YKQiyRCp14YhVWlgo
 SQ8BFWpeV7JJZ0/nWnhCgJV/CpR3dEyuYWMV43Seu87ro2s9qPMK5YIPdE8220HMrYg8IUFULc4
 o
X-Gm-Gg: ASbGnct+zllmOcFcoUe6U8lC1pRwwmFQg0UsxqxULd0J2LVZy0RTUTasij2Swn5kDHr
 TOJMXd0Br5/DO5J1qK3vqtvSvxDvlcA0ciUFswCOPk0Jh8kBwLbZKBODBzjyWuEYJp2KuArJzhf
 C7iS9vxs3H+u8iVh4fUNZhark5TccUUtdXlv47Ozpo+Sg5KqGmKf4LL/Ko1l0qwos6qvbebtQDo
 zWAup1yDMhn4fKxpEiPmW5NdUGlhUHax62JX+kdhRIpyXvBi+8g9tplSMRudSfrYdMd2dBoiqH1
 VteJXknF8KruKbF0JV6BLnd1xBPNOSjWtCl5Q4oJn/8KJCtxdoIywcDll9XvMgcYZbABkbWR5ya
 X9kMoQ2tJW5gc
X-Google-Smtp-Source: AGHT+IHgpERnOa6G1F5+/Q3WmycfCRFNoD1Mznp0s0J9GXtxnLLkWSPotwqFkkZN8gvi0TTO54oK0Q==
X-Received: by 2002:a05:600c:3ca6:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-43db61d823emr93139045e9.5.1743428085405; 
 Mon, 31 Mar 2025 06:34:45 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com>
References: <20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com>
Subject: Re: [PATCH] clk/qcom: sdm845: add missing USB3 clocks
Message-Id: <174342808398.411395.16229080114576057682.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Wed, 19 Mar 2025 15:45:29 +0000, Sam Day wrote:
> These are necessary for USB gadget to come up properly, now that
> qcom_gate_clk_en fails on unknown clocks.
> 
> 

Applied, thanks!

[1/1] clk/qcom: sdm845: add missing USB3 clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/70bc6c4acb1c

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

