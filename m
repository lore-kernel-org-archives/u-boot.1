Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73F0CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A302844CF;
	Wed,  3 Jun 2026 19:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3Lf0M0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B67484881; Wed,  3 Jun 2026 19:06:03 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1B283FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68d2342c5e6so6152057a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506360; cv=none;
 d=google.com; s=arc-20240605;
 b=fVZgv1gCaxJjQnelx/SMzpM65lAOqpV5+39gvc+jGnVBvNooBhWPKqnXplUrR+E9HK
 ARmrKGUGyPNNFgIjhp/5nSoD7XrDyLy9y5jI5tNxYTI9CWGaUPlEmKJDY8B8HyC/Yg+9
 8rNJpFcLvuK9kDQS9tlgjXSG8Q4hQFT87uAhPnzbPs2ERGPVnFhmYxP6U8x6XWu5ephU
 vVuJQeEGloS4aa6OQP5TzofH9duDCOo/+kWdqOHJ902PloGmyTOqCd9as2f9c7n9OR5u
 J+GugpdpiPBD4JUiQKN9+dvBX34xnx8gjfT37XdjLlue/C084kQ7e270dnF+KEsi1mhb
 5b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I21e/uTZamr5lK1R+JnC5rgICk1ZfMjuP3DkC9ExmYU=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=HESAriT0NEr8bcKlEhfEvp0tbRTdFN6yzrRqcNLzZ3ZkTSBCZr8ptilQjLaJBvhDWG
 Z6ajm1kjcaW+rLeSD+ZYPk/Bv1KtwEdP0OUbpEPcM4NJybBl1KY/F04YlKgT6S3oKjfx
 kyAtOKyQfHxEcGCJj4ERxRdquwqH3CrfaEHP7K9ZXfftDBwM1UtV+KxBQglj/HsGz7ni
 ywHWXjrVwTCsbC9P6mRCLoYLsKIydCSqdozTUoe+QM1COAJamq9jBXf299+r91EEVxuR
 ZxqjX0JR1OaSl22xeTDwNgoKyMm4jdNnZHdLdgGBLXY0pZ1L93jbeXvCfCMnNxoOXB03
 8Umg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506360; x=1781111160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I21e/uTZamr5lK1R+JnC5rgICk1ZfMjuP3DkC9ExmYU=;
 b=P3Lf0M0viLxr9GFzU+UOawjxvDi8GtLCt3bjcDUL6mAS8boU3DM+g4gcArCumReVGQ
 sv90aWlj71vdleOrl2HE7YXvh9R3X32HHqOpuRva79kKAJCGi5AC9/ohSgg9kFiljOWQ
 /kUzOuFeu9Tol+/bzpkYBdJBX0lzrFbt/JlnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506360; x=1781111160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I21e/uTZamr5lK1R+JnC5rgICk1ZfMjuP3DkC9ExmYU=;
 b=jXvGQOQl4B7AvIyqxj4R5neV6JkLzdxClY51/nc1bwy7KY0q37O8GW+yO16Ct3Ws/z
 BUEqU2yviFBEKqQwW3820mMUqYCcNFqdlkswCMtz+jKndKjpFWDthzk91+qP1HKE2xRf
 Wy9I/o8OSlupLhD2gOytMmCj6g2XZ6SAodb1rYdhx83Pm3I+y1H0CpLu9CCtT4zQke25
 CSUJ+EN9iMiEcm7nZ7QEY/2nBeS6ha1W2nDNDrTvmD3tmV7mb/DCKdoR2GpCrW5R4Z03
 o6NmMMY7WzAPSt0Owg81jdX4/ToSTkAFUp2ioNQPUou97kqMAx7INCzfysq6J0GhlZzW
 mq8Q==
X-Gm-Message-State: AOJu0Yx1e43DfDoMbOqHlnCEa5LN8ApjBFQ3WvG6rnxkuCGu/NFWW6AL
 T5v+n2WooqtA7iZwc16CoziCj0tQKRLfsUNbmEJth64m0HdfZQwCtxqy5BLVS1VpHOsMl7oYL5k
 /KsgKBXjDvAfGVQdnpv5O2RlO3/3fR/MnOwstAd6P
X-Gm-Gg: Acq92OHHwu/UtOTLpOQcEaJBoC7HVKZ6XPM3+X4sWEPnEaJBI7N/tTqRXgeJ/AVJ0Rc
 tv5gnCVbU6S0G77Z3OQamT0rM53t5+w3m5DHX4TsNhyKCyfceVsBE/ai8iV9S+X1XRHZXZJxRzo
 FElwuYqLozY7lIfAd77ID0Y13jNIEUbIIw67Mt3d67Vu66iAus0DpFis7GVsFLrQVj44cWJpy/A
 RtVHguccZorZdq/KqYzjj7KmNrys5uc7TvkuF9fd8dkIL+aUcu6KDrQk8cwZfwC3De5v+v6Nfv1
 6672vUUybQq+BhV0
X-Received: by 2002:a17:907:1998:b0:beb:b53d:4839 with SMTP id
 a640c23a62f3a-bf0aea0a6femr252542166b.33.1780506360465; Wed, 03 Jun 2026
 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-7-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-7-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:59 -0600
X-Gm-Features: AVHnY4IpnkO0jkviO9NtKWkOgpfn7uMpyjn2tz-t2Vnfms_Lcl7LkHhD3hpa1Zc
Message-ID: <CAFLszTiyLvi12XX+qL5R5WZ8NLFa29wDFSPXZYrDH+Z7KxY9_Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] docs: reset: document cold reset option
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> docs: reset: document cold reset option
>
> Update the reset command documentation to cover 'reset -c' and explain
> that the default reset type can be overridden through the relevant
> Kconfig choice.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> doc/usage/cmd/reset.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
