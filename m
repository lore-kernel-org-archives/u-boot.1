Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D90606A931
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ehrOWh4c;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Fxl2Wjff
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82FB6406C4;
	Mon,  2 Nov 2026 17:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KG4T_n9_U2mA; Mon,  2 Nov 2026 17:39:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB316405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793641158;
	b=n/Hv0NhzmZMxmHIHELgBqFPgQrH+2POMqGWY9VFwBhbq9GqwdNFrWiBOcXZotdkB6a9E
	 zrGeF6waC54penuyG7uKATJmocu9TY4q0zLIwx6KoS7OLsm0zwmWBiK3oKXzyHLwOB5I4
	 WpVkbLkIOk57nX+5YGKpmOCUQyaN4D1jE3YFEgC3Igh32DNkn8dDGY6tYubZJNfNhaLOw
	 kXMKwi7kgsLo/seMpt5ZMZqvcMTlFj1taHw27SMQY6zG5hBA4YH+NzBc3uH9RAxnGl5O5
	 YLBoH/lX9YmNLPaUbre1tcfI0Whd6zLK3CW6zeLE6bsB2qnxCkbL+RShvTqaR2DPcOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793641158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Iwn1TrAm85LUOgrkzh8ZDEV0qfgOUqY7/tCIJ+77Mwk=;
	b=DMBerJ/+4I5zX69XYlM6ooVbQjCnxaQXLaAGKNxjFl+RNxhcPqzFu/ik9YTbRhpmJASR
	 X48PhJMaHcDB+fE8vmCUvTBRw4VG6XU2Tm+HKH+ujDc95s11174DblrPxm6SDuYAICJ7O
	 a0IQe6/3GlbNQMaMor9F82Y/JYM+e/QErrbM/+9tdUhvuuppK9bNDWChxGa+/bMrN6G0Q
	 /eQOcFA5U7ZWkMasMNvXJf+GZhA9JUfHk9P+LJrXMxMdFPhVJhIMgKwnE3GrOzPicHkfL
	 KdCehYse1jkUDIM96WF0Ss5/ADNIqJcTDfvFxPCg+sM9L8apBIUP/Uw0taLcSWhz11A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Fxl2Wjff;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793641158;
	bh=Iwn1TrAm85LUOgrkzh8ZDEV0qfgOUqY7/tCIJ+77Mwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehrOWh4c8oSklmMJuWEEUR3vp0HCMg0NCj0rxtoqamxa84WO3horww2Uvl3bH9D7Z
	 g7cvYDvl6cabjEg0MHcixqSRQXehTmFMSBwr5wSEB6ooOz7zrNrqNgm0P0vxyCtQoJ
	 af0uWhxAKlGcKdCd7gSBTCkfh1Dmn+HsJovVXTQxINKjb5cZdtvz7Gzb126Y+i4qo6
	 T7p5efNQzSSLKKHUc793HTXCftwb1Kbze01XV9ecvnMdi+0mdZUTJtLiXjCOu8DdSO
	 YWkRCWdUYxRtt8LcCZpfgwvwHvMDVXnO2Ne+tUFjZ+SPEHub8uctQS1fn4jTtwnI+S
	 i/7T6xw1K8RwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB316405B9;
	Mon,  2 Nov 2026 17:39:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE6374BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFD1C4060A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyzFHGnnAY_X for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9CC9405B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793641157;
 b=EPhXLUWOx8GgJpBcrWHI+UdeCQ1YbQlG9Py4qzql5WWV483KiFkmHyov/3KzqmMQBnBF
 h0QoZtcozp93v6FGXawTEwYlpzJyTfNBHAj3aWKKO5E0MzzC+gR6cJLh9U/3mDz14QBWu
 xLtYRvtELX/3R0kEo6BfqtqzWJJy7hKZjqKJG3e+nCwxx0X5IBvCmJIdWOZL9dejeSRbt
 dxsox4Q5Jzzq+ay73bOFOkBG1p4xvEQbJP1yzqUU647d5PJehOehzHUIQI6VG0nZvG4GS
 inEl96nt6C0ZYl8PrDMzOxH/wT74HUqUi4gH1Htfw6hYSRl55PJzsAWuZKJhkbE+0Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793641157;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Iwn1TrAm85LUOgrkzh8ZDEV0qfgOUqY7/tCIJ+77Mwk=;
 b=cwyYCc6hh2KHXx9VF81ntdAmjs3WuXs3FkxKKqcCIcZBXj603E8XN0UniECT/2Srkgf+
 M7dVk6KKFYvhCftxnSVGJUB0LUNRH6CQxcrf3GMFa2xRqVM9gy3CmpvHRzTNPSs/Lnl+z
 F2mmF5XgJQZwTtL3H/zsPfkMvITfPUxRd7D8YnLyzo4cC64ecz16/d6vGs5+F91wFqpsQ
 SKsjDLHlCsm0pcXR878ubHR84QFJRoMOzLSPyEjAOT2+/LOt3cuIVhm+FoOIGG82+8zkI
 S7fV0i9ryG8t7xf4RoFlUrJkvsh6P+fGi+twkYE8P6Ldhc7GcCSbMts64kv+iUTXLWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fxl2Wjff; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fxl2Wjff
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9CC9405B0
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:39:16 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539d2baa897so1251844b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793641155; x=1794245955;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iwn1TrAm85LUOgrkzh8ZDEV0qfgOUqY7/tCIJ+77Mwk=;
 b=Fxl2Wjff6MM/xLg5fxwKlAcoALwiDrTj7wzfQsktjXHP3mE2dMLjtNKKWviR0GT59m
 bDuOAFNi9A5Km82jqJ0bD0NOUVI4QQ82uzM3v3NNreDq+kce7ihxlBiTlQdiUtkDSCQq
 JjrT27iviYIaaIeXFX2C0DjyCV8GZQK0RmjI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793641155; x=1794245955;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iwn1TrAm85LUOgrkzh8ZDEV0qfgOUqY7/tCIJ+77Mwk=;
 b=B5BG9wZIWXTPBX8raDi2gWRup2WHgRPCNFcMWEVd4rXwxzbhscGXIxGXtCBhEy0w7A
 OZzAXDyy1t9cDo+RPAaHHfT64yKo9qa52XJvkjew3ZfMiS5zEhIinwsHKJB39Jk+Vkol
 gB+kyt/lla2dur0uQwYmGiclAQMHeb4lA9eFTSnsX0tW3xkHmMM5idxsizR4xJjqa1ko
 qpfJtAj2+Xj5zORLKZqjcfd4aBl12wpj2/j5zbwcTHzf677d/tk5F+hMvRJvl8YQXLZg
 v2e5YvFVUp4GzQYLYals0ubEU8ig7bhz7CL+X/ByVbV+jdD4kzjde1N5uR/6Tuz3rgoP
 mFuQ==
