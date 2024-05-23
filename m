Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9C8C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A70884EA;
	Thu, 23 May 2024 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mycgvMyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC82A884EA; Thu, 23 May 2024 17:25:47 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791AC884C9
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f855b2499cso355182a34.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716477944; x=1717082744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cQiH5Q5u1DB9CwuCDLk23ouRhwhJy88DH9jp9ZTrMbY=;
 b=mycgvMyOAxmNBR1ooSNsyy6yGbozxT1rq/lDY72TcSEHiNi1rVCSDHHGxaxRaJGb/G
 jCruu+JdfHgslm4GpkcNywCd9ruumfXSzRnz9jPoolCOp7nkAL8NDGR80c4PScjao2DN
 x+hEKO/xZLWRl66LP16eg1Bs2Qf3hvUlvB4SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716477944; x=1717082744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQiH5Q5u1DB9CwuCDLk23ouRhwhJy88DH9jp9ZTrMbY=;
 b=SUCKrD8QJtPHP0YhAVm3rp2y1/XMelqjhqWPV+8cmUVruA/dl13ZuHt0AXCJA9GW3Y
 10YbrdmMpuhpcONCCRWYulvNOnWtsUooDSZH8xGqbzifE8L6fPJHM+iwx/oRruv9xLA4
 SDtPtjaL0rqeZD3y5CEUWoHkzqFJ3Pc3CR5L5NNTtfy+/BPz4By67eEo4DnsvJNu+dRx
 iACGks8DxEDvyOcT2AmkWrzsJMSoEDbczBslGT9BE0lVyNIgtvmsunzrUxa1QIunTrZY
 dm4TwqxnF6/YNKD1F42gNdfprlHq+wj0jnNjz3SMTHJE5f2wYbZxSHLbSDTxk1WIYB88
 rECw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6CSdgpn9Izt5K+xdSx5m7No6n4/ZJF3+aJGioor5Jga/ZiG3gDnsfsmfZHnuq/9BQgBh0p8YpKorl8LDTvAOIYfvTpQ==
X-Gm-Message-State: AOJu0YyhEqkT53mPBTiWG8zUV/9CIp/Dj8GxumYEMpw2WEdk9T26F0K7
 jRV3dEUAjOweNjPo6nreDsAUkZowOBTeREM+nnLINraKVZ+US0415JZb7l+P11c=
X-Google-Smtp-Source: AGHT+IH5hjrxm34j5yj9f0lXtN6L+G6rqsW2OluRHR6PUN0vwsVrLPhkPyXM1GhyKsvtVpWzKp647g==
X-Received: by 2002:a05:6358:7f1e:b0:18e:3ec:94cb with SMTP id
 e5c5f4694b2df-19791e07119mr640969455d.14.1716477944100; 
 Thu, 23 May 2024 08:25:44 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d9dd2sm144051586d6.129.2024.05.23.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:25:43 -0700 (PDT)
Date: Thu, 23 May 2024 09:25:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] LoongArch initial support
Message-ID: <20240523152540.GR2568172@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DhxTyTF7kq03gaYX"
Content-Disposition: inline
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
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


--DhxTyTF7kq03gaYX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:

> Hi all,
>=20
> Sorry for flooding the mailing list recently, yet another huge RFC series=
 ahead.
>=20
> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, as sug=
gested
> by=A0Heinrich.

My big feedback here, and it applies to all of your other series as
well, is to please update CI to make use of and test this. On the Docker
side, update tools/docker/Dockerfile as needed. For Azure, you can tell
it to use a different image and then follow the documentation on
https://docs.u-boot.org/en/latest/develop/ci_testing.html and for GitLab
you can at least use their "linter" to make sure that your additions
have the correct syntax. Thanks.

--=20
Tom

--DhxTyTF7kq03gaYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPX/QACgkQFHw5/5Y0
tyy6FQv/VrIi1y96XZzUDMoOtY4GoogjU8/BfwzjFMRrzX6Y3hiDSSD1qzBa2KXP
sRV0a0Zsw/qMfVvnKRUH464WSZtjlsV3AK8yp8Nv1+JLYVD26dg40sEfpopJRQbm
SYWkO+LnDoxbGcb7rHj4A7e+H7pLiCu3OaFsbb73wbQVBtr9/kyj48ZovOnVoyR2
MXSBBgqaiCTk9+osACikdZYl9V+HxU/Qv/I8HH8TMmCrGa+TxdENb7ThvgjVfvIO
NtuhG31JsnPRiIuDVvfhryZO4JckabrZG/7DDGNbTEgS79j5JY2PlSP2IoPSuymZ
dvCybSZpPltApzN60c/S9arUBdecq7TW8m9xZgZcNdrdujgVa8kbc8nAV3yHDu5j
6A7tgYJ80VZww68Uf1T/pISoAF9CwC78g6cAVy85wdcO1qRbUzUtRph7FWChLuoW
/wpUanwB3WjmNxdPo9bqT3YS2MNRBYGG6Tm0yJULEG3+jBLxh5UdE6lOlyvwcH5x
auQTFAgu
=W+E0
-----END PGP SIGNATURE-----

--DhxTyTF7kq03gaYX--
