Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF689CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7473460641;
	Sat,  3 Oct 2026 15:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gmvuhqD_8Mw; Sat,  3 Oct 2026 15:24:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AEE3460631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791041040;
	b=fkxRC4Iv5JxygWUjvoScpKtijz09TJmwu7hNBkH2gULMogMePVhrywgoRv+lqE45EqiS
	 /E3IKnjxfuIq2j9Qu8B+KNtw7vftPtaunhS15L2cJnBGBlgg10swene4i4ZeKn/EhL6SC
	 UWB1ddM1SgGry14/4yB3EcSGU77H7F8pWovWIMYH0XWa0TIhEyZJUgyom6S9UB27kA2PN
	 Al8GyPgG2rF0ie7a+zmXKbXz7j/uVVL/YAYjTwCp3o4mWEBhJ8/5D7LgWlMLfTK82ZxXG
	 BW6l0xDy5Bt4ELP0uyC1rWqepm25g6zmZH7VQzGmCE7rdTrvDIlW0EOJcdLrzCgprEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791041040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YyOvkGRsBiLIi98kL9CT4kKRPxlU75mbavWz2GAAMvw=;
	b=QPuNNwwlcj0OspImM9M9IW6blOw3QsxHfVl1w+v6xFinPG4UUF1Y+hnVR4cMtqafsrHv
	 86hgmVRYMHMaPMFmRNSUAwsqXZ6mSK/i1VM9AAAIcUZIF7Bl748mnTKnpT/NQ8E7f6zi/
	 9o2yNefqFhko09AaJWZfVZRCWGDKgvHOoHuWc+RYu4Rl6GxmWKQKtRPjQcfNmsN6POKvX
	 /WxRswwb8KSBfGgiLfVKD5nbW/fGyIBybsFgjumDC0AedOWEJun+TDBCQh+xorDUEZZFS
	 mqr522a9SouByhGDdu6BYMQPu4/A6kf0aIntADFz9PjV6kEn6IZWuXIUeHH3LrDgRrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VVWuRyLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791041040;
	bh=YyOvkGRsBiLIi98kL9CT4kKRPxlU75mbavWz2GAAMvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXkfj3yBeZidjM39fbQJGN9qZasLHJvf0TTMlSFv/eyzJmby5AQxSEABphKRbdIfO
	 /fd16uQb2Z9drca13EOP4Rqp/qNaMuq/+m3Ig0HD4k3/eAqBXUY0WdsvldiECxv3LB
	 +7WvVKkcfWRxa7Q1WjTIIiKj20bCWGDyIszhSjCuzqegteNL2WooWFDgIFGSXC9XOM
	 WoWhc8IdoG3p17dMewDDYnfSWsXoxPdQSOxD+bpbaCqYz3aAQ3y24M3FTNdYG/NscT
	 O3m3/YAgeRUk3obSZCpbzAYwjLVQ6Wz1HPCTo5ArslcLJo6Y/AhCdfpD2/dpr40XfA
	 FPgX7h2+2xCTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEE3460631;
	Sat,  3 Oct 2026 15:24:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BFE8335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61DD860631
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTsVAAJFGj9A for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 15:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FC5D6062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791041038;
 b=ZG+qrheZHMwIC9DftqAHglgXdIWObFCnAlFrmDJGMZM1OKazMV+BkDUdotWQ1KwmJ/Ha
 ZnHIXw6gJPLaFuNAB/vY6DczRE6BFUuft0pW2emJs66Mz3aCfzw9v5PCydguLe6JWni2w
 aMQbn58NGJPtkug+vlvtw3kUsk9uZMzU5RXOv6CnPRFjxs5wLB8utakbgVurmxnbGIYm/
 9brFd31tvGBgsnZp7srwYqp0g10GdKfA4607TipThKKkQjGVED+pJ+vTWsZSboIbtO8zt
 VOe5V3uwsTZSZDqmZ6l1cNYFByMxJM+HniPbQercHut1ZUGh9HGSkL+7EADY+I3X1LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791041038;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YyOvkGRsBiLIi98kL9CT4kKRPxlU75mbavWz2GAAMvw=;
 b=gWUKktDHZraHB1vRIeWMr//NXVViFrgL8QiMyfkNz917O1CgmYAM/clueUK0NXLB/pGT
 jzKCPINx5Md/E0pldiI8YlGcnCnPYlYZkB41dqk//DAg0KwxF+qA3VgNTeNOuV2AJfNt/
 Xs4go/+QVVhQcDPnETPp6qp4Z5VW593D+Aj7q17+zptHetDGidjbzhBfKJ6h2k0RXn7c4
 bfHgEBXyFLwc/A1o6G6LAyXB7ZSVKT7+fvsa4QsRAsQbnIlyRXyeCSwSwTxM5CNdEsMqC
 snL8pUKS68Rhl8p6wJXNQcRad04l495A+kFlTh4xfA6CptCOYv3g7GYXZuZqInGiVvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VVWuRyLc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VVWuRyLc
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FC5D6062A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:23:58 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b4bff33ceaso588446eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791041037; x=1791645837;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YyOvkGRsBiLIi98kL9CT4kKRPxlU75mbavWz2GAAMvw=;
 b=VVWuRyLc4cCmch9qjBwEOlXEP+kYKkgkb5n2xc6xGWN4HDU8chfTCo5s8WQ4VxdH7p
 AyhSQ7acVLnMrvKL9XN96w8KDNo6ed/xPlkcAuzfyNJ1OdnLZ/fj+seCxRgPPO+W+azR
 ydD7r6JdGNO+Svyd92if68Xddeuv8fBbrQung=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791041037; x=1791645837;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YyOvkGRsBiLIi98kL9CT4kKRPxlU75mbavWz2GAAMvw=;
 b=QoWHyBpW9Bbj1WZn6l4qjsZT7OXSXB4ydmJVwlHdlpeGyZqt7NqMwW6kZ36wPnqUpA
 SS1VVRvfS9Ajryr6VnSIBwZR/vhbXbTcfUNnSkVqc/XOhI6Vp+CR6ZN6hZg7ktJXSv/z
 fu2RyDSxt2WkaZABsYN0DT6jZ2nx09XNoovEpdvEkkckbGdNWOuq8IzQiPnOto53TvBg
 UoRg5Gv72j/WyF73HwNAZQYayusyszLZutfIUx7lvLTce5NdUlUOAymr4XV5/v/bZLfX
 R11xKexmSPQNy1bGI5ubm8ibJ3hwqDFSPRHNZdPxsFDBCrix9ujNQGNHcdxM/UBny3Rl
 N4nA==
