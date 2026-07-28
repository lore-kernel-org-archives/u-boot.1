Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80994C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 14:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C69B608CA;
	Tue, 28 Jul 2026 14:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLjLRWxotrWY; Tue, 28 Jul 2026 14:09:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 042196089B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785247760;
	bh=D80oo2PkEwRgl0XeoXickzbHjyIfy2qig+SwsvjDAU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NUCqOrAOSpHhx0GY3O3ltchl/sKeCrO3fKBQvo3rBIXtPJGSw3p9mOVRlyx/Je7OB
	 k2f5dfrCzXiuUCJHAZGW18aVCBboNlClOB10N3k1Txh1HZE3a+Fe4A+C6APOXYVVTK
	 Acp+4/Un+Ka81A83Cx8dHtt25sJWo/gflAmLO+H6/wmq3hx1a681xIPmQ1P9TZkg+W
	 bl4FszIkGLcZuBvRnEQsk3SSG0Pj5IpV9dwCFGJqoxr4ji6HdYDE5apwfO73kjHvXn
	 lnZdZKzK++tSQDrGW+IkrekgN0b69hIVODc9wqxYa8kA0CcaM5pEcM+ZKt7sxAdGsg
	 4dR8Jbe3hWYQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 042196089B;
	Tue, 28 Jul 2026 14:09:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF88423F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1A214031D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chRtzQuYiGqY for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 14:09:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B6A464011D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6A464011D
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6A464011D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:09:17 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5aeb2bc82ccso3847713e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247755; cv=none;
 d=google.com; s=arc-20260327;
 b=LwsP1HWPQGXblxU/RMqrOUMAUctIKpSYM2WhVjcoY8znM5K3MyykGAlt9LY0B2XHbd
 TZyzeU3wOKws0tJC89VHTgdkQcJSTSARW2zdXxCidlNDMR+eljT+bEs/jGLfQzyqeZxw
 B66Holxulsd/YdIXtJgJunqJUE0rc8XSMQ5lroLD0UvBrdzMZk1Lqi+QVE9n4STYuSOP
 Mct6egavHZ4bG5r/2jZnT67fuJznh5Fcwi9sTlVbdsrdYYwoMzb6r1TfsOeTYO4ECzU+
 iSHuI9UTMlpvG9pVS/X0uoiLeUXRaoaAunoRpVewXOisFIB2UjY318G5DdSm6b8j30Nw
 8T6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D80oo2PkEwRgl0XeoXickzbHjyIfy2qig+SwsvjDAU4=;
 fh=aGKUbroJdazhS886R3CJn3pL3zXQycL7WlaNn40JDjE=;
 b=N6ZsVFbDxSQdsozlDNf6tbZSElzqbjjQp4BLGxfwAn7iQSL6u1cuEyddKK56/p59pd
 7Gl9OkyGzuaLbMliAePRwxFGXUfOGvmX8sMwdRMOOnTR7r/7eSfVf6kakD4JdMgbIiZj
 aBeHC5Hvp6aU0QHO8QDDEZUlwwSyZ6QbNsgbHrC3SZ6xelodPhZ3lIXC+z3wy6Bg7BeE
 d+d3MB4lilb93zNfg8f4DjCfkm3F8QBVKAH+G6YmNznnvhcrkrGa6sPLfLbM1aDdZzdg
 3QnTT1H1xPJHyEFRRvhMktCL3/SbC9uJqOsDHlLggmpwIG3PjE2z9Y3z7o24OeTVzPBm
 tIvQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247755; x=1785852555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D80oo2PkEwRgl0XeoXickzbHjyIfy2qig+SwsvjDAU4=;
 b=cCNtfhiutJnKFTpS0MSfTUfw/XqHy2xKKVgVY3ZY7TZ9mF94OfaYge2AMwQXpLEG+S
 /U1HxN4nhj7kCCiC/Um2oDPlLeQXcDcURAYIGoTsKZwJ6snBxO9cvEBXo9wW2d4tE5dk
 oF4fCdgcE+ihNp/q99fZ3VrvxudX0dLysyXcPmrR9+RhHe92ycPzjmWaDte5jWmCp4n1
 /Ms9yYoJa56qnUO23iKtvAGXtqGV3kPLXCDf+Kkki1pTFxl2G/e7KM5jjylEniGy484j
 6tAM20P1NKokzqXAsLy73JIUv30/2URJm9d8039mXBsAGV8JPJxDmmNlQQiD12maa6Jq
 3VoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkJEmilirm7BIvBm5ZZiS/7LIGoiclQ0Uxt9Cdot1DsMz3+3EIocZEkMWQVlWl1hiGjXP1GXg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzUUk/bbK9Et0Kq+eMaY/9Xs5ivnSJAGGtIuBBMFy4NRG8NqOI4
 vm6kszHfak/z8nOn2Z2Ox5tSlc3GAm2tVG+O/RlPQtnZeQjAO09O4aBT3aSa7NWEqZo4xajJhhz
 FEUSlDD1Xdb2N+Da7gwBoqcnfG+U3wcg=
