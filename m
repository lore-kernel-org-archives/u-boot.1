Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222E8C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 18:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5DE860613;
	Fri, 11 Sep 2026 18:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2X71XyuHdLy; Fri, 11 Sep 2026 18:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0471960617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789152833;
	b=ps5SieozUfMAf6t0Ozbkhsr52Z4mWJsiQ9feRxBauO8d9YB8bJ+wTa/laA+leWgz8F/M
	 FOa7kuRMuvyYqGMR8jXoc9jFvXuOh13Pn+5sBY0Yt2YQEIQtSOQ5JgMXvHBqJwhaDPDkH
	 939vBdFFEB+3CiicfS+t/FdsnWEVy7XBINxunQOdL9nsPN1Gsn+xcWBw8a2Oni1jlJ8oT
	 5jm7nCHkTocnL5t8rRdUaIbdFiwzEfn3/MuEmhelD/OkBEuVdA36FaMyc7e0gI+9Fs1ZD
	 DqrqqGi88VGeokUl/ZPhm2+a1P/ICfsInCYjZsPg9HX3IJ5YxRVCQyY6wt11uLBygJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789152833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3dGnWKocZY/kUY/l7jAuHcNTS+MWSgsBGBpvtkrpjOU=;
	b=d2XhpvxIN94nG7WunRpjZ9cipERJiUzXerKohaoEC+HlM5SQInAd/SJV8UR43bpyMMlv
	 QkiuGY2xGsS+T+QY3ATC4Oe4nu0MQRihD4J2+xIrT3Avm6qtP/MAQ1jB6FR1BcG0B3rgY
	 3EHxbhWJCQ5Jh1y5YC1+PdkGk0HVSquqEZ78A/fMNtBXXD86Ug7qTEsIOoJu1KmmLetVX
	 mPxsKJSBgiIQd0G46ev3b4KJpCLwqyCHv4Pw0o7FBHm/CBnv+e97aEqsyygvNB3sr+MXQ
	 WWRyQNjgbgDx2Yv0VuF9dTo1YGpb+9UbF7c/TZNi6azgjutTcaBHYCyii8K50traUNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789152833;
	bh=3dGnWKocZY/kUY/l7jAuHcNTS+MWSgsBGBpvtkrpjOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yLf60ws9Ahp/EIijK+FihCbK+HAmZuUSftFCJ1nhAU6ssQ4pMwVG1FpHOboNqVvkg
	 l795fBCPmpYLswZCSsPe2e8H+ymB2s8gQ39lbk8e0OR7k/cEa7NZVLfGnlWVeUYrP9
	 LglVeIBJvKxnI7fHaxMk6pufq9T37NZWsguH8tZFtmEIA/3k4ew2xfVUNcz33xQL3X
	 tmvrRUulwzGjMJUqeAuZ5GN6+F6MW85a47Em+2GP89dOkohZmPY/Qkz4P8OCKbP8Kw
	 zqHwccffCG5jJz4yyNrpZsKQ6p3HKE+3Du0UavYYaDH0qa4NLtAkUX34bTA30Dk73D
	 7W3ELhweyjmiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0471960617;
	Fri, 11 Sep 2026 18:53:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A9A72E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A88B407F8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fm8eeyblrSz5 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 31684407F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789152830;
 b=bO4VmPjaJlD93++S8GVzD578jY2A7Z9AXFQAVKme5vovTugh06fs/gHIdte/m9qR3ZKl
 0fALoTz19ywSOjquO0D+98eSuhN9lLFoS1JaviYYJHsvPJLFQhYkICu93kzqDZa4A4KCA
 ZvPKLZ7k6NA31xoVMtDH9Y6hFdg7ogOyS6UcuYZfDG/ufW11ZLp88nuSQ6Hu44cRSA8Fq
 NNKSENz48JlrxQ31zmAM4AHxml8HIFWnZKZPmqzoOfWvnox3HK7NORXoEpxwiPgAm/NEJ
 1wfrYAB9TJeV8vHMGEB7l2OPuoXh4mIeEYnhr0kT/F2s8wHS+Mk/vCIBQnL9mBdmzJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789152830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3dGnWKocZY/kUY/l7jAuHcNTS+MWSgsBGBpvtkrpjOU=;
 b=N/Zkf6s0QDiyY3QdZ68BDWRLuacanClhNvk6wFAsc5OQmjnlqxkke9k4MGFKirZRIp9p
 aFG4f4f2Nui4o00VeP1HCwM0113F+dfvPSpGgUchD/mRsBxHm9EYFlpUUNmGRtlIzdWy8
 CNU1CMWGhH383A1nXIg1Cz65hyGqpEcqdUtT1PVF0exYSJw7U6rl8uiuUW6YjYekljY3F
 QGCHEjk8c6SyWNl+vKctYPphJQBl4yI1ymJ0LNiHOfJ6+owFB/azbZYWHk9a2clIrEdu7
 0jcb3V3zdMC+wOS78QilcxwSeWZh2BWj8TzxhHf824o6bH5mbEvg4Ul1FQ+q2VtZGlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nFTnuJZQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nFTnuJZQ
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31684407F6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:53:49 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4b333de9451so1334108b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789152829; x=1789757629;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3dGnWKocZY/kUY/l7jAuHcNTS+MWSgsBGBpvtkrpjOU=;
 b=nFTnuJZQG386q3eqXyRao7+J/K8vRko/xCu41mMvO+Xer/lh7jDmb4hr2zP/L7x0tJ
 C0GzwBMO+VMCE3uozWqdKVr6Y0QKXl9Va7/Vwt9pAEG73blYDyYiYYS44kwDkh0cQpV2
 5hRFfX/su7yMKqSZHlNLYavlVljykGX0NaSFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789152829; x=1789757629;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3dGnWKocZY/kUY/l7jAuHcNTS+MWSgsBGBpvtkrpjOU=;
 b=WEUGHXD6iUmeUHfZ50XvBDqdtLd+HRhDOrBoztF5vHBCnpLJ5XJm6aS/g2lPw+jxRM
 nB6ZmvjBgxkDwNnqZZZ7sD1LgNqQZL0bGF38RKzMsoEptNDv/9KJmBOkxS87igZHj6yc
 lframM0K/L8wq81pJ31xRcWrlIExEtiVtq+E4L9gUGMhBcjGR4Cd+M/U60IzWthFg627
 xonRBfu7DD5bklNN5zWhU13OxO3gjB7SvSdTQ0aFlj75l4/pcRNP/N7vp/HWYAri62S+
 CHwDi0jkVRrAQN/lS3D0uQ1wju5vjDvR0bmQrjJ3+wl7PjaqkOz2hlADiKPVOPzwoJt2
 d9bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDHhWJNc6o1jQ3DtGfmwXvrgIC9y0Orz0EpJwEDMm4p0IfdNZJDKFJMUnoDpVIYY/5ZbvyqNA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mK2H2t1O5FoZNldxKlVvvWQz91bQS+7Lg4l7+29X/V75jOW8zu
 0LYddX1Iy9poj9nHZHvF/BKwXpulFCkMUP/aTg9IOP3xu2cKl6PhwwCCErtgpC/zyNA=
