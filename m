Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CA606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s4EU6dSR;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RKNDj4k0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E12F360750;
	Fri, 20 Nov 2026 14:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heFmoT_2NT59; Fri, 20 Nov 2026 14:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CAA160B8C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795183233;
	b=WWprP7RoL3FLgeJX6CPqPlViuIzwanWKOWQ2CbJjky2QxoF1FRTHN8M9v+bTryJVxm3I
	 zOUYQItVN4lsV+Zv9ERBvFHbrsZFSbQaq4/mtwyRieXSX2TtLpVQgws68WhhjxT7UC5K7
	 XIHyY/rbfkl0aYomqIlQqY5D2R/emSeO3Z40b+eegSxg5k5IjwJcRAWQCzaMRdD3pD9O/
	 Bebg1AxrREBW6oMq1EZ33YbAqfk5uz96oa0C4ChZRDjG0OkObup4O7bLSJFiFxOLyIDRw
	 bnHU9SUy1XnJgCWUZs+YLHDQpGBqtpedSN19+kxoorUWGv7+VocvIUJZq/Xv1E/Me2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795183233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RgSpafruXZMy+uemMb1wfXttdLj7N/cUpK8Rk/XyVL4=;
	b=eJ4EczEXz25axixpENgFlQZf3nM7Y/a3aJLPNaKZPX/3hHnpn4l0PAueZSNr+Kj1ObSR
	 3X1EvVPMRbIC3mol76APhJarYkhJiATU89cmRHILqgXh7DDRR6sT5qA4iL0wYcYS4FI8O
	 z85jTlSEgfJRHVc2z7MmYQGgyrcX6WWAfAutDXBgjnkQ5PfHi18GLc7IeIRq1iwGAByOG
	 DOi6mbxh5Obqmc+o7Qe5HWwejzOCDCXmz7MqmVrgddMmnwx8QSpb3CzH/VxwZLZP+Ym0X
	 zXwkqyiaBnPe6Rx2omoPaqIsynDH93FWUx7rCN4VhTlvB0Niuj4JoRB+0lpcCtyO5lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795183233;
	bh=RgSpafruXZMy+uemMb1wfXttdLj7N/cUpK8Rk/XyVL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4EU6dSRsF1Be0WZcpXHhW8C53sF2vUFHMc6hoKXHeKRaLSKGWsvkf34T/5diuwW+
	 ixPVN9RVDYQ8EVDFZEjVmsHLvui6foSvu7+nanqcMArc5eeWq56KUWp/G9opbQMwy6
	 cjx8djbkZx9496VEOMr/HjE91YdHKO5ezUnLnJHMzm+qS8cBV6X78zXihxlUtCix4M
	 rw3b+PA2Ocb/mVO6CrGT3OJ3FpKC9DtraVQQBpl4y7OoY+79TdNRxPl7K+rqC8ZSdQ
	 vfAHBmPkkEetqHUQD1aI8pDa/yIrIUBVt8Hj9XmySQ0HAcqjA/NzzSPS/CYsyvzzQ9
	 i6QftFZw57pJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CAA160B8C;
	Fri, 20 Nov 2026 14:00:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 14295E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11EDB81691
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXu34VIm4ZJa for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38E9181690
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RKNDj4k0
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38E9181690
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:00:30 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8451a619da7so595122a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795183230; x=1795788030;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RgSpafruXZMy+uemMb1wfXttdLj7N/cUpK8Rk/XyVL4=;
 b=RKNDj4k0TUPtytI3iWKCWY1vFwzwzb7fXcEjY5RmgOyzxx2e/fYRg+fS6/PdcgMHZF
 nJPqJQ+lW0wAnOYcUJAF5G2jBYkR1TpNy8DEybvbO3HyWN+H8ho5RXgV26tfZqQZwiX2
 tGiPgi9rpR4te+pGtXrTIhFNNiACzXNYQn6sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183230; x=1795788030;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RgSpafruXZMy+uemMb1wfXttdLj7N/cUpK8Rk/XyVL4=;
 b=dRAXu7OB6tOsFydPpNKrs63SgZCJHsmSHEucYyNnAnv67S+P0/jWu39CGp332dkzE3
 x11C3XYbHQsbV0g6TdoBHZKWZFCa5gReehFgfvVHPgTe0tnJ6kneiRnmAOCH1xkQIapb
 GTUItJfvA8UCg7piIJCavkRxmEUjLVUnsKjzv/g4+ZTY7ZC5hX4w+k5mdWjhqfY3Atf7
 5EHnO65QdNhAEk3qCBhZ8IgEh+jUBJI+50xxqEqkih5BgDQlX6bt+MZf7c8tigkl4gUM
 wNFfGGVESb4si33ESTvQFpOY0R/AuJM0zZHWzeE41uvDKZHXZhrzWliY5GX0xIsLtflF
 lx7w==
X-Forwarded-Encrypted: i=1;
 AL+hErGXvHFKtlZJqPJQDzVEjbX6RHV29Vv1Spjyc+s7i2cqyFxqvFpGWf4RnKQSPxGYFxfWZisSQj8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8c7Gs5R6FlgV8W3hRyjNVZJPoh1D05z4mxzZEqESLJMNNsfFCg
 ojO/OHuMkQ0q/6kKu9UdHa33n7rvdBWA3BXgedXaR8WIuNGJXe31Of90q1fnMyoTMHY=
