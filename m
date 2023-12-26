Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12CC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD3A8788D;
	Tue, 26 Dec 2023 15:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jB8hjTAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF4B87895; Tue, 26 Dec 2023 15:51:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2563E87849
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e266e8d39eso36279937b3.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703602284; x=1704207084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S1KtHiPZfcPiBztCh3tYVXlrm9+SkhWRUYc6QSeBNas=;
 b=jB8hjTASI7IIDL7EL+G1h5Z58xybb7xXfIdDImsXf7Zg0ztyqKi4lmcwRX7GVFzIZe
 BBeQ7qWFyXjAf2SocUKW19Kd/URD1Xa4uWTvNvxqQgVj3I0QwktSh48iGXQcFhwsR5hP
 GSVOZ8khQgfoqSdgEEiCCpvPDwPrhluREcw1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703602284; x=1704207084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1KtHiPZfcPiBztCh3tYVXlrm9+SkhWRUYc6QSeBNas=;
 b=DHiYYUlL+lzTPFkZBhYaryW5vf7nS6TQUVkysLBykgo4l0yTNUuYOtfFj6tGXjx+Dv
 2LVLGmNuZsKwcZImtgLyPHaIlUvlRA5Q5BcYaI1zFxr3z+aIWOQir5ThsG901byiirsC
 RrJzUtPFTsziUUNYKBOhSnOe9gGemm3XnkoJnNE54VMn2gnSIyHmIuziFea8BfaCRl+i
 CneHsoSA1H4ut0oua0ttZN9/nD7YVz9dicI7TRcc1OD3Tdslybobg0vBnfiWacaHncZL
 agnLL7LXxIsIr4qYXZfso+huSIWuKfqQXsyDpSmdRKwKfklfL+ezCwUyOgVw4Hen/NNw
 S5tg==
X-Gm-Message-State: AOJu0YwCyqM0HNgy19xm4d9VV/7QsjYQSf0t6rcNkFsVbi8cowyRPiZM
 ZL9L3Q3Wt//230xSr9f084gNT/FfSVnWSKyZcs8cQmLxpQM=
X-Google-Smtp-Source: AGHT+IHZ9B1olurBW8ZbE1lKsOM3+SNFX0suHdu29YvTctcWLr/5qnm5r3ZEOFGiFu55wnn9/vGtjQ==
X-Received: by 2002:a05:690c:4713:b0:5e8:2db6:3eee with SMTP id
 gz19-20020a05690c471300b005e82db63eeemr2581502ywb.1.1703602283752; 
 Tue, 26 Dec 2023 06:51:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x84-20020a814a57000000b005d6f34893dfsm5469477ywa.135.2023.12.26.06.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 06:51:23 -0800 (PST)
Date: Tue, 26 Dec 2023 09:51:21 -0500
From: Tom Rini <trini@konsulko.com>
To: sploitem <sploitem@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Fwd: [scr1564375] your CVE ID requests
Message-ID: <20231226145121.GL2652760@bill-the-cat>
References: <6581d54e.ll82lGTmJx9oFRYQ%cve-request@mitre.org>
 <CADk2PNOxKKTW6n=+49j==rRKd_xNqG7EP9Gw4BO0URi1V8BWow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4B/FPiE9SMwB4p6k"
Content-Disposition: inline
In-Reply-To: <CADk2PNOxKKTW6n=+49j==rRKd_xNqG7EP9Gw4BO0URi1V8BWow@mail.gmail.com>
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


--4B/FPiE9SMwB4p6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 08:07:20AM +0300, sploitem wrote:
> ---------- Forwarded message ---------
> =D0=9E=D1=82: <cve-request@mitre.org>
> Date: =D0=B2=D1=82, 19 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 20=
:39
> Subject: Re: [scr1564375] your CVE ID requests
> To: <sploitem@gmail.com>
> Cc: <cve-request@mitre.org>
>=20
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
>=20
> > [Suggested description]
> > Integer underflow in ipv6 net component when processing incoming packet=
s.
> udp->udp_len is not verified before substruction leading to large number =
in
> len parameter (unsigned int). This can lead to DoS or code execution.

Would you please submit a patch to address the issue as well? Thanks.

--=20
Tom

--4B/FPiE9SMwB4p6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK6GUACgkQFHw5/5Y0
tyyM6gv/epyMu0gWHI4i8NBAkXZdlm7yyF/FnBNqL4xhJBdJrvxrxabN40dJNBgY
tlSGf9xZ4SgVAmYPwopoCxfQZjyYi9E5Bq4z5ozsrNTGglA7KfOT2Fs2722BZZqg
jO+DYu6QBfYQJvZWfsYW5XodMasJYLfc8TKhU6JJ9DQPcQ3mic0FkyTdEKj3hnmh
aQZ1WbDQjjQqCDQBXeFKEjTBy9j9wZpOQBgEGa2qRMOBtatJhjsNufJ3EdUIb6xB
7CrwkKyBCG4S6VbHODNPotg9QW0ephm+RUwIOcuhhr1wCVbPufmPUTUyqNRtUt0t
H7nG/LcXyE0YxaiFB3CONiG/A+Nl6SeOnFZiXUyFcOOXQ2ZTHcmlCUYTsx4IpZMb
7ygh7DPSmqL3BFsZSU9ecTRvcg+BlhZdv+v9697zQxh+WBFTwyXbF9F1mE/L5Jzi
L28/dI0dPI4ja+ahApzgZqZot5UdQoL5MVlOT3soclsg62ydTpmyP7ie+YfaIPof
PrPazZ5D
=nnZr
-----END PGP SIGNATURE-----

--4B/FPiE9SMwB4p6k--
