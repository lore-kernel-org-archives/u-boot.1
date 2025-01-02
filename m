Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9B0E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F2B8007D;
	Thu,  2 Jan 2025 17:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KPKJlOpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AC280196; Thu,  2 Jan 2025 17:13:20 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0228001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 17:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d92e457230so111374816d6.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735834396; x=1736439196; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/zjH7fUlDpv0DmAm0vf7+hG1yFc41QyIIVj7vdqyNL4=;
 b=KPKJlOpyj9Z3po37FaZHwF3rG4p5RQBfR2Mgp296a5IdEVvDzf53qCEliQ53DFZRFt
 lmxXK3p+JEO+CJMVGPEyRgbrXIOR+6FceWyzhcwm52hC0B14yDFyKr6SBymBBkRs3BUp
 SZk8NSFgJZ7FKx7IfSJg6xYCtIN/JewtAcpJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735834396; x=1736439196;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zjH7fUlDpv0DmAm0vf7+hG1yFc41QyIIVj7vdqyNL4=;
 b=JXi3DtwE6TBTvPRog32LGn/718Ga7fc5ROcF+7pNTgaWT2PjM62HUGHsbpAwbO3GYo
 9Of/2R5d8D8+Hw8qX20rdEwFx+XnChceBFwZzCEH2JWHwlt9lHQEObs+C7vC0fSGM9X3
 uc3UjScaE7ZSOkL2Wf65abM75gpr9hSktFO7KIwE4aiqYEoUU5FxUho4T3PjYI1KFhQT
 bxh2sv3DbPpVGUxdbnG7RPDsZJpNVMZUP3cMhin2zPs/0WIo+PvH2FYhzN0BxAGKe+Fk
 lJAd+BlnBLtaqUqpq+TcIwFp0lDnxuMCwSOKwdsRsMLVRDBwLbFpJMTPheJqGJC4xH12
 JnmA==
X-Gm-Message-State: AOJu0Yw7ooVfo131sjsez4r1rFtLITux/YtBeKDAYlxlJjyqlv2Bbd08
 mikC+ivJLfxjpxn16wjJdyjYO2ZtzwcArT6Q06Ga30Sq10CED6sA/zO5LFNhwCFMJUgf/b04jwe
 xMoo=
X-Gm-Gg: ASbGnctgPUxBRZZP+2VIC1SnhUT85rpkHBFGqXrdZ0wsGRXuznY8OeT9dI+6rCT22HY
 LFf+qt6tq09qmH2CEIakScftAFPi0mZcVw6Hd1O8K/f6vIWyHoZq0UlTY2h8RSjBx3XdhVhbSqE
 jZZ87q8pOk3Ey2rbotXkOHeA7Z9Nj+Ry3MhdPPa2h4rJ2EA2yCT36orF3O43WI74gleWe8mpXOr
 JSXJX2XHGo9m8A1m/vnddSnwzV8/cI9rYBeKhDywdg5ifidecKpzha0Ew==
X-Google-Smtp-Source: AGHT+IFDtRttw4wi5OzHXEWtvXyn9450CblMyu1XoQKKB3CN2JEwUw3/Ky9zMC7zSUPir20wlsysqg==
X-Received: by 2002:a05:6214:d8e:b0:6d4:36ff:435b with SMTP id
 6a1803df08f44-6dd23345b2fmr781026596d6.20.1735834396661; 
 Thu, 02 Jan 2025 08:13:16 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182082f0sm132930866d6.129.2025.01.02.08.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 08:13:15 -0800 (PST)
Date: Thu, 2 Jan 2025 10:13:13 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Simon Glass's future with Das U-Boot project?
Message-ID: <20250102161313.GP3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vEnyDvTZ9ek507Pp"
Content-Disposition: inline
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


--vEnyDvTZ9ek507Pp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

While I had hoped that the quiet of the last week or so had meant that
things would perhaps return to how they had been before, Simon's large
patch series and then comments on the TPM+bloblist patch have shown
otherwise.

At this point, I do not know how best to handle Simon's behavior,
without soliciting feedback in public first. At best he's created a
soft-fork of the project with his "sjg/master" branch. I've asked him
repeatedly to explain how he thinks this is all going to work out, in
public. I've had private conversations with him, but I want him to
explain in public. Or, he can post the messages if he likes.

And I am in the process of getting outside help that would in turn be
able to help the project move beyond the BDFL model we've always used.
Because at the end of the day, if most of the active developers would
prefer the direction Simon wants to take everything in, that's something
I can accept. But what's going on now is towards the worst end of
possible outcomes I think for the project itself. And by that I mean,
one prominent contributor steam-rolling over others and doing as the
please and implicitly acting as an authoritative voice for the project.

--=20
Tom

--vEnyDvTZ9ek507Pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2uxUACgkQFHw5/5Y0
tyzUcgv+JJ9+joFar7gtuRdRbvoibXFv4eQbuakCeS6RgB0rjFpb97dP7/tm3HM4
E/wkRlYsohXmaNmbaDnBJsAzsQDl2j2Mdo7AFOfRAvHsIjKwciSJO1PIQgaug78I
DybOfhcibpoGahOJXAdXStnvTGR8ecsFsdDk37fVpwWrrOxuqtfeD2OWms5VsqG+
QhSxjp7hnPY7jqK6cnTc1IyRmIwwq1YWJf6VXzngMGncFI8oKxp2zzUbH3aeLzTd
iqR/7yK3BmdkS1KRw+9VgUL0V0kVLYVXGw0SAmhbmxij/wULrNDpQgfOyvqsxUCt
DwbpbjHAZHtl2BXpBQiBVPpe632Rxmf+gvi1Td5ntDtQnIHNb+N0sw1fNjT34JhX
Zyu5H/wXNAAMXd0KkKdjOL/X2blZ329wBRgn1fs4GbH0sVQd4VMHxhuJDnBA8fE+
tpt2zpIGUFMj2oPhrDaUCRsVHdQA0qN67G+SsJyRzO6F3elIg2AiB24bPoDGFg0W
ZMO3Vmar
=4qjR
-----END PGP SIGNATURE-----

--vEnyDvTZ9ek507Pp--
