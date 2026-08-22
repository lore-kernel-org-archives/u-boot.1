Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85648C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 19:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1B8E80C47;
	Sat, 22 Aug 2026 19:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-SfUosZlRE7; Sat, 22 Aug 2026 19:06:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787425619;
	bh=R0H2+YPbq6dfJ4JY6XpiHJsb/anDe4JkYO9snx9EYF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXHzStPaXKNg5ndfGZSFF5+Mbt3cT+LuMfAfmHqxk2+zDpinklrJYRunUNVjsUT9z
	 h+A6xP1Wcfrtqy13vzUIY3LFhjVeU1VK4HcgJZDQVwGuDfS21yj/5pebYFBKpFqeX4
	 UUNpgRtPMq4idtwuMIJxKufjBPdDUGlADDCLXEv/LUnhWQdJIfTnRKqN1BTOma9PsY
	 YkF+oA1Q7q/Soj+4MJayjgBn1EDZV3GuoaZXgsc1leAL5BX76mdzvQEFDGJl+Pgkto
	 OB+sjFAv8NpgK9KPk3QFQmHNdVdWvWHtCeTBcUrtYcWnCXs16zHiMvVQI7ddBIUCpO
	 1qEm+ZLAJjPLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 024D780C3B;
	Sat, 22 Aug 2026 19:06:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14C2E118
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF2B060624
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObZy76RDA8Us for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 19:06:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ir+UG6FJ
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16E13605F5
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 19:06:55 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c9fe62e0da3so713874a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787425614; x=1788030414;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R0H2+YPbq6dfJ4JY6XpiHJsb/anDe4JkYO9snx9EYF4=;
 b=ir+UG6FJp+mHRh5Te7lp+COOMDA/D/Tu+MxMPm6VphAyG9helnAvHR52DzgHcwAz3b
 +VYmMOd9Vz9WYA9bsMPpRm+qE0oYnaGvt3QBZbZzZVPi5q6xKXdBHOHoiQyyFoSgUsgQ
 L9v2sBJlTkjrgnAShTP+6NUREFbjyTsQaeYEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425614; x=1788030414;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R0H2+YPbq6dfJ4JY6XpiHJsb/anDe4JkYO9snx9EYF4=;
 b=GWYfxmZThe8pZ+3LEG7K/ljLLk1pRZFm05A6AWhDNCifA4BEr504bByxnjzc318JCN
 KE3Yd/j6nrGt9wEcfqRwhiXr1t1Tg9ksrTFPXqCeIrdSa7lg7S3XQw0dpx7X2YEi2cHc
 s/Nf+fVKJbVBX/aXebMRHpyXN9OvqxoZvTN0UpgwuW5xU/TWn5SwWit704PiJbQmao/7
 2TSznuoYUE4z4chO1FQbjXIAT/lvy5/xhrkl0opnMHHZOX7wZK7r0Hd1I8wwBWeNZ3LT
 ed5wyiOQd72NYsgn+ejYmHnZeF+Vid/n37uAFJypdXh4OWQBN4gujn8q4lzjsRQRysRZ
 lgMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rouu5OFHqlYl9VAcArb5ngxppivv5rnFTxP9Ia68Ai2YuQXSTqsmZJmxM6imDBYnz3in3ZZ6+4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mZcIfX0c+e8bLLLUUkBgalXBFpm4uxhXpaFkMNCon5HowXrYcb
 YZP8I1ZxCWoIXTvv5cpnroAhbwyIEdBem3YfU+eeSPENKWCXOFVheBnr2Forxz5je5s=
