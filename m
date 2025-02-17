Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E5C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 17:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAC080843;
	Mon, 17 Feb 2025 18:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oP4+GxVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511F0809A4; Mon, 17 Feb 2025 18:46:05 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F417E8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220f4dd756eso54309905ad.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739814361; x=1740419161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AqdcryvydJjeRNSMoAddRB2Cy4Xl80KAHyfX1r12Z0Y=;
 b=oP4+GxVn/Oh2gzj4CAzRXejqxz782rFD9v55ExTcJShBhMjrRc719kQ28m1TcQIo/u
 UQUJnpsRDEqynjY7lERJr8u/CuvbzGcEjWGKAOpsB3cV4pVNOBgYUtyiPmQqWrmBW0aD
 3t0mYyyj2B4eG4M3T7OXetd9jQP9jNWzDPtMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814361; x=1740419161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqdcryvydJjeRNSMoAddRB2Cy4Xl80KAHyfX1r12Z0Y=;
 b=cknJ8t7uJnzz0vWuaY7BkWTC5S00SvP2lWqz9f39SXhs8ohjx9kMof+n9GkW3WB6HI
 cy8Zk46Mrwrra4OBykbUaS0jXDESCBJFObchNvx5aF1hxYBBP60BzNCz5UkmF1vVxP3q
 qdx7VnykGAH/wFxL0PbSFPsFCAqg3PGjXEm1Ovw9BQb9wLQhVAL1a5U7cYazzmI2ug7S
 h9l8MfGTOIIx5feHrTGW8KZUxeR2iB30C0ATmStc+9LLH3RK23iH3n8luaacVjB11YgU
 dL29tne3SogN5Wj8GHtCLGLwHpJLmuPTCIJRIbZsl6tyv/CdUSqE2lE5g+Q/xZ+NTDyL
 Ou4Q==
X-Gm-Message-State: AOJu0YzhzEPdGyTDIfHQY/6LaKG1rtdqiO0k5cXWPm5SaTFCnZ7PStFz
 A/acSxs0tGw21Ki+tmOT0jeduY8V4kq5e1fjkaifD1SXrNjx1oIOEWvgc5gNL1w=
X-Gm-Gg: ASbGnctntxq5MBWsTFwlobX/JFjsjTJ02AYFXMBej+4Og0035EMBcHxdkR0tg79eiks
 afmoVLbKUUYElbHEiVB2lN8jtnCNVW7riJOFJ0g8Ndy5idybdpvNYTizUOHrAkahgw2L8LA6/0b
 K4IoYibGv1trr5+VjgdIC9f0+7DzkHfpsyTvHx2MBzSuMxqunZMNDLla4a1293uMugDukN1qnGE
 RVcvmHgbDdxD93jG3zgcC3ddycUObCqJX6ujxn1EYjDV5E/zL4Aiq0dnbKxmxNByDMHqM9l1A39
 bzS0wYbruMMcJg==
X-Google-Smtp-Source: AGHT+IEfF2biOigHSzV1YK5hXpQY450ORuJXqMqGv0ZlsxdOi7Ng1RsdAI3Ovi4kAzElaZ0HNNaB0w==
X-Received: by 2002:a05:6a20:6a24:b0:1e1:9fef:e96a with SMTP id
 adf61e73a8af0-1ee8cb1f65cmr19691896637.6.1739814361498; 
 Mon, 17 Feb 2025 09:46:01 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adc6d9ca8d1sm5157724a12.51.2025.02.17.09.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:46:00 -0800 (PST)
Date: Mon, 17 Feb 2025 11:45:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 27/28] RFC: test/py: Deal with timeouts
Message-ID: <20250217174557.GP1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-28-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZalG0sh+YUiz/99Z"
Content-Disposition: inline
In-Reply-To: <20250216204421.3560012-28-sjg@chromium.org>
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


--ZalG0sh+YUiz/99Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 01:44:12PM -0700, Simon Glass wrote:

> The distro test takes a little longer to shut down and restart, so
> add more time to this operation.
>=20
> Disable the sleep command for now, as it seems to be unreliable on
> QEMU with '-cpu host'.
>=20
> More thought will be needed for both of these problems.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

We already do:
    TEST_PY_TEST_SPEC: "not sleep"
for every QEMU target in CI. The test fuzz-factor is generally enough
for sandbox, but maybe we should just make that test opt-in.

--=20
Tom

--ZalG0sh+YUiz/99Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezdc4ACgkQFHw5/5Y0
tywFDAv8C2AejQHPfEl/2GR9FvlUh8qw/10BJHFf6Xd1A1cHfPrWPt6G0Mt0/yzl
VlnqhZhfv+1NssQARBi+6lP8QpphKZndQvpr8yp9Rqyb3kB0jnnTJ066+0GP1xA+
+BN2U4SZ2+YAfSMwdlo5wZor/0vFy3mktUd8tnUaL3WhOXDqyTEulpYgOJgLbGOp
WY12pdlUlK3eaxnDT39FgIaaXkPQsWI4hKcOHHKmVUPBaG+jxbzpYMhC3YBE89DG
0zuDK0wgSVekmY5/mWom4h/5s9pAmnEDULWstIXZkrAKo1vdka3ii0XCCBwJiOy1
TXR7ihrxUW1zk8eVSZgRVCzY/pNnSjcbiO50biYwd6LZZ0HXVN3rOAkvuxnoGciT
pI0QwJs+ASx3Lw3C/5kksWoXZ9B4yqKzKjd2tWIyvlybiL19QhK5fXN46EJaAswI
8HSL4PYJOvliowqmzpHCT5IyYnVRYy4JW5B93TsN7mP2Yho3nj87eQrx8LFUfqd0
QdLOho/+
=9hCy
-----END PGP SIGNATURE-----

--ZalG0sh+YUiz/99Z--
