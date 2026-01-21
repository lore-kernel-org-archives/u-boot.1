Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD632C44502
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DE48341A;
	Wed, 21 Jan 2026 10:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YpvZEWVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80ECB8397D; Wed, 21 Jan 2026 10:44:58 +0100 (CET)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8EB82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2b1981ca515so6864334eec.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768988694; cv=none;
 d=google.com; s=arc-20240605;
 b=WlWl09k2tTEESOpVCEPVsQHiOeobeK7oEg/NqrwHsWdN1EQs83oTwqTCk+RXIAntTw
 U6KUZZJtjpgjbyjSIMZbfe56E8Yi2GnfzLu+mjBViwnuHgJb4GtApFW8ubNtTUYckrKP
 E9gyDIIpDRQmRDtOQ5Q4SF4An6VmLfj82XQzdoe3wEmPGGic612gFw39BziKoRyfBvVo
 2U+yCm0xzfNCBAw3ot099O542lgmXm8H0tPeHfvexMPqdw4wAg+ovUSY7Qn4MO7fGAAq
 AzdQw4dpgIgk9He+f/jn7mUtmkYWhLryX2qaXuItViJHt6f5EJsZb8s0e0cgbBtxznPy
 v7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DJKPrs0o5M5JzNmQe2vP5/JElwAOsGwt9Jb+6Nx7DaE=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=Fel2tV94+IrO2vOUlH43Ak8DvGBdOkqasiO7yUcYuadyxKRWiI6q8087stH6gN43wQ
 PP/AOz7HAGHBK2WgaoKmMR1uDvBZ7G5JRvL23wVOgnhyymcx+rvoeA3qIUiiNJldHbr7
 ah+n1716gfdQxpGnd7lwBUjO1AjYawkbiSLEi19D0wal0/LWBgaZGkGVAIvVkqWFrWsi
 j4ovN25Q62Uyp5ryXz4JtL0TD4w1N15q64BuI+998j2Ky78AOHKPXAv82mVQuzRw3Rnx
 HbGgKblLSDRLn0EzEMCkvP8tnAsJVmT2XnyNImQseLtGe2GV/gxy4Ouh1r3dnMmDBAKm
 zwSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768988694; x=1769593494;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJKPrs0o5M5JzNmQe2vP5/JElwAOsGwt9Jb+6Nx7DaE=;
 b=YpvZEWVYSR9wDXzwkw4mE2WLJoSVwUSKaIK5JFdVlpAGuC+bhZ1PnBHeOzyfRcF+pq
 OWi0ui5dhb/byPmwg64V13fzUkK8mB1zSZQDPC59hv4EDaiAKXIj8lzrgm2ijQ31Sn+E
 Y6KMiXHPu83Ze5s9sQTcBegsq+rT0m9CGkzqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768988694; x=1769593494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJKPrs0o5M5JzNmQe2vP5/JElwAOsGwt9Jb+6Nx7DaE=;
 b=uZ20HnfO+QlYXPyV+6XnYZ1QGYz0XGhAoownl3yylKErXUg85bEqTYoyWDsd0cwg/w
 V3HNfcUVRnNtBLW+NXTLaS6dAaC+ZUeF7VObhWAMoVakOG6nfdRLdrvgBnZ0nUQaaux6
 xMixHSSnFS4Ar3VNQgGNgSQbxICwxaOOTseu/ZWYbabsnr2uh7d1jOSNGNydw8ewBxMG
 2qaPTfaskVBfXrkQonDsJkGukPpJlP5ensR+uKGjEW6kEafj0iEISQlFnEp74ibEKhvV
 uATEBfDIbCHcniiW5EhY5pGryz5hHbeltLV0P2yWALrNqqQ1ABl72ZUWPQjbFIQv3S+x
 r1ng==
X-Gm-Message-State: AOJu0YzrS0DZOCnL8wdY3Mdh9TW6wOBGSjw6iWiddxd745UIySQTB95P
 AKYbU2LfDI3Iy+1i2Xzh3NFaR9VQbMQN5V4FU18iz0w2rIKn9x0YwEWpyOvaO508Upsznx0YFB2
 UwlM48fGtxkN1oxSMTxa0c3NvVsGgHRwSyjaIMMr2W7nIdtNn7nOM
X-Gm-Gg: AZuq6aIAfEgqjOeLQ6ajPK3ofsXwWf7OB/yaPQnwdNNTqIWyiX363zifdhJR4GHehvg
 kkUklcecYHEeNX7lZrbi7LxTORC6KzFNOeb089WBwvpsaWCWpMFGhAtS1XWtNK/D+lQUgf2GsJS
 VEPlIhYCEi4+4bLSSLoeAe8uaLXiieJsQQh6OppOCR8VJ3lhv9tuFfJG95EwWW4azN/VmirPVeF
 tgOwuU7Ni8Y9pv+uaIXNXXXOEDPT0kpSZ/yHtKqLPih9zUQ9ijjJlrHCOG7PMaAXncJBIMVnEbp
 fQBzw3kjx3fl640MgqkS1ca8gqdLapPTLCxMYA==
X-Received: by 2002:a05:7300:a18a:b0:2b0:520c:df62 with SMTP id
 5a478bee46e88-2b6fd766d45mr3827155eec.19.1768988694507; Wed, 21 Jan 2026
 01:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-3-trini@konsulko.com>
In-Reply-To: <20260120223405.469050-3-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 21 Jan 2026 10:44:42 +0100
X-Gm-Features: AZwV_QhooQhGaUOZHzV6hP5Ck4uZy7ri2iaq6SyZgEv8Hmqj012mMgmnMu1toqs
Message-ID: <CAOf5uwkkkehBhMdHEKwbr00DCDJ2B+qe18kBRUJ=chox0NKLLA@mail.gmail.com>
Subject: Re: [PATCH 2/5] doc: develop: process: Make "Work flow of a
 Custodian" a subsection
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom

On Tue, Jan 20, 2026 at 11:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> Make the "Work flow of a Custodian" section be a subsection of the
> Custodioans section.
>

You have just a typo here

> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  doc/develop/process.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 3bda5e6b51dd..f436a98433a7 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -233,7 +233,7 @@ feedback to the submitter of a patch about what is go=
ing on:
>      apply cleanly.
>
>  Work flow of a Custodian
> -------------------------
> +^^^^^^^^^^^^^^^^^^^^^^^^
>
>  The normal flow of work in the U-Boot development process will look
>  like this:
> --
> 2.43.0
>

I'm fine with it
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
