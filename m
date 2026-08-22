Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D0C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 19:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5636B60666;
	Sat, 22 Aug 2026 19:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kx7bda9ByBI7; Sat, 22 Aug 2026 19:03:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787425404;
	bh=jA22fRzYcGeeh6mJwjBKnl35TfE5EMlewn0Xkh9Zils=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ET28ouPbSEOyBhFzAMsflRB8GDlaUgDIijMb33mxLKC0L+VH+azzvHQMiuB3nwd/9
	 6KMXBCYITqi+PjQCc8NEKmlOKG8d8hJN1rRagOVP4o0Kj2Jn1H2IklV5Jutm65vioD
	 DVmdjDgtJcwvv+BCUbgR/djJxrWDqYjQt/65D1Kxs2Dhpj//7sSej7IN4b9aEVBqP8
	 /HwPSY3EDZ6XL2jOUJfzpCzGBmENQ7MTzWkfUpYVwUPYggl2MeYP6KjpjUP2jpTqNP
	 ENFaKeKODDFXIt8DRf+YTzW8VeovfnNyBrPOjb1RzIFTG3Q3fdk9Lm3MyGVHFoBo5C
	 2m4J66sXVm0VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97EC3605E9;
	Sat, 22 Aug 2026 19:03:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E16BC118
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7F16400A7
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hx0AgYkIejWK for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 19:03:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::;
 helo=mail-oi2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Cb1QwyL5
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5152A40056
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:03:20 +0000 (UTC)
Received: by mail-oi2-x00.google.com with SMTP id
 46e09a7af769-7eb36c2f2b9so871093a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787425399; x=1788030199;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jA22fRzYcGeeh6mJwjBKnl35TfE5EMlewn0Xkh9Zils=;
 b=Cb1QwyL5HCy/typh5blAMN8m/eWJqIvMI2prXhvhmkYky7hGef3KIpjUYoHCp1fyUO
 IbFCkBH4GeQvIH/J+twIUugzhMu0xFBxAiSnKEqogvDExjLkTwOJHpOTVcgJ7VDg0Q/e
 qM3JCzSSlc8Tj1Ayt/A4hFmPa/Ahgygg4Meos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425399; x=1788030199;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jA22fRzYcGeeh6mJwjBKnl35TfE5EMlewn0Xkh9Zils=;
 b=oIG2jB4bcmiMmBffu5dr5eUztkFjPCwGVuZ05CuRNh6uvD9CGnQavVtt+d/CRDW0lE
 7XphSCdFuJ3ZmBwr1iSkaMn0DIQsklBR3AVJS+IUPJ1mwi/3wLZujfwPwWXvSAtKq0HL
 PaftY37BbJW69/9ERlA60dcbGb2ryCdHhDguHwZBxvnYxHUIrHyOhqiy60KFeaeS2lWM
 84CwDSb1skimVRwV6ZLN2QPOPVcXpSrzWLA242BSdlHc3SWSpkSeUMWyJb8xpPb5gsPf
 XUs+gUxl2aeUi2zKoOyLmsYNGeiTV7Uk1yTmxH4UPF9RTByoDklOD7BpOsPuf3NoQs9Z
 SqQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV824/xo8W+4PmzdFtzyy+imH7buec1OoVicQ92swjb22IPLkRa1Wu/tZ7xDs/z6zVeMCj3dU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lx7o+UU+9q6rfSk97Ihg0PpR39ibdz/Pn0ehtqGKa1nS+NAsud
 2jRYzQLjOUBXnKBVOOXIVjJN64KlD0kIBGZ5CtT4GPPmm95zTmH5vjHu9G7cOtHZHhM=
