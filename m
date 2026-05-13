Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CFACD4F35
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BA583FB0;
	Wed, 13 May 2026 13:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="brMpWyF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3026684255; Wed, 13 May 2026 13:25:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BA5836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F2E843E5A;
 Wed, 13 May 2026 11:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D8C2BCB7;
 Wed, 13 May 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778671516;
 bh=WJwytgZZiDRrPbgBu4yNUpGqXfnmXewWAjzWIm16whY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=brMpWyF7NSQYG1ziqVKsBaIH+78gOj7vmckapffL9MhvGsd/mbc8UMHkqiZA0YjH5
 g58K5nWobl9djyG7u7Icf64dsJLq1RJhn5hn5T4siQYaXet8XHc+v2mBdMG8V8B1MV
 0+OO9tgoKa+oFXTbbGRO794OJQdqOE9iUrywrwDjGONL939XSxoS2KTpwMDrOVtzPu
 NWKbHYGWZETtHUIxxJmGpU76P7b4wYDDtsbW4oGU69a9rdjajiZcX7PVT2PT7+UQt2
 mIFCeBnYGIkCEERVPg30Y3OYFGkT5iJLVPU/A/LQQlSKJxKJ8p76Ry5uwGe99yHFj8
 JCi8/oKR63AFQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, stephan.gerhold@linaro.org
Subject: Re: Commit 59310d1ec (usb: gadget: introduce 'enabled' flag in
 struct usb_ep) broke atmel_usba_udc
In-Reply-To: <CA+GyqeZ8=P_i98Y4wT0Hfi9cmfvKsHn-upQ2h51zGB54-_JZvQ@mail.gmail.com>
References: <CA+GyqeZ8=P_i98Y4wT0Hfi9cmfvKsHn-upQ2h51zGB54-_JZvQ@mail.gmail.com>
Date: Wed, 13 May 2026 13:25:13 +0200
Message-ID: <87ecjfv9eu.fsf@kernel.org>
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

Hi Zixun,

On Tue, May 12, 2026 at 12:23, Zixun LI <admin@hifiphile.com> wrote:

> Hi,
> With 59310d1ec an "enabled" flag has been introduced to guard ep->ops
> against
> disable before enable or vice versa.
> In atmel_usba_udc/usba_ep_disable() returns an error if the endpoint is
> already disabled.
> When the gadget is re-attached, for example a dhcp command triggers
> usb_gadget_ops.pullup event, the bus is reset and
> atmel_usba_udc/reset_all_endpoints() is called. Since ep->enabled flag is
> still
> true, following usb_ep_disable()/usb_ep_enable() calls will fail.
>
> What's the correct fix, change atmel_usba_udc/reset_all_endpoints() ?

Thank you for testing and reporting this problem.
I've seen you have posted a patch fixing this here:
https://lore.kernel.org/all/20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com/

Let's continue the discussion there.

Regards
Mattijs

>
> Regards,
> Zixun
