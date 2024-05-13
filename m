Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D30C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 08:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539EC8815E;
	Mon, 13 May 2024 10:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fOnoYy3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAFA87F13; Mon, 13 May 2024 10:27:20 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90859881BC
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41fc2f7fbb5so21389165e9.1
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715588836; x=1716193636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xx1CKiicLVpLnXpopRBe+lp9kQLLwCDDUnfpZnNf52g=;
 b=fOnoYy3WXFdpqzlCYoxOzcgJkEjXKzKtkc0G/Ulzsg6QPpcTqUwSWHNhfPr1AtAEOc
 sgtOcrrsjo9vH7z/vFJRt2kBGhHRQbxSuKVtvQBtG2qxvjfJ4VQSC/joH3qYVB8VswHm
 Mak6FssvfkAs/W24xFMD1w9xaVLOQovafDjYy0ju3p4o8z4cahgn7ORjYZz5kDITeJec
 ZyQqjyFwsRqN+wif70q0HliBiysm7a3UDuznoXkxkIiqT2QQTUFvIkICZ540mMifFy4F
 u1U2ZS8Hl9kzRGqWOHCGrgVxYcsqD9NAdPwfAdyFiKontcVpGDCOi3rCaW+vk2nU8HWe
 OIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715588836; x=1716193636;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xx1CKiicLVpLnXpopRBe+lp9kQLLwCDDUnfpZnNf52g=;
 b=WUOwQh2H3ce1W9+PiHKH/BKnlZjOi+laYWEA0pka4FcdbkVmkolqd34HoeDpPYZfUR
 Isx7ooGmuBIJOzxNvdyvZIeiE3Lc5Gs9OTbBWCJ7Hvd8tnsllK8RFNIaRQt5/MlHH12z
 dkBeyQBMAf4I9/C0Q550vm25XKhxNvK5oNZIBywFzW97YeRucRUWxRjexTQCmr575s5s
 SOxHmjwEKAGHy0NkTHx80cyuao4i6KrCGON0uG6M6IJRqGMv6GsrnfT5S8jmVlCPYHSD
 m+JEba7OYAR/S9yggSmJAep2FvpHGNkvyP1VrJAztPbELaEp1HaKkQUSlRiU4P8VWOek
 gAyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLWyPivNpX1lnmpJbj4ZjULHcjJJHkLK/pIGNX8JdOg7/jlu7HkpEPuIn1hB9BiqUqTA5Xb8pUS8/PEqUgR1CH3NA+ew==
X-Gm-Message-State: AOJu0YzquvAX7FD5092uC+vjv6sIkn5RVgqdrOmATR4P2vjtZ84xYrWn
 KdNdInvE9lirbApUQF2xJ+8sgXRI/2fpDQOZOGlRk8t3koEybb3AB6w232gcOGU=
X-Google-Smtp-Source: AGHT+IF5SfX2A7zBzBz/6lPJRBtTlT6r5g0i6OB9vbnqLnacJM8Szi9EIXtNOixoK9FxQEVpGUq7tA==
X-Received: by 2002:adf:ed8d:0:b0:34d:7d04:7903 with SMTP id
 ffacd0b85a97d-3504979ca69mr7972373f8f.6.1715588835982; 
 Mon, 13 May 2024 01:27:15 -0700 (PDT)
Received: from [10.91.0.157] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf52sm10640263f8f.87.2024.05.13.01.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 01:27:15 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
References: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
Subject: Re: [PATCH v2 0/2] qcom: ehci: enable core + iface clocks
Message-Id: <171558883489.3055487.8428613683652910908.b4-ty@linaro.org>
Date: Mon, 13 May 2024 10:27:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 06 May 2024 10:26:51 +0000, Sam Day wrote:
> These clocks are mandatory, as can be seen in msm_hsusb driver in the
> Linux kernel.
> 
> The appropriate HS_USB AHB/SYSTEM clocks were added to gcc_apq8016.
> 
> Technically there's other adjacent SoC families that can use the
> msm_hsusb driver with different clocks, but only msm8916/apq8016 are
> currently making use of it so I think this change shouldn't break
> anything elsewhere.
> 
> [...]

Applied, thanks!

[1/2] clk/qcom: apq8016: add support for USB_HS clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9809ca4fae77
[2/2] ehci: msm: bring up iface + core clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5c23a760473f

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

