Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE84EC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 22:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F9080FB9;
	Mon, 10 Mar 2025 23:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gxvI0q1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7459B800D7; Mon, 10 Mar 2025 23:26:54 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC883807D9
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 23:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22355618fd9so87762625ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741645610; x=1742250410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZC5EbY61XmGDIGfILiUK/GQaI+EW30J4LROEz7K92UM=;
 b=gxvI0q1Z4S0O4kPxNFqLTOoGWqs9Atux+zUcQ0NBE/aZZGGUZYf5YnIP2mZMRiG9ZP
 3GHWMTt+MxWWngb6tedD/VTkTv5yfTrexAxBxrH9inTV3u0n1W7ekSnf7+pow0+Ns2Yt
 IkNQS7cr8WCDnPrXEAzKV1mfd+Zcg1rYIM6GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741645610; x=1742250410;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZC5EbY61XmGDIGfILiUK/GQaI+EW30J4LROEz7K92UM=;
 b=qAbhLjBVOknJ00YB1ZueauL2Y8X6xWkks2CgqsdGS5FbI3hKBH5FfbrtVz5ZjjiCCB
 +PH3AMA/SmoSujeoORNd+NNcvF3eQvioGj6mCCBN8vBUwnxJn47Rj6Or7/rqH16EVTvk
 8GlDD7yNWk5f5s+9yiNWh6GPoPlYp9Zidf3q/rD2rnSAuNrLbRWlWoW3LXIGT54oPz/r
 3LuLlD9WvkX5Z2izfp6uU2wIPxKHT12QGgSwb9Si1fxk3zw9FzjapQTlohLdXw7CBNoD
 4hVlkUDFb+zZZxsr24edPn0pTxvbmQKGqCtGVIeiJMPbaBIkZbkmY9PD+AhoFzFJr9ka
 3jPA==
X-Gm-Message-State: AOJu0YyXsuLGB09PQ15ExKk3vpb6Kxufs0tfLrBJfHDeXmV1lE6eZoNO
 +D9JFEsfIDsPKkOKQRetTdLj7teS9hqrFpZz+UOyUswmd2JiKsCtJn8n/kMQBVVmtjEqlp1cEJD
 0
X-Gm-Gg: ASbGncsWjs+EpMEJHZ9jEgGimI46akg5GagpdsZ5u0cMJYf3Htq6BajA4cGV5emJlBN
 Tnx659uz45+RrwMDMw10+XsJAky7u9ceNQDl6n/jNYPbH5FNmsv6BfzWM6rktC5u8LHLW1RHFHn
 8FJdnl7Kr4CZf4YhxmvaF4DvlEGxTbYhOnodb4Ec/1FlJLeb6YtkBn/U+heiho/PZas/3Ks8x8N
 FLHvd1evwzSv7+lGLO9IkykjhigfeTbyWfdV4jiUCDQd4VPnQksAsbHLKBNVbGADKieUpx4JUS9
 QkFPs8VdBm4j0vJNiNkWp74XSnlLcYKtm6Tc2hTyHeY8
X-Google-Smtp-Source: AGHT+IFO4JsM7ZjG4Fk3MM3956f3cwEUKwxeJrdPBiv/1AIIl53UW8Xaq3OR6OamsBRu4kTCTX07eg==
X-Received: by 2002:a05:6a00:4f91:b0:736:51ab:7ae1 with SMTP id
 d2e1a72fcca58-736eb85864fmr1703614b3a.16.1741645610530; 
 Mon, 10 Mar 2025 15:26:50 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a336010dsm8394138b3a.59.2025.03.10.15.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 15:26:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>
In-Reply-To: <87wmcx3rqn.fsf@baylibre.com>
References: <87wmcx3rqn.fsf@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20250310
Message-Id: <174164560952.390216.5670118124614269429.b4-ty@konsulko.com>
Date: Mon, 10 Mar 2025 16:26:49 -0600
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

On Mon, 10 Mar 2025 15:06:08 +0100, Mattijs Korpershoek wrote:

> Please find the following developments/cleanups for next:
> 
> Usb gadget:
> - Remove legacy CONFIG_USB_DEVICE
> - Remove legacy usbtty driver
> 
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25060
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


