Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FCC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0E8780E16;
	Wed, 23 Sep 2026 11:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ll7koF_6O0LK; Wed, 23 Sep 2026 11:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8CB480C7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790162504;
	b=AU++ne6hYMX0Dj8HdAvh8vzXre/MmnQHTFq2MDTIZUQmBU4fDoCYP9Asc7at4uUACI5Z
	 YI3hLglTRCc0RX7IhNINPGYLs3fozGgShUZ6RGpjTihnrxndscYi41+Alo129o+iiDI/6
	 QWc4g9I0+c+9ZLa1hGji+H2VvkZ0/17e683/PN2qOMlvB+aycKmhOakheXFyIrdjqcUrk
	 0gZuTZMv3BTg30YZrs3TP+t5sMp3tq1ANN1OTtgWWKHM3JN/yV943HQzgA/htOdWTi1T1
	 jIxZTTwF4fNW3jHq6XpXz/SWthes35fuXqX1d8INHmGCyEhtf18G/CuFyuiFv2xJnQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790162504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
	b=B2Cv5b3Gl5pfj773nMNXhl/QIbLcKhy1cUgqmQ4G8rrDMmZY6OAXDwOpbC/dPak4GSP2
	 8QXmfzbBb/rmyM6EHxrKNSfkSDrkPB+VrleLducikYqUWvrUZyy2rZK5+WtBypgOVIbQA
	 QtX3eWtjw3fYNnOyleea25NYmrNzOkCwBpabdpYTXX2FwWmnLfDmdDezV4asm+bStExU9
	 B4qks008woejXG7+uvu6CbVKivIHvzbb0PZvRCP7NztWx2Lu4881JAtqeMWbPjfmrdrph
	 iTrTHFsyrSduC3tezUzdCrnEMsND+nOdpNJflrZXnP1Up935lxCKnBueQWNIJKlrXNQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=TVMex1h5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790162504;
	bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q6Jga3teHKkf77eogposYQ2qhI7gaDFT5WjBhM1q+R4+wD6Fu0WWHyNkmZ1zPiKIX
	 XtYJjOjBqBg3Xx0m3xUAe+sPp/MawH+f64pXwoGcW57a2gmJPW1PfUtRyqWOCLuB4t
	 5FwMG1gszcyZpoEbeVtDrWusNzUhCX8Pa7fCawqnyb8DjPN0AebUPvTC+7xU+rXY4+
	 LKmQesQjSKJHgXCazqSSMklICvvsG+c+FPbu3oVkxid27CysIIXzGpr0tR86h4/Mze
	 3crXXrFCGSOcaAFxpW7zBo0V1uuoRW0l5x5UZAJ0TmnE3aefw5oJjVN68ayjw38Ye0
	 trumgdw4yXlzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8CB480C7B;
	Wed, 23 Sep 2026 11:21:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BD9B35A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51CC780D96
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIgRz-FvKtnI for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 07:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B4B0980D89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790146836;
 b=UDL5dJm/GrrfmXfNFUA5OHSOYsJtuh+05D4jMXUPVlrMGErsUowV7lL7SPOIE4OSj4f2
 JqyCpk9vteZFeAWuOBlmDTTou7VGdYYxeJNDfZKoB7NY5PP7BSPcLYSQVwKfQdkaVIsAA
 xrRA5CGCuCJjiuXkx05dY/2/97WD9TTjFajf26pXK7uM1PKeZQAZgomsrnZ2/RfA19kc7
 NirZVTspM6RklGcOHRAVu1RK3yus0iNLPiZ4QQlIPEzT9qQSqSq8y6OKNVnJbogh3janX
 NfTF+ChG8eTmqjGJ3hwrzmmPf+EV6w9sF5/hKCNWjrUoZpgZRobMr20HorbzMK/OEZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790146836;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
 b=DhAy8CSoVmO2mr1e9TWIV5WmZflB7V6ussCTjQOUGfn0Q9HbaEWDCn3p6iIXI59jUFY+
 AaZNq4dZwKtC016T3SlA3MUUVJCiknAAsQizPADaK7NpjN/0Q2NzHtetuI6xG544qG78+
 403do67cpbqntbR4cvJHp5mrIgzD/iGq4/Y5ITk4Nid+XcQUJa6cNDHXH+cvCiCTDNMzM
 lptxKWRYfHZ/OvOfK2NuYXwaeKd3RaEOwvKvNXaD6au71Z7NFKLWiAoYSm3wwInE8pEQH
 VPvHcLQtIDZtYWRrV6lAoGrdCntiskSXivmfiHkGNo+pKMz8vsiNYqVeRRKIGPKmDog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=TVMex1h5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TVMex1h5
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4B0980D89
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:00:31 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0CB503F323
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790146829;
 bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=TVMex1h5L7HbgTDt6MHnV/CN6z3TMY8tIePzubI8uuLtxD9b7gfM77UB8SPDHrF+h
 4fXn0sQpgFhpkzS5OXecZyNdR0xw5FADLI83c6t6objaSEKpflVw9XHOiKcZzkPaFJ
 aslKAeE5pdeG9rqlOIVqiiW6gc8+xtLpaAE9IIn3r48aL7Z4+2TtVrjnvCHZ/2YXYK
 XtLq/gIAIfyZJvBCBai/A423tafs3bpN0/OmLdgKSOjyeSHEF2LcVlZnFiYOY7Fcwa
 h/hHMLBmgb1PnLuukiVSeXFCQASDFQMYg26u0DXARybzpnbGyUCeG6B1t+e5F7Vumb
 E4SJDoMp/ElrVfmhQnAVZIJxrmK6cJQZjfT3X8P1W5Ajvra70K0/f2Wylq2Bjx/frq
 ys/NyW1fqZ1OhtYk+EPuHdDQBu3VNga5oHXRpDhYHx7qlNPEwoK5pgoRq18huzx8Al
 5rrhZ/rcBb6C84+vTKplbOu15vBh5c/uze9kp06sdMozS8q/iVtbkT7/Xj1UIFttDi
 v9EcS6qcAo/tgmxmdbVAIdHWPi+IYCYz8neXC03b74CHUS9VpdxJeoC3fwZNHOjRUY
 9g0KCaUNcfEoZYJ4Yf4ULrd/hK69M/wFYQE0q04DI8kccXMx5MdPPPZRLVlXT2M5i7
 KJJpjKhB20xaBA3lbG/g/Vwg=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a64cb77b0aso695927a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 00:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790146828; cv=none;
 d=google.com; s=arc-20260327;
 b=K1e0ikKtkyb4OdY+UpkxphEs0dm2wCY1jiU3k+zt+XN1lhVU08q47vEF5Fz4kpXH6l
 z3iMwTsWlsOor735bxglUbNS46BL/ahC7BNM7Ot8UrmN35JUCJZYgTvPwvA3WZ3YkhwL
 SzuRLH+r3QWd5soQ74Hwg1xVfpMc4ePW3eSsYItTwDJaQax6cl696x8cLy4jMO+rPrrs
 3PQ9n3UcLAiza3q7d7giC1Rdn/PnR+DDzKsJaArQx4Jtc+AP6wzYyJIurmz1YQQ57bS5
 VOwK7WcgeTP/DuafA2jMIJTSa20rT05QeGA+00wqqgU9JnKKOT3bDapgUBYNG9tMlPHO
 4+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
 fh=Gi4D60aOXzJZYHBigtrUTRbCehIM3Nt2iHcqzCyb+SU=;
 b=W24Ytal68eonBfJiThfCOnNipFuImETuNU5W4bW2jb+y3CeKx+Ii342TOUMfrJ/ssc
 uQK7gqBwh6bxZVkSdutXf4/CPYN7RzTfDR0BQe6yKXQudqxN8W8emMJldrPk5An+0tcE
 8rDS0/9kHBxR82Mi/EzOgyfJFG9iikzmd1Yf9IKpBU3ZlYjfOwy+0uBMeXKe8Y0YDFWI
 PYfmh+4T3Efux0XcfkicNqzYslT26smg/si7b6V+iBhgNK4sx58twDOWpWhV3g5YU5xu
 7sQKowLqsS7FsuMk3zi5Vy/5hRIpMe0ygQ5RD/2+K28H4NwOt3JKKDkUkRMHzNa6J9bT
 zLgA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790146828; x=1790751628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLrjgz/BiKrlh9pcsdlW5CIgcnstULmXNdZRixMB/Zw=;
 b=Yoy6h+7Hq5LPTAKZ9mE2EbG+4n8cpelxYwxZTsOCawikEBt6AnoB1qfiLanxYLWWWg
 GSSOwQVlPGBimG/FxOx3AKU6v5xlh6EjsydW9+88cQkvlBzAbK+0QonOFiF1JW90dwtn
 kvFoO+qDguBJ2XFuICGrfTiUYfutqaqrEbtPYseDoBQR0MDwYlgVQdaxqzLlYE1cSCzt
 URdcrtP/FhlT6MFhoN3gcz32TKhlOTuHGE7KyvIXUViWhWm+R9GABb6XmRlhLqw0RzIn
 BXp/vl88iEr9WOLZqSME3l/R+58W0F7CUpJ7QpMPwa5TT7jQNJGvozYVHmqPAUr71Mpm
 joXw==
