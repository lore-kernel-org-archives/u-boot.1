Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E4FCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB72835B0;
	Thu, 23 Oct 2025 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RByGcVZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F4D807C0; Thu, 23 Oct 2025 01:03:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEB08003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 01:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761174203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D9oq5plzFzAhXj/Cn8vjlTYpM3SNo5EzHh4Rpv54bsk=;
 b=RByGcVZbUe0FtAntJlPzMjCtfnjS5tSs/p8eSWiCVo5VHajl4VOtFuCnPQ8kZ6ZCF6j8lx
 kRDHLOjvH/ndJaNxzOR3jPerQHvaIjPz43fEIUqKLzEot+y3z2y6cO+KAc34olQiE4q3Fl
 5mnuB5hk4W2JZA77hvzUU0QS5mJ9Hz4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-C7jqG46gNYKvJVGk7Uof9w-1; Wed, 22 Oct 2025 19:03:20 -0400
X-MC-Unique: C7jqG46gNYKvJVGk7Uof9w-1
X-Mimecast-MFC-AGG-ID: C7jqG46gNYKvJVGk7Uof9w_1761174199
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-932ce8647b0so274532241.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761174199; x=1761778999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9oq5plzFzAhXj/Cn8vjlTYpM3SNo5EzHh4Rpv54bsk=;
 b=xMTDgqH8Mtq4Xhr4pwctRyMSidr9b02CQYQPLvNbxZVuIEvt5OJxMk1WIECJpQ+qwx
 /79BPefw6GTmoqK7p2X2j1YTYP3MpwBY5yg0g060NEAL2/FK8/5Udap8B6ywClX05xhw
 11UUa9ku7tAuppmry7csISUMdn/ETAOUnITAciD7fXeLwgT9HE6Igf+jVL5lgl+NrN1S
 hRgWDE228VupFP6ssrfj/8xPwwZn4/Mfdm6pudblHZFg8q9OxyWtEG9bn5cmOQ2zLzsG
 2K51drd2GGyt3gGfmBR2gJ7UtDO0cBQMsqknBGMMs59tI9Rve5H5jeArUp1cpBvan4qS
 Xs5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSIrhRpwKEkgF0tPmKFCFdxLjQ1KwjRQYqGdKERp41Fy4Nk2moGPM6GhSrVl2L4uJAdyH56M=@lists.denx.de
X-Gm-Message-State: AOJu0YyuagqANfxqHXM5Cw9HwDRaohAqmCOWOczghb4fqkL7wfpKj9Ei
 qa5oE270hzwqwMy+tqZRqyTtRGM9uRo6CPutqIo/WJaPuIHx+h5TXoFw6n8HOdUJCVg1xAxoGPb
 Q4R3nuN/ooxm/2zs8MfzgwwKQTv96InIg9Xc3RWm30Rf8px6dWwFM/7g=
X-Gm-Gg: ASbGncvY+VGA54j5vX8JG38U99BIwlVEdmG2pB0OsTQWdfhdVAetTSgsO6/T/Djo1CC
 aSKdQvgaGFU7wrp9cEK6Qr2FzfZ8W3SH8N6aKvzrr2ZmZErx4Jz4ftLIejGlO1QBGYjpZkv9X1V
 xU1KHroHkt0mHaP6v+oOlzlzlFSHaqh0V2KXF0QycwpzBuetxcdy3gpOG2QEAkgGzhTVRgUg2WZ
 GPaK7jfVwQUg29VKzZUb4X9Xei3L4jD5f3aVEt081D1KWYcwT5A7tVFIkO8J9OhNbnZe+0lP0kI
 KqIYD/qSe+jwh3mA8JmNXRMiE02uEaKCPsF+W4ZeS6Dx3xWAp0MvXqoLMD1lkDMEgku4lQ==
X-Received: by 2002:a05:6102:1a18:20b0:5db:23d1:96da with SMTP id
 ada2fe7eead31-5db23d19746mr1102465137.16.1761174199546; 
 Wed, 22 Oct 2025 16:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkfmmqQ9QZw9weLdTLPQlsAkFuNzwhmuIW1eBcR/TdfbyZ/S117QjWgAvVqna90IwKbH8wvQ==
X-Received: by 2002:a05:6102:1a18:20b0:5db:23d1:96da with SMTP id
 ada2fe7eead31-5db23d19746mr1102439137.16.1761174199189; 
 Wed, 22 Oct 2025 16:03:19 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f9e824cc2sm3194156d6.61.2025.10.22.16.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 16:03:18 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:03:17 -0600
From: Eddie Kovsky <ekovsky@redhat.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, loic.poulain@linaro.org, tobias@eub.se,
 paul.henrys_ext@softathome.com, sjg@chromium.org,
 jstancek@redhat.com, eballetb@redhat.com, u-boot@lists.denx.de
Subject: Re: [PATCH] Add support for OpenSSL Provider API
Message-ID: <aPlitSZ8x1yqHFHG@daedalus>
References: <20251017171329.255689-1-ekovsky@redhat.com>
 <87347gpi7s.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
In-Reply-To: <87347gpi7s.fsf@bloch.sibelius.xs4all.nl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8DIMYBOYIP35q8V_gqNLNzRQL6Ff5CWRrFzVxjLLRlo_1761174199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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

On 10/18/25, Mark Kettenis wrote:
> > From: Eddie Kovsky <ekovsky@redhat.com>
> > Date: Fri, 17 Oct 2025 11:13:27 -0600
> > 
> > The Engine API has been deprecated since the release of OpenSSL
> > 3.0. End users have been advised to migrate to the new Provider
> > interface. Several distributions have already removed support for
> > engines, which is preventing U-Boot from being compiled in those
> > environments.
> > 
> > The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the
> > Provider API while continuing to use the existing Engine API on
> > distros shipping older releases of OpenSSL.
> > 
> > This is based on similar work contributed by Jan Stancek
> > updating Linux to use the Provider interface.
> > 
> >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >     Author: Jan Stancek <jstancek@redhat.com>
> >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > 
> >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > 
> > The changes have been tested with the FIT signature verification
> > vboot tests on Fedora 42 and Debian 13. All 30 tests pass with both
> > the legacy Engine library installed and with the Provider API.
> 
> Did you test this with LibreSSL?
> 

Hi Mark

No, I did not test this patch with LibreSSL. OpenSSL is the build
dependency for U-Boot, so that's what I was focused on. The LibreSSL
project states that "The OpenSSL 3 API is not currently supported."

I did make sure to add #ifdef guards throughout the existing code so
that users who do not enable this configuration option can continue to
use the engine interface. That should also work for users who substitute
LibreSSL on their systems.

I did attempt to use the libretls package since you first asked about
this, but I wasn't able to get the build to compile. Is this something
you would be able to verify? I'd be happy to add your Tested-by.

Thanks

Eddie