X-Gm-Gg: AR+sD113B3jR7AXH9i6rdioMiRTvH0uUChXnbT9mn5qzC7yeW+Rbkj4R1cdmFgrQYmy
 pi3yG+DLH1KKEM9Q9M9yO/VGoza0S7CO90ulOyRZulI2VrnX//OoVY3wOr20N/gK9BAvRdDsX/I
 YPwtz8vv6HzLBhjS6VwzCuIFK+XR4WSZEr/tcwdoGFZpDhlA2YocM+fwYCLI68brYxXZaR+0zOw
 BuV2rHWWgxWPxR6sRa9Pkvk64AZF59UNI6KcIRBWlYt5HOe5SXNDhiviMNQSbL25MsUYfOTGQml
 mywHFTt/jWiV/NZTJR5KqGjhM1JlYlV2D4SsQs8LOQq7vCDVBCeZdRnP4yy8qr8dNEAjEHWu/xd
 kDb4n0wkDWpH0NXueL21gLfS4Mzbuo8gxpoQVND5tWDUObzxP3LYP/6qNeaXRUARCFxdtzRgZPB
 69DthI0ZmSyaMvSVI2nz8taPl1N+J1Bn7el3n3MQmiNRvb2ZSiDqsRrnPAn/dO9vG8m+frCAFrC
 YqlXCRKdlyoP90rnpMXrE26prvKkYMjttd0+675VOg3iqoXk7thMPbVe+FcZfWfuZjcR4W4+k0T
 HR/pIXqkg4o=
X-Received: by 2002:a05:6a21:9214:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3cd4ba4839amr15625432637.5.1787425614542; 
 Sat, 22 Aug 2026 12:06:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d2d1esm9431151eec.17.2026.08.22.12.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:06:53 -0700 (PDT)
Date: Sat, 22 Aug 2026 13:06:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 10/19] LoongArch: Boot Image bits
Message-ID: <20260822190651.GX523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-11-me@ziyao.cc>
 <20260821162048.GN523975@bill-the-cat> <aonhzngo6A-kZ9pF@pie>
 <20260822190316.GW523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QevInT7P+OD7iKkc"
Content-Disposition: inline
In-Reply-To: <20260822190316.GW523975@bill-the-cat>
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


--QevInT7P+OD7iKkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 01:03:16PM -0600, Tom Rini wrote:
> On Sat, Aug 22, 2026 at 05:52:14PM +0000, Yao Zi wrote:
> > On Fri, Aug 21, 2026 at 10:20:48AM -0600, Tom Rini wrote:
> > > On Fri, Aug 21, 2026 at 08:42:10AM +0000, Yao Zi wrote:
> > >=20
> > > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > >=20
> > > > Implement loading and booting functions for LoongArch
> > > > standard kernel image as per spec.
> > > >=20
> > > > LoongArch kernel do expect us to fake a efi systemtable
> >=20
> > I occasionally noticed this typo ('a' -> 'an'), will fix it.
> >=20
> > > > for passing fdt to kernel, we don't need to implement any
> > > > EFI functions for kernel because it won't look into anything
> > > > beside devicetree from that table if we tell kernel we are
> > > > not efi compatible by setting a0 boot argument to zero.
> > > >=20
> > > > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > [snip]
> > > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > > index ac4be2c837c0..5654de5a58c7 100644
> > > > --- a/arch/loongarch/Kconfig
> > > > +++ b/arch/loongarch/Kconfig
> > > > @@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
> > > >  config OF_BOARD_FIXUP
> > > >  	default y if OF_SEPARATE
> > > > =20
> > > > +config LIB_BOOTM
> > > > +	select CRC32
> > >=20
> > > If this is needed, it's a generic problem (and to be fixed outside th=
is
> > > series) where LIB_BOOTM (and possibly LIB_BOOTI/Z since you know what=
 to
> > > look for) need to select CRC32 and SPL_LIB_BOOTM SPL_CRC32. Thanks.
> >=20
> > I think the dependency is specific to LoongArch, since CRC32 is
> > necessary only because we need to fake an EFI system table, which is
> > CRC32-checksum'ed, to pass FDT to the kernel on LoongArch. AFAIK other
> > architectures don't require such treatment, so I keep this
> > LoongArch-only.
>=20
> Ah, I think where you select LIB_BOOTM you should also select CRC32
> then.

Or, finishing the thought, "select CRC32 if LOONGARCH" in the main
entry for LIB_BOOTM.

--=20
Tom

--QevInT7P+OD7iKkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaonzSgAKCRAr4qD1Cr/k
Ch1AAQDzezeTRff+wuUaW7PmodVNTtcr+IG/LLs9Lxv4ZCRM5AEA76KmpQhbOrK9
HD871TxNyd6WIXjLjQ4Ixi0D7NKN1Qg=
=dPvL
-----END PGP SIGNATURE-----

--QevInT7P+OD7iKkc--
