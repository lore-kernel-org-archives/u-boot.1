Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD26C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 16:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A84889A0;
	Tue, 27 Aug 2024 18:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724777604;
	bh=8QeC7stDxb4i6Y5SOlMgm3TQE0EP2hJbmaQmonbsGs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+JF0XH+RtYYWIQe9pmvhFD2RR1l0bdNXBuiXLN9loQw5gmoep3joXIusT9tsq6Dz
	 qqL0JTgDYbnlxky7WbGidmoVWuQ5x1voQDDmMYiEjFWfInLilA1xv/qhKLAamQink+
	 g2MvDS1qXOqzkUS21MwiOYMhKnQIh4QPg6X40qdrm3FJAbOEtr8Dyg4BQQ4vkl8qLA
	 9wbIlwBJTuUrJoPV2xzBxLkjr2Uy/Yn/gEIJfEdrUBRteB43HNCy0vP/JRWKZf+yzI
	 +UxdPH/H1ylw4BSpTCXyIrSwLhlnysQMfcAGmn3soW9gp7/MkoTVeu1gJLk+h9NAYx
	 pjHs7V9eX5p6w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E898C886A0;
 Tue, 27 Aug 2024 18:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724777603;
 bh=8QeC7stDxb4i6Y5SOlMgm3TQE0EP2hJbmaQmonbsGs4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VLKzNT0vq5PuPCUutR6xBo1n5k/pcTMM0YdF6m4P21gTuLgTUwVfXqMn+BwuFMbPN
 AwgAwqOi9s5Q1lOd4rd70Oo708k5zEamHYn6r34ZSorRN5GuM8IkwYraaV5O2+lurF
 9Y5iO/QuV9Y/yNjuwDkC4rGFFRCqNyw5lsr+S86oJDy5+tTeRmYfgTU7tdBPOoomGh
 Ij8BPbligXUNlu0Us7V4Qqh/JW4PgYvKEKkbtrbxqxo+MfE5bNM453GtO5pIb6/59A
 7DilzFgaTQqUeiYbY+GFndj4rPcaDanznOdyWaAp1J2P8BzZKSUMxlXtwbW/em1Aj7
 Gj/7SUwAlnpBA==
Message-ID: <2b3c8c1a-4d67-4541-9fe4-dad4d661eebf@denx.de>
Date: Tue, 27 Aug 2024 18:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xPL terminology
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/25/24 3:07 PM, Simon Glass wrote:
> Hi,

Hi,

> We have the term 'SPL', which has a dual meaning. It is both a
> particular phase of U-Boot (the one that loads U-Boot proper) and a
> generic name for any pre-proper phase.
> 
> You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> enabled for TPL and VPL builds, not just SPL.

I wasn't aware of this.

> I propose to rename the generic term from SPL to xPL (meaning any PL
> phase), leaving SPL to just refer to the phase before U-Boot proper.
> 
> The symbol would be CONFIG_XPL but in documentation we would talk of
> xPL, with a lower-case X, so it is more obvious that it refers to any
> phase.
> 
> What do you think?

Works for me, thanks.
