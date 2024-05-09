Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC9C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C4D688140;
	Thu,  9 May 2024 16:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cTX81RQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EC088113; Thu,  9 May 2024 16:53:56 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB9D880F1
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43ae2a44963so4193791cf.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715266433; x=1715871233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fyRqssiam4XeNOFb/IJTFtPb5asNVCzlw9W2jQ9qcjk=;
 b=cTX81RQU6PLDKJqt6MPYhRtDLrPp1sTfyrw2wEgYVHjAvCKrSOuApZLy8yX0Uf0A1R
 g8RC8IqJmpBkG4VqiTbuxt/gb44ID9eQM2yLgZTU2f8mCEVqbBt/3iolaru31R4MmGGF
 D/bzwk72ys1G3C7tRcnMPUxk96UPK0nbSdvmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715266433; x=1715871233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyRqssiam4XeNOFb/IJTFtPb5asNVCzlw9W2jQ9qcjk=;
 b=KgU4UeyCUkjN56xgqGyfY1Uc7AGGxewPoWoFGoMnQwKw4/YuiiBN5e0ow1sfd6Nq+O
 ML9jj/wn4HoMQKUdpnvmrzzwUohZb8uqJEuauT0IqJxJNmq7Y1db5DyuVdWPqaZvPbJ7
 lokj56wI2EQc0yMCr4XEas52LwmJpFaKOv2ZDLtZXKkioUbIOxORrpSNUf4tBqkiypf7
 xZHy4v7XbImTk5INbm+5qTX8vJrzlENwf0DE/poWiW7PgLaxcxsq4E/X9ZonaU507Yz8
 MnlTBLOYoGbsT2y0tZAOzOLxuB8caeSaY+DjVrXkJNzOH6awsJ/jG1TI2U/lfPtpeiZJ
 5DkQ==
X-Gm-Message-State: AOJu0YywCQ6MmYL/0CXJ8M1pW4ikM8exNGQamfTcxeSEp9IJGNczDbjS
 UOqo79bVS09oPPdUE0jmZHis2HzDDQl5MAPVBc8k7Qv/zpvbSxutT4cgJzWgoQg=
X-Google-Smtp-Source: AGHT+IF7BLXWzIWKK3ujvzkOpcUb8Bl9pyWaHCOsHuf+ky3BUzNvw/YBCKpqByXBvKNp6DmAEdtbiA==
X-Received: by 2002:ac8:7d07:0:b0:43a:f7fb:9698 with SMTP id
 d75a77b69052e-43dbf739d8amr69248491cf.41.1715266432841; 
 Thu, 09 May 2024 07:53:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df550c10fsm9126401cf.43.2024.05.09.07.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:53:52 -0700 (PDT)
Date: Thu, 9 May 2024 08:53:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 2/4] efi_loader: remove redundant hash includes
Message-ID: <20240509145349.GH2568172@bill-the-cat>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pspdGSRAzoJGGk8t"
Content-Disposition: inline
In-Reply-To: <20240509143743.1496210-3-raymond.mao@linaro.org>
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


--pspdGSRAzoJGGk8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 07:37:39AM -0700, Raymond Mao wrote:

> Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
> and u-boot/sha512.h
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pspdGSRAzoJGGk8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY8430ACgkQFHw5/5Y0
tyysqAv+If08VN8rIg85ebh+wEhsnQDYx1cbp9OEEIWwEdAK/ZN1UxW/e/XSUIw2
vqzrsIwk7BzXwGXepCsUc+Po4zro7ks4XtSwS/ZkapnCRUePKXkiqqZdLmP/7J+p
0L08TdX+t+wHdntFrfwtHihMHRG+U7Kk4Iazd4mwaUmZd+JgSiY0zshjUwB20qDB
+QknbH/Suuyz4vHDksxW0fXQAcYz48AMIo6LMb/nJSwUtsEuB6lEAK48WqgLgg96
kKw5bbpZvyC5MLO0RiMK0UGQsNr28SzkBdm0GG10ZtpE72nyp09L6tsVdIBSQJ+P
V8eHwrTa+Cfi2q7sNcufyaVEMXtXnP7mKfm1CoPdkSGvsBr/Di5GBheY7hjPvWIn
Qd0UYdzn58MgZDBHN/H6pemctQ4pZYp4y2fxWxncrjty/rfDQ8rM/hZg3yyzEmQ5
XYEp9Wd7dzcL7quYsE2N94F4svq9dgANwdVMx/UvXfTvTX1eWFSDZUFFKEWbT66q
+Q3C5LJN
=C7wr
-----END PGP SIGNATURE-----

--pspdGSRAzoJGGk8t--
