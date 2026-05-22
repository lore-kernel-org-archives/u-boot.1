Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A121CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 17:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE138489E;
	Fri, 22 May 2026 19:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bCo1VsNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5452C8489F; Fri, 22 May 2026 19:08:53 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37AE84878
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 19:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4824b15c19eso6292105b6e.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779469729; x=1780074529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GmueLU2Z/N+QtfVr3hWH//x7nxVzTrrfp0CJ7fSKChU=;
 b=bCo1VsNhkinyvhyROUWopfZtyNmMYlZCIDXcjJx5mBi9twmWrVKf65KDWYsX42MYiV
 XnS384qMbyjIempSVl8gq1EavWnbcjE5UgwM4UzLl8GtuKQ/wOmr3RjekHtO9E3H6km0
 oZu8bAgmucBcdO5ZsHHp87jWiWB1Gjmcc7kec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779469729; x=1780074529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmueLU2Z/N+QtfVr3hWH//x7nxVzTrrfp0CJ7fSKChU=;
 b=RI1nescsqI1w1+VgVwPMpmmzKpaWqD3vmFM9vxm0QNJTdDsG98ETeinx9Ey2i0LEk2
 hp5QeNP81gGn8OTUhR3uRCs5IvnW2inJASIQkKD2u7H6+MyVIJFb379QFJ8HcYprJSrs
 syrdFA1+e3gwVI9vbKGznN0MRwsydxdia6gbB3bU3e4/oFKS83JUFqOpQ+VhaZBilCrP
 uZfMmxzCyWZ8IA1hae9r/oLXtzQ2SgO/kVFz9vWt1IGHlaavzA5ftYGJvuzoE1zNx6Tu
 0r8gQE9h9Y7031UCx2aPyk5JgaNg6ZrBfCc3AH9+Dhi36PXKtTe0qkI4yFuxo9SDL+Ek
 2/Cg==
X-Gm-Message-State: AOJu0Yw4pmCG3rMAUMo2Snnl0y1NLiZZsd17twrI9+Yp5Q1aZGPSSbXm
 Lm6OYU2OK/J5wZ47Nar01s/f7rWCBoI7nnh5fFGZY+8/Y81j5baII+UTnjyV2K7JVnBztZx+p1W
 gdlJWRFU=
X-Gm-Gg: Acq92OFiJwzpaABTGQxeb1ozwOHmb9FV/F8ljC9k0seHRuKMzFaEDIacPCojoqTGfOT
 jVmfSkHaO0cLPNv/fewFiCwbUzs8n6TznyAuZ6kQgDUzvMXJa4oW3rB0ghYJp+9EZRaiNGryRH0
 ckXMIEU4owD67oui4s1ia+vQIhfcs9mwvHvsVjFI9QLTSmXLIJ1X/vDlI+06KzNmhHsIILAdqm4
 IIRXEhllIxUa2xXEvEeM96JTAxxoXlUW8uWl6jpNjS3ewhA/Won9ErGEJl1wnvC2fkdCcqadHPd
 FvGdk25jMLDONsbRXb68D5TiBbQGc594c8JCXKY1spEZMj8xUMUUML6/iIaA46go9smVtQMO8qN
 XGJ8043vLwW97hdH9Nwpvc6F1Xintlc9ug3vtkcgguhuvq1uPKKgNt8jLlbdKwyoimK/vweBW3v
 szOI/SKxw8LvwIOinLssOgl6qEzNi9vi92QAmFGdqoCO0OSf9ONPDvetqOQc0GyQ8ZyUVBMgfUy
 Rd8DbM08V+X7sUcIvVwIMzvkwB1RXHHNksUS7OSJSWHfQ==
X-Received: by 2002:a05:6808:23c9:b0:47c:7c7c:c792 with SMTP id
 5614622812f47-48549ecf769mr2973756b6e.7.1779469729304; 
 Fri, 22 May 2026 10:08:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476cbccsm821980b6e.18.2026.05.22.10.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:08:48 -0700 (PDT)
Date: Fri, 22 May 2026 11:08:46 -0600
From: Tom Rini <trini@konsulko.com>
To: liu zhenyu <lzy20000419@outlook.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jerome.forissier@arm.com" <jerome.forissier@arm.com>
Subject: Re: [SECURITY] net: wget: wrapped receive offset can bypass
 buffer_size check
