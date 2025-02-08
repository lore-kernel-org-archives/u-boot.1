Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A84C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB4880805;
	Sat,  8 Feb 2025 22:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bEeVAPZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52835807FE; Sat,  8 Feb 2025 22:33:32 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2876A80805
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso3018037276.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739050409; x=1739655209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cnd9r3WwgtmP2lLGFGIc6ENF80F59IeWrW+gi+amiZo=;
 b=bEeVAPZs2Pv4JnyqyObok++GUSsUPw3NMSYaGjnv2U29INYdPicFsa0GU5kfwvcAUB
 /6BdYuJ/0+46RMAgbvJDjtZjpZM+CVHVct1cmk9QczeFS83k7mEiq1m6zlIqq/vPV55o
 2jFJcNCzlpl+x/0f7+6D12T6pmwqMtdqStcb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739050409; x=1739655209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cnd9r3WwgtmP2lLGFGIc6ENF80F59IeWrW+gi+amiZo=;
 b=BCpvrwssznFCruMlTvSA+O2TKbI7xAWnum/fLrIBDuQAiMcqTcXarZqz9vZ2UDITjO
 i/PJdp8eor2Cq50X32QBHKpps+vlHVG3MUlAD2XJKRwg+HIgEpbQ1YcckJWI01IubUzK
 vlPlzE1bhdvNnl1fm9qd+g+6sWir6c3AyDSlYuEvmsz6OPSTaPA/JfupQ7JBOLcddiBs
 KBq3xA7Hxr2gaEtbK2p8XHAzWOGzo+TKWV8Ag6HGIrQ3pBRSZXD0Lbk1eS/iJ8A0s3Q9
 THg9fJEUTt7TRF1ZpPMUvP4Qa3PPjLov9mWNfH6q02twOJTwCMvTuBE3aZL0Iq3AKC/v
 qlxA==
X-Gm-Message-State: AOJu0YyuW2aGbNDVOX8nmgaf6l2eRUHxUCIeMDcdVNQ0MVtQSYNJMk6q
 5I5DHOTvD3cEY4h18vXJFGQH8VkAO10fcGJxZ7JJkp9eU34hMZsHR+ClM72LiOA=
X-Gm-Gg: ASbGncsBPLLICB8OU5f12k0IMK2YWlIaBTpkY0xK1tHOw/Y/0XXrT3haBEMKKBGQpjy
 tHOeTRmgjV9b32GPQZQU5qHKvXhJtoZQu51rnyPC0Eh6TjGTDKgaEmRonx2P8daF3unNBEidM5H
 QRrt4Vp8V54IOePrWJLafsN8MP5Q2O+cHXhjsNGk1NkAEdyIV8EnbGu85aIH4ZrNPF9cfKpP9HY
 QD0l0bh2wZTee3FuhvvwgO1B02WEk/lcXVJL+oKC2W3fE4DspfrYf+EbXONypgbEpNmgsT6cIjr
 Jc0PME4Khu9Jgr4=
X-Google-Smtp-Source: AGHT+IGAi1WVAkFto/nGUXXrnx1PtNwqnPJy8N6jC/62L9mdJTSMCmrpSKFFFLu+ffj78RkbTkt4pg==
X-Received: by 2002:a05:6902:1b8e:b0:e48:b296:17d with SMTP id
 3f1490d57ef6-e5b4626ca83mr5869965276.37.1739050409010; 
 Sat, 08 Feb 2025 13:33:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a4898e8sm1624768276.49.2025.02.08.13.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 13:33:27 -0800 (PST)
Date: Sat, 8 Feb 2025 15:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] CI: Use different git-directory for each runner
Message-ID: <20250208213325.GF1233568@bill-the-cat>
References: <20250208133426.309526-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ffpm71dC6L76YAcG"
Content-Disposition: inline
In-Reply-To: <20250208133426.309526-1-sjg@chromium.org>
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


--ffpm71dC6L76YAcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 06:34:24AM -0700, Simon Glass wrote:

> It seems that the new approach doesn't go far enough, since when there
> are multiple independent runners on a machine, they end up sharing the
> same git directory.
>=20
> Add $CI_RUNNER_ID as well, so they are kept separate.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ffpm71dC6L76YAcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmenzaUACgkQFHw5/5Y0
tyxwIgv+OuFA6i/C1yngZqLnXeIVGXzjqy888dQFo93a8C2jHHKi2c3bKUGpX4kY
xdkyXGrYgDNJOBf7liEvhcynCJ5shfs/in1hF80gNyOtc+8Vf38UlPu1MC8rxUHS
qJyEiz7DLX5uu07YGQ6lLGkbIH2XN01M56zJ/6kbRdViqU4oBTkttwA4kFDZu7+I
dcW4njF8NLlPQUYES2HfEbLPm6Mz5fx6kS1c90DbggcuXbdCXSIQEV+KFD0H3FFy
xFftZQRMP59yCSQ+EZcJtxgBebvTPwANreaV+2BYSumpiLzLTwqXq+q4c0IX7hO0
kKU2xdOG2Jiz9tvB0h2B0hQGcEm1CgvOigG4zGqn5YfNin5OIOG/AOX6y8EPAKSY
pGn1yfCMTw4e+9GYsogrhy2pkYgghW1MKG1HcHVGHiQENvqcl+saSTWlsHcQraFl
Je6Ca1H+4B6ngPub4NuWlX55i1rXpBb8WMvPqlOlg+vGXe+Rlvn9yL5DQVpUg1Lm
aQ3/7oRG
=TshR
-----END PGP SIGNATURE-----

--ffpm71dC6L76YAcG--
