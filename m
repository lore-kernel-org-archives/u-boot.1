Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11DAC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAA987822;
	Thu, 14 Dec 2023 17:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="u8JHyJkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 048D087A21; Thu, 14 Dec 2023 17:47:47 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF80877E2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7debb60f-9aa0-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7debb60f-9aa0-11ee-91e7-005056994fde;
 Thu, 14 Dec 2023 17:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=epTBktcQxmu6MMlnjwJsF6Enk6fC3YFlsmDqkB6LrGI=;
 b=u8JHyJkzRbfLdx2ziZ8ZrdsLpI33bWDfYCpsVhuUAq4TN2FpSBuo7ztSmn8MYXMUfV4hovXtcThXX
 /bULOjhiVGV48h7YGyqO/1J2enQBaNGPUpE+2kuxAvHJ/prFk/KMvLfoUt7+Z6vP0VvSPWqFl8ePeB
 M6vtB+CVrBbLOcbEFHcz0NLV1BtPhWQ5X8jUnNAjsCNrAH1zCC+JjbAtCzn1jIaIPkw8X7ka7+ixJ9
 eABEPq0+WTasBhz99wcp1qfGskrJqEsfGvdUEaJDycqnaUKfZ+7HI8PCnGQ0loDhAJ+hqn1qh+svKy
 UQy9hnSVSkoP2yuN3Zl36wMNW+9Fsew==
X-KPN-MID: 33|qp4sAY9P0gghx7hud7DVJ41qT5fGTSsADrMZhZDVwAnS1qc9H9iQ1PcwnT0OyD2
 dLwg2Ws/MyOqSW+d7vLhugHHnhKMA4oEV4BNeVROwgKg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0G1k6EzhPYpfb4j3m8k3N6gZyEF50OZwUdgcJvQiznmWJhw3I8lW2WpXYNj7LDW
 DvjOHJLwbFuSRt6wmb9s/rw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 80175816-9aa0-11ee-acaa-00505699d6e5;
 Thu, 14 Dec 2023 17:47:43 +0100 (CET)
Date: Thu, 14 Dec 2023 17:47:42 +0100
Message-Id: <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, sjg@chromium.org,
 Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <20231214155346.GB295924@e130802.arm.com> (message from
 Abdellatif El Khlifi on Thu, 14 Dec 2023 15:53:46 +0000)
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
References: <20231214155346.GB295924@e130802.arm.com>
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

> Date: Thu, 14 Dec 2023 15:53:46 +0000
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Hi Abdellatif,

> Hi guys,
> 
> I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
> in U-Boot.
> 
> The objective is to enable the FF-A messaging APIs in EFI RT to be
> used for comms with the secure world. This will help getting/setting
> EFI variables through FF-A.
> 
> The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).
> 
> Two possible solutions:
> 
> 1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])

I don't think this is a terribly good idea.  With this approach orders
of magnitude more code will be present in kernel address space one the
OS kernel is running and calling into the EFI runtime.  Including code
that may access hardware devices that are now under OS control.  It
will be nigh impossible to audit all that code and make sure that only
a safe subset of it gets called.  So...

> 
> 2/ Create an RT variant for the FF-A APIs needed.
>       These RT variant don't call the DM APIs
>       (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)
> 
> What do you recommend please ?

...this is what I would recommend.  Preferably in a way that refactors
the code such that the low-level functionality is shared between the
DM and non-DM APIs.

> 
> [1]: https://lore.kernel.org/all/CAPnjgZ21qLnSFcCJ9rPQXEfQf-NjMBF3kYUDBBOc6WUQXQtDEA@mail.gmail.com/
> 
> Cheers,
> Abdellatif
> 
