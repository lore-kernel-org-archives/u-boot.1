Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064ECD3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9F989A40;
	Tue, 26 Nov 2024 09:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r1X/oHcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188D989963; Tue, 26 Nov 2024 09:57:27 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D3389AAA
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4349fb56260so15738785e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732611442; x=1733216242;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTRJmrA5FM2AFKjUtccyX3MGY9NpBqcGMiWh1R4BFWw=;
 b=r1X/oHcWcOcwr+JZYlq2xkaWOn6xi+2DtVAOxLNNBmzXzFlbiRWnbz+4S1VEKeEOTn
 3cxcjrRQeZQSt2vF+D4tG0jjpVfw5X+T5mQaBWWT6yJuVxA4D7iAjhboEFt4up4IxXDn
 8BTDnM+cSkwuDdn4r910zSSLsgjfoClTkfUJnriJI2LcimoCRt6Dm+kD4bBJsBrWPayw
 xpXUZaEbCNQf4hOFXYCUHjlrEbdu6lqmT4DxWKFuSYltZ/DtqVp5uSh8ASTY3dCwj7qx
 wnCQSKjlfVa3BGdPXCyHOk9psrThh09dBkLLZXpYU0K2Ip4gMDWQs/uzhQpX/uaAFyIK
 SnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732611442; x=1733216242;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTRJmrA5FM2AFKjUtccyX3MGY9NpBqcGMiWh1R4BFWw=;
 b=wrhap2FqmyxF5ROi/QVQvVMR1YSLQ8kZn3bB/JcaplpnuwzBsy/NJxdGzL4gx8DiKg
 K8O8poy+KgrUxzltNIsXdXbU8L9P7PuiY4xpJHNTj5JQDuSnyvK4kYq0CGSGzG/A6bwX
 lqCthZMK8xOY4kI/8Y37qHq/6trx7L2CpqiALrbTj4IexhGTrlHWI8Kt/xqNo7rI00S7
 uHNAw7SJZY4n5xhAbTZ0QaHrIPUA21emGs/zi+MqTDXmmzEkoN/Qflcs9YBLBrJ5fEjH
 me+fiGqg16LjIfS8+9MWLmFbvw2cmSgtEl0mQRy0+ZSU7HrcWbZlOBGK6I+AemOdCGUR
 SU/g==
X-Gm-Message-State: AOJu0YwrTnyrEVhjkULcrwM6VeuWyoM9VTr/s+iyRivGTXHdJ0pvZ8NF
 ut+Cz8iy1IeCn7KugZrHMwGIkZasuJ1odQLDUdk1b32a+YnvHU2G4GNHlNRrFU4=
X-Gm-Gg: ASbGncvLjU47iibl4PPB5IzYYt4jRIbpyEJ3Dud5EAaCZs12n+777dUcvCCcih1DVIV
 AopDuI6GBp//Z3lNuEoEiUAHFA5rY2G23NjjRMb6U2MtrHD8VD/hkatq7fPguzf/37jgVUAyko7
 LrVAE1Lk6BLs3mDxvBKLsLthN6HwnxwjO4JBNcJUZYqFszD2SOASziRLR8q4kQmSvu1Pj9eLUUg
 8hwe73+CidiOfpI8Gxeaeik/YM3d4aLrrZGNkZsaqu2ivlQEg6mEom8Tl66pA==
X-Google-Smtp-Source: AGHT+IEg/5upWXZcL2eh6q5ZA7/XOpIQ//5Nv1eATIZrPLkE7td0TW9KUemsqz+TbXU5WxYY2kD+HQ==
X-Received: by 2002:a05:600c:34cd:b0:434:9cf0:d23d with SMTP id
 5b1f17b1804b1-4349cf0d3c9mr66561375e9.25.1732611441774; 
 Tue, 26 Nov 2024 00:57:21 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a4faf750sm21502035e9.10.2024.11.26.00.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:57:21 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Holesch <simon@holesch.de>, 
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241126072956.64778-1-clamor95@gmail.com>
References: <20241126072956.64778-1-clamor95@gmail.com>
Subject: Re: [PATCH v2 0/1] Fix peripheral USB mode detection
Message-Id: <173261144067.10850.14519612599506948897.b4-ty@baylibre.com>
Date: Tue, 26 Nov 2024 09:57:20 +0100
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

On Tue, 26 Nov 2024 09:29:55 +0200, Svyatoslav Ryhel wrote:
> In the older USB controllers like for example in ChipIdea controller
> used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
> does not exist, so the new device address set during SET_ADDRESS
> can't be deferred by hardware, which causes the host to not recognize
> the device and give an error.
> 
> Instead store it until ep completes to apply the change into the hw
> register as Linux kernel does. This should fix regression on old and
> and be compatible with newer controllers.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: ci_udc: don't use "advance" feature when setting address
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/35d967f5a8219adc47628247a98c302b1870313e

--
Mattijs
