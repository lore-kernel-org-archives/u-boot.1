Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBC606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GxUHs5hu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lCKNWVPa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55D0A80E23;
	Mon, 16 Nov 2026 15:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Sy7EjzkV9zj; Mon, 16 Nov 2026 15:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7310380E39
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794842407;
	b=DJk1tRFe+T+vlw3DqvSGOEFyTNqsZ7Tudf8TaUMo4rkcCUInpKL/rRgCkp2TrESudK7v
	 xDVYYVutPBg8CDgo/PHHsr9Cm8tXrreMhyRI6mwPQOUHtO+bvwWE7tqq2zapn1IsgXqok
	 l5lkdUtwW6Mm7WXQybdCvu044NvqqKCongzMWXKdKXYLgcQQbLnbq6Och8IJnKoxNua31
	 nD1LwlBGR/Drlq0lmJm5Ihh3jwim97l7w025QYQwmEqe7Srr3am3ItYCc05/Wdnqem5Ra
	 qnQT4nIyk6HvdZU+v4YBQwIU7Wml3ms7V3MVyAIjzPbaedyb+vvD1xEYJa6ZiITUQzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794842407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wtxoaA1GZGKQCL/btRr98HsH3RHAvR+/mLXVNHgmbEs=;
	b=KjbjfVhsLV3ICu99yUxGc9GuNW1NNR8dr47OzDAZ1huf6UTdBR675QY5CInDZFLlhH+q
	 xCwS5AE1cZcJWVvwQrfzEVDkRHO1tqBVWFXh8CPM8DGpvDcl6O6+Qx+bpqwL3/IVmEy9Y
	 M3Knjufluo+CtPCSNe4SBMc5FMhL10LiBaBUxycRaXoFwTz93KqfTdwYS3GgN/uNs/hfK
	 EZS80U43vs9jhIZcG4bKsg8496DWnVcdiXS6xZIpPVe2gS0nsnZDJ1pFnDGp43Q5oOir1
	 sqbsKC5bzPuOx5pQsCbZXIgUkerXaSaOL6jky7w4m0JVMlSKu2WfrWY/0zg+5grUUIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794842407;
	bh=wtxoaA1GZGKQCL/btRr98HsH3RHAvR+/mLXVNHgmbEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxUHs5huqbYVmQrswjAgEwrPibYgzo7u/EN7PXZS48/X5TL+Hgm9dvSn9Q46iKMtE
	 XQTc8kUH/wpYyTcd7hCD+aWkhmoH77UxowgXlR7oR6Af2IjHu2i/I6pLRJzYswysVB
	 OeokU+URz87QEtOPYKOEID8wdp3AA14VQOSDs2536VahtvUcZrRhyUj7+6GD4sK3Ic
	 sHcCgMxe7AR6vM4vWiP1+6RlFbPrmQLsYA6Bvwar2pFIQNv5gLFGVkxPdg9pfSItak
	 PcBDFdq04lczcs5u+HxA+AJWzgNJ6QQizjPK+ROvkRJEOzUugE1m34w2LqiVt8lPkA
	 kcxpnjVYiHoJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7310380E39;
	Mon, 16 Nov 2026 15:20:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A91728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C9074029F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwTapwXEA7CJ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 06F2240282
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lCKNWVPa
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06F2240282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:20:04 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-53ec9237600so2197793b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794842404; x=1795447204;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wtxoaA1GZGKQCL/btRr98HsH3RHAvR+/mLXVNHgmbEs=;
 b=lCKNWVPaDsPDN0K/E4UlUbo0bf/1TdlAbzyvkmWqZtx9NDqObxi1G1NkEVaB/lAo/d
 C7pcX4YM0GX74Ho5T2Y8sF3iRXjaSl5U0Sk+cNAWNGM4L6iSoYD8GPozTyDKynz7fDvb
 ULzEvrG/Qt/HW4T6YCEc023/XEMb1N/9HjWpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794842404; x=1795447204;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wtxoaA1GZGKQCL/btRr98HsH3RHAvR+/mLXVNHgmbEs=;
 b=hVI45n3LYd2g5zW2/vyYIAZyXpOlqdZ2Rq7K8ZB4aFbU6O0ZiimlDn46acqvSdcefn
 5n/aIfxLjm2A0+9HwhSFU7jKSMIZcgtBlP9I/oGWvZsf/gqi/ZrMu0e743FehFaC9n6f
 5qvhCxPttuLCvs2PIkpf42Ux3akWj7jsPpQdQtHtIukI9UbgYWEZExNhWFHW+UpiDvKc
 FsCqzsqy0JkLELJrHfitRHcFR9abwaa16mVOz2fKQcZdEEp2N1FF8VSd/dRem+sQ8xDH
 Z8xKOVd8hBSo12OLIr+5BYj5bMaEzV0YbZrf8cTUuKkDhCmOCE4d1ithsAiMpTstkogD
 o+RQ==
