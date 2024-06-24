Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D96C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E29988403;
	Mon, 24 Jun 2024 21:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A88ki3YS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF47E883C2; Mon, 24 Jun 2024 21:30:41 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53A188403
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7009b8113ebso2027091a34.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719257437; x=1719862237; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M4Pydd91BzW5yBemycokvUslaOTHoLGdx/0Mtqjd9Cc=;
 b=A88ki3YSOp7xZbWekkFfz7TIbIeEDJA+A3fu2V7a4P3u8rRh88R3RKIUk9/N1UdLtY
 c5QfwosjBpcXGdDioyZLj/y50AdYxdHW3ayQkUI9cY74VWON6ewJWRN8AyyHtD6ovcn9
 QVOLfvA65pffSmOYiYeb+srmNuoVVtFlBaGIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719257437; x=1719862237;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4Pydd91BzW5yBemycokvUslaOTHoLGdx/0Mtqjd9Cc=;
 b=O5d2il75vcgDJc2Zj931Okr2vt5V5tIV/x1KbZzf9PZ5KKzre+5/VtMiNFVj+N57k8
 IxzaPh7s15nedDctp8UcbHR2AslrjoV6QNukVt5YQlNaWOsx4RKM5GOrj4lxNV/XGjkY
 YddYu3/EnWd0RrKCTdyY4PgMWeait2ryqSDtAi1mVz7BByJxMD7G2v4cbydgtnRK8r+6
 OhTk0kN2eEJDf0SVZZasHbnnpBGvy7CWJBg7DFAQN+UjqdTtsWh48PJRMuX29gz/U4im
 KdVwGmaco0KgmWR5qOysI4reQ9ziEMUiGr01zXn6gqsEP4+uBOnYjuE/EqueXnhEEelT
 RTQg==
X-Gm-Message-State: AOJu0Yxfy2OuDPOK73XR1WmcHKt0be3cUNPvQZH2+wPQZtdTn53+vR9h
 BGUgKR0dTvGdEMJkTe6+WH66O5TNLqLe7cqMe3YC3aFAVWqMmckkxk7iU0Yngs8UVVScoX9qn6s
 z3K4=
X-Google-Smtp-Source: AGHT+IHgH2/EPhjN/Coz3pU7zl0juOU/Px5Z885u7DrWgVwK2ci/5VQwRgWbVD03cR2OxvvWC0cmUA==
X-Received: by 2002:a9d:3e50:0:b0:700:b15a:ee22 with SMTP id
 46e09a7af769-700b15aeeb3mr5583626a34.23.1719257437427; 
 Mon, 24 Jun 2024 12:30:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c676919sm1304208a34.72.2024.06.24.12.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 12:30:37 -0700 (PDT)
Date: Mon, 24 Jun 2024 13:30:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07-rc5 released
Message-ID: <20240624193035.GK38804@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dfd/N5+VPG6nOjjA"
Content-Disposition: inline
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


--Dfd/N5+VPG6nOjjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Well, once again I need to check my calender reminders since, whoops,
I'm a week late. That said, looking at the list of changes in this
slightly elongated period, I think it's OK. At this point we're a week
out from the release, so it's time for clear and obvious regression
fixes. Ideally ones introduced this release cycle so there's less
chances of unintended side-effects.

In terms of a changelog,=20
git log --merges v2024.07-rc4..v2024.07-rc5
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

With that, the final release is planned for Monday, July 1st, 2024.
Thanks all!

--=20
Tom

--Dfd/N5+VPG6nOjjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5yVsACgkQFHw5/5Y0
tyw9LQv/SFMKDZKUj+tHsCVHcUGC82GjeFgvRqQqiwgHCz9ywfhLNyTmIFockprS
vl7+JqQYscFQi5yMqBvHS0m2tKNwY+G+lEuASpkp0f28+YMMXOOWaw3q2yvF5ilt
JjnYbwvq7eHXhbtXDpS0cXQg/yYhRVFeUuCh4RF0rKudLwwK3Jf1jXIyTsk1yOvy
wVpCHxnh5tTYMa7GcOBmzityRzuN3PH929xHQHJmpfjI3BtLEdkst7DrMwoY+3+4
UwEXdyawuIL+jXFxuo7SrCLShs7OLG6uMJ/6cuKbbab1QCc+WQprTyq5CplzxYZz
46yfTWDMFo181RTiFvD1i3NEbSUHsHpxAxQSRHfZBpBFvd+1YyZuSpCevlzDqjiV
Ey+UXyydpLmru5I12f3yC0rfMMSPZBfx4DH7iDwO54Cle1EW8gl8mOtCKGn3EEbE
r/sNQCIGjwF3RdURr1UpyEnmJySasS64IKrFfNQPOQgMMTr6cQwfMR6MTJ/5Ll1S
seX2Fxvb
=N06x
-----END PGP SIGNATURE-----

--Dfd/N5+VPG6nOjjA--
