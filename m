Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9CFD876E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8531884314;
	Tue, 17 Mar 2026 14:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g0SjnVoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF0484315; Tue, 17 Mar 2026 14:41:13 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FBBC84308
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40423dbe98bso2123107fac.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773754870; x=1774359670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UjFyL2X9A78+n++VD67aAT92Uj7yvVgiA65x8G4NCuE=;
 b=g0SjnVoCX1S+ztYlOB8INtRMp8vgSdotjdI3XiyZwsFdWZECXdssmPqYmtBw4D5vX7
 sWzBGIDtSE8+dnfELjhNnvcs0wn7BqRr6veklnFFEy/h8bcACo3d12q2O7xL5x0GINuf
 44vSdc8ShRnJIXiKpHdZ7aUllQu4LEVgvyOw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754870; x=1774359670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjFyL2X9A78+n++VD67aAT92Uj7yvVgiA65x8G4NCuE=;
 b=brMZLvW3i+dq+at1MTQWqZ1QjpwWzodUV27H2XEycdT0clTD47KsN34nJ22g/4iznC
 MaCb7UXrcMSmiByMDR+ySvKSES9l2yZ7GKtK4+dpxqB/uKiglW0F/ziaSlXXyQ9eaLxR
 FxFgWrwl7QZFDm7tisXbgbXgnHjduoLafaUL/Awwa9ph5I4Z6V5kkcidwhFmX0lH4jIz
 Q3K8/Pn0jOJdWEwBFeolPk4OYhfQUHkkgKt469rkffaSCY0sEzCajuDRsdO2r8Xtk3si
 J24y8cH5bh4gNnOt62lI/hdAFi/6Y4zk5jUgtyJ+OEHAo6rqGd7+wnAxTpLDx2SZv/dm
 2UyQ==
X-Gm-Message-State: AOJu0Yzg9DpZb8OzPe25xxEmXAaHfI89I7hsIhvGKiHDWE0qFLWFdmQv
 gW64sbM+gGzl5phuALbv8G5bplOS9Ifiw0DcMo1zcyYB5kgArJfeuJhmidEFEHdOcCI=
X-Gm-Gg: ATEYQzwqWpgoGOubVH8/UefW5VskxHVbHFwFRsryzc/6g0dvDkG2Jyr5uE0r60cIP74
 rAwmg0updowau2FfrAa9kOcsVrN5wxG3QzZgE3xKlu423zkmZ4oEqnkxoZ9i/qZlrc4JQwR0rVa
 n1tqsA5vSP0nq6r5HjytQsoczwWKPMNPoATvwCfXWRY5kDxpcBCQLbOMhBsXIQmlEn7c9LCttnW
 SzKZ2fscbY5hJvKovdaOIkV9bqCj+Ap/Qw3GhSrTuaUQQ0SSWnV+Dufig7XuPidm6pmz4WZxjcB
 aaxz+JoSnBTL1FW97fmXlIBppljV50aMF5mM79XD6MRYC7eSAvEzHAa00bqplIrBDDJyuJg6GM5
 QvCtLGGFsxiwmf/rPFrS28Joty/nTdmYU5at21Wpg8GZqZJYekMGVPOrTrvmBxmS21wl5gJSm2z
 wH4raK3oo1a2GVMYIr2Gou0NIOIRivF91uYC0IXGHlnUGUGPoaZ1GxDPEmjjWDWgZZq7wd9J8Jx
 2Tgc89OlTKxMOGjanFSz/HbnhUkLpyeHACvC0+5o+WWP6r2byIkoH9n7TM=
X-Received: by 2002:a05:6870:d10e:b0:40e:dadc:4a05 with SMTP id
 586e51a60fabf-417b9059ab8mr9542142fac.8.1773754870129; 
 Tue, 17 Mar 2026 06:41:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e2df1ddsm19273111fac.9.2026.03.17.06.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:41:09 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:41:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
Message-ID: <20260317134107.GR502704@bill-the-cat>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GpU/n991INCYpA9S"
Content-Disposition: inline
In-Reply-To: <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--GpU/n991INCYpA9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
> On 3/17/26 2:24 AM, Tom Rini wrote:
> > As exposed by "make randconfig", we have an issue around
> > USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> > SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
> > this is a hidden symbol, move it up within the menu.
> What is the issue this is fixing ?

Valid configs causing the kconfig part of the build system to note
unmet dependencies.

--=20
Tom

--GpU/n991INCYpA9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablZ8wAKCRAr4qD1Cr/k
CpwwAQD5K6aALOi7qpOE5aIR0h6W+mj4UpcbsVTx5W7o8Jr6zQD/TRHwLMYPknGC
g7vWYNDZRm80Z3iqo3RVzBmsXgbWQQE=
=0hAv
-----END PGP SIGNATURE-----

--GpU/n991INCYpA9S--
