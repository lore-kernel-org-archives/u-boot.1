Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4C4CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 18:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01B5836AC;
	Tue, 12 May 2026 20:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dg6Eiwcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BF483C2B; Tue, 12 May 2026 20:38:49 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55858341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 20:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-4756e74f8edso4539132b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778611125; x=1779215925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q4Ti3EfvPRWu4p/qv+tHFBkfwTO1q7v1NXMJHKU8lI8=;
 b=Dg6Eiwcmmv+K6nZ01EXCsTOYLdAgg7D4Wp80ETm3rKlrk3Zz705fRryxV4S4/u2JoN
 xqoo1Vc6GKveuaECPrUFuKDYAm5ZMrFZxxS4smjGy/PMIxmTxpYbsCz42JSmEUr6igMk
 +PmfoAdl1s1U1S8U79sj5OCwElHsyPJTg5Sys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778611125; x=1779215925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4Ti3EfvPRWu4p/qv+tHFBkfwTO1q7v1NXMJHKU8lI8=;
 b=JGCtW9TzzskIdyNmqixz+uf3+VLH/gp5yc6pV+Tqd3rAQ+Adt9FdAyFNwp19O+X44S
 gXhegYTqNZW8o3oa4Ual6onrHtCMgyB39SYhQVGNiLBt8GtDE39t4i+AOgra7sTUcPo8
 UO2w9JD1sFDmiUEoPAGJt6jB67Bm4SYgCdyQX5XOHeNY2/jXiqUw+FcHp9aIl7Ma5idH
 B0Fs4mAr6kglkXhWgskTmPU9/7GVQmAEyLHQJ2kUfmplxPK6GyRkeoTFC89GFIQsn1Ul
 C4RzU79PPdcxSvljAQhseV+4xvo32yhkkAz617Kuzgq5g2wkmNId2IriFSJ4NXukafVM
 xsJw==
X-Gm-Message-State: AOJu0Yy7xfxw9YYThL3QDn+/GGofoTjUuJ/hEUNkUfGfrb/AYPh/lkzi
 91GtLNxbBjn3oTsLs+gF7hdvrgOvxn9n+wrgIJNgiAzaxC0pjeQjs5lG9EizNoUpbk1vEYx5Dda
 D7TTB+o1UU62bdUc=
X-Gm-Gg: Acq92OGwWUQoZARBK89w0vpfYyTcXFqbIuBs2kvFWCHI5evvJ+9l2V0qThWCIOYiNmx
 m5e78lHvwzJp/u0LoHvY7nkYsIFtO1ZJ559g3ma4wHVGrVEA5f6z3W4ZljN9byaBZbb/GNUD0gC
 UwJLWGRIWX7cMrAltAeghC7zT+rV2BNYq6lzE36UM1toB9ITqvv6uk6vNWnoZp+lrXLKuHsPwb2
 B5xXHoeCl4ei7+MyDhKDJIBjg84yAm5M47yKJ9mQjggUTDG+mmBOhhJy6F5kjZhXIv1oWo6tCT8
 JB7S1aUrxZyqULXEf7wbEGpRkrQhJr4w1Oe29ImFSNskZhY1Wi/35YKK8Stc+sfiaNksXP6Uh1h
 ib21UaorKRzGnACxqi4FKt+oznsJ98abpQfa3FYUlukIaUsxlZGniV9GmM8e2PAjiv6D3qUrctq
 eyeOEqWhhbSjWRbxPuPDO0JLdLSWNZHYDlLTMDmSIDpFJbMarsL8JWWRkyGj04NPJ0AUVpOz47Q
 tOz3MiajP++eOhKlqogmi1V6bLxtk3EUucjPfhgbKj9R3uQPdg=
X-Received: by 2002:a05:6808:148d:b0:46a:5558:59a6 with SMTP id
 5614622812f47-482b282e948mr190199b6e.6.1778611125399; 
 Tue, 12 May 2026 11:38:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435aec16e0dsm7785054fac.10.2026.05.12.11.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:38:44 -0700 (PDT)
Date: Tue, 12 May 2026 12:38:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260512183842.GR1858239@bill-the-cat>
References: <20260428140433.GQ41863@bill-the-cat>
 <f3298612-fea3-4669-9264-03af727b436a@kernkonzept.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iRpr4MrZSmYaGXQg"
Content-Disposition: inline
In-Reply-To: <f3298612-fea3-4669-9264-03af727b436a@kernkonzept.com>
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


--iRpr4MrZSmYaGXQg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:44:46AM +0200, Christian P=F6tzsch wrote:
> Hi Tom,
>=20
> On 4/28/26 4:04 PM, Tom Rini wrote:
> > Here's the latest report.
[snip]
> > ** CID 645834:       Control flow issues  (NO_EFFECT)
> > /drivers/virtio/virtio_blk.c: 184           in virtio_blk_do_req()
> >=20
> >=20
> > _______________________________________________________________________=
______________________
> > *** CID 645834:         Control flow issues  (NO_EFFECT)
> > /drivers/virtio/virtio_blk.c: 184             in virtio_blk_do_req()
> > 178     	*/
> > 179     	while (i < blkcnt) {
> > 180     		u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->seg_ma=
x);
> > 181
> > 182     		ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
> > 183     					       buffer + i * 512, type);
> > > > >      CID 645834:         Control flow issues  (NO_EFFECT)
> > > > >      This less-than-zero comparison of an unsigned value is never=
 true. "ret < 0UL".
> > 184     		if (ret < 0)
> > 185     			return ret;
> > 186     		i +=3D blk_per_sg;
> > 187     	}
> > 188
> > 189     	return blkcnt >> priv->blksz_shift;
> >=20
> > ** CID 645833:       Control flow issues  (DEADCODE)
> > /drivers/virtio/virtio_blk.c: 185           in virtio_blk_do_req()
> >=20
> >=20
> > _______________________________________________________________________=
______________________
> > *** CID 645833:         Control flow issues  (DEADCODE)
> > /drivers/virtio/virtio_blk.c: 185             in virtio_blk_do_req()
> > 179     	while (i < blkcnt) {
> > 180     		u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->seg_ma=
x);
> > 181
> > 182     		ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
> > 183     					       buffer + i * 512, type);
> > 184     		if (ret < 0)
> > > > >      CID 645833:         Control flow issues  (DEADCODE)
> > > > >      Execution cannot reach this statement: "return ret;".
> > 185     			return ret;
> > 186     		i +=3D blk_per_sg;
> > 187     	}
> > 188
> > 189     	return blkcnt >> priv->blksz_shift;
> > 190     }
> The last two errors should hopefully be fixed by https://patchwork.ozlabs=
=2Eorg/project/uboot/patch/20260512083949.3493010-1-christian.poetzsch@kern=
konzept.com/

Thanks!

--=20
Tom

--iRpr4MrZSmYaGXQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagNzsgAKCRAr4qD1Cr/k
Ch8VAQDbnuD2TziUQ3ynBhaxwfsn/Gdj88zEfsX7IeKfFXZCiQEAudgZlvDEC1FN
vynUWeXnB6E4UFhm2NlCIMceHaCHuwQ=
=KcmF
-----END PGP SIGNATURE-----

--iRpr4MrZSmYaGXQg--
