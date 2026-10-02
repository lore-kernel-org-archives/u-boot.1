Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D11CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 15:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F1416062D;
	Fri,  2 Oct 2026 15:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PE9jnBGJU5IK; Fri,  2 Oct 2026 15:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CB53160668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790954773;
	b=krURUgPXU3IKa30lEljvDV5QETDAxxxxiATOZRdOqEikYGfAi3jyf56tW6Uce0duRMd8
	 Kr3z76QQmAnOOFPJe+oQevjXsjfWThW8bWF1gAmdnQuM2xQulrYsCjP8Hvk+KDcchBtp0
	 yclEs2fovZY45Q9h9dj7Cja3qdNbkCuaAHtuH3vS/rK0u8HdgMTo+BgSmGdR9pwlKlKpb
	 dYlv5mGDWa5Y3uzxGZDlfD3BG5K8jKUuLOu4AI/bi51ytmnBkqDeKfu1hiQRxYwXIaBbX
	 8uTqJ0CU9JmP5o+O66XHr06QMP2WPDj+JFuVtzn0y8LUEP5K+IOf1rgKbzBcVJH3mRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790954773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AJREkcayAU41gLN/crN2WryxF/eh39YSBVA/ueZ/DXo=;
	b=Lsknh5HcoNhhFrJjsQFwfUIhzz2HiyvY1VNUOiRPIHPkgXBaebXZv+KPw5bGLKR5GAZm
	 owOSiBO5zImqcHLE34Ekev67bA2cpXQ4z9QhVOuVBHwL4CKJB0xGGSUvuL+XNBQQ/fib4
	 Sgt5vxhg5ouUBaofnhoYQN8HmUasD3EGlThSqhiJOy9hVbS/a28AU5eB7Fzko3h7VLkEW
	 5pNAIE1zzAXoQ/mp3Li+o4XQwvejDCv7s5pKl/DR8Ew7E2ZTT2AJ2ffBWkSuL26BWtWqR
	 ntDElBEvx1htTzHfi8yhXV0i4ZXpjT4gkKdaGFU6aJGd7YZc0jCE0xBG8HZe/esZF7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="h5O3o//I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790954772;
	bh=AJREkcayAU41gLN/crN2WryxF/eh39YSBVA/ueZ/DXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D0XtJp4Xeepd/oNLiuzbEzxP+xUPurDQPLHwHvZlSbSRTP6S+HwZUccmTI/4gj/Q9
	 dRg80QxN5XQ7YyW4OrBtjBTNJQS1jJtY6cYLBxCRJwBZ45aBpkT/m3phV+3iZfWYuh
	 +3DXoD+tZmLtcikf3PhNbZ/AeebDYHSrqdCAYXhYojc62WOMWc3kxW0X1eWRj2EESA
	 maBW7YGznw8jquMMNZIXnBwoWj5qtl9k+5Xy5WowJ8IKNxCiIGvoHGkpfiqTQE6T4I
	 oeTw1ERgFh3HvxVr3gdQn2YYE6DmzkW7Ryvt+dS4GfCPujNOw9zvc9vD6FP5ZWd06U
	 GyUsqCcMfXO/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB53160668;
	Fri,  2 Oct 2026 15:26:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EDE3B435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF92B60668
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 07w6R8E8j6ys for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 15:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2A5B6062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790954770;
 b=VggEOBkcf+hv/Q+ShiaBLOjasPcx4IFUvOHHHqF7WzKpcyiGJjvsnnUYnIEv8jNWptw+
 VKBSkwY/b5V5dCBUpTX0FTs0wByoNeylsEaaumYLXH1YDJzQbecdpkjB5Yybycq+ugWaC
 rLvI3eoE+z/ZLFHTzk5ihOz9jNA+j0jeZXWpoByPQbCutZpYnTFYyEKBNUHu9AlxWQAeV
 NaFhbFd8GIYZFliNoeSGPC+uQMQzpnrvmI8G5/WgnYpq0Kl2q7z5nA77GPTt0cHFHZ3QE
 vx5VeGhr5908tWHfoz8w42cFwZkWxf0PzJbZR5HJtTUMJqE2sK+uZVJwRV4wGGO+sBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790954770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AJREkcayAU41gLN/crN2WryxF/eh39YSBVA/ueZ/DXo=;
 b=A6N9ETu5qlkS1C4CorsNlLXLVvUC8tDOqU5/ryzO/n4DX6GMVSqmy/mprUaubllzL/JP
 1kKau0zDlgK4QHMppw/RptLHfjljopq4s4DvgjxhOXh1+kFlTr7Q6N8M+qYPVfecjMfkD
 qI0DEgFDQba16AQJDw6T1yN5TreV27RG4yRl9OfJTdAWvQmUhB9DzzNpeMKGAwIy++ROd
 r1HYKShhpAECcMAxo1Nk2d5eVBrb/4hWz7vt7xjuO1KWJ7rF+foDpaaOjDKh2sjNiczQ0
 mDW4kI4UFIY5BjNQk/n2T3sOGRIXD72a5EMatQ3BNcrqIP7dBCAMWV65rw4M9nIWYQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="h5O3o//I"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h5O3o//I
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2A5B6062D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:09 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6defc0a3724so3186eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790954768; x=1791559568;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AJREkcayAU41gLN/crN2WryxF/eh39YSBVA/ueZ/DXo=;
 b=h5O3o//I3S5/FPfqD4408tB8jmHSRvpvk0Uw/oj1XUipxAss45KgoMPz9v/d+R6Xqg
 iyK4R/Geqr8/+QI8gSp9V/fg6MQR85licENJsrEfC3WMYeDe8KcsBUBZzPey55mj/cxm
 hnrpHHI1ahdAXWnDTRbqq1sgEhw74A53gkVMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954768; x=1791559568;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AJREkcayAU41gLN/crN2WryxF/eh39YSBVA/ueZ/DXo=;
 b=r/48JClcH/zWT+napJKas8ZS9NW7ydchBeeQ59nyAgn7o80yVW3UL2Md+I3bfe8h3n
 e7Ue4ybODaxtiUmEOgzh4ueFkVzlLd/4o1rAmjbUnOWDMloy607s+q3nCMnc9ex2Gs3y
 nLbvnqVw1tyKAwLNycFSBajFpaw/KNp59y7qOw+6mGqRK+8La6P9h/DStVOHczyyD8R5
 RCPmBW+XnlL3LqN+LJh3RknlvPlKWvg9esLDna6SIrHBaarTmtqdDqkrhVq2Or8F1fyf
 HlACSmZTYD1VpSCbN1fNf6kNLEa5XzTFMstyGbGXGOMQhe9FlHLG4fVbO8wtJT6Ib9fG
 WQdA==
