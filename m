Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD8CC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 09:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D852688452;
	Wed, 26 Jun 2024 11:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zadloZWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B57988452; Wed, 26 Jun 2024 11:43:56 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83218884DD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 11:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4247f36f689so45026525e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719395031; x=1719999831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKN1p1pamJhVTARy7UdKn6sH7uxhDkWsOL5N+6QzpG8=;
 b=zadloZWbRWwuRGtqZBYKrk/Yo+Jd1x5TTRlXUDeX11SptgQdjTxAZcQ/R0LMKKi2Z1
 iDEAsb3c14ywPIChlY1V7WDWsGK0RSzW2cGngn1a3CR5QNjNm0RNIoS6HVUAlTnXRlXj
 g3VCP37+B1TsWQWDqD1it98yt5mqlFZhhxhdZJNH3shRJZdNBRs0lQnwkUtJgcODHBAP
 Wh6NW6ptQo1ZSPpgb6BZGFxpAJS9OQMaSHrkT8RFC6MTYnV79Bg3mxS8Q7jA+IevHLkV
 r/v6WQc4ds9eoyZ9Dit9FLohzhpYPT2uLpgZuUqYKfvHlcs7A+bugWIPW0+Qr4fzAFGK
 S2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719395031; x=1719999831;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKN1p1pamJhVTARy7UdKn6sH7uxhDkWsOL5N+6QzpG8=;
 b=k//pmxWDlXvcjMMYFg3UNcHmDYkks4zuYZjgTO9+3ZeJETi0BqogGO+bGFNkA6qF9C
 14yiQJ8eKKz8chLgVFCpm9ZNrCW2bwyKWNDrPfuEx/nR2hhuq9kaOj3+a3GWerZUhmcM
 StSVmv0lazvL+BqkRWtPXpPhZd5Cv7IOXLms/nLPrgA6FgQtToAa2jCX4smtADtcmja1
 t7Hi2oWf5QRqMgb7Z0M8qjlcy+49duTIXgJ03bpXzVEZItQlrF6IgiosVXUOyYis+I4/
 m2+F4N8W/Q1bzS2Y9yeEejFyDKWfMDOqMK0pfBXnA8fJlBFj6vPBH8jkJ2gposal6blm
 PTFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhbrJu6f6JAPQ3UUOdpP9+ZFgq6CWAOU4YrVft3Xj4oyn1l9OLFS2oE3MmwlO6b13ET4jPOBxS1TA/sXbTLj/yg21aYA==
X-Gm-Message-State: AOJu0YxibFeUDNjo4IpHyeULpjpHCcQvRi5ZlQ2tPFnUmeQBIloJqv9X
 4LAj4ZdiyhfJaPevVwPVZHWFnKICcn/r9/+YjIGGd+LCMPbw0IENhNbzkMUiS+8=
X-Google-Smtp-Source: AGHT+IFLpNAmCIyiFsgMIXhxvp9bsVR0CgEPv4Ds8KG+cQyjGgV2OcXFpbYDUbYUy9kIQrEJEmM97g==
X-Received: by 2002:a05:600c:56cc:b0:421:7bed:5274 with SMTP id
 5b1f17b1804b1-4248b95d0edmr84554065e9.10.1719395030498; 
 Wed, 26 Jun 2024 02:43:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 02:43:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and
 other cleanup
Message-Id: <171939502981.2754394.12351884665745788367.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:49 +0200
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

Hi,

On Thu, 20 Jun 2024 09:42:49 +0200, Neil Armstrong wrote:
> Switch to set_mode callback now it's available and in the same
> time make public functions static and drop useless mach-meson
> headers that are no more needed.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/5] phy: meson-gxl-usb2: add set_mode callback
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e7265f62aa6bf20c9011d0848926d6206fdf7d51
[2/5] usb: dwc3: meson-gxl: switch to generic_phy_set_mode
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8c58c35048cb47a999c050aad9c6c9785fc5870e
[3/5] phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/affb461d9aa235d12075fbd943cb11e481ada79d
[4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/98ce6d3e322c428f37e75956d316fb76479472ea
[5/5] usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/93b6a52f5a9754e3077c31590a7d5fcc2858d415

-- 
Neil

