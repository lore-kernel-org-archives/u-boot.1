Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D0C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 15:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28A0829A1;
	Tue, 29 Apr 2025 17:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745940491;
	bh=IOlpDrmPj6nx9eIsMif/jAqJXx/y2i1KDFNaYU3qTPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aiAz/4WSmNw9whdu1leXEXazNXZOPwJoy+GmMnrSdVd1D56auCaa7vIrqYqHXzlR2
	 2UyBxDK0Gb49Zu7mDKShZR6n2T5uFZ7CpQa0CIvxk+Q0BBAm5bqCiDRrtKjBY7tRJ+
	 x4yP/WU1K5MuDP6gi23yQsVm5R5Rn0VBiFfwI6CIzlGVXaXNO14Falsw+PJ/i4okHq
	 o6nWV4uYgJUAsJMd05VUhyYeKc1AKe1wtHjGNqgw6ZzTGi0LiEbAmfQZQBHxYedMpV
	 Pi6hzQczYtMmBWMDUipFXjM5WdZzIGKwHTGkKCOKLoEL+Zd0x5CnBiRy5DKZoIljjQ
	 5za60vYJ6pXgw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BAA82A39; Tue, 29 Apr 2025 17:28:10 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E757782958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SQYcUI/h"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9C8010271400; 
 Tue, 29 Apr 2025 17:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745940487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=IOlpDrmPj6nx9eIsMif/jAqJXx/y2i1KDFNaYU3qTPs=;
 b=SQYcUI/hwVz69r5xeNju7TaL8a1aH+VBDJyGr3w6dcjAJtddRyFt7QbJ8sh663HHlwuYy8
 CEj0q+w0rjUxWrTOzfgETgX8ddg1v4PWCJlCEnNy1k8ZZw1S16SULjLNzzG2zvemBRJiaR
 f8HWDuxHPbvpCzL2Xa0E7xdfPvAL42NRjWSfPyC/qtS1fONw//yvu/ani9lX0F10cIbKO4
 SolEpwTz6v6Gz4r1v8mU1RFkUSNrGivSSFTQ3FiVZa6slxft8PM7bCl8dB62oYfnS0l4bd
 /cQ7uG4S4VEP+0x9TmPY6qqt4EOBKAuAFR7z7mSPxOqPLl0ISarQQQtN210VrQ==
Message-ID: <6ac53871-954f-4321-9ab4-23038216c2ae@denx.de>
Date: Tue, 29 Apr 2025 17:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] tiny-printf: Handle formatting of %p with an extra
 Kconfig
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Benedikt Spranger <b.spranger@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Ogness <john.ogness@linutronix.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250429144756.2467039-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250429144756.2467039-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/29/25 4:47 PM, Christoph Niedermaier wrote:
> The formatting with %pa / %pap behaves like %x, which results in an
> incorrect value being output. To improve this, a new fine-tuning
> Kconfig SPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> has been added. If it is enabled, the output of %pa / %pap should
> be correct, and if it is disabled, the pointer formatting is
> completely unsupported. In addition to indicate unsupported formatting,
> '?' will be output. This allows enabling pointer formatting only
> when needed. For SPL_NET and NET_LWIP it is selected by default.
> Then it also supports the formatting with %pm, %pM and %pI4.
> 
> In summery this level of %p support for tiny printf is possible now:
> 
> 1) The standard tiny printf won't have support for pointer formatting.
>     So it doesn't print misleading values for %pa, instead '?' will be
>     output:
>     %p   => ?
>     %pa  => ?a
>     %pap => ?ap
> 
> 2) If SPL_USE_TINY_PRINTF_POINTER_SUPPORT is enabled or DEBUG is defined
>     tiny printf supports formatting %p and %pa / %pap.
> 
> 3) If SPL_NET or NET_LWIP is enabled the support of pointers is extended
>     for %pm, %pM and %pI4.
If you need rich printf formatting support , enable full printf instead?
