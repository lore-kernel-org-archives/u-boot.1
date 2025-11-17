Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679FACE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 08:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D041D83B0A;
	Mon, 17 Nov 2025 09:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NlLP1Wn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0036283B0B; Mon, 17 Nov 2025 09:13:44 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C486C83AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEEEE601AD;
 Mon, 17 Nov 2025 08:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308D7C19422;
 Mon, 17 Nov 2025 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763367221;
 bh=sqdh/wWGiQcYDQhImhfQxomJazYkFFRjfr8PpFFAAqg=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=NlLP1Wn3LPnoGe4x6HWe1YJSLAAOIgljx1kwboK3xQc70tCkCFq7fnLOvp0QT9xhc
 oSYNv0KIBgYCyyiP6oAnrF3rQurTbWR7D9iXlL5QPS0jT0n2JMSUbJv3s1QGoR0XoD
 WlGwHdzLFEYIhq48B7/E/Ga85RxitE2ZXJmKwC7loWVX5VKYzjal8NjJFKv/9XQUZm
 EzBkM8wx+iwi96qESu0eCmy1tbSdVWT5x4fQqFhk8HjQ4neriMyrJPxhuYiiUSL9S4
 NBfzqxvjvD5Ao0UCGUTK/T9XnJ4ZpXKJbTkwmJ2mhuZ8mw5yysyp1DnWE0p5kdRjit
 79fgJijz9/u1Q==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=14b8c9c0a0d591dc54135ca3892661de7aa14fce5e6976432dd1ea6bee0e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 17 Nov 2025 09:13:36 +0100
Message-Id: <DEATIC39P9JQ.24GJE4VJJVRSB@kernel.org>
Subject: Re: [PATCH 1/2] drivers: rtc: add PCF85063 support
Cc: <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.0
References: <20251114151255.2008694-1-mwalle@kernel.org>
 <20251114151255.2008694-2-mwalle@kernel.org>
 <20251114152236.GB6688@bill-the-cat>
In-Reply-To: <20251114152236.GB6688@bill-the-cat>
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

--14b8c9c0a0d591dc54135ca3892661de7aa14fce5e6976432dd1ea6bee0e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

>> +config RTC_PCF85063
>> +	tristate "Enable PCF85063 driver"
>
> tristate is wrong for U-Boot, only bool is meaningful (and I need to go
> update checkpatch.pl to complain about this).

Yeah, sorry, This was a copy and paste error from the very next
config entry. I'll fix it in v2 and add a patch to convert the
existing tristate to bool.

> This is I assume otherwise
> checkpatch warning free and compiles on sandbox?

Yeah, except for the missing maintainers entry.

-michael

--14b8c9c0a0d591dc54135ca3892661de7aa14fce5e6976432dd1ea6bee0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaRrZMRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j5DgGA3HWgH+zR04WPVmgD1zAkM7WBsL0AyT66
h2Tq6K2nxkmSLOe9K/OF7JIDCFl+qK42AYDwCIpD5VGhr/z83nPCOG30UlUXw1y+
YW3i5bPVStDpJBYzXqvWJB/mPSHhusuGXn0=
=x2cr
-----END PGP SIGNATURE-----

--14b8c9c0a0d591dc54135ca3892661de7aa14fce5e6976432dd1ea6bee0e--