X-Gm-Gg: AYBFou0rrunKh+mwxmr/9PawaYYEDqrx+r5bneSSbSgGpqmO0XC7t/IDXMOgG86wltL
 puzQUN3YBwoi4kAv2I8ZZn5qL9dro2Zgrj0EH249Qgi4hbUxTEUl79OhUS3tjKN5jdKH5uFhTDd
 d41SWedLx7NvUDP8tlvuKJU0Q4dN1cLLX0NBiKmv5r7NbK+o1JIHQ3Qe2DJqcvc0NwLOWOMvaFh
 DD4QJD3xvWbd18gPpmK+OrCssfYDRG3yXcXCoMaZlRRbWIboNK8F1JTXg4v90snxXeGFwE9yE77
 ACepc8ZK902hk5AiTIS0ndcBmtRly3QIG21oHw3BM+afvVQNfvaMfVDW0s9cBL/IFp3BiAsMakf
 9ZioOY4Zne/MtAiHsROh1kYCw+gsSW2j3pMcad/xN4kpeXbvX58gJRSenk6nzFVtn2Rh9AJPXo2
 a872SUVuoN56HgpnSC6W9IxIQ/OwY0DyIboBJRQUGfa9vww3Qwl3ADTJnWp1IemU2VMq35FfoV/
 zJsmD6ZJeArp0SkWMFt081PX7aBJt+hmQeZfj2E5XIbPkNEL3J1ypez8BnkNTAEp6+RHry8Bn+E
 P/e4mYrRE25zRHVAv3DMZ6MqHJ0sg/Wuj2OMfswKvGciNhVDIXqvKENzk/EvZw1tA7aWk47id1H
 2R/MAgT5AY1FccMk9ZdfJ76li0kLZAC02u5iZtr59obWx3PUKIqLUwJnptKfIKPdPu0gtKiyNnt
 2Ayn31csnAmxEg00j0
X-Received: by 2002:a05:6808:4fec:b0:4c3:7695:1177 with SMTP id
 5614622812f47-57a06c1bc3dmr4280464b6e.6.1795183229406; 
 Fri, 20 Nov 2026 06:00:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdbb4fsm2682869fac.5.2026.11.20.06.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:00:28 -0800 (PST)
Date: Fri, 20 Nov 2026 08:00:25 -0600
From: Tom Rini <trini@konsulko.com>
To: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Cc: aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 abhilash.v@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, gopinath.sekar@oss.qualcomm.com
Subject: Re: [PATCH v1 1/1] board: qualcomm: shikra: pass TOC FDT to BL32
Message-ID: <20261120140025.GC3176972@bill-the-cat>
References: <20261120102438.1382555-1-kr.sowmiya@oss.qualcomm.com>
 <20261120102438.1382555-2-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TzAxP/d4jTGfybmd"
Content-Disposition: inline
In-Reply-To: <20261120102438.1382555-2-kr.sowmiya@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TzAxP/d4jTGfybmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 03:54:38PM +0530, KR Sowmiya wrote:
> Pass the optional toc_fdt image address to BL32 through
> arg0 when preparing the TF-A parameter list for Shikra.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> ---
>  board/qualcomm/shikra/spl-shikra.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/s=
pl-shikra.c
> index c2a5d2d692b..4367a5e7264 100644
> --- a/board/qualcomm/shikra/spl-shikra.c
> +++ b/board/qualcomm/shikra/spl-shikra.c
> @@ -20,6 +20,7 @@
>  #include <mmc.h>
>  #include <part.h>
>  #include <spl.h>
> +#include <atf_common.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -477,3 +478,29 @@ u32 spl_boot_device(void)
> =20
>  	return boot_device;
>  }
> +
> +/**
> + * qcom_spl_board_fixup_bl31_params_v2() - Apply Shikra's BL31 parameter=
 fixups.
> + * @bl_params: BL31 parameters populated by the Snapdragon implementatio=
n.
> + *
> + * The Snapdragon implementation handles the QCSDI-to-BL31 handoff. Shik=
ra
> + * additionally passes the optional TOC FDT address to BL32.
> + */
> +void qcom_spl_board_fixup_bl31_params_v2(struct bl_params *bl_params)
> +{
> +	struct bl_params_node *node;
> +	u64 toc_fdt_address;
> +
> +	toc_fdt_address =3D qcom_spl_get_toc_fdt_address();
> +
> +	for_each_bl_params_node(bl_params, node) {
> +		if (node->image_id =3D=3D ATF_BL32_IMAGE_ID) {
> +			if (toc_fdt_address =3D=3D 0)
> +				pr_debug("TOC FDT address not set, BL32 will get arg0=3D0\n");
> +
> +			node->ep_info->args.arg0 =3D toc_fdt_address;
> +			printf("TOC FDT address passed to BL32 (arg0): 0x%lx\n",
> +			       (unsigned long)node->ep_info->args.arg0);
> +		}
> +	}
> +}
> \ No newline at end of file

There's no newline, nothing calls this function and the cover letter
doesn't list any prerequisite series. There should also be a
documentation update *somewhere* because without any further context
there's no explanation of what this is doing or why we want to do it.

--=20
Tom

--TzAxP/d4jTGfybmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawBScQAKCRAr4qD1Cr/k
CtxXAQC6dzFZ6p64lA5kUJ9oellnIZ47BplIhCv1ifxvkKmd+QD+KV3OgeDK3PJ6
mFgt1uIGNOvSr5c+hsJLkKcC/K2cnAY=
=ggHg
-----END PGP SIGNATURE-----

--TzAxP/d4jTGfybmd--
