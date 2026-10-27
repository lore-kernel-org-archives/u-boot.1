Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iQoudohd;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pMKQL5Lm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7685A40575;
	Tue, 27 Oct 2026 00:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IONJFVKeZWx5; Tue, 27 Oct 2026 00:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 635E34056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793061292;
	b=sqczCQgNHeSuNKN9fXn8e4gUYUSs36HywyH6EWpr4zXezUdv1HnHHIr04BUxoAag7j+H
	 XhJapDsJHuHVgj5dxk48SEm8NcE0kFdwJGbXQJaMPgPWKo4toSSQA0R7Tr2XYNy6J8lg/
	 pHO5wmiRKAbjxEAUJyBqdzkRIUbzUJr3j+n6B8kqZxUm7Q1oYQP/6EJc2IAS3L0ZH58rU
	 4+MROYaqyDwGbEKbK8hM8TKZ8FbkeM5zhtLKQwgdDgPaxOdR0xO5/XTq9mSZEFTAnb+ex
	 GvjRkJhLoc8YdBDotz/0StUy7JRBjWhKyXCphvqcIvkyzErbkhNrnItQEGh14CwhmbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793061292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8pT8EFwZA6sMCK1bDqgXej1Emv/MGAQQjY+xbt7CAwA=;
	b=Z51NEOw1647LZXrlVBdJCJ9nXlhRY1HoSvqkMumLKARepiY6TaLNNvp8tp69va/VugPI
	 XZFYO3xCxEHzGEFCDC3y/Z9Q+AwkBViza542jVQINyAF+VYlu/V3AK7wAEoc0I1h20mks
	 5L6WVVuxm2ZpVJgbvmOTOqVQudfndZO4A2WAo6k6s6lp24Oc/IE+V5U5jEkzbyOa1rVMh
	 U2bSx1IPlWS50J7qE/etRmI0lOYxAzRFjDd8FGkOzmUszAmfoizoSaPX2mr+xegUlHp1c
	 je1Dscft8p31ucmBzSR6Sg25AZHuCaZzsHAeS7IBRcyd64oewvQWUSlkiTaGCuBD0Zw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793061292;
	bh=8pT8EFwZA6sMCK1bDqgXej1Emv/MGAQQjY+xbt7CAwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQoudohdZqGAjS68E0FWZn85jv4oZ6SLBZ4sDfXSJ/UH2BnCWim1vDKhZ1Ma0bepD
	 BoDtv5TpMT6LqqnNsFhb0pM/AJpIZku/SE0u2uJ1lPJBzE7MQFUMr8Lu9ZiCYTnUw4
	 g6C8v/wBfkP3EAU8+RgBFzcqQZDqifM8cOzHspOh1treap2EVQK7OuF2GD2WNdtDuy
	 rlNWbBYyXYyEK00BODOT1bml3uIXYrKjO2akFEKpR17Yp3UwaaRhoCYoJ6QNJd8olR
	 KXfy8WqsnwSttcevEk3PoXvEZnpalBS7Yjiy8yLE/SgPPrnuvnaDuwWS4d2sdyxJWO
	 G/IYObRotdCkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 635E34056C;
	Tue, 27 Oct 2026 00:34:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 908AA2F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767FB605F9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:34:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQDtRDL6C36J for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 00:34:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 432FA605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793061289;
 b=aZ1P20OT6b08EOk0O+4kaH1racTv043TsxfFskAQNLjPj8xMPxXKlj6HGo9xAW2k220G
 3AOgoy8fUOuSM8Sg1OXuM2W9RhgsnlIT3ZYrZj7YT8kMFDtKv1+iJ7aFkTyT2mGIQLwH1
 GVk2Z0LB8tde3W1NCDzc8UtW6jQSoavUqkg6FAFS4fF+rqkrZeHO6t+bQeiLqwUudwea0
 3CC5V6JvhwaxWy4TpfJzhOzgJo/hGkLKOAL195LJbi1w5iwVxku+AaVVO229H6DVv7d2F
 pT3k45ozHhIIhq1+U2V3LNoAPhSRoLiAR619Hn1JxdrV1GPtPdahqf1IotsFXzVTxFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793061289;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=8pT8EFwZA6sMCK1bDqgXej1Emv/MGAQQjY+xbt7CAwA=;
 b=hlBpNRbTYcS0nqmdYTwN+zRmoNsD1spRWti1T9iabpUIo5ko+XLYz2V7G+m2o2hUVplU
 U/BuzNEhfNzwz2MlhxtXTdlaOjSMCrlJrc306W6/1+H7FMR0o5VXZm+i6epAmQHhwiem8
 ytXMQmVVlPxKck4xA3CQUpSTbAtWlWfXOKXPpDXM/TtFFS5CbUdU4XLc846Q+1V0wtafN
 oe7QxjOpEB19oYVQFXYc7dyfymRWvhDXXKEfb/o2qQLPrUyoIIFFUSL2eBw8H7FX8x297
 rUrqwuUNGi/Ml74scjk7IroX7yp5cIyKkizQj1d/f/SCEO+/MfU2RYvJBU4AOby4x4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pMKQL5Lm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pMKQL5Lm
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 432FA605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:34:48 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-820ff812cd8so661357a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793061288; x=1793666088;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8pT8EFwZA6sMCK1bDqgXej1Emv/MGAQQjY+xbt7CAwA=;
 b=pMKQL5LmeFSboXbOCRtpkBoiFFOKBbq6waLrrweWKDKdgV4BNu5XR/7O4R4xIWybES
 wZMDnSYDkSslD/FRyLSWYWCttUkkxvQPKnfS4ohFzewdgD7334YxVLnmk7QU+2BTDjWl
 iX7QuQvRJ4qjoiq6OGbfiJ95kNSLXJQzIu03Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793061288; x=1793666088;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8pT8EFwZA6sMCK1bDqgXej1Emv/MGAQQjY+xbt7CAwA=;
 b=YM8F0ThtpCo8Vvnw0DJbjOA8r1tPf3baBdnToH3AApBkAU0SFe4PygqXtR3aTNIRAr
 Q+yKXJeyz4rf7iVlOLTm8Mb7gcD45twu4CcwIlho0URZjypVznYF4KnORmtZSKXzUfNU
 yst/QJoTbKIXZF6so5zXbNRAlHp3avnLsqGggoPldYK/Z1E18hJ3nQgPZr9u1i79haue
 85So3YU7nYj3hEsJ9HrSR0xuRLk9LzsSnO/DLZYWxEXbCGL9BOpbfFOcev8MoarcY/ss
 kPsRauVf3qy5DwnrevdzsLyYPHB2NkUE7FLYtbXRppUWj1L5fRz6vL++pTmLxzspkv2N
 gWrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtTn8zlzJxlWblgclKSudm4mHncAwwBx5VCIuTgdkKifvf/54txNVc7BidPNKVZqiLfKD8FTc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJ+NIWoFxTLjPkx/5vXSTmCDmdU1xFHKfGFwVKoMnJ8/lOwIW/
 ZRMw9XueTWC7AgcP8IAA5fBrckBA7jPINpYQdyEr6jQam1JzqFrseWjd4mL2W8kvYng=