X-Gm-Message-State: AFuF++nIbMIcS7GDOJi1MdOsYnLEDK6/PdtknIhYtvxnyFcatnI9SUoh
 WXM7n4n3l+kz7wdf0IRP438yeWbf2frhvEwVWizBSLeL3O804ri/nUglzlWcF3HTwXU=
X-Gm-Gg: AYBFou2+fnCCez1+M5nYgGJluD4BR3k6Ag70ZBq30/vAqbcnLOZiJm8N/LurbWI7rt4
 kt4lyEPmYO4En0SKKNp6WP+XaP6SVNFQVdFhFtYO3Wz2t4fz/KL37tWLgrXAwfWKBdNGqTzxhS9
 NSojgBCBfAkgTnszfjdyqqRez9Qq1DmEFIdeuezK79QZ9LdcloU0qyAkwT8DjiskiLGpBtef+UM
 GK7HSlApHx04c6+ISf1No2yYsnM8xON8WXr8nHYYLEvRLIlXC5bNv4HDwNFNChb+w2JfxRO4VlP
 kFiR7+2QmXIa50mlwyUL7b8yYGunXZFOHyjS9GVyZuU5/lhUDIFsdUmIgu2DC+nv0dD2Ql1l5KY
 SS07ipfW5S9maYZwLiNXGgRtYn2pX1N5ZYD8DTGV0+jDwfkgAfLEd4Ykqwbh0FlEL4oquKzw6IH
 AOfp754AbXmiUSrlmfGNQs9rpnQvTAO7y+9J2bfCH8ei79dOrZxEpmHL8ntWIieDXmy6zpf7/0b
 qHYqNzEn+YQzDGNW+mthKbtiNMNQcMvS4K7eUAHkt8IWppzC1AL+JXiWdQPX/IzyiBe5JY5JrSO
 nXcPOAPEtLnlrHuCBQ8=
