Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AFCC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 02:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B31D605EE;
	Tue, 15 Sep 2026 02:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8Dyjhg35KOt; Tue, 15 Sep 2026 02:14:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C2AE60681
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789438491;
	b=aV8hmUFG1xS6iXbawYbTZCjAWN/AVpZhMOiPTLA7bskYuSwAYYtABfIQgKtOPFgpQayr
	 myf5SP7ZNVipE5roBjJ1gElIdzLd+1CVEDt5Lx4sSLeKsGirFpwtHi+4Nqzi+odfkL/2Z
	 M/BDHKn30CYlYiqeqG8TwwrXmR39hJtlspnxudLCSBXqtIm5q3uJKGbqVuZEhCh0jsLGU
	 1RJIZ5BIl4jizErFF6ugNi4ebEZDhsNKErpwZFxL9ayZXUoDX5jDDLuNBE8lWINIy0/vs
	 WIIeLOnNZU5YBD6+l+7FO89nR1hYmiDA+vCdm/e9XWEkU+q5wUxqJW0gxKXkIRcfmZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789438491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jYRpVbxs2FFJDOsmNIL7Wav74xFx/GrW3wHjhPY5WcA=;
	b=H15E9In6FigUHF6dUpo4/acYMGEYN8b8A5KrYcr6PZ2LYLCeu66zEq44XLNxcGXW+rid
	 syt5k5J+bsA6A2txIzLrrrZV5CBZkPd+RQC8+WpL2sNfYoi1709FN99ckEAjrMNMscCQs
	 FtDxT/aFaEgDyA6FqjY0I7LLcrrcb4geObXbzbdpCN5gX+4wkaqc+D/FRcdLpik7slumL
	 NhzyoyN9JwmAk5Q7NttQ7TukEbH9gtCwt64Ur4ov3JQcLh3gxJmlB3cu89calIdDSb0S3
	 /wSvWn2bI2l/xThvdT9E15yJ4NfbMrDU5TgQ0iGThTN6qqTMqVqiP1IZfMCkHOAHHjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789438491;
	bh=jYRpVbxs2FFJDOsmNIL7Wav74xFx/GrW3wHjhPY5WcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFgQmbuSRAyno2K7Dr2iYuube6T1yvqLqC/k5y899kp7aHzf0dsqk7yOtGVvEmmnu
	 ITIM/9aEHn93R923gFUQxnQPo4KuFe4skWbuG7MwyMoBq8FcRtHOCLivBYg/L6APeJ
	 AJBb5SYSqdzTWq6O0DXAGIof99boL134sJOXb6CkQd4UAO+xEHu9SVV9pzwY4gTwtm
	 YZLunf+GN+YTjE+gIyRdoFHXDqsLNUOyiVthVqbIU33UVC8YaD1O+klPmtSF2iieig
	 divaplwBcE3KoWhxwTbwL/eA/YneuEq8pV2uvdkQsXjJR60planxxJoNR02eO0igA8
	 Afzbh72dQDIlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C2AE60681;
	Tue, 15 Sep 2026 02:14:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE34D2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 02:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B6280C33
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 02:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id as-t-Dsg3B0Q for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 02:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED76180C16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789438489;
 b=StJbnvLvG2SOnagzn+cos8ARe1qjqGYICpkfvASXczOtgBbgZs99cxzfxMAISB4y9nY1
 lLWlc3U+/2b06/GtHpxcgSY/ffFh/oWLdJcaK5GCaTn+BxeDCLRFm4+cepHdMzhywFxbV
 rQif52QC3EWHjSOYbqszLxM3ALoDhMeWaFArNWiwedTewvs0FsOsw1ZoUEkx4cNGNN3i+
 F4mhvejzubqDD6kCv+TTu7exNUZslj+6eOmx1bluUl0OWflTmgd99yNSwFQZMdcNB89ft
 av/k4LpiuDTDkPXKsf/HXUJPW91cOeLvj9Cv+taehrEZhfLhHXQglANnLiJyXJtQbVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789438489;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=jYRpVbxs2FFJDOsmNIL7Wav74xFx/GrW3wHjhPY5WcA=;
 b=lV+hjV9fbri9aQaJDQookqFJP65/+9TMGHm/sA2jP/G46NAgkQt823aqCUjJ81rp9SBf
 skC1qt22dhP3lFdHUZkM5rlV+Qt9uF1MheVtHi1IUT26VsYXN+BGy1TPuGw61iNLGZwiZ
 blxyo8FLAR+V11fpiKk3ETEbKLGKjW37hk2QCSA6xaxDM5LHdlQQ8i07UZFkX7NAOYFkx
 Q8NbBnSX/jJCWhMQDvhjS3n2blF+TpxuTnqdiymY7VDfQ2RBJ1aLkAZsfZ02p+ZV24wf2
 wuHG6q6vFlxHItiL+ZFqJS2afIAjD/elq63UDtf8NBSnbqt4lx7rxAqL4bH9cqBiWnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iFsBR0jX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iFsBR0jX
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED76180C16
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 02:14:48 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8055dcba0a5so604034a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789438487; x=1790043287;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jYRpVbxs2FFJDOsmNIL7Wav74xFx/GrW3wHjhPY5WcA=;
 b=iFsBR0jX0djgAw7xuKt4UmmE54dIn7mAFoHIlPSMwG0bRAzXz9hX2Fqia5xn2h2ZDM
 yzG8aAD9bX1HE/ijdeayZs3UBqXMGClezeuNKlV6vkcfI0l2Mm9HUIiERiVXqMpewhDl
 4PUpEOQrJMO6r7o8T9mr5t2Z0x0+HClQyVOpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789438487; x=1790043287;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jYRpVbxs2FFJDOsmNIL7Wav74xFx/GrW3wHjhPY5WcA=;
 b=ZiTDhn0eKyhlIOl9IaFdMiiYQNP/XE00uVtu5XaDvzoMslgm4gzJb3660f9X/ohl15
 x0IWhM8XNPtjds/3ms8SU/7336uIcathuRHdsOn5m+R3qL2a0okk2deDX3PdoeNXxETG
 o6BGJozjIE+DNo0aG0Y9hfk1/sVGPP6ASbqZdBoZsAg17kPdSJ82Kq7IOpA7ZwlLdmdR
 uCaxZuV8Ar93NmlrWPe3cwHpOa3uGDJyAatvVzKokhFLeA5Y5HW51ehxp30ImvVwhFsO
 VKUxC8en7ygCLa1FcN+0KswiiErvfx/e16Ped4ApuLmOVeuZ7oxdYQhuwL7w1C0ZzVtP
 NuvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSCISWl9MLv6w0hOCo+71NXAskBNj0+1Q5upSkD77P+w13yltL4+3pFlru86Nj+ZP3J7BkdI4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lh6xv8KttEUp7PUC2TBqY0c6U51uDD0Vuh53gTe8h7jXLBD7qL
 pTKa36JfKzUhQF6pUeEMnWqioeWUQJcGNulLW2IC+COOCpRLxgQQCuT7oSlWat4/xDA=