X-Gm-Message-State: APuU4Z/BcJROV+8MiXOWEXAyfQs7j+i69ARchfpM3ez8L5bXyfkNs9Ta
 OeyrTMRpvl0TxLG14KMEWCcdODRyt6JvnjXSkNdHxeF7OdapjaWvvTU0svQ+8neGCEU=
X-Gm-Gg: AYBFou2AZboK9vgUCM/EbGBBYF7vtZbhXm6Y82/e5NF7kDJ35VNq8a3lhSTfFNT0s05
 NQ84MIEaNUCIrbySCMmuJmpDgLlZFy6tJ50Sixa3wxrhPunBKhRkgVvNZ3kCOqIMLD652izrcsC
 oL/kwGMyt+rAiwn533PuQ4jIOLBL+YPkxHQMToWQ8OsYAMI9g51xlpeUcPfz5LrJ27zfIKfhIMV
 St4kSLTuvhIF68+OncgWsnObqjGRwbe9tP7BuSSu6BJAhFn+Pd2B1wtqUpFxISD12UNB7F/q1cr
 /dR5j4GiDd0j4nri3hMaQOjhw4YeyJIN9p+xeBtyfpmmbLQ2Uk8xYB9btYY+c/phMMnCoyG4LFY
 mtGyfz/NJdOWFrYYgfAoaqE1TxeZI0cSLbFg+5kuYzX9cyNz0VQsmNarcQ5szvfUUTRhMdpoDdM
 tSSYMC5UHLcV2MDtPaN3Nr8GvfE59sI3LTh7/em0mmWfFs31FnWQXIZ1r06wK/fZ1+6bO2oCZGO
 8SKBAH/r/aAtFo7EMuwlaC+b1kgmbfwdBmtU7kEwr/anl/ph+OJccxCqVEJj85zP41cllvb2xMu
 qSLH2S7qbiygcJak4YnfbuRvjkBlHxd6Ob23ixPoYNHIlBx+EzhCct6G5F0QsOXJ5JaZUDnCMMD
 h6pAL35dGVgLlGvN2H55VtARy+WnmWwQ+gHeaRaAM6BeM4rpYmwqojxS2bty62HeBPwCpyM0frj
 joLcQQaM8egNi2Tpw+Czp+jSg78cm2r29N
X-Received: by 2002:a05:6808:50a8:b0:572:8f69:6b0b with SMTP id
 5614622812f47-5728f697966mr6145456b6e.25.1794842403684; 
 Mon, 16 Nov 2026 07:20:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e7044690dsm10344901b6e.9.2026.11.16.07.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:20:02 -0800 (PST)
Date: Mon, 16 Nov 2026 09:20:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Linus Walleij <linusw@kernel.org>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261116152000.GZ554944@bill-the-cat>
References: <20261109221650.GA3741582@bill-the-cat>
 <CAA=k7=kgnH8EPpHpdKhqF98ykJG6QdaeYD53sBEdap5OudZwLw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gr+U1Yf+8dhyS7lY"
