Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA360A3822
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GLlhI/DR;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AnpoqfN2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10ECB80F1F;
	Wed, 28 Oct 2026 15:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DqWJhn-BC55G; Wed, 28 Oct 2026 15:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15D6B80B49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793200953;
	b=J6lHLPTvfEyi4+C5BAnhvDr3oRFMYTfcTG1vUDE8tc6ycSrwh4Df+z38kihFXIcjhCo4
	 0uSaCDym80oGV1bUn44akuOZQiVT2xTgXAMvxX5Ni9yPGKOGnegAba18itcEpQA+Za6TL
	 5x2Kwz3LeukYkuYPi6i/t6wPfNGxsVhOHqeRA6ErDytCXZc92l25NH/49McIaCFprHpQm
	 0tkVO8Nb/aNaPc3l3b9clirwa0NXueE4P9cYju/wjKfhF3jpMYW3OWO2x/lvev6deDk0S
	 CEPYJzFP5d6bl0pp6tugIJ9UnT91kibAV2hpjz7oRMgj1RFpqCQh561G7Kb8ZAO7Y3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793200953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q1zXW9QgjR6UVjwUzW6NDhmV4k9PYLItcAWoiRghTPA=;
	b=Tlsj/Lsg4NQ6F6T6wo7t+ONCTlwGes//OiQ2BJvKczjd+XB/VtipAZ64U4LNc2vHKMT+
	 DRIzLkGx4YjA0u7fmOS0y6dpVVJtD6a6dCxzIR9EbYlizzjhkRBanJAgwKY1USOIwGIKU
	 PwMfGICbqMiaOuuGSesMZZUEaKMdPnODwEsDdxagzZLv7PZBIjOAys44CnwxlSp7Mzvl+
	 +DOiSOBYfkc44unkNQomftHCc+a+1tblCRv1cQNZ2DPtjsLJZnsRFYjkIUNgq40lKNJSq
	 kuZYuI6oLD9gikFTARNLGnlCD4H8L6ottkLoway6uH/uO3dB/m0eVfvt7OotYvuy2Vg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AnpoqfN2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793200953;
	bh=Q1zXW9QgjR6UVjwUzW6NDhmV4k9PYLItcAWoiRghTPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GLlhI/DRsSSXJ++aafPkgFV7CIAtH4O0pu4io+oVGVuwQUMD7TkTdlw1s6jOTSN+5
	 JFOfFps4yZ3JI3x6O/Wlx3GeF0Q9V39EMrufQOFCO9zV8BZLx7GzF2Q6r+oQNhMjQt
	 8/wITV4GmQ8b9jByyv90xbLkcXMsFBD+No50IZb61Sfudh/BWAZ6amOYsNRFtwm1Yy
	 MTJwIE1RDT8UJ57Jd7l8nMx6DP4pv8V4WxYvSqBNtCw3ZAwAqpQm0MU5nrNFoSW6mz
	 JZA2UyK95JecWYAvji6AHwp3iN8JGD6zTAzyrWxM2fXIq6G3fjAJ+UUIYFCfYCkEKX
	 aZRstfGOT+mzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15D6B80B49;
	Wed, 28 Oct 2026 15:22:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2A53356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B483F80B49
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:22:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnQtTc1lA3JH for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 15:22:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C428880A65
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793200951;
 b=LFHNfOnHuXttnaR4756I7aTNUBcJX81gwZXaFpBcb03gzkfmhml6mhoVZvXycQwJnt1Z
 u/+wPInMqFIwVEcXi5YdpNnWXMi6ffzHvfEm5rrSZYvOyFpopadKOVSefEt7SxtcymSv8
 xO0rsoGQrZwHSGl4z+VaZfaCdiZGV4sWQWnJC+SnEpsNkz1GCG0ITxx+gebsWQhdmm2Jh
 cktaPjdk9v8LukKrmf6McN0pKYvgRu3qzcQPoOcOoQDwY1wNZrIbrNTiFSAoE67wCq12B
 xJhGb5/0lU2ZkoIVAB4f7TvrsKyfR7s/q1/+hNI/FbHlQElEwIrJ8aHUKz6BuvC60ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793200951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Q1zXW9QgjR6UVjwUzW6NDhmV4k9PYLItcAWoiRghTPA=;
 b=MoE16SHu5+iUYMyaj27W523cHxJVS9+/Um5tPpQszJS+H6P3c8MeSqslEY7ViFUz/ULA
 qlIkYkWrXFlLuypF+C+BWN0QozDZk8MLXzfruc60q7WX2CUWz6Tmd+N3c/gCgQitkU9uh
 S3+WAyCo5XlYQ5bXR78+0vmqhK619K5TbVZtkpihOZoIoE+ztwy8qaXpJ1HBBl79DlADX
 jmJNoI+8fJQjPsBqO/Z0gh94RsyJ+Gzbw00dZwQu2sdt5ltS0352eglVi8j13SGFyhDLX
 bxovBRfGgbieSfx0pO7+kLp/4xWgjN4upYryeqiSfzHZR3uSoGaivnvNmPcvZjPzoYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AnpoqfN2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::9;
 helo=mail-oi2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AnpoqfN2
