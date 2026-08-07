Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D038C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1555F60A4E;
	Fri,  7 Aug 2026 11:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8u_6TYS-B4z; Fri,  7 Aug 2026 11:50:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 301F360909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786103411;
	bh=dnWdUBUgn12xAo71syhUVspzkaniGP7H9jp3Kw4dOfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XAClaDFs5aMUIwqVHvMb5A/nEwQY2fNt3fJ35J1Rj1sH1R68UXZQLPl0SUs1HGmfg
	 oKh2uQq0I4LufosfpgojNF4QdP4nhxnxdo7zcqcf6JQfX3z1t9q6Fpc2190sfd8h2A
	 81K+dnFYgrc7/UXueEVbVCURrFti1XernRkzHgzf3eJ6Y07kwTLVN3aXTHmTSkJSc1
	 OFvztjRgOKexslZHT0N9GK/3q5jcgFv8JPokx1G7PFuzg3DkznamLXGPkA3KjrSvtb
	 amILi3owAXvwZCctqfHKK6fuw6eA+Zak1OwM83iSSS5EEIGUFMxzt9pqdfiRZL8s//
	 /55stVVONtY/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 301F360909;
	Fri,  7 Aug 2026 11:50:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0388F259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0121260909
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecnFwRhdHx7A for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:50:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1554560905
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1554560905
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1554560905
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:50:08 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ecf499af9so48142887b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786103408; cv=none;
 d=google.com; s=arc-20260327;
 b=rKD7//3rCBviLhaS3QZ8Cg441uCvhflaa+9wpRYVgLTBPCjzF06GODdc4ksBmyBFnA
 +KEWtZcCgSvWgk0v2+yRjQaFmd9cLVKX3W2K19o7h+PYxawpK3YEDAsTIUYdMoUC74w8
 nXaYQYXUMnbrNvNd4G/xbv5MPeKwVHhSjbL6Y47q33rG5M1+wx729MyJeVq/1EQ1MIg9
 H81rjJpqhqyeketAu5DziG5Wj21niR/AfMUStOu9lQlII/3sgRANj6lSBnUgBA9/3s1+
 SBdFV53SrDPuu4d+7Onnhb1Jzve9j9Kx1k5Ct3UIlf//ByDUz/1UT/korzFIJuCaVce9
 TmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dnWdUBUgn12xAo71syhUVspzkaniGP7H9jp3Kw4dOfI=;
 fh=t9Hv7oJRwgNGFWMpOy6ztfryJPxqO4p5/Nq4rEjoHwQ=;
 b=n3M1GE5KEscvYNSP2AFgWKFHJv6KRLIICTkDzeUVR61Y6oVMoxcYGOiXKgV9nN5el9
 cDzkXSiz501I75acl6uzJYBcq78J/QRM0xn5NAyM7Aqj3l8ZPiUkkdOMr0eyMMKTQblx
 5IIOnRUYQwLn06biOVuxuDYMbg+UT/Lq+xu7Nm8Vis62p8elDethsrkWLNMTtO4Rkqkc
 83VINq2jm98+Hezm90mDAA1BjV01PCphd8RdTY023sjZ0oL16OZ6+4QPn9Cul69fmNLQ
 ju1KJCIPBjr0EEoN9Xyh3yal7LZ6WzYlyd7RHohY/3pOZJOHBm/zCxaVyAD4IIQW3mv7
 cEXw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786103408; x=1786708208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dnWdUBUgn12xAo71syhUVspzkaniGP7H9jp3Kw4dOfI=;
 b=miQYNO8sPHMEgCTbQgXOUvBwxlk/cpStG/waUVxRFWOZixOeC5QxL/GZsYAclYOx28
 L+w/KoBsu+lTUJPypjDD8RqVOXzLfWC+6qReBtfc7b2Py9Q2Sj+gfrgzMuA65TrpT1eL
 vk8+xE4CyKSlP8QcRpZpN9PQVLevM95VKcZQy+pTiJfoT8/7D56rB1yykmKzGjReTMw1
 4EuZSHIJRgI6bH8DZujyGDySkLNfKb/nK/cLFgbV+CdNvL8gM2hVlNgBITKP/k7gbHkt
 O+LgL0rcOz8rWDINBhFp67hhhgPFTy0e3YBLBdy1cc1U9jxKa6AXrs2AYYjjcweBj0Jx
 iaSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkHN95nheA7s8uxdJc4lkJ910cH1+BfK9qMnch/1NbDeAR+GSKN2IgMZgod/0NNJBwcVYmJ2g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxlK4IwY1r5ubgWcx4HZu+0jcaev06VaNKdm3rgmnD9QpIihuZj
 jrQau5yiTtUwXtbXNFGV3e1e1k8+8EK+bNYaGvPwa8itI/XwmtEJNLTjOZiaAqTxQpWeX40p1ZV
 831AcYZ2kzdZhRHLBTUCQa1qYcoyUx6Y=
