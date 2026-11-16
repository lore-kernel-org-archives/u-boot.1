Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445C606A32F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uoghBRCO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=DRHQvrr6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 079D980F29;
	Mon, 16 Nov 2026 21:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yM2Z6mmMKqGH; Mon, 16 Nov 2026 21:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50C0F80E8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794863858;
	b=WSevbVpy8sKnRaO7GCJbEFhDBCMB3XAhtTa/3oEENFuIwERcdHF0hry6Hw3z2AkKjkz8
	 YOwcEjFcGVo8y7LBizkbHOoyZvaOdW022TS8K5eOwdsY0S24vjRbylmVO/vZes1r89bqi
	 UARa3yXHdNtHapf3t89oPpjEmUM+fwzE+RK0E8O6P9L2gw4ZyEOI4frrITElg75OJ0q/B
	 XLLwlVJBhYUb9s6JV384Gi4ab04N15vvEr9FqZkITYzH39QIXKcpiXSXcKM9AWCelgbUV
	 oQ+uNIiILGS6C9k6Ku3VlEMUjitrXECrXNC9+q3EYlbB2INUAHJ//yTMZ1kRHpJ4K+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794863858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/cxTI+2NgZNWSxR8JkHgEde/eRf+GWD837CrjHpMh6s=;
	b=Vpt3tg5JE3CQ3ZdEpnuWwjogr3XiKjz4TdVeyY6bD+OUiEH0lTY86gn976zkpkb9LaNE
	 R655Eb9G+Qh/hABnDglO+zqZdbS8g2TZZP9WTMGd3AGuWKLy6aIv6OWQueiHj+kuf/P/5
	 bwTR0vt1/3KdHKgbcFHbptoMpQjE+kbN5StissnYzAbxrx0dY52kEO+Z+OIcLCZ6VVOlM
	 ubOoh4He50qCz+EqX+VyGjAvS5bFeFSNGHa9zrPlVPAf3Tpa1UBK/+PUO/9M3QL9dungG
	 IPtwiDhcNJWUoj0S8FGbfFGEQJZrMF2q20TKJnETQhzFIfU2hnZSwNRea9CEalYmIMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794863858;
	bh=/cxTI+2NgZNWSxR8JkHgEde/eRf+GWD837CrjHpMh6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uoghBRCOGjdzPKMwz6GJ+HbX1N8VyP6b2iyGh17D3hfZOUjTAZf74y3gTeDijYFB2
	 UvHK38T3QNDxiQf9taCIqnyBpYmobButkD0uChDz+7K6hxot5nHqEd6I9G7yJKQpPA
	 mz89/qIvLHaLrv8fkl2gPupBGYvqNs9qdM4yaVOC/aYm3br2T9UcnQM0gh6+ii4v8N
	 HSjr51m7DqNnWaMwVNp0r267ie48Ay9+4tx1ddq5ZC4fT8AJet71sRKC9LyAw5IRd1
	 wn5yIzhRiEXimD0cFjtsvT8znuiEgbIJzVHsa8+5/pfb8j0COuhclFKHgJYY1Gv2es
	 uKCAbxNnPdsKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50C0F80E8D;
	Mon, 16 Nov 2026 21:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1215E13C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC3A660811
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53Dym0qalPFi for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37D9C606A2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DRHQvrr6
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37D9C606A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:17:35 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-5722bc8ddc5so644617b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794863855; x=1795468655;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/cxTI+2NgZNWSxR8JkHgEde/eRf+GWD837CrjHpMh6s=;
 b=DRHQvrr6sV2jf/YyHT71fVi4V3AqvWQcPcyLFLW2QDof5pq4teByIOMxjhdj/oTHms
 cTFn2YDLpfIRBTua7OGiEDGRXxH3sRCtjKUU8azpMRdb4xVlVLr5VFKoqZcsCgiG2CDo
 HcUkVXqbehbGWdTsxWsb9c+sUtfDkFAKVMDM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863855; x=1795468655;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/cxTI+2NgZNWSxR8JkHgEde/eRf+GWD837CrjHpMh6s=;
 b=X+66BJoFQjAVlcKqhZJG03U9xjTc0l6saFFu+54VcBaTExgntykuRCe2Unu+o79oD8
 qh2EBtZjCP8GIQVAMf6ut5wDUYBaC+6Rmxwp9g2rQtMbSNT7ZligfUBuK2kYN2d6jxMF
 JmEFuiOIcH5AyTvlgmrDEYJ6XYVvlPhWhgEtcvcJB6zMMFGzcY4GWGl1mNBylmUzMfWC
 DzK519pvjuN18Tke8UvezAvJ+dvQBFjiN5naxeTXsiHoAVNKKZDpciHmNqtIZGqHMjGR
 3qwxqFw0j0LLSjdgkGoRmsiQvtbXRn+P9VQGvjT4xgWX9Gg2JFJC8gLIRoXuuzPpzdPY
 gMxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEHXDJfEXpq4a8OSzERbiZ/MPfV/b5SEPLv94d5512XMBbOpBvokqDfZWDnasBQxotLFA4ZxDc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8eAxedH7LPooMD9LAfLbd/PmvfMNhRfcmGH8XHUC3loahjcnz2
 QPK70XGHhYh3b/0ujw6urU1u4OKiYTiHRrYh2EBiOSWRlZSJlmGFXuqQ1h+Y3q2TBKKwuNpsXY3
 GuX/vVnBUBg==
