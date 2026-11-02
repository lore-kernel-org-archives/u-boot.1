Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE597606FB5E
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CqYvc2M4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=I3CfcXrl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4A5B80F95;
	Mon,  2 Nov 2026 14:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFqd-Dm7pizN; Mon,  2 Nov 2026 14:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04B5580F62
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793630567;
	b=AzdgSysJZEi+BEceM1hDO70ELrywLMlHmlidcVu6qIb3ycvhiOSF7dRbYpVgt/ltd9AH
	 jMW4FfXdWoZedzvICEqzXNCE/GTRPsGBM5+7kRd7BTDbreDEo4vNH+XXAMsfoy8SSjwa0
	 LqyxSAr1kTPcXGhVCnjU0cfpfMkHmS+NDJp+bYN+CuZfUhDyLOs95hFeUnG+0zpeBMHW3
	 za5+X7tNv1G7m7Z11s1ak2vkv90FnkKKm6DzpY2O54zbP8nISMc4LZ/8tSk2lvmDGZeMc
	 aK+OFYTL/jjwuvBCfBRHzi72+GjKwTAqxqiUIgKgucrUtwCj+280MpaqVJ+DuSRVvZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793630567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FyFelsg1WCcYhQm//KmvoS1XOtUk3Xgy5562+qFwqnQ=;
	b=GE+Ja87/FubSDMziIRJR9I8cRtlAE9tomUSrmEJHS/GTfQQaxl5Cda+qwRhuVEvEnMml
	 iiTYOpbhh78adshg75j78h/M+mqu/1JWZvB1tp2ZPAwBmhhVy507MgBe+kKAyR3BoFSgn
	 gUH7+ABesMBhi02VzSRJ8VP0o4CeyMi841jOIfUs3DIb8/TqWOEjVbW2EYBh5ZQlD1Jua
	 6GPD6V3Vg8wkfs0LZOZoQBS92p2iV0aSffhd1E+S+/IeBX1KbAFIPMUJEHbxqTr3yKOdz
	 Zv/2G7EGKbvIWbzscoNhK9V22X/JCJUhfaZmf4FggWAtb6Xzl/5RJFKTsLW7GxhP6Pw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793630567;
	bh=FyFelsg1WCcYhQm//KmvoS1XOtUk3Xgy5562+qFwqnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqYvc2M4TVZ3q8CEgOtX8Y+J8/z8CanxVTLOKHu3i4XZ5mUYZE3VRAOrnyrOC3KSx
	 9wt+atynL3fUHKyJ1GapUEX8HWCYO8KwV3/X2aZph8sRSkOcSZrHodoJDCySqVzBob
	 vY3mCa6dNQV56z25V31/lIszC04BMPmDpzj8+uzAKP9c3SdK6C59WvpWFzh/n8Ue41
	 qTRSJ5cND8eU0fNp8hRxyFAUrkyT1Sg5gGcbI45BIERyfWKbZQEbQsZnf8caFUtdN8
	 MQ6XggTU4L6D6d0lbdznVa62YL7WiPDUu0SKRTgEGSQFZPcwfeqx7mg1b6RtZFgUTr
	 mPvofiNR31BSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04B5580F62;
	Mon,  2 Nov 2026 14:42:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F8182A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F87E405AD
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQ1ZHFUxwoXN for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82C8A405C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793630564;
 b=lvdiVQu5GK0hnaYL45WXGtbt961GIaTwnquulyC/dd1GZ1uSGsrQbQ/hjJY4bQvgzzE5
 E2oAsfrRqY1tKfZXA+FiIPXdd8sxMV8amasxlHNOvBzJhI5at7EFw1WZP69b+iAeQUidk
 tYJ5q2bLj4lAxki2+97jip02VGJUR2Wf89HylAenDXGC6SnXkyz92+AfPQnosfDCD98KE
 v2/e7fE0tp0OFzs+IQR/KY13J9QT2ZDIrkxLTopox+78L0ITeJYFjfVhHtR8WueahFfSs
 PJ5zrM6KDy0AV17LxjxKhXCWG9/F9okUSFmlswVcY1+EwZdGbSfC7FMzjuWOqHx45ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793630564;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=FyFelsg1WCcYhQm//KmvoS1XOtUk3Xgy5562+qFwqnQ=;
 b=AnzIWkA2k49E6zJG7RjZDKsGk/Gkkdb/nyZ6xucJc1lHnTVKNLCuEeefs0+3N3dAm3ah
 HgkcT+bjuwsiCK2uFhyBzPY0aJwCe18G5HHg410aIaGIN4lURi7amqdaI9VHAwJsGaH1g
 RnoKpcdLjp9Nwg2HNEmY1PFKHul4ksLyEMs3a3XDepaQ+4lc2GIDm6nyTFSTdKCOyW3IJ
 1yHgK6bnGDs9cBwu2UjI+zFfnZkqLc8dm7Vtg1oFoQW2GgZ3cRJ+Pf5m8nq1eqyuRBdpr
 0sSbT7WivYctjqM+6MaMf9HW2S1Btj9//dYcd2aQbKT3hwd2gCyIuLbeROn8+8/S7sg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I3CfcXrl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I3CfcXrl
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82C8A405C4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:42:43 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-8490a7d6696so1984683a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793630563; x=1794235363;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FyFelsg1WCcYhQm//KmvoS1XOtUk3Xgy5562+qFwqnQ=;
 b=I3CfcXrl0qG7KDiAEtee22y3padOPei7zLHrv4PMpdDcE62Qhhrm5CBoHfqNPDkx1V
 L5jDaXwcCFSxikOOoWHA/GA+ReD3Xnhx75hxS5qMCmOksDKszi/Mhv6N2Wx0By+KF0KM
 9GA9zHszInnbqIwpsd8Wc167GmGx81vl8DMKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630563; x=1794235363;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FyFelsg1WCcYhQm//KmvoS1XOtUk3Xgy5562+qFwqnQ=;
 b=NGMWDrWZ7BpQdE0DJhVlXOqgeZ1TrQ3ZfQsQcifkYDSGnx64nLWo9TuzY9cv3kTd08
 X4cVbMWkv25CFBtkrNkmWvkD4zFEJ05Ts0c2m4spij/uWezAnNm6qRmiryW6mzAsSHJu
 n6oRoe9xnYU3aiqmFGz+6SkEgvY8crzsLixR46zlf6T2fCXtCmmrqUeC7/3LMX473jki
 Jf110Iz7O9VBig9Cp8oipyyZmMZPv5TD++8XMfogd7xqytvXm6M7a4T7CV7pncZFHWx4
 ZHNNLoixW5msWm4IiCa8vtrHEIlfqqpGqsPotr+9V60Vv4AGBYpE0RBAFc1Dm7W7Nwfp
 ELMw==
