Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C668FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DA784875;
	Wed, 29 Apr 2026 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jQ/jrl60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3A684876; Wed, 29 Apr 2026 16:09:12 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E976384872
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bb662d56b5aso164665966b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471748; cv=none;
 d=google.com; s=arc-20240605;
 b=HodnTEqoMitkVZfn7zUaTXfXgQPd+FU406locYFHCXKoWg1+RJnohvIhuw4l7ncUBf
 JOSBFuDJIEr5myc3uyp5T0WBsZaD/6RhBKamVoHCpBR74LpDCYNIk/anZJKThTos+tce
 tlAev7OU5LoYADjmgt2thAiIa9Lz6esCqDPmKBGdn5mtH7QS5GOUu133h7l+RHNQgokR
 H1uUnIdDL/ml8MyD0mvde8HLvFLZ/eusxPfvtKhMJ2nBQ8+SFlR+1wimpKO71coH9GJb
 /EsB91OIjQJCkeHMP59h2BwOsOPLoEP2AqSZgGsCmAqj9alFezKcExs17A9U1uWWb8QA
 Z21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qnZLcRv6kmDcnBqQ6TIKVBCifsbVQQfIeiVRh9Z3Wl8=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=DgQ64snzL0EspwuVdITt1wvdDRGJ0G3oT+f0Ii7Fuk8zjf+y5gAzIiQ2jQPGaSvPJw
 yzp/F66M/+pKtjOuZcQP6ZI4W7s4AXqWmksXPePs+pWReH95KjN8mOWA+8Eq0wjjwuFr
 ZDw8urz70gWWyLeday7whO0NLlXdNkhwsD8e+8d+AnExonH3brsN+BIimA5OwS8AMXFC
 0qMQIp66c8E3WwQ4gmNLl7Z4Ewf77B226DeYa10xOLerDJHP9uDvyhdRnA9tAN9ZM5Mx
 LavPkF1SO9x4Xl8F5F0PSMx3nrdYjHZy2tQAOI4MdM0LwHZiKAAaRKsd881v/BkjwUIu
 gpRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471748; x=1778076548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qnZLcRv6kmDcnBqQ6TIKVBCifsbVQQfIeiVRh9Z3Wl8=;
 b=jQ/jrl60mNa8xYyiCHGY7CFfuj9UTWOB++HEfZCMCg3xy/tG4xD9TC/7NaMoGxkNxw
 75k8t7R56VknyzibOZ3U71DsO29qjsukOHYRYw1yF9U3QvfqNru2gqVvXCmMU2hPnJ2T
 GNwILVY7fyHfvEH4HuZFzyNZIFodbnTA7wa0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471748; x=1778076548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnZLcRv6kmDcnBqQ6TIKVBCifsbVQQfIeiVRh9Z3Wl8=;
 b=jIktw/rN4A0lPRHJZMfr4qnqiN4aM7Lup1pm6mF5bJpTuxeO2596WAzGyZP1Mr2XmM
 KJBwVE75mYGPAc4HDiew4HDdDFgkbR9Bl1SlnBU+TyhFTMqqZyYSIF/OBpEXwBfHaDtc
 51OUsWm/kOnCuzDXVt1BYoFRx/qrCag4AGBWMDcXJeOdsHc1IQp67BK0xAr5OwMEi24q
 q91Jx2W+DWRW5HCAmdtk6kNuQXwn/QekWwEXz8cLgypHOnEggxCvMLcRJNA4mgNyaZAL
 y6CV8PbOPRjCOSjj3w9ml6jHx1YMJlVDR9/Aw18HtszqWDjcrUzqUhmD++66f8rL2s1L
 RYEQ==
X-Gm-Message-State: AOJu0YxoywTv69hYbaXDM6nfxtM6kTCeOKN9w2Zk3DD+ELsEg6GFi+d0
 vCp7zZDoppn/k8L9LajU83G9ZTD/5zQkSrOygQ5ttEbuA61U1kwob4mdvMct2v6qPVVeh43BSFX
 LXSy9K++LTWiJX9BLNHdkXOLm6eW49iOAW4EI2MOu
X-Gm-Gg: AeBDiev1xU1m4g5E3TiPyhrQdZdG47BW/FsEtrm8a0EN3vQdmjA2VHEAFKqRL4tLrUK
 A1/veO5KAG4HfhezeEWHvJ2yJoBe4NTdtSNPudTb474jAorbMFzh3k+iRk+euHg/9UjKDo3/DyZ
 uZiskPchZyticMf4ptfj6IhIt4GQ7GIRHpRBi0AcpmYJyPbVS75Az3JW1V+z80FHisVCck6+3zL
 CbRRynibagCCB5capvfnjbV6hOJtQQ43O+MV3ANRODs6FkwwsBl1bISP6ttcZPrpCBqPJmzvOfQ
 CF6kzyD/gXTpeeIr
X-Received: by 2002:a17:907:6eab:b0:ba3:bc3e:d5f3 with SMTP id
 a640c23a62f3a-bb969ebd0ffmr179912366b.5.1777471748189; Wed, 29 Apr 2026
 07:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <39d4e7e75c543754563f36b265ae584889211d57.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <39d4e7e75c543754563f36b265ae584889211d57.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:08:56 -0600
X-Gm-Features: AVHnY4LyiHDPYZ7Xx63gpWAVA-j_fcj4EKvp--qqVZdA0KL-PXsBEIJK4Ym4CqY
Message-ID: <CAFLszTjEgzORULHxybLqDRyOFWaz5O4ka7KmhoX0BHk51pNUiQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] mach-sc5xx: Switch from tftp to wget
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Switch from tftp to wget
>
> Switch the nfsboot and other relevant commands to use
> wget instead of tftp. This also includes the addition of
> the httpdstp variable for selecting the wget port.
>
> The default port is set to 8000 instead of the usual 80
> to allow for use with an unprivileged web server.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> include/env/adi/adi_boot.env | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -27,15 +28,14 @@ adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
>  /* Boot modes are selectable and should be defined in the board env before including */
>  #if defined(USE_NFS)
> -// rootpath is set by CONFIG_ROOTPATH
>  nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfsvers=3 ${adi_bootargs}
> -nfsboot=run init_ethernet;
> -     tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
> -     run nfsargs;
> +nfsboot= run nfsargs;
>       run addip;
> +     wget ${loadaddr} ${serverip}:/fitImage;
>       bootm ${loadaddr}

A few thoughts:

1. Dropping init_ethernet is a behavioural change: there is no longer
a dhcp or setenv serverip ${tftpserverip} before the wget. wget will
not auto-DHCP, so a user with no static IP will see this fail. Either
keep a network-bring-up step or call this out explicitly in the commit
message.

2. 'nfsboot= run nfsargs;' has a stray leading space after '=' (same
in 'ramboot= wget ...' below). Please drop it.

3. The image path is now hard-coded to /fitImage instead of
${tftp_dir_prefix}${imagefile}. The commit message suggetss this is a
pure tftp->wget switch, but it also removes the user-configurable
filename/prefix. If that is intentional, please say so; otherwise keep
${imagefile} and let boards override it.

Regards,
Simon
