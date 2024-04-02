Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EABC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4143A88368;
	Tue,  2 Apr 2024 11:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RFp8BLfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1984488371; Tue,  2 Apr 2024 11:13:12 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75AB87FDA
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4156684ee9cso11508405e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712049189; x=1712653989;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Uw+qvJBjC2PuojwknkedUS1Mu2KvbMFfAD6h3uC0dg=;
 b=RFp8BLfnRWZlsKht40Sl8H15yD4SIqt+lzKMo+NeXRv2D+R/cTiSbedd1ACiGzKSsK
 chtKAyLPeRvc+qdndt6XWXInDdHqNiVx8Y2W3d82ZcD9ISPycyc0cSpNIW44pvS7uNFI
 hVUdxalkbqFQfCz8TP1kCOYulEw9Q5UnHPHJ5o51me1DaQQE5IwtQG4zISMs2/juX8D6
 gqniRi5mIpAeuG6gJaS+SEu4F6GHXXfGijG+akAm3KiD1YJML4gfi7MsIwj3r7f4GH8O
 wSRJk4wM1Kj4qFF1g0aeaBiC+w30oE424twEJtF2Lb/+7KqMvE2KGb8Uh4Nh2x2WJTc8
 Czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712049189; x=1712653989;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Uw+qvJBjC2PuojwknkedUS1Mu2KvbMFfAD6h3uC0dg=;
 b=SC92gfOus/djNbMsqE+dOJC6RBzodTF/ZNhFtUGVbJ01k+LARCU+E937rcoDo2uaaL
 hknI4OYALTLjKnVV69xASyPd8IxQ7Zv3xsr7oQo6eiE5k7oh1LH0Ksjzxf4RfrnnhEeW
 brFRethO4uhomY9XxzXcKL4As1h7xlqBY0bmKE9FYPMB68k1tKP0KcQatQbMmfFBZg4Z
 iE7oqRHqVJGYcI35Kozssln5UXrKV7HmkzfYlWiitLU0GUTk/zZpjlDI5P1tHucgzBA+
 efMefxN+c5FOSo9nxbvTicbNACIPV5OvDwDkY36uBZa4NKYtaoG2t2KDCcUGMPX6yuF4
 OwVA==
X-Gm-Message-State: AOJu0YyFVLYRK0zjTknnhRL9CExZnUHViil/AYAolvwGYHn2d7vYc64N
 Suh4hfGnD5GkED0yGMnxhmse2q9IS908hHWtNFc1qWq4JjfoxWyagdGaRcgLaNc=
X-Google-Smtp-Source: AGHT+IFLniX6mDWQOhSU2QxViRODw0N1qE+pEOZ30cqqlOqEePa1iYs4QrtNMD+DgcfuoZ/9Y76reg==
X-Received: by 2002:a05:600c:3ac5:b0:415:68c1:5899 with SMTP id
 d5-20020a05600c3ac500b0041568c15899mr2963059wms.26.1712049189279; 
 Tue, 02 Apr 2024 02:13:09 -0700 (PDT)
Received: from [192.168.2.43] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a05600c3ba600b00415509b11c3sm13419996wms.22.2024.04.02.02.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 02:13:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Angus Ainslie <angus@akkea.ca>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 kernel@puri.sm
In-Reply-To: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Message-Id: <171204918804.88969.5638551486198110201.b4-ty@baylibre.com>
Date: Tue, 02 Apr 2024 11:13:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

On Sun, 17 Mar 2024 05:42:52 +0100, Marek Vasut wrote:
> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
> this into DWC3 driver. The OMAP implementation is special, add new weak
> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
> handling should be called, and override it in OMAP DWC3 code, to repair
> the special OMAP interrupt handling code until OMAP gets switched over
> to DM UDC proper.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4d158980897085a5b0255ab910208d8afc8522dc
[2/2] usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt into dm_usb_gadget_handle_interrupts
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/12ac51cdb788b9f8e50cbc4fa3681102882ade33

--
Mattijs
