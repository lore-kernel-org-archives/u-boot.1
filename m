Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8246FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0934A80548;
	Mon, 24 Mar 2025 15:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ShQE401B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B01805C3; Mon, 24 Mar 2025 15:48:11 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A2B801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so2717152f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742827688; x=1743432488;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jxs9ksOT53+sIajJgyEcx5y0wMgYzaCjvdNj3+4oKb0=;
 b=ShQE401BTT1oR2SgFCQ27URpm1+lpeX7mFzHLoiTbxgFDvAA9cItTHUFf4FsasuQjK
 EgxrXL9HuA+Yv27otGVsZLz4Ku2JIV8G4TzWeo7f8+yt5LQHdQcXvWycWiT5roxV/JBG
 BIu0RC8YMeVD6r/456oezoxRyRQe0rB9ANB0j69VaSbB4BrfgXGbpG7z1ZG3XNtagyD9
 2yuz4bDBV7gdOWl19iblL7WpX4Xmohy4TWfQYh0zndowb0dshHXlEjhUrUS9aaSSWxzV
 avLlIeTSyI4kOmzmAQglWHnrxnbWDWx9nWm3risu92u3q4DpqYeRKdJaa4aeWtvbW1CX
 bMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742827688; x=1743432488;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jxs9ksOT53+sIajJgyEcx5y0wMgYzaCjvdNj3+4oKb0=;
 b=D/PY89HbgHvKM9jt8EQCkChIPk4OUOIB+uY8DueEnj8YoTqVH9qM9h/q7dfySdxa0m
 XFFDXBLewQ4uULUHkhVuabWL25bbOmjRhGR9pQ4VPw+TjLvRIO1vkg+M1iP9U/o2CTYH
 QAKaLIC7yWN6mhwpuOxC6Bsq4alK6j6Yzu71uZL5Aywaze0h+alNMBwgIFACvau9RORw
 Uj7y9DwvwxKEiw8mn8aHrI22vRpwVyFAqJxCgV/VZIvrI+FpTGDfnt94HK3ZLBwivcwT
 ryx/r0wnhxCNF8VjmKGT5BUomFrd6BgpqIJQcnbFuFHRy0feGevs58+4PA9PVBX6chjB
 eSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzjnyNaP3A5Tv5iWziSp5TPsUHTqSKByuBwG7hqFgT88eQtE2x4HuDmYx3VRTRIxw+eLaVjYo=@lists.denx.de
X-Gm-Message-State: AOJu0YwaKvrdT3IVtX6YWVOomRzBcEDHCnj4cm/DLl5y0X5XQUZ38apw
 N+2vdZzkN3xaon38DOp15fu2Y7SV+2NwmhccM1oTeGAS9HkOB0O4GS16Fg+nLzw=
X-Gm-Gg: ASbGnctX0E5xB8l6WkB3dOhT36ZIhg6pMFgleLoeWtqOzc32fE3LoXMnJ1ooUpcPEga
 7Kxhc3vxlflKNj+XS1RFIDGyDiB7PD+9on6MoY4R+WKT6hrrnu223LW2OmZCAKTabYTA9VfD9c9
 HZKn0TU7HkwpWo6d66W2184WTN6e5FwbdmNRmuh/h9U9ETvPk9167cjPKU+0j30mY1ppFQZQQrk
 yUL1CWDgHu2i/+58t1zsedEi5M0xj0fmt1ez4HroNknZLDo91rXvnGTjVIuFnhtSLkhh2dfVwt2
 Z6kBbRACMDpp+U/AZYnaU/2E4SrDg8dZiRXLZyI6egE7vFO7nhlTEG8=
X-Google-Smtp-Source: AGHT+IF+9u52o122e9wmvWr4q/9wcHDcl472pWMfjzgiMz7godgsWA4YmD28efIYP0mmVU1CUKa4Xw==
X-Received: by 2002:a05:6000:418a:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-3997f94de0dmr8769791f8f.41.1742827687770; 
 Mon, 24 Mar 2025 07:48:07 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995778sm11245772f8f.11.2025.03.24.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:48:07 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix excepts/expects typo
In-Reply-To: <20250324143956.91791-1-marex@denx.de>
References: <20250324143956.91791-1-marex@denx.de>
Date: Mon, 24 Mar 2025 15:48:06 +0100
Message-ID: <87h63ieb89.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.

On lun., mars 24, 2025 at 15:39, Marek Vasut <marex@denx.de> wrote:

> Fix the excepts typo to expects , no functional change.
>
> Fixes: 0916053ebc56 ("usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/dwc3/gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>

[...]

> -- 
> 2.47.2
