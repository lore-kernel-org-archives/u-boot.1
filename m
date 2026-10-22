Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497D606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vLDUv4A6;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=syxUoRBB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AB5F40719;
	Thu, 22 Oct 2026 16:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBgt70eXjFvQ; Thu, 22 Oct 2026 16:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F650406D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687080;
	b=dO348eNdJFGaQSHmD5OmZIh4qzVdc5KT9E43HZjQKmJOwDk4lPGAi+2AQSamPO470vHk
	 Jxk8EDpUE/OaJKqIjmS7zU/jPR9WsXa0wa8rOZPiCDoLU3K+MJ1D4VY2nprzGVMhjlaW8
	 5e4y2dTu4i5uiLBYezzlvnzx10Nk6LKZx7u26eF0+HD4+BSL58FDeLdctuI4vj3a1uWiF
	 CAtjVHN4V7NukT68g0jQa+SzJXEprJAlRRYgLy9e199ZEW4VLCXD5EVZRhks6n5N44c+R
	 jPkJLwKpD0EBx/+pl/FsuIcG3DfxtqifCtFRFyItEnD4lWIYJG571uMR41fuELgBr7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792687080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LqJ8ZgJqywGElP13Im8OgLkmzCvP/cxp4I+jti51KEI=;
	b=GE47qXphL+iv+LQMpk6rMhXwwXZsbxyMVP2aisy47GZB3C6ep88XDGwkTo7qHaO0/yKv
	 0F9C2LyG/5thlB9WUgHRxXOHaemVcHD+z1ihbKx4VaKdFPwMhvR0BEb0KPxMaMMqHmJQa
	 eDDG05hWVxI6b0xXYlGAgEpmPRzODGdcNMXdqx0MDhLHRSbI+Cy+pdxn4/j8Uc7mz9+uZ
	 +/IrJrdwqIDv+gvRmkjCogUEHBDdThUi2qHeE6p3fDBJ+PO2l3ZRa494Z4gYSW0+yOQne
	 fU1f1yWnBzweEe/YvuGTLQ77IiWojGexKJmDIvC/hAq0ofSyCCI3B6/dDz6W8lLjjag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=syxUoRBB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792687080;
	bh=LqJ8ZgJqywGElP13Im8OgLkmzCvP/cxp4I+jti51KEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLDUv4A6i16FefuTNvKhqNQhpHu8lcfKXRVYybQ/YiCgA4CkVaoWyoWUBqJb30/+R
	 FhsZOIAJqrX/dzWwQQMSc0tEbvvTl4bB3w0OyUk8+alq8zOWXE9wdJTnUSA9TkiK9m
	 GH5b6LQmgCQWwWK2AzZV+v15fcSZqx0iXWvZgCM+Kj73jyMsSDhDSncZ9qKbHXRdlV
	 doB8jQYf806Ffj8CDkAVJtMtfBqxr7ttEVm7G2LmXAr60iaiJqmycYYjqvC4iEKrYK
	 +CoSDe1TPV5BaG0zF2Cv5NX2ATqpCGWicysiXWmuYNNC/NVhzZUuVNk4j0+mpkr/CN
	 6CrJfi8YGo1kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F650406D8;
	Thu, 22 Oct 2026 16:38:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53801769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45921406D8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6M90MkGVvzet for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E27C406D2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792687078;
 b=lFbth+lNqJWXNcC0TsIWOYG4UyJ+UTcEKzKMTIAvrIdcATaNXf3mUq+UtNkh6lJjP57e
 9JYoXWtm/ZknL0HdYnsEzfbn5dqu0RGHb6QypUD3iMhxb+ovFEON+NuQI7mp08SYq9llD
 TfMNwHU0D6Zu+271nTKnEVPRPBL2e+K7cpFOv8rL74uwhUt6z1N5CYkYU4p1L5DJGhoPT
 KkWX5lvpZ5bfCQ6499VKF8y0z0HAr8h0TfhixH4I+9obTVjPqOEqkLk2jRmc/F2/6I+PZ
 LG8rqefK2A2iBEWhIflelgh1VjVG95hCaDCNisNwDs20qDDMS/0okcLWAy4OFQwSIig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792687078;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=LqJ8ZgJqywGElP13Im8OgLkmzCvP/cxp4I+jti51KEI=;
 b=TGFgeNahvsu/buDVBZrqJJdMDbs3KKJ+QS+H/EK0RWAka/NpbyT9QkXYx6BEkEVcM4pC
 xwDv6IY++2uo7gmZp04yp4ADkpPUooDq6v8mRJoZv6GM+dyN8IakzI584ibOw0onvJeml
 KlIchujipZR39ojMVmw9/SCpf9ezfjTrEfYv9k6EKP8ZMSyQwfoW5Nwo242bw2TGWRmIl
 Im4Ua9IeSZE8nwUsINOqnNFfr0M4wLuaFVicsdLqpDlx+9mI/8uQUWoGQbUDECEx0od3m
 GMjOslO4xPBqSypFhnOdSGr+WhTnMk8dq72yZBkU+4hPNZcPt8vjCe5AtkRKlStNarw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=syxUoRBB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=syxUoRBB
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E27C406D2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:37:58 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-845f3fa7f38so1248790a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792687077; x=1793291877;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LqJ8ZgJqywGElP13Im8OgLkmzCvP/cxp4I+jti51KEI=;
 b=syxUoRBBgMPFo2mEWcEIEfpOhaenBf+jl1lDARiU9mGO/S7ade5tCJGAhS2UrzD0ZI
 gPtY8rvncF+Ak/GrQmPmCppULilUYhv+TpHxXiP0leNdDzG3p4VoLzqBPUTtuIx75vA0
 PFB22KeEN6SFaRNSz38miD+HgPJXJEtTS7kM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687077; x=1793291877;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LqJ8ZgJqywGElP13Im8OgLkmzCvP/cxp4I+jti51KEI=;
 b=Noya1XkLNJfk7eWpNUrsYOHHa6Xo7c+01osverjeLFyA5BT0VFcVme5SVBW+nRg2++
 xNKT13ULRwUdqa4rTsQO0+hx801S1z7EeHIC4MTifFOxFvwk4OlCr0Heml0UmADjPvMb
 zFWiF8aDEyRKEukPFKBg2/u2xuqiqJKKf5fsaJCMDjxowaQgiP2bYpxqJ1/KXG3TZDuU
 dC4entSIXiDgjrVj5CihYDGe3yLbt0TTb2C8KKejHkMZuJx+BWmNPVe1WORHNreOOHQ7
 JtblkhTqlejxEtNsTvo1j2Z5EanedfPBy1chx3HECI2p8G0ma5E2aM+5zcpTvqToCu1w
 DsuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPvHp5pB+ExbJD2e/4s8pmQAJnzDIlaCfAt2tonJkEn8ZkZ3EavAqsvAoFVilJ8gGjhUJ/Ec8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJRLeNiLHQ2vDKlE2YBa+liVrC+SRgN5Hf3M0GB9295/CS38b4B
 xNIHrCH6JClMpy7uXoXhjd0CVnLVLtfs9sRolzlpVoTFC4r4FMa/iIQNiHrm6ygzXFQ=