X-Gm-Message-State: AFuF++lhoetO4PrgN7hZlzBhukeZDe64Ay3pGnl5cPbKi3WCXx5dxmIh
 YiyTh7Jh/U3CuRQcpucn7p0r+n1PEbUqDq4Dv0EQak2i8k2X2uQJ5lDSzRc5E026ym0wE3bi+sH
 3jlU+azy4WreXHuE3bFr3RjVv59zIhqmBRBfI+HAwQHPtqodIWiu5n+BjOCmY7ztyoomqh/hXhm
 s2qT6KbZ7Ds80CFpsZJuT1SmHqwSjvA+t9okplVLvSRPOyQ7oWgypz3QbX9ty1
X-Gm-Gg: AYBFou24FOiKU5qAd7WmwbnNGf5QdRM+WzySl6yQp6qqi9KMXjIpCTQS8KP0t08pfoL
 q9XNH4bTpCu4UAcq1X9woHVrRKxvjKQtLXS5IU33gNjlH7NOtUzF/WMpXgMnKM25aN6hLmsVvGM
 R9C/MLoNKMzmNvQDTeoao1ZXQzOu6jlPDJ6c8YrgAs/8UZcXcG/QK4SPdlyw==
X-Received: by 2002:a05:6402:2747:b0:6aa:b382:8475 with SMTP id
 4fb4d7f45d1cf-6aab3b1008dmr1360065a12.16.1790146828085; 
 Wed, 23 Sep 2026 00:00:28 -0700 (PDT)
