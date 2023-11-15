Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E80C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 01:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C191587063;
	Wed, 15 Nov 2023 02:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MF1y8ZX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D308487203; Wed, 15 Nov 2023 02:40:22 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD7E87063
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 02:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5c08c47c055so50945667b3.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700012419; x=1700617219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sspLc0aXZ0kVYhK99YVjDxCo5b2VZUNI39bFji0nOOQ=;
 b=MF1y8ZX8JQl/VD4Dh4mAgDIAPqoAZjRL2WBUtOnF4/TSdwKQpc/RjgvWjQPptFtJUS
 kuaeFz7R1oor9ebabTtmMfmlxr0wDQAWP7sdDBPdobP/1m4xcLT/UcV97Ku9IIVOuw7w
 hZ1NYHOnZTAiwgwg3sWUqHyvdurWWVaNQRdBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700012419; x=1700617219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sspLc0aXZ0kVYhK99YVjDxCo5b2VZUNI39bFji0nOOQ=;
 b=kKM2mWwW4ste6NHRyamhmORvMNWK9z3RSNPCM2bbPo5Q8jEfyvnku0uHR2QbqaGCCP
 LoYETCndr1xGYtQVhYSJl9dPFjzQA2FEh427BxX6MCMLsOeV3cM4JBNruaKmiIOV3mpq
 GdTM24HVk1dJ1LaI4Ig/8B2Ik00CdHD++KjSbs7t2+alt1T6zRMcFSGo7x8QOgpz6v8U
 0xFVsK3cckwMLnbORKydVNcJ9RTAL0uzfQU8pzC3msmy9c4ppMQaPet+A9da4rjwlbdh
 lXWmDvFeUJ5iR64wiU+JzrHlIVmjNR/W0G+7NTSk2t7SlB9OmQX/ASlLcrQJuSihH7cN
 8odg==
X-Gm-Message-State: AOJu0YxUbZdG86UGHyOX2tjnbkDi9KnsLJO3PIDn9C+NladdQxpTgXxY
 yAGpK0ut7uAMJOk5z6Es8To0tw==
X-Google-Smtp-Source: AGHT+IGv1GeDd43mwidmF8xDNDG6F4clf+R7rBvQbcQW2WqCBKWqZbhzkW6g1x4B3o+ZezcRDqFUgg==
X-Received: by 2002:a81:8357:0:b0:5ad:cd52:d6f0 with SMTP id
 t84-20020a818357000000b005adcd52d6f0mr12856849ywf.45.1700012419074; 
 Tue, 14 Nov 2023 17:40:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 mm2-20020a0562145e8200b0066d1e20455bsm125108qvb.96.2023.11.14.17.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 17:40:18 -0800 (PST)
Date: Tue, 14 Nov 2023 20:40:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231115014016.GA2922344@bill-the-cat>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rEKpo8PNOfO2HIrk"
Content-Disposition: inline
In-Reply-To: <20231112200255.172351-5-sjg@chromium.org>
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


--rEKpo8PNOfO2HIrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 01:02:46PM -0700, Simon Glass wrote:

> This is needed to support Truetype fonts. In any case, the compiler
> expects SSE to be available in 64-bit mode. Provide an option to enable
> SSE so that hardware floating-point arithmetic works.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rEKpo8PNOfO2HIrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVUIYAACgkQFHw5/5Y0
tyzbcAv+Jt0RFvhZvNg9f5JtXmiXjVAUZ3uGRxa3AiIVTxiGmME4JU8SPB9nTFB2
N89o94/bszkglkb7OxGKJSvjomzAa4OCgDhS+7AlAkzSV1/82n8E6J9COgqOPTUO
fasGKUnCkkbxieTRXU5ov1BHsejwv4ZmY+pktWrMf8DFdHyRF3IiLev4cDjZBF7y
VvpEbg5EB8BKxWBWxzsRVE+A3rDfIJHrJECgQM/mGigYSTFjiBdpEgSmARiyLX8x
1DsdNlxSyfpDrnYZuZ444F4XD7XcqzYINbUR8W20IPxzc2pNVfnevKFxGmfRHUQk
74870gJcryHT7KY9cE74+D6oWFiKLqzgcbVKYsluLVCUTZb4e4GFn4wwZ0zeo+r5
rNesVa9LqlNr8y9HEFXThUCEgIeJdwJGSp3SxMUHDNQcmKAcaSanTC3v+WScL8aE
oP3ggNO3qt+apxPtXhqiSZLkXBY1/a9VQraRwxf+VHEdRviZCd34h8a/jZeZhg8h
i1+u+HjS
=fVQa
-----END PGP SIGNATURE-----

--rEKpo8PNOfO2HIrk--
