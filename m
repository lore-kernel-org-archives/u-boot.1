Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C595F94CA0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 19:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD5983936;
	Tue, 21 Apr 2026 21:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aBriPosp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA17883BC4; Tue, 21 Apr 2026 21:11:02 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F88E83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so814294666b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776798660; cv=none;
 d=google.com; s=arc-20240605;
 b=CC3YqjHwcuzpkJSdcZSBbN2o1FeQujtKyqhZ51xPK8HYjZUIqHsyeZ33wiLXjA+rmy
 JX1Sv0nz9tlUumcnaO06GVfGg5IOuPq7cgWt4ThI9S3KItwCzh0xyqdvN/vS8798xple
 0oTzulj8gXIwUrWMBKyr52LWJM0alsDfpcdQXIqXU/UrwDQNlegOHfUr+98Gw+pcGIyX
 G+GNsa3oYOMNmLmU840Xp3P5SltOnmQZnKdMHVFwpEpCOskx2ZSSCvs2rMitcx+kfOTt
 FNUPdtKAzpUbZluE9aDn5/xuavd+j/tHTJ1Y6P7DY+y8BByhhmaJWOfXz2/9j3Jy5rIv
 h16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XjvEIJ64YJjwY/H+u+34g0uq3Iv6+N92S73mA5beh3s=;
 fh=ilFGAWhrw+4sfmxJgLS4Tbt6+FKjwFrTj0WwZ5SOs8A=;
 b=He8c41NAohnpsGq4GmBEIOMhPFnnFbjgvzQW6lMLEOGYecUsFN4yvMvhKLd6q1UfdN
 beRvrRucSkaif11udLB9HBObeEqsOuuiU+raxiUjjrBC/Y9IIYVzPPvXGJCINLTlHy/o
 HHu1I5yAOqdJm0gX6Eqn9dEDmXWg3tRD/GMgk/Q/VTQC9D5JaNyheBBX9kOg91dVi07f
 6yy1/kZfpHkzWBR3mrCiNdiCL2UZF1BZcleRhxDOR2QbbOE/fl+pOkjhKtCKLL5F2R41
 rH1mLW2gSPyH5j35fNZuyK1ZUbQnaX+PVudwz7UFiuPwcsAMPZ3UDR6c6V3Go6TP9I3V
 VuyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776798660; x=1777403460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XjvEIJ64YJjwY/H+u+34g0uq3Iv6+N92S73mA5beh3s=;
 b=aBriPospukgYlo4u7ONy7rMSQL6oRMBZid5bYrLtpPA7zCJiJENw4FwlV3R0GAQ9UV
 7d+S5sQAYneweEKz4uyd4+FtZ+33jkXqYmfHm6mqxUNYdvBDLBpGumuiB7+72a3HgSjf
 hLTD/RjfVrhwm1CNcQQJsZRIXjRSIyXHrWkSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776798660; x=1777403460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjvEIJ64YJjwY/H+u+34g0uq3Iv6+N92S73mA5beh3s=;
 b=sm4paja6YFteJp+9A4TKbknErxCXp+lyblwOrZ8hi4KSwO/hyDubtQ+PeQcmqqnWIO
 EmwsMzQXj74kkohX8fb7bY1Qmszs/wN6vTH8sdNpQxgqFxE99hhTSlDitMOYtXhQQJof
 zxYjdlS/w0T7VJWOZdZq4kkNIxFdDu2tsDf/grMDXXR2Vyq6Ulo6dIy0ZceZbIsTqPwm
 4NEkvmQC7JvNgy/PgqlNljQWANi/9XxUlbYhQRtWkFdaw4O6nlHwws2tjYgslDveD3hB
 akda1Rp/MgTfGwVEcnbadOceS51XYUcFle223YjnrPLAl7z70KK0YaBAJqZ+RhnTugBw
 ROFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AYycUkNY3lBqf+xiieZmavKSngDTa6YzH1VE2PKy+zEIC88JFgqSrgFx6YQg8VaIuM5J9PKo=@lists.denx.de
