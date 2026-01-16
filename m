Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDFAC982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F318C83AB8;
	Fri, 16 Jan 2026 19:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQtNFwN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A04F83B49; Fri, 16 Jan 2026 19:03:31 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC0E83AB7
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so3136379a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586608; x=1769191408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jekMKY77mj/E9QWbE0R1Qagd9t/oRBrQ4ctSP9fChw=;
 b=cQtNFwN1JdAdjzdfPWgm/eARUhRLlaS43qv9GbPYoQghIjWZJIz1bxUH5Buk2NCpV/
 vxZSTmNJUQbZ/PE0G6whA7XBNkhK0v04Bxy5+1TNk850CZkCQzub+QGpCX7S+SNUIitd
 XGFZ+wZ7pTxdQvpqgUBhGxdeMzpDzJM6lunR8Kufl6A6k5L42NpPT5cQGhGxOnMi6Eez
 K0tbg/HoWbyOBnPOv2pLjmPRquPib3RWqafmQf6ReXbTPkdMMMyo3mGAj7M5LMqXCQDQ
 Ic6CMydi8Fb2ixZzNjpTzotXOoANt8pQr42GpaeZsJJMu2vWKAJVf3QkSYQzzhM58pUQ
 PWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586608; x=1769191408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jekMKY77mj/E9QWbE0R1Qagd9t/oRBrQ4ctSP9fChw=;
 b=dgPiegcsch6QvdOa6Z65C1pdku5D3AgS7zKCVUkv/notP0ytSx4l+xwEb7MLpHTc/g
 hrprDbUkb3MJpgBNVqXzpt6npJoT1t+b9OFBajwrnhn+0KuHJvZSqNTToPf/lmRPYddj
 8UpbxnYVKpZ+eBSPesHIQj24Wd+LjrslbgYU5zBnXRelSRUoMHVwQGVZAqMyyhuxKZdx
 I1ndiBjYKHjRZqKaQkQd37fv3L1/R17zdGQSJ++XpjhFAgG653QNMdXgZWemp1S++1X7
 OBx+CB8nxQyH1c2euWr0lsoGL6Yxm4jD6em/VqftLNX5TxKHmLXlOjK+czlrzP4cIdvf
 D72A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjf4MwMUHlEN63RQGOhHwz4FBTfoIh+EGoWsaCUPg26d9oKJnRlwBtHpfL1+YSt4UR4INUFjM=@lists.denx.de
X-Gm-Message-State: AOJu0YxOCs9bZtQfNTfxHSACXeWz/T087Tus50xa14lSVL+kBbBMnAps
 lM2PBaTYX1LsPDgaxQjjMDtzb3+62sws0Fy02yEVc0Y3P1KhbI2oUvxV1II6U58tA4I=
X-Gm-Gg: AY/fxX4vOO4wmsWT7ToK++uW8IvONjcV9suUl6sndZZrkUVnjoUE2GRqsdn9nLOarqC
 kL3E6pAmfQkyxt+/A1MbmepY5fynMRLxMnE67mTbiDloG/77JWAYk48RUXMuWHTqO6jkQzrij44
 7CvIydziepK431H3y7JWtNXZJOEMOs5Qz49nH/GTYt/NHnU6AoIlmREj+D+B/hKFsmzA+bl/eoM
 Gsvrw8eEvrPyXF5jnXjejW+8oyF30cDFTDBcBT+uoi6Jx3RX2j1B8XiBJc+ykpaQ76nMEFFdbX0
 hNKdZKnksiCiYPducy6/G6ohPR4PTxPJxcwDVB/1FFGzFe6V4T7l12Gg6qR0FxnbX07x8meGZPb
 092qNl/psHpb6sJtP2hvhHhM40jPD3ZvbcyodvEcZ1FC97uUBBxB/Dued7695lQe8nwoiPV3B3T
 FXLulb/2C1FyqWzJo9mvH4mPlBrM+F70DCUdy6atUXjjTJw/GvLWWP5w==
X-Received: by 2002:a17:907:d7c9:b0:b73:99f7:8134 with SMTP id
 a640c23a62f3a-b8792feaf8amr290898666b.45.1768586604939; 
 Fri, 16 Jan 2026 10:03:24 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:24 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: lukma@denx.de, mkorpershoek@kernel.org, marex@denx.de, 
 trini@konsulko.com, kever.yang@rock-chips.com, jonas@kwiboo.se, 
 quentin.schulz@cherry.de, gchan9527@gmail.com, u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: gadget: Kconfig: Correct Qualcomm config name used
Message-Id: <176858660377.3399278.13340356463907232797.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 24 Dec 2025 10:17:47 +0530, Balaji Selvanathan wrote:
> Correct ARCH_QCOM to ARCH_SNAPDRAGON as ARCH_QCOM is outdated/unused
> config. Using ARCH_QCOM was causing USB fastboot mode to fail.
> 
> 

Applied, thanks!

[1/1] usb: gadget: Kconfig: Correct Qualcomm config name used
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fe3b827a5937

Best regards,
-- 
// Casey (she/they)


