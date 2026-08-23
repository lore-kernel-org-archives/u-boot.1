Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C39C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA7846061B;
	Sun, 23 Aug 2026 19:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVONd_WgTlSA; Sun, 23 Aug 2026 19:39:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787513962;
	bh=1KMIiWoNyQ5/p47WDeEK475UPvmxZRv6UuOjnCzPmZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CiozqeE1/nMXdU9p6jpHAlN6ppC03pkTy8qHqDeg0dQ0+5odZ1pQNUzueAGfGovuk
	 t/MzpnrgMMo5Hxf8vzALc6hridNFBq5Mu7o11mnf+S4pmnWdv19kR8ZRhDMbjOn6JX
	 s4jYg05jtVkZtGy3/Sd0UkLeIS2ivf8jvZSM6xrS0K0IIN+nsfwzAOc6DPfXLGdMo3
	 63z35ynP10ZHeBIPfP2FLmetJALkQELmyzxTYCbN655zan3nPyqC8ZB2Jd8JH1qGW6
	 /l/zQgsamAPru4XDYawOF5WEJbEiUvsqyY4XMrgzgMdw0jP6HdfRKRNYKc7b6ZT2oA
	 ZnoNYduIj7oPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C42A060622;
	Sun, 23 Aug 2026 19:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 749423DA
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 668E3606C5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXtJeaeAm0Bx for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:08:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DaOujbWm
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 302B96061B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:08:38 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so20857366b.2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 12:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787512117; cv=none;
 d=google.com; s=arc-20260327;
 b=c7A7KyAKjetwrufcNffxGBxxMy3ZoRDWD1zHhBrg56h7xyga+qzRO5ZjcoQi37/akc
 SQVRDTX1ypLIuezkHHzv5XzIZO7ySU/uyi4Be8rmkO5EanJD7cUPOII+aaw6x7x/jGaA
 XsTIx0a+/IqtNCJy82aYsTmK0dru0gT6mPIE1kCXvjBX5OPdUVLz0jz0DSBTXh+fHE/7
 54tKzoaRDYFUyJDCRlYOjlB/tIJoAzyWGaf34Xo7FCf2O6mrfBGdnqvgiA4fOvS5dJdM
 S2CXPJaeTAlPVV8VXPZHEtaGPvGC1lzTyfmGxYPXf2NAfyc4S8AcLPc8DH6oOrRdXDlu
 zAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1KMIiWoNyQ5/p47WDeEK475UPvmxZRv6UuOjnCzPmZM=;
 fh=+EYxUlI2J8XbvCFg/mlS83mNKWbgOrSaln8R2Si0Pdc=;
 b=kjYtGCH4cV38rOgM7R/7Q+SOZ6qEVf6E9VIKT8vy9E2S9kMC3RLvznThfR/PvNJl23
 e/wgoqn/F3Nr/8ftj8y/0WWeEu0kBn3+MraO5BaR6Q0AwoM+DtRo0s+I8dR+cFGrQgkQ
 Zx+RW0W6wrTHG0Dup5vDBg2m0aNLEVeSSaxBd6evlqREkY2DMDEEyOP7oAU9ffyk8jhC
 bTwhS8uOeyB6n/d5yf7TW3NDtkjK/4IqZaL8fx47NCF+4Q6qmblLrW+7eOtgfi88J7Ki
 R0NeC/yiCCw31yaHYB3HAyliYkyTv5oB/0mgfyMdh3/i2rEwcMw4zNtIY98Y9cx7m9CK
 +lSA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787512117; x=1788116917;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1KMIiWoNyQ5/p47WDeEK475UPvmxZRv6UuOjnCzPmZM=;
 b=DaOujbWmVmbcYXuGCfuPjymP7twr/WxsRlmHwuof6eqeexEPc0csyFKK7k5SxTYQzU
 zf3MUUHmeC6ONqD+K47YXD7seVMlord0YYkSKYiKkWWEj/WhqcxeArlBHTw3lVsWTfGm
 lhKTWqzGZQpkcqUp6i3g0bNNHjUzgDNe9IuCenEwKBzOvUcVLuHzIrz7iiI+3EfFtH4A
 C3FtvdeXNqAGibh9yVKC0t+grc55ALg1bRsZ8HOhTTjl2dv9xlSvBOi97zQWbp9Z1VFj
 k1R5NM2nmmcAr7Cgac6S5vUhXoztg3F6B8aghJW/D8RXa0dM3bplFHjr1gV58UapywCV
 cjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787512117; x=1788116917;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1KMIiWoNyQ5/p47WDeEK475UPvmxZRv6UuOjnCzPmZM=;
 b=Jk+vcCNk85wzHO/NrJhdu9AV1nyFq4gDcdCntT99JVD7iY2AHF8c0FoFmfT70XDtYK
 wRife3bUn5ZGvV26wYTDa6x3SYf7jMl5E0TbeSXNpSgOPjYo8XyZ4CMo1ymBYDsL2q4a
 nLfIjmPSCg9oJtqSVvaX4Lpn8KSYd0FMiV2yEcL7yO+BmNo+6VNSykb27gG04NhIQvzp
 /MpdtSYNyWyddNXkaTMgA4NTEYsL2AANzCcVhl5WG9svkxQAF3OB4rdoaKJJHcGf0vCT
 9AWIcZol3YOyu4dsOyBIxesnlQH0daESlCP/vmZyU87Cw0VBwTnA5iv1tpNWPgBVKI89
 uNDA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+CQ22GK5ryUx9wvBdpkV5VlpOFB8Tgjyc96WjIwYWXHb4IuwDTemGd72p71fTcAjkU2A4oMQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kHioqxWLne3VqWtH1c60dwZcS/vqrpN/OEvG4MNvZkOS2Z0x5+
 GEJz5MzW4XUu9eCd9leoUubditVm2gwa3t8YhMcHZ4oVUc7TGONEpEbmqJpndH1MzZ4X7j/07YV
 esomaw3IJ331cIineQCywp4Mhd5yIqIFUu3a0wtMDHA==
