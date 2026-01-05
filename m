Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92255C2A07E
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 09:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E217683AB7;
	Mon,  5 Jan 2026 10:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G1cAHlEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0537E83CBD; Mon,  5 Jan 2026 10:36:11 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456FE83A9F
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B22ED44319;
 Mon,  5 Jan 2026 09:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1874FC19423;
 Mon,  5 Jan 2026 09:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767605766;
 bh=1YlpjpDSqF+F3kWIx5yrwQfdbTMxNdw/DhJmO4S9hjU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=G1cAHlEnT1RQrDzdHwMkSRGQkvcMydEXynmsled8Yd5+aOr8pqAKIr2mrFc3L8jcZ
 QLg806WlWBhTI+UFHvcBo3Q5CDYdsxQsDTMmkuKxWboCTxiPbZJbnOHLV7gxz30mZG
 jwzt/cJ6lDa94DDlTT/Ab6so/uJCZSsPLQFZfrD1u/P88fA5gFEminysWRUhbOvbMi
 XiUKUgLawtr7gb5UDGOdh4ZqDS/FoiZ0DKXVXEnCMCMMWli1PyDU0vBjjIQHMQscjY
 yUUQxzB/FK7Vqm3ZnuMt6XXcI9cXeFybXQ5LR3/vcpaWoCvq/Zh95DcTU+ms10B2ZG
 LTvnbW6BPT5Ng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eddie Kovsky <ekovsky@redhat.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini
 <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>, Jan
 Stancek <jstancek@redhat.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
In-Reply-To: <aUmB_fvpK1macga7@daedalus>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus> <87fr9h5swg.fsf@kernel.org>
 <aUmB_fvpK1macga7@daedalus>
Date: Mon, 05 Jan 2026 10:36:04 +0100
Message-ID: <87zf6sflkr.fsf@kernel.org>
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

On Mon, Dec 22, 2025 at 10:38, Eddie Kovsky <ekovsky@redhat.com> wrote:

> On 12/11/25, Mattijs Korpershoek wrote:
>> Hi Eddie,
>> 
>> Thank you for working on this. It would be really nice if we could build
>> U-Boot on more recent Linux distros without bridge packages such as
>> openssl-devel-engine.
>> 
>> 
>> I also don't linke this double negative.
>> As you already shared, Linux solved this via:
>> 
>> #if OPENSSL_VERSION_MAJOR >= 3
>> 
>> Why can't we have something similar?
>> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558bdc45dfb2669e1741384a0c80be9c82fa052c
>> 
>
> Hi Mattijs
>
> Yes, we could also implement it this way with the extra USE_PKCS11_XXX
> symbol. Jan's original patch I based my work on does something similar,
> and I perhaps oversimplified it.

In my experience, when porting things from the Linux kernel into U-Boot,
we try to keep the code as similar as possible. This helps reducing
maintainance burden.

Sometimes, we can't do that. In that case, we should explain why.

Do we have a strong reason for *not* reusing OPENSSL_VERSION_MAJOR with
USE_PKCS11_XXX ?

[...]

>> >> 
>> >
>> > It's not the prettiest code. But I'm trying to be very conservative
>> > in making these changes so that no one's workflow is disrupted.
>> > Developers should be able to build U-Boot with the latest OpenSSL
>> > without impacting developers who are in environments utilizing the
>> > Engine API. The goal here is to preserve feature parity between the two
>> > APIs. Adding support for custom Providers is outside the scope of this
>> > change, but could certainly be added later.
>> 
>> I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together and
>> just use "#if OPENSSL_VERSION_MAJOR >= 3".
>> 
>> Tom, or anyone else, is there a particular` reason for gating this in a
>> Kconfig ?
>> 
>> The oldest Ubuntu version that seems supported (22.04) already has
>> OpenSSL version 3:
>> 
>> $ podman run -it /bin/bash ubuntu:22.04
>> root@6dc347676b8a:~# apt update && apt install -y openssl
>> root@6dc347676b8a:~# openssl version
>> OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
>> 
>
> I assumed that we would want this to be an explicit config option, but
> logically there is no reason that it has to be. I'd be happy to spin up
> a v3 if there's agreement that the Kconfig isn't needed.

Tom, do you have an opinion on this? It seems you are listed as
maintainer for this (THE REST).

>
> Eddie