X-Gm-Message-State: AFq9FYJjz8i1gE8LjJQ5dma/cDwf5cly/t2AhsHgiH223pS5fpkLDgeF
 g3Itbv1cuzvB7UOtNVXDLPaBaYuFvu49z+K6WgCYePfO7vxDtc1KJuGjzb0EKM+wKok=
X-Gm-Gg: AYBFou0ImARzCjB2/nyGmciww+ZpV40Pm2LcTp9vx6V/BGiuzJwjecatogH5DqrCMJD
 udKpqCdW2KiPDgzpM6cbEI/F+ZY+y4Jo6TBK+YHtn12if9KloLRJaJ8//X3U2xWkYUl93oabVNT
 Ekxr7umV6509m8MqwzxYC+jKP3keEtI3y50tgK1Sh7hA5un7qS5mn0cvljKgw6nw5PQ1P5gf2yf
 0SmfifR9l3YBHMYcSTSYTa17QXC6GViWGOsiY34b7s7e79FHyTyfn1KLAwnKmhpzrBIB9t9l498
 wxUtKE4ORT9cUHB0ajydlAdlzaSyc0dZOxfX2fpRhIjqveChlh77eZ9nN9zizOmpc1dP59A07pi
 r39/0eVUVT5kBic8DKwARCNAwzOAurCdKIVJ5CqlfG3hgndBMIRPFnqM4gXnGWYFyovANmz4SyY
 rYsBihvPZL04y9KKMkx4uYgXa4n3vJTqbIvjjczyL4NKidnroLWzivxX1qCeuNz7UCsbcRZeo6X
 Z3oCSzAd1HIN1TCCnlf81/KmirCzzjOhCS8Tpwn3MOAz9UFo7ZZaWvQxk9rlKcdfe7PBJeW6Kmb
 MpbBP2gve4A0WOOMeoI3hW/J4xFmPgMrUfKxwNPGJR56c1VoX+rftX4xy8oPkkzfXYTJgjb/jnw
 dIL9BsAN63uI65LTDs+A6IbdeqxcEJUPlIv4xpY8Tod9/JwqSqAg5ufCGdW2q6ahXzX0LqpvTNi
 56djHDHRPb/Ge4ASNesAZ2xPNStRPc6A==
X-Received: by 2002:a05:6808:3098:b0:4f4:e649:b99d with SMTP id
 5614622812f47-5640de36bcfmr7151552b6e.52.1793641155061; 
 Mon, 02 Nov 2026 09:39:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9219e594fsm7249048fac.11.2026.11.02.09.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:39:14 -0800 (PST)
Date: Mon, 2 Nov 2026 11:39:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v10 0/7] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Message-ID: <20261102173911.GG3309461@bill-the-cat>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IGKPOuS14wtnK/TI"
Content-Disposition: inline
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--IGKPOuS14wtnK/TI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2026 at 03:48:38PM +0530, Balaji Selvanathan wrote:

> This series adds support for running U-Boot in snagboot mode on
> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>=20
> Snagboot (https://github.com/bootlin/snagboot) is a recovery and
> reflashing tool that works through the SoC boot ROM. On Qualcomm
> SoCs, snagrecover loads XBL over Sahara in EDL mode to initialise
> DDR and then loads U-Boot into DDR, where it enters fastboot so
> that snagflash can write the images. Support for the Lemans-EVK
> (IQ9075) is in the snagboot tree, see the Qualcomm IQ9075 sections of
> https://github.com/bootlin/snagboot/blob/main/docs/snagrecover.md
> See also the doc/board/qualcomm/snagboot.rst added in patch 7 for
> usage and build steps.
>=20
> XBL leaves the MMU enabled and does not set up PSCI firmware or
> Command DB in this flow, so the series adds a QCOM_SNAGBOOT_MODE
> option, an early MMU disable, and a defconfig and config fragment
> for Lemans-EVK.
>=20
> Tested on Lemans-EVK board.

This all seems fine and I'll leave the Qualcomm-specific reviews to
someone else now, thanks for reworking it.

--=20
Tom

--IGKPOuS14wtnK/TI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujKtwAKCRAr4qD1Cr/k
CnlWAQDv6Fafndq97jOwh66KrxKOjlfyFF3NRqV2RvQiG4wxPQD+PR/BEyKNJ4cI
5QtHWuysmseoJC1TfofoefdMZIdy1Q0=
=uNN/
-----END PGP SIGNATURE-----

--IGKPOuS14wtnK/TI--