X-Forwarded-Encrypted: i=1;
 AKwUvByy5WmJlvyzj8Rj5Yz6FU3faDVkrYpS5/yYlSR7Eg/L58Vf9URKqFjb/MYhqR8vzzqc0YuHy+U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nlsS+1jFMgnwggL5hXgP4ZVvk6V+UsCANZ5A8WvokYnLsuqPJc
 jgvgcUTYSop4Uj4aJGleG4m8XRt7GfbNjBSRr5Z6U+g5RDYTS/dkvgNMq5/EF9vtFCJQhyWCkgR
 Xchq6zLiGKpWs
X-Gm-Gg: AYBFou0xCBXgbkmcvfTIc/qoWheb7vbnQXA8PluTsSzvDpKXT+3AFHedERQAzkHi7Wf
 dqUMqmvM3kaDh6Ra5MBBf9rrCpXolP+HSyxeXO69e55zBElwuca8zG+7iJcsAUAW10tK0vhUyGf
 nKUmUuCaoZI9ilLKCI8jQx/B3TtqKuymAVyuYLtJ1P8M2beVKwLrJc5ZS1+xLBXrGTR+SvxKsMS
 1RHvOiDWOu0xKfGz4dhWpI8sXD9Xwgu/8y3jpJLM1Caq6lXxuU4ci29FHeRKvY0qqYs0cdYX6mX
 7Kc4cb5wSuz4OuazTuPZwE8ohz0lBiEAXzSwdPrtQqM1c6jkP7TsXYnt+EkT8DEiiKEay28eJTv
 PpfQZHfEy5kCZHxuFmC1VJ/7Y3HQVLUpULi08b/ZQ5sIyjeYtJyEiLzumxxyrMhCLTj4ElPAJi+
 U2X8CLoEXJ3GDlVK93PEig3I8IyuziJHb0SKViQRXJ2amQQ+xT7lLRSyjsqTxXrYPxX+V4GvHDY
 bA6lSDzgo1v82npZL2H7akalX6oNSpd/TbZzu4sS3fPJ4aX9HfUDK4MDssw14E9Rl90yl7E1LWE
 UfWhjxVdYHY9+EIyv80=
