Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FEC282DE
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 01:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB0D80F77;
	Tue, 11 Mar 2025 02:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JWl524g5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C8E81335; Tue, 11 Mar 2025 02:21:42 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7107A806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so6385339a91.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741656098; x=1742260898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+oEaG0tqfqqkQBSrCp4UvP5RaySUFM9HIaOsqI5Qv4=;
 b=JWl524g5K+XdT+7vZonnqTZgXiSPdEU9CoVuzpJxleIB1K6Us+4hQlVAC+lYpbfg+m
 Y9jKGlcJj5X0SSrN51rG9jTlMfUTVjKFMY538NF1f0lJGE4brqYVasuCQTFqCMX6+kHx
 y5xfw85I3ictC5/qSXQznTmIHtafrmiQpm8QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741656098; x=1742260898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+oEaG0tqfqqkQBSrCp4UvP5RaySUFM9HIaOsqI5Qv4=;
 b=QGaDH8grpUXGweV/NcDDnzLiK2xvsLp70Q7fGiV3jOpjYIVHgxNFDG0jobrWIUgp6T
 nDB0Rt59vPA1NH/gsqk0qqC58DcrqnQnHrjTEmjX7tFY92qrbwUPuxccApgu6Yh7QZga
 so1HAaglgsSC2vd3qQ0W4XiAZyJ9cKPKCV59Ujro3qUq98oOoa7f5Sa9IN65KvTltAwu
 nCByBCaGPvnPO+WPs6SllZzi5whV9W6Y8xa1WenPp3wOch7JuFtiApdI3NGwf68pO2ty
 Zp54oITjR6hNrm8adg9aXxDWyq6pnu3UHWbNN40XJ4w1tYV6HJWZNYZuuEBMejgtsc9+
 Cctw==
X-Gm-Message-State: AOJu0YwNIdxOhETaWBK8fUksJszNLT+CnTouxb46Ds7ZBLUBHCTGvC/8
 k1NIH6RueMmdZCPmvzxk3EN2PW5/3A0TzI7T2K1fdTUmnO/C5LKQvOId12B8zxM=
X-Gm-Gg: ASbGncur5Z+kGPqc7T7K4EnV7FtnrcMCOI1ItJQ5YPyGhwEVmqj5pAcnewAEerHFTlm
 SWUUoPkyxdU5f60/f4sjD+eLtSX4HA1zvqpmDol1sUWGMRXeq6RxLNbLruvEAP5HytezI3JfFdT
 M+aYa9xEUoSxQZsTp+pBBf3sftXjtqt957NB+hyTXy2EYbTCLoQ36HFWzqzcWt4Jq1RBC9S7CyW
 WbpXOKS2GYeHxKOvPeZy8oX4P8l5UeUd+4PU8qtewYS1stU3g2HEnbMZs7RFZCdPkks1RZjZaPx
 jIvmi5s0tAOsC8niRzJfpU1JbUVxGppLI7z19VFbeYJ6MA==
X-Google-Smtp-Source: AGHT+IHHPsJSj39dh2cX0VSRMjYK/U3PeNj/VjtKbOVOSGai9j5Izh1BMO10miq9vDD5S4xEXAA1/g==
X-Received: by 2002:a17:90b:264e:b0:2fe:8c08:88c6 with SMTP id
 98e67ed59e1d1-300ff0a9d81mr2548924a91.7.1741656097966; 
 Mon, 10 Mar 2025 18:21:37 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693e7fb5sm9797965a91.37.2025.03.10.18.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 18:21:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:21:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc4 released
Message-ID: <20250311012134.GR2640854@bill-the-cat>
References: <20250310233215.GP2640854@bill-the-cat>
 <5b90d598-8b82-49d1-aba1-c6e70ba447c2@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jXeXgiW2sNMIEhoo"
Content-Disposition: inline
In-Reply-To: <5b90d598-8b82-49d1-aba1-c6e70ba447c2@denx.de>
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


--jXeXgiW2sNMIEhoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:44:03AM +0100, Marek Vasut wrote:
> On 3/11/25 12:32 AM, Tom Rini wrote:
> > Hey all,
>=20
> Hi,
>=20
> > So it's release day and I have tagged and pushed things out. This will
> > be merged to -next shortly.
> >=20
> > Continuing on with what I started after the -rc1 release, we had a call
> > today and the link was
> > https://calendar.google.com/calendar/event
>=20
> Maybe it would be good to inform people BEFORE the call rather than AFTER
> the call ? I would've actually liked to join ...

Sigh. Yes, I edit the emails. Last release I messed up and didn't send
the rc notice the right day. This release I got the day correct, but
missed this part. I did not miss the part where I updated the meeting
time to note it's tomorrow. They also continue to be the day after the
release, Tuesdays. Sorry for the confusion.

--=20
Tom

--jXeXgiW2sNMIEhoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPkBcACgkQFHw5/5Y0
tyzl3wv8CHeYoywwen0PZ+isHBW3hIjiwjuNMVis9fA1TAY5noe39SWB5WEtQaiA
DUFI3uxdXjwqsPeqzGHBpSengT+WdlaHsWAeJuBQsz/Ea39vhjxS78R+cKm2pG4A
2BfT5LAWlQ9nWalZwX+sGxp5/lIPTRM/0aizFWaFeYhBfmz2kc9xZdBG6Coq6baH
wdalJMr9barHhPl/8Vqz/tji8qRLd0attB+XQZ7jXL0sqsfP2IDDQ9ZWQIx/eL/T
oCPm7Jl2feiamx4XQJTAHKATn9q/Mszhc2TLqLWdSAu78ZDNj8GiX8nuMQNXBsH6
aUj5dsDz2gj9DaKvA4wCq3KN2bhQ0tr99kYSZkL7sTlUsnl1k1Jim3Lf6CaG0zDH
9hNmXjcoaNdbv41jIcfPpjIWv9OjFzHtdPMpLysqii9JKNOM53FoQqBXm0RZ05ja
9EwIWwwAgMwhMr2uzBSArRLFI+LeWlg3h8QzVnYfm/P3MvIbb8O+oeb3976lLn9c
LZOf8MxX
=Ms6J
-----END PGP SIGNATURE-----

--jXeXgiW2sNMIEhoo--