X-Gm-Message-State: AOJu0YyE0GYdJWkKWcJdi/zLf7tVF5Ke8ZkCRXijctbMI1jcQZVy/Gu1
 SBGVnSbybmFMqfnP9TXzBwQd+D8z2QLknEjawNnZQpGoxNbKTVdc7Jg/231q0dAtinZJQ58bQCR
 SW2n+sbDAHxvuhkohoo55q7lGdmnlYk+tJDKwhL0W
X-Gm-Gg: AeBDieutWutAVeFt5onEuItwghE7zkWs26gO7DspZWkS0C2+AOgctHXr6TIOhXdZ2Vu
 XCpk6cEb2giGSuzQAYSNNMUIGxVJ4TlpRgNmon3fKuB0Ln+l4zi+23A3UPEuK+QnklTMWoyVmbY
 RWj7ElzMpRTcy75idj6zPZE2A60F0K5uB7KoESEa0GsdGLCaGpPAUTR1Tl7BDphSpCyc0HQzpvK
 ly/UMqmAyIeBTnmz940Nt7i6SPIou8d4Sktt2C+cPuYQaxxa3tqcjf0LmnOMC99JAfao7arG7OY
 AHBUcgaQMN6J9JTuZbRh
X-Received: by 2002:a17:907:da7:b0:ba7:62f:9fa6 with SMTP id
 a640c23a62f3a-ba7062fa2eemr526434766b.2.1776798659917; Tue, 21 Apr 2026
 12:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <63a35f9608c046f37f610fb0679c7217c93016f3.1776344788.git.jcethrid@gmail.com>
 <CAFLszTg-xE4RcK7j8e9m4ViQCoEfSJrh2SMia+A3W_8Kkoqv+g@mail.gmail.com>
 <ZvRFPTw_Edctn_6wqjb-fOsMId7IXsw7-610jpX4IF7sW-c5ZPQYP3rODdLWluzL5jgvp2Hc8HVt7R8njIiIluAhznZqOrVi6isOVMHT1-E=@philipmolloy.com>
In-Reply-To: <ZvRFPTw_Edctn_6wqjb-fOsMId7IXsw7-610jpX4IF7sW-c5ZPQYP3rODdLWluzL5jgvp2Hc8HVt7R8njIiIluAhznZqOrVi6isOVMHT1-E=@philipmolloy.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 07:10:47 +1200
X-Gm-Features: AQROBzAYqXELg8g2UHHhoOaDbZV_6yHdTRczib6y2P-s-ttO95_c-P1FqzCYPL4
Message-ID: <CAFLszTh6cOb2PXUCj7tBDTFq9QrjJMTjSe76DHut0w9KBrxdMA@mail.gmail.com>
Subject: Re: [RESEND v4 04/14] mach-sc5xx: Switch from tftp to wget
To: Philip Molloy <philip@philipmolloy.com>
Cc: jcethrid@gmail.com, u-boot@lists.denx.de, malysagreg@gmail.com, 
 trini@konsulko.com, linux@analog.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Philip,

On Mon, 20 Apr 2026 at 21:33, Philip Molloy <philip@philipmolloy.com> wrote:
>
> Hi Simon,
>
> Thanks so much for this and the other reviews on the series. We really appreciate it!

You're welcome!

>
> On Monday, April 20th, 2026 at 4:51 AM, Simon Glass <sjg@chromium.org> wrote:
> > Hi Caleb,
> >
> > On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> > > mach-sc5xx: Switch from tftp to wget
> > >
> > > Switch the nfsboot and other relevant commands to use
> > > wget instead of tftp. This also includes the addition of
> > > the httpdstp variable for selecting the wget port.
> > >
> > > Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
> > >
> > > include/env/adi/adi_boot.env | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > > diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> > > @@ -15,6 +15,7 @@
> > > +httpdstp=8000
> >
> > The default HTTP port is 80. The commit message does not explain why
> > 8000 is chosen. Please can you add a comment explaining the rationale,
> > or use port 80 if there is no specific need for a non-standard port?
>
> Explaining it in the commit message sounds good. It allows us to run an unprivileged web server.[1] 8000 is the default for `python3 -m http.server`.

Sounds good.

>
> [1]: https://analogdevicesinc.github.io/documentation/products/adsp/setup.html#boot-linux

Regards,
Simon
