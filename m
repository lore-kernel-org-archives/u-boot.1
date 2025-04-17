Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035BDC369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 16:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB1282B3F;
	Thu, 17 Apr 2025 18:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sfconservancy.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="HOBUZukG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBF582D39; Thu, 17 Apr 2025 18:46:00 +0200 (CEST)
Received: from pine.sfconservancy.org (pine.sfconservancy.org [192.237.253.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527A182B3F
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 18:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=sfconservancy.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=karen@sfconservancy.org
Received: from mail.sfconservancy.org (unknown [192.237.253.17])
 (Authenticated sender: karen)
 by pine.sfconservancy.org (Postfix) with ESMTPSA id B5CBEE445;
 Thu, 17 Apr 2025 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
 s=pine; t=1744908357;
 bh=nB8rKEmGDe0bR5Wo3qFZgG8ynKEozq/MHY62sgZAf0M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HOBUZukGYnwBvxXB7/Tlpzzo356TU2wDF2S77RHmLyFOdYi/uQMNa3FfZ0H+QiRy7
 agxHTqmOA4cCmp201EQfF5iitTxjoqPLg6NPQILUW8uyC1qXMNGKnJUhNeIq2+uSgP
 sbfOBzhN0W6kvzC9/c4DTn+CLdPoUhjai2rDbY2uVFgfuth9M/alaM4fukCW6S5jxb
 JO5jzrcViFeEPiihgtY6Va6a/ZsjdIGfwZEXSHtJkLLXN4ccBob/16WExnQ9B+92lc
 U7vFh1dshxTulHZr7pWyhsaUMWa6PjYmHlXeHmhZeuf/DWfLc6ZllyK3EGQIjyyydp
 dDTep4gcdGpXw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Apr 2025 12:45:56 -0400
From: "Karen M. Sandler" <karen@sfconservancy.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Levi
 Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Denver Gingerich
 <denver@sfconservancy.org>, Bkuhn <bkuhn@sfconservancy.org>
Subject: Re: [PATCH] bloblist: Drop BSD license
In-Reply-To: <20250417163326.GZ5495@bill-the-cat>
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
 <20250417160423.GX5495@bill-the-cat>
 <CAFLszTgWUNP6L6ZML639wz76CuuBoPDt447vjfz8MRZyLE5gFw@mail.gmail.com>
 <20250417163326.GZ5495@bill-the-cat>
Message-ID: <5b0876bbed279e41a741fdcaf6091694@sfconservancy.org>
X-Sender: karen@sfconservancy.org
User-Agent: Roundcube Webmail/1.2.3
X-Mailman-Approved-At: Thu, 17 Apr 2025 18:58:07 +0200
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

On 2025-04-17 12:33, Tom Rini wrote:
> On Thu, Apr 17, 2025 at 10:26:53AM -0600, Simon Glass wrote:
>> Hi Tom,
>> 
>> On Thu, 17 Apr 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > On Thu, Apr 17, 2025 at 09:58:42AM -0600, Simon Glass wrote:
>> > > On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
>> > > >
>> > > > Linaro has decided to write their own version of bloblist from scratch,
>> > > > so there is no point in having a non-GPL license on this file. Change
>> > > > it, to better fit with the U-Boot project.
>> > > >
>> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > > > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
>> > > >
>> > > > ---
>> > > >
>> > > >  common/bloblist.c  | 2 +-
>> > > >  include/bloblist.h | 2 +-
>> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > Applied to sjg/master, thanks!
>> > >
>> > > (Tom, this one seemed to get dropped but I'm not sure why)
>> >
>> > Because AFAICT you legally cannot unilaterally change the license as
>> > others have changed the code.
>> 
>> OK, let's put this on the list of things to discuss.
> 
> Sure. And I know I'm behind on getting process going with Conservancy
> but Karen can you or someone else please be on the call next Tuesday
> (22nd, same time/dial in as before)? For background
> https://lore.kernel.org/u-boot/20250101195817.995321-1-sjg@chromium.org/
> is hopefully enough but I'm sure Simon and myself would be happy to
> point at any other links that might help. Thanks!


Sure, at least one of us will attend.

karen
