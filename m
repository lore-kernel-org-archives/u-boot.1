Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F3606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f71e0Sqm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyKW8Qng
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B89F80E1A;
	Sun, 22 Nov 2026 11:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhDGycIIEq_Y; Sun, 22 Nov 2026 11:41:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61B7A80E16
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795347672;
	b=rEGUV2IHeo3ZFWtiV3olX+p8hzpnONFa/5dlCrMzPRU9Cyae2EJDOl5urJm7ma5v00kD
	 DQ/lYohW6uW4lGQDHLPU6udO5zeG0coFsdPtF91RfggjgRyUEQBLOQHd4bhdoEd9QD5hn
	 G5ZVJfLl7VwKz1rvwgNaePLu7J8wubjOkMSe6KlA9rYCC95LxrSfrjD627sSjGWO3JjlF
	 9keesqTzgcGKrK62+gZzntH5H8Fzck6vsnyUXdfI+aqeeEN9zgfanTwQROfd3yBac1rDX
	 GwNADGE6UUKhQv1YGQtv2mmVFQxx63ujo6z+vsI4JDGhTEe6fxWv17aOgDEmEzBfCJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795347672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HhHZsZxw+R8VcasdsyLQAuMh9FgZW2lIab18SWsvZSI=;
	b=SVcq7Vl9Bn6cNPBmGhkMty2ESVxHwVwttcakZPj7WWdjmoWmI7eVp5PqBw+GZVDmjydQ
	 ar8Mbfp7WmnWSFKRPBNQvRt18EKMdCo0n8TnwaRvLIE5ArNiX6xRoIHdaZ2OALp9ADlcU
	 rCxZc/4ILT15hwkaLuQejrVdrDuHS4aKERb8MNL5ylq6vvjNOsonLH2Ke5CiHpZB+RPrq
	 62wJ5wNtubESiPqPs5GiVmjFkgRfgl9Gy/4KwPOaooz9NeVx4UrvgfhVlwmKrZSObIDLh
	 zMJlYwsh/ynYNG02BpoojcLa93AlI/2vl98Ub1nxhyqf+6Qn6IrRDMHrO6lBuTuly9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795347672;
	bh=HhHZsZxw+R8VcasdsyLQAuMh9FgZW2lIab18SWsvZSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f71e0SqmHAizxFZIn9m+hf7n+u6Mr2+6MbuF6vs/uPhZiAZ3TWk+mfrwiBdSMw2aH
	 e06tTecwyTIHzDQ6O4lS/S5ULlnbgtDIMVkHj2axUdIcSGopzt6XcwbhuPX3EjjSeJ
	 Rg7rsaoWq2kvsJchKla3ZoS4HTwXkQXJ42I/d5BIif0GV2fGUnuXQXIZa/+8QewxFI
	 ZntTNCIDrRTXI0uQYoaNSlZ7AQOooff+Tph8wgprFQPJy8VbyDxIoG3P4hm7tlT9mu
	 bxTgmDEiR6aF/Ms+q69NqyG8kRssUc139OXktJwh4UvgbuzFadFFqRsjl7ygSz6xco
	 I/URktUEPmMDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61B7A80E16;
	Sun, 22 Nov 2026 11:41:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B46D260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C9024062D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6cUi0wnJ_rZ for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 11:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06EC84062B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vyKW8Qng
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06EC84062B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:41:09 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3ae417eb235so19647571fa.3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 03:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795347667; x=1795952467;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HhHZsZxw+R8VcasdsyLQAuMh9FgZW2lIab18SWsvZSI=;
 b=vyKW8QngPlzQHjQ5zkVTgzoZ2SW6wQOiC8q4MwRzBBS6q1CE97x+Svcu76/lmBUyOx
 /mpF6NQ9xm4yU1xf2gQE2datY7u/kv+B8QBaDAW1HVO5ywEioppjrLDXljC3cYTojtEW
 x+9Xuuoq6eL2r5igPPinunVunEMDONAGPtCIOyffIfvS/q2nNvW3iSAfMVaIJqaqbHe9
 fZdDuhBXu4SJT5U3rxrxxkX3LyBVxJsZqFXyWgkS3VlQTZSiwlegACdkbTEUgdUy9DJE
 kDZVF+K3uZnVOtAm1qB+NR7p2dl1bmimWyWjeqMvMSO2fDbQJxPv0TYHAksowi/J/aZ8
 iDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795347667; x=1795952467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HhHZsZxw+R8VcasdsyLQAuMh9FgZW2lIab18SWsvZSI=;
 b=zgwdK3BK9mADfw4uoCkRv6zVzMTrt5OZu6W655XHZR+ICtdGK3O9sfTodjx7AJlHOf
 gf73yx0DsT6Ce1wdZFax3uwvkyXJhpXQjJJeKRUECtSaO8vOfLIa6zG9QhJDobxw4+QQ
 BuJZ6FOFldemwLNpRLUMQdjweHT9ABv6ByItTqPIgc4vzqF6XnYYJRQ5rp5g+gDBAB3S
 AlokV+jbpn8k6TwlSHjSyUQoTnKA38IJdEVqRFfC05NJwyMRlIkWLvTWM2B1jlv7NQT8
 jifSm08FuNbz6Nfgh+pNYXHdqZtVvLdI/Q38o/Mb1xDYIG/KFbrRBkCsyCTSGERhGPwI
 NpVw==