Message-ID: <20260522170846.GV1858239@bill-the-cat>
References: <SY0P300MB02651B9296F4AEA13E1B976DBD0F2@SY0P300MB0265.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eB45tToRAh6KX9WN"
Content-Disposition: inline
In-Reply-To: <SY0P300MB02651B9296F4AEA13E1B976DBD0F2@SY0P300MB0265.AUSP300.PROD.OUTLOOK.COM>
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


--eB45tToRAh6KX9WN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 04:03:44AM +0000, liu zhenyu wrote:

> Hello U-Boot maintainers,
>=20
> I found an integer-overflow bounds-check issue in U-Boot's WGET receive p=
ath.
>=20
> No CVE is assigned at report time.
>=20
> Summary
> -------
>=20
> `net/wget.c` checks whether a received HTTP response block fits the confi=
gured download buffer by evaluating:
>=20
>     wget_info->buffer_size < offset + len
>=20
> The addition is performed before the bounds check. Since `offset` and `le=
n` are unsigned inputs to `store_block()`, a large offset can wrap `offset =
+ len` to a small value and bypass the intended `buffer_size` guard before =
`memcpy()` writes response bytes to `image_load_addr + offset`.
>=20
> Affected version
> ----------------
>=20
> Observed in current master:
>=20
>     38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
>=20
> Affected file:
>=20
>     net/wget.c
>=20
> Details
> -------
>=20
> The vulnerable bounds check is in `store_block()`:
>=20
>     net/wget.c:48-55
>         static inline int store_block(uchar *src, unsigned int offset,
>                                       unsigned int len)
>         {
>                 ulong store_addr =3D image_load_addr + offset;
>                 ...
>                 if (wget_info->buffer_size &&
>                     wget_info->buffer_size < offset + len)
>                         return -1;
>=20
> If `offset + len` wraps, the comparison can allow a write whose starting =
offset is already outside the intended buffer.
>=20
> The data is then copied to the computed load address:
>=20
>     net/wget.c:67-69
>         ptr =3D map_sysmem(store_addr, len);
>         memcpy(ptr, src, len);
>         unmap_sysmem(ptr);
>=20
> The offset passed into `store_block()` is derived in the TCP receive call=
back:
>=20
>     net/wget.c:234-240
>         static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs,
>                                  void *buf, int len)
>         {
>                 if ((max_rx_pos =3D=3D (u32)(-1)) ||
>                     (max_rx_pos < rx_offs + len - 1))
>                         max_rx_pos =3D rx_offs + len - 1;
>=20
>                 if (store_block(buf, rx_offs - http_hdr_size, len) < 0)
>                         return -1;
>=20
> The same callback also computes `rx_offs + len - 1` before checking for o=
verflow.
>=20
> There is an additional adjacent issue while parsing headers:
>=20
>     net/wget.c:136-140
>         ptr =3D map_sysmem(image_load_addr, rx_bytes + 1);
>         saved =3D ptr[rx_bytes];
>         ptr[rx_bytes] =3D '\0';
>         pos =3D strstr((char *)ptr, http_eom);
>         ptr[rx_bytes] =3D saved;
>=20
> This temporarily touches one byte past the received byte count in order t=
o run C-string parsing. If `rx_bytes` is at the configured buffer boundary,=
 this touches one byte beyond the caller's intended receive buffer.
>=20
> Minimal host-side PoC
> ---------------------
>=20
> The attached/referenced harness uses:
>=20
>     buffer_size =3D 64
>     offset      =3D 0xfffffff0
>     len         =3D 0x40
>=20
> In unsigned 32-bit arithmetic:
>=20
>     offset + len =3D=3D 48
>=20
> The current check therefore sees:
>=20
>     buffer_size < wrapped_sum
>     64 < 48  // false
>=20
> So the guard allows the write even though the starting offset is far outs=
ide the 64-byte buffer.
>=20
> Observed harness output:
>=20
>     BA2-T6-CAND-006: wrapped_sum=3D48 allows=3D1 terminator_one_past=3D1
>=20
> PoC source to attach:
>=20
>     poc-wget-bounds.c
>=20
> Build and run:
>=20
>     gcc -std=3Dc11 -Wall -Wextra -O0 poc-wget-bounds.c -o poc-wget-bounds
>     ./poc-wget-bounds
>=20
> Observed output:
>=20
>     buffer_size=3D64
>     offset=3D0xfffffff0
>     len=3D64
>     wrapped_sum=3D48
>     current_check_allows=3D1
>     VULNERABLE: wrapped offset+len bypasses buffer_size check
>=20
> Impact
> ------
>=20
> This affects systems using U-Boot WGET/HTTP boot with a configured receiv=
e buffer size. A malicious HTTP server on the boot network controls respons=
e bytes reaching the WGET receive path. If the TCP stream layer presents a =
large receive offset, the current arithmetic can bypass the buffer-size che=
ck and copy attacker-controlled bytes outside the intended image buffer. Th=
e impact is pre-OS denial of service or memory corruption in the bootloader=
 context.
>=20
> Expected invariant
> ------------------
>=20
> The WGET receive path should reject any `(offset, len)` range that does n=
ot fit inside `wget_info->buffer_size` without first computing `offset + le=
n` in a wrapping expression. The usual form is to reject when:
>=20
>     offset > buffer_size || len > buffer_size - offset
>=20
> Similar non-wrapping checks should be used for `rx_offs + len - 1` and fo=
r the temporary HTTP header terminator.
>=20
> I can prepare a separate patch or sandbox test if that would be useful, b=
ut I am sending this first as a vulnerability report so the security impact=
 can be triaged independently of the fix shape.
>=20
> Regards,
> Zhenyu Liu

> #include <stdint.h>
> #include <stdio.h>
>=20
> int main(void)
> {
>     const uint32_t buffer_size =3D 64u;
>     const uint32_t offset =3D 0xfffffff0u;
>     const uint32_t len =3D 0x40u;
>     const uint32_t wrapped_sum =3D offset + len;
>     const int current_check_allows =3D !(buffer_size < wrapped_sum);
>=20
>     /*
>      * This models net/wget.c:
>      *
>      *   if (wget_info->buffer_size &&
>      *       wget_info->buffer_size < offset + len)
>      *       return -1;
>      *
>      * offset + len wraps to 48, so a 64-byte buffer does not reject it.
>      */
>     printf("buffer_size=3D%u\n", buffer_size);
>     printf("offset=3D0x%08x\n", offset);
>     printf("len=3D%u\n", len);
>     printf("wrapped_sum=3D%u\n", wrapped_sum);
>     printf("current_check_allows=3D%d\n", current_check_allows);
>=20
>     if (offset > buffer_size && current_check_allows) {
>         puts("VULNERABLE: wrapped offset+len bypasses buffer_size check");
>         return 0;
>     }
>=20
>     puts("not reproduced");
>     return 1;
> }

Hi,

As this is starting to come up more often now:
https://lore.kernel.org/u-boot/0100019e40e72ac1-c3d57c2e-cac3-4f65-a98f-f1c=
6173c047d-000000@email.amazonses.com/
https://lore.kernel.org/u-boot/20260520143639.GM1858239@bill-the-cat/

I'm going to repeat what I said to start with in both, and encourage you
to read in full the second thread above.

First, the current stance of this project with respect to AI is, "please
don't" and is well explained over on
https://docs.postmarketos.org/policies-and-processes/development/ai-policy.=
html

Second, if you're going to use an AI tool anyhow, please read
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D36d49bba19f2c19c933d13b25dcf4eb607a030b3
and specifically the section titled "Responsible use of AI to find
bugs".

Finally, our normal patch submission process is documented at
https://docs.u-boot.org/en/latest/develop/sending_patches.html

--=20
Tom

--eB45tToRAh6KX9WN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCNngAKCRAr4qD1Cr/k
CjuJAQDDliByYfyhKaib+Dy+unkRMfh0+HzHoxQX+FaLwAh4kAD/eHs6qPhoOkoq
YA50ot9hf16wkkn3thekV1A7ayrKmAs=
=uMeY
-----END PGP SIGNATURE-----

--eB45tToRAh6KX9WN--
