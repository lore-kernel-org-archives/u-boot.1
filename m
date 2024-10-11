Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3DAD0D783
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 12:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C876892FD;
	Fri, 11 Oct 2024 14:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kV+fS8Ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5806D892F5; Fri, 11 Oct 2024 14:33:09 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25119892D3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53993564cb1so2460219e87.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728649986; x=1729254786;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBfvldiZ8QX2wgZZGzdxxENfG3m83nuiyFdmeQgYnhE=;
 b=kV+fS8Ky/aPbrtUNrTWLpU7f7pI9r3387VlkYkujpcud/bnfmvHez4NOs6S89EPADH
 w1NBRdoiiujIQRhuY9ZtrnOjIWImP065KSXKZYga/jADy8IaOJYz/LPE8COOwLOnA4vN
 leLxX0USqfzksR1MKcc2XrawjKF7TNaQPH2Ef/p7v5QP8LqeTyMPEtO8IANCvn2BpwAP
 tz4tcpHpZ9bXsDcFjsxxXhduTQ0vcKgrY/hUtbiVET47OFJ1z70wnzZc7STrn5kGnj+P
 spSKIFrW7f+yw1AKlwOHf+tdwAFZ+emvfp1UKIuzvz4iF+WzKbd6psuLb98tEYIbR/+3
 K36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649986; x=1729254786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBfvldiZ8QX2wgZZGzdxxENfG3m83nuiyFdmeQgYnhE=;
 b=NwHql09/f/d1UD6g/df+gomqAx4oyXPYrEd0O8drHKejnGLf0lKKD4DFEEV4Ulag8R
 Q33/MkNBdecbLX9yO+cqi2S2D9USuqVpIjOh9eJpYPIvhyiYpyPnONcVTwBDZ88moyKF
 5kXN4vFUxOHKC1ySsBe8Kagwlf5UOvrwRMjyHmIeDLIhApsXm03NSu/x//7arFqXENjc
 BvceaIehqghk0kRNqnZIKwIxkkudePsnfAnoS5rujTYPgtComchZOCVGpQBWrggwPpkK
 bVupg8KZaDimEaWZZeAQ2dMXmGvEqL8qXnEpfNLG3+MYNdbpukOoRzXY6jCqfuD6j0Qy
 M1yg==
X-Gm-Message-State: AOJu0Yxi2cAR+kbQd+WuYaIZnXDOPLwVVXJDklzoC9lMjXC2NVkWLGkA
 B1Tfo75lYmATJGe+fM0rWW7OrOslbPmmo/fkvDLIwwfiO74Eox/OB2gS06OOwEDIRoC3vz6JHLR
 u
X-Google-Smtp-Source: AGHT+IGFxPf1Z+VxzVlZL6fyuFhTgNOS1fDxASO9+scjxAe9XOZp+nPFDjUjDeSYcfxhdM88DzI9LA==
X-Received: by 2002:a05:6512:1113:b0:533:42ae:c985 with SMTP id
 2adb3069b0e04-539da3d603emr1535732e87.25.1728649986254; 
 Fri, 11 Oct 2024 05:33:06 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431183062b5sm40925315e9.26.2024.10.11.05.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 05:33:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: trini@konsulko.com, lukma@denx.de, marex@denx.de, rogerq@kernel.org, 
 vigneshr@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20241007121927.1680039-1-s-vadapalli@ti.com>
References: <20241007121927.1680039-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2] usb: gadget: cdns3: Fix cdns3_ep_config() by
 setting ep.maxpacket
Message-Id: <172864998471.10995.7784088919446282474.b4-ty@baylibre.com>
Date: Fri, 11 Oct 2024 14:33:04 +0200
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

On Mon, 07 Oct 2024 17:49:27 +0530, Siddharth Vadapalli wrote:
> The function cdns3_ep_config() calculates the maximum packet size based
> on the Endpoint Type and the Gadget Speed and stores it in the variable
> "max_packet_size". This value is then programmed in the USB Controller
> for the corresponding Endpoint. This may result in a mismatch between
> the maximum packet size programmed in the USB controller and the maximum
> packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
> basis of the maximum packet size stored in the "maxpacket" member of
> "struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
> with what the USB controller actually expects (max_packet_size).
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: cdns3: Fix cdns3_ep_config() by setting ep.maxpacket
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c54c72dec7948093b200ae1290575a1e9abbbb40

--
Mattijs