X-Gm-Gg: AYBFou382AmpV+lyESpwTdW7QvoptaV52sn6ts8JAOvseP66dQSDGwvZVCdtPeSkgyz
 aphJfthfdw44HkBvJ9DdDgLF0p5/xd5sxHzhI0CUV5J6ACEUKVZL+wdVp9HMmiMOd7io6nXagaM
 mgoK/JH5d/aZ3z05H4ak4ji+i6O6XJO5U0H+7o9lq/3iWgtwbpGQGh+6PuI9nJgPSdTRBrNPnVl
 Fhu/yRXABUL6MqLewkOjBUBH1AMUklx9PE2l0ob6BGqegfEWkOR2XMV2uiOPbhh+X2PUlAybDIc
 gx1D1tQgJNBsR29iQKx7Efuccpirz9hH+mcj3SbVtWsIK1VjDfD69f8vE2rYBLs5NK9HbFFv4II
 xjyAZvnvVxnE7fMi67SqxapMg5HBj2XwJWBfuBsT2lwwh+RpLrD/PfH9XkzNx8Inb5OapstdKmo
 lwymYiJLG0j/Q+iJqsZZRqs39zSL0pxUHik/+Wty6Dzgpv2jwY2flXoTK6MfVbn2QBm30U8BWFx
 V182V5228uj068n8NyyoV55YvTngjaYM1Jy0V3wi0G8Zju1bnNrOT9wnGj0khQ4rEfoy36ppH4D
 JzmBtjc0wzNA9gV5IaU2mwJ2cGBRBFqOpTA45U+xDvWXdMjvzbTIbCnJjSS8vF+M9VT2aZ7NXo0
 M8HFoW4/vPGU9wRvqEM2+brA+caPXiPYUbfvGDCWdW4z4Ouf68XHuzNJjAg==
