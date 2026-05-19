Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E59CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11558470B;
	Tue, 19 May 2026 15:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sXi0Z+7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05675846EC; Tue, 19 May 2026 15:35:11 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A39846EC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso3788795a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197707; x=1779802507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mnhU69Gc/tzkB7eM6chi8HtYiS31kPMpd8SL0soSflU=;
 b=sXi0Z+7pV/oRi8LwmqGrO39dMlKRz1GIfYi4wMkXN4qJatsICL7KhIW+sSxdZIFQm4
 XnL2G704THePNJdlRfFufpiQW/WsSL4kc3heHYVSjyumFedvX3cBfUqExPXeEVX/e3tr
 mgCTpWSggtgIi/pB0A1PzVzzQQvsEFrCVJRKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197707; x=1779802507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mnhU69Gc/tzkB7eM6chi8HtYiS31kPMpd8SL0soSflU=;
 b=Ap2xo9lWsj0lTZw7gFQ6uAjxXa+y/2ISdXCXfdmOcEYIa8loKgqjK8vLNfHwwT+K3R
 khSusEeAoVgM5yMHGS2f78VZXUUvjBe0Ft7z18ujZ07+duZL2Uqr6XPF/9zcmtAJKPW5
 qtvN6MrJPcOIyk/DjO6aQr6g2MDZRAdf1A8tVAJBATbAHMbISm7bSPcoQDIIXIidyPZd
 uzg2Ua5SyBvEv3qxY1vu3GezubfMB5Ca/dAw1PkYLhXnMGaGuds/XbZbZfOItfVGxTja
 b9hZaXPKxc7OWELScf92Zj1+05STVcpUJvEswhXd+6L5Y+70FuqwB9pJKZTeM6qsW82y
 Yxkw==
X-Gm-Message-State: AOJu0YxYz2fwwW7KU9zOooU5XMV/PiR+JaeKdTzaF5tIlAhekEisZp4t
 pth0xP53O/RpWSquUBFpxlafzFLINprIWHEdLTw0av3zsZ5oXDBaSlwDITBVKDN+j5iXe+LuWTt
 rHVxNAlxtIgeP
X-Gm-Gg: Acq92OGZx2um3Yo2AJTEVu5adBhlzqIOWzklt3lKLWDZVQhxoumvdQb8VajU6bQj5ra
 +427AOh0DaFXcNuGTNWSKXxzmAREVm8nnr+l4u/6w9wdROxP2PLX+OUvrcUJ98mTIfdHM18DVCh
 YTaetVBzVxIieqtXtlvIaCnw4FJ52FeJRjBmj5US0sYNCphIdifi5LaBKViYt2N3GBisPL50wOt
 j4WJKkXiLSBEIMEIyMjNzAhLsLRpYRn/vF1IQwtxdqmg2SaZHroyy18HvSZ6klMs/SO654XW4bW
 gtYCliF9WnZYVKySdK0sq/TuX9bA0DaO5alPm4u1Zd/epJJ4wZRPOJ4i7zNOQEpIJp7UuiMp3HD
 XUTvK/iWS+aqGkB/UFDwCoinKz57yn0zAc7Q5lmxvOnc0tjFG5t/z7RqRTPmgRiTW7vFqS9Wmb7
 j2/YpA0ZASxNl9oQ/IuxaGDyKMK4fbi8b+sf7r/NQqTMldRUNsVNnCLilTb4IkabXzcukBupZ2R
 jXtsW0hQKLRsxa+NWExg5RupCuTcIsBlH5MUVuVyK/4C01XIA==
X-Received: by 2002:a05:6830:82aa:b0:7d7:e844:7f4e with SMTP id
 46e09a7af769-7e4f2bd75c5mr13741620a34.22.1779197707359; 
 Tue, 19 May 2026 06:35:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] mailbox: apple: Staticize and constify driver ops
Message-Id: <177919770668.672258.14652507399084600853.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 08 May 2026 00:06:28 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/6] mailbox: apple: Staticize and constify driver ops
      commit: 499cb93dec85fbdff60c3a6c626db46caccc24e6
[2/6] mailbox: imx: Staticize and constify driver ops
      commit: 44f6ca49e9d3c1c7bc77139fbb3968afd587f891
[3/6] mailbox: k3-sec-proxy: Staticize and constify driver ops
      commit: b2961202a7a7bad23a470f7df3de2005786edccc
[4/6] mailbox: renesas: Staticize and constify driver ops
      commit: 85f4b086911c9a9601d703a06d91846f22ce3e33
[5/6] mailbox: sandbox: Staticize and constify driver ops
      commit: 0a1347f0a1d8660676668b5a58670dd5846cc5b6
[6/6] mailbox: stm32-ipcc: Staticize and constify driver ops
      commit: e253640e3ffa9dff8a0b5c3f8735039552fba5e9
-- 
Tom


