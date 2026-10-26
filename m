Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE03606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=04RAQfCH;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aLHr5dlk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ABCD8098B;
	Mon, 26 Oct 2026 21:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiiXgNCKtDrL; Mon, 26 Oct 2026 21:08:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51A8680806
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793048938;
	b=Jl02vdSY1ivObxHkAdW8EeG9WsxzffHBlPjgBdpHQwcZzUjknMGdJ5ZHYLp8hM4QKea+
	 wtUwxAgJK64zPs+5U7CxcRfctE73SxKiccIRdRzOWmjYQpG9GcdcOdICXWlxV6UM7v2mb
	 RSk+nfMFedcMFe0Z21GT2ZVt2bvVKmS84t82ZZIoXIp7ntDgo3UTr2kFwwQJzD2WJCHLz
	 UH+Qyq13tmM2INRf05+dZOKXyX8ea3VJpjbx/g8SzASGOCG5NV9NDPiAUAdoPEqRqXQgw
	 FBMII7ArYJ3Ipj5AhzB0Zg55C14A2iD+y4Oapgjwyv//fxGlEdlXrW82GlMMJYconzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793048938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/orsSUpP+6Mx3Cw2su/kM7ta+94sDKxmwPUpy6D9+a4=;
	b=nDqwfrO7mIClL//bLm3zKRo1qhUY4cGmfzzdfN32+Ve6QbvnhStCXpDfPEkBtTNm3YPe
	 EiMtYPnkVYsuKCKSoR9OUOZkle+2WeWjzUhJuqDFH/+/xqYFBN5bvvnK0DrQHadMurZ0T
	 V3g6eEQ1EH49EfdzBHRWQGs68Vc4zzyekRE4E/Z9aXH9KQPYL0pOQkFs9l63NT+w2Mi9U
	 MM/TxxsDTYv/gEKB4CkNWYbsm4GNO4QJYu1eSimay/keEi274VrjHAqpqSHtR5IXe0Te7
	 AEAyvguiWqPgKH918hl52RlyLN2GV0P7Ve/tvnhn4ZwP5cOPq3UNF2zpEg96uuihR1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793048938;
	bh=/orsSUpP+6Mx3Cw2su/kM7ta+94sDKxmwPUpy6D9+a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=04RAQfCHZLoHUI1S0XAuV+a0gED7hrCt75LnpSgjfcthB86HweETcNinAha25DXY3
	 Aw4htou/yyM8FFBKQHUhWKzifnMdn2lhvVqP4Ya50VZO0Lw9BUpMN7yxMDPmFPy9LT
	 jDvP1LZ0lc1/PNV0D6wA6dwOcPo6q44CjaH/tiFTnGZk5GsnjpRnjD2dnj8+1vzwui
	 a4Lq8M2KuVjWf4m1cUtqMI4Yp1wQvVQxERJV5rZIXaBsOFDBI1QghlSUEXh50SjxdM
	 DPO7HEiUJTZS22HP5tzjZtESXGrAEvo705ybKS0NOwdhE9lM3AcZYNg3JJJagKUAW6
	 X+m4O0SrY+qhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51A8680806;
	Mon, 26 Oct 2026 21:08:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA306235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A034D40205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j2-4LAK3jIuH for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:08:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C68EB40112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793048936;
 b=myjVM5ui6uG0/K9jtQI0XHZyo/88iMw7MFbQaPqYgM02isGJqg3sZgPQg1++WQZjp6ru
 0UfLCza/O8B8Hd6oTUseIb2n6VHZEz8HEpp0qh4CkCu6ESH0VdCw6W7aF3kCSROeTlxOr
 TqKEsTdVStIf09Wf84bS51ZibU9pPB+VA/KiDeUr1GewOWRbHwbyMwUJppyMXOWymYmKC
 N46bJsivxksH51jg46Wx5zCWoyUiDhOiu4tD8O6SqJwtqt3IGEB1EYHMaIkRBR3L58RmE
 9MsUy1J3SYcTMpgR2urNbsExyU6D1ducLThcsMnBDNdk0hUSRm2aU+o+B2XEgVgAKGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793048936;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/orsSUpP+6Mx3Cw2su/kM7ta+94sDKxmwPUpy6D9+a4=;
 b=SKezt+kjYZxxfTIO3e/6ulwJme4YMNmlVldZcXQvV5QMCbG/tPjf5Qa61wtaMVzovYSI
 CjSyVKB9oO9auNoFwxiEgWBvTFzp8J3fjcLJgv4646FX8UHmaKeWVvMQzh2ag6ma8PU0A
 dD26CUs04IQAplxcSYv4P2TkJUb119h+Pv3/2pPLYYqzBPnqZSxyiN5J2b3Y9CjpH6tgK
 2wKpUwZh/yijn/Lh0dHZCKDHMbcXVZ7BBHHF6p9wiO8vWNLieLMcCwvbXTpQVqMdMebf1
 4y2M/eEGEnaBDVH4Tb5IwmCYfisMcHGM+YcGV/4KK4CcxiSims88IOepjgO82MY9Hxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aLHr5dlk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aLHr5dlk
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C68EB40112
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:08:55 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-82380b0f55dso1665869a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793048934; x=1793653734;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/orsSUpP+6Mx3Cw2su/kM7ta+94sDKxmwPUpy6D9+a4=;
 b=aLHr5dlkDlEnw2X/PDyYUgTKcBMcDNqDMbcTEK73pb2Mhgmm7Dy07nUXnDyV0AG98h
 Oqo3b1tXoZKPCo/VaHtmKuqJfmf1HTiQDcSGiHTx3G+gbgAXBFzrpJ8yftWY2xYAskAo
 wMgITBKsQHv1Gl2CoW/ye/CEPa+yrgj0gOW+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048934; x=1793653734;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/orsSUpP+6Mx3Cw2su/kM7ta+94sDKxmwPUpy6D9+a4=;
 b=wobwhbu1C8XwkWxK1ze51KGRfbZxI0518XOk4S8oypb4/X6VrrxdFk6ur2ZjA+iUke
 cAeAAbsVUS3FfMH+PSfmNkrLkTeGjiKVUDFYKZ9PdtBq1WdhYKtK0wGBtjRO/IolEYct
 JiG+uyoDXcpdLg8ojO5JVCEPvsjHyneUIasg4pyPj1le9d4lFrIizy5EX6LoL/jH4OnG
 YAOX5innmuatAPhLfTInllmYgY9Pdeb4jlI1UdC8E0lr1ENpZd/E9jc+s+w89dI39qDn
 +C3ABq6c/8TwCtMUTSCVUbFPJhsn7o4OzCCVizlFrz2fRlU4az5KfbGe3WWvzTImnGzl
 4Zfw==