X-Gm-Gg: AYBFou1RvmNKui/vr2ScLSDykR+Lvo4H91e0sUcwVcrspTINJf5kBGbeZo1QXqafDQ2
 mHaaYTc+6Qjw1m+hpFm8c93N63dPm0TgyFy/GMU735oM5ZUrUC9vBZZAppqxkafyGbooJ1+Lmiw
 D7XMfhR/xJ0aWNjqf4k7TP4YJQYHI4LrD94EHm7M5CJd2d4KT8b6Y3cNFEUzRZ37hiXmu4qRc19
 YqconhhA1TWA2tqqD68Cptv4/E1N9lqTYQ63j+CcSWATayl3RdIpipFh0sU6r9LHEBbOKL/PR07
 jKOJCukp1/1YgRhGN9P6S2o7fcZqcgbv3kNToOX0QFclTP2/kyBkMh5XFy49+75GWzAE5L2oDQo
 obB/giXMM/iKSPNXdOZ3AhTm3QRfgIFm50TLRXfMT6zbqx5q0boYTsPuIswDxbrXfo+TiPuy95M
 VjFXzRWIUO64hKqTsuUuYXDj4ZpJDSENaSsWw0QCR2qQ7F2wCE96ULuXAiNFK/APVGouJLLUHH2
 9UNGFfHEkWcQVqRufTnRzDqOr7YOli9ibvLOWFK589XSvIrc4+srV8UExqmn+C4gyYrtwJSxT7W
 rnMNBgHXkx/NZuDzbEGu
X-Received: by 2002:a05:6830:3808:b0:7e9:e19c:75f3 with SMTP id
 46e09a7af769-809817a6be1mr1234131a34.2.1789438487223; 
 Mon, 14 Sep 2026 19:14:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80a15f8cf4csm56420a34.12.2026.09.14.19.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 19:14:46 -0700 (PDT)
Date: Mon, 14 Sep 2026 20:14:44 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks
 Devkit support
Message-ID: <20260915021444.GK1764417@bill-the-cat>
References: <CAHCN7xJKwZXdJW_UnVB8rTaAzBfAT+wyua=52Q-iDzz689dZ-A@mail.gmail.com>
 <20260915015125.2737587-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VplCg1sGJ3NigRvI"
Content-Disposition: inline
In-Reply-To: <20260915015125.2737587-1-peng.fan@oss.nxp.com>
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


--VplCg1sGJ3NigRvI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 09:51:16AM +0800, Peng Fan (OSS) wrote:
> On Sun, 13 Sep 2026 11:24:31 -0500 Adam Ford <aford173@gmail.com> wrote:
>=20
> > On Sun, Sep 13, 2026 at 11:15=E2=80=AFAM Fabio Estevam <festevam@gmail.=
com> wrote:
> >=20
> > > Hi Adam,
> > >
> > > On Sun, Sep 13, 2026 at 12:53=E2=80=AFPM Adam Ford <aford173@gmail.co=
m> wrote:
> > > >
> > > > Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along
> > > > with its defconfigs, config header, U-Boot device tree overlay,
> > > > documentation and Kconfig target.
> > >
> > > Please explain the rationale for removing these boards.
> > >
> >=20
> > I haven't worked at Beacon aka LogicPD in almost a year.  I have asked =
that
> > someone take over maintenance, but nobody has stepped forward.  I didn't
> > want to put that into the official commit message, because I didn't wan=
t to
> > sound harsh or snarky.
>=20
> I think mark the board as orphaned should be fine.

It sounds like no one from the current company plans to pick them up,
however. I think these should land in -next, as that will give time for
someone with interest / need to come forward.

--=20
Tom

--VplCg1sGJ3NigRvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqiqCwAKCRAr4qD1Cr/k
CkiNAQCcmJ7ppZh3ksGvA6CNCVBPnJ+Z8OougdRJN3dEYFqUaAEA5//B3lZ5ruJw
qM3KtCVLbBXE2uk6FA8/Gx4AkNVGhgE=
=G6sR
-----END PGP SIGNATURE-----

--VplCg1sGJ3NigRvI--