Content-Disposition: inline
In-Reply-To: <CAA=k7=kgnH8EPpHpdKhqF98ykJG6QdaeYD53sBEdap5OudZwLw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Gr+U1Yf+8dhyS7lY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:17:49AM +0800, Aristo Chen wrote:
> Hi Tom,
>=20
> On Tue, Nov 10, 2026 at 6:16=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > Here's the latest report.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Nov 9, 2026 at 4:13=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >    - *New Defects Found:* 2
> >    - 2 defect(s), reported by Coverity Scan earlier, were marked fixed =
in
> >    the recent build analyzed by Coverity Scan.
> >    - *Defects Shown:* Showing 2 of 2 defect(s)
> >
> > Defect Details
> >
> > ** CID 661899:       Insecure data handling  (TAINTED_SCALAR)
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 661899:         Insecure data handling  (TAINTED_SCALAR)
> > /boot/image-fit.c: 2244             in fit_image_load_storage()
> > 2238            fit_image_get_comp(fit, noffset, &img_comp);
> > 2239
> > 2240            if (img_comp =3D=3D IH_COMP_NONE && load_op !=3D FIT_LO=
AD_IGNORED &&
> > 2241                !fit_image_get_load(fit, noffset, &img_load)) {
> > 2242                    dst =3D map_sysmem(img_load, data_sz);
> > 2243
> > >>>     CID 661899:         Insecure data handling  (TAINTED_SCALAR)
> > >>>     Passing tainted expression "data_sz" to "imagemap_map_to", whic=
h uses it as an offset.
> > 2244                    mapped =3D imagemap_map_to(images->imagemap, da=
ta_off, data_sz,
> > 2245                                             dst);
> > 2246                    unmap_sysmem(dst);
> > 2247            } else {
> > 2248                    mapped =3D imagemap_map(images->imagemap, data_=
off, data_sz);
> > 2249            }
> >
> > ** CID 661898:       Insecure data handling  (TAINTED_SCALAR)
> > /drivers/pinctrl/pinctrl-nomadik.c: 171           in nmk_pinctrl_set_st=
ate()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 661898:         Insecure data handling  (TAINTED_SCALAR)
> > /drivers/pinctrl/pinctrl-nomadik.c: 171             in nmk_pinctrl_set_=
state()
> > 165                             continue;
> > 166
> > 167                     cfg =3D ofnode_parse_phandle(node, "ste,config"=
, 0);
> > 168                     if (!ofnode_valid(cfg))
> > 169                             cfg =3D node;
> > 170
> > >>>     CID 661898:         Insecure data handling  (TAINTED_SCALAR)
> > >>>     Using tainted variable "count" as a loop boundary.
> > 171                     for (i =3D 0; i < count; i++) {
> > 172                             const char *name;
> > 173                             unsigned int pin;
> > 174
> > 175                             ret =3D ofnode_read_string_index(node, =
"pins", i, &name);
> > 176                             if (ret)
> >
> >
>=20
> I had a look at both.
>=20
> CID 661899 (image-fit.c) is real, and it is a write rather than just a
> read. In fit_image_load_storage() data_sz comes from the sub-image's
> data-size property. For an uncompressed image with a load address that
> the caller asks to have loaded (a ramdisk or a loadable, for example,
> but not the kernel, which bootm moves later) it is used as the length of
> a read straight into that address:
>=20
> dst =3D map_sysmem(img_load, data_sz);
> mapped =3D imagemap_map_to(imagemap, data_off, data_sz, dst);
>=20
> Two things make that exploitable on a signed FIT:
>=20
>  - data-size is in exc_prop[] in boot/image-fit-sig.c, so it is not
>    covered by the configuration signature. The value can be enlarged
>    without invalidating the signature.
>=20
>  - On the imagemap storage path the sub-image is streamed to its load
>    address here, and fit_image_load() only runs fit_image_select() (the
>    data hash) afterwards. So the copy sized by the untrusted data-size
>    lands in RAM before the hash is checked.
>=20
> Reproduced on sandbox with a signed FIT (sha256,rsa2048) read through an
> imagemap over a disk partition. With the ramdisk data-size bumped from
> 0x1000 to 0x3000, the configuration signature still verifies OK, 0x3000
> bytes are written to the ramdisk load address, and only then does the
> data hash fail and bootm abort. The 0x2000 bytes past the signed image
> are already overwritten with whatever follows the FIT on storage; the
> honest image leaves that memory untouched. load and entry are signed, so
> the base address cannot be moved on a signed FIT, but the overflow past
> the intended image (bounded only by the 32-bit data-size and the end of
> the partition) is controlled.
>=20
> No in-tree production caller supplies a non-NULL imagemap yet: bootm
> propagates one from struct bootm_info, but imagemap_create() is only
> reached from the unit tests, and the bootmeth_openwrt consumer that
> would populate it, posted as an RFC in February, has not been merged.
> The code is in the tree, though.
>=20
> The imagemap follow-up series that just landed ("imagemap: structural and
> cosmetic review follow-ups") refactors this function and adds the
> data-offset range check, which is good, but it does not bound data-size,
> so CID 661899 survives it. Daniel's series that is on the list now
> ("imagemap: Fix boot errors and resource lifetimes") does not touch this
> function either.
>=20
> I will send a fix as a separate series,
>=20
> CID 661898 (pinctrl-nomadik.c) is a false positive. count is
> ofnode_read_string_count() on the "pins" property of each child of the
> selected pinctrl config node, used as the loop bound, but each iteration
> reads pins[i] with ofnode_read_string_index() and returns on the first
> failure, so an out-of-range index is never dereferenced whatever count
> is. The device tree here is the platform's own description, not external
> input.

Thanks for looking at all this, I'll go update 661898 next time I pull
open the dashboard.

--=20
Tom

--Gr+U1Yf+8dhyS7lY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavsfHQAKCRAr4qD1Cr/k
CtiBAQCnklNFV1rZ0Cu+ADL1IFRambEjDeGLVSWUFebNWTMZ5AEAx1t01NZIvbiZ
FZM5KOCAOjQWAP7zRV9cqB8BiBDIJAs=
=3+yt
-----END PGP SIGNATURE-----

--Gr+U1Yf+8dhyS7lY--
