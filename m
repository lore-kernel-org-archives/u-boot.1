Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25999CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE67C839A8;
	Wed, 27 May 2026 07:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IwTx9f0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2019484671; Wed, 27 May 2026 07:00:39 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1BE80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so6694198a12.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779858037; cv=none;
 d=google.com; s=arc-20240605;
 b=g/nvWcRILiQZ985BklUnfkNWlZWbTAzvAuaMx2gsbGFhrYwALFje6hLSpl4SF4NsQ4
 56lTfLITUMYN3LShzz1HWrYr1wuVTK6u6/bh4l5HCupCXEPLmk245yjWMZn7sdiHvH8M
 zxo1ekAC4XseXz1LORZTEy86I+S0NRbmRj7rAzoybOFjVrgxL+DFEnFiC8w2r4ApiGCW
 m2Uty5Z1x08dPkX9tZxgr53PLJcVdFn6Hou6zUKVpiFaPtlsqOoDu7ChBSKc0WA1cX4J
 yc5uVkb/E8zX1yldVw150fi0jDXLa2DKhJtbR46VtxAJhGc5RXUL8WZDwlOpbx469ugy
 TyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ZX7lQbNQZr4+7vybo/CVB+At3Oe639KZ8P6yRlgTSs=;
 fh=gE6Yt7gElLCbh8ryhtP+HD2nmjSP4RFADqefourqOuY=;
 b=NZ5BuNxhb2SgzR3bEQOnXNJUjziBxo4HmK39ZCNqOr/Cnar8ZmeiqipJDUm30nIL03
 39dOufV83lJd7w0Rxv94ce4CyZpymptue0Hj06+IAKganfN4Q54287oj6aTpONU7VKsq
 5QohglL7txxvWEbbOv3VAw3fnzemeeWsVl+Ga2jPbhPbEMcdf0cPiCz/zesmkdcZ7Zlp
 ooduVqjZQmLHcZaQEpm7xN9NCdizLUFhlxDS/Xwn70BKdEUaqBpbREaEKrj2JO4K4CdQ
 aYPWULkVUhXxmmbv4yDumJ7x7jR9860XRDWZ9rGaKhhZIUGwQJDmFNscJqtmWG3s7jYy
 5cvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779858037; x=1780462837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZX7lQbNQZr4+7vybo/CVB+At3Oe639KZ8P6yRlgTSs=;
 b=IwTx9f0o5JHaTxaS8Jkp2CEqrmytyfsH9raWlzaaeLNou2+ogJ3Lv93bo1rQSGz/uW
 VWN1sA2v6gQPpvhfJDrMzlr1E20iFrjIGesENm8VJ7uw+6vCq0pFt2oJWnPXfPYA+tJ1
 7LOZI5wYIpz8/davzaWBngqtwUib7Qd1intNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779858037; x=1780462837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZX7lQbNQZr4+7vybo/CVB+At3Oe639KZ8P6yRlgTSs=;
 b=J1SQ2Q7bC9mhFVM1E9f3Ihz7L89S0dDj3prdr5AaEfVt8t57VSDaLG1Dpb2p+xSBz9
 PANLvUmI9/eUXqPawGygwcLFGVbxZAvPrpVBVSV4nUgyAyaQNFGQ5C9qBd4u2jZy8Ej6
 dEEXesAY9XZZ5gost/q+JgimeWgoDmlkJGtNyS5toMTL4Cci5Fgl4cGJ3LnwYfdtsImQ
 Q5hC4u0YgOt1rTRLEoIcEraFWN2iPOLw/u5jW2u2UmJ6hg9gleYuo0t8Ex68YxjmIbds
 JI0IzAfxb64ur0/LEm9qmwFLhYFHG1wgUozHQ6FPBeEmohdxTw4/Y/oFJvGhc9oK9Xhl
 oA3g==
X-Gm-Message-State: AOJu0YxU19vxpBky0plWGysw5TXcSDYI3J4cgwJV5InebShcIazxwlo6
 agzm76fvh7bTIFHdFRfnF7WZ/14DNeG/okZbmea00tWXXfLAhAUh8b4u7/f0J2VaffDx40PcSDY
 u9G4XytdDwtr5TNRTZaBP9MmJdWVs7ra1j78DcVLWrwiXrx81JX3kORt0WDi59Oi9
X-Gm-Gg: Acq92OFX1GXp5AWyUfV0RWjGH9FeE4MKtJzVZ6roS9tx1mHWBWPL6DL8UXc3P4tiDof
 1XUz1DBF4OoQmuaaw+F+JXYsWKJDcPJQ8Fu/DmMRLhsPPXsFdtzOt5D3/+aSMWH1ONsY8khcuhX
 PmCUMOITIXTtNasHYBJENRwpwNKnYSxHO424JmwNMia4dH8Mn40l6LYUC2EjSdD53HL1wNQs1f5
 Ccp7j4tOjP/3pYxOHQqch60Syva41eb/1SsMZR1HWVmLJ74qXiaCxXQ8pIdagKOC9dtb/EEol27
 X3zBlg4=
X-Received: by 2002:a17:907:8d8f:b0:bdb:2fad:4811 with SMTP id
 a640c23a62f3a-bdd274c9aa3mr338354366b.28.1779858036406; Tue, 26 May 2026
 22:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260520044554.15373-3-aristo.chen@canonical.com>
In-Reply-To: <20260520044554.15373-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 May 2026 00:00:24 -0500
X-Gm-Features: AVHnY4JVkatGNJycB42gljajrXd9iP-cuMaqJL7d6rSPSCum4DM39ICeNH5oavQ
Message-ID: <CAFLszTiXHnCZ=C+CW-3MvX1J7nSssHhg0sUYqMuHQiDn8sXR-Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] test/py: test kernel_noload decompression buffer
 overflow
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-05-20T04:45:49, Aristo Chen <aristo.chen@canonical.com> wrote:
> test/py: test kernel_noload decompression buffer overflow
>
> Add a sandbox test that builds a FIT containing a compressed
> kernel_noload kernel whose uncompressed size far exceeds four times its
> compressed size. bootm_load_os() sizes the decompression buffer to
> ALIGN(image_len * 4, SZ_1M), so such an image must be rejected with a
> decompression error rather than overflowing the buffer.
>
> The test verifies that 'bootm loados' reports the failure instead of
> decompressing past the end of the buffer.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit.py | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
