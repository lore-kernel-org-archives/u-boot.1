Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619EACD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3B584659;
	Mon, 18 May 2026 09:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bCcYSLb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC4384664; Mon, 18 May 2026 09:37:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2061D83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BEBF843CEA;
 Mon, 18 May 2026 07:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FAFC2BCB7;
 Mon, 18 May 2026 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779089846;
 bh=I8S35QMMRzeLKlpaZCES7XpVreW8NuVd+5+9jDjHw2U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bCcYSLb2NxgkG4M8tpPNP5EbXAqKBPZKHQWZHM8ISKYLEhdWGUMZ91dYu0woZ/8eF
 fo1nPCBg6fDlTPsyg8XCA4hmEdCUTde0+CGFkZrk5kh/8pth/dVe6J8SJteTCRaKsZ
 Ke8hTrh2FAn55yZd63sxlx+rkhYixuOWGXudrSqxNSp0gOaFNl9xcgHCgVq27RANc/
 NzWiD45pH9MTLwSWBoYdJhNbby8v/k0IBGsLOKts1H9efmfJk0l6MzmzNG0qjCGutC
 JWPI4FaVvGoKWQDGX4b9str64hvZDaHpL6HqPPM4dP5w95ahFOdro/DZL0UdyoraPe
 Y20TRTJAyVK8A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Zixun LI <zli@ogga.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
In-Reply-To: <CA+GyqebQKevme6u+tvp1LCKAhVxsSuKo7PQq-saQOx3dTBZ5hA@mail.gmail.com>
References: <20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com>
 <87h5obv9go.fsf@kernel.org>
 <CA+GyqebQKevme6u+tvp1LCKAhVxsSuKo7PQq-saQOx3dTBZ5hA@mail.gmail.com>
Date: Mon, 18 May 2026 09:37:24 +0200
Message-ID: <87h5o5w4ln.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 13, 2026 at 16:05, Zixun LI <admin@hifiphile.com> wrote:

> Hi Mattijs,
>
> On Wed, May 13, 2026 at 1:24=E2=80=AFPM Mattijs Korpershoek <mkorpershoek=
@kernel.org>
> wrote:
>
>>
>> Also, I believe (but I may be wrong, please try it out) that we can
>> maybe remove the whole if (!ep->desc) block from usba_ep_disable() since
>> that should be handled by the enabled flag wrapper introduced by
>> commit 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct
>> usb_ep")
>>
>>
> I agree we can remove the whole if block but it will desync with kernel
> code.
> Do you want me to send a patch ?

I see a follow-up has been send here:
https://lore.kernel.org/all/20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com/

That one looks good to me. I indeed prefer to stay synced with the
kernel code!

>
> Best regards,
> Zixun LI
