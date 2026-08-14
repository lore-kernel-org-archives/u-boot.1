Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83236C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29CC840CDC;
	Fri, 14 Aug 2026 14:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEhLjvjikRuf; Fri, 14 Aug 2026 14:56:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 557C340CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719412;
	bh=9qYUMqZl5+gFxxVYXvVvrI0Ly2QONdgLZuuvqokoxq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e/fn7ETH2LDR1jGDPlYfjLGHVF7cS4P1DQjkUVaD1nPfeJs8T7EB4kOaB0DOJTA+G
	 CIJ/XkCXlEUibYpX9WeiMX4ynkgSAPar0hZZ9lOHFDY3SGT2gMLlizUFZ7VjTdMNw1
	 7ZhnwlVwMLl/KL/dtBAR185tDpa+EnbJ9FcK5f5BgvoAsH6RhqwfwD0mYiY1psSnkA
	 vFzwloQaphsvUl3IRufWWmHiBSfqlgBn2ZM4CNXRb5UodQPZEGx7aCQAcYXsNXTcHJ
	 BsbwDUg9/LiUIOx25I0CUIhhLYVgYyw7F2LiZmni3PjvRBvuljNC0PDwuOmXtnmtrB
	 jvG4rhhIJmlvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 557C340CBC;
	Fri, 14 Aug 2026 14:56:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98E3F23F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ADCB40AC0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2o1C2QFEb7V for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:56:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 89D84400A4
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89D84400A4
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y/P9XNpI
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89D84400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:56:49 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4a45b3f0becso682815b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786719408; x=1787324208;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9qYUMqZl5+gFxxVYXvVvrI0Ly2QONdgLZuuvqokoxq4=;
 b=Y/P9XNpIWcbEGzGVrwVd/WDIEYh+Ea58kCusgRp6lnDTuNwcLvfbYRGn7cweH8d1eH
 BmVCI6SFSJQoaVz1ItDWxSUXvxJa41efsw/7XYCt7ynTNAqM0FXPeAebpVZXHTY3y8kj
 hbwORqFZqnFfzFs5JlE4ayzYtiofPQ2YMct9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719408; x=1787324208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qYUMqZl5+gFxxVYXvVvrI0Ly2QONdgLZuuvqokoxq4=;
 b=UM//4By8tqStrYZt32Lk06qX4UnWxWA8j+5Jau3XyJMhv/9dFiQ8jpCr/I3YT0HZ3+
 9w/k0914mlzZmS+XKHz18O0nwHjmAGNnmcEC79REfOmBq6S6Gs9GwPQS0gTQdmlJ6fa5
 R5JdKjC6rze37G9gM1Z9OU6Jt4uYtQNjxp+PO1rjLGOHlblZexz7PPWXd3aB3OlwzJe+
 uaPVG/pQr/4CrGknVVbjNKazg15hQ6gbGVziejIuMwnqbP46aKGuCSE9Qoh8eCkSfHKO
 U2jVdPlD5mqQEGgxcgXendtLJoWej3Q7KkU5yMu2tTCzdi/00/RKWh1zGppSJl59beib
 FPDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp33BTWkmcIdJDPme6RN9v7bpaMUFhu9Rhi+TdwYIXcnZTgEAo8GqPDuIq2uP2GETLqFNL56j8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz/UHy5XC5rH7HC3qyiMjbWcSprOu0ymNXzzyERxSOF2KCicsZB
 sqmkmpDZ6Pd1N7sjhzIV+KYABSGHoz3JMLxRNhIGac13mq+v9SgB0lUo/XadOH/Odcc=
X-Gm-Gg: AR+sD13wBftHA8y9IXN8oOlN4myg3400xb6f3FYKJyaa8lRTYK/iDjCDHYM5nhv1f6B
 mFs1CaM11eMAZkl0PDwZmlOdkmBvqB5eoomq/7W5OXLXjUgJ2lHC3CXFwz9Kezoqbg1iYSYwwpH
 LS2nsgsyQTUMpB3mHyA4wh3xhcuw1/p3sgNSEAr+VhIBFH6d2gjvY77e8s2eRJoQJqYY4kD2Oh3
 sr7R1o55qB3qOvPbjq05j0Jl5Ynzz07V55RXU09TCtgfVDhkY9p16wJ/7wscDert8wpZ1T6842/
 tPuLPdJ6UrEKE5UpdXGx/OpFk3lWfUVEFvAsamribagom3i1riqrJMGAc+Oye9swTAl/I7NFbWL
 FIryPxQmipQR+ztCu4vaMXfyIn0u+APLLLVBOTrmRRT5MIcw2/cvVTOlMYX08oWfTqc5jHZ/Hui
 Ae9Y+ZzNp6rCJ2bO2T4KnMMnhLAVOZVOtIz6NKPRlO2BfRIdBpjJqrMS3bsqmS55674Y5OR9Hxp
 gd3pbTlfhM/1eBjv7oDhW2zJ8sciaf+1LdUhxWcLztsqpKi0N9TSCPzr8U87vhfRFUAUzvL7BD/
 CPxSD5AmJQ==
X-Received: by 2002:a05:6808:1448:b0:4b1:b83a:5878 with SMTP id
 5614622812f47-4b241e8215fmr4791744b6e.14.1786719408303; 
 Fri, 14 Aug 2026 07:56:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b24d8b0babsm1057017b6e.3.2026.08.14.07.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:56:47 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:56:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Gokul Praveen <g-praveen@ti.com>
Cc: n-francis@ti.com, a-nandan@ti.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/3] Semi-Falcon Boot Support
Message-ID: <20260814145645.GJ3297518@bill-the-cat>
References: <20260814102153.44487-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GZki66K2C8fMUMdo"
Content-Disposition: inline
In-Reply-To: <20260814102153.44487-1-g-praveen@ti.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--GZki66K2C8fMUMdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 03:51:50PM +0530, Gokul Praveen wrote:

> Semi-Falcon Mode is a hybrid boot approach that bypasses
> the A72 SPL while retaining U-Boot in the boot flow. This mode provides f=
aster
> boot times compared to normal boot while maintaining U-Boot's flexibility=
 for
> kernel loading and system configuration..
>=20
> Boot logs link :
>=20
> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>=20
> Gokul Praveen (3):
>   configs: add semi-falcon mode fragment for k3 devices
>   arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
>   doc: ti: document semi-falcon mode for J784S4 EVM

This is just doing what many other aarch64 platforms do, of skipping the
SPL phase in Cortex-A because something else has already done any
required initialization, unless I'm reading all of this wrong. So my
feedback is:
- It's not "semi-falcon", it's just "no SPL". Naming differences, if
  any, should be done with that in mind.
- You should make sure to structure this so any K3 platform *could* take
  advantage. I seem to recall part of the rationale for the current
  approach is that some variants might only have a little SRAM (512k?
  256k?) while others might have 1-2M and so easily fit U-Boot in SRAM
  prior to relocation. It sounds like this specific family has a large
  enough lower memory bound.

--=20
Tom

--GZki66K2C8fMUMdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan8smAAKCRAr4qD1Cr/k
CltWAP4qP5fbSgqS+QnEdM/d3dH1A+lmHSp4MhwDXMHk6q+GGAEAmXxZ5cpvLVmB
1H3QxyuM/dJ59CO8zcrMMKqF8yx8MAg=
=NT7e
-----END PGP SIGNATURE-----

--GZki66K2C8fMUMdo--
