Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B97AE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2826802B4;
	Thu, 19 Dec 2024 14:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="c/rfT8f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D3180328; Thu, 19 Dec 2024 14:07:02 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EF580314
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 14:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0B2D0240104
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 14:07:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1734613620; bh=ZK9k9FJBS02PxGxjhQl0ny9kcy7k1KqjtnTJkAhkBmY=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=c/rfT8f2enZGMx/bE6odWzlqA7149ig66HdUkKNtHyyY8GFDa/WsRsrRFr/rFOez/
 zz4u4T20XHL5ZfdbmlaZ5eCkN86TNSpWQ8AtFwe3rNJq+l1wkjguiTsjfxNZUz+cxt
 ZB6mgFymH/FF5Tvea4ymnTrTprHCReEIuC35ZZQZ6wb3arcEorEgNmy2VsDhCONa1f
 JvG3NmY1QAv2PNfQmZhfl7IpHejv//17IL5iyay30PQ6DmYcEUHWGgFKPWY3H/MVxk
 CGzKcWdxv3AZXE6CrSr3CuiOpn7hIb2FPJ2Lk5onIRKkh7Af260VlbeT0tKPYrJu6Q
 wI1UUepv6YCbQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4YDW6C2rGsz9rxQ;
 Thu, 19 Dec 2024 14:06:59 +0100 (CET)
Date: Thu, 19 Dec 2024 13:06:59 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Sinan Akman <sinan@writeme.com>
Cc: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] gpio: mpc8xxx: Preserve pre-init state of outputs
Message-ID: <Z2Qac5yDvhhJV8Pu@probook>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-4-8cd6daae4f93@posteo.net>
 <30176d01-b244-47ac-82c9-8ee2b1f44a6b@writeme.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30176d01-b244-47ac-82c9-8ee2b1f44a6b@writeme.com>
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

On Wed, Dec 18, 2024 at 02:20:21PM -0500, Sinan Akman wrote:
> Hi
> 
> On 2024-12-15 10:18, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer"<j.ne@posteo.net>
> > 
> > The mpc8xxx_gpio driver contains a workaround for certain chips
> > where the previously written state of outputs cannot be read back
> > from the GPIO data (GPDAT) register (MPC8572/MPC8536). This workaround
> > consists of tracking the state of GPDAT in a "shadow register" (i.e. a
> > software variable). The shadow register is initialized to zero.
> > 
> > This results in a problem w.r.t. outputs that are configured to a
> > high (1) state before U-Boot runs, but not touched by U-Boot itself:
> > Due to the zero-initialization, these GPIOs end up being set to zero,
> > the first time that any other output is set.
> > 
> > To avoid such issues initialize the GPDAT shadow register to the value
> > previously held by any outputs, if possible. On MPC8572/MPC8536 this
> > should make no difference,
> 
>  Did you test this on a MPC83xx board ?

Yes, on MPC8314E. I'll mention it in the commit message.

I did not test it on MPC85xx, though.


 -- jn
