Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A378DC52D70
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0086F88A43;
	Tue,  6 Aug 2024 14:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1VGkF3s0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B3B88A27; Tue,  6 Aug 2024 14:59:27 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B162F88A05
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so296798f8f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722949160; x=1723553960;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcczTmF1gubIAa235CuSuVySuy4XsQ46UQppBMztWlY=;
 b=1VGkF3s046jqQk376YBCrIOpGRruJOfAbyViMF7Hbx2+oHQ/5+wBv5r79YZySyXzeH
 F/ik1fsTdP1gDRToSfXSB05abEPUxg+2rshBwnqGwsPVCuE3NS+C4fkOGhsBJC9xUNu/
 T1nObiaZMvS+lJXIPZzZK8SZcpB2Ot3R0dGJ/qvhML9+y8Q98XsagSOZCoOQcPcZk9JW
 /gs/z+Obr89tuvmwpn+1bZvTP0aycemD26UsAlJGtejGwJrnaSg+WjJ8p5IKlY41GJeN
 j1WplyM26Pqr7dYktakREWcX2Xpl3mpmV5QHamigo0IlESYKBrppTuwCKT7vDYnT8SvA
 vsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949160; x=1723553960;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcczTmF1gubIAa235CuSuVySuy4XsQ46UQppBMztWlY=;
 b=eR/FIt1PKiJaYimS2dMgumdpdgGVXgiduneRAOD7fjheUkjFXWkphjbnCa0WISOTFb
 S9rYGEYC6Z940xmUd7wIkMdykTo5FWRBZD+pr1slGo7s60OjMqvTIv29EYt9Kf1C3NMh
 coe5JiqvlRzFP+CJZ5ox+UPWaq5WtSW8UN/ecVRAebSTlSvlUuHzph3jRsdatf96TQRM
 /Gw5q8ydoSyFW5ERLOR5yJplVy1Bb/3LQgsEGDbHQ9dXnAb+0Ym6lXrXlkyZGkuMRo9A
 KrAHVlcXv4PS9w7tEzJhoJXKly7bW9fxli8N0zdP7+Fok00YLQid1ZHYCdPOjE2swf3w
 MRmw==
X-Gm-Message-State: AOJu0YxZMieey9TlVn8JDK/1NplrfVkto4QO9EMWYTmLNK3WEvTTTUne
 ndfs4sg5y2+2CjGDa7E0oqfuPVKeY4BaidgRTa7u45z73NdaxlV1BKT72cxt54Q=
X-Google-Smtp-Source: AGHT+IHBUIJcP5H2v+ta5zLIoj+jBoSQPRujbBkAuOlavCL/IjTCvSnw9dantJ+K6ELiVmmkk39W3w==
X-Received: by 2002:a05:6000:1faf:b0:368:d0d:a5d6 with SMTP id
 ffacd0b85a97d-36bbc1beb75mr10317873f8f.50.1722949159875; 
 Tue, 06 Aug 2024 05:59:19 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1dc90sm12782529f8f.25.2024.08.06.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
References: <20240725153204.358925-1-admin@hifiphile.com>
Subject: Re: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and
 DM_USB_GADGET support
Message-Id: <172294915875.40327.6325892052107416270.b4-ty@baylibre.com>
Date: Tue, 06 Aug 2024 14:59:18 +0200
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

On Thu, 25 Jul 2024 17:31:54 +0200, Zixun LI wrote:
> Changes in v4:
> - Release clocks if probe failed
> - Add missing endpoint data free
> - Addressed comments
> 
> Changes in v3:
> - Separate code refactor into individual commits
> - Extract the controller point from udevice private data in DM functions
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/7] usb: gadget: atmel: Sort includes
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9cfee49022e2f22ca7074d423bd23a610ed652f4
[2/7] usb: gadget: atmel: Replace printf() and pr_err() by log_err()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9ec3b70b21d9f825a4dedbf609cf76ffe37deb55
[3/7] usb: gadget: atmel: Fix typo in usb gadget driver register and unregister
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbbacf19d6310b5b255662ad87c07eb34b73d39d
[4/7] usb: gadget: atmel: Move usba_udc_pdata() with other static functions
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9b97a354bdc0afc788b9e99ceb9d03a696e5f749
[5/7] usb: gadget: atmel: Rename atmel_usba_start()/_stop() to usba_udc_enable()/_disable()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7a448c8f384022a2585e8439c2a182ada3e4aab2
[6/7] usb: gadget: atmel: Add attach/detach support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ef5e1d1f97623f8c549c6fffd481bb120df12dcb
[7/7] usb: gadget: atmel: Add DM_USB_GADGET support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d6376f7ed823569acd8bb0fdfa501c040cfec36f

--
Mattijs
