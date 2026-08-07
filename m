Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F01C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C660E60601;
	Fri,  7 Aug 2026 16:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxgx1WdrE0Ir; Fri,  7 Aug 2026 16:15:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53FC960684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119352;
	bh=fs3h0gdAxx+KMz8/6nBBwXcXrjBbYjh3x7cikYlvxJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYvMHhdvDtrA9TwK8EZsVGhIoLOYWg/AdGCbkcajWu9Ao1RWNsKZc5N/PzqCTqw6/
	 1iyTIVMwBXvYKcuNEdvbPZl1I1QSatvT9C6wAgmqC35C3twzwngG9P+qDAkewI1vu1
	 6NCu7nsJnOwU5BWs1L9qciNThhAGak2CtIs4CafyIx6KwD7zwxSu+cdM7IWI6aYTi3
	 rxz0tGQ2zRlH3MLW89C4qUJhZRZBWhSnRlhxwCdDjmG5itaPYHFZtwCXofsJR5bBoE
	 9c5yhSw/sT2vvS38cka6Ocpb0PwVu0og9G+RIgnI0Ey9Un/LZ7JzxZuUJLkRSVSR49
	 Vzxw2sKCR6Wpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53FC960684;
	Fri,  7 Aug 2026 16:15:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67E0E198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 593D980E4C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUKs2IrpQfKJ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:15:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6A5F180E4A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A5F180E4A
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A5F180E4A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:15:50 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6acc2a10023so1301008eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119349; x=1786724149;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fs3h0gdAxx+KMz8/6nBBwXcXrjBbYjh3x7cikYlvxJA=;
 b=ciiLLppe7ccinV/ABAnILDXQjCnuExoC9lfLF699ucF0WmdUg4zma8qpuswdpUTdg6
 ZAjro8HpJ2E1probNhx8CzHSMjFr024AcL79RbOxXRfqIMsr1R2HDNTMonBDv1NtUjkp
 I0HydI0u24tUyEHcg9zuTeA0kGgym+njLHsilXMiStMBZwbgy8NMuTs+3O8FQaRUCxkj
 NsKlIihdyBAD/WJEODGvHiZLi8gsHrqnIM7E4HP2KZDye5Yy1rQYp3NbDC5Fv105KCyZ
 /6Wti517BUQ6YexQLrngJ3B4XIlT5+q27Lbugm0i5OY7qBidb2kEcRA8uDpIEs2GQiiD
 Cirg==
X-Gm-Message-State: AOJu0YwXSkyv2Tq8LXZnyt9SDV1VcR/i8WSSrD8mZLSpUn6kQL4EJFX7
 /+MiBnRt7hGDRdl6Sa98OQK/9uS6ulKtKmwtS0JOlrFvZWe3/349eIWbDtWkKVvzdDPcgiUR0kb
 l/oe0oW4=
X-Gm-Gg: AR+sD12q4WJvQoDevkSWxquLgfPjM8ECz9yttsARfbtrjXWuC5BjZMcYYrvrN49MEBf
 uiC7RIyhauLYVVogBlnbaky/+9Ud2M+IhPEQD49Fi0k2JkjjZ9dUWtKoZRlu5buVBkYJ4oeqV4j
 /GbItjCD4G3Pf4+iKRNYjcjTHZEy5s8xFTqWP7UH/Ds7jCgCjrbWGSsVLRoJ8Xwe2bHWOARJhXH
 9j2KS8zQXV4iQxp6eTcL5/JYYvElclGwNyoNvBhls7kCk8A6LlCThLQflkRh3ZLt4loZ5wnFXCM
 2/j6C+oZsiKdPAIIlvqnYIx+U1qciXohlVC/dJKtIgxOAoZUepC9eaIFArbS2t20bi53LMXR82u
 yyp7h8VPdW6JHtSTs07U+YH0J2dXSBGAcScJ7cat3TSsd9CoxY8tSjr+MAu2sO2/E6Fi0W2xf8v
 xSUqSwyciEQaWt7cEzbLl3iSzRAAYgAOLYYrIngug3bMji4OkrjhQpwYGQTzkNI5GCKOluuPkxf
 kItq9BbcEUHD+qVbsw1gwsRdjJIGraKzbPQR3puyioDML3r8AJFHu+7d9CKZ7TfoXwse8vcOKAS
 vFfcyKxyNze+zDQGCYd4
X-Received: by 2002:a4a:e917:0:b0:6a1:189a:dae7 with SMTP id
 006d021491bc7-6ae96f6e9f1mr12312556eaf.25.1786119349160; 
 Fri, 07 Aug 2026 09:15:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f15e43c2sm2451229fac.0.2026.08.07.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:15:48 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:15:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: Pull request: rpi-2026.10 rc1
Message-ID: <20260807161546.GC180789@bill-the-cat>
References: <CALeDE9PU9taVrDUYxr5XyXHQ7-EW3i797mGsQOX+tJ9gFf9TXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KcveVU/U8JNNGYxF"
Content-Disposition: inline
In-Reply-To: <CALeDE9PU9taVrDUYxr5XyXHQ7-EW3i797mGsQOX+tJ9gFf9TXA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119349; x=1786724149;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fs3h0gdAxx+KMz8/6nBBwXcXrjBbYjh3x7cikYlvxJA=;
 b=n9QgImrUXYmAgQAF2F7uSY7blt/Ls1JlCDNxl7XqMxvu+ZuDVF0X34DI9VG0fM7v1/
 kC0Ouf+VwohJIajS2gOKOAnNpVyuvi0sN8RLVk+MQNXtNuCFVWyqEk2nLqtnDjRRckLu
 yGoJJ6GPudCRvaljUAZO3oXJTCjh+w89+uE8E=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=n9QgImrU
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--KcveVU/U8JNNGYxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 02, 2026 at 05:22:04PM +0100, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
>=20
> Updates for RPi 2026.10:
>=20
> - configs: enable NVMe
> - test: Add a unit test in phys_to_bus for dynamically created device nod=
es
> - core: Skip parent device nodes without a DT reference when looking
> for dma-ranges
>=20
> The following changes since commit:
> 5c215cb75c3723cbf77c36cbac3e60b001721c79
>=20
> https://git.u-boot-project.org/u-boot/custodians/u-boot-raspberrypi
> tags/rpi-2026.10-rc1

This breaks CI, as your tree shows:
https://git.u-boot-project.org/u-boot/custodians/u-boot-raspberrypi/-/jobs/=
58351

--=20
Tom

--KcveVU/U8JNNGYxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanYErgAKCRAr4qD1Cr/k
ClA2AP4r+DDabOEzwg19GHJ9yMjJ5eU1JhPnv7qb/PT5IJHtEAEA2AINE/jva6hX
4ejDRfMFe2cS1Rj9iTT5RIppIFxSXQM=
=yxAn
-----END PGP SIGNATURE-----

--KcveVU/U8JNNGYxF--