X-Gm-Gg: AR+sD10WF3US06JtH5rAA0MOux85RLPY9LjaWRUSgcbBB2sk93KFEkDKu/V2ueySMoH
 UZ92kPWV4QOl1jwchzWCCiTvlVZyvQVUiiwNx8IyezIaAlf2uNvSkxut0tlXse1gVsKjY3VpwAQ
 r+0JQYtxEx18WZ1dRbJd3mk2byj8mD75Ck7jKr9b7bMzhil7grqdBojYOicJcuC0a+4KE3ILYsZ
 OhRia+dI2gkTuNjVdoayaYFVqq6PzHrJkbSnkiyECMpvy5LXnx8KDn4ziacmUum4qvUca7vr5kD
 0YGzmz5cO8pIZ+SJTxWRGZDVX4XgA9CKLVFFpHYHqAVRmHOm1rOCUAA5Dg1awlunq7z9THrFEXW
 BO7qcffq0/BX/fcdHX7cKovUyesoAf9+g
X-Received: by 2002:a05:690c:6b12:b0:81e:8112:c5c9 with SMTP id
 00721157ae682-8201bc85c8amr140604177b3.3.1786103407825; Fri, 07 Aug 2026
 04:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
 <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
 <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
 <4024d372-29c2-4c6d-8185-9b97fe27f91d@nxp.com>
 <CAOMZO5AuKP+DQfSCWNRxuzPJJpK2vz9DJFHxf5J2FQi0u18=2Q@mail.gmail.com>
 <e11a94e7-b0d7-4570-bce7-8dce51d426e9@nxp.com>
In-Reply-To: <e11a94e7-b0d7-4570-bce7-8dce51d426e9@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 7 Aug 2026 08:49:54 -0300
X-Gm-Features: AUfX_mzY2dMpWc0UKwXnou6VbixHhZH2yFmkhhc01ChdONKRRjTKGbGri7uIvFY
Message-ID: <CAOMZO5BmmyvikMqOFLGPw26uu+tiR5z8xzLRPMqt4we9xNfq0Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786103408; x=1786708208;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dnWdUBUgn12xAo71syhUVspzkaniGP7H9jp3Kw4dOfI=;
 b=K6x6UIZictQjmjjbVQJmyGQTe7sIYELOwQLDQty0R/vJRtLns5mxq1EZKLqCKfLVHN
 2JCo0Ubai+lVxtNYDUYYvmKj6ZXomJAWvpMr0H0tjccEji6GJ5tO0R6zZ3C/G3i2PKw1
 5ODhc+eKAW8C8d6qNdKxlKn+fT/uFYIj5KqeFgl3sx9Obe/WOUpCUkDhK4kco2Q0xkc8
 b4IBRQJ1pIyH5zq0eOQ/8rttqLsHgLBgJdQIHPTZkuOHkm7/QDKXFknrff4P/mB/8Stk
 NUEPbswmGnjiafCiwwwzLdn6Y8/sU4gEN3AKzviL+tAxlWWDf1Wk7JTUEl8r/4/NwmVh
 NTRA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=K6x6UIZi
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Joseph,

On Thu, Aug 6, 2026 at 6:43=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wrot=
e:

> Hi Fabio,
>
> Thanks for the suggestion to make the U-Boot driver honor `linux,pci-doma=
in =3D <N>;` the way Linux does.
>
> I looked into implementing this, but I don't think it is the right fit fo=
r U-Boot, for the following reasons:
>
> 1. `linux,pci-domain` and U-Boot bus numbering solve different problems. =
In Linux, `linux,pci-domain` assigns a *PCI domain* (segment) number; it do=
es not control the order in which host bridges are probed or the Linux bus =
numbers. U-Boot's driver model has no concept of PCI domains/segments =E2=
=80=94 a PCI controller is identified only by its DM sequence number, which=
 doubles as the root bus number. So there is no existing field to map `linu=
x,pci-domain` onto; honoring it would mean overloading the DM sequence numb=
er with domain semantics.
>
> 2. Making U-Boot consume `linux,pci-domain` requires overriding the DM se=
quence number in a non-obvious way. The DM sequence number is normally assi=
gned during the bind phase (from `/aliases`), and the only way to make a co=
ntroller pick up the domain value is to overwrite `dev->seq_` later in `of_=
to_plat()`. This is fragile: it silently reinterprets a Linux-specific prop=
erty as a U-Boot core-behavior knob, it interacts with the `pci` alias mech=
anism in ways that are easy to get wrong, and it changes the enumeration/li=
sting order for *every* PCI platform, not just i.MX95. The regression surfa=
ce (e.g. the `pci` command's bus-walk stopping at the first link-down root =
complex) is larger than the problem being solved.
>
> 3. The pci aliases are the documented [1], portable U-Boot mechanism for =
exactly this. U-Boot already defines pci<N> aliases as the canonical way to=
 fix PCI controller sequence numbers (DM_UC_FLAG_SEQ_ALIAS), and other boar=
ds use them for the same purpose. Keeping the aliases in the board -u-boot.=
dtsi is consistent with U-Boot conventions and does not touch the upstream =
kernel DTS.
>
> If you main concern is keeping the U-boot DTS sync with the upstream. I c=
an upstream the pci aliases. These aliases only influence U-Boot's DM seque=
nce numbering; Linux ignores `pci` aliases for PCI enumeration and bus numb=
ering, so adding them upstream is functionally a no-op for the kernel.
>
> [1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#de=
vice-sequence-numbers

Ok, I applied your patch as is.