X-Received: by 2002:a05:6820:1907:b0:6b7:8396:f3c3 with SMTP id
 006d021491bc7-6df3477b080mr2211164eaf.37.1790954768295; 
 Fri, 02 Oct 2026 08:26:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-822768d21b0sm3040380a34.1.2026.10.02.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:26:07 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:26:05 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 03/10] disk: efi: Reuse the GPT entries buffer with
 simple malloc
Message-ID: <20261002152605.GT858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-3-bc44cf0e0289@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cKkU4sRLPnrZo2kH"
Content-Disposition: inline
In-Reply-To: <20261002-mt2824-v1-3-bc44cf0e0289@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--cKkU4sRLPnrZo2kH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 03:02:21PM +0200, Beno=EEt Monin wrote:
> The simple malloc used in SPL has a no-op free(), so allocating the
> GPT partition entries buffer on every partition table read leaks
> memory. With repeated lookups, SPL can exhaust its small heap.
>=20
> Keep a single cached buffer and reuse it while the allocation size
> does not change. The entries are re-read on every call, so the buffer
> is device- and LBA-agnostic.
>=20
> It is safe to reuse the same buffer in the single-threaded xPL context
> as the returned pointer is only ever handed out within a single
> partition-table lookup and every caller consumes or copies the entries
> before the next lookup.
>=20
> The change is gated on CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE), so builds
> with a real free() (U-Boot proper) keep the original malloc/free behavior.
>=20
> Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>
> ---
>  disk/part_efi.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91..8a57fe911c4 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -1141,7 +1141,7 @@ static int find_valid_gpt(struct blk_desc *desc, gp=
t_header *gpt_head,
>  static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
>  					 gpt_header *pgpt_head)
>  {
> -	size_t count =3D 0, blk_cnt;
> +	size_t count =3D 0, blk_cnt, size;
>  	lbaint_t blk;
>  	gpt_entry *pte =3D NULL;
> =20
> @@ -1158,10 +1158,27 @@ static gpt_entry *alloc_read_gpt_entries(struct b=
lk_desc *desc,
>  		  (u32)le32_to_cpu(pgpt_head->sizeof_partition_entry),
>  		  (ulong)count);
> =20
> +	size =3D PAD_TO_BLOCKSIZE(count, desc);
> +
>  	/* Allocate memory for PTE, remember to FREE */
> -	if (count !=3D 0) {
> -		pte =3D memalign(ARCH_DMA_MINALIGN,
> -			       PAD_TO_BLOCKSIZE(count, desc));
> +	if (CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)) {
> +		/*
> +		 * The simple malloc has a no-op free(): keep one
> +		 * buffer and reuse it. The entries are re-read on
> +		 * every call, so the buffer is device- and LBA-agnostic.
> +		 */
> +		static gpt_entry *cache;
> +		static size_t cache_size;
> +
> +		if (cache && cache_size =3D=3D size) {
> +			pte =3D cache;
> +		} else {
> +			pte =3D memalign(ARCH_DMA_MINALIGN, size);
> +			cache =3D pte;
> +			cache_size =3D size;
> +		}
> +	} else {
> +		pte =3D memalign(ARCH_DMA_MINALIGN, size);
>  	}
> =20
>  	if (count =3D=3D 0 || pte =3D=3D NULL) {

This doesn't seem identical in the non-SPL case, since now pte is always
assigned. Or am I missing something?

--=20
Tom

--cKkU4sRLPnrZo2kH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/NDAAKCRAr4qD1Cr/k
ChWMAQCFLDI7K14nPC8WQbsE3a82JWX84ZSGxUURoTbrNcXr9AD+N/HZSYlUtXCE
BNn4VIwCQMbTt8RPH78OD6RWm5Omsgs=
=FKb/
-----END PGP SIGNATURE-----

--cKkU4sRLPnrZo2kH--
