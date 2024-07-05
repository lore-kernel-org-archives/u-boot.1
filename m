Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BFBC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB69288986;
	Fri,  5 Jul 2024 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EpKp6Whw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E988896C; Fri,  5 Jul 2024 14:10:48 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B211E88992
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so1695833f8f.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720181446; x=1720786246;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlIN2N0/d+JyUoXEs72mS4z1JC8oJzEDH37yxTgPgrE=;
 b=EpKp6WhwrUfCoBFqqofGNx7S49j8qjUVROgveRSp6zerSdFKtyFodBMYSO0G6ilVG5
 /Vm58gy6SgJYJxttrt7XY8XWERb7fQ+7u8ZCNb+BCLmgpuNg/1BpsMWunnb0xIacVHS3
 vQfcHsUiPG/o30hI//qk59h2DoH08ovxrL0aerh6hXkqHoueFfsvJZUBSc5iynxgREDN
 NesJ8yH6zhYuNfFZZ3ZtgqzxIBRfZjmGgKM2hkOzRd2as2IE9CbeONURk0OSsN4weNcl
 aDD6oWe52onfj68lmTdS65xVeP9YxV6WUJsUVX508Z4lwPgX3rXUhXtJvwR7cyT4R3IK
 RZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720181446; x=1720786246;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlIN2N0/d+JyUoXEs72mS4z1JC8oJzEDH37yxTgPgrE=;
 b=Invz/XjMDCPXswN3uGpznilhHcF8tZD7+rphi4ixptJomVxqMO20dsB8pE3qFvqZLx
 9FgjivAM7KmhzEMHBBWvPRwVoEXFem32YBTmEVE5u+0sUEx8n3r4SFXhDNFuXvnkmU1C
 qm72YwN76QXuYlz+kveZItcuBaOd1PHlA7+giOKJcpZdfyxfjFfCQ8FsqVqG4ZIIs1RL
 P6k6Aka9toQ0J3VqCBtBqHraFeQGQG7tJ1551PUVMH89d80EYulEOY9Tov0sB1eaUDnp
 reM8003rYb1iEdx+rMDw5JG3TWK2FjrWkfkCreYybHSSBKmT/LRD4oHfjJtr4zhww+28
 /l+A==
X-Gm-Message-State: AOJu0YzR8xer3Cgc6lY1EZAFzgdlcckweKva45hNiZxrn6aS51rwM7qv
 DmsNSw+B1y41e7AM1b52aXagQ4vjP15gchTehPktt1rFerVkjQZ7tIpq6wDbokIGNDo3fJKo4BZ
 B
X-Google-Smtp-Source: AGHT+IFta6ZasWeYgD0hQ5DriE2PI3T2VfIL6OOWNfx5D4SO45nQkUtCV0fgfqQCFig1bOAJwTqPXw==
X-Received: by 2002:adf:ef89:0:b0:367:9268:bfca with SMTP id
 ffacd0b85a97d-3679f75c4famr3991869f8f.22.1720181445697; 
 Fri, 05 Jul 2024 05:10:45 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21d2adsm59275785e9.29.2024.07.05.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 05:10:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Lukasz Majewski <lukma@denx.de>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
Message-Id: <172018144450.2142299.9049881669126268493.b4-ty@baylibre.com>
Date: Fri, 05 Jul 2024 14:10:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Fri, 14 Jun 2024 02:51:15 +0200, Marek Vasut wrote:
> Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
> .handle_interrupts which must be implemented by DM capable USB gadget
> controller drivers and must implement interrupt handling similar to
> dm_usb_gadget_handle_interrupts(). For DM USB gadget drivers this is
> a replacement for dm_usb_gadget_handle_interrupts(). Convert the DM
> USB gadget drivers to this new ops instead.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[01/11] usb: gadget: Introduce handle_interrupts ops to USB_GADGET_GENERIC uclass
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d36ef5cbedd08e9a11c6a719d853f1003173133e
[02/11] usb: gadget: cdns3: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/356542d6dd72f66031bc0fbe174a99c360ee318a
[03/11] usb: gadget: dwc2: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2329109fbd7e48c559594c089238dc57d7fea166
[04/11] usb: gadget: dwc3: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/75f94ed82ff0a8c021decaa9a0eda56d48cba716
[05/11] usb: gadget: max3420: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a75753327399d821ba70d8cb493d1bc12d1034cc
[06/11] usb: gadget: mtu3: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2c2d7c2bab0ec6e4cd93db242822a57986680917
[07/11] usb: gadget: omap2430: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/521bc756cb5fea0ca8c159bd812da063e08bd351
[08/11] usb: gadget: musb: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/281eaf1ed83a09bfce6b82b86775e11d4269ad08
[09/11] usb: gadget: ux500: Convert interrupt handling to usb_gadget_generic_ops
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ac4bf5d48a9e85e79ced3b7195a8599c21c0a16d
[10/11] usb: gadget: sandbox: Drop dm_usb_gadget_handle_interrupts()
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ed8e638de1ef0ab2bf87c6c83882b275b66b292f
[11/11] usb: gadget: Mark dm_usb_gadget_handle_interrupts as non-weak for DM_USB_GADGET
        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9e2c14804e4aaefe7cbb43d444f5dc83ba76c86d

--
Mattijs