X-Received: by 2002:a05:6820:4ccc:b0:6b6:c0bc:365c with SMTP id
 006d021491bc7-6df32aa172cmr4975910eaf.22.1791041037004; 
 Sat, 03 Oct 2026 08:23:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3b498a0csm4669265eaf.12.2026.10.03.08.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 08:23:56 -0700 (PDT)
Date: Sat, 3 Oct 2026 09:23:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: vincent.stehle@arm.com, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 2/2] efi_selftest: add minimal fmp test
Message-ID: <20261003152353.GA82153@bill-the-cat>
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
 <20261002-authi-v2-2-900f6f9141d5@arm.com>
 <CAFLszTh8mPZRmvY3zNwtj2Qi5sAi9SJ2Zo_HU20eUXyLk__U9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zB1SJDXCIzMnRT5u"
Content-Disposition: inline
In-Reply-To: <CAFLszTh8mPZRmvY3zNwtj2Qi5sAi9SJ2Zo_HU20eUXyLk__U9A@mail.gmail.com>
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


--zB1SJDXCIzMnRT5u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 06:40:04AM +0100, Simon Glass wrote:
> Hi Vincent,
>=20
> On 2026-10-02T08:37:46, Vincent Stehl=E9 <vincent.stehle@arm.com> wrote:
> > efi_selftest: add minimal fmp test
> >
> > Add a minimal test for the UEFI Firmware Management Protocol.
> > At this point the test only does the following:
> >
> > For all handles in the system with FMP,
> > - Get current firmware images info.
> > - For each image, verify consistency of the flags, with some attention =
to
> >   authentication.
> >
> > This can be tested on the sandbox with the following command:
> >
> >   ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
> >                   bootefi selftest"
> >
> > Testing with multiple handles supporting FMP can be done by enabling
> > both CONFIG_EFI_CAPSULE_FIRMWARE_FIT and
> > CONFIG_EFI_CAPSULE_FIRMWARE_RAW.
> >
> > Signed-off-by: Vincent Stehl=E9 <vincent.stehle@arm.com>
> > [...]
> >
> > lib/efi_selftest/Makefile           |   2 +
> >  lib/efi_selftest/efi_selftest_fmp.c | 240 ++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 242 insertions(+)
>=20
> > diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi=
_selftest_fmp.c
> > @@ -0,0 +1,240 @@
> > +     if (desc_size < sizeof(struct efi_firmware_image_descriptor) ||
> > +         __builtin_mul_overflow(desc_size, desc_cnt, &total_size) ||
> > +         total_size > img_info_size) {
>=20
> Please can you use check_mul_overflow() from <linux/overflow.h> rather
> than the builtin? Nothing else in lib/efi_selftest or lib/efi_loader
> uses the builtin directly.

Importing that header first and making use of it more widely second
would be a reasonable thing for a backlog / TODO list for someone. As
Rasmus is the original author in Linux, it might even be on his list
somewhere (along with re-syncing the related compiler header parts).

--=20
Tom

--zB1SJDXCIzMnRT5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasEeBgAKCRAr4qD1Cr/k
Ck84AQDPAjt7R7ROOfGZKij8A2Hb7li9xxya0OG+vzyYCD6l5wEAsL5edX5w9wWN
QEL8fmdNWNU4YcrH7xGr92ztT/Gr7Qg=
=/4EN
-----END PGP SIGNATURE-----

--zB1SJDXCIzMnRT5u--