X-Gm-Message-State: AFq9FYI604Ds2FYMLAJ38kSBJJAeYFWwSYaWU87GIRSNQKYMSr2NmFUu
 hgMQVS9efjANnEO2so6bKScO8Q2bW6aydKbRq3hs2kyq4xggTO8Cpeo5z87MpmuhtYQ=
X-Gm-Gg: AYBFou3D2CrWWG4agblzFiI4jIzgrtlEMJ9QxEJDMZve414lWajy7ow4iwBY5RAVvsm
 09rPX8KlYj3TIv3Et7W3/VCTAz/iDhNoAGFKw/5E2dJakfeyYKDhwjya3mhGWdT8Lwww3ZHfAKW
 F2bRnM2zmpLgyG9nO8h8/p1OKpoA20vt7OAvHgTF4dH7p2IiiZsHIUvtH1zSdISIQx5X3yP1ZH/
 SLnG8SnGrZMibV0v4297la2zkx9woFUVmJ53tpOJvG42u9wNgLP9wrkPJWFit42V8JFPmTKthKY
 Lah4VwRxz7D/Q/2rl+5RVisNlBXc0W4+vV+/O73hou27FKchs5z/Ga8YMCLq2Dgppia7zWKlRHY
 Yw59AvtN6VVoMwPsOPOVm4Bv7ZlIHv0xpYpFvGRPKSKWCluSUfKjJ/cSi/uRRDlIUnsc5tkF4Gt
 r5AKZGDl4IeN/ScIjurEmcA+cduep5oMIHjhYqpvNZbbD+hhq88oDJtinw4m1ruOI6Bohwv/jgx
 leN7h6Aqjw7PBM5oqzUPEHqyj75OnfKou1UmdG6ibllsaG6hq1MZeT9B6K37glDMkl6XXVAeLiM
 RZGOhuTNm3nRiJ4HGeXuRXpvxF1KCNXV0erxKTkeMr52XPCyFganJ5/5jfsMvEyQtVUVw4FWX3P
 cb3gILb0YuLqpK0LovCALcf9wRM1juDQswfGGl9aL2aQTDd5YS1aSk0cfjw==
