Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D753C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0323780FA4;
	Fri, 31 Jan 2025 23:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ik227CLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D991580FCC; Fri, 31 Jan 2025 23:58:32 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F3A80E90
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6c3629816so140395385a.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738364309; x=1738969109; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p6MAA7mi9mYGBNOFrrZxD8PJgAV4w33SaTtByeuomxM=;
 b=Ik227CLKfE8XPRdfySsZmEXgxPBEnl40xk7EkDij0GgZa+mXkWedL12QorvWvZ5XKP
 gYXiqcRBBIHtkzw5hORKhTgL1iN7AXBmtNX1d2t6UlpLyhNHAD8EXiWoRvPyPiQ3w1wv
 4BU0ulC/AshvphNfnrGhOcKSX6x3B7QyfhhkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738364309; x=1738969109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6MAA7mi9mYGBNOFrrZxD8PJgAV4w33SaTtByeuomxM=;
 b=jjBnKrUJlcMbK+lBb4zwVcrwm9w3QwJ2hrVfjJLSydIbMPfAIWHmEn75XVpV+JKBiD
 gso2FNAGVMqXdw5bzhS8IeWo//jlPUcg/3w2b9E2JRyU73w0dCsTXmvZKgpy2d1hHmmD
 5BL+QDdJmOCwpBoPE0vgiItIdZz4fW0asXqdiIO5iQO4hKozMjM6nim1lcuoSNV96AVY
 RI1UELuCIElqGIry5ZHMN3ZscET2kmdtWDY0VIfTz1sj/Jc2TqcvRgYlLfH6rTF5VlFY
 CIKb0jp6iiIItv4YMxe6iUfEtaSh32ODeaMn+IjOcNuWp1cx9gyczJwJjPJJ89JZwMn5
 yF/g==
X-Gm-Message-State: AOJu0Yz+IvtxfxFHqQ5LJdBa9VHghEwpXRuVSK/Ev0t0IiUbBeTTz4R9
 EKWDuNJhazhpEcpOqeD7Vg1oCmeOzluwYYux4Fpe5RX964G5hc8H03Jb85MNNG3AIXzqjMDnNGB
 a
X-Gm-Gg: ASbGnctl3xRdsIaZmAoTSF8pIH7GxrLLwZkYexvh3vNjuOsE12QgNCEPAVsG3CUqYo5
 j0QoSdh2LTTCz4DVSdeEQiQzEvlIEISQdLaITLmEGWv2Dd+V+bEI0XB6bEhsFkDVNFe3N56bcDZ
 KGw9erhEHvU8aGMWTquqOexQc0iZuZFJua9c9JLTIJEcHPB2bE51+sUXVSTPHOOIqFwxKIeY8lZ
 D/U4vwrJSKkYGHyQ90vUg92kZNbnvyibu0Z0LpT/OQHQdKf4kFV2go90GEDuD2SnptynJSUYGBW
 6CZpuEtxmNc0ESQ=
X-Google-Smtp-Source: AGHT+IFSLeUEahiuQ7xPyReqhBDKoXqSVtUldq2dvio8Zihm7ett4pLLrRS3PLZr8J6e6dZvYldAqA==
X-Received: by 2002:a05:620a:3955:b0:7be:3d43:8fea with SMTP id
 af79cd13be357-7bffcda0a6fmr1957747385a.58.1738364309144; 
 Fri, 31 Jan 2025 14:58:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a9055ffsm239257685a.75.2025.01.31.14.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:58:28 -0800 (PST)
Date: Fri, 31 Jan 2025 16:58:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Subject: Re: Enabling test/py/tests/test_spi.py more?
Message-ID: <20250131225825.GU1233568@bill-the-cat>
References: <20250131200007.GR1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeivubGwrTX07DPr"
Content-Disposition: inline
In-Reply-To: <20250131200007.GR1233568@bill-the-cat>
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


--eeivubGwrTX07DPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 02:00:07PM -0600, Tom Rini wrote:
> Hey,
>=20
> Can you please confirm that this test currently functions on your
> platforms? And then can we please enable it in
> https://source.denx.de/u-boot/u-boot-test-hooks as both a functional
> example, and testing of the SPI framework?
>=20
> I'm asking in part because I've attempted to enable it on two TI K3
> platforms (am62x_evm_a53 and am64x_evm_a53) and the write twice test
> fails there and while I can repeat the failure on the command line, I
> can't make the same concept fail at the CLI (including 0xff'ing out
> memory before reading back to the same location). I've also tried
> enabling it for sifive_unleashed via QEMU but that in turn seems to fail
> differently, and possibly because we're destroying all of the SPI
> contents and need to expand the test to include a region to ignore? I'm
> not entirely sure, I'm still debugging that one.

