Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87BCC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC45083AB0;
	Wed, 21 Jan 2026 21:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EwcZb+LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D01C80077; Wed, 21 Jan 2026 21:48:51 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036BB83A3B
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfd139645cso146067a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028528; x=1769633328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfI4XPEnIBC4jNh9kCgckiGUZkmmDlhxMKwe52UHn3M=;
 b=EwcZb+LLvWNkV67VK3TZFMTCyMtfAFX/3PudOK2kbrPofrBryIGQkSHSGE8IiMMrEj
 wqHQOY8parR9OKd0ERr5kcVptY7KwIav06GMVY9OpfA6iHMscGHuMoNzwzDOI+QsvbgO
 Cjs5k40tblu4NUrDBPrboUcqyHz+sCLAtdpwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028528; x=1769633328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OfI4XPEnIBC4jNh9kCgckiGUZkmmDlhxMKwe52UHn3M=;
 b=dmSIGX6vIOZ4kkpVvImN/Rn2xuJxAfArYM2fonbom+JhOa7U+LO4X0X6dFg/Vykzlv
 jQA+M6dQpJQha9LniFxSHIOM1mdzGc2OPUEIRJLDd+xrqsUFh+DbPg9YEEDgS+EdGJGn
 umWzqpmCQNYvETgT01y9qjZx5kWxcQx2573hkcsgNvsAfcBtWCVIdAvWAjswr9m3JxRX
 ITdLYdYk2XM2B/z4iq6/PUjxIoYRVPMRyyQ+8bLTpFQajJ0O+4L4Siv/on7AFpb/s6KB
 +bv3qEpvOSiswdgNRBf8QXTLnG7EZ7rt8/NayQ+8WBUVm+0erlPbM9px0OBbo002qqzZ
 DZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3sa5GkqobPi2w3yoKFNQinJsOfiPbZpXtLJmOCKFE88DFu8KSytf+3ACG0dh5ekfLkfbX9k0=@lists.denx.de
X-Gm-Message-State: AOJu0YyKnm9RJICgiasnnr19QYJ1vAgd1e01IFXmz5609DlQmvRPhTgG
 9aTB3uEHf0HPWF6xRsTzIhnRQrPgXIf6cRqNIphVKp3F5gvgLtEpUVY6cl1+0zj/XueyjOHycm6
 3k5WmqcE=
X-Gm-Gg: AZuq6aIHjHtMtuPEyM6FOWsLMxeHp2Od9QbIAvk/ELC6Q1+4fO7XhlUpeNKcqk581Va
 UzYF98LFpDpfye/u6i/17YLN95z9dlnTpizzWGqopbUKli86uTrTJulhd0ihoYZwtsQLZOhwZxH
 kqqDj3TcUY7Td14HoIfp32Ve5FkA+Q/HpM1Lfui4AD7ImAGq1Z1DnPv6N/XWDhXkEscmXHI9sbi
 1LXDm0Igqw7xhewKFCNhLsdakJu11k1phBnGxZpunGt/CF9hE8dPVDP796zpaDJJcWYow4wvV7i
 WFVipQV4P/EdC+CIjHcSon/wkKW0VtLVs9KwEDY2rCQj6xR477pXD/tfQXZuxBX6JpINbjc4oBv
 JIAGPgRcLiabjFEqHR62tdnBfgZYJQVca1qLz7x3K+01ypC5MqJjuiLWBRb73tusNvQmJn2RtcE
 lov4BE2iYjEBxEJxsTJ5YEodOrmAQk+Lnyk7Ek7babzFeCZEVsJzrDGXDGTQ5mR76ixFrTujDTX
 OWHh9TplvLO5vlYiV6u7qzFHsMnWYg3tLuvrA==
X-Received: by 2002:a9d:6b15:0:b0:7d1:5253:a0b6 with SMTP id
 46e09a7af769-7d15253a5e4mr258301a34.2.1769028527782; 
 Wed, 21 Jan 2026 12:48:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260114-clk-mtk-use-is-err-value-v1-1-ab35f0f35118@baylibre.com>
References: <20260114-clk-mtk-use-is-err-value-v1-1-ab35f0f35118@baylibre.com>
Subject: Re: [PATCH] clk: mtk: use IS_ERR_VALUE() to check rate return values
Message-Id: <176902852690.661474.695289092614250246.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 14 Jan 2026 16:58:57 -0600, David Lechner wrote:

> Replace casting with long to IS_ERR_VALUE() macro to check for error
> return values from rate calculation functions. This is the recommended
> way to check the return value from clock rate functions.
> 
> 

Applied to u-boot/master, thanks!

[1/1] clk: mtk: use IS_ERR_VALUE() to check rate return values
      commit: 80cb8a0e895d5ec835dda0ebaf14e293b4039c60
-- 
Tom


