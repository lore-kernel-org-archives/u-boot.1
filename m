Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93546C3601E
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D463C82075;
	Thu,  3 Apr 2025 16:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZZzECX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871CD820E8; Thu,  3 Apr 2025 16:17:59 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F75082012
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30613802a6bso9524161fa.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743689877; x=1744294677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FToQjvVGhR55oC5dnRx1pbudTnU8Pw7mZCfn/DzqoSY=;
 b=SZZzECX0heYW7+g7ANNSB6+cWK/tSHFqavWqteYA5SMNTHHjy2hp355et8XiVE3gSO
 uzHFgz/Y/BEZ9S+nLMj8ohZiPDkDg9nh0GxqaNA01XF3ZdSgKM9Rg/yqJp5Nlvv5j/Hh
 mRqHOwIFEQ1AfMshCudMruBpM53l82bTakthe40Q9mn3j43px0hKtgJy9zjsrMl8iW1S
 S7JbmihQKe6+uSa3KpTUM72AXAs5x6C80B9/sSOEipqIj/vblS33E1oxK7dCRBcnibhj
 Iewx9BN5ZMBKQq/J7y5V8Mnh+xRPAvtSDjPjXImrd56+LANhaMmJHW3yJjFl9Av4Dp83
 3N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743689877; x=1744294677;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FToQjvVGhR55oC5dnRx1pbudTnU8Pw7mZCfn/DzqoSY=;
 b=g37NQYLfytxtQRnVbBCSa3LIyFGUWie/JQ4vz/R0R5skJQh1HMIMFsUMc0E6CyHiXH
 np30p3ydKRL7/7hItZmBgfoh0NGxrFl41VU3nCAqJlxUysjE6s88LvMCSUYVrygIekVK
 f2Z4BMRdyTAOg0UPV54Ge5E22NHoBChV+t1MZPAD6jKo0cr+tLBtEjf0IAirI9KshNJn
 fXqpAmYjnnpruXSuJn8g6z12fI8T6mexnaOAM9lP5meDj4XSXU5BsnLYdZYLjsP/KCuh
 l51sKzkzO3VV/zjnTzZ0ZFfh3JOZL6cFkM5kcnDsy8qGfVLo1tmXJ6AQpKQzNWsKze8F
 vvOg==
X-Gm-Message-State: AOJu0YyyFkBDEyb3c58phCZ+v83RQUhiM8J5URxmLoh9kCrgcd+pvD+n
 yqP5rQ+HKszPDdZoiNQXe1VW4jjA1EftC47VWd4pgTCUz+kbP/LIkgy5q8RGoBEuuzYwejmMdBX
 vi0ekYM21EC19cv0D01hceKfRDrw=
X-Gm-Gg: ASbGncsy1G/waRwwC60FZxD9z2zzmt2GxUtzoCGfIVxGJV8zBlllM2mG06IhJ429+bT
 oztmgRADVEbW+k839+nbopIvLd7qkEkgiqyx79DZ3L2Yl073Kg2BXu8v8Q5fpuEFss1PT6WlPYu
 fUz+OX9oc4aoOsugdR+zXbuRIRcgWP1ULcMVth5w05kfccYfzZkjUrtjku0w==
X-Google-Smtp-Source: AGHT+IFzuAs3ljWbAxySaLYd3Fnzdk8pBLfQDut5pekbKS0g7hWtxR4nA5ZmF66KWIHjUNRTPAGJGk4VGWkskhBSVl0=
X-Received: by 2002:a05:651c:1584:b0:30c:d32:aba8 with SMTP id
 38308e7fff4ca-30f02175bccmr10545421fa.30.1743689876419; Thu, 03 Apr 2025
 07:17:56 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Apr 2025 11:17:44 -0300
X-Gm-Features: AQ5f1Jr3XptkEOBiV540byUDt9ZcqHoYhr_mrPq7PEvS66-5ZK1i3agqbBwA0gg
Message-ID: <CAOMZO5CYsDA3fqdt9UZVFmcTttB4q-_=X5vqQocDpn2-ORSikQ@mail.gmail.com>
Subject: sama5d27: Replacing at91bootstrap with U-Boot SPL
To: eugen.hristev@linaro.org
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alexander Dahl <ada@thorsis.com>,
 admin@hifiphile.com, artur@conclusive.pl
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

Hi,

Booting top of tree U-Boot from the SD card on a sama5d27_wlsom1_ek
board works when  AT91 Bootstrap is used.

Now, I want to replace AT91 Bootstrap with U-Boot SPL.

I copied spl/boot.bin to the VFAT partition of the SD card, and I only
got this storm of the following messages:

Could not initialize timer (err -96)

Could not initialize timer (err -96)

Could not initialize timer (err -96)

Could not initialize timer (err -96)

Could not initialize timer (err -96)

Would you happen to have any suggestions on how to fix this error and
boot sama5d27 using U-Boot SPL?

Thanks,

Fabio Estevam