Received: from mail-oi2-x09.google.com (mail-oi2-x09.google.com
 [IPv6:2607:f8b0:4864:32::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C428880A65
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:22:30 +0000 (UTC)
Received: by mail-oi2-x09.google.com with SMTP id
 5614622812f47-4f61e12e8e0so210802b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793200949; x=1793805749;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q1zXW9QgjR6UVjwUzW6NDhmV4k9PYLItcAWoiRghTPA=;
 b=AnpoqfN2UQfxIM8+QoOIv/AtBh96kbP7Iyti/PptHf4NNIRLHtY1at8stPnCv7QXYk
 fXrAe9gZhQlJ3wwy6FRP52i61QlZAaEsPoDeRAZscOnv/aQB19WQjzXDnr5s4nclTK/j
 Y/mksXQfnqpTsp79qszb7rbO7dZziXP3j4GPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200949; x=1793805749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q1zXW9QgjR6UVjwUzW6NDhmV4k9PYLItcAWoiRghTPA=;
 b=C+bwWT5F3vYwqK/w2+7lRW0P7Q/cQJ4G4aGlo544mGwXKn781qU/IyaXEfJRSp7vkG
 k4B3WlKqNfyVR7/ebECN+D5q48jch7PJx0pxRWJfI9vgcn4Di23pn8xv4uYirfqRJEi4
 50RGg1P2idfv59hQvFHC2unIu5jEbIAl9VWgFIGEtejeP7BfdesP1Qb5dtiR0FTmQ0tp
 /TgtwqxNTvVb/Rqyb7OS11hAlGEzt6PWf+XUji7GJzil01C9JoUK7SwavQ0SaJKuHS52
 h1yGtSEVPxkq8Rkvdl+rNfTPaoVHUeSaAJ7MtFMRGqgwZhXHfNBU59q9YnmCtwvRQxNI
 D1Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNyQucyLQjI7vf09qKriD7sHfWnFtazwBGu/F8chHpSQ/Vb6ZJdfE40NfIoHtYAfPPCMmXGb4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKQfBg/uM/8ZQdkIrfuQEPlmtR5A9Ie1sXC7nu9GzhFFmLElh3N
 BnIZjJn15l9dM4kmORLhPoaXseY8GffYCF+UtUPssq8+khWfRCGKilBLu4iZxLxaLSk=
X-Gm-Gg: AYBFou2Gi725ICOZ1PWyHka+YMHeeJw/CGgTz+48Zfz3LSBxWKMW34YWgvueoH4E2rK
 JSrhzvnB3jVrK1hqB/2uj66/kRBaks8yKdZtZxKqZjN1WSAb7YxEHqzeZkYxMzkkeGRZO6OdAl+
 OOJKg4Ptnd1SEwbO/CY8CtSmcoIGPHOI1JPSOBuudroEUSC3kznpoZgi5Gp5S4GF5Cz9ynnXzS4
 Y1Fq39jyaKuIujrTzm11/gl45dfKGWjv7NL447DBPapMgAO5gda9RrxetOIGdgvCEIDRaNXWczD
 5WRx5hmvyd5FB/rDOa540qUKhvWinGlR5rf6LZyhgTY11TT6Lusd3IQzn987rPZHJxI4S8tDRca
 GxwSQM7fla1OSeRRwqQXhx7MlIUhk8cbY74SPViZ2UFYssq4olmZY7Cv76qbl0UakdXPNaLdQim
 dNL1+UnA3h4YLCeD/EYaIBRs+ri9nv5Bm9HSz4ncZxq7pLBaVj7zUJGzvx2ah9FfbC3QVeKcBLs
 xinv5UuDzAd3VgWWoYw0oCYLIpRw38hI+1gHZpFriOAM+2RH9dR10d+ZwT1sHj/Vzv5LPL5kwDg
 UW3wrIG0VmRnqLy/x61MloV/52NYcks1wZJqQ0Yj3ULTDL8wWqqdj7CpgoSnLyK+Z9E3DAxSJjm
 seWiTPXBmuWaYEGWAiw2Ry0Nx0/4DobP/8hGQM6H/BgJu6i6180567sDja+eY0kGlgvjtZ0CCfQ
 Va8Y+xznM2agUepwfqMAdsv7GKyQH1dDb3MZLDjGHtjFZYhf6+5V9/
X-Received: by 2002:a05:6809:1c:10b0:4f8:65de:7293 with SMTP id
 5614622812f47-56382c84d30mr1348400b6e.15.1793200949382; 
 Wed, 28 Oct 2026 08:22:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c603f72csm1443577b6e.10.2026.10.28.08.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:22:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:21:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
Message-ID: <20261028152156.GB2677024@bill-the-cat>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
 <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
 <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
 <CAC_iWj+ofe4fbY2yVc3qzZmxwBprLem-urjepKtVg8ORtiT2Fg@mail.gmail.com>
 <CAC_iWj+hJHKrH+owS8s99iBYAQRVZ+zvjt-rvA-0d657=SpK-Q@mail.gmail.com>
 <b69631ed-8621-4d8c-9497-846c3f0caf36@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6yfdc0OvzyQO1K7H"
Content-Disposition: inline
In-Reply-To: <b69631ed-8621-4d8c-9497-846c3f0caf36@embetrix.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--6yfdc0OvzyQO1K7H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:46:26AM +0100, Ayoub Zaki wrote:
> Hi Ilias,
>=20
>=20
> On 10/27/26 13:01, Ilias Apalodimas wrote:
> > Apologies for the late reply.
> > Was waiting for some announcements to settle down.
> >=20
> > What I found out was this [0]. Comments welcome but I'd like to see
> > how this plays out before making any decisions, since we use mbedTLS
> > for https as well
> >=20
> > [0] https://lists.trustedfirmware.org/archives/list/mbed-tls@lists.trus=
tedfirmware.org/thread/YPIGCB7WN6GCHOGEGKOJXUYAP7OK527W/
> >=20
> > Thanks
> > /Ilias
>=20
> Thanks for checking. Should I address Simon=E2=80=99s comments and send a=
 v2 of the
> Linux based ML-DSA series or hold off until the direction for crypto
> integration in U-Boot is clearer?

We can hold off a bit until the overall direction is clearer, thanks.

--=20
Tom

--6yfdc0OvzyQO1K7H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauITEAAKCRAr4qD1Cr/k
Co0EAP4n8S17gujFBwGoKKxw/IT6iD0zRMFSUGSWYe9Pg0Oc+QEA8uRqVs/NtqIF
8qFLRo2Cf9PzHlgQf5V1nXBIq0KCHAQ=
=qDDn
-----END PGP SIGNATURE-----

--6yfdc0OvzyQO1K7H--
