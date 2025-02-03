Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94AC980207;
	Mon,  3 Feb 2025 21:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P5ZouRBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05632800B3; Mon,  3 Feb 2025 21:08:55 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAAC080207
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7be3f230436so433231785a.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613332; x=1739218132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xazXTuVkZm/zosNOEs7ImGhCBUFYT/FlLqPp6bg00lc=;
 b=P5ZouRBtq2y1AKR6IljQdxLXutGHwq9L56EqUXkGPjmfMj0YdWSqVb2/bBsEz6uUNI
 lKcnbUfImWE+X0cxOG+v6yM08vRF4JPPPjjmP7v/8KqI/7mdHQpEVl20gqxW9wPa8+LC
 mo2lyk/sldcIhDhOvnatVBeGaHs6xm3Cb7oT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613332; x=1739218132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xazXTuVkZm/zosNOEs7ImGhCBUFYT/FlLqPp6bg00lc=;
 b=dbpXHtv+I8uu/YqR6mTw+HOiz3FlALooEOoNjgf2lmXC1nrDhwmReATBIzqyxkY3Sv
 OqlKyCVV01NEJNlV2NvKsip1MdzfXGbK4eMKPfF4QjmshoEpnRhmqqL0mWw/rYIv7FDn
 agh18zlvY+qu1m36NtHpW0fIB3dydF17ZTPkWCLm8SGREavqWfYkQFfinhHhaPW/DwNt
 y1233+ejFDIjDiVC4CSjiAmjI0jMycfC0vQf4t9ROghNT+oWjvU7ZA7EdIAlb69Spp7E
 awCAuHcuxRdC4FN2L0Q6+pUQqAPM8CLIY5WoMB3u8dO31PCH4PAcmMCX01hrNWACF7hU
 braQ==
X-Gm-Message-State: AOJu0YzPyjN1JXeEPJTa2vOsVDJLdoOb39OkPKS1x7Ey1oD6B7ApRP7m
 rzhwzXOjTWhp8FYaRhCSr+5jzn6kj8B7keLzgY0KX2g3JVynTDFKbcLr7/cGw4s=
X-Gm-Gg: ASbGnctzUjlPh3Pu1kCQ2PG4Sn7BEluxj74fBu2DctvfS5xPjEhJi7GxWP/YoTK/YXa
 B2+meHiMQAL3begR8yYV/YB3XHo8OnJQaTANFWixAZ712U1kLs1uC5ZrUs/iwQHFPLb6lGLuLPv
 qpvlyfIHZHv+FsvCEDGG0Ed+tZ6PzqnTDrLfithj0w9nItyyVuR6+MJdfNg7l/sCspriZNJ3Eli
 Alfxt67d1x9F4c7tYLUMawwMcnLMCw9SZ2zHfbl1bMvE1+HqL+liehrU2u4DlCL4mf46UsKe3YK
 7a+WuIcWF5ECuKE=
X-Google-Smtp-Source: AGHT+IH+2/oND1DfQ9RMwBLru2gMYTDnuXbDfsguIvmUksuVwAKNo5EPjvtvYhnoMK0vLe6+SjRDdA==
X-Received: by 2002:a05:6214:411e:b0:6d8:8256:41d7 with SMTP id
 6a1803df08f44-6e243c9cb4cmr354297436d6.33.1738613331713; 
 Mon, 03 Feb 2025 12:08:51 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922475sm53894156d6.70.2025.02.03.12.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:50 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:47 -0600
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
Subject: Re: [PATCH 11/32] efi: x86: Rework VENDOR_EFI option to permit other
 archs
Message-ID: <20250203200847.GG1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rYqoGbBVN8nAvNs1"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-12-sjg@chromium.org>
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


--rYqoGbBVN8nAvNs1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:04AM -0700, Simon Glass wrote:

> At present only x86 supports the EFI app and (apart from Qualcomm) the
> payload. In preparation for supporting ARM more generally, rename the
> existing VENDOR_EFI option to VENDOR_EFI_X86, using that to define a
> generic VENDOR_EFI which will be enabled for all architectures.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This looks like things that should just live under
BOARD_SPECIFIC_OPTIONS in board/efi/Kconfig instead.

--=20
Tom

--rYqoGbBVN8nAvNs1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIk8ACgkQFHw5/5Y0
tyyr6gv+Pz/CjlSb3ZrJZBwlyJ9OWixBWJ9PdXCz71+M+TVGqEZSrno6jtCvxI/c
UFL7Cq4CJSu/bffxFWF9in6u2oDNmhzQS+vJFCc22it41CKK89VVIirLvADG6Oj3
7dqfcm41pZk/2+s6ZVdW4sR20JkNgmdwmv7EPnDjYjKD3Ay/H+cXNbVDj6cmrsrw
/zlBTfQ8kzPRU7k0KBIdFTBYLzKoqzCtftLe7dOS2DY+RSbogU8GJpnuaKm2hh5D
uB6YGNfvrB7ALDBM/T4NuDTrE5GyZ+I8ksvq0v3j3TP5WsJSdQXrgXE5sNH+QyPE
Pc3nBclr9lK5fjFsJZcvrdtsaSdtRMFllLdv++dkoJYwQuebha/pRzf46crRjW7Z
gBX1jUCq5dMV9E93jahGVbUIqFRoIkv80JfCPTpGFiBKs1oVfXsQ0trmDP4Ng3X9
Ynz2PiP+QrgmPbr22jimunVEZncb1aC2f2eIdmVKyd+l2iUKye6qmcRIw6dA7L7Q
3phxkZrN
=i4/s
-----END PGP SIGNATURE-----

--rYqoGbBVN8nAvNs1--