X-Gm-Gg: AYBFou2ck6RtMofZK47j8l3M3AEs3d04PI+lXFjAZtracME18xYlQe/d8MRNzrZvqQ/
 W8jAZ6uuIHqZ0mFdWQ4eKTydkdN/atBdskCOhXffzACiIxLtpqb+Kwm33y6y7AC6BQz3cysP2+K
 A0X77DeHC7DVY2K166+z545FisRVzLW1Bz3F4gWsYf9nw+dnr1R2GWQHPcRU1no1kKM8fhnK6uI
 QFZvndY7C+/LirrgKb+z1SPkUKgoBY8++yl1U2wQ48YXojD+Yqq/QXHdMT9qsonTsdCmzRxd6hn
 20vhwZ/IaICVCtNNp4yuFU3ibsuq40/wGORq1fA5TLow8dm9AfjABtpCPMzoWLHwlcKrIbHbFwk
 /c2ybAQTUIHMT5QLAoK6mE+7vcVcJCmfB4IbXWDE6l9YXryBGuU1AsmS592fakWQpT562BuHGzn
 nGyeFhyBMIx7ZP39cZ1k/F9jtDnmMhWT8KYhq7/GfiHGmEJ6cGRizoCMoRLTtLwNafrIDKUtwYo
 BIxuK338P/BHFXhskD8sN/qdBfEXqdrQTpk5a1neqkhLXkHlWoCmIfvjnbtNhFOXR1X0/HLpWD1
 sDHJEe/JyrbfkeunU7UkGEcTuhF5hCgzFWRrDMZJ/QY5SgRmxGeTWIcydHWthp3x+pqyVK1mUAc
 m/qIwJS9TNuXuCSKb/IJTDw==
X-Received: by 2002:a05:6830:6f85:b0:81c:ebf4:9ff8 with SMTP id
 46e09a7af769-84d09218548mr4881832a34.30.1792687077227; 
 Thu, 22 Oct 2026 09:37:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84f784f3c50sm163092a34.21.2026.10.22.09.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:37:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:37:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, nathbappai@gmail.com, Michael.Srba@seznam.cz,
 quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v1 1/2] configs: qcom_defconfig: Enable
 CONFIG_SKIP_EARLY_DM
Message-ID: <20261022163754.GA3618621@bill-the-cat>
References: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
 <20261008103146.706211-2-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="259V/AmmVjwaj6Gz"
Content-Disposition: inline
In-Reply-To: <20261008103146.706211-2-aswin.murugan@oss.qualcomm.com>
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


--259V/AmmVjwaj6Gz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 04:01:45PM +0530, Aswin Murugan wrote:

> Enable CONFIG_SKIP_EARLY_DM to skip device model initialization during
> pre-relocation phase, improving boot time by around 50% by deferring
> device probing until after relocation.
>=20
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 7d4a2b589aa..4713ced0939 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=3Dy
>  CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_SKIP_EARLY_DM=3Dy
>  CONFIG_POSITION_INDEPENDENT=3Dy
>  CONFIG_SYS_INIT_SP_BSS_OFFSET=3D0x180000
>  CONFIG_ARCH_SNAPDRAGON=3Dy

Given the number of platforms which also build on top of this defconfig,
is this safe to do everywhere? And since this was something introduced
for Qualcomm platforms, you should be doing "default y if ..." in the
Kconfig, or imply SKIP_EARLY_DM in arch/arm/mach-snapdragon/Kconfig
instead.

--=20
Tom

--259V/AmmVjwaj6Gz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCato73gAKCRAr4qD1Cr/k
Cjv/APwIO1ZlR/pUsKVbOGATGFtTPBQcAHM1z31a9JbinMNImQEApe/v7NC5yTY8
6JvKONwpwPRbiLgYKlBtaxyaJuQOrwI=
=liDR
-----END PGP SIGNATURE-----

--259V/AmmVjwaj6Gz--
