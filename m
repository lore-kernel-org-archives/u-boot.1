Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ADFC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 327456064D;
	Sun, 23 Aug 2026 20:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QakFwMFa4xzz; Sun, 23 Aug 2026 20:57:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787518673;
	bh=5BDC8zVsIlH4zE+mCagQpYy0dFZsI/7rCaTMYqW5AVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fhGJea6+hUn+wXGjv7ko0LpxcfDDWN8Nu2NednoPjPz301RbTgphroF6WwS3ShJhm
	 y3131j+FH9PFO3yjZVmNTWlr+uwYqO9niL9YRwsXSUWoAFQOfCrVqdeEfWuTIUett6
	 KZr3Vm2zfpDsQeMbhjIN4YedXxFSYVikKYtyoctrZOG6QmbZPmbxH09mEDM5Sgez5C
	 md871SNr4ANcvmgLX/wxVJXdnBxcwcC3ubnWGR0thnNnfRhARa+pzW19Q2IZ/WsZ7l
	 QVRPATU7+zDYYQcQA9pnePI/+2rvK0ZavzfJYo0TwkSOu46Pf9iV2c+hJ4cc1SmurV
	 S2E7nCQjTqoMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8F8A60600;
	Sun, 23 Aug 2026 20:57:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 868AE3DA
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 846C84062D
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1sZ_ayYBWiW for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:57:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f0NMK9wd
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D27E4062C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:57:49 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 46e09a7af769-7edccf768b0so1195396a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787518668; x=1788123468;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5BDC8zVsIlH4zE+mCagQpYy0dFZsI/7rCaTMYqW5AVg=;
 b=f0NMK9wdDJbGlwOGHwSnYibD/zdxnLg3G9W0HV+CYmW4IRGJn19t85Mj1nPM+uCrFR
 eWmdmlCZ9gqztW5SKWFImz0xaS/ij4HxSKyAjwUMEpxJcFRRrdaDUeAMlDMZwMMUXVf0
 i3TkcsMQ8z/+gXY8kEmQSG+LygLWti9ZApteY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787518668; x=1788123468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BDC8zVsIlH4zE+mCagQpYy0dFZsI/7rCaTMYqW5AVg=;
 b=rrq2hzp+iZS3WMVRashtQr4hU44KjiOWT+Zq4ClZqobATA3UwegmB1e206H+tc7bEA
 zHl1pJWWo8+U1cjMUe8CdE7tm9dW+Ws+Dw336tktgpaIIf8TH1qLlw4ZerL1ffL2kNOX
 LNyWgwq8PjKVXtX5jpEe2ykmccDbJ6QcAr6Cm9VNeAOACmwDd9w0p2I8SSPXv5OUnWXT
 1A4tT10PHiuvnZQSrmMOlsg7gAnrFz48JPWv4wkt8J0ctbP3olCmHST/6zn4OLzNXU3e
 0Ik1D1cx0w4s5hNJll1hsflUdQm3qA0TwAFXldUBN5QiiygEX8NgGljc29zBBWYHczyL
 cslQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5FmYYjYocmwiLmI/2UWiEmfbem7rBh9s4+1e7QJHk5C1EZAxNpQsBs7qeqYOaSWNWF5mdja4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lfZe9IpzewuQphOiUj174doTzW2kFUrVazTDnYz0fpihb97zCC
 gEcurdGNE4jF4mmYwW6EwUhzKIt3XfnjNtONSIli8lJnPEFtadlvwIxkZBbkLePXrHo=
X-Gm-Gg: AR+sD10e5Dav3m+Y1f1YfZpa4M/I/xv88ZQ1YAuXbMPdsG5in8BMLha8la4XRX+zib2
 k36j4q26tifEHqPpHNDvepFb5bgcspCi2rmAHkyMrBjvlK5n6L/UVFoSIQGi/5stHW5QgyR3Vcx
 5IEg8D6MN1ziSRpXCq72tWF4/qoc5Z0s21iapJfvc5qO5viUus/fJqueMlJxk2upe7X3Fa0EsOy
 Uhh/K2ksIXgtsVQ3xCU8A/+kms7F9IhaU+qrDTYeFNaww9jdRoR4CxmHpuCKsVCvaqWRyfVIFJa
 F1u73tIvjty07GbVx3cW37pUao0H9GfNpGkf/If6tJt9++ZCYtdsA7jKCUjG52YrnMIRALDbo6x
 +3sQ9uD5VGxq0+KfTuVEAZJ04zNHtoMwvJi5cIOpx+O+A+ElAmOHdntog20fQY/9zC7AkJGzuZ7
 v6cHzijpHxKQg/+AbX65/wF3mDuHYu3dvjSWcbAFgTHHPt/itIuoedK6tLZproaHW8XvMM4D2wD
 Y+7EGCp+Odw8+NEBu9WOL4pATCRaO5UeAC02DG3vz1eVCICFHaUzxbR6qYc3rHAYGEOPG4fsKrL
 HKVGdwQN0A==
X-Received: by 2002:a05:6820:c085:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b16ad247fcmr9302359eaf.31.1787518668328; 
 Sun, 23 Aug 2026 13:57:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17cc0c2e9sm2275782eaf.11.2026.08.23.13.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 13:57:47 -0700 (PDT)
Date: Sun, 23 Aug 2026 14:57:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, mkorpershoek@kernel.org,
 ilias.apalodimas@linaro.org, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from
 kernel v6.16
Message-ID: <20260823205744.GC523975@bill-the-cat>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
 <20260821194451.GA3890585@bill-the-cat>
 <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
 <CADYN=9KBebUKhgwkvZ__EO8vjktsP+-cA=FuryObWpn5eGpysg@mail.gmail.com>
 <20260823185928.GB523975@bill-the-cat>
 <CADYN=9K7vSEKy2sb9ctPYoNmxdu4crsDE+iMEDbNaizyntF3ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o5j/WXt4AdtFtj8s"
Content-Disposition: inline
In-Reply-To: <CADYN=9K7vSEKy2sb9ctPYoNmxdu4crsDE+iMEDbNaizyntF3ig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--o5j/WXt4AdtFtj8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 09:08:24PM +0200, Anders Roxell wrote:
> On Sun, 23 Aug 2026 at 20:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Aug 23, 2026 at 08:44:33PM +0200, Anders Roxell wrote:
> >
> > > Hi Marek, Tom,
> > >
> > > I'm sorry, my send died in the middle, gmail locked me out, so the
> > > cover letter and the last patches never went out. Marek, the tree
> > > is at https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v6.
> > > Tom, yes to the split: 01-63 import, 64-87 make it work. The import
> > > patches are unchanged since v5. I will fix the cc list for v7.
> >
> > If the import patches are unchanged since v5, I think maybe we can just
> > say v7 onward is only the second half? Marek, does that work for you as
> > well? b4 can be told to grab a specific version and numbers of patches.
>=20
> Sorry, I was not clear. The code is unchanged since v5, but the commit
> messages are not. I fixed the "Commits imported" lists, dropped a stray
> Fixes tag, and collected tags from Mattijs and Simon. Taking the imports
> from v5 would lose all of that, so I should send both parts.

Ah, OK, thanks.

--=20
Tom

--o5j/WXt4AdtFtj8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaotexQAKCRAr4qD1Cr/k
CjTIAP9CiMRx47nGztuDCZQjnMdpCYSvYZ2ifkLkNmQkjsQ/lgEA0IX9pkc/oXzt
Ze1nmqA2SAuY8qhmHX8xwrY3Y1pvrgE=
=90x0
-----END PGP SIGNATURE-----

--o5j/WXt4AdtFtj8s--
