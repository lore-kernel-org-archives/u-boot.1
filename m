Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD00E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923378039A;
	Tue, 31 Dec 2024 05:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JrsVyalG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1B7804B6; Tue, 31 Dec 2024 05:08:42 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E57780352
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d92cd1e811so91775166d6.1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735618119; x=1736222919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KpsftNy1xZ0zPUhOkEwzQAm9cx9OZVPQzGuX0ZeRZ3A=;
 b=JrsVyalGrSqx+dq2doyZseEcRoZ2UwC9qFtrAFLumUv+MKovN3uSFzUcFgvLnQq2pr
 +0GTy29JMYbX0lpEOwWhuP5/F+JCC0fMrufcZUWzcH9WbJAmUNnxaPbT50qR9no9+5/W
 St1fmrt5Wdr0iT6ibQsZm1kux+lVYtekJLMT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735618119; x=1736222919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpsftNy1xZ0zPUhOkEwzQAm9cx9OZVPQzGuX0ZeRZ3A=;
 b=eD9LUlzPQSO8bWVVomfyzF58dUEEOFBm6Kab0vewycDt8R3iZ7koLE+ecgN5ac1H8c
 Y5Uz0Fax+0duB+XE5jCrnlNXJDVFHAdMDuzddVSDN/GW1E2oWF/7H7hJOtW35ReSvTAy
 6ITVD8c8HpESgLBDxi0YbZfnqjLF3B80AXnkQ/MpVhA0ukPl6FHjVX4O0OlZQuWODx7j
 LSfithnggl8U+QLHc+AkWw483E82Tr5k6mhphpUu5/ITsuCZcbl1GeUiaBO214A/owt1
 EspEYwc0xy7KMiyqYugPU33ipGUofY6pmLDmFzaPY+DrdSjPfq46EHq+QkfkFJY4B1ua
 NGrA==
X-Gm-Message-State: AOJu0YwBOaYKYmqAANhWoxSj1P2Os5n29LdWiy8fJwyXxU4WQUVIpdIr
 BgpDIN5MmBscy/gNqgdJdeZprE1lLaYPPkcHjaCOxh5L3vfy7V50YQWhdJw/JWc5F9OcnBNDhVS
 y
X-Gm-Gg: ASbGncu8IlZZJ8IewEHchcWuSmDuQxnHiVOI5hz7cIHsINPeC/wZ86NDHjqA6JiVHE8
 7p4k1oWWLURmCj7OOXpGRKGXIWIcJHZlaC3SCG8s+L6ZYXjA0kprQ39oM4Scl+5tV1efF8Nylck
 XZWRYLdy+WLgFBESBnYdCVM+aRZjartiGtQEHJ9a8g26lRN46x8U2dOzRbqOn9j8Y5eVU91zWjZ
 +pnBzhdgv1WGTctnB7b7botG0rX9Nb6lAxhwKHmdii6UUqOwL5QmIBbrg==
X-Google-Smtp-Source: AGHT+IHbs/lB5LUM1EZPKYFyQSvq3EtrVuYJSTzdwN/qCdzio11loTch9WQU9IccwSy0Ic23ReCH9A==
X-Received: by 2002:a05:6214:4002:b0:6d8:f0d2:f472 with SMTP id
 6a1803df08f44-6dd1555433fmr721665076d6.10.1735618119386; 
 Mon, 30 Dec 2024 20:08:39 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810cfd7sm110177576d6.30.2024.12.30.20.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:08:38 -0800 (PST)
Date: Mon, 30 Dec 2024 22:08:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] Gitlab: Remove some "rules:when: always" lines
Message-ID: <20241231040835.GF3476@bill-the-cat>
References: <20241212223336.1623762-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wHKl9bGqrCeGkbmL"
Content-Disposition: inline
In-Reply-To: <20241212223336.1623762-1-trini@konsulko.com>
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


--wHKl9bGqrCeGkbmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 04:33:36PM -0600, Tom Rini wrote:

> In commit 399f739be6b2 ("CI: allow jobs to be run in merge requests") we
> added "rules:when: always" to many stages of the pipeline to allow for me=
rge
> requests to trigger a run. However based on current Gitlab
> documentation, we should still be triggered on merge requests without
> this. Furthermore the way we have things written today we always run all
> stages of the CI rather than failing out early on problems, which is not
> always useful. Remove these as we should still be fine with merge
> requests triggering a run.
>=20
> Link: https://docs.gitlab.com/ee/ci/yaml/#rules
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--wHKl9bGqrCeGkbmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdzbkMACgkQFHw5/5Y0
tyw60Av7BCqDTBZyPo3E0MOmtz/ysPCps0YRNzH2jN7OrLkA4oMuRddn7WdRoNs8
7FUCI9+t+w/g1PBpevrsmCPwqBLANIBMrHYY8FMsDDsox9vRMcjUHre89Mnt4FGd
e+5rsQP4xzUtVGAbFq0OzXkx6Rc/gTBVGqzn9O6Xdzh7PwwYsNFB+5TlA3hos4jD
rHkvN1nLOBP7IIpNO0Qs/zxNsZ9nx9wny7Lyqak7kvZZXoll3ouqd/blODgxnTzF
WkylohirS1KBcbJfUxgkGzfAp2wcFX63d36FAcfYknJebnINR+M8oZN+sskKi3RW
wBNvJdwz8FSa+F1uG5/Jdg6e6OuUArdEtlN8PMSyM+B29VPuCBtll9pNm/CTqeyl
bNYGmtDkU9UqgTLTYZUcWE4+lysAmibfry2I36cDKGg7chHWqAlGlWoFp4qShAal
GG4XtNCXdcpzYezPlnrQSHVwS2G2YwTOzFyDDQiX0jYHJeBmmZkg9Z+v/6NlJ4QF
BSMJR0eA
=kZ+p
-----END PGP SIGNATURE-----

--wHKl9bGqrCeGkbmL--
