Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E340C71150
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07EF82A0A;
	Sun, 15 Jun 2025 12:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KyEm8nBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779DF82B00; Sun, 15 Jun 2025 12:49:33 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950DD80C83
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso702696966b.1
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749984571; x=1750589371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FAsJl48odKa1mXmIaQuDrM/0AWpF8NEuRj0GtOBfCMA=;
 b=KyEm8nBqnZJLjmUpK+gBVGLw9vMtIM1ZGJu5qO//09l+ZFr7maKWGnmb+4YP7DAP/c
 2jOnO9OFznOCC6/HIfFLxep2G7AL/23j/RJ/uqqOmYqoMwyMFEtfB3d0cnJrxxWtvQkJ
 UAPclTxgg9rKpH1HzOZLEIaBR1yuLdzid+vQWGT9/efApbEnShtUcTDF3JHXuwr0IGXq
 3yhDdCbYmJ4trbObKInJ2O82tjuPGwN0dfzGUxHxY/Pzm05mi6+bx6ZypTTMfBOwfEBd
 jd4uPzYOKintl3xHhKvm6P6Gd8T2zPLPiGfDJmtv+M7hhqA2SHhgDKc/cYS8kD5XJrM3
 m76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749984571; x=1750589371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAsJl48odKa1mXmIaQuDrM/0AWpF8NEuRj0GtOBfCMA=;
 b=Kjs9xBNIvmu9On0RFrgsQWqeBJxmCm91B8mmea/iwZzc0KDrWDHFx9nQIhHvVzx5UZ
 5emgKDPqt07fVZveyWsq1/azi/Xl/ciyYULQ6ER7+FVSPCYExq9dR9+D+GydIFC3WGa8
 VRpMuDn3L1qpA0O+x5u6Z3ZW3xScPTVlUhKlVJmjgZ1iqPC+4kLNSfRHGsWVZNPsP68M
 zeMr56CpjnpcBjm01Rgp9tME2BeSKJS/iS3XgUsxd7427wt93hkvm2ZdYa/sbIS/xlpN
 Yy+RjrsJqBMkyuw89rh9N3fG0cpyUtnunZOAriKPAZ7tOnQxCbtekjNI0vWVSGLTNuni
 VN4w==
X-Gm-Message-State: AOJu0Yx423E8hkqmuORzkLZnCNy8ldRf8oaspYyaIdb8gKmNUkvefWB5
 ul9nF2xqjnbCP0UqTDNTyzM0B6wQljXwdA6AqZ0DzTtPRdVUMRGq931pBiiE+3rIAGppmyqO2eA
 ei/LvihhIoVxxr+L3mtgoOkCwU0USN1Cp6Q==
X-Gm-Gg: ASbGncv3AVhC2CwwuDyk0ZGxnEuuSHwnhUFlAVUheceQwoVQ2l/vDMGn1YWxpMX8SEK
 jjOhpALqB7B+gw80akkGoAej0RGBWWNj5RJ4oCgigcYEBYGgQsfeUhZJEti4G6s8pdBgNn26uSC
 z/KcPnOvBvzj73u6uAD0ray/sMEdb/ETuzpl/5FcQzs1CGc3oKHW5c+Hf1gBkuWFufM2Ne6sLbJ
 EMB
X-Google-Smtp-Source: AGHT+IEE1htFxr0IcNzOTFqiZAundT7Mj7HpCPYKsewroYKokyrhLOACauaIKpfJDFvaLE4jouR68NDM4f8VZJy4Dr4=
X-Received: by 2002:a17:907:7ba0:b0:ad8:9ff4:c02f with SMTP id
 a640c23a62f3a-adfad35906dmr528139466b.19.1749984570862; Sun, 15 Jun 2025
 03:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <DB9P189MB1612ABFDB8BF170AB1D64CA7D0A72@DB9P189MB1612.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P189MB1612ABFDB8BF170AB1D64CA7D0A72@DB9P189MB1612.EURP189.PROD.OUTLOOK.COM>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 11:49:19 +0100
X-Gm-Features: AX0GCFtpT3jDDwvYOhYsBSV68CkAm4nsrTVrf0FTWAIrIQVNjL_q9bk2cxN3pI0
Message-ID: <CALeDE9N6WM4hkrx0Xk1oSa6kQn=63XvsDQ_8WFpq4KjDDaEXkA@mail.gmail.com>
Subject: Re: Rpi5 usb boot support
To: ludovic wittlin <ludovicw35@hotmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

> What is the status of usb boot for Raspberry Pi 5 platform ?
> It's the last thing we need to use u-boot on Rpi5.

Nobody has done work to support the RP1 chip which contains the USB HW as yet.