X-Gm-Gg: AR+sD10WV4sGyT20peg840wbeKvjMow7HTWhQlcMD9OHEXiby18X5JBUxXbjDnxJ1zb
 JrpsBgIdKaBCoTeTGgPigiOFKQog0uHx74SWjEOmVRtQeUqxG9gzPH5/M7nF9rdDnPlU6eBcfae
 A4PcqfgGkzBzht8ZwSaHz21vvdlpvEMabc9rA052FyKEh/IZTZ7RfbqyLNCvWXnSWGxzHrZiHHy
 nmVah1uY8RV0eCiPhGmrnKSZPpR2lesVDt5aEkymsUbVzpXpqaeqG6TURJStY5aLscsSytMYy2Z
 B52RB4yh2l0HuYjnKUltfhsJ26x3XYs61NN/ZffcL7f3gxwaf9sBdyu9Ig3hz8SJosa1Jxkhbjy
 Uk8/FFpO+ndJrK+ONSnmqz2cQ/xrU6rtsvPKpfsMbtsclF2NNv5+V+QCv5V6+qUpL475LVLISZz
 zxKtqnhjl8cj96Xz931+PLzvz9jYgDYThsTWj6j1GsNMPMbtLX5FRHJ8zff+4l9u3OKQTjQ3LSj
 V++kW2QEMoZEnPgbxR1oBbd5Xh9TLJiYsKB980ptD6mL32Z4GAmt3OtWjSoB4tF3MlkAnjjgnQL
 i7OvB5IpkA==
X-Received: by 2002:a05:6830:4116:b0:7f3:a8ac:45fe with SMTP id
 46e09a7af769-7f461510b2fmr17452337a34.11.1787425399271; 
 Sat, 22 Aug 2026 12:03:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f43fea4893sm11003097a34.9.2026.08.22.12.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:03:18 -0700 (PDT)
Date: Sat, 22 Aug 2026 13:03:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 10/19] LoongArch: Boot Image bits
Message-ID: <20260822190316.GW523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-11-me@ziyao.cc>
 <20260821162048.GN523975@bill-the-cat> <aonhzngo6A-kZ9pF@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K+Z1j4eBnJRobxdv"
Content-Disposition: inline
In-Reply-To: <aonhzngo6A-kZ9pF@pie>
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


--K+Z1j4eBnJRobxdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 05:52:14PM +0000, Yao Zi wrote:
> On Fri, Aug 21, 2026 at 10:20:48AM -0600, Tom Rini wrote:
> > On Fri, Aug 21, 2026 at 08:42:10AM +0000, Yao Zi wrote:
> >=20
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > Implement loading and booting functions for LoongArch
> > > standard kernel image as per spec.
> > >=20
> > > LoongArch kernel do expect us to fake a efi systemtable
>=20
> I occasionally noticed this typo ('a' -> 'an'), will fix it.
>=20
> > > for passing fdt to kernel, we don't need to implement any
> > > EFI functions for kernel because it won't look into anything
> > > beside devicetree from that table if we tell kernel we are
> > > not efi compatible by setting a0 boot argument to zero.
> > >=20
> > > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > [snip]
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index ac4be2c837c0..5654de5a58c7 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
> > >  config OF_BOARD_FIXUP
> > >  	default y if OF_SEPARATE
> > > =20
> > > +config LIB_BOOTM
> > > +	select CRC32
> >=20
> > If this is needed, it's a generic problem (and to be fixed outside this
> > series) where LIB_BOOTM (and possibly LIB_BOOTI/Z since you know what to
> > look for) need to select CRC32 and SPL_LIB_BOOTM SPL_CRC32. Thanks.
>=20
> I think the dependency is specific to LoongArch, since CRC32 is
> necessary only because we need to fake an EFI system table, which is
> CRC32-checksum'ed, to pass FDT to the kernel on LoongArch. AFAIK other
> architectures don't require such treatment, so I keep this
> LoongArch-only.

Ah, I think where you select LIB_BOOTM you should also select CRC32
then.

--=20
Tom

--K+Z1j4eBnJRobxdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaonycAAKCRAr4qD1Cr/k
CuuSAPsH5p+FMzXMk5JnuXKEmvE7lrygHXyxh05zsSXLLGd1lAEA63WYnLS5Q9Y3
1kIJHZQjHEMRobLLkYIRQShSMmNOwwE=
=jMHU
-----END PGP SIGNATURE-----

--K+Z1j4eBnJRobxdv--