X-Received: by 2002:a05:6820:80a:b0:6f5:217:b0a2 with SMTP id
 006d021491bc7-70ba0b5eac4mr4317278eaf.12.1793061287836; 
 Mon, 26 Oct 2026 17:34:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0749cfsm9923646a34.9.2026.10.26.17.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:34:46 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:34:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261027003444.GO646438@bill-the-cat>
References: <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
 <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
 <20261026211952.GL646438@bill-the-cat>
 <49FFC097-8DAD-4424-BAED-823C55BA3524@mainlining.org>
 <20261027001923.GM646438@bill-the-cat>
 <B40E19A5-99C4-49F6-AF13-D0BE0D682404@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iwbze1eC283OwFqi"
Content-Disposition: inline
In-Reply-To: <B40E19A5-99C4-49F6-AF13-D0BE0D682404@mainlining.org>
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


--iwbze1eC283OwFqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 12:25:48AM +0000, Bradley Morgan wrote:
> On 27 October 2026 00:19:23 GMT, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, Oct 26, 2026 at 09:27:05PM +0000, Bradley Morgan wrote:
> >> On 26 October 2026 21:19:52 GMT, Tom Rini <trini@konsulko.com> wrote:
> >> >On Mon, Oct 26, 2026 at 09:14:37PM +0000, Bradley Morgan wrote:
> >> >> On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrot=
e:
> >> >> >On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
> >> >> >> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com>
> >wrote:
> >> >> >> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
> >> >> >> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
> >> >> ><brads@mainlining.org>
> >> >> >> >> wrote:
> >> >> >> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
> >> >> >> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
> >> >> >> >> >>>>
> >> >> >> >> >>>>Hi all,
> >> >> >> >> >>>>
> >> >> >> >> >>>>Just a data point from a user: we are using U-Boot on a
> >T1040
> >> >> >(QorIQ
> >> >> >> >/
> >> >> >> >> >>>>mpc85xx) in a product, and we intend to keep up with
> >mainline
> >> >as
> >> >> >> >much
> >> >> >> >> >as
> >> >> >> >> >>>>we can. We'd appreciate PowerPC support staying in tree,
> >and
> >> >> >we're
> >> >> >> >> >happy
> >> >> >> >> >>>>to test patches on T1040 hardware and report back.
> >> >> >> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible =
to
> >> >use
> >> >> >> >64-bit)
> >> >> >> >> >>>>and
> >> >> >> >> >>>>linux in 64-bit.
> >> >> >> >> >>>>I am in the process of bringing it up to our 2025.07 bran=
ch
> >> >and
> >> >> >> >> >>>>potentially
> >> >> >> >> >>>>mainlining as much as possible. We have some remnants of =
it
> >> >under
> >> >> >> >> >>>>`board/keymile/kmcent2`.
> >> >> >> >> >>>
> >> >> >> >> >>>Would T1042D4RDB affect you?
> >> >> >> >> >>
> >> >> >> >> >>Not directly from what I see in the code, as long as the
> >shared
> >> >> >code
> >> >> >> >with
> >> >> >> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted =
to
> >> >> >report
> >> >> >> >that
> >> >> >> >> >>there are dozens of us using powerpc :)
> >> >> >> >> >
> >> >> >> >> >What you could do if you would like is to test the whole
> >series
> >> >to
> >> >> >see
> >> >> >> >if
> >> >> >> >> >it unaffected you.
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >Btw tom I had a idea: you merge Vincent's bug fix and my
> >> >maintainers
> >> >> >> >> >patch,you make a PowerPC custodian tree, and I handle the
> >series
> >> >and
> >> >> >> >the
> >> >> >> >> >naks and stuff and the comments.
> >> >> >> >>=20
> >> >> >> >> and btw yes I'll make the pr with the finished patches so you
> >can
> >> >> >merge
> >> >> >> >> them cleanly
> >> >> >> >
> >> >> >> >Trees are relatively cheap, but I'm not sure we need another one
> >> >either
> >> >> >> >for the subset of formerly-Freescale and not-QorIQ PowerPC part=
s.
> >> >Since
> >> >> >> >I added you to the fsl-qoriq tree, you can also just pick up the
> >> >> >> >outstanding fixes and your maintainer patches (and leave droppi=
ng
> >> >stuff
> >> >> >> >for now, as this series shows today we're just getting people
> >having
> >> >a
> >> >> >> >chance to see and reply to this stuff) and send me a PR. Thanks.
> >> >> >>=20
> >> >> >> Hi, sorry, I didn't clarify enough, so I had a chat for some
> >people
> >> >from
> >> >> >> the open src firmware slack, yes?
> >> >> >>=20
> >> >> >> And here is their answer=20
> >> >> >>=20
> >> >> >> "Ah, Peng Fan maintains the FSL QoriQ tree:
> >> >> >> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
> >> >> >>=20
> >> >> >> That is the vendor one though.
> >> >> >> So yea, I'd go with a general PowerPC tree.
> >> >> >>=20
> >> >> >> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
> >> >> >>=20
> >> >> >> And even my slopper suggests the tree, for sanity purposes :D
> >> >> >
> >> >> >Fine, trees are still cheap. There's u-boot-ppc now. But please ke=
ep
> >in
> >> >> >mind everything else I said, thanks.
> >> >>=20
> >> >> Thx.=20
> >> >>=20
> >> >> Question: will you merge the maintainers patch on this PR, so I can
> >> >focus on my add-on maintainers patch and the removals?
> >> >
> >> >Lets hold off on the removals a bit more, as I was saying.
> >>=20
> >> That's not what I meant
> >>=20
> >> I meant, you'd merge ONLY the maintainers patch in this PR
> >>=20
> >> Then, I'll go and take up the removals, and give it say, a couple weeks
> >to
> >> let it marinade, and give it responses THEN submit a PR with the
> >removals
> >> in it. Then happy days.
> >>=20
> >>=20
> >> Or I could also take the maintainers patch with me too...
> >
> >Yes, please pick up the maintainers patches and if I follow what's in
> >Peng's queue right, there are a few other powerpc fixes out there.
> >
>=20
> Not in this PR, maybe any on lore that stands out?
>=20
> lx2160a is ARM
>=20
> nbxv3 is arm too.
>=20
> I'll look harder (maybe I'm wrong) soon

Maybe I'm just mis-remembering, thanks.

--=20
Tom

--iwbze1eC283OwFqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/xpAAKCRAr4qD1Cr/k
ColOAQDzjrkgP+xVxUVkDRomk8M4D3OAzq5TeEzHtmwGjSW07gD9FucOao7qChFM
rlQFNavUna/rW7sUcHCdooV0dqHGDgI=
=lEPW
-----END PGP SIGNATURE-----

--iwbze1eC283OwFqi--
