Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF234CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC75486E2F;
	Fri, 13 Oct 2023 18:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMQPwJFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32FA586E5E; Fri, 13 Oct 2023 18:45:52 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0427386B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59b5484fbe6so28759497b3.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697215548; x=1697820348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f4VxW5WrU9F6OZpYchPmDf5BOEXLwyFypu5Zas43Yqk=;
 b=FMQPwJFm3CDSC140QHR+6fVB4koUjUmWBthIH58/JqI5Jp7FjbYqZsZlbFBDcU3sRT
 utN7WL1Wv94MtgOmsxBcyJMTNJ+w2pihTMWIaMhpzBu4O2/tkpQLgAYkX5XcKwu1sCAz
 2T+bOhOpqFT/+fElLP/H1LK8ZezGteDaVW5eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215548; x=1697820348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4VxW5WrU9F6OZpYchPmDf5BOEXLwyFypu5Zas43Yqk=;
 b=h7tQJz1QAeezR6Piqb9kxaFRtKJfr+eWOitqdyWj2bsGktHN+nqG6M/XeJKAMiu8bM
 yPkmm1LBkYsthz+0BmmGpAxbN4PDV91gSH7SIYZ8a6eFFXXjJjGUG0OaDIuj084kiC85
 R0mwihFDlbSwEAUUyoEhbjmyrGJpnrQQEGboy6gnGY7gFeQlkEw6fsA6ubbtkXKHDsEn
 nJZQ3wx3a3duRanBe2vsCuXm/uwHkmzhCHWJhOdzwcarXLv2tfsjPDMrulnPFJ8FlUQk
 kmQ5d7a1ckyuLp5qtKTBU1Q0MNs24RSCO4aLkRhz7KtjLqkqd6dBTF3xySO860v+KhOx
 BJiQ==
X-Gm-Message-State: AOJu0YzsAbZA7vX7dcEQX0Am3O5UUECP3yr34cJ4YDvnmY5KCMQiptVC
 Qo5pi8FZZMoJ2SHH7fFDFoLW5Q==
X-Google-Smtp-Source: AGHT+IGNPvZ5L3ninY3NjKWjd0a6H9d9YR10FeLmxBYVzc+lGlpvUAMoJOXbhl6J0lQdNJXrXW4YcA==
X-Received: by 2002:a0d:d40d:0:b0:5a7:c1f1:24b with SMTP id
 w13-20020a0dd40d000000b005a7c1f1024bmr12795589ywd.22.1697215547763; 
 Fri, 13 Oct 2023 09:45:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 o75-20020a0dcc4e000000b005a7d46770f2sm789058ywd.83.2023.10.13.09.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:45:47 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:45:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] patman: Add a little documentation on the
 checkpatch tests
Message-ID: <20231013164545.GM3119521@bill-the-cat>
References: <20231013162836.1911982-1-sjg@chromium.org>
 <20231013162836.1911982-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LryZTD/9MrkFcXbO"
Content-Disposition: inline
In-Reply-To: <20231013162836.1911982-2-sjg@chromium.org>
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


--LryZTD/9MrkFcXbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 09:28:33AM -0700, Simon Glass wrote:

> These texts lack comments. Add some so that it is clearer what is going
> on.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Ah, OK, I see now why my changes failed, thanks.

--=20
Tom

--LryZTD/9MrkFcXbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpdDYACgkQFHw5/5Y0
tyyeKQv+N27mM6I2O3a5Q8VU+vTU/0l/KJNrvFrum2rUUeIUtoJAbHaFuIUqyTgn
+yVeZUecRsyk+6xSME+S7+lViMPfoSJ2vjs4rU9icCKYzuJmVPHP2WCPNQMfRvCk
Ueu5wE0ZX0PVIxuRGxh2gKRd3YZUmMuFMnvqNKibf0fpNCVkkZLac0HKLeWljcD1
sCoi0grNZy7noVpizzRYGwB82qQBbWxcGcv7ggSqHNfsIIMXUH2jRnaA2MGsToBs
QlANCzqaz+9+Q0DqCVlWm15X4IqA1djYiRIwZgwISuL2tS3M3dWnI8evGvPicke7
HRmiSdwI0SanmA9J15dU+Dd3lz0z1z8yUOp+nmMHOfMmvduxhqrmeQEqrnNorVuF
sOuu9pRAHcjvIlbMZu9hCO1ppwUJw72873/NtAbI/5YbCV5W9eC84bxQa+juO5FX
NApul+xD9EeLv7SQbSSyQKOEWKb/4pL9xjBq6akR7iK4la6zeKij7Cjre3L0P+Xq
vndlVo53
=SnUf
-----END PGP SIGNATURE-----

--LryZTD/9MrkFcXbO--
