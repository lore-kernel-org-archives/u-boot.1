Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB22C87FC5
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 09:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF2D830B3;
	Mon, 21 Jul 2025 11:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GAJL/gLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCBA830C0; Mon, 21 Jul 2025 11:26:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A535E8309E
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 11:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4B3135C59EB;
 Mon, 21 Jul 2025 09:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDE8C4CEED;
 Mon, 21 Jul 2025 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753090000;
 bh=X4IXRu7ARB47A/HcS1VY3q0HuS0M6YEVn9VZzy+DR1s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GAJL/gLmYOgR5hdBTHC/1h7xPjEbKKHhGfVvEULoD74QUzTLttSZuZl7YZ4zrjFSL
 KHJWkFHocBWWa/ZBtW6IEGjNdgLfne9YE2NhMY4biWOJMWX4Z2oiBZrYrP6CZ/5LbJ
 VSpXibplusm0YrcE9xbsrsRbhaT/xDiCyys8mjNa6HmoRcU9+pPTXytANOQluDHBsV
 fCxRY53Evb4QLZy7zw7ZbVcM3ymxx8uusfezsN/Vgut+ecRnp+nONObgaFRtmuneN3
 eIpTX6qx6mX64MHhi9SmCJ1PzcPIL+ocTbbwsvSO4fpZbqhlhpUZw1b1UMsAq1Bvot
 az+s1HFJBTMPw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Minkyu Kang
 <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>, Simon Glass
 <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg
 Malysa <malysagreg@gmail.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Roger Quadros <rogerq@kernel.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
In-Reply-To: <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
Date: Mon, 21 Jul 2025 11:26:37 +0200
Message-ID: <87ikjllws2.fsf@kernel.org>
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

On Sun, Jul 20, 2025 at 14:57, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:

> On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Sam,
>>
>> Thank you for the patch.
>>
>
> [snip]
>
>> > +
>> > +#define EXYNOS850_DRD_UTMI                   0x50
>> > +#define UTMI_FORCE_SLEEP                     BIT(0)
>> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
>> > +#define UTMI_DM_PULLDOWN                     BIT(2)
>> > +#define UTMI_DP_PULLDOWN                     BIT(3)
>> > +#define UTMI_FORCE_BVALID                    BIT(4)
>> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
>>
>> Comparing with the linux driver using
>> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm=
 controller")
>>
>> I notice that the defines are in reverse order (from 0 to 5 and linux
>> has from 5 to 0).
>>
>> Is there any particular reason for this?
>> I don't mind it too much but it makes diffing between linux and U-Boot a
>> bit harder.
>>
>> Anyway, I've compared this with the linux driver and it looks good to
>> me!
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>
>
> Thank for reviewing this, Mattijs! Yeah, I kinda flipped the register
> bits w.r.t. kernel's version, just because it looks better to me this
> way (easier to read when it's sorted properly). Due to the driver
> model API differences between kernel and U-Boot I had to rework the
> whole structure of the driver, and I only added Exynos850 support for
> now, so the difference between U-Boot and kernel versions is quite big
> as it is anyway, so I figured it's not a big deal to reorder things
> even more. Hope it's ok with you?

It's ok with me. I was just curious if there was any special reason for
re-ordering. I agree that it's easier to read with the sorting you have
applied.
I've noticed that only Exynos850 is supported for now. That's fine as
well in my opinion!

Feel free to pick this up through your tree.