X-Gm-Gg: AR+sD13mViUxbp+yb/Dx99ID1vcODIX4cbvScQ8ww4PWRQp7299V99TUKpdYfnjOaSt
 n3XLZ80Sp4uUL+g3R1CjwVW1jmQEVtngrrzUIthnCucqOOsQ/KPhB3+EUaEoS6RKqZcHZPyL4n6
 h5PwAmMF9qrjZiddq3KvaO8Y67qoNGt0yNXoBEmUGY7S3A1B4sFWZqvyWkWjuMj8ddjlOfnvV5j
 GJz3oN/bKhetuV6tHHPUhaFuK2LjLPdIHAYZ/a85G4eA5QaKVs0+mJxXs2xqB2v/7dLRP3/6gR0
 hO6HGUrD6mxgrI/s4qqT6rZzDvQjr4qERHWFkFGTzLnbVxeXrcg=
X-Received: by 2002:a05:6512:10d2:b0:5b1:5d7f:84d8 with SMTP id
 2adb3069b0e04-5b2d0267510mr501370e87.46.1785247755033; Tue, 28 Jul 2026
 07:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
In-Reply-To: <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Jul 2026 11:09:01 -0300
X-Gm-Features: AUfX_mzR4tp2uF8OnR2LjmMGxmnaAszAqWnp2yLDww2ejuiZtPRx5eXXTzxUwIs
Message-ID: <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
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
 d=gmail.com; s=20251104; t=1785247755; x=1785852555;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D80oo2PkEwRgl0XeoXickzbHjyIfy2qig+SwsvjDAU4=;
 b=rTqQQ9Dnf6f5C6uM+oq54Uj6DQdFnkE56Eu3TQ/9s+GDc6zIC/67OgvsFh3plQR2re
 qDFODeghKJqmrrvHyDtk3Jo5ZBljFdgbfz7sbWOXbnoVKWdRfrfJ4jXxtNAXvsn3g+uy
 ofRM7zATKOQpwHE4HLC5FX1qbb9kThTY4WnIF68gFRE9oeboh4AGKiTaBMaTvLeeTGkO
 gqdSLDM9ESRHujoDI59Hge6qGOY/EIYiPXecxRUSmaLH000fSOjUjSB07sDuKqnDaf6d
 b/CgyjZeayaUTdlw1urVT3oeyxeGQeBtTuQHHOwnDrn4cPCOy1mzD0hyUWP/YpGP9qVv
 IRyQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rTqQQ9Dn
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

On Mon, Jul 27, 2026 at 3:07=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> Sure I understand the bootph- properties are accepted upstream. I'm happy=
 to upstream them.
> I prefer to keep the alias into u-boot.dtsi because only u-boot read that=
 alias to assgin the fixed sequence to netc PCI host controller. It is no n=
eeded by kernel.
> Is it okay for you?

I accept the u-boot.dtsi changes, but please send them upstream.

The aliases node can also be upstreamed. There is no reason for Linux
and U-Boot dts to deviate on this area,
