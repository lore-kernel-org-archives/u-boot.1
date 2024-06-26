Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07814C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 17:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192A187F33;
	Wed, 26 Jun 2024 19:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="CdfVDmhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A4387FED; Wed, 26 Jun 2024 19:37:14 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CED87D43
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 19:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=bage@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=b5XCzgI7qVHDD3nFnNOl0Lnyt/SnaobQ5nXovs9A1FY=; b=CdfVDmhMOyuedQ39b+dpUk+SOp
 +xRO8Fl97CXDJxeyyuVVEzfzVpadCu/yfzsJ0okud8lLqRqp/yJ2tuCYMBmzAD/atdNicLo8ZBgqm
 7VKOkeuNxucCJhTaTDwvrPQH4CBYCt5FfQcfoKtAvLQWCi2llGMV+R2ESbH9BGlYDEJlVhxIaH3wU
 G8dIlS4a8B4qEIKX2cKDJGBbOsmf/hXY5ITFcResin4iYN5tBDbCoz+es1x38q9so+6mW6JELCZP0
 SKrHIgFyaURbVksRr02PuDmjAy2OU57zoHzNQGO23NGtIZuipHjIB4s0IkIrNLj8mOBcnn7/Eh9sa
 TmuFX18Q==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.94.2) (envelope-from <bage@debian.org>)
 id 1sMWZz-002jZ8-9Z; Wed, 26 Jun 2024 17:37:11 +0000
Message-ID: <8f512ff0-b4b9-4aaa-941c-728030f48ba2@debian.org>
Date: Wed, 26 Jun 2024 19:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fit: Make data-size a conditionally mandatory
 property
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240624170041.1024-1-bage@debian.org>
 <CAFLszTg=n1fa8itjbw9t2X7hwjXMr2=o4GaR=5wj27WT1seW3g@mail.gmail.com>
Content-Language: de-DE
From: Bastian Germann <bage@debian.org>
In-Reply-To: <CAFLszTg=n1fa8itjbw9t2X7hwjXMr2=o4GaR=5wj27WT1seW3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage
X-Mailman-Approved-At: Wed, 26 Jun 2024 19:39:05 +0200
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

Am 26.06.24 um 10:00 schrieb Simon Glass:
> Can you please add a PR here?
> 
> https://github.com/open-source-firmware/flat-image-tree

In that copy, the property is already conditionally mandatory.
