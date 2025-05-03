Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A8FC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1D082169;
	Sat,  3 May 2025 18:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/HQta14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858B082163; Sat,  3 May 2025 18:31:31 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BBA81FAB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f8df49e75fso698882b6e.1
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289888; x=1746894688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRuU44c3xw9Kv/yOR2mSxJZSq79jEVioyV2rm34HuE0=;
 b=t/HQta14qgUCxaq3nbS0kWUi2tdVz1EOX1h8ZBNF/IUWuDRwtOA5yEg8iGrxdr8kCb
 n3Nq/C4msvMf8h/snGmLrJ4aosHAhqUiddMbHN1/t5kGdhqubipyCKrMDJB/vMh57moi
 QPsQmkYZFEkbC8n7cxTl9FyHff2FvNuY2Q2uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289888; x=1746894688;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRuU44c3xw9Kv/yOR2mSxJZSq79jEVioyV2rm34HuE0=;
 b=qKGaT+WYI3G0rnByVTApMvqjImgZcdDuDC8t/OWUK8CWGvl+BRCdg6lyBSSitwiyV8
 WOGMruQR5HUlh6IrnuoeWlj6n1ahlO1n30EURKWz7bK/wVZ8AZOulX0SOOxMNH4TWVBz
 z5OzqnGmqLpd2SkbIJerXN8hHRvurUwHZr1SpprhXFy1BqzdkjpfzTo3KWHUhAKA6Swz
 YHWZBGi1lKHvXBqFb4cw5f2dMs1tyVWkGcs2VMx5ZWfEpcA+eZRysE7/uoQvLKqs52iB
 IbCihHpB5WReOYYFn/y2OxdEBZpiubQ9ps8wDdgbowwLhi3jFhIuvIpvvKL6havtxMaw
 0JfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWHE1w97Wb8VHn1NfgAw6sDgo4VQB6cxR/OHpxolMpqAPh9V6guj/lyNFAoX8L11z8UGD19HY=@lists.denx.de
X-Gm-Message-State: AOJu0YzY9IPAAZOPemBqw98/tIK7n/ykVP7y7nht8KgJIcWWbm9Dad0X
 dfSoYKUs7wg1lNd+0j8yIxomj6YMaomYWbk/x8AF+J5k+VzRVwophIdZZ7u1RzcFlmR39MLgr3D
 1
X-Gm-Gg: ASbGnct4GFUej5QLUrU6tSOn7BPF3btatHOke1QlkhnfAkrIgqlNmnw9e5PP0GO9qq8
 IqkMPskKNEyft2GqkiwsA0zEDH4Orf9RnixH1Cr1AGsB5BbttPI/vTR+JElWKBg5TUYKPFREFUc
 +863QSQJLHaSki8CMLwD/qP7eBsrBFvPcryJem5jkpSfNQnoGQFoHbgDHAC9T2ofl2hsv9QeNWj
 7szlN2yj22VDwWoKeATLUAFf0oedLAcD90J+oNL51qyQYfC5LkJX9os/4vPfRd4pFEo+7L4cZ3+
 wUNXt5SX8Lj7IvWvN4USyBtUTwcdYpssLTtgSnpSfbMeyhyZwGJQVnkwDTSSl90lGMZ3auqQCzg
 J
X-Google-Smtp-Source: AGHT+IHx8cGimf+ij0k1BJOfWMjbyXQc818cw78uiePo7BAxJZzPIQNgI9oBUWF0mvvwLT7maaf5Yg==
X-Received: by 2002:a05:6808:6b98:b0:3fb:e9f1:8620 with SMTP id
 5614622812f47-4035a53ea2amr948099b6e.2.1746289888115; 
 Sat, 03 May 2025 09:31:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Bryan Brattlof <bb@ti.com>
In-Reply-To: <20250424193331.1633376-1-jm@ti.com>
References: <20250424193331.1633376-1-jm@ti.com>
Subject: Re: [PATCH] configs: am64x_evm_a53: Enable MMC UHS modes
Message-Id: <174628988691.1571566.10982461144639897823.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:26 -0600
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

On Thu, 24 Apr 2025 14:33:31 -0500, Judith Mendez wrote:

> Enable UHS modes for SD by enabling configs for voltage regulator
> drivers, IO voltage switching, and configs to support UHS modes.
> 
> The am64x SoC has an internal LDO which does voltage switching,
> but the MMC_IO_VOLTAGE config is still required to be able to
> switch voltage for SD.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: am64x_evm_a53: Enable MMC UHS modes
      commit: 4b033d47c4fc051c47513441547f1ad155d2f9b4
-- 
Tom


