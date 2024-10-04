Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB22CF8840
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D8588C98;
	Fri,  4 Oct 2024 19:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgYbqdCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E81988D03; Fri,  4 Oct 2024 19:15:27 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7223B88C4C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so16947106d6.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062124; x=1728666924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FwV4Arx62PD2LnGEFmYNMSYaDDs4kGBw4rRdkJUlAE=;
 b=hgYbqdCWgHn4BnU3M3hZ7LcIowC7QDl8YdcSZoJbIJJVLDaoQ4K+WXyKq5A35yGUBm
 7EVm7Mb6x5RQQUhJ0jVoQqkE/4Vu5MydS/bvIWXEgt1BdHP6ytvbkdqzBdJ3i3MxmovU
 w8JLakaJ5d5r7XS+fDQqjGee36bclGfCmkhYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062124; x=1728666924;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FwV4Arx62PD2LnGEFmYNMSYaDDs4kGBw4rRdkJUlAE=;
 b=qkThLRcNgyM5B/02QXCHvU8CsC5l6/EugppOq1rrmOdxI4h57DsgmQ1dVCDVjMVieH
 ewwACBcxEiShfW8DUJvdXQGbf1h+6Sry8VonLEBPrN5BEGEIBBH8X7dnHYFEzckpS+iq
 xbn2PpjPuxIFmA0TO9bE4IV741dEMwCkhdg/sd9DbO968Y1Ho+JMtBI8sddKqld3B4yk
 nFSXzUJ6X5PwJYkLwYatmMA4k03aJha4VBj9/Uz/CAK1KPgloCUPXj/cpxRnrr1ZMixp
 XhngmAmjIkX48r+UA/KqrPO5OqeLr+SfpZEhZBTNtKBdxqmlFFVgBhKh786FE+mNtz83
 FWcw==
X-Gm-Message-State: AOJu0YzGdgbV9hs3HsRss47n8fqtxZs1tJmD9tjTB92LAhsAmUNqhndD
 kM4w3L3iyc6YwU2t8CuR64pP2U7i16Y0Up2C9gIbh+rHuc8d3vME+L1g4K1UAw0=
X-Google-Smtp-Source: AGHT+IG3HcPxUy89VG+wfFTdFPpUDyQUVr47iahGAtLWHS1HYLROeHk+Fv7IrbOfKtlrUJjjwAjZ+A==
X-Received: by 2002:a05:6214:5d90:b0:6c7:c5cb:b70b with SMTP id
 6a1803df08f44-6cb9a306a36mr42420836d6.28.1728062124358; 
 Fri, 04 Oct 2024 10:15:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46df36esm986726d6.30.2024.10.04.10.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:15:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241004062136.491995-1-jonas@kwiboo.se>
References: <20241004062136.491995-1-jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: Provid SPL control over otp presence
Message-Id: <172806212346.2290501.15348023539691408921.b4-ty@konsulko.com>
Date: Fri, 04 Oct 2024 11:15:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 04 Oct 2024 06:21:34 +0000, Jonas Karlman wrote:

> The series "rockchip: Add efuse and otp support to more SoCs" [1],
> merged in v2023.04, refactored and extended the Rockchip efuse and otp
> driver to support reading eFUSE/OTP for all supported Rockchip SoCs.
> 
> Due to use of different licenses the drivers were never combined into a
> single driver, however anything non SoC specific should be applied to
> both drivers.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