X-Received: by 2002:a05:6402:2747:b0:6aa:b382:8475 with SMTP id
 4fb4d7f45d1cf-6aab3b1008dmr1359979a12.16.1790146825940; Wed, 23 Sep 2026
 00:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260831142800.25966-1-aristo.chen@canonical.com>
 <20260831142800.25966-3-aristo.chen@canonical.com>
 <CAFLszTj0H71E8K8mJS_Oc6dtvPTeQT9m_7A++91XL_H=SkV3hQ@mail.gmail.com>
In-Reply-To: <CAFLszTj0H71E8K8mJS_Oc6dtvPTeQT9m_7A++91XL_H=SkV3hQ@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Wed, 23 Sep 2026 15:00:14 +0800
X-Gm-Features: AclHuK-etAzqr1e-FmnIk0SklQUmwBT62KDodGJPPL05JANSMLklwyOsTsvTYx4
Message-ID: <CAA=k7=mn25hODFV2OPu0t7=dArdXDv0FYUug5-RoEr6_zBLw5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: boot: Check that rauc rejects over-long slot
 names
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Martin Schwan <m.schwan@phytec.de>, Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 23 Sep 2026 11:21:43 +0000
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

Hi Simon,

On Sat, Sep 19, 2026 at 4:45=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On 2026-08-31T14:25:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> > test: boot: Check that rauc rejects over-long slot names
> >
> > Boot the RAUC bootflow after setting BOOT_ORDER to a 33-character slot
> > name, one more than fits the "BOOT_<slot>_LEFT" env-var name buffer. Th=
e
> > boot must now fail with -ENAMETOOLONG.
> >
> > Before the previous commit the name overflowed the stack buffer; as no
> > such variable exists the boot then failed with -ENOENT, hiding the
> > overflow.
> >
> > Also check the accepted side of the boundary: a 32-character name, the
> > longest that fits, must pass the length check and fail only with -ENOEN=
T
> > because its BOOT_<slot>_LEFT variable does not exist.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > test/boot/bootflow.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
>
> Since the boundary is boot_left_name(), please exercise the scan path
> too - distro_rauc_read_bootflow() calls it against
> CONFIG_BOOTMETH_RAUC_BOOT_ORDER, which is what a user is most likely
> to hit. The current test only reaches find_active_slot() via
> BOOT_ORDER at boot time.