X-Gm-Message-State: APuU4Z/8Dz6gESUnI1I9TadUCByvJs6+CVAk8IwoIpIkdgi/9oyLZCf8
 5H8/Y5DEGj6PNTQ0r1bcCvcF+lX+B+j785QOT0torMFLLZaGYwXxg3sTzV2iIuEL3Cv8A9J5uGu
 hBk6l31veTqA6eBQruk2iwkiKeh2SlOU=
X-Gm-Gg: AZFdTZfs0AuSLiT00kr8FK8Ggd5SqAf+37VKUf/vY8bYuSk4XVDN53qu+TJRR4juZjo
 yKYbm4A4Am9a/cFS7041P6DlnMhCzhLJUqw1uJJ2iLgt74BmgBIS59Mekc5M6iJRT44NW19258M
 qUvuXdX1m67pOfhSBzxEy2avy/ZPpaNQkFTtp1HBvH17Z6ISPbSglW9vdc0RXJ/ZPJPc0Blv6Kn
 WcqcWV5mh7Nf1pn4sh/VJNbfievVUytSaJp3+oSBAQmvXR+VGWHC/MeyMhkTi4dm864fWuyMCtF
 zBAjFgjILt5r+TKaSO8OPL3VAmxDKMv0wmlPsuyEnba+v/3//16fwIym7A31isuLmGsfsonuboq
 t7+TGzT0uS3X1+i1CUM0igSGHma+aki8VE8PeQ9Uz3z0j052Vzw0nDHWh3R/nWTjHV3mxui2GaO
 82+v/8j3VslJqh7l7sa8GHTIqwyA==
X-Received: by 2002:a05:6512:340f:b0:5bb:7c8e:15b2 with SMTP id
 2adb3069b0e04-5c1bc7d2e17mr2217094e87.31.1795347667208; Sun, 22 Nov 2026
 03:41:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
 <20261114-91qsb-v1-2-046293559467@nxp.com>
In-Reply-To: <20261114-91qsb-v1-2-046293559467@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Nov 2026 08:40:55 -0300
X-Gm-Features: Aa3M54puRG6BoryNfNMfr-N1_7Apgz8_XGRCh7fWxqCJrKhgpJQZ9dPDdVsdmRw
Message-ID: <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>,
 Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alice,

On Sat, Nov 14, 2026 at 1:36=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Joy Zou <joy.zou@nxp.com>
>
> Add the U-Boot specific device tree overlay for the i.MX91 9x9 Quick
> Start Board.

Why are all these properties U-Boot specific?

It seems they can be part of the mainline Linux DTS.

Please explain.