X-Gm-Message-State: AFq9FYKRSpmpcxmD0WgRGL9yXeS9Bp7BnkKmeUfHDk4gGliDb++/9Com
 1wbhJZyNKf2gJ7skrg8k94s4ZKal2gsi4aNGBL0u36R0Ikc/o0tU8rvr3M8rW53siJ4=
X-Gm-Gg: AYBFou3i/ZEnCndJsW9/tCy5tNf/hKjFkXM4G8nUoXjj3/VDSP2vmvMEoARGvTjrgyf
 zNDqfAcEzZDMzYu7zh4rHhXgzFK1t2WGiSZjfdLiFIrIV325O9boVvDZeJRfeRzRXrirJV326JR
 UMhcu3ucwaa/9lGAsclgEAgOkdwB52jDdR0bbU7/Se7WKxYIt3qR6QQWG+5q6y2rKi5ZHMv0sy7
 PUWAVyorgIRikJkyORzQ424tjtVzm+u4RFAmarl1WpqbspWr53dIy9KHY6lWd8CWmCg7rKGdeS5
 gH8HswLW+lnhF6QzIvkHmXwHZZF8sGmUg/BmAtxy7Aj5hdM2R2JAcsUmxQUYCLg6j5P1kQx9mlj
 qW+9JSAD+gBzR03D1WFT1sYx/LugaNPww1XXrgMojB3Bv5DgYT0DwhaMr9rNkHay1DzZGYMePK4
 nRHzAEs88MJrJKA8/4iBJ8JbiftzL24lgTShAs/+9IGEltyIfD33+5upC87D6bKs+yFoydrqllW
 6nYY86G3ii1/ccZhBC4ZRS1E+O4jNJUS9wK+nk+zkdHFfRrpU5BK31V0W2jBYU3TPVOI3u2LR9X
 svCNy+hrfxI26kNJYr+P7/W4wWrAm9LYHKgcnadDDqIr8nC6yWqY9K3xaLxIaieqWFy9lp1Bo2J
 Ko66xqNlJnNCVaK4OjILOe0vBzoyq+csvIZyr+KG1YDyDU46P7mXCJWt9x4JWISc1LbTnmU7uxy
 ttNI+P3LmUcwVxPGgyyzFfH3HvrZbBfQ==
X-Received: by 2002:a05:6830:675d:b0:85d:44ee:607d with SMTP id
 46e09a7af769-85d44ee62b0mr4891932a34.0.1793630562723; 
 Mon, 02 Nov 2026 06:42:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e841fsm10105380a34.1.2026.11.02.06.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:42:42 -0800 (PST)
Date: Mon, 2 Nov 2026 08:42:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
Subject: Re: Pull request: u-boot-sunxi/master for 2027.01
Message-ID: <20261102144240.GS3309461@bill-the-cat>
References: <20261102114733.3468703-1-andre.przywara@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fCsZTOytPRR8dOnY"
Content-Disposition: inline
In-Reply-To: <20261102114733.3468703-1-andre.przywara@arm.com>
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


--fCsZTOytPRR8dOnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 12:47:33PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull these sunxi changes into main. Please note that's the master
> branch on the remote side, the main branch is immutable, so I couldn't
> push a fix there again.

Ah. On that note, I think the answer is you should start using a branch
name (for-tom, whatever) or tag, rather than just pushing to "main" or
"next".

> Not much to report here, some cleanup for some older V3 SoCs, also a PMIC
> fix for some Olimex A20 board.
> H6 boards with 3GB of DRAM now work again, and the A133 build process gets
> adjusted to the now mainlined TF-A support.
>=20
> There are bigger changes lined up, but they depend on DT bindings which
> have not been merged to the kernel repo yet.
>=20
> Gitlab CI timed out, but worked fine until then.

Ah, I thought I had adjusted everyones projects to have 2h be the
timeout, but I see I missed at least u-boot-sunxi, I've fixed that now.

--=20
Tom

--fCsZTOytPRR8dOnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauihYAAKCRAr4qD1Cr/k
CtgqAQDg3+DZlSr8oX3TPv8QhlQCcMn7cGLUWG8uFVALrpy9wQEA1VZjYbHyjDnG
S03cs3Rvh8k+gm5H6LNn/6h6eAUpSw4=
=Vy6p
-----END PGP SIGNATURE-----

--fCsZTOytPRR8dOnY--