X-Received: by 2002:a05:6830:6512:b0:81f:138e:77a0 with SMTP id
 46e09a7af769-850fe3f7864mr6249445a34.24.1793048934230; 
 Mon, 26 Oct 2026 14:08:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fbb260aasm9337062a34.19.2026.10.26.14.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:08:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:08:50 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clegoffic@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH 1/3] env: flash: Add an erase operation
Message-ID: <20261026210850.GK646438@bill-the-cat>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
 <20261026-clegoffic-env-flash-erase-v1-1-18777abd1bde@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fA8EE7IGN8z9DMmK"
Content-Disposition: inline
In-Reply-To: <20261026-clegoffic-env-flash-erase-v1-1-18777abd1bde@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fA8EE7IGN8z9DMmK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 03:41:02PM +0100, Cl=E9ment Le Goffic wrote:

> The flash environment driver has load, save and init operations but no
> erase.
>=20
> Erase the environment sector the way env_flash_save prepares it for a
> write: unprotect it, erase it and protect it again.
>=20
> When the sector is larger than the environment, the rest of the sector
> is saved before the erase and written back afterwards, as the save path
> does.
>=20
> With a redundant copy, both sectors are erased: the active copy
> alternates between them on every save, so erasing only one can leave a
> valid environment behind.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Cl=E9ment Le Goffic <clegoffic@baylibre.com>

Using LLMs is discouraged in U-Boot. Patches 2 and 3 are trivial, but
Claude is tagged since presumably you directed it to implement the whole
thing.

The commit message is one of the things which bugs me, but it's also a
more minor thing. Handling redundant copies correctly is an expected
requirement, not something special to be explained, and is something the
other environment stores handle too. The partial sector case is
something only "raw" flash types have to handle, but again, all do. When
handling expected functional cases, one should just acknowledge them as
being handled.

But the commit message nor cover letter don't note the real problem.
That is CMD_ERASEENV can be enabled for ENV_IS_IN_FLASH but is not
implemented by the driver. The next step here would be a quick check of
which other backing stores also don't implement erase and then updating
the Kconfig logic.

> ---
>  env/flash.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/env/flash.c b/env/flash.c
> index 31dd1656e721..4b402437eb77 100644
> --- a/env/flash.c
> +++ b/env/flash.c
> @@ -310,6 +310,66 @@ done:
> =20
>  #endif /* CONFIG_ENV_ADDR_REDUND */
> =20
> +#ifdef CMD_SAVEENV
> +static int env_flash_erase_sect(ulong addr, ulong end)
> +{
> +	char	*saved_data =3D NULL;
> +	int rc =3D 1;
> +#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
> +	ulong	tail_size =3D end + 1 - (addr + CONFIG_ENV_SIZE);
> +
> +	debug("Sector tail to keep 0x%lx\n", tail_size);
> +	if (tail_size) {
> +		saved_data =3D malloc(tail_size);
> +		if (!saved_data) {
> +			printf("Unable to save the rest of sector (%lu)\n",
> +			       tail_size);
> +			return 1;
> +		}
> +		memcpy(saved_data, (void *)(addr + CONFIG_ENV_SIZE), tail_size);
> +	}
> +#endif	/* CONFIG_ENV_SECT_SIZE */
> +
> +	debug("Protect off %08lX ... %08lX\n", addr, end);
> +
> +	if (flash_sect_protect(0, addr, end))
> +		goto done;
> +
> +	if (flash_sect_erase(addr, end))
> +		goto done;
> +
> +#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
> +	if (tail_size) {	/* restore the rest of sector */
> +		debug("Restoring the rest of data to 0x%lx len 0x%lx\n",
> +		      addr + CONFIG_ENV_SIZE, tail_size);
> +		rc =3D flash_write(saved_data, addr + CONFIG_ENV_SIZE, tail_size);
> +		if (rc) {
> +			flash_perror(rc);
> +			goto done;
> +		}
> +	}
> +#endif
> +	rc =3D 0;
> +done:
> +	free(saved_data);
> +	/* try to re-protect */
> +	flash_sect_protect(1, addr, end);
> +
> +	return rc;

All of the CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE code is the same as
the saveenv with the variables changed. So a refactor is in order.

--=20
Tom

--fA8EE7IGN8z9DMmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/BXgAKCRAr4qD1Cr/k
CtVYAP9Q98QaFcm3H3bxLP7Zh2qn4aw6dI19LeDzqJ3ECDMiNAEA3RZZJKh57IbD
SrJh6ti5orodawdi2lmHP3jFI8NUuQ4=
=Co8B
-----END PGP SIGNATURE-----

--fA8EE7IGN8z9DMmK--