X-Gm-Gg: AYBFou17zJM8F905HEAbAdkpDEKYVG4pDkDpvDAUcg2IsjRCPGwxL3TPyR+SFIQwAMT
 Ol7drwstCV3vJ+Eq59PS6UxMJi2lkJEquk3iaT/cbaxIa/GauTYOR7FPgtQOXG9VcQvsWcCJkiL
 GLsyqPYtyORJs21l3uVYy8B/TSDDOso3TINOYys8NokeWpdwyXN9FKFaa/oGg4FXjLezSNZBpAT
 2p9BbicMn7/5ZZgSHQeS7sWFxb8x5yTcqjVL6s5GnHFKTYTms481mVnDcY3lN/gmiu4GlSZKzpZ
 Ozg+eEa/LhKSPi6+Oyk426QB+iivVHopFz2FQYvSbENiof+hkAdmxVuswKVD3P5b7rlt7uzaSUB
 qKDVkv4A2i3gA9hx1DKBii/yZOsE1ohKn4tuB9IaxHpgN+vuOwr8/V4cYQE2x3tf6Am2Oxc2lYq
 XYyRZk/SMOGbBq9013uwS1+HInwaZtk1FbJgLzfp4txI4W3T+BDB56zoLzfzDzDVR4VRq/dNzhv
 wJbPOs7O/84zULXj0EexMhiZs9YgEjS8mTCSnMrz0Dmoveg8g4K3IyvD94Ki0q9/uIvio+FeTgb
 TOkR+EZWUzyoAqO7i2UB
X-Received: by 2002:a05:6808:1589:b0:4b9:e6ab:d07c with SMTP id
 5614622812f47-4c31f29b81bmr4399199b6e.28.1789152828687; 
 Fri, 11 Sep 2026 11:53:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32eb4274dsm2878708b6e.1.2026.09.11.11.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 11:53:48 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:53:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: phodina <petr.hodina@protonmail.com>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
Message-ID: <20260911185345.GT1764417@bill-the-cat>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
 <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r4OyBmle4w2mq+s6"
Content-Disposition: inline
In-Reply-To: <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
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


--r4OyBmle4w2mq+s6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 08:46:30PM +0200, Marek Vasut wrote:
> On 9/11/26 8:39 PM, phodina wrote:
> > On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasut@ma=
ilbox.org> wrote:
> >=20
> > > On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> > > > From: Petr Hodina <petr.hodina@protonmail.com>
> > > >=20
> > > > Add a new utility library for parsing command line parameters in
> > > > key=3Dvalue format.
> > > Is this reinventing environment or UPL ?
> > >=20
> >=20
> > The target is a chainloaded environment. In this case u-boot running on=
 Android devices where you unfortunately don't have the possibility to use =
UPL.
> >=20
> > As stated above it's purpose is to simplify the operations on the comma=
nd line arguments from the previous stage and pass them to the next.
> >=20
> > Typical example is to remove the skip initramfs or extract the value fo=
r the panel to pick the right dtb (not part of this patch series)
>=20
> Is this something you could do in an U-Boot script using setexpr sub/gsub
> instead ?

Yes, I would like to see how this gets used in implementation too, as
I'm wondering if we shouldn't just be also saving off something like
"prev_bl_bootargs" and leaving the rest to the board code to deal with.
Maybe we should also add the android-specific helpers in a new file
under an Android-related Kconfig as well.

--=20
Tom

--r4OyBmle4w2mq+s6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqRONQAKCRAr4qD1Cr/k
CpWpAP9EvDecyq6CPZZGoLRTb0447ZSG2O5rBWMSbAnjG/Sz1QEAkbsa4YwcjJlz
ktCmg0wj9GgghsaPur2pGY5llPx2xgI=
=4JK9
-----END PGP SIGNATURE-----

--r4OyBmle4w2mq+s6--