During a scan the only names that reach boot_left_name() are the entries
of CONFIG_BOOTMETH_RAUC_BOOT_ORDER, a compile-time string ("A B" on
sandbox). The BOOT_ORDER entries seen at scan time go through get_slot()
in distro_rauc_scan_parts() instead, which marks the bootflow invalid
when a name does not match a configured slot, so no env-var name is
built from them. The test cannot change the Kconfig value at run time,
so covering the rejecting side of the scan path would need either a
dedicated sandbox configuration (which would require adapting or
excluding the existing rauc test, since the bootflow becomes invalid)
or a test hook that lets the scan path take an alternate default
order. The scan path's normal accepted-input case is exercised by every
scan in bootflow_rauc(), and it goes through the same helper the
boot-time test drives across the 32/33-char boundary. If you still
want the rejecting Kconfig scan path covered, I can add a dedicated
test configuration, although that seems disproportionate for this fix.

>
> > +     /*
> > +      * A 32-char slot name is the longest that fits. It must pass the
> > +      * length check and fail only because BOOT_<slot>_LEFT does not e=
xist.
> > +      */
> > +     ut_assertok(env_set("BOOT_ORDER", "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=
BB"));
> > +     ut_asserteq(1, run_command("bootflow boot", 0));
> > +     ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' wit=
h rauc");
> > +     ut_assert_nextline("Boot failed (err=3D%d)", -ENOENT);
> > +     ut_assert_console_end();
>
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > @@ -1520,6 +1520,29 @@ static int bootstd_images(struct unit_test_state=
 *uts)
> >       ptr =3D map_sysmem(img->addr, 0);
> >       ut_asserteq_strn("BOOT_IMAGE=3D/vmlinuz-5.15.0-121-generic root=
=3D", ptr);
> >
> > +     /*
> > +      * Boot with a BOOT_ORDER slot name (33 chars) that is too long f=
or the
> > +      * "BOOT_<slot>_LEFT" env-var name buffer. It must be rejected ra=
ther
> > +      * than overflow the stack.
> > +      */
> > +     ut_assertok(run_command("bootflow select 0", 0));
> > +     ut_assert_console_end();
> > +     ut_assertok(env_set("BOOT_ORDER", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAA B"));
> > +     ut_asserteq(1, run_command("bootflow boot", 0));
> > +     ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' wit=
h rauc");
> > +     ut_assert_nextline("Boot failed (err=3D%d)", -ENAMETOOLONG);
> > +     ut_assert_console_end();
>
> This is in the wrong function. bootstd_images() scans
> mmc2/mmc1/mmc4/mmc5 and produces the four extlinux/script/cros
> bootflows listed just above; it never binds bootmeth_rauc or enables
> mmc10, so 'bootflow select 0' picks mmc1.bootdev.part_1 (extlinux_cfg)
> and the expected "** Booting bootflow 'mmc10.bootdev.whole' with rauc"
> line never appears. Please extend bootflow_rauc() (or add a sibling
> test that reuses its setup) so mmc10 is bound and rauc is in the
> bootmeth order before 'bootflow boot' runs. Also restore BOOT_ORDER
> (and the bootmeth/bootdev order) at the end so it does not leak into
> the next test.

The hunk you quote is not the one in the patch. As sent it is

  @@ -1445,6 +1445,29 @@ static int bootflow_rauc(struct unit_test_state *u=
ts)

so it does extend bootflow_rauc(), right after the scan and list that
leave the single rauc bootflow on mmc10 as index 0. The series is based
on next (base-commit 856a00aeb61 in the cover letter) because it builds
on the bootflow_rauc() additions from the "Fix crashes and memory leaks
on scan/boot error paths" series, which is only in next. I think the
hunk you saw comes from applying the patch to master: patch(1) accepts
it there with fuzz 2, landing inside bootstd_images(), which matches
your quote, while git am refuses it.

On the restore: bootflow_rauc() already sets BOOT_ORDER back to "A B"
(the value distro_rauc_read_bootflow() seeds from
CONFIG_BOOTMETH_RAUC_BOOT_ORDER) and restores the bootdev order before
returning, and UTF_DM gives every test a fresh driver-model root, so the
bootmeth order does not carry over either.

Looking into that last point did turn up a small pre-existing leak: the
array allocated by bootmeth_set_order() is never freed when the bootstd
device goes away, since bootstd_remove() frees bootdev_order but not
bootmeth_order. It affects every test that sets a bootmeth order (three
in bootflow.c alone) and real teardown too, so it seems better handled
as a separate one-line fix to bootstd_remove() than folded into this
series; I can send that patch.

I re-checked both patches on top of current next (951132236b9): they
apply cleanly and bootflow_rauc passes, so I will hold off on a resend
unless you or Tom prefer one.

>
> Regards,
> Simon

Best regards,
Aristo