As an easy'ish for-example, if you rename
py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py to
py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py and add:

env__spi_device_test =3D {
    'bus': 0,
    'chip_select': 0,
    'mode': 0,
    'part_name': 'mx25l25635e',
    'timeout': 10000,
    'iteration': 5,
}

So that the test will run, it fails with:
AssertionError: assert 'f753d4e0' in 'crc32 for 822000c8 ... 83212327 =3D=
=3D> bf3e333c'
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> sf probe 0:0 0 0
SF: Detected mx25l25635e with page size 256 Bytes, erase size 64 KiB, total=
 32 MiB
=3D> =3D> crc32 0x82200000 0x10
crc32 for 82200000 ... 8220000f =3D=3D> ecbb4b55
=3D> =3D> sf erase 0x0 0x10000
SF: 65536 bytes @ 0x0 Erased: OK
=3D> =3D> sf write 0x82200000 0x0 0x10
device 0 offset 0x0, size 0x10
SF: 16 bytes @ 0x0 Written: OK
=3D> =3D> sf read 0x82200054 0x0 0x10
device 0 offset 0x0, size 0x10
SF: 16 bytes @ 0x0 Read: OK
=3D> =3D> crc32 0x82200054 0x10
crc32 for 82200054 ... 82200063 =3D=3D> ecbb4b55
=3D> =3D> crc32 0x82200000 0x1012260
crc32 for 82200000 ... 8321225f =3D=3D> f753d4e0
=3D> =3D> sf erase 0x0 0x1020000
SF: 16908288 bytes @ 0x0 Erased: OK
=3D> =3D> sf write 0x82200000 0x0 0x1012260
device 0 offset 0x0, size 0x1012260
SF: 16851552 bytes @ 0x0 Written: OK
=3D> =3D> sf read 0x822000c8 0x0 0x1012260
device 0 offset 0x0, size 0x1012260
SF: 16851552 bytes @ 0x0 Read: OK
=3D> =3D> crc32 0x822000c8 0x1012260
crc32 for 822000c8 ... 83212327 =3D=3D> bf3e333c
=3D>=20

And that is also how the TI K3 platforms fail. However, evb-ast2600 is
fine, with:
env__spi_device_test =3D {
    'bus': 0,
    'chip_select': 0,
    'mode': 0,
    'part_name': 'mx25u51245g',
    'timeout': 10000,
    'iteration': 5,
}

And note that evb-ast2600 is a 64MB flash while evb-ast2500 is a 32MB
flash.

--=20
Tom

--eeivubGwrTX07DPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmedVZEACgkQFHw5/5Y0
tyzKKQwAi2OXJ9mwGLMgRH32TW7jih8LlRGIAmBS5fO6w9Nsy+GWBBN+yO5v4M5G
SwYHfFVl46R0tqLkqkGoSEe3VRf/2Qo/jPTI/+Fe+kbJelDat3a5Kw8mzyofkSMm
iyeeKVloEiGRjudz++/fAriDRduyTIzYK47Ad6N7qVaMrzyzfxZTRoUnqaCema9n
/cyy96kyC58qraLZUMUjObsoWh5MmuW/j2Lf62X2Gxad8ADylhrxI5oNcqBQLy4H
D4ZLyrZ6MnW025YfcJjsl1jsdOnq6chTmBIBLAVj6M6SOYIqo68UJdsGolydYubU
dRed1kQtN5P8OCQp4GMHClL/yGXzV8LrvKE/4aT5xiZWTMt1Bw5e5fgvjrzUC3mf
6eSmYlpMDbjQWEWRFfZJZX1cbkio65p7oD0R49PX3ai6QGnolpmdFGy/xxb2vTib
c3xqiPre8WTAjZwZeUdXJmGK4N4WvqNv3heDRWCmFrWYHTrkkWpcUrGvXa1Uz9am
7o1P+ApL
=4ham
-----END PGP SIGNATURE-----

--eeivubGwrTX07DPr--