X-Gm-Gg: AYBFou0CxpJHe85ao9RK7BjE4NOMDQaSoQvvj1zKc4Dm/DiCS+ctF+XTHXen9nINsOO
 4aUMPwhyFTr3ZTkOJZOPp02APVi9aNPFzkWN+Oq/VKqBX5Qsr8BIAJOpWpwsVRyIhX/44xJVLE/
 yq+gEwfNoi5MQDPRAnvahCS300Vniv0Aa9dYgh5DZB5rDbsr6qp5CmZiO9AxS1IC1bgFReUf/mk
 vHkl5kz7pCDtGsh03tEGqdei4lpnvSqJWtVKFbBYDZuxHFH/9Gy2cBJ5rwWiymgl/XkZE6UfCCa
 A0fEypmEUnCU5HYOGrYSvvErgIOilvLrTROa3zkHWEUC/E33GsyoJSaS/ps0Ur7Cv5MiLfNmvgz
 nWoq/oYVgOitjVuRAzO4Lt3jDkR3S6nB1sMmYNznjfnkbcHPhxG4szplVQGFRkNejvcUAaf6WUR
 CKzhPbp/mCV9fCaPJS3MEqkGJsw4Z5xsH+rVW/sJXjHgXpyVPZz+0nMT2essUWCCyqXIoNeCsO2
 jm0BTVLQvIl075sW0gN3CGOuXQl7JetaCeh9i7OAa5tOhI9H9ko+we6rCOCDP/83WMlsU7v93qZ
 OKX0liI259AtjACpWdw5QDUjbfNBobLM2z+HR7dIk8B1FJUvk39S4lnvH/Yz7PEvzwXocx56IaV
 9TOHL7iv+53QABEBj3b+1tN54+polpVj0ZdASrNkBz40WP1SIr8poTkftk0IWj1CaBym9LxhKM6
 NhJDhnundBLPDl9eSeIEE3ojB9JL75i9I=
X-Received: by 2002:a05:6808:13cc:b0:500:5e36:3a9d with SMTP id
 5614622812f47-56e63aa2b9emr10424527b6e.30.1794863854621; 
 Mon, 16 Nov 2026 13:17:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e6fc3eaf6sm10874278b6e.5.2026.11.16.13.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:17:33 -0800 (PST)
Date: Mon, 16 Nov 2026 15:17:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>, Dilip Mallavarapu <dilipchowdary21@gmail.com>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] fs/btrfs: fix path buffer overflow in subvolume listing
Message-ID: <20261116211731.GL554944@bill-the-cat>
References: <20261116205502.14884-1-dilipchowdary21@gmail.com>
 <767dd299-5aa0-4e4f-a84f-a55395214a30@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lNQd9+jcUQv5qoGD"
Content-Disposition: inline
In-Reply-To: <767dd299-5aa0-4e4f-a84f-a55395214a30@suse.com>
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


--lNQd9+jcUQv5qoGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 07:43:31AM +1030, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2026/11/17 07:25, Dilip Mallavarapu =E5=86=99=E9=81=93:
> > get_path_in_subvol() and list_one_subvol() accumulate a path across the
> > on-disk inode-ref / root-ref chain with strncat(path_ret, tmp, PATH_MAX=
).
> > strncat()'s bound limits the source copy, not the destination total, and
> > there is no depth/cycle limit, so a deep or cyclic ref chain overflows
> > the PATH_MAX path_ret buffer (CWE-787/120).
> >=20
> > Use strlcat()/strlcpy(), which bound the total length, and reject the
> > path if it would be truncated (which also terminates a cyclic chain).
> >=20
> > Reachable via the btrsubvol command on a crafted btrfs image.
> >=20
> > Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20
> Just a nitpick on the comment.
>=20
> > ---
> >   fs/btrfs/subvolume.c | 25 ++++++++++++++++++++-----
> >   1 file changed, 20 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
> > index 68ca7e48e48..bac9c1d1722 100644
> > --- a/fs/btrfs/subvolume.c
> > +++ b/fs/btrfs/subvolume.c
> > @@ -64,7 +64,16 @@ static int get_path_in_subvol(struct btrfs_root *roo=
t, u64 ino, char *path_ret)
> >   				   (unsigned long)(iref + 1), name_len);
> >   		path_ret[name_len] =3D '/';
> >   		path_ret[name_len + 1] =3D '\0';
> > -		strncat(path_ret, tmp, PATH_MAX);
> > +		/*
> > +		 * strncat()'s bound limits the source copy, not the
> > +		 * destination, so a deep/cyclic ref chain would overflow
> > +		 * path_ret (PATH_MAX). strlcat() bounds the total; reject
> > +		 * the path if it would be truncated.
> > +		 */
>=20
> This comment seems overkilled, and it only covers one call site.
>=20
> To be honest, I don't think there is any comment needed for usage of
> strlcat()/strlcpy().

Yes, and it's the kind of thing which AI tends to do, and then expects
human reviewers to remark on. Please note that the AI policy for U-Boot
is "please don't".

--=20
Tom

--lNQd9+jcUQv5qoGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavty6AAKCRAr4qD1Cr/k
CidYAQDnlqiEclqrgF01l9zJbjue2LgyNNCV3X82BLTgJ3GM5gD8CwODkELtFYCn
eTk1CPRsg8J+mvnzhgtPLz/pjU6DGQs=
=3bAx
-----END PGP SIGNATURE-----

--lNQd9+jcUQv5qoGD--