X-Gm-Gg: AR+sD13H+GeNnkWtJq1vXCZ6ye2h1XZ/7rpIOWO25eEhWjkzdW7R2qD8+5vC3lD0h1r
 d1su7btabqrtcpanKFkklopfGNXuFZulhpKwYMYZy2NWB7uwkiX5AuQmZEcQ3rqvzPSljaAz1Jq
 r3o4VJJPwvTlD/HPBCwzvB06VmJTJmmDp3EXKokL66qIchs6YXVOi6NGMIBOe+gkfNcMyHdK+Pw
 HqQJ8bpkCz/nCXqktnnP8mrh3OEkB8idAcrhOrdXQOh5FbsDeajZAK377/M+PiCHZiCtGIS1gh9
 u1V9qFldiEZ7EQUf82BXDTv8D31ED13Cs0LVGx3clqQ=
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr13002483a12.1.1787512116190; Sun, 23 Aug 2026
 12:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
 <20260821194451.GA3890585@bill-the-cat>
 <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
 <CADYN=9KBebUKhgwkvZ__EO8vjktsP+-cA=FuryObWpn5eGpysg@mail.gmail.com>
 <20260823185928.GB523975@bill-the-cat>
In-Reply-To: <20260823185928.GB523975@bill-the-cat>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sun, 23 Aug 2026 21:08:24 +0200
X-Gm-Features: AcwNN1WjUP_P9kCMi4PtHDAZ7gQkB7P62_uoiBWe1-MsEihqoXh3XJfr64wodxQ
Message-ID: <CADYN=9K7vSEKy2sb9ctPYoNmxdu4crsDE+iMEDbNaizyntF3ig@mail.gmail.com>
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, mkorpershoek@kernel.org, 
 ilias.apalodimas@linaro.org, michal.simek@amd.com, alchark@flipper.net, 
 jerome.forissier@arm.com, Jerome Forissier <jerome.forissier@linaro.org>, 
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 23 Aug 2026 19:39:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, 23 Aug 2026 at 20:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Aug 23, 2026 at 08:44:33PM +0200, Anders Roxell wrote:
>
> > Hi Marek, Tom,
> >
> > I'm sorry, my send died in the middle, gmail locked me out, so the
> > cover letter and the last patches never went out. Marek, the tree
> > is at https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v6.
> > Tom, yes to the split: 01-63 import, 64-87 make it work. The import
> > patches are unchanged since v5. I will fix the cc list for v7.
>
> If the import patches are unchanged since v5, I think maybe we can just
> say v7 onward is only the second half? Marek, does that work for you as
> well? b4 can be told to grab a specific version and numbers of patches.

Sorry, I was not clear. The code is unchanged since v5, but the commit
messages are not. I fixed the "Commits imported" lists, dropped a stray
Fixes tag, and collected tags from Mattijs and Simon. Taking the imports
from v5 would lose all of that, so I should send both parts.

Cheers,
Anders
