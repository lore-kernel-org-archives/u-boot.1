Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7349BC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96F7807FE;
	Sun,  9 Feb 2025 19:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jxAJsFKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D6C807FE; Sun,  9 Feb 2025 19:09:08 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D1780141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so31744567b3.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124544; x=1739729344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ECeYVwj9Z3rQIi8kWbDVWPewnEshjFC21+UF6lhwhoE=;
 b=jxAJsFKkfUvOoPZ/PWB+77Gvpt0/HPnnEh78LiUtQsufEYb3vBqttqov6b6zucIw3i
 B9ugM/2DqGMYGvMw+6tka0sxVm/kR1J0QrqNW6r64ICcxoFgzoTZBWWBdJxFkmVGj/ND
 DPPgc6k9bfz3OFmwvYQtzdVdlAAt1t7HGQ2iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124544; x=1739729344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECeYVwj9Z3rQIi8kWbDVWPewnEshjFC21+UF6lhwhoE=;
 b=mkjh5eLZZ8OqbCAGTW9mAMr03mCWI75C4H69DYQ9g0mGiRME0207cMtCA8wFS+/KV9
 aL44LbbitDGTkJ6Vwv0JYZ6eX2Ga7Ukh9ok84jDR39WUhzS3VhI5bIUhOmFIVRfEwAzc
 VkW7kl79l8lYFO0CFjl7P8hgDbddAIUyCyfzg1FgbRGifW6EBidTBklxhdyBZegpEHnx
 jS6BzdORFeaVaTLfb3ukYMSxvbT3H5Cc/rltfCC+zAL7UzuMjf9Fnyi6ubRbC+ZSFTVS
 l7vCy2msOYHL0urVs9XTntrdXWs48KzZSDoqFmRyzV0MJpaRyBKlSVXsxzOPbArRlvrY
 fzQQ==
X-Gm-Message-State: AOJu0Ywri+h5h8ArbzoIICj6/cV+dWQDnafZJcrnR6CG05n/aJ2Tf0yz
 sFBi3plUsEQ4xTYNRILGYF/EcbEGoFOt1BzwEhREqt8Obc6SB18zrPjKbSBt944=
X-Gm-Gg: ASbGnctGMw451L3TFlJLVeY5WvmN6Mfo38dTxjcQ/H0PhScGu8uGIJAViL6Z5dQkucP
 jFajvvffqd5GvpPG3UUzfP6TclABaLKdso6mOYsxredASM36M7UQd2O8iYtWloC+K0lRhWc1ner
 rTUDiH9/wz9glDGnMViWdEjqNr4OtZizUJLEK5gWVbPHw2kFeNVu5YLUfM+IWg39BH3xd2T4lmO
 xHj1rBNmrHZb30OB1lExpJA0+t6Y9wf7xv1q+y8jh2SJ9i6ZnybdArq84tH3PoECHOF48GDpyAZ
 rh12FTPohJg86k0=
X-Google-Smtp-Source: AGHT+IGKELyC92o4SRYgU38vOLwREvpYyqjDGp9PFXaDgujXjZqDR61Z2n/Q7NeXZwBWGAY2f1cgGQ==
X-Received: by 2002:a05:690c:7106:b0:6f7:acc3:63dc with SMTP id
 00721157ae682-6f9b2a0d784mr87204937b3.36.1739124544367; 
 Sun, 09 Feb 2025 10:09:04 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fce1eacsm13007567b3.17.2025.02.09.10.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:09:03 -0800 (PST)
Date: Sun, 9 Feb 2025 12:09:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v3 09/29] efi: x86: Rework VENDOR_EFI option to permit
 other archs
Message-ID: <20250209180900.GV1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pTJXk6VkTkW0gagi"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-10-sjg@chromium.org>
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


--pTJXk6VkTkW0gagi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:08PM -0700, Simon Glass wrote:

> At present only x86 supports the EFI app and (apart from Qualcomm) the
> payload. In preparation for supporting 64-bit ARM more generally, rename
> the existing ARCH_EFI option to ARCH_EFI_X86, using that to define a
> generic ARCH_EFI which will be enabled for all architectures.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pTJXk6VkTkW0gagi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo7zwACgkQFHw5/5Y0
tyx7GwwApUL48XytDbWHpu7sWyxQepCp84oqgjyZVz0ENl9fYKmQFCpPkcCIgB8q
gOaf9AWW8UEX57MahrHyTiFSdG8K2cj/23oA3tECX1y41+SeugyO74U2uO7BVWRK
MT7xly12uLfbwvNK3qmL4ghdo3dIvr9jgW0ZkQ4OEeaRb4VyJpEvVgZz4HujuKtk
t74wxMtVV2BuK+PbapXCAdH730W8in8z+hPqonfWgjjE3dku46cFGQeHx83sLXeO
DvEuDabzSnB+w0iW6n6S7BCPuZ81JA0Wp1YQY44u0U33c3FIx3sRw/Wfe0xTyEJ6
r4QynBs3YR+rZ8mf+/OuCSYdXfxuF/M8EgS+cAJ9dpKyFc2bG1pslB78CtIXOQcW
XStGiqot+7h3S6rB2PV6M3XsrT+hhasRxTIOBTUco8L9a0q6AOmwmbgB4sTYspam
09YueOkxUi8LBreKq8Vg+9bTnv8cM1FDFaczEtC6KuCEu67D9K22TLvbPAykAzUY
uK4gjlCo
=YwLk
-----END PGP SIGNATURE-----

--pTJXk6VkTkW0gagi--
