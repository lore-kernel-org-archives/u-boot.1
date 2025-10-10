Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5356CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B5483F7B;
	Fri, 10 Oct 2025 16:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lFpboC3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E9CE83F7B; Fri, 10 Oct 2025 16:11:59 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D76183FCB
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 808C86265C;
 Fri, 10 Oct 2025 14:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B382FC4CEF9;
 Fri, 10 Oct 2025 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760105514;
 bh=j2stkuemoMSMTAaXaPy9ZH/r1aocXaHbchXEGklSqns=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lFpboC3Yi2+7eMJDaRbwm6/9CTHpHDKudrWP4hSWDsoi/fnZ6kbfSeCoRDegi6haO
 ZXzO1tEeu7FifMACX8PY09HFVY38mWteY+trU6uWwP91U7h78/PqZ2SdV//XH8yV3n
 n9TrNOUrHM8BU4gfXG4ZtHdpyzAV9hon8akkPlBb2xBApTGI2++mtWv4LixdMtek3P
 skojfwhxcLYpxHl4/pnQt+uXIFiBl1SwR+sQpoiDJxJ7KbWiG9BWKpVKLzS+s+cPgY
 G3drd+iNp5wEu+qlwEVvBB3YDbj5yxB205lM9MtPeFBz9eHn8KE0Df+FQE+wCnuxQd
 1b++J0VRUGSyw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Guillaume La Roque
 <glaroque@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome
 Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Maximilian Brune
 <maximilian.brune@9elements.com>, Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
In-Reply-To: <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
 <20251009172428.GP298503@bill-the-cat>
 <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
Date: Fri, 10 Oct 2025 16:11:51 +0200
Message-ID: <87wm52vobc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Oct 10, 2025 at 11:35, Simon Glass <sjg@chromium.org> wrote:

> Hi Tom,
>
> On Thu, 9 Oct 2025 at 18:24, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:
>>
>> > The 'bootflow list' command supports looking at the EFI device-path when
>> > available. Move this piece into a common function so it can be used
>> > elsewhere.
>>
>> The point of this was to enable the show_bootflow->bootflow_show chnage,
>> so should be dropped.
>
> OK.
>
>>
>> > Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
>> > column space.
>> >
>> > This updates the output from 'bootflow list'.
>>
>> And this is unrelated and should be its own patch. Wikipedia says USB
>> MSC or UMS are the common short forms for USB Mass Storage devices, and
>> we should use one of them to have the output be more precise (since we
>> support USB networking devices for example).
>
> Ok I can move it into its own patch.
>
> Are you wanting this to say 'ums' instead of 'usb' ? Will anyone know
> what that means?

Search for 'ums' gives the following U-Boot documentation:

https://docs.u-boot.org/en/latest/usage/cmd/ums.html#ums-command

Where the acronym is documented.
This is also the acronym used by the cmd (to configure usb gadget as USB
Mass Storage).

So I'd say it's a reasonable acronym

>
> Re the second point, at least in U-Boot a USB Ethernet device shows as
> 'ethernet', i.e. the interface doesn't matter. We don't have logic to
> look a level deeper, at present.
>
> Regards,
> Simon
