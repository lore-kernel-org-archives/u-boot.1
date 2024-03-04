Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE77C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5457988022;
	Mon,  4 Mar 2024 16:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IwHrrUJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BFC88011; Mon,  4 Mar 2024 16:27:18 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 711168800F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-783045e88a6so360979285a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566033; x=1710170833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C4rIry90wvKn/waFRN0MS8NnS2poUdgIUUXlQOllbeM=;
 b=IwHrrUJmjNEEtWrqd2UvrP0L4Ny/bOkwVfbI2dsHKSeJjKs9GTxda7z+kIAkiACkcY
 GdkwTwaspPh4SUkiE30KCk7jByWPRL3ZE1TLrWXURz2NvExYyxup2g/JaBlxXWXIWjoP
 rfWY2EPv9JjHIEgIA099NzZPFdnahlIjs5Ecg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566033; x=1710170833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4rIry90wvKn/waFRN0MS8NnS2poUdgIUUXlQOllbeM=;
 b=DtZcSoqFrcO9m6fzZY46cA9ag9IB23o7l0MYGCc4E/Hh9iCE3wcxykYMOg8NSIMPRu
 3W1E0V6IRM7jNtVN0djFkoxWCQPGWDeN62314cnggdng4AfoCHNGDJqm5e58dMi6YdNd
 fXp6vbqKP0aaAvo8P6HxnRqum/+zXtr5dk9ePe1bjnITeg/UASn3EO+AHMnMc6xUAzfY
 z6svw0KVMa4QB9ExM2T7MTITBSiDAT+YIgSm2Uyc6qXrtvy7O635ikpCBcwD5nachuTp
 WB3edmMpfud7yNIqjgaofHwnMP+MkDRu3tetF3koeTPTkDj8DYR0H0g98C2a0+LpJRaT
 zBJQ==
X-Gm-Message-State: AOJu0YxexwmDTA8HqaVWyx7qGbeC9LYXfsV+uwSB82bPCrHWto9KS387
 ttMWhoz6y3iqYLHrhrsqWTOFhtWMJt85HiqXH+Iy6z/NwgUgJyvr3+RdRKSVHrc=
X-Google-Smtp-Source: AGHT+IGR16xu0U/yKj8vi8oO4faqN3vZSpb0JksXJY/bDhAagH/2FD3SIfV/meOM4/c1+ZGt9/K8EQ==
X-Received: by 2002:a05:622a:182:b0:42e:b2c3:d77a with SMTP id
 s2-20020a05622a018200b0042eb2c3d77amr10504457qtw.46.1709566033541; 
 Mon, 04 Mar 2024 07:27:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 w23-20020ac86b17000000b0042efaec307esm124148qts.52.2024.03.04.07.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:13 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com,
 neil.armstrong@linaro.org
Subject: Re: [PATCH v5] test/py: net: Add dhcp abort test
Message-ID: <20240304152710.GP1523872@bill-the-cat>
References: <e603fb51b11cb4c29470a44d4276ace356ce7ddd.1706599828.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zivw0zKJ7ZQFxDFN"
Content-Disposition: inline
In-Reply-To: <e603fb51b11cb4c29470a44d4276ace356ce7ddd.1706599828.git.love.kumar@amd.com>
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


--Zivw0zKJ7ZQFxDFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 01:37:01PM +0530, Love Kumar wrote:

> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Zivw0zKJ7ZQFxDFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6E4ACgkQFHw5/5Y0
tyz/Owv/d6d29yFLuDInBvc3UD0LnE5IA2bXL2v2jW3AxAT4b7civMEqp63q/jsR
Xr6y2WLNV9rJy4ys3c/gaKyELUK/jrCyqOTtzVvutnf6UE8+c0gppDuhJ+VpFzA3
fMEgHpQr0uLJ+zYYskYHdkG97add0xVZ5rCxyzoeRq2/T5ogysehqmOq0vjU9JnV
Ql9N5IWvAGi2fdbl2/c5LLrr8WfLY1YsEA0WBkKxxJgoasaQDXXgxqaQ2aMfnvIh
9Om2J7dO0jDRjCOQpu0KeO5SFChyAeCq5U60r6zUsnSwFFPmq/XcNyKA8HeW4B1d
H7Z2IzR1l93o9oR4/keFdKjzI0OI0/aG5lFt7+JfCahqgB1aalkkPV20iSHouSPU
S59h+fS38jAe2WOmaRVcS2L19EITbyZhquz6YfY9TlU3biN4CnF73yp76KvVElQC
iZ0t0h83XvQDGBOBFQbSqhi8xlHpsWVL66ATqEOBAs7fPfu3mRQKRYSezhmiDyx0
AMFc6X/E
=Zmf5
-----END PGP SIGNATURE-----

--Zivw0zKJ7ZQFxDFN--
